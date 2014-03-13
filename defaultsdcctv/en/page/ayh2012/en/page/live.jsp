<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="../common/golbal.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="<%=static_url%>/css/style.css" />
<link type="text/css" rel="stylesheet" href="<%=static_url%>/css/content.css" />
<script type="text/javascript" src="<%=static_url%>/js/common.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/commonevent.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/ajax_common.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/cookie.js"></script>
</head>
<body onload="onPageLoad();" background="#" bgcolor="transparent">
<div style="position:absolute;z-index:-1;">
	<img style="width:640px;height:530px;" src="<%=static_url%>/images/bg-live.gif" />
</div>
<%@ include file="../datasource/datasource.jsp"%>
<%@ include file="../datasource/property.jsp"%> 
<% 
String currentPageId = "_1001"; 
DataSource dataSource=new DataSource(request); 
int pos=dataSource.huaWeiUtil.getInt(request.getParameter("pos"),0);
int area=dataSource.huaWeiUtil.getInt(request.getParameter("area"),0);  
int pageIndex=dataSource.huaWeiUtil.getInt(request.getParameter("pageIndex"),1);
int pageSize=dataSource.huaWeiUtil.getInt(request.getParameter("pageSize"),8);
int playChannelId=dataSource.huaWeiUtil.getInt(request.getParameter("channelId"),15);
int pageCount = 0;

/*JSP页面加载数据时启用
PkitEpgResult epgResult=dataSource.getChannels(pageIndex,pageSize,biaoqingzhibocode);   
List channels=new ArrayList();
if(epgResult!=null&&epgResult.getResultcode()==0&&epgResult.getDatas()!=null)
{
   channels=(List)epgResult.getDatas();
   pageCount=epgResult.getPageCount();
}*/
%>

<div class="wrapper">
<%@ include file="../common/head.jsp" %>
<!--分类-->
<div class="live-sort">
	<!--<div class="item" style="top:0px">
		<div class="icon"><img src="<%=static_url%>/images/icon-up-gray.png" /></div>
	</div> --> 
    <div class="item" id="item_0" style="top:0px;">
		<div class="link"><a id="chan_a_0" href="#" onclick="playChannel(15)" >
        <img src="<%=static_url%>/images/t.gif" /></a></div>
	</div>
    <div class="item" style="top:0px;">
        <div class="txt" id="channel_0">CCTV-5</div>
	</div>    
	<div class="item" id="item_1" style="top:39px;">
		<div class="link"><a id="chan_a_1" href="#" onclick="playChannel(11)" >
        <img src="<%=static_url%>/images/t.gif" /></a></div>
	</div>
    <div class="item" style="top:39px;">
        <div class="txt" id="channel_1">CCTV-1</div>
	</div> 
	<div class="item" id="item_2" style="top:79px;">
		<div class="link"><a id="chan_a_2" href="#" onclick="playChannel(12)" >
        <img src="<%=static_url%>/images/t.gif" /></a></div>
	</div> 
    <div class="item" style="top:79px;">
        <div class="txt" id="channel_2">CCTV-2</div>
	</div> 
	<div class="item" id="item_3" style="top:117px;">
		<div class="link"><a id="chan_a_3" href="#" onclick="playChannel(17)" >
        <img src="<%=static_url%>/images/t.gif" /></a></div>
	</div> 
    <div class="item" style="top:117px;">
        <div class="txt" id="channel_3">CCTV-7</div>
	</div> 
</div>	
<!--the end-->


<!--播放区-->
<div class="live-video">
	<div class="item">	
		<div class="link"><a onclick="fullplayChannel()" id="channel_a_0"><img src="<%=static_url%>/images/t.gif" /></a></div>
        <div class="pic"><iframe id="playPage" name="playPage" frameborder="0" height="1px" width="1px"></iframe></div>
    </div>
	<div class="full-screen">
		
		<div class="txt">点击确认键进入全屏观看</div>
	
	</div>
</div>
<!--the end-->

		
</div>
<script type="text/javascript">
var loadIframeTimer = "";
var pageCount=<%=pageCount%>;
var pageIndex=<%=pageIndex%>;
var pageSize=8;
var area = <%=area %>; //0:导航 1： 2右
var pos = <%=pos %> ;
var backUrl = "live.jsp";
var ajaxurl = "";
var jsonObj;
var channelList;
var playChannelId = <%=playChannelId %>;
var $$ = {};
function $(id){
	if(!$$[id]){
	   $$[id] = document.getElementById(id);
	}
	return $$[id];
}
function onPageLoad(){
     keyBinds();
    // init();
	 initpos();
	 loadIframeTimer = setTimeout(loadIframe,200);
}
function initpos()
{
	if(2==area){$("channel_a_"+pos).focus();}
	else{$("chan_a_"+pos).focus();}
}
function init(){
	ajaxurl = "<%=static_en%>/ajaxdata/channel_list_data.jsp?pageIndex="+pageIndex+"&pageSize="+pageSize;
 	getAJAXData(ajaxurl,myCallBack);
}

function playChannel(num){
	playChannelId = num;//channelList[num].dchannelnumber;
	loadIframe();
}
function loadIframe(){
	playPage.location.href = "<%=static_en%>/player/PlayTrailerInVas.jsp?_channelid="+playChannelId+"&_height=360&_width=470&_left=140&_top=100";
}
function fullplayChannel(){
	var channelPlayUrl = "<%=static_en%>/player/play_ControlChannel.jsp?CHANNELNUM="+playChannelId;
	//var channelPlayUrl = "<%=static_en%>/player/channelplay.jsp?CHANNELNUM="+playChannelId;
	backUrl = "<%=static_en%>/page/live.jsp?area=2&pos=0&pageIndex="+pageIndex+"&channelId="+playChannelId;
	addURLtoCookie("channelPlay",backUrl);
	location.href = channelPlayUrl;
}

function pageAction(action){ 
   if(action==1){ pageIndex = pageIndex+1; }else{ pageIndex = pageIndex-1; } 
   if((pageIndex>0)&&(pageIndex<=pageCount)){
     area = 1;  pos = 0; init();
   }else{
      if(action==1){ pageIndex = pageCount; }else{ pageIndex = 1; } 
   }
}

function myCallBack(respText)
{
	 jsonObj = eval('('+respText+')');
	 channelList = jsonObj.jsonchannellist;
	 pageCount = jsonObj.jsonpagecount;
	 var len = channelList.length;
	 for(var i=0;i<len;i++){       
	  	$("channel_"+i).innerText = ((channelList[i].dname).length)>6?(channelList[i].dname).substr(0,6):channelList[i].dname;
	 	$("item_"+i).style.display = "block";
	 }
	 for(var i=len;i<pageSize;i++){
	 	$("item_"+i).style.display = "none";
	 }
	 initpos();
}

BaseProcess.prototype.KEY_PAGEUP_EVENT=function(){
	   pageAction(-1 );
	}
BaseProcess.prototype.KEY_PAGEDOWN_EVENT=function(){
	   pageAction( 1 );
	}
BaseProcess.prototype.KEY_BACK_EVENT=function(){
	   goBack();
	}

function goBack(){
	 if(loadIframeTimer){clearTimeout(loadIframeTimer);}
	 var url="index.jsp";
	 window.location.href=url ;
}
/*
function showFullName(num){
	 $("channel_"+num).innerHTML = ((channelList[num].dname).length)>6?("<marquee>"+channelList[num].dname+"</marquee>"):(channelList[num].dname);
}
function showCutName(num){
	 $("channel_"+num).innerHTML = ((channelList[num].dname).length)>6?(channelList[num].dname).substr(0,6):channelList[num].dname;
}*/
</script>
	
</body>
</html>
