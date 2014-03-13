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
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/jsp/defaulthdcctv/en_develop/index.jsp";

//获取目标服务器地址
String target = "";
target = request.getParameter("TARGET");
System.out.println("!!!!!!!!!!!!!!TARGET!!!!!!!!!!!!!"+target);


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

var targetPath = <%=target%>;

function goBack(){
	backUrl = "../../special_topic.jsp";
	location.href = backUrl ;
}
function goVas(){

		location.href = "http://125.88.102.29/gd_dx_2/gupiao1.php?userId=<%=itvUserId%>&stbid=<%=itvUserId%>&backUrl=<%=basePath%>&localIp=<%=basePath%>";
}
</script>
</body>
</html>
