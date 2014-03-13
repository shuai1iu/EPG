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
</head>
<%@ include file="../datasource/datasource.jsp"%>
<%@ include file="../datasource/property.jsp"%>
<% 
   DataSource dataSource=new DataSource(request); 
   int pos = dataSource.huaWeiUtil.getInt(request.getParameter("pos"),0);

   EpgResult meiriyixings = dataSource.getVodInfoListByTypeId(1,5,meiriyixing,"0");
   List meiriyixingslist = new ArrayList();
   if(meiriyixings!=null&&meiriyixings.getResultcode()==0&&meiriyixings.getDatas()!=null)
   {
	   meiriyixingslist = (List)meiriyixings.getDatas();
   }
   
   EpgResult tuijians = dataSource.getVodInfoListByTypeId(1,5,meiriyixing,"1");
   List tuijianslist = new ArrayList();
   if(tuijians!=null&&tuijians.getResultcode()==0&&tuijians.getDatas()!=null)
   {
	   tuijianslist = (List)tuijians.getDatas();
   }

%>
<body onload="onPageLoad();">
<% String currentPageId = "_1003"; %>
<%@ include file="../common/head.jsp" %>



<!--sub-->
<div class="sub" style="width:610px;">  <!--item-focus为焦点；select为当前选中--> 
	<div class="item">
		<div class="link"><a href="china.jsp" ><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">冠军中国</div>
	</div>
	<div class="item" style="left:151px;">
		<div class="link"><a href="china-corps.jsp"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">中国军团</div>
	</div>
	<div class="item item-focus" style="left:301px;">
		<div class="link"><a href="#"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">每日一星</div>
	</div>
</div>	

<!--the end-->

<div class="star-intro">
	<div class="title" align="center" id="meiriTitle"></div>
	<div class="con">
		<div class="txt" id="jianjie"></div>
	</div>
</div>


<div class="star-title"><img src="<%=static_url%>/images/title-about.jpg" /></div>
<div class="star-pic-list"> <!--item-focus为焦点-->
    <%
	 if(tuijianslist!=null&&tuijianslist.size()>0){
		 int tuijianlen = tuijianslist.size();
		 int leftpx = 0;
		 for(int i=0;i<tuijianlen;i++){
			 leftpx = 124*i;
		 %>
         <div class="item" style="left:<%=leftpx%>px">
			<div class="pic"><a href="#" id="vod_a_<%=i%>" 
            onclick="showPosert(<%=((TblCmsProgram)tuijianslist.get(i)).getDsubvodidlist().get(0)%>,<%=((TblCmsProgram)tuijianslist.get(i)).getDid()%>,"<%=((TblCmsProgram)meiriyixingslist.get(i)).getDpostpath()%>","<%=((TblCmsProgram)meiriyixingslist.get(i)).getDname()%>","<%=((TblCmsProgram)meiriyixingslist.get(i)).getDdescription()%>")">
        	<img  src="<%=((TblCmsProgram)tuijianslist.get(i)).getDpostpath()%>" /></a></div>		
		 </div>
         <%
	 }}
	%>
</div>


<!--the end-->
<!--r-poster-->
<div class="hd-r-poster03"> <!--item-focus为焦点--> 
	<div class="item">
      <%
	  	if(meiriyixingslist!=null&&meiriyixingslist.size()>0)
		{
			%>
            <div class="pic"><a href="#" id="vod_a_5" 
            onclick="gotoVodPlay()">
      			<img  id="poster"  src="<%=((TblCmsProgram)meiriyixingslist.get(0)).getDpostpath()%>" /></a></div>
            <%
		}
	  %>
	</div>
</div>
<!--the end-->
<script type="text/javascript">
var pos = <%=pos %> ;
var backUrl = "index.jsp";
var programid =  <%=((TblCmsProgram)meiriyixingslist.get(0)).getDsubvodidlist().get(0)%>;
var fatherid = <%=((TblCmsProgram)meiriyixingslist.get(0)).getDid()%>;
var psotertpath = "<%=((TblCmsProgram)meiriyixingslist.get(0)).getDpostpath()%>";
var title = "<%=((TblCmsProgram)meiriyixingslist.get(0)).getDname()%>";
var discreption = "<%=((TblCmsProgram)meiriyixingslist.get(0)).getDdescription()%>";
function onPageLoad(){
	 initpos();
	 $("meiriTitle").innerText = title;
	$("jianjie").innerText = discreption;
}

function initpos(){
    $("vod_a_"+pos).focus();
}
function showPosert(num,num2,pos0,titleTex,diScpt)
{
	programid = num;
	fatherid = num2;
	psotertpath = pos0;
	title = titleTex;
	discreption = diScpt;
	$("meiriTitle").innerText = title;
	$("jianjie").innerText = discreption;
	$("poster").src = psotertpath;
	

}

function gotoVodPlay(){
	//var vodPlayUrl = "<%=static_en%>/player/vodplay.jsp?progId="+programid;
var vodPlayUrl = "<%=static_en%>/player/au_PlayFilm.jsp?PROGID="+programid+"&FATHERSERIESID="+fatherid+"&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=0&BEGINTIME=0&ENDTIME=200000";
	backUrl = "<%=static_en%>/page/china-daily-star.jsp?pos="+num+"&categoryId=-1&categoryname=&programid="+programid;
	addURLtoCookie("vodPlay",backUrl);
	location.href = vodPlayUrl;
}	
var $$ = {};
function $(id){
	if(!$$[id]){
	   $$[id] = document.getElementById(id);
	}
	return $$[id];
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
		case 8:
			goBack();
			break;
	} 
}
function goBack(){
	 var url="index.jsp";
	 window.location.href=url ;
}
</script>	
</body>
</html>
