<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="com.huawei.iptvmw.epg.facade.metadata.CommonImpl" %>
<%@ page import="com.huawei.iptvmw.epg.util.xml.DateUtilities" %>
<%@ include file="keyboard/keydefine.jsp" %>
<%@ include file="config/config_playControl.jsp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%!
private static int ROWS = 8;                //的行数（每页）
private static int COLS = 1;				 //显示的列数（每页）
private static int PAGEITEMS = ROWS*COLS;	//显示的数量（每页）
%>
<%
TurnPage turnPage = new TurnPage(request);
ServiceHelp serviceHelp = new ServiceHelp(request);
String goBackUrl = turnPage.go(-1);
String strProgId = request.getParameter("PROGID");
String strIsPerview = request.getParameter("PREVIEWFLAG");//预览标识；1:支持 0:不支持
String strChannelNum = request.getParameter("CHANNELNUM");
String comeType = request.getParameter("COMEFROMFLAG");
String strIsSub = request.getParameter("ISSUB"); //是否订购
String strBackUrl = request.getParameter("returnurl");//vas方式的返回
String locktimeStamp = "";//解锁验证页面使用
locktimeStamp = StringDateUtil.getTodaytimeString("yyyyMMddhhmmss");
int isfromgat = request.getParameter("isfromgat")==null?0:Integer.parseInt(request.getParameter("isfromgat"));
String _userid = (String)session.getAttribute("USERID");
if (_userid == null)
{
	_userid = "-1";
}
//判读是否从vas过来
if(null != strBackUrl && ! "".equals(strBackUrl))
{
	goBackUrl = strBackUrl;
}
int iShowDelayTime = 5000;//miniepg展示时间通过接口获取
int encryptMode = 0;//获取加密方式,中间件业务密码的加密方式 0：163 MD5加密 1：IPTV MD5加密
CommonImpl commonImpl = new CommonImpl(request);// 获取加密方式,中间件业务密码的加密方式 0：163 MD5加密 1：IPTV MD5加密
encryptMode = commonImpl.getSystemParam().getEncryptMode();
String userId = (String) session.getAttribute("USERID");//用户ID
String timeStamp = DateUtilities.getCurrDate() ;
int itype = 0;
String type=request.getParameter("ECTYPE");
if(type != null && type !="" && type != "null")
{	
	itype=Integer.parseInt(type);
}
%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>play_Controlchannel</title>
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<style type="text/css"> 
body { background-color:#000; font-family:"Microsoft YaHei"; font-size:22px; color:#fff;  margin:0px; padding:0px; width:640px; height:530px; overflow:hidden; position:relative;}
div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,p,th,td {margin:0; padding:0}
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
.btn-operate {
	left:500px; 
	position:absolute; 
	top:60px;
}
</style>
<style type="text/css">
img {border:0; margin:0}
table{border:0;*border-collapse:collapse; border-spacing:0}
body td{
	font-family:"黑体";
	font-size: 24px;
	color: white;
}
#no_order {
	font-family:"黑体";
	position: absolute;
	height: 146px;
	width: 363px;
	top: 100px;
	left: 250px;
	display: none;
}
#chan_page {
	font-family:"黑体";
	position: absolute;
	height: 20px;
	width: 40px;
	top: 398px;
	left: 15px;
    font-size: 20px;
	color:#FFFFFF;	
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
.item, .link, .txt, .pic, .btn { 
left:0; 
position:absolute; 
top:0;
}
.link { z-index:4;}
.txt { z-index:3;}
.pic { z-index:2;}
.onboder{ 
	border:2px solid #ffff50;
	background:none;
}
.offboder{ 
	border:2px hidden #3f6089;
	background:none;
}
.live-item .con .item,.live-item .con .item .txt  {
	height:39px;
	line-height:39px;
	left:0; 
	position:absolute; 
	top:0;
	width:189px;
}
.live-item .con .item .link,.live-item .con .item .link img{
	height:35px;
	left:0;
	width:189px;
}
.live-item .con .item .txt { left:10px;}
</style>
</head>
<script language="javascript">
if(typeof(iPanel) != 'undefined'){
iPanel.focusWidth = "2";
iPanel.defaultFocusColor = "#FCFF05";
}
/*********************重要begin****************************/
var itype="<%=itype%>";
var count=0;
var tempLockFlag;
var encryptMode = "<%=encryptMode%>" ;//加密方式
var timeStamp = "<%=timeStamp%>" ;//时间戳
var userId = "<%=userId%>" ;//用户ID
var channelId = <%=strProgId%>;//直播id
var isPerview = <%=strIsPerview%>;//是否支持预览
var isSubSingle = <%=strIsSub%>;//是否订购
var currChannelNum = <%=strChannelNum%>;//当前直播号
var backUrl = "<%=goBackUrl%>";//返回url
var comeType = "<%=comeType%>";
/***********************end******************************/
var currChannelIndex = -1;//当前索引
var chanListFocus = -1;//直播列表的当前索引
var totalChannel = -1;//直播总个数
var isControlChanIndex = -1; //当输入的直播号是受限制的直播号 记录当前索引  
var rows = <%=ROWS%>;//行数
var cols = <%=COLS%>;//列数
var page_items = rows*cols;//总页数
var currListPage = 0;//直播列表当前页
var totalListPages = 0;//直播列表总页

var channelListTimer="";//直播列表计时器
var hideNumTimer = "";//直播号清空计时器
var showTimer = -1;//显示计时器
var hiddenTimer = -1;//隐藏计时器
var timeID = "";//数字键跳转计时器
var lockTimer = "";//加锁层隐藏计时器
var hiddenDivTimer = "";//层隐藏计时器
var timeID_jumpTime = "";//跳转框
var timeID_check = "";
var bottomTimer = "";

var number = 0;//数字切换直播
var pr2 = null;//提交直播控制信息
var live_type = "live";  //直播业务
var back_type = "back";//直播回看业务
var business_type = live_type; //当前的业务类型 live_type直播状态 back_type时移状态
var shiftQuitFlag = 0;//时移上报退出标志位
var shiftFlag = 0;    // 时移标志位
var upPageToLastIndex = false ;//按向上键到前一面的最后一条数据
var lockPlay = "true";//加锁播放标志
var lockFlag = "false";//锁控制标志位 false--解锁层不存
var infoFlag = "false";//右边miniEPG显示的标识位
var playStat = "play";//播放器的播放的状态
var voiceflag="";
var premode; //记录上次mod是否为3 
var showFilmInfoFlag = "false";//miniepg数据获取标志位
var channelListFlag = "true";//左边直播列表显示/隐藏标识  false:已经显示
var channelListPlayFlag = "true";//直播列表播放标识
var mediaErrorFlag = "false";//系统错误提示
var isNotSubFlag = "false";//未订购层标志位
var isLeaveChannelFlag = "false";//断流标志位 如果==false 说明正常播放，未授权提示得自动消失 ,== true 说明没流未授权等提示要一直存在

var getDataFlag = "false";//子页面获取数据标志位
var quitDivIsShow = false; //退出DIV 是否显示标志位
var jumpDivIsShow = false; //跳转DIV
var seekDivIsShow = false;//进度条DIV，包含了跳转在内
var volumeDivIsShow = false;//音量DIV
/************************begin****************************/
var channelIds = new Array();//直播id号
var channelNames = new Array();	//直播名称
var channelNums = new Array();//直播号，对比是否存在直播的参考
var channelNumsShow = new Array();//用来显示的直播号数组
var isSub = new Array();//是否授权
var pltvStatus = new Array();//是否是时移直播
var channelUrls = new Array();//授权通过的URL链
var isLock = new Array();//是否加锁
var isControlled = new Array();//是否有父母控制
var channelCode = new Array();//直播的MediaCode
var isSubPreview = new Array();//是否支持预览
var STBType =Authentication.CTCGetConfig("STBType");
var positionFlag = 0; //记录页面焦点位置
var isSeeking = 0;//是否已经显进度DIV
var isJumpTime = 1;
var jumpPos = 4;//默认在进度条上
var speed = 1;

var currTime = 0,mediaTime = 0;
var timePerCell = mediaTime / 100;
var currCellCount = 0;
var preInputValueHour = "";//上一次检测时，文本框中的值
var preInputValueMin = "";
var volume = 20;//默认20%音量
var muteflag = -1;//设置默认为-1,强制第一次获取一下

var mp = new MediaPlayer();
var strchannelNum='<%=strChannelNum%>';
var chennelNum=parseInt(strchannelNum);
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
	setSTB();
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
	loadData();
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
		case <%=KEY_BOTTOMLINE%>:showBottomLine();break;//直播号下划线
		case <%=KEY_0%>:
			if(jumpDivIsShow){showInputTime(0);}
			else{inputNum(0);}
			return 0;			
			break;
		case <%=KEY_1%>:
			if(jumpDivIsShow){showInputTime(1);}
			else{inputNum(1);}
			return 0;	
			break;
		case <%=KEY_2%>:
			if(jumpDivIsShow){showInputTime(2);}
			else{inputNum(2);}
			return 0;	
			break;
		case <%=KEY_3%>:
			if(jumpDivIsShow){showInputTime(3);}
			else{inputNum(3);}
			return 0;	
			break;
		case <%=KEY_4%>:
			if(jumpDivIsShow){showInputTime(4);}
			else{inputNum(4);}
			return 0;	
			break;
		case <%=KEY_5%>:
			if(jumpDivIsShow){showInputTime(5);}
			else{inputNum(5);}
			return 0;
			break;
		case <%=KEY_6%>:
			if(jumpDivIsShow){showInputTime(6);}
			else{inputNum(6);}
			return 0;
			break;
		case <%=KEY_7%>:
			if(jumpDivIsShow){showInputTime(7);}
			else{inputNum(7);}
			return 0;
			break;
		case <%=KEY_8%>:
			if(jumpDivIsShow){showInputTime(8);}
			else{inputNum(8);}
			return 0;
			break;
		case <%=KEY_9%>:
			if(jumpDivIsShow){showInputTime(9);}
			else{inputNum(9);}
			return 0;
			break;
		case <%=KEY_CHANNEL_UP%>: addChannel();break;	//加直播
		case <%=KEY_CHANNEL_DOWN%>: decChannel();break;//减直播
		case <%=KEY_RIGHT%>:pressRight();return false;		
		case <%=KEY_LEFT%>:pressLeft();return false;
		case <%=KEY_DOWN%>:arrowDown();return false;
		case <%=KEY_UP%>:arrowUp();return false;
		case <%=KEY_PAGEDOWN%>:pageDown();return false;
		case <%=KEY_PAGEUP%>:pageUp();return false;
		//case <%=KEY_VOL_UP%>:volumeUp();return false; 
		//case <%=KEY_VOL_DOWN%>:volumeDown();return false;
		case <%=KEY_MUTE%>:setMuteFlag();return false;
		//case <%=KEY_STOP%>:stopKey();break;
		case <%=KEY_RETURN%>:pressReturn();break;
		case <%=KEY_GO_BEGINNING%>:break;	
		case <%=KEY_OK%>:pressOK();break;
		case <%=KEY_IPTV_EVENT%>:goUtility();break;
		case <%=KEY_SWITCH%>:break;//喜爱键	
		case <%=KEY_INFO%>: shwoFilmInfo();break;
		case <%=KEY_BLUE%>:mp.leaveChannel();mp.stop();window.location.href="space_collect.jsp";return 0;
		//case <%=KEY_PAUSE_PLAY%>:
		//case <%=KEY_POS%>: pauseOrPlay();return false;
		case <%=KEY_PREVIEWTIMES%> :previewTimes();break;//预览次数	
		//case <%=KEY_FAST_FORWARD%>:fastForward();return false;
		//case <%=KEY_FAST_REWIND%>:fastRewind();return false; 			
		case <%=KEY_PREVIEWTIME%>:previewTime();break;//预览时间	
		case <%=KEY_STBNOCHANNEL%>:stbNoChannel();break;
		case <%=KEY_TRACK%>: changeAudio(); break;
		case 1131:delInputTime();return 0;break;//删除	
	    case 277:
	    case 1109://点播
			mp.stop();window.location.href="vod.jsp?returnurl="; return false;break;
	    case 276:
	    case 1110://回放
			mp.stop();window.location.href="playback.jsp?returnurl=";return false;break;
		case 275:
		case 1108://直播
		    mp.stop(); window.location.href="live.jsp?returnurl=";return false;break;
	    case 1105://搜索
			mp.stop();window.location.href="search.jsp";return 0;
		case 281://收藏
			//mp.stop();
			//window.location.href="testTurnPage.jsp";
			return 0;
		default:
			return videoControl(keyval);
	}
	return true;
}
//事件响应
function goUtility()
{
	if(disLockFlag == 1){return;}
	eval("eventJson = " + Utility.getEvent());
	var typeStr = eventJson.type;
	switch(typeStr)
	{  
		case "EVENT_MEDIA_ERROR": mediaError(eventJson); break;
		case "EVENT_PLAYMODE_CHANGE":resumeMediaError(eventJson);break;		  
		case "EVENT_PLTVMODE_CHANGE":playModeChange(eventJson); return false;
		case "EVENT_TVMS":getTvms(eventJson); return false;
		case "EVENT_TVMS_ERROR":
			top.TVMS.closeMessage();
			top.TVMS.setKeyForSTB();
			return false;
		case "EVENT_MEDIA_BEGINING":
			$("seekDiv").style.display = "none";
			isSeeking = 0;speed = 1;			
			jumpDivIsShow = false;
			seekDivIsShow = false;
			resumestat();
			return false;
		case "EVENT_MEDIA_END":
			shiftFlag=0;isSeeking=1;			
			resumestat();
			return false;
		default :
			 break;
	}
	return true;
}
function pressReturn()
{
	if(business_type == back_type){goEnd();}
	else{quit();}
}

function showShift()
{
	
}

function resumestat()
{
	speed = 1,playStat = "play",premode = 0;
	if (1==isSeeking ){displaySeekTable();}       
}

//20120330修改为div以及自动跳转
function showInputTime(id){
	var bufInput;	
    if(jumpPos == 0){
    	bufInput = $("jumpTimeHour").innerText;
		if(bufInput == " "){bufInput = "";}
        else if(bufInput.length<2){ 
			$("jumpTimeHour").innerText = bufInput+id;
			if(($("jumpTimeHour").innerText).length==2){pressRight();}
		}
    }else if(jumpPos == 1){
        bufInput = $("jumpTimeMin").innerText;
		if(bufInput == " "){bufInput = "";}
        else if(bufInput.length<2){
			$("jumpTimeMin").innerText = bufInput+id;
			if(($("jumpTimeMin").innerText).length==2){pressRight();}
		}       	
    }
}
//20120330修改删除输入的时间数字
function delInputTime()
{
	var bufInput;	
    if(jumpPos == 0){
    	bufInput = $("jumpTimeHour").innerText;
		if(bufInput.length>0){$("jumpTimeHour").innerText=bufInput.substring(0,bufInput.length-1);}
    }else if(jumpPos == 1){
        bufInput = $("jumpTimeMin").innerText;
		if(bufInput.length>0){$("jumpTimeMin").innerText=bufInput.substring(0,bufInput.length-1);}
    }
}

function changeAudio()
{
	mp.switchAudioChannel();
	/*var audio = mp.getCurrentAudioChannel();  //FOR zte
	if(audio=="0" || audio=="Left"){audio=0;}
	else if(audio=="1" ||  audio=="Right"){	audio=1;}
	else if(audio=="2" ||  audio=="JointStereo" || audio=="Stereo" ){audio=2;}
	clearTimeout(voiceflag);
	switch(audio)
	{
		case 0:$("voice").src="images/voice/leftvoice.png";break;
		case 1:$("voice").src="images/voice/rightvoice.png";break;
		case 2:$("voice").src="images/voice/centervoice.png";break;
		default:break;		
	}
	voiceflag=setTimeout(function(){$("voice").src="../images/dot.gif";},5000);*/
}
function setMuteFlag()
{
	if("true"== mediaErrorFlag|| "true"==lockFlag || "true"==isNotSubFlag){return;}
	if("false" == channelListFlag){hiddenChannelList();}
	clearTimeout(showTimer);
	showTimer = "";
	clearTimeout(bottomTimer);
	bottomTimer = ""; 
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){
		mp.setMuteFlag(0);
		/*if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0){
			$("voice").src="/muteoff.png";
			bottomTimer = setTimeout(hideMute, 3000);
		}*/
	}else{
		mp.setMuteFlag(1);
		/*if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0){
			$("voice").src="/muteon.png";
			//bottomTimer = setTimeout(hideMute, 3000);
		}*/
	}      
}
function hideMute()
{
	$("voice").src="#";
}

//暂停键
function pauseOrPlay()
{	
	//时移状态: 1激活 0去激 （即不支持就不响应）  infoFlag:osd节目单信息 || "true" == infoFlag
	if(pltvStatus[currChannelIndex] == 0){return 0;}
	if("false" == channelListFlag){ hiddenChannelList();}
	if(infoFlag){hiddenFilmInfo();}
	resetPauseOrPlay();
	//business_type = back_type;//表示用户在时移状态了
	if("play" == playStat){ displaySeekTable(); jumpDivIsShow = true; pause(); }
    else{ displaySeekTable(); resume(); }
	$("statusImg").innerHTML = '<img src="../images/play/btn-pause.png"/>';
	$("speed").innerHTML = '';
}

//重置播放暂停焦点
function resetPauseOrPlay()
{
	if(0==jumpPos){$("jumpTimeHour").className="inp";}
	else if(1==jumpPos){$("jumpTimeMin").className="inp";}
	else if(2==jumpPos){$("ensureJump").className="btn02";}
	else if(3==jumpPos){$("cancelJump").className="btn02";}
}

function pause()
{
	mp.pause(); 
	playStat = "pause"; speed = 1; shiftFlag = 1;	  
}
/**
*退出当前页
*/
function quit()
{
	goBack();
}	

/**
*取消退出层
*/
function cancel()
{
	hideQuitDiv();
}
/**
*隐藏退出层
*/
function hideQuitDiv()
{
	if(false==quitDivIsShow){return;}
    $("quitDiv").style.display = "none";
	quitDivIsShow = false;
}
function volumeDown11()
{	
	if("true"==mediaErrorFlag ||"true"== lockFlag|| "true"==isNotSubFlag || true==oneKeySwitchJumpInfoIsShow){return 0;}
	if("false" == channelListFlag){hiddenChannelList();}
	if(seekDivIsShow){
		seekDivIsShow=false;
		displaySeekTable();
		if(playStat!= "play"){resume();}
	}
	if ("true" == infoFlag){hiddenFilmInfo();}
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){mp.setMuteFlag(0);}
	if(!volumeDivIsShow){volume = mp.getVolume();genVolumeTable();volumeDivIsShow = true;} 	
	volume -= 5;	
	if(volume <0){volume = 0;return;}		
	changeVolume(volume);
	mp.setVolume(volume);  	
	clearTimeout(bottomTimer);
	bottomTimer=setTimeout(hideBottom,3000);	
}

function volumeDown()
{
	//首先判断是否有音
	if(-1==muteflag){ muteflag=mp.getMuteFlag(); if(muteflag==1){mp.setMuteFlag(0);} }
	if(!volumeDivIsShow){genVolumeTable();volumeDivIsShow = true;volume = mp.getVolume();} 	
	volume -= 5;	
	if(volume <0){volume = 0;return;}		
	changeVolume(volume);mp.setVolume(volume); 	 	
	clearTimeout(bottomTimer);bottomTimer=setTimeout(hideBottom,3000);
}
function genVolumeTable()
{
	//$("volumeDiv").style.display = "block";//FOR zte
}
function changeVolume(volume)
{
	//$("volumeCur").innerHTML=volume;//FOR zte
	//$("volumeLen").style.width=volume+"%";//FOR zte
}
//音量控制
function volumeUp11()
{
	if("true"==mediaErrorFlag ||"true"== lockFlag|| "true"==isNotSubFlag || true==oneKeySwitchJumpInfoIsShow){return 0;}
	if("false" == channelListFlag){hiddenChannelList();}
	if("true" == infoFlag){hiddenFilmInfo();}
	if(seekDivIsShow){
		seekDivIsShow=false;
		displaySeekTable();
		if(playStat!= "play"){resume();}
	}
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){mp.setMuteFlag(0);}
	if(!volumeDivIsShow){volume = mp.getVolume();genVolumeTable();volumeDivIsShow = true;} 
	volume += 5;
	if(volume > 100){volume = 100; return;}	
	changeVolume(volume);
	mp.setVolume(volume);
	clearTimeout(bottomTimer);
	bottomTimer=setTimeout(hideBottom, 3000);	
}
function volumeUp()
{
	if(-1==muteflag){ muteflag=mp.getMuteFlag(); if(muteflag==1){mp.setMuteFlag(0);} }
	if(!volumeDivIsShow){genVolumeTable();volume = mp.getVolume();volumeDivIsShow = true;} 
	volume += 5;
	if(volume > 100){volume = 100; return;}	
	changeVolume(volume);mp.setVolume(volume);
	clearTimeout(bottomTimer);bottomTimer=setTimeout(hideBottom, 3000);		
}
function hideBottom()
{	
	$("volumeDiv").style.display = "none";
	volumeDivIsShow = false;
}

//快退
function fastRewind()
{    
	if(0==isSeeking){
		if(0==pltvStatus[currChannelIndex] || "true"==mediaErrorFlag || "true" ==lockFlag|| "true"==isNotSubFlag){return 0; }	
		displaySeekTable();
		$("statusImg").innerHTML = '<img src="../images/play/icon-fast-return.png"/>';
		if(volumeDivIsShow){hideBottom();}
		if("false" == channelListFlag){hiddenChannelList();}
		if("true" == infoFlag){hiddenFilmInfo();}
		//$("jumpTimeDiv").style.display = "none";
		playStat = "fastrewind";
	}			
	if(playStat != "fastrewind"||(speed >= 32 && "fastrewind"==playStat)){shiftFlag=1;speed = 1;} 
	if(playStat != "fastrewind"){$("statusImg").innerHTML = '<img src="../images/play/icon-fast-return.png"/>';playStat = "fastrewind"; }
	speed = speed * 2; $("speed").innerHTML = 'X'+speed; mp.fastRewind(-speed);		
       
}
//测试方法
function fastRewind1()
{
	$("seekDiv").style.display = "block"; //显示整个在暂停跳转DIV
}
//快进
function fastForward()
{ 		
   if(0==isSeeking){
	   if(0==pltvStatus[currChannelIndex]|| 0== shiftFlag||"true"==mediaErrorFlag || "true" ==lockFlag|| "true"==isNotSubFlag){ return 0;} 
		displaySeekTable();isJumpTime = 0;
		$("statusImg").innerHTML = '<img src="../images/play/icon-fast-enter.png"/>';
		if(volumeDivIsShow){hideBottom();}
		if("false" == channelListFlag){hiddenChannelList();}
		if("true" == infoFlag){hiddenFilmInfo();}
		//$("jumpTimeDiv").style.display = "none"; 
		playStat = "fastforward";
   }	 
   if(playStat != "fastforward"||(speed >= 32 && "fastforward"==playStat)){speed = 1; }  
   if(playStat != "fastforward"){$("statusImg").innerHTML = '<img src="../images/play/icon-fast-enter.png"/>';playStat = "fastforward";}         	
   speed = speed * 2; $("speed").innerHTML = 'X'+speed;mp.fastForward(speed);  
}

function displaySeekTable()
{
	//isSeeking等于0时展示进度条及跳转框
	if(0==isSeeking){
		$("seekDiv").style.display = "block"; //显示整个在暂停跳转DIV
		$("currentTime_progress").className="baron";
		currTime = mp.getCurrentPlayTime(); 
		processSeek(currTime);			
		checkSeeking();//调用方法检测进度条及跳转框的状态
		seekDivIsShow = true;jumpDivIsShow = true;isSeeking = 1;jumpPos=4;	
	}else{	
		$("seekDiv").style.display = "none";seekDivIsShow = false;jumpDivIsShow = false;
		clearTimeout(timeID_check);timeID_check = "";				
		resetPara_seek();//复位各参数	
		jumpPos = 4;
	}
}
//跳转提示信息隐藏后，重置相关参数
function resetPara_seek()
{
	clearTimeout(timeID_jumpTime);
	isSeeking = 0;
	isJumpTime = 1;
	preInputValueHour = "";
	preInputValueMin = "";playStat = "play";
	//$("jumpTimeDiv").style.display = "none";
	$("jumpTimeMin").innerText = "";
	$("jumpTimeMin").innerText = "";
	$("timeError").innerHTML = "";
	if(playStat=="play"){$("statusImg").innerHTML = '<img src="../images/play/btn-pause.png"/>';}
	else if(playStat=="fastrewind") {$("statusImg").innerHTML = '<img src="../images/play/icon-fast-return.png">';}
	else{$("statusImg").innerHTML = '<img src="../images/play/icon-fast-enter.png">';}
}
function processSeek(_currTime)
{
	var innerFlag = 0;
	if(null == _currTime || _currTime.length != 16 || _currTime == undefined){ _currTime = mp.getCurrentPlayTime();}
	if(_currTime < 0){_currTime = 0;innerFlag = 1; }
    if(0==mediaTime){mediaTime = mp.getMediaDuration(); }	
    var currPlayTime = _currTime;
    timePerCell =  mediaTime / 100;  
	 _currTime = getRelativeTime(_currTime); // 得到到前播放相对时间，单位秒
    currCellCount = Math.floor(_currTime / timePerCell); 
	if(currCellCount > 100){currCellCount = 100;}
	if(currCellCount < 0){currCellCount = 0;innerFlag = 1; }
	var maxTime2 = getCurrTime2();
	var maxTime=getCurrTime();
	var tmp12 = getCurrPlayTime2(currPlayTime);  
	var tmp1  = getCurrPlayTime(currPlayTime); 
	var tmp22 = getShiftBeginTime2();
	var tmp2  = getShiftBeginTime();	
	if (tmp12 < tmp22){tmp1 = tmp2;} // 规避当前时间显示小于时移开始时间的问题
	if(tmp12 > maxTime2){tmp1 = maxTime;}	
	//if(tmp1==maxTime){ alert("processSeek");displaySeekTable();} //下面这句判断不能快进的时候,清理20120427
	$("currTimeShow").innerHTML = tmp1;
	$("fullTime").innerHTML = maxTime;
	$("beginTime").innerHTML = tmp2;
	$("td_1").style.width = currCellCount * 3.6;
}
//检查进度条
function checkSeeking()
{
	if(playStat != "fastrewind" && playStat != "fastforward"){$("statusImg").innerHTML = '<img src="../images/play/btn-pause.png"/>';}
	var inputValueHour = $("jumpTimeHour").innerText;
	var inputValueMin =  $("jumpTimeMin").innerText;
	clearTimeout(timeID_check);timeID_check = setTimeout(checkSeeking,500);//更新焦点条
	if("fastrewind"==playStat || "fastforward"==playStat){	currTime = mp.getCurrentPlayTime(); processSeek(currTime);}
	if(preInputValueHour != inputValueHour || preInputValueMin != inputValueMin){
		clearTimeout(timeID_jumpTime);
		timeID_jumpTime = setTimeout(hideCheckSeekDiv,15000); //20120427
		preInputValueHour = inputValueHour;
		preInputValueMin = inputValueMin;
	}
}
function hideCheckSeekDiv()
{
	if("pause" == playStat){resetPauseOrPlay();}
	displaySeekTable();resume();
}

function hideJumpTimeDiv()
{    	
	clearTimeout(timeID_jumpTime);timeID_jumpTime = "";
	jumpDivIsShow = false;
	var inputValueHour = $("jumpTimeHour").innerText;
	var inputValueMin = $("jumpTimeMin").innerText;	
	if(preInputValueHour != inputValueHour || preInputValueMin != inputValueMin){return;} // 如果输入发生变化，则不作隐藏	
	if(isEmpty(inputValueHour) || isEmpty(inputValueMin))//如果文本框中有一个值为空，隐藏div
	{
		isJumpTime = 0;
		// $("jumpTimeDiv").style.display = "none";
	}
	//如果文本框中有值则调用clickJumpBtn方法
	else{clickJumpBtn(); }
	count=0;
	jumpPos=0;
	$("currentTime_progress").className="bar";
}

function checkJumpTime(pHour, pMin)
{    
	if(isEmpty(pHour)||!isNum(pHour)||isEmpty(pMin)||!isNum(pMin)||!isInMediaTime(pHour, pMin)||parseInt(pHour)>=24||parseInt(pMin)>=60){return false;}
	else{return true;}
}
 //判断是否在播放时长内
function isInMediaTime(pHour, pMin)
{
	var currTime = new Date();   
	var inputTime = new Date();  
	if(0==mediaTime){var shiftLength = mp.getMediaDuration();  }	
	else{var shiftLength=mediaTime;}
	var beginTime = new Date(currTime.getTime() - shiftLength * 1000);// 如果读到时间为零则取1小时
	pHour = pHour.replace(/^0*/, "");
	if(pHour == ""){pHour = "0";}
	pMin = pMin.replace(/^0*/, "");        
	if(pMin == ""){pMin = "0";}
	inputTime.setHours(parseInt(pHour));  
	inputTime.setMinutes(parseInt(pMin));
	inputTime.setSeconds(0);
	return  (((beginTime.getTime() - inputTime.getTime()) <= 0) && ((currTime.getTime() - inputTime.getTime()) > 0));
}
function isEmpty(s)
{   
	return ((s == undefined) || (s == "") || (s == null) || (s.length == 0));
}
function isNum(s)
{
	var nr1=s,flg=0,cmp="0123456789",tst ="";
	for (var i=0,l=nr1.length;i<l;i++){
		tst=nr1.substring(i,i+1)
		if (cmp.indexOf(tst)<0){flg++;}
	}
	if (flg == 0){return true;}
	else{return false;}
}
function clickJumpBtn()
{    	
	var inputValueHour = $("jumpTimeHour").innerText;
	var inputValueMin = $("jumpTimeMin").innerText;
	var timeJump=getShiftBeginTime();
	var hourJump=timeJump.substring(0,2);
	var minJump=timeJump.substring(3,5);
	if(inputValueHour==""){inputValueHour="00";}
	if(inputValueMin==""){inputValueMin="00";}
	$("ensureJump").className="btn02";
	//校验通过，跳转到相应时间，并隐藏跳转框所在div
	if(checkJumpTime(inputValueHour, inputValueMin))
	{
		var hour = parseInt(inputValueHour,10);
		var min = parseInt(inputValueMin,10);
		var dateobj = new Date();
		dateobj.setHours(hour - 8);

		var year =  dateobj.getFullYear();  
		var month = dateobj.getMonth() + 1;
		var day = dateobj.getDate(); 
		hour = dateobj.getHours();
		
		if (month < 10) month = "0" + month;
		if (day < 10) day = "0" + day;
		if (hour < 10) hour = "0" + hour;
		if (min < 10) min = "0" + min;
		var timeStamp = "" +  year + month + day + "T" + hour + min + "00" + "Z";

		clearTimeout(timeID_jumpTime);
		timeID_jumpTime = "";
		isJumpTime = 0;
		//$("jumpTimeDiv").style.display = "none";
	    $("jumpTimeHour").innerText = "";
		$("jumpTimeMin").innerText = "";
		jumpToTime(timeStamp);
	}
	else
	{        	
		$("jumpTimeHour").innerText = "";
		$("jumpTimeMin").innerText = "";
		$("timeError").innerHTML = "时间输入不合理，请重新输入！";
		jumpPos = 0;	   
		preInputValueHour = "";
		preInputValueMin = "";
		$("jumpTimeHour").className="inpon";	
		setTimeout(inputErrorcls,5000);
		clearTimeout(timeID_jumpTime);timeID_jumpTime="";
		//timeID_jumpTime = setTimeout(hideJumpTimeDiv,15000);
	}
	count=0;
}

function inputErrorcls()
{
	$("timeError").innerHTML = "";
}

function jumpToTime(_time)
{  
	timeForShow = 0;
	playByTime(_time);
	processSeek(_time); 
	displaySeekTable(); 
}
function playByTime(beginTime)
{       
	var type = 2;speed = 1;	playStat = "play";
	mp.playByTime(type,beginTime,speed);
	count=0;
	jumpPos=0;
	$("currentTime_progress").className="bar";
}
function getShiftBeginTime()
{
	var currTime = new Date();   
	var beginTime = new Date(currTime.getTime() - mediaTime * 1000);
	var min = beginTime.getMinutes();
	var sec = beginTime.getSeconds();
	if (sec >= 30) beginTime.setMinutes(min + 1);   	
	var hour = beginTime.getHours();
	min = beginTime.getMinutes();
	if (hour < 10) hour = "0" + hour;
	if (min < 10) min = "0" + min;   
	return hour + ":" + min;    	
}
function getShiftBeginTime2()
{
	var currTime = new Date();  
	var beginTime = new Date(currTime.getTime() - mediaTime * 1000);
	var year = beginTime.getYear();
	var month = beginTime.getMonth()+1;
	var day =beginTime.getDate(); 
	var hour = beginTime.getHours();
	var min = beginTime.getMinutes();
	var sec = beginTime.getSeconds();
	if (sec >= 30) beginTime.setMinutes(min + 1);   	
	min = beginTime.getMinutes();
	if(month<10) month="0"+month;
	if(day<10)day ="0"+day;
	if (hour < 10) hour = "0" + hour;
	if (min < 10) min = "0" + min;   
	var timeFlag=year+""+month+""+day+""+hour+""+min+""+sec;
	var timeOutFlag=countTime(timeFlag,0);
	return timeOutFlag;    	
}
function getCurrTime()
{	
	var currTime = new Date();    	
	var min = currTime.getMinutes();
	var sec = currTime.getSeconds();
	if (sec >= 30) currTime.setMinutes(min + 1);
	var hour = currTime.getHours();
	min = currTime.getMinutes();

	if (hour < 10) hour = "0" + hour;
	if (min < 10) min = "0" + min;    	
	return hour + ":" + min;
}
function getCurrTime2()
{	
	var currTime = new Date(); 
	var year=currTime.getYear();
	var month=currTime.getMonth()+1;
	var day =currTime.getDate();
	var min = currTime.getMinutes();
	var sec = currTime.getSeconds();
	if (sec >= 30) currTime.setMinutes(min + 1);
	var hour = currTime.getHours();
	min = currTime.getMinutes();
	if(month<10) month="0"+month;
	if(day<10)day="0"+day;
	if (hour < 10) hour = "0" + hour;
	if (min < 10) min = "0" + min;    	
	var timeFlag=year+""+month+""+day+""+hour+""+min+""+sec;
	var timeOutFlag=countTime(timeFlag,0);
	return timeOutFlag;
}

function getCurrPlayTime(currPlayTime)
{
	//转化UTC时间
	currPlayTime = parseUtcTime(currPlayTime);
	var sec = currPlayTime.getSeconds(); 
	var hour = currPlayTime.getHours();
	var min = currPlayTime.getMinutes();
	if (sec >= 30){
	   min = min + 1;
	   if(min == 60){ min = 59;}
	}
	if (hour < 10) hour = "0" + hour;
	if (min < 10) min = "0" + min;
	return hour + ":" + min;    	
} 
function getCurrPlayTime2(currPlayTime)
{
	//转化UTC时间
	currPlayTime = parseUtcTime(currPlayTime);
	var year = currPlayTime.getYear();
	var month= currPlayTime.getMonth()+1;
	var sec = currPlayTime.getSeconds();
	var day=currPlayTime.getDate(); 
	var hour = currPlayTime.getHours();
	var min = currPlayTime.getMinutes();
	if (sec >= 30){
	   min = min + 1;
	   if(min == 60){min = 59;}
	}
	if(month<10) month="0"+month;
	if(day<10)day ="0"+day;
	if (hour < 10) hour = "0" + hour;
	if (min < 10) min = "0" + min;
	var timeFlag=year+""+month+""+day+""+hour+""+min+""+sec;
	var timeOutFlag=countTime(timeFlag,0);
	return timeOutFlag;     	
} 
function getRelativeTime(currPlayTime)
{   
	currPlayTime = parseUtcTime(currPlayTime);		
	var currTime = new Date(); 
	var beginTime = new Date(currTime.getTime() - mediaTime * 1000);
	var relativeTime = (currPlayTime.getTime() - beginTime.getTime())/1000;
	return relativeTime;
} 
// 解析UTC时间为一日期对象
function parseUtcTime(utcTime)
{
	var year = parseInt(utcTime.substr(0, 4));
	var month = parseInt(utcTime.substr(4, 2));
	var day = parseInt(utcTime.substr(6, 2));
	var hour = parseInt(utcTime.substr(9, 2));
	var min = parseInt(utcTime.substr(11, 2));
	var sec = parseInt(utcTime.substr(13, 2)); 
	// 处理parseInt("0X")等于零的问题
	if (month == 0) month = parseInt(utcTime.substr(5,1));
	if (day == 0) day = parseInt(utcTime.substr(7,1));
	if (hour == 0) hour = parseInt(utcTime.substr(10,1));
	if (min == 0) min = parseInt(utcTime.substr(12,1));
	if (sec == 0) sec = parseInt(utcTime.substr(14,1));	
	var d =  new Date(year, month -1, day, hour + 8, min, sec);   
	return d;   	 	
}  
function resume()
{
	speed = 1,playStat = "play"; mp.resume();
	if(mp.getNativeUIFlag() == 0){$("topframe").innerHTML = "";}
}

function getTvms(eventJson)
{
	top.TVMS.showMessage(eventJson);
}

//播放模式变化
function playModeChange(eventJson)
{
	hideMediaError();
	var stat = eventJson.service_type;
    if (stat == 1)//进入时移
    {
        if (business_type == live_type) { business_type = back_type;}
    }
    if (stat == 0)//返回直播
    {
		if (business_type == back_type){ business_type = live_type;}
    }
}
//切换直播
function joinChannel(chanNum)
{	
	//如果miniepg显示，先清空
	if("true" == infoFlag){
		clearTimeout(hiddenTimer);
		hiddenFilmInfo();
	}
	showChannelNum();
	//1,外部进来 预览播放 
	if(0 == isSubSingle && 1 == isPerview){
		var testChanNum = "<ChannelPreviewCMD ChannelNo='"+chanNum+"'/>";
		mp.sendVendorSpecificCommand(testChanNum);
		isSubSingle = -1;
		isPerview = -1;
	}
	//2,内部切换 预览播放 
	else if(isSubPreview[currChannelIndex] == 1 && 3 == isSub[currChannelIndex]){	
		var testChanNum = "<ChannelPreviewCMD ChannelNo='"+chanNum+"'/>";
		mp.sendVendorSpecificCommand(testChanNum);
	}
	//3,开机播放,正常播放
	else{
		if(STBType.indexOf("EC5108") != -1 || STBType.indexOf("EC1308") != -1 ||　STBType.indexOf("EC2108") != -1)
		{
			//alerts("加载的时候判断终端");
		}
		else{mp.leaveChannel();}
		mp.joinChannel(chanNum);
	}
	//恢复流
	isLeaveChannelFlag = "false";	
	setFocus(currChannelIndex);
	//新直播播放前需要重新设置miniEPG显示
	if("true" == showFilmInfoFlag){showInfo();}
	//clearTimeout(showTimer);//20120508修改为直接显示
	//showTimer = setTimeout(shwoFilmInfo,<%=iShowDelayTime%>);
	shwoFilmInfo();
}	
//直播号显示
function showChannelNum()
{
	//基本以直播号为主
	if(channelNums[currChannelIndex] != undefined){channelNumAction(channelNums[currChannelIndex]);}
	else{channelNumAction(currChannelNum);}
}
//停止键
function stopKey()
{
	//如果直播列表存在，先去掉直播列表
	if("false" == channelListFlag){
		//clearTimeout(channelListTimer);
		hiddenChannelList();
	}
	//如果一键跳转层显示，就先退出层
	if(oneKeySwitchJumpInfoIsShow){hideOneKeySwitchJumpInfo();}
	if(lockFlag == "true"){stopChannel();}
	else{ stopChannel();goBack();}
}	
//返回键
function returnBack()
{	
	//如果直播列表存在，先去掉直播列表
	if("false" == channelListFlag){
		hiddenChannelList();
		return;
	}
	//如果一键跳转层显示，就先退出层
	if(oneKeySwitchJumpInfoIsShow){hideOneKeySwitchJumpInfo();return;}
	//如果是时移状态的话，先切换到直播状态
	if(business_type == back_type){
		if(seekDivIsShow){	
			$("seekDiv").style.display = "none";
			seekDivIsShow = false;
			count=0;
			jumpPos=0;
			$("currentTime_progress").className="bar";
		}
		business_type = live_type;
		mp.gotoEnd();
		return;
	}else  //退出提示层
	{
		stopChannel();
		resetQuitDiv();
		showQuitDiv();
	}	
}	
/**
*进入退出层时，重置退出层
*/
function resetQuitDiv()
{
	positionFlag = 0;
}	
/**
*显示退出层
*/
function showQuitDiv()
{
	quit();
}
//离开当前直播
function stopChannel()
{		
	//离开直播时清空miniEPG
	clearTimeout(hiddenTimer);
	hiddenFilmInfo();
	mp.leaveChannel();
     //	mp.stop();//hwwebkit
	if("true" == isNotSubFlag){clearDiv();}//清空层	
	if("true" == lockFlag){hiddenLockInfo();}//清空锁控制层	
	if("false" == channelListFlag){hiddenChannelList();}//清空直播列表	
	if(preDivIsShow){hiddenPreview();	}//清空预览提示
	if("true" == mediaErrorFlag){hiddenMediaError();}//清空错误层
	setTimeout(hideChannelNum,<%=DEFAULT_HIDEINFO_TIME%>);//清空直播号
	freeFocus(currChannelIndex);		
}	
//离开当前页面
function goBack()
{	
	var url = unescape(backUrl);	
	if("true" == isNotSubFlag){clearDiv();}//清空层
	if("true" == lockFlag){hiddenLockInfo();}
	/*if(seekDivIsShow){ hideCheckSeekDiv();return 1;}
	if(infoFlag){hiddenFilmInfo();return 1;}
	if("false" == channelListFlag){hiddenChannelList();return 1;}
	//alert("22222");*/
	mp.leaveChannel();
	mp.stop();
	shiftQuitFlag = 1;//此出赋值,以防在destoryMP方法中再上报一次
	//为频道的焦点记忆	
	if(backUrl.indexOf('?')==-1){ backUrl+="?back=1";}	   
    else if(backUrl.indexOf('&back=1')==-1){ backUrl+="&back=1";}
	if("3"==comeType){	backUrl = "index.jsp";}
	window.location.href = backUrl;
}
//从子页面加载数据
function loadData()
{
	filmInfo.location.href = "play_ControlChannelListTv.jsp?isfromgat=<%=isfromgat%>&CHANNELID="+channelId+"&CHANNELNUM="+currChannelNum+"&COMEFROMFLAG="+comeType;
}	
//向下键
function arrowDown()
{
	
	if(quitDivIsShow){return;}
	//直播列表显示的时候，处理按键
	if("false" == channelListFlag)
	{	
		if(chanListFocus%rows == (rows-1)|| chanListFocus == totalChannel){	
			pageDown();return;
		}
		addChannelList();
		return;
	}else if(jumpDivIsShow && jumpPos==4)
	{
		jumpPos=0;
		$("currentTime_progress").className="bar";
		$("jumpTimeHour").className="inpon";
		return;
	}
	decChannel();
}	
//向下切直播 函数中注意先后顺序
function decChannel()
{
	if(quitDivIsShow||oneKeySwitchJumpInfoIsShow||jumpDivIsShow || seekDivIsShow){return;}
	stopChannel();//离开上一个直播	
	if(0 == currChannelIndex){currChannelIndex = totalChannel;}//是否直播是第一个直播，如果是应该切到最后一个直播
	else{currChannelIndex--;}
	lockPlay = "true";
	if("false" == lockPlay){
		//是否直播是最后一个直播，如果是应该切到第一个直播
		if(totalChannel == currChannelIndex){currChannelIndex = 0;}
		else{currChannelIndex++;}
		return;
	}
    joinChannel(channelNums[currChannelIndex]);
}	
//向上键
function arrowUp()
{
	if(quitDivIsShow){	return;}
	//直播列表显示的时候，处理按键
	if("false" == channelListFlag){	
		if(chanListFocus%rows == 0){ upPageToLastIndex = true ; pageUp(); return;}
		decChannelList();
		return;
	}
	if(jumpDivIsShow){
		resetPauseOrPlay();
		jumpPos=4;
		$("currentTime_progress").className="baron";
		return;
	}
	addChannel();
}	
//向上切直播 函数中注意先后顺序
function addChannel()
{
	if(quitDivIsShow||oneKeySwitchJumpInfoIsShow||jumpDivIsShow || seekDivIsShow){return;}	
	stopChannel();//先离开上一个直播
	if(totalChannel == currChannelIndex){currChannelIndex = 0;}//是否直播是最后一个直播，如果是应该切到第一个直播
	else{currChannelIndex++;}
	lockPlay = "true";
	joinChannel(channelNums[currChannelIndex]);
}
//直播列表下键切直播 函数中注意先后顺序
function addChannelList()
{
	freeFocus(chanListFocus);
	if(totalChannel == chanListFocus){chanListFocus = 0;}//是否直播是最后一个直播，如果是应该切到第一个直播
	else{chanListFocus++;}
	setFocus(chanListFocus);
	//如果锁存在，则直播列表一直存在
	isHaveLock();
	if("true" == lockFlag){hiddenLockInfo();}
}	
//直播列表上键切直播  函数中注意先后顺序
function decChannelList()
{
	freeFocus(chanListFocus);
	if(0 == chanListFocus){chanListFocus = totalChannel;}	//是否直播是最后一个直播，如果是应该切到第一个直播
	else{chanListFocus--;}
	setFocus(chanListFocus);
	//如果锁存在，则直播列表一直存在
	isHaveLock();
	if("true" == lockFlag){hiddenLockInfo();}
}	
	
//授权验证，父母控制，加锁等
function authtication(_chanIndex)
{	
	
}	
//父母控制，加解锁提示
function showLockInfo()
{
	lockFlag = "true";
	bg_lockpass.style.display = "block";
	lock_pass.style.display = "block";
	$("pwd").focus();
}
/******************************解码begin**********************************************/
/*解码页面使用 */
function clickAction(value)
{			
	
}
//判断输入字符是否为空
function isValidString(s)
{

}	
//隐藏解锁提示信息
function hiddenLockInfo()
{
	
}	
//错误提示信息
function showErrorInfo()
{
	
}	
/**********************************解码end******************************************/	
//miniEPG数据
function showInfo()
{	
	miniInfo.location.href = "play_ControlChannelminiInfo.jsp?CHANNELID=" + channelIds[currChannelIndex] + "&pltvStatusFlag=" + isSubPreview[currChannelIndex];
}	
//右边的OSD miniEPG显示
function shwoFilmInfo()
{	
	if( "fastforward" ==playStat|| "fastrewind"==playStat){ clearTimeout(showTimer); showTimer = ""; resume();}
	//hideBottom();20120508
	if(0 == bottomLineNum){showChannelNum();}	//直播下划线存在的时候不显示
	if(jumpDivIsShow){hideJumpTimeDiv();}
	if(volumeDivIsShow){hideBottom();}
	if(seekDivIsShow){$("seekDiv").style.display = "none";}
	$("filmInfo1").style.display = "block";
	infoFlag = "true";
	hiddenTimer = setTimeout(hiddenFilmInfo,5000);
}	
//右边OSD miniEPG隐藏
function hiddenFilmInfo()
{
	//隐藏直播号
	if("true" == infoFlag){
		clearTimeout(hideNumTimer);
		hideChannelNum();
	}
	clearTimeout(hideNumTimer);
	hideNumTimer = setTimeout(hideChannelNum,<%=DEFAULT_HIDEINFO_TIME%>);
	$("filmInfo1").style.display = "none";
	infoFlag = "false";
}	
//信息健
function infoKey()
{	
	if(playStat!= "play"){resume();}
	if("false"==infoFlag ){
		clearTimeout(showTimer);
		clearTimeout(hiddenTimer);
		//getDataFlag为true表示已经获取到了数据	
		if("true" == getDataFlag){shwoFilmInfo();} //showInfo();setTimeout(showInfo,800);shwoFilmInfo();
	}else{	
		hiddenFilmInfo();
		clearTimeout(hiddenTimer);
	}
}	
//清空层 主要是未授权、直播不存在、
function clearDiv()
{
	//未授权
	isNotSubFlag = "false"; //hxt修改了频道号不存在一直提示的问题
	bg_noorder.style.display = "none";
	no_order.style.display = "none";
}	
/*****************直播列表begin******************************************/	
//直播列表页面初始化 
function init_page()
{
	//init_data();
	create_chanTable();
	setFocus(chanListFocus);
   //showPage();
}
//直播OSD列表
function create_chanTable()
{		
	var chaninfo = "",tmpPages=currListPage * rows,index=0,top=0;
	for(var j = 0; j<rows; j++){
		index = tmpPages + j; top=36*j;
		//alert("#######currListPage="+currListPage+"$$$$$$$$$index="+index);
		if(typeof(channelNumsShow[index]) != "undefined"){
			//alert("-------------------"+channelNumsShow[index]);
			chaninfo += "<div class='item' style='top:"+top+"px'><div class='link'><a id='chan_"+j+"' href='#'><img src='../images/t.gif'/></a></div><div id='osd_"+j+"' class='txt'>"+channelNumsShow[index]+"&nbsp;"+channelNames[index]+"</div></div>";
		}else{
			//alert("-------------------"+channelNumsShow[index]);
			//chaninfo += "<div class='item'>&nbsp;</div>";
			chaninfo += "<div class='item' style='top:"+top+"px'><div class='link'><a id='chan_"+j+"' href='#'><img src='../images/t.gif'/></a></div><div id='osd_"+j+"' class='txt'>&nbsp;</div></div>"; 
		}
	}
	chaninfo += "<div class='page' id='osdpage' style='top:300px; left:85px;'>"+(currListPage+1)+"/"+totalListPages+"</div>"; 
	$("chan_info").innerHTML = chaninfo;
}
//第二次加载的时候
function updateList()
{
	//alert("updateList() currListPage"+currListPage);
	var tmpPages=currListPage * rows,index=0;
	for(var j = 0; j<rows; j++){
		index = tmpPages + j;
                if(index <= channelNames.length-1 && index <= channelNumsShow.length-1)  //修改中兴全屏播放频道列表出现undefined的问
         		$("osd_"+j).innerHTML=channelNumsShow[index]+"&nbsp;"+channelNames[index];	
	        else
			$("osd_"+j).innerHTML="&nbsp;";
	}
	$("osdpage").innerHTML=(currListPage+1)+"/"+totalListPages;
}	
 //加载直播列表
function init_data()
{
	create_chanTable();
}	
//释放焦点选择
function freeFocus(curr_focus)
{
	var focusAt = curr_focus%rows;
       if($("chan_"+focusAt) != undefined)  //ztewebkit
	$("chan_"+focusAt).blur();
}	
//获得焦点选择
function setFocus(curr_focus)
{
	var focusAt = curr_focus%rows;
	$("chan_"+focusAt).focus();
}	
function gotoEnd()
{
	if(pltvStatus[currChannelIndex] == 0||"true" ==mediaErrorFlag|| "true" ==lockFlag|| "true"==isNotSubFlag){return;}
	if("false" == channelListFlag){hiddenChannelList();}
	if("true"==infoFlag){hiddenFilmInfo();}
	shiftFlag = 0;  // 规避一键到尾不能收到MEDIA_END的问题    	
	resumestat();
	goEnd();
}	
function goEnd()
{
	business_type = live_type;
	mp.gotoEnd();
}	
	
//下翻页
function pageDown()
{
	//直播列表不显示，按翻页键没用
	if("true" == channelListFlag){gotoEnd();}
	else{
		if(currListPage > totalListPages - 1 || totalListPages == 1){return;}
		freeFocus(chanListFocus);
		if(currListPage == totalListPages - 1) {	currListPage = 0;}    //如果是最后一页 则下翻到第一页
		else{currListPage++;}
		updateList();
		chanListFocus = currListPage*rows;
		setFocus(chanListFocus);
		isHaveLock();		//如果锁存在，则直播列表一直存在
	}
}	
 //上翻页
function pageUp()
{
	//直播列表不显示，按翻页键没用
	if("true" == channelListFlag){gotoStart();	}
	else{
		if(currListPage < 0 || totalListPages == 1){return;}
		freeFocus(chanListFocus);		
		if(currListPage == 0) {currListPage = totalListPages - 1;}     //如果是第一页 则上翻到最后一页             
		else{currListPage--;}
		updateList();
		if(upPageToLastIndex==true)
		{
			if(0 == chanListFocus){chanListFocus = totalChannel;}
			else{chanListFocus--;}
			upPageToLastIndex = false ;
		}
		else{chanListFocus = currListPage*rows;}
		setFocus(chanListFocus);		
		isHaveLock();//如果锁存在，则直播列表一直存在
	}
}
function gotoStart()
{
	if(pltvStatus[currChannelIndex] == 0||mediaErrorFlag == "true" || lockFlag == "true" || isNotSubFlag == "true"){return; }
	if("false" == channelListFlag){
		//clearTimeout(channelListTimer);
		hiddenChannelList();
	}
	if ("true"==infoFlag){hiddenFilmInfo();}
	shiftFlag = 1;  // 规避一键到头不能收到MEDIA_BEGGIN的问题
	//pr.beginShift();
	goBeginning();
	resumestat();
}
function goBeginning()
{
	business_type = back_type;
	mp.gotoStart();
}	
//重载直播列表
function chanReload1()
{
	//init_data();
	//下面修改为翻页的时候只是修改加载的数据20120508
	updateList();	
}

//ok键
function pressOK()
{	
	//判断情况：1.是否快进，快退 2.是否已经有直播OSD的情况 3.是否有跳转框出现 4.音量
	if("fastforward"== playStat|| "fastrewind"==playStat){clearTimeout(showTimer);showTimer = "";resume();}
	if(volumeDivIsShow){hideBottom();}
	currentTime = mp.getCurrentPlayTime();
	if(quitDivIsShow){return;} //目前没有推出界面
	//false:已经显示
	else if("false" == channelListFlag){	
		if(currChannelIndex == chanListFocus && "false" == isLeaveChannelFlag){ hiddenChannelList();}  //如果刚好是当前播放的直播，并且不是在停流的情况
		else{		
			playByChannelList();//直播列表上按ok键切换直播
		}
	}else if(jumpDivIsShow && jumpPos==4){
		playByTime(currTime);//定时跳转播放
		$("seekDiv").style.display = "none";
		isSeeking = 0;
		speed = 1;
	}
	else if(jumpDivIsShow && jumpPos==2){clickJumpBtn();}
	else if(jumpDivIsShow && jumpPos==3){	
		resetHHAndMM();//重置时间//pauseOrPlay();//取消的模式
	}else{
		if(jumpDivIsShow){return;} //焦点在时和分的情况不处理
		else if("true" == getDataFlag){showChannelList();	}
	}
}	

//重置跳转框
function resetHHAndMM()
{
	jumpPos=0;
	$("jumpTimeHour").innerText="";$("jumpTimeMin").innerText="";	
	$("jumpTimeHour").className="inpon"; $("cancelJump").className="btn02";   
}

//显示直播列表
function showChannelList()
{
	setEPG();
	freeFocus(chanListFocus);
	chanListFocus = currChannelIndex;
	realCurrPage();//当前是第几页
	chanReload1();//加载数据
	setFocus(chanListFocus);
	showChannelListDiv();
	clearTimeout(channelListTimer);
	channelListTimer = setTimeout(hiddenChannelList,<%=DEFAULT_HIDEINFO_TIME%>);
}	
//获取正整数
function getInt(num)
{
	num = num + "";
	//alert("num"+num);
	var i = num.indexOf(".");
	var currpage = num.substring(0,i);
	//alert("currpage"+currpage+" rows"+rows);
	return parseInt(currpage,10);
}	
//根据索引判断当前是第几页
function realCurrPage()
{
	if(chanListFocus % rows == 0){currListPage = chanListFocus / rows;}
	else{
		//alert("realCurrPage() chanListFocus"+chanListFocus+" rows"+rows);
		/*
		if(currListPage == rows )
		{
			currListPage = totalListPages; 
		}
		else
		*/
		currListPage = getInt(chanListFocus / rows);
		//alert("realCurrPage() else currListPage"+currListPage);
	}
}	
//直播列表层显示
function showChannelListDiv()
{	
    if(jumpDivIsShow || seekDivIsShow||"false"==channelListFlag){return;}
	channelListFlag = "false";
	$("channelListDIV").style.display = "block";
	setFocus(chanListFocus);  //hwwebkit
}	
//隐藏直播OSD列表
function hiddenChannelList()
{	
	clearTimeout(channelListTimer);channelListTimer="";
	if("true"== channelListFlag ){return;}
	channelListFlag = "true";
	$("channelListDIV").style.display = "none";
	setSTB();
}	
//通过直播OSD列表播放
function playByChannelList()
{
	lockPlay = "true";
	if("true" == isNotSubFlag){clearDiv();}//清空层	
	if("true" == mediaErrorFlag){hiddenMediaError();}//清空错误层
	if(preDivIsShow){hiddenPreview();	}//清空预览提示
	var temp1 = currChannelIndex;
	var temp2 = currChannelNum;
	currChannelIndex = chanListFocus;
	currChannelNum = channelIds[chanListFocus];
	if("false" == lockPlay){currChannelIndex = temp1;currChannelNum = temp2;return;}
	isHaveLock();//如果锁存在，则直播列表一直存在	
	joinChannel(parseInt(channelNums[chanListFocus]));//播放时需要把直播列表的临时焦点赋给真正的焦点
}	
//判读是否有锁，如果有锁的话，直播列表得一直显示
function isHaveLock()
{
	if("true" == lockFlag){clearTimeout(channelListTimer);}	
	else{
		clearTimeout(channelListTimer);
		channelListTimer = setTimeout(hiddenChannelList,<%=DEFAULT_HIDEINFO_TIME%>);
	}
}
/*****************直播列表end******************************************/	
//直播号处理函数
function channelNumAction(num)
{
	// 如果机顶盒来控制,则不展示
	if (mp.getNativeUIFlag() == 1 && mp.getChannelNoUIFlag() == 1){return;}
	var tabdef = '<table width=280 height=40><tr align="center"><td style="color:#006600;font-size:28px;">';
	tabdef += num;
	tabdef += '</td></tr></table>';
	$("topframe").innerHTML=tabdef;
	//8秒钟后隐藏直播号
	clearTimeout(hideNumTimer);
	hideNumTimer = setTimeout(hideChannelNum,<%=DEFAULT_HIDEINFO_TIME%>);
}	
//隐藏直播号
function hideChannelNum()
{
	numCount = 0;
	number = 0;
	tempNumber = "";
	$("topframe").innerHTML="";
}		
var tempNumber = "";	
//输入数字切换直播
function inputNum(i)
{
	if(quitDivIsShow||"false"==getDataFlag||number * 10 >= 10000||oneKeySwitchJumpInfoIsShow||"false" == channelListFlag){return;}		
	if(bottomLineNum !=0)//不能大过下划线
	{
		clearTimeout(bottomLineHideTime);
		bottomLineHideTime = setTimeout(hideBottomLine,<%=DEFAULT_HIDEINFO_TIME%>);
		if(numCount >= bottomLineNum ){return;}
	}
	if(numCount >= 4||jumpDivIsShow||seekDivIsShow){return;}
	numCount++;
	tempNumber = tempNumber+""+i;
	number = number * 10 + i;
	channelNumAction(tempNumber);//显示界面
	clearTimeout(timeID);
	timeID = setTimeout("playByChannelNum("+ number +")", 3000);// 3秒钟之后切换直播
}	
//用户输入的直播号时的处理
function playByChannelNum(chanNum)
{
	//是否是通过下划线切换
	if(bottomLineNum !=0){
		clearTimeout(bottomLineHideTime);
		bottomLineHideTime = setTimeout(hideBottomLine,<%=DEFAULT_HIDEINFO_TIME%>);
		clearTimeout(hideNumTimer);
		hideNumTimer = setTimeout(hideChannelNum,<%=DEFAULT_HIDEINFO_TIME%>);
		if(numCount < bottomLineNum){return;}
	}
	clearTimeout(bottomLineHideTime);
	hideBottomLine();
	//输入的数字
	number = 0;
	numCount = 0;
	tempNumber="";
	updateChannelFromNum(chanNum);
}	
//数字播放
function updateChannelFromNum(chanNum)
{	
	if(chanNum == currChannelNum && "false"==isLeaveChannelFlag){return;}//判断当前输入的直播号是否是正在播放的直播	
	stopChannel();//离开上一个直播
	var returnIndex = getChanIndexByNum(chanNum);	//通过用户输入的直播号判断直播是否存在，加锁，父母控制等等	
	if(-1 == returnIndex){ channelIsNotExist(chanNum); currChannelNum = chanNum;}//-1表示直播不存在
    else{ currChannelIndex = returnIndex; currChannelNum = chanNum;joinChannel(chanNum); }
}	
//直播不存在
function channelIsNotExist(chanNum)
{
	clearTimeout(hiddenDivTimer);
	hiddenDivTimer = setTimeout(clearDiv,<%=DEFAULT_HIDEINFO_TIME%>);
	isNotSubFlag = "true";
	bg_noorder.style.display = "block";
	no_order.style.display = "block";
	$("orderInfo").innerHTML = '直播&lt;' + chanNum + '&gt;不存在';
	$("showmessage").innerHTML = "请切换到其它直播收看!";
}	
//直播未订购
function channelIsNotSub(chanNum)
{
	clearTimeout(hiddenDivTimer);
	hiddenDivTimer = setTimeout(clearDiv,<%=DEFAULT_HIDEINFO_TIME%>);
	isNotSubFlag = "true";
	bg_noorder.style.display = "block";
	no_order.style.display = "block";
	$("orderInfo").innerHTML = '您尚未订购&lt;' + chanNum + '&gt;直播';
	$("showmessage").innerHTML = "请切换到其它直播收看!";
}
//通过直播号比对出索引，判断直播是否存在
function getChanIndexByNum(chanNum)
{
	var chanIndex = -1;
	for (var i = 0; i <= totalChannel; i++){
		if (chanNum == channelNums[i]){
			chanIndex = i;
			break;
		}
	}
	return chanIndex;
}
//右键控制
function pressRight()
{
	if(quitDivIsShow){mainPressKeyRight();}
	else if(oneKeySwitchJumpInfoIsShow){commonPressKeyRight();	}
	else if(jumpDivIsShow)
	{
		if(jumpPos == 0){
			$("jumpTimeHour").className="inp";
			$("jumpTimeMin").className="inpon";
			jumpPos ++;
		}else if(jumpPos == 1){
			$("jumpTimeMin").className="inp";
			$("ensureJump").className="btn02 on2";
			jumpPos ++;
		}else if(jumpPos == 2){
			$("ensureJump").className="btn02";
			$("cancelJump").className="btn02 on2";
			jumpPos ++;
		}else if(jumpPos==4){
			 var currentTime = mp.getCurrentPlayTime();
			 var maxTime = getCurrTime2();//时移最大时间
			 var tmp2 = getShiftBeginTime2();//时移开始时间
			 count++;
			 currTime =currentTime.substring(0,8)+currentTime.substring(9,15);
			 currTime = countTime(currTime,count);
			 var value1=currTime.substring(0,4);
			 var value2=currTime.substring(4,6);
			 var value3=currTime.substring(6,8);
			 var value4=currTime.substring(8,10);
			 var value5=currTime.substring(10,12); 
			 var oldTime =value4+":"+value5+":00"
			 var temDate = value2+'/'+value3+'/'+value1+' '+oldTime;
			 var T =new Date(Date.parse(temDate));
			 var t=Date.parse(T)+28800*1000;
			 T.setTime(t);
			 var tmp1 =dataToNum(T);
			  // 规避当前时间显示小于时移开始时间的问题
			  if(tmp1 >= maxTime) { 
					count--;
					currTime = countTime(currTime,count);
					currTime = currTime.substring(0,8)+"T"+currTime.substring(8,14)+"Z"; 
			  } else {
					currTime = currTime.substring(0,8)+"T"+currTime.substring(8,14)+"Z"; 
			  }
			  clearTimeout(timeID_jumpTime);
			  timeID_jumpTime = "";
			  isJumpTime = 0;
			  processSeek(currTime);
		}
		return false;
	}
	else{volumeUp();}
}
//左键控制，一键跳转层
function pressLeft()
{	
	if(quitDivIsShow){mainPressKeyLeft();}
	else if(oneKeySwitchJumpInfoIsShow){commonPressKeyLeft();}
	else if(jumpDivIsShow)
	{
			if(jumpPos == 1){
				$("jumpTimeMin").className="inp";
				$("jumpTimeHour").className="inpon";
				jumpPos --;
			}else if(jumpPos == 2){
				$("ensureJump").className="btn02";
				$("jumpTimeMin").className="inpon";
				jumpPos --;
			}else if(jumpPos == 3){
				$("cancelJump").className="btn02";
				$("ensureJump").className="btn02 on2";
				jumpPos --;
			}else if(jumpPos==4){
				 var currentTime = mp.getCurrentPlayTime();
				 var maxTime = getCurrTime2();//时移最大时间	
				 var tmp2 = getShiftBeginTime2();//时移开始时间
				 count--;
				 currTime =currentTime.substring(0,8)+currentTime.substring(9,15);
				 currTime = countTime(currTime,count);
				 var value1=currTime.substring(0,4);
				 var value2=currTime.substring(4,6);
				 var value3=currTime.substring(6,8);
				 var value4=currTime.substring(8,10);
				 var value5=currTime.substring(10,12); 
				 var oldTime =value4+":"+value5+":00"
				 var temDate = value2+'/'+value3+'/'+value1+' '+oldTime;
				 var T =new Date(Date.parse(temDate));
				 var t=Date.parse(T)+28800*1000;
				 T.setTime(t);
				 var tmp1 =dataToNum(T);
				if (tmp1 <= tmp2){
					count++;
					currTime = countTime(currTime,count);
					currTime = currTime.substring(0,8)+"T"+currTime.substring(8,14)+"Z";
				}else{
					currTime = currTime.substring(0,8)+"T"+currTime.substring(8,14)+"Z";
				}
				clearTimeout(timeID_jumpTime);
				timeID_jumpTime = "";
				isJumpTime = 0;	
				processSeek(currTime);
			}
		return false;
	}
	else{volumeDown();}
}
function countTime(currTime,count)
{
   var startTime =currTime;
   var d = new Date();
   var value1=startTime.substring(0,4);
   var value2=startTime.substring(4,6);
   var value3=startTime.substring(6,8);
   var value4=startTime.substring(8,10);
   var value5=startTime.substring(10,12); 
   var oldTime =value4+":"+value5+":00"
   var temDate = value2+'/'+value3+'/'+value1+' '+oldTime;
   var T =new Date(Date.parse(temDate));
   var t=Date.parse(T)+60*count*1000;   
	   T.setTime(t);
   var endTime =dataToNum(T);
   return endTime;
}
function dataToNum(d)
{
	var result ;
	var h=d.getHours();
	var m=d.getMinutes();
	var s=d.getSeconds();
	var y=d.getYear();
	var M=d.getMonth()+1;
	var day=d.getDate();
	if(m<10){ m='0'+m;}
	else{m=""+m; }
	if(h<10){h='0'+h;}
	else{h=""+h;  }
	if(s<10){s='0'+s;}
	else{s=""+s;}
	if(M<10){M='0'+M;}
	else{M=""+M; }
	if(day<10){day='0'+day;}
	else{day=""+day;  }
	y =""+y;
	result =y+M+day+h+m+s;
	return result;
}
function mainPressKeyRight()
{
	if(positionFlag == 0)
	{
		positionFlag++;
		$("cancel").focus();
		return;
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
/*******************显示直播下划线 Begin***************************/
//显示下划线
var bottomLineNum = 0;
var numCount = 0;
var bottomLineAllNum = 3;
var bottomLineHideTime = "";
function showBottomLine()
{
	//如果一键跳转层显示，不能切直播||如果有直播列表存在，不能切
	if(oneKeySwitchJumpInfoIsShow||"false" == channelListFlag){return;}
	if(hideNumTimer != ""){ clearTimeout(hideNumTimer);		}
	clearTimeout(hideNumTimer);
	hideChannelNum();
	if(bottomLineHideTime != ""){clearTimeout(bottomLineHideTime);}
	if(bottomLineNum < bottomLineAllNum){bottomLineNum++;}
	else{bottomLineNum = 0;}
	var strBottom = '<table width=200 height=30><tr align="right"><td><font color="green" size="20"  height="10" style="font-weight:400">';
	for(var i = 0; i < bottomLineNum; i++){strBottom += '_';}
	strBottom += '</font></td></tr></table>';
	$("topframe_bottomLine").innerHTML = strBottom;
	clearTimeout(bottomLineHideTime);
	bottomLineHideTime = setTimeout(hideBottomLine,<%=DEFAULT_HIDEINFO_TIME%>);
}
//隐藏直播下划线
function hideBottomLine()
{	
	bottomLineNum = 0;
	numCount = 0;
	$("topframe_bottomLine").innerHTML = "";
}
/******************************显示直播下划线 End**********************************/
//预览层是否显示
var preDivIsShow = false; 	
//预览次数
function previewTimes()
{		
	if("true" == isNotSubFlag){clearDiv();}//清空层	
	if("true" == lockFlag){hiddenLockInfo();}//清空锁控制层	
	if("true" == mediaErrorFlag){hiddenMediaError();}//清空错误层
	mp.leaveChannel();
	isLeaveChannelFlag = "true";
	previewInfo.style.display = "block";
	preview.style.display = "block";
	//$("showPreviewInfo").innerText = "您的预览次数已到，已无法继续观看此直播，您可以选择其他直播继续观看，或按&lt;返回&gt;键退出！";
	preDivIsShow = true;
}
//预览时间
function previewTime()
{		
	if("true" == isNotSubFlag){clearDiv();}//清空层	
	if("true" == lockFlag){hiddenLockInfo();}//清空锁控制层	
	if("true" == mediaErrorFlag){hiddenMediaError();}//清空错误层
	mp.leaveChannel();
	isLeaveChannelFlag = "true";
	previewInfo.style.display = "block";
	preview.style.display = "block";
	//$("showPreviewInfo").innerText = "预览时间到，您可以选择其他直播继续观看，或按&lt;返回&gt;键退出！";
	preDivIsShow =  true;
}
//隐藏预览提示信息
function hiddenPreview()
{
	/*$("preview").style.display = "none";
	$("previewInfo").style.display = "none";
	preDivIsShow = false;*/
}
//页面退出的时候无条件执行
function destoryMP()
{
	stopChannel();
}
//错误提示函数
function mediaError(eventJson)
{
	var type = eventJson.error_code;
	if(10 == type){showMediaError();}
}
//显示错误信息
function showMediaError()
{	
	if("false" == channelListFlag){hiddenChannelList();}//如果直播列表存在，先去掉直播列表	
	if(oneKeySwitchJumpInfoIsShow){hideOneKeySwitchJumpInfo();}//如果一键跳转层显示，就先退出层
	if(preDivIsShow){hiddenPreview();	}//清空预览提示
	if("true" == isNotSubFlag){clearDiv();}//清空层	
	if("true" == lockFlag){hiddenLockInfo();}//清空锁控制层
	if(jumpDivIsShow){hideJumpTimeDiv();}
	if(volumeDivIsShow){hideBottom();}
	if(seekDivIsShow){$("seekDiv").style.display = "none";}
	mediaErrorFlag = "true";
	$("errorDiv").style.display = "block";
	$("errorBackGround").style.display = "block";
}
//隐藏错误提示信息
function hiddenMediaError()
{
	mediaErrorFlag = "false";
	$("errorDiv").style.display = "none";
	$("errorBackGround").style.display = "none";
}
function stbNoChannel()
{
    if("3"==comeType){stbNoThisChannel(currChannelNum);}//数字键进来的
	else if("true"==getDataFlag){stbNoThisChannel(channelNums[currChannelIndex]);}
	else{stbNoThisChannel(currChannelNum);}	
	
}	
//直播列表存在，但是机顶盒中不存在
function stbNoThisChannel(chanNum)
{
	clearTimeout(showTimer);
	isNotSubFlag = "true";
	bg_noorder.style.display = "block";
	no_order.style.display = "block";
	$("orderInfo").innerHTML = '直播&lt;' + chanNum + '&gt;暂时不能播放';
	$("showmessage").innerHTML = "";//"请重启机顶盒更新直播列表或切换到其他直播!";
}	
//清除断流错误提示
function resumeMediaError(eventJson)
{
	var type_new_play = eventJson.new_play_mode;
	var type_old_play = eventJson.old_play_mode;
	if(2 == type_new_play && 0 == type_old_play)
	{
		hiddenMediaError();
		mp.resume();
		$("seekDiv").style.display = "none";
		isSeeking = 0;
		speed = 1;
		jumpDivIsShow = false;
		seekDivIsShow = false;
		playStat = "play";
	}
	//如果是暂停状态
	if(1 != type_new_play)
	{
		//一键跳转到其他直播
		if(oneKeySwitchJumpInfoIsShow){hideOneKeySwitchJumpInfo();	}
		if(seekDivIsShow && type_new_play == 2 )
		{
			$("seekDiv").style.display = "none";
			isSeeking = 0;
			speed = 1;
			jumpDivIsShow = false;
			seekDivIsShow = false;
			playStat = "play";
		}
	}
}	
function formatDate(dateobj)
{
	var year = dateobj.getYear();
	var month = dateobj.getMonth() + 1;
	var day = dateobj.getDate();
	var hour = dateobj.getHours();
	var min = dateobj.getMinutes();
	var sec = dateobj.getSeconds();
	if (month < 10){month = "0" + month;}
	if (day < 10){day = "0" + day;}
	if (hour < 10){hour = "0" + hour;}
	if (min < 10){min = "0" + min;}
	if (sec < 10){sec = "0" + sec;}
	var dateStr = "" + year  + month  + day + hour  + min  + sec;
	return dateStr;
}
function $(strId)
{
	return document.getElementById(strId);
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
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="transparent" onLoad="javascript:init();" onUnload="destoryMP();"  style="background:transparent;">
<!--ztewebkit
<div style="width:1px; height:1px; top:1px; left:1px;">
<a id="currentTime" href="#" style="width:1px; height:1px; top:-1px; left:-1px;"><img src="../images/dot.gif" width="1" height="1"/></a>
</div>
-->

<%--直播节目单OSD---------ztewebkit---------------------------------%>
<div id="filmInfo1" style="position:absolute; left:420px; top:0px; width:360px; height:530px;z-index:3;display:none;">
  <iframe name="miniInfo" id="miniInfo" src="" scroll="no" height="530px"></iframe>
</div>
<div id="bottomframe" style="position:absolute;left:60px; top:330px; width:600px; height:190px; z-index:1"></div>


<%--按暂停键后出现的模块begin-------------------------------%>
<div id="seekDiv" class="play-page" style="position:absolute;width:640px;height:150px;left:5px;top:400px; z-index:1;display:none">
    <div id="statusImg" class="key" style="top:22px; left:10px;"></div>
    <div id="beginTime" class="timeline" style="left:88px;">00:00:00</div>
    <div id="speed" style="position:absolute;width:60px;height:23px;left:40px;top:17px; z-index:2;"></div>
    <div id="timeError" style="position:absolute;width:220px;height:23px;left:65px;top:42px; z-index:2;font-size:18px;color:#FF3"></div>
    <div class="progress-bar" style="left:168px;">
        <div id="currentTime_progress" class="baron"> <!--当前为 class="bar"；选中为 class="baron";-->
            <div id="td_0" class="b1"></div>
            <div id="td_1" class="b2" style="width:360px;"></div> <!--总宽度为11（b1为固定宽）+360px-->				
            <div id="currTimeShow" style="top:30px;left:150px;">01:40:20</div>
        </div>
    </div>
    <div id="fullTime" class="timeline" style="left:540px;">02:00:22</div>		
    <div class="set-time"  id="jumpTimeDiv">
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




<!--直播未定购显示-->
<div id="bg_noorder" style="position:absolute; right:150;top:50px; width:350px; height:135px; display:none">  </div>

<div id="no_order" style="position:absolute; right:150;top:50px; width:350px; height:135px; display:none">
  <table width="340px" height="135px" border="0">
    <tr>
      <td  height="40"></td>
    </tr>
    <tr>
      <td id="orderInfo" width="340px" align="center"></td>
    </tr>
    <tr>
      <td id="showmessage" width="340px" align="center"></td>
    </tr>
    <tr>
      <td  height="40"></td>
    </tr>
  </table>
</div>

<%--直播左边OSD列表div-begin-----------------------%>
<div id="channelListDIV"  style="display:none" class="live-item">
   <div id="chan_info" class="con"></div>
</div>
<%--直播OSD列表div- end-------------------------%>

<!--右上方时移图标-->
	<div id="shift" style="display:none;" class="btn-operate"><img src="../images/play/icon-time-shifting.gif" /></div>
<!--右上方时移图标-->

<!--音量键-->
<div id="volumeDiv" class="volume" style="display:none;">
    <div style="width:320px;"><div id="volumeLen" class="on" style="width:0%;"></div></div> <!--总宽度为320px;也可以用100%-->
    <div id="volumeCur" style="left:380px;"></div>
</div>
<!--音量键-->

<%--数据封装------ztewebkit----------%>
<div id="filmInfoDB">
  <iframe name="filmInfo" id="filmInfo" src="" scroll="no" height="0px" width="0px"></iframe>
</div>

<!-- 右上显示直播号-->
<div id="topframe" style="position:absolute;left:180px; top:8px; width:200px; height:30px; z-index:1"></div>
<div id="topframe_bottomLine" style="position:absolute;left:475px; top:10px; width:200px; height:30px; z-index:2"></div>
<!--预览提示信息-->
<div id="preview" style="position:absolute;left:250px; top:60px; width:350px; height:135px; z-index:-1; display:none;"> 
<img src="images/playcontrol/playChannel/noOrder.jpg" border="0" width="350px" height="135px" /> </div>
<div id="previewInfo" style="position:absolute;left:250px; top:60px; width:350px; height:135px; z-index:-1; display:none;">
  <table width="350" height="135px" border="0">
    <tr>
      <td id="showPreviewInfo" width="350" align="center"></td>
    </tr>
  </table>
</div>
<div id="errorBackGround" style="position:absolute; left:150x; top:100px; width:350px; height:80px; z-index:-1; display:none">
 <img src="images/playcontrol/bg-seek.gif" border="0" width="350px" height="80"> </div>
<!--系统错误提示-->
<div id="errorDiv" style="position:absolute; left:120px; top:315px; width:400px; height:70px; z-index:1;display:none">
<img src="images/playcontrol/playChannel/jumpDivBack.gif" width="400px" height="70px"/> </div>
<div id="errorDiv" style="position:absolute; left:120px; top:315px; width:400px; height:80px; z-index:1;display:none">
  <table width="400px" height="80" border="0">
    <tr>
      <td width="400px" align="center">系统错误，请切换直播或稍候再试！</td>
    </tr>
  </table>
</div>
<div style="position:absolute; left:15px; top:15px; width:54px; height:66px; z-index:3;"><img id="voice" src="images/dot.gif"/></div>

<div style="visibility:hidden;">
<img src ="../images/play/icon-time-shifting.gif"/>
<img src ="../images/play/volume-bgon.jpg"/>
<img src ="../images/t.gif"/>
<img src ="../images/live-pop-bg.png"/>
<img src ="../images/play/icon-fast-return.png"/>
<img src ="../images/play/icon-fast-enter.png"/>
<img src ="../images/play/play-page-bg.png">
<img src ="../images/play/progress-barbg.png">
<img src ="../images/play/progress-bar.png">
<img src ="../images/play/progress-baron.png">
<img src ="../images/play/progress-barbg2.png">
<img src ="../images/play/progress-bar-l.png">
<img src ="../images/play/progress-baron-l.png">
<img src ="../images/play/volume-bg.png">
<img src ="../images/play/btn-pause.png">
</div>
</body>
</html>
