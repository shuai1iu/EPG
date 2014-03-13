<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="codepage.jsp"%>
<%@ include file="database.jsp"%>
<html>
<head>
<script>
<%
    //String[][] s={{"TYPE_PICPATH","images/temp/11.jpg"}};
    //String[] ss={};
	 //ArrayList array=new MyUtil(request).getTypeListSimulateData(ss,s,3,curpage);
	 int curpage= Integer.parseInt(request.getParameter("curpage"));
	ArrayList array=new MyUtil(request).getTypeListData(zhuanticode,3,curpage);
%>
    window.parent.getdata(eval('('+'<%=array.get(0)%>'+')'),'<%=array.get(1)%>');
</script>
</head>
<body>
</body>
</html>
