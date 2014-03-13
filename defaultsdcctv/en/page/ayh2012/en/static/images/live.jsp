<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="../common/golbal.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视奥运 标清EPG 2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="<%=static_url%>/css/style.css" />
<link type="text/css" rel="stylesheet" href="<%=static_url%>/css/content.css" />
<script type="text/javascript" src="<%=static_url%>/js/common.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/commonevent.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/ajax_common.js"></script>
<style type="text/css">
<!--
	body{  background: transparent url(<%=static_url%>/images/bg-live.gif) no-repeat;}
-->
</style>
</head>
<body onload="onPageLoad();">
<%@ include file="../datasource/datasource.jsp"%>
<%@ include file="../datasource/property.jsp"%> 
<% 
DataSource dataSource=new DataSource(request); 
int pageIndex=dataSource.huaWeiUtil.getInt(request.getParameter("pageIndex"),1);
int pageSize=dataSource.huaWeiUtil.getInt(request.getParameter("pageSize"),8);
EpgResult epgResult=dataSource.getChannels(pageIndex,pageSize,biaoqingzhibocode);
    
List channels=new ArrayList();
int pageCount=0;

if(epgResult!=null&&epgResult.getResultcode()==0&&epgResult.getDatas()!=null)
{
   channels=(List)epgResult.getDatas();
   pageCount=epgResult.getPageCount();
}

%>

<div class="wrapper">
<%String currentPageId = "_1001"; %>
<%@ include file="../common/head.jsp" %>
<!--分类-->
<div class="live-sort">
	<div class="item"> <!--当前选中为 class="item item_select"-->
		<div class="icon"><img src="<%=static_url%>/images/icon-up-gray.png" /></div>
	</div>
	<% if(channels.size()>0) {
		TblCmsChannel channel=null;
		for(int i=0;i<channels.size();i++){ 
		 channel=(TblCmsChannel)channels.get(i);%>
			<div class="item" style="top:<%=39+(39*i) %>px;">
		      <div class="link onboder"><a id="chan_<%=i%>" href="#;" onclick="playChannel(<%=i %>)"><img src="<%=static_url%>/images/t.gif" /></a></div>
              <div class="txt" id="channel_<%=i%>"><%=channel.getDname() %></div>
	        </div>
		<%}
	} %>
	<div class="item" style="top:351px;">
		<div class="icon"><img src="<%=static_url%>/images/icon-down.png" /></div>
	</div>
</div>	
<!--the end-->


<!--播放区-->
<div class="live-video">
	<div class="item">	
		<div class="link"><a href="#;" onclick="fullplayChannel()"><img src="<%=static_url%>/images/t.gif" /></a></div>
        <div class="pic"><iframe name="playscreen" id="playscreen" src="" frameborder="0" width="440" height="331" allowtransparency="true" style="background:transparent" ></iframe></div>
    </div>
	<div class="full-screen">
		<div class="link"><a href="#;" onclick="fullplayChannel()"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">全屏模式观看</div>
		<div class="icon"><img src="<%=static_url%>/images/icon-full-screen.png" /></div>
	</div>
</div>
<!--the end-->

		
</div>
<script type="text/javascript">
var pageCount=<%=pageCount%>;
var pageIndex=1;
var pageSize=8;
var jsonObj;
var channelList;
var channelIdList = new Array();
var ajaxflag = false;
<%
if(channels.size()>0)
{
  TblCmsChannel chan=null;
	int len = channels.size();
	for(int i=0;i<len;i++){ 
		chan=(TblCmsChannel)channels.get(i);
		%>
		channelIdList[<%=i%>]="<%=chan.getDchannelnumber()%>";
		<%
	}
}
%>
var $$ = {};
function $(id){
	if(!$$[id]){
	   $$[id] = document.getElementById(id);
	}
	return $$[id];
}
function onPageLoad(){
     keyBinds();
     <% if(channels.size()>0) {
    		TblCmsChannel channel=(TblCmsChannel)channels.get(0); %>
    		playChannel('<%=channel.getDchannelnumber() %>');
     <%} %> 
}

var playChannelId=0;
function playChannel(num){
	if(ajaxflag){playChannelId = channelList[num].dchannelnumber; }
	else{playChannelId = channelIdList[num];}
	playscreen.src="<%=static_en%>/player/frame-index-vedio.jsp?userchannelid="+playChannelId+"&_height=360&_width=470&_left=140&_top=100";
}
function fullplayChannel(){
	window.location.href="<%=static_en%>/player/liveplay.jsp?userchannelid="+playChannelId;
}


var ajaxurl="";
function pageAction(action ){ 
   ajaxflag = true ;
   if(action==1){ pageIndex=pageIndex+1; }else{ pageIndex=pageIndex-1; } 
   if((pageIndex>0)&&(pageIndex<=pageCount)){
        ajaxurl="<%=static_en%>/ajaxdata/channel_list_data.jsp?pageIndex="+pageIndex +"&pageSize="+pageSize;
        getAJAXData(ajaxurl,myCallBack);
   }else{
      if(action==1){ pageIndex=pageCount; }else{ pageIndex=1; } 
   }
   if(1==pageIndex){ajaxflag=false;}
}

function myCallBack(respText)
{
	 jsonObj = eval('('+respText+')');
	 channelList = jsonObj.jsonchannellist;
	 var len=channelList.length;
	 for(var i=0;i<len;i++)
	 {
	  	$("channel_"+i).innerText = channelList[i].dname;
	 }
	 for(var i=len;i<pageSize;i++)
	 {
	 	$("channel_"+i).innerText = "";
	 }
	 $("chan_0").focus();
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
	 var url="index.jsp";
	 window.location.href=url ;
	}
</script>
	
</body>
</html>