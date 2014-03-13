<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<%
  String categoryCode=request.getParameter("categoryCode")==null?"":request.getParameter("categoryCode");
  String vodListFile="../../../" + datajspname  + "/vodList.jsp";
  System.out.println(categoryCode+"*****************************1111***"+categoryCode);
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>dibTVCategoryListName</title>
<script type="text/javascript">

            <jsp:include page="<%=vodListFile%>">             
			<jsp:param name="categoryCode" value="<%=categoryCode%>" /> 
			<jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="10" /> 
			<jsp:param name="varName" value="dibTVCategoryListName" />
			<jsp:param name="fileds" value="-1" />
			<jsp:param name="isBug" value="1" />
			</jsp:include>
			
		
             function init(){
               parent.callCategoryData(dibTVCategoryListName);
              }
			
         
         
         
</script>

</head>

<body onload="init()">
</body>
</html>
