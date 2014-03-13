<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ include file="keydefine.jsp" %>
<%@ include file="../../../config/properties.jsp"%>
<%@ include file="../../../config/code.jsp"%>
<%
	String channelListFile="../../../" + datajspname  + "/channelList.jsp";
	String channelID = request.getParameter("channelID")==null?"":request.getParameter("channelID").toString();
	String channelIndex = request.getParameter("channelIndex")==null?"0":request.getParameter("channelIndex").toString();
	String returnUrl = request.getParameter("returnUrl")==null?"":request.getParameter("returnUrl");
%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title></title>
<style type="text/css"> 
body { background-color:#000; font-family:"Microsoft YaHei"; font-size:22px; color:#fff;  margin:0px; padding:0px; width:1280px; height:720px; overflow:hidden; position:relative;}
div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,p,th,td {margin:0; padding:0}
pre,em,i,textarea,input,font{font-size:12px; font-weight:normal; font-style:normal}
img {border:0; margin:0}
button, input, select, textarea { font-size:100%;}
</style>
</head>
<script language="javascript">

     //将频道列表全部取出来
	<jsp:include page="<%=channelListFile%>">
			<jsp:param name="categoryCode" value="<%=channelListCode%>"/> 
			<jsp:param name="varName" value="tempchannelList"/>
			<jsp:param name="fields" value="-1" /> 
			<jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="-1" />
			<jsp:param name="isBug" value="1" />
	</jsp:include>	
    var mp = new MediaPlayer();
	var channelID="<%=channelID%>";
	var channelIndex="<%=channelIndex%>";
	var icurrentchannel="";
	var channelJptimeID;
	var tempShowMsgTimer;
	var curindex=0;
	var shiftFlag=0;
	
	var channelList=tempchannelList.channelDataList;
	function initMediaPlay()
	{
		var instanceId = mp.getNativePlayerInstanceID();
		var playListFlag = 0;
		var videoDisplayMode = 0,useNativeUIFlag = 0;
		var height = 0,width = 0,left = 0,top = 0;
		var muteFlag = 0;
		var subtitleFlag = 0;
		var videoAlpha = 0;
		var cycleFlag = 0;
		var randomFlag = 0;
		var autoDelFlag = 0;
		mp.initMediaPlayer(instanceId,playListFlag,videoDisplayMode,height,width,left,top,muteFlag,useNativeUIFlag,subtitleFlag,videoAlpha,cycleFlag,randomFlag,autoDelFlag);
	}

	function init()
	{
	
		initMediaPlay();	
		mp.setNativeUIFlag(1); //0不使UI本地显示 		   1本地显示
		mp.setMuteUIFlag(1);  //0静音图标不显示			    1本地显示  
		mp.setAudioVolumeUIFlag(1);//设置音量调节本地UI的显示标志 0:不允许 1：允许
		mp.setAudioTrackUIFlag(1);
		mp.setProgressBarUIFlag(1);
		mp.setChannelNoUIFlag(0); //0不使频道号本地显示 		   1本地显示
		mp.setAllowTrickmodeFlag(0);//0允许媒体快进，快退，暂停  1本地控制许
		mp.setVideoDisplayArea(0, 0, 0, 0);//全屏显示
		mp.setVideoDisplayMode(1); //1:全屏显示
		mp.refreshVideoDisplay(); //调整视频显示，需要上面两函数配合
		mp.joinChannel(parseInt(channelIndex));
	}

	function destoryMP(){
		var instanceId = mp.getNativePlayerInstanceID();
	    mp.leaveChannel();
		mp.releaseMediaPlayer(instanceId);
	}
	
    window.onload = function(){
	  window.focus();
	  init();
	  curindex=getChanIndexByNum(channelIndex);
	  setSTB();
	 };

	//左右键机顶盒控制
	function setSTB()
	{
		Authentication.CTCSetConfig("key_ctrl_ex", "1");
	}
	


	document.onkeypress = keyEvent;
	function keyEvent()
	{
		var val = event.which ? event.which : event.keyCode;
		return keypress(val);
	}
	function keypress(keyval)
	{
		switch(keyval)
		{
			
			case <%=KEY_0%>:
				inputNum(0);
				return 0;			
				break;
			case <%=KEY_1%>:
				inputNum(1);
				return 0;	
				break;
			case <%=KEY_2%>:
				inputNum(2);
				return 0;	
				break;
			case <%=KEY_3%>:
				inputNum(3);
				return 0;	
				break;
			case <%=KEY_4%>:
				inputNum(4);
				return 0;	
				break;
			case <%=KEY_5%>:
				inputNum(5);
				return 0;
				break;
			case <%=KEY_6%>:
				inputNum(6);
				return 0;
				break;
			case <%=KEY_7%>:
				inputNum(7);
				return 0;
				break;
			case <%=KEY_8%>:
				inputNum(8);
				return 0;
				break;
			case <%=KEY_9%>:
				inputNum(9);
				return 0;
				break;
			case <%=KEY_UP%>: //2014/1/27
			case <%=KEY_CHANNEL_UP%>: addChannel();break;	//加直播
			case <%=KEY_DOWN%>: //2014/1/27
			case <%=KEY_CHANNEL_DOWN%>: decChannel();break;//减直播
			case <%=KEY_PAGEDOWN%>:gotoEnd();return false;
			case <%=KEY_PAGEUP%>:gotoStart();return false;
			case <%=KEY_RETURN%>:pressReturn();break;
			case <%=KEY_IPTV_EVENT%>:goUtility();break;
		}
		return true;
	}
	
	function inputNum(tempvalue){
		showChannnum();
		clearTimeout(channelJptimeID);
		icurrentchannel=icurrentchannel+tempvalue;
		$("topframenum").innerHTML=icurrentchannel;
		channelJptimeID = setTimeout("playJoinChannel()", 3000);// 3秒钟之后切换直播
		
	}
	
	function gotoStart()
	{
		 mp.gotoStart();
	}
	
    function gotoEnd()
	{
		mp.gotoEnd();
	}	
	
    //离开当前直播
	function stopChannel()
	{	
		mp.leaveChannel();
	}	
    
	function playJoinChannel(){
		var tempindex=getChanIndexByNum(icurrentchannel);
		if(tempindex==-1){
			showChannnum();
		    $("topframenum").innerHTML="频道号不存在！";
			icurrentchannel="";
			tempShowMsgTimer = setTimeout("hiddenChannnum();", 5000);
		}else{
			icurrentchannel="";
			joinChannel(channelList[tempindex]);
		}
	}
	
	//加减频道
	function addChannel()
	{
		var totalChannel=channelList.length;
		stopChannel();//先离开上一个直播
		if(totalChannel-1 == curindex){curindex = 0;}//是否直播是最后一个直播，如果是应该切到第一个直播
		else{curindex++;}
		joinChannel(channelList[curindex]);
	}
	
	function  joinChannel(tempchannel){
		showChannnum();
		mp.joinChannel(tempchannel.channelIndex);
		channelID=tempchannel.channelID;
		channelIndex=tempchannel.channelIndex;
		$("topframenum").innerHTML=tempchannel.channelIndex;
		tempShowMsgTimer = setTimeout("hiddenChannnum();", 5000);
	}
	
	//向下切直播 函数中注意先后顺序
	function decChannel()
	{
		var totalChannel=channelList.length;
		stopChannel();//离开上一个直播	
		if(0 == curindex){curindex = totalChannel-1;}//是否直播是第一个直播，如果是应该切到最后一个直播
		else{curindex--;}
		joinChannel(channelList[curindex]);
   }	
	
	 //返回dom对象
  function $(elementid){
	  return document.getElementById(elementid);  
  }
	//事件响应
	function goUtility()
	{
		eval("eventJson = " + Utility.getEvent());
		var typeStr = eventJson.type;
		switch(typeStr)
		{  
			case "EVENT_MEDIA_ERROR": showMediaError(); tempShowMsgTimer = setTimeout("hiddenMediaError();", 3000);break;
			case "EVENT_PLAYMODE_CHANGE":break;		  
			case "EVENT_PLTVMODE_CHANGE":playModeChange(eventJson);return false;
			case "EVENT_MEDIA_BEGINING":
				 return false;
			case "EVENT_MEDIA_END":
				return false;
			default :
				 break;
		}
		return true;
	}

	//播放模式变化
	function playModeChange(eventJson)
	{
		var stat = eventJson.service_type;
		if (stat == 1)//进入时移
		{
			shiftFlag = 1;
		}
		if (stat == 0)//返回直播
		{
			shiftFlag = 0;
		}
	}
	
	function pressReturn()
	{	
		if(shiftFlag == 0)
			goBack();
		else
			mp.gotoEnd();
	}


    function goBack(){
		window.location.href="<%=returnUrl%>";
	}

    function showMediaError()
    {	
	  $("errorDiv").style.display = "block";
	}
	
	//隐藏错误提示信息
	function hiddenMediaError()
	{
	   $("errorDiv").style.display = "none";
    }
	
	
	function showChannnum()
    {	
	  $("topframe").style.display = "block";
	}
	
	//隐藏错误提示信息
	function hiddenChannnum()
	{
	   $("topframe").style.display = "none";
	   $("topframenum").innerHTML="";
    }
	
	//通过直播号比对出索引，判断直播是否存在
	function getChanIndexByNum(tempchanNum)
	{
		var chanIndex = -1;
		for (var i = 0; i < channelList.length; i++){
			if (parseInt(tempchanNum) == parseInt(channelList[i].channelIndex)){
				chanIndex = i;
				break;
			}
		}
		return chanIndex;
	}
	
</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="transparent"  style="background:transparent;" onUnload="destoryMP()">

<!-- 右上显示直播号-->
<div id="topframe" style="position:absolute;left:180px; top:8px; width:200px; height:30px; z-index:1;display:none">
<table width="280" height="40"><tr align="center"><td style="color:#006600;font-size:28px;" id="topframenum"></td></tr></table>
</div>


<!--系统错误提示-->
<div id="errorDiv" style="position:absolute; left:450px; top:315px; width:400px; height:70px; z-index:1;display:none>
  <table width="400px" height="80" border="0">
    <tr>
      <td width="400px" align="center"  style="color:#006600;font-size:28px;">系统错误，请切换直播或稍候再试！</td>
    </tr>
  </table>
</div>

</body>
</html>
