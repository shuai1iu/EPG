<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="net.sf.json.JSONArray" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head><%@ include file="../common/golbal.jsp" %>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<meta name="page-view-size" content="640*530"/>
<title>名栏 - EPG</title>
<link rel="stylesheet" type="text/css" href="<%=static_url%>/css/style.css" />
<script type="text/javascript" src="<%=static_url%>/js/cookie.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/common.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/commonevent.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/ajax_common.js"></script>
</head>
<body onload="onPageLoad();" background="#" bgcolor="#000000">
<div style="position:absolute;z-index:-1;">
	<img style="width:640px;height:530px;" src="<%=static_url%>/images/bg-page-1.jpg" />
</div>
<%@ include file="../datasource/datasource.jsp"%>
<%@ include file="../datasource/property.jsp"%>
<% 
   DataSource dataSource=new DataSource(request); 
   String posterType="0";
   int pos=dataSource.huaWeiUtil.getInt(request.getParameter("pos"),0);
   int area=dataSource.huaWeiUtil.getInt(request.getParameter("area"),0);
   int pageIndex=dataSource.huaWeiUtil.getInt(request.getParameter("pageIndex"),1);
   int pageSize = 15;
   int pageCount=0;
   String categoryId=dataSource.huaWeiUtil.getString(request.getParameter("categoryId"));
   if("".equals(categoryId)){
   		categoryId = aoyunminglan;
   }
   /*
   PkitEpgResult epgResult=dataSource.getCategorys(pageIndex,pageSize,categoryId,posterType);
   List categorys=new ArrayList();
   if(epgResult!=null&&epgResult.getResultcode()==0&&epgResult.getDatas()!=null){
	   categorys = (List)epgResult.getDatas();
	   pageCount = epgResult.getPageCount();
   }*/
%>

<div class="wrapper">

<%String currentPageId = "_1004"; %>
<%@ include file="../common/head.jsp" %>
    <!-- E 导航 -->

    <!-- S 主内容 -->
    <div class="gallaryBox">     
      
       <!-- 第一排 -->
        <div class="item" id="div_item_0" style="left:20px;top:121px;">
            <div class="link" style="z-index:7;"><a href="#" onfocus="showFullName(0)" onblur="showCutName(0)" onclick="goXmdb(0)" id="cate_a_0"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic" style="z-index:8;" id="div_pic_0"><img src="#" id="cate_img_0" /></div>
            <div class="txt-wrap" style="z-index:9;" id="div_txt_wrap_0"><div class="txt" id="cate_0"></div></div>
        </div>
        <div class="item" id="div_item_1" style="left:142px;top:121px;">
            <div class="link" style="z-index:7;"><a href="#" onfocus="showFullName(1)" onblur="showCutName(1)" onclick="goXmdb(1)" id="cate_a_1">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic" style="z-index:8;" id="div_pic_1"><img src="#" id="cate_img_1" /></div>
            <div class="txt-wrap" style="z-index:9;" id="div_txt_wrap_1"><div class="txt" id="cate_1"></div></div>
        </div>
        <div class="item" id="div_item_2" style="left:264px;top:121px;">
            <div class="link" style="z-index:7;"><a href="#" onfocus="showFullName(2)" onblur="showCutName(2)" onclick="goXmdb(2)" id="cate_a_2">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic" style="z-index:8;" id="div_pic_2"><img src="#" id="cate_img_2" /></div>
            <div class="txt-wrap" style="z-index:9;" id="div_txt_wrap_2"><div class="txt" id="cate_2"></div></div>
        </div>
        <div class="item" id="div_item_3" style="left:386px;top:121px;">
            <div class="link" style="z-index:7;"><a href="#" onfocus="showFullName(3)" onblur="showCutName(3)" onclick="goXmdb(3)" id="cate_a_3">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic" style="z-index:8;" id="div_pic_3"><img src="#" id="cate_img_3" /></div>
            <div class="txt-wrap" style="z-index:9;" id="div_txt_wrap_3"><div class="txt" id="cate_3"></div></div>
        </div>
        <div class="item" id="div_item_4" style="left:508px;top:121px;">
            <div class="link" style="z-index:7;"><a href="#" onfocus="showFullName(4)" onblur="showCutName(4)" onclick="goXmdb(4)" id="cate_a_4">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic" style="z-index:8;" id="div_pic_4"><img  src="#" id="cate_img_4" /></div>
            <div class="txt-wrap" style="z-index:9;" id="div_txt_wrap_4"><div class="txt" id="cate_4"></div></div>
        </div>

        <!-- 第二排 -->
        <div class="item" id="div_item_5" style="left:20px;top:243px;">
            <div class="link" style="z-index:7;"><a href="#" onfocus="showFullName(5)" onblur="showCutName(5)" onclick="goXmdb(5)" id="cate_a_5">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic" style="z-index:8;" id="div_pic_5"><img  src="#" id="cate_img_5" /></div>
            <div class="txt-wrap" style="z-index:9;" id="div_txt_wrap_5"><div class="txt" id="cate_5"></div></div>
        </div>
        <div class="item" id="div_item_6" style="left:142px;top:243px;">
            <div class="link" style="z-index:7;"><a href="#" onfocus="showFullName(6)" onblur="showCutName(6)" onclick="goXmdb(6)" id="cate_a_6">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic" style="z-index:8;" id="div_pic_6"><img  src="#" id="cate_img_6" /></div>
            <div class="txt-wrap" style="z-index:9;" id="div_txt_wrap_6"><div class="txt" id="cate_6"></div></div>
        </div>
        <div class="item" id="div_item_7" style="left:264px;top:243px;">
           <div class="link" style="z-index:7;"><a href="#" onfocus="showFullName(7)" onblur="showCutName(7)" onclick="goXmdb(7)" id="cate_a_7">
           <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic" style="z-index:8;" id="div_pic_7"><img  src="#" id="cate_img_7" /></div>
            <div class="txt-wrap" style="z-index:9;" id="div_txt_wrap_7"><div class="txt" id="cate_7"></div></div>
        </div>
        <div class="item" id="div_item_8" style="left:386px;top:243px;">
            <div class="link" style="z-index:7;"><a href="#" onfocus="showFullName(8)" onblur="showCutName(8)" onclick="goXmdb(8)" id="cate_a_8">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic" style="z-index:8;" id="div_pic_8"><img  src="#" id="cate_img_8" /></div>
            <div class="txt-wrap" style="z-index:9;" id="div_txt_wrap_8"><div class="txt" id="cate_8"></div></div>
        </div>
        <div class="item" id="div_item_9" style="left:508px;top:243px;">
            <div class="link" style="z-index:7;"><a href="#" onfocus="showFullName(9)" onblur="showCutName(9)" onclick="goXmdb(9)" id="cate_a_9">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic" style="z-index:8;" id="div_pic_9"><img  src="#" id="cate_img_9" /></div>
            <div class="txt-wrap" style="z-index:9;" id="div_txt_wrap_9"><div class="txt" id="cate_9"></div></div>
        </div>

        <!-- 第三排 -->
        <div class="item" id="div_item_10" style="left:20px;top:365px;">
            <div class="link" style="z-index:7;"><a href="#" onfocus="showFullName(10)" onblur="showCutName(10)" onclick="goXmdb(10)" id="cate_a_10">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic" style="z-index:8;" id="div_pic_10"><img  src="#" id="cate_img_10" /></div>
            <div class="txt-wrap" style="z-index:9;" id="div_txt_wrap_10"><div class="txt" id="cate_10"></div></div>
        </div>
        <div class="item" id="div_item_11" style="left:142px;top:365px;">
            <div class="link" style="z-index:7;"><a href="#" onfocus="showFullName(11)" onblur="showCutName(11)" onclick="goXmdb(11)" id="cate_a_11">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic" style="z-index:8;" id="div_pic_11"><img  src="#" id="cate_img_11" /></div>
            <div class="txt-wrap" style="z-index:9;" id="div_txt_wrap_11"><div class="txt" id="cate_11"></div></div>
        </div>
        <div class="item" id="div_item_12" style="left:264px;top:365px;">
            <div class="link" style="z-index:7;"><a href="#" onfocus="showFullName(12)" onblur="showCutName(12)" onclick="goXmdb(12)" id="cate_a_12">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic" style="z-index:8;" id="div_pic_12"><img  src="#" id="cate_img_12" /></div>
            <div class="txt-wrap" style="z-index:9;" id="div_txt_wrap_12"><div class="txt" id="cate_12"></div></div>
        </div>
        <div class="item" id="div_item_13" style="left:386px;top:365px;">
            <div class="link" style="z-index:7;"><a href="#" onfocus="showFullName(13)" onblur="showCutName(13)" onclick="goXmdb(13)" id="cate_a_13">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic" style="z-index:8;" id="div_pic_13"><img  src="#" id="cate_img_13" /></div>
            <div class="txt-wrap" style="z-index:9;" id="div_txt_wrap_13"><div class="txt" id="cate_13"></div></div>
        </div>
        <div class="item" id="div_item_14" style="left:508px;top:365px;">
            <div class="link" style="z-index:7;"><a href="#" onfocus="showFullName(14)" onblur="showCutName(14)" onclick="goXmdb(14)" id="cate_a_14">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic" style="z-index:8;" id="div_pic_14"><img  src="#" id="cate_img_14" /></div>
            <div class="txt-wrap" style="z-index:9;" id="div_txt_wrap_14"><div class="txt" id="cate_14"></div></div>
        </div>
         
    </div>
    <!-- E 主内容 -->
</div>

<script type="text/javascript">
var pageCount = <%=pageCount%>;
var pageIndex = <%=pageIndex%>;
var pageSize = <%=pageSize%>;
var jsonObj;
var categoryList;
var area = <%=area%>; 
var pos = <%=pos%> ;
var backUrl = "index.jsp";
var ajaxurl="";
var first = true ;
var $$ = {};
function $(id){
	if(!$$[id]){
	   $$[id] = document.getElementById(id);
	}
	return $$[id];
}

function pageAction(action ){ 
   if(action==1){ pageIndex=pageIndex+1; }else{ pageIndex=pageIndex-1; } 
   if((pageIndex>0)&&(pageIndex<=pageCount)){
	  pos = 0; init();
   }else{
      if(action==1){ pageIndex=pageCount; }else{ pageIndex=1; } 
   }
}
function myCallBack(respText)
{
	 jsonObj = eval('('+respText+')');
	 categoryList = jsonObj.jsoncategorylist;
	 if(first) { pageCount = jsonObj.jsonpagecount;first = false;}
	 var len = categoryList.length;
	 for(var i = len ;i < pageSize; i++) {
		$("div_item_"+i).style.display = "none";
	 }
	 for(var i=0; i<len; i++) {
	  	 $("cate_"+i).innerText = ((categoryList[i].dname).length)>5?(categoryList[i].dname).substr(0,5):categoryList[i].dname;
		 $("cate_img_"+i).src = categoryList[i].picpath;
		 $("div_item_"+i).style.display = "block";
	 }
	 if(len>=1){$("cate_a_"+pos).focus();}
}
function onPageLoad(){
     keyBinds();
	 init();
}
function init(){
	  ajaxurl="<%=static_en%>/ajaxdata/category_list_data.jsp?pageIndex="+pageIndex +"&pageSize="+pageSize+"&categoryId=<%=categoryId%>&posterType=<%=posterType%>";
      getAJAXData(ajaxurl,myCallBack);
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

function goXmdb(num){
	var categoryId = categoryList[num].dcmsid;
	if(categoryId!=null && categoryId!="" && categoryId!="undefined" && categoryId!=undefined){
			var xmdbUrl="<%=static_en%>/page/xmdb.jsp?categoryId="+categoryId;
			backUrl = "oyml.jsp?pageIndex="+pageIndex+"&categoryId=<%=categoryId%>&pos="+num+"&area=0";
			addURLtoCookie("xmdb",backUrl);
			location.href = xmdbUrl;
	}
}
function showFullName(num){
	 $("cate_"+num).innerHTML = ((categoryList[num].dname).length)>5?("<marquee>"+categoryList[num].dname+"</marquee>"):(categoryList[num].dname);
}
function showCutName(num){
	 $("cate_"+num).innerHTML = ((categoryList[num].dname).length)>5?(categoryList[num].dname).substr(0,5):categoryList[num].dname;
}
</script>

</body>
</html>