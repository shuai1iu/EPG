<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="page-view-size" content="1280*720">
<title>珠江频道</title>
</head>
<body onLoad="init()" onUnload="exitPage()" bgcolor="transparent">
</body>
<script>
var mp = new MediaPlayer();
function init()
{
    initMediaPlay();
}
function startPlay(playUrl)
{
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
    mp.setSingleMedia(mediaStr); //设置媒体播放器播放媒体内容
    mp.refreshVideoDisplay(); //调整视频显示，需要上面两函数配合 
    mp.playFromStart();
}
function initMediaPlay()
{
    var instanceId = mp.getNativePlayerInstanceID(); //读取本地的媒体播放实例的标识
    var playListFlag = 0; //Media Player 的播放模式。 0：单媒体的播放模式 (默认值)，1: 播放列表的播放模式
    var videoDisplayMode = 1; //MediaPlayer 对象对应的视频窗口的显示模式. 1: 全屏显示2: 按宽度显示，3: 按高度显示
    var height = 0;
    var width = 0;
    var left = 0;
    var top = 0;
    var muteFlag = 0; //0: 设置为有声 (默认值) 1: 设置为静音
    var subtitleFlag = 0; //字幕显示 
    var videoAlpha = 0; //视频的透明度
    var cycleFlag = 0;
    var randomFlag = 0;
    var autoDelFlag = 0;
    var useNativeUIFlag = 1;

    //初始话mediaplayer对象
    mp.initMediaPlayer(instanceId,playListFlag,videoDisplayMode,height,width,left,top,muteFlag,useNativeUIFlag,subtitleFlag,videoAlpha,cycleFlag,randomFlag,autoDelFlag);
    mp.setVideoDisplayArea(0,0,1280,720);
    mp.setVideoDisplayMode(0);
    mp.setAllowTrickmodeFlag(0); //设置是否允许trick操作。 0:允许 1：不允许

    mp.setNativeUIFlag(0); //播放器是否显示缺省的Native UI，  0:允许 1：不允许
    mp.setAudioTrackUIFlag(1);//设置音轨的本地UI显示标志 0:不允许 1：允许

    mp.setMuteUIFlag(1); //设置静音的本地UI显示标志 0:不允许 1：允许
    mp.setAudioVolumeUIFlag(1);//设置音量调节本地UI的显示标志 0:不允许 1：允许
    startPlay("rtsp://58.60.146.6/PLTV/88888895/224/3221227202/10000100000000060000000000966366_0.smil");
}

document.onkeypress = keyEvent;
function keyEvent()
{
    var val = event.which ? event.which : event.keyCode;
    return keypress(val);
}
function keypress(keycode)
{
    switch(keycode)
    {
 	case 8:keyBack();return 0;//返回
	case 259:keyVolUp();return 0;//KEY_VOL_UP       音量加
	case 260:keyVolDown();return 0;//KEY_VOL_DOWN     音量减
	case 261:keyMute();return 0;//KEY_MUTE         静音
	default:return 1;
    }
}

function keyBack()
{
    window.location.href = "index.jsp";
}
function exitPage()
{
    mp.stop();
}

//以下为音量操作代码
function keyMute()
{
    if(mp.getMuteFlag() == 0)
    {
 	mp.setMuteFlag(1);
    }
    else
    {
	mp.setMuteFlag(0);
    }
}
function keyVolUp()
{
    mp.setMuteFlag(0);
    changeVolume(5);
}
function keyVolDown()
{
    mp.setMuteFlag(0);
    changeVolume(-5);
}
function changeVolume(num)
{
    var volume = mp.getVolume();
    volume = volume + num;
    volume = volume > 100 ? 100 : volume;
    volume = volume < 0 ? 0 : volume;
    mp.setVolume(volume);
}
</script>
</html>
