<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%> 

	<%
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("M/d,HH:mm");
		Date currDate = new java.util.Date();
		String str_CurrDateTime = formatter.format(currDate);
		String[] str = str_CurrDateTime.split(",");
		String str1 = str[0];
		String str2 = str[1];
		
	%>	

<script type="text/javascript">
	var time1 = '<%=str1%>';
	var time2 = '<%=str2%>';
</script>