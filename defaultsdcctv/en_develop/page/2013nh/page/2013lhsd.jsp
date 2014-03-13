<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>2013¡Ωª·EPG2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />

<style type="text/css">
<!--
	body { background:url(../images/lianghui.jpg) no-repeat;}
-->
</style>
</head>

<body>

<%
String itvUserId = (String)session.getAttribute("USERID");
%>
<div class="wrapper">
  <!--menu1-->
  <div class="menu1">
    <div class="pic"style="top:165px;left:12px;"><a href="../../vod-list.jsp?typeid=10000100000000090000000000027175&returnurl=2013nh/page/2013lhsd.jsp"><img src="../images/1_03.jpg" /></a></div>
    <div class="pic" style=" top:165px;left:327px; "><a href="../../vod-list.jsp?typeid=10000100000000090000000000027178&returnurl=2013nh/page/2013lhsd.jsp"><img src="../images/1_05.jpg" /></a></div>
    <div class="pic" style=" top:284px;left:12px;"><a href="../../vod-list.jsp?typeid=10000100000000090000000000027176&returnurl=2013nh/page/2013lhsd.jsp"><img src="../images/1_10.jpg" /></a></div>
    <div class="pic" style=" top:284px;left:327px;"><a href="../../vod-list.jsp?typeid=10000100000000090000000000027179&returnurl=2013nh/page/2013lhsd.jsp"><img src="../images/1_09.jpg" /></a></div>
    <div class="pic" style=" top:402px;left:12px;"><a href="../../vod-list.jsp?typeid=10000100000000090000000000027177&returnurl=2013nh/page/2013lhsd.jsp"><img src="../images/1_13.jpg" /></a></div>
    <div class="pic" style="top:402px;left:327px;"><a href="../../vod-list.jsp?typeid=10000100000000090000000000027201&returnurl=2013nh/page/2013lhsd.jsp"><img src="../images/1_14.jpg" /></a></div>
  </div>
  <!--the end-->
</div>
<script>
if(typeof(iPanel)!= 'undefined'){iPanel.focusWidth = "4"; iPanel.defaultFocusColor = "#FFFF00";}
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
	location.href="http://14.31.15.70:8001/EPG.aspx?itvno=<%=itvUserId%>&endUrl="+location.href;
}
</script>
</body>
</html>
