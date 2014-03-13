<!-- 文件名：util_AdText.jsp -->
<!-- 描  述：获取屏幕下方滚动字幕 -->
<!-- 修改人：yangtao -->
<!-- 修改时间：2010-8-10 -->
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="java.util.*" %>
<style type="text/css">
	.scroll {
		font-family:"Arial white", Gadget, sans-serif;
		color:#FFFFFF;
		position:absolute;
		left: 55px;
		top: 465px;
		width: 570px;
		height: 29px;
		line-height:29px;
	}
</style>

<%
    HashMap rollAd = null;
	ServiceHelp serviceHelp_Ad = new ServiceHelp(request);
	//随机获取一条滚动信息
	rollAd = serviceHelp_Ad.getAdText();
	//滚动信息
	String rollName = "��";
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
