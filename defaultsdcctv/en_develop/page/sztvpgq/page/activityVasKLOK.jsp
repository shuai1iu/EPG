<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>深圳活动EPG 3.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
</head>

<body bgcolor="transparent" onLoad="goVas()">
<%
UserProfile upf_Jump = new UserProfile(request);
String user = upf_Jump.getUserId();
ServiceHelp serviceHelp_Jump = new ServiceHelp(request);
//获取本地服务器地址
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/jsp/defaultsdcctv/en/page/index.jsp";//20130910 hxt 应用返回到高清首页问题
String itvUserId = (String)session.getAttribute("USERID");
%>
<script>
function goVas(){
	location.href="http://125.88.98.144:9090/gd/index.jsp?user=<%=itvUserId%>&endUrl=<%=basePath%>";
}
</script>
</body>
</html>
