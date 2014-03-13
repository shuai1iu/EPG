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
    ArrayList vl=(ArrayList)metadata.getContentBySubjectId(request.getParameter("typeid"),-1,0);
    if(vl!=null && vl.size()>1 &&((ArrayList)vl.get(1)).size()>0 ){
             ArrayList pl=(ArrayList)vl.get(1);
             for(int i=0;i<pl.size();i++){
	         HashMap mp=(HashMap)pl.get(i);
		 if(mp!=null && mp.get("POSTERPATHS")!=null){
		 	HashMap postersMap = (HashMap)mp.get("POSTERPATHS");
		 	if(postersMap!=null && postersMap.get("1")!=null){
		         	String[] ars= (String[])postersMap.get("1");
	                 	if(ars.length>0){
			     		mp.put("POSTPATH",ars[0]);
			 	}		 
		 	}
		 }
	     }	     
             out.print(JSONArray.fromObject((ArrayList)vl.get(1)).toString());
    }
}
%>


