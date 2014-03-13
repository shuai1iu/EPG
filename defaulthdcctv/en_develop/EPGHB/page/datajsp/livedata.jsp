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
var contentTotalList;
var jsonChannelList;
<%
int stratPosition = request.getParameter("stratPosition")==null?0:Integer.parseInt(request.getParameter("stratPosition"));
int isFirstFlag = request.getParameter("isFirstFlag")==null?0:Integer.parseInt(request.getParameter("isFirstFlag"));
String typeID = request.getParameter("typeID")==null?biaoqingzhibocode:request.getParameter("typeID");
int contentTotalList=0;
int pageSize=10;
JSONArray jsonChannelList = null; //节目列表
ArrayList tempList = new ArrayList();
MetaData metadata = new MetaData(request);
ArrayList result = metaData.getChanListByTypeId(typeID,pageSize,stratPosition);
if(result!=null&&result.size()>1)
{
	  ArrayList newresultList=(ArrayList)result.get(1);
	  HashMap tempType = (HashMap)result.get(0);
	  contentTotalList = ((Integer)tempType.get("COUNTTOTAL")).intValue();
	  for(int i=0;i<newresultList.size();i++)
	  {
			  HashMap tempMap = (HashMap)newresultList.get(i);
			  HashMap resultMap = new HashMap();
			  resultMap.put("CHANNELID",(String)tempMap.get("CHANNELID"));
			  resultMap.put("CHANNELNAME",(String)tempMap.get("CHANNELNAME"));
			  resultMap.put("ISTVOD",(String)tempMap.get("ISTVOD"));
			  resultMap.put("CHANNELINDEX",(String)tempMap.get("CHANNELINDEX"));
			  resultMap.put("ISSUBSCRIBED",(String)tempMap.get("ISSUBSCRIBED"));
			  resultMap.put("CHANNELTYPE",(String)tempMap.get("CHANNELTYPE"));
			  tempList.add(resultMap);
	  }
}
jsonChannelList = JSONArray.fromObject(tempList);
%>
isFirstFlag = <%=isFirstFlag%>;
jsonChannelList=<%=jsonChannelList%>;
contentTotalList = <%=contentTotalList%>;
if(isFirstFlag==1)
{
	window.parent.bindChannelList(jsonChannelList);
}
</script>