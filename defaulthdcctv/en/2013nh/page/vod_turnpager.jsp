<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>页面跳转页（点播：单集or连续剧）</title>

</head>
<% /* ZTE */ %>
<body bgcolor="transparent">
<%
//获取参数
//   String tmp_parm = " returnurl=2013nh/page/nhindex.jsp&typeid=00000100000000090000000000018161"; 
// String tmp_parm = "typeid=00000100000000090000000000018161&returnurl=2013nh/page/nhindex.jsp";
String tmp_parm = request.getQueryString();
String typeid = request.getParameter("typeid")==null?"-1":request.getParameter("typeid"); 

MetaData metadata = new MetaData(request);
int isSubTypeOrContent = metadata.getSubTypeOrContent(typeid);	
// String typeid ="00000100000000090000000000018161";
//	MetaData metadata = new MetaData(request);
//	int isSubTypeOrContent = 0;
%>
<script>
<%
if(isSubTypeOrContent==0){
	%>
		location.href = "../../program_tvpart_choose2.jsp?<%=tmp_parm %>";
	<%
}else if(isSubTypeOrContent==1){
	%>
		location.href = "dibbling-column.jsp?<%=tmp_parm %>";
	<%
}else if(isSubTypeOrContent==0x07010000){
	%>
		location.href = "errorinfo.jsp?ERROR_ID=23&ERROR_TYPE=1&backurl=nhindex.jsp";
	<%
}
%>

</script>
</body>
</html>
