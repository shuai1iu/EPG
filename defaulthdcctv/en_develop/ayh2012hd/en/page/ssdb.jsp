<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head><%@ include file="../common/golbal.jsp" %>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<meta name="page-view-size" content="1280*720"/>
<title>赛事点播 - EPG</title>
<link rel="stylesheet" type="text/css" href="<%=static_url%>/css/style.css" />
<script type="text/javascript" src="<%=static_url%>/js/common.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/cookie.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/ajax_common.js"></script>
<style type="text/css">
body {
background: #1c1949 url("<%=static_url%>/images/bg-page-1.jpg") no-repeat;
}
</style>
</head>
<body onload="onPageLoad();">
<%@ include file="../datasource/datasource.jsp"%>
<%@ include file="../datasource/property.jsp"%>
<% 
   DataSource dataSource=new DataSource(request); 
   
   int pageIndex=dataSource.huaWeiUtil.getInt(request.getParameter("pageIndex"),1);
   int pos=dataSource.huaWeiUtil.getInt(request.getParameter("pos"),0);
   int pageSize=15;
   int pageCount=0;
   
   String posterType = "0";
   String categoryId = saishidianbo;
   
   /*
   EpgResult epgResult=dataSource.getCategorys(pageIndex,pageSize,categoryId,posterType);
   List categorys=new ArrayList();
   if(epgResult!=null&&epgResult.getResultcode()==0&&epgResult.getDatas()!=null){
	   categorys=(List)epgResult.getDatas();
	   pageCount=epgResult.getPageCount();
   } */
%>
<div class="wrapper">
<%String currentPageId = "_1003"; %>
<%@ include file="../common/head.jsp" %>

    <!-- S 主内容 -->

    <!-- S 分页按钮 -->
    <div class="paging">
        <div class="btn btn-prev" style="left:21px; top:112px;"><a href="#" onclick="pageAction( -1 )"><img src="<%=static_url%>/images/t.gif" /></a></div>
        <div class="btn btn-next" style="left:108px; top:112px;"><a href="#" onclick="pageAction( 1 )"><img src="<%=static_url%>/images/t.gif" /></a></div>
        <div class="paging-num" style="left:510px; top:120px;"><span class="current" id="page"></span></div>
    </div>
    <!-- E 分页按钮 -->

    <div class="gallaryBox">
 
 		 <!-- 第一排 -->
        <div class="item" style="left:20px;top:153px;">
            <div class="link"><a href="#" id="cate_a_0" onclick="goXmdb(0)"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic"><img src="#" id="cate_img_0"/></div>
            <!--
            默认 pic-100x100-2.jpg         className = item
            经过 pic-100x100-2_focus.jpg   className = item item_focus
            其余亦同
            -->
            <div class="txt-wrap"><div class="txt" id="cate_0"></div></div>
        </div>
        <div class="item" style="left:142px;top:153px;">
            <div class="link"><a href="#" id="cate_a_1" onclick="goXmdb(1)"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic"><img src="#" id="cate_img_1"/></div>
            <div class="txt-wrap"><div class="txt" id="cate_1"></div></div>
        </div>
        <div class="item" style="left:264px;top:153px;">
           <div class="link"><a href="#" id="cate_a_2" onclick="goXmdb(2)"><img src="<%=static_url%>/images/t.gif" /></a></div>
           <div class="pic"><img src="#" id="cate_img_2"/></div>
           <div class="txt-wrap"><div class="txt" id="cate_2"></div></div>
        </div>
        <div class="item" style="left:386px;top:153px;">
            <div class="link"><a href="#" id="cate_a_3" onclick="goXmdb(3)"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic"><img src="#" id="cate_img_3"/></div>
            <div class="txt-wrap"><div class="txt" id="cate_3"></div></div>
        </div>
        <div class="item" style="left:508px;top:153px;">
            <div class="link"><a href="#" id="cate_a_4" onclick="goXmdb(4)"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic"><img src="#" id="cate_img_4"/></div>
            <div class="txt-wrap"><div class="txt" id="cate_4"></div></div>
        </div>

        <!-- 第二排 -->
        <div class="item" style="left:20px;top:275px;">
            <div class="link"><a href="#" id="cate_a_5" onclick="goXmdb(5)"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic"><img src="#" id="cate_img_5"/></div>
            <div class="txt-wrap"><div class="txt" id="cate_5"></div></div>
        </div>
        <div class="item" style="left:142px;top:275px;">
            <div class="link"><a href="#" id="cate_a_6" onclick="goXmdb(6)"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic"><img src="#" id="cate_img_6"/></div>
            <div class="txt-wrap"><div class="txt" id="cate_6"></div></div>
        </div>
        <div class="item" style="left:264px;top:275px;">
            <div class="link"><a href="#" id="cate_a_7" onclick="goXmdb(7)"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic"><img src="#" id="cate_img_7"/></div>
            <div class="txt-wrap"><div class="txt" id="cate_7"></div></div>
        </div>
        <div class="item" style="left:386px;top:275px;">
            <div class="link"><a href="#" id="cate_a_8" onclick="goXmdb(8)"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic"><img src="#" id="cate_img_8"/></div>
            <div class="txt-wrap"><div class="txt" id="cate_8"></div></div>
        </div>
        <div class="item" style="left:508px;top:275px;">
            <div class="link"><a href="#" id="cate_a_9" onclick="goXmdb(9)"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic"><img src="#" id="cate_img_9"/></div>
            <div class="txt-wrap"><div class="txt" id="cate_9"></div></div>
        </div>

        <!-- 第三排 -->
        <div class="item" style="left:20px;top:397px;">
            <div class="link"><a href="#" id="cate_a_10" onclick="goXmdb(10)"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic"><img src="#" id="cate_img_10"/></div>
            <div class="txt-wrap"><div class="txt" id="cate_10"></div></div>
        </div>
        <div class="item" style="left:142px;top:397px;">
            <div class="link"><a href="#" id="cate_a_11" onclick="goXmdb(11)"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic"><img src="#" id="cate_img_11"/></div>
            <div class="txt-wrap"><div class="txt" id="cate_11"></div></div>
        </div>
        <div class="item" style="left:264px;top:397px;">
            <div class="link"><a href="#" id="cate_a_12" onclick="goXmdb(12)"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic"><img src="#" id="cate_img_12"/></div>
            <div class="txt-wrap"><div class="txt" id="cate_12"></div></div>
        </div>
        <div class="item" style="left:386px;top:397px;">
            <div class="link"><a href="#" id="cate_a_13" onclick="goXmdb(13)"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic"><img src="#" id="cate_img_13"/></div>
            <div class="txt-wrap"><div class="txt" id="cate_13"></div></div>
        </div>
        <div class="item" style="left:508px;top:397px;">
            <div class="link"><a href="#" id="cate_a_14" onclick="goXmdb(14)"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic"><img src="#" id="cate_img_14"/></div>
            <div class="txt-wrap"><div class="txt" id="cate_14"></div></div>
        </div>
 
    </div>
    <!-- E 主内容 -->
</div>
<script type="text/javascript">
var pageCount = 1;
var pageIndex = <%=pageIndex%>;
var pageSize = <%=pageSize%>;
var pos = <%=pos%> ;
var backUrl = "index.jsp";
var jsonObj;
var categoryList;

var $$ = {};
function $(id){
	if(!$$[id]){
	   $$[id] = document.getElementById(id);
	}
	return $$[id];
}
function onPageLoad(){
	 init();
}

function init()
{
	 ajaxurl="<%=static_en%>/ajaxdata/category_list_data.jsp?pageIndex="+pageIndex +"&pageSize="+pageSize+"&categoryId=<%=categoryId%>&posterType=<%=posterType%>";
	 getAJAXData(ajaxurl,myCallBack); $("cate_a_"+pos).focus();
}

function mycheck()
{
	if(pageIndex == pageCount){}
}  

var ajaxurl = "";
function pageAction(action ){ 
   if(action==1){ pageIndex=pageIndex+1; }else{ pageIndex=pageIndex-1; } 
   if((pageIndex>0)&&(pageIndex<=pageCount)){
	   init();
   }else{
      if(action==1){ pageIndex=pageCount; }else{ pageIndex=1; } 
   }
}
function myCallBack(respText)
{
	 jsonObj = eval('('+respText+')');
	 categoryList = jsonObj.jsoncategorylist;
	 pageCount=jsonObj.jsonpagecount;
	 var len=categoryList.length;
	 for(var i=0;i<len;i++)
	 {
	  	$("cate_"+i).innerText = categoryList[i].dname;
		$("cate_img_"+i).src = categoryList[i].picpath;
	 }
	 $("page").innerText = pageIndex + "/" + pageCount;
	 for(var i=len;i<pageSize;i++)
	 {
	 	$("cate_"+i).innerText = "";
		$("cate_img_"+i).src = "#";
	 }
}
function goXmdb(num){
	var categoryId = categoryList[num].dcmsid;
	if(categoryId!=null && categoryId!="" && categoryId!="undefined" && categoryId!=undefined){
		var xmdbUrl="<%=static_en%>/page/xmdb.jsp?categoryId="+categoryId;
		backUrl = "ssdb.jsp?pos="+num+"&pageIndex="+pageIndex;
		addURLtoCookie("xmdb",backUrl);
		location.href = xmdbUrl;
	}
}

function goBack(){
	 var url = "index.jsp";
	 window.location.href = url ;
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
		 pageAction(-1 );
			break;
		case 34://page_down
		 pageAction( 1 );
			break;
		case 8:
			goBack();
			break;
	} 
}
</script>

</body>
</html>