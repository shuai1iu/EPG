<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" buffer="64kb"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="java.util.HashMap"%>
<%
	String strVodId = request.getParameter("vodid");
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
		response.sendRedirect("../play_controlVod.jsp?PROGID="+strVodId+"&FATHERSERIESID=-1&PLAYTYPE=1&BEGINTIME=0&PRODUCTID=0&SERVICEID=0&ONECEPRICE=0&CONTENTTYPE=10&returnurl="+backurl);
	}
	
/*	
	String code = request.getParameter("code");
	String backurl = request.getParameter("backurl");
	MetaData metaData = new MetaData(request);
	HashMap filmMap = (HashMap)metaData.getContentDetailInfoByCode(code,200);
	System.out.println("--------pm-------code:"+code);
	System.out.println("---===========pm--------filmMap:"+filmMap);
	int isSitcom = ((Integer)filmMap.get("ISSITCOM")).intValue();
	int vodId = ((Integer)filmMap.get("VODID")).intValue();
	if(1 == isSitcom)
	{
		response.sendRedirect("TNL_lxj.jsp?vodId="+vodId);
	}
	else
	{
		response.sendRedirect("../play_controlVod.jsp?PROGID="+vodId+"&FATHERSERIESID=-1&PLAYTYPE=1&BEGINTIME=0&PRODUCTID=0&SERVICEID=0&ONECEPRICE=0&CONTENTTYPE=10&backurl="+backurl);
	}*/
%>