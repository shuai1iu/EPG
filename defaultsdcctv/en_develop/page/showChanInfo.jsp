<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page language="java" import="java.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="com.huawei.iptvmw.epg.facade.metadata.CommonImpl" %>
<%@ page import="com.huawei.iptvmw.epg.util.xml.DateUtilities" %>
<%@ include file="keyboard/keydefine.jsp" %>
<%@ include file="config/config_playControl.jsp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%
MetaData metaData = new MetaData(request);
String introduce = "";
HashMap typeinfomap = metaData.getTypeInfoByTypeId("10000100000000090000000000041210"); //过滤不能直播不能快进频道
if(typeinfomap!=null){
  introduce = (String)typeinfomap.get("TYPE_INTRODUCE");
}
String[] strarray = introduce.split("@");
%>


<div id="channelNum" style="position:absolute; left:470px;top:8px;width:120px;height:40px;font-size:40px; color:#00ff00;"></div>
<div id="errorInfo" style="position:absolute; left:425px; top:48px; font-size:28px; color:#00ff00;"></div>

<div id="filmInfo" style="position:absolute; left:400px; top:0px; width:240px; height:530px;z-index:3;">
  <iframe name="minifilmInfo" id="minifilmInfo" src="" scroll="no" height="530px"></iframe>
</div>

<script type="text/javascript" src="../js/mediaPlayerEx.js"></script>
<script type="text/javascript">
var isAllowChannel=true;
var numCount = 0;
var tempNumber="";
var number=0;
var timeID = "";//数字键跳转计时器
var showFilmInfoTimer;//节目信息计时器
var numTimeoutId;//频道号定时器
var errorTimeoutId;//错误原因定时器
var markArray = new  Array();//用来存放过滤的数据
var isshowFilmInfo=false;
var mediaMg;
	<%
		for(int i = 0;i < strarray.length;i++){
	%>
		markArray[<%=i %>] = "<%=strarray[i] %>";
	<%
	}
	%>
function containFun(strArr,str)//过滤频道判断
	{	
	if(strArr!=null){
		for(var i=0;i<strArr.length;i++){
			 if(strArr[i]==str){
				 return true; 
			 }
		}
	}
	return false;
}
//通过直播号比对出索引，判断直播是否存在
function getChanIndexByNum(chanNum)
{
	var chanIndex = -1;
	for (var i = 0; i <= mediaMg.totalChannel; i++){
		if (chanNum == mediaMg.channelNums[i]){
			chanIndex = i;
			break;
		}
	}
	return chanIndex;
}

//输入数字切换直播
function inputNum(i)
{   
    if(!isAllowChannel) return;
    numCount++;
	tempNumber = tempNumber+""+i;
	number = number * 10 + i;
    $("channelNum").innerHTML = tempNumber;
	clearTimeout(timeID);
	timeID = setTimeout("playByChannelNum("+ number +")", 3000);// 3秒钟之后切换直播
}	

 function $(domid){
	return document.getElementById(domid);	
 }

 function initMediaMg(){
	mediaMg=parent.mediaManage;
 }

function playByChannelNum(chanNum){
	if(chanNum == mediaMg.currChannelNum){
		numCount=0;
	    tempNumber="";
	    number=0;
	    clearNum();
	    clearError();
		return;
	}	
	
	var returnIndex = getChanIndexByNum(chanNum);	//通过用户输入的直播号判断直播是否存在，加锁，父母控制等等	
	if(-1 == returnIndex){ 
	   $("errorInfo").innerHTML = '直播&lt;' + chanNum + '&gt;不存在'; 
	  //mediaMg.currChannelNum = chanNum;
	}
    else
	{  
	   mediaMg.player.leaveChannel();
	   mediaMg.player.stop();
	   mediaMg.currChannelIndex = returnIndex; 
	   mediaMg.currChannelNum = chanNum;
	   mediaMg.currChannelId=mediaMg.channelIds[mediaMg.currChannelIndex];
	   mediaMg.player.joinChannel(mediaMg.currChannelNum);
	    if(containFun(markArray,mediaMg.currChannelNum))
		{  
				mediaMg.currControlFlag=1;
				$("timeError").innerHTML = "此频道不支持快进";
		}else
		{
				mediaMg.currControlFlag=0;
				$("timeError").innerHTML = "";
		}
	}
	$("filmInfo").style.display = "none";
	numCount=0;
	tempNumber="";
	number=0;
	clearNum();
	clearError();
}

//显示直播频道的节目信息
function showInfo()
{	
   var jumpurl="play_ControlChannelminiInfo.jsp?CHANNELID=" + parseInt(mediaMg.channelIds[mediaMg.currChannelIndex]) + "&pltvStatusFlag=1&timespan="+(new Date()).toString();
	minifilmInfo.location.href = jumpurl;
}	

function clearFilmInfo(){
    clearTimeout(showFilmInfoTimer);
    showFilmInfoTimer = setTimeout('isshowFilmInfo=false;$("filmInfo").style.display = "none"', 14000);
}

function clearNum() {
    clearTimeout(numTimeoutId);
    numTimeoutId = setTimeout('$("channelNum").innerHTML = "&nbsp;"', 3000);
}

function clearError(){
    clearTimeout(errorTimeoutId);
    errorTimeoutId = setTimeout('$("errorInfo").innerHTML = "&nbsp;"', 3000);
	
}

//向上切直播 函数中注意先后顺序
function addChannel()
{ 
    if(!isAllowChannel) return;
    mediaMg.player.leaveChannel();
	mediaMg.player.stop();
	if(mediaMg.totalChannel == mediaMg.currChannelIndex){mediaMg.currChannelIndex = 0;}//是否直播是最后一个直播，如果是应该切到第一个直播
	else{mediaMg.currChannelIndex++;}
	mediaMg.currChannelNum = mediaMg.channelNums[mediaMg.currChannelIndex];
	mediaMg.currChannelId=mediaMg.channelIds[mediaMg.currChannelIndex];
	mediaMg.playChan(mediaMg.channelNums[mediaMg.currChannelIndex]);
	if(containFun(markArray,mediaMg.currChannelNum))
	{
         mediaMg.currControlFlag=1;
		 $("timeError").innerHTML = "此频道不支持快进";
	}else{
		 mediaMg.currControlFlag=0;
		 $("timeError").innerHTML = "";
    }
	$("channelNum").innerHTML = mediaMg.currChannelNum;
	clearNum();
}

function createFilmInfo(){
	 
	 if(isshowFilmInfo) return;
	 $("filmInfo").style.display = "none";
	 showInfo();
	 
}
function clearFilmDiv(){
	 isshowFilmInfo=true;
	 $("filmInfo").style.display = "block";
	 clearFilmInfo();
}
//向下切直播 函数中注意先后顺序
function decChannel()
{
	if(!isAllowChannel) return;
	mediaMg.player.leaveChannel();
	mediaMg.player.stop();
	if(0 == mediaMg.currChannelIndex){mediaMg.currChannelIndex = mediaMg.totalChannel;}//是否直播是第一个直播，如果是应该切到最后一个直播
	else{mediaMg.currChannelIndex--;}
	mediaMg.currChannelNum = mediaMg.channelNums[mediaMg.currChannelIndex];
	mediaMg.currChannelId=mediaMg.channelIds[mediaMg.currChannelIndex];
	mediaMg.playChan(mediaMg.channelNums[mediaMg.currChannelIndex]);
	if(containFun(markArray,mediaMg.currChannelNum))
	{
         mediaMg.currControlFlag=1;
		 $("timeError").innerHTML = "此频道不支持快进";
	}
	else
	{
		 mediaMg.currControlFlag=0;
	     $("timeError").innerHTML = "";
    }
	$("channelNum").innerHTML = mediaMg.currChannelNum;
	clearNum();
	//$("filmInfo").style.display = "block";
	//showInfo();
	//clearFilmInfo();
}

//事件响应
function goUtility()
{
	eval("eventJson = " + Utility.getEvent());
	var typeStr = eventJson.type;
	switch(typeStr)
	{  
		case "EVENT_MEDIA_ERROR":$("errorInfo").innerHTML=eventJson;clearError();break;
		default : break;
	}
	return true;
}
function setAllowChannel(allowvalue){
    	isAllowChannel=allowvalue;
}
</script>
