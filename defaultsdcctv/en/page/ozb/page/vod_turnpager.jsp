<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.HashMap"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>页面跳转页（点播：单集or连续剧）</title>
</head>

<body>
<%
  //获取参数
	String vodid = request.getParameter("vodid"); //影片id
	String returnurl = request.getParameter("returnurl");
	String typeid = "-1";			
	MetaData metadata = new MetaData(request);
	HashMap tmpmediaoinfo_map = (HashMap)metadata.getVodDetailInfo(Integer.parseInt(vodid));
	if(tmpmediaoinfo_map!=null){
		typeid = ((String[])tmpmediaoinfo_map.get("allTypeId"))[0];
	}
		String url = "vod-detail.jsp?typeid="+typeid+"&vodid="+vodid;
%>
<script>
	location.href = '<%=url %>&returnurl='+escape('<%=returnurl %>');
</script>

</body>
</html>
