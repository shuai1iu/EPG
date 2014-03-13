<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ include file="../datasource/datasource.jsp"%>
<%@ include file="../datasource/property.jsp"%>
<%
    DataSource dataSource=new DataSource(request); 
	int pageIndex=dataSource.huaWeiUtil.getInt(request.getParameter("pageIndex"),1);
	int pageSize=dataSource.huaWeiUtil.getInt(request.getParameter("pageSize"),8);
    PkitEpgResult epgResult=dataSource.getChannels(pageIndex,pageSize,szayhzhibocode);
    
   List channels=new ArrayList();
   int pageCount=0;
   JSONArray jsonpage=null;
   if(epgResult!=null&&epgResult.getResultcode()==0&&epgResult.getDatas()!=null)
   {
	   channels=(List)epgResult.getDatas();
	   pageCount=epgResult.getPageCount();
   }
   jsonpage = JSONArray.fromObject(channels);
response.getWriter().print("{jsonchannellist:"+jsonpage+",jsonpagecount:"+pageCount+"}");
%>
