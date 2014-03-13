<!-- 文件名：spaceCollectAddIframe.jsp -->
<!-- 描  述：添加收藏控制页面 -->
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="../../../config/properties.jsp"%>
<%
String programCode = request.getParameter("programCode")==null?"-1":request.getParameter("programCode");
String contentCode = request.getParameter("contentCode")==null?"-1":request.getParameter("contentCode");
String categoryCode = request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode");
String favoriteType = request.getParameter("favoriteType") == null ? "VOD" : request.getParameter("favoriteType");
String strFavouriteFile="../../../" + datajspname  + "/addFavourite.jsp";
%>
<jsp:include page="<%=strFavouriteFile%>">             
		<jsp:param name="contentCode" value="<%=contentCode%>" /> 
        <jsp:param name="categoryCode" value="<%=categoryCode%>" />
        <jsp:param name="programCode" value="<%=programCode%>" /> 
        <jsp:param name="favoriteType" value="<%=favoriteType%>" />
		<jsp:param name="varName" value="tempAddFav"/>
        <jsp:param name="isJson" value="-1"/>
</jsp:include>
<%
	JSONObject tempAddFav=new JSONObject();
	if(request.getAttribute("tempAddFav")!=null){
		tempAddFav = (JSONObject)request.getAttribute("tempAddFav");
	}
	System.out.println(tempAddFav.toString()+"wangss");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>spaceCollectAddIframe</title>
<script type="text/javascript">
var data=<%=tempAddFav%>;
		  function init(){
               parent.addCollect(data);
          }
</script>
</head>
<body onload="init()">
</body>
</html>
