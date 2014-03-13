<!-- 文件名：self_Native_Data.jsp -->
<!-- 描  述：本地页面数据层 -->
<!-- 修改人：zhanghui -->
<!-- 修改时间：2010-8-9-->
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ include file="SubStringFunction.jsp"%>
<%
	TurnPage turnPage = new TurnPage(request);
	turnPage.addUrl();

	String preFocus = null == request.getParameter("PREFOUCS") ? "0,0,0" : request.getParameter("PREFOUCS");
	/*以下做对页面初始化焦点的解析*/
	String[] preFocusArray = preFocus.split(",");
	//String areaFlag = preFocusArray[0];
	String curr_Index = preFocusArray[1];
	//String page_Index = preFocusArray[2];
	/*以上做对页面初始化焦点的解析*/	
%>