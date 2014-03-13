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

int currCount = 1;
int pageIndex = Integer.parseInt(request.getParameter("pageIndex"));
String currDate = request.getParameter("currdate");
int startRecord = (pageIndex - 1) * pageSize;
ArrayList programList = (ArrayList) metaData.getChannelRecBill(Integer.parseInt(channelId),pageSize,startRecord,-1,currDate);//metaData.getRecBill(Integer.parseInt(channelId));// metaData.getChanBill(Integer.parseInt(channelId));//metaData.getRecBill(Integer.parseInt(channelId),currDate);
if(programList != null && programList.size() == 2)
{
HashMap totalHash  = (HashMap) programList.get(0);
totalRecord = ((Integer)((HashMap)programList.get(0)).get("COUNTTOTAL")).intValue();
if(totalRecord % pageSize == 0)
pageCount = totalRecord  / pageSize;
else
pageCount = (totalRecord  / pageSize) + 1;
ArrayList detailList = (ArrayList) programList.get(1);
JSONArray jsondetailList = JSONArray.fromObject(detailList);
JSONObject result = new JSONObject();
result.put("data",jsondetailList);
result.put("count",pageCount);
response.getWriter().print(result); 		
}

%>