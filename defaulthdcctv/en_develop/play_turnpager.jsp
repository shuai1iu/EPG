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
<%@ include file="util/save_focus.jsp"%>
</head>
<!-- ZTE-->
<!--<body>-->
<body bgcolor="transparent">
<%
  //获取参数
	String tmp_parm = request.getQueryString();
	
	Integer vodid = request.getParameter("vodid")==null?1:Integer.parseInt(request.getParameter("vodid")); //子id
	String returnurl = request.getParameter("returnurl")==null?"index.jsp":request.getParameter("returnurl");
	MetaData metadata = new MetaData(request);
	String progid = "";
	//ISSITCOM
	HashMap mediadetailInfo = (HashMap)metadata.getVodDetailInfo(vodid);
	String issitcom = "0";  				//影片类型 0:非连续剧父集 1:连续剧父集
	if(mediadetailInfo!=null){
		issitcom = mediadetailInfo.get("ISSITCOM").toString();
	}
	if(issitcom.equals("0")){
%>
	   <script>
	   window.location.href="au_PlayFilm.jsp?PROGID=<%=vodid%>&PLAYTYPE=1&CONTENTTYPE=10&BUSINESSTYPE=1&returnurl="+escape('<%=returnurl %>');
       </script>
<%
	}else{
		List sitcom_result = (ArrayList)mediadetailInfo.get("SUBVODIDLIST");
		int subvodid =	(Integer)sitcom_result.get(0);	
%>
	 <script>
	   window.location.href="au_PlayFilm.jsp?PROGID=<%=subvodid %>&FATHERSERIESID=<%=vodid %>&PLAYTYPE=1&CONTENTTYPE=10&BUSINESSTYPE=1&returnurl="+escape('<%=returnurl %>');
       </script>
<%
	}
%>
</body>
</html>
