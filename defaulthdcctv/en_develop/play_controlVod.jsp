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
<meta name="page-view-size" content="1280*720" />
<%@page import="java.io.*"%>
<%

String progId = request.getParameter("PROGID"); //vod节目id
int iProgId = 0;	
String fatherId = request.getParameter("FATHERSERIESID");
String playType = request.getParameter("PLAYTYPE"); //播放类型
int iPlayType = 0;	
String beginTime = request.getParameter("BEGINTIME"); //节目播放开始时间
String breakpoint = request.getParameter("BREAKPOINT");
String vasBeginTime = request.getParameter("beginTime");
String productId = request.getParameter("PRODUCTID"); //订购产品id	
String serviceId = request.getParameter("SERVICEID"); //对应服务id	
String price = request.getParameter("ONECEPRICE"); //该产品对应价格	
String contentType = request.getParameter("CONTENTTYPE");
String vasFlag = request.getParameter("vasFlag"); //增值页面标志位
String backurl = request.getParameter("returnurl"); //如果是从增值服务页面进入的返回url
System.out.println("BACKURL===="+backurl);
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
if(fatherId == null || "".equals(fatherId) || "null".equals(fatherId) || "undefined".equals(fatherId))
{
	fatherId = "-1";
}
if(beginTime == null || "".equals(beginTime)|| "null".equals(fatherId))
{
	beginTime = "0";
}
if(breakpoint == null || "".equals(breakpoint))
{
	breakpoint = "0";
}
if(productId == null || "".equals(productId)|| "null".equals(fatherId))
{
	productId = "0";
}
if(serviceId == null || "".equals(serviceId)|| "null".equals(fatherId))
{
	serviceId = "0";
}
if(price == null || "".equals(price)|| "null".equals(fatherId))
{
	price = "0";
}
if(contentType == null || "".equals(contentType)|| "null".equals(fatherId))
{
	contentType =String.valueOf(EPGConstants.CONTENTTYPE_VOD);
}
String infoDisplay = "errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=26&ECTYPE="+itype;

/*******************对获取参数进行异常处理 end*************************/
MetaData metaData = new MetaData(request);
ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
ServiceHelp serviceHelp = new ServiceHelp(request);
BookmarkImpl bookmarkImpl = new BookmarkImpl(request);//书签
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
if( "1".equals(vasFlag))//增值业务使用老接口
{
	playUrl = serviceHelp.getTriggerPlayUrl(iPlayType,iProgId,"0");
	playUrl = playUrl + "&playseek="+vasBeginTime+"-"+endTime;
}
else
{
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
	}
	else
	{
		isSucess = false;
	}
}	
/*************************获取播放url end**************************************/
		
TurnPage turnPage = new TurnPage(request);

String goBackUrl = turnPage.getLast();;

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
body { font-family:"黑体"; font-size:30px; color:#FFFFFF;margin:0px;padding:0px;width:1280px; height:720px}
.blueFont
{ font:"黑体";color:#33CCFF;font-size:24px; line-height:30px }
.whiteFont line-height:30px
{font:"黑体";color:#FFFFFF;font-size:24px; line-height:30px }


/*control_panel*/
.control_load{ position:absolute; top:25px; right:35px}
.control_panel{ position:absolute; top:483px; background:url(images/playerimages/control_bbg.png) repeat-x; width:1280px; height:237px; z-index:7}
.control_panel3{ position:absolute; top:466px; background:url(images/playerimages/control_bbg3.png) repeat-x; width:1280px; height:100px; z-index:7}
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
	
.disno{ display:none}

/*popup*/
.popup,.popup2{ position:absolute; top:170px; left:290px; width:700px; height:380px; z-index:9}
	.popup{ background:url(images/popup_bg.png) no-repeat}
	.popup2{ background:url(images/popup_bg2.png) no-repeat}
.pop_fee,.pop_tip,.pop_price,.pop_buy{ position:absolute; left:80px; width:545px; text-align:center; line-height:46px}
	.pop_fee{ top:60px}
	.pop_tip{ top:170px}
	.pop_price{ top:120px}
	.pop_buy{ top:90px}
.pop_btns{ position:absolute; top:221px; left:120px; width:500px}
	.po1,.po2{ left:270px!important; width:160px!important}
	.po1{top:290px!important}
	.po2,.po3{top:250px!important}
	.po4{top:180px!important}
.pop_btns div,.btns div{ float:left; width:151px; height:39px; line-height:39px; text-align:center}
.pop_btns div.on,.btns div.on{ background:url(images/btn_bg.png) no-repeat}
	.btns{ position:absolute; top:40px; right:90px}
	.btns2{ position:absolute; top:630px; left:290px; width:750px}
	.btns2 div{ float:left; text-align:center; width:350px; height:40px; line-height:40px}
	.btns2 div.on{ background:url(images/channel_subon.png) no-repeat}
		.b2_po{ left:180px!important; width:350px!important}
		
	.btns3{ padding:35px 0;}
	.btns3 div{ float:left; text-align:center; width:214px; height:46px; line-height:46px}
	.btns3 div.on{ background:url(images/sub_bg3on.png) no-repeat}	
	
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
if (typeof(iPanel) != 'undefined')
{
iPanel.focusWidth = "4";
iPanel.defaultFocusColor = "#FCFF05";
}
var isChildren = "<%=isChildren%>";
var count=0;
var playStatFlag=0;
//页面加载前执行的数据转换与方法
//var playStatus = 0;
var itype="<%=itype%>";
var progId = '<%=iProgId%>'; //当前播放的vodid
var playType = '<%=iPlayType%>'; //播放的类型
var fatherId = '<%=fatherId%>'; //当前播放的vodid的父级id
var playUrl ='<%=playUrl%>';//触发机顶盒播放url
var beginTime = '<%=beginTime%>';
var breakpoint = '<%=breakpoint%>';
var endTime = '<%=endTime%>';
var isAssess = <%= iPlayType == EPGConstants.PLAYTYPE_ASSESS%>; //是否是片花播放
var isBookMark = <%= iPlayType == EPGConstants.PLAYTYPE_BOOKMARK%>; //是否为书签播放
var hideTime = <%=iShowDelayTime%>; //epg自动隐藏时间
var delayTime = 8000; //epg开机延时显示minepg时间
var dataIsOk = false; //数据是否准备结束
var goBackUrl = '<%=goBackUrl%>'+"&backvodid="+progId;
var succ=-1;//添加书签标记
var pk_interval_handle = null;//快进，快退进度条控制
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
var isJumpTime = 1;//跳转输入框是否显1默认显;
var playStat = "play";
var timeID_check = "";
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
var jumpPos = 4;//焦点在进度条上面
var jumpDivIsShow = false;
var seekDivIsShow = false;
var speedDivIsDispaly  = false;
var volumeDivIsShow = false;
var voiceIsShow=false;//静音是否显示 false:没有显示
var t = 0;
//szgx hhr 进入直播、VOD、回看频道，测试定位播放功能，输入小时（两位数），光标再移动到小时输入框，光标会自动跳到分钟输入框中。
var lastJumpPos = 0;
/**
*初始化mediaPlay对象
*/

var timeErrorDIvIsShow = false;//定位输入时间错误
function initMediaPlay()
{
	var instanceId = mp.getNativePlayerInstanceID(); //读取本地的媒体播放实例的标识
	var playListFlag = 0; // 0：单媒体的播放模式 (默认值)，1: 播放列表的播放模式
	var videoDisplayMode = 1; // 1: 全屏显示2: 按宽度显示，3: 按高度显示
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
	mp.initMediaPlayer(instanceId,playListFlag,videoDisplayMode,height,width,left,top,muteFlag,useNativeUIFlag,subtitleFlag,videoAlpha,cycleFlag,randomFlag,autoDelFlag);
	mp.setSingleMedia(mediaStr); //设置媒体播放器播放媒体内容
	mp.setAllowTrickmodeFlag(0); //设置是否允许trick操作。 0:允许 1：不允许
	mp.setNativeUIFlag(0); //播放器是否显示缺省的Native UI，  0:允许 1：不允许
	mp.setAudioTrackUIFlag(1);//设置音轨的本地UI显示标志 0:不允许 1：允许
	mp.setMuteUIFlag(1); //设置静音的本地UI显示标志 0:不允许 1：允许
	mp.setAudioVolumeUIFlag(1);//设置音量调节本地UI的显示标志 0:不允许 1：允许
	mp.refreshVideoDisplay();
}

/**
*播放
*/
function play()
{
	if(parseInt(breakpoint)>0)
	{
		mp.playByTime(1,breakpoint,1);
	}
	else if(isBookMark)
	{
	   //alert("有书签播放的时候beginTime="+beginTime+"endTime="+endTime);
		var type = 1;
		var speed = 1;
		mp.playByTime(type,beginTime,speed);
	}
	else
	{
		mp.playFromStart();
	}
}
/**
*进入页面后直接播放
*/
function start()
{	
	Authentication.CTCSetConfig("key_ctrl_ex","0");
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
var lightImages = new Array();
var darkImages = new Array();
lightImages[0] = "images/playcontrol/playVod/bookmark1.gif";
lightImages[1] = "images/playcontrol/playVod/sure1.gif";
lightImages[2] = "images/playcontrol/playVod/cancel1.gif";
lightImages[3] = "images/playcontrol/playVod/preVod1.jpg";
lightImages[4] = "images/playcontrol/playVod/nextVod1.jpg";

darkImages[0] = "images/playcontrol/playVod/bookmark.gif";
darkImages[1] = "images/playcontrol/playVod/sure.gif";
darkImages[2] = "images/playcontrol/playVod/cancel.gif";
darkImages[3] = "images/playcontrol/playVod/preVod.jpg";
darkImages[4] = "images/playcontrol/playVod/nextVod.jpg";
	
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
		case <%=KEY_RIGHT%>:return pressKey_right();			
		case <%=KEY_PAGEDOWN%>:return pressKey_pageDown();				
		case <%=KEY_PAGEUP%>:return pressKey_pageUp();
		case <%=KEY_PAUSE_PLAY%>:
		case <%=KEY_POS%>:
			  pauseOrPlay();return 0;
	    case <%=KEY_RETURN%>:pressKey_quit(); return 0; //退出时处理
		case <%=KEY_STOP%>:pressKey_Stop();return 0;
		case <%=KEY_VOL_UP%>:volumeUp();return false;
		case <%=KEY_VOL_DOWN%>:volumeDown();return false;
		case <%=KEY_FAST_FORWARD%>:fastForward();return false;
		case <%=KEY_FAST_REWIND%>:fastRewind();return false;
		case <%=KEY_IPTV_EVENT%>:goUtility();  break;
		case <%=KEY_MUTE%>:setMuteFlag();return false;
		case <%=KEY_BLUE%>:
		case <%=KEY_INFO%>:
			//window.location.href="space_collect.jsp";
			 pressOk(); return 0;
		case <%=KEY_TRACK%>:
		   changeAudio(); return 0;
		case <%=KEY_OK%>:	
		   // window.location.href="ajaxTest.jsp";
		   pressOk();return;
		//case 277:
		case  1109:
			mp.stop();window.location.href="dibbling.jsp";return 0;
		//case 276:
		case 1110:
			mp.stop();window.location.href="playback.jsp";return 0;
		//case 275:
		case 1108:
			mp.stop();window.location.href="channel.jsp";return 0;
		case 1111://通信
				return 0;
		  default:
				return videoControl(keyval);
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
	else if(audio=="2" ||  audio=="JointStereo" || audio=="Stereo" )
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
		$("jumpTimeHour").innerHTML = "";
    }else if(1==jumpPos){
		$("jumpTimeMin").innerHTML = "";
    }
}
function pressOk()
{
	var totalTime = mp.getMediaDuration();
	var currTime = parseInt(mp.getCurrentPlayTime()) + parseInt(count*60);
	if(currTime<=0)
	{
		currTime=1;
	}
	if(!seekDivIsShow&&speedDivIsDispaly==false)
	{	
		pressKey_info_Ok();
	}
	else if(jumpDivIsShow && jumpPos==4)
	{
		jumpDivIsShow=false;
		playByTime(currTime);
		$("seekDiv").style.visibility = "hidden";
		isSeeking = 0;
		speed = 1;
		seekDivIsShow =false;
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
	return 0;
}
//静音设置
function setMuteFlag()
{
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return true;}
	clearTimeout(showTimer);showTimer = "";	
	clearTimeout(bottomTimer);bottomTimer = "";	
	voiceIsShow = true;
	if(minEpgIsShow){hideMinEpg();}
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
	
//暂停
function pauseOrPlay()
{	
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return ;	}
	else if(minEpgIsShow){hideMinEpg();	//如果miniEPG显示，则隐藏
	}		
	speed = 1;
	jumpDivIsShow = true; 
	displaySeekTable(0);//显示进度条及跳转框	
/*	$("jumpTimeDiv").style.display = "block";
	$("jumpTimeImg").style.display = "block";*/
	playStatFlag=1;
}
	
function volumeUp()
{
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return true;}
	clearTimeout(showTimer);showTimer = "";
	volumeDivIsShow = true;
	if(minEpgIsShow){hideMinEpg();}
	var muteFlag =  mp.getMuteFlag();
	if(muteFlag == 1){mp.setMuteFlag(0);}
	if(voiceIsShow){hideMute();}
	volume = mp.getVolume();
	volume += 5;
	if(volume >100){volume = 100;return;}
	mp.setVolume(volume);
	if (mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
	{
		clearTimeout(bottomTimer);bottomTimer = "";
		genVolumeTable(volume);
		bottomTimer = setTimeout(hideBottom, 5000);
	}
}
//音量图片的隐藏
function hideBottom()
{	
	if(volumeDivIsShow == false)return;
	volumeDivIsShow = false;
	$("bottomframe").innerHTML = "";
}
//隐藏是否静音的图标	
function hideMute()
{
	$("voice").src="#";
	voiceIsShow=false;
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

    	tableDef += '<td width="20px"></td><td width="40px"><img border="0" src="images/playcontrol/playVod/volume.gif"></td><td width="40px" style="color:white;font-size:28">' + volume + '</td>';

    	tableDef += '</tr></table>';

    	$("bottomframe").innerHTML = tableDef;
    }
function volumeDown()
{
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return true;}
	clearTimeout(showTimer);showTimer = "";
	volumeDivIsShow = true;
	if(minEpgIsShow){hideMinEpg();}
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){mp.setMuteFlag(0);}
	if(voiceIsShow){hideMute();}
	volume = mp.getVolume();
	volume -= 5;
	if(volume < 0){volume = 0;return;}
	mp.setVolume(volume);
	if (mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
	{
		clearTimeout(bottomTimer);
		bottomTimer = "";
		genVolumeTable(volume);
		bottomTimer = setTimeout(hideBottom, 5000);
	}
}
	
	//显示时间进度条
    function displaySeekTable(playFlag)
    {
	    mediaTime = mp.getMediaDuration();
        //有时机顶盒取出的vod总时长有问题，在这里重新获取。initMediaTime是初始化页面时取出的总片铿
        if(undefined == mediaTime || typeof(mediaTime) != "number" || mediaTime.length == 0 || 0 == mediaTime || initMediaTime != mediaTime)
        {
            mediaTime = mp.getMediaDuration();
			//计算移动一格的单元
			timePerCell = mediaTime / 100;
        }
        //isSeeking等于0时展示进度条及跳转框
        if(isSeeking == 0)
        {
			isSeeking = 1;
            currTime = mp.getCurrentPlayTime();
            processSeek(currTime);
            var fullTimeForShow = "";
            fullTimeForShow = convertTime();			
            $("fullTime").innerHTML = fullTimeForShow;
			$("fullTime2").innerHTML = fullTimeForShow;
			//显示跳转框		   
			// $("jumpTimeHour").focus(); //给跳转框落焦点 20120315屏蔽
			jumpPos=4;
		    $("currentTime_progress").style.background="url(images/playerimages/progressbar.png)";
            //6秒后隐藏跳转输入框所在的div
            clearTimeout(timeID_jumpTime);
            timeID_jumpTime = "";
		    checkSeeking();//调用方法检测进度条及跳转框的状态
			if (playFlag != 1)
			{
			  $("seekDiv").style.visibility = "visible"; //显示进度条
			  $("speedDiv").style.visibility = "hidden";
			  speedDivIsDispaly  = false; 
			  seekDivIsShow = true;
            	pause();//暂停播放
				//playStatus= 0;
            }
        }
        else
        {
			clearTimeout(timeID_check);//清空定时            timeID_check = "";
            resetPara_seek();//复位各参数
			// 如果切换到开头则不需要恢复播放，机顶盒会自动播放
			if (playFlag != 2 && playFlag != 3)
			{
				speed = 1;
            	resume();//恢复播放状态
            }
			seekDivIsShow = false;
			jumpDivIsShow = false;
            $('seekDiv').style.visibility = 'hidden';
			jumpPos = 0;	
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
		jumpDivIsShow = true;
        /*$("jumpTimeDiv").style.display = "block";
        $("jumpTimeImg").style.display = "block";*/
	    $("jumpTimeHour").innerHTML = "";
        $("jumpTimeMin").innerHTML = "";
//        $("timeError").innerHTML = "";//请输入时间！
        /*
         ZTE
         */
        $("jumpTimeHour").className = "inp";
		$("jumpTimeMin").className = "inp";
		$("jumpBtn").className = "btnoff";
		$("cancelBtn").className = "btnoff";
	//	$("timeError").innerHTML = "";
        //$("statusImg").innerHTML = '<img border="0" src="images/playcontrol/playVod/pause.png" width="40" height="40"/>';
		$("speedDiv").style.visibility = "hidden";
		speedDivIsDispaly  = false;
    }
function checkSeeking()
{       
	if(isSeeking == 0){clearTimeout(timeID_check);timeID_check = "";}
	else{
		//下面一行代码的作用：获取不到文本框中的值，动态刷新文本框所在div可以解决
		if(playStat != "fastrewind" && playStat != "fastforward")
		{
			$("statusImg").innerHTML = '<img src="images/playerimages/pause.png" width="40" height="40"/>';
		}
		var inputValueHour = $("jumpTimeHour").innerHTML;
		var inputValueMin = $("jumpTimeMin").innerHTML;
		//szgx hhr
		if(2==inputValueHour.length && 0==jumpPos && 0==lastJumpPos){$("jumpTimeMin").className = "inp inp-focus";jumpPos=1;lastJumpPos=1;}
		if(2==inputValueMin.length && 1==jumpPos && 2>lastJumpPos){$("jumpBtn").className = "btnon";jumpPos=2;lastJumpPos=2;}
		clearTimeout(timeID_check);timeID_check = setTimeout(checkSeeking,500);
		if(playStatFlag==0 && (playStat == "fastrewind" || playStat == "fastforward"))
		{	
			currTime = mp.getCurrentPlayTime();processSeek(currTime);
		}
		if(preInputValueHour != inputValueHour || preInputValueMin != inputValueMin)
		{               
			var tempTimeID = timeID_jumpTime;
			//6秒后隐藏跳转输入框所在的div
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
	//	beginTime = tempCurrTime;
	}
	var type = 1;
	var speed = 1;
	playStat = "play";
    currTime = mp.getCurrentPlayTime();
	//if(beginTime==0){beginTime=currTime;} //20120523
	mp.playByTime(type,beginTime,speed);
	mp.setVideoDisplayMode(1);
	mp.refreshVideoDisplay();
	count=0;
	jumpPos=0;
	$("currentTime_progress").style.background="url(images/playerimages/progressbar02.png)";
    /*
         ZTE
         */
//	$("jumpTimeHour").focus();
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
        else
        {
            return true;
        }
        
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

	 //判断是否在播放时长内
    function isInMediaTime(pHour, pMin)
    {
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
        var alltime=pHour*3600+pMin*60
		return (alltime <= mediaTime);
	}
	
//定时选择按钮
function clickJumpBtn()
{
	var inputValueHour = $("jumpTimeHour").innerHTML;
	var inputValueMin = $("jumpTimeMin").innerHTML;
	_time = mp.getMediaDuration();
	if(isEmpty(inputValueHour)){inputValueHour="00";}
	if(isEmpty(inputValueMin)){ inputValueMin="00";}
	if(checkJumpTime(inputValueHour, inputValueMin))
	{
	    var hour = parseInt(inputValueHour,10);
	    var mins = parseInt(inputValueMin,10);
		var timeStamp =  hour*3600 + mins*60;
		clearTimeout(timeID_jumpTime);
		timeID_jumpTime = "";
		isJumpTime = 0;
		/*$("jumpTimeDiv").style.display = "none";
		$("jumpTimeImg").style.display = "none";*/
		$("jumpTimeHour").innerHTML = "";
		$("jumpTimeMin").innerHTML = "";
	    displaySeekTable(3);
		jumpToTime(timeStamp);
	}
	//校验不通过，提示用户时间输入不合理
	else
	{
		$("timeErrorDIv").style.display = "block";
		timeErrorDIvIsShow = true ;
		$("jumpTimeHour").innerHTML = "";
		$("jumpTimeMin").innerHTML = "";
		preInputValueHour = "";
		preInputValueMin = "";	
		$("jumpBtn").className = "btnoff";	
		$("jumpTimeHour").className = "inp inp-focus";	
		jumpPos = 0;
		//15秒后隐藏跳转输入框所在的div"
	   clearTimeout(timeID_jumpTime); timeID_jumpTime = ""; 
	   //timeID_jumpTime = setTimeout("hideJumpTimeDiv();",15000);
	}
	count=0;
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
	//jumpDivIsShow = false;
	var inputValueHour = $("jumpTimeHour").innerHTML;
	var inputValueMin = $("jumpTimeMin").innerHTML;

	//如果文本框中的值为空，隐藏div
	if(isEmpty(inputValueHour) || isEmpty(inputValueMin))
	{
		isJumpTime = 0;
		$("jumpTimeHour").className = "inp";
		$("jumpTimeMin").className = "inp";
		 /*$("jumpTimeDiv").style.display = "none";
		 $("jumpTimeImg").style.display = "none";*/
	}
	//如果文本框中有值则调用clickJumpBtn方法
	else
	{
		clickJumpBtn();
	}
	count=0;
	jumpPos=0;
	$("currentTime_progress").style.background="url(images/playerimages/progressbar02.png)";
    /*
         ZTE
         */
//	$("jumpTimeHour").focus();
}
	
function isEmpty(s)
{
	return ((s == undefined) || (s == "") || (s == null) || (s.length == 0));
}
 function convertTime(_time)
{
	if(undefined == _time || _time.length == 0)
	{
		_time = mp.getMediaDuration();
	}

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
	else
	{
		time_min = String(_time / 60);
	}

	tempIndex = (String(time_min / 60)).indexOf(".");
	if(tempIndex != -1)
	{
		time_hour = (String(time_min / 60)).substring(0,tempIndex);
		tempIndex = -1;
	}
	else
	{
		time_hour = String(time_min / 60);
	}

	time_min = String(time_min % 60);
	if("" == time_hour || 0 == time_hour)
	{
		time_hour = "00";
	}

	if("" == time_min || 0 == time_min)
	{
		time_min = "00";
	}

	if("" == time_second || 0 == time_second)
	{
		time_second = "00";
	}


	if(time_hour.length == 1)
	{
		time_hour = "0" + time_hour;
	}

	if(time_min.length == 1)
	{
		time_min = "0" + time_min;
	}

	if(time_second.length == 1)
	{
		time_second = "0" + time_second;
	}

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
        if (timePerCell == 0)
        {
            currCellCount  = 0;
        }
        if(currCellCount > 100)
        {
            currCellCount = 100;
        }
        if(currCellCount < 0)
        {
            currCellCount = 0;
        }
       
//	if( (currCellCount == 0) || ( currCellCount == 100 ) )
//      		 hideAllDiv();	

	$("seekPercent").innerHTML = currCellCount + "%";
   
        var currTimeDisplay = convertTime(_currTime);//将时间（单位：秒）转换成在页面中显示的格式（HH：MM?
	    /*if(currCellCount >= 100)
		{
			 $("td_0").style.width = 1000;	//990
			 $("td_1").style.width = 0; //10
		}
		else if(currCellCount<=0)
		{
			 $("td_0").style.width = 0;	//10
			 $("td_1").style.width = 1000;	//990
		}
		else
		{
			$("td_0").style.width = currCellCount * 10;
			$("td_1").style.width = 1000- currCellCount * 10;
		}
        $("currTimeShow").innerHTML = currTimeDisplay;
		$("td_0").bgColor =  "#DAA520";
		$("td_1").bgColor =  "#000080";*/
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
	if(minEpgIsShow){hideMinEpg();}
    if(isSeeking == 0)
	{	
		displaySeekTable(1);
		clearTimeout(timeID_jumpTime);
		timeID_jumpTime = "";
		isJumpTime = 0;
		/*$("jumpTimeDiv").style.display = "none";
		$("jumpTimeImg").style.display = "none";*/
	}
	//if(speed >= 32 && playStat == "fastforward"){displaySeekTable();return 0;}
	$("speedDiv").style.visibility = "visible"; //显示进度条
	speedDivIsDispaly  = true;
	$("seekDiv").style.visibility = "hidden"; 
	seekDivIsShow = false;
	if(playStat == "fastrewind"||(speed >= 32 && playStat == "fastforward")) speed = 1;
	speed = speed * 2;
	playStat = "fastforward";
	mp.fastForward(speed);
	$("statusImg").innerHTML = '<img src="images/playerimages/icon_fast.png" align="absmiddle"/>&nbsp;X' + speed;
}
	
//后退
function fastRewind()
{	
	playStatFlag=0;
	if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow){return;}
	if(minEpgIsShow){hideMinEpg();}

	if(isSeeking == 0)
	{
		displaySeekTable(1);
		clearTimeout(timeID_jumpTime);
		timeID_jumpTime = "";
		isJumpTime = 0;
		/*$("jumpTimeDiv").style.display = "none";
		$("jumpTimeImg").style.display = "none";*/
	}
	$("speedDiv").style.visibility = "visible"; //显示进度条
	speedDivIsDispaly  = true;
	$("seekDiv").style.visibility = "hidden"; 
	seekDivIsShow = false;
	if (playStat == "fastforward"||(speed >= 32 && playStat == "fastrewind")) {speed = 1;}			
	speed = speed * 2;
	playStat = "fastrewind";				
	mp.fastRewind(-speed);				
	$("statusImg").innerHTML = '<img src="images/playerimages/icon_refast.png" align="absmiddle"/>&nbsp;X' + speed;
}
	
	function pressKey_up()
	{
		if(quitDivIsShow){mainPressKeyUp();}
		else if(oneKeySwitchJumpInfoIsShow){commonPressKeyUp();}
		else if(jumpToChannelInfoIsShow){commonPressKeyUp();}
		else if(jumpDivIsShow){
			//20120315修改屏蔽
			jumpPos=4;
			$("jumpTimeMin").className = "inp";
			$("jumpTimeHour").className = "inp";
			$("cancelBtn").className = "btnoff";
			$("jumpBtn").className = "btnoff";
			//$("currentTime").focus();
		    $("currentTime_progress").style.background="url(images/playerimages/progressbar.png)";
			return;
		}
		return false;
	}
	
	function pressKey_down()
	{
		if(quitDivIsShow)
		{
			mainPressKeyDown();
		}
		else if(oneKeySwitchJumpInfoIsShow)
		{
			commonPressKeyDown();
		}
		else if(jumpToChannelInfoIsShow)
		{
			commonPressKeyDown();
		}
		else if(jumpDivIsShow && jumpPos==4)
		{
			jumpPos=0;
			$("jumpTimeHour").className = "inp inp-focus";
			$("currentTime_progress").style.background="url(images/playerimages/progressbar02.png)";
			return;
		}
		return false;
	}

	function pressKey_left()
	{
		if(quitDivIsShow)
		{
			mainPressKeyLeft();
		}
		else if(finishedDivIsShow)
		{
			finishedPressKeyLeft();
		}
		else if(oneKeySwitchJumpInfoIsShow)
		{
			commonPressKeyLeft();
		}
		else if(jumpToChannelInfoIsShow)
		{
			commonPressKeyLeft();
		}
		else if(seekDivIsShow)
		{
			if(jumpDivIsShow)
			{ 
			   jumpPressKeyLeft();
			}
		}
		else if(speedDivIsDispaly)
		{
			//不做响应
		}
		else
		{
            volumeDown();
			//fastRewind();
		}
		
		return false;
	}
	
	function pressKey_right()
	{		
		if(quitDivIsShow)
		{
			mainPressKeyRight();
		}
		else if(finishedDivIsShow)
		{
			finishedPressKeyRight();
		}
		else if(oneKeySwitchJumpInfoIsShow)
		{
			commonPressKeyRight();
		}
		else if(jumpToChannelInfoIsShow)
		{
			commonPressKeyRight();
		}
		else if(seekDivIsShow)
		{
			if(jumpDivIsShow)
			{
			  jumpPressKeyRight();
			}
		}
		else if(speedDivIsDispaly)
		{
			//不做响应
		}
		else
		{
			volumeUp();
			//fastForward();
		}
		return false;
	}
	//暂停键后的方向键的操作
	function jumpPressKeyRight()
	{
		//说明：0:小时 1：分 2：确认 3：取消 4：进度
		if(jumpPos>4)
		{
			jumpPos=4;
		}
		if(jumpPos == 0){
			$("jumpTimeHour").className = "inp";
			$("jumpTimeMin").className = "inp inp-focus";
			jumpPos++;
		}
		else if(jumpPos == 1){
			$("jumpTimeMin").className = "inp";
			$("jumpBtn").className = "btnon";
			jumpPos++;
		}
		else if(jumpPos==2){
			$("jumpBtn").className = "btnoff";
			$("cancelBtn").className = "btnon";
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
			 // alert(currTime);
			  processSeek(currTime);
		}
	}
	function jumpPressKeyLeft()
	{
		if(jumpPos<0)
		{
		  jumpPos==0;
		}
		if(jumpPos == 1){
			$("jumpTimeMin").className = "inp";
			$("jumpTimeHour").className = "inp inp-focus";
			jumpPos--;
		}
		else if(jumpPos == 2){
			$("jumpBtn").className = "btnoff";
			$("jumpTimeMin").className = "inp inp-focus";
			jumpPos--;
		}
		else if(jumpPos==3){
			$("cancelBtn").className = "btnoff";
			$("jumpBtn").className = "btnon";
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
			//alert(currTime);
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
			if(!dataIsOk)//数据未准备好
			{
				return true;
			}
			if(minEpgIsShow)
			{
				hideMinEpg();
			}
			else
			{
				showMinEpg();
			}
			return true;
		}
	}
	function pressKey_info_Ok()
	{
		if(!quitDivIsShow && !jumpToChannelInfoIsShow && !oneKeySwitchJumpInfoIsShow && !errorDivIsShow &&!finishedDivIsShow)
		{
			if(!dataIsOk)//数据未准备好
			{
				return true;
			}
			if(minEpgIsShow)
			{
				hideMinEpg();
			}
			else
			{
				showMinEpg();
			}
		
			return true;
		}
		else if(quitDivIsShow)
		{	
			
		//	mainPressKeyOk();
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
			if(isAssess)
			{
				return false;
			}
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
	if(minEpgIsShow){hideMinEpg();return;}
	else if(isSeeking == 1)
	{	
		//隐藏进度条和跳转框
		if(0==jumpPos || 1==jumpPos){
			delInputTime();return 0;
		}
		else
		{
			displaySeekTable(1);
			count=0;
			jumpPos=0;
			$("currentTime_progress").style.background="url(images/playerimages/progressbar02.png)";
		}
        /*
         ZTE
         */
//		$("jumpTimeHour").focus();
	}else{
		hideAllDiv();//这一句话对性能有影响
		resetQuitDiv();//进入退出层时，重置退出层
		setTimeout(showQuitDiv,200) //显示退出层
		pause();
	}
}
	
	function pressKey_Stop()
	{
		//判断miniEPG数据是否取好，频道跳转层是否显示，一键跳转是否显示，退出层是否显示，结束提示层是否显示
		if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || quitDivIsShow || finishedDivIsShow)
		{
			return;
		}
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
		if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow)
		{
			return false;
		}
		/*
		if(fatherId == -1)
		{
			goStart();
		}*/
		goStart();
		//goPreProg();
		hideAllDiv();
		return true;
	}
	
	function pressKey_pageDown()
	{	
		
		if(!dataIsOk || jumpToChannelInfoIsShow || oneKeySwitchJumpInfoIsShow || errorDivIsShow || quitDivIsShow || finishedDivIsShow)
		{
			return false;
		}
		goEnd();
		hideAllDiv();
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

		if(10 == type)
		{
			showMediaError();
		}
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
		playStat = "pause"
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
	//	setSTB();
		hideQuitDiv();
	}
	
/**
*退出当前页
*/
function quit()
{	
	clearTimeout(t);
	var url = goBackUrl;
	if(errorDivIsShow){hideErrorDiv();}
	mp.stop();
	//搜索页面转码
	if(url.indexOf("self_ResultList.jsp")==0)
	{
		if(itype==1){url = encodeURI(url);window.location.href = addViewRecord(url) ;}
		else if(itype==0){window.location.href = addViewRecord(url);	}		
	}
	else{window.location.href = addViewRecord(url);	}
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
	window.location.href =addViewRecord(url);
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
		if(errorDivIsShow == true)
		{
			hideErrorDiv();
		}
		if(errorDivIsShow == true)
		{
			hideErrorDiv();
		}
		 addBook();
		 /*添加书签后根据是否成功作相应处理
		 mp.stop();
//ZTE 20120630
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
    var backurl = url;
		//var backurl = goBackUrl+"&sitcom="+sitNum;
		window.location.href =backurl;
		*/
	}
	

/**
*播放上一集
*/
function goPreProg()
{
	clearTimeout(minEpgShowDelayId);
	if(preProgId == '-1')
	{
		return true;
	}
	var jumpUrl = "au_PlayFilm.jsp?PROGID=" + preProgId + "&PROGTYPE=" + '<%=EPGConstants.VOD_ISSITCOM_YESSUBFILM %>'
			 + "&PLAYTYPE=" + '<%=EPGConstants.PLAYTYPE_VOD%>' + "&CONTENTTYPE=" + '<%=EPGConstants.CONTENTTYPE_VOD_VIDEO%>'
			 + "&BUSINESSTYPE=" + '<%=EPGConstants.BUSINESSTYPE_VOD%>' + "&ISTVSERIESFLAG=1&FATHERSERIESID=" + fatherId+"&TYPE_ID="+typeId+"&returnurl="+escape(goBackUrl);
	if(preCanPlay=="1")
	{
		jumpUrl = "errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=129" ;
	}
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
	if(nextCanPlay=="1")
	{
		jumpUrl = "errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=129" ;
	}
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
		bookMarkIsShow();
		//genSeekTable();
	}
	
	/**
	*获取数据
	*/
	function loadData()
	{
		var dataIframe = $("getDataIframe");
		dataIframe.src = "play_controlVodData.jsp?progId="+ progId + "&fatherId=" + fatherId+"&isChildren="+isChildren;
	}

	//添加观影记录（断点）
	function addViewRecord(tmpurl)
	{
		var _currtime = mp.getCurrentPlayTime(); 
		var _mediatime = mp.getMediaDuration(); 
		var _breakpoint = 0;
		if(_currtime != undefined && _mediatime != undefined)
		{
			_breakpoint = _currtime;
		}
		tmpurl += "addViewRecord.jsp?SUPVODID=<%=fatherId%>&PROGID=<%=progId%>&PROGTYPE=<%=contentType%>&BREAKPOINT="+_breakpoint+"&JUMPURL="+escape(url);
		return tmpurl;
	}
	//添加书签
	function addBook()
	{
		var bookIframe=$("addBookIframe");
	    var progTime=mp.getCurrentPlayTime(); //读取当前播放的时间
		var endTime = mp.getMediaDuration(); //该vod播放时长
		//var addBookUrl="datajsp/space_bookMarkAdd_iframedata.jsp?SUPVODID=<%=fatherId%>&PROGID=<%=progId%>&BEGINTIME="+progTime+"&ENDTIME="+endTime;
		//alert("addBookUrl:"+addBookUrl);
		//bookIframe.src=addBookUrl;
		getAJAXData("datajsp/space_bookMarkAdd_iframedata.jsp?SUPVODID=<%=fatherId%>&PROGID=<%=progId%>&BEGINTIME="+progTime+"&ENDTIME="+endTime,GetJson);
	}
    function GetJson(num)
	{
		 $("quitDiv").style.display = "none";
		 var code = parseInt(num);
		 switch(code){
				case 0://添加书签失败
					$("bookmark_msg").innerHTML = "添加书签失败，请稍后再试";
					$("tip_bookmark").style.display = "block";
					setTimeout("quit();",1000);
					break;
				case 1://添加书签成功
					quit();
					break;
				case 2://书签列表已满
					$("bookmark_msg").innerHTML = "书签列表已满，请删除后再操作";
					$("tip_bookmark").style.display = "block";
					setTimeout("quit();",1000);
					break;
				default:
					$("bookmark_msg").innerHTML = "添加书签失败, 返回码为"+code;
					$("tip_bookmark").style.display = "block";
					setTimeout("quit();",1000);
					break;
		} 	
	}
	
	/**
	*判断是否要显示书签
	*/
	//var showBookMark = false;
	function bookMarkIsShow()
	{
		if(!isAssess)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

/*************************涉及页面层显示部分 start**************************************************/
	var errorDivIsShow = false; //错误提示层是否显示标志位
	/**
	*显示错误提示层
	*/
	function showErrorDiv()
	{
		if(errorDivIsShow)
		{
			return true;
		}
		
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
		if(minEpgIsShow)
		{
			return;
		}
		if(volumeDivIsShow)
		{
			hideBottom();
		}
		if(jumpDivIsShow)
		{	
			return; //如果跳转层显示,则返回
			hideJumpTimeDiv();
		}
		if(seekDivIsShow)
		{	
			return;//如果进度条显示，则不显示miniEPG
			$("seekDiv").style.visibility = "hidden";
		}
		var minEpgDiv = $("minEpgDiv");
		minEpgDiv.style.display = "block";

		minEpgIsShow = true;
		minEpgHideDelayId = setTimeout("hideMinEpg()",hideTime);
	}
	/**
	*隐藏minEPG
	*/
	function hideMinEpg()
	{
		if(minEpgIsShow == false)
		{	
			return;
		}
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
		setTimeout(delayCreateMinEpg,1200);
	}
	function delayCreateMinEpg()
	{
			$("vodName").innerHTML = vodName;
			$("director").innerHTML = director;
			$("actor").innerHTML = actor;
			$("time").innerHTML = getVodTime();
			$("introduce").innerHTML = introduce;
			minEpgShowDelayId = setTimeout(showMinEpg,delayTime);
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
	//clearTimeout(minEpgShowDelayId);//20110821
}
	/**
	*隐藏退出层
	*/
	function hideQuitDiv()
	{
        if(quitDivIsShow == false)
		{
			return;
		}
		$("quitDiv").style.display = "none";
		//$("bottomAd").style.display = "none";
		quitDivIsShow = false;
		
	}
	function hideFinishedDiv()
	{
		if(finishedDivIsShow == false)
		{
			return;
		}
		$("finishedBackground").style.display = "none";
		//$("bottomAd").style.display = "none";
		if(nextProgId != "-1")
		{
			$("preNextDiv").style.display = "none";
		}
		else
		{
			$("endDiv").style.display = "none";
		}
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
			t = setTimeout(goNextProg,3000);
		}
		else
		{
			$("endDiv").style.display = "block";
			$("end").focus();
			positionFlag = 5;
			tempTime=  setTimeout(antoQuit,1000);
		}
		finishedDivIsShow = true;
	}
	
	function antoQuit()
	{
		 clearTimeout(tempTime);
	  	 window.location.href =addViewRecord(goBackUrl);
	}
	/**
	*生成退出层,在数据获取页面调用（子页面）
	*/
	function createQuitDiv()
	{
		if(!isAssess)
		{
			$("saveBookMark").style.display = "block";
		}
		if(preProgId != "-1")
		{
			$("prePlay").style.visibility = "visible";
		}
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
		if(jumpDivIsShow)
		{
			hideJumpTimeDiv();
		}
		$("seekDiv").style.visibility = "hidden";
		seekDivIsShow =false;
		$("speedDiv").style.visibility = "hidden";
		speedDivIsDispaly = false;
		isSeeking = 0;		
		jumpPos =0 ;
		count=0;
		$("currentTime_progress").style.background="url(images/playerimages/progressbar02.png)";
        /*
         ZTE
         */
//		$("jumpTimeHour").focus();
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
		
		if(hour < 10)
		{
			hour = '0' + hour;
		}
		
		if(minute < 10)
		{
			minute = '0' + minute;
		}
		
		if(second < 10)
		{
			second = '0' + second;
		}
		time = hour + ':'+ minute + ':' + second;
    	return time;
    }
	
    /**
     *生成进度条，此方法只是生成背景，具体进度在processSeek方法中生憿
     *整个进度条长度为500像素，每个td即片长的1%斿像素
     */
function genSeekTable()
{
	var seekTableDef = "";
	seekTableDef = '<table width="1000" height="" border="0" cellpadding="0" cellspacing="0" bgcolor="#000080"><tr>';
	seekTableDef +='<td id="td_0" width="0%" height="20" style="border-style:none;"></td>';
	seekTableDef +='<td id="td_1" width="100%" height="20" style="border-style:none;"></td>';
	seekTableDef += '</tr></table>';
	$("seekTable").innerHTML = seekTableDef;
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
<body bgcolor="transparent" leftmargin="0px" topmargin="0px" marginwidth="0px" marginheight="0px" style="background-color: transparent" onLoad="start();init()" onUnload="unload()">
<div style="width:1px; height:1px; top:1px; left:1px;">
<a id="currentTime" href="#" style="width:1px; height:1px; top:-1px; left:-1px;"><img src="images/dot.gif" width="1px" height="1px"/></a>
</div>

<div id="bottomframe" style="position:absolute;left:60px; top:430px; width:1200px; height:190px;color:green;font-size:36;"></div>

<!-- 进度条及跳转框所在的div begin-->
<!--ZTE -->
<!--<div id="seekDiv" style="position:absolute;width:1280px;height:200px;left:0px;top:413px; z-index:1;display:none;"> -->

<!---------------------------------新UI 快进快退------------------------------------->
<div id="speedDiv" class="control_panel control_panel3" style="visibility:hidden">
    <div id="currTime" class="playing_time" style="top:30px;"></div>
    <div id="statusImg" class="fasttime" style="top:30px;"><img src="images/playerimages/icon_fast.png" align="absmiddle"/> &nbsp;</div>
    <div id="beginTime" class="time1" style="top:65px;">00:00:00</div>
    <div class="progressbar" style="top:80px;"><img src="images/playerimages/line3.png" /></div>
    <div id="speedPos" class="bar" style="top:72px;"><img src="images/playerimages/bar.png" /></div>
    <div id="fullTime2" class="time2" style="top:65px;"></div>
    <div id="seekPercent" class="playing_time" style="left:120px;top:30px"></div>
</div>    
<!---------------------------------新UI 快进快退------------------------------------->

<!---------------------------------新UI 定位------------------------------------->
<div id="seekDiv" style="visibility:hidden">  
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

<%--minEPG显示层开始--%>
<div style="position:absolute; left:15px; top:15px; width:54px; height:66px; z-index:3;"><img id="voice" src="images/dot.gif"/></div>
<div id="minEpgDiv" style="display:none;">
<div id="minEpgBackground" style="position:absolute; bottom:0; background:url(images/control_bbg.png) repeat-x; width:1280px; height:237px;left:0px; top:500px; z-index:1;"></div>
<div style="position:absolute; left:5px; top:518px; width:1280px; height:160px; z-index:2;">
  <table width="1280" height="220">
    <tr>
      <td  height="3"></td>
    </tr>
   <tr>
      <td valign="bottom" height="25"><table>
          <tr valign="bottom">
            <td width="15"  height="25"></td>
            <td id="vodName" style="font-size:26px;color:#fff" align="left"></td>
          </tr>
        </table></td>
    </tr>
    <tr height="3">
      <td></td>
    </tr>
    <tr height="25">
<!--ZTE -->     
 <td style="overflow:hidden"><table width="90%">
          <tr>
            <td class="blueFont"> 【导演】 </td>
            <td style="width:300px; height:20px;overflow:hidden;line-height:20px;align:left;color:#fff;font-size:24px" id="director">
		
			</td>
            <td class="blueFont"> 【演员】 </td>
            <td style="width:300px; height:20px;overflow:hidden;line-height:20px;align:left;color:#fff;font-size:24px" id="actor">
	
			</td>
            <td class="blueFont"> 【时长】 </td>
            <td id="time" style="font-size:26px;color:#fff" align="left"></td>
          </tr>
        </table></td>

    </tr>
    <tr height="3">
      <td></td>
    </tr>
    <tr>
<!-- ZTE-->
      <td valign="top"><table width="100%"> 
          <tr>
            <td width="20"></td>
           <!-- <td class="whiteFont" valign="top" width="80">-->
            <td class="whiteFont" valign="top" width="80" style="font-size:26px;color:#fff"> 简介: </td>
            <td id="introduce" style="font-size:25px;color:#fff" align="left" ></td>
          </tr>
        </table></td>
    </tr>
  </table>
</div>
</div>
<%--minEPG显示层结束--%>

<%-- AD-begin--%>
<div id="bottomAd" style="position:absolute; bottom:0; left:0; background:url(../images/bottombg.png) repeat-x; width:1280px; height:152px;z-index:4;display:none;">
		<div class="bottom_ad" style="position:absolute; top:40px; left:72px"><img src="images/temp/ad_1.jpg" /><img src="images/temp/ad_2.jpg" /><img src="images/temp/ad_3.jpg" /></div>	
</div>
<%--AD-END--%>

<%--退出层开始--%>
<div id="quitDiv" style="display:none;">

<div style="position:absolute; left:255px; top:135px; width:380px; height:262px;" align="center">
 <img src="images/popup_bg2.jpg" height="360px" width="730px"></div>
 
<div style="position:absolute;left:390px;top:155px;width:730px;height:480px;z-index:1;color:#FFFFFF;font-size:32px;">
   <!-- ZTE -->
   <!-- <table height="250px" width="450px" border="0"> -->
   <table height="250px" width="450px" border="0" style="color:#FFFFFF;font-size:32px;">
    <tr height="20px">
      <td colspan="5"></td>
    </tr>
    <tr>
      <td colspan="5" align="center">您是否要退出当前收看节目?</td>
    </tr>
    <tr>
      <td></td><td align="center" >退出</td><td></td><td align="center">取消</td> <td></td>
    </tr>
    <tr>
      <td></td><td colspan="3" align="center">加入书签并退出</td> <td></td>
    </tr>
  </table>
  <a id="quit" href="javascript:quit();" style="position:absolute;left:71px;top:114px;"><img src = "#" width="83px" height="36px"/></a> 
  <a id="cancel" href="javascript:cancel();" style="position:absolute;left:294px;top:114px;"><img src = "#" width="83px" height="36px"/></a>
  <a id="bookmark" href="javascript:saveBookMark();" style="position:absolute;left:112px; top:191px;"><img src = "#" width="225px" height="36px"/></a> 
</div>

</div>
<%--退出层结束--%> 
  
<!--连续剧播放下一集-->
<div id="finishedBackground" style="position:absolute; left:255px; top:135px; width:730px; height:380px; display:none;"> 
<img src="images/popup_bg2.png" height="380" width="730"> </div>
<div id="preNextDiv" style="position:absolute; left:450px; top:155px; width:730px; height:480px;display:none; z-index:2; color:#FFFFFF; font-size:24px;">
  <table height="140" width="320">
    <tr height="20px">
      <td colspan="5"></td>
    </tr>
    <tr>
      <td colspan="5" style="color:#FFF">您是否继续收看下一集?</td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td style="color:#FFF">下一集</td>
      <td>&nbsp;</td>
      <td style="color:#FFF">退出</td>
      <td>&nbsp;</td>
    </tr>
  </table>
  <div style="position:absolute; left:-80px; top:170px;"> <img height="120px" width="450px" src="images/temp/11.jpg" /> </div>
  <a id="nextProg" href="javascript:goNextProg();" style="position:absolute; left: 23px; top: 90px;"><img src = "images/dot.gif" width="83px" height="36px"/></a>
  <a id="finishedQuit" href="javascript:quit();"  style="position:absolute;left:178px; top:90px;"><img src = "images/dot.gif" width="83px" height="36px"/></a>
</div>

<!--书签提示层-->
<div class="popup" id="tip_bookmark" style="display:none;">
	<div class="pop_tip" id ="bookmark_msg">节目已成功加入收藏/节目已移除收藏</div>		
</div> 
<!--书签提示层-->

<%--播放结束层--%>
<div id="endDiv" style="position:absolute; left:450px; top:200px; width:310px; height:262px; display:none; color:#FFFFFF; font-size:24px;">
 <table height="72" width="320" border="0">
    <tr>
      <td style="color:#FFFFFF; font-size:40px;" align="center">谢谢观看</td>
    </tr>
  </table>
  <div style="position:absolute; left:50px;top:132px;font-size:28px">1秒后自动退出</div>
  <a id="end" href="javascript:quit();" style="position:absolute; left: 73px; top: 12px; "><img src = "images/dot.gif"  width="170px" height="44px"/></a> 
</div>
<%--播放结束--%>

<%--错误提示层--%>
<div id="errorDiv" style="position:absolute; left:120px; top:300px; width:400px; height:80px; z-index:-1; display:none"> <img src="images/playcontrol/playVod/errorBack.gif" width="400px" height="80px"/></div>
<div id="errorDiv2" style="position:absolute; left:120px; top:300px; width:400px; height:80px; z-index:1;display:none">
  <table align="center" width="400" height="80">
      <tr>
        <td class="whiteFont" align="center"> 系统错误，请按返回键退出或稍候再试！</td>
      </tr>
  </table>
</div>

<%--隐藏层--%>
<div style="display:none">
  <%--获取数据--%>
  <iframe id="getDataIframe" width="1px" height="1px"></iframe>
  <%--记录书签--%>
  <iframe id="addBookIframe" width="1px" height="1px"></iframe>
</div>
 

<div style="display:none;">
<img src="images/popup_bg2.png" />
<img src="images/playcontrol/playVod/pause.png" />
</div>
</body>
<%@ include file = "play_pageVideoControl.jsp"%>
</html>
