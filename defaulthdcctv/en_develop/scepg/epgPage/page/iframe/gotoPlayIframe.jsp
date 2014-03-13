<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../../../config/properties.jsp"%>

<%
String strFile="../../../" + datajspname  + "/vodInfo.jsp";
String vodListFile="../../../" + datajspname  + "/vodList.jsp";         
String programCode = request.getParameter("programCode")==null?"-1":request.getParameter("programCode");
String contentCode = request.getParameter("contentCode")==null?"-1":request.getParameter("contentCode");
String categoryCode = request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>

<script type="text/javascript">
	<jsp:include page="<%=strFile%>">
		<jsp:param name="programCode" value="<%=programCode%>" /> 
		<jsp:param name="contentCode" value="<%=contentCode%>" /> 
		<jsp:param name="categoryCode" value="<%=categoryCode%>" /> 
		<jsp:param name="varName" value="vodInfoData" /> 
		<jsp:param name="isBug" value="1" />
	</jsp:include>
	
	window.onload = function(){
		parent.gotoPlay(vodInfoData);
	}
	
</script>



</head>

<body>
</body>
</html>