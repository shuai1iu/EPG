<!-- 文件名：self_KindIntro_Data.jsp -->
<!-- 描  述：套餐页面数据层 -->
<!-- 修改人：zhanghui -->
<!-- 修改时间：2010-8-9-->
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%
	TurnPage turnPage = new TurnPage(request);
	turnPage.addUrl();
	String type=request.getParameter("ECTYPE");
	int itype = 0;
	try
	{
		itype=Integer.parseInt(type);
	}
	catch(Exception e)
	{
		
	}
%>

