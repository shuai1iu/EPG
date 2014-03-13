<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../config/properties.jsp"%>
<%

	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	int areaid = request.getParameter("areaid")==null?0:Integer.parseInt(request.getParameter("areaid"));
	int indexid = request.getParameter("indexid")==null?0:Integer.parseInt(request.getParameter("indexid"));
	
	String parentCategoryCode = "00000100000000090000000000001064";
    String categoryListFile="../../" + datajspname + "/categoryList.jsp";

%>