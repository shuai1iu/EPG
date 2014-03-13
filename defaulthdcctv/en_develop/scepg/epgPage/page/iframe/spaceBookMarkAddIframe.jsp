<!-- 文件名：spaceCollectAddIframe.jsp -->
<!-- 描  述：添加收藏控制页面 -->
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="../../../config/properties.jsp"%>
<%
String parentProgramCode = request.getParameter("parentProgramCode")==null?"-1":request.getParameter("parentProgramCode");
String programCode = request.getParameter("programCode")==null?"-1":request.getParameter("programCode");
String contentCode = request.getParameter("contentCode")==null?"-1":request.getParameter("contentCode");
String categoryCode = request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode");
String breakPoint = request.getParameter("breakPoint")==null?"-1":request.getParameter("breakPoint");
String totalTime = request.getParameter("totalTime")==null?"-1":request.getParameter("totalTime");
String bookMarkType = request.getParameter("bookMarkType") == null ? "VOD" : request.getParameter("bookMarkType");
String strBookMarkFile="../../../" + datajspname  + "/addBookMark.jsp";
%>
<jsp:include page="<%=strBookMarkFile%>">             
		<jsp:param name="contentCode" value="<%=contentCode%>" /> 
        <jsp:param name="categoryCode" value="<%=categoryCode%>" />
        <jsp:param name="programCode" value="<%=programCode%>" /> 
        <jsp:param name="parentProgramCode" value="<%=parentProgramCode%>" />
        <jsp:param name="totalTime" value="<%=totalTime%>" />
        <jsp:param name="breakPoint" value="<%=breakPoint%>" />
        <jsp:param name="bookMarkType" value="<%=bookMarkType%>" />
		<jsp:param name="varName" value="tempAddMark"/>
        <jsp:param name="isJson" value="-1"/>
</jsp:include>
<%
	JSONObject tempAddMark=new JSONObject();
	if(request.getAttribute("tempAddMark")!=null){
		tempAddMark = (JSONObject)request.getAttribute("tempAddMark");
	}
	System.out.println(tempAddMark.toString()+"wangss");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>spaceBookMarkAddIframe</title>
<script type="text/javascript">
var data=<%=tempAddMark%>;
		  function init(){
               parent.addBookMarkResult(data);
          }
</script>
</head>
<body onload="init()">
</body>
</html>
