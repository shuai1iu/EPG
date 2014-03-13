<%@ page language="java" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><%@ include file="../common/golbal.jsp" %>
<%  
    int left = 0;
    int top = 0;
    int width = 640;
    int height = 530;
	int channelId = 1;
	if (request.getParameter("_left") != null && !"".equals(request.getParameter("_left")))
	{
    	left = Integer.parseInt(request.getParameter("_left")) ;
    }
	if (request.getParameter("_top") != null && !"".equals(request.getParameter("_top")))
    {
		top = Integer.parseInt(request.getParameter("_top")) ;
    }
	if (request.getParameter("_width") != null && !"".equals(request.getParameter("_width")))
    {
		width = Integer.parseInt(request.getParameter("_width"));
    }
	if (request.getParameter("_height") != null && !"".equals(request.getParameter("_height")))
    {
		height = Integer.parseInt(request.getParameter("_height"));
	}
	if (request.getParameter("_channelid") != null && !"".equals(request.getParameter("_channelid")))
    {
		channelId = Integer.parseInt(request.getParameter("_channelid"));
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
	mp.setSingleMedia(json);
	mp.setAllowTrickmodeFlag(0);
	mp.setNativeUIFlag(0);
	mp.setMuteUIFlag(0);
	play();	
	parent.mp = mp;
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
	mp.setAllowTrickmodeFlag(0); //设置是否允许trick操作。 0:允许 1：不允许
	mp.setNativeUIFlag(0); //播放器是否显示缺省的Native UI，  0:允许 1：不允许
	mp.setAudioTrackUIFlag(1);//设置音轨的本地UI显示标志 0:不允许 1：允许
	mp.setMuteUIFlag(1); //设置静音的本地UI显示标志 0:不允许 1：允许
	mp.setAudioVolumeUIFlag(1);//设置音量调节本地UI的显示标志 0:不允许 1：允许
}

/**
*开始播放
*/
function play()
{
    mp.setVideoDisplayArea(<%=left%>,<%=top%>,<%=width%>,<%=height%>);
    mp.setVideoDisplayMode(0);
    mp.refreshVideoDisplay();
    mp.joinChannel(<%=channelId%>);
}

/**
*停止播放
*/
function destoryMP()
{
    mp.leaveChannel();
	mp.stop();
}
if(typeof(iPanel)!= 'undefined'){iPanel.focusWidth = "8"; iPanel.defaultFocusColor = "#2A5BB8";}
</script>
</head>
<body bgcolor="transparent"  onLoad="init()" onUnload="destoryMP()">
</body>
</html>
