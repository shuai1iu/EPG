
<%@ page  language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="java.util.*" %>

<%
    HashMap rollAd = null;
	ServiceHelp serviceHelp_Ad = new ServiceHelp(request);
	//随机获取一条滚动信息
	rollAd = serviceHelp_Ad.getAdText();
	//滚动信息
	String rollName = "";
	//信息循环次数
	int reTime = 0;
	//循环速度 (1:快速 2:中速; 3:慢速)
	int speed = 0;
	
	if(null != rollAd)
	{
	    rollName = (String)rollAd.get("ADTEXT_NAME");
	
	    reTime = (Integer)rollAd.get("RECYCLE_TIME");
	
	    speed = (Integer)rollAd.get("RECYCLE_SPEED");
	}
	
%>