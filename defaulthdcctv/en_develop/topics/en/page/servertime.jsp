<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
 <%@ page import="java.text.*"%> 
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>

	<%
		/*String[] weekDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};
		Calendar  cal = Calendar.getInstance();
		int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK) - 1;
		if(dayOfWeek < 0)
			dayOfWeek = 0;
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy年M月d日 HH:mm");
		Date currDate = new java.util.Date();
		String str_CurrDateTime = formatter.format(currDate) + " " + weekDays[dayOfWeek];*/
		Calendar calendar = Calendar.getInstance();
        String hour = ((Integer)calendar.get(Calendar.HOUR_OF_DAY)).toString();
        String minute = ((Integer)calendar.get(Calendar.MINUTE)).toString();
        minute = minute.length() < 2?"0"+minute :minute;
		response.getWriter().print(hour + ":"+minute); 
	%>	

