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
<%@ include file="database.jsp"%>
<script>
<%
    //String[][] imgs={{"PICPATH","images/temp/15.jpg"}};
    //String[] texts={"VODNAME"};
	//ArrayList array=new MyUtil(request).getVodListSimulateData(texts,imgs,10);
	String code= request.getParameter("code");
	int type= Integer.parseInt(request.getParameter("type"));
	ArrayList array=null;
	if(type==1||type==9999)
	    array=new MyUtil(request).getVodListData(code,3);
	else if(type==3)
		array=new MyUtil(request).getLiveListData(code,3);
		
%>

    var list=eval('('+'<%=array!=null?array.get(0):null%>'+')');
	var pagecount='<%=array!=null?array.get(1):1%>';
	var type='<%=type%>';
</script>