<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%

	int len = 0;
	MetaData metaData = new MetaData(request);
	String channelId = request.getParameter("channelId");
	int pageSize = 11;
	int totalRecord = 0;
	int pageCount = 0;
	HashMap timeHash = metaData.getChannelInfo(channelId);
	len = Integer.parseInt(timeHash.get("RECORDLENGTH").toString());
	int timeShiftLength = (int)len / 60;
	if(timeShiftLength < 1)
	timeShiftLength = 1;
	timeShiftLength = (int)timeShiftLength / 60 / 24;
	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	SimpleDateFormat formatterChinese = new SimpleDateFormat("yyyy年M月d日");
	Date currDate = new java.util.Date();
	Calendar  cal = Calendar.getInstance();
	cal.add(Calendar.DAY_OF_MONTH , -timeShiftLength);
	Date beforeDate = cal.getTime();
	String time = formatter.format(beforeDate);
	ArrayList channelDateList= new ArrayList();
	while(beforeDate.compareTo(currDate) <= 0 )
	{
			HashMap mydate=new HashMap();
			String dayOfMonth = Integer.toString(cal.get(Calendar.DAY_OF_MONTH));
			dayOfMonth = dayOfMonth.length() == 1 ? "0"+dayOfMonth:dayOfMonth;
			dayOfMonth +="日";
			mydate.put("date24",formatter.format(beforeDate));
			mydate.put("dateDay",dayOfMonth);
			//mydate.put("status","enable");
			channelDateList.add(mydate);
			cal.add(Calendar.DAY_OF_MONTH,1);
			beforeDate = cal.getTime();	
	}
		//小于7天,填充为7天
		
		JSONArray jsonDateList = JSONArray.fromObject(channelDateList);
		response.getWriter().print(jsonDateList); 
		//response.getWriter().print(timeShiftLength);
%>
