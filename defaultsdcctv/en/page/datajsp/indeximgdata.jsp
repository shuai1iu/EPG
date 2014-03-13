<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>

<%
    MetaData metadata = new MetaData(request);
	int vasid= Integer.parseInt(request.getParameter("vasid"));
	ServiceHelp serviceHelp = new ServiceHelp(request);
	String url=serviceHelp.getVasUrl(vasid);
	Map map = metadata.getVasDetailInfo(vasid);
	JSONObject result = new JSONObject();
	
	result.put("img",map.get("POSTERPATH"));
	result.put("url",url);
	response.getWriter().print(result); 
%>