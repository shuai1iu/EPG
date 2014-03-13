<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="../../../config/code.jsp"%>
<%@ include file="../../../config/properties.jsp"%>
<%

	String categoryCode = request.getParameter("categoryCode")==null?"":request.getParameter("categoryCode");
	int curpage = request.getParameter("curpage")==null?1:Integer.parseInt(request.getParameter("curpage"));

    String categoryListFile="../../../" + datajspname + "/categoryList.jsp";

%>
<script>

	<jsp:include page="<%=categoryListFile%>">
		<jsp:param name="parentCategoryCode" value="<%=categoryCode%>" /> 
		<jsp:param name="pageIndex" value="<%=curpage%>" /> 
		<jsp:param name="pageSize" value="6" /> 
		<jsp:param name="varName" value="categoryListData" />
		<jsp:param name="fileds" value="-1" />
	</jsp:include>
	
	window.onload = function(){
		
		parent.categoryListData = categoryListData;
		parent.bindCategoryListData();
		
	}

</script>