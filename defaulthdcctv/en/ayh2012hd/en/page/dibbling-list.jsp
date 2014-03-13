<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head><%@ include file="../common/golbal.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>深圳奥运专题高清3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../static/css/style.css" />
<script type="text/javascript" src="<%=static_url%>/js/common.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/cookie.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/ajax_common.js"></script>
<style type="text/css">
<!--
body{ background:transparent url(../static/images/bg-gold-medal.gif) no-repeat;}
-->
</style>
</head>
<body onload="onPageLoad();">
<%@ include file="../datasource/datasource.jsp"%>
<%@ include file="../datasource/property.jsp"%>
<% 
   DataSource dataSource=new DataSource(request); 
   
   int pos=dataSource.huaWeiUtil.getInt(request.getParameter("pos"),0);
   int area=dataSource.huaWeiUtil.getInt(request.getParameter("area"),2);
   int pageSize=9;
   String posterType = "0";
   String categoryId = saishidianbo;
   String dbListcategoryId=dataSource.huaWeiUtil.getString(request.getParameter("dbListcategoryId"));
   String postertype = "5";
   
   int dblistPageIndex = dataSource.huaWeiUtil.getInt(request.getParameter("dblistPageIndex"),1);
   int categoryIDIndex = dataSource.huaWeiUtil.getInt(request.getParameter("categoryIDIndex"),0);
   int dbListpageCount=dataSource.huaWeiUtil.getInt(request.getParameter("dibblistpageCount"),0);
   int dibblistCatePageIndex=dataSource.huaWeiUtil.getInt(request.getParameter("dibblistCatePageIndex"),1);
   int cruntfocusPageIndex = dataSource.huaWeiUtil.getInt(request.getParameter("cruntfocusPageIndex"),dibblistCatePageIndex);
   int flage =dataSource.huaWeiUtil.getInt(request.getParameter("flage"),0);
   int cruntId = dataSource.huaWeiUtil.getInt(request.getParameter("cruntId"),categoryIDIndex);
   
   int pressOKFlage = dataSource.huaWeiUtil.getInt(request.getParameter("pressOKFlage"),0);
   int cruntDBListFocus = dataSource.huaWeiUtil.getInt(request.getParameter("cruntDBListFocus"),0);
   int cruntdblistFocusPageIndex = dataSource.huaWeiUtil.getInt(request.getParameter("cruntdblistFocusPageIndex"),dblistPageIndex);
   int dblistPageSize = 10;
   int pressListOKFlage= dataSource.huaWeiUtil.getInt(request.getParameter("pressListOKFlage"),0);
   String dbLisVodId=dataSource.huaWeiUtil.getString(request.getParameter("dbLisVodId"));
   String vodDiscription= dataSource.huaWeiUtil.getString(request.getParameter("vodDiscription"));
   String fanyeQianIDList = dataSource.huaWeiUtil.getString(request.getParameter("FanyeQianIDList"));
//   EpgResult epgResult=dataSource.getVodInfos(dblistPageIndex,dblistPageSize,dbListcategoryId,postertype);
//   List vods=new ArrayList();
//   if(epgResult!=null&&epgResult.getResultcode()==0&&epgResult.getDatas()!=null){
//	   vods=(List)epgResult.getDatas();
//	   pageCount=epgResult.getPageCount();
//   }
   
   /*
   EpgResult epgResult=dataSource.getCategorys(pageIndex,pageSize,categoryId,posterType);
   List categorys=new ArrayList();
   if(epgResult!=null&&epgResult.getResultcode()==0&&epgResult.getDatas()!=null){
	   categorys=(List)epgResult.getDatas();
	   pageCount=epgResult.getPageCount();
   } */
%>
<div class="wrapper">
<%String currentPageId = "_1004"; %>
<%@ include file="../common/head.jsp" %>
<!--the end-->



<!--list-->
<div class="leftcol04"> 
	<!--sub-->
	<div class="leftcol-sub"> <!--item-focus为焦点--> 
		<div class="item"  id="div_cate_0">
			<div class="link"><a href="#" id="cate_a_0" onclick="getDBList(0)"  onfocus="setAre(1)"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="cate_0"></div>
		</div>
		<div class="item " id="div_cate_1" style="top:61px;"> 
			<div class="link"><a href="#" id="cate_a_1" onclick="getDBList(1)" onfocus="setAre(1)"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="cate_1"></div>
		</div>
		<div class="item" id="div_cate_2" style="top:112px;">
			<div class="link"><a href="#" id="cate_a_2" onclick="getDBList(2)" onfocus="setAre(1)"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="cate_2"></div>
		</div>
		<div class="item" id="div_cate_3" style="top:163px;">
			<div class="link"><a href="#" id="cate_a_3" onclick="getDBList(3)" onfocus="setAre(1)"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="cate_3"></div>
		</div>
		<div class="item" id="div_cate_4" style="top:214px;">
			<div class="link"><a href="#" id="cate_a_4" onclick="getDBList(4)" onfocus="setAre(1)"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="cate_4"></div>
		</div>
		<div class="item" id="div_cate_5" style="top:265px;">
			<div class="link"><a href="#" id="cate_a_5" onclick="getDBList(5)" onfocus="setAre(1)"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="cate_5"></div>
		</div>
		<div class="item" id="div_cate_6" style="top:316px;">
			<div class="link"><a href="#" id="cate_a_6" onclick="getDBList(6)" onfocus="setAre(1)"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="cate_6"></div>
		</div>
		<div class="item" id="div_cate_7" style="top:367px;">
			<div class="link"><a href="#" id="cate_a_7" onclick="getDBList(7)" onfocus="setAre(1)"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="cate_7"></div>
		</div>
		<div class="item" id="div_cate_8" style="top:418px;">
			<div class="link"><a href="#" id="cate_a_8" onclick="getDBList(8)" onfocus="setAre(1)"><img src="../static/images/t.gif" /></a></div>
			<div class="txt" id="cate_8"></div>
		</div>
		<!--pages-->
		<div class="page"><span class="current" id="categoryPageNum"></span></div>
	</div>
	<!--sub end-->
		
	<!--list-->	
	<div class="dibbling-list">  <!--当前选中则显示<div class="icon"></div>-->
		<div class="item" id="div_vod_0">
			<div class="link"><a href="#" id="focus_0" onclick="gotopaly(0)" onfocus="showFullName(0)" onblur="showCutName(0)"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="vod_0" style="overflow:hidden"></div>
            <div class="icon" id="flage_0" style="display:none"></div>
		</div>
		<div class="item" id="div_vod_1" style="top:51px;">
			<div class="link"><a href="#" id="focus_1" onclick="gotopaly(1)" onfocus="showFullName(1)" onblur="showCutName(1)"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="vod_1" style="overflow:hidden"></div>
            <div class="icon" id="flage_1" style="display:none"></div>
		</div>
		<div class="item" id="div_vod_2" style="top:97px;">
			<div class="link"><a href="#" id="focus_2" onclick="gotopaly(2)" onfocus="showFullName(2)" onblur="showCutName(2)"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="vod_2" style="overflow:hidden"></div>
            <div class="icon" id="flage_2" style="display:none"></div>
		</div>
		<div class="item" id="div_vod_3" style="top:143px;">
			<div class="link"><a href="#" id="focus_3" onclick="gotopaly(3)" onfocus="showFullName(3)" onblur="showCutName(3)"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="vod_3" style="overflow:hidden"></div>
            <div class="icon" id="flage_3" style="display:none"></div>
		</div>
		<div class="item" id="div_vod_4" style="top:189px;">
			<div class="link"><a href="#" id="focus_4" onclick="gotopaly(4)" onfocus="showFullName(4)" onblur="showCutName(4)"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="vod_4" style="overflow:hidden"></div>
            <div class="icon" id="flage_4" style="display:none"></div>
		</div>
		<div class="item" id="div_vod_5" style="top:235px;">
			<div class="link"><a href="#" id="focus_5" onclick="gotopaly(5)" onfocus="showFullName(5)" onblur="showCutName(5)"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="vod_5" style="overflow:hidden"></div>
            <div class="icon" id="flage_5" style="display:none"></div>
		</div>
		<div class="item" id="div_vod_6" style="top:281px;">
			<div class="link"><a href="#" id="focus_6" onclick="gotopaly(6)" onfocus="showFullName(6)" onblur="showCutName(6)"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="vod_6" style="overflow:hidden"></div>
            <div class="icon" id="flage_6" style="display:none"></div>
		</div>
		<div class="item" id="div_vod_7" style="top:327px;">
			<div class="link"><a href="#" id="focus_7" onclick="gotopaly(7)" onfocus="showFullName(7)" onblur="showCutName(7)"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="vod_7" style="overflow:hidden"></div>
            <div class="icon" id="flage_7" style="display:none"></div>
		</div>
		<div class="item" id="div_vod_8" style="top:373px;">
			<div class="link"><a href="#" id="focus_8" onclick="gotopaly(8)" onfocus="showFullName(8)" onblur="showCutName(8)"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="vod_8" style="overflow:hidden"></div>
            <div class="icon" id="flage_8" style="display:none"></div>
		</div>
		<div class="item" id="div_vod_9" style="top:419px;">
			<div class="link"><a href="#" id="focus_9" onclick="gotopaly(9)" onfocus="showFullName(9)" onblur="showCutName(9)"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="vod_9" style="overflow:hidden"></div>
            <div class="icon" id="flage_9" style="display:none"></div>
		</div>
	</div>
	<!--pages-->
	<div class="pages page-sty04">
		<div class="item">
			<div class="pic"><a href="#" onclick="pageAction(-1)"><img src="../static/images/btn-prev.png" width="78" height="30" /></a></div>
		</div>
		<div class="item" style="left:87px;">
			<div class="pic"><a href="#" onclick="pageAction(1)"><img src="../static/images/btn-next.png" width="78" height="30" /></a></div>
		</div>
		<div class="pages-num"><span class="current" id="dblistPageNum"></span></div>
	</div>
	<!--list end-->	
	
</div>
<!--the end-->

<!--r-poster-->
<div class="hd-r-poster02">
	<div class="intro">
		<div class="txt" id="infortext"></div>
	</div>
	<div class="poster">
    	<div class="link" style="margin-left:0px"><a href="#" id="vofulldpaly" onclick="vofulldpaly()" onfocus="setAre(3)"><img width="572" height="430" src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="pic">
			<iframe id="playPage" name="playPage" border="0" frameSpacing="0" marginWidth="0" marginHeight="0" frameBorder="0" noResize scrolling="no" vspace="0" width="565" height="423" style="background:transparent;"></iframe>
		</div>
	</div>
</div>

<div class="full-screen">
	<div class="txt">全屏播放</div>
	<div class="pic"><img src="../static/images/icon-full-screen.png"></div>
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
var pageSize=<%=pageSize%>;
var dblistPageIndex = <%=dblistPageIndex%>;
var dblistPageSize = <%=dblistPageSize%>;
var dbListpageCount = <%=dbListpageCount%>;
var categoryIDIndex = <%=categoryIDIndex%>;
var dbListcategoryId="<%=dbListcategoryId%>";
var cruntId = <%=cruntId%>;
var cruntfocusPageIndex = <%=cruntfocusPageIndex%>;
var dibblistCatePageIndex = <%=dibblistCatePageIndex%>;

var cruntdblistFocusPageIndex = <%=cruntdblistFocusPageIndex%>;
var cruntDBListFocus = <%=cruntDBListFocus%>;
var pressOKFlage = <%=pressOKFlage%>;
var flage = <%=flage%>;
var pressListOKFlage = <%=pressListOKFlage%>;
var dbLisVodId= "<%=dbLisVodId%>";
var categoryList;
var vodDiscription = "<%=vodDiscription%>";
var jsonObj;
var vodList;
var vodIdList = new Array();
var backUrl = "dibbling.jsp";
var area = <%=area%>; 
var pos = <%=pos%> ;
var ajaxflag = false;
var ajaxlistflag = false;
var gotoPlayFlage = 0;
var subPos = 0;//子集
var FanyeQianIDList;
var FanyeQianDBList;
var fatherId = -1;
var SubLen = 0;
var FanyeQianFlage=0;
var loadIframeTimer ="";
var ajaxurl;
if(""!=("<%=fanyeQianIDList%>"))
{
	FanyeQianIDList = ("<%=fanyeQianIDList%>").split(",");
}

function $(id){
	return document.getElementById(id);
}
function onPageLoad(){
	 init();
	 initpos();
	 loadIframeTimer = setTimeout("loadIframe()",500);
	 if(cruntdblistFocusPageIndex == dblistPageIndex)
	 {
	   $("flage_"+cruntDBListFocus).style.display = "block";
	 }
	 else
	 {
		 $("flage_"+cruntDBListFocus).style.display = "none";
	 }
	 
	 if(cruntfocusPageIndex == dibblistCatePageIndex)
	 {
	   $("cate_"+cruntId).style.background = "../static/images/leftcol-subbg-on.png";
	 }
	 else
	 {
		 $("cate_"+cruntId).style.background = "../static/images/leftcol-subbg.png";
	 }
}
function initpos(){
   if(1==area){$("cate_a_"+pos).focus();}
	 else if(2==area){$("focus_"+pos).focus();}
	 else if(3==area){$("vofulldpaly").focus();}
}
function init()
{
	 ajaxurl="<%=static_en%>/ajaxdata/category_list_data.jsp?pageIndex="+dibblistCatePageIndex +"&pageSize="+pageSize+"&categoryId=<%=categoryId%>&posterType=<%=posterType%>";
	 getAJAXData(ajaxurl,myfirstCategoryCallBack);
	 gotoPlayFlage=0;
}
function  initVodList(){
	 //取视频列表
	 if(pressOKFlage==1)
	{
		dbListcategoryId = categoryList[categoryIDIndex].dcmsid;
	}
	ajaxurl="<%=static_en%>/ajaxdata/vod_list_data.jsp?pageIndex="+dblistPageIndex +"&pageSize="+dblistPageSize+"&categoryId="+dbListcategoryId+"&posterType=<%=posterType%>";
	getAJAXData(ajaxurl,myDBListCallBack);
}

function myfirstCategoryCallBack(respText)
{
	 jsonObj = eval('('+respText+')');
	 categoryList = jsonObj.jsoncategorylist;
	 pageCount=jsonObj.jsonpagecount;
	 var len=categoryList.length;
	 for(var i=len;i<pageSize;i++)
	 {
	 	$("cate_"+i).innerText = "";
		$("cate_a_"+i).style.display = "none";
		$("div_cate_"+i).style.display = "none";
	 }
	 for(var i=0;i<len;i++)
	 {
	  	$("cate_"+i).innerText = categoryList[i].dname;
		$("cate_a_"+i).style.display = "block";
		$("div_cate_"+i).style.display = "block";
	 }
	 $("categoryPageNum").innerText = ((pageCount == 0)?0:dibblistCatePageIndex) + "/" + pageCount;
	 
	 //取视频列表
	 initVodList();
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
		$("cate_a_"+i).style.display = "none";
		$("div_cate_"+i).style.display = "none";
	 }
	 if(len<pageSize)
	 {
	 	$("cate_a_"+(len-1)).focus();
	 }
	 for(var i=0;i<len;i++)
	 {
	  	$("cate_"+i).innerText = categoryList[i].dname;
		$("cate_a_"+i).style.display = "block";
		$("div_cate_"+i).style.display = "block";
	 }
	 $("categoryPageNum").innerText = ((pageCount == 0)?0:dibblistCatePageIndex)  + "/" + pageCount;
}

function pageCategoryAction(action)
{
    ajaxflag = true ;
   if(action==1){ dibblistCatePageIndex=dibblistCatePageIndex+1; }else{ dibblistCatePageIndex=dibblistCatePageIndex-1; } 
   if((dibblistCatePageIndex>0)&&(dibblistCatePageIndex<=pageCount)){
       ajaxurl="<%=static_en%>/ajaxdata/category_list_data.jsp?pageIndex="+dibblistCatePageIndex +"&pageSize="+pageSize+"&categoryId=<%=categoryId%>&posterType=<%=posterType%>";
	   getAJAXData(ajaxurl,myCategoryCallBack);
	   if(cruntfocusPageIndex == dibblistCatePageIndex)
		 {
		   $("cate_"+cruntId).style.background = "../static/images/leftcol-subbg-on.png";
		 }
		 else
		 {
			 $("cate_"+cruntId).style.background = "../static/images/leftcol-subbg.png";
		 }
   }else{
      if(action==1){ dibblistCatePageIndex=pageCount; }else{ dibblistCatePageIndex=1; } 
   }
   if(1==dibblistCatePageIndex){ajaxflag = false;}
}

function getDBList(num)
{
	gotoPlayFlage=2;
	dblistPageIndex=1;
	categoryIDIndex = num%9;
	pressOKFlage = 1;
	$("cate_"+cruntId).style.background = "../static/images/leftcol-subbg.png";
	cruntId = num;
	cruntfocusPageIndex = dibblistCatePageIndex;
	if(cruntfocusPageIndex == dibblistCatePageIndex)
	{
	  $("cate_"+cruntId).style.background = "../static/images/leftcol-subbg-on.png";
	}
	else
	{
	  $("cate_"+cruntId).style.background = "../static/images/leftcol-subbg.png";
	}
	dbListcategoryId = categoryList[num].dcmsid;
	ajaxurl="<%=static_en%>/ajaxdata/vod_list_data.jsp?pageIndex="+dblistPageIndex +"&pageSize="+dblistPageSize+"&categoryId="+dbListcategoryId+"&posterType=<%=posterType%>";
	getAJAXData(ajaxurl,myDBListCallBack);

}
function myDBListCallBack(respText)
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
	 $("dblistPageNum").innerText = ((dbListpageCount == 0)?0:dblistPageIndex)  + "/" + dbListpageCount;
	 if(len==0)
	 { 
		  for(var i=len;i<dblistPageSize;i++)
		 {
			$("div_vod_"+i).style.display = "none";
		 }
		  var nodiscreption = "暂无简介";
		 var noComment = "暂无内容";
		 $("vod_0").innerText = noComment;
		 $("infortext").innerText = nodiscreption;
	 }
	 if(len>0)
	 {
		 for(var i=len;i<dblistPageSize;i++)
		 {
			//$("vod_"+i).innerText = "";
			$("div_vod_"+i).style.display = "none";
		 }
		 if(len<dblistPageSize&&dblistPageIndex>1)
		 {
			$("focus_"+(len-1)).focus();
		 } 
		 for(var i=0;i<len;i++)
		 {
			$("vod_"+i).innerText = vodList[i].dname.substr(0,15);
			$("div_vod_"+i).style.display = "block";
		 }
	 }
	if(gotoPlayFlage==2)
	{ 
		gotopaly(0);
	   //loadFirstPlay(0);
	}
	if(pressListOKFlage ==1||dbLisVodId==""||dbLisVodId==undefined)
	 {
	   dbLisVodId = vodList[flage].dsubvodidlist[subPos];
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
	ajaxlistflag = true ;
	gotoPlayFlage =1;
   if(action==1){ dblistPageIndex=dblistPageIndex+1; }else{ dblistPageIndex=dblistPageIndex-1; }
   if((dblistPageIndex>0)&&(dblistPageIndex<=dbListpageCount)){
      ajaxurl="<%=static_en%>/ajaxdata/vod_list_data.jsp?pageIndex="+dblistPageIndex +"&pageSize="+dblistPageSize+"&categoryId="+dbListcategoryId+"&posterType=<%=posterType%>";
	   getAJAXData(ajaxurl,myDBListCallBack);
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
   if(4==area){hideSubNumDiv();return ;}
   backUrl = getURLtoCookie("dibbling-list");
   backUrl = (backUrl!="")?backUrl:"dibbling.jsp";
   location.href=backUrl ;
}
function loadIframe(){
	if(loadIframeTimer){clearTimeout(loadIframeTimer);}
	if(0==dbListpageCount){return;}
	if(vodDiscription==""||vodDiscription==undefined)
	{
		vodDiscription = "暂无简介";
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
	playPage.location.href = "<%=static_en%>/player/vodSmallplay.jsp?progId="+dbLisVodId+"&_height=423&_width=565&_left=668&_top=230";
	voiceTimer = setTimeout("isMute()",800);
}

function loadFirstPlay(num)
{
	if(0==dbListpageCount){return;}
	dbLisVodId = vodList[0].dsubvodidlist[0];
	vodDiscription = vodList[0].ddescription;
	playPage.location.href = "<%=static_en%>/player/vodSmallplay.jsp?progId="+dbLisVodId+"&_height=423&_width=565&_left=668&_top=230";

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
	//dbListcategoryId = vodList[flage].dsubvodidlist[0];
	if(vodDiscription==""||vodDiscription==undefined)
	{
		vodDiscription = "暂无简介";
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
	playPage.location.href = "<%=static_en%>/player/vodSmallplay.jsp?progId="+dbLisVodId+"&_height=423&_width=565&_left=668&_top=230";
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
	backUrl = "<%=static_en%>/page/dibbling-list.jsp?area=3&pageIndex="+pageIndex+"&pageCount="+pageCount+"&dbListcategoryId="+dbListcategoryId+"&dblistPageIndex="+dblistPageIndex+"&categoryIDIndex="+categoryIDIndex+"&dbListpageCount="+dbListpageCount+"&flage="+flage+"&dibblistCatePageIndex="+dibblistCatePageIndex+"&cruntId="+cruntId+"&cruntfocusPageIndex="+cruntfocusPageIndex+"&cruntdblistFocusPageIndex="+cruntdblistFocusPageIndex+"&cruntDBListFocus="+cruntDBListFocus+"&pressOKFlage="+pressOKFlage+"&dbLisVodId="+dbLisVodId+"&pressListOKFlage="+pressListOKFlage+"&vodDiscription="+vodDiscription+"&FanyeQianIDList="+FanyeQianIDList;
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
var subisok = 0;
function chooseSubNum(num){
	left_right_timer = setTimeout("chooseSub_Num("+num+")",5);
}

function chooseUpAndDown(num){
	up_down_timer = setTimeout("chooseUp_Down("+num+")",5);
}

function chooseSub_Num(num){
	if(left_right_timer){clearTimeout(left_right_timer)}
	subPos = subPos + num;
	if(subPos>SubLen-1){subPos = 0;}
	else if(subPos<0){subPos = SubLen-1;}
	$("select_"+subPos).focus();
	area=4;
}

function chooseUp_Down(num){
	if(up_down_timer){clearTimeout(up_down_timer)}
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
				pressListOKFlage = 0;
				//翻页没有按OK
				FanyeQianFlage=1;
				pageAction(-1);
			}
			break;
		case 34://page_down
			if(area==1)
			{
			   pressOKFlage = 0;
			   pageCategoryAction( 1 );
			}
			else if(area==2)
			{
				pressListOKFlage = 0;
				//翻页没有按OK
				FanyeQianFlage=1;
				pageAction(1);
			}
			break;
		case 37://left
		if(area==4&&1 == subisok)
		{
			chooseSubNum(-1);
		}
			break;
		case 39://right
		if(area==4&&1 == subisok)
		{
			chooseSubNum(1);
		}
			break;
		case 38://up
		if(area==4&&1 == subisok)
		{
			chooseUpAndDown(-4);
		}
			break;
		case 40://down
		if(area==4&&1 == subisok)
		{
			chooseUpAndDown(4);
		}
			break;
		case 13://ok
			if( 4 == area && 1 == subisok)
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
<div id="bottomframe" style="position:absolute; left:711px; top:570px; width:600px; height:80px; z-index:3"></div>
<div style="position:absolute; left:1163px; top:244px; width:54px; height:66px; z-index:4;"><img id="voice" src="<%=static_url%>/images/dot.gif"/></div>
</body>
</html>
