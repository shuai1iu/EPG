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
if(typeof(iPanel)!= 'undefined'){iPanel.focusWidth = "2"; iPanel.defaultFocusColor = "#FCFF05";}
</script>
<script type="text/javascript" src="<%=static_url%>/js/cookie.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/common.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/commonevent.js"></script>
</head>
<body onload="onPageLoad();"  background="#" bgcolor="transparent">
<div style="position:absolute;z-index:-1;">
<img style="width:640px;height:530px;" src="<%=static_url%>/images/bg-index.png" />
</div>
<%@ include file="../datasource/datasource.jsp" %>
<%@ include file="../datasource/property.jsp" %>
<%  
   DataSource dataSource=new DataSource(request);
   String index = request.getParameter("returnurl");
   int pos=dataSource.huaWeiUtil.getInt(request.getParameter("pos"),0);
   int area=dataSource.huaWeiUtil.getInt(request.getParameter("area"),0);   
   //String _userid = (String)session.getAttribute("USERID");
   //获取热词(栏目形式)
   PkitEpgResult hotkeys=dataSource.getCategorys(1,5,recisousuo,"0");
   List hotskeylist=new ArrayList();
   if(hotkeys!=null&&hotkeys.getResultcode()==0&&hotkeys.getDatas()!=null)
   {
	   hotskeylist=(List)hotkeys.getDatas();
   }   
   
   //获取精彩回放列表
   PkitEpgResult jingcaihuikans = dataSource.getVodListByTypeId(1,4,jingcaituijian,"0");
   List jingcaihuikanlist = new ArrayList();
   if(jingcaihuikans!=null&&jingcaihuikans.getResultcode()==0&&jingcaihuikans.getDatas()!=null)
   {
	   jingcaihuikanlist = (List)jingcaihuikans.getDatas();
   }
            
   //获得推荐位图片(影片)：采用普通栏目的方式,需要启用即可
   /*
   String duijian_categoryid=xiangmudianbotuijian;
   PkitEpgResult tuijians=dataSource.getVodListByTypeId(1,2,duijian_categoryid,"0");
   List tuijianlist=new ArrayList();
   if(tuijians!=null&&tuijians.getResultcode()==0&&tuijians.getDatas()!=null)
   {
	   tuijianlist=(List)tuijians.getDatas();
   }
   */
   
   //增值业务栏目的推荐位,需要时启用即可
   /*
   PkitEpgResult vastuijians = dataSource.getVasCategorys(1,2,shouyetuijianvas,"0");
   List vastuijianlist = new ArrayList();
   if(vastuijians!=null && vastuijians.getResultcode()==0 && vastuijians.getDatas()!=null)
   {
	   vastuijianlist = (List)vastuijians.getDatas();
   } 
   */  
   
   //普通推荐栏目的方式
   PkitEpgResult catetuijians = dataSource.getCategorys(1,2,shouyetuijiancate,"2");
   List catetuijianlist = new ArrayList();
   if(catetuijians!=null&&catetuijians.getResultcode()==0&&catetuijians.getDatas()!=null)
   {
		catetuijianlist = (List)catetuijians.getDatas();
   }
   
   //获得滚动走字信息,需要动态是启用
   /*
   PkitEpgResult rollinfo = dataSource.getAdText(gundong);
   String rollname = "";
   if(rollinfo!=null&&rollinfo.getOneObject()!=null)
   {
	   rollname = ((TblRollInfo)rollinfo.getOneObject()).getDrollname();
   }*/
%>

<div class="wrapper">
<% String currentPageId = "_1000"; %>
<%@ include file="../common/head.jsp" %>

<!--左边推荐位-->
<div class="index-pic">
	<div class="item">
	    <%if(catetuijianlist!=null){if(catetuijianlist.size()>0) {%>
        <div class="link"><a href="#" id="vas_a_0" onclick="goXmdb(0)"><img src="<%=static_url%>/images/t.gif" /></a></div>
        <div class="pic"><img src="<%=((TblCmsCategory)catetuijianlist.get(0)).getPicpath()%>" /></div>
        <%}}%>
	</div>
	<div class="item" style="top:113px;">
		<%if(catetuijianlist!=null){if(catetuijianlist.size()>1) {%>
        <div class="link"><a href="#" id="vas_a_1" onclick="goXmdb(1)"><img src="<%=static_url%>/images/t.gif" /></a></div>
        <div class="pic"><img src="<%=((TblCmsCategory)catetuijianlist.get(1)).getPicpath()%>" /></div>
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
	if(vodname.length()>=9){
		%>
		<div class="item" style="top:<%=toppx %>px;">
			<div class="link"><a href="#" onclick="goDetail(<%=i%>)" id="vod_a_<%=i%>" onfocus="showFullName(<%=i%>)" onblur="showCutName(<%=i%>)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt" id="vod_<%=i%>"><%=vodname.substring(0,9) %></div>
		</div>
		<%
	}else{
		%>
		<div class="item" style="top:<%=toppx %>px;">
			<div class="link"><a href="#" onclick="goDetail(<%=i%>)"  id="vod_a_<%=i%>" onfocus="showFullName(<%=i%>)" onblur="showCutName(<%=i%>)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt" id="vod_<%=i%>"><%=vodname %></div>
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
	int hotNum = 0 ;//热词的长度 设定为15个字
	int hotlen = hotskeylist.size();
	for(int i=0;i<hotlen;i++){ 
		category=(TblCmsCategory)hotskeylist.get(i);
		String categoryname = dataSource.huaWeiUtil.getString(category.getDname());
		int cateNameLen = categoryname.length()>5?5:categoryname.length();
		if( (hotNum+cateNameLen)>15 ){break;}
		if(cateNameLen>=5){
			%>
			<div class="item" style="left:<%=leftpx %>px; float:left;">
				<div class="link wid4"><a href="#" onclick="goSearch(<%=i%>)" id="key_a_<%=i%>"><img src="<%=static_url%>/images/t.gif" /></a></div>
                <div class="txt wid4"><%=categoryname.substring(0,5) %></div>		
			</div>
			<%
			leftpx+=109;hotNum+=5;
		}else if(cateNameLen>=4){
			%>
			<div class="item" style="left:<%=leftpx %>px; float:left;">
				<div class="link wid3"><a href="#" onclick="goSearch(<%=i%>)" id="key_a_<%=i%>"><img src="<%=static_url%>/images/t.gif" /></a></div>
                <div class="txt wid3"><%=categoryname.substring(0,4) %></div>
			</div>
			<%
			leftpx+=87;hotNum+=4;
		}else if(cateNameLen==3){
			%>
			<div class="item" style="left:<%=leftpx %>px; float:left;">
				<div class="link wid2"><a href="#" onclick="goSearch(<%=i%>)" id="key_a_<%=i%>"><img src="<%=static_url%>/images/t.gif" /></a></div>
                <div class="txt wid2"><%=categoryname %></div>
			</div>
			<%
			leftpx+=65;hotNum+=3;
		}else {
			%>
			<div class="item" style="left:<%=leftpx %>px; float:left;">
				<div class="link wid1"><a  href="#" onclick="goSearch(<%=i%>)" id="key_a_<%=i%>"><img src="<%=static_url%>/images/t.gif" /></a></div>
                <div class="txt wid1"><%=categoryname %></div>
			</div>   
			<%
			leftpx+=47;hotNum+=2;
		}
	}
}%>
</div>
<!--the end-->


<!--播放区-->
<div class="index-video"> 
	<div class="item">	
		<div class="link"><a href="#" onclick="goChannelPlay(15)" id="channel_a_0"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="pic"><iframe id="playPage" name="playPage" frameborder="0" height="1px" width="1px"></iframe></div>
	</div>
</div>
<!--the end-->

	 
<!--滚动字幕-->
<div class="notice">
	<div class="txt" id="mymarquee"><marquee scrollamount="3">版权所有 © 2012国际奥委会 所有权利保留。</marquee></div>
</div>
<!--the end-->	
		
</div>	

<script type="text/javascript">
var area = <%=area %>; //0:导航 1：左推荐位 2：精彩推荐 3：搜索词 4：视频窗口
var pos = <%=pos %> ;
var loadIframeTimer ="";
var backUrl = "index.jsp";
var keyNameList = new Array();
var vodIdList = new Array();
var vodNameList =  new Array();
var vasCateUrlList = new Array();
var CateIdList = new Array();
<%
if(hotskeylist.size()>0){
   TblCmsCategory category=null;
	int len = hotskeylist.size();
	for(int i=0;i<len;i++){ 
		%>
		keyNameList[<%=i%>]="<%=((TblCmsCategory)hotskeylist.get(i)).getDdescription().toUpperCase()%>";//修改为传递简介
		<%
	}
}
if(jingcaihuikanlist.size()>0){
	TblCmsProgram vods=null;
	int vodlen = jingcaihuikanlist.size();
	for(int i=0;i<vodlen;i++){ 
	   %>
		vodIdList[<%=i%>]="<%=((TblCmsProgram)jingcaihuikanlist.get(i)).getDcmsid()%>";
		vodNameList[<%=i%>]="<%=((TblCmsProgram)jingcaihuikanlist.get(i)).getDname()%>";
	   <%
	}
}
/*增值业务栏目，需要时启用
if(vastuijianlist.size()>0){
	TblCmsVasCategory vasCate = null;
	int vaslen = vastuijianlist.size();
	for(int i= 0; i < vaslen ; i++){
	  %>
		vasCateUrlList[<%=i%>]="<%=((TblCmsVasCategory)vastuijianlist.get(i)).getDvasurl()%>";
	   <%
	}
}*/

if(catetuijianlist.size()>0){
	int len = catetuijianlist.size();
	for(int i= 0; i < len ; i++){
	  %>
		CateIdList[<%=i%>]="<%=((TblCmsCategory)catetuijianlist.get(i)).getDcmsid()%>";
	   <%
	}
}
%>
function onPageLoad(){
     keyBinds();
	 init();
	 loadIframeTimer = setTimeout(loadIframe,200);
}
BaseProcess.prototype.KEY_BACK_EVENT = function(){
	 goBack();
}


function init()
{
	if(1==area){$("vas_a_"+pos).focus();}
	else if(2==area){$("vod_a_"+pos).focus();}
	else if(3==area){$("key_a_"+pos).focus();}
	else if(4==area){$("channel_a_0").focus();}
}

function goBack(){
	 if(loadIframeTimer){clearTimeout(loadIframeTimer);}
	  location.href = "<%=static_cctv_index%>";
}

function goSearch(num){
	var searchUrl = "search.jsp?keywords="+keyNameList[num];
	backUrl = "index.jsp?area=3&pos="+num;
	addURLtoCookie("search",backUrl);
	location.href = searchUrl;
}
function goChannelPlay(num){
	var channelPlayUrl = "<%=static_en%>/player/play_ControlChannel.jsp?CHANNELNUM="+num;
	//var channelPlayUrl = "<%=static_en%>/player/channelplay.jsp?CHANNELNUM="+num;
	backUrl = "<%=static_en%>/page/index.jsp?area=4&pos=0";
	addURLtoCookie("channelPlay",backUrl);
	location.href = channelPlayUrl;
}
function goDetail(num){
	var detailUrl="<%=static_en%>/page/detail.jsp?categoryId=-1&categoryname=&programid="+vodIdList[num];
	backUrl = "<%=static_en%>/page/index.jsp?area=2&pos="+num;
	addURLtoCookie("detail",backUrl);
	location.href = detailUrl;
}
function goXmdb(num){
	var xmdbUrl="<%=static_en%>/page/xmdb.jsp?categoryId="+CateIdList[num];
	//var xmdbUrl = vasCateUrlList[num];//采用增值业务栏目的时候时开启即可
	if(xmdbUrl!=null && xmdbUrl!="" && xmdbUrl!="undefined" && xmdbUrl!=undefined){
		backUrl = "<%=static_en%>/page/index.jsp?area=1&pos="+num;
		addURLtoCookie("xmdb",backUrl);
		location.href = xmdbUrl;
	}
}
function loadIframe(){
	playPage.location.href = "<%=static_en%>/player/PlayTrailerInVas.jsp?_channelid=15&_height=325&_width=422&_left=208&_top=145";
}
var $$ = {};
function $(id){
	if(!$$[id]){
	   $$[id] = document.getElementById(id);
	}
	return $$[id];
}
function showFullName(num){
	 $("vod_"+num).innerHTML = (vodNameList[num].length)>9?("<marquee>"+vodNameList[num]+"</marquee>"):(vodNameList[num]);
}
function showCutName(num){
	 $("vod_"+num).innerHTML = (vodNameList[num].length)>9?vodNameList[num].substr(0,9):(vodNameList[num]);
}
</script>

</body>
</html>
