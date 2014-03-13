<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
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
	body { background:url(../images/hdbg1.jpg) no-repeat;}
-->
</style>
</head>

<body bgcolor="transparent">
<%
 String itvUserId = (String)session.getAttribute("USERID");
%>
	<!--menu-->
	<div class="menu">
       <div class="pic"style="top:100px;left:500px;"><a href="vod_turnpager.jsp?typeid=10000100000000090000000000026654&returnurl=2013nh/page/nhindex2.jsp"><img src="../images/xingfu.png" /></a></div>       
	   <div class="pic" style=" top:230px;left:375px; "><a href="vod_turnpager.jsp?typeid=10000100000000090000000000026653&returnurl=2013nh/page/nhindex2.jsp"><img src="../images/daju.png" /></a></div>
	   <div class="pic" style=" top:150px;left:250px; "><a href="vod_turnpager.jsp?typeid=10000100000000090000000000026655&returnurl=2013nh/page/nhindex2.jsp"><img src="../images/dianying.png" /></a></div>
	   <div class="pic" style=" top:300px;left:120px; "><a href="vod_turnpager.jsp?typeid=10000100000000090000000000026652&returnurl=2013nh/page/nhindex2.jsp"><img src="../images/geshou.png" /></a></div>       
    </div>
	<!--the end-->

<script>
if(typeof(iPanel)!= 'undefined'){iPanel.focusWidth = "4"; iPanel.defaultFocusColor="#FFFF00";}
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
function goVas(){http:
	location.href="http://14.31.15.70/?itvUserId=<%=itvUserId%>&endUrl="+location.href;
}
</script>
</body>
</html>
