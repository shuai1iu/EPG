<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

</head>

<body style="background-color:transparent;">

<script>
<%
	int vasid= Integer.parseInt(request.getParameter("vasid"));
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/EPG/jsp/";
	ServiceHelp serviceHelp = new ServiceHelp(request);
	String url=basePath+serviceHelp.getVasUrl(vasid);
%>
	parent.alertVasurl('<%=url%>');
</script>
</body>
</html>