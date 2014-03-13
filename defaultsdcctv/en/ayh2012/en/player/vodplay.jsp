<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><%@ include file="../common/golbal.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>标清点播</title>

<%@ include file="../datasource/datasource.jsp" %>
<%
    DataSource dataSource=new DataSource(request); 
	
	String progId = request.getParameter("progId");
	int iProgId = Integer.parseInt(progId);
	
	String playUrl = dataSource.getVodUrl(1,iProgId,1,"0","200000","0","0","0");
	//String	playUrl = serviceHelpHWCTC.getTriggerPlayUrlHWCTC(1,96785890,1,"0","200000","0","0","0");
	if(playUrl != null && playUrl.length() > 0)
	{
		int tmpPosition = playUrl.indexOf("rtsp");
		if(-1 != tmpPosition)
		{
			playUrl = playUrl.substring(tmpPosition,playUrl.length());
		}
	}
%>
<script>
var backUrl = "<%=static_en%>/page/index.jsp";
var playUrl ='<%=playUrl%>';//触发机顶盒播放url
/******************在iframe页面赋值的参数 end********************************/
var mediaStr = '[{mediaUrl:"'+ playUrl +'",';
mediaStr += 'mediaCode: "jsoncode1",';
mediaStr += 'mediaType:2,';
mediaStr += 'audioType:1,';
mediaStr += 'videoType:1,';
mediaStr += 'streamType:1,';
mediaStr += 'drmType:1,';
mediaStr += 'fingerPrint:0,';
mediaStr += 'copyProtection:1,';
mediaStr += 'allowTrickmode:1,';
mediaStr += 'startTime:0,';
mediaStr += 'endTime:20000,';
mediaStr += 'entryID:"jsonentry1"}]';
	
var mp = new MediaPlayer();//播放器对象	
/**
*初始化mediaPlay对象
*/
function initMediaPlay()
{
    var instanceId = mp.getNativePlayerInstanceID();
    var playListFlag = 0;
    var videoDisplayMode = 1,useNativeUIFlag = 1;
    var height = 0,width = 0,left = 0,top = 0;
    var muteFlag = 0;
    var subtitleFlag = 0;
    var videoAlpha = 0;
    var cycleFlag = 0;
    var randomFlag = 0;
    var autoDelFlag = 0;
    mp.initMediaPlayer(instanceId,playListFlag,videoDisplayMode,height,width,left,top,muteFlag,useNativeUIFlag,subtitleFlag,videoAlpha,cycleFlag,randomFlag,autoDelFlag);
	mp.setSingleMedia(mediaStr); //设置媒体播放器播放媒体内容
	
    mp.setNativeUIFlag(1); //0不使UI本地显示 		   1本地显示
    mp.setMuteUIFlag(1);  //0静音图标不显示			    1本地显示  
    mp.setAudioVolumeUIFlag(1);//设置音量调节本地UI的显示标志 0:不允许 1：允许
    mp.setAudioTrackUIFlag(1);
	mp.setProgressBarUIFlag(1);
    mp.setChannelNoUIFlag(1); //0不使频道号本地显示 		   1本地显示
	mp.setAllowTrickmodeFlag(0);//0允许媒体快进，快退，暂停  1本地控制
	mp.setVideoDisplayArea(0, 0, 0, 0);//全屏显示*/
    mp.setVideoDisplayMode(1); //1:全屏显示
    mp.refreshVideoDisplay(); //调整视频显示，需要上面两函数配合 
}
/**
*播放
*/
function play()
{
	setSTB();
	initMediaPlay();
	mp.playFromStart();
}

function unload()
{
	mp.stop();
}

document.onkeypress = keyEvent;
function keyEvent()
{
	var val = event.which ? event.which : event.keyCode;
	return keypress(val);
}
function goUtility()
{	
	eval("eventJson = " + Utility.getEvent());
	var typeStr = eventJson.type;
	switch(typeStr)
	{	
		case "EVENT_MEDIA_ERROR":mediaError(eventJson);return false;
		case "EVENT_PLAYMODE_CHANGE":resumeMediaError(eventJson);break;	 	
		case "EVENT_MEDIA_END":goBack();return false;
		case "EVENT_MEDIA_BEGINING":break;
		default :break;	
	}
	return true;
}	
function keypress(keyval)
{
	switch(keyval)
	{
		case 8: mp.stop(); goBack() ; break;
		case 768: goUtility(); break;
		default:
			return videoControl(keyval);
	}
	return true;
}
function goBack(){
	 backUrl = getURLtoCookie("vodPlay");
	 backUrl = (backUrl!="")?backUrl:"<%=static_en%>/page/index.jsp";
	 location.href = backUrl ;
}

function myalert(myinfo){
	document.getElementById("alert").innerHTML = "信息："+myinfo;
}

//左右键机顶盒控制
function setSTB()
{
    Authentication.CTCSetConfig("key_ctrl_ex", "1");
}

//左右键EPG控制
function setEPG()
{
    Authentication.CTCSetConfig("key_ctrl_ex", "0");
}
</script>
<body bgcolor="transparent" leftmargin="0" topmargin="0" onLoad="play()" style="color:#FFF" onunload="unload()">
<center><div id="alert"></div></center>
</body>
<script type="text/javascript" src="<%=static_url%>/js/cookie.js"></script>

</html>



