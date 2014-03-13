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
<%@ include file="codepage.jsp"%>
<script>
var isFirstFlag;//0:第一次进入此页面，1:后面通过IFrame刷新数据的标识。
var jsonChannelList;
var jsonchannelDateList;
var jsonprevueList;
var recPrevueLength;
<%
int stratPosition = request.getParameter("stratPosition")==null?0:Integer.parseInt(request.getParameter("stratPosition"));
int isFirstFlag = request.getParameter("isFirstFlag")==null?0:Integer.parseInt(request.getParameter("isFirstFlag"));
String typeID = request.getParameter("typeID")==null?biaoqingzhibocode:request.getParameter("typeID");
int pageSize=10;
JSONArray jsonChannelList = null; //直播列表
JSONArray jsonchannelDateList = null; //日期列表
JSONArray jsonprevueList = null; //节目单
ArrayList tempList = new ArrayList();
ArrayList channelDateList=new ArrayList();
ArrayList prevueList = new ArrayList();
int recPrevueLength=0;
MetaData metaData = new MetaData(request);
ArrayList result = metaData.getChanListByTypeId(typeID,-1,0);
if(result!=null&&result.size()>1)
{
	  ArrayList newresultList=(ArrayList)result.get(1);
	  HashMap tempType = (HashMap)result.get(0);
	  for(int i=0;i<newresultList.size();i++)
	  {
			  HashMap tempMap = (HashMap)newresultList.get(i);
			  HashMap resultMap = new HashMap();
			  resultMap.put("CHANNELID",tempMap.get("CHANNELID"));
			  resultMap.put("CHANNELNAME",(String)tempMap.get("CHANNELNAME"));
			  resultMap.put("ISTVOD",tempMap.get("ISTVOD"));
			  resultMap.put("CHANNELINDEX",tempMap.get("CHANNELINDEX"));
			  resultMap.put("ISSUBSCRIBED",tempMap.get("ISSUBSCRIBED"));
			  resultMap.put("CHANNELTYPE",tempMap.get("CHANNELTYPE"));
			  tempList.add(resultMap);
	  }
	  
	  
	  
	  //封装日期
	  int recordLength = 0;
	  //String cruntChannelID = (((HashMap)tempList.get(0)).get("CHANNELID")).toString();
	  String cruntChannelID = request.getParameter("cruntChannelID")==""?(((HashMap)tempList.get(0)).get("CHANNELID")).toString():request.getParameter("cruntChannelID");
	  HashMap timeHash = metaData.getChannelInfo(cruntChannelID);
	  if(timeHash.get("RECORDLENGTH")!=null)
	  {
         recordLength = Integer.parseInt(timeHash.get("RECORDLENGTH").toString());
	  }
	  
	  //录了多少天
	  int dayNum = recordLength/(60*60*24);
	  
	  SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
      SimpleDateFormat formatterChinese = new SimpleDateFormat("yyyy年MM月dd日");
	  //当前日期
      Date currDate = new java.util.Date();
	  Calendar cal = Calendar.getInstance();
	  cal.add(Calendar.DAY_OF_MONTH, -dayNum);
	  Date beforeDate = cal.getTime();
	  while(beforeDate.compareTo(currDate) <= 0 )
	  {
		  HashMap mydate=new HashMap();
		  mydate.put("date24",formatter.format(beforeDate));
		  mydate.put("dateChinese",formatterChinese.format(beforeDate));
		  channelDateList.add(mydate);
		  cal.add(Calendar.DAY_OF_MONTH,1);
		  beforeDate = cal.getTime();	
     }
	 
	 
	 //封装当前频道当前日期的回放节目单和直播节目单
	//String str_CurrDateTime = formatter.format(currDate);
	String str_CurrDateTime = request.getParameter("currDateTime")==""?formatter.format(currDate):request.getParameter("currDateTime");
	String[] recPrevue = metaData.getRecBill(Integer.parseInt(cruntChannelID),str_CurrDateTime,1);
	
	String[] proPrevue = metaData.getProgBill(Integer.parseInt(cruntChannelID),str_CurrDateTime);
	if(recPrevue != null && recPrevue.length > 0)
	{
		for(int i = 0; i < recPrevue.length; i++)
		{
			HashMap tempMap = new HashMap();
			String[] temp = recPrevue[i].split("\u007f");
			String tempDate = temp[0];
			int selectTimes = Integer.parseInt(str_CurrDateTime);
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
			tempMap.put("recPrevueNum",recPrevue.length);
			prevueList.add(tempMap);
			
		}
	}
}
jsonChannelList = JSONArray.fromObject(tempList);
jsonchannelDateList = JSONArray.fromObject(channelDateList);
jsonprevueList = JSONArray.fromObject(prevueList);
%>
isFirstFlag = <%=isFirstFlag%>;
jsonChannelList=<%=jsonChannelList%>;
jsonchannelDateList = <%=jsonchannelDateList%>;
jsonprevueList = <%=jsonprevueList%>;
recPrevueLength = <%=recPrevueLength%>;
window.parent.recPrevueLength=recPrevueLength;
window.parent.tempchnnalList=jsonChannelList;
window.parent.tempProgramList=jsonprevueList;
window.parent.turnPageShowChnnnelList(jsonChannelList);
window.parent.bandDateData(jsonchannelDateList);
window.parent.turnPageProgramList(jsonprevueList);
</script>