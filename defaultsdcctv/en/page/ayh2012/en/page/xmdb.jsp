<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head><%@ include file="../common/golbal.jsp" %>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<meta name="page-view-size" content="640*530"/>
<title>赛事点播内容列表页</title>
<link rel="stylesheet" type="text/css" href="<%=static_url%>/css/style.css" />
<script type="text/javascript" src="<%=static_url%>/js/common.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/cookie.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/commonevent.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/ajax_common.js"></script>
</head>
<body onload="onPageLoad();" background="#"  bgcolor="#000000">
<div style="position:absolute;z-index:-1;">
	<img style="width:640px;height:530px;" src="<%=static_url%>/images/bg-page-1.jpg" />
</div>
<%@ include file="../datasource/datasource.jsp"%>
<%@ include file="../datasource/property.jsp"%>
<% 
   DataSource dataSource=new DataSource(request); 
   
   String postertype = "5";
   int pageCount=0;
   
   int pos=dataSource.huaWeiUtil.getInt(request.getParameter("pos"),0);
   int area=dataSource.huaWeiUtil.getInt(request.getParameter("area"),2);
   int pageIndex=dataSource.huaWeiUtil.getInt(request.getParameter("pageIndex"),1);
   int pageSize=dataSource.huaWeiUtil.getInt(request.getParameter("pageSize"),10);
   String categoryId=dataSource.huaWeiUtil.getString(request.getParameter("categoryId"));
   
   /*JSP页面直接加载时启用
   PkitEpgResult epgResult=dataSource.getVodInfos(pageIndex,pageSize,categoryId,postertype);
   List vods=new ArrayList();
   if(epgResult!=null&&epgResult.getResultcode()==0&&epgResult.getDatas()!=null){
	   vods=(List)epgResult.getDatas();
	   pageCount=epgResult.getPageCount();
   }
   */
   
   //获得该栏目的自身的图片做为左边的图片显示
	PkitEpgResult categoryinfo = dataSource.getCategory(categoryId,"0");
	TblCmsCategory cate = new TblCmsCategory();
	String categoryPic = "";
	if(categoryinfo!=null){
		cate = (TblCmsCategory)categoryinfo.getOneObject();
		categoryPic = cate.getPicpath();
	}
   
   //获得推荐位图片
   PkitEpgResult tuijians=dataSource.getVodListByTypeId(1,2,xiangmudianbotuijian,"3");
   List tuijianlist=new ArrayList();
   if(tuijians!=null&&tuijians.getResultcode()==0&&tuijians.getDatas()!=null)
   {
	   tuijianlist = (List)tuijians.getDatas();
   }
%>
<div class="wrapper">
<%String currentPageId = "_1003"; %>
<%@ include file="../common/head.jsp" %>
    <!-- E 导航 -->

    <!-- S 主内容 -->

    <!-- S 分页按钮 -->
    <div class="paging">
        <div class="btn btn-prev" style="left:202px; top:112px;"><a href="#" onclick="pageAction(-1 )"><img src="<%=static_url%>/images/t.gif" /></a></div>
        <div class="btn btn-next" style="left:289px; top:112px;"><a href="#" onclick="pageAction( 1 )"><img src="<%=static_url%>/images/t.gif" /></a></div>
        <div class="btn btn-back" style="left:376px; top:112px;"><a href="#" onclick="goBack()"><img src="<%=static_url%>/images/t.gif" /></a></div>
        <div class="paging-num" style="left:510px; top:120px;"><span class="current" id="page"></span></div>
    </div>
    <!-- E 分页按钮 -->

    <div class="newsList newsList-b" style="left:203px;">
        <div class="item" id="item_0" style="top:0px;">
            <div class="link"><a href="#" onfocus="showFullName(0)" onblur="showCutName(0)" onclick="goDetail(0)" id="vod_a_0">
            <img src="<%=static_url%>/images/t.gif"/></a></div>
            <div class="txt" id="vod_0"></div>
        </div>
        <div class="item" id="item_1" style="top:36px;">
            <div class="link"><a href="#" onfocus="showFullName(1)" onblur="showCutName(1)" onclick="goDetail(1)" id="vod_a_1">
            <img src="<%=static_url%>/images/t.gif"/></a></div>
            <div class="txt" id="vod_1"></div>
        </div>
        <div class="item" id="item_2" style="top:72px;">
            <div class="link"><a href="#" onfocus="showFullName(2)" onblur="showCutName(2)" onclick="goDetail(2)" id="vod_a_2">
            <img src="<%=static_url%>/images/t.gif"/></a></div>
            <div class="txt" id="vod_2"></div>
        </div>
        <div class="item" id="item_3" style="top:108px;">
            <div class="link"><a href="#" onfocus="showFullName(3)" onblur="showCutName(3)" onclick="goDetail(3)" id="vod_a_3">
            <img src="<%=static_url%>/images/t.gif"/></a></div>
            <div class="txt" id="vod_3"></div>
        </div>
        <div class="item" id="item_4" style="top:144px;">
            <div class="link"><a href="#" onfocus="showFullName(4)" onblur="showCutName(4)" onclick="goDetail(4)" id="vod_a_4">
            <img src="<%=static_url%>/images/t.gif"/></a></div>
            <div class="txt" id="vod_4"></div>
        </div>
        <div class="item" id="item_5" style="top:180px;">
            <div class="link"><a href="#" onfocus="showFullName(5)" onblur="showCutName(5)" onclick="goDetail(5)" id="vod_a_5">
            <img src="<%=static_url%>/images/t.gif"/></a></div>
            <div class="txt" id="vod_5"></div>
        </div>
        <div class="item" id="item_6" style="top:216px;">
            <div class="link"><a href="#" onfocus="showFullName(6)" onblur="showCutName(6)" onclick="goDetail(6)" id="vod_a_6">
            <img src="<%=static_url%>/images/t.gif"/></a></div>
            <div class="txt" id="vod_6"></div>
        </div>
        <div class="item" id="item_7" style="top:252px;">
            <div class="link"><a href="#" onfocus="showFullName(7)" onblur="showCutName(7)" onclick="goDetail(7)" id="vod_a_7">
            <img src="<%=static_url%>/images/t.gif"/></a></div>
            <div class="txt" id="vod_7"></div>
        </div>
        <div class="item" id="item_8" style="top:286px;">
            <div class="link"><a href="#" onfocus="showFullName(8)" onblur="showCutName(8)" onclick="goDetail(8)" id="vod_a_8">
            <img src="<%=static_url%>/images/t.gif"/></a></div>
            <div class="txt" id="vod_8"></div>
        </div>
        <div class="item" id="item_9" style="top:322px;">
            <div class="link"><a href="#" onfocus="showFullName(9)" onblur="showCutName(9)" onclick="goDetail(9)" id="vod_a_9">
            <img src="<%=static_url%>/images/t.gif"/></a></div>
            <div class="txt" id="vod_9"></div>
        </div>
    </div>
    <!-- E 主内容 -->

    <!-- S 侧栏 -->
    <div class="showPicSideBar">
        <div class="pic"><img src="<%=categoryPic%>" /></div>
        <div class="pic-shade"><img src="<%=static_url%>/images/t.gif" /></div>
    </div>
    <div class="picList-b" style="left:23px; top:289px;">
        <div class="item" style="top:0px;">
        <%if(tuijianlist!=null){if(tuijianlist.size()>0) {%>
        <div class="link"><a href="#" id="tuijian_a_0" onclick="goDetail0(0,<%=((TblCmsProgram)tuijianlist.get(0)).getDcmsid()%>)">
        	<img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic"><img src="<%=((TblCmsProgram)tuijianlist.get(0)).getDpostpath()%>" /></div>
            <%}}%>
        </div>
        <div class="item" style="top:114px;">
        <%if(tuijianlist!=null){if(tuijianlist.size()>1) {%>
        <div class="link"><a href="#" id="tuijian_a_1" onclick="goDetail0(1,<%=((TblCmsProgram)tuijianlist.get(1)).getDcmsid()%>)">
        	<img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic"><img src="<%=((TblCmsProgram)tuijianlist.get(1)).getDpostpath()%>" /></div>
            <%}}%>
        </div>
    </div>
    <!-- E 侧栏 -->

</div>
<script type="text/javascript">
var pageCount=<%=pageCount%>;
var pageIndex=<%=pageIndex%>;
var pageSize=<%=pageSize%>;
var jsonObj;
var vodList;
var backUrl = "index.jsp";
var ajaxurl="";
var area = <%=area%>; //0:top 1：左边2个推荐位 2:列表 
var pos = <%=pos%> ;
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
	// initpos();
}
function initpos(){
	if(1==area){$("tuijian_a_"+pos).focus();}
	else if(2==area){$("vod_a_"+pos).focus();}	
}

function pageAction(action ){ 
   area = 2;
   if(action==1){ pageIndex=pageIndex+1; }else{ pageIndex=pageIndex-1; } 
   if((pageIndex>0)&&(pageIndex<=pageCount)){
      pos = 0; init();
   }else{
      if(action==1){ pageIndex = pageCount; }else{ pageIndex = 1; } 
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
	 pageCount=jsonObj.jsonpagecount;
	 var len = vodList.length;
	 for(var i=0;i<len;i++){     
	  	$("vod_"+i).innerText = ((vodList[i].dname).length)>20?(vodList[i].dname).substr(0,20):vodList[i].dname;
	 	$("item_"+i).style.display = "block";
	 }
	 for(var i=len;i<pageSize;i++){
	 	$("item_"+i).style.display = "none";
	 }
	 $("page").innerText = ((pageCount == 0)?0:pageIndex)+"/"+pageCount;
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

var programid = 0;
function goDetail(num){
	programid = vodList[num].dcmsid;
	if(programid != null && programid !="" && programid != "undefined" && programid != undefined){
		var detailUrl="<%=static_en%>/page/detail.jsp?categoryId=-1&categoryname=&programid="+programid;
		backUrl = "xmdb.jsp?categoryId=<%=categoryId%>&area=2&pageIndex="+pageIndex+"&pos="+num;
		addURLtoCookie("detail",backUrl);
		location.href = detailUrl;
	}
}
function goDetail0(num,programid){
	var detailUrl="<%=static_en%>/page/detail.jsp?categoryId=-1&categoryname=&programid="+programid;
	backUrl = "xmdb.jsp?categoryId=<%=categoryId%>&area=1&pageIndex="+pageIndex+"&pos="+num;
	addURLtoCookie("detail",backUrl);
	location.href = detailUrl;
}
function goBack(){
	 backUrl = getURLtoCookie("xmdb");
	 backUrl = (backUrl!="")?backUrl:"index.jsp";
	 location.href=backUrl ;
    }
function showFullName(num){
	 $("vod_"+num).innerHTML = ((vodList[num].dname).length)>20?("<marquee>"+vodList[num].dname+"</marquee>"):(vodList[num].dname);
}
function showCutName(num){
	 $("vod_"+num).innerHTML = ((vodList[num].dname).length)>20?(vodList[num].dname).substr(0,20):vodList[num].dname;
}
</script>

</body>
</html>