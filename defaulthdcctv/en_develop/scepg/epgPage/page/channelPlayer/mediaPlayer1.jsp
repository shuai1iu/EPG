<%@ page contentType="text/html; charset=utf-8" language="java" pageEncoding="utf-8"%>
<html>
<head>
<script type="text/javascript">
		
	var mp = parent.mp;
	var channelNum=parent.channelNum;


	function initMediaPlay(_left,_top,_width,_height)
	{
		var instanceId = mp.getNativePlayerInstanceID();
		var playListFlag = 0;
		var videoDisplayMode = 0,useNativeUIFlag = 1;
		var height = 0,width = 0,left = 0,top = 0;
		var muteFlag = 0;
		var subtitleFlag = 0;
		var videoAlpha = 0;
		var cycleFlag = 0;
		var randomFlag = 0;
		var autoDelFlag = 0;
		mp.initMediaPlayer(instanceId,playListFlag,videoDisplayMode,height,width,left,top,muteFlag,useNativeUIFlag,subtitleFlag,videoAlpha,cycleFlag,randomFlag,autoDelFlag);
	}
	function destoryMP()
	{
		var instanceId = mp.getNativePlayerInstanceID();
		mp.leaveChannel();//mp.stop();
		mp.releaseMediaPlayer(instanceId);
	}
	function init()
	{
		Authentication.CTCSetConfig("key_ctrl_ex","0");
		initMediaPlay();
		mp.setAllowTrickmodeFlag(0);  //0不允许媒体快进，快退，暂停  1本地控制
		mp.setChannelNoUIFlag(0);//0不使直播号本地显示 		   1本地显示
		mp.setNativeUIFlag(0);//0不使UI本地显示 		   1本地显示
		mp.setMuteUIFlag(1);//0静音图标不显示			    1本地显示	
		mp.setVideoDisplayArea(0,0,0,0);//全屏显示
		mp.setVideoDisplayMode(1);
		mp.refreshVideoDisplay();
		mp.joinChannel(channelNum);
	//	filmInfo.location.href = "../../inc/channel/play_channeldata.jsp?CHANNELID="+channelId+"&CHANNELNUM="+currChannelNum+"&ISSUB="+isSubSingle+"&COMEFROMFLAG="+comeType;//hxt

    }
	

</script>
</head>
<body  bgcolor="transparent" leftmargin="0" topmargin="0" onLoad="init()" onUnload="destoryMP()">
</body>
</html>