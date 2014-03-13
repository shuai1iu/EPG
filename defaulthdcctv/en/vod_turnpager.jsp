<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>页面跳转页（点播：单集or连续剧）</title>

</head>
<% /* ZTE */ %>
<body bgcolor="transparent">
<%
  //获取参数
	String tmp_parm = request.getQueryString();	
	Integer vodid = request.getParameter("vodid")==null?1:Integer.parseInt(request.getParameter("vodid")); //子id
	MetaData metadata = new MetaData(request);
	HashMap mediadetailInfo = (HashMap)metadata.getVodDetailInfo(vodid);
	String issitcom = "0";  				//影片类型 0:非连续剧父集 1:连续剧父集
	if(true||mediadetailInfo!=null){
			issitcom = mediadetailInfo.get("ISSITCOM").toString();
			if(issitcom.equals("0")){
%>
			<script>location.href="program_film.jsp?<%=tmp_parm %>";</script>
<%
			}else{
%>
			<script>location.href="program_tv_choose.jsp?<%=tmp_parm %>";</script>
<%
			}
	}else{
%>
			<script>location.href="index.jsp";</script>
<%
	}
%>
</body>
</html>
