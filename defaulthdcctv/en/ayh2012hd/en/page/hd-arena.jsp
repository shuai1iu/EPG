<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="net.sf.json.JSONArray" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head><%@ include file="../common/golbal.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>深圳奥运专题高清3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../static/css/style.css" />
<script type="text/javascript" src="<%=static_url%>/js/cookie.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/common.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/ajax_common.js"></script>
<script type="text/javascript">
if(typeof(iPanel)!= 'undefined'){iPanel.focusWidth = "8"; iPanel.defaultFocusColor = "#2A5BB8";}
</script>
<style type="text/css">
<!--
	body{ background:transparent url(../static/images/bg-hd.gif) no-repeat;}
-->
</style>
</head>
<body onload="onPKPageLoad();">
<%@ include file="../datasource/datasource.jsp"%>
<%@ include file="../datasource/property.jsp"%>
<% 
   DataSource dataSource=new DataSource(request); 
   String posterType="0";
   int pos=dataSource.huaWeiUtil.getInt(request.getParameter("pos"),0);
   int area=dataSource.huaWeiUtil.getInt(request.getParameter("area"),2);
   int pageIndex=dataSource.huaWeiUtil.getInt(request.getParameter("pageIndex"),1);
   int pageCount=dataSource.huaWeiUtil.getInt(request.getParameter("pageCount"),0);
   int pageSize = 7;
   String categoryId=dataSource.huaWeiUtil.getString(request.getParameter("categoryId"));
   String dbListcategoryId=dataSource.huaWeiUtil.getString(request.getParameter("dbListcategoryId"));
   if("".equals(categoryId)){
   		categoryId = gaoqingsaichang;
   }
   
   int cruntfocusPageIndex = dataSource.huaWeiUtil.getInt(request.getParameter("cruntfocusPageIndex"),pageIndex);
   int cruntId = dataSource.huaWeiUtil.getInt(request.getParameter("cruntId"),0);
   int dblistPageIndex=dataSource.huaWeiUtil.getInt(request.getParameter("dblistPageIndex"),1);
   int dbListpageCount=dataSource.huaWeiUtil.getInt(request.getParameter("dbListpageCount"),0);
   int flage =dataSource.huaWeiUtil.getInt(request.getParameter("flage"),0);
   int dblistPageSize = 9;
   int cruntDBListFocus = dataSource.huaWeiUtil.getInt(request.getParameter("cruntDBListFocus"),0);
   int cruntdblistFocusPageIndex = dataSource.huaWeiUtil.getInt(request.getParameter("cruntdblistFocusPageIndex"),dblistPageIndex);
   int pressOKFlage = dataSource.huaWeiUtil.getInt(request.getParameter("pressOKFlage"),0);
   int pressListOKFlage= dataSource.huaWeiUtil.getInt(request.getParameter("pressListOKFlage"),0);
   int categoryIDIndex = dataSource.huaWeiUtil.getInt(request.getParameter("categoryIDIndex"),0);
   String dbLisVodId=dataSource.huaWeiUtil.getString(request.getParameter("dbLisVodId"));
   String vodDiscription=dataSource.huaWeiUtil.getString(request.getParameter("vodDiscription"));
   String fanyeQianIDList = dataSource.huaWeiUtil.getString(request.getParameter("FanyeQianIDList"));
%>

<div class="wrapper">

<%String currentPageId = "_1001"; %>
<%@ include file="../common/head.jsp" %>



<!--日期-->
<div class="sub">    <!--item-focus为焦点；select为当前选中;若有item-focus为焦点则去掉<div class="link"><a href="#"><img src="../static/images/t.gif" /></a></div>--> 
	<div class="item">
		<!--<div class="link"><a href="#"><img src="../static/images/t.gif" /></a></div>-->
		<div class="txt">选择日期:</div>
	</div>
	<div class="btn"><a href="#" id="cateFocusPageUp" onclick="pageCategoryAction(-1)" ><img src="../static/images/btn-left.png" /></a></div>   <!--btn-left.png/btn-left-on.png-->
	<div class="item" style="left:175px;">
		<div class="link"><a href="#" id="cateFocus_0" onclick="getDBList(0)" onfocus="setAre(1)"><img src="../static/images/t.gif" /></a></div>
		<div class="txt" id="cate_0" style="overflow:hidden"></div>
	</div>
	<div class="item" style="left:318px;">
		<div class="link"><a href="#" id="cateFocus_1" onclick="getDBList(1)" onfocus="setAre(1)"><img src="../static/images/t.gif" /></a></div>
		<div class="txt" id="cate_1" style="overflow:hidden"></div>
	</div>
	<div class="item" style="left:461px;">
		<div class="link"><a href="#" id="cateFocus_2" onclick="getDBList(2)" onfocus="setAre(1)"><img src="../static/images/t.gif" /></a></div>
		<div class="txt" id="cate_2" style="overflow:hidden"></div>
	</div>
	<div class="item" style="left:604px;">
		<div class="link"><a href="#" id="cateFocus_3" onclick="getDBList(3)" onfocus="setAre(1)"><img src="../static/images/t.gif" /></a></div>
		<div class="txt" id="cate_3" style="overflow:hidden"></div>
	</div>
	<div class="item" style="left:747px;">
		<div class="link"><a href="#" id="cateFocus_4" onclick="getDBList(4)" onfocus="setAre(1)"><img src="../static/images/t.gif" /></a></div>
		<div class="txt" id="cate_4" style="overflow:hidden"></div>
	</div>
	<div class="item" style="left:890px;">
		<div class="link"><a href="#" id="cateFocus_5" onclick="getDBList(5)" onfocus="setAre(1)"><img src="../static/images/t.gif" /></a></div>
		<div class="txt" id="cate_5" style="overflow:hidden"></div>
	</div>
	<div class="item" style="left:1033px;">
		<div class="link"><a href="#" id="cateFocus_6" onclick="getDBList(6)" onfocus="setAre(1)"><img src="../static/images/t.gif" /></a></div>
		<div class="txt" id="cate_6" style="overflow:hidden"></div>
	</div>
	<div class="btn" style="left:1178px;"><a href="#" id="cateFocusPagedown" onclick="pageCategoryAction(1)"><img src="../static/images/btn-right.png" /></a></div> <!--btn-right.png/btn-right-on.png-->
</div>	
<!--the end-->



<!--list-->
<div class="leftcol list">  <!--当前选中则显示<div class="icon"></div>-->
	<div class="item bg01">
		<div class="link"><a href="#" id="vodFocus_0" onclick="gotopaly(0)" onfocus="showFullName(0)" onblur="showCutName(0)"><img src="../static/images/t.gif" /></a></div>
		<div class="txt" id="vod_0" style="overflow:hidden"></div>
        <div class="icon" id="flage_0" style="display:none"></div>
	</div>
	<div class="item bg02" style="top:49px;">
		<div class="link"><a href="#" id="vodFocus_1" onclick="gotopaly(1)" onfocus="showFullName(1)" onblur="showCutName(1)"><img src="../static/images/t.gif" /></a></div>
		<div class="txt" id="vod_1" style="overflow:hidden"></div>
        <div class="icon" id="flage_1" style="display:none"></div>
	</div>
	<div class="item bg01" style="top:98px;">
		<div class="link"><a href="#" id="vodFocus_2" onclick="gotopaly(2)"  onfocus="showFullName(2)" onblur="showCutName(2)"><img src="../static/images/t.gif" /></a></div>
		<div class="txt" id="vod_2" style="overflow:hidden"></div>
        <div class="icon" id="flage_2" style="display:none"></div>
	</div>
	<div class="item bg02" style="top:147px;">
		<div class="link"><a href="#" id="vodFocus_3" onclick="gotopaly(3)" onfocus="showFullName(3)" onblur="showCutName(3)"><img src="../static/images/t.gif" /></a></div>
		<div class="txt" id="vod_3" style="overflow:hidden"></div>
        <div class="icon" id="flage_3" style="display:none"></div>
	</div>
	<div class="item bg01" style="top:196px;">
		<div class="link"><a href="#" id="vodFocus_4" onclick="gotopaly(4)" onfocus="showFullName(4)" onblur="showCutName(4)"><img src="../static/images/t.gif" /></a></div>
		<div class="txt" id="vod_4" style="overflow:hidden"></div>
        <div class="icon" id="flage_4" style="display:none"></div>
	</div>
	<div class="item bg02" style="top:245px;">
		<div class="link"><a href="#" id="vodFocus_5" onclick="gotopaly(5)" onfocus="showFullName(5)" onblur="showCutName(5)"><img src="../static/images/t.gif" /></a></div>
		<div class="txt" id="vod_5" style="overflow:hidden"></div>
        <div class="icon" id="flage_5" style="display:none"></div>
	</div>
	<div class="item bg01" style="top:294px;">
		<div class="link"><a href="#" id="vodFocus_6" onclick="gotopaly(6)" onfocus="showFullName(6)" onblur="showCutName(6)"><img src="../static/images/t.gif" /></a></div>
		<div class="txt" id="vod_6" style="overflow:hidden"></div>
        <div class="icon" id="flage_6" style="display:none"></div>
	</div>
	<div class="item bg02" style="top:343px;">
		<div class="link"><a href="#" id="vodFocus_7" onclick="gotopaly(7)" onfocus="showFullName(7)" onblur="showCutName(7)"><img src="../static/images/t.gif" /></a></div>
		<div class="txt" id="vod_7" style="overflow:hidden"></div>
        <div class="icon" id="flage_7" style="display:none"></div>
	</div>
	<div class="item bg01" style="top:392px;">
		<div class="link"><a href="#" id="vodFocus_8" onclick="gotopaly(8)" onfocus="showFullName(8)" onblur="showCutName(8)"><img src="../static/images/t.gif" /></a></div>
		<div class="txt" id="vod_8" style="overflow:hidden"></div>
        <div class="icon" id="flage_8" style="display:none"></div>
	</div>
</div>
	
	<!--pages-->
	<div class="pages">
		<div class="item">
			<div class="pic"><a href="#" onclick="pageAction(-1)"><img src="../static/images/btn-prev.png" width="78" height="30" /></a></div>
		</div>
		<div class="item" style="left:87px;">
			<div class="pic"><a href="#" onclick="pageAction(1)"><img src="../static/images/btn-next.png" width="78" height="30" /></a></div>
		</div>
		<div class="pages-num"><span class="current" id="vodlistPageNum"></span></div>
	</div>

<!--the end-->



<!--r-poster-->
<div class="hd-r-poster">
	<div class="intro">
		<div class="txt" id="infortext" ></div>
	</div>
	<div class="poster">
    	<div class="link"><a href="#" id="vofulldpaly" onclick="vofulldpaly()" onfocus="setAre(3)"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="pic">
			<iframe id="playPage" name="playPage" border="0" frameSpacing="0" marginWidth="0" marginHeight="0" frameBorder="0" noResize scrolling="no" vspace="0" width="685" height="387" style="background:transparent;"></iframe>
		</div>
	</div>
</div>

<div class="full-screen">
	<div class="txt">全屏播放</div>
	<div class="pic"><img src="../static/images/icon-full-screen.png" /></div>
</div>
</div>
<!--the end-->

<!--pop up-->
<div class="popup popbg02" id="subNumDiv" style="display:none;">
	<div class="txt02" style="top:80px;">请选择节目分段：</div>
	<div class="pop-btn" style="left:92px;top:140px;">
		<div class="item wid02">
			<div class="link"><a href="#" id="select_0"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_0"></div>
		</div>
		<div class="item wid02" style="left:140px;">
			<div class="link"><a href="#" id="select_1"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_1"></div>
		</div>
		<div class="item wid02" style="left:280px;">
			<div class="link"><a href="#" id="select_2"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_2"></div>
		</div>
		<div class="item wid02" style="left:420px;">
			<div class="link"><a href="#" id="select_3"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_3"></div>
		</div>
	</div>
	<div class="pop-btn" style="left:92px;top:210px;">
		<div class="item wid02">
			<div class="link"><a href="#" id="select_4"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_4"></div>
		</div>
		<div class="item wid02" style="left:140px;">
			<div class="link"><a href="#" id="select_5"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_5"></div>
		</div>
		<div class="item wid02" style="left:280px;">
			<div class="link"><a href="#" id="select_6"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_6"></div>
		</div>
		<div class="item wid02" style="left:420px;">
			<div class="link"><a href="#" id="select_7"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_7"></div>
		</div>
	</div>
	<div class="pop-btn" style="left:92px;top:280px;">
		<div class="item wid02">
			<div class="link"><a href="#" id="select_8"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_8"></div>
		</div>
		<div class="item wid02" style="left:140px;">
			<div class="link"><a href="#" id="select_9"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_9"></div>
		</div>
		<div class="item wid02" style="left:280px;">
			<div class="link"><a href="#" id="select_10"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_10"></div>
		</div>
		<div class="item wid02" style="left:420px;">
			<div class="link"><a href="#" id="select_11"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="sub_11"></div>
		</div>
	</div>
</div>		
<!--the end-->

<script type="text/javascript">
var pageCount=<%=pageCount%>;
var pageIndex=<%=pageIndex%>;
var pageSize=<%=pageSize%>;
var dblistPageIndex = <%=dblistPageIndex%>;
var dblistPageSize = <%=dblistPageSize%>;
var dbListpageCount = <%=dbListpageCount%>;
var cruntfocusPageIndex = <%=cruntfocusPageIndex%>;
var cruntId = <%=cruntId%>;
var dbListcategoryId = "<%=dbListcategoryId%>";
var categoryList;
var jsonObj;
var vodList;
var vodIdList = new Array();
var backUrl = "index.jsp";
var area = <%=area%>; 
var pos = <%=pos%> ;
var ajaxflag = false;
var ajaxlistflag = false;
var cruntdblistFocusPageIndex = <%=cruntdblistFocusPageIndex%>;
var cruntDBListFocus = <%=cruntDBListFocus%>;
var dbListcategoryId= "<%=dbListcategoryId%>";
var pressListOKFlage = <%=pressListOKFlage%>;
var dbLisVodId= "<%=dbLisVodId%>";
var categoryIDIndex = <%=categoryIDIndex%>;
var pressOKFlage = <%=pressOKFlage%>; 
var gotoPlayFlage = 0;
var vodDiscription = "<%=vodDiscription%>";
var subPos = 0;//子集
var SubLen;
var flage = <%=flage%>;
var FanyeQianIDList;
var FanyeQianDBList;
var subisok = 0;
var fatherId = -1;
if(""!=("<%=fanyeQianIDList%>"))
{
	FanyeQianIDList = ("<%=fanyeQianIDList%>").split(",");
}
var FanyeQianFlage=0;
function $(id){
	return document.getElementById(id);
}
function onPKPageLoad(){
	 init();
	 initpos();
	 var loadIframeTimer = setTimeout("loadIframe()",500);
	 if(cruntfocusPageIndex == pageIndex)
	 {
	   $("cate_"+cruntId).style.background = "../static/images/sub-blue-bg.png";
	 }
	 else
	 {
		 $("cate_"+cruntId).style.background = "../static/images/subbg.png";
	 }
	 
	 if(cruntdblistFocusPageIndex == dblistPageIndex)
	 {
	   $("flage_"+cruntDBListFocus).style.display = "block";
	 }
	 else
	 {
		 $("flage_"+cruntDBListFocus).style.display = "none";
	 }
}
function initpos(){
	if(1==area){$("cateFocus_"+pos).focus();}
	else if(2==area){$("vodFocus_"+pos).focus();}
	else if(3==area){$("vofulldpaly").focus();}	
}
function init()
{
	 var ajaxurl="<%=static_en%>/ajaxdata/category_list_data.jsp?pageIndex="+pageIndex +"&pageSize="+pageSize+"&categoryId=<%=categoryId%>&posterType=<%=posterType%>";
	 getAJAXData(ajaxurl,myfirstCategoryCallBack);
}

function myfirstCategoryCallBack(respText)
{
	 jsonObj = eval('('+respText+')');
	 categoryList = jsonObj.jsoncategorylist;
	 pageCount=jsonObj.jsonpagecount;
	 var len=categoryList.length;
	 if(dbListcategoryId==""||dbListcategoryId==undefined)
	 {
	   dbListcategoryId = categoryList[0].dcmsid;
	 }
	 else
	 {
		 if(pressOKFlage == 1)
		 {
			dbListcategoryId = categoryList[categoryIDIndex].dcmsid;
		 }
	 }
	 if(dbListcategoryId==""||dbListcategoryId==undefined)
	 {
	   dbListcategoryId = categoryList[0].dcmsid;
	 }
	ajaxurl="<%=static_en%>/ajaxdata/vod_list_data.jsp?pageIndex="+dblistPageIndex +"&pageSize="+dblistPageSize+"&categoryId="+dbListcategoryId+"&posterType=<%=posterType%>";
	gotoPlayFlage = 0;
	getAJAXData(ajaxurl,myMLListCallBack);
	 for(var i=len;i<pageSize;i++)
	 {
	 	$("cate_"+i).innerText = "";
		$("cateFocus_"+i).style.display = "none";
	 }
	 for(var i=0;i<len;i++)
	 {
	  	$("cate_"+i).innerText = categoryList[i].dname;
		$("cateFocus_"+i).style.display = "block";
	 }
	 
	 //取视频列表
}

function myCategoryCallBack(respText)
{
	 jsonObj = eval('('+respText+')');
	 categoryList = jsonObj.jsoncategorylist;
	 pageCount=jsonObj.jsonpagecount;
	 var len=categoryList.length;
	 for(var i=len;i<pageSize;i++)
	 {
	 	$("cate_"+i).innerText = "";
		$("cateFocus_"+i).style.display = "none";
	 }
	 for(var i=0;i<len;i++)
	 {
	  	$("cate_"+i).innerText = categoryList[i].dname;
		$("cateFocus_"+i).style.display = "block";
	 }
	 
	 //取视频列表
}

function pageCategoryAction(action)
{
	ajaxflag = true ;
   if(action==1){ pageIndex=pageIndex+1; }else{ pageIndex=pageIndex-1; } 
   if((pageIndex>0)&&(pageIndex<=pageCount)){
       ajaxurl="<%=static_en%>/ajaxdata/category_list_data.jsp?pageIndex="+pageIndex +"&pageSize="+pageSize+"&categoryId=<%=categoryId%>&posterType=<%=posterType%>";
	   getAJAXData(ajaxurl,myCategoryCallBack);
	    if(cruntfocusPageIndex == pageIndex)
	   {
		 $("cate_"+cruntId).style.background = "../static/images/sub-blue-bg.png";
	   }
	   else
	   {
		   $("cate_"+cruntId).style.background = "../static/images/subbg.png";
	   }
   }else{
      if(action==1){ pageIndex=pageCount; }else{ pageIndex=1; } 
   }
   if(1==pageIndex){ajaxflag = false;}
}
function getDBList(num)
{
	dblistPageIndex=1;
	categoryIDIndex = num%9;
	pressOKFlage = 1;
	gotoPlayFlage=2;
	$("cate_"+cruntId).style.background = "../static/images/subbg.png";
	cruntId = num;
	dbListcategoryId = categoryList[num].dcmsid;
	cruntfocusPageIndex = pageIndex;
	if(cruntfocusPageIndex == pageIndex)
	{
	  $("cate_"+cruntId).style.background = "../static/images/sub-blue-bg.png";
	}
	else
	{
	  $("cate_"+cruntId).style.background = "../static/images/subbg.png";
	}
	ajaxurl="<%=static_en%>/ajaxdata/vod_list_data.jsp?pageIndex="+dblistPageIndex +"&pageSize="+dblistPageSize+"&categoryId="+dbListcategoryId+"&posterType=<%=posterType%>";
	getAJAXData(ajaxurl,myMLListCallBack);

}
function myMLListCallBack(respText)
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
	 dbListpageCount=jsonObj.jsonpagecount;
	 var len=vodList.length;
	 $("vodlistPageNum").innerText = ((dbListpageCount == 0)?0:dblistPageIndex) + "/" + dbListpageCount;
	 if(len==0)
	 { 
	   //中兴的盒子必须拿个变量保存中文字符不然要出现乱码
		 vodDiscription="暂无简介";
		 var vodComent = "暂无内容";
		  for(var i=len;i<dblistPageSize;i++)
		 {
			 $("vod_"+i).innerText = "";
			$("vodFocus_"+i).style.display = "none";
		 }
		 $("vod_0").innerText = vodComent;
		 $("infortext").innerText = vodDiscription;
	 }
	 if(len>0)
	 {
		 for(var i=len;i<dblistPageSize;i++)
		 {
			$("vod_"+i).innerText = "";
			$("vodFocus_"+i).style.display = "none";
		 }
		 if(len<dblistPageSize&&dblistPageIndex>1)
		 {
			$("vodFocus_"+(len-1)).focus();
		 }
		 for(var i=0;i<len;i++)
		 {
			$("vod_"+i).innerText = (vodList[i].dname).substr(0,15);
			$("vodFocus_"+i).style.display = "block";
		 }
	 }
	 if(gotoPlayFlage==2)
	{
	   gotopaly(0);
	}
	
	if(pressListOKFlage ==1||dbLisVodId==""||dbLisVodId==undefined)
	 {
	   dbLisVodId = vodList[flage].dsubvodidlist[subPos];
	   vodDiscription = vodList[flage].ddescription;
	 }
}

function pageAction(action)
{
	gotoPlayFlage =1;
	//翻页没有按OK
	FanyeQianFlage=1;
	pressListOKFlage = 0;
	ajaxlistflag = true ;
   if(action==1){ dblistPageIndex=dblistPageIndex+1; }else{ dblistPageIndex=dblistPageIndex-1; } 
   if((dblistPageIndex>0)&&(dblistPageIndex<=dbListpageCount)){
      ajaxurl="<%=static_en%>/ajaxdata/vod_list_data.jsp?pageIndex="+dblistPageIndex +"&pageSize="+dblistPageSize+"&categoryId="+dbListcategoryId+"&posterType=<%=posterType%>";
	   getAJAXData(ajaxurl,myMLListCallBack);
	   if(cruntdblistFocusPageIndex == dblistPageIndex)
	 {
	   $("flage_"+cruntDBListFocus).style.display = "block";
	 }
	 else
	 {
		 $("flage_"+cruntDBListFocus).style.display = "none";
	 }
   }else{
      if(action==1){ dblistPageIndex=dbListpageCount; }else{ dblistPageIndex=1; } 
   }
   if(1==dblistPageIndex){ajaxlistflag = false;}
}

function goBack(){
	if(4==area){ hideSubNumDiv(); return ;}
	 var url="index.jsp";
	 window.location.href=url ;
	}
	
function loadIframe(){
	if(loadIframeTimer){clearTimeout(loadIframeTimer);}
	if(0==dbListpageCount){return;}
	if(vodDiscription==""||vodDiscription==undefined)
	{
		vodDiscription="暂无简介";
	    $("infortext").innerText = vodDiscription;
	}
	else
	{
		if(vodDiscription.length>40)
		{
		     $("infortext").innerText = vodDiscription.substr(0,40)+"...";
		}
		else
		{
			 $("infortext").innerText = vodDiscription;
		}
	}
	playPage.location.href = "<%=static_en%>/player/vodSmallplay.jsp?progId="+dbLisVodId+"&_height=387&_width=685&_left=548&_top=268";
	voiceTimer = setTimeout("isMute()",800);
}

function gotopaly(num)
{
	$("flage_"+cruntDBListFocus).style.display = "none";
	flage = num;
	cruntDBListFocus = num;
	cruntdblistFocusPageIndex = dblistPageIndex;
	pressListOKFlage = 1;
	if(pressListOKFlage ==1)
	{
	   FanyeQianFlage = 0;
	   dbLisVodId = vodList[flage].dsubvodidlist[0];
	   vodDiscription = vodList[flage].ddescription;
	}
	if(0==dbListpageCount){return;}
	if(vodDiscription==""||vodDiscription==undefined)
	{
		vodDiscription="暂无简介";
	    $("infortext").innerText = vodDiscription;
	}
	else
	{
		if(vodDiscription.length>40)
		{
		     $("infortext").innerText = vodDiscription.substr(0,40)+"...";
		}
		else
		{
			 $("infortext").innerText = vodDiscription;
		}
	}
	if(cruntdblistFocusPageIndex == dblistPageIndex)
	 {
	   $("flage_"+cruntDBListFocus).style.display = "block";
	 }
	 else
	 {
		 $("flage_"+cruntDBListFocus).style.display = "none";
	 }
	playPage.location.href = "<%=static_en%>/player/vodSmallplay.jsp?progId="+dbLisVodId+"&_height=387&_width=685&_left=548&_top=268";
}
function setAre(num)
{
	area=num;
}

function showFullName(num){
	 setAre(2);
	 if(0==dbListpageCount){return;}
	 $("vod_"+num).innerHTML = ((vodList[num].dname).length)>15?("<marquee>"+vodList[num].dname+"</marquee>"):(vodList[num].dname);
}
function showCutName(num){
	if(0==dbListpageCount){return;}
	 $("vod_"+num).innerHTML = ((vodList[num].dname).length)>15?(vodList[num].dname).substr(0,15):vodList[num].dname;
}

function vofulldpaly()
{
	if(0==dbListpageCount){return;}
	if(pressListOKFlage ==0)
	{
	   SubLen = FanyeQianIDList.length;
	}
	else
	{
		SubLen = vodList[flage].dsubvodidlist.length;
	}
	//SubLen=7;
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
	   dbLisVodId = FanyeQianIDList[subPos];
	}
	else
	{
		dbLisVodId = vodList[flage].dsubvodidlist[subPos];
	}
	backUrl = "<%=static_en%>/page/hd-arena.jsp?area=3&cruntId="+cruntId+"&cruntfocusPageIndex="+cruntfocusPageIndex+"&pageIndex="+pageIndex+"&flage="+flage+"&dblistPageIndex="+dblistPageIndex+"&dbListcategoryId="+dbListcategoryId+"&cruntdblistFocusPageIndex="+cruntdblistFocusPageIndex+"&cruntDBListFocus="+cruntDBListFocus+"&pressOKFlage="+pressOKFlage+"&categoryIDIndex="+categoryIDIndex+"&dbLisVodId="+dbLisVodId+"&pressListOKFlage="+pressListOKFlage+"&vodDiscription="+vodDiscription+"&FanyeQianIDList="+FanyeQianIDList;
	addURLtoCookie("vodPlay",backUrl);
	location.href = "<%=static_en%>/player/au_PlayFilm.jsp?PROGID="+dbLisVodId+"&FATHERSERIESID="+fatherId+"&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=0&BEGINTIME=0&ENDTIME=200000";
}
function showSubNumDiv(){
	area = 4;//焦点转移到弹出选集层
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
}
function hideSubNumDiv(){
	area = 3; //焦点回到视频窗口区域
	$("subNumDiv").style.display = "none";
	$("vofulldpaly").focus();
}

var left_right_timer = "";
var up_down_timer = "";
function chooseSubNum(num){
	left_right_timer = setTimeout("chooseSub_Num("+num+")",5);
}

function chooseUpAndDown(num){
	up_down_timer = setTimeout("chooseUp_Down("+num+")",5);
}

function chooseSub_Num(num){
	if(left_right_timer){clearTimeout(left_right_timer)};
	subPos = subPos + num;
	if(subPos>SubLen-1){subPos = 0;}
	else if(subPos<0){subPos = SubLen-1;}
	$("select_"+subPos).focus();
	area=4;
}

function chooseUp_Down(num){
	if(up_down_timer){clearTimeout(up_down_timer)};
	subPos = subPos + num;
	if(subPos>SubLen-1){subPos = 0;}
	else if(subPos<0){subPos = SubLen-1;}
	$("select_"+subPos).focus();
	area=4;
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
			if(area==1)
			{
			   pressOKFlage = 0;
			   pageCategoryAction(-1);
			}
			else if(area==2)
			{
				//翻页没有按OK
				//FanyeQianFlage=1;
//				pressListOKFlage = 0;
				pageAction(-1);
			}
			break;
		case 34://page_down
			if(area==1)
			{
				//翻页没有按OK
			  FanyeQianFlage=1;
			   pressOKFlage = 0;
			   pageCategoryAction( 1 );
			}
			else if(area==2)
			{
				//pressListOKFlage = 0;
				pageAction(1);
			}
			break;
		case 37://left
		if( 4 == area&&subisok==1)
		{
			chooseSubNum(-1);
		}
			break;
		case 39://right
		if( 4 == area&&subisok==1)
		{
			chooseSubNum(1);
		}
			break;
		case 38://up
		if( 4 == area&&subisok==1)
		{
			chooseUpAndDown(-4);
		}
			break;
		case 40://down
		if( 4 == area&&subisok==1)
		{
			chooseUpAndDown(4);
		}
			break;
		case 13://ok
			if( 4 == area&&subisok==1)
			{
				pkPlay();
			}
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
<div id="bottomframe" style="position:absolute; left:566px; top:570px; width:600px; height:80px; z-index:3"></div>
<div style="position:absolute; left:1163px; top:284px; width:54px; height:66px; z-index:4;"><img id="voice" src="<%=static_url%>/images/dot.gif"/></div>
</body>
</html>
