<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<%
 
	 String programId = request.getParameter("channelID")==null?"":request.getParameter("channelID");
	 String getPlayUrlFile="../../../" + datajspname  + "/getPlayURL.jsp";	 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>dibTVCategoryListName</title>
<script type="text/javascript">
          <jsp:include page="<%=getPlayUrlFile%>">
			<jsp:param name="type" value="CHAN" />
			<jsp:param name="value" value="<%=programId%>" />  
			<jsp:param name="isBug" value="1" />
	      </jsp:include>
		  
		  function init()
		  {
               parent.callPlayUrlData(playUrl);
         }
</script>
</head>
<body onload="init()">
</body>
</html>
