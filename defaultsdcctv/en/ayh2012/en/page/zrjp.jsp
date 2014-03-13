<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head><%@ include file="../common/golbal.jsp" %>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<meta name="page-view-size" content="640*530"/>
<title>昨日金牌(中国军团)</title>
<link rel="stylesheet" type="text/css" href="<%=static_url%>/css/style.css" />
<script type="text/javascript" src="<%=static_url%>/js/common.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/cookie.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/commonevent.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/ajax_common.js"></script>
</head>
<body onload="onPageLoad();" background="#"  bgcolor="#000000">
<%@ include file="../datasource/datasource.jsp"%>
<%@ include file="../datasource/property.jsp"%>
<div style="position:absolute;z-index:-1;">
	<img style="width:640px;height:530px;" src="<%=static_url%>/images/bg-page-1.jpg" />
</div>
<% 
   DataSource dataSource=new DataSource(request); 
   int pos = dataSource.huaWeiUtil.getInt(request.getParameter("pos"),0);
   int area = dataSource.huaWeiUtil.getInt(request.getParameter("area"),2);
   int pageIndex = dataSource.huaWeiUtil.getInt(request.getParameter("pageIndex"),1);
   int pageSize = dataSource.huaWeiUtil.getInt(request.getParameter("pageSize"),10);
   String postertype = "5";
   int pageCount=0;
   String categoryId = zhongguojuntuan;
   
   /*需要页面JSP加载数据时启用
   PkitEpgResult epgResult=dataSource.getVodInfos(pageIndex,pageSize,categoryId,postertype);
   List vods=new ArrayList();
   if(epgResult!=null&&epgResult.getResultcode()==0&&epgResult.getDatas()!=null){
	   vods=(List)epgResult.getDatas();
	   pageCount=epgResult.getPageCount();
   }
   */
   
   //增值业务栏目的推荐位,需要时启用
   /*
   PkitEpgResult vastuijians = dataSource.getVasCategorys(1,3,"00000100000000090000000000018811","0");
   List vastuijianlist = new ArrayList();
   if(vastuijians!=null && vastuijians.getResultcode()==0 && vastuijians.getDatas()!=null)
   {
	   vastuijianlist = (List)vastuijians.getDatas();
   } */
     
   //普通推荐栏目的方式
   PkitEpgResult catetuijians = dataSource.getCategorys(1,3,zhongguojuntuantuijiancate,"2");
   List catetuijianlist = new ArrayList();
   if(catetuijians!=null&&catetuijians.getResultcode()==0&&catetuijians.getDatas()!=null)
   {
		catetuijianlist = (List)catetuijians.getDatas();
   }
%>

<div class="wrapper">
<%String currentPageId = "_1002"; %>
<%@ include file="../common/head.jsp" %>
    <!-- E 导航 -->

    <!-- S 主内容 -->

    <!-- S 分页按钮 -->
    <div class="paging">
        <div class="btn btn-prev" style="left:21px; top:112px;"><a href="#" onclick="pageAction(-1)"><img src="<%=static_url%>/images/t.gif" /></a></div>
        <div class="btn btn-next" style="left:108px; top:112px;"><a href="#" onclick="pageAction(1)"><img src="<%=static_url%>/images/t.gif" /></a></div>
        <div class="paging-num" style="left:310px; top:120px;"><span class="current" id="page"></span></div>
    </div>
    <!-- E 分页按钮 -->

    <div class="newsList">
        <div class="item" id="item_0" style="top:0px;">
            <div class="link"><a href="#" id="vod_a_0" onclick="goDetail(0)" onfocus="showFullName(0)" onblur="showCutName(0)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="txt" id="vod_0"></div>
        </div>
        <div class="item" id="item_1" style="top:36px;">
            <div class="link"><a href="#" id="vod_a_1" onclick="goDetail(1)" onfocus="showFullName(1)" onblur="showCutName(1)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="txt" id="vod_1"></div>
        </div>
        <div class="item" id="item_2" style="top:72px;">
            <div class="link"><a href="#" id="vod_a_2" onclick="goDetail(2)" onfocus="showFullName(2)" onblur="showCutName(2)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="txt" id="vod_2"></div>
        </div>
        <div class="item" id="item_3" style="top:108px;">
            <div class="link"><a href="#" id="vod_a_3" onclick="goDetail(3)" onfocus="showFullName(3)" onblur="showCutName(3)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="txt" id="vod_3"></div>
        </div>
        <div class="item" id="item_4" style="top:144px;">
            <div class="link"><a href="#" id="vod_a_4" onclick="goDetail(4)" onfocus="showFullName(4)" onblur="showCutName(4)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="txt" id="vod_4"></div>
        </div>
        <div class="item" id="item_5" style="top:180px;">
            <div class="link"><a href="#" id="vod_a_5" onclick="goDetail(5)" onfocus="showFullName(5)" onblur="showCutName(5)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="txt" id="vod_5"></div>
        </div>
        <div class="item" id="item_6" style="top:216px;">
            <div class="link"><a href="#" id="vod_a_6" onclick="goDetail(6)" onfocus="showFullName(6)" onblur="showCutName(6)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="txt" id="vod_6"></div>
        </div>
        <div class="item" id="item_7" style="top:252px;">
            <div class="link"><a href="#" id="vod_a_7" onclick="goDetail(7)" onfocus="showFullName(7)" onblur="showCutName(7)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="txt" id="vod_7"></div>
        </div>
        <div class="item" id="item_8" style="top:286px;">
            <div class="link"><a href="#" id="vod_a_8" onclick="goDetail(8)" onfocus="showFullName(8)" onblur="showCutName(8)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="txt" id="vod_8"></div>
        </div>
        <div class="item" id="item_9" style="top:322px;">
            <div class="link"><a href="#" id="vod_a_9" onclick="goDetail(9)" onfocus="showFullName(9)" onblur="showCutName(9)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="txt" id="vod_9"></div>
        </div>
    </div>
    <!-- E 主内容 -->

    <!-- S 侧栏 -->
    <div class="picList" style="left:432px; top:113px;">
       <%if(catetuijianlist!=null){int len = catetuijianlist.size();for(int i = 0;i<len ;i++) {%>
        <div class="item" style="top:<%=126*i%>px;">
            <div class="link"><a href="#" id="cate_a_<%=i%>" onclick="goXmdb(<%=i%>)"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic"><img src="<%=((TblCmsCategory)catetuijianlist.get(i)).getPicpath()%>" /></div>
        </div>
        <%}}%>
    </div>
    <!-- E 侧栏 -->

</div>

<script type="text/javascript">
var pageCount=<%=pageCount%>;
var pageIndex=<%=pageIndex%>;
var pageSize=<%=pageSize%>;
var pos = <%=pos%> ;
var area = <%=area%>; //0:top 1:翻页 2：列表 3：推荐位
var backUrl = "index.jsp";
var ajaxurl="";
var jsonObj;
var vodList;
var CateIdList = new Array();
<%
if(catetuijianlist.size()>0){
	int len = catetuijianlist.size();
	for(int i= 0; i < len ; i++){
	  %>
		CateIdList[<%=i%>] = "<%=((TblCmsCategory)catetuijianlist.get(i)).getDcmsid()%>";
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
	 init(); 
	 //initpos();
}
function initpos()
{
	if(2==area){$("vod_a_"+pos).focus();}
	else if(3==area){$("cate_a_"+pos).focus();}
}
function pageAction(action ){ 
   area = 2;
   if(action==1){ pageIndex=pageIndex+1; }else{ pageIndex=pageIndex-1; } 
   if((pageIndex>0)&&(pageIndex<=pageCount)){
       pos = 0 ; init(); 
   }else{
      if(action==1){ pageIndex=pageCount; }else{ pageIndex=1; } 
   }
}
function init(){
	ajaxurl="<%=static_en%>/ajaxdata/vod_list_data.jsp?pageIndex="+pageIndex+"&pageSize="+pageSize+"&categoryId=<%=categoryId%>&posterType=<%=postertype%>";
    getAJAXData(ajaxurl,myCallBack);
}
function myCallBack(respText)
{
	 jsonObj = eval('('+respText+')');
	 vodList = jsonObj.jsonvodlist;
	 pageCount = jsonObj.jsonpagecount;
	 var len = vodList.length;
	 for(var i=0;i<len;i++) {   
	  	$("vod_"+i).innerText = ((vodList[i].dname).length)>19?(vodList[i].dname).substr(0,19):vodList[i].dname;
		$("item_"+i).style.display = "block";
	 } 
	 for(var i=len;i<pageSize;i++){
	  	$("item_"+i).style.display = "none";
	 } 
	 $("page").innerText = ((pageCount == 0)?0:pageIndex) +"/" + pageCount;
	 initpos();
}
var programid=null;
function goDetail(num){
	programid = vodList[num].dcmsid;
	if(programid!=null && programid!="" && programid!="undefined" && programid!=undefined){
		var detailUrl="<%=static_en%>/page/detail.jsp?categoryId=<%=categoryId%>&categoryname=&programid="+programid;
		backUrl = "zrjp.jsp?pos="+num+"&pageIndex="+pageIndex+"&area=2";
		addURLtoCookie("detail",backUrl);
		location.href = detailUrl;
	}
}
function goXmdb(num){
	var xmdbUrl="<%=static_en%>/page/xmdb.jsp?categoryId="+CateIdList[num];
	if(xmdbUrl!=null && xmdbUrl!="" && xmdbUrl!="undefined" && xmdbUrl!=undefined){
		backUrl = "<%=static_en%>/page/zrjp.jsp?area=3&pos="+num+"&&pageIndex="+pageIndex;
		addURLtoCookie("xmdb",backUrl);
		location.href = xmdbUrl;
	}
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
function showFullName(num){
	 $("vod_"+num).innerHTML = ((vodList[num].dname).length)>19?("<marquee>"+vodList[num].dname+"</marquee>"):(vodList[num].dname);
}
function showCutName(num){
	 $("vod_"+num).innerHTML = ((vodList[num].dname).length)>19?(vodList[num].dname).substr(0,19):vodList[num].dname;
}
</script>

</body>
</html>