<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%
	TurnPage tpage = new TurnPage(request); 
	tpage.addUrl(request.getRequestURI()+"?"+request.getQueryString());
%>
<script>
	parent.window.alert("<%=tpage.go(0) %>");
</script>