<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><%@ include file="../common/golbal.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>标清直播</title>
<%  
int channelId = 1;
if (request.getParameter("CHANNELNUM") != null && !"".equals(request.getParameter("CHANNELNUM")))
{
	channelId = Integer.parseInt(request.getParameter("CHANNELNUM"));
}
%>
<script type="text/javascript" language="javascript">
var mp = new MediaPlayer();
var json = '[{mediaUrl:"",';
json +=	'mediaCode: "",';
json +=	'mediaType:1,';
json +=	'audioType:1,';
json +=	'videoType:3,';
json +=	'streamType:2,';
json +=	'drmType:1,';
json +=	'fingerPrint:0,';
json +=	'copyProtection:1,';
json +=	'allowTrickmode:0,';
json +=	'startTime:0,';
json +=	'endTime:10000.3,';
json +=	'entryID:"jsonentry1"}]';
var playStat = "";
var speed = 0;

/**
*页面初始化
*/
function init()
{	
	initMediaPlay();
	mp.leaveChannel();
	play();	
}
    
/**
*初始化MediaPlay的属性
*/
function initMediaPlay()
{
	var instanceId = mp.getNativePlayerInstanceID();
	var playListFlag = 0;
	var videoDisplayMode = 0;
	var height = 0;
	var width = 0;
	var left = 0;
	var top = 0;
	var muteFlag = 0;
	var subtitleFlag = 0;
	var videoAlpha = 0;
	var cycleFlag = 0;
	var randomFlag = 0;
	var autoDelFlag = 0;        
	var useNativeUIFlag = 1;
	mp.initMediaPlayer(instanceId,playListFlag,videoDisplayMode,height,width,left,top,muteFlag,useNativeUIFlag,subtitleFlag,videoAlpha,cycleFlag,randomFlag,autoDelFlag);
	mp.setChannelNoUIFlag(0);
	mp.setNativeUIFlag(1); //0不使UI本地显示 		   1本地显示
    mp.setMuteUIFlag(1);  //0静音图标不显示			    1本地显示  
    mp.setAudioVolumeUIFlag(1);//设置音量调节本地UI的显示标志 0:不允许 1：允许
    mp.setAudioTrackUIFlag(1);
	mp.setProgressBarUIFlag(1);
    mp.setChannelNoUIFlag(1); //0不使频道号本地显示 		   1本地显示
	mp.setAllowTrickmodeFlag(0);//0允许媒体快进，快退，暂停  1本地控制
	mp.setVideoDisplayArea(0, 0, 0, 0);
    mp.setVideoDisplayMode(1); //1:全屏显示
}

/**
*开始播放
*/
function play()
{
    setSTB();
    mp.refreshVideoDisplay();
    mp.joinChannel(<%=channelId%>);
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
		case 8: mp.stop(); goBack() ; break;
		case 768: goUtility(); break;
		default:
			return videoControl(keyval);
	}
	return true;
}
function goBack(){
	 setEPG();
	 var backUrl = getURLtoCookie("channelPlay");
	 backUrl = (backUrl!="")?backUrl:"../page/index.jsp";
	 location.href = backUrl ;
}
/**
*停止播放
*/
function destoryMP()
{
    setEPG();
    mp.leaveChannel();
	mp.stop();
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
if(typeof(iPanel)!= 'undefined'){iPanel.focusWidth = "2"; iPanel.defaultFocusColor = "#FCFF05";}
</script>
</head>
<body bgcolor="transparent"  onLoad="init()" onUnload="destoryMP()">
</body>
<script type="text/javascript" src="<%=static_url%>/js/cookie.js"></script>
</html>
