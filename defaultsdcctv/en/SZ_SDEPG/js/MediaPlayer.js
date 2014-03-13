var mp = new MediaPlayer();
var playUrl = "";
var playmode="tv";
var playstatus="first";
function initMediaStr(playUrl)
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
	mp.setAllowTrickmodeFlag(0); //设置是否允许trick操作。 0:允许 1：不允许
	mp.setNativeUIFlag(0); //播放器是否显示缺省的Native UI，  0:允许 1：不允许
	mp.setAudioTrackUIFlag(1);//设置音轨的本地UI显示标志 0:不允许 1：允许
	mp.setMuteUIFlag(1); //设置静音的本地UI显示标志 0:不允许 1：允许
	mp.setAudioVolumeUIFlag(1);//设置音量调节本地UI的显示标志 0:不允许 1：允许
	mp.setVideoDisplayArea(203, 20,405, 305 );//全屏显示*/
	mp.setVideoDisplayMode(0); //1:全屏显示
	mp.setCycleFlag(1);
	mp.refreshVideoDisplay(); //调整视频显示，需要上面两函数配合 
}

function playChannel(lastChan){
	if(playmode=="tv" && playstatus=="second"){
	    mp.stop();
		mp.setVideoDisplayArea(203, 20,405, 305 );//全屏显示*/
	    mp.setVideoDisplayMode(0); //1:全屏显示
		//mp.refreshVideoDisplay(); //调整视频显示，需要上面两函数配合 
	    mp.joinChannel(lastChan);
	}else if(playmode=="tvod"  && playstatus=="second"){
		playmode="tv";
		mp.stop();
		mp.setVideoDisplayArea(203, 20,405, 305 );//全屏显示*/
	    mp.setVideoDisplayMode(0); //1:全屏显示
	    mp.joinChannel(lastChan);
	}else{
		initMediaPlay();
		mp.joinChannel(lastChan);
		playmode="tv";
	}
	playstatus="second";
}

function play(playUrl)
{
	initMediaStr(playUrl);
	Authentication.CTCSetConfig("key_ctrl_ex","0");
    if(playmode=="tv" && playstatus=="second")
	{
	   mp.leaveChannel();
	   mp.stop();
	   playmode="tvod";
	   mp.setSingleMedia(mediaStr); //设置媒体播放器播放媒体内容
	   mp.setCycleFlag(0);
	   mp.refreshVideoDisplay(); //调整视频显示，需要上面两函数配合 
	   mp.playFromStart();
	}
	else if(playmode=="tvod" && playstatus=="second")
	{
		mp.stop();
	    mp.setSingleMedia(mediaStr); //设置媒体播放器播放媒体内容
	    mp.setCycleFlag(0);
	    mp.refreshVideoDisplay(); //调整视频显示，需要上面两函数配合 
	    mp.playFromStart();
	}
	else
	{ 
	    initMediaPlay();
	    mp.playFromStart();
		playmode="tvod";
	}
	playstatus="second";
}

function destoryMP(){
	var instanceId = mp.getNativePlayerInstanceID();
	mp.stop();
	mp.releaseMediaPlayer(instanceId);
}

function setMuteFlag(){
	var flag = mp.getMuteFlag();
	if(flag == 0){
		mp.setMuteFlag(1);
	}else{
		mp.setMuteFlag(0);
	}
}

function volumUp(){
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1)
	{
		mp.setMuteFlag(0);
	}
	var volume = mp.getVolume();
	volume += 5;	
	if(volume >= 100)
	{
		volume = 100;    
	}
	mp.setVolume(volume);  
}

function volumDown(){
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1)
	{
		mp.setMuteFlag(0);
	}
	var volume = mp.getVolume();
	volume -= 5;	
	if(volume <= 0)
	{
		volume = 0;    
	}
	mp.setVolume(volume);  
}