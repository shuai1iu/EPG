<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="codepage.jsp"%>
<script>
var isFirstFlag;//0:第一次进入此页面，1:后面通过IFrame刷新数据的标识。
var jsonChannelList;
<%
int stratPosition = request.getParameter("stratPosition")==null?0:Integer.parseInt(request.getParameter("stratPosition"));
int isFirstFlag = request.getParameter("isFirstFlag")==null?0:Integer.parseInt(request.getParameter("isFirstFlag"));
String typeID = request.getParameter("typeID")==null?biaoqingzhibocode:request.getParameter("typeID");
int pageSize=10;
JSONArray jsonChannelList = null; //节目列表
ArrayList tempList = new ArrayList();
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
}
jsonChannelList = JSONArray.fromObject(tempList);
%>
isFirstFlag = <%=isFirstFlag%>;
jsonChannelList=<%=jsonChannelList%>;
window.parent.tempchnnalList=jsonChannelList;
window.parent.turnPageShowChnnnelList(jsonChannelList);
</script>