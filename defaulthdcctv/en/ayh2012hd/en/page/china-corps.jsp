<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><%@ include file="../common/golbal.jsp" %> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>深圳奥运专题高清3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="<%=static_url%>/css/style.css" />
<script type="text/javascript">
if(typeof(iPanel)!= 'undefined'){iPanel.focusWidth = "8"; iPanel.defaultFocusColor = "#2A5BB8";}
</script>
<script type="text/javascript" src="<%=static_url%>/js/common.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/cookie.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/ajax_common.js"></script>
<style type="text/css">
<!--
body{ background:transparent url(<%=static_url%>/images/bg-gold-medal.gif) no-repeat;}
-->
</style>
</head>
<%@ include file="../datasource/datasource.jsp"%>
<%@ include file="../datasource/property.jsp"%>
<% 
   DataSource dataSource=new DataSource(request); 
   int pos = dataSource.huaWeiUtil.getInt(request.getParameter("pos"),0);
   int area = dataSource.huaWeiUtil.getInt(request.getParameter("area"),1);
   int pageIndex = dataSource.huaWeiUtil.getInt(request.getParameter("pageIndex"),1);
   int pageSize = dataSource.huaWeiUtil.getInt(request.getParameter("pageSize"),9);
   int cruntDBListFocus = dataSource.huaWeiUtil.getInt(request.getParameter("cruntDBListFocus"),0);
   int flage = dataSource.huaWeiUtil.getInt(request.getParameter("flage"),0);
   int cruntdblistFocusPageIndex = dataSource.huaWeiUtil.getInt(request.getParameter("cruntdblistFocusPageIndex"),pageIndex);
   int pressListOKFlage= dataSource.huaWeiUtil.getInt(request.getParameter("pressListOKFlage"),0);
   String dbLisVodId=dataSource.huaWeiUtil.getString(request.getParameter("dbLisVodId"));
   String vodDiscription=dataSource.huaWeiUtil.getString(request.getParameter("vodDiscription"));
   String fanyeQianIDList = dataSource.huaWeiUtil.getString(request.getParameter("FanyeQianIDList"));
   String postertype = "5";
   int pageCount=0;
   String categoryId = zhongguojuntuan;
%>
<body onload="onPageLoad();">
<!--head-->
<% String currentPageId = "_1003"; %>
<%@ include file="../common/head.jsp" %>
<!--the end-->

<!--sub-->
<div class="sub">  <!--item-focus为焦点；select为当前选中;若有item-focus为焦点则去掉<div class="link"><a href="#"><img src="<%=static_url%>/images/t.gif" /></a></div>--> 
	<div class="item">
		<div class="link"><a href="china.jsp" ><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">冠军中国</div>
	</div>
	<div class="item item-focus" style="left:151px;">
		<div class="link"><a href="#" ><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">中国军团</div>
	</div>
	<div class="item" style="left:301px;">
		<div class="link"><a href="china-daily-star.jsp" ><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">每日一星</div>
	</div>
</div>	
<!--the end-->



<!--list-->
<div class="leftcol03 list">  <!--当前选中则显示<div class="icon02"></div>-->
	<div class="item bg01">
		<div class="link"><a href="#" id="vod_a_0" onclick="gotopaly(0)" onfocus="showFullName(0)" onblur="showCutName(0)">
        <img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt" id="vod_0" style="overflow:hidden"></div>
        <div class="icon02" id="flage_0" style="display:none"></div>
	</div>
	<div class="item bg02" style="top:49px;">
		<div class="link"><a href="#" id="vod_a_1" onclick="gotopaly(1)" onfocus="showFullName(1)" onblur="showCutName(1)">
        <img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt" id="vod_1" style="overflow:hidden"></div>
        <div class="icon02" id="flage_1" style="display:none"></div>
	</div>
	<div class="item bg01" style="top:98px;">
		<div class="link"><a href="#" id="vod_a_2" onclick="gotopaly(2)" onfocus="showFullName(2)" onblur="showCutName(2)">
        <img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt" id="vod_2" style="overflow:hidden"></div>
        <div class="icon02" id="flage_2" style="display:none"></div>
	</div>
	<div class="item bg02" style="top:147px;">
		<div class="link"><a href="#" id="vod_a_3" onclick="gotopaly(3)" onfocus="showFullName(3)" onblur="showCutName(3)">
        <img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt" id="vod_3" style="overflow:hidden"></div>
        <div class="icon02" id="flage_3" style="display:none"></div>
	</div>
	<div class="item bg01" style="top:196px;">
		<div class="link"><a href="#" id="vod_a_4" onclick="gotopaly(4)" onfocus="showFullName(4)" onblur="showCutName(4)">
        <img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt" id="vod_4" style="overflow:hidden"></div>
        <div class="icon02" id="flage_4" style="display:none"></div>
	</div>
	<div class="item bg02" style="top:245px;">
		<div class="link"><a href="#" id="vod_a_5" onclick="gotopaly(5)" onfocus="showFullName(5)" onblur="showCutName(5)">
        <img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt" id="vod_5" style="overflow:hidden"></div>
        <div class="icon02" id="flage_5" style="display:none"></div>
	</div>
	<div class="item bg01" style="top:294px;">
		<div class="link"><a href="#" id="vod_a_6" onclick="gotopaly(6)" onfocus="showFullName(6)" onblur="showCutName(6)">
        <img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt" id="vod_6" style="overflow:hidden"></div>
        <div class="icon02" id="flage_6" style="display:none"></div>
	</div>
	<div class="item bg02" style="top:343px;">
		<div class="link"><a href="#" id="vod_a_7" onclick="gotopaly(7)" onfocus="showFullName(7)" onblur="showCutName(7)">
        <img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt" id="vod_7" style="overflow:hidden"></div>
        <div class="icon02" id="flage_7" style="display:none"></div>
        
	</div>
	<div class="item bg01" style="top:392px;">
		<div class="link"><a href="#" id="vod_a_8" onclick="gotopaly(8)" onfocus="showFullName(8)" onblur="showCutName(8)">
        <img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt" id="vod_8" style="overflow:hidden"></div>
        <div class="icon02" id="flage_8" style="display:none"></div>
	</div>
</div>
	
	<!--pages-->
	<div class="pages page-sty">
		<div class="item">
			<div class="pic"><a href="#" onclick="pageAction(-1)"><img src="<%=static_url%>/images/btn-prev.png" width="78" height="30" /></a></div>
		</div>
		<div class="item" style="left:87px;">
			<div class="pic"><a href="#" onclick="pageAction(1)"><img src="<%=static_url%>/images/btn-next.png" width="78" height="30" /></a></div>
		</div>
		<div class="pages-num" id="page"><span class="current" id="vodlistPageNum"></span></div>
	</div>

<!--the end-->




<!--r-poster-->
<div class="hd-r-poster02">
	<div class="intro">
		<div class="txt" id="infortext"></div>
	</div>
    <div class="poster" id="fullPlay">
		<div class="link"><a id="vofulldpaly" href="#"  onclick="vofulldpaly()" onfocus="setAre(2)"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="pic"><iframe id="playPage" name="playPage" border="0"></iframe></div>
	</div>

</div>

<div class="full-screen">
	<div class="txt" style="vertical-align:bottom">全屏播放</div>
	<div class="pic"><img src="<%=static_url%>/images/icon-full-screen.png" /></div>
</div>
<!--the end-->

<!--pop up-->
<div class="popup popbg02" id="subNumDiv" style="display:none;">
	<div class="txt02" style="top:80px;">请选择节目分段：</div>
	<div class="pop-btn" style="left:92px;top:140px;">
		<div class="item wid02">
			<div class="link"><a href="#" id="select_0" onfocus="setAre(3)"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_0"></div>
		</div>
		<div class="item wid02" style="left:140px;">
			<div class="link"><a href="#" id="select_1" onfocus="setAre(3)"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_1"></div>
		</div>
		<div class="item wid02" style="left:280px;">
			<div class="link"><a href="#" id="select_2" onfocus="setAre(3)"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_2"></div>
		</div>
		<div class="item wid02" style="left:420px;">
			<div class="link"><a href="#" id="select_3" onfocus="setAre(3)"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_3"></div>
		</div>
	</div>
	<div class="pop-btn" style="left:92px;top:210px;">
		<div class="item wid02">
			<div class="link"><a href="#" id="select_4" onfocus="setAre(3)"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_4"></div>
		</div>
		<div class="item wid02" style="left:140px;">
			<div class="link"><a href="#" id="select_5" onfocus="setAre(3)"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_5"></div>
		</div>
		<div class="item wid02" style="left:280px;">
			<div class="link"><a href="#" id="select_6" onfocus="setAre(3)"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_6"></div>
		</div>
		<div class="item wid02" style="left:420px;">
			<div class="link"><a href="#" id="select_7" onfocus="setAre(3)"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_7"></div>
		</div>
	</div>
	<div class="pop-btn" style="left:92px;top:280px;">
		<div class="item wid02">
			<div class="link"><a href="#" id="select_8" onfocus="setAre(3)"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_8"></div>
		</div>
		<div class="item wid02" style="left:140px;">
			<div class="link"><a href="#" id="select_9" onfocus="setAre(3)"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_9"></div>
		</div>
		<div class="item wid02" style="left:280px;">
			<div class="link"><a href="#" id="select_10" onfocus="setAre(3)"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_10"></div>
		</div>
		<div class="item wid02" style="left:420px;">
			<div class="link"><a href="#" id="select_11" onfocus="setAre(3)"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_11"></div>
		</div>
	</div>
</div>		
<!--the end-->

<script type="text/javascript">
var pageCount=<%=pageCount%>;
var pageIndex=<%=pageIndex%>;
var pageSize=<%=pageSize%>;
var cruntDBListFocus = <%=cruntDBListFocus%>;
var cruntdblistFocusPageIndex = <%=cruntdblistFocusPageIndex%>;
var flage = <%=flage%>;
var pressListOKFlage = <%=pressListOKFlage%>;
var dbLisVodId= "<%=dbLisVodId%>";
var vodDiscription = "<%=vodDiscription%>";
var FanyeQianIDList;
var FanyeQianDBList;
var FanyeQianFlage=0;
var fatherId;
var loadIframeTimer ="";
if(""!=("<%=fanyeQianIDList%>"))
{
	FanyeQianIDList = ("<%=fanyeQianIDList%>").split(",");
}
var pos = <%=pos%> ;
var area = <%=area%>; // 0：top 1：列表  2:视频窗口 3:弹出的选集数的层 4：弹出的收藏层
var backUrl = "index.jsp";
var jsonObj;
var vodList;
var vodIdList = new Array();
var CateIdList = new Array();
var ajaxflag = false;
var $$ = {};
var subPos = 0;//子集
function $(id){
	if(!$$[id]){
	   $$[id] = document.getElementById(id);
	}
	return $$[id];
}
function onPageLoad(){
	 init();
	 initpos();
	 var loadIframeTimer = setTimeout("loadIframe()",200);
	 if(cruntdblistFocusPageIndex == pageIndex)
	 {
	   $("flage_"+cruntDBListFocus).style.display = "block";
	 }
	 else
	 {
		 $("flage_"+cruntDBListFocus).style.display = "none";
	 }
}
function initpos(){
	if(1==area){$("vod_a_"+pos).focus();}
	else if(2==area){$("vofulldpaly").focus();}
}
function init()
{
	ajaxurl="<%=static_en%>/ajaxdata/vod_list_data.jsp?pageIndex="+pageIndex+"&pageSize="+pageSize+"&categoryId=<%=categoryId%>&posterType=<%=postertype%>";
    getAJAXData(ajaxurl,myCallBack);
}
function myCallBack(respText)
{
	 jsonObj = eval('('+respText+')');
	 vodList = jsonObj.jsonvodlist;
	 fatherId = vodList[flage].did;
	 //翻页没有按OK前
	 if(FanyeQianFlage == 0&&FanyeQianIDList==undefined)
	 {
		 FanyeQianDBList = vodList;
		 FanyeQianIDList = FanyeQianDBList[flage].dsubvodidlist;
		 fatherId = FanyeQianDBList[flage].did;
	 }
	 pageCount=jsonObj.jsonpagecount;
	 var len = vodList.length;
	 $("vodlistPageNum").innerText = ((pageCount == 0)?0:pageIndex) + "/" + pageCount;
	 $("page").innerText = ((pageCount == 0)?0:pageIndex) + "/" + pageCount;
	 if(len==0)
	 { 
		 for(var i=len;i<pageSize;i++)
		 {
			$("vod_a_"+i).style.display = "none";
		 }
		 //中兴的盒子必须拿个变量保存中文字符不然要出现乱码
		var nodiscreption = "暂无简介";
		 var noComment = "暂无内容";
		 $("vod_0").innerText = nodiscreption;
		 $("infortext").innerText = noComment;
	 }
	 if(len>0)
	 {
		  for(var i=len;i<pageSize;i++) {
		    $("vod_a_"+i).style.display = "none";
		  } 
		  for(var i=0;i<len;i++){
			  $("vod_"+i).innerText = vodList[i].dname;
			  $("vod_a_"+i).style.display = "block";
		  }
	 }
	 if(pressListOKFlage ==1||dbLisVodId==""||dbLisVodId==undefined)
	 {
	   dbLisVodId = vodList[flage].dsubvodidlist[0];
	   vodDiscription = vodList[flage].ddescription;
	 }
	 else
	 {
		//解决中兴盒子乱码问题
	   vodDiscription="";
	 }
}

function pageAction(action)
{
   ajaxflag = true ;
   if(action==1){ pageIndex=pageIndex+1; }else{ pageIndex=pageIndex-1; } 
   if((pageIndex>0)&&(pageIndex<=pageCount)){
       ajaxurl="<%=static_en%>/ajaxdata/vod_list_data.jsp?pageIndex="+pageIndex+"&pageSize="+pageSize+"&categoryId=<%=categoryId%>&posterType=<%=postertype%>";
	   getAJAXData(ajaxurl,myCallBack);
	   if(cruntdblistFocusPageIndex == pageIndex)
	 {
	   $("flage_"+cruntDBListFocus).style.display = "block";
	 }
	 else
	 {
		 $("flage_"+cruntDBListFocus).style.display = "none";
	 }
   }else{
      if(action==1){ pageIndex=pageCount; }else{ pageIndex=1; } 
   }
   if(1==pageIndex){ajaxflag = false;}
}

function goBack(){
	 if(3==area){hideSubNumDiv();return ;}
	 var url="index.jsp";
	 window.location.href=url ;
}

function loadIframe(){
	if(loadIframeTimer){clearTimeout(loadIframeTimer);}
    if(0==pageCount){return;}
	if(vodDiscription==""){ vodDiscription="暂无简介";$("infortext").innerText = vodDiscription;}
	else{
		if(vodDiscription.length>40){ $("infortext").innerText = vodDiscription.substr(0,40)+"...";}
		else{ $("infortext").innerText = vodDiscription;}
	}
	playPage.location.href = "<%=static_en%>/player/vodSmallplay.jsp?progId="+dbLisVodId+"&_height=423&_width=565&_left=668&_top=230";
	voiceTimer = setTimeout("isMute()",800);
}

function gotopaly(num)
{
	$("flage_"+cruntDBListFocus).style.display = "none";
	flage = num;
	cruntDBListFocus = num;
	cruntdblistFocusPageIndex = pageIndex;
	pressListOKFlage = 1;
	if(pressListOKFlage ==1)
	 {
	   FanyeQianFlage=0;
	   dbLisVodId = vodList[flage].dsubvodidlist[0];
	   vodDiscription = vodList[flage].ddescription;
	 }
	if(0==pageCount){return;}
	if(vodDiscription=="")
	{
		vodDiscription="暂无简介";
	    $("infortext").innerText = vodDiscription;
	}
	else{
		if(vodDiscription.length>40){ $("infortext").innerText = vodDiscription.substr(0,40)+"...";}
		else{ $("infortext").innerText = vodDiscription;}
	}
	
	if(cruntdblistFocusPageIndex == pageIndex)
	 {
	   $("flage_"+cruntDBListFocus).style.display = "block";
	 }
	 else
	 {
		 $("flage_"+cruntDBListFocus).style.display = "none";
	 }
	
	playPage.location.href = "<%=static_en%>/player/vodSmallplay.jsp?progId="+dbLisVodId+"&_height=423&_width=565&_left=668&_top=230";

}
function setAre(num)
{
	area=num;
}
function showFullName(num){
	setAre(1);
	 if(0==pageCount){return;}
	 $("vod_"+num).innerHTML = ((vodList[num].dname).length)>22?("<marquee>"+vodList[num].dname+"</marquee>"):(vodList[num].dname);
}
function showCutName(num){
	 if(0==pageCount){return;}
	 $("vod_"+num).innerHTML = ((vodList[num].dname).length)>22?(vodList[num].dname).substr(0,22):vodList[num].dname;
}

function vofulldpaly()
{
	if(0==pageCount){return;}
	if(pressListOKFlage ==0)
	{
	   SubLen = FanyeQianIDList.length;
	}
	else
	{
		SubLen = vodList[flage].dsubvodidlist.length;
	}
	//SubLen=9
	if(SubLen > 1){
		subPos = 0;
		showSubNumDiv();
		chooseSubNum(0);
	}else{
		subPos = 0;
		pkPlay();
	}
	subisok = 1;
}
function  pkPlay(){
	if(pressListOKFlage ==0)
	{
	   dbLisVodId = FanyeQianIDList[0];
	}
	else
	{
		dbLisVodId = vodList[flage].dsubvodidlist[0];
	}
	backUrl = "<%=static_en%>/page/china-corps.jsp?area=2&pageIndex="+pageIndex+"&flage="+flage+"&cruntdblistFocusPageIndex="+cruntdblistFocusPageIndex+"&cruntDBListFocus="+cruntDBListFocus+"&dbLisVodId="+dbLisVodId+"&pressListOKFlage="+pressListOKFlage+"&vodDiscription="+vodDiscription+"&FanyeQianIDList="+FanyeQianIDList;
	addURLtoCookie("vodPlay",backUrl);
	location.href = "<%=static_en%>/player/au_PlayFilm.jsp?PROGID="+dbLisVodId+"&FATHERSERIESID="+fatherId+"&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=0&BEGINTIME=0&ENDTIME=200000";
}

function showSubNumDiv(){
	area = 3;//焦点转移到弹出选集层
	for(var i = 0; i<SubLen; i++)
	{
		if(i<9)
		{
			$("sub_"+i).innerText = "0"+(i+1);
		}
		else
		{
			$("sub_"+i).innerText = i+1;
		}
	}
	for(var i = SubLen; i<12; i++)
	{
		$("select_"+i).style.display="none";
	}
	$("subNumDiv").style.display = "block";
	$("select_"+subPos).focus();
}

var left_right_timer = "";
var up_down_timer = "";
var subisok = 0;
function hideSubNumDiv(){
	area = 2; //焦点回到视频窗口区域
	$("subNumDiv").style.display = "none";
	$("vofulldpaly").focus();
}
function chooseSubNum(num){
	if(left_right_timer){clearTimeout(left_right_timer)}
	subPos = subPos + num;
	if(subPos>SubLen-1){subPos = 0;}
	else if(subPos<0){subPos = SubLen-1;}
	$("select_"+subPos).focus();
	area=3;
}

function chooseUpAndDown(num){
	if(up_down_timer){clearTimeout(up_down_timer)}
	subPos = subPos + num;
	if(subPos>SubLen-1){subPos = 0;}
	else if(subPos<0){subPos = SubLen-1;}
	$("select_"+subPos).focus();
	area=3;
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
		case 33://pgae_up
		if(1 == area)
		{
			pressListOKFlage = 0;
				//翻页没有按OK
			FanyeQianFlage=1;
			pageAction(-1 );
		}
			break;
		case 34://page_down
		if(1 == area)
		{
		  pressListOKFlage = 0;
			//翻页没有按OK
		  FanyeQianFlage=1;
			pageAction(1);
		}
			break;
		case 37://left
		if(3 == area&&1== subisok){
			left_right_timer = setTimeout("chooseSubNum(-1)",5);
		}
			break;
		case 39://right
		if(3 == area&&1== subisok){
			left_right_timer = setTimeout("chooseSubNum(1)",5);
		}
			break;
		case 38://up
		if(3 == area&&1== subisok){
			up_down_timer = setTimeout("chooseUpAndDown(-4)",5);
	 		//chooseUpAndDown(-4);
		}
			break;
		case 40://down
		if(3 == area&&1== subisok){
			up_down_timer = setTimeout("chooseUpAndDown(4)",5);
			//chooseUpAndDown(4);
		}
			break;
		case 13://ok
			if( 3 == area&&1== subisok){pkPlay();};
			break;
		case 259:volumeUp();break;
		case 260:volumeDown();break;
		case 261:setMuteFlag();break;
		case 8:
			goBack();
			break;
	} 
}

//////为深圳加播放器的控制begin///////
var volumeDivIsShow = false;
var volume = 50;
var bottomTimer = "";
var voiceTimer = "";
function volumeUp()
{
	hideVoice();
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(1 == muteFlag){mp.setMuteFlag(0);}
	volume = mp.getVolume(); 
	volume += 5;
	if(volume >= 100){volume = 100;  }
	mp.setVolume(volume);  
	if (mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
	{
		if(bottomTimer){clearTimeout(bottomTimer);}
		genVolumeTable(volume);
		bottomTimer = setTimeout("hideBottom();", 3000);
	}
}
function volumeDown()
{	
    hideVoice();
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){mp.setMuteFlag(0);}
	volume = mp.getVolume();
	volume -= 5;	
	if(volume <= 0){volume = 0;   }
	mp.setVolume(volume);  
	if (mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
	{
		if(bottomTimer){clearTimeout(bottomTimer);}
		genVolumeTable(volume);
		bottomTimer = setTimeout("hideBottom();", 3000);
	}
}
function hideBottom()
{
	volumeDivIsShow = false;
	$("bottomframe").innerHTML = "";
}
function hideVoice()
{
	$("voice").src = "#";
}
function genVolumeTable(volume)
{
	var tableDef = '<table width="490px" border="0" cellpadding="0" cellspacing="0"><tr>';
	volume = parseInt(volume / 5);
	for (i = 0; i < 40; i++)
	{
		if (i % 2 == 0)
		{
			tableDef += '<td width="10px" height="27px" bgcolor="transparent"></td>';
		}
		else
		{
			if ( i / 2 < volume)
			{
				tableDef += '<td width="10px" height="27px" bgcolor="#00ff00"></td>';
			}
			else
			{
				tableDef += '<td width="10px" height="27px" bgcolor="cccccc"></td>';
			}
		}
	}
	tableDef += '<td width="10px"></td><td width="20px"><img src="<%=static_en%>/player/playerimages/volume.gif"></td><td width="20px" style="color:white;font-size:28">' + 						volume + '</td>';
	tableDef += '</tr></table>'; 
	$("bottomframe").innerHTML = tableDef;    	
}
function setMuteFlag()
{
	hideBottom();
	if(voiceTimer){clearTimeout(voiceTimer);}
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(1 == muteFlag){
		mp.setMuteFlag(0);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0){
			$("voice").src = "<%=static_en%>/player/playerimages/muteoff.png";
			voiceTimer = setTimeout("hideVoice()", 3000);
		}
	}else{
		mp.setMuteFlag(1);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0){
			$("voice").src = "<%=static_en%>/player/playerimages/muteon.png";
		}
	}      
}
function isMute(){
	var muteFlag = mp.getMuteFlag();
	if(1 == muteFlag){
		$("voice").src = "<%=static_en%>/player/playerimages/muteon.png";
	}
}
//////为深圳加播放器的控制end///////
</script>
<div id="bottomframe" style="position:absolute; left:711px; top:570px; width:600px; height:80px; z-index:3"></div>
<div style="position:absolute; left:1163px; top:244px; width:54px; height:66px; z-index:4;"><img id="voice" src="<%=static_url%>/images/dot.gif"/></div>
</body>
</html>
