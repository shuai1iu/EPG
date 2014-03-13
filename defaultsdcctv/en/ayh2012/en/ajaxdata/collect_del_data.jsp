<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ include file="../datasource/datasource.jsp"%>
<%@ include file="../datasource/property.jsp"%>
<%
	DataSource dataSource=new DataSource(request); 
	
	String programid = dataSource.huaWeiUtil.getString(request.getParameter("programid"));
	String programType = dataSource.huaWeiUtil.getString(request.getParameter("programType"));

    PkitEpgResult epgResult = dataSource.delFavorite(programid,programType);
	
	response.getWriter().print("{resultcode:"+epgResult.getResultcode()+",resultdesc:'"+epgResult.getResultdesc()+"'}");
%>
