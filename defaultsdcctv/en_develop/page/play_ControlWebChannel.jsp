<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
	String jumuUrl = request.getParameter("jumuUrl");
	if(null != jumuUrl)
	{
		response.sendRedirect(jumuUrl);
	}
%>