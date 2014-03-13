<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%
	Integer vasid= Integer.parseInt(request.getParameter("vasid"));
	ServiceHelp serviceHelp = new ServiceHelp(request);
	String url=serviceHelp.getVasUrl(vasid);
	response.getWriter().print(url);
%>