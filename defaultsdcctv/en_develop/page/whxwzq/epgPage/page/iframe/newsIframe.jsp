<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../config/code.jsp"%>
<%@ include file="../../../config/properties.jsp"%>
<%

	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	String categoryCode = request.getParameter("categoryCode")==null?"":request.getParameter("categoryCode");
	int curpage = request.getParameter("curpage")==null?1:Integer.parseInt(request.getParameter("curpage"));
    String categoryListFile="../../../" + datajspname + "/categoryList.jsp";

%>
<html>
<head>
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
	parent.bindCatalogListData();
}

</script>
</head>
<body></body>
</html>