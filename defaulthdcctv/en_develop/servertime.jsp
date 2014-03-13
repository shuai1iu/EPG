<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
 <%@ page import="java.text.*"%> 
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>

	<%
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy年M月d日 HH:mm");
		Date currDate = new java.util.Date();
		String str_CurrDateTime = formatter.format(currDate);
		response.getWriter().print(str_CurrDateTime); 
	%>	

