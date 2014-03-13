<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.UserViewingRecord"%>
<%
	String progId = request.getParameter("PROGID"); 
	String progType = request.getParameter("PROGTYPE");
	String breakPoint = request.getParameter("BREAKPOINT");
	String supVodId = request.getParameter("SUPVODID");
	String jumpUrl = request.getParameter("JUMPURL");
	UserViewingRecord uvr = new UserViewingRecord(request);
	boolean flag = uvr.addViewingRecord(progId,progType,0,0,breakPoint,supVodId);
%>
<jsp:forward page="<%=jumpUrl%>" />