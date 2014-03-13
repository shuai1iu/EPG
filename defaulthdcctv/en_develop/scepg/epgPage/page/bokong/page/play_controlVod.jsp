<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<link type="text/css" rel="stylesheet" href="../css/playstyle.css" />
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
	top:1px;
	text-align:center;
	width: 109px;
}
.pop_btns .btn02 { width:105px; visibility:hidden}
.pop_btns div.on2 { visibility:visible;}
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

.mod-pop-box {
	background: url(../images/pop-365x176-1.png) no-repeat;
	height: 176px;
	width: 365px;
	position: absolute;
	left: 140px;
	top: 180px;
}
.smallmod-pop-box{
	background: url(../images/pop-245x176-1.png) no-repeat;
	height: 176px;
	width: 245px;
	position: absolute;
	left: 200px;
	top: 180px;

}

.bottom-ad {
	background: url(../images/t30.png);
	height: 109px;
	width: 420px;
	position: absolute;
	left: 110px;
	top: 371px;
}
.bottom-ad img {
	height: 103px;
	width: 414px;
	position: absolute;
	left: 3px;
	top: 3px;
}
.exit{
	height: 530px;
    width: 640px;
    position: absolute;
	left:0px;
}
.exitback{
    background: #0d4764 url(../images/body-page-end5.jpg) no-repeat;
}


.exitsticom {background: #0d4764 url(../images/body-page-tv-auto-end.jpg) no-repeat;}
.mod-tvAutoEnd .pic {
	height: 91px;
	width: 109px;
	left: 176px;
	top: 91px;
}
.mod-tvAutoEnd .txtTitle {
	color:#7cc9e6;
	font-size: 20px;
	left: 302px; top: 94px;
}
.mod-tvAutoEnd .txtNum {
	font-size: 24px;
	left: 302px; top: 132px;
}
.mod-tvAutoEnd .link {}

.pop-next {
	background: url("../images/pop-365x176-1.png") no-repeat;
	height: 176px;
	width: 365px;
	position: absolute;
	left: 140px;
	top: 178px;
}
.pop-next .txtTitle,
.pop-next .txtCont {
	height: 24px;
	text-align: center;
	width: 365px;
	position: absolute;
	left: 0px;
}
.pop-next .txtTitle {
	color: #7cc9e6;
	top: 24px;
}
.pop-next .txtCont {
	font-size: 26px;
	top: 65px;
}
.bottom01 {
	background:url(../images/bottom-bg01.png) repeat;
	left:0;
	position:absolute;
	top:461px;
	height:36px;
    width:640px;
	z-index:3;
}
.bottom02 {
	background:url(../images/bottom-bg02.png) repeat;
	left:0;
	position:absolute;
	top:496px;
	height:34px;
    width:640px;
	z-index:3;
}

.bottom02 .txt {
	font-size:18px;
	line-height:34px;
}

-->
</style>

<style>
.blueFont
{font:"黑体";color:#FFFFFF;font-size:16px; }
.whiteFont
{font:"黑体";color:#FFFFFF;font-size:16px;}
</style>
<%

String progId = request.getParameter("PROGID"); //vod节目id


//progId="1579865";


progId="2065613";


int iProgId = 0;	
String fatherId = request.getParameter("FATHERSERIESID");
String playType = request.getParameter("PLAYTYPE"); //播放类型
playType="1";

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


typeId="10000100000000090000000000033294";

String isChildren = request.getParameter("isChildren");
String type=request.getParameter("ECTYPE");
String poster = request.getParameter("POSTER");
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
//	playUrl = serviceHelpHWCTC.getTriggerPlayUrlHWCTC(iPlayType,iProgId,iPlayBillId,beginTime,endTime,productId,serviceId,contentType);
	
	
//	System.out.println("iPlayBillId="+iPlayBillId+"beginTime="+beginTime+"endTime="+endTime+"productId="+productId+"serviceId="+serviceId+"contentType"+contentType);
	
	//iPlayBillId=0beginTime=0endTime=20000productId=0serviceId=0contentType=10
	playUrl = serviceHelpHWCTC.getTriggerPlayUrlHWCTC(iPlayType,iProgId,-1,beginTime,endTime,"0","0","0");
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
<script>

var KEY_DEL=1131;
var minEPGIsShowFlag=false;
var seekDivIsShowFlag=false;
var quitDivIsShow = false;
var preOrNextProgIsShow = false;
var processDivIsShowFlag = false;

var processLength = 0;
var timesLength = 0;
var totalMoveTimes = 10;
var timePreCell=0;
//每次移动的精度条的像素
var processPreCell=0;
//移动当前次数
var cruntMoveTimes = 0;
//快进快退进度条
//精度条总长度
var speedProcessLength = 445-19;
var speedTimesLength=0;
var speedCruntPlayTime=0;
var dowrSpeedProcessTime;

var seekAreaFlag = 0;
var seekArea0Position = 0;
var seekArea1Position = 0;
var progNamePosition=0;

//输入框时
var bufInputH="";
//输入框分
var bufInputM="";

var currVodIndex="";
var preProgId="";
var nextProgId=""
var preProgNum="";
var nextProgNum="";
var vodName="";
var preProgName="";
var nextProgName=""; 
var allVodJsonObject="";

var totalSitNum="";

var movePreProgIndex=0;
var moveNextProgIndex=0;



//var playUrl="rtsp://220.181.168.185:5541/mp4/2013henanfenghui/zhibo/cctv1.ts";
var playUrl="<%=playUrl%>";

var mp = new MediaPlayer();//播放器对象
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
		case <%=KEY_LEFT%>: return pressKey_left(); 
		case <%=KEY_RIGHT%>: return pressKey_right();			
		case <%=KEY_PAGEDOWN%>:return pressKey_pageDown();		
		case <%=KEY_PAGEUP%>:return pressKey_pageUp();	
		case <%=KEY_PAUSE_PLAY%>:
		case <%=KEY_POS%>:
			pauseOrPlay(); //case 271://定位键
			return 0;
			return false;
		 case <%=KEY_RETURN%>:
			pressKey_quit();  //退出时处理
			return 0;
		  case <%=KEY_STOP%>:
			pauseOrPlay();
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
			return false;
		case <%=KEY_IPTV_EVENT%>:  
			goUtility();
			break;
		case <%=KEY_MUTE%>:setMuteFlag();return false;
		case <%=KEY_INFO%>:showMinEpg();return 0;
		case <%=KEY_OK%>:pressOk();return;
		case KEY_DEL:
		case 280:
        	if(seekDivIsShowFlag==true){delInputTime();}return 0;break;
		case <%=KEY_0%>:showInputTime(0);return false;
	    case <%=KEY_1%>:showInputTime(1);return false;
		case <%=KEY_2%>:showInputTime(2);return false;
		case <%=KEY_3%>:showInputTime(3);return false;
		case <%=KEY_4%>:showInputTime(4);return false;
		case <%=KEY_5%>:showInputTime(5);return false;
		case <%=KEY_6%>:showInputTime(6);return false;
		case <%=KEY_7%>:showInputTime(7);return false;
		case <%=KEY_8%>:showInputTime(8);return false;
		case <%=KEY_9%>:showInputTime(9);return false;
	}
	return true;
}




function pressKey_up()
{
	if(seekDivIsShowFlag==true)
	{
		if(seekAreaFlag==1)
		{
			$("seekArea1_"+seekArea1Position).className="item";
			seekArea0Position=0;
			$("seekArea0_"+seekArea0Position).src="../images/btn-point_focus.png";
			seekAreaFlag=0;
		  
		}
	}
	
}

function pressKey_down()
{
	if(seekDivIsShowFlag==true)
	{
		if(seekAreaFlag==0)
		{
			$("seekArea0_"+seekArea0Position).src="../images/btn-point.png";
			seekArea1Position=0;
			$("seekArea1_"+seekArea1Position).className="item item_focus";
			seekAreaFlag=1;
		}
	}
}

function pressKey_left()
{
	if(seekDivIsShowFlag==true)
	{
		if(seekAreaFlag==0)
		{
			seekArea0Position=0;
			$("seekArea0_"+seekArea0Position).src="../images/btn-point_focus.png";
			drowProcess(-1);
		
		}
		else
		{
			$("seekArea1_"+seekArea1Position).className="item";
			seekArea1Position--;
			if(seekArea1Position<0)
			{
				seekArea1Position=3;
			}
			$("seekArea1_"+seekArea1Position).className="item item_focus";
		}
	}else if(minEPGIsShowFlag==true)
	{
		if(progNamePosition==1)
		{
		    $("preAProgName").focus();	
		    progNamePosition=0;
		}
		else if(movePreProgIndex-1>=0)
		{
			
			movePreProgIndex=movePreProgIndex-2;
		
			moveNextProgIndex=movePreProgIndex+2;
			if(movePreProgIndex<0)
			{
				$("preProgName").innerHTML = "暂无";
			}else
			{
				$("preProgName").innerHTML = allVodJsonObject.vodList[movePreProgIndex].VODNAME;
			}
			
	        $("nextProgName").innerHTML = allVodJsonObject.vodList[moveNextProgIndex].VODNAME;	
			preProgId=allVodJsonObject.vodList[movePreProgIndex].VODID;
			nextProgId=allVodJsonObject.vodList[moveNextProgIndex].VODID;
			
			
		}
		
	}
	else if(quitDivIsShow==true||preOrNextProgIsShow==true)
	{
		//不响应
	}
	else
	{
		fastRewind();
	}

}




function pressKey_right()
{
	if(seekDivIsShowFlag==true)
	{
		if(seekAreaFlag==0)
		{
			seekArea0Position=0;
			$("seekArea0_"+seekArea0Position).src="../images/btn-point_focus.png";
			drowProcess(1);
		
		}
		else
		{
			$("seekArea1_"+seekArea1Position).className="item";
			seekArea1Position++;
			if(seekArea1Position>3)
			{
				seekArea1Position=0;
			}
			$("seekArea1_"+seekArea1Position).className="item item_focus";
		}
	}
	else if(minEPGIsShowFlag==true)
	{
		if(progNamePosition==0)
		{
		   $("nextAProgName").focus();	
		   progNamePosition=1;
		}
		else if(moveNextProgIndex+1<totalSitNum)
		{
			
			moveNextProgIndex=moveNextProgIndex+1;
			movePreProgIndex=moveNextProgIndex-1;
			
			
			alert(">>>>>>>>>>>>>>moveNextProgIndex>>>>>>>>>>>>>>>>>>"+moveNextProgIndex)
			alert(allVodJsonObject.vodList[movePreProgIndex].VODNAME);
			
			alert(">>>>>>>>>>>>>>movePreProgIndex>>>>>>>>>>>>>>>>>>"+movePreProgIndex)
			alert(allVodJsonObject.vodList[movePreProgIndex].VODNAME);
			
			$("preProgName").innerHTML = allVodJsonObject.vodList[movePreProgIndex].VODNAME;
	        $("nextProgName").innerHTML = allVodJsonObject.vodList[moveNextProgIndex].VODNAME;	
			preProgId=allVodJsonObject.vodList[movePreProgIndex].VODID;
			nextProgId=allVodJsonObject.vodList[moveNextProgIndex].VODID;
			
		}
		
		
		
	}
	else if(quitDivIsShow==true||preOrNextProgIsShow==true)
	{
	    //不响应
	}
	else
	{
		fastForward();
	}
}


//快进
function fastForward()
{
	if(minEPGIsShowFlag==true)
	{
		hideMinEpg();
	}
	else if(seekDivIsShowFlag==true)
	{
		hideseekDiv();
	}
	if(speed>=32)
	{
		speed=1;
	}
	speed = speed * 2;
	$("speedIcon").src ="../images/icon-fast.png";
	$("speedText").innerHTML = speed+'X';	
	mp.fastForward(speed);
	if(dowrSpeedProcessTime!=undefined)
	clearTimeout(dowrSpeedProcessTime);
	dorwSpeedProcess();
	if(processDivIsShowFlag==false)
	{
	    showSpeedDiv();
	}
}





//快退
function fastRewind()
{
	if(minEPGIsShowFlag==true)
	{
		hideMinEpg();
	}
	else if(seekDivIsShowFlag==true)
	{
		hideseekDiv();
	}
	if(speed>=32)
	{
		speed=1;
	}
	speed = speed * 2;
	$("speedIcon").src ="../images/icon-rewind.png"
	$("speedText").innerHTML = speed+'X';	
	mp.fastRewind(-speed);
	if(dowrSpeedProcessTime!=undefined)
	clearTimeout(dowrSpeedProcessTime);
	dorwSpeedProcess();
	if(processDivIsShowFlag==false)
	{
	    showSpeedDiv();
	}
}





//画快进快退的进度条
function dorwSpeedProcess()
{
	speedTimesLength = mp.getMediaDuration();
	speedCruntPlayTime = mp.getCurrentPlayTime();
	$("speedBar").style.left=Math.floor((speedCruntPlayTime/speedTimesLength)*speedProcessLength)+"px";
	$("totalTime").innerHTML = convertTime(speedTimesLength);
	$("cruntSpeedPlayTime").innerHTML = convertTime(speedCruntPlayTime);
	dowrSpeedProcessTime = setTimeout(dorwSpeedProcess,5000);

}












//画暂停的精度条
function drowProcess(step)
{
	cruntMoveTimes=cruntMoveTimes+step;
	if(cruntMoveTimes>totalMoveTimes)
	{
		cruntMoveTimes=totalMoveTimes;
	}
	else if(cruntMoveTimes<0)
	{
		cruntMoveTimes=0;
	}
	$("processBor").style.left=Math.floor(processPreCell*(cruntMoveTimes))+"px";
	$("cruntTime").innerHTML = convertTime(Math.floor(timePreCell*(cruntMoveTimes)));

}





function pressOk()
{
	if(seekDivIsShowFlag==false&&processDivIsShowFlag==false&&quitDivIsShow==false&&minEPGIsShowFlag==false)
	{
	    readyMinEpgData();	
	}
	else if(processDivIsShowFlag==true)
	{
		hiddenSpeedDiv();
		resume();
	}
	else if(minEPGIsShowFlag==true)
	{
		if(progNamePosition==0&&preProgId!=-1)
		{
			unload();
			

			window.location.href="play_controlVod.jsp?PROGID="+preProgId+"&PLAYTYPE=1"+"&TYPE_ID="+"<%=typeId%>"+"&backurl="+escape("<%=goBackUrl%>");
		}
		else if(progNamePosition==1&&nextProgId!=-1)
		{
			unload();
			window.location.href="play_controlVod.jsp?PROGID="+nextProgId+"&PLAYTYPE=1"+"&TYPE_ID="+"<%=typeId%>"+"&backurl="+escape("<%=goBackUrl%>");
		}
	}
	else if(seekDivIsShowFlag==true)
	{
		var playTime=0;
		if(seekAreaFlag==0&&seekArea0Position==0)
		{
			playTime = Math.floor(timePreCell*(cruntMoveTimes));
			hideseekDiv();
			playByTime(playTime);
		}
		else if(seekAreaFlag==1&&seekArea1Position==2)
		{
			if(bufInputH.length==0)
			{
			    bufInputH="00";
			}
			
			if(bufInputM.length==0)
			{
				bufInputM="00"
			}
			 var hour = parseInt(bufInputH,10);
	         var mins = parseInt(bufInputM,10);	
		     playTime =  hour*3600 + mins*60;
			if(playTime>timesLength||playTime<0)
			{
				$("inputTimesError").style.display = "block";
				bufInputH="";
				bufInputM="";
				$("seekArea1Text_0").innerHTML="";
			    $("seekArea1Text_1").innerHTML="";
			}
			else
			{
				$("inputTimesError").style.display = "none";
				hideseekDiv();
				playByTime(playTime);
			}
		}
		else if(seekAreaFlag==1&&seekArea1Position==3)
		{
		     //输入框时
			bufInputH="";
			//输入框分
			bufInputM="";
			$("seekArea1Text_0").innerHTML="00";
			$("seekArea1Text_1").innerHTML="00";
		}
	}
}



function pressKey_quit()
{
	if(seekDivIsShowFlag==true)
	{
	    delInputTime();
	}
	else
	{
		if(processDivIsShowFlag==true)
		{
			hiddenSpeedDiv();
		}
		else if(seekDivIsShowFlag==true)
		{
			hideseekDiv();
		}
		
		showQuitDiv();
		pause();
	}
}






function showQuitDiv()
{
	if(quitDivIsShow == true){return;}
    $("quitDiv").style.display = "block";
	$("quit").focus()
	quitDivIsShow = true;
}

function hideQuitDiv()
{
	if(quitDivIsShow == false){return;}
	$("quitDiv").style.display = "none";
	quitDivIsShow = false;
}













function showInputTime(num)
{
	if(seekAreaFlag==1)
	{
		if(seekArea1Position==0)
		{
			if(bufInputH.length>=2)
			{
				$("seekArea1_0").className="item";
				$("seekArea1_1").className="item item_focus";
				seekArea1Position=1;
			}
			else
			{
				bufInputH = bufInputH+num;
			   $("seekArea1Text_0").innerHTML=bufInputH;
			}
		}
		else if(seekArea1Position==1)
		{
			if(bufInputM.length>=2)
			{
				$("seekArea1_1").className="item";
				$("seekArea1_2").className="item item_focus";
				seekArea1Position=2;
			}
			else
			{
				bufInputM = bufInputM+num;
			   $("seekArea1Text_1").innerHTML=bufInputM;
			}
		}
	}
}



function delInputTime()
{
	if(seekAreaFlag==1)
	{
		if(seekArea1Position==0)
		{
			bufInputH = bufInputH.substring(0,bufInputH.length-1)
			$("seekArea1Text_0").innerHTML=bufInputH;
		}
		else if(seekArea1Position==1)
		{
			bufInputM = bufInputM.substring(0,bufInputM.length-1)
			$("seekArea1Text_1").innerHTML=bufInputM;
		}
		else
		{
			resume();
		    hideseekDiv();
		}
	}
	else
	{
		resume();
		hideseekDiv();
	}
}





function volumeUp()
{
	if(seekDivIsShowFlag||processDivIsShowFlag){return true;}
	if(minEPGIsShowFlag){hideMinEpg();}
	var muteFlag =  mp.getMuteFlag();
	if(muteFlag == 1){mp.setMuteFlag(0);}
	volume = mp.getVolume();
	showVolumeTable();
	volume += 5;
	if(volume > 100){volume = 100;}
	//changeVolume(volume);
	mp.setVolume(volume);
	if(bottomTimer!=undefined)
	clearTimeout(bottomTimer);
	bottomTimer=setTimeout(hideVolumeTable, 3000);
}


//减小音量
function volumeDown()
{
	if(seekDivIsShowFlag||processDivIsShowFlag){return true;}
	if(minEPGIsShowFlag){hideMinEpg();}
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){mp.setMuteFlag(0);}
	volume = mp.getVolume();
	showVolumeTable();
	volume -= 5;
	if(volume <0){volume = 0;}
	//changeVolume(volume);
	mp.setVolume(volume);
	if(bottomTimer!=undefined)
	clearTimeout(bottomTimer);
	bottomTimer=setTimeout(hideVolumeTable, 3000);
}


function setMuteFlag()
{
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){
		mp.setMuteFlag(0);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0){
			$("voice").style.display = "none";
			var Timer;
			if(Timer!=undefined)
			Timer = setTimeout(hideMute, 5000);
		}
	}else{
		mp.setMuteFlag(1);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0){
			$("voice").style.display = "block";
			var Timer;
			if(Timer!=undefined)
			Timer = setTimeout(hideMute, 5000);
		}
	}
}




function pauseOrPlay()
{/*
	if(processDivIsShowFlag==true)
	{
		hiddenSpeedDiv();
	}
	else if(minEPGIsShowFlag==true)
	{
		hideMinEpg();
	}
	else if(quitDivIsShow==true)
	{
		hideQuitDiv();
	
	}
	else if(preOrNextProgIsShow==true)
	{
		quitpreOrNext();
	}
	if(seekDivIsShowFlag==false)
	{
		pause();
		readyseekDivData();
		showseekDiv();
	}
	else
	{
		resume();
		hideseekDiv();
	}
*/
  
    if(processDivIsShowFlag==true)
	{
		hiddenSpeedDiv();
		pause();
		showseekDiv();

	}
	else if(quitDivIsShow==true)
	{
		hideQuitDiv();
	}

   else if(minEPGIsShowFlag==true)
   {
	  hideMinEpg();
   }
   else if(seekDivIsShowFlag==false)
	{
		pause();
		readyseekDivData();
		showseekDiv();
	}else
	{
		resume();
		hideseekDiv();	
	}
}




function readyseekDivData()
{
	var mediaTime = mp.getMediaDuration();
	var cruntPlayTime = mp.getCurrentPlayTime();
	//prcess总像素
	processLength = 485-19;
	//影片总长度
	timesLength = mediaTime;
	//每次移动的时间的单元格
	timePreCell=timesLength/totalMoveTimes;
	//每次移动的精度条的像素
	processPreCell=processLength/totalMoveTimes;
	//当前所在的次数
	cruntMoveTimes = Math.ceil(cruntPlayTime/timePreCell);
	
	var endTime = convertTime(mediaTime);
	var cruntTime = convertTime(cruntPlayTime);
	$("processBor").style.left=processPreCell*(cruntMoveTimes)+"px";
	$("endTime").innerHTML = endTime;
	$("cruntTime").innerHTML = cruntTime;
}


function showseekDiv()
{
	$("seekArea0_"+seekArea0Position).src="../images/btn-point_focus.png";
	$("seekDiv").style.display = "block";
    seekDivIsShowFlag=true;
}

function hideseekDiv()
{
	seekAreaFlag = 0;
    seekArea0Position = 0;
	//输入框时
    bufInputH="";
    //输入框分
    bufInputM="";
	$("seekArea1_"+seekArea1Position).className="item";
	$("seekArea1Text_0").innerHTML=bufInputH;
	$("seekArea1Text_1").innerHTML=bufInputM;
	$("seekDiv").style.display = "none";
	seekDivIsShowFlag=false;
}



function showSpeedDiv()
{
	$("prcessDiv").style.display = "block";
    processDivIsShowFlag=true;
}

function hiddenSpeedDiv()
{
	speed=1;
	$("prcessDiv").style.display = "none";
    processDivIsShowFlag=false;
}

function cancel()
{
	resume();
	hideQuitDiv();
}
function quit()
{	
    mp.stop();
    antoQuit();
}
function antoQuit()
{
	window.location.href =unescape("<%=goBackUrl%>");
}



/**
*保存书签并退出
*/
function saveBookMark()
{
	// addBook();
}

//添加书签
function addBook()
{

}


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
	/*
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
	*/
	mp.setNativeUIFlag(1); //0不使UI本地显示 		   1本地显示
    mp.setMuteUIFlag(1);  //0静音图标不显示			    1本地显示  
    mp.setAudioVolumeUIFlag(1);//设置音量调节本地UI的显示标志 0:不允许 1：允许
    mp.setAudioTrackUIFlag(1);
	mp.setProgressBarUIFlag(0);
    mp.setChannelNoUIFlag(0); //0不使频道号本地显示 		   1本地显示
	mp.setAllowTrickmodeFlag(0);//0允许媒体快进，快退，暂停  1本地控制
    mp.setVideoDisplayArea(0, 0, 0, 0);//全屏显示
    mp.setVideoDisplayMode(1); 
    mp.refreshVideoDisplay(); //调整视频显示，需要上面两函数
}

/**
*播放
*/
function play()
{
	/*if(isBookMark){ var type = 1,speed = 1;mp.playByTime(type,beginTime,speed);}
	else{mp.playFromStart();}*/
	mp.playFromStart();
}


/**
*页面加载结束后触发此函数
*/
function start()
{		
	initMediaPlay();		
	play();
	init();
}



function init()
{
	loadData();
}
	
/**
*获取数据
*/
function loadData()
{
	$("getDataIframe").src = "play_controlVodData.jsp?progId="+"<%=iProgId%>"+"&categoryCode="+"<%=typeId%>";
}

function createMinEpg()
{
	setTimeout(readyMinEpgData,1000);
}
function readyMinEpgData()
{

//	var VodFullTime=getVodTime();
//	var inforcurrTime = mp.getCurrentPlayTime();
//	var inforcurrTimeDisplay = convertTime(inforcurrTime);
	$("vodName").innerHTML = vodName;
	$("preProgName").innerHTML = preProgName;
	$("nextProgName").innerHTML = nextProgName;
	
	showMinEpg();
}


function showMinEpg()
{
	
	alert(currVodIndex+">>>>>>>>>>>currVodIndex>>>>>>>>>"+currVodIndex);

	movePreProgIndex=parseInt(currVodIndex)-1;
	moveNextProgIndex=parseInt(currVodIndex)+1;
	
	alert(movePreProgIndex+">>>>>>>>>>movePreProgIndex>>>>>>>>>>"+movePreProgIndex);
	
	alert(moveNextProgIndex+">>>>>>>>>>moveNextProgIndex>>>>>>>>>>"+moveNextProgIndex);
	$("minEpgDiv1").style.display = "block";
	$("minEpgDiv2").style.display = "block";
	$("preAProgName").focus();
	progNamePosition=0;
	
	
	minEPGIsShowFlag=true;
	var hideMinEpgTimer;
	if(hideMinEpgTimer!=undefined)
	clearTimeout(hideMinEpgTimer);
	hideMinEpgTimer=setTimeout(hideMinEpg,5000);
}

function hideMinEpg()
{
	$("preAProgName").focus();
	progNamePosition=0;
	$("minEpgDiv1").style.display = "none";
	$("minEpgDiv2").style.display = "none";
	minEPGIsShowFlag=false;
}

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

function playByTime(playTime)
{
	var type = 1;
	speed = 1;
	var playTime = parseInt(playTime);
	mp.playByTime(type,playTime,speed);
	mp.setVideoDisplayMode(1);
	mp.refreshVideoDisplay();
}



function unload()
{
   var instanceId = mp.getNativePlayerInstanceID();
	mp.stop();
	mp.releaseMediaPlayer(instanceId);
}
/**
*机顶盒事件响应
*/

function goUtility(){    
    	eval("eventJson = " + Utility.getEvent());
		var typeStr = eventJson.type;
    	switch(typeStr){
			case 'EVENT_FIRST_I_FRAME'://b700 V2U
    		case "EVENT_MEDIA_BEGINING"://b700 V2A
    			break;
            case "EVENT_MEDIA_ERROR":
            //	goBack();
            	break;
            case "EVENT_MEDIA_END":
				playNextProg();
                break;
            default :
                return 1;
        }
        return 1;
}



function playNextProg()
{
	if(nextProgId!=-1)
	{
		window.location.href="play_controlVod.jsp?PROGID="+nextProgId+"&PLAYTYPE=1"+"&TYPE_ID="+"<%=typeId%>"+"&backurl="+escape("<%=goBackUrl%>");
	}
	else
	{
		window.location.href=unescape("<%=goBackUrl%>");
	}

}




</script>
</head>
<body bgcolor="transparent" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="background-color: transparent" onLoad="start()" onUnload="unload()">
 
   	<iframe id="getDataIframe"  style="width:0px;height:0px;border:0px;" ></iframe> 
      <%--记录书签-----------%>
    <iframe id="addBookIframe"  style="width:0px;height:0px;border:0px;" ></iframe> 
            
<!--音量键-->
<div id="volumeDiv" class="volume" style="display:none">
    <div style="width:320px;"><div id="volumeLen" class="on" style="width:1px;"></div></div> <!--总宽度为320px;也可以用100%-->
    <div id="volumeCur" style="left:380px; text-align:center; line-height:45px"></div>
</div>
<!--音量键-->              
           
<%--按暂停键后出现的模块begin-------------------------------%>
<div class="bottom-b" id="seekDiv" style="display:none">
	<div class="icon" style="left:0px; top:25px;"><img src="../images/icon-pause.png" alt="暂停" /></div>
	
	<div class="txt txt-time" style="left:18px;top:20px; text-align:right;">00:00:00</div> <!--已播放的时间-->
	<div class="txt txt-time" style="left:572px; top:20px;" id="endTime"></div> <!--总时间-->
	
	<div class="progress-bar3" style="top:3px;">
		<div class="txt txt-time" style="left:200px;" id="cruntTime"></div> <!--快进快退的时间-->
		<div class="bar">
        <!--<div class="btn" style="left:43px;"><img src="../images/btn-point_focus.png" /></div>--> <!--获得焦点时；left最大值：430px-->
			<div class="btn" style="left:0px;" id="processBor"><img id="seekArea0_0" src="../images/btn-point_focus.png" /></div> <!--left最大值：430px-->
		</div>
	</div>
	
	<div class="txt txt-prompt" style="color:#00F;display:none" id="inputTimesError">提示：输入超出设定范围，请重新输入</div>
	
	<div class="form">
		<div class="txt" style="width:130px;">输入定位时间：</div>
		<div class="item" id="seekArea1_0" style="position:absolute; left:125px">
			<div class="txt" id="seekArea1Text_0" style="color:#00F;"></div>
		</div>
		<div class="txt" style="position:absolute;left:179px;">时</div>
		<div class="item" style="position:absolute;left:201px;" id="seekArea1_1">
			<div class="txt" id="seekArea1Text_1" style="color:#00F;"></div>
		</div>    
		<div class="txt" style="position:absolute;left:255px;">分</div>
	</div>
	
	<div class="btn-a">
		<div class="item" id="seekArea1_2">
			<div class="txt">跳转</div>    
		</div>
		<div class="item" style="position:absolute;left:72px;" id="seekArea1_3">
			<div class="txt">重置</div>    
		</div>
	</div>
	
</div>
<%--按暂停键后出现的模块end---------------------------------%>

<div class="bottom-a"  id="prcessDiv" style="display:none">
	<div class="btn btn-fast" style="left:0px">
		<div class="icon"><img id="speedIcon" src="../images/icon-fast.png" alt="快进" /></div>
		<!--<div class="icon"><img src="../images/icon-rewind.png" alt="快退" /></div>-->
		<div class="txt" id="speedText">2X</div>
	</div>
	
	<div class="txt txt-time" style="left:55px;top:28px; text-align:right;">00:00:00</div> <!--已播放的时间-->
	<div class="txt txt-time" style="left:572px; top:28px;" id="totalTime">10:30</div> <!--总时间-->
	
	<div class="progress-bar3">
		<div class="txt txt-time" style="left:43px;" id="cruntSpeedPlayTime">09:15</div> <!--快进快退的时间-->
		<div class="bar">
			<div class="btn" style="left:0px;" id="speedBar"><img src="../images/btn-point_focus.png" /></div> <!--left最大值：430px-->
		</div>
	</div>
	
</div>






                 
                 
                 
                 
                 
<%--音量begin-------------------------%>
<div id="voice" style="position:absolute; left:581px; top:15px; width:61px; height:89px; background:url(../images/mute.png);background-color:transparent; display:none;z-index:3;"></div>
<%--音量end---------------------------%>

<%-----------------------play-page-点播信息键--------------%>
<!--pop up layer

minEpgDiv1 minEpgDiv2 curNewName  curUpNewName curNextNewName
-->



<div class="bottom01" id="minEpgDiv1" style="display:none">
	<div class="txt" id="vodName" style="font-size:17px; left:20px; top:9px; width:480px;">正在播放：20140209新闻联播</div>
	<div class="txt" style="font-size:17px; left:500px; top:9px; text-align:right; width:120px;"></div>
</div>
<div class="bottom02" id="minEpgDiv2" style="display:none">
	<div class="item">
		<div class="link"><a href="#" id="preAProgName"><img src="../images/t.gif" width="320" height="34" /></a></div>
		<div class="icon" style="left:283px; top:5px;"><img src="../images/arrow-left.png" /></div>
		<div class="txt" id="preProgName" style="left:10px; width:270px;"  >国内：我国南极泰山站2月8日竣工 </div>
	</div>
	<div class="item" style="left:320px;">
		<div class="link"><a href="#" id="nextAProgName"><img src="../images/t.gif" width="320" height="34" /></a></div>
		<div class="icon" style="left:10px; top:5px;"><img src="../images/arrow-r.png" /></div>
		<div class="txt" id="nextProgName" style=" left:39px; width:270px;">国内：我国南极泰山站2月8日竣工 </div>
	</div>
</div>





<!--pop up layer the end-->



<%-----------------------play-page the end-----------------%>

<%--退出层begin--------------------%>
<div class="exit" id="sticomquitDiv" style="display:none">
    <div class="mod-pop-box">
        <div class="btn btn-g-211x42-1" style="left:77px; top:14px;">
            <div class="link"><a id="bookmarkSticom" href="javascript:saveBookMark();"><img src="../images/t.gif" /></a></div>
            <div class="txt">加入书签并退出</div>
        </div>
        <div class="btn btn-w-91x42-1" id="proSticomDiv" style="left:16px; top:65px;">
            <div class="link"><a id="proSticom" href="javascript:goPreProg();"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="proSticomText"></div>
        </div>
        <div class="btn btn-ori-131x42-1" style="left:117px; top:65px;">
            <div class="link"><a id="quitSticom" href="javascript:quit();"><img src="../images/t.gif" /></a></div>
            <div class="txt">结束观看</div>
        </div>
        <div class="btn btn-w-91x42-1" id="nextSticomDiv" style="left:258px; top:65px;">
            <div class="link"><a id="nextSticom" href="javascript:goNextProg();"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="nextSticomText"></div>
        </div>
        <div class="btn btn-w-131x42-1" style="left:117px; top:115px;">
            <div class="link"><a id="cancelSticom" href="javascript:cancel();"><img src="../images/t.gif" /></a></div>
            <div class="txt">继续观看</div>
        </div>
    </div>
    
    <!--ad-->
	<!--<div class="bottom-ad"><a href="#"><img src="../images/demopic/pic-414x103.jpg" /></a></div>-->
</div>
<div class="exit" id="quitDiv" style="display:none">
    <div class="smallmod-pop-box">
        <div class="btn btn-g-211x42-1" style="left:17px; top:14px;">
            <div class="link"><a id="bookmark" href="javascript:saveBookMark();"><img src="../images/t.gif" /></a></div>
            <div class="txt">加入书签并退出</div>
        </div>
        <div class="btn btn-ori-131x42-1" style="left:57px; top:65px;">
            <div class="link"><a id="quit" href="javascript:quit();"><img src="../images/t.gif" /></a></div>
            <div class="txt">结束观看</div>
        </div>
        <div class="btn btn-w-131x42-1" style="left:57px; top:115px;">
            <div class="link"><a id="cancel" href="javascript:cancel();"><img src="../images/t.gif" /></a></div>
            <div class="txt">继续观看</div>
        </div>
    </div>
</div>
  
<%--连续剧播放下一集begin-------------------%>
<!--<div class="wrapper" id="preOrNext" style="left:0px;top:0px;display:block">
    <div class="pop-next">
        <div class="txtTitle" id="txtTitle"></div>
        <div class="txtCont" id="programTitile"></div>
        <div class="btn btn-w-91x42-1" style="top:113px; left:86px;">
            <div class="link"><a id="playProgram" href="javascript:gotoProg();"><img src="../images/t.gif" /></a></div>
            <div class="txt">确认</div>
        </div>
        <div class="btn btn-w-91x42-1" style="top:113px; left:188px;">
            <div class="link"><a id="backProgram" href="javascript:quitpreOrNext();"><img src="../images/t.gif" /></a></div>
            <div class="txt">返回</div>
        </div>
    </div>
</div>-->
<%--连续剧播放下一集end---------------------%>

<%--播放结束begin-------------------%>
<div class="exit exitback" id="endDiv" style="left:0px;top:0px;display:none;">

    <!-- S 倒计时文字 -->
    <div class="txt" style="color:#7cc9e6; height: 24px; width:640px; text-align: center; font-size:18px; top:266px;">5秒后自动返回</div>
    <!-- E 倒计时文字 -->

    <!-- S 广告部分 -->
    <!--<div class="mod-as-420x110-1" style="left: 110px; top: 370px;"><div class="pic"><a href="#"><img src="../images/demopic/pic-414x103.jpg" alt="广告位" /></a></div></div>-->
    <!-- E 广告部分 -->

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

  <%--获取数据-----------%>




 
</body>
</html>
