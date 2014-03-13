<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../config/code.jsp"%>
<%@ include file="../../../config/properties.jsp"%>
<%

	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	String categoryCode = request.getParameter("categoryCode")==null?"":request.getParameter("categoryCode");
	int curpage = request.getParameter("curpage")==null?1:Integer.parseInt(request.getParameter("curpage"));
	
    String vodListFile="../../../" + datajspname + "/vodList.jsp";

%>
<html>
<head>
<script>

<jsp:include page="<%=vodListFile%>">
	<jsp:param name="categoryCode" value="<%=categoryCode%>" /> 
	<jsp:param name="varName" value="vodListData" /> 
	<jsp:param name="pageIndex" value="<%=curpage%>" /> 
	<jsp:param name="pageSize" value="10" />
	<jsp:param name="fields" value="-1" />
</jsp:include>

window.onload = function(){
	parent.vodListData = vodListData;
	parent.bindVodListData();
}

</script>
</head>
<body></body>
</html>