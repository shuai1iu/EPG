<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>深圳活动EPG 3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
</head>

<body bgcolor="transparent" onLoad="goVas()">
<%
UserProfile upf_Jump = new UserProfile(request);
String user = upf_Jump.getUserId();
ServiceHelp serviceHelp_Jump = new ServiceHelp(request);

//获取本地服务器地址
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/jsp/defaulthdcctv/en/index.jsp";
String localIP = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/jsp/defaulthdcctv/en/";
String itvUserId = (String)session.getAttribute("USERID");
%>
<!--menu-->
	<div class="menu">
	</div>
<!--the end-->
<script>
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
/**
	* Title 更改高清“快乐学堂”专区入口
	* Author LS
	* Date 2013-09-05
**/
	location.href="http://125.88.107.79:18080/hdfrontend/welcome.htm?localIp=<%=localIP%>&userId=<%=itvUserId%>&backUrl=<%=basePath%>";  //“快乐学堂”专区入口地址
}
</script>
</body>
</html>
