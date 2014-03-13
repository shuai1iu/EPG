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
<%
String progId = request.getParameter("PROGID"); //节目id
int iProgId = 0;	
String channelId = request.getParameter("CHANNELID");//频道id
String chanNum = request.getParameter("LOGICCHANNELID")==null?"-1":request.getParameter("LOGICCHANNELID").toString();//频道id
int iChannelId = 0;

MetaData metaData = new MetaData(request);
String HDintroduce = "";
HashMap HDinfomap = metaData.getTypeInfoByTypeId("10000100000000090000000000031910"); //过滤频道
if(HDinfomap!=null){
	HDintroduce = (String)HDinfomap.get("TYPE_INTRODUCE");
}
String allIntroduce = HDintroduce;
String[] strarray = allIntroduce.split("@");

String playType = request.getParameter("PLAYTYPE"); //播放类型
int iPlayType = 0;	
String beginTime = request.getParameter("PROGSTARTTIME"); //节目播放开始时间
String endTime = request.getParameter("PROGENDTIME"); //节目播放结束时间
String productId = request.getParameter("PRODUCTID"); //订购产品id	
String serviceId = request.getParameter("SERVICEID"); //对应服务id	
String price = request.getParameter("ONECEPRICE"); //该产品对应价格	
String contentType = request.getParameter("CONTENTTYPE");
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
	iShowDelayTime = 8000;
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
body { font-family:"黑体"; font-size:30px; color:#FFFFFF;margin:0px;padding:0px;width:1280px; height:720px}
.blueFont
{   
	font:"黑体";
	color:#33CCFF;
	font-size:24px;
}
.whiteFont
{
	font:"黑体";
	color:#FFFFFF;
	font-size:24px;
}

/*control_panel*/
.control_load{ position:absolute; top:25px; right:35px}
.control_panel{ position:absolute; top:483px; background:url(images/playerimages/control_bbg.png) repeat-x; width:1280px; height:237px; z-index:7}
.control_panel .playing_time{ position:absolute; top:25px; left:565px; width:150px; text-align:center}
.control_panel .fasttime{ position:absolute; top:25px; left:1110px}
.control_panel .time1{ position:absolute; top:70px; left:40px; width:130px; text-align:right}
.control_panel .time2{ position:absolute; top:70px; right:40px; width:130px}
.control_panel .time11{ position:absolute; top:69px; left:40px; width:130px; text-align:right}
.control_panel .time22{ position:absolute; top:69px; right:40px; width:130px}
.control_panel .progressbar{ position:absolute; top:137px; left:170px}
.control_panel .progressbar2{ position:absolute;top:80px; left:190px}
.control_panel .bar{ position:absolute; top:128px; left:190px}
.control_panel .bar2,.control_panel .bar3 { position:absolute; top:70px; left:190px; height:32px; padding-right:12px}
.control_panel .bar2{ background:url(images/playerimages/progressbar.png) right no-repeat;}
.control_panel .bar3{ background:url(images/playerimages/progressbar02.png) right no-repeat;}
.control_panel2{ position:absolute; top:618px; background:url(images/playerimages/control_bbg2.png) repeat-x; width:1280px; height:102px; z-index:8}
.control_panel3{ position:absolute; top:446px; background:url(images/playerimages/control_bbg3.png) repeat-x; width:1280px; height:100px; z-index:7}

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
</style>
<script>	
var markArray = new  Array();//用来存放过滤的数据
<%
	for(int i = 0;i < strarray.length;i++){
%>
		markArray[<%=i %>] = "<%=strarray[i] %>";
<%
	}
%>

if(typeof(iPanel) != 'undefined')
{
iPanel.focusWidth = "4";
iPanel.defaultFocusColor = "#FCFF05";
} 
//提示信息计时器
var tempShowMsgTimer = "";
//页面加载前执行的数据转换与方法 
var itype="<%=itype%>";
var count=0;
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
/******************在iframe页面赋值的参数 start********************************/
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
var progTimeSpan = ""; //节目开始时间与结束时间
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
 var preInputValueHour = "";
var preInputValueMin = "";	
 var showTimer = "";
var volume = 20;
var bottomTimer = "";
var jumpDivIsShow = false;
 var seekDivIsShow = false;
 var speedDivIsDispaly  = false;
 var quitDivIsShow = false;
var jumpPos = 4;//4:进度条 0：小时 1：分 2：跳转 3：取消
var volumeDivIsShow = false;
var voiceIsShow=false;//静音是否显示 false:没有显示
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
//szgx hhr 输入小时（两位数），光标再移动到小时输入框，光标会自动跳到分钟输入框中。
var lastJumpPos = 0;
/**
*初始话mediaPlay对象
*/
var timeErrorDIvIsShow = false;//定位输入时间错误
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
	
	mp.setSingleMedia(mediaStr); //设置媒体播放器播放媒体内容
	mp.setAllowTrickmodeFlag(0); //设置是否允许trick操作。 0:允许 1：不允许
	
	mp.setNativeUIFlag(0); //播放器是否显示缺省的Native UI，  0:允许 1：不允许
	mp.setAudioTrackUIFlag(1);//设置音轨的本地UI显示标志 0:不允许 1：允许
  
	mp.setMuteUIFlag(0); //设置静音的本地UI显示标志 0:不允许 1：允许
	mp.setAudioVolumeUIFlag(0);//设置音量调节本地UI的显示标志 0:不允许 1：允许
	mp.refreshVideoDisplay();
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
	else
	{
		//alert("123");
		mp.playFromStart();
	}
}

/**
*进入页面后直接播放
*/
function start()
{	
	initMediaPlay();		
	play();
	setSTB();
}

function unload()
{
	mp.stop();
	setEPG();
}

function $(strId)
{
	return document.getElementById(strId);
}

document.onkeypress = keyEvent;
var positionFlag = 0; //记录页面焦点位置
function keyEvent()
{
	var val = event.which ? event.which : event.keyCode;
	return keypress(val);
}
function keypress(keyval)
{
	switch(keyval)
	{
		case <%=KEY_0%>:if(seekDivIsShow){showInputTime(0);}return false;break;
		case <%=KEY_1%>:if(seekDivIsShow){showInputTime(1);}return false;break;
		case <%=KEY_2%>:if(seekDivIsShow){showInputTime(2);}return false;break;
		case <%=KEY_3%>:if(seekDivIsShow){showInputTime(3);}return false;break;
		case <%=KEY_4%>:if(seekDivIsShow){showInputTime(4);}return false;break;
		case <%=KEY_5%>:if(seekDivIsShow){showInputTime(5);}return false;break;
		case <%=KEY_6%>:if(seekDivIsShow){showInputTime(6);}return false;break;
		case <%=KEY_7%>:if(seekDivIsShow){showInputTime(7);}return false;break;
		case <%=KEY_8%>:if(seekDivIsShow){showInputTime(8);}return false;break;
		case <%=KEY_9%>:if(seekDivIsShow){showInputTime(9);}return false;break;       
		case <%=KEY_UP%>:return pressKey_up();			
		case <%=KEY_DOWN%>:return pressKey_down();		
		case <%=KEY_LEFT%>:  return pressKey_left();	  
		case <%=KEY_RIGHT%>: return pressKey_right();		
		case <%=KEY_PAGEDOWN%>:return pressKey_pageDown();//return 0;		
		case <%=KEY_PAGEUP%>:return pressKey_pageUp();	//return 0;
		case <%=KEY_PAUSE_PLAY%>:
		case <%=KEY_POS%>:
				pauseOrPlay();return false;
		case <%=KEY_FAST_FORWARD%>:fastForward();return 0;
		case <%=KEY_FAST_REWIND%>:fastRewind();return 0;
		case <%=KEY_VOL_UP%>:volumeUp();return false;
		case <%=KEY_VOL_DOWN%>:volumeDown();return false;
		case <%=KEY_MUTE%>:setMuteFlag();return false;
		case <%=KEY_RETURN%>:pressKey_quit(); return 0; //退出时处理
		case <%=KEY_STOP%>:pressKey_Stop();return 0;
		case <%=KEY_IPTV_EVENT%>:goUtility();break;
		case <%=KEY_INFO%>:
		case <%=KEY_BLUE%>: showMinEpgByInfo();return 0;
		case <%=KEY_TRACK%>: changeAudio(); return 0;
		case <%=KEY_OK%>:pressOk();return 0;
	    //case 277:
		case  1109://点播
			mp.stop();window.location.href="dibbling.jsp";return 0;
		//case 276:
		case 1110://回看
			mp.stop();window.location.href="playback.jsp";return 0;
	
			//case 275:
		case 1108://频道
			mp.stop();window.location.href="channel.jsp";return 0;
		case 1111://通信
				return 0;
			default:return videoControl(keyval);				
	}
	return true;
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
		   // alert(mp.getCurrentPlayTime()+"?"+mp.getMediaDuration());
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
		default :break;	
	}
	return true;
}
/************************************************按键响应处理 start************************************************/
var voiceflag="";
function changeAudio()
{
    mp.switchAudioChannel();
	var audio = mp.getCurrentAudioChannel();
	if(audio=="0" || audio=="Left")
	{
	    audio=0;
	}
	else if(audio=="1" ||  audio=="Right")
	{
	    audio=1;	
	}
	else if(audio=="2" ||  audio=="JointStereo" ||  audio=="Stereo")
	{
	    audio=2;	
	}
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
	voiceflag=setTimeout(function(){$("voice").src="images/dot.gif";},5000);
}

//20120330修改为div以及自动跳转
function showInputTime(id){
	var bufInput = "";	
    if(0==jumpPos){
    	bufInput = $("jumpTimeHour").innerHTML;
        if(bufInput.length<2){ 
			$("jumpTimeHour").innerHTML = bufInput+id;
			if(2==($("jumpTimeHour").innerHTML).length){jumpPressKeyRight();}
		}
    }else if(1==jumpPos){
        bufInput = $("jumpTimeMin").innerHTML;
        if(bufInput.length<2){
			$("jumpTimeMin").innerHTML = bufInput+id;
			if(2==($("jumpTimeMin").innerHTML).length){jumpPressKeyRight();}
		}       	
    }
}
//20120330修改删除输入的时间数字
function delInputTime()
{
    if(0==jumpPos){
		var tempHour = $("jumpTimeHour").innerHTML;
		if(tempHour == null || tempHour == "" || tempHour == undefined){
			displaySeekTable(1);
			count=0;
			jumpPos=0;
		}
		$("jumpTimeHour").innerHTML = "";
    }else if(1==jumpPos){
		var tempMinute = $("jumpTimeMin").innerHTML;
		if(tempMinute == null || tempMinute == "" || tempMinute == undefined){
			displaySeekTable(1);
			count=0;
			jumpPos=0;
		}
		$("jumpTimeMin").innerHTML = "";
    }
}
function pressOk()
{
	
	var totalTime = mp.getMediaDuration();
	currTime = parseInt(mp.getCurrentPlayTime()) + parseInt(count*60);
	if(currTime<=0){currTime=1;}
	if(!seekDivIsShow&&speedDivIsDispaly==false){pressKey_info_Ok();}
	else if(jumpDivIsShow && jumpPos==4){
		playByTime(currTime);
		$("seekDiv").style.display = "none";
		jumpDivIsShow=false;
		isSeeking = 0;
		speed = 1;
	}
	else if(jumpDivIsShow && jumpPos==2)
	{
	    clickJumpBtn();
	}
	else if(jumpDivIsShow && jumpPos==3)
	{
	    pauseOrPlay();
	}
	else if(timeErrorDIvIsShow)
	{
		$("timeErrorDIv").style.display = "none";
		timeErrorDIvIsShow = false ;
	}
	return;
}
function setMuteFlag()
{
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return true;}
	if(minEpgIsShow){hideMinEpg();}
	clearTimeout(showTimer);showTimer = "";
	clearTimeout(bottomTimer);bottomTimer = "";
	voiceIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1)
	{
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
function pauseOrPlay()
{
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return true;}
	else if(minEpgIsShow){hideMinEpg();}
	speed = 1;		
	setTimeout("displaySeekTable(0)",100);//显示进度条及跳转框
	//$("jumpTimeDiv").style.display = "block";
	//$("jumpTimeImg").style.display = "block";
	hideBottom();
	playStatFlag=1;
}

 function volumeUp()
{
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return true;}
	if(minEpgIsShow){hideMinEpg();}
	clearTimeout(showTimer);showTimer = "";
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){mp.setMuteFlag(0);}
	if(voiceIsShow){hideMute();}
	volume = mp.getVolume();
	volume += 5;
	if(volume > 100){ volume = 100;}
	mp.setVolume(volume);
	if (mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
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
	tableDef += '<td width="20px"></td><td width="40px"><img border="0" src="images/playcontrol/playTvod/volume.gif"></td><td width="40px" style="color:white;font-size:28">' + volume + '</td>';
	tableDef += '</tr></table>';
	$("bottomframe").innerHTML = tableDef;
}

function volumeDown()
{
	//alert(mp.getNativeUIFlag()+"chengzhichao===="+mp.getAudioVolumeUIFlag());
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return true;}
	if(minEpgIsShow){hideMinEpg();}
	clearTimeout(showTimer);showTimer = "";
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){mp.setMuteFlag(0);}
	if(voiceIsShow){hideMute();}
	volume = mp.getVolume();
    volume -= 5;
    if(volume <0){volume = 0;}
	mp.setVolume(volume);
	if (mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
	{
		clearTimeout(bottomTimer);
		bottomTimer = "";
		genVolumeTable(volume);
		bottomTimer = setTimeout(hideBottom, 5000);
	}
}

function fastRewind()
{
	playStatFlag=0;
	//jumpDivIsShow = false;
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){	return true;}
	if(isSeeking == 0)
	{
		displaySeekTable(1);
		clearTimeout(timeID_jumpTime);
		timeID_jumpTime = "";
		isJumpTime = 0;
		//$("jumpTimeDiv").style.display = "none";
		//$("jumpTimeImg").style.display = "none";
	}
	//ZTE
		/*if($("jumpTimeDiv").style.display != "none"){
		   $("jumpTimeDiv").style.display = "none";
		   $("jumpTimeImg").style.display = "none";
		}*/
	$("speedDiv").style.display = "block"; //显示进度条
	speedDivIsDispaly  = true;
	$("seekDiv").style.display = "none"; 
	seekDivIsShow = false;
    if(playStat == "fastforward"||(speed >= 32 && playStat == "fastrewind")){ speed = 1;}
	speed = speed * 2;
	playStat = "fastrewind";
	mp.fastRewind(-speed);
	$("statusImg").innerHTML = '<img src="images/playerimages/icon_refast.png" align="absmiddle"/>&nbsp;X' + speed;

}
function convertTime(_time)
{
	if(null == _time || _time.length == 0){_time = mp.getMediaDuration();}
	var time_second = "",time_min = "",time_hour = "";
	
	time_second = String(_time % 60);
	
	var tempIndex = -1;
	tempIndex = (String(_time / 60)).indexOf(".");
	if(tempIndex != -1){time_min = (String(_time / 60)).substring(0,tempIndex);tempIndex = -1;}
    else{time_min = String(_time / 60);}

	tempIndex = (String(time_min / 60)).indexOf(".");
	if(tempIndex != -1){time_hour = (String(time_min / 60)).substring(0,tempIndex);tempIndex = -1;}
    else{time_hour = String(time_min / 60);}

	time_min = String(time_min % 60);
	if("" == time_hour || 0 == time_hour){time_hour = "00";}
	if("" == time_min || 0 == time_min){time_min = "00";}
	if("" == time_second || 0 == time_second){time_second = "00";}

	if(time_hour.length == 1){time_hour = "0" + time_hour;}
	if(time_min.length == 1){time_min = "0" + time_min;}
	if(time_second.length == 1){time_second = "0" + time_second;}

	return time_hour + ":" + time_min + ":" + time_second;
}

function displaySeekTable(playFlag)
{
	mediaTime = mp.getMediaDuration();
	//有时机顶盒取出的vod总时长有问题，在这里重新获取。initMediaTime是初始化页面时取出的总片长
    if(undefined == mediaTime || typeof(mediaTime) != "number" || mediaTime.length == 0 || 0 == mediaTime || initMediaTime != mediaTime)
	{
		mediaTime = mp.getMediaDuration();timePerCell = mediaTime / 100;
	}
	//isSeeking等于0时展示进度条及跳转框
	if(isSeeking == 0)
	{	
		isSeeking = 1;  
		currTime = mp.getCurrentPlayTime();
		processSeek(currTime);
		if(minEpgIsShow){hideMinEpg();}
		//if(playFlag != 1){mp.pause();}
		$("fullTime").innerHTML = convertTime();
		$("fullTime2").innerHTML = convertTime();
		//$("statusImg").innerHTML = '<img border="0" src="images/playcontrol/playTvod/pause.png" width="40" height="40"/>';
		$("seekDiv").style.display = "block";
		jumpPos=4;
		$("currentTime_progress").style.background="url(images/playerimages/progressbar.png) right";
		clearTimeout(timeID_jumpTime);timeID_jumpTime = "";
	   // timeID_jumpTime = setTimeout("hideJumpTimeDiv();",15000);//15秒后隐藏跳转输入框所在的div
		checkSeeking();//调用方法检测进度条及跳转框的状态
		seekDivIsShow = true;
		jumpDivIsShow = true;
		if(playFlag==1){
				jumpDivIsShow = false;
		}else{
			  $("seekDiv").style.display = "block"; //显示进度条
			  $("speedDiv").style.display = "none";
			  speedDivIsDispaly  = false; 
			  seekDivIsShow = true;
              pause();//暂停播放
		}
	}
	else//isSeeking等于1时
	{
		clearTimeout(timeID_check);timeID_check = "";//清空定时器
		resetPara_seek();//复位各参数		
		if (playFlag != 2 && playFlag != 3){speed= 1;mp.resume();}// 如果切换到开头则不需要恢复播放，机顶盒会自动播放
		seekDivIsShow = false;
		jumpDivIsShow = false;
		$("seekDiv").style.display = "none";
		jumpPos = 0;
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
	preInputValue = "";
	/*$("jumpTimeDiv").style.display = "block";
	$("jumpTimeImg").style.display = "block";*/
	$("jumpTimeHour").innerHTML = "";
    $("jumpTimeMin").innerHTML = "";
    /*
        ZTE
     */
//	$("timeError").innerHTML = "";//请输入时间！    
    $("jumpTimeHour").className = "inp";
	$("jumpTimeMin").className = "inp";
	$("jumpBtn").className = "btnoff";
	$("cancelBtn").className = "btnoff";
//	$("timeError").innerHTML = "";
	//$("statusImg").innerHTML = '<img border="0" src="images/playcontrol/playTvod/pause.png" width="40" height="40"/>';
	$("speedDiv").style.display = "none";
	speedDivIsDispaly  = false;
}
//负责检查进度条
function checkSeeking()
{	
	if(isSeeking == 0){clearTimeout(timeID_check);timeID_check = "";} 
	clearTimeout(timeID_check);timeID_check = setTimeout(checkSeeking,300);
	if(playStatFlag==0 && (playStat == "fastrewind" || playStat == "fastforward")){currTime = mp.getCurrentPlayTime();processSeek(currTime);}
	//processSeek(currTime);
	var inputValueHour = $("jumpTimeHour").innerHTML;
	var inputValueMin = $("jumpTimeMin").innerHTML;
	//szgx hhr
	if(2==inputValueHour.length && 0==jumpPos && 0==lastJumpPos){$("jumpTimeMin").className = "inp inp-focus";jumpPos=1;lastJumpPos=1;}
	if(2==inputValueMin.length && 1==jumpPos && 2>lastJumpPos){$("jumpBtn").className = "btnon";jumpPos=2;lastJumpPos=2;}	
	if(preInputValueHour != inputValueHour || preInputValueMin != inputValueMin)
	{
		var tempTimeID = timeID_jumpTime;
		clearTimeout(tempTimeID);tempTimeID = "";
		//timeID_jumpTime = setTimeout(hideJumpTimeDiv,15000);
		preInputValueHour = inputValueHour;
		preInputValueMin = inputValueMin;
	}
	//下面一行代码的作用：获取不到文本框中的值，动态刷新文本框所在div可以解决
	if(playStat != "fastrewind" && playStat != "fastforward")
	{
		$("statusImg").innerHTML = '<img src="images/playerimages/pause.png" width="40" height="40"/>';
	}
}
function hideJumpTimeDiv()
{
	var inputValueHour = $("jumpTimeHour").innerHTML;
	var inputValueMin = $("jumpTimeMin").innerHTML;
	if(preInputValueHour != inputValueHour || preInputValueMin != inputValueMin)
	{
		var tempTimeID = timeID_jumpTime;
		clearTimeout(tempTimeID);tempTimeID = "";
		//timeID_jumpTime = setTimeout(hideJumpTimeDiv,15000);
		preInputValueHour = inputValueHour;
		preInputValueMin = inputValueMin;
	}else{
		clearTimeout(timeID_jumpTime); timeID_jumpTime = "";
		preInputValue = "";
		jumpDivIsShow = false;	
		if(isEmpty(inputValueHour) || isEmpty(inputValueMin))
		{	
			isJumpTime = 0;
			$("jumpTimeHour").className = "inp";
		   $("jumpTimeMin").className = "inp";
			/*$("jumpTimeDiv").style.display = "none";
			$("jumpTimeImg").style.display = "none";*/
		}else{
			clickJumpBtn();
		}
	}
    count=0;
	jumpPos=0;
	$("currentTime_progress").style.background="url(images/playerimages/progressbar02.png) right";
	//$("jumpTimeHour").focus();
}
	  
function isNum(s)
{
	var nr1=s,flg=0,cmp="0123456789",tst ="";
	for (var i=0,l=nr1.length;i<l;i++)
	{
		tst=nr1.substring(i,i+1)
		if(cmp.indexOf(tst)<0){flg++;}
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
	if(isEmpty(pHour)||!isNum(pHour)||isEmpty(pMin)||!isNum(pMin)||!isInMediaTime(pHour, pMin)){return false;}
	else{  return true;}
}
function playByTime(beginTime)
{
	var type = 1,speed = 1;
	mp.playByTime(type,beginTime,speed);
	//currTime = mp.getCurrentPlayTime();//20120516
	count=0;
	jumpPos=0;
	$("currentTime_progress").style.background="url(images/playerimages/progressbar02.png) right";
    /*
    ZTE
     */
//	$("jumpTimeHour").focus();
}
function jumpToTime(_time)
{
	_time = parseInt(_time,10);
	playByTime(_time);
	//processSeek(_time); //20120516
}
function clickJumpBtn()
{
    var inputValueHour = $("jumpTimeHour").innerHTML;
	var inputValueMin = $("jumpTimeMin").innerHTML;
	if(isEmpty(inputValueHour)){inputValueHour="00";}
	if(isEmpty(inputValueMin)){ inputValueMin="00";}
	if(checkJumpTime(inputValueHour, inputValueMin))
	{
		var hour = parseInt(inputValueHour,10);
		var mins = parseInt(inputValueMin,10);
		var timeStamp =  hour*3600 + mins*60;
		clearTimeout(timeID_jumpTime);timeID_jumpTime = "";
		displaySeekTable(3);
		jumpToTime(timeStamp);
	}else{
		$("timeErrorDIv").style.display = "block";
		timeErrorDIvIsShow = true ;
		$("jumpTimeHour").innerHTML = "";
		$("jumpTimeMin").innerHTML = "";
		preInputValueHour = "";
		preInputValueMin = "";	
		$("jumpBtn").className = "btnoff";	
		$("jumpTimeHour").className = "inp inp-focus";
		jumpPos = 0;
		preInputValue = "";
		$("jumpTimeHour").focus();
		//15秒后隐藏跳转输入框所在的div
		clearTimeout(timeID_jumpTime);timeID_jumpTime = "";
		//timeID_jumpTime = setTimeout(hideJumpTimeDiv,15000);
	}
	count=0;
}

function isEmpty(s)
{
	return ((s == undefined) || (s == "") || (s == null) || (s.length == 0));
}
//负责勾画进度条
function processSeek(_currTime)
{
	if(null == _currTime || _currTime.length == 0){ _currTime = mp.getCurrentPlayTime();}
	if(_currTime < 0){_currTime = 0;}
	if(_currTime>mediaTime){_currTime=mediaTime;}


	currCellCount = Math.ceil(_currTime / timePerCell); 
	if(currCellCount > 100){currCellCount = 100;}
	if(currCellCount < 0){currCellCount = 0;}
	
	$("seekPercent").innerHTML = currCellCount + "%";
	var currTimeDisplay = convertTime(_currTime);//将时间（单位：秒）转换成在页面中显示的格式（HH：MM?
	var td_0_width=currCellCount * 10;
	/*if(currCellCount >= 100)
	{
		$("td_0").style.width = 1000;	
		$("td_1").style.width = 0;
	}
	else if(currCellCount<=0)
	{
		$("td_0").style.width =0;	
		 $("td_1").style.width = 1000;	
	}
	else
	{
		$("td_0").style.width = td_0_width;
		$("td_1").style.width = 1000- td_0_width;
	}*/
	if( ( (currTimeDisplay == "00:00:00") || ( currTimeDisplay == convertTime() ) ) && !seekDivIsShow)       	
		hideAllDiv();
	$("currTimeShow").innerHTML = currTimeDisplay;
	$("currTime").innerHTML = currTimeDisplay;
	$("currentTime_progress").style.width =2+currCellCount * 9;
	$("speedPos").style.left =174+currCellCount * 9;
}






	  

	  
//快进
function fastForward()
{	
	playStatFlag=0;
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return true;}
	if(isSeeking == 0)
	{	
		displaySeekTable(1);
		clearTimeout(timeID_jumpTime);
		timeID_jumpTime = "";
		isJumpTime = 0;
		//$("jumpTimeDiv").style.display = "none";
//		$("jumpTimeImg").style.display = "none";
	}
	//ZTE
		/*if($("jumpTimeDiv").style.display != "none"){
		   $("jumpTimeDiv").style.display = "none";
		   $("jumpTimeImg").style.display = "none";
		}*/
	$("speedDiv").style.display = "block"; //显示进度条
	speedDivIsDispaly  = true;
	$("seekDiv").style.display = "none"; 
	seekDivIsShow = false;
	if(playStat == "fastrewind"||(speed >= 32 && playStat == "fastforward")){ speed = 1;}
	speed = speed * 2;
	playStat = "fastforward";
	$("statusImg").innerHTML = '<img src="images/playerimages/icon_fast.png" align="absmiddle"/>&nbsp;X' + speed;
	mp.fastForward(speed);
	

}

function pressKey_up()
{
	if(quitDivIsShow){mainPressKeyUp();}
	else if(oneKeySwitchJumpInfoIsShow){commonPressKeyUp();}
	else if(jumpToChannelInfoIsShow){commonPressKeyUp();}
	else if(jumpDivIsShow){
		jumpPos=4;
	$("jumpTimeMin").className = "inp";
	$("jumpTimeHour").className = "inp";
	$("cancelBtn").className = "btnoff";
	$("jumpBtn").className = "btnoff";		
	$("currentTime_progress").style.background="url(images/playerimages/progressbar.png) right";
		return;
	}
	return false;
}
	
function pressKey_down()
{
	if(quitDivIsShow){mainPressKeyDown();}
	else if(oneKeySwitchJumpInfoIsShow){commonPressKeyDown();}
	else if(jumpToChannelInfoIsShow){commonPressKeyDown();}
	else if(jumpDivIsShow && jumpPos==4){
		jumpPos=0;
		$("jumpTimeHour").className = "inp inp-focus";
		$("currentTime_progress").style.background="url(images/playerimages/progressbar02.png) right";
		return;
	}
	return false;
}

function pressKey_left()
{
	if(quitDivIsShow){mainPressKeyLeft();}
	else if(oneKeySwitchJumpInfoIsShow){commonPressKeyLeft();}
	else if(jumpToChannelInfoIsShow){commonPressKeyLeft();}
	else if(seekDivIsShow){if(jumpDivIsShow){jumpPressKeyLeft();}}
	else if(speedDivIsDispaly)
	{
			//不做响应
	}
	else{volumeDown();}
	return false;
}
	
function pressKey_right()
{
	if(quitDivIsShow){mainPressKeyRight();}
	else if(oneKeySwitchJumpInfoIsShow){commonPressKeyRight();}
	else if(jumpToChannelInfoIsShow){commonPressKeyRight();}
	else if(seekDivIsShow){if(jumpDivIsShow){jumpPressKeyRight();}}
	else if(speedDivIsDispaly)
	{
			//不做响应
	}
	else{volumeUp();}
	return false;
}
	
function jumpPressKeyRight()
{
	if(jumpPos>4)
	{
		jumpPos=4;
	}
	if(jumpPos == 0)
	{
		$("jumpTimeHour").className = "inp";
		$("jumpTimeMin").className = "inp inp-focus";
		jumpPos++;
	}
	else if(jumpPos == 1)
	{
		$("jumpTimeMin").className = "inp";
		$("jumpBtn").className = "btnon";
		jumpPos++;
	}
	else if(jumpPos==2)
	{
		$("jumpBtn").className = "btnoff";
		$("cancelBtn").className = "btnon";
		jumpPos++;
	}
	else if(jumpPos==4){
		  totalTime = parseInt(mp.getMediaDuration());
		  currTime = parseInt(mp.getCurrentPlayTime());
		  count++;
		  currTime =currTime+parseInt(60*count);
		  if(currTime>totalTime){currTime=totalTime;count--;}
		  clearTimeout(timeID_jumpTime);
		  timeID_jumpTime = "";
		  isJumpTime = 0;
		  processSeek(currTime);
	}
}
function jumpPressKeyLeft()
{
	if(jumpPos<0)
	{
		 jumpPos==0;
	}
	if(jumpPos == 1)
	{
		$("jumpTimeMin").className = "inp";
		$("jumpTimeHour").className = "inp inp-focus";
		jumpPos--;
	}
	else if(jumpPos == 2)
	{
		$("jumpBtn").className = "btnoff";
		$("jumpTimeMin").className = "inp inp-focus";
		jumpPos --;
	}
	else if(jumpPos==3)
	{
		$("cancelBtn").className = "btnoff";
		$("jumpBtn").className = "btnon";
		jumpPos--;
	}
	else if(jumpPos==4){
		currTime = parseInt(mp.getCurrentPlayTime());
		count--;
		currTime = currTime+parseInt(count*60);
		if(currTime<0){currTime=0;count++;}
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
	if(!quitDivIsShow && !jumpToChannelInfoIsShow && !oneKeySwitchJumpInfoIsShow && !finishedDivIsShow)
	{
		if(!dataIsOk){return true;}
		if(minEpgIsShow){hideMinEpg();}
		else{showMinEpg();}
		return true;
	}
	else if(quitDivIsShow)
	{
		mainPressKeyOk();
		return true;
	}
	else if(jumpToChannelInfoIsShow)
	{
		commonPressKeyOk();
	}
	else if(oneKeySwitchJumpInfoIsShow)
	{
		commonPressKeyOk();
	}
	
}

function pressKey_quit()
{
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || quitDivIsShow || finishedDivIsShow){return true;}
	if(errorDivIsShow){hideErrorDiv();}
	if(minEpgIsShow){hideMinEpg();return;}
	if(isSeeking == 1)
	{
		if(0==jumpPos || 1==jumpPos){
			delInputTime();return 0;
		}
		else
		{
			displaySeekTable(1);
			count=0;
			jumpPos=0;
			$("currentTime_progress").style.background="url(images/playerimages/progressbar02.png) right";
		}
	}else{
		hideAllDiv();
		resetQuitDiv();
		setTimeout(showQuitDiv,200);
		pause();
		setEPG();
	}	
}


function pressKey_Stop()
{
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || quitDivIsShow || finishedDivIsShow){return true;}
	if(errorDivIsShow){hideErrorDiv();}
	else
	{
		hideAllDiv();
		pause();
		resetQuitDiv();
		showQuitDiv();
		setEPG();
	}	
}
	
function pressKey_pageUp()
{
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return false;}
	mp.gotoStart();
	hideAllDiv();
	return 0;
}
	
function pressKey_pageDown()
{
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return false;}
	mp.gotoEnd();
	hideAllDiv();
	return 0;
}
	
function mainPressKeyUp()
{
	return false;
}

function mainPressKeyDown()
{
	return false;
}

function mainPressKeyLeft()
{
	if(positionFlag == 1)
	{
		positionFlag--;
		$("quit").focus();
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
	//alert(type);
	if(10 == type){showMediaError();}
}

//显示错误提示
function showMediaError()
{
	hideAllDiv();
	hideOneKeySwitchJumpInfo();
	hideJumpToChannelInfo();
	setEPG();
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
	//如果是暂停状态
	if(0 != type_new_play)
	{
		setSTB();
		//退出层
		if(quitDivIsShow){hideQuitDiv();}
		//一键跳转到频道
		if(jumpToChannelInfoIsShow){hideJumpToChannelInfo();}
		//一键跳转到其他频道
		if(oneKeySwitchJumpInfoIsShow){hideOneKeySwitchJumpInfo();	}
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
	resume();
	setSTB();
	hideQuitDiv();
}

/**
*退出当前页
*/
function quit()
{
	//alert("quit");
	if(errorDivIsShow == true){hideErrorDiv();}
	mp.stop();
	var url = goBackUrl;
	window.location.href = goBackUrl;	
}
/**
*结束播放
*/
function finishedPlay()
{	
	hideAllDiv();
	showFinishedDiv();	
	//$("end").focus();
}

/**
*播放上一集
*/
function goPreProg()
{
	if(preProgId == '-1'){return true;}
	var jumpUrl="au_PlayFilm.jsp?PROGID=" + preProgId +"&PLAYTYPE=<%=iPlayType%>&CONTENTTYPE=<%=EPGConstants.CONTENTTYPE_PROGRAM%>&BUSINESSTYPE=<%=EPGConstants.BUSINESSTYPE_TVOD%>"
	+  "&PROGSTARTTIME=" + preProgBeginTime +"&PROGENDTIME=" + preProgEndTime + "&CHANNELID=" + channelId+"&LOGICCHANNELID="+chanNum;
	setEPG();
	mp.stop();
	window.location.href = jumpUrl;
}
/**
*播放下一集
*/
function goNextProg()
{
	if(nextProgId == '-1'){	return true;}
	var jumpUrl="au_PlayFilm.jsp?PROGID=" + nextProgId +"&PLAYTYPE=<%=iPlayType%>&CONTENTTYPE=<%=EPGConstants.CONTENTTYPE_PROGRAM%>&BUSINESSTYPE=<%=EPGConstants.BUSINESSTYPE_TVOD%>"
	+  "&PROGSTARTTIME=" + nextProgBeginTime +"&PROGENDTIME=" + nextProgEndTime + "&CHANNELID=" + channelId+"&LOGICCHANNELID="+chanNum;
	setEPG();
	mp.stop();
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
	bookMarkIsShow();
	mp.setProgressBarUIFlag(0);
	genSeekTable();
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

var minEpgIsShow = false; //minepg是否显示标志位
var minEpgShowDelayId = 0;
var minEpgHideDelayId = 0;
/**
*显示minEPG
*/
function showMinEpg()
{
	if(minEpgHideDelayId != 0)
	{
		clearTimeout(minEpgHideDelayId);
		minEpgHideDelayId = 0;
	}
	if(seekDivIsShow)
	{	
		return;
		$("seekDiv").style.display = "none";
	}
	if(jumpDivIsShow)
	{	
		return;
		hideJumpTimeDiv();
	}
	if(minEpgIsShow){return;}
	if(volumeDivIsShow){hideBottom();}
	$("minEpgDiv").style.display = "block";
	$("minEpgBackground").style.display = "block";
	minEpgIsShow = true;
	minEpgHideDelayId = setTimeout(hideMinEpg,hideTime);
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
	$("minEpgBackground").style.display = "none";
	minEpgIsShow = false;
}
/**
*生成Minepg层，在数据获取页面调用
*/
function createMinEpg()
{
	$("preTvodName").innerText = "【上一节目】"+preProgName;
	$("preProgBeginTime").innerText="【开始时间】"+sp_convertTime(preProgBeginTime);
	$("nextTvodName").innerText = "【下一节目】"+nextProgName;
	$("nextProgBeginTime").innerText="【开始时间】"+sp_convertTime(nextProgBeginTime);
	//$("progTimeSpan").innerText = progTimeSpan;
	$("progName").innerText = "【当前节目】"+progName;
	//$("director").innerText = progName;20120521
	setTimeout("getVodTime()",1000);
	//$("time").innerHTML = "【节目时长】"+getVodTime();
	//$("actor").innerHTML = "暂无";
	$("vodName").innerText ="【当前频道】" + channelName;//当前节目名称
	//$("introduce").innerHTML = introduce;//20120521
	minEpgShowDelayId = setTimeout(showMinEpg,delayTime);
}
//转为的小时：分钟的格式
function sp_convertTime(_time)
{
	if(_time!=null && _time!=""){
		return _time.substring(8,10)+":"+_time.substring(10,12)+":"+_time.substring(12,14);
	}
	return "";
}
var finishedDivIsShow = false;
/**
*显示退出层
*/
function showQuitDiv()
{
	quit();
}
/**
*隐藏退出层
*/
function hideQuitDiv()
{
}
/**
*显示播放结束层
*/
function showFinishedDiv()
{
	if(finishedDivIsShow == true){return;}
	$("finishedBackground").style.display = "block";
	$("endDiv").style.display = "block";
	finishedDivIsShow = true;
	tempTime =  setTimeout(antoQuit,1000);
}
//20120319修改为1秒后自动退出
function antoQuit()
{
	 clearTimeout(tempTime);
	 quit();
}

/**
*隐藏播放结束层
*/
function hideFinishedDiv()
{
	if(finishedDivIsShow == false)
	{
		return;
	}
	$("endDiv").style.display = "none";
	$("finishedBackground").style.display = "none";
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
	if(jumpDivIsShow)hideJumpTimeDiv();
	if (speedDivIsDispaly)
	{
		jumpPos =0 ;
		count=0;
		isSeeking = 0;
		speedDivIsDispaly= false;
		$("speedDiv").style.display = "none";
	}
	if(seekDivIsShow)
	{
		$("seekDiv").style.display = "none";
		seekDivIsShow = false;
		$("speedDiv").style.display = "none";
		speedDivIsDispaly = false;
		isSeeking = 0;
		jumpPos =0 ;
		count=0;
		$("currentTime_progress").style.background="url(images/playcontrol/playChannel/chanMini_lostTimePro.png)";
/*
ZTE
*/		
//$("jumpTimeHour").focus();
	}
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
	//$("progTime").innerText = time ;
	$("time").innerText = "【节目时长】"+ time ;
	return time;
}
/**
*进入退出层时，重置退出层
*/
function resetQuitDiv()
{
	$("quit").focus();
	positionFlag = 0;
}
/**
*复写的公共控制页面的方法，判断公共页面的层是否可以显示
*/
function commonJumpDivCanShow()
{
	var canShow = false;
	if(!quitDivIsShow && !errorDivIsShow)
	{
		canShow = true;
	}
	return canShow;
}
function genSeekTable()
{
	var seekTableDef = "";
	seekTableDef = '<table width="1000" height="" border="0" cellpadding="0" cellspacing="0" bgcolor="#000080"><tr>';
	seekTableDef +='<td id="td_0" width="0%" height="25" style="border-style:none;color:#DAA520"></td>';
	seekTableDef +='<td id="td_1" width="100%" height="25" style="border-style:none;color:#000080"></td>';
	seekTableDef += '</tr></table>';
	$("seekTable").innerHTML = seekTableDef;
}
/**
 * 左右键机顶盒控制
 */
function setSTB()
{
	Authentication.CTCSetConfig("key_ctrl_ex","0");
}

/*
 * 左右键EPG控制
 */
function setEPG()
{
	Authentication.CTCSetConfig("key_ctrl_ex","0");
}
</script>
</head>
<body bgcolor="transparent" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="start();init()" onUnload="unload()">

<div id="showMessageDiv" style=" background-color:#999; height:80px; width:420px; margin-left:415px; margin-top:30px;text-align:center;z-index:1; display:none;">
   	<span id="testMsg" style="color:#000; font-size:28px; font-weight:bold;">本频道为付费频道，目前为免费体验期，正式收费将提前告知。</span>
</div>

<div style="width:1px; height:1px; top:-1px; left:-1px;">
<a id="currentTime" href="#" style="width:1px; height:1px; top:-1px; left:-1px;"><img src="images/dot.gif" width="1" height="1"/></a>
</div>
<div id="bottomframe" style="position:absolute;left:30px; top:430px; width:600px; height:150px; z-index:1">
</div>

<%--minEPG显示层--%>
<div style="position:absolute; left:15px; top:15px; width:54px; height:66px; z-index:3;bgcolor:red"><img id="voice" src="images/dot.gif"/></div>
<div id="minEpgDiv" style="display:none;">
<div id="minEpgBackground" style="position:absolute; background:url(images/control_bbg.png) repeat-x; width:1280px; height:237px;left:10px; top:500px; z-index:1;"></div>
<div style="position:absolute;left:10px; top:550px; width:1200px; height:160px;z-index:2;">
  <table width="1200" height="220">
    <tr>
      <td  height="5"></td>
    </tr>
    <tr>
      <td valign="bottom" height="25"><table>
          <tr valign="bottom">
            <td width="18"  height="25"></td>
            <td id="vodName" style="font-size:26px;color:#fff" align="left"></td>
          </tr>
        </table></td>
    </tr>
    <tr height="5">
      <td></td>
    </tr>
    <tr height="25">
     <td style="overflow:hidden"><table width="90%">
          <tr>
            <td width="15px"></td>
            <td  style="font-size:26px;color:#fff;width:480px" align="left" id="progName" > </td>
            <td id="time" style="width:350px;"  class="whiteFont" align="left"></td>
          </tr>
        </table></td>
    </tr>
    <tr height="5">
      <td></td>
    </tr>
    <tr>
      <td valign="top"><table width="93%">
          <tr valign="bottom" width="1200">
            <td width="15"></td>
            <td id="preTvodName"  style="font-size:26px;color:#fff;width:450px" align="left"></td>
            <td id="preProgBeginTime" style="width:350px;"  class="whiteFont" align="left"></td>
          </tr>
          <tr height="5">
              <td colspan="3"></td>
          </tr>
          <tr valign="bottom" width="1200">
            <td width="15"></td>
            <td id="nextTvodName"  style="font-size:26px;color:#fff;width:450px" align="left"></td>
            <td id="nextProgBeginTime" style="width:350px;"  class="whiteFont" align="left"></td>
          </tr>
        </table></td>
    </tr>
    
  </table>
</div>
</div>

<%--退出层--%>
<div id="quitBackground" style="position:absolute; left:135px; top:135px; width:380px; height:262px; display:none;" align="center"> <img src="images/popup_bg2.png" height="262" width="380"> </div>
<div id="quitDiv"  style="position:absolute; left:149px; top:135px; width:310px; height:262px; display:none; font-size:24px;">
  <table height="150" width="350" style="color:#FFFFFF" border="0">
    <tr height="25px;">
      <td colspan="5"></td>
    </tr>
    <tr>
      <td colspan="5" align="center" style="color:white;">您是否要退出当前收看节目?</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td align="center" style="color:white;">退出</td>
      <td>&nbsp;</td>
      <td align="center" style="color:white;">取消</td>
      <td>&nbsp;</td>
    </tr>
  </table>
  <div style="position:absolute; left:1px; top:160px;"> <img src="images/playcontrol/playTvod/" /> </div>
  <a id="quit" href="javascript:quit();" style="position:absolute; left: 52px; top: 100px;"><img src = "images/dot.gif" width="83px" height="36px"/></a>
   <a id="cancel" href="javascript:cancel();" style="position:absolute;left:213px; top:100px;"><img src = "images/dot.gif" width="83px" height="36px"/></a> </div>
   
<%--播放结束--%> 
<div id="finishedBackground" style="position:absolute; left:255px; top:135px; width:730px; height:380px; display:none;"> 
<img src="images/popup_bg2.png" height="380" width="730"> </div>

<div id="endDiv" style="position:absolute; left:450px; top:200px; width:310px; height:262px; display:none; color:#FFFFFF; font-size:24px;">
<!-- <table height="72" width="310" border="0">
    <tr>
      <td style="color:#FFFFFF; font-size:36px;" align="center">谢谢观看</td>
    </tr>
  </table>-->
  <div style="position:absolute; left:50px;top:132px;font-size:28px; width:225px; text-align:center" align="center">1秒后自动退出</div>
  <a id="end" href="javascript:quit();" style="position:absolute; left: 55px; top: 124px;"><img src = "images/dot.gif" width="225px" height="37px"/></a> </div>
<%--播放结束--%> 

<%--错误提示层--%>
<div id="errorDiv" style="position:absolute; left:120x; top:300px; width:400px; height:80px; z-index:-1; display:none"> <img src="images/playcontrol/playVod/" width="400px" height="80px"/> </div>
<div id="errorDiv2" style="position:absolute; left:120x; top:300px; width:400px; height:80px; z-index:1;display:none">
  <table align="center" width = "400px" height="80">
    <tr>
      <td class="whiteFont" align="center" style="color:white;"> 系统错误，请按返回键退出或稍候再试！ </td>
    </tr>
  </table>
</div>
<%--隐藏层--%>
<div style="display:none">
  <%--获取数据--%>
  <iframe id="getDataIframe" width="0" height="0"></iframe>
</div>

<!---------------------------------新UI 快进快退------------------------------------->
<!--<div id="speedDiv" class="control_panel" style="display:none">
    <div id="currTime" class="playing_time"></div>
    <div id="statusImg" class="fasttime"><img src="images/playerimages/icon_fast.png" align="absmiddle"/> &nbsp;</div>
    <div id="beginTime" class="time1">00:00:00</div>
    <div class="progressbar"><img src="images/playerimages/line3.png" /></div>
    <div id="speedPos" class="bar"><img src="images/playerimages/bar.png" /></div>
    <div id="fullTime2" class="time2"></div>
    <div id="seekPercent" class="playing_time" style="top:170px"></div>
</div> -->   
<div id="speedDiv" class="control_panel control_panel3" style="display:none">
    <div id="currTime" class="playing_time" style="top:30px;">01:29</div>
    <div id="statusImg" class="fasttime" style="top:30px;"><img src="images/playerimages/icon_fast.png" align="absmiddle"/>X3</div>
    <div id="beginTime" class="time1" style="top:65px;">00:00:00</div>
    <div class="progressbar" style="top:80px;"><img src="images/playerimages/line3.png" /></div>
    <div id="speedPos" class="bar" style="top:72px;"><img src="images/playerimages/bar.png" /></div>
    <div id="fullTime2" class="time2" style="top:65px;">00:00:00</div>
    <div id="seekPercent" class="playing_time" style="top:30px; left:120px;">100%</div>
</div>    
<!---------------------------------新UI 快进快退------------------------------------->

<!---------------------------------新UI 定位------------------------------------->
<div id="seekDiv" style="display:none">  
  <div class="control_panel">
		<div id="currTimeShow" class="playing_time" style="top:100px"></div>
		<div id="seekBeginTime" class="time11">00:00:00</div>
		<div class="progressbar2"><img id="progressBar" src="images/playerimages/progressbarbg.jpg" /></div>
		<div class="bar2" id="currentTime_progress"><!--43px的倍数 总宽为903px--></div>
		<div id="fullTime" class="time22"></div>
  </div>
  
  <div class="control_panel2">
  		<div class="enter_time">
			<div>输入定位时间：</div>
            <div class="e1"><div id="jumpTimeHour" class="inp"></div></div>
            <div class="e2">时</div>
            <div class="e3"><div id="jumpTimeMin" class="inp"></div></div> 
            <div class="e4">分</div>
		</div>

        
        <div class="btns">	
			<div  id="jumpBtn">跳转</div>
			<div id="cancelBtn" style="left:200px;">取消</div>
	 	</div>
  </div>
</div>


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
<!-- 进度条及跳转框所在的div end-->
<div style=" visibility:hidden;">
<img src ="images/playcontrol/playChannel/chanMini_lostTimePro.png"/>
<img src ="images/playcontrol/playChannel/chanMini_timePro.png"/>
<img src="images/popup_bg2.png" />
<img src="images/playcontrol/playVod/pause.png" />
</div>
</body>
<%@ include file = "play_pageVideoControl.jsp"%>
</html>
