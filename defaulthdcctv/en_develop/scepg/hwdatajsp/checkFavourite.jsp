<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="java.util.*"%>
<%
	  String favoriteType = request.getParameter("favoriteType") == null ? "" : request.getParameter("favoriteType");
	  String categoryCode = request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode");
	  String programCode = request.getParameter("programCode") == null ? "-1" : request.getParameter("programCode");
	  String contentCode = request.getParameter("contentCode")==null?"-1":request.getParameter("contentCode");
	  int intfavoriteType=-1;
	  if(favoriteType.equals("VOD") ||  favoriteType.equals("TVOD")){
		intfavoriteType=0;
	  }
	  if(favoriteType.equals("CHAN")){
	 	intfavoriteType=1;
	  }
	  
	  String varName = request.getParameter("varName")==null?"tempFavourite":request.getParameter("varName");
	  String isBug = request.getParameter("isBug")==null?"-1":request.getParameter("isBug").toString();
	  String isJson = request.getParameter("isJson")==null?"1":request.getParameter("isJson").toString();
	  Boolean  isfaved = new Boolean("False");	
	  ServiceHelp shelper = new ServiceHelp(request);
	  boolean tempisfaved = shelper.isFavorited(Integer.parseInt(programCode),intfavoriteType);  //ÊÇ·ñÒÑÊÕ²Ø   
	  if(tempisfaved){
		 isfaved = new Boolean("True");	
	  }
	  request.setAttribute(varName,isfaved);
%>
<%
if(isBug.equals("1"))
{
	System.out.println(isfaved);
}
if(isJson.equals("1"))
{
%>	
var <%=varName%> = <%=isfaved%>;
<%
}
%>
