<!-- FileName:play_ControleTVod.jsp -->
<%-- 
	录制节目播放控制
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="java.util.*" %>
<%@ include file = "keyboard/keydefine.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>TVod</title>
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<style type="text/css"> 
<!--
body {  font-family:"Microsoft YaHei"; font-size:22px; color:#fff;  margin:0px; padding:0px; width:640px; height:530px; overflow:hidden; position:relative;/*line-height: 100%;*/}
pre,em,i,textarea,input,font{font-size:12px; font-weight:normal; font-style:normal}
img {border:0; margin:0}
button, input, select, textarea { font-size:100%;}
/*popup*/
.popup {
	background: url(../images/play/pop-bg2.gif) no-repeat;
	font-size:22px;
	height:262px;
	left:150px;
	position:absolute;
	top:135px;
	width:380px;
	z-index:9;
}
.pop_title {
	font-size:26px;
	left:10px; 
	position:absolute;
	text-align:center;
	top:52px; 
	width:360px; 
	align:center;
}
.pop_title2 { 
	left:10px; 
	position:absolute;
	text-align:center;
	top:52px; 
	width:360px; 
}
.pop_tip { 
	left:60px;
	line-height:36px; 
	position:absolute;
	text-align:center; 
	top:35px;
	width:380px; 
}
.pop_btns { 
	left:10px;
	position:absolute; 
	top:115px;  
	width:360px;
}
.pop_btns div { 
	height:35px;
	line-height:35px;
	position:absolute;
	top:0;
	text-align:center; 
}
.pop_btns .btn01 { width:155px;}
.pop_btns .btn02 { width:105px;}
.pop_btns div.on { background:url(../images/btn_bg.png) no-repeat;}
.pop_btns div.on2 { background:url(../images/btn2_bg.png) no-repeat;}
.volume {
	background:url(../images/play/volume-bg.png) no-repeat;
	height:45px;
	line-height:45px;
	left:102px; 
	position:absolute; 
	top:455px;
	width:431px;
}
.volume div{
	left:0; 
	position:absolute; 
	top:0;
}
.volume div.on{
	background:url(../images/play/volume-bgon.jpg) repeat-x;
	border:solid 1px #262626;
	height:21px;
	left:48px; 
	position:absolute; 
	top:9px;
}

-->
</style>
<%
String progId = request.getParameter("PROGID"); //节目id
int iProgId = 0;	
String channelId = request.getParameter("CHANNELID");//频道id
int iChannelId = 0;
String playType = request.getParameter("PLAYTYPE"); //播放类型
int iPlayType = 0;	
String beginTime = request.getParameter("PROGSTARTTIME"); //节目播放开始时间
String endTime = request.getParameter("PROGENDTIME"); //节目播放结束时间
String productId = request.getParameter("PRODUCTID"); //订购产品id	
String serviceId = request.getParameter("SERVICEID"); //对应服务id	
String price = request.getParameter("ONECEPRICE"); //该产品对应价格	
String contentType = request.getParameter("CONTENTTYPE");
String chanNum = request.getParameter("LOGICCHANNELID")==null?"-1":request.getParameter("LOGICCHANNELID").toString();//频道id

MetaData metaData = new MetaData(request);
String SDintroduce = "";
HashMap SDinfomap = metaData.getTypeInfoByTypeId("10000100000000090000000000031911"); //过滤频道

if(SDinfomap!=null){
	SDintroduce = (String)SDinfomap.get("TYPE_INTRODUCE");
}
String allIntroduce = SDintroduce;
String[] strarray = allIntroduce.split("@");

//vasTvod
String vasTvod =request.getParameter("vasTvod");
if(vasTvod == null)
{
	vasTvod="0";
}
String playUrl = ""; //触发机顶盒播放地址
boolean isSucess = true;
/*******************对获取参数进行异常处理 start*************************/
try
{
	iProgId = Integer.parseInt(progId);
	iChannelId = Integer.parseInt(channelId);
	iPlayType = Integer.parseInt(playType);
}
catch(Exception e)
{
	iProgId = -1;
	iChannelId = -1;
	iPlayType = EPGConstants.PLAYTYPE_TVOD;
	isSucess = false;
}
if(beginTime == null || "".equals(beginTime))
{
	beginTime = "0";
}	
if(endTime == null  || "".equals(endTime))
{
	endTime = "0";
}
if(productId == null || "".equals(productId))
{
	productId = "0";
}
if(serviceId == null || "".equals(serviceId))
{
	serviceId = "0";
}	
if(price == null || "".equals(price))
{
	price = "0";
}	
if(contentType == null || "".equals(contentType))
{
	contentType =String.valueOf(EPGConstants.CONTENTTYPE_PROGRAM);
}
String infoDisplay = "errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=26";

/*******************对获取参数进行异常处理 end*************************/


ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);

ServiceHelp serviceHelp = new ServiceHelp(request);

int iShowDelayTime = 5000;
try
{
	String showDelayTime = serviceHelp.getMiniEPGDelay ();
	iShowDelayTime = Integer.parseInt(showDelayTime)* 1000;
}
catch(Exception e)
{
	iShowDelayTime = 5000;
}	
/*************************获取播放url start**************************************/
try
{
	if(vasTvod.equals("1"))
	{
		playUrl = serviceHelpHWCTC.getTriggerPlayUrlHWCTC(iPlayType,iChannelId,iProgId,beginTime,endTime,productId,serviceId,contentType)+"&playseek="+beginTime+"-"+endTime;
	}
	else
	{
		playUrl = serviceHelpHWCTC.getTriggerPlayUrlHWCTC(iPlayType,iChannelId,iProgId,beginTime,endTime,productId,serviceId,contentType);
	}
	if(playUrl != null && playUrl.length() > 0)
	{
		int tmpPosition = playUrl.indexOf("rtsp");
		if(-1 != tmpPosition)
		{
			playUrl = playUrl.substring(tmpPosition,playUrl.length());
		}
		else
		{
			isSucess = false;
		}
	}
}
catch(Exception e)
{
	%>
	  <script> location.href="errorinfo.jsp?ERROR_TYPE=1&ERROR_ID=180"; </script>
	<%
}
/*************************获取播放url end**************************************/			
TurnPage turnPage = new TurnPage(request);	
String goBackUrl = turnPage.go(-1);	
if(!isSucess)
{
	response.sendRedirect(infoDisplay);
}
int itype = 0;
String type=request.getParameter("ECTYPE");	
if(type != null && type !="" && type != "null")
{	
	itype=Integer.parseInt(type);
}
%>
<style>
.blueFont
{   
	font:"黑体";
	color:#33CCFF
}
.whiteFont
{
	font:"黑体";
	color:#FFFFFF
}
</style>
<script>	
var markArray = new  Array();//用来存放过滤的数据
<%
	for(int i = 0;i < strarray.length;i++)
	{
%>
		markArray[<%=i %>] = "<%=strarray[i] %>";
<%
	}
%>

if (typeof(iPanel) != 'undefined')
{
iPanel.focusWidth = "4";
iPanel.defaultFocusColor = "#FCFF05";
}
//页面加载前执行的数据转换与方法 
var itype="<%=itype%>";
var count=0;
//提示信息计时器
var tempShowMsgTimer = "";
var playStatFlag=0;
var chanNum=<%=chanNum%>;
var progId = '<%=iProgId%>'; //当前播放的vodid
var channelId = '<%=iChannelId%>'; //当前节目单对应的 频道号
var playType = '<%=iPlayType%>'; //播放的类型
var playUrl = '<%=playUrl%>';//触发机顶盒播放url
var beginTime = '<%=beginTime%>';
var isAssess = <%= iPlayType == EPGConstants.PLAYTYPE_BOOKMARK%>; //是否是片花播放
var isBookMark = <%= iPlayType == EPGConstants.PLAYTYPE_ASSESS%>; //是否为书签播放
var hideTime = <%=iShowDelayTime%>; //epg自动隐藏时间
var delayTime = 8000; //epg开机延时显示minepg时间
var dataIsOk = false; //数据是否准备结束
var goBackUrl = '<%=goBackUrl%>';
var minEpgIsShow = false; //minepg是否显示标志位
var minEpgShowDelayId = 0;
var minEpgHideDelayId = 0;
/******************在iframe页面赋值的参数 start********************************/
var startDate = "";//节目开始日期 
var preProgId = "-1"; //tvod上一集id
var preProgName = "";
var preProgBeginTime = "";
var preProgEndTime = "";
var nextProgId = "-1" //tvod下一集id
var nextProgName = "";
var nextProgBeginTime = "";
var nextProgEndTime = "";
var progName = "";//本节目的名字
var channelName = "";//频道名称
var progTimeBegin = "";//节目开始时间
var progTimeEnd = "";//节目结束时间
var progTimeSpan = ""; //节目开始时间~结束时间
var introduce = "";
var timePerCell = mediaTime / 100;
var currCellCount = 0;
var seekStep = 1;//每次移动的百分比
var isSeeking = 0;
var tempCurrTime = 0;
var timeID_playByTime = 0;
var isJumpTime = 1;//跳转输入框是否显示,1默认显示
var speed = 1;
var playStat = "play";
var mediaTime = 0;
var timeID_jumpTime = "";
var initMediaTime = 0;
var timeID_check = "";
var preInputValue = "";
var showTimer = "";
var volume = 20;
var jumpPos = 4;
var voiceflag="";
var bottomTimer = "";
var positionFlag = 1; //记录退出层焦点位置0:继续 1：退出 2 书签退出
var PauseDivIsShow = false;//整个暂停和进度，输入框
var seekDivIsShow = false;
var volumeDivIsShow = false;
var finishedDivIsShow = false;
var quitDivIsShow=false;
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
var mp = new MediaPlayer();
var currTime = mp.getCurrentPlayTime();
/**
*初始话mediaPlay对象
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
    var cycleFlag = 1;
    var randomFlag = 0;
    var autoDelFlag = 0;
    mp.initMediaPlayer(instanceId,playListFlag,videoDisplayMode,height,width,left,top,muteFlag,useNativeUIFlag,subtitleFlag,videoAlpha,cycleFlag,randomFlag,autoDelFlag);
	mp.setSingleMedia(mediaStr); //设置媒体播放器播放媒体内容
	mp.setCycleFlag(1); //0循环播放   1单次播放
    mp.setNativeUIFlag(1); //0不使UI本地显示 		   1本地显示
    mp.setMuteUIFlag(1);  //0静音图标不显示			    1本地显示  
    mp.setAudioVolumeUIFlag(1);//设置音量调节本地UI的显示标志 0:不允许 1：允许
    mp.setAudioTrackUIFlag(1);
	mp.setProgressBarUIFlag(1);
    mp.setChannelNoUIFlag(1); //0不使频道号本地显示 		   1本地显示
	mp.setAllowTrickmodeFlag(0);//0允许媒体快进，快退，暂停  1本地控制
    mp.setVideoDisplayArea(0, 0, 0, 0);//全屏显示
    mp.setVideoDisplayMode(1); 
    mp.refreshVideoDisplay(); //调整视频显示，需要上面两函数配合
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
	
/**
*播放
*/
function play()
{
	if(isBookMark)
	{
		var type = 1;
		var speed = 1;
		mp.playByTime(type,beginTime,speed);
	}
	else{mp.playFromStart();}
}
/**
*进入页面后直接播放
*/
function start()
{	
	setSTB();
	initMediaPlay();		
	play();
}

function unload()
{
	mp.stop();
}

function $(strId)
{
	return document.getElementById(strId);
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
		case <%=KEY_UP%>:return pressKey_up();
		case <%=KEY_DOWN%>:return pressKey_down();				
		case <%=KEY_LEFT%>:  return pressKey_left();			  
		case <%=KEY_RIGHT%>: return pressKey_right();			
		case <%=KEY_PAGEDOWN%>:return pressKey_pageDown();		
		case <%=KEY_PAGEUP%>:return pressKey_pageUp();	
		//case <%=KEY_PAUSE_PLAY%>:
		//case <%=KEY_POS%>:pauseOrPlay();return false;
		//case <%=KEY_FAST_FORWARD%>:fastForward();return false;
		//case <%=KEY_FAST_REWIND%>:fastRewind();return false;
		//case <%=KEY_VOL_UP%>:volumeUp();return false;
		//case <%=KEY_VOL_DOWN%>:volumeDown();return false;
		case <%=KEY_MUTE%>:setMuteFlag();return false;
		case <%=KEY_RETURN%>:pressKey_quit();return 0;  //退出时处理
		//适配华为webkit
		case <%=KEY_STOP%>:pressKey_Stop();return 0;
		case <%=KEY_IPTV_EVENT%>:goUtility();break;
		case <%=KEY_INFO%>: showMinEpgByInfo();return 0;
		case <%=KEY_BLUE%>:mp.stop();window.location.href="space_collect.jsp";return 0;
		case <%=KEY_TRACK%>: changeAudio(); return 0;
		case <%=KEY_OK%>:pressOk();  return 0;
		case  1131://删除
			if(PauseDivIsShow){delInputTime();}
			return 0;break;
	   case 277:
	   case  1109:
			mp.stop();
			window.location.href="vod.jsp?returnurl=";
		    return false;break;
	   case 276:
	   case 1110:
			mp.stop();
			window.location.href="playback.jsp?returnurl=";
			return false;break;
		case 275:
		case 1108:
		    mp.stop();
		    window.location.href="live.jsp?returnurl=";
		    return false;break;
	   case 1105://搜索
			mp.stop();
			window.location.href="search.jsp";
			return 0;
		case 281://收藏
			return 0;
		default:
			return videoControl(keyval);
	}
	return true;
}
/************************************************按键响应处理 start************************************************/
//20120330修改为div以及自动跳转
function showInputTime(id){
	var bufInput;	
    if(jumpPos == 0){
    	bufInput = $("jumpTimeHour").innerText;
		if(bufInput == " "){bufInput = "";}
        else if(bufInput.length<2){ 
			$("jumpTimeHour").innerText = bufInput+id;
			if(($("jumpTimeHour").innerText).length==2){jumpPressKeyRight();}
		}
    }else if(jumpPos == 1){
        bufInput = $("jumpTimeMin").innerText;
		if(bufInput == " "){bufInput = "";}
        else if(bufInput.length<2){
			$("jumpTimeMin").innerText = bufInput+id;
			if(($("jumpTimeMin").innerText).length==2){jumpPressKeyRight();}
		}       	
    }
}

function delInputTime()
{
	var bufInput;	
    if(jumpPos == 0){
    	bufInput = $("jumpTimeHour").innerText;;
		if(bufInput.length>0){$("jumpTimeHour").innerText=bufInput.substring(0,bufInput.length-1);}
    }else if(jumpPos == 1){
        bufInput = $("jumpTimeMin").innerText;
		if(bufInput.length>0){$("jumpTimeMin").innerText=bufInput.substring(0,bufInput.length-1);}
    }
}


function changeAudio()
{
    mp.switchAudioChannel();
	/*var audio = mp.getCurrentAudioChannel(); //FOR ZTE
	if(audio=="0" || audio=="Left"){ audio=0;}
	else if(audio=="1" ||  audio=="Right"){ audio=1;	}
	else if(audio=="2" ||  audio=="JointStereo" ||  audio=="Stereo"){ audio=2;	}
	clearTimeout(voiceflag);
	switch(audio)
	{
		case 0:
		$("voice").src="images/voice/leftvoice.png";
		break;
		case 1:
		$("voice").src="images/voice/rightvoice.png";
		break;
		case 2:
		$("voice").src="images/voice/centervoice.png";
		break;
		default:
		break;
	}
	voiceflag=setTimeout(function(){$("voice").src="images/dot.gif";},5000);*/
}
function pressOk()
{	
	var totalTime = mp.getMediaDuration();
	currTime = parseInt(mp.getCurrentPlayTime()) + parseInt(count*60);
	if(currTime<=0){currTime=1;}	
	if(quitDivIsShow){
		if(positionFlag==0){cancel();}
		else if(positionFlag==1){quit();}
	}
	else if(!PauseDivIsShow){pressKey_info_Ok();}
	else if(PauseDivIsShow && jumpPos==4)
	{
		playByTime(currTime);
		$("seekDiv").style.display = "none";
		isSeeking = 0;
		speed = 1;
		PauseDivIsShow=false;
	}
	else if(PauseDivIsShow && jumpPos==2){clickJumpBtn();}
	else if(PauseDivIsShow && jumpPos==3){
		//pauseOrPlay();//取消的模式
		resetHHAndMM();//重置时间
	}
	return 0;
}

function resetHHAndMM()
{
	$("jumpTimeHour").innerText="";
	$("jumpTimeMin").innerText="";
	jumpDIvPos=0;
	$("jumpTimeHour").className="inpon";
    $("cancelJump").className="btn02";
}

function setMuteFlag()
{
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return true;}
	if(minEpgIsShow){hideMinEpg();}
	clearTimeout(showTimer);
	showTimer = "";
	clearTimeout(bottomTimer);
	bottomTimer = "";
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1)
	{
		mp.setMuteFlag(0);
		/*if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
		{
			$("voice").src="images/playcontrol/playChannel/muteoff.png";
			bottomTimer = setTimeout("hideMute();", 5000);
		}*/
	}
	else
	{
		mp.setMuteFlag(1);
		/*if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
		{
			$("voice").src="images/playcontrol/playChannel/muteon.png";
			bottomTimer = setTimeout("hideMute();", 5000);
		}*/
	}
}
	
function hideMute()
{
	$("voice").src="#";
}
function pauseOrPlay()
{	
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return true;}
	if(PauseDivIsShow){resetPauseOrPlay();}
	if(minEpgIsShow){hideMinEpg();	}
	speed = 1;	
	PauseDivIsShow=true;	
	if($("jumpTimeHour")!=undefined)$("jumpTimeHour").innerText="";
    if($("jumpTimeMin")!=undefined) $("jumpTimeMin").innerText="";	
	displaySeekTable(0);//显示进度条及跳转框
	playStatFlag=1;
	$("statusImg").innerHTML = '<img src="../images/play/btn-pause.png"/>';
	$("speed").innerHTML = '';
}

//reset播放暂停焦点
function resetPauseOrPlay()
{
	if(jumpPos==0){$("jumpTimeHour").className="inp";}
	else if(jumpPos==1){$("jumpTimeMin").className="inp";}
	else if(jumpPos==2){$("ensureJump").className="btn02";}
	else if(jumpPos==3){$("cancelJump").className="btn02";}
}

function volumeUp()
{
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow|| isSeeking==1){return true;}
	clearTimeout(showTimer);
	showTimer = "";
	if(minEpgIsShow){hideMinEpg();}
	var muteFlag =  mp.getMuteFlag();
	if(muteFlag == 1){mp.setMuteFlag(0);}
	if(!volumeDivIsShow){volume = mp.getVolume();genVolumeTable();volumeDivIsShow = true;} 
	volume += 5;
	if(volume > 100){volume = 100;return;}
	changeVolume(volume);
	mp.setVolume(volume);
	clearTimeout(bottomTimer);
	bottomTimer = "";
	bottomTimer=setTimeout(hideBottom, 3000);	
}
	
function hideBottom()
{
	volumeDivIsShow = false;
	$("volumeDiv").style.display = "none";
}
	
function genVolumeTable()
{
	//$("volumeDiv").style.display = "block";//for ZTE
}

function changeVolume(volume)
{
	//$("volumeLen").style.width=volume+"%";//for ZTE
	//$("volumeCur").innerHTML=volume;//for ZTE
}
function volumeDown()
{
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow|| isSeeking==1){return true;}
	clearTimeout(showTimer);
	showTimer = "";
	if(minEpgIsShow){hideMinEpg();}
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){mp.setMuteFlag(0);}
	if(!volumeDivIsShow){volume = mp.getVolume();genVolumeTable();volumeDivIsShow = true;} 
	volume -= 5;
	if(volume <0){volume = 0;return;}
	changeVolume(volume);
	mp.setVolume(volume);
	clearTimeout(bottomTimer);
	bottomTimer = "";
	bottomTimer = setTimeout(hideBottom, 3000);
}

  
function convertTime(_time)
{
	if(null == _time || _time.length == 0){_time = mp.getMediaDuration();}
	var returnTime = "";
	var time_second = "";
	var time_min = "";
	var time_hour = "";
	time_second = String(_time % 60);
	var tempIndex = -1;
	tempIndex = (String(_time / 60)).indexOf(".");
	if(tempIndex != -1)
	{
		time_min = (String(_time / 60)).substring(0,tempIndex);
		tempIndex = -1;
	}
	else{time_min = String(_time / 60);}
	tempIndex = (String(time_min / 60)).indexOf(".");
	if(tempIndex != -1)
	{
		time_hour = (String(time_min / 60)).substring(0,tempIndex);
		tempIndex = -1;
	}
	else{time_hour = String(time_min / 60);}
	time_min = String(time_min % 60);
	if("" == time_hour || 0 == time_hour){time_hour = "00";}
	if("" == time_min || 0 == time_min){time_min = "00";}
	if("" == time_second || 0 == time_second){time_second = "00";}
	if(time_hour.length == 1){time_hour = "0" + time_hour;}
	if(time_min.length == 1){time_min = "0" + time_min;}
	if(time_second.length == 1){time_second = "0" + time_second;}
	returnTime = time_hour + ":" + time_min + ":" + time_second;
	return returnTime;
}

function displaySeekTable(playFlag)
{
	mediaTime = mp.getMediaDuration();
	//有时机顶盒取出的vod总时长有问题，在这里重新获取。initMediaTime是初始化页面时取出的总片长
	if(undefined == mediaTime || typeof(mediaTime) != "number" || mediaTime.length == 0 || 0 == mediaTime || initMediaTime != mediaTime)
	{
		mediaTime = mp.getMediaDuration();
		timePerCell = mediaTime / 100;
	}		
	//isSeeking等于0时展示进度条及跳转框
	if(isSeeking == 0)
	{	
		isSeeking = 1;
		PauseDivIsShow = true;
		currTime = mp.getCurrentPlayTime();
		processSeek(currTime);
		if(minEpgIsShow){hideMinEpg();}
		if (playFlag != 1)
		{
			mp.pause();//暂停播放
			playStatus=0;
			$("jumpTimeDiv").style.display = "block"; 
			jumpTimeIsShow=true;
		}
		var fullTimeForShow = "";
		fullTimeForShow = convertTime();
		$("fullTime").innerHTML = fullTimeForShow;
		//$("statusImg").innerHTML = '<img border="0" src="images/playcontrol/playTvod/pause.png" width="40" height="40"/>';
		$("seekDiv").style.display = "block";
		jumpPos=4;
		$("currentTime_progress").className="baron";
		//15秒后隐藏跳转输入框所在的div
		clearTimeout(timeID_jumpTime);
		timeID_jumpTime = "";
	   // timeID_jumpTime = setTimeout("hideJumpTimeDiv();",15000);
		checkSeeking();//调用方法检测进度条及跳转框的状态
		seekDivIsShow = true;
		if(playFlag==1)
		{
			PauseDivIsShow = false;	
		}			
	}
	//isSeeking等于1时
	else
	{
		clearTimeout(timeID_check);//清空定时器
		timeID_check = "";
		resetPara_seek();//复位各参数
		
		// 如果切换到开头则不需要恢复播放，机顶盒会自动播放
		if (playFlag != 2 && playFlag != 3)
		{	
			speed= 1;
			resume();//恢复播放状态
			//playStatus = 1;
		}
		seekDivIsShow = false;
		PauseDivIsShow = false;
		$('seekDiv').style.display = 'none';
		$("jumpTimeDiv").style.display = "none";
		jumpPos = 4;//20120329修改隐藏后默认焦点到进度条
	}
}
  //跳转提示信息隐藏后，重置相关参数
function resetPara_seek()
{
	clearTimeout(timeID_jumpTime);
	timeID_jumpTime = "";
	isSeeking = 0;
	isJumpTime = 1;
	jumpPos = 0;
	preInputValue = "";playStat = "play";
	$("jumpTimeDiv").style.display = "block";
	$("jumpTimeHour").innerText = "";
	$("jumpTimeMin").innerText = "";
	$("timeError").innerHTML = "";//请输入时间！
	$("statusImg").innerHTML = '<img src="../images/play/icon-fast-enter.png">';
}
	
function checkSeeking()
{
	if(isSeeking == 0)
	{
		clearTimeout(timeID_check);
		timeID_check = "";
	}
	else
	{
		var inputValueHour = $("jumpTimeHour").innerText;
		var inputValueMin = $("jumpTimeMin").innerText;	
		currTime = mp.getCurrentPlayTime();
		clearTimeout(timeID_check);
		timeID_check = "";
		timeID_check = setTimeout(checkSeeking,1000);	
		if(playStatFlag==0 && (playStat == "fastrewind" || playStat == "fastforward"))
		{
			processSeek(currTime);
		}
		if(preInputValueHour != inputValueHour || preInputValueMin != inputValueMin)
		{
			var tempTimeID = timeID_jumpTime;
			//5秒后隐藏跳转输入框所在的div
			clearTimeout(tempTimeID);
			tempTimeID = "";
			timeID_jumpTime = setTimeout(hideJumpTimeDiv,15000);
			preInputValueHour = inputValueHour;
			preInputValueMin = inputValueMin;
		}
	}
}
function hideJumpTimeDiv()
{
	clearTimeout(timeID_jumpTime);
	timeID_jumpTime = "";
	preInputValueHour = "";
	preInputValueMin = "";
	PauseDivIsShow = false;
	var inputValueHour =  $("jumpTimeHour").innerText;
	var inputValueMin =  $("jumpTimeMin").innerText;
	//如果文本框中的值为空，隐藏div
	if(isEmpty(inputValueHour) || isEmpty(inputValueMin)){
		isJumpTime = 0;
	}else//如果文本框中有值则调用clickJumpBtn方法
	{
		clickJumpBtn();
	}
	if(jumpPos==0){$("jumpTimeHour").className="inp";}
	else if(jumpPos==1){$("jumpTimeMin").className="inp";}
	else if(jumpPos==2){$("ensureJump").className="btn02";}
	else if(jumpPos==3){$("cancelJump").className="btn02";}
	count=0;
	jumpPos=4;
	$("seekDiv").style.display = "none";
}
	  
function isNum(s)
{
	var nr1=s;
	var flg=0;
	var cmp="0123456789"
	var tst ="";

	for (var i=0;i<nr1.length;i++)
	{
		tst=nr1.substring(i,i+1)
		if (cmp.indexOf(tst)<0){flg++;}
	}
	if (flg == 0){return true;}
	else{return false;}
}
 //判断是否在播放时长内
function isInMediaTime(pHour, pMin)
{
	pHour = pHour.replace(/^0*/, "");
	if(pHour == ""){pHour = "0";}
	pMin = pMin.replace(/^0*/, "");        
	if(pMin == ""){pMin = "0";}
	var alltime=pHour*3600+pMin*60
	return (alltime <= mediaTime);
}
function checkJumpTime(pHour, pMin)
{        
	if(isEmpty(pHour)){return false;}
	else if(!isNum(pHour)){return false;}
	if(isEmpty(pMin)){return false;}
	else if(!isNum(pMin)){return false;}
	else if(!isInMediaTime(pHour, pMin)){return false;}
	else{return true;}
}
function playByTime(beginTime)
{
	var type = 1;
	var speed = 1;
	mp.playByTime(type,beginTime,speed);
	currTime = mp.getCurrentPlayTime();
    count=0;
	jumpPos=4;//20120329
	$("currentTime_progress").className="bar";
}
function jumpToTime(_time)
{
	_time = parseInt(_time,10);
	playByTime(_time);
	processSeek(_time);
}
function clickJumpBtn()
{
	var inputValueHour = $("jumpTimeHour").innerText;
	var inputValueMin = $("jumpTimeMin").innerText;
	if(isEmpty(inputValueHour)){ inputValueHour="00";}
	if(isEmpty(inputValueMin)){inputValueMin="00";}
	$("ensureJump").className="btn02";
	if(checkJumpTime(inputValueHour, inputValueMin))
	{
		var hour = parseInt(inputValueHour,10);
		var mins = parseInt(inputValueMin,10);
		var timeStamp =  hour*3600 + mins*60;
		clearTimeout(timeID_jumpTime);
		timeID_jumpTime = "";
		displaySeekTable(3);
		jumpToTime(timeStamp);
	}
	else
	{
		$("jumpTimeHour").innerText = "";
		$("jumpTimeMin").innerText = "";
		$("timeError").innerHTML = "时间输入不合理，请重新输入！";
		preInputValue = "";
		jumpPos = 0;
		$("jumpTimeHour").className="inpon";

		//15秒后隐藏跳转输入框所在的div
		clearTimeout(timeID_jumpTime);timeID_jumpTime = "";
		setTimeout(inputErrorcls,10000);
		//timeID_jumpTime = setTimeout("hideJumpTimeDiv();",15000);
	}
	count=0;
}

function inputErrorcls()
{
	$("timeError").innerHTML = "";
}

function isEmpty(s)
{
	return ((s == undefined) || (s == "") || (s == null) || (s.length == 0));
}
function processSeek(_currTime)
{
	if(null == _currTime || _currTime.length == 0){ _currTime = mp.getCurrentPlayTime();}
	if(_currTime < 0){_currTime = 0;}
	if(_currTime>mediaTime){_currTime=mediaTime;}
	var tempIndex = -1;
	tempIndex = (String(_currTime / timePerCell)).indexOf(".");
	if(tempIndex != -1){currCellCount = (String(_currTime / timePerCell)).substring(0,tempIndex);}
	else{currCellCount = String(_currTime / timePerCell);}
	if (timePerCell == 0){currCellCount = 0;}
	if(currCellCount > 100){currCellCount = 100;}
	if(currCellCount < 0){currCellCount = 0;}
	var currTimeDisplay = convertTime(_currTime);
	if(currCellCount >= 100){ $("td_1").style.width = 360; }
	else if(currCellCount<=0){ $("td_1").style.width = 0;	}
	else{$("td_1").style.width = currCellCount * 3.6;}
	$("currTimeShow").innerHTML = currTimeDisplay;
}

//信息键OSD上时间进度控制
 function processSeek1(_currTime)
 {
	//如果入参时间为空，则取当前时长
	mediaTime = mp.getMediaDuration();
	timePerCell = mediaTime / 100;
	if(null == _currTime || _currTime.length == 0){ _currTime = mp.getCurrentPlayTime();}
	if(_currTime < 0){ _currTime = 0;}
	if(_currTime>mediaTime){ _currTime=mediaTime;}
	var tempIndex = -1;
	tempIndex = (String(_currTime / timePerCell)).indexOf(".");
	if(tempIndex != -1){ currCellCount = (String(_currTime / timePerCell)).substring(0,tempIndex);}
	else{  currCellCount = String(_currTime / timePerCell);}
	if (timePerCell == 0){currCellCount  = 0;}
	if(currCellCount > 100){currCellCount = 100;}
	if(currCellCount < 0){currCellCount = 0;}
	//$("seekPercent").innerHTML = currCellCount + "%";//20120331屏蔽当前播放的百分比
	var currTimeDisplay = convertTime(_currTime);//将时间（单位：秒）转换成在页面中显示的格式（HH：MM?
	if(currCellCount >= 100){ $("bar_0").style.width = 195; }
	else if(currCellCount<=0){ $("bar_1").style.width = 0;}
	else{$("bar_1").style.width = currCellCount * 1.95;}
	//$("currTimeShow").innerHTML = currTimeDisplay;
}

//快进
function fastForward()
{	
	if(isSeeking == 0)
	{	
		displaySeekTable(1);clearTimeout(timeID_jumpTime);timeID_jumpTime = "";isJumpTime = 0;playStatFlag=0;
		$("statusImg").innerHTML = '<img src="../images/play/icon-fast-enter.png">';
		if(volumeDivIsShow){volumeDivIsShow=false;hideBottom();}
		if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return true;}
		playStat = "fastforward";
	}
	if(playStat != "fastforward"||(speed >= 32 && playStat == "fastforward")) {speed = 1;}
	if(playStat != "fastforward"){$("statusImg").innerHTML = '<img src="../images/play/icon-fast-enter.png">';playStat = "fastforward";}
	speed = speed * 2;$("speed").innerHTML = 'X'+speed;	mp.fastForward(speed);		
}
//快退
function fastRewind()
{
	if(isSeeking == 0)
	{
		displaySeekTable(1);clearTimeout(timeID_jumpTime);timeID_jumpTime = "";isJumpTime = 0;playStatFlag=0;
		$("statusImg").innerHTML = '<img src="../images/play/icon-fast-return.png"/>';
		if(volumeDivIsShow){volumeDivIsShow=false;hideBottom();}
	    if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return true;}	
		playStat = "fastrewind";	
	}
    if(playStat != "fastrewind" || (speed >= 32 && playStat == "fastrewind")){ speed = 1;}
	if(playStat != "fastrewind" ){$("statusImg").innerHTML = '<img src="../images/play/icon-fast-return.png"/>';playStat = "fastrewind";}
	speed = speed * 2;$("speed").innerHTML = 'X'+speed;	mp.fastRewind(-speed);				
}
function pressKey_up()
{
	if(quitDivIsShow){mainPressKeyUp();}
	else if(oneKeySwitchJumpInfoIsShow){commonPressKeyUp();}
	else if(jumpToChannelInfoIsShow){commonPressKeyUp();}
	else if(PauseDivIsShow)
	{
		resetPauseOrPlay();
		jumpPos=4;
		$("currentTime_progress").className="baron";
		return;
	}
	return false;
}
	
function pressKey_down()
{
	if(quitDivIsShow){mainPressKeyDown();}
	else if(oneKeySwitchJumpInfoIsShow){commonPressKeyDown();}
	else if(jumpToChannelInfoIsShow){commonPressKeyDown();}
	else if(PauseDivIsShow && jumpPos==4)
	{		
		jumpPos=0;
		$("currentTime_progress").className="bar";
		$("jumpTimeHour").className="inpon";
		return;
	}
	return false;
}
function pressKey_left()
{	
	if(quitDivIsShow){mainPressKeyLeft();}
	else if(oneKeySwitchJumpInfoIsShow){commonPressKeyLeft();}
	else if(jumpToChannelInfoIsShow){commonPressKeyLeft();}
	else if(PauseDivIsShow){jumpPressKeyLeft();}
	else{volumeDown();}
	return false;
}
	
function pressKey_right()
{
	if(quitDivIsShow){mainPressKeyRight();}
	else if(oneKeySwitchJumpInfoIsShow){commonPressKeyRight();}
	else if(jumpToChannelInfoIsShow){commonPressKeyRight();}
	else if(PauseDivIsShow){jumpPressKeyRight();}
	else
	{
		volumeUp();
		//fastForward();
	}
	return false;
}
	
function jumpPressKeyRight()
{
	//说明：0:小时 1：分 2：确认 3：取消 4：进度
	if(jumpPos == 0){
		$("jumpTimeHour").className="inp";
		$("jumpTimeMin").className="inpon";
		jumpPos++;
	}
	else if(jumpPos == 1){
		$("jumpTimeMin").className="inp";
		$("ensureJump").className="btn02 on2";
		jumpPos++;
	}
	else if(jumpPos==2){
		$("ensureJump").className="btn02";
		$("cancelJump").className="btn02 on2";
		jumpPos++;	
	}
	else if(jumpPos==4){
		  var totalTime = parseInt(mp.getMediaDuration());
		  var currTime = parseInt(mp.getCurrentPlayTime());
		  count++;
		  currTime =currTime+parseInt(60*count);
		  if(currTime>=totalTime)
		  {
			currTime=totalTime;
			count--;
		  }
		  clearTimeout(timeID_jumpTime);
		  timeID_jumpTime = "";
		  isJumpTime = 0;
		  processSeek(currTime);
	}
}
function jumpPressKeyLeft()
{
	if(jumpPos == 1){
		$("jumpTimeMin").className="inp";
		$("jumpTimeHour").className="inpon";
		jumpPos--;
	}else if(jumpPos == 2){
		$("ensureJump").className="btn02";
		$("jumpTimeMin").className="inpon";
		jumpPos--;
	}else if(jumpPos==3){		
		$("cancelJump").className="btn02";
		$("ensureJump").className="btn02 on2";
		jumpPos--;
	}else if(jumpPos==4){
		var currTime = parseInt(mp.getCurrentPlayTime());
		count--;
		currTime = currTime+parseInt(count*60);
		if(currTime<=0){
			currTime=0;
			count++;
		}
		clearTimeout(timeID_jumpTime);
		timeID_jumpTime = "";
		isJumpTime = 0;	
		processSeek(currTime);
	}
}
function showMinEpgByInfo()
{
	if(!quitDivIsShow && !jumpToChannelInfoIsShow && !oneKeySwitchJumpInfoIsShow && !finishedDivIsShow)
	{
		if(!dataIsOk){return true;}
		if(minEpgIsShow){hideMinEpg();}
		else{showMinEpg();}
		return true;
	}
}
	
function pressKey_info_Ok()
{
	if(!quitDivIsShow && !jumpToChannelInfoIsShow && !oneKeySwitchJumpInfoIsShow && !finishedDivIsShow){
		if(!dataIsOk){return true;}
		if(minEpgIsShow){hideMinEpg();}
		else{showMinEpg();}
		return true;
	}else if(quitDivIsShow){
		mainPressKeyOk();
		return true;
	}else if(jumpToChannelInfoIsShow){
		commonPressKeyOk();
	}else if(oneKeySwitchJumpInfoIsShow){
		commonPressKeyOk();
	}		
}
	
function pressKey_quit()
{
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || quitDivIsShow || finishedDivIsShow){return true;}
	if(isSeeking == 1){displaySeekTable(1);count=0;jumpPos=0;$("currentTime_progress").className="bar";}
    else{
		setTimeout(showQuitDiv,200);
		hideAllDiv();
		pause();
	}	
	if(errorDivIsShow){hideErrorDiv();}
}
	
	
function pressKey_Stop()
{
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || quitDivIsShow || finishedDivIsShow){	return true;}
	if(errorDivIsShow){hideErrorDiv();}
	else{
		hideAllDiv();
		pause();
		change_focus(positionFlag,false); //hwwebkit
		resetQuitDiv();
		showQuitDiv();
	//	setEPG();
	}	
}
	
function pressKey_pageUp()
{
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return false;}
	mp.gotoStart();
	return true;
}
	
function pressKey_pageDown()
{
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return false;}
	mp.gotoEnd();
	return true;
}
	
function mainPressKeyUp()
{
	change_focus(positionFlag,false);
	positionFlag--;
	if(positionFlag<0){positionFlag=0;}
	change_focus(positionFlag,true);
}

//焦点修改内
function change_focus(pos,flag)
{
	if(flag){		
		$("quit_"+pos).className="btn01 on";
	}else{		
		$("quit_"+pos).className="btn01";
	}
}

function mainPressKeyDown()
{
	change_focus(positionFlag,false);
	positionFlag++;
	if(positionFlag>1){positionFlag=1;}
	change_focus(positionFlag,true);
}

//退出层出现的时候的左键
function mainPressKeyLeft()
{
	/*if(positionFlag == 1)
	{
		positionFlag--;
		$("quit").focus();
	}*/
	//alert("mainPressKeyLeft");
	return false;
}

function mainPressKeyRight()
{
	/*if(positionFlag == 0)
	{
		positionFlag++;
		$("cancel").focus();
	}*/
	//alert("mainPressKeyRight");
	return false;
}

function mainPressKeyOk()
{
}
/**
*机顶盒事件响应
*/
function goUtility()
{
	eval("eventJson = " + Utility.getEvent());	
	var typeStr = eventJson.type;
	switch(typeStr)
	{
		case "EVENT_MEDIA_ERROR":
			mediaError(eventJson);
			return false;
		case "EVENT_PLAYMODE_CHANGE":
			resumeMediaError(eventJson);
			 break;	  		
		case "EVENT_MEDIA_END":
			finishedPlay();
			return false;
		case "EVENT_MEDIA_BEGINING":
			hideAllDiv();
			speed = 1;
			break;
		case "EVENT_TVMS":
			getTvms(eventJson);      	
			return false;
		case "EVENT_TVMS_ERROR":
			top.TVMS.closeMessage();
			top.TVMS.setKeyForSTB();
			return false;
		default :
			break;
	}
	return true;
}

function getTvms(eventJson)
{
	top.TVMS.showMessage(eventJson);
}
/**
*出现错误
*/
function mediaError(eventJson)
{
	var type = eventJson.error_code;
	if(10 == type){showMediaError();}
}
	
//显示错误提示
function showMediaError()
{
	hideAllDiv();
	hideOneKeySwitchJumpInfo();
	hideJumpToChannelInfo();
	showErrorDiv();
	$("confirm").focus();
}
	
//码流恢复事件响应
function resumeMediaError(eventJson)
{
	var type_new_play = eventJson.new_play_rate;
	var type_old_play = eventJson.old_play_rate;
	if(1 == type_new_play && 0 == type_old_play)
	{
		hideErrorDiv();
		resume(); 
	}		
}
/********************************************按键响应处理 end**************************************************************/
/**
*播放暂停
*/
function pause()
{
	mp.pause();
}
/**
*恢复播放
*/
function resume() 
{
	mp.resume(); 
}
	
/**
*取消退出层
*/
function cancel()
{
	positionFlag=0;
	resume();
	hideQuitDiv();
}

function quitDivShow()
{
	alert("quit");	
}	
/**
*退出当前页
*/
function quit()
{
	//if(errorDivIsShow == true){hideErrorDiv();}
	mp.stop();
	//alert(goBackUrl);
	//20120411月修改为有退出菜单的方式
	//$("quitDiv").style.display = "block";
	//quitDivIsShow=true;	
	window.location.href = goBackUrl;	
}
/**
*结束播放
*/
function finishedPlay()
{	
	//hideAllDiv();
	showFinishedDiv();	
	//$("end").focus();
	//一下为20120410增加自动播放下一节目
			
}

/**
*播放上一集
*/
function goPreProg()
{
	if(preProgId == '-1'){return true;}
	var jumpUrl="au_PlayFilm.jsp?PROGID=" + preProgId +"&PLAYTYPE=<%=iPlayType%>&CONTENTTYPE=<%=EPGConstants.CONTENTTYPE_PROGRAM%>&BUSINESSTYPE=<%=EPGConstants.BUSINESSTYPE_TVOD%>"
	+  "&PROGSTARTTIME=" + (startDate+preProgBeginTime) +"&PROGENDTIME=" + (startDate+preProgEndTime) + "&CHANNELID=" + channelId+"&LOGICCHANNELID="+chanNum+"&returnurl="+goBackUrl;
	mp.stop();
	//setEPG();
	window.location.href = jumpUrl;
}
/**
*播放下一集
*/
function goNextProg()
{
	if(nextProgId == '-1'){return true;}
	var jumpUrl="au_PlayFilm.jsp?PROGID=" + nextProgId +"&PLAYTYPE=<%=iPlayType%>&CONTENTTYPE=<%=EPGConstants.CONTENTTYPE_PROGRAM%>&BUSINESSTYPE=<%=EPGConstants.BUSINESSTYPE_TVOD%>"
	+  "&PROGSTARTTIME=" + (startDate+nextProgBeginTime) +"&PROGENDTIME=" + (startDate+nextProgEndTime) + "&CHANNELID=" + channelId+"&LOGICCHANNELID="+chanNum+"&returnurl="+goBackUrl;
	mp.stop();
	//setEPG();
	window.location.href = jumpUrl;
}
/**
*页面加载结束后触发此函数
*/
function init()
{
	 if(containFun(markArray,chanNum) == true){
		$("showMessageDiv").style.display = "block";
		clearTimeout(tempShowMsgTimer);
		tempShowMsgTimer = setTimeout("hiddenShowMessage();", 5000);
	}
	loadData();
	//bookMarkIsShow();
	//mp.setProgressBarUIFlag(0);
}

function hiddenShowMessage(){
	$("showMessageDiv").style.display = "none";
}

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

/**
*获取数据
*/
function loadData()
{
	$("getDataIframe").src = "play_controlTVodData.jsp?progId="+ progId + "&channelId=" + channelId;
}

/**
*判断是否要显示书签
*/
function bookMarkIsShow()
{
	return false;
}

/*************************涉及页面层显示部分 start**************************************************/
var errorDivIsShow = false; //错误提示层是否显示标志位
/**
*显示错误提示层
*/
function showErrorDiv()
{
	if(errorDivIsShow){return true;}
	var errorDiv = $("errorDiv");
	var errorDiv2 = $("errorDiv2");
	errorDiv.style.display = "block";
	errorDiv2.style.display = "block";
	errorDivIsShow = true;
}

/**
*隐藏错误提示层
*/
function hideErrorDiv()
{
	$("errorDiv").style.display = "none";
	$("errorDiv2").style.display = "none";
	errorDivIsShow = false;
}


/**
*显示minEPG
*/
function showMinEpg()
{
	if(minEpgHideDelayId != 0){
		clearTimeout(minEpgHideDelayId);
		minEpgHideDelayId = 0;
	}
	if(seekDivIsShow){	
		return;
		$("seekDiv").style.display = "none";
	}
	if(PauseDivIsShow){	
		return;
		hideJumpTimeDiv();
	}
	if(minEpgIsShow == true){return;}
	if(volumeDivIsShow){hideBottom();}
	$("minEpgDiv").style.display = "block";
	//$("minEpgBackground").style.display = "block";
	minEpgIsShow = true;	
	minEpgHideDelayId = setTimeout(hideMinEpg,5000);//hideTime
	processSeek1(mp.getCurrentPlayTime());//由于信息键是5秒内消失，所以没有实时刷新进度
	//$("fullTime1").innerHTML=getVodTime();
}
/**
*隐藏minEPG
*/
function hideMinEpg()
{
	if(minEpgShowDelayId != 0)
	{
		clearTimeout(minEpgShowDelayId);
		minEpgShowDelayId = 0;
	}
	if(minEpgIsShow == false){return;}
	$("minEpgDiv").style.display = "none";
	//$("minEpgBackground").style.display = "none";
	minEpgIsShow = false;
}
/**
*生成Minepg层，在数据获取页面调用
*/
function createMinEpg()
{
//	$("preTvodName").innerText ="上一个节目："+sp_convertTime(preProgBeginTime)+"&nbsp;"+preProgName;
        $("preTvodName").innerHTML ="上一个节目："+sp_convertTime(preProgBeginTime)+"&nbsp;"+preProgName; //ztewebkit
//	$("nextTvodName").innerText = "下一个节目："+sp_convertTime(nextProgBeginTime)+"&nbsp;"+nextProgName;
	$("nextTvodName").innerHTML = "下一个节目："+sp_convertTime(nextProgBeginTime)+"&nbsp;"+nextProgName; //ztewebkit
	var paogTimes=progTimeSpan.split("~");
	$("progTimeBegin").innerText =paogTimes[0];
	$("progTimeEnd").innerText = paogTimes[1];
	$("progName").innerText = "当前节目："+progName;
	//$("director").innerText = progName;
	//setTimeout("getVodTime()",200);
	//getVodTime();20120525
	$("channelName").innerText = "当前频道："+channelName;
	//$("introduce").innerText = introduce;
	//minEpgShowDelayId = setTimeout(showMinEpg,delayTime);
	showMinEpg();
}
//转为的小时：分钟的格式
function sp_convertTime(_time)
{
	if(_time!=null && _time!=""){
		return _time.substring(0,2)+":"+_time.substring(2,4);
	}
	return "";
}


/**
*显示退出层
*/
function showQuitDiv()
{
	$("quitDiv").style.display = "block";
	if(errorDivIsShow == true){hideErrorDiv();}	
	quitDivIsShow=true;	
	setEPG();
}
/**
*隐藏退出层
*/
function hideQuitDiv()
{
	$("quitDiv").style.display = "none";
	quitDivIsShow=false;
	setSTB();
}
/**
*显示播放结束层
*/
function showFinishedDiv()
{
	if(nextProgId != "-1")
	{
	  if(finishedDivIsShow == true){return;}
	  $("finishedBackground").style.display = "block";
	  //$("endDiv").style.display = "block";
	  finishedDivIsShow = true;
	  setTimeout(goNextProg,3000);
	}
	else 
	{
		$("OUTquitDiv").style.display = "block";
		mp.stop();
	    setTimeout(antoQuit,3000);
	}
}
//20120319修改为1秒后自动退出
function antoQuit()
{
	 //clearTimeout(tempTime);
	 quit();
}	
/**
*隐藏播放结束层
*/
function hideFinishedDiv()
{
	if(finishedDivIsShow == false){return;}
	$("endDiv").style.display = "none";
	$("finishedBackground").style.display = "none";
	$("OUTquitDiv").style.display = "none";
	finishedDivIsShow = false;
}
/**
*隐藏所有层
*/
function hideAllDiv()
{
	hideMinEpg();
	hideQuitDiv();
	hideFinishedDiv();
	hideBottom();
	if(PauseDivIsShow)hideJumpTimeDiv();
	if(seekDivIsShow)
	{
		$("seekDiv").style.display = "none";
		seekDivIsShow = false;
		isSeeking = 0;
		jumpPos =0 ;
		count=0;
		$("currentTime_progress").className="bar";
	}
}
/*************************涉及页面层显示部分 end**************************************************/	
/**
*获取vod的播放时间
*/	
function getVodTime()
{
	var time = '';
	var hour = 0;
	var minute = 0;
	var second = 0;
	var totalSecond = mp.getMediaDuration();	
	if(totalSecond != "undefined" && second != null)
	{
		minute = Math.floor(totalSecond/60);
		second = totalSecond%60;
	}
	hour = Math.floor(minute/60);
	minute = minute%60;
	if(hour < 10){hour = '0' + hour;}
	if(minute < 10){minute = '0' + minute;}
	if(second < 10){second = '0' + second;}
	time = hour + ':'+ minute + ':' + second;
	//$("progTime").innerText = time ;
}
/**
*进入退出层时，重置退出层
*/
function resetQuitDiv()
{
//	$("quit").focus();
	positionFlag = 1;
	change_focus(positionFlag,true);  //hwwebkit
}
/**
*复写的公共控制页面的方法，判断公共页面的层是否可以显示
*/
function commonJumpDivCanShow()
{
	var canShow = false;
	if(!quitDivIsShow && !errorDivIsShow){canShow = true;}
	return canShow;
}
</script>
</head>
<body bgcolor="transparent" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="start();init()" onUnload="unload()">
<div id="showMessageDiv" style="position:relative; background-color:#eaeaea; height:60px; width:338px; left:170px; top:8px;text-align:center;z-index:1; display:none;">
   	<div id="testMsg" style="color:#131313; font-size:22px; font-weight:bold; padding-top:8px;">本频道为付费频道，目前为免费体验期，正式收费将提前告知。</div>
</div>

<div style="width:1px; height:1px; top:-1px; left:-1px;">
<a id="currentTime" href="#" style="width:1px; height:1px; top:-1px; left:-1px;"><img src="images/dot.gif" width="1" height="1"/></a>
</div>
<div id="bottomframe" style="position:absolute;left:30px; top:330px; width:600px; height:150px; z-index:1">
</div>

<!--音量键-->
<div id="volumeDiv" class="volume" style="display:none;">
    <div style="width:320px;"><div id="volumeLen" class="on" style="width:0%;"></div></div> <!--总宽度为320px;也可以用100%-->
    <div id="volumeCur" style="left:380px;"></div>
</div>
<!--音量键-->

<!--play-page-回看信息键---------------------------------------------------->
<div id="minEpgDiv" class="play-page"  style="display:none;">
    <div id="progName" class="txt"></div>
    <div id="progTimeBegin" class="timeline2"></div>
    <div class="progress-bar2">
        <div class="bar"> <!--当前为 class="bar"；选中为 class="baron";-->
            <div id="bar_0" class="b1"></div>
            <div id="bar_1" class="b2" style="width:0px;"></div> <!--总宽度为11（b1为固定宽）+195-->
        </div>
    </div>
    <div  id="progTimeEnd" class="timeline2" style="left:550px;"></div>
    <div class="line" style="top:52px;"><img src="../images/line.png" /></div>
    <div id="channelName" class="txt" style="top:55px;"></div>
    <div id="preTvodName" class="txt" style="left:290px;top:55px;"></div>
    <div id="nextTvodName" class="txt" style="left:290px;top:90px;"></div>
</div>
<!--play-page the end---------------------------------------------------->

<!--播放结束后DIV-------------------------->
<div  class="popup" style="display:none;">
    <div class="pop_title">确认要跳转到直播频道吗？</div>		
    <div class="pop_btns" style="top:155px;">	 <!--焦点为 class="btn02 on2"--> 
        <div class="btn02 on2" style="left:80px;">确认</div>
        <div class="btn02" style="left:260px;">返回</div>
    </div>
</div>
<!--popup the end------------------------->

<!--popup-->
<div id="finishedBackground" class="popup" style="display:none">
    <div class="pop_title" style="top:120px;">3秒后自动播放下一节目</div>
</div>

<div id="OUTquitDiv" class="popup" style="display:none">
    <div class="pop_title" style="top:120px;">谢谢观看</div>
</div>
<!--popup the end-->

<!--popup-->
<div id="quitDiv" class="popup"  style=" display:none;">
    <!--<div id="quit_0" class="pop_title2">继续观看</div>-->
     <div class="pop_btns" style="top:72px;">	 <!--焦点为 class="btn01 on"-->
        <div id="quit_0" class="btn01" style="top:0px;left:110px;">继续观看</div>
    </div>
    <div class="pop_btns">	 <!--焦点为 class="btn01 on"-->
        <div id="quit_1" class="btn01 on"  style="top:48px;left:110px;">结束观看</div>
    </div>
   <!-- <div class="pop_btns" style="top:188px; left:120px;">  
        <div id="quit_2" class="btn01">加入书签并退出</div> -->
    </div>
</div>
<!--popup the end-->



<%--错误提示层--%>
<div id="errorDiv" style="position:absolute; left:120x; top:300px; width:400px; height:80px; z-index:-1; display:none"> <img src="images/playcontrol/playVod/" width="400px" height="80px"/> </div>
<div id="errorDiv2" style="position:absolute; left:120x; top:300px; width:400px; height:80px; z-index:1;display:none">
  <table align="center" width = "400px" height="80">
    <tr>
      <td class="whiteFont" align="center" style="color:white;"> 系统错误，请按返回键退出或稍候再试！ </td>
    </tr>
  </table>
</div>

<%--隐藏层获取数据-begin--%>
<div style="display:none">
  <iframe id="getDataIframe" width="1px" height="1px"></iframe>
</div>
<%--隐藏层获取数据-end----%>

<%--按暂停键后出现的模块begin-------------------------------%>
<div id="seekDiv" class="play-page" style="position:absolute;width:640px;height:150px;left:5px;top:380px; z-index:1;display:none">
    <div id="statusImg" class="key" style="top:22px; left:10px;"></div>
    <div class="timeline" style="left:82px;">00:00:00</div>
    <div id="speed" style="position:absolute;width:60px;height:23px;left:40px;top:17px; z-index:2;"></div>
    <div id="timeError" style="position:absolute;width:220px;height:23px;left:150px;top:42px; z-index:2;font-size:18px;color:#FF3"></div>
    <div class="progress-bar" style="left:168px;">
        <div id="currentTime_progress" class="baron"> <!--当前为 class="bar"；选中为 class="baron";-->
            <div id="td_0" class="b1"></div>
            <div id="td_1" class="b2" style="width:360px;"></div> <!--总宽度为11（b1为固定宽）+360px-->				
            <div id="currTimeShow" style="top:30px;left:220px;">01:40:20</div>
        </div>
    </div>
    <div id="fullTime" class="timeline" style="left:540px;">02:00:22</div>		
    <div class="set-time"  id="jumpTimeDiv" style="display:none">
        <div style="top:6px;">输入定位时间：</div>
        <div style="left:150px;" id="jumpTimeHour" class="inp"></div> <!--当前为 class="inp"；焦点为class="inpon"-->
        <div style="top:6px;left:235px;">时</div>
        <div style="left:265px;" id="jumpTimeMin" class="inp"></div> <!--当前为 class="inp"；焦点为class="inpon"-->
        <div style="top:6px;left:350px;">分</div>
        <div class="pop_btns" style="top:8px;left:380px;">
            <div  id="ensureJump" class="btn02">跳转</div><!--焦点为class="btn02 on2"-->
            <div  id="cancelJump" class="btn02" style="left:100px;">重置</div>
        </div>
    </div>
</div>
<%--按暂停键后出现的模块end---------------------------------%>

<div style=" visibility:hidden;">
<img src="../images/play/inp-bg.png" />
<img src="../images/play/inp-bgon.png" />
<img src="../images/play/pop-bg2.gif" />
<img src="../images/play/btn-pause.png" />
<img src="../images/play/play-page-bg.png" />
<img src="../images/play/icon-fast-return.png" />
<img src="../images/play/icon-fast-enter.png" />
<img src="../images/play/btn-play.png" />
<img src="../images/play/icon-mute.png" />
<img src="../images/play/icon-pause.png" />
</div>
</body>
<%@ include file = "play_pageVideoControl.jsp"%>
</html>
