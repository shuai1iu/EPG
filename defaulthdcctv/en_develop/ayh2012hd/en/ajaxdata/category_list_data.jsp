<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ include file="../datasource/datasource.jsp"%>
<%@ include file="../datasource/property.jsp"%>
<%
    DataSource dataSource=new DataSource(request); 

	int pageIndex=dataSource.huaWeiUtil.getInt(request.getParameter("pageIndex"),1);
	int pageSize=dataSource.huaWeiUtil.getInt(request.getParameter("pageSize"),15);
	String categoryId=dataSource.huaWeiUtil.getString(request.getParameter("categoryId"));
	String posterType = dataSource.huaWeiUtil.getString(request.getParameter("posterType"));
	
	EpgResult epgResult=dataSource.getCategorys(pageIndex,pageSize,categoryId,posterType);
	
	int pageCount=0;
    List categorys=new ArrayList();
	JSONArray jsonpage=null;
	
    if(epgResult!=null&&epgResult.getResultcode()==0&&epgResult.getDatas()!=null){
	   categorys=(List)epgResult.getDatas();
	   pageCount=epgResult.getPageCount();
    }
	jsonpage=JSONArray.fromObject(categorys);
	
	response.getWriter().print("{jsoncategorylist:"+jsonpage+",jsonpagecount:"+pageCount+"}");
%>
