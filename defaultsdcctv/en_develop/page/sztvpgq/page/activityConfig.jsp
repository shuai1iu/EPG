<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>外部服务器地址传USERID页面</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
</head>

<body bgcolor="transparent" onLoad="goVas()">
<%


String targetUrl = request.getParameter("TARGETURL");
String pageId = request.getParameter("pageId");

UserProfile upf_Jump = new UserProfile(request);
String user = upf_Jump.getUserId();
ServiceHelp serviceHelp_Jump = new ServiceHelp(request);

//获取本地服务器地址
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/jsp/defaultsdcctv/en/page/index.jsp";
String localIP = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/jsp/defaultsdcctv/en/page/";
String itvUserId = (String)session.getAttribute("USERID");
%>
<script>

var targetUrl = unescape(<%=targetUrl%>);
	
function goVas(){
/**
	* Title 可配置入口地址的活动页面
	* Author LS
	* Date 2013-11-05
**/
	location.href=targetUrl+"?localIp=<%=localIP%>&userId=<%=itvUserId%>&backUrl=<%=basePath%>&pageId=<%=pageId%>";  //可配置入口定制
}
</script>
</body>
</html>
