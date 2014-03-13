<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%
if(request.getParameter("typeid")!=null){
    MetaData metadata=new MetaData(request);
    HashMap map=metadata.getChannelInfo(request.getParameter("typeid"));
    if(map!=null){
       out.print(map.get("CODE"));

       out.print(map.get("VODID"));
       out.print(map.get("CHANNELNAME"));
       out.print(map.get("CHANNELINDEX"));
       out.print(map.get("CHANNELID"));
    } 
}
%>


