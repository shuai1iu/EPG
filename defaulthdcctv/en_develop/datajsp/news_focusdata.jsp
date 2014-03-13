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
    //String[][] imgs={{"TYPE_PICPATH","images/temp/13.jpg"}};
    //String[] texts={"TYPE_NAME","TYPE_INTRODUCE"};
	String typeId = request.getParameter("typeid")==null?jiaodianxinwencode:request.getParameter("typeid");
	ArrayList array=new MyUtil(request).getTypeListData(typeId,3);
	//ArrayList array=new MyUtil(request).getTypeListSimulateData(texts,imgs,3);
%>
    var list=eval('('+'<%=array.get(0)%>'+')');
	var pagecount='<%=array.get(1)%>';
	
</script>