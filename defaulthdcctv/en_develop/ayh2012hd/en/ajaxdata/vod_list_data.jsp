﻿<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ include file="../datasource/datasource.jsp"%>
<%@ include file="../datasource/property.jsp"%>
<%
	DataSource dataSource=new DataSource(request); 
	
	int pageIndex=dataSource.huaWeiUtil.getInt(request.getParameter("pageIndex"),1);
	int pageSize=dataSource.huaWeiUtil.getInt(request.getParameter("pageSize"),10);
	String categoryId=request.getParameter("categoryId");
	String posterType=request.getParameter("posterType");
	int pageCount=0;
	
	//int pageIndex,int pageSize,String categoryid,String postertype  
    //EpgResult epgResult=dataSource.getVodInfos(pageIndex,pageSize,categoryId,posterType);不需要单集和多集采用list来存放时使用
	EpgResult epgResult=dataSource.getVodInfoListByTypeId(pageIndex,pageSize,categoryId,posterType);
    List vods=new ArrayList();
	JSONArray jsonpage=null;
    if(epgResult!=null&&epgResult.getResultcode()==0&&epgResult.getDatas()!=null){
	   vods=(List)epgResult.getDatas();
	   pageCount=epgResult.getPageCount();
    }
	jsonpage=JSONArray.fromObject(vods);
	
	response.getWriter().print("{jsonvodlist:"+jsonpage+",jsonpagecount:"+pageCount+"}");
%>
