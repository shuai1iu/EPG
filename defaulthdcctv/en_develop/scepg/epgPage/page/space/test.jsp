<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="GBK"%>
<html>
<head>
<script type="text/javascript">
		
	var mp = new MediaPlayer();
	var playUrl = "rtsp://220.181.168.185:5541/mp4/2013henanfenghui/zhibo/cctv1.ts";
	var media_left=0,media_top=0,media_width=0,media_height=0;
	function initMediaStr()
	{
		mediaStr = '[{mediaUrl:"'+ playUrl +'",';
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
	}
	
	function initMediaPlay(_left,_top,_width,_height)
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
		mp.setSingleMedia(mediaStr);
		mp.setAllowTrickmodeFlag(0);
		mp.setNativeUIFlag(0);
		mp.setAudioTrackUIFlag(0);
		mp.setMuteUIFlag(0); 
		mp.setAudioVolumeUIFlag(0);
		mp.setVideoDisplayArea(_left,_top,_width,_height);
		mp.setVideoDisplayMode(0);
		mp.refreshVideoDisplay();
	}
	function destoryMP(){
		var instanceId = mp.getNativePlayerInstanceID();
		mp.stop();
		mp.releaseMediaPlayer(instanceId);
	}
	function play(_left,_top,_width,_height)
	{	
		media_left = _left;
		media_top = _top;
		media_width = _width;
		media_height = _height;
		initMediaStr();
		Authentication.CTCSetConfig("key_ctrl_ex","0");
		initMediaPlay(media_left,media_top,media_width,media_height);
		mp.playFromStart();
	}
	
	function init(){	  
			play(0,0,1280,720);
			
	}
</script>
</head>
<body  bgcolor="transparent" leftmargin="0" topmargin="0" onLoad="init()" onUnload="destoryMP()">
</body>
</html>