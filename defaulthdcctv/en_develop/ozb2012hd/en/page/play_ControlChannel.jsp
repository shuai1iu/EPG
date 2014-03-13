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
private static int ROWS = 13;               //的行数（每页）
private static int COLS = 1;				//显示的列数（每页）
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
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>play_Controlchannel</title>
<style type="text/css">
body { font-family:"黑体"; font-size:30px; color:#FFFFFF;margin:0px;padding:0px;width:1280px; height:720px}
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,p,th,td {margin:0; padding:0}
img {border:0; margin:0}
table{border:0;*border-collapse:collapse; border-spacing:0}
body td{
	font-family:"黑体";
	font-size: 26px;
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
	left: 168px;
    font-size: 24px;
	color:#FFFFFF;	
}
.channel_choose{ position:absolute;left:0px top:0; background:url(../images/play/channel_OSD_lbg.png) repeat-y; width:405px; height:720px;}
.sub{ height:46px; line-height:46px; padding-left:35px}
.on{ background:url(../images/play/channel_sub2on.png) no-repeat;padding-left:35px; height:46px;;line-height:46px; }
</style>
</head>
<script language="javascript">
if (typeof(iPanel) != 'undefined')
{
	iPanel.focusWidth = "4";
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
var chanListFocus = -1;//直播列表的当前索引1-
var totalChannel = -1;//直播总个数
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
var pr2 = null;//提交直播控制信息
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
var isControlled = new Array();//是否有父母控制
var channelCode = new Array();//直播的MediaCode
var isSubPreview = new Array();//是否支持预览
var upPageToLastIndex = false ;//按向上键到前一面的最后一条数据
var positionFlag = 0; //记录页面焦点位置
var quitDivIsShow = false; //退出层是否显示标志位
var jumpDivIsShow = false;
var seekDivIsShow = false;//进度条及跳转框
var volumeDivIsShow = false;//音量层
var STBType =Authentication.CTCGetConfig("STBType");
var isSeeking = 0;
var isJumpTime = 1;
var jumpDIvPos = 4;//4:进度条 0：时 1:分 2：跳转 3：取消
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
var shiftFlag = 0;    // 时移标志位
var timeID_check = 0;
var premode; //记录上次mod是否为3 
var voiceflag="";
var voiceIsShow=false;
var mp = new MediaPlayer();
var strchannelNum='<%=strChannelNum%>';
var chennelNum=parseInt(strchannelNum);
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
	loadData();
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
		case <%=KEY_0%>:inputNum(0);break;
		case <%=KEY_1%>:inputNum(1);break;
		case <%=KEY_2%>:inputNum(2);break;
		case <%=KEY_3%>:inputNum(3);break;
		case <%=KEY_4%>:inputNum(4);break;
		case <%=KEY_5%>:inputNum(5);break;
		case <%=KEY_6%>:inputNum(6);break;
		case <%=KEY_7%>:inputNum(7);break;
		case <%=KEY_8%>:inputNum(8);break;
		case <%=KEY_9%>:inputNum(9);break;
		case <%=KEY_CHANNEL_UP%>:addChannel(); break;//加直播
		case <%=KEY_CHANNEL_DOWN%>:decChannel();break;//减直播
		case <%=KEY_RIGHT%>:pressRight();return false;
		case <%=KEY_LEFT%>:pressLeft();return false;
		case <%=KEY_DOWN%>:arrowDown();return false;	
		case <%=KEY_UP%>:arrowUp();return false;
		case <%=KEY_PAGEDOWN%>:pageDown();return 0;break;
		case <%=KEY_PAGEUP%>:pageUp();break;	
		case <%=KEY_VOL_UP%>:volumeUp();return false; 
		case <%=KEY_VOL_DOWN%>:volumeDown();return false;
		case <%=KEY_MUTE%>:setMuteFlag();return false; //静音键
		case <%=KEY_STOP%>:stopKey();break;
		case <%=KEY_RETURN%>:pressReturn();break;//返回键
		case <%=KEY_GO_BEGINNING%>:break;			
		case <%=KEY_OK%>:pressOK();break;
		case <%=KEY_IPTV_EVENT%>:goUtility();break;
		case <%=KEY_SWITCH%>:break;//喜爱键			
		case <%=KEY_INFO%>:
		case <%=KEY_BLUE%>:
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
	   //case 277:
	   case  1109:
			mp.stop();window.location.href="dibbling.jsp"; return 0;	   
	   //case 276:
	   case 1110:
			mp.stop();window.location.href="playback.jsp";return 0;
		//case 275:
		case 1108:
		    mp.stop(); window.location.href="channel.jsp"; return 0;
		case 1111://通信
			return 0;
		//case 278://蓝色键信息
		default:
			return videoControl(keyval);
	}
	return true;
}
function pressReturn()
{
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
	clearTimeout(voiceflag);
	switch(audio)
	{
		case 0:$("voice").src="../images/play/leftvoice.png";break;
		case 1:$("voice").src="../images/play/rightvoice.png";break;
		case 2:$("voice").src="../images/play/centervoice.png";break;
		default:break;
	}
	voiceflag=setTimeout(function(){$("voice").src="../images/dot.gif";},5000);
}
function setMuteFlag()
{
	if(mediaErrorFlag == "true" || lockFlag == "true" || isNotSubFlag == "true"){return;}
	if("false" == channelListFlag){clearTimeout(channelListTimer);hiddenChannelList();}
	clearTimeout(showTimer);showTimer = "";
	clearTimeout(bottomTimer);bottomTimer = ""; 
	voiceIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){
		mp.setMuteFlag(0);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
		{
			$("voice").src="../images/play/muteoff.png";
			bottomTimer = setTimeout(hideMute, 5000);
		}
	}else{
		mp.setMuteFlag(1);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
		{
			$("voice").src="../images/play/muteon.png";
			//bottomTimer = setTimeout(hideMute, 5000);
		}
	} 
	if(volumeDivIsShow){hideBottom();}    
}
function hideMute()
{
	$("voice").src="#";
	voiceIsShow=false;
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
	if(mediaErrorFlag == "true" || lockFlag == "true" || isNotSubFlag == "true" || oneKeySwitchJumpInfoIsShow == true){return;}
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
	if(volume < 0){volume = 0; return;  }
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
	if(mediaErrorFlag == "true" || lockFlag == "true" || isNotSubFlag == "true" || oneKeySwitchJumpInfoIsShow){return;}
	if("false" == channelListFlag){clearTimeout(channelListTimer);hiddenChannelList();}
	if(seekDivIsShow){
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
	volume += 5;
	if(volume > 100){volume = 100;  return; }
	mp.setVolume(volume);  
	if(mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
	{
		clearTimeout(bottomTimer);
		bottomTimer = "";
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
	tableDef += '<td width="20px"></td><td width="40px"><img src="../images/playcontrol/playChannel/volume.gif"></td><td width="40px" style="color:white;font-size:28">' + volume + '</td>';
	tableDef += '</tr></table>'; 
	$("bottomframe").innerHTML = tableDef;    	
}

function hideJumpTimeDiv()
{    	
	clearTimeout(timeID_jumpTime);
	timeID_jumpTime = "";
	jumpDivIsShow = false;
	var inputValueHour = $("jumpTimeHour").value;
	var inputValueMin = $("jumpTimeMin").value;
	 // 如果输入发生变化，则不作隐藏
	 if(preInputValueHour != inputValueHour || preInputValueMin != inputValueMin){return;}
	//如果文本框中有一个值为空，隐藏div
	if(isEmpty(inputValueHour) || isEmpty(inputValueMin))
	{
		 isJumpTime = 0;
		 $("jumpTimeHour").blur(); $("jumpTimeMin").blur();
		 $("jumpTimeDiv").style.display = "none";
		 $("jumpTimeImg").style.display = "none";
	}
	//如果文本框中有值则调用clickJumpBtn方法
	else{clickJumpBtn();   }
	count=0;
	jumpDIvPos=0;
	$("currentTime_progress").style.background="url(../images/play/chanMini_lostTimePro.png)";
	$("jumpTimeHour").focus();
}
function checkJumpTime(pHour, pMin)
{    
	if(isEmpty(pHour)||!isNum(pHour)||isEmpty(pMin)||!isNum(pMin)||parseInt(pHour)>=24||parseInt(pMin)>=60||!isInMediaTime(pHour, pMin)){return false;}
	else{return true;}
}
 //判断是否在播放时长内
function isInMediaTime(pHour, pMin)
{
	var currTime = new Date();   
	var inputTime = new Date();    
	var shiftLength = mp.getMediaDuration();   
	var beginTime = new Date(currTime.getTime() - shiftLength * 1000);// 如果读到时间为零则取1小时
	pHour = pHour.replace(/^0*/, "");
	if(pHour == ""){pHour = "0";}
	pMin = pMin.replace(/^0*/, "");        
	if(pMin == ""){pMin = "0";}
	
	//跨天
	if((beginTime.getDate())!=(currTime.getDate()) && (parseInt(pHour))<24)
	{
	    var InputDate=inputTime.getDate();
	    inputTime.setDate(parseInt(InputDate)-1);
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
function clickJumpBtn()
{    	
	var inputValueHour = $("jumpTimeHour").value;
	var inputValueMin = $("jumpTimeMin").value;
	var timeJump=getShiftBeginTime();
	var hourJump=timeJump.substring(0,2);
	var minJump=timeJump.substring(3,5);
	if(inputValueHour==""){ inputValueHour="00";}
	if(inputValueMin==""){inputValueMin="00";	}
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
		$("jumpTimeDiv").style.display = "none";
		$("jumpTimeImg").style.display = "none";
		$("jumpTimeHour").value = "";
		$("jumpTimeMin").value = "";
		jumpToTime(timeStamp);
	}else{        	
		$("jumpTimeHour").value = "";
		$("jumpTimeMin").value = "";
		$("timeError").innerHTML = "时间输入不合理，请重新输入！&nbsp;&nbsp;&nbsp;&nbsp;";
		jumpDIvPos = 0;	   
		preInputValueHour = "";
		preInputValueMin = "";		
		$("jumpTimeHour").focus();		
		//15秒后隐藏跳转输入框所在的div"
		clearTimeout(timeID_jumpTime);timeID_jumpTime = "";		
		//timeID_jumpTime = setTimeout(hideJumpTimeDiv,15000);
	}
	count=0;
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
	var type = 2;
	speed = 1;
	playStat = "play"; 
	mp.playByTime(type,beginTime,speed);
	count=0;
	jumpDIvPos=0;
	$("currentTime_progress").style.background="url(../images/play/chanMini_lostTimePro.png)";	
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
function checkSeeking()
{
	if(isSeeking == 0){clearTimeout(timeID_check);timeID_check = "";}
	else{
		//下面一行代码的作用：获取不到文本框中的值，动态刷新文本框所在div可以解决
		if(playStat != "fastrewind" && playStat != "fastforward")
		{
			$("statusImg").innerHTML = '<img src="../images/play/pause.png" width="40" height="40"/>';
		}
		var inputValueHour = $("jumpTimeHour").value;
		var inputValueMin = $("jumpTimeMin").value;
		if(2==inputValueHour.length && 0==jumpDIvPos ){$("jumpTimeMin").focus();jumpDIvPos=1;}
		if(2==inputValueMin.length && 1==jumpDIvPos ){$("ensureJump").focus();jumpDIvPos=2;}
		clearTimeout(timeID_check);
		timeID_check = setTimeout(checkSeeking,500);
		if(playStat == "fastrewind" || playStat == "fastforward")
		{	
			currTime = mp.getCurrentPlayTime(); processSeek(currTime);			
		}
		if(preInputValueHour != inputValueHour || preInputValueMin != inputValueMin)
		{
			var tempTimeID = timeID_jumpTime;
			clearTimeout(tempTimeID);tempTimeID = "";
			timeID_jumpTime = setTimeout(hideJumpTimeDiv,15000);
			preInputValueHour = inputValueHour;
			preInputValueMin = inputValueMin;
		}
	}
}
function displaySeekTable()
{
	//mediaTime = mp.getMediaDuration(); 
	// 如果读到时间为零则取1小时
	//timePerCell = mediaTime / 100;
	//isSeeking等于0时展示进度条及跳转框
	if(isSeeking == 0){
		isSeeking = 1;
		currTime = mp.getCurrentPlayTime(); 
		processSeek(currTime);
		//$("fullTime").innerHTML = getCurrTime();
		//$("beginTime").innerHTML = getShiftBeginTime();
		//$("statusImg").innerHTML = '<img src="../images/playcontrol/playChannel/pause.png" width="40" height="40"/>';
		$("seekDiv").style.display = "block";		
		jumpDIvPos=4;
		$("currentTime_progress").style.background="url(../images/play/chanMini_timePro.png)";
		clearTimeout(timeID_jumpTime);
		timeID_jumpTime = "";  
		checkSeeking();//调用方法检测进度条及跳转框的状态
		seekDivIsShow = true;jumpDivIsShow = true;
	}else{ 	
		$("seekDiv").style.display = "none";
		clearTimeout(timeID_check);timeID_check = "";//清空检查进度条的定时器	
		resetPara_seek();//复位各参数	
		seekDivIsShow = false;
		jumpDivIsShow = false;
		jumpDIvPos = 4;
	}
}
//跳转提示信息隐藏后，重置相关参数
function resetPara_seek()
{
	clearTimeout(timeID_jumpTime);timeID_jumpTime = "";//清空隐藏跳转hideJumpTimeDiv
	isSeeking = 0;
	isJumpTime = 1;
	preInputValueHour = "";
	preInputValueMin = "";
	//$("jumpTimeDiv").style.display = "block";
   // $("jumpTimeImg").style.display = "block";
	$("jumpTimeHour").value = "";
	$("jumpTimeMin").value = "";
	$("timeError").innerHTML = "";
	$("statusImg").innerHTML = '<img src="../images/play/pause.png" width="40" height="40"/>';
}
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
	$("seekPercent").innerHTML =  currCellCount + "%";
	var maxTime2 = getCurrTime2();
	var maxTime=getCurrTime();
	var tmp12 = getCurrPlayTime2(currPlayTime);  
	var tmp1=getCurrPlayTime(currPlayTime); 
	var tmp22 = getShiftBeginTime2();
	var tmp2 = getShiftBeginTime();
	// 规避当前时间显示小于时移开始时间的问题
	if (tmp12 < tmp22){tmp1 = tmp2;}
	if(tmp12 > maxTime2){tmp1 = maxTime;}
	$("currTimeShow").innerHTML = tmp1;
	$("fullTime").innerHTML = maxTime;
	$("beginTime").innerHTML = tmp2;
	$("td_0").style.width = currCellCount * 10;
	$("td_0").bgColor =  "#DAA520";
	$("td_1").style.width = 1000 - currCellCount * 10;
	$("td_1").bgColor =  "#000080";
	$("currentTime_progress").style.left = 123 + currCellCount * 10;
}
//暂停键
function pauseOrPlay()
{	
	//时移状态: 1激活 0去激
	if(pltvStatus[currChannelIndex] == 0 ){return;}
	business_type = back_type;
	clearTimeout(showTimer);showTimer = "";
	if("false"==channelListFlag){hiddenChannelList();}
	if("true" == infoFlag){hiddenFilmInfo();}
	if(volumeDivIsShow){hideBottom();}
	if("play"==playStat){displaySeekTable(); pause(); jumpDivIsShow = true;}
    else{ displaySeekTable();resume(); }
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
	//if(speed >= 32 && playStat == "fastrewind"){displaySeekTable();resume();return 0;}//深圳要求循环
	if(isSeeking == 0)
	{
		if(pltvStatus[currChannelIndex] == 0||mediaErrorFlag == "true" || lockFlag == "true" || isNotSubFlag == "true"){return; }	
		if(volumeDivIsShow){hideBottom();}
		if("false" == channelListFlag){clearTimeout(channelListTimer);hiddenChannelList();}
		if(infoFlag == "true"){hiddenFilmInfo();}
		business_type = back_type;
		shiftFlag=1;
		clearTimeout(showTimer);showTimer = "";		
		displaySeekTable();clearTimeout(timeID_jumpTime);timeID_jumpTime = "";isJumpTime = 0;
	}	
	if(playStat == "fastforward" || (playStat == "fastrewind" && speed >= 32)) {speed = 1;}
	speed = speed * 2;
	$("statusImg").innerHTML = '<img src="../images/play/fastRewind.png" width="20" height="20"/>&nbsp;X' + speed; 
	mp.fastRewind(-speed);  
    playStat = "fastrewind"; 
}
//快进
function fastForward()
{ 		    
	//if(speed >= 32 && playStat == "fastforward"){displaySeekTable();resume(); return 0;}//深圳要求循环
    if(isSeeking == 0)
	{	
		if(pltvStatus[currChannelIndex] == 0|| 0== shiftFlag || mediaErrorFlag == "true" || lockFlag == "true" || isNotSubFlag == "true"){  return;}
		if(volumeDivIsShow){hideBottom();}
		if("false" == channelListFlag){hiddenChannelList();}
		if("true" == infoFlag){hiddenFilmInfo();}    
		displaySeekTable();clearTimeout(timeID_jumpTime);timeID_jumpTime = "";isJumpTime = 0;	
		//$("jumpTimeDiv").style.display = "none";
		//$("jumpTimeImg").style.display = "none";
	}
	if(playStat == "fastrewind" ||(playStat == "fastforward" && speed >= 32)) {speed = 1;  }      	            	
	speed = speed * 2;
	$("statusImg").innerHTML = '<img src="../images/play/fastForward.png" width="20" height="20"/>&nbsp;X'+speed;
	mp.fastForward(speed);
	playStat = "fastforward";
}
//事件响应
function goUtility()
{
	if(disLockFlag == 1){ return;}
	eval("eventJson = " + Utility.getEvent());
	var typeStr = eventJson.type;
	switch(typeStr)
	{  
		case "EVENT_MEDIA_ERROR":mediaError(eventJson);break;
		case "EVENT_PLAYMODE_CHANGE":resumeMediaError(eventJson);break;		  
		case "EVENT_PLTVMODE_CHANGE": playModeChange(eventJson); return false;
		case "EVENT_TVMS":getTvms(eventJson); return false;
		case "EVENT_TVMS_ERROR":top.TVMS.closeMessage();top.TVMS.setKeyForSTB();return false;
		case "EVENT_MEDIA_BEGINING":
			 $("seekDiv").style.display = "none";
			 isSeeking = 0;
			 speed = 1;
			 jumpDivIsShow = false;
			 seekDivIsShow = false;
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
//切换直播
function joinChannel(chanNum)
{	
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
		mp.joinChannel(chanNum);
	}
	//恢复流
	isLeaveChannelFlag = "false";	
	setFocus(currChannelIndex);
	//新直播播放前需要重新设置miniEPG显示
	if("true" == showFilmInfoFlag){showInfo();}
	clearTimeout(showTimer);
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
	//如果一键跳转层显示，就先退出层
	if(oneKeySwitchJumpInfoIsShow){hideOneKeySwitchJumpInfo();}
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
	//如果一键跳转层显示，就先退出层
	if(oneKeySwitchJumpInfoIsShow){hideOneKeySwitchJumpInfo();return;}
	//如果是时移状态的话，先切换到直播状态
	if(business_type == back_type)
	{
		if(seekDivIsShow)
		{	
			$("seekDiv").style.display = "none";
			seekDivIsShow = false;
			count=0;
			jumpDIvPos=0;
			$("currentTime_progress").style.background="url(../images/play/chanMini_lostTimePro.png)";
		}
		business_type = live_type;
		mp.gotoEnd();
		return;
	}
	else  //退出提示层
	{
		stopChannel();
		resetQuitDiv();
		setTimeout(showQuitDiv,200);
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
	filmInfo.location.href = "play_ControlChannelListTv.jsp?CHANNELID="+channelId+"&CHANNELNUM="+currChannelNum+"&COMEFROMFLAG="+comeType;
}	
//向下键
function arrowDown()
{
	if(quitDivIsShow){return;}
	//直播列表显示的时候，处理按键
	if("false" == channelListFlag)
	{	
		if(chanListFocus%13 == 12|| chanListFocus == totalChannel){pageDown();return;}
		addChannelList();
		return;
	}
	else if(jumpDivIsShow && jumpDIvPos==4)
	{
		jumpDIvPos=0;
		$("jumpTimeHour").focus();
		$("currentTime_progress").style.background="url(../images/play/chanMini_lostTimePro.png)";
		return;
	}
	decChannel();
}	
//向下切直播 函数中注意先后顺序
function decChannel()
{
	if(quitDivIsShow||oneKeySwitchJumpInfoIsShow||jumpDivIsShow || seekDivIsShow){return;}
	//离开上一个直播
	stopChannel();
	//是否直播是第一个直播，如果是应该切到最后一个直播
	if(0 == currChannelIndex){currChannelIndex = totalChannel;}
	else{currChannelIndex--;}
	lockPlay = "true";
	if("false" == lockPlay)
	{	
		if(totalChannel == currChannelIndex){currChannelIndex = 0;}//是否直播是最后一个直播，如果是应该切到第一个直播
		else{currChannelIndex++;}
		return;
	}
    joinChannel(channelNums[currChannelIndex]);
}	
//向上键
function arrowUp()
{
	if(quitDivIsShow){return;}
	//直播列表显示的时候，处理按键
	if("false" == channelListFlag)
	{	
		if(chanListFocus%13 == 0){upPageToLastIndex = true ;pageUp();return;}
		decChannelList();
		return;
	}
	if(jumpDivIsShow)
	{
		if(jumpDIvPos<4){resetJumpDiv();}
		jumpDIvPos=4;
		$("currentTime_progress").style.background="url(../images/play/chanMini_timePro.png)";		
		return;
	}
	addChannel();
}	
function resetJumpDiv()
{
	if(0==jumpDIvPos){ $("jumpTimeHour").blur();}
	else if(1==jumpDIvPos){ $("jumpTimeMin").blur();}
	else if(2==jumpDIvPos || 3==jumpDIvPos){ $("jumpTimeHour").blur();}
}
//直播列表下键切直播 函数中注意先后顺序
function addChannelList()
{
	freeFocus(chanListFocus);
	//是否直播是最后一个直播，如果是应该切到第一个直播
	if(totalChannel == chanListFocus){chanListFocus = 0;}
	else{chanListFocus++;}
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
	if(0 == chanListFocus){chanListFocus = totalChannel;}
	else{chanListFocus--;}
	setFocus(chanListFocus);
	//如果锁存在，则直播列表一直存在
	isHaveLock();
	if("true" == lockFlag){hiddenLockInfo();}
}	
//向上切直播 函数中注意先后顺序
function addChannel()
{
	if(quitDivIsShow||oneKeySwitchJumpInfoIsShow||jumpDivIsShow || seekDivIsShow){return;}
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
//miniEPG数据
function showInfo()
{	
	miniInfo.location.href = "play_ControlChannelminiInfo.jsp?CHANNELID=" + channelIds[currChannelIndex] + "&pltvStatusFlag=" + isSubPreview[currChannelIndex];
}	
//右边的OSD miniEPG显示
function shwoFilmInfo()
{	
	if( playStat=="fastforward" || playStat=="fastrewind"){ clearTimeout(showTimer);showTimer = "";resume();}
	if(0 == bottomLineNum){showChannelNum();}//直播下划线存在的时候不显示
	if(jumpDivIsShow){hideJumpTimeDiv();resume();}
	if(volumeDivIsShow){hideBottom();}
	if(seekDivIsShow){$("seekDiv").style.display = "none";resume();}
	$("filmInfo1").style.display = "block";
	infoFlag = "true";
	hiddenTimer = setTimeout(hiddenFilmInfo,5000);
}	
//miniEPG隐藏
function hiddenFilmInfo()
{
	clearTimeout(hideNumTimer);
	hideChannelNum();//隐藏直播号
	$("filmInfo1").style.display = "none";
	infoFlag = "false";
}	
//信息健
function infoKey()
{	
	if(playStat!= "play"){	resume();}
    if("false"==infoFlag ){
		clearTimeout(showTimer);clearTimeout(hiddenTimer);				
		if("true" == getDataFlag){setTimeout(showInfo,800);shwoFilmInfo();}
	}else{	
		hiddenFilmInfo();clearTimeout(hiddenTimer);	
	}
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
	var chaninfo = "";
	if(currListPage>0){
		chaninfo = "<div align='center'><img src='../images/play/up.png'/></div>";
	}else{
		 chaninfo = "<div align='center'><img src='../images/play/up_gray.png'/></div>";
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
		chaninfo+="<div><img src='../images/menu_line.png'/></div>";
	}
	if(currListPage<totalListPages-1){
		chaninfo += "<div align='center'><img src='../images/play/down.png'/></div>";
	}else{
		 chaninfo += "<div align='center'><img src='../images/play/down_gray.png'/></div>";
	}
	$("chan_info").innerHTML = chaninfo;	
}	
 //加载直播列表
function init_data()
{
	create_chanTable();
}	
//释放焦点选择
function freeFocus(curr_focus)
{
	var focusAt = curr_focus%13;
	$("chan_"+focusAt).className="sub";
}	
//获得焦点选择
function setFocus(curr_focus)
{
	var focusAt = curr_focus%13;
	$("chan_"+focusAt).className="on";
}	
function gotoEnd()
{
	if(pltvStatus[currChannelIndex] == 0||mediaErrorFlag == "true" || lockFlag == "true" || isNotSubFlag == "true"){return;}
	if("false" == channelListFlag){clearTimeout(channelListTimer);hiddenChannelList();}
	if ("true"==infoFlag){hiddenFilmInfo();}
	shiftFlag = 0;  // 规避一键到尾不能收到MEDIA_END的问题    	
	resumestat();
	//pr.endShift();
	goEnd();
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
	if (isSeeking == 1){displaySeekTable();}     
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
		chanReload1();
		chanListFocus = currListPage*13;
		setFocus(chanListFocus);		
		isHaveLock();	//如果锁存在，则直播列表一直存在
	}
}	
 //上翻页
function pageUp()
{
	//直播列表不显示，按翻页键没用
	if("true" == channelListFlag){gotoStart();}
	else{
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
		else{chanListFocus = currListPage*13;}
		setFocus(chanListFocus);
		isHaveLock();//如果锁存在，则直播列表一直存在
	}
}
function gotoStart()
{
	if(pltvStatus[currChannelIndex] == 0||mediaErrorFlag == "true" || lockFlag == "true" || isNotSubFlag == "true"){return; }
	if("false" == channelListFlag){clearTimeout(channelListTimer);hiddenChannelList();}
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
	init_data();
}
//ok键
function pressOK()
{	
	if( playStat=="fastforward" || playStat=="fastrewind"){resume();}
	currentTime = mp.getCurrentPlayTime();
	if(quitDivIsShow){return;}
	//如果显示就隐藏  channelListFlag true：已经隐藏 false:已经显示
	else if("false" == channelListFlag){		
	    //如果是当前播放的直播，并且不是在停流的情况下
		if(currChannelIndex == chanListFocus && "false" == isLeaveChannelFlag){hiddenChannelList();}
		else{		
			playByChannelList();	//直播列表上按ok键切换播
		}
	}
	else if(jumpDivIsShow && jumpDIvPos==4){
		//定时跳转播放
		playByTime(currTime);
		$("seekDiv").style.display = "none";
		isSeeking = 0;
		speed = 1;
	}else{
		if(jumpDivIsShow){return;}
		else if("true" == getDataFlag){showChannelList();}
	}
}	
//显示直播列表
function showChannelList()
{
	freeFocus(chanListFocus);
	chanListFocus = currChannelIndex;
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
	return parseInt(currpage,13);
}	
//根据索引判断当前是第几页
function realCurrPage()
{
	if(chanListFocus % 13 == 0){currListPage = chanListFocus / 13;}
	else{currListPage = getInt(chanListFocus / 13);}
}	
//直播列表层显示
function showChannelListDiv()
{	
    if(jumpDivIsShow || seekDivIsShow||"false"==channelListFlag){return;}
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
	var tabdef = '<table width=200 height=30><tr align="right"><td><font color=green size=20>';
	tabdef += num;
	tabdef += '</font></td></tr></table>';
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
	if(quitDivIsShow||getDataFlag=="false"||oneKeySwitchJumpInfoIsShow||"false" == channelListFlag||number * 10 >= 10000){return;}
	if(bottomLineNum !=0)
	{
		clearTimeout(bottomLineHideTime);
		bottomLineHideTime = setTimeout(hideBottomLine,<%=DEFAULT_HIDEINFO_TIME%>);
		if(numCount >= bottomLineNum ){return;}
	}
	if(numCount >= 4||jumpDivIsShow||seekDivIsShow){return;}
	numCount++;
	tempNumber = tempNumber+""+i;
	number = number * 10 + i;
	channelNumAction(tempNumber);
	clearTimeout(timeID);
	timeID = setTimeout("playByChannelNum("+ number +")", 3000);// 一秒钟之后切换直播
}	
//用户输入的直播号时的处理
function playByChannelNum(chanNum)
{
	//是否是通过下划线切换
	if(bottomLineNum !=0)
	{
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
	clearTimeout(hiddenDiv);
	hiddenDiv = setTimeout(clearDiv,1500);
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
	else if(oneKeySwitchJumpInfoIsShow){commonPressKeyRight();}
	else if(jumpDivIsShow){
			if(jumpDIvPos == 0){
				$("jumpTimeMin").focus();jumpDIvPos ++;	
			}else if(jumpDIvPos == 1){
				$("ensureJump").focus(); jumpDIvPos ++;
			}else if(jumpDIvPos == 2){
				$("cancelJump").focus(); jumpDIvPos ++;		
			}else if(jumpDIvPos==4){
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
	else if(jumpDivIsShow){
			if(jumpDIvPos == 1){
				$("jumpTimeHour").focus();jumpDIvPos --;
			}else if(jumpDIvPos == 2){
				$("jumpTimeMin").focus(); jumpDIvPos --;				
			}else if(jumpDIvPos == 3){
				$("ensureJump").focus();  jumpDIvPos --;			
			}else if(jumpDIvPos==4){
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
   var t=Date.parse(T)+30*count*1000;   
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
		$("quit").focus();  positionFlag--;  return;
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
	if(oneKeySwitchJumpInfoIsShow||"false" == channelListFlag){return;}
	clearTimeout(hideNumTimer);
	hideChannelNum();
	if(bottomLineHideTime != ""){clearTimeout(bottomLineHideTime);}
	if(bottomLineNum < bottomLineAllNum){bottomLineNum++;}
	else{bottomLineNum = 0;}
	var strBottom = '<table width=200 height=30><tr align="right"><td><font color="green" size="20"  height="10" style="font-weight:900">';
	for(var i = 0; i < bottomLineNum; i++)
	{
		strBottom += '_';
	}
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
	//如果一键跳转层显示，就先退出层
	if(oneKeySwitchJumpInfoIsShow){hideOneKeySwitchJumpInfo();}
	//清空预览提示
	if(preDivIsShow){hiddenPreview();	}
	//清空层
	if("true" == isNotSubFlag){clearDiv();}
	//清空锁控制层
	if("true" == lockFlag){hiddenLockInfo();}
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
	else if(getDataFlag == "true"){stbNoThisChannel(channelNums[currChannelIndex]);}
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
		if(oneKeySwitchJumpInfoIsShow)
		{
			hideOneKeySwitchJumpInfo();	
		}
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
	
</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="transparent" onLoad="javascript:init();" onUnload="destoryMP();"  style="background:transparent;">

<div style="width:1px; height:1px; top:-1px; left:-1px;">
<a id="currentTime" href="#" style="width:1px; height:1px; top:0px; left:0px;"><img src="../images/dot.gif" width="1" height="1"/></a>
</div>
<!--数据封装-->
<div id="filmInfoDB">
  <iframe name="filmInfo" id="filmInfo" src="" scroll="no" height="0px" width="0px"></iframe>
</div>
<!--直播节目单OSD-->
<div id="filmInfo1" style="position:absolute; left:920px; top:0px; width:360px; height:720px;display:none;z-index:97;">
  <iframe name="miniInfo" id="miniInfo" src="" scroll="no" width="360px" height="720px"></iframe>
</div>

<div id="bottomframe" style="position:absolute;left:60px; top:590px; width:1200px; height:190px; z-index:1"></div>

<!--进度条及跳转框所在的div begin-->
<div id="seekDiv" style="position:absolute;width:1280px;height:200px;left:0px;top:408px; z-index:1;display:none;">
  <!-- 进度条中显示的百分比 -->
  <div id="seekPercent" style="position:absolute;color:#FFFFFF;width:50px;height:20px;top:118px;left:640;z-index:1;"></div>
  <!--进度点-->
  <div id="currentTime_progress" style="position:absolute;left:345px;top:172px;width:23px;height:20px; z-index:1; background:url(../images/play/chanMini_lostTimePro.png);"></div>
  <!-- 进度条所在div -->
  <div style="position:absolute; background:url(../images/play/control_bbg.png) repeat-x; width:100%; height:237px;left:0;top:80;z-index:-1;"></div>
  
  <div style="position:absolute;width:1280;height:237px;left:0;top:110;z-index:1;color:white;">
    <table width="1280" height="100" border="0" cellpadding="0" cellspacing="0">
      <tr height="40">
        <td></td>
        <td height="20"><table width="940" border="0" cellpadding="0" cellspacing="0" >
            <tr>
              <!-- 当前时间 -->
              <td id="currTimeShow" width="268" valign="middle" align="right" style="color:#FFF"></td>
              <!-- 当前播放状态-->
              <td id="statusImg" height="20" align="right" style="color:#FFF"></td>
              <td width="5"></td>
            </tr>
          </table></td>
        <td></td>
      </tr>
      <tr  style="color:#FFF">
        <td width="105" height="45" valign="middle" align="center" style="color:#FFF" id="beginTime"></td>
        <td width="1000"  valign="middle" align="center"  height="45">
			<table width="" height="" border="0" cellpadding="0" cellspacing="0">
				<tr>
				  <!-- 进度条-->
				  <td id="seekTable" width="" height="20" style="color:#FFF"></td>
				</tr>
			  </table>
		  </td>
        <td width="105" valign="middle" align="center" id="fullTime" style="color:#FFF"></td>
      </tr>
    </table>
  </div>
  
  <!-- 跳转框所在div -->
<div id="jumpTimeImg" style="position:absolute; width:100%; height:220px;left:0;top:72;z-index:-3;"></div>
  <div id="jumpTimeDiv" style="position:absolute;width:1280;height:76;left:0;top:205px;z-index:3;color:white;">
    <table width="1280" height="76" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td height="10" colspan="7"></td>
      </tr>
      <tr height="36">
        <td width="40"></td>
        <td width="180" height="36" valign="middle" align="center" style="color:#FFF">请输入播放时间</td>
        <form action="javascript:clickJumpBtn();">
          <td width="60" valign="middle" align="center"><input id="jumpTimeHour" type="text" align="middle" width="60" height="28" maxlength="2" size="2" style="color:#000000;;font-size:22px"/></td>
          <td width="30" valign="middle" align="center" style="color:#FFF">时</td>
          <td width="60" valign="middle" align="center"><input id="jumpTimeMin" type="text" width="60" align="middle"  height="28" maxlength="2" size="2" style="color:#000000;;font-size:20px"/> </td>
        </form>
        <td width="30" valign="middle" align="center" style="color:#FFF">分</td>
        <td width="280" valign="middle" align="center"><a id="ensureJump" href="javascript:clickJumpBtn();"><img src="../images/play/ensureJump.png" width="73" height="28"/></a> &nbsp;&nbsp;&nbsp;&nbsp; <a id="cancelJump" href="javascript:pauseOrPlay();"><img src="../images/play/cancelJump.png" width="73" height="28"/></a> </td>
      </tr>
      <tr>
        <td height="8" colspan="7"></td>
      </tr>
      <tr>
        <!-- 跳转框下的提示信息 -->
         <td id="timeError" width="640" height="30" align="center" colspan="7" style="color:DAA520;line-height:25px"></td>
    </table>
  </div>
</div>
<!-- 进度条及跳转框所在的divend 下面的DIV可能多了-->

<!--直播未定购显示-->
<div id="bg_noorder" style="position:absolute; right:500;top:60px; width:750px; height:135px; display:none">  </div>

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


<!--直播列表div-->
<div id="channelListDIV"  style="display:none;">
   <div id="chan_info" class="channel_choose"></div>
</div>

<!-- 右上显示直播号-->
<div id="topframe" style="position:absolute;left:575px; top:8px; width:200px; height:30px; z-index:1"></div>
<div id="topframe_bottomLine" style="position:absolute;left:675px; top:10px; width:200px; height:30px; z-index:2"></div>
<!--预览提示信息-->
<div id="preview" style="position:absolute;left:250px; top:60px; width:350px; height:135px; z-index:-1; display:none;"> 
<img src="../images/play/noOrder.jpg" border="0" width="350px" height="135px" /> </div>
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
<div id="errorDiv" style="position:absolute; left:120px; top:315px; width:400px; height:70px; z-index:1;display:none"> <img src="images/playcontrol/playChannel/jumpDivBack.gif" width="400px" height="70px"/> </div>
<div id="errorDiv" style="position:absolute; left:120px; top:315px; width:400px; height:80px; z-index:1;display:none">
  <table width="400px" height="80" border="0">
    <tr>
      <td width="400px" align="center">系统错误，请切换直播或稍候再试！</td>
    </tr>
  </table>
</div>
<div style="position:absolute; left:15px; top:15px; width:54px; height:66px; z-index:3;"><img id="voice" src="../images/dot.gif"/></div>
<!--解决一键跳转层出现时，解锁层焦点问题-->
<a id="none" href="#"> <img src="#"  width="1" height="1"> </a>
<div style="visibility:hidden;">
<img src ="../images/play/chanMini_lostTimePro.png"/>
<img src ="../images/play/chanMini_timePro.png"/>
<img src ="../images/play/up.png"/>
<img src ="../images/play/down.png"/>
<img src ="../images/play/up_gray.png"/>
<img src ="../images/play/down_gray.png"/>
</div>
</body>
</html>
