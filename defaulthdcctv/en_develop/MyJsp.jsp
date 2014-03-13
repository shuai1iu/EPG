<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*"%> 
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="util/util_getPosterPaths.jsp" %>
<%
HashMap fullMap = new HashMap();
JSONObject jsontypeList = null; 
fullMap.put("totalSize",1);
fullMap.put("curPage",1);
fullMap.put("totalPage",1);
ArrayList fullTypeList = new ArrayList();
for(int i=0;i<3;i++){
  HashMap resultMap = new HashMap();
  resultMap.put("parentCategoryCode","111");
  resultMap.put("description","简历");
  resultMap.put("name","简历"+i);
  fullTypeList.add(resultMap);
}
  Map<Integer,String> map=new HashMap<Integer,String>(); 
      map.put(1, "zhu");
      map.put(2, "aa");
      map.put(3, "bbb");
      map.put(4, "ccc");
      map.put(5, "ddd");
      request.setAttribute("map", map);
fullMap.put("categoryList",fullTypeList);
jsontypeList = JSONObject.fromObject(fullMap);
request.setAttribute("testC",jsontypeList);
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>My JSP 'MyJsp.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>&nbsp; 
    This is my JSP page. <br>
    <c:forEach var="bean" items="${map}">
   		<div style="padding-left:50px;">${bean.key}333</div><br>
        <c:out value="${map.value}" /> 
    </c:forEach>
    
    <c:if test="${ 1 == 0}">
    	<div style="padding-left:50px;">222</div>
    </c:if>
  </body>
</html>
