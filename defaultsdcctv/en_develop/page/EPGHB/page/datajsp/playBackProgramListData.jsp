<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<script>
var jsonprevueList;
var recPrevueLength;
<%
String cruntChannelID= request.getParameter("channelid")==null?"0":request.getParameter("channelid");
String str_CurrDateTime = request.getParameter("currDateTime")==null?"20140102":request.getParameter("currDateTime");
int recPrevueLength=0;
JSONArray jsonprevueList = null; //节目单
ArrayList prevueList = new ArrayList();
MetaData metaData = new MetaData(request);


//当前日期
Date currDate = new java.util.Date();
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
int CurrDateTimes = Integer.parseInt(formatter.format(currDate));
int selectTimes =  Integer.parseInt(str_CurrDateTime);
//封装当前频道当前日期的回放节目单和直播节目单
String[] recPrevue = metaData.getRecBill(Integer.parseInt(cruntChannelID),str_CurrDateTime,1);
if(recPrevue != null && recPrevue.length > 0)
{
  for(int i = 0; i < recPrevue.length; i++)
  {
	  HashMap tempMap = new HashMap();
	  String[] temp = recPrevue[i].split("\u007f");
	  String tempDate = temp[0];
	  int tempDatetimes = Integer.parseInt(tempDate.substring(0,4)+tempDate.substring(5,7)+tempDate.substring(8,10));
	  if(tempDatetimes-selectTimes==0)
	  {
		  tempMap.put("channelID",cruntChannelID);
		  tempMap.put("currDate",tempDate);
		  String startTime = temp[1];
		  tempMap.put("startTime",startTime);
		  String name = temp[2];
		  tempMap.put("tvodProgramName",name);
		  String endTime = temp[3];
		  tempMap.put("endTime",endTime);
		  String tvodProgramId = temp[4];
		  tempMap.put("tvodProgramId",tvodProgramId);
		  String searchCode = temp[6];
		  tempMap.put("searchCode",searchCode);
		  tempMap.put("recPrevueNum",recPrevue.length);
		  prevueList.add(tempMap);
	  }	
  }
  
  recPrevueLength = prevueList.size();
}

if(CurrDateTimes-selectTimes<=0)
{
	String[] proPrevue = metaData.getProgBill(Integer.parseInt(cruntChannelID),str_CurrDateTime);
	if(proPrevue != null && proPrevue.length > 0)
	{
	  for(int i = 0; i < proPrevue.length; i++)
	  {
		  HashMap tempMap = new HashMap();
		  String[] temp = proPrevue[i].split("\u007f");
		  tempMap.put("channelID",cruntChannelID);
		  String tempDate = temp[0];
		  tempMap.put("currDate",tempDate);
		  String startTime = temp[1];
		  tempMap.put("startTime",startTime);
		  String name = temp[2];
		  tempMap.put("tvodProgramName",name);
		  String endTime = temp[3];
		  tempMap.put("endTime",endTime);
		  String tvodProgramId = temp[4];
		  tempMap.put("tvodProgramId",tvodProgramId);
		  String searchCode = temp[6];
		  tempMap.put("searchCode",searchCode);
		  prevueList.add(tempMap);
		  
	  }
	}
}
jsonprevueList = JSONArray.fromObject(prevueList);
%>
jsonprevueList = <%=jsonprevueList%>;
recPrevueLength = <%=recPrevueLength%>;
window.parent.tempProgramList=jsonprevueList;
window.parent.recPrevueLength=recPrevueLength;
window.parent.turnPageProgramList(jsonprevueList);
</script>