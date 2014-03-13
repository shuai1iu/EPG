<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head><%@ include file="../common/golbal.jsp" %>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<meta name="page-view-size" content="1280*720"/>
<title>赛事点播内容列表页</title>
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
   
   String postertype = "5";
   int pageCount=0;
   
   int pos=dataSource.huaWeiUtil.getInt(request.getParameter("pos"),0);
   int area=dataSource.huaWeiUtil.getInt(request.getParameter("area"),0);
   int pageIndex=dataSource.huaWeiUtil.getInt(request.getParameter("pageIndex"),1);
   int pageSize=dataSource.huaWeiUtil.getInt(request.getParameter("pageSize"),10);
   String categoryId=dataSource.huaWeiUtil.getString(request.getParameter("categoryId"));
   
   EpgResult epgResult=dataSource.getVodInfos(pageIndex,pageSize,categoryId,postertype);
   List vods=new ArrayList();
   if(epgResult!=null&&epgResult.getResultcode()==0&&epgResult.getDatas()!=null){
	   vods=(List)epgResult.getDatas();
	   pageCount=epgResult.getPageCount();
   }
   
   //获得该栏目的自身的图片做为左边的图片显示
	EpgResult categoryinfo = dataSource.getCategory(categoryId,"0");
	TblCmsCategory cate = new TblCmsCategory();
	String categoryPic = "";
	if(categoryinfo!=null){
		cate = (TblCmsCategory)categoryinfo.getOneObject();
		categoryPic = cate.getPicpath();
	}
   
   //获得推荐位图片
   String duijian_categoryid=xiangmudianbotuijian;
   EpgResult tuijians=dataSource.getVodListByTypeId(1,2,duijian_categoryid,"0");
   List tuijianlist=new ArrayList();
   if(tuijians!=null&&tuijians.getResultcode()==0&&tuijians.getDatas()!=null)
   {
	   tuijianlist=(List)tuijians.getDatas();
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
        <div class="paging-num" style="left:510px; top:120px;"><span class="current" id="page"><%=pageIndex%>/<%=pageCount%></span>页</div>
    </div>
    <!-- E 分页按钮 -->

    <div class="newsList newsList-b" style="left:203px;">
        
	<% if(vods.size()>0) {
        TblCmsProgram vod=null;
		int len=vods.size();
		for(int i=0;i<len;i++){ 
			vod=(TblCmsProgram)vods.get(i);%>
			<div class="item" style="top:<%=(36*i) %>px;">
            <div class="link"><a href="#" onclick="goDetail(<%=i%>)" id="vod_a_<%=i%>"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="txt" id="vod_<%=i%>"><%=vod.getDname() %></div>
        </div>
		<%}
	} %>
         
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
            <div class="link"><a href="#"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic"><img src="<%=((TblCmsProgram)tuijianlist.get(0)).getDpostpath()%>" /></div>
            <%}}%>
        </div>
        <div class="item" style="top:114px;">
			<%if(tuijianlist!=null){if(tuijianlist.size()>1) {%>
            <div class="link"><a href="#"><img src="<%=static_url%>/images/t.gif" /></a></div>
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
var vodIdList = new Array();
var backUrl = "index.jsp";
var area = <%=area%>; 
var pos = <%=pos%> ;
var ajaxflag = false;
<%
if(vods.size()>0)
{
    TblCmsProgram vod=null;
	int len = vods.size();
	for(int i=0;i<len;i++){ 
		vod=(TblCmsProgram)vods.get(i);
		%>
		vodIdList[<%=i%>]="<%=vod.getDcmsid()%>";
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
	 mycheck();
}
function  mycheck()
{
	$("vod_a_"+pos).focus();
	if(pageIndex>1){ pageIndex =pageIndex - 1 ;pageAction(1);}
}

var ajaxurl="";
function pageAction(action ){ 
   ajaxflag = true ;
   if(action==1){ pageIndex=pageIndex+1; }else{ pageIndex=pageIndex-1; } 
   if((pageIndex>0)&&(pageIndex<=pageCount)){
        ajaxurl="<%=static_en%>/ajaxdata/vod_list_data.jsp?pageIndex="+pageIndex+"&pageSize="+pageSize+"&categoryId=<%=categoryId%>&posterType=<%=postertype%>";
        getAJAXData(ajaxurl,myCallBack); $("vod_a_"+pos).focus();
   }else{
      if(action==1){ pageIndex=pageCount; }else{ pageIndex=1; } 
   }
   if(1==pageIndex){ajaxflag = false;}
}
function myCallBack(respText)
{
	 jsonObj = eval('('+respText+')');
	 vodList = jsonObj.jsonvodlist;
	 pageCount=jsonObj.jsonpagecount;
	 var len=vodList.length;
	 for(var i=0;i<len;i++)
	 {
	  	$("vod_"+i).innerText = vodList[i].dname;
	 }
	 $("page").innerText=pageIndex+"/"+pageCount;
	 for(var i=len;i<pageSize;i++)
	 {
	 	$("vod_"+i).innerText = "";
	 }
}

var programid = 0;
function goDetail(num){
	if(ajaxflag){programid = vodList[num].dcmsid;}
	else{ programid = vodIdList[num];}
	if(programid != null && programid !="" && programid != "undefined" && programid != undefined){
		var detailUrl="<%=static_en%>/page/detail.jsp?categoryId=-1&categoryname=&programid="+programid;
		backUrl = "xmdb.jsp?categoryId=<%=categoryId%>&area=0&pageIndex="+pageIndex+"&pos="+num;
		addURLtoCookie("detail",backUrl);
		location.href = detailUrl;
	}
}
 
function goBack(){
	 backUrl = getURLtoCookie("xmdb");
	 backUrl = (backUrl!="")?backUrl:"index.jsp";
	 location.href=backUrl ;
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