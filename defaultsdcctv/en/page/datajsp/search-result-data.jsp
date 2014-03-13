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
	String words = new String(request.getParameter("words").getBytes("ISO-8859-1"),"UTF-8");
	String searchType = request.getParameter("searchType");
	int pageSize = 10;
	int isSubVod = 1;
	int totalRecord = 0;
	int pageCount = 0;
	MetaData meta = new MetaData(request);
	ServiceHelp svcHelp = new ServiceHelp(request);
	List result =  null ;
	if(searchType.equals("programname"))
		result = svcHelp.searchFilmsByCode(words,0,-1,isSubVod);
	else if(searchType.equals("personname"))
	{
		result = svcHelp.searchFilmsByActor(words,0,-1,isSubVod);
	}
	//result = svcHelp.searchFilmsByName(words,0,-1,isSubVod);
	if(result != null)
	{
		totalRecord = Integer.parseInt(((HashMap)result.get(0)).get("COUNTTOTAL").toString()); //总数
		if(totalRecord % pageSize == 0)
			pageCount = totalRecord  / pageSize;
		else
			pageCount = (totalRecord  / pageSize) + 1;
		ArrayList tmpList = (ArrayList)result.get(1);
		JSONArray jsonArray = JSONArray.fromObject(tmpList);
		JSONObject resultList = new JSONObject();
		resultList.put("data",jsonArray);
		resultList.put("pageCount",pageCount);
		resultList.put("totalRecord",totalRecord);
	     response.getWriter().print(resultList);
		
	}
		//response.getWriter().print("test88888");

%>
