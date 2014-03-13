<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<%
  String  curpage=request.getParameter("curpage")==null?"1":request.getParameter("curpage");
  String categoryCode=request.getParameter("categoryCode")==null?"":request.getParameter("categoryCode");
  String pageSize=request.getParameter("pageSize")==null?"10":request.getParameter("pageSize");
  String vodListFile="../../../" + datajspname  + "/vodList.jsp";
 
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>getColumnNewsFrame</title>
<script type="text/javascript">

            <jsp:include page="<%=vodListFile%>">             
			<jsp:param name="categoryCode" value="<%=categoryCode%>" /> 
			<jsp:param name="pageIndex" value="<%=curpage%>" /> 
			<jsp:param name="pageSize" value="<%=pageSize%>" /> 
			<jsp:param name="varName" value="colNewsVodFiles" />
			<jsp:param name="fileds" value="-1" />
			<jsp:param name="isBug" value="1" />
			</jsp:include>
			
		
             function init()
			 {
                parent.callVodListData(colNewsVodFiles);
             }
			     
</script>

</head>

<body onload="init()">
</body>
</html>
