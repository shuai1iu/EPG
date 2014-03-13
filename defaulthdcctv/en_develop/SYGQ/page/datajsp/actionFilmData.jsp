<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray"%>
<%@ page import="net.sf.json.JSONObject"%>
<%@ include file="codepage.jsp"%>
<%@ include file="../util/util_getPosterPaths.jsp"%>
<script>
var isFirstFlag;//0:第一次进入此页面，1:后面通过IFrame刷新数据的标识。
var contentTotal;
var dongzuoData;
<%
JSONArray jsonvodlist = null; //节目列表
String postertype = "1";
int pagesize=8;
int stratPosition = request.getParameter("stratPosition")==null?0:Integer.parseInt(request.getParameter("stratPosition"));
int isFirstFlag = request.getParameter("isFirstFlag")==null?0:Integer.parseInt(request.getParameter("isFirstFlag"));
int contentTotal=0;
MetaData metadata = new MetaData(request);
ArrayList vodlist = (ArrayList)metadata.getVodListByTypeId(dongzuo,pagesize,stratPosition);
ArrayList tempList = new ArrayList();
ArrayList vod_list = new ArrayList();
if(vodlist!=null && vodlist.size() > 1 && ((ArrayList)vodlist.get(1)).size() > 0)
{
	vod_list = (ArrayList)vodlist.get(1);
	HashMap temp = (HashMap)vodlist.get(0);
	contentTotal = ((Integer)temp.get("COUNTTOTAL")).intValue();
}
for(int i = 0;i<vod_list.size();i++)
{
	Object obj = vod_list.get(i);
	HashMap tempmap = new HashMap();
	String tmpvodid = ((HashMap)obj).get("VODID").toString();
	String tmpvodname = ((HashMap)obj).get("VODNAME").toString();
	tempmap.put("VODID",tmpvodid);
	tempmap.put("VODNAME",tmpvodname);
	//海报信息
	HashMap postersMap = (HashMap)(((HashMap)obj).get("POSTERPATHS"));
	String picpath = (String)((HashMap)obj).get("PICPATH");
	String postpath =  getPosterPath(postersMap,request,picpath,postertype).toString();
	tempmap.put("POSTERPATHS","../"+postpath);
	tempList.add(tempmap);
}

jsonvodlist = JSONArray.fromObject(tempList);
//response.getWriter().print(jsonvodlist);
%>
isFirstFlag = <%=isFirstFlag%>;
dongzuoData=<%=jsonvodlist%>;
contentTotal = <%=contentTotal%>;
if(isFirstFlag==1)
{
	window.parent.bindFilmsData(dongzuoData);
}
</script>