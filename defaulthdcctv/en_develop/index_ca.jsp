<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="config/config_TrailerInVas.jsp"%>
<%@ include file="OneKeyPlay.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<%@ include file="datajsp/new_util_AdText.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="save_focus.jsp"%>
<%@ include file="datajsp/indexdata.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页_央视高清EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<style type="text/css">
<%
//ZTE
//body{ background:url(images/mainbg_index.png) no-repeat}
%>
<!--20130909 10:00 ZSZ 修改背景图显示规避用户重启前不能重新加载背景图图片-->
<!--
body{ background1:url(images/mainbg_index_new.png) no-repeat}
.geton{z-index:3}
.getoff{z-index:1}
-->
#mod-marquee {position: absolute; top:666px;  left:370px; float:left; width:660px;height:25px;margin:10px auto 0;zoom:1; overflow:hidden;line-height:25px;margin-bottom:4px;z-index:100;} 
#mod-marquee div{ width:660px; height:25px; overflow:hidden;zoom:1; font-size:20px;} 


</style>
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript">
//var numkey=true;var bluekey=true;var redkey=true;var greenkey=true;var yellowkey=true;
var returnurl=escape(window.location.href);
var area2;
var area3;
var area4;
var area1setlink = 0; //area1setlink=0 use iframe player and live URL; area1setlink=1 usr picture and page-link URL;
var progId="<%=CATEGORY_TRAILER_ID%>";

var changeFlag = 3;
var changeRecommend =  window.setInterval("changeImage()",5000);
window.onload=function()
{
	var areaid=<%=request.getParameter("areaid")%>;
	var indexid=<%=request.getParameter("indexid")%>;
	var backflag='<%=request.getParameter("back")%>';
	var area0=AreaCreator(10,1,new Array(-1,-1,-1,1),"area0_list_","className:menuli on","className:menuli");
	area0.setstaystyle("className:menuli current",3);
	area0.doms[0].mylink=indexhref[0];
	area0.doms[1].mylink=indexhref[1];
	area0.doms[2].mylink=indexhref[2];
	//	   area0.doms[3].mylink="2013nh/page/nhindex2.jsp?indexid=3";
	area0.doms[3].mylink=indexhref[3];
	area0.doms[4].mylink=indexhref[4];
	area0.doms[5].mylink=indexhref[5];
	area0.doms[6].mylink=indexhref[6];
//	area0.doms[7].mylink=indexhref[7];
	area0.doms[7].mylink= "application.jsp";
	area0.doms[8].mylink=indexhref[8];
	area0.doms[9].mylink=indexhref[9];
	area0.setfocuscircle(0);
	area0.stablemoveindex = new Array(-1,-1,-1,"8-2>0,9-2>0");
	var area1=AreaCreator(1,1,new Array(-1,0,2,3),"area1_list_","className:mid_adon","className:mid_ad");
	area1.stablemoveindex = new Array(-1,-1,"0-2>1",-1);
	area1setlink = <%=imageorchannel%>;
	if(area1setlink == 0)
		area1.doms[0].mylink="play_ControlChannel.jsp?CHANNELNUM=<%=shouyezhibo%>&COMEFROMFLAG=1&returnurl="+escape(location.href);//"<%=CATEGORY_fullScreenPlayUrl%>";
	else if(indexiframeUrl!=null&&indexiframeUrl!="")
		// area1.doms[0].mylink = "../../"+indexiframeUrl+"?returnurl="+escape(location.href);
		area1.doms[0].mylink = "../../"+indexiframeUrl;
	else
		area1.doms[0].mylink = "../../defaultgd/en/hdyoung/page/index.jsp?returnurl="+escape(location.href);

	area2=AreaCreator(1,4,new Array(1,0,4,3),"area2_list_","className:item item03 item03_focus","className:item item03");
	area2.stablemoveindex=new Array(-1,-1,"0-0,1-2,2-4,3-6","3-3,7-3,11-3");
	for(var i=0;i<area2.doms.length;i++){
		area2.doms[i].contentdom = $("area2_listName_"+i);
	}
	area2.doms[0].focusstyle = new Array("className:item item04 item04_focus");
	area2.doms[0].unfocusstyle = new Array("className:item item04");

	area4=AreaCreator(2,8,new Array(2,0,-1,3),"area4_list_","className:item item01 item01_focus","className:item item01");
	area4.stablemoveindex=new Array("0-0,1-0,2-1,3-1,4-2,5-2,6-3,7-3",-1,-1,"7-3,15-3");
	for(var j=0;j<area4.doms.length;j++){
		area4.doms[j].contentdom = $("area4_listName_"+j);
	}
	area4.doms[0].focusstyle = new Array("className:item item02 item02_focus");
	area4.doms[0].unfocusstyle = new Array("className:item item02");
	area4.doms[1].focusstyle = new Array("className:item item02 item02_focus");
	area4.doms[1].unfocusstyle = new Array("className:item item02");
	area4.doms[8].focusstyle = new Array("className:item item02 item02_focus");
	area4.doms[8].unfocusstyle = new Array("className:item item02");
	area4.doms[9].focusstyle = new Array("className:item item02 item02_focus");
	area4.doms[9].unfocusstyle = new Array("className:item item02");

	area3=AreaCreator(4,1,new Array(5,1,5,-1),new Array("area3_list_","area3_list1_"),new Array("className:on","className:geton"),new Array("className:","className:"));
	area3.stablemoveindex=new Array(-1,"3-2>3","3-5>0",-1);
	//添加推荐海报循环2011.3.13
//	area3.setfocuscircle(0);
	for(i=0;i<4;i++)
		area3.doms[i].imgdom=$("area3_img_"+i);
/*
    @description 创建新Area5用来选择当前推荐位内容
    @author LS
    @date 2013-09-06
*/
        area5 =AreaCreator(1,3,new Array(3,-1,3,-1),"area5_recommend_","className:on","className:item");
	area5.stablemoveindex=new Array("0-3>3,1-3>3,2-3>3",-1,"0-3>0,1-3>0,2-3>0",-1);
        area5.setfocuscircle(1);
	//开机定位深圳
	var start=getCookie("isstart");
	//随时定位深圳
	var backfocus;
	if("1"==backflag)
		backfocus=getCurFocus("index");
	pageobj=new PageObj(areaid!=null?parseInt(areaid):(backfocus!=null?backfocus[0].areaid:0),indexid!=null?parseInt(indexid):(backfocus!=null?backfocus[0].curindex:(start==undefined?5:0)),new Array(area0,area1,area2,area3,area4,area5));
	saveCookie("isstart","yes"); 
	if(backfocus!=null)
	{

		pageobj.areas[backfocus[0].areaid].curpage=backfocus[0].curpage;
		pageobj.areas[backfocus[0].areaid].curindex=backfocus[0].curindex;
		setDarkFocus("index");
	}
	pageobj.pageOkEvent=function()
	{
		var json=createFocstr(pageobj);
		saveCookie("index",json!=undefined?json:"");    
	}
	pageobj.pageVolChangeEvent=function(num)
	{
		if(num==-1)
			volumeDown();
		else if(num==1)
			volumeUp();
	}
	pageobj.pageNumTypeEvent=function(num){
		funcInputNum(parseInt(num));
	}
	pageobj.pageSetMuteFlagEvent=setMuteFlag;
	if(areaid!=null&&areaid!=0)
		area0.setdarknessfocus(0);
	pageobj.goBackEvent=function()
	{
		this.changefocus(0,0);
	}
	getdata(fivelist,sdtwolist);
	getdataSecond(fourlist,hdtwolist);
	//$("ad_text").innerHTML = fourlist.length + "    " + hdtwolist.length;
	changeImage();
	//load_iframe();
	setTimeout(load_iframe,200);
//    @description 触发推荐位自动切换
	changeImage();
        document.getElementById("area5_recommendon_0").style.display = "block";
	document.getElementById("area5_recommendon_1").style.display = "none";
	document.getElementById("area5_recommendon_2").style.display = "none";


	area5.areaInedEvent = function(){
		window.clearInterval(changeRecommend);
		document.getElementById("area5_recommendon_0").style.display = "none";
		document.getElementById("area5_recommendon_1").style.display = "none";
		document.getElementById("area5_recommendon_2").style.display = "none";                
	}
	area5.areaOutingEvent =  function(){
		changeRecommend = window.setInterval("changeImage()",5000);
                for(i = 0; i < 3; i++)
                {
                    if( i == area5.curindex)
                    {
                        document.getElementById("area5_recommendon_" + i).style.display = "block";     
                    }else
                    {
                        document.getElementById("area5_recommendon_" + i).style.display = "none";
                    }
                }
	};
	area5.changefocusedEvent=function(){changeRecomFocus();}

	area3.areaIningEvent = function(){ window.clearInterval(changeRecommend);}
	area3.areaOutingEvent =  function(){changeRecommend = window.setInterval("changeImage()",5000);}
	area3.changefocusedEvent=function(){window.clearInterval(changeRecommend);}
   	if(pageobj.curareaid==3)
	{
		window.clearInterval(changeRecommend);
	}

}


/*
    @description 推荐位手动切换按钮的选中效果控制Function
    @author ls
    @date 2013-09-07
*/
function changeRecomFocus()
{
	if( area5.curindex == 0 )
	{
		changeFlag = 1;
        changeImage();
	}
	else if( area5.curindex  == 1)
	{
        changeFlag = 2;
		changeImage();
	}
	else if( area5.curindex  == 2)
	{
		changeFlag = 3;
		changeImage();
	}
}


/*
    @description 控制推荐位切换
    @author ls
    @date 2013-09-07
*/
       function changeImage()
{
    if( pageobj.curareaid == 5)
    {
	    if(changeFlag == 1 )
	    {
		    getdatacommon(list1,0,2,1);
		    getdatacommon(list2,2,1,0,vasList2Pic);
		    getdatacommon(list3,3,1,0,vasList3Pic);
		    changeFlag = 2;
            area3.stablemoveindex=new Array("0-5>0","3-2>3","3-5>0",-1);
	    }     
	    else if(changeFlag == 2)
	    {
		    getdatacommon(listVod2,0,2,1);
		    getdatacommon(list11,2,1,0,vasList11Pic);
		    getdatacommon(list12,3,1,0,vasList12Pic);
		    changeFlag = 3;
		    area3.stablemoveindex=new Array("0-5>1","3-2>3","3-5>1",-1);
		}
		else
	    {
            getdatacommon(listVod3rd,2,2,1);
            getdatacommon(list3rd_right1,0,1,0,vasList3rd_right1Pic);
            getdatacommon(list3rd_right2,1,1,0,vasList3rd_right2Pic);
		    changeFlag = 1;
		    area3.stablemoveindex=new Array("0-5>2","3-2>3","3-5>2",-1);
		} 
    }else
    {
        if(changeFlag == 1 )
        {
		    getdatacommon(list1,0,2,1);
            getdatacommon(list2,2,1,0,vasList2Pic);
            getdatacommon(list3,3,1,0,vasList3Pic);
            changeFlag = 2;
            area3.stablemoveindex=new Array("0-5>0","3-2>3","3-5>0",-1);
            document.getElementById("area5_recommendon_0").style.display = "block";
            document.getElementById("area5_recommendon_1").style.display = "none";
            document.getElementById("area5_recommendon_2").style.display = "none";
        }
        else if(changeFlag == 2)
        {
            getdatacommon(listVod2,0,2,1);
            getdatacommon(list11,2,1,0,vasList11Pic);
            getdatacommon(list12,3,1,0,vasList12Pic);
            changeFlag = 3;
            area3.stablemoveindex=new Array("0-5>1","3-2>3","3-5>1",-1);
            document.getElementById("area5_recommendon_0").style.display = "none";
            document.getElementById("area5_recommendon_1").style.display = "block";
            document.getElementById("area5_recommendon_2").style.display = "none";
        }
        else
        {
            getdatacommon(listVod3rd,2,2,1);
            getdatacommon(list3rd_right1,0,1,0,vasList3rd_right1Pic);
            getdatacommon(list3rd_right2,1,1,0,vasList3rd_right2Pic);
            changeFlag = 1;
            document.getElementById("area5_recommendon_0").style.display = "none";
            document.getElementById("area5_recommendon_1").style.display = "none";
            document.getElementById("area5_recommendon_2").style.display = "block";
            area3.stablemoveindex=new Array("0-5>2","3-2>3","3-5>2",-1);
        }
    }
}

function getdatacommon(data,start,length,type,vaspic)
{
	var end =  (start + length) ;
	if( 1 == type)
	{
		if(data.length==undefined || data==null || data.length<1)
		{
			area3.datanum +=1;
		}
		else
		{
			area3.datanum=data.length;
			for(var i = start;i < end ; i++)
			{
				if((i-start)<data.length)
				{
					area3.doms[i].updateimg(data[i-start].POSTERPATHS.type0[0]!=undefined?data[i-start].POSTERPATHS.type0[0]:(data[i-start].PICPATH!=undefined?data[i-start].PICPATH:'images/no_picture_259x165.jpg'));
					area3.doms[i].mylink="vod_turnpager.jsp?vodid="+data[i-start].VODID+"&typeid=<%=shouyetuijian2code%>"+"&returnurl="+returnurl;
				}
				else
					area3.doms[i].updateimg("#");
			}
		}
	}
	else
	{
		if(data.length==undefined || data==null || data.length<1)
		{
			area3.datanum +=1;
		}
		else
		{
			area3.datanum += data.length;
			for(var i = start; i < end ; i++)
			{
				if(i<area3.datanum)
				{
					area3.doms[i].updateimg(vaspic[i-start]);
					area3.doms[i].youwannauseobj=data[i-start].VASID;
					area3.doms[i].mylink = "../../" + data[i-start].VASURL;
				}
				else
				{
					area3.doms[i].updateimg("#");
				}
			}
		}
	}	
}



function getdataSecond(four,hdtwo)
{

	var j_index = 0;
	var j2_index = 0;
	for(var j=0;j<area4.doms.length;j++){
		if(j == 0 || j == 1 || j == 8 || j == 9){
			if(four[j_index] != null){
				var showName = four[j_index].VASNAME;
				if(showName.length > 2){showName = four[j_index].VASNAME.substring(0,3)}
				area4.doms[j].setcontent("",showName,20,true,true);
				area4.doms[j].youwannauseobj=four[j_index].VASID;
				area4.doms[j].domOkEvent=function()
				{
					$('hidden_frame').src="datajsp/indexdetaildata.jsp?vasid="+this.youwannauseobj;
				}
			}else{
				area4.doms[j].updatecontent("");
			}
			j_index++;
		}else{
			if(hdtwo[j2_index] != null){
				var showName = hdtwo[j2_index].VASNAME;
				if(showName.length > 2){showName = hdtwo[j2_index].VASNAME.substring(0,2)}
				area4.doms[j].setcontent("",showName,20,true,true);
				area4.doms[j].youwannauseobj=hdtwo[j2_index].VASID;
				area4.doms[j].domOkEvent=function()
				{
					$('hidden_frame').src="datajsp/indexdetaildata.jsp?vasid="+this.youwannauseobj;
				}
			}else{
				area4.doms[j].updatecontent("");
			}
			j2_index++;
		}

	}
}
function getdata(five,sdtwo)
{
	var i_index = 0;
	for(var i=0;i<area2.doms.length;i++)
	{
		if(i == 0)
		{
			if(five[0]!=null){
				area2.doms[i].setcontent("",five[i].VASNAME.substring(0,5),20,true,true);
				area2.doms[i].youwannauseobj=five[i].VASID;
				area2.doms[i].domOkEvent=function()
				{
					$('hidden_frame').src="datajsp/indexdetaildata.jsp?vasid="+this.youwannauseobj;
				}
			}else{
				area2.doms[i].updatecontent("");
			}
		}else{
			if(sdtwo[i_index] != null){
				var showName = sdtwo[i_index].VASNAME;
				if(showName.length > 3){showName = sdtwo[i_index].VASNAME.substring(0,4)}
				area2.doms[i].setcontent("",showName,20,true,true);
				area2.doms[i].youwannauseobj=sdtwo[i_index].VASID;
				area2.doms[i].domOkEvent=function()
				{
					$('hidden_frame').src="datajsp/indexdetaildata.jsp?vasid="+this.youwannauseobj;
				}
			}else{
				area2.doms[i].updatecontent("");
			}
			i_index++;
		}	
	}
}



//视频窗口
function load_iframe()
{
	//area1setlink须从闭包中取出
	if(area1setlink == 1)
	{
	
		progId="";	//mxr修改中间视频窗口为图片
	}
	if (progId != "" && progId != "null" && progId != null)
	{			
		playPage.location.href = "PlayTrailerInVas.jsp?left=150&top=200&width=508&height=385&type="+"<%=CATEGORY_TRAILER_TYPE%>"+"&value=" + "<%=CATEGORY_TRAILER_ID%>" +"&mediacode="+ "<%=CATEGORY_TRAILER_ID%>" +"&contenttype="+ "<%=CATEGORY_TRAILER_CONTENTTYPE%>";
	}
	else 
	{
		//ZTE			
		//document.getElementById("mid_play").src  ="images/hdkid.jpg";
		if(indexiframePic[0]!=null&&indexiframePic[0]!="")
			document.getElementById("mid_play").src = indexiframePic[0];
		else
			document.getElementById("mid_play").src ="images/hdkid.jpg";
		//document.body.style.background = "url(images/mainbg_index.jpg) no-repeat";document.getElementById("mid_play").src  =  ( picpath!=null&&picpath!=""&&picpath!="absolute") ? picpath:"images/temp/ozb2012.jpg";
	}
}
function goURL(url)
{
	document.location.href='../'+url;	
}

function goURL1(vasurl)
{
	document.location.href=vasurl;	
}

var volumeDivIsShow = false;
var volume = 20;
function volumeUp()
{
	hideVoice();
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1)
	{
		mp.setMuteFlag(0);
	}
	volume = mp.getVolume(); 
	volume += 5;
	if(volume >= 100)
	{
		volume = 100;             
	}
	mp.setVolume(volume);  
	if (mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
	{
		clearTimeout(bottomTimer);
		bottomTimer = "";
		genVolumeTable(volume);
		bottomTimer = setTimeout("hideBottom();", 5000);
	}
}
function volumeDown()
{	
	hideVoice();
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1)
	{
		mp.setMuteFlag(0);
	}
	volume = mp.getVolume();
	volume -= 5;	
	if(volume <= 0)
	{
		volume = 0;    
	}
	mp.setVolume(volume);  
	if (mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
	{
		clearTimeout(bottomTimer);
		bottomTimer = "";
		genVolumeTable(volume);
		bottomTimer = setTimeout("hideBottom();", 5000);
	}
}
function hideBottom()
{
	volumeDivIsShow = false;
	document.getElementById("bottomframe").innerHTML = "";
}
function hideVoice()
{
	document.getElementById("voice").src="images/dot.gif";
}
function genVolumeTable(volume)
{
	var tableDef = '<table width="980px" border="0" cellpadding="0" cellspacing="0"><tr>';
	volume = parseInt(volume / 5);
	for (i = 0; i < 40; i++)
	{
		if (i % 2 == 0)
		{
			tableDef += '<td width="20px" height="54px" bgcolor="transparent"></td>';
		}
		else
		{
			if ( i / 2 < volume)
			{
				tableDef += '<td width="20px" height="54px" bgcolor="#00ff00"></td>';
			}
			else
			{
				tableDef += '<td width="20px" height="54px" bgcolor="cccccc"></td>';
			}
		}
	}
	tableDef += '<td width="20px"></td><td width="40px"><img src="images/playcontrol/playChannel/volume.gif"></td><td width="40px" style="color:white;font-size:28">' + volume + '</td>';
	tableDef += '</tr></table>'; 
	document.getElementById("bottomframe").innerHTML = tableDef;    	
}
function setMuteFlag()
{
	hideBottom();
	clearTimeout(voiceTimer);
	bottomTimer = ""; 
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1)
	{
		mp.setMuteFlag(0);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
		{
			//document.getElementById("bottomframe").innerHTML = '<table><tr><td><img src="images/playcontrol/playChannel/muteoff.png"></td></tr></table>';
			document.getElementById("voice").src="images/playcontrol/playChannel/muteoff.png";
			voiceTimer = setTimeout(hideVoice, 5000);
		}
	}
	else
	{
		mp.setMuteFlag(1);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
		{
			//document.getElementById("bottomframe").innerHTML = '<table><tr><td><img src="images/playcontrol/playChannel/muteon.png"></td></tr></table>';
			document.getElementById("voice").src="images/playcontrol/playChannel/muteon.png";
			//voiceTimer = setTimeout("hideVoice();", 5000);
		}
	}      
}


/**********************
* Time:20130909 9:30
* Author:ZSZ
* description:高清首页跑
* 马灯
**********************/
var $ = function (d){ 
typeof d == "string" &&(d = document.getElementById(d)); 
return $.fn.call(d); 
}; 
$.fn = function (){ 
this.addEvent = function (sEventType,fnHandler){ 
if (this.addEventListener) {this.addEventListener(sEventType, fnHandler, false);} 
else if (this.attachEvent) {this.attachEvent("on" + sEventType, fnHandler);} 
else {this["on" + sEventType] = fnHandler;} 
} 
this.removeEvent = function (sEventType,fnHandler){ 
if (this.removeEventListener) {this.removeEventListener(sEventType, fnHandler, false);} 
else if (this.detachEvent) {this.detachEvent("on" + sEventType, fnHandler);} 
else { this["on" + sEventType] = null;} 
} 
return this; 
}; 
var Class = {create: function() {return function() { this.initialize.apply(this, arguments); }}}; 
var Bind = function (obj,fun,arr){return function() {return fun.apply(obj,arr);}} 
var Marquee = Class.create(); 
Marquee.prototype = { 
initialize: function(id,name,out,speed) { 
this.name = name; 
this.box = $(id); 
this.out = out;//滚动间隔时间,单位秒 
this.speed = speed; 
this.d = 1; 
this.box.style.position = "relative"; 
this.box.scrollTop = 0; 
var _li = this.box.firstChild; 
while(typeof(_li.tagName)=="undefined")_li = _li.nextSibling; 
this.lis = this.box.getElementsByTagName(_li.tagName); 
this.len = this.lis.length; 
for(var i=0;i<this.lis.length;i++){ 
var __li = document.createElement(_li.tagName); 
__li.innerHTML = this.lis[i].innerHTML; 
this.box.appendChild(__li);//cloneNode 
if(this.lis[i].offsetTop>=this.box.offsetHeight)break; 
} 
this.Start(); 
this.box.addEvent("mouseover",Bind(this,function(){clearTimeout(this.timeout);},[])); 
this.box.addEvent("mouseout",Bind(this,this.Start,[])); 
}, 
Start:function (){ 
clearTimeout(this.timeout); 
this.timeout = setTimeout(this.name+".Up()",this.out*1000) 
}, 
Up:function(){ 
clearInterval(this.interval); 
this.interval = setInterval(this.name+".Fun()",10); 
}, 
Fun:function (){ 
this.box.scrollTop+=this.speed; 
if(this.lis[this.d].offsetTop <= this.box.scrollTop){ 
clearInterval(this.interval); 
this.box.scrollTop = this.lis[this.d].offsetTop; 
this.Start(); 
this.d++; 
} 
if(this.d >= this.len + 1){ 
this.d = 1; 
this.box.scrollTop = 0; 
} 
} 
}; 
$(window).addEvent("load",function (){ 
marquee = new Marquee("mod-marquee","marquee",5,1); 
}); 
</script>
</head>
<!--20130909 10:00 ZSZ 修改背景图显示规避用户重启前不能重新加载背景图图片-->
<!--<body style="background:url(images/mainbg_index_new.png); background-color:transparent;">-->
<body style="background:url(images/mainbg_index_new.png); background-color:transparent;">
<!--20130909 10:00 ZSZ 修改背景图显示规避用户重启前不能重新加载背景图图片-->
<div class="main">
<!--初始化加载图片-->
<div style="visibility:hidden; z-index:-1">
<!--首页左边导航暗焦点--> 
<img src="images/menu_bgfocuson.png"/>
<img src="images/menu_bgon.png"/>
<!--首页视频大图-->
<img src="images/pic_bg1on.png"/>
<!--节目-->
<img src="images/nav_bgon.png"/>
<!--右侧-->
<img src="images/pic_bg2.png"/>
</div>
<!--logo-->
<div class="logo"><img src="images/logo.png" /></div>
<div class="date" id="currDate"></div>
<!--menu-->
<div class="menu"> <!--焦点为 class="menuli on"  当前选中为 class="menuli current"-->
<div><img src="images/menu_line.png" /></div>
<div class="menuli" id="area0_list_0" style="top:1px"><img src="images/icon_0.png" />首  页</div> <!--class="menuli on"-->
<div style="top:55px"><img src="images/menu_line.png" /></div>
<div class="menuli" id="area0_list_1" style="top:56px"><img src="images/icon_1.png" />频  道</div>
<div style="top:110px"><img src="images/menu_line.png" /></div>
<div class="menuli" id="area0_list_2" style="top:111px"><img src="images/icon_2.png" />点  播</div>
<div style="top:165px"><img src="images/menu_line.png" /></div>
<div class="menuli" id="area0_list_3" style="top:166px"><img src="images/icon_3.png" />专  题</div>
<div style="top:220px"><img src="images/menu_line.png" /></div>
<div class="menuli" id="area0_list_4" style="top:221px"><img src="images/icon_4.png" />回  放</div>
<div style="top:275px"><img src="images/menu_line.png" /></div>
<div class="menuli" id="area0_list_5" style="top:276px"><img src="images/icon_5.png" />深  圳</div>
<div style="top:330px"><img src="images/menu_line.png" /></div>
<div class="menuli" id="area0_list_6" style="top:331px"><img src="images/icon_11new.png" />排  行</div>
<div style="top:385px"><img src="images/menu_line.png" /></div>
<div class="menuli" id="area0_list_7" style="top:386px"><img src="images/icon_7.png" />应  用</div>
<div style="top:440px"><img src="images/menu_line.png" /></div>
<div class="menuli" id="area0_list_8" style="top:441px"><img src="images/icon_9.png" />空  间</div>
<div style="top:499px"><img src="images/menu_line.png" /></div>
<div class="menuli" id="area0_list_9" style="top:500px"><img src="images/icon_10.png" />搜  索</div>
<div style="top:555px"><img src="images/menu_line.png" /></div>
</div>




<!--mid-->
<div class="mid_ad" id="area1_list_0"><img src="#" id="mid_play" width="508" height="385" /></div> <!--mid_ad/mid_adon-->

<div class="mid_nav"> 
<div class="icon-hd"><img src="images/index-nav-hd.png" /></div>
<!--焦点 
class="item item01 item01_focus"  2字
class="item item02 item02_focus"　3字
class="item item03 item03_focus"  4字
class="item item04 item04_focus"  5字
-->
<div id="area2_list_0" class="item item04">
<div id="area2_listName_0" class="txt">直播港澳台</div>
</div>
<div id="area2_list_1" class="item item03" style="left:169px;">
<div class="icon"></div>
<div id="area2_listName_1" class="txt">尊享包</div>
</div>
<div id="area2_list_2" class="item item03" style="left:293px;">
<div id="area2_listName_2" class="txt">时尚包</div>
</div>
<div id="area2_list_3" class="item item03" style="left:418px;">
<div id="area2_listName_3" class="txt">淘淘乐园</div>
</div>

<div id="area4_list_0" class="item item02" style="top:44px;">
<div id="area4_listName_0" class="txt">看大片</div>
</div>
<!------area4_list0 and area4_list_9,left:84px----->
<div id="area4_list_1" class="item item02" style="left:84px;top:44px;">
<div id="area4_listName_1" class="txt"style="text-align:center;">热剧</div>
</div>
<div id="area4_list_2" class="item item01" style="left:169px;top:44px;">
<div id="area4_listName_2" class="txt">热剧</div>
</div>
<div id="area4_list_3" class="item item01" style="left:232px;top:44px;">
<div id="area4_listName_3" class="txt">热剧</div>
</div>
<div id="area4_list_4" class="item item01" style="left:293px;top:44px;">
<div id="area4_listName_4" class="txt">热剧</div>
</div>
<div id="area4_list_5" class="item item01" style="left:357px;top:44px;">
<div id="area4_listName_5" class="txt">热剧</div>
</div>
<div id="area4_list_6" class="item item01" style="left:418px;top:44px;">
<div id="area4_listName_6" class="txt">热剧</div>
</div>
<div id="area4_list_7" class="item item01" style="left:480px;top:44px;">
<div id="area4_listName_7" class="txt">热剧</div>
</div>

<div id="area4_list_8" class="item item02" style="top:85px;">
<div id="area4_listName_8" class="txt">纪实</div>
</div>
<div id="area4_list_9" class="item item02" style="left:84px;top:85px;">
<div id="area4_listName_9" class="txt" style="text-align:center;">娱乐</div>
</div>
<div id="area4_list_10" class="item item01" style="left:169px;top:85px;">
<div id="area4_listName_10" class="txt">热剧</div>
</div>
<div id="area4_list_11" class="item item01" style="left:232px;top:85px;">
<div id="area4_listName_11" class="txt">热剧</div>
</div>
<div id="area4_list_12" class="item item01" style="left:293px;top:85px;">
<div id="area4_listName_12" class="txt">热剧</div>
</div>
<div id="area4_list_13" class="item item01" style="left:357px;top:85px;">
<div id="area4_listName_13" class="txt">热剧</div>
</div>
<div id="area4_list_14" class="item item01" style="left:418px;top:85px;">
<div id="area4_listName_14" class="txt">热剧</div>
</div>
<div id="area4_list_15" class="item item01" style="left:480px;top:85px;">
<div id="area4_listName_15" class="txt">热剧</div>
</div>
</div>


<!--r-->
<div class="r_ad">
<div style="top:0" id="area3_list1_0"><img id="area3_img_0"  width="305" height="137"/></div>
<div id="area3_list_0" style="top:-1px"></div>
<div style="top:139px;" id="area3_list1_1"><img id="area3_img_1" width="305" height="137"/></div>
<div id="area3_list_1" style="top:138px"></div>
<div style="top:278px;" id="area3_list1_2"><img id="area3_img_2" width="305" height="137" /></div>
<div id="area3_list_2" style="top:277px;"></div>
<div style="top:417px;" id="area3_list1_3"><img id="area3_img_3" width="305" height="137" /></div>
<div id="area3_list_3" style="top:416px"></div>

</div>

<!--changeRecommend--推荐位自动切换CSS---->
<div class = "recommend">
<div class = "rec_1">
<div class = "item" style = "z-index:-1" id="area5_recommend_0"></div>
</div>
<div class = "rec_2">
<div class = "item" style = "left:102px;z-index:-1" id="area5_recommend_1"></div>
</div>
<div class = "rec_3">
<div class = "item" style = "left:204px;z-index:-1" id="area5_recommend_2"></div>
</div>
<!--推荐位自动切换时高亮效果DIV--->
<div id="area5_recommendon_0"><img src="images/recommend_1.png" /></div>
<div style = "left:102px;" id="area5_recommendon_1"><img src="images/recommend_2.png" /></div>          
<div style = "left:204px;" id="area5_recommendon_2"><img src="images/recommend_3.png" /></div>

</div>


<!--20130909 12:00 ZSZ 修改跑马灯-->
<div class="mod-marquee" id="mod-marquee" >
	<%
		for(int i=0;i<rollsize;i++){
	%>
			<div><%=rollText[i]%></div>
	<%
		}
	%>

</div>
<!--20130909 12:00 ZSZ 修改跑马灯-->

<div id="bottomframe" style="position:absolute;left:60px; top:530px; width:1200px; height:190px; z-index:1"></div>
<div style="position:absolute; left:816px; top:105px; width:54px; height:66px; z-index:3;"><img id="voice" src="images/dot.gif"/></div>
<iframe name="hidden_frame_time" id="hidden_frame_time" style=" display:none" width="1px" height="1px" ></iframe>
<!-- 视频窗口 -->
<iframe id="playPage" name="playPage" frameborder="0" height="1pxpx" width="1pxpx"></iframe>
<iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="1px" height="1px" ></iframe>
<%@ include file="servertimehelp.jsp" %>
</body>
</html>
