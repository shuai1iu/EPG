<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="codepage.jsp"%>
<%@ include file="database.jsp"%>
<script type="text/javascript">
<%
	
	int vasid= Integer.parseInt(request.getParameter("vasid"));
	ServiceHelp serviceHelp = new ServiceHelp(request);
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/EPG/jsp/";
	String url=basePath+serviceHelp.getVasUrl(vasid);
	System.out.println("===============url========="+url);
%>
	parent.goURL1('<%=url%>');
</script>
