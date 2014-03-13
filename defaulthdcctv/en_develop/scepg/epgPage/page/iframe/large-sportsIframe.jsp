<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<html>
<head>

<%
	//String datajspname = "hwdatajsp";
	String largeSportsRecCode = request.getParameter("catagoryCode");
	String pageIndex = request.getParameter("pageIndex");
	String strfile = "../../../" + datajspname  + "/vodList.jsp";
	System.out.println("large-sportsIframe.jsp%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"+largeSportsRecCode+"%"+pageIndex);
%>
   <script type="text/javascript">
   		 //专题推荐
		<jsp:include page="<%=strfile%>">
			<jsp:param name="categoryCode" value="<%=largeSportsRecCode%>"/> 
			<jsp:param name="varName" value="recContentList"/>
			<jsp:param name="fields" value="-1" /> 
			<jsp:param name="pageIndex" value="<%=pageIndex%>" /> 
			<jsp:param name="pageSize" value="3" />
			<jsp:param name="isBug" value="1" />
		</jsp:include>
   
   		window.onload = function(){
			parent.recTurnPageBind(recContentList);	
		}
   
   </script>
</head>
<body>
</body>
</html>