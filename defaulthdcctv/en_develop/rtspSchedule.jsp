<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>RTSP调度页面</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
</head>

<body bgcolor="transparent" onLoad="goVas()">
<%
UserProfile profile = new UserProfile(request);
String groupId = profile.getUserGroupId();
String rtspChan = request.getParameter("RTSPCHAN");
%>
<!--menu-->
	<div class="menu">
	</div>
<!--the end-->
<script>

var rtspChan = <%=rtspChan%>;


if (typeof(iPanel) != 'undefined')
{
	iPanel.focusWidth = 4;
	iPanel.defaultFocusColor = "#FCFF05";
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
		return 1; 
		break;
		default:
		return 1;
	
	} 
}
function goBack(){
	backUrl = "../../special_topic.jsp";
	location.href = backUrl ;
}
function goVas(){
	alert(rtspChan);
	location.href="rtspPlay.jsp";
}
</script>
</body>
</html>
