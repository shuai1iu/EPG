<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page language="java" import="java.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="com.huawei.iptvmw.epg.facade.metadata.CommonImpl" %>
<%@ page import="com.huawei.iptvmw.epg.util.xml.DateUtilities" %>
<%@ include file="keyboard/keydefine.jsp" %>
<%@ include file="config/config_playControl.jsp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
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
String strChannelId = request.getParameter("CHANNELID");
String strControlFlag = request.getParameter("ControlFlag");
String strIsshow=request.getParameter("ishow");
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
if(strIsshow==null){
	strIsshow="0";
	
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
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <style type="text/css">
	body {font-family:"Microsoft YaHei"; font-size:22px; color:#fff; }
	.page {
	  left:280px; 
	  position:absolute; 
	  top:428px;
    }
	.live-item {
		background:url(../images/live-pop-bg.png) no-repeat;
		height:402px;
		left:3px; 
		position:absolute; 
		top:1px;
		width:240px;
	}
	.live-item .con {
		left:23px; 
		position:absolute; 
		top:35px;
		width:189px;
	}
	.live-item .con2 {
		font-size:20px;
		line-height:39px;
		left:30px; 
		position:absolute; 
		top:35px;
		width:189px;
	}
	.live-item .item {
		height:39px;
		line-height:39px;
		left:0; 
		position:absolute; 
		top:0;
		width:189px;
	}
	.live-item .item div {
		left:12px; 
		position:absolute; 
		top:0;
	}
	.live-item div.on {
		background:url(../images/list3-bgon.png) no-repeat;
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
<body bgcolor="transparent" onLoad="init();">

<div id="channelListDIV"  class="live-item" style="display:none;">
     <div id="chan_info" class="con"></div>
</div>
<div id="filmInfoDB">
  <iframe name="channelfilmInfo" id="channelfilmInfo" src="" scroll="no" height="0px" width="0px"></iframe>
</div>
	
<jsp:include page="volumeControl.jsp"></jsp:include>
<jsp:include page="showChanInfo.jsp"></jsp:include>
<jsp:include page="normaltrickmode.jsp"></jsp:include>
</body>
<script type="text/javascript" src="../js/registerGlobalKey1.js"></script>	
<script type="text/javascript">

var rows = <%=ROWS%>;//行数
var cols = <%=COLS%>;//列数

var currChannelNum = <%=strChannelNum%>;//当前直播号
var currChannelId=<%=strChannelId%>;//当前频道ID
var currControlFlag=<%=strControlFlag%>;
var ishow=<%=strIsshow%>;
var currChannelIndex = -1;//当前索引
var chanListFocus = 0;//直播列表的当前索引
var totalChannel = -1;//直播总个数
var totalListPages = 0;//直播列表总页
var currListPage = 0;//直播列表当前

var channelIds = new Array();//直播id号
var channelNames = new Array();	//直播名称
var channelNums = new Array();//直播号，对比是否存在直播的参考
var channelNumsShow = new Array();//用来显示的直播号数组
var channelCode = new Array();//直播的MediaCode
var controlflag = 1;//0:正常频道y页面 1：受控频道页面
var channelListisShow=false;//直播OSD列表是否显示


//直播列表页面初始化 
function init_page()
{
	mediaMg.currChannelNum=currChannelNum;
	mediaMg.currChannelId=currChannelId;
	//mediaMg.currControlFlag=currControlFlag;
	mediaMg.channelIds=channelIds;
	mediaMg.channelNames=channelNames;
	mediaMg.channelNums=channelNums;
	mediaMg.channelNumsShow=channelNumsShow;
	mediaMg.channelCode=channelCode;
	mediaMg.currChannelIndex=currChannelIndex;
	mediaMg.chanListFocus=chanListFocus;
	mediaMg.totalChannel=totalChannel;
	mediaMg.totalListPages=totalListPages;
	mediaMg.currListPage=currListPage;
	//showInfo();
	//clearFilmInfo();
	create_chanTable();
	setFocus(chanListFocus);
	if(ishow==1)
	{
	    showChannelListDiv();
		channelListisShow=true;
    }else{
		hiddenChannelList();
	}
    
}

//释放焦点选择
function freeFocus(curr_focus)
{
	var focusAt = curr_focus%rows;
	
	if($("chan_"+focusAt) != undefined)
		$("chan_"+focusAt).blur();
}	
//获得焦点选择
function setFocus(curr_focus)
{
	var focusAt = curr_focus%rows;
	$("chan_"+focusAt).focus();
}	

//OSD翻页载的时候
//第二次加载的时候
function updateList()
{
	var tmpPages=currListPage * rows,index=0;
	for(var j = 0; j<rows; j++){
		index = tmpPages + j;
		if(index <= channelNames.length-1 && index <= channelNumsShow.length-1)
			$("osd_"+j).innerHTML=channelNumsShow[index]+"&nbsp;"+channelNames[index];
	        else 
		    $("osd_"+j).innerHTML="&nbsp;"; 	
	}
	$("osdpage").innerHTML=(currListPage+1)+"/"+totalListPages;
}
	

//直播OSD列表
function create_chanTable()
{		
	var chaninfo = "",tmpPages=currListPage * rows,index=0,top=0;
	for(var j = 0; j<rows; j++){
		index = tmpPages + j; top=36*j;
		if(typeof(channelNumsShow[index]) != "undefined"){
			chaninfo += "<div class='item' style='position:absolute;top:"+top+"px'><div class='link'><a id='chan_"+j+"' href='#'><img src='../images/t.gif'/></a></div><div id='osd_"+j+"' class='txt'>"+channelNumsShow[index]+"&nbsp;"+channelNames[index]+"</div></div>";
		}else{
			chaninfo += "<div class='item' style='position:absolute;top:"+top+"px'><div class='link'><a id='chan_"+j+"' href='#'><img src='../images/t.gif'/></a></div><div id='osd_"+j+"' class='txt'>&nbsp;</div></div>"; 
		}
	}
	chaninfo += "<div class='page' id='osdpage' style='top:300px; left:85px;'>"+(currListPage+1)+"/"+totalListPages+"</div>"; 
	$("chan_info").innerHTML = chaninfo;
}

//从子页面加载数据
function loadData()
{
	channelfilmInfo.location.href = "play_ControlChannelListTv.jsp?CHANNELID="+currChannelId+"&CHANNELNUM="+currChannelNum+"&COMEFROMFLAG="+comeType;
}	
//下翻页
function pageDown()
{
	//直播列表不显示，按翻页键没用
	if(true != channelListisShow){  
	  mediaMg.gotoEnd();
	  return;
	}
	else{
		if(currListPage > totalListPages - 1 || totalListPages == 1){return;}
		freeFocus(chanListFocus);
		if(currListPage == totalListPages - 1) {currListPage = 0;}    //如果是最后一页 则下翻到第一页
		else{currListPage++;}
		mediaMg.currListPage=currListPage;
		updateList();
		chanListFocus = currListPage*rows;
		mediaMg.chanListFocus=chanListFocus;
		setFocus(chanListFocus);
	}
}	

 //上翻页
function pageUp()
{
	
	
	//直播列表不显示，按翻页键没用
	if(true != channelListisShow){
		mediaMg.player.pause();
		mediaMg.player.gotoStart();
		return;	
    }
	else{
		if(currListPage < 0 || totalListPages == 1){return;}
		freeFocus(chanListFocus);		
		if(currListPage == 0) {currListPage = totalListPages - 1;}     //如果是第一页 则上翻到最后一页             
		else{currListPage--;}
		mediaMg.currListPage=currListPage;
		updateList();
		if(currListPage==(totalListPages - 1))
		{
			chanListFocus = totalChannel;
		}
		else{
			chanListFocus = currListPage*rows;
	    }
		mediaMg.chanListFocus=chanListFocus;
		setFocus(chanListFocus);		
	}
}

//按键下移动
function arrowDown(){
	
	 if(channelListisShow==false){
		 decChannel();
		 return;
     }
	if(chanListFocus%rows == (rows-1)|| chanListFocus == totalChannel){	
	    pageDown();
		return;
	}
	if(chanListFocus<0) chanListFocus=0;
	
	freeFocus(chanListFocus);
	chanListFocus++;
	mediaMg.chanListFocus=chanListFocus;
	setFocus(chanListFocus);
}

//按键上移动
function arrowUp(){
	if(channelListisShow==false){
		 addChannel();
		 return;
    }
	if(chanListFocus%(rows) == 0){
		 pageUp(); 
         return;
	}
	freeFocus(chanListFocus);
	chanListFocus--;
	mediaMg.chanListFocus=chanListFocus;
	setFocus(chanListFocus);
}

function init(){
	initMediaMg();
	
	if(parent.isJoinChannle){
	  mediaMg.initChannelMedia();
      mediaMg.playChan(currChannelNum);
    }
	
	if(containFun(markArray,currChannelNum))
	{  
	    
         mediaMg.currControlFlag=1;
	}
	else
	{
		  
		 mediaMg.currControlFlag=0;
    }
    loadData();//加载直播数据
}

//直播列表层显示
function showChannelListDiv()
{	
    if(channelListisShow==true){return;}
	channelListisShow=true;
	$("channelListDIV").style.display = "block";
	setFocus(chanListFocus); //hwwebkit
	channelListIsShowTimer = setTimeout(hiddenChannelList,30000);
}	

//隐藏直播OSD列表
function hiddenChannelList()
{	
	clearTimeout(channelListIsShowTimer);
	channelListIsShowTimer="";
	channelListisShow = false;
	$("channelListDIV").style.display = "none";
}

function pressOK(){
	if(channelListisShow==false)
	{
    	showChannelListDiv();
		channelListisShow=true;
	}
	else
	{  
	    channelListisShow=false;
	    if(chanListFocus<=0) chanListFocus=0;
		currChannelNum=channelNums[chanListFocus];
		currChannelIndex=chanListFocus;
		currChannelId=channelIds[chanListFocus];
	    if(containFun(markArray,currChannelNum))
		{
            currControlFlag=1;
	    }else{
			currControlFlag=0;
		}
		mediaMg.currChannelNum=currChannelNum;
		mediaMg.currChannelIndex=currChannelIndex;
		mediaMg.currChannelId=currChannelId;
		mediaMg.currControlFlag=currControlFlag;
		
		$("channelListDIV").style.display = "none";
		mediaMg.player.joinChannel(currChannelNum);
		//$("filmInfo").style.display = "block";
		//showInfo();
	    //clearFilmInfo();
	}
}

function pauseOrPlay(){
  
  window.location.href="pause.jsp?ControlFlag=" +mediaMg.currControlFlag + "&CHANNELNUM=" + mediaMg.currChannelNum+"&CHANNELID="+ mediaMg.currChannelId +"&COMEFROMFLAG=<%=comeType%>";
}

function pressReturn(){
   mediaMg.player.leaveChannel();
   var browserAgent = navigator.userAgent;
   if (browserAgent.indexOf("WebKit") == -1) 
   { 
      	mediaMg.player.stop();
   }
   parent.goBack();	
}

//快退
function fastRewind(){
     window.location.href="trickmode.jsp?trickMode=rewind&ControlFlag=" +mediaMg.currControlFlag + "&CHANNELNUM=" + mediaMg.currChannelNum+"&CHANNELID="+ mediaMg.currChannelId +"&COMEFROMFLAG=<%=comeType%>";
}

//快进
function fastForward(){
	if(mediaMg.currControlFlag==1)
	{
       showTrickModeDiv();
	}
	else
	{
		window.location.href="trickmode.jsp?trickMode=forward&ControlFlag=" +mediaMg.currControlFlag + "&CHANNELNUM=" + mediaMg.currChannelNum+"&CHANNELID="+ mediaMg.currChannelId +"&COMEFROMFLAG=<%=comeType%>";
   }
}

document.onkeypress = parent.keyevent;
function keypress(keyval)
{
	//$("channelNum").innerHTML = keyval;
	switch(keyval)
	{
		
		case <%=KEY_TRACK%>:changeAudio();return 0;
		case <%=KEY_INFO%>:if(!isShowSeekDiv) createFilmInfo();return 0;
		case <%=KEY_0%>:
		    inputNum(0);
			break;
		case <%=KEY_1%>:
			inputNum(1);
			break;
		case <%=KEY_2%>:
		    inputNum(2);
			break;
		case <%=KEY_3%>:
			inputNum(3);
			break;
		case <%=KEY_4%>:
			inputNum(4);
			break;
		case <%=KEY_5%>:
			inputNum(5);
			break;
		case <%=KEY_6%>:
			inputNum(6);
			break;
		case <%=KEY_7%>:
		    inputNum(7);
			break;
		case <%=KEY_8%>:
			inputNum(8);
			break;
		case <%=KEY_9%>:
		    inputNum(9);
			break;
		case <%=KEY_RIGHT%>:volumeUp();return false;		
		case <%=KEY_LEFT%>:volumeDown();return false;
		case <%=KEY_CHANNEL_UP%>: addChannel();break;	//加直播
		case <%=KEY_CHANNEL_DOWN%>: decChannel();break;//减直播
		case <%=KEY_DOWN%>:arrowDown();break;
		case <%=KEY_UP%>:arrowUp();break;
		case <%=KEY_PAGEDOWN%>:pageDown();return false;
		case <%=KEY_PAGEUP%>:pageUp();return false;
		case <%=KEY_VOL_UP%>:volumeUp();return false; 
		case <%=KEY_VOL_DOWN%>:volumeDown();return false;
		case <%=KEY_MUTE%>:setMuteFlag();return false;
		case <%=KEY_STOP%>:pressReturn();break;
		case <%=KEY_RETURN%>:pressReturn();break;
		case <%=KEY_GO_BEGINNING%>:break;	
		case <%=KEY_OK%>:pressOK();break;
		case <%=KEY_IPTV_EVENT%>:goUtility();break;
		case <%=KEY_BLUE%>:mediaMg.player.leaveChannel();mediaMg.player.stop();parent.window.location.href="space_collect.jsp";return 0;
		case <%=KEY_PAUSE_PLAY%>:
		case <%=KEY_POS%>: pauseOrPlay();return false;
		case <%=KEY_FAST_FORWARD%>: fastForward();return false;
		case <%=KEY_FAST_REWIND%>:fastRewind();return false; 			
	    case 277:
	    case 1109://点播
			mediaMg.player.stop();parent.window.location.href="vod.jsp?returnurl="; return false;break;
	    case 276:
	    case 1110://回放
			mediaMg.player.stop();parent.window.location.href="playback.jsp?returnurl=";return false;break;
		case 275:
		case 1108://直播
		    mediaMg.player.stop(); parent.window.location.href="live.jsp?returnurl=";return false;break;
	    case 1105://搜索
			mediaMg.player.stop();parent.window.location.href="search.jsp";return 0;
		default:
			break;
	}
	return true;
}
</script>
</html>
