<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>页面跳转页（点播：二级列表or专题列表）</title>
<style type="text/css">
body {
    background: #0d4764 url("../images/bg02.jpg") no-repeat;
}
</style>
<%@ include file="datajsp/codepage.jsp"%>
</head>

<body>
<%
  //获取参数
	String tmp_parm = request.getQueryString();	
	String typeid = request.getParameter("typeid")==null?"-1":request.getParameter("typeid"); //子id
	MetaData metadata = new MetaData(request);
	int isSubTypeOrContent = metadata.getSubTypeOrContent(typeid);
%>
	<script>
	<%	
		if(isSubTypeOrContent==0){
	%>
			location.href = "vodlist.jsp?<%=tmp_parm %>";
	<%
		}else if(isSubTypeOrContent==1){	
	%>
			location.href = "vod-catelist.jsp?<%=tmp_parm %>";
	<%
		}else if(isSubTypeOrContent==0x07010000){
	%>
			location.href = "error.jsp";
	<%
		}
	%>
    </script>
</body>
</html>
