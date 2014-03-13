<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file="../../util/save_focus.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>深圳活动EPG 3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<style type="text/css">
<!--
	body { background:url(../images/2013lh_hd2.jpg) no-repeat;}
-->
</style>
</head>

<body bgcolor="transparent">
<%
 String itvUserId = (String)session.getAttribute("USERID");
%>
	<!--menu-->
	<div class="menu">
       	   <div id="button1" class="pic"style="top:233px;left:47px;"><a id="abt1" href="vod_turnpager.jsp?typeid=10000100000000090000000000027175&returnurl=2013nh/page/nhindex.jsp"><img src="../images/2013lh_hd_03.jpg" /></a></div>       
	   <div id="button2" class="pic" style=" top:233px;left:677px; "><a id="abt2" href="vod_turnpager.jsp?typeid=10000100000000090000000000027178&returnurl=2013nh/page/nhindex.jsp"><img src="../images/2013lh_hd_05.jpg" /></a></div>
	   <div id="button3" class="pic" style=" top:396px;left:47px; "><a id="abt3" href="vod_turnpager.jsp?typeid=10000100000000090000000000027176&returnurl=2013nh/page/nhindex.jsp"><img src="../images/2013lh_hd_10.jpg" /></a></div>
	   <div id="button4" class="pic" style=" top:395px;left:677px; "><a id="abt4" href="vod_turnpager.jsp?typeid=10000100000000090000000000027179&returnurl=2013nh/page/nhindex.jsp"><img src="../images/2013lh_hd_09.jpg" /></a></div>
	   <div id="button5" class="pic" style=" top:558px;left:47px; "><a id="abt5" href="vod_turnpager.jsp?typeid=10000100000000090000000000027177&returnurl=2013nh/page/nhindex.jsp"><img src="../images/2013lh_hd_14.jpg" /></a></div>
	   <div id="button6" class="pic"style=" top:557px;left:677px; "><a id="abt6" href="vod_turnpager.jsp?typeid=10000100000000090000000000027203&returnurl=2013nh/page/nhindex.jsp"><img src="../images/2013lh_hd_13.jpg" /></a></div>       
    </div>
	<!--the end-->

<script>
if(typeof(iPanel)!= 'undefined'){iPanel.focusWidth = "7"; iPanel.defaultFocusColor="#FFFF00";}
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
		return 1; 
		break;
		default:
		return 1;
	
	} 
}
function goBack(){
	backUrl = "../../index.jsp";
	location.href = backUrl ;
}
function goVas(){
	location.href="http://14.31.15.70/?itvUserId=<%=itvUserId%>&endUrl="+location.href;
}
function start()
{
	//onLoad="start()
	document.getElementById("abt3").focus();	
}
</script>
</body>
</html>
