<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<script>
<%
JSONArray recChannelBill=null;
MetaData metaData = new MetaData(request);
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
Date currDate = new java.util.Date();
String str_CurrDateTime = formatter.format(currDate);
int channelid= Integer.parseInt(request.getParameter("channelid"));
String[] recBill=metaData.getProgBill(channelid,str_CurrDateTime);
ArrayList list=new ArrayList();
int count=0;
if(recBill!=null)
{
   count=recBill.length>4?4:recBill.length;
   for(int i=0;i<count;i++)
   {
	   String s=recBill[i].substring(10,11);
	   String[] pros=recBill[i].split(s);
	   HashMap map = new HashMap();
	   map.put("startdate",pros[0]);
	   map.put("starttime",pros[1]);
	   map.put("proname",pros[2]);
	   map.put("endtime",pros[3]);
	   map.put("proid",pros[4]);
	   map.put("canbook",pros[5]);
	   map.put("searchcode",pros[6]);
	   map.put("status",pros[8]);
	   map.put("code",pros[9]);
	   list.add(map);
   }
}
recChannelBill = JSONArray.fromObject(list);
%>
var recChannelBill=<%=recChannelBill%>;
window.parent.bindProgram(recChannelBill);
</script>
