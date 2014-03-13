<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.facade.service.BookmarkImpl" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ include file = "keyboard/keydefine.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>vod播控页面</title>
<style type="text/css"> 
<!--
body { background-color:#000; font-family:"Microsoft YaHei"; font-size:22px; color:#fff;  margin:0px; padding:0px; width:640px; height:530px; overflow:hidden; position:relative;}
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,p,th,td {margin:0; padding:0}
pre,em,i,textarea,input,font{font-size:12px; font-weight:normal; font-style:normal}
img {border:0; margin:0}
button, input, select, textarea { font-size:100%;}
.pop_btns { 
	left:30px;
	position:absolute; 
	top:115px;  
	width:420px;
}
.pop_btns div { 
	height:35px;
	line-height:35px;
	position:absolute;
	top:0;
	text-align:center; 
}
.pop_btns .btn02 { width:105px;}
.pop_btns div.on2 { background:url(../images/btn2_bg.png) no-repeat;}
.play-page {
	background:url(../images/play/play-page-bg.png) repeat-x;
	height:131px;
	line-height:35px;
	left:0; 
	position:absolute; 
	top:399px;
	width:100%;
}
.play-page .key {
	line-height:24px;
	left:8px; 
	position:absolute; 
	top:20px;
}
.play-page .key div{
	font-size:28px;
	left:0; 
	position:absolute; 
	top:0;
}
.play-page .timeline {
	height:35px;	
	left:110px; 
	position:absolute; 
	top:16px;
}
.play-page .timeline2 {
	font-size:14px;
	height:20px;
	line-height:20px;
	left:365px; 
	position:absolute; 
	top:3px;
}
.play-page .txt {
	left:28px; 
	position:absolute; 
	top:14px;
}
.play-page .txt span {
	color:#44c8f5;
}
.progress-bar {
		background:url(../images/play/progress-barbg.png) no-repeat;
		height:35px;
		left:169px; 
		position:absolute; 
		top:17px;
		width:372px;
	}
	.progress-bar div {
		left:0; 
		position:absolute; 
		top:0;
	}
	.progress-bar .bar,.progress-bar .baron {
		height:35px;
		width:372px;
		top:0;
	}
	.progress-bar .bar div,.progress-bar .baron div {
		height:35px;
		top:0;
	}
	.progress-bar .bar div.b1,.progress-bar .baron div.b1 {		
		width:11px;
		top:0;
	}
	.progress-bar .bar div.b2,.progress-bar .baron div.b2 {		
		width:360px;
		left:11px;
		top:0;
	}
	.progress-bar .bar div.b1 { background:url(../images/play/progress-bar-l.png) no-repeat;}
	.progress-bar .baron div.b1 { background:url(../images/play/progress-baron-l.png) no-repeat;}
	.progress-bar .bar div.b2 { background:url(../images/play/progress-bar.png) right no-repeat;}
	.progress-bar .baron div.b2 { background:url(../images/play/progress-baron.png) right no-repeat;}

.progress-bar2 {
		background:url(../images/play/progress-barbg2.png) no-repeat;
		height:35px;
		left:375px; 
		position:absolute; 
		top:14px;
		width:207px;
	}
	.progress-bar2 div {
		left:0; 
		position:absolute; 
		top:0;
	}
	.progress-bar2 .bar,.progress-bar2 .baron {
		height:35px;
		width:207px;
		top:0;
	}
	.progress-bar2 .bar div,.progress-bar2 .baron div {
		height:35px;
		top:0;
	}
	.progress-bar2 .bar div.b1,.progress-bar2 .baron div.b1 {		
		width:11px;
		top:0;
	}
	.progress-bar2 .bar div.b2,.progress-bar2 .baron div.b2 {		
		width:196px;
		left:11px;
		top:0;
	}
	.progress-bar2 .bar div.b1 { background:url(../images/play/progress-bar-l.png) no-repeat;}
	.progress-bar2 .baron div.b1 { background:url(../images/play/progress-baron-l.png) no-repeat;}
	.progress-bar2 .bar div.b2 { background:url(../images/play/progress-bar.png) right no-repeat;}
	.progress-bar2 .baron div.b2 { background:url(../images/play/progress-baron.png) right no-repeat;}

.set-time {
	left:42px; 
	position:absolute; 
	top:75px;
	width:100%;
}
.set-time div {
	left:0; 
	position:absolute; 
	top:0;
}
.set-time .inp,.set-time .inpon {
	background:url(../images/play/inp-bg.png) no-repeat;
	color:#fff;
	font-family:"Microsoft YaHei";
	font-size:26px;
	height:52px;	 
	line-height:52px;
	text-align:center;
	width:78px;
}
.set-time .inp {
	background:url(../images/play/inp-bg.png) no-repeat;
}
.set-time .inpon {
	background:url(../images/play/inp-bgon.png) no-repeat;
}
.btn-operate {
	left:500px; 
	position:absolute; 
	top:40px;
}
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
String progId = request.getParameter("PROGID"); //vod节目id
int iProgId = 0;	
String fatherId = request.getParameter("FATHERSERIESID");
String playType = request.getParameter("PLAYTYPE"); //播放类型
int iPlayType = 0;	
String beginTime = request.getParameter("BEGINTIME"); //节目播放开始时间
String vasBeginTime = request.getParameter("beginTime");
String productId = request.getParameter("PRODUCTID"); //订购产品id	
String serviceId = request.getParameter("SERVICEID"); //对应服务id	
String price = request.getParameter("ONECEPRICE"); //该产品对应价格	
String contentType = request.getParameter("CONTENTTYPE");
String vasFlag = request.getParameter("vasFlag"); //增值页面标志位
String backurl = request.getParameter("backurl"); //如果是从增值服务页面进入的返回url
String typeId = request.getParameter("TYPE_ID");//栏目ID
String isChildren = request.getParameter("isChildren");
String type=request.getParameter("ECTYPE");
int itype =0;	
if(type != null && type !="" && type != "null")
{	
	itype=Integer.parseInt(type);
}	
String playUrl = ""; //触发机顶盒播放地址
int iPlayBillId = 0; //节目单编号（可选参数），仅当progId是频道时有效，此处只是为满足接口	
String endTime = request.getParameter("ENDTIME");
if(endTime == null || endTime=="" || "".equals(endTime) || "undefined".equals(endTime))
{
	endTime = "20000"; //播放结束时间
}
boolean isSucess = true;
/*******************对获取参数进行异常处理 start*************************/
try
{
	iProgId = Integer.parseInt(progId);
	iPlayType = Integer.parseInt(playType);
}
catch(Exception e)
{
	iProgId = -1;
	iPlayType = -1;
	isSucess = false;
}
if(fatherId == null || "".equals(fatherId) || "null".equals(fatherId) || "undefined".equals(fatherId)){fatherId = "-1";}
if(beginTime == null || "".equals(beginTime)|| "null".equals(fatherId)){beginTime = "0";}
if(productId == null || "".equals(productId)|| "null".equals(fatherId)){productId = "0";}
if(serviceId == null || "".equals(serviceId)|| "null".equals(fatherId)){serviceId = "0";}
if(price == null || "".equals(price)|| "null".equals(fatherId)){price = "0";}
if(contentType == null || "".equals(contentType)|| "null".equals(fatherId)){
	contentType =String.valueOf(EPGConstants.CONTENTTYPE_VOD);
}
String infoDisplay = "errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=26&ECTYPE="+itype;
/*******************对获取参数进行异常处理 end*************************/
MetaData metaData = new MetaData(request);
ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
ServiceHelp serviceHelp = new ServiceHelp(request);
BookmarkImpl bookmarkImpl = new BookmarkImpl(request);//书签
int iShowDelayTime = 5000;
try{
	String showDelayTime = serviceHelp.getMiniEPGDelay ();
	iShowDelayTime = Integer.parseInt(showDelayTime)* 1000;
}catch(Exception e){
	iShowDelayTime = 8000;
}
/*************************获取播放url start**************************************/
if( "1".equals(vasFlag))//增值业务使用老接口
{
	playUrl = serviceHelp.getTriggerPlayUrl(iPlayType,iProgId,"0");
	playUrl = playUrl + "&playseek="+vasBeginTime+"-"+endTime;
}else{
	playUrl = serviceHelpHWCTC.getTriggerPlayUrlHWCTC(iPlayType,iProgId,iPlayBillId,beginTime,endTime,productId,serviceId,contentType);
}

//连续剧子集书签焦点记忆
if(!fatherId.equals("-1"))
{
	bookmarkImpl.addSitcomItem(progId,fatherId);		
}
if(playUrl != null && playUrl.length() > 0)
{
	int tmpPosition = playUrl.indexOf("rtsp");
	if(-1 != tmpPosition)
	{
		playUrl = playUrl.substring(tmpPosition,playUrl.length());
	}else{
		isSucess = false;
	}
}	
/*************************获取播放url end**************************************/
		
TurnPage turnPage = new TurnPage(request);

String goBackUrl = turnPage.go(-1);

if(backurl != null && ! "".equals(backurl))
{
	goBackUrl = backurl;
}
if(!isSucess)
{
	response.sendRedirect(infoDisplay);
}
%>
<style>
.blueFont
{font:"黑体";color:#FFFFFF;font-size:16px; }
.whiteFont
{font:"黑体";color:#FFFFFF;font-size:16px;}
</style>
<script>
var _in_ajax = window.ActiveXObject ? new ActiveXObject("Microsoft.XMLHTTP") : new XMLHttpRequest();
function getAJAXData(url, successMethed) {
    if (url != undefined && url != null && url != "") {
        var temp = url.split("?"); url = temp[0];
        if (temp.length > 1) { url += "?" + encodeURI(temp[1]); }
    }
    _in_ajax.open("POST", url, false);
    _in_ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
    _in_ajax.setRequestHeader("X-Requested-With", "XMLHttpRequest");
    _in_ajax.send(null);
	if (_in_ajax.readyState == 4){
			if (_in_ajax.status == 200) {
				 window.clearInterval(interval);
				 successMethed(_in_ajax.responseText); 			
			}else{
				getAJAXData(url, successMethed);
			}
		}
}
</script>
<script>
 if (typeof(iPanel) != 'undefined') {
	iPanel.focusWidth = "2";
	iPanel.defaultFocusColor = "#FCFF05";
  }
var isChildren = "<%=isChildren%>";
var count=0;
var playStatFlag=0;//1:pause  0:快进，快退 
//页面加载前执行的数据转换与方法
var playStatus = 0;//0:暂停 1：播放
var KEY_DEL=1131;
var itype="<%=itype%>";
var progId = '<%=iProgId%>'; //当前播放的vodid
var playType = '<%=iPlayType%>'; //播放的类型
var fatherId = '<%=fatherId%>'; //当前播放的vodid的父级id
var playUrl ='<%=playUrl%>';//触发机顶盒播放url
var beginTime = '<%=beginTime%>';
var endTime = '<%=endTime%>';
var isAssess = <%= iPlayType == EPGConstants.PLAYTYPE_ASSESS%>; //是否是片花播放
var isBookMark = <%= iPlayType == EPGConstants.PLAYTYPE_BOOKMARK%>; //是否为书签播放
var hideTime = <%=iShowDelayTime%>; //epg自动隐藏时间
var delayTime = 8000; //epg开机延时显示minepg时间
var dataIsOk = false; //数据是否准备结束
var PauseDivIsShow = false;//按暂停键出来的整个DIV置
var jumpTimeIsShow = false;//暂停后输入的时间，跳转DIV
var volumeDivIsShow = false;
var goBackUrl = '<%=goBackUrl%>';
var succ=-1;//添加书签标记
var pk_interval_handle = null;//快进，快退进度条控制
var voiceflag="";
/******************在iframe页面赋值的参数 start********************************/
var preProgId = "-1"; //连续剧子集上一集id
var preProgNum = "";
//下一集标清？
var preCanPlay = "2" ;
var nextCanPlay = "2" ;
var nextProgId = "-1" //连续剧子集下一集id
var preProgNum = "";	
var vodName = "";//本vod的名字
var director = "";//导演
var actor = "";//演员
var introduce = "";//介绍信息
var sitNum = ""; //当前vod的集数
var currIndex;//当前集数下标
var mediaTime = 0;
var initMediaTime = 0;
var tempTime=0;
var timePerCell = 0;
var currCellCount = 0;
var seekStep = 1;//每次移动的百分比
var isSeeking = 0;
var tempCurrTime = 0;
var timeID_playByTime = 0;
var isJumpTime = 1;//跳转输入框是否显 1默认显;
var playStat = "play";
var timeID_check = "";//检查进度条时间
var preInputValueHour = "";//上一次检测时，文本框中的值
var preInputValueMin = "";
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
var typeId = "<%=typeId%>" ;
var timeID_jumpTime = "";
var showTimer = "";
var hideTimer = "";
var volume = 0;
// 隐藏bottomTimer的定时器
var bottomTimer = "";
var speed = 1;
var currTime = 0;
var jumpPos = 4;//0:小时 1：分 2：确认 3：取消 4：进度条
var t = 0;
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
    mp.setVideoDisplayArea(0, 0, 0, 0);//全屏显示
    mp.setVideoDisplayMode(); 
    mp.refreshVideoDisplay(); //调整视频显示，需要上面两函数配合
}
/**
*播放
*/
function play()
{
	if(isBookMark){ var type = 1,speed = 1;mp.playByTime(type,beginTime,speed);}
	else{mp.playFromStart();}
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
var positionFlag = 0; //页面焦点位置标志


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
		case <%=KEY_UP%>:
				return pressKey_up();
		case <%=KEY_DOWN%>:
				return pressKey_down();
		case <%=KEY_LEFT%>: 
			  return pressKey_left();
		case <%=KEY_RIGHT%>:
				return pressKey_right();
		case <%=KEY_PAGEDOWN%>:
				return pressKey_pageDown();
		 case <%=KEY_PAGEUP%>:
				return pressKey_pageUp();
		/*case <%=KEY_PAUSE_PLAY%>:
		case <%=KEY_POS%>:
			pauseOrPlay(); //case 271://定位键
			return 0;
			return false;*/
		 case <%=KEY_RETURN%>:
			pressKey_quit();  //退出时处理
			return 0;
		 /* case <%=KEY_STOP%>:
			pressKey_Stop();
			return 0;
		 case <%=KEY_VOL_UP%>:
			volumeUp();
			return false;
		case <%=KEY_VOL_DOWN%>:
			volumeDown();
			return false;
		 case <%=KEY_FAST_FORWARD%>:
			fastForward();
			return false;
		case <%=KEY_FAST_REWIND%>:
			fastRewind();
			return false;*/
		case <%=KEY_IPTV_EVENT%>:  
			goUtility();
			break;
		case <%=KEY_MUTE%>:setMuteFlag();return false;
		/*case <%=KEY_BLUE%>:
		case <%=KEY_INFO%>:
			window.location.href="space_collect.jsp";
			return 0;*/
		case <%=KEY_TRACK%>: changeAudio(); return 0;
		case <%=KEY_OK%>:	
		   pressOk();
		   return;
		case KEY_DEL:
        	if(PauseDivIsShow){delInputTime();}
        	return 0;
			break;
	/*	 case 277:
	   case  1109:
			mp.stop();
			window.location.href="vod.jsp?returnurl=";
		    return false;
			break;
	   case 276:
	   case 1110:
			mp.stop();
			window.location.href="playback.jsp?returnurl=";
			return false;
			break;
		case 275:
		case 1108:
		    mp.stop();
		    window.location.href="live.jsp?returnurl=";
		    return false;
			break;
	   case 1105://搜索
			mp.stop();
			window.location.href="search.jsp";
			return 0;*/
		case 281://收藏
			return 0;
		case 1112://1112轮播
			return 0;
		//case 261:return 0;//静音键
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

//音道控制
function changeAudio()
{
    mp.switchAudioChannel();
	/*var audio = mp.getCurrentAudioChannel();
	if(audio=="0" || audio=="Left"){ audio=0;}
	else if(audio=="1" ||  audio=="Right"){ audio=1;	}	   
	else if(audio=="2" ||  audio=="JointStereo" || audio=="Stereo" ){  audio=2;	}
	clearTimeout(voiceflag);
	switch(audio)
	{
		case 0:
		$("voice").src="../images/voice/leftvoice.png";
		break;
		case 1:
		$("voice").src="../images/voice/rightvoice.png";
		break;
		case 2:
		$("voice").src="../images/voice/centervoice.png";
		break;
		default:
		break;
	}
	voiceflag=setTimeout(function(){$("voice").src="../images/dot.gif";},5000);*/
}
//确认键
function pressOk()
{	
	//var totalTime = mp.getMediaDuration();//20120509
	//if(currTime<=0){currTime=1;}
	if(!PauseDivIsShow){pressKey_info_Ok();}	
	else if(PauseDivIsShow && jumpPos==4) //在进度条上面的时候 20120329修改4为2
	{
		var currTime = parseInt(mp.getCurrentPlayTime()) + parseInt(count*60);
		PauseDivIsShow=false;
		playByTime(currTime);
		$("seekDiv").style.display = "none";
		isSeeking = 0;
		speed = 1;
		jumpTimeIsShow=false;
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
	jumpPos=0;
	$("jumpTimeHour").className="inpon";
    $("cancelJump").className="btn02";
}
//静音设置
function setMuteFlag()
{
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return true;}
	clearTimeout(showTimer);
	showTimer = "";
	clearTimeout(bottomTimer);
	bottomTimer = "";
	volumeDivIsShow = true;
	if(minEpgIsShow){hideMinEpg();}
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){
		mp.setMuteFlag(0);
		/*if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0){
			$("voice").src="../images/playcontrol/playChannel/muteoff.png";
			bottomTimer = setTimeout("hideMute();", 5000);
		}*/
	}else{
		mp.setMuteFlag(1);
		/*if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0){
			$("voice").src="../images/playcontrol/playChannel/muteon.png";
			bottomTimer = setTimeout("hideMute();", 5000);
		}*/
	}
}	
//暂停
function pauseOrPlay()
{	
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return true;	}
	if(PauseDivIsShow){resetPauseOrPlay();}
	else if(minEpgIsShow){hideMinEpg();}			
	speed = 1;
	PauseDivIsShow = true; 
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
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow || isSeeking==1){return true;}
	clearTimeout(showTimer);
	showTimer = "";
	if(minEpgIsShow){hideMinEpg();}
	var muteFlag =  mp.getMuteFlag();
	if(muteFlag == 1){mp.setMuteFlag(0);}
	if(!volumeDivIsShow){volume = mp.getVolume();genVolumeTable();volumeDivIsShow = true;} 
	volume += 5;
	if(volume > 100){volume = 100;}
	changeVolume(volume);
	mp.setVolume(volume);
	clearTimeout(bottomTimer);
	bottomTimer = "";
	bottomTimer=setTimeout(hideBottom, 3000);	
}
function hideBottom()
{	
	volumeDivIsShow = false;
	//document.getElementById("bottomframe").innerHTML = "";
	$("volumeDiv").style.display = "none";
}
function hideMute()
{
	$("voice").src="#";
}	
//构建音量界面genVolumeTable(volume)
function genVolumeTable()
{
	//$("volumeDiv").style.display = "block";
}

function changeVolume(volume)
{
	//$("volumeLen").style.width=volume+"%";
	//$("volumeCur").innerHTML=volume;
}

//减小音量
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
	if(volume <0){volume = 0;}
	changeVolume(volume);
	mp.setVolume(volume);
	clearTimeout(bottomTimer);
	bottomTimer = "";
	bottomTimer = setTimeout(hideBottom, 3000);
}	
//显示时间进度条
function displaySeekTable(playFlag)
{ 
	//PauseDivIsShow = true;
	//playFlag 0:暂停键进来的 1：没有进度条的时候按快进快退,有进度条的时候按推出按钮  3：输入
	mediaTime = mp.getMediaDuration();
	//有时机顶盒取出的vod总时长有问题，在这里重新获取。initMediaTime是初始化页面时取出的总片铿
	if(undefined == mediaTime || typeof(mediaTime) != "number" || mediaTime.length == 0 || 0 == mediaTime || initMediaTime != mediaTime)
	{
		mediaTime = mp.getMediaDuration();
		//计算移动一格的单元
		timePerCell = mediaTime / 100;
	}
	if(isSeeking == 0)	//isSeeking等于0时说明还没有显示进度,所以展示进度条及跳转框
	{
		currTime = mp.getCurrentPlayTime();
		isSeeking = 1;			
		processSeek(currTime);
		var fullTimeForShow = "";
		fullTimeForShow = convertTime();			
		$("fullTime").innerHTML = fullTimeForShow;		
		$("seekDiv").style.display = "block"; //显示进度条
		jumpPos=4;//设置默认进来的时候焦点在进度条上
		$("currentTime_progress").className="baron";		
		clearTimeout(timeID_jumpTime);
		timeID_jumpTime = "";
		checkSeeking();//调用方法检测进度条及跳转框的状态
		if (playFlag != 1){
			pause();
			playStatus=0;
			$("jumpTimeDiv").style.display = "block"; 
			jumpTimeIsShow=true;
		}
	}
	else//进度条已经存
	{
		clearTimeout(timeID_check);//清空定时           
	    timeID_check = "";
		resetPara_seek();//复位各参数
		// 如果切换到开头则不需要恢复播放，机顶盒会自动播放
		if (playFlag != 2 && playFlag != 3)
		{
			speed = 1;
			resume();
			playStatus=1;
		}
		jumpTimeIsShow=false;
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
	jumpPos = 0;
	isJumpTime = 1;
	preInputValueHour = "";
	preInputValueMin = "";
	PauseDivIsShow = true;
	$("jumpTimeMin").innerText = "";
	$("jumpTimeMin").innerText = "";
	$("timeError").innerHTML = "";//请输入时间！
}

function checkSeeking()
{       
	if(isSeeking == 0){
		clearTimeout(timeID_check);
		timeID_check = "";
	}else{
		var inputValueHour = $("jumpTimeHour").innerText;
		var inputValueMin = $("jumpTimeMin").innerText;
		currTime = mp.getCurrentPlayTime();
		clearTimeout(timeID_check);
		timeID_check = "";
		timeID_check = setTimeout(checkSeeking,1000);
		if(playStatFlag==0 && (playStat == "fastrewind" || playStat == "fastforward")){	
			processSeek(currTime);
		}
		if(preInputValueHour != inputValueHour || preInputValueMin != inputValueMin)
		{               
			var tempTimeID = timeID_jumpTime;
			clearTimeout(tempTimeID);
			tempTimeID = "";
			timeID_jumpTime = setTimeout(hideJumpTimeDiv,15000);
			preInputValueHour = inputValueHour;
			preInputValueMin = inputValueMin;
		}
	}
}
function playByTime(beginTime)
{
	if(isSeeking == 1)
	{
		beginTime = tempCurrTime;
	}
	var type = 1;
	var speed = 1;
	playStat = "play";
	currTime = mp.getCurrentPlayTime();
	//if(beginTime==0){beginTime=currTime;}
	mp.playByTime(type,beginTime,speed);
	mp.setVideoDisplayMode(1);
	mp.refreshVideoDisplay();
	count=0;
	jumpPos=4;//20120329
	$("currentTime_progress").className="bar";
}
function jumpToTime(_time)
{
	timeForShow = 0;
	_time = parseInt(_time,10);	
	playByTime(_time);
	processSeek(_time);
}
function checkJumpTime(pHour, pMin)
{        
	if(isEmpty(pHour)||!isNum(pHour)||isEmpty(pMin)||!isNum(pMin)||!isInMediaTime(pHour, pMin)){return false;}
	else{return true;}
}
		
function isNum(s)
{
	var nr1=s,flg=0, cmp="0123456789",tst ="";
	for (var i=0,l=nr1.length;i<l;i++)
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
//定时输入跳转按钮
function clickJumpBtn()
{
	var inputValueHour = $("jumpTimeHour").innerText;
	var inputValueMin = $("jumpTimeMin").innerText;
	_time = mp.getMediaDuration();
	if(isEmpty(inputValueHour)){inputValueHour="00";}
	if(isEmpty(inputValueMin)){inputValueMin="00";}
	$("ensureJump").className="btn02";
	if(checkJumpTime(inputValueHour, inputValueMin))
	{
	    var hour = parseInt(inputValueHour,10);
	    var mins = parseInt(inputValueMin,10);	
		var timeStamp =  hour*3600 + mins*60;
		clearTimeout(timeID_jumpTime);timeID_jumpTime = "";		
		isJumpTime = 0;jumpPos = 4;		
		displaySeekTable(3);
		jumpToTime(timeStamp);
	}	
	else //校验不通过，提示用户时间输入不合理
	{	
		$("jumpTimeHour").innerText = "";
		$("jumpTimeMin").innerText = "";
		$("timeError").innerHTML = "时间不合理，请重新输入！";
		jumpPos = 0;
		$("jumpTimeHour").className="inpon";
		preInputValueHour = "";
		preInputValueMin = "";			
		//15秒后隐藏跳转输入框所在的div"
		clearTimeout(timeID_jumpTime);
		timeID_jumpTime = "";
	    setTimeout(inputErrorcls,10000);
		timeID_jumpTime = setTimeout(hideJumpTimeDiv,12000);
	}
	count=0;
}

function inputErrorcls()
{
	$("timeError").innerHTML = "";
}

 /**
 *隐藏跳转框所在的div
 */
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
	resetPauseOrPlay();
	count=0;
	jumpPos=4;
	$("seekDiv").style.display = "none";
}	
function isEmpty(s)
{
	return ((s == undefined) || (s == "") || (s == null) || (s.length == 0));
}
function convertTime(_time)
{
	if(undefined == _time || _time.length == 0){_time = mp.getMediaDuration();}
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
 //时间进度控制
 function processSeek(_currTime)
 {
	//如果入参时间为空，则取当前时长
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
	if(currCellCount >= 100){ $("td_1").style.width = 360; }
	else if(currCellCount<=0){ $("td_1").style.width = 0;}
	else{$("td_1").style.width = currCellCount * 3.6;}
	$("currTimeShow").innerHTML = currTimeDisplay;
}

 //信息键OSD上时间进度控制
 function processSeek1(_currTime)
 {
	//如果入参时间为空，则取当前时长
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
	$("currTimeShow").innerHTML = currTimeDisplay;
}

//快进
function fastForward()
{
	playStatFlag=0;
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return true;}
	if(volumeDivIsShow){volumeDivIsShow=false;hideBottom();}
	if(minEpgIsShow){hideMinEpg();}
	if(isSeeking == 0 || (isSeeking == 1 && isJumpTime == 0)||isSeeking == 1 && isJumpTime == 1)
	{
		if(isSeeking == 0){	
			displaySeekTable(1);
			clearTimeout(timeID_jumpTime);
			timeID_jumpTime = "";
			isJumpTime = 0;
		}
		if(speed >= 32 && playStat == "fastforward"){	
			displaySeekTable();
			return 0;
		}else{	
			if(playStat == "fastrewind"){speed = 1;}
			speed = speed * 2;
			playStat = "fastforward";
			mp.fastForward(speed);
			if(speed<=2){$("statusImg").innerHTML = '<img src="../images/play/icon-fast-enter.png">';}		
			$("speed").innerHTML = 'X'+speed;		
		}
	}
}	
//后退
function fastRewind()
{	
	playStatFlag=0;
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return;}
	if(volumeDivIsShow){volumeDivIsShow=false;hideBottom();}
	if(minEpgIsShow){hideMinEpg();}
	if(isSeeking == 0 || (isSeeking == 1 && isJumpTime == 0)||isSeeking == 1 && isJumpTime == 1)
	{
		if(isSeeking == 0){
			displaySeekTable(1);
			clearTimeout(timeID_jumpTime);
			timeID_jumpTime = "";
			isJumpTime = 0;
		}if(speed >= 32 && playStat == "fastrewind"){	
			displaySeekTable();
			return 0;
		}else{
			if (playStat == "fastforward") {speed = 1;}			
			speed = speed * 2;
			playStat = "fastrewind";				
			mp.fastRewind(-speed);	
			if(speed<=2){$("statusImg").innerHTML = '<img src="../images/play/icon-fast-return.png"/>';}			
			$("speed").innerHTML = 'X'+speed;	
		}
	}
}	
function pressKey_up()
{
	if(quitDivIsShow){mainPressKeyUp();}
	else if(oneKeySwitchJumpInfoIsShow){commonPressKeyUp();}
	else if(jumpToChannelInfoIsShow){commonPressKeyUp();}
	else if(PauseDivIsShow )
	{
		if(jumpPos==0){$("jumpTimeHour").className="inp";}
		else if(jumpPos==1){$("jumpTimeMin").className="inp";}
		else if(jumpPos==2){$("ensureJump").className="btn02";}
		else if(jumpPos==3){$("cancelJump").className="btn02";}
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
	else if(PauseDivIsShow && jumpPos==4 && jumpTimeIsShow)
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
	else if(finishedDivIsShow){finishedPressKeyLeft();}
	else if(oneKeySwitchJumpInfoIsShow){commonPressKeyLeft();}
	else if(jumpToChannelInfoIsShow){commonPressKeyLeft();}
	else if(PauseDivIsShow){jumpPressKeyLeft();}
	else{volumeDown();}
	return false;
}	
function pressKey_right()
{		
	if(quitDivIsShow){mainPressKeyRight();}
	else if(finishedDivIsShow){finishedPressKeyRight();}
	else if(oneKeySwitchJumpInfoIsShow){commonPressKeyRight();}
	else if(jumpToChannelInfoIsShow){commonPressKeyRight();}
	else if(PauseDivIsShow){jumpPressKeyRight();}
	else{volumeUp();}
	return false;
}
//暂停键后的方向键的操作
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
//暂停键后的左右键
function jumpPressKeyLeft()
{
	if(jumpPos == 1){
		$("jumpTimeMin").className="inp";
		$("jumpTimeHour").className="inpon";
		jumpPos--;
	}
	else if(jumpPos == 2){
		$("ensureJump").className="btn02";
		$("jumpTimeMin").className="inpon";
		jumpPos--;
	}
	else if(jumpPos==3){		
		$("cancelJump").className="btn02";
		$("ensureJump").className="btn02 on2";
		jumpPos--;
	}
	else if(jumpPos==4){
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
function finishedPressKeyLeft()
{
	if(positionFlag == 4){
		clearTimeout(t);
		t = setTimeout("goNextProg()",3000);
		$("nextProg").focus();
		positionFlag = 3;
	}
}
function finishedPressKeyRight()
{
	if(positionFlag == 3)
	{
		clearTimeout(t);
		t = setTimeout("goNextProg()",3000);
		$("finishedQuit").focus();
		positionFlag = 4;
	}
}
function showMinEpgByInfo()
{
	if(!quitDivIsShow && !jumpToChannelInfoIsShow && !oneKeySwitchJumpInfoIsShow && !errorDivIsShow && !finishedDivIsShow)
	{
		if(!dataIsOk){return true;}
		if(minEpgIsShow){hideMinEpg();}
		else{showMinEpg();}
		return true;
	}
}
//信息键
function pressKey_info_Ok()
{
	if(!quitDivIsShow && !jumpToChannelInfoIsShow && !oneKeySwitchJumpInfoIsShow && !errorDivIsShow &&!finishedDivIsShow)
	{
		if(!dataIsOk){return true;}
		if(minEpgIsShow){hideMinEpg();}
		else{showMinEpg();}		
		return true;
	}
	else if(quitDivIsShow){return true;}
	else if(jumpToChannelInfoIsShow){commonPressKeyOk();}
	else if(oneKeySwitchJumpInfoIsShow){commonPressKeyOk();}	
}
function mainPressKeyUp()
{
	if(positionFlag == 2)
	{
		$("quit").focus();
		positionFlag = 0;
	}
}	
function mainPressKeyDown()
{
	if(positionFlag == 0 || positionFlag == 1)
	{
		if(isAssess){return false;}
		positionFlag = 2;
		$("bookmark").focus();
	}
}	
function mainPressKeyLeft()
{
	if( positionFlag == 1)
	{	
		$("quit").focus();
		positionFlag--;
		return;
	}

}	
function mainPressKeyRight()
{
	if(positionFlag == 0)
	{
		positionFlag++;
		$("cancel").focus();
	}
}
function mainPressKeyOk()
{
}
	
//退出
function pressKey_quit()
{	
	//判断miniEPG数据是否取好，频道跳转层是否显示，一键跳转是否显示，退出层是否显示，结束提示层是否显示
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || quitDivIsShow || finishedDivIsShow){return;}
	else if(isSeeking == 1)
	{
		if(jumpPos==0){$("jumpTimeHour").className="inp";}
		else if(jumpPos==1){$("jumpTimeMin").className="inp";}
		else if(jumpPos==2){$("ensureJump").className="btn02";}
		else if(jumpPos==3){$("cancelJump").className="btn02";}
		//隐藏进度条和跳转框
		displaySeekTable(1);
		count=0;
		jumpPos=4;
		$("currentTime_progress").className="bar";
	}else
	{
		//hideAllDiv();//这一句话对性能有影响
		
		//resetQuitDiv();//进入退出层时，重置退出层
		showQuitDiv();
		//setTimeout(showQuitDiv,300) //显示退出层
		pause();
	}	
}
	
function pressKey_Stop()
{
	//判断miniEPG数据是否取好，频道跳转层是否显示，一键跳转是否显示，退出层是否显示，结束提示层是否显示
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || quitDivIsShow || finishedDivIsShow){return;}
	else
	{
		hideAllDiv();///这一句话对性能有影响
		pause();
		resetQuitDiv();//进入退出层时，重置退出层
		showQuitDiv(); //显示退出层
	}	
}
	
	  
function pressKey_pageUp()
{
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return false;}
	goStart();
	//goPreProg();
	hideAllDiv();
	return true;
}
	
function pressKey_pageDown()
{	
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return false;}
	goEnd();
	return false;
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
			setTimeout("hideAllDiv();",200);
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
//	setEPG();
	showErrorDiv();
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
*一键到尾
*/
function goEnd()
{
	mp.gotoEnd();
}
/**
*一键到头
*/
function goStart()
{
	mp.gotoStart();
}
	
/**
*取消退出层
*/
function cancel()
{
	resume();
	setEPG();
	hideQuitDiv();
}
	
/**
*退出当前页
*/
function quit()
{	
	clearTimeout(t);
	var url = goBackUrl;
	if(errorDivIsShow == true){hideErrorDiv();}
	mp.stop();
	//搜索页面转码
	if(url.indexOf("self_ResultList.jsp")==0)
	{
		if(itype==1)
		{
			url = encodeURI(url);
			window.location.href = url ;
		}
		else if(itype==0){window.location.href = url;	}	
	}
	else{window.location.href = url;	}
	if(url.indexOf("?")>0){
		if(goBackUrl.indexOf("&sitcom")!=-1){
			var tytmpstr = 	goBackUrl.substring(goBackUrl.indexOf("?"));
			tytmpstr = tytmpstr.substring(tytmpstr.indexOf("&sitcom"));
			var tmpsidx = tytmpstr.lastIndexOf("&");
			goBackUrl = goBackUrl.replace(tytmpstr,"");
		}
		url=goBackUrl+"&sitcom="+sitNum;
	}else{
		url=goBackUrl+"?sitcom="+sitNum;
	}
	window.location.href =url;
}

/**
*结束播放
*/
function finishedPlay()
{
	hideAllDiv();
	showFinishedDiv();
}

/**
*保存书签并退出
*/
function saveBookMark()
{
	clearTimeout(t);
	var url = goBackUrl;
	var jumpUrl = url;
	if(errorDivIsShow == true){hideErrorDiv();}
	// addBook();//加入临时去掉
	 mp.stop();
	var backurl=goBackUrl+"&sitcom="+sitNum;
	window.location.href =backurl;
}

/**
*播放上一集
*/
function goPreProg()
{
	clearTimeout(minEpgShowDelayId);
	if(preProgId == '-1'){return true;}
	var jumpUrl = "au_PlayFilm.jsp?PROGID=" + preProgId + "&PROGTYPE=" + '<%=EPGConstants.VOD_ISSITCOM_YESSUBFILM %>'
			 + "&PLAYTYPE=" + '<%=EPGConstants.PLAYTYPE_VOD%>' + "&CONTENTTYPE=" + '<%=EPGConstants.CONTENTTYPE_VOD_VIDEO%>'
			 + "&BUSINESSTYPE=" + '<%=EPGConstants.BUSINESSTYPE_VOD%>' + "&ISTVSERIESFLAG=1&FATHERSERIESID=" + fatherId+"&TYPE_ID="+typeId+"&returnurl="+escape(goBackUrl);
	if(preCanPlay=="1"){jumpUrl = "errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=129" ;}
	//setEPG();
	mp.stop();
	window.location.href = jumpUrl;
}

/**
*播放下一集
*/
function goNextProg()
{	
	clearTimeout(t);
	clearTimeout(minEpgShowDelayId);
	if(nextProgId == '-1'){return true;}
	var jumpUrl = "au_PlayFilm.jsp?PROGID=" + nextProgId + "&PROGTYPE=" + '<%=EPGConstants.VOD_ISSITCOM_YESSUBFILM %>'
			 + "&PLAYTYPE=" + '<%=EPGConstants.PLAYTYPE_VOD%>' + "&CONTENTTYPE=" + '<%=EPGConstants.CONTENTTYPE_VOD_VIDEO%>'
			 + "&BUSINESSTYPE=" + '<%=EPGConstants.BUSINESSTYPE_VOD%>' + "&ISTVSERIESFLAG=1&FATHERSERIESID=" + fatherId+"&TYPE_ID="+typeId+"&returnurl="+escape(goBackUrl);
	if(nextCanPlay=="1"){jumpUrl = "errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=129" ;}
	mp.stop();
	window.location.href = jumpUrl;
}
	
/**
*进入退出层时，重置退出层
*/
function resetQuitDiv()
{
	positionFlag = 0;
}

/**
*页面加载结束后触发此函数
*/
function init()
{
	loadData();
	//bookMarkIsShow();
}
	
/**
*获取数据
*/
function loadData()
{
	$("getDataIframe").src = "play_controlVodData.jsp?progId="+ progId + "&fatherId=" + fatherId+"&isChildren="+isChildren;
}
	
//添加书签
function addBook()
{
	var bookIframe=document.getElementById("addBookIframe");
	var progTime=mp.getCurrentPlayTime(); //读取当前播放的时间
	var endTime = mp.getMediaDuration(); //该vod播放时长
	//var addBookUrl="datajsp/space_bookMarkAdd_iframedata.jsp?SUPVODID=<%=fatherId%>&PROGID=<%=progId%>&BEGINTIME="+progTime+"&ENDTIME="+endTime;
	//alert("addBookUrl:"+addBookUrl);
	//bookIframe.src=addBookUrl;
	getAJAXData("datajsp/space_bookMarkAdd_iframedata.jsp?SUPVODID=<%=fatherId%>&PROGID=<%=progId%>&BEGINTIME="+progTime+"&ENDTIME="+endTime,GetJson);
}
function GetJson(num)
{
	//alert("添加书签成功返回"+num);	
}
	
/**
*判断是否要显示书签
*/
//var showBookMark = false;
function bookMarkIsShow()
{
	if(!isAssess){return true;}
	else{return false;}
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
var minEpgIsShow = false; //minepg是否显示标志位
var minEpgShowDelayId = 0;
var minEpgHideDelayId = 0;
/**
*显示minEPG
*/
function showMinEpg()
{
	if(minEpgHideDelayId != 0){
		clearTimeout(minEpgHideDelayId);
		minEpgHideDelayId = 0;
	}
	if(minEpgIsShow){return;}
	if(volumeDivIsShow){hideBottom();}
	if(PauseDivIsShow)
	{	
		return; //如果跳转层显示,则返回
		hideJumpTimeDiv();
	}
	var VodFullTime=getVodTime();
	$("fullTime1").innerHTML=VodFullTime;
	$("vodName").innerHTML = vodName;
	$("director").innerHTML = director;
	$("actor").innerHTML = actor;
	$("time").innerHTML = "【片长】"+VodFullTime;
	//$("introduce").innerHTML = introduce;
	$("minEpgDiv").style.display = "block";
	minEpgIsShow = true;
	minEpgHideDelayId = setTimeout(hideMinEpg,hideTime);
	processSeek1(mp.getCurrentPlayTime());//由于信息键是5秒内消失，所以没有实时刷新进度
}
/**
*隐藏minEPG
*/
function hideMinEpg()
{
	if(minEpgIsShow == false){return;}
	if(minEpgShowDelayId != 0)
	{
		clearTimeout(minEpgShowDelayId);
		minEpgShowDelayId = 0;
	}
	$("minEpgDiv").style.display = "none";
	minEpgIsShow = false;
}
/**
*生成Minepg层，在数据获取页面调用
*/
function createMinEpg()
{
	//delayCreateMinEpg();
	setTimeout(delayCreateMinEpg,500);
}
function delayCreateMinEpg()
{

	showMinEpg();
	//minEpgShowDelayId = setTimeout(showMinEpg,delayTime);
}
var quitDivIsShow = false; //退出层是否显示标志位
var finishedDivIsShow = false; //播放结束层是否显示的标志位
/**
*显示退出层
*/
function showQuitDiv()
{
	if(quitDivIsShow == true){return;}
	$("quitDiv").style.display = "block";
	//$("bottomAd").style.display = "block";
	$("quit").focus();
	quitDivIsShow = true;
	clearTimeout(minEpgShowDelayId);//20110821
}
/**
*隐藏退出层
*/
function hideQuitDiv()
{
	if(quitDivIsShow == false){return;}
	$("quitDiv").style.display = "none";
	//$("bottomAd").style.display = "none";
	quitDivIsShow = false;
	
}
function hideFinishedDiv()
{
	if(finishedDivIsShow == false){	return;}
	$("finishedBackground").style.display = "none";
	//$("bottomAd").style.display = "none";
	if(nextProgId != "-1"){$("preNextDiv").style.display = "none";}
	else{$("endDiv").style.display = "none";}
	finishedDivIsShow = false;
}
	
//播放结束
function showFinishedDiv()
{	
	if(finishedDivIsShow == true){return;}
	$("finishedBackground").style.display = "block";
	//$("bottomAd").style.display = "block";
	if(nextProgId != "-1")
	{
		$("preNextDiv").style.display = "block";
		$("nextProg").focus();
		positionFlag = 3;
		clearTimeout(t);
		t = setTimeout("goNextProg()",3000);
	}
	else
	{
		$("endDiv").style.display = "block";
		$("end").focus();
		positionFlag = 5;
		tempTime=  setTimeout("antoQuit();",1000);
	}
	finishedDivIsShow = true;
}
	
function antoQuit()
{
	 clearTimeout(tempTime);
	 window.location.href =goBackUrl;
}
/**
*生成退出层,在数据获取页面调用（子页面）
*/
function createQuitDiv()
{
	if(!isAssess){$("saveBookMark").style.display = "block";}
	if(preProgId != "-1"){$("prePlay").style.visibility = "visible";}
	if(nextProgId != "-1")
	{
	//	$("nextPlay").style.visibility = "visible";
	}
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
	hideErrorDiv();
	if(PauseDivIsShow){hideJumpTimeDiv();}
	$("seekDiv").style.display = "none";
	jumpTimeIsShow=false;
	isSeeking = 0;		
	jumpPos =0 ;
	count=0;
	$("currentTime_progress").className="bar";
}
/*************************涉及页面层显示部分 end**************************************************/	
/**
*获取vod的播放时间
*/
function getVodTime()
{
	var time = '',hour = 0,minute = 0,second = 0;
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
	return time;
}
	
/**
*复写的公共控制页面的方法，判断公共页面的层是否可以显示
*/
function commonJumpDivCanShow()
{
	var canShow = false;
	if(!quitDivIsShow && !errorDivIsShow && !finishedDivIsShow)
	{
		canShow = true;
	}
	return canShow;
}
</script>
</head>
<body bgcolor="transparent" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="background-color: transparent" onLoad="start();init()" onUnload="unload()">

<div style="width:1px; height:1px; top:1px; left:1px;">
<a id="currentTime" href="#" style="width:1px; height:1px; top:-1px; left:-1px;"><img src="../images/dot.gif" width="1" height="1"/></a>
</div>

<div id="bottomframe" style="position:absolute;left:60px; top:330px; width:600px; height:190px;color:green;font-size:20;"></div>

<!--音量键-->
<div id="volumeDiv" class="volume" style="display:none;">
    <div style="width:320px;"><div id="volumeLen" class="on" style="width:0%;"></div></div> <!--总宽度为320px;也可以用100%-->
    <div id="volumeCur" style="left:380px;"></div>
</div>
<!--音量键-->

<%--按暂停键后出现的模块begin-------------------------------%>
<div id="seekDiv" class="play-page" style="position:absolute;width:640px;height:150px;left:5px;top:400px; z-index:1;display:none">
    <div id="statusImg" class="key" style="top:22px; left:10px;"></div>
    <div class="timeline" style="left:81px;">00:00:00</div>
    <div id="speed" style="position:absolute;width:60px;height:23px;left:40px;top:17px; z-index:2;"></div>
    <div id="timeError" style="position:absolute;width:220px;height:23px;left:120px;top:42px; z-index:2;font-size:18px;color:#FF3"></div>
    <div class="progress-bar" style="left:168px;">
        <div id="currentTime_progress" class="baron"> <!--当前为 class="bar"；选中为 class="baron";-->
            <div id="td_0" class="b1"></div>
            <div id="td_1" class="b2" style="width:360px;"></div> <!--总宽度为11（b1为固定宽）+360px-->				
            <div id="currTimeShow" style="top:30px;left:150px;"></div>
        </div>
    </div>
    <div id="fullTime" class="timeline" style="left:540px;"></div>		
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

<%--音量begin-------------------------%>
<div style="position:absolute; left:635px; top:15px; width:54px; height:66px; z-index:3;"><img id="voice" src="../images/dot.gif"/></div>
<%--音量end---------------------------%>

<%-----------------------play-page-点播信息键--------------%>
<div id="minEpgDiv" class="play-page" style="display:none">
    <div id="vodName" class="txt"></div>
    <div class="timeline2">00:00:00</div>
    <div class="progress-bar2">
        <div class="bar"> <!--当前为 class="bar"；选中为 class="baron";-->
            <div id="bar_0" class="b1"></div>
            <div id="bar_1" class="b2" style="width:0px;"></div> <!--总宽度为11（b1为固定宽）+195-->
        </div>
    </div>
    <div id="fullTime1" class="timeline2" style="left:550px;"></div>
    <div class="line" style="top:52px;"><img src="../images/line.png" /></div>
    <div class="txt" style="top:66px;"><span id="director"></span> &nbsp;&nbsp;<span  id="actor"></span> &nbsp;&nbsp;&nbsp;&nbsp;<span id="time"></span></div>
</div>
<%-----------------------play-page the end-----------------%>



<%-- AD-begin---------%>
<div id="bottomAd" style="position:absolute; bottom:0; left:0; background:url(../images/play/play-page-bg.png) repeat-x; width:640px; height:152px;z-index:4;display:none;">
		<div class="bottom_ad" style="position:absolute; top:40px; left:72px"><img src="../images/temp/ad_1.jpg" /><img src="../images/temp/ad_2.jpg" /><img src="../images/temp/ad_3.jpg" /></div>	
</div>
<%--AD-END------------%>

<%--退出层begin--------------------%>
<div id="quitDiv" style="display:none;">
    <div style="position:absolute; left:150px; top:120px; width:380px; height:262px;" align="center">
     <img src="../images/play/pop-bg2.gif" height="262px" width="380px"></div> 
    <div style="position:absolute; left:170px; top:135px; width:340px; height:200px; z-index:2; color:#FFFFFF; font-size:20px;">
          <table height="200" width="340" border="0" style="color:#FFF">
            <tr height="25px;">
              <td colspan="5"></td>
            </tr>
            <tr>
              <td colspan="5" align="center" style="color:#FFF">您是否要退出当前收看节目?</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td align="center" style="color:#FFF">退出</td>
              <td>&nbsp;</td>
              <td align="center" style="color:#FFF">取消</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td></td>
              <td id="saveBookMark" colspan="3" style="position:relative;padding-left:2px;padding-top:5px;color:#FFF" align="center">加入书签并退出</td>
              <td></td>
            </tr>
          </table>
          <div style="position:absolute; left:1px;top:160px;"></div>
          <a id="quit" href="javascript:quit();" style="position:absolute; left: 64px; top: 91px;"><img src = "../images/dot.gif" width="45px" height="30px"/></a> 
          <a id="cancel" href="javascript:cancel();" style="position:absolute;left:230px; top:91px;"><img src = "../images/dot.gif" width="45px" height="30px"/></a>
          <a id="bookmark" href="javascript:saveBookMark();" style="position:absolute;left:98px; top:154px;"><img src = "../images/dot.gif" width="145px" height="30px"/></a> 
    </div>
</div>
<%--退出层end----------------------%> 
  
<%--连续剧播放下一集begin-------------------%>
<div id="finishedBackground" style="position:absolute; left:155px; top:135px; width:200px; height:180px; display:none;"> 
<img src="../images/play/pop-bg2.gif" height="180" width="340"> </div>
<div id="preNextDiv" style="position:absolute; left:200px; top:155px; width:340px; height:280px;display:none; z-index:2; color:#FFFFFF; font-size:22px;">
  <table height="140" width="320">
    <tr height="20px">
      <td colspan="5"></td>
    </tr>
    <tr>
      <td colspan="5" style="color:#FFF">&nbsp;&nbsp;&nbsp;您是否继续收看下一集?</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td style="color:#FFF">下一集</td>
      <td>&nbsp;</td>
      <td style="color:#FFF">退出</td>
      <td>&nbsp;</td>
    </tr>
  </table>
  <div style="position:absolute; left:-80px; top:170px;"> <img height="120px" width="450px" src="../images/temp/11.jpg" /> </div>
  <a id="nextProg" href="javascript:goNextProg();" style="position:absolute; left: 13px; top: 90px;"><img src = "../images/dot.gif" width="83px" height="36px"/></a>
  <a id="finishedQuit" href="javascript:quit();"  style="position:absolute;left:178px; top:90px;"><img src = "../images/dot.gif" width="83px" height="36px"/></a> 
</div>
<%--连续剧播放下一集end---------------------%>

<%--播放结束begin-------------------%>
<div id="endDiv" style="position:absolute; left:180px; top:170px; width:310px; height:262px; display:none; color:#FFFFFF; font-size:24px;">
 <table height="62" width="300" border="0">
    <tr>
      <td style="color:#FFFFFF; font-size:30px;" align="center">谢谢观看</td>
    </tr>
  </table>
  <div style="position:absolute; left:75px;top:100px;font-size:24px">1秒后自动退出</div>
  <a id="end" href="javascript:quit();" style="position:absolute; left: 75px; top: 14px; "><img src = "../images/dot.gif"  width="155px" height="37px"/></a>
</div>
<%--播放结束end---------------------%>

<%--错误提示开始层-------------%>
<div id="errorDiv" style="position:absolute; left:120px; top:200px; width:400px; height:80px; z-index:-1; display:none"> 
<img src="../images/errorBack.gif" width="400px" height="80px"/></div>
<div id="errorDiv2" style="position:absolute;left:120px;top:300px;width:400px;height:80px;z-index:1;display:none">
  <table align="center" width="400" align="center" height="80">
  <tr>
    <td class="whiteFont" align="center"> 系统错误，请按返回键退出或稍候再试！</td>
  </tr>
  </table>
</div>
<%--错误提示层结束-------------%>

<%--隐藏层begin----%>
<div style="display:none">
  <%--获取数据-----------%>
  <iframe id="getDataIframe" width="1px" height="1px"></iframe>
  <%--记录书签-----------%>
  <iframe id="addBookIframe" width="1px" height="1px"></iframe>
</div>
<%--隐藏层 end-----%> 
<div style="display:none;">
<img src="../images/play/inp-bg.png" />
<img src="../images/play/inp-bgon.png" />
<img src="../images/play/pop-bg2.gif" />
<img src="../images/play/btn-pause.png" />
<img src="../images/play/play-page-bg.png" />
<img src="../images/play/icon-fast-return.png" />
<img src="../images/play/icon-fast-enter.png" />
<img src="../images/play/btn-play.png" />
<img src="../images/line.png" />
<img src="../images/play/icon-pause.png" />
<img src="../images/btn2_bg.png" />
</div>
</body>
<%@ include file = "play_pageVideoControl.jsp"%>
</div>
</html>
