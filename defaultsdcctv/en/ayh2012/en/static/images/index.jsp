<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><%@ include file="../common/golbal.jsp" %> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>央视奥运 标清EPG 2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="<%=static_url%>/css/style.css" />
<link type="text/css" rel="stylesheet" href="<%=static_url%>/css/content.css" />
<script type="text/javascript">
if(typeof(iPanel)!= 'undefined'){iPanel.focusWidth = "2";iPanel.defaultFocusColor = "#FCFF05";}
</script>
<script type="text/javascript" src="<%=static_url%>/js/cookie.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/common.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/commonevent.js"></script>
<style type="text/css">
<!--
body{ background: transparent url(<%=static_url%>/images/bg-index.gif) no-repeat;}
-->
</style>
</head>
<body onload="onPageLoad();">
<%@ include file="../datasource/datasource.jsp" %>
<%@ include file="../datasource/property.jsp" %>
<%  
   DataSource dataSource=new DataSource(request); 
   
   //获取热词(栏目形式)
   EpgResult hotkeys=dataSource.getCategorys(1,3,recisousuo,"0");
   List hotskeylist=new ArrayList();
   if(hotkeys!=null&&hotkeys.getResultcode()==0&&hotkeys.getDatas()!=null)
   {
	   hotskeylist=(List)hotkeys.getDatas();
   }
     
   
   //获取精彩回放列表
   EpgResult jingcaihuikans = dataSource.getVodListByTypeId(1,4,jingcaituijian,"0");
   List jingcaihuikanlist = new ArrayList();
   if(jingcaihuikans!=null&&jingcaihuikans.getResultcode()==0&&jingcaihuikans.getDatas()!=null)
   {
	   jingcaihuikanlist=(List)jingcaihuikans.getDatas();
   }
            
   //获得推荐位图片：采用普通栏目的方式,需要启用即可
   /*
   String duijian_categoryid=xiangmudianbotuijian;
   EpgResult tuijians=dataSource.getVodListByTypeId(1,2,duijian_categoryid,"0");
   List tuijianlist=new ArrayList();
   if(tuijians!=null&&tuijians.getResultcode()==0&&tuijians.getDatas()!=null)
   {
	   tuijianlist=(List)tuijians.getDatas();
   }
   */
   
   //增值业务栏目的推荐位
   EpgResult vastuijians = dataSource.getVasCategorys(1,2,shouyetuijianvas,"0");
   List vastuijianlist = new ArrayList();
   if(vastuijians!=null && vastuijians.getResultcode()==0 && vastuijians.getDatas()!=null)
   {
	   vastuijianlist = (List)vastuijians.getDatas();
   }   
   
   //获得滚动走字信息
   EpgResult rollinfo = dataSource.getAdText(gundong);
   String rollname = "";
   if(rollinfo!=null&&rollinfo.getOneObject()!=null)
   {
	   rollname = ((TblRollInfo)rollinfo.getOneObject()).getDrollname();
   }
%>

<div class="wrapper">

<% String currentPageId = "_1000"; %>
<%@ include file="../common/head.jsp" %>



<!--左边推荐位-->
<div class="index-pic">
	<div class="item">
	    <%if(vastuijianlist!=null){if(vastuijianlist.size()>0) {%>
        <div class="link"><a href=""><img src="<%=static_url%>/images/t.gif" /></a></div>
        <div class="pic"><img src="<%=((TblCmsVasCategory)vastuijianlist.get(0)).getDposterpath0()%>" /></div>
        <%}}%>
	</div>
	<div class="item" style="top:113px;">
		<%if(vastuijianlist!=null){if(vastuijianlist.size()>1) {%>
        <div class="link"><a href=""><img src="<%=static_url%>/images/t.gif" /></a></div>
        <div class="pic"><img src="<%=((TblCmsVasCategory)vastuijianlist.get(1)).getDposterpath0()%>" /></div>
        <%}}%>
	</div>
</div>	
<!--the end-->


	
<!--精彩推荐-->
<div class="index-look-back">
<div class="title">精彩推荐</div>
   <% if(jingcaihuikanlist.size()>0) {
		TblCmsProgram vods=null;
		int toppx=0;//距离左边的长度
	    for(int i=0;i<jingcaihuikanlist.size();i++){ 
		 	vods=(TblCmsProgram)jingcaihuikanlist.get(i);
			String vodname=vods.getDname();
			toppx=30*(i+1);
			if(vodname.length()>=8){
				%>
				<div class="item" style="top:<%=toppx %>px;">
                    <div class="link"><a href="<%=static_en%>/page/detail.jsp"><img src="<%=static_url%>/images/t.gif" /></a></div>
                    <div class="txt"><%=vodname.substring(0,8) %></div>
                </div>
				<%
			}else{
				%>
				<div class="item" style="top:<%=toppx %>px;">
                    <div class="link"><a href="<%=static_en%>/page/detail.jsp"><img src="<%=static_url%>/images/t.gif" /></a></div>
                    <div class="txt"><%=vodname %></div>
                </div>
				<%
			}
		}
	}%>
</div>
<!--the end-->	


        
<!--关键词-->
<div class="keyword" align="left"><!-- 2字宽为wid1;3字宽为wid2,4字宽为wid3,5字宽为wid4-->
<% if(hotskeylist.size()>0) {
	TblCmsCategory category=null;
	int leftpx=0;//距离左边的长度
	for(int i=0;i<hotskeylist.size();i++){ 
		category=(TblCmsCategory)hotskeylist.get(i);
		String categoryname = category.getDname().toString();
		if(categoryname.length()>=5){
			%>
			<div class="item" style="left:<%=leftpx %>px;">
				<div class="link wid4"><a href="search.jsp?keywords=<%=categoryname%>"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt wid4"><%=categoryname.substring(0,5) %></div>
			</div>  
			<%
			leftpx+=109;
		}else if(categoryname.length()>=4){
			%>
			<div class="item" style="left:<%=leftpx %>px;">
				<div class="link wid3"><a href="search.jsp?keywords=<%=categoryname%>"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt wid3"><%=categoryname.substring(0,4) %></div>
			</div>  
			<%
			leftpx+=87;
		}else if(categoryname.length()==3){
			%>
			<div class="item" style="left:<%=leftpx %>px;">
				<div class="link wid2"><a href="search.jsp?keywords=<%=categoryname%>"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt wid2"><%=categoryname %></div>
			</div>  
			<%
			leftpx+=65;
		}else {
			%>
			<div class="item" style="left:<%=leftpx %>px;">
				<div class="link wid1"><a href="search.jsp?keywords=<%=categoryname%>"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt wid1"><%=categoryname %></div>
			</div>  
			<%
			leftpx+=47;
		}
	}
}%>
</div>
<!--the end-->


<!--播放区-->
<div class="index-video"> 
	<div class="item">	
		<div class="link"><a href="<%=static_en%>/player/liveplay.jsp?userchannelid=15"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="pic">
		<iframe src="<%=static_en%>/player/frame-index-vedio.jsp?userchannelid=15&_height=325&_width=430&_left=205&_top=145" frameborder="0" width="390" height="294" style="background:transparent" ></iframe>
		</div>
	</div>
</div>
<!--the end-->


	 
<!--滚动字幕-->
<div class="notice">
	<div class="txt"><marquee scrollamount="3"><%=rollname %></marquee></div>
</div>
<!--the end-->	
		
</div>	

<script type="text/javascript">
function onPageLoad(){
     keyBinds();
	 addURLtoCookie("index","../../../ozb2012/ozb/url.html");
}
BaseProcess.prototype.KEY_BACK_EVENT=function(){
	   goBack();
}


function goBack(){
	 var backUrl = getURLtoCookie("index");
	 backUrl = (backUrl!="")?backUrl:"../../../ozb2012/ozb/url.html";
	 window.location.href = backUrl ;
}
</script>

</body>
</html>
