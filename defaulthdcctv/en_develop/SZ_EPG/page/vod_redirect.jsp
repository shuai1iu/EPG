<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="java.util.*"%>
<%
	MetaData metadata = new MetaData(request);
	int vodid = Integer.parseInt(request.getParameter("vodid"));
	HashMap detailMap = (HashMap)metadata.getVodDetailInfo(vodid);
	int type = (Integer)detailMap.get("ISSITCOM");
	String pageName = "";
	if(type == 1){
		pageName = "tv_detail.jsp?"+request.getQueryString();
		%>
			<script>
				window.location.href = "<%=pageName%>";
			</script>
		<%
	}else if(type == 0){
		pageName = "film_detail.jsp?"+request.getQueryString();
		%>
			<script>
				window.location.href = "<%=pageName%>";
			</script>
		<%
	}
%>