<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="com.huawei.iptvmw.epg.facade.metadata.CommonImpl" %>
<%@ page import="com.huawei.iptvmw.epg.util.xml.DateUtilities" %>
<%@ page import="java.util.*" %>
<%@ include file="keyboard/keydefine.jsp" %>
<%@ include file="config/config_playControl.jsp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%!
private static int ROWS = 4;               //的行数（每页）
private static int COLS = 1;				//显示的列数（每页）
private static int PAGEITEMS = ROWS*COLS;	//显示的数量（每页）
%>
<%
TurnPage turnPage = new TurnPage(request);
ServiceHelp serviceHelp = new ServiceHelp(request);
//String goBackUrl = turnPage.go(-1);
String goBackUrl = "index.jsp";
String strProgId = request.getParameter("PROGID");
String strIsPerview = request.getParameter("PREVIEWFLAG");//预览标识；1:支持 0:不支持
String strChannelNum = request.getParameter("CHANNELNUM");
String comeType = request.getParameter("COMEFROMFLAG");
String strIsSub = request.getParameter("ISSUB"); //是否订购
int isfromgat = request.getParameter("isfromgat")==null?0:Integer.parseInt(request.getParameter("isfromgat"));
int currChannelIndex = request.getParameter("currChannelIndex")==null?0:Integer.parseInt(request.getParameter("currChannelIndex"));
int chanListFocus = request.getParameter("chanListFocus")==null?0:Integer.parseInt(request.getParameter("chanListFocus"));


//System.out.println("default-------------------------issubscribe"+strIsSub);
String strBackUrl = request.getParameter("returnurl");//vas方式的返回
String locktimeStamp = "";//解锁验证页面使用
locktimeStamp = StringDateUtil.getTodaytimeString("yyyyMMddhhmmss");
String _userid = (String)session.getAttribute("USERID");
if (_userid == null){
	_userid = "-1";
}
//判读是否从vas过来
if(null != strBackUrl && ! "".equals(strBackUrl))
{
	goBackUrl = strBackUrl;
}
int iShowDelayTime = 8000;//miniepg展示时间通过接口获取
//获取加密方式,中间件业务密码的加密方式 0：163 MD5加密 1：IPTV MD5加密
int encryptMode = 0;
// 获取加密方式,中间件业务密码的加密方式 0：163 MD5加密 1：IPTV MD5加密
CommonImpl commonImpl = new CommonImpl(request);
encryptMode = commonImpl.getSystemParam().getEncryptMode();
//用户ID
String userId = (String) session.getAttribute("USERID");
String timeStamp = DateUtilities.getCurrDate() ;
int itype = 0;
String type=request.getParameter("ECTYPE");
if(type != null && type !="" && type != "null")
{	
	itype=Integer.parseInt(type);
}
MetaData metaData = new MetaData(request);
String HDintroduce = "";
HashMap HDinfomap = metaData.getTypeInfoByTypeId("10000100000000090000000000031910"); //过滤频道
if(HDinfomap!=null){
	HDintroduce = (String)HDinfomap.get("TYPE_INTRODUCE");
}
String allIntroduce = HDintroduce;
String[] strarray = allIntroduce.split("@");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>play_Controlchannel</title>
<meta name="page-view-size" content="1280*720" />
<style type="text/css">
.channel_msg{ position:absolute;top:0px; right:0px; background:url(images/channel_OSD_rbg.png) repeat-y; width:360px; height:720px; padding-left:0px; line-height:46px;}
.channel_msg div.title{ font-size:30px; padding:60px 0 10px 50px;}
.channel_msg div.mar{ width:360px; height:46px; color:#FFF; font-size:26px;padding-left:50px;}
.channel_msg div.line {text-align:right;}
</style>
<style type="text/css">
body { font-family:"黑体"; font-size:30px; color:#FFFFFF;margin:0px;padding:0px;width:1280px; height:720px}
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,p,th,td {margin:0; padding:0}
img {border:0; margin:0}
table{border:0;*border-collapse:collapse; border-spacing:0}
body td{font-family:"黑体";font-size: 26px;color: white;}
#no_order {font-family:"黑体";position: absolute;height: 146px;width: 363px;top: 100px;left: 250px;display: none;}
#chan_page {font-family:"黑体";position: absolute;height: 20px;width: 40px;top: 398px;left: 168px;font-size: 24px;color:#FFFFFF;	}
.channel_choose{ position:absolute;left:0px top:0; background:url(images/playerimages/channel_OSD_lbg.png) repeat-y; width:405px; height:720px;}
.sub{ height:46px; line-height:46px; padding-left:35px}
.on{ background:url(images/playerimages/channel_sub2on.png) no-repeat;padding-left:35px; height:46px;;line-height:46px; }

/*control_panel*/
.control_load{ position:absolute; top:25px; right:35px}
.control_panel{ position:absolute; top:483px; background:url(images/playerimages/control_bbg.png) repeat-x; width:1280px; height:237px; z-index:7}
/*修改遮字幕问题，20131015*/
.control_panel3{ position:absolute; top:446px; background:url(images/playerimages/control_bbg3.png) repeat-x; width:1280px; height:100px; z-index:7}
.control_panel .playing_time{ position:absolute; top:45px; left:565px; width:150px; text-align:center}
.control_panel .fasttime{ position:absolute; top:45px; right:115px}
.control_panel .time1{ position:absolute; top:120px; left:40px; width:130px; text-align:right}
.control_panel .time2{ position:absolute; top:120px; right:40px; width:130px}
.control_panel .time11{ position:absolute; top:69px; left:40px; width:130px; text-align:right}
.control_panel .time22{ position:absolute; top:69px; right:40px; width:130px}
.control_panel .progressbar{ position:absolute; top:137px; left:170px}
.control_panel .progressbar2{ position:absolute;top:80px; left:190px}
.control_panel .bar{ position:absolute; top:128px; left:190px}

.control_panel .bar2,.control_panel .bar3 { position:absolute; top:70px; left:190px; height:32px; padding-right:12px}
.control_panel .bar2{ background:url(images/playerimages/progressbar.png) right no-repeat;}
.control_panel .bar3{ background:url(images/playerimages/progressbar02.png) right no-repeat;}

.control_panel2{ position:absolute; top:618px; background:url(images/playerimages/control_bbg2.png) repeat-x; width:1280px; height:102px; z-index:8}
.enter_time{ position:absolute; top:32px; left:140px; width:550px; line-height:50px}
.enter_time div{ position:absolute; top:0; left:0}
.enter_time div.e1{ left:210px}
.enter_time div.e2{ left:320px}
.enter_time div.e3{ left:370px}
.enter_time div.e4{ left:480px}
.enter_time .inp{ background-color:#646464; border:solid 1px #000; color:#FFF; font-size:36px; width:90px; height:48px; line-height:48px; text-align:center;}
.enter_time .inp-focus { border:solid 3px #FFFF00;width:86px; height:44px; line-height:44px;text-align:center;}
	
.btns{ position:absolute; top:40px; left:800px}
.btns div {height:39px;line-height:39px;left:0;position:absolute;top:0;text-align:center;width:151px; }
.btns div.btnon{ background:url(images/playerimages/btn_bg.png) no-repeat}
.btns div.btnoff{ }

/* left ----------------------------------------------- */

.item, .link, .txt-wrap, .txt, .btn, .icon, .pic, .cover, .num, .win { 
	left: 0;
	position:absolute;
	top: 0;
}

.wrapper {
	left: 0;
	position: absolute;
	top: 0;
    height: 720px;
    width: 1280px;
    background: transparent;
    /*overflow: hidden;*/
    position: relative;
}
.logo {
	left:13px;
	position:absolute; 
	top:203px; 
}
.btn { text-align: center;}
.hd-left {
	background:url(images/left-bg.png) repeat;
	left:0;
	position:absolute; 
	top:0; 
	height:720px;
	width:280px;
}
.nav {
	left:0;
	position:absolute; 
	top:259px; 
}
.nav .item {
	background:url(images/nav-bg01.png) no-repeat;
	height:63px;
	width:230px;
	z-index:5;
}
.nav .item .txt {
	color:#908f8d;
	left:10px;
	text-align:center;
	line-height:42px;
	top:13px;
	height:42px;
	width:206px;
}
.nav .item_focus {
	background:url(images/nav-bg01_focus.png) no-repeat;
	z-index:6;
}
.nav .item_focus .txt { 
	color:#fff;
	font-size:27px;
	line-height:46px;
	left:42px;
	top:7px;
	height:46px;
	width:155px;
}
.nav .btn {
	background:url(images/nav-bg02.png) no-repeat;
	color:#000;
	left:220px;
	top:13px;
	text-align:center;
	line-height:36px;
	height:36px;
	width:60px;
	z-index:4;
}
.poster  {
	left:3px;
	position:absolute; 
	top:503px; 
}
.poster .item {
	height:98px;
	width:210px;
}
.poster .item .pic {
	left:3px;
	top:3px;
}
.poster .item .pic,
.poster .item .pic img {
	height:92px;
	width:204px;
}
.poster .item_focus {
	background:url(images/list-pic01_focus.png) no-repeat;
}

/* list ------------------------------------------------*/
.list {
	background:url(images/list-bg.png) no-repeat;
	left:0px;
	position:absolute;
	top:0px;
	height:240px;
	width:425px;
}
.list .txt {
	color:#ababab;
	left:65px;
	top:65px;
	width:315px;
}
.list .txt-on {
	color:#fff;
	font-size:34px;
}
</style>

</head>
<script language="javascript">
var markArray = new  Array();//用来存放过滤的数据
<%
	for(int i = 0;i < strarray.length;i++){
%>
		markArray[<%=i %>] = "<%=strarray[i] %>";
<%
	}
%>
if (typeof(iPanel) != 'undefined')
{
	iPanel.focusWidth = "4";iPanel.defaultFocusColor = "#FCFF05";
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
var currChannelIndex = <%=currChannelIndex%>;//当前索引
var chanListFocus = <%=chanListFocus%>;//直播列表的当前索引1-
var totalChannel = 0;//直播总个数
var infoFlag = "false";//miniEPG标识位
var showTimer = -1;//显示计时器
var hiddenTimer = -1;//隐藏计时器
var isControlChanIndex = -1; //当输入的直播号是受限制的直播号 记录当前索引  
var lockPlay = "true";//加锁播放标志
var rows = <%=ROWS%>;//行数
var cols = <%=COLS%>;//列数
var page_items = rows*cols;//总页数
var channelListFlag = "true";//直播列表显示/隐藏标识
var channelListPlayFlag = "true";//直播列表播放标识
var currListPage = 0;//直播列表当前页
var totalListPages = 0;//直播列表总页数
var channelListTimer="";//直播列表计时器
var hideNumTimer = "";//直播号清空计时器
var number = 0;//数字切换直播
var timeID = "";//数字键跳转计时器
var lockTimer = "";//加锁层隐藏计时器
var hiddenDiv = "";//层隐藏计时器
var lockFlag = "false";//锁控制标志位 false--解锁层不存在
var mediaErrorFlag = "false";//系统错误提示
var pr2 = null;//直播统计
var live_type = "live";  //直播业务
var back_type = "back";//直播回看业务
var business_type = live_type; //当前的业务类型 live_type直播状态 back_type时移状态
var shiftQuitFlag = 0;//时移上报退出标志位
var isNotSubFlag = "false";//未订购层标志位
var showFilmInfoFlag = "false";//miniepg数据获取标志位
var isLeaveChannelFlag = "false";//断流标志位 如果==false 说明正常播放，未授权提示得自动消失 ,== true 说明没流未授权等提示要一直存在
var getDataFlag = "false";//子页面获取数据标志位
/************************begin****************************/
var channelIds = new Array();//直播id号
var channelNames = new Array();	//直播名称
var channelNums = new Array();//直播号
var channelNumsShow = new Array();//用来显示的直播号数组
var isSub = new Array();//是否授权
var pltvStatus = new Array();//是否是时移直播
var channelUrls = new Array();//授权通过的URL链
var isLock = new Array();//是否加锁
//提示信息计时器
var tempShowMsgTimer = "";
var isControlled = new Array();//是否有父母控制
var channelCode = new Array();//直播的MediaCode
var isSubPreview = new Array();//是否支持预览
var isTvod = new Array();//是否支持回放
var upPageToLastIndex = false ;//按向上键到前一面的最后一条数据
var positionFlag = 0; //记录页面焦点位置
var quitDivIsShow = false; //退出层是否显示标志位
var seekDivIsShow = false;//进度条及跳转框
var volumeDivIsShow = false;//音量层
var STBType =Authentication.CTCGetConfig("STBType");
var isSeeking = 0;
var seekDIvPos = 4;//4:进度条 0：时 1:分 2：跳转 3：取消
var speed = 1;
var playStat = "play";
var timeID_jumpTime = "";
var currTime = 0;
var mediaTime = 0;
var timePerCell = mediaTime / 100;
var currCellCount = 0;
var preInputValueHour = "";//上一次检测时，文本框中的值
var preInputValueMin = "";
var volume = 20;
var bottomTimer = "";
var shiftFlag = 0;    // 时移标志位 1:进入时移
var timeID_check = 0;
var premode; //记录上次mod是否为3 
var voiceflag="";
var voiceIsShow=false;
var mp = new MediaPlayer();
var strchannelNum='<%=strChannelNum%>';
var chennelNum=parseInt(strchannelNum);

                
				
				
				
var tuiJianDate = new Array();


function $(strId)
{
	return document.getElementById(strId);
}
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
	loadData();   //alert(currChannelIndex+"---"+isSubSingle);
	genSeekTable();
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
		case <%=KEY_0%>:if(seekDivIsShow){showInputTime(0);}else {inputNum(0);}return false;break;
		case <%=KEY_1%>:if(seekDivIsShow){showInputTime(1);}else {inputNum(1);}return false;break;
		case <%=KEY_2%>:if(seekDivIsShow){showInputTime(2);}else {inputNum(2);}return false;break;
		case <%=KEY_3%>:if(seekDivIsShow){showInputTime(3);}else {inputNum(3);}return false;break;
		case <%=KEY_4%>:if(seekDivIsShow){showInputTime(4);}else {inputNum(4);}return false;break;
		case <%=KEY_5%>:if(seekDivIsShow){showInputTime(5);}else {inputNum(5);}return false;break;
		case <%=KEY_6%>:if(seekDivIsShow){showInputTime(6);}else {inputNum(6);}return false;break;
		case <%=KEY_7%>:if(seekDivIsShow){showInputTime(7);}else {inputNum(7);}return false;break;
		case <%=KEY_8%>:if(seekDivIsShow){showInputTime(8);}else {inputNum(8);}return false;break;
		case <%=KEY_9%>:if(seekDivIsShow){showInputTime(9);}else {inputNum(9);}return false;break;
		case <%=KEY_CHANNEL_UP%>:addChannel(); break;//加直播
		case <%=KEY_CHANNEL_DOWN%>:decChannel();break;//减直播
		case <%=KEY_RIGHT%>:pressRight();break;
		case <%=KEY_LEFT%>:pressLeft();break;
		case <%=KEY_DOWN%>:arrowDown();return false;	
		case <%=KEY_UP%>:arrowUp();return false;
		case <%=KEY_PAGEDOWN%>:pageDown();return false;break;
		case <%=KEY_PAGEUP%>:pageUp();return false;break;
		case <%=KEY_VOL_UP%>:volumeUp();return false; 
		case <%=KEY_VOL_DOWN%>:volumeDown();return false;
		case <%=KEY_MUTE%>:setMuteFlag();return false; //静音键
		case <%=KEY_STOP%>:stopKey();break;
		case <%=KEY_RETURN%>:pressReturn();break;//返回键
		case <%=KEY_GO_BEGINNING%>:break;			
		case <%=KEY_OK%>:pressOK();return false;break;
		case <%=KEY_IPTV_EVENT%>:goUtility();break;
		case <%=KEY_SWITCH%>:break;//喜爱键			
		case <%=KEY_INFO%>:
		case <%=KEY_BLUE%>:
		case <%=KEY_INFO_URL%>:
			  shwoFilmInfo();break;//信息键
		case <%=KEY_PAUSE_PLAY%>:
		case <%=KEY_POS%>:
			  pauseOrPlay();return false;
		case <%=KEY_PREVIEWTIMES%> :previewTimes();break;//预览次数	
		case <%=KEY_FAST_FORWARD%>:fastForward();return false;
		case <%=KEY_FAST_REWIND%>:fastRewind();return false; 
		case <%=KEY_PREVIEWTIME%> :previewTime();break;//预览时间	
		case <%=KEY_STBNOCHANNEL%>:stbNoChannel();break;
		case <%=KEY_TRACK%>: changeAudio();  break;
	   case 277:
	   case  1109:
			mp.stop();window.location.href="dibbling.jsp"; return 0;	   
	   case 276:
	   case 1110:
			mp.stop();window.location.href="playback.jsp";return 0;
		case 275:
		case 1108:
		    mp.stop(); window.location.href="channel.jsp"; return 0;
		case 1111://通信
			return 0;
		//case 278://蓝色键信息
		 	//shwoFilmInfo();break;//信息键
		default:
			return videoControl(keyval);
	}
	return true;
}
//20120330修改为div以及自动跳转
function showInputTime(id){
	var bufInput = "";	
    if(0==seekDIvPos){
    	bufInput = $("hour").innerHTML;
        if(bufInput.length<2){ 
			$("hour").innerHTML = bufInput+id;
			if(2==($("hour").innerHTML).length){;pressRight();}
		}
    }else if(1==seekDIvPos){
        bufInput = $("minute").innerHTML;
        if(bufInput.length<2){
			$("minute").innerHTML = bufInput+id;
			if(2==($("minute").innerHTML).length){pressRight();}
		}       	
    }
}
//20120330修改删除输入的时间数字
function delInputTime()
{
    if(0==seekDIvPos){
		$("hour").innerHTML = "";
    }else if(1==seekDIvPos){
		$("minute").innerHTML = "";
    }
}
function pressReturn()
{
	if(seekDivIsShow){
		if(0==seekDIvPos || 1==seekDIvPos){
			delInputTime();return 0;
		}else{
			displaySeekTable();resume();
		}
	}
	if(business_type == back_type){goEnd();}
	else{quit();}
}
function changeAudio()
{
	mp.switchAudioChannel();
	var audio = mp.getCurrentAudioChannel();
	if(audio=="0" || audio=="Left"){audio=0;}
	else if(audio=="1" ||  audio=="Right"){audio=1;	}
	else if(audio=="2" ||  audio=="JointStereo" || audio=="Stereo" ){audio=2;}
	if(voiceflag){clearTimeout(voiceflag);}
	switch(audio)
	{
		case 0:$("voice").src="images/playerimages/leftvoice.png";break;
		case 1:$("voice").src="images/playerimages/rightvoice.png";break;
		case 2:$("voice").src="images/playerimages/centervoice.png";break;
		default:break;
	}
	voiceflag = setTimeout(function(){$("voice").src="images/dot.gif";},5000);
}
function setMuteFlag()
{
	if(mediaErrorFlag == "true" || lockFlag == "true" || isNotSubFlag == "true"){return;}
	if("false" == channelListFlag){clearTimeout(channelListTimer);hiddenChannelList();}
	if(showTimer){clearTimeout(showTimer);}
	if(bottomTimer){clearTimeout(bottomTimer);}
	voiceIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){
		mp.setMuteFlag(0);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
		{
			$("voice").src="images/playcontrol/playChannel/muteoff.png";
			bottomTimer = setTimeout(hideMute, 5000);
		}
	}else{
		mp.setMuteFlag(1);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
		{
			$("voice").src="images/playcontrol/playChannel/muteon.png";
		}
	} 
	if(volumeDivIsShow){hideBottom();}    
}
function hideMute()
{
	$("voice").src = "#";
	voiceIsShow = false;
}


/**
*按遥控器的退出键
*/
function quit()
{
	//如果是在回放的情况就现退回到直播的状态 20120513修改
	if(business_type == back_type){business_type = live_type;mp.gotoEnd();return;}
	//如果直播列表存在，先去掉直播列表
	if("false" == channelListFlag){clearTimeout(channelListTimer);hiddenChannelList();return;}
	if(infoFlag == "true"){hiddenFilmInfo();return;}
	else {goBack();}
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
	if(quitDivIsShow == false){return;}
	var quitDiv = $("quitDiv");
	quitDiv.style.display = "none";
	quitDivIsShow = false;
}
function volumeDown()
{	
	if(mediaErrorFlag == "true" || lockFlag == "true" || isNotSubFlag == "true" ){return;}
	if("false" == channelListFlag){clearTimeout(channelListTimer);hiddenChannelList();}
	if(seekDivIsShow)
	{
		seekDivIsShow=false;
		displaySeekTable();
		if(playStat!= "play"){resume();}
	}
	clearTimeout(showTimer);
	showTimer = "";
	volumeDivIsShow = true;
	if ("true" == infoFlag){hiddenFilmInfo();}
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){mp.setMuteFlag(0);}
	if(voiceIsShow){hideMute();}
	volume = mp.getVolume();
	volume -= 5;	
	if(volume < 0){volume = 0;}
	mp.setVolume(volume);  
	if(mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
	{
		clearTimeout(bottomTimer);
		bottomTimer = "";
		genVolumeTable(volume);
		bottomTimer = setTimeout(hideBottom, 5000);
	}
}
//音量控制
function volumeUp()
{
	if(mediaErrorFlag == "true" || lockFlag == "true" || isNotSubFlag == "true"){return;}
	if("false" == channelListFlag){clearTimeout(channelListTimer);hiddenChannelList();}
	if(seekDivIsShow){
		seekDivIsShow=false;
		displaySeekTable();
		if(playStat!= "play"){resume();}
	}
	if(showTimer){clearTimeout(showTimer);}
	volumeDivIsShow = true;
	if ("true" == infoFlag){hiddenFilmInfo();}
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){mp.setMuteFlag(0);}
	if(voiceIsShow){hideMute();}
	volume = mp.getVolume(); 
	volume += 5;
	if(volume > 100){volume = 100;}
	mp.setVolume(volume);  
	if(mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
	{
		if(bottomTimer){clearTimeout(bottomTimer);}
		genVolumeTable(volume);
		bottomTimer = setTimeout(hideBottom, 5000);
	}
}
function hideBottom()
{
	$("bottomframe").innerHTML = "";
	volumeDivIsShow = false;
}
function genVolumeTable(volume)
{
	var tableDef = '<table width="980px" border="0" cellpadding="0" cellspacing="0"><tr>';
	volume = parseInt(volume / 5);
	for (i = 0; i < 40; i++)
	{
		if (i % 2 == 0)
		{
			tableDef += '<td width="20px" height="54px" bgcolor="transparent"></td>';
		}
		else
		{
			if ( i / 2 < volume)
			{
				tableDef += '<td width="20px" height="54px" bgcolor="#00ff00"></td>';
			}
			else
			{
				tableDef += '<td width="20px" height="54px" bgcolor="cccccc"></td>';
			}
		}
	}
	tableDef += '<td width="20px"></td><td width="40px"><img src="images/playerimages/volume.gif"></td><td width="40px" style="color:white;font-size:28">' + volume + '</td>';
	tableDef += '</tr></table>'; 
	$("bottomframe").innerHTML = tableDef;    	
}

function hideJumpTimeDiv()
{    	
	if(timeID_jumpTime){clearTimeout(timeID_jumpTime);}
	var inputValueHour = $("hour").innerText;
	var inputValueMin = $("minute").innerText;
	 // 如果输入发生变化，则不作隐藏
	 if(preInputValueHour != inputValueHour || preInputValueMin != inputValueMin){return;}
	//如果文本框中有一个值为空，隐藏div
	if(isEmpty(inputValueHour) || isEmpty(inputValueMin))
	{
		 $("hour").className = "inp";
		 $("minute").className = "inp";
		 $("seekDiv").style.visibility = "hidden";
	}
	//如果文本框中有值则调用clickJumpBtn方法
	else{clickJumpBtn();   }
	count=0;
	seekDIvPos=4;
	$("hour").className = "inp inp-focus";
}
function checkJumpTime(pHour, pMin)
{    
	if(isEmpty(pHour))
	{
		return false;
	}
	else if(!isNum(pHour))
	{        
		return false;
	}
	if(isEmpty(pMin))
	{
		return false;
	}
	else if(!isNum(pMin))
	{
		return false;
	}
	else if(!isInMediaTime(pHour, pMin))
	{ 
		return false;
	}
	if(parseInt(pHour)>=24)
	{
		 return false;
	}
	if(parseInt(pMin)>=60)
	{
		return false;
	}
	else
	{
		return true;
	}
}
 //判断是否在播放时长内
function isInMediaTime(pHour, pMin)
{
	var currTime = new Date();   
	var inputTime = new Date();    
	var shiftLength = mp.getMediaDuration();   
	// 如果读到时间为零则取1小时
	var beginTime = new Date(currTime.getTime() - shiftLength * 1000);
	pHour = pHour.replace(/^0*/, "");
	if(pHour == "")
	{
		pHour = "0";
	}
	pMin = pMin.replace(/^0*/, "");        
	if(pMin == "")
	{
		pMin = "0";
	}
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
	var nr1=s;
	var flg=0;
	var cmp="0123456789";
	var tst ="";
	for (var i=0,l=nr1.length;i<l;i++)
	{
		tst=nr1.substring(i,i+1)
		if (cmp.indexOf(tst)<0)
		{
			flg++;
		}
	}
	if (flg == 0)
	{
		return true;
	}
	else
	{
		return false;
	}    
}
var timeErrorDIvIsShow = false;//定位输入时间错误
function clickJumpBtn()
{    	
	var inputValueHour = $("hour").innerHTML;
	var inputValueMin = $("minute").innerHTML;
	var timeJump = getShiftBeginTime();
	var hourJump = timeJump.substring(0,2);
	var minJump = timeJump.substring(3,5);
	if(inputValueHour==""){inputValueHour="00";}
	if(inputValueMin==""){inputValueMin="00";}
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
		jumpToTime(timeStamp);
	}else{        	
		//$("timeError").innerHTML = "时间输入不合理，请重新输入！&nbsp;&nbsp;&nbsp;&nbsp;"; 
		$("timeErrorDIv").style.display = "block";
		timeErrorDIvIsShow = true ;
		preInputValueHour = "";
		preInputValueMin = "";	
		$("jumpBtn").className = "btnoff";	
		$("hour").className = "inp inp-focus";	
		seekDIvPos = 0;
		//15秒后隐藏跳转输入框所在的div"
	}
	if(timeID_jumpTime){clearTimeout(timeID_jumpTime);}
	count=0;
	$("hour").innerHTML = "";
	$("minute").innerHTML = "";
}
function jumpToTime(_time)
{  
	resetSeekDiv();
	playByTime(_time);
	processSeek(_time); 
	displaySeekTable(); 
}
function playByTime(beginTime)
{       
	var type = 2;
	speed = 1;
	playStat = "play"; 
	mp.playByTime(type,beginTime,speed);
	count=0;
	seekDIvPos=4;
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
//按下定位键时的检测
function checkSeeking()
{
	if(isSeeking == 0){if(timeID_check){clearTimeout(timeID_check);}}
	else{
		//下面一行代码的作用：获取不到文本框中的值，动态刷新文本框所在div可以解决
		if(playStat != "fastrewind" && playStat != "fastforward")
		{
			$("statusImg").innerHTML = '<img src="images/playerimages/pause.png" width="40" height="40"/>';
		}
		var inputValueHour = $("hour").innerHTML;
		var inputValueMin = $("minute").innerHTML;
		/* 自动跳转焦点
		if(2==inputValueHour.length && 0==seekDIvPos ){$("minute").focus();seekDIvPos=1;}
		if(2==inputValueMin.length && 1==seekDIvPos ){$("minute").blur();$("jumpBtn").className = "btnon";seekDIvPos=2;}
		*/
		if(timeID_check){clearTimeout(timeID_check);}
		timeID_check = setTimeout("checkSeeking()",500);
		if(playStat == "fastrewind" || playStat == "fastforward")
		{	
			currTime = mp.getCurrentPlayTime(); processSeek(currTime);			
		}
		if(preInputValueHour != inputValueHour || preInputValueMin != inputValueMin)
		{
			var tempTimeID = timeID_jumpTime;
			if(tempTimeID){clearTimeout(tempTimeID);}
			timeID_jumpTime = setTimeout("hideJumpTimeDiv()",15000);
			preInputValueHour = inputValueHour;
			preInputValueMin = inputValueMin;
		}
	}
}
var speed_check_timer = "";//检查进度点的时间
//快进快退的检查
function checkSpeedSeeking()
{
	if(speed_check_timer){clearTimeout(speed_check_timer);}
	speed_check_timer = setTimeout("checkSpeedSeeking()",500);
	if(playStat == "fastrewind" || playStat == "fastforward")
	{	
		currTime = mp.getCurrentPlayTime(); processSpeed(currTime);			
	}
}
//用于暂停键时构建定位显示层
function displaySeekTable()
{
	//isSeeking等于0时展示进度条及跳转框
	if(isSeeking == 0){
		isSeeking = 1;
		currTime = mp.getCurrentPlayTime(); 
		processSeek(currTime);
		$("seekDiv").style.visibility = "visible";//输入跳转层
		seekDivIsShow = true ;	
		checkSeeking();
		seekDIvPos=4;
	}else{ 	
        $("seekDiv").style.visibility = "hidden";//输入跳转层
		seekDivIsShow = false;
		resetPara_seek();//复位各参数	
	}
}
var speedDivIsShow = false ;//速度进度条
//构建快进，快退层
function displaySpeedTable()
{
	if(speedDivIsShow){
		speedDivIsShow = false ;
		$("speedDiv").style.visibility = "hidden";
	}else{		
		speedDivIsShow = true ;
		$("speedDiv").style.visibility = "visible";
		currTime = mp.getCurrentPlayTime(); 
		processSpeed(currTime);
		checkSpeedSeeking();//调用方法检测进度条
	}
}


//跳转提示信息隐藏后，重置相关参数
function resetPara_seek()
{
	if(timeID_jumpTime){clearTimeout(timeID_jumpTime);}//清空隐藏跳转hideJumpTimeDiv
	isSeeking = 0;
	preInputValueHour = "";
	preInputValueMin = "";
	$("hour").innerHTML = "";
	$("minute").innerHTML = "";
//	$("timeError").innerHTML = "";
	$("statusImg").innerHTML = '<img src="images/playerimages/pause.png" width="40" height="40"/>';
}

//快进快退时
function processSpeed(_currTime)
{
	var innerFlag = 0;
	if(null == _currTime || _currTime.length != 16 || _currTime == undefined){ _currTime = mp.getCurrentPlayTime();}
	if(_currTime < 0){_currTime = 0;innerFlag = 1; }
    mediaTime = mp.getMediaDuration(); 
    var currPlayTime = _currTime;
    timePerCell =  mediaTime / 100;  
	_currTime = getRelativeTime(_currTime); // 得到到前播放相对时间，单位秒
    currCellCount = Math.ceil(_currTime / timePerCell); 
	if(currCellCount > 100){currCellCount = 100;shiftFlag=0;}
	if(currCellCount < 0){currCellCount = 0;innerFlag = 1; }
	/*if(currCellCount < 49)
	{
		$("seekPercent").innerHTML = currCellCount + "%";
	}
	else if(currCellCount >= 49 && currCellCount <= 50)
	{
		$("seekPercent").innerHTML = '<span style="color:black;">' + (String(currCellCount)).substring(0,1) + '</span><span style="color:white;">' + (String(currCellCount)).substring(1,2) + "%</span>";
	}
	else if(currCellCount >= 51 && currCellCount <= 53)
	{
		$("seekPercent").innerHTML = '<span style="color:black;">' + currCellCount + '</span><span style="color:white;">%</span>';
	}
	else if(currCellCount >= 54)
	{
		$("seekPercent").innerHTML = '<span style="color:black;">' + currCellCount + "%</span>";
	}*/
	$("Percent").innerText =  currCellCount + "%";
	var maxTime2 = getCurrTime2();
	var maxTime=getCurrTime();
	var tmp12 = getCurrPlayTime2(currPlayTime);  
	var tmp1=getCurrPlayTime(currPlayTime); 
	var tmp22 = getShiftBeginTime2();
	var tmp2 = getShiftBeginTime();
	// 规避当前时间显示小于时移开始时间的问题
	if (tmp12 < tmp22){tmp1 = tmp2;}
	if(tmp12 > maxTime2){tmp1 = maxTime;}
	
	$("currTime").innerText = tmp1;
	$("fullTime").innerText = maxTime;
	$("beginTime").innerText = tmp2;
	$("speedPos").style.left = (205 + currCellCount * 8.5) + "px";
}

//定位拖动时
function processSeek(_currTime)
{
	var innerFlag = 0;
	if(null == _currTime || _currTime.length != 16 || _currTime == undefined){ _currTime = mp.getCurrentPlayTime();}
	if(_currTime < 0){_currTime = 0;innerFlag = 1; }
    mediaTime = mp.getMediaDuration(); 
    var currPlayTime = _currTime;
    timePerCell =  mediaTime / 100;  
	_currTime = getRelativeTime(_currTime); // 得到到前播放相对时间，单位秒
    currCellCount = Math.ceil(_currTime / timePerCell); 
	if(currCellCount > 100){currCellCount = 100;shiftFlag=0;}
	if(currCellCount < 0){currCellCount = 0;innerFlag = 1; }
	var maxTime2 = getCurrTime2();
	var maxTime=getCurrTime();
	var tmp12 = getCurrPlayTime2(currPlayTime);  
	var tmp1=getCurrPlayTime(currPlayTime); 
	var tmp22 = getShiftBeginTime2();
	var tmp2 = getShiftBeginTime();
	// 规避当前时间显示小于时移开始时间的问题
	if (tmp12 < tmp22){tmp1 = tmp2;}
	if(tmp12 > maxTime2){tmp1 = maxTime;}

	$("seekCurrTime").innerText = tmp1;
	$("seekFullTime").innerText = maxTime;
	$("seekBeginTime").innerText = tmp2;
	$("seekPos").style.width = (2 + currCellCount * 9) + "px";
}

//暂停键=
function pauseOrPlay()
{	
   
	//时移状态: 1激活 0去激
	if(0==pltvStatus[currChannelIndex]){return;}
	business_type = back_type;
	if(showTimer){clearTimeout(showTimer);}
	if("false"==channelListFlag){hiddenChannelList();}
	
        if("true" == infoFlag){hiddenFilmInfo();}
	if(volumeDivIsShow){hideBottom();}
	
	if(speedDivIsShow){displaySpeedTable();resume();}
	else{
		if(0==isSeeking){
			pause();displaySeekTable();
		}else{
			displaySeekTable();resume();
		}
	}
}
function pause()
{
	playStat = "pause";speed = 1;shiftFlag = 1;
	mp.pause(); 
}
function resume()
{
	speed = 1;playStat = "play";
	mp.resume();
	if(mp.getNativeUIFlag() == 0){$("topframe").innerHTML = "";}
}
function getCurrPlayTime(currPlayTime)
{
	//转化UTC时间
	currPlayTime = parseUtcTime(currPlayTime);
	var sec = currPlayTime.getSeconds(); 
	var hour = currPlayTime.getHours();
	var min = currPlayTime.getMinutes();
	if (sec >= 30)
	{
	   min = min + 1;
	   if(min == 60)
	   {
		  min = 59;
	   }
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
	if (sec >= 30)
	{
	   min = min + 1;
	   if(min == 60)
	   {
		  min = 59;
	   }
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

//快退
function fastRewind()
{    	
	if(seekDivIsShow){return;}
	if(!speedDivIsShow)
	{
		if(pltvStatus[currChannelIndex] == 0||mediaErrorFlag == "true" || lockFlag == "true" || isNotSubFlag == "true"){return; }	
		if(volumeDivIsShow){hideBottom();}
		if("false" == channelListFlag){ if(channelListTimer){clearTimeout(channelListTimer);}hiddenChannelList();}
		if(infoFlag == "true"){hiddenFilmInfo();}
		
		business_type = back_type;
		shiftFlag = 1;
		
		if(showTimer){clearTimeout(showTimer);}		
		displaySpeedTable();
		if(timeID_jumpTime){clearTimeout(timeID_jumpTime);}
	}	
	if(playStat == "fastforward" || (playStat == "fastrewind" && speed >= 32)) {speed = 1;}
	speed = speed * 2;
	$("statusImg").innerHTML = '<img src="images/playerimages/icon_refast.png" align="absmiddle"/>&nbsp;X' + speed; 
	mp.fastRewind(-speed);  
    playStat = "fastrewind"; 
}
//快进
function fastForward()
{ 		    
	if(seekDivIsShow){return;}   
    if(!speedDivIsShow)
	{	
		if(pltvStatus[currChannelIndex] == 0|| business_type == live_type|| mediaErrorFlag == "true" || lockFlag == "true" || isNotSubFlag == "true"){  return;}
		if(volumeDivIsShow){hideBottom();}
		if("false" == channelListFlag){hiddenChannelList();}
		if("true" == infoFlag){hiddenFilmInfo();}    
		displaySpeedTable();
		if(timeID_jumpTime){clearTimeout(timeID_jumpTime);};
	}
	if(playStat == "fastrewind" ||(playStat == "fastforward" && speed >= 32)) {speed = 1;  }      	            	
	speed = speed * 2;
	$("statusImg").innerHTML = '<img src="images/playerimages/icon_fast.png" align="absmiddle"/>&nbsp;X' + speed; 
	mp.fastForward(speed);
	playStat = "fastforward";
}
//事件响应
function goUtility()
{
	//if(disLockFlag == 1){ return;}
	eval("eventJson = " + Utility.getEvent());
	var typeStr = eventJson.type;
	switch(typeStr)
	{  
		case "EVENT_MEDIA_ERROR":mediaError(eventJson);break;
		case "EVENT_PLAYMODE_CHANGE":resumeMediaError(eventJson);return false;break;		  
		case "EVENT_PLTVMODE_CHANGE": playModeChange(eventJson); return false;
		case "EVENT_TVMS":getTvms(eventJson); return false;
		case "EVENT_TVMS_ERROR":top.TVMS.closeMessage();top.TVMS.setKeyForSTB();return false;
		case "EVENT_MEDIA_BEGINING":
			 $("seekDiv").style.visibility = "hidden";
			 $("speedDiv").style.visibility = "hidden";
			 isSeeking = 0;
			 speed = 1;
			 seekDivIsShow = false;
			 displaySpeedTable();
			 resumestat();
			 return false;
		case "EVENT_MEDIA_END":shiftFlag=0;resumestat();return false;
		default : break;
	}
	return true;
}
function getTvms(eventJson)
{
	top.TVMS.showMessage(eventJson);
}

//播放模式变化
function playModeChange(eventJson)
{
	//hideMediaError();
	var stat = eventJson.service_type;
    if (stat == 1)//进入时移
    {
        if (business_type == live_type) { 
			business_type = back_type;
			
		}
    }
    if (stat == 0)//返回直播
    {
		if (business_type == back_type){ 
			business_type = live_type;
			displaySpeedTable();
		}
    }
}
function genSeekTable()
{
	var seekTableDef = "";
	seekTableDef = '<table width="1000" height="" border="0" cellpadding="0" cellspacing="0" bgcolor="#000080"><tr>';
	seekTableDef +='<td id="td_0" width="0%" height="25" style="border-style:none;"></td>';
	seekTableDef +='<td id="td_1" width="100%" height="25" style="border-style:none;"></td>';
	seekTableDef += '</tr></table>';
	var seekTableFocus="";
	seekTableFocus = '<table width="1000" height="" border="0" cellpadding="0" cellspacing="0"><tr>';
	seekTableFocus +='<td id="td_0" width="0%" height="25" style="border-style:none;"></td>';
	seekTableFocus +='<td id="td_1" width="100%" height="25" style="border-style:none;"></td>';
	seekTableFocus += '</tr></table>';
	$("seekTable").innerHTML = seekTableDef;
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

//切换直播
function joinChannel(chanNum)
{	
    $("showMessageDiv").style.display = "none";
    if(containFun(markArray,chanNum) == true){
		$("showMessageDiv").style.display = "block";
		clearTimeout(tempShowMsgTimer);
		tempShowMsgTimer = setTimeout("hiddenShowMessage();", 5000);
	}
	//如果miniepg显示，先清空
	if("true" == infoFlag){clearTimeout(hiddenTimer);hiddenFilmInfo();}
	showChannelNum();
	//1,外部进来 预览播放 
	if(0 == isSubSingle && 1 == isPerview)
	{
		var testChanNum = "<ChannelPreviewCMD ChannelNo='"+chanNum+"'/>";
		mp.sendVendorSpecificCommand(testChanNum);
		isSubSingle = -1;
		isPerview = -1;
	}
	//2,内部切换 预览播放 
	else if(isSubPreview[currChannelIndex] == 1 && 3 == isSub[currChannelIndex])
	{	
		var testChanNum = "<ChannelPreviewCMD ChannelNo='"+chanNum+"'/>";
		mp.sendVendorSpecificCommand(testChanNum);
	}
	//3,开机播放,正常播放
	else
	{
		if(STBType.indexOf("EC5108") != -1 || STBType.indexOf("EC1308") != -1 ||　STBType.indexOf("EC2108") != -1)
		{
			//alerts("加载的时候判断终端");
		}
		else{mp.leaveChannel();}
               var issubb="<%=strIsSub%>";
            //   alert("dddddd"+issubb);
	     //   if(<%=strIsSub%>=="1"&&<%=strIsSub%>=='1')
        //  alert(currChannelIndex+"---"+isSubSingle); 
         //  alert("--"+isSub[currChannelIndex]+"==="+channelNums[currChannelIndex]);
        //    if(isSubSingle==1&&currChannelIndex==61||isSubSingle==1&&currChannelIndex==65||isSubSingle==1&&currChannelIndex==63){
            //     mp.joinChannel(chanNum);
              //   $('tipText').style.visibility = "hidden";}
             /*if(isSub[currChannelIndex]==1 ){*/
                  mp.joinChannel(chanNum);      
             /*   $('tipText').style.visibility = "hidden"; }
            else{
                  mp.stop();
                 $('tipText').style.visibility = "visible"; }*/
            
                  
               // else
                 //   window.location.href="index.jsp";
	}
	//恢复流
	isLeaveChannelFlag = "false";
	if(chanListFocus!=0)
	{
	    setFocus(chanListFocus);
	}
	else
	{	
	    setFocus(currChannelIndex);
	}
	//新直播播放前需要重新设置miniEPG显示
	
	clearTimeout(showTimer);
	currChannelNum =chanNum;
       
	showTimer = setTimeout(shwoFilmInfo,<%=iShowDelayTime%>);
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
	if("false" == channelListFlag)
	{
		clearTimeout(channelListTimer);
		hiddenChannelList();
	}
	if(lockFlag == "true"){stopChannel();}
	else
	{
		stopChannel();
		goBack();
	}
}	
//返回键
function returnBack()
{	
	//如果直播列表存在，先去掉直播列表
	if("false" == channelListFlag){clearTimeout(channelListTimer);hiddenChannelList();return;}
	//如果是时移状态的话，先切换到直播状态
	if(business_type == back_type)
	{
		if(seekDivIsShow)
		{	
			$("seekDiv").style.visibility = "hidden";
			seekDivIsShow = false;
			count=0;
			seekDIvPos=4;
		}
		business_type = live_type;
		mp.gotoEnd();
		return;
	}
	else  //退出提示层
	{
		stopChannel();
		resetQuitDiv();
		setTimeout("showQuitDiv()",200);
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
	//清空层
	if("true" == isNotSubFlag){clearDiv();}
	//清空锁控制层
	if("true" == lockFlag){hiddenLockInfo();}
	//清空直播列表
	if("false" == channelListFlag){hiddenChannelList();}
	//清空预览提示
	if(preDivIsShow){hiddenPreview();}
	//清空错误层
	if("true" == mediaErrorFlag){hiddenMediaError();}
	//清空直播号
	setTimeout("hideChannelNum()",<%=DEFAULT_HIDEINFO_TIME%>);
	freeFocus(currChannelIndex);		
}	
//离开当前页面
function goBack()
{	
	var url = unescape(backUrl);
	//清空层
	if("true" == isNotSubFlag){clearDiv();}
	if("true" == lockFlag){hiddenLockInfo();}
	mp.leaveChannel();
	mp.stop();
	shiftQuitFlag = 1;//此出赋值,以防在destoryMP方法中再上报一次
	//为频道的焦点记忆
	if(backUrl.indexOf('?')==-1){backUrl+="?back=1";}	    
    else if(backUrl.indexOf('&back=1')==-1){ backUrl+="&back=1";	}
	window.location.href = backUrl;
}
//从子页面加载数据
function loadData()
{
	filmInfo.location.href = "play_ControlChannelListTvHD.jsp?isfromgat=" +<%=isfromgat%> +"&CHANNELID="+channelId+"&CHANNELNUM="+currChannelNum+"&ISSUB="+isSubSingle+"&COMEFROMFLAG="+comeType;//hxt
         // alert(isSubSingle+"++++"+currChannelIndex);if(isSubSingle==1){isSub[currChannelIndex]=1;}
}	
//向下键
function arrowDown()
{
	if(quitDivIsShow){return;}
	//直播列表显示的时候，处理按键
	if("false" == channelListFlag)
	{	
		//if(chanListFocus%6 == 5|| chanListFocus == totalChannel){pageDown();return;}
		addChannelList();
		return;
	}
	else if(seekDivIsShow && seekDIvPos==4)
	{
		$("seekPos").style.background = "url(images/playerimages/progressbar02.png)";//进度点失去焦点的时候
		seekDIvPos=0;
		$("hour").className = "inp inp-focus";
		return;
	}
	decChannel();
}	
//向下切直播 函数中注意先后顺序
function decChannel()
{
	if(quitDivIsShow || seekDivIsShow){return;}
	//离开上一个直播
	stopChannel();
	//是否直播是第一个直播，如果是应该切到最后一个直播
	if(0 == currChannelIndex){currChannelIndex = totalChannel;}
	else{currChannelIndex--; }
	lockPlay = "true";
	if("false" == lockPlay)
	{	
		if(totalChannel == currChannelIndex){currChannelIndex = 0;}//是否直播是最后一个直播，如果是应该切到第一个直播
		else{currChannelIndex++;}
		return;
	}
  // alert("--"+isSub[currChannelIndex]+"==="+channelNums[currChannelIndex]);  
   joinChannel(channelNums[currChannelIndex]);
}	
//向上键
function arrowUp()
{
	if(quitDivIsShow){return;}
	//直播列表显示的时候，处理按键
	if("false" == channelListFlag)
	{	
		//if(chanListFocus%6 == 0){upPageToLastIndex = true ;pageUp();return;}
		decChannelList();
		return;
	}
	if(seekDivIsShow)
	{
		if(seekDIvPos<4){resetSeekDiv();}
		seekDIvPos = 4;
		return;
	}
	addChannel();
}	
function resetSeekDiv()
{
	if(0==seekDIvPos){ $("hour").className = "inp";}
	else if(1==seekDIvPos){ $("minute").className = "inp";}
	else if(2==seekDIvPos){ $("jumpBtn").className = "btnoff";}
	else if(3==seekDIvPos){ $("cancelBtn").className = "btnoff";}
	 //$("hour").className = "inp"; $("minute").className = "inp";$("jumpBtn").className = "btnoff";$("cancelBtn").className = "btnoff";
	$("seekPos").style.background = "url(images/playerimages/progressbar.png)";//进度点得到焦点的时
}
//直播列表下键切直播 函数中注意先后顺序
function addChannelList()
{
	freeFocus(chanListFocus);
	//是否直播是最后一个直播，如果是应该切到第一个直播
	if(chanListFocus == 5)
	{
		chanListFocus = 0;
	}
	else
	{
		chanListFocus++;
	}
	setFocus(chanListFocus);
	//如果锁存在，则直播列表一直存在
	isHaveLock();
	if("true" == lockFlag){hiddenLockInfo();	}
}	
//直播列表上键切直播  函数中注意先后顺序
function decChannelList()
{
	freeFocus(chanListFocus);
	//是否直播是最后一个直播，如果是应该切到第一个直播
	if(0 == chanListFocus)
	{
		chanListFocus = 5;
	}
	else
	{
		chanListFocus--;
	}
	setFocus(chanListFocus);
	//如果锁存在，则直播列表一直存在
	isHaveLock();
	if("true" == lockFlag){hiddenLockInfo();}
}	
//向上切直播 函数中注意先后顺序
function addChannel()
{
	if(quitDivIsShow|| seekDivIsShow){return;}
	//先离开上一个直播
	stopChannel();
	//是否直播是最后一个直播，如果是应该切到第一个直播
	if(totalChannel == currChannelIndex){currChannelIndex = 0;}
	else{currChannelIndex++;}
	lockPlay = "true";
	joinChannel(channelNums[currChannelIndex]);
}	
//授权验证，父母控制，加锁等
function authtication(_chanIndex)
{	
	
}	
//父母控制，加解锁提示
function showLockInfo()
{
	/*lockFlag = "true";
	bg_lockpass.style.display = "block";
	lock_pass.style.display = "block";
	$("pwd").focus();*/
}
/******************************解码begin**********************************************/

/**********************************解码end******************************************/	

//右边的OSD miniEPG显示
function shwoFilmInfo()
{	
	if( playStat=="fastforward" || playStat=="fastrewind"){ clearTimeout(showTimer);showTimer = "";resume();}
	if(0 == bottomLineNum){showChannelNum();}//直播下划线存在的时候不显示
	if(volumeDivIsShow){hideBottom();}
	if(seekDivIsShow){$("seekDiv").style.visibility = "hidden";resume();}
	//$("filmInfo1").style.display = "block";
	
    var currChannelNumStr = "";//用于显示当前播放频道的频道号

	//根据需求频道号添加显示000
	if(undefined == chanNum){
		if(currChannelNum < 10){
			currChannelNumStr = "00" + currChannelNum.toString();
		}else if(currChannelNum < 100){
			currChannelNumStr = "0" + currChannelNum.toString();
		}else if(currChannelNum < 1000){
			currChannelNumStr = currChannelNum.toString();
		}
	}else{
		if(chanNum < 10){
			currChannelNumStr = "00" + chanNum.toString();
		}else if(chanNum < 100){
			currChannelNumStr = "0" + chanNum.toString();
		}else if(chanNum < 1000){
			currChannelNumStr = chanNum.toString();
		}
	}
        //alert(infoFlag);
	getAJAXData("play_ControlChannelminiInfoajax.jsp?CHANNELID=" + channelIds[currChannelIndex] + "&pltvStatusFlag="+isSubPreview[currChannelIndex]+"&CHANNELNUM=" + channelNums[currChannelIndex],init_info);
}	
//miniEPG隐藏
function hiddenFilmInfo()
{
	clearTimeout(hideNumTimer);
	hideChannelNum();//隐藏直播号
	$("filmInfo1").style.display = "none";
	infoFlag = "false";
}	
	
//清空层 主要是未授权、直播不存在、
function clearDiv()
{
	//未授权
	isNotSubFlag = "false";
	bg_noorder.style.display = "none";
	no_order.style.display = "none";
}	
/*****************直播列表begin******************************************/	
//直播列表页面初始化 
function init_page()
{
	init_data();
	setFocus(chanListFocus);
}
//直播OSD列表
function create_chanTable()
{		
	/*var chaninfo = "";
	if(currListPage>0){
		chaninfo = "<div align='center'><img src='images/playerimages/up.png'/></div>";
	}else{
		 chaninfo = "<div align='center'><img src='images/playerimages/up_gray.png'/></div>";
	}
	for(var j = 0; j<rows; j++)
	{
		var index = currListPage * rows + j;
		var divId="chan_"+j;
               
		if(typeof(channelNumsShow[index]) != "undefined"){
			chaninfo += "<div id='"+divId+"' class='sub'>"+channelNumsShow[index]+"&nbsp;&nbsp;"+channelNames[index]+"</div>";
		}else{
			chaninfo += "<div class='sub'>&nbsp;</div>"; 
		}
		chaninfo+="<div><img src='images/playerimages/menu_line.png'/></div>";
	}
	if(currListPage<totalListPages-1){
		chaninfo += "<div align='center'><img src='images/playerimages/down.png'/></div>";
	}else{
		 chaninfo += "<div align='center'><img src='images/playerimages/down_gray.png'/></div>";
	}
	$("chan_info").innerHTML = chaninfo;	*/
	
	for(var j=0;j<6;j++)
	{
		if(j<4)
		{
			var index = currListPage * rows + j;
			if(typeof(channelNumsShow[index]) != "undefined")
			{
				$("chanName_"+j).innerHTML = channelNames[index];
			}
			else
			{
				 $("chanName_"+j).innerHTML = "";
			}
		}
		else
		{
			if((j-4)<tuiJianDate.length)
			 {
				 $("post_"+(j-4)).src=(tuiJianDate[j-4].POSTERPATHS==undefined?"images/no_picture_259x232.jpg":tuiJianDate[j-4].POSTERPATHS);
				 //$("post_"+(j-4)).src="images/no_picture_259x232.jpg";
			 }
			 else
			 {
				 $("post_"+(j-4)).src="#";
			 }
		}
	}
	//if("true" == getDataFlag){showChannelList();}
}	
 //加载直播列表
function init_data()
{
	create_chanTable();
}

//释放焦点选择
function freeFocus(curr_focus)
{
	var focusAt = curr_focus%6;
	if($( "chan_" + focusAt)!=undefined)
	{
		$("chan_"+focusAt).className="item";
		if(focusAt<4&&isTvod[focusAt]=="1")
		{
			$("isPlayBack_"+focusAt).style.display="none";
		}
		else
		{
			$("isPlayBack_3").style.display="none";
			$("isPlayBack_0").style.display="none";
			$("isPlayBack_1").style.display="none";
			$("isPlayBack_2").style.display="none";
		}
	}
}	
//获得焦点选择
function setFocus(curr_focus)
{
	var focusAt = curr_focus%6;
	if($( "chan_" + focusAt)!=undefined)
	{
		$("chan_"+focusAt).className="item item_focus";
		if(focusAt<4)
		{
			$("logoImag").src ="images/logo_"+focusAt+".png" ;
			if(isTvod[focusAt]=="1")
			{
			   $("isPlayBack_"+focusAt).style.display="block";
			}
		}
		else
		{
			$("isPlayBack_3").style.display="none";
			$("isPlayBack_0").style.display="none";
			$("isPlayBack_1").style.display="none";
			$("isPlayBack_2").style.display="none";
		}
	}
}	
function gotoEnd()
{
	//alert("gotoEnd/"+pltvStatus[currChannelIndex]+"/"+mediaErrorFlag+"/"+lockFlag+"/"+isNotSubFlag);
	if(pltvStatus[currChannelIndex] == 0||mediaErrorFlag == "true" || lockFlag == "true" || isNotSubFlag == "true"){return;}
	if("false" == channelListFlag){if(channelListTimer){clearTimeout(channelListTimer);}hiddenChannelList();}
	if("true"==infoFlag){hiddenFilmInfo();}
	shiftFlag = 0;  // 规避一键到尾不能收到MEDIA_END的问题    	
	goEnd();
	isSeeking = 0;
	$("speedDiv").style.visibility="hidden";
	$("seekDiv").style.visibility="hidden";
	resumestat();
}	
function goEnd()
{
	business_type = live_type;
	mp.gotoEnd();
}	
function resumestat()
{
	speed = 1;
	playStat = "play"; 
	premode = 0;
}	
//下翻页
function pageDown()
{
	//直播列表不显示，按翻页键没用
	if("true" == channelListFlag){gotoEnd();}
	/*else{
		if(currListPage > totalListPages - 1 || totalListPages == 1){return;}
		freeFocus(chanListFocus);
		if(currListPage == totalListPages - 1) {	currListPage = 0;}    //如果是最后一页 则下翻到第一页
		else{currListPage++;}
		chanReload1();
		chanListFocus = currListPage*4;
		setFocus(chanListFocus);		
		isHaveLock();	//如果锁存在，则直播列表一直存在
	}*/
}	
 //上翻页
function pageUp()
{
	//直播列表不显示，按翻页键没用
	if("true" == channelListFlag){gotoStart();}
	/*else{
		if(currListPage < 0 || totalListPages == 1){return;}
		freeFocus(chanListFocus);
		if(currListPage == 0){currListPage = totalListPages - 1;}   //如果是第一页 则上翻到最后一页             
		else{currListPage--;}
		chanReload1();
		if(upPageToLastIndex==true){
			if(0 == chanListFocus){chanListFocus = totalChannel;}
			else{chanListFocus--;}
			upPageToLastIndex = false ;
		}
		else{chanListFocus = currListPage*6;}
		setFocus(chanListFocus);
		isHaveLock();//如果锁存在，则直播列表一直存在
	}*/
}
function gotoStart()
{
	//alert("gotoStart/"+pltvStatus[currChannelIndex]+"/"+mediaErrorFlag+"/"+lockFlag+"/"+isNotSubFlag);
	
	if(pltvStatus[currChannelIndex] == 0||mediaErrorFlag == "true" || lockFlag == "true" || isNotSubFlag == "true"){return; }
	if("false" == channelListFlag){clearTimeout(channelListTimer);hiddenChannelList();}
	if ("true"==infoFlag){hiddenFilmInfo();}
	shiftFlag = 1;  // 规避一键到头不能收到MEDIA_BEGGIN的问题
	pause();
	isSeeking = 0;
	$("speedDiv").style.visibility="hidden";
	$("seekDiv").style.visibility="hidden";
	goBeginning();
	resumestat();
}
function goBeginning()
{
	mp.gotoStart();
	business_type = back_type;
}	
//重载直播列表
function chanReload1()
{
	init_data();
}
//ok键
function pressOK()
{	
	if(speedDivIsShow){displaySpeedTable();resume();}
	currentTime = mp.getCurrentPlayTime();
	if(quitDivIsShow){return;}
	//如果显示就隐藏  channelListFlag true：已经隐藏 false:已经显示
	else if("false" == channelListFlag){		
	    //如果是当前播放的直播，并且不是在停流的情况下
		if(currChannelIndex == chanListFocus && "false" == isLeaveChannelFlag){hiddenChannelList();}
		else{
			if(chanListFocus<4)
			{		
			    playByChannelList();//直播列表上按ok键切换播
			}
			else
			{
				if(chanListFocus==4)
				{
					mp.leaveChannel();
	                mp.stop();
					window.location.href="../../"+tuiJianDate[0].VARSURL+"&returnurl=../../play_ControlChannelHD.jsp?CHANNELNUM="+channelNums[currChannelIndex]+"&COMEFROMFLAG=1&currChannelIndex="+currChannelIndex+"&chanListFocus="+chanListFocus;
				}
				else
				{
					mp.leaveChannel();
	                mp.stop();
					window.location.href="../../"+tuiJianDate[1].VARSURL+"&returnurl=play_ControlChannelHD.jsp?CHANNELNUM="+channelNums[currChannelIndex]+"&COMEFROMFLAG=1&currChannelIndex="+currChannelIndex+"&chanListFocus="+chanListFocus;
				}
			}
		}
	}else if(seekDivIsShow ){
		if(timeErrorDIvIsShow){
			$("timeErrorDIv").style.display = "none";
			timeErrorDIvIsShow = false ;
		}else{
			if(2==seekDIvPos){
				clickJumpBtn();
			}else if(3==seekDIvPos || 4==seekDIvPos){
				//定时跳转播放
			//	alert(currentTime);
			//	alert(currTime);
			//	alert(maxTime);
				resetSeekDiv();
				playByTime(currTime);
				$("seekDiv").style.visibility = "hidden";
				seekDivIsShow = false ;
				isSeeking = 0;
				speed = 1;
			}
		}
	}else{
		if("true" == getDataFlag){showChannelList();}
	}
}	
//显示直播列表
function showChannelList()
{
	freeFocus(chanListFocus);
	if(chanListFocus<4)
	{
	    chanListFocus = currChannelIndex;
	}
	//当前是第几页
	realCurrPage();
	chanReload1();
	setFocus(chanListFocus);
	showChannelListDiv();
	//直播列表在8秒后未被操作自动消失
	clearTimeout(channelListTimer);
	channelListTimer = setTimeout(hiddenChannelList,<%=DEFAULT_HIDEINFO_TIME%>);
}	
//获取正整数
function getInt(num)
{
	num = num + "";
	var i = num.indexOf(".");
	var currpage = num.substring(0,i);
	return parseInt(currpage,6);
}	
//根据索引判断当前是第几页
function realCurrPage()
{
	if(chanListFocus % 6 == 0){currListPage = chanListFocus / 6;}
	else{currListPage = getInt(chanListFocus / 6);}
}	
//直播列表层显示
function showChannelListDiv()
{	
    if(speedDivIsShow || seekDivIsShow||"false"==channelListFlag){return;}
	$("channelListDIV").style.display = "block";
	channelListFlag = "false";
}	
//隐藏直播列表
function hiddenChannelList()
{	
	if(channelListFlag == "true"){return;}	
	$("channelListDIV").style.display = "none";
	channelListFlag = "true";
}	
//通过直播OSD列表播放
function playByChannelList()
{
	lockPlay = "true";//清空层	
	if("true" == isNotSubFlag){clearDiv();}//清空错误层
	if("true" == mediaErrorFlag){hiddenMediaError();}//清空预览提示
	//if(preDivIsShow){hiddenPreview();	}
	var temp1 = currChannelIndex;
	var temp2 = currChannelNum;
	currChannelIndex = chanListFocus;
	currChannelNum = channelIds[chanListFocus];   
	if("false" == lockPlay)
	{
		currChannelIndex = temp1;
		currChannelNum = temp2;
		return;
	}	
	//如果锁存在，则直播列表一直存在
	isHaveLock();
	//播放时需要把直播列表的临时焦点赋给真正的焦点
	//currChannelIndex = chanListFocus;
	//currChannelNum = channelNums[chanListFocus];
	//alert("channelNums="+parseInt(channelNums[chanListFocus],10));
	joinChannel(parseInt(channelNums[chanListFocus],10));
	hiddenChannelList();
}	
//判读是否有锁，如果有锁的话，直播列表得一直显示
function isHaveLock()
{
	if("true" == lockFlag){clearTimeout(channelListTimer);}	
	else
	{
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
	var tabdef = '<table width=400 height=70><tr align="right"><td><font color=green size=40>';
	tabdef += num +'</font></td></tr></table>';
	$("topframe").innerHTML = tabdef;
	//8秒钟后隐藏直播号
	if(hideNumTimer){clearTimeout(hideNumTimer);}
	hideNumTimer = setTimeout("hideChannelNum()",<%=DEFAULT_HIDEINFO_TIME%>);
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
	if(quitDivIsShow||getDataFlag=="false"||"false" == channelListFlag||number * 10 >= 10000){return;}
	if(bottomLineNum !=0)
	{
		clearTimeout(bottomLineHideTime);
		bottomLineHideTime = setTimeout("hideBottomLine()",<%=DEFAULT_HIDEINFO_TIME%>);
		if(numCount >= bottomLineNum ){return;}
	}
	if(numCount >= 4||seekDivIsShow){return;}
	numCount++;
	tempNumber = tempNumber+""+i;
	number = number * 10 + i;
	channelNumAction(tempNumber);
	clearTimeout(timeID);
	timeID = setTimeout("playByChannelNum("+ number +")", 3000);// 3秒钟之后切换直播
}	
//用户输入的直播号时的处理
function playByChannelNum(chanNum)
{
	//是否是通过下划线切换
	if(bottomLineNum !=0)
	{
		//if(bottomLineHideTime){clearTimeout(bottomLineHideTime);}
		//bottomLineHideTime = setTimeout("hideBottomLine()",<%=DEFAULT_HIDEINFO_TIME%>);
		if(hideNumTimer){clearTimeout(hideNumTimer);}
		hideNumTimer = setTimeout("hideChannelNum()",<%=DEFAULT_HIDEINFO_TIME%>);
		if(numCount < bottomLineNum){return;}
	}
	if(bottomLineHideTime){clearTimeout(bottomLineHideTime);}
	hideBottomLine();
	//输入的数字
	number = 0;
	numCount = 0;
	tempNumber = "";
	updateChannelFromNum(chanNum);
}	
//数字播放
function updateChannelFromNum(chanNum)
{	
	//判断当前输入的直播号是否是正在播放的直播
	if(chanNum == currChannelNum && isLeaveChannelFlag == "false"){return;}
	//离开上一个直播
	stopChannel();
	//通过用户输入的直播号判断直播是否存在，加锁，父母控制等等
	var returnIndex = getChanIndexByNum(chanNum);
	//-1表示直播不存在
	if(-1 == returnIndex){
		channelIsNotExist(chanNum);
		currChannelNum = chanNum;
	}else{
		currChannelIndex = returnIndex;
		currChannelNum = chanNum;
		joinChannel(chanNum);
	}
}	
//直播不存在
function channelIsNotExist(chanNum)
{
	if(hiddenDiv){clearTimeout(hiddenDiv);}
	hiddenDiv = setTimeout("clearDiv()",1500);
	isNotSubFlag = "true";
	bg_noorder.style.display = "block";
	no_order.style.display = "block";
	$("orderInfo").innerHTML = '直播&lt;' + chanNum + '&gt;不存在';
	$("showmessage").innerHTML = "请切换到其它直播收看!";
}	
//直播未订购
function channelIsNotSub(chanNum)
{
	clearTimeout(hiddenDiv);
	hiddenDiv = setTimeout("clearDiv();",<%=DEFAULT_HIDEINFO_TIME%>);
	isNotSubFlag = "true";
	bg_noorder.style.display = "block";
	no_order.style.display = "block";
	$("orderInfo").innerHTML = '您尚未订购&lt;' + chanNum + '&gt;直播';
	$("showmessage").innerHTML = "请切换到其它直播收看!";
}
//通过直播号比对出索引
function getChanIndexByNum(chanNum)
{
	var chanIndex = -1;
	for (i = 0; i <= totalChannel; i++)
	{
		if (chanNum == channelNums[i])
		{
			chanIndex = i;
			break;
		}
	}
	return chanIndex;
}
//右键控制，一键跳转层
function pressRight()
{
	if(quitDivIsShow){mainPressKeyRight();}
	else if(seekDivIsShow){
			if(seekDIvPos == 0){
				$("hour").className = "inp";$("minute").className = "inp inp-focus";seekDIvPos = 1;	
			}else if(seekDIvPos == 1){
				$("minute").className = "inp";$("jumpBtn").className = "btnon";seekDIvPos = 2;
			}else if(seekDIvPos == 2){
				$("jumpBtn").className = "btnoff";$("cancelBtn").className = "btnon"; seekDIvPos = 3;	
			}else if(seekDIvPos==4){
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
				  if(timeID_jumpTime){clearTimeout(timeID_jumpTime);}
				  processSeek(currTime);
			}
		return false;
	}
	else if(channelListFlag=="false")
	{
		if(chanListFocus<4)
		{
			
			                        
									
									
									
									
									
			//window.location.href="playback.jsp?isComFromHD=1&areaid=1&indexid="+chanListFocus;
			mp.leaveChannel();
	        mp.stop();
			window.location.href="playbacklist.jsp?channelId="+channelIds[currChannelIndex]+"&isComFromHD=1&areaid=0&cruntFocus="+chanListFocus;
		}
	}
	else{volumeUp();}
}
//左键控制，一键跳转层
function pressLeft()
{	
	if(quitDivIsShow){mainPressKeyLeft();}
	else if(seekDivIsShow){
		    if(seekDIvPos == 1){
				$("minute").className = "inp";$("hour").className = "inp inp-focus";seekDIvPos = 0;
			}else if(seekDIvPos == 2){
				$("jumpBtn").className = "btnoff";$("minute").className = "inp inp-focus"; seekDIvPos = 1;				
			}else if(seekDIvPos == 3){
				$("cancelBtn").className = "btnoff";$("jumpBtn").className = "btnon";seekDIvPos = 2;				
			}else if(seekDIvPos==4){
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
			
				processSeek(currTime);
			}
		return false;
	}
	else{volumeDown();	}
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
   var t=Date.parse(T)+30*count*1000*3;//每次拖动为3秒   
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
		//$("cancel").focus();
		return;
	}
}
function mainPressKeyLeft()
{
	if( positionFlag == 1)
	{	
		//$("quit").focus();  
		positionFlag--;  return;
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
	//如果一键跳转层显示，不能切直播
	if("false" == channelListFlag){return;}
	if(hideNumTimer){clearTimeout(hideNumTimer);}
	hideChannelNum();
	if(bottomLineHideTime){clearTimeout(bottomLineHideTime);}
	if(bottomLineNum < bottomLineAllNum){bottomLineNum++;}
	else{bottomLineNum = 0;}
	var strBottom = '<table width=200 height=30><tr align="right"><td><font color="green" size="20"  height="10" style="font-weight:900">';
	for(var i = 0; i < bottomLineNum; i++)
	{
		strBottom += '_';
	}
	strBottom += '</font></td></tr></table>';
	$("topframe_bottomLine").innerHTML = strBottom;
	if(bottomLineHideTime){clearTimeout(bottomLineHideTime);}
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
	//清空层
	if("true" == isNotSubFlag){clearDiv();}
	//清空锁控制层
	if("true" == lockFlag){hiddenLockInfo();}
	//清空错误层
	if("true" == mediaErrorFlag){hiddenMediaError();}
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
	//清空层
	if("true" == isNotSubFlag){clearDiv();}
	//清空锁控制层
	if("true" == lockFlag){hiddenLockInfo();}
	//清空错误层
	if("true" == mediaErrorFlag){hiddenMediaError();}
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
	$("preview").style.display = "none";
	$("previewInfo").style.display = "none";
	preDivIsShow = false;
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
	if(10 == type){	showMediaError();}
}
//显示错误信息
function showMediaError()
{
	//如果直播列表存在，先去掉直播列表
	if("false" == channelListFlag){clearTimeout(channelListTimer);hiddenChannelList();}
	//清空预览提示
	if(preDivIsShow){hiddenPreview();	}
	//清空层
	if("true" == isNotSubFlag){clearDiv();}
	//清空锁控制层
	if("true" == lockFlag){hiddenLockInfo();}
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
	else if(getDataFlag == "true"){stbNoThisChannel(channelNums[currChannelIndex]);}
	else{stbNoThisChannel(currChannelNum);}	
	
}	
//直播列表存在，但是机顶盒中不存在
function stbNoThisChannel(chanNum)
{
	if(showTimer){clearTimeout(showTimer);}
	isNotSubFlag = "true";
	bg_noorder.style.display = "block";
	no_order.style.display = "block";
	$("orderInfo").innerHTML = '直播&lt;' + chanNum + '&gt;暂时不能播放';
	$("showmessage").innerHTML = "";//"请重启机顶盒更新直播列表或切换到其他直播!";
}	
//根据状态调整显示
function resumeMediaError(eventJson)
{
	/*
	1:暂停状态 2：正常播放状态 3：正常之外，快进，快退，慢进，慢退 4：组播频道直播状态 5：单播频道直播状态
	*/
	//alert("eventJson.new_play_mode:"+ eventJson.new_play_mode+"/eventJson.old_play_mode:"+eventJson.old_play_mode);
	var type_new_play = eventJson.new_play_mode;
	var type_old_play = eventJson.old_play_mode;
	if(2 == type_new_play && 0 == type_old_play)
	{
		hiddenMediaError();
		mp.resume();
		$("speedDiv").style.visibility = "hidden";
		isSeeking = 0;
		speed = 1;
		speedDivIsShow = false;
		playStat = "play";
	}
	if(speedDivIsShow && type_new_play == 2 )
	{
		$("speedDiv").style.visibility = "hidden";
		speedDivIsShow = false;
		playStat = "play";
		speed = 1;
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
function getAJAXData(url, successMethed,param) {
	var zte_browser = navigator.userAgent.indexOf('ztebw');
    if (url != undefined && url != null && url != "") {
        var temp = url.split("?"); url = temp[0];
        if (temp.length > 1) { url += "?" + encodeURI(temp[1]); }
    }
    if(zte_browser >=0){
	    var _in_ajax_1 = window.ActiveXObject ? new ActiveXObject("Microsoft.XMLHTTP") : new XMLHttpRequest();
	    _in_ajax_1.open("POST",  url,  true); 
	    _in_ajax_1.onreadystatechange= function() {
	    if (_in_ajax_1.readyState == 4) { if (_in_ajax_1.status == 200) { successMethed(_in_ajax_1.responseText,param);} } 
     }
	 
     _in_ajax_1.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
     _in_ajax_1.setRequestHeader("X-Requested-With", "XMLHttpRequest");
     _in_ajax_1.send(null);
    }else{
		 var _in_ajax = window.ActiveXObject ? new ActiveXObject("Microsoft.XMLHTTP") : new XMLHttpRequest();
    _in_ajax.open("POST", url, false);
    _in_ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
    _in_ajax.setRequestHeader("X-Requested-With", "XMLHttpRequest");
    _in_ajax.send(null);
    //_in_ajax.onreadystatechange=successMethed;
    if (_in_ajax.readyState == 4) { if (_in_ajax.status == 200) { successMethed(_in_ajax.responseText,param); } } 
  }
}

function init_info(jsontext){
	$("filmInfo1").style.display = "block";
	infoFlag = "true";
    var thisjson=eval('('+jsontext+')'); 
	//alert(txtJson);
	Authentication.CTCSetConfig("mediacode",thisjson.channelinfo.channelMediaCode);
	
	if(thisjson.channelinfo!=undefined&&thisjson.channelinfo.progName!=undefined)
	{
		if(getbytelength(thisjson.channelinfo.progName)<18)
		{
	        document.getElementById("currprog").innerText = thisjson.channelinfo.progName;
		}
		else
		{
			document.getElementById("currprog").innerHTML="<marquee scrollamount='6'>"+thisjson.channelinfo.progName+"</marquee>";
		}
	}
	else
	{
		document.getElementById("currprog").innerText = "";
	
	}

	/********20130905 17:30 ZSZ 增加显示频道号********/
	//document.getElementById("num").innerText = thisjson.channelinfo.progNum;
	/********20130905 17:30 ZSZ 增加显示频道号********/

	//document.getElementById("title").innerText = thisjson.channelinfo.channelName;
	for(var i=0;i<2;i++)
	{
		if(thisjson.progMenus[i+1]!=undefined&&thisjson.progMenus[i+1].progTime!=undefined&&thisjson.progMenus[i+1].progName!=undefined)
		{
		   document.getElementById("progTime_"+i).innerText=thisjson.progMenus[i+1].progTime;
		   if(getbytelength(thisjson.progMenus[i+1].progName)<14)
		   {
		       document.getElementById("progName_"+i).innerText=thisjson.progMenus[i+1].progName;
		   }
		   else
		   {
			   document.getElementById("progName_"+i).innerHTML="<marquee scrollamount='6'>"+thisjson.progMenus[i+1].progName+"</marquee>";
		   }
		}
		else
		{
			document.getElementById("progTime_"+i).innerText=thisjson.progMenus[i+1].progTime;
			document.getElementById("progName_"+i).innerText="";
		}
		//document.getElementById("time_"+i).innerText=thisjson.progMenus[i].progTime;
	}   
	hiddenTimer = setTimeout(hiddenFilmInfo,10000);
	showFilmInfoFlag = "true";
}

function getbytelength(str){
	var byteLen=0,len=str.length;
	if(str){
		for(var i=0;i<len;i++)
		{
		   if(str.charCodeAt(i)>255)
		      byteLen+=2;
		   else
		      byteLen++;
		}
	    return byteLen;
	}
	    return 0;
}
</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="transparent" onLoad="javascript:init();" onUnload="destoryMP();"  style="background:transparent;">
<div id="showMessageDiv" style="float:left; background-color:#999; height:80px; width:420px; margin-left:415px; margin-top:500px;text-align:center;z-index:4; display:none;">
   	<span id="testMsg" style="color:#000; font-size:28px; font-weight:bold;">本频道为付费频道，目前为免费体验期，正式收费将提前告知。</span>
</div>

<!--20130904 16:45 ZSZ 修改修复OSD上移bug-->
<div style="width:1px; height:1px; top:-1px; left:-1px;">
<a id="currentTime" href="#" style="position:absolute; width:1px; height:1px; top:0px; left:0px;"><img src="images/dot.gif" width="1" height="1"/></a>
</div>
<!--20130904 16:45 ZSZ 修改修复OSD上移bug-->

    <div id="tipText" style="background-color:#999; border:thin; position:absolute; left:328px; top:506px; width:500px; text-align:center; height:100px; line-height:45px; font-size:28px; color:#000;visibility:hidden;">尊敬的用户，您没有订购高清时尚包，无法观看此高清频道</div>
<!--数据封装-->
<div id="filmInfoDB">
  <iframe name="filmInfo" id="filmInfo" src="" scroll="no" height="1px" width="1px"></iframe>
</div>
<!--直播节目单OSD-->
<div id="filmInfo1"  style="position:absolute;left:843px; top:468px; width:425px; height:240px; display:none">
<!--    <div class="channel_msg">
		<!--  20130905 17:30 ZSZ 修改频道OSD样式-->
	    <!--<div class="num" id ="num" style="position:absolute;font-size:30px;top:20px;left:980px;"></div>-->
		<!--<div class="title" id="title"></div>
		<div class="mar">当前节目:</div>
		<div class="line"><img src="images/menu_line.png" /></div>
		<div class="mar" id="currprog"></div>
		<div class="line"><img src="images/menu_line.png" /></div>
		<div class="mar">节目单:</div>
		<div class="line" style="display:none;" ><img src="images/menu_line.png" /></div>
		<div class="mar" id="time_0"style="display:none;" ></div>
		<div class="line" style="display:none;" ><img src="images/menu_line.png" /></div>
		<div class="mar" id="progName_0" style="display:none;" ></div>
		<div class="line"><img src="images/menu_line.png" /></div>
		<div class="mar" id="time_1"></div>
		<div class="line"><img src="images/menu_line.png" /></div>
		<div class="mar" id="progName_1"></div>
		<div class="line"><img src="images/menu_line.png" /></div>
		<div class="mar" id="time_2"></div>
		<div class="line"><img src="images/menu_line.png" /></div>
		<div class="mar" id="progName_2"></div>
		<div class="line"><img src="images/menu_line.png" /></div>
		<div class="mar" id="time_3"></div>
		<div class="line"><img src="images/menu_line.png" /></div>
		<div class="mar" id="progName_3"></div>	
		<div class="line"><img src="images/menu_line.png" /></div>
		<div class="mar" id="time_4"></div>
		<div class="line"><img src="images/menu_line.png" /></div>
		<div class="mar" id="progName_4"></div>
   </div>-->
   
    <div class="list">
		<div class="txt txt-on" id="currprog"></div>
		<div class="txt" style="top:123px;">
            <div id="progTime_0" style="position:absolute; left:0px; top:0px;width:90px"></div>
            <div id="progName_0" style="position:absolute; left:90px; top:0px;width:225px"></div>
        </div>
		<div class="txt" style="top:155px;">
            <div id="progTime_1" style="position:absolute; left:0px; top:0px;width:90px"></div>
            <div id="progName_1" style="position:absolute; left:90px; top:0px;width:225px"></div>
        </div>
	</div>
</div>

<!--20130904 16:45 ZSZ 修改修复OSD上移bug-->
<div id="bottomframe" style="position:absolute;left:60px; top:530px; width:1200px; height:190px; z-index:1"></div>
<!--20130904 16:45 ZSZ 修改修复OSD上移bug-->

<!---------------------------------新UI 快进快退------修改遮字幕问题，20131015------------------------------->
<div id="speedDiv" class="control_panel control_panel3" style="visibility:hidden">
    <div id="currTime" class="playing_time" style="top:30px;"></div>
    <div id="statusImg" class="fasttime" style="top:30px;"><img src="images/playerimages/icon_fast.png" align="absmiddle"/> &nbsp;</div>
    <div id="beginTime" class="time1" style="top:65px;"></div>
    <div class="progressbar" style="top:80px;"><img src="images/playerimages/line3.png" /></div>
    <div id="speedPos" class="bar" style="left:200px; top:72px;"><img src="images/playerimages/bar.png" /></div>
    <div id="fullTime" class="time2" style="top:65px;"></div>
    <div id="Percent" class="playing_time" style="top:30px; left:120px"></div>
</div>       
<!---------------------------------新UI 快进快退------------------------------------->

<!---------------------------------新UI 定位------------------------------------->
<div id="seekDiv" style="visibility:hidden">  
  <div class="control_panel">
		<div id="seekCurrTime" class="playing_time" style="top:100px"></div>
		<div id="seekBeginTime" class="time11"></div>
		<div class="progressbar2"><img id="progressBar" src="images/playerimages/progressbarbg.jpg" /></div>
		<div class="bar2" id="seekPos" style="width:86px"><!--43px的倍数 总宽为903px--></div>
		<div id="seekFullTime" class="time22"></div>
  </div>
  
  <div class="control_panel2">
  		<div class="enter_time">
			<div>输入定位时间：</div>
            <div class="e1"><div id="hour" class="inp"></div></div>
            <div class="e2">时</div>
            <div class="e3"><div id="minute" class="inp"></div></div> 
            <div class="e4">分</div>
		</div>

        
        <div class="btns">	
			<div  id="jumpBtn">跳转</div>
			<div id="cancelBtn" style="left:200px;">取消</div>
	 	</div>
  </div>
</div>
<!---------------------------------新UI 定位------------------------------------->

<!---------时间输入错误提示------------>
<div id="timeErrorDIv" style="background:url(images/playerimages/popup_bg.png) no-repeat left;position:absolute;left:300px;top:170px;width:720px;height:380px;display:none;">
	<table border="0" cellspacing="0" cellpadding="0" width="100%" style="font-size:38px; color:#FFFFFF">
		<tr>
			<td height="115" align="center" >温馨提示</td>
		</tr>
		<tr >
			<td height="125" align="center" style="font-size:28px; color:#FFFFFF" id="infoText">您输入的时间超过影片时长，请重新输入!</td>
		</tr>
		<tr style="font-size:26px;">
			<td height="140" align="center">&nbsp;
				<div id="focus_bg" style="position:absolute;left:288px;top:268px;">
					<img src="images/playerimages/btn_bg.png" style="width:130px;height:39px;" />
				</div>
				<div style="left:315px;top:268px;position:absolute;font-size:36px;color:#ffffff;text-align:center;">确定</div>
			</td>
		</tr>
	</table>
</div>
<!----------时间输入错误提示----------->

<!--直播未定购显示-->
<div id="bg_noorder" style="position:absolute; right:500;top:60px; width:750px; height:135px; display:none"></div>
<div id="no_order" style="position:absolute; right:300;top:60px; width:750px; height:135px; display:none">
  <table width="750px" height="135px" border="0">
    <tr>
      <td  height="40"></td>
    </tr>
    <tr>
      <td id="orderInfo" width="750px" align="center"></td>
    </tr>
    <tr>
      <td id="showmessage" width="750px" align="center"></td>
    </tr>
    <tr>
      <td  height="40"></td>
    </tr>
  </table>
</div>
<!--直播未解锁显示
<div id="bg_lockpass"  style="position:absolute;left:355px; top:60px; width:300px; height:135px; z-index:-1; display:none"> 
<img src="#" border="0" width="300px" height="135px" /> </div>
<div id="lock_pass" style="position:absolute;left:355px; top:60px; width:300px; height:135px; z-index:2; display:none">
  <form action="">
    <table width="300px" height="135px" border="0">
      <tr>
        <td width="300px" height="35"></td>
      </tr>
      <tr>
        <td id="passInfo" width="300px" height="30" align="center"></td>
      </tr>
      <tr>
        <td width="355" height="35" align="center"><input maxlength="12" type="password" height="20px" width="180px" name="pwd" id="pwd">
        </td>
      </tr>
      <tr>
        <td width="300px" height="50" align="center"></td>
      </tr>
    </table>
  </form>
</div>
-->

<!--直播列表div-->
<div id="channelListDIV" style="display:none">
<div class="wrapper">
<div class="hd-left">
		<div class="logo"><img id="logoImag" src="#" /></div>
		
		<div class="nav">
			<!--焦点 
					class="item item_focus"
				-->
			<div class="item" id="chan_0">
				<div class="txt" id="chanName_0">CCTV-3</div>
			</div>
			<div class="btn" id="isPlayBack_0" style="display:none">回看</div>
			<div class="item" id="chan_1" style="top:35px;">
				<div class="txt" id="chanName_1">CCTV-5</div>
			</div>
            <div class="btn" id="isPlayBack_1" style="top:48px;display:none">回看</div>
			<div class="item" id="chan_2" style="top:70px;">
				<div class="txt" id="chanName_2">CCTV-6</div>
			</div>
            <div class="btn" id="isPlayBack_2" style="top:83px;display:none">回看</div>
			<div class="item" id="chan_3" style="top:105px;">
				<div class="txt" id="chanName_3">CCTV-7</div>
			</div>
            <div class="btn" id="isPlayBack_3" style="top:118px;display:none">回看</div>
		</div>
		
		<div class="poster">
			<!--焦点 
					class="item item_focus"
				-->
			<div class="item" id="chan_4">
				<div class="pic"><img id="post_0" src="#" /></div>
			</div>
			<div class="item" id="chan_5" style="top:98px;">
				<div class="pic"><img id="post_1" src="#" /></div>
			</div>
		</div>
	</div>
</div>
<!--   <div id="chan_info" class="channel_choose"></div>-->
</div>

<!-- 右上显示直播号-->
<div id="topframe" style="position:absolute;left:425px; top:8px; width:300px; height:70px; z-index:1"></div>
<div id="topframe_bottomLine" style="position:absolute;left:675px; top:10px; width:300px; height:70px; z-index:2"></div>

<!--预览提示信息-->
<div id="preview" style="position:absolute;left:250px; top:60px; width:350px; height:135px; z-index:-1; display:none;"> 
<img src="#" border="0" width="350px" height="135px" /> </div>
<div id="previewInfo" style="position:absolute;left:250px; top:60px; width:350px; height:135px; z-index:-1; display:none;">
  <table width="350" height="135px" border="0">
    <tr>
      <td id="showPreviewInfo" width="350" align="center"></td>
    </tr>
  </table>
</div>
<div id="errorBackGround" style="position:absolute; left:150x; top:100px; width:350px; height:80px; z-index:-1; display:none">
 <img src="#" border="0" width="350px" height="80"> </div>
<!--系统错误提示-->
<div id="errorDiv" style="position:absolute; left:120px; top:315px; width:400px; height:70px; z-index:1;display:none">
 <img src="#" width="400px" height="70px"/> </div>
<div id="errorDiv" style="position:absolute; left:120px; top:315px; width:400px; height:80px; z-index:1;display:none">
  <table width="400px" height="80" border="0">
    <tr>
      <td width="400px" align="center">系统错误，请切换直播或稍候再试！</td>
    </tr>
  </table>
</div>
<div style="position:absolute; left:15px; top:15px; width:54px; height:66px; z-index:3;"><img id="voice" src="images/dot.gif"/></div>
<!--解决一键跳转层出现时，解锁层焦点问题-->
<a id="none" href="#"><img src="#"  width="1px" height="1px"> </a>
<div style="display:none;">
<img src ="images/playerimages/up.png"/>
<img src ="images/playerimages/down.png"/>
<img src ="images/playerimages/up_gray.png"/>
<img src ="images/playerimages/down_gray.png"/>
<img src ="images/playerimages/menu_line.png"/>
<img src ="images/playerimages/channel_OSD_lbg.png"/>
<img src ="images/playerimages/progressbar.png"/>
<img src ="images/playerimages/control_bbg2.png"/>
<img src ="images/playerimages/control_bbg.png"/>
</div>
</body>
</html>
