<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" buffer="64kb"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="java.util.HashMap"%>
<%
	String strVodId = request.getParameter("vodId");
	String backurl = request.getParameter("backurl");
	if("undefined".equals(strVodId) || "".equals(strVodId))
	{
		strVodId = "0";
	}
	int vodId = Integer.parseInt(strVodId);
    MetaData metaData = new MetaData(request);
	HashMap filmMap = (HashMap)metaData.getVodDetailInfo(vodId);
	int isSitcom = ((Integer)filmMap.get("ISSITCOM")).intValue();
	if(1 == isSitcom)
	{
		response.sendRedirect("TNL_lxj.jsp?vodId="+strVodId);
	}
	else
	{
		response.sendRedirect("../au_PlayFilm.jsp?PROGID="+strVodId+"&FATHERSERIESID=-1&BUSINESSTYPE=1&PLAYTYPE=1&CONTENTTYPE=0");
	}
%>