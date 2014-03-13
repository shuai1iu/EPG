<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="datajsp/search_result_data.jsp" %>
<%@ include file="search_result_ctrl.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>搜索结果_央视高清EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<style>
<!--

-->
</style>

<body>
<div class="main">
	
	<!--logo-->
	<div class="logo">搜索结果</div>
	<div class="date" id="currDate">2011年5月30日 | 15:00</div>
	
	
	
	<!--menu-->
	<div class="menu2"> <!--焦点为 class="menuli on"  当前选中为 class="menuli current"-->
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli"><%=request.getParameter("keyword")!=null?request.getParameter("keyword"):"空白"%></div>
		<div><img src="images/menu_line.png" /></div>
	</div>
	
	
	
	<!--search_result-->
	<div class="search_result">
		<div align="center"><img src="images/up_gray.png" /></div>
		<div class="r_li on" id="result0">夏晚莲波</div>
		<div class="r_li" id="result1">新娃俩爸</div>
		<div class="r_li" id="result2">新闻联播</div>
		<div class="r_li" id="result3">下午聊吧</div>
		<div class="r_li" id="result4">夏晚莲波01</div>
		<div class="r_li" id="result5">夏晚莲波02</div>
		<div class="r_li" id="result6">夏晚莲波03</div>
		<div class="r_li" id="result7">夏晚莲波04</div>
		<div class="r_li" id="result8">夏晚莲波05</div>
		<div class="r_li" id="result9">下午聊吧十一特别节目</div>
		<div class="r_li" id="result10"></div>
		<div class="r_li" id="result11"></div>
		<div align="center"><img src="images/down_gray.png" /></div>
	</div>	
	<!--bottom_notice-->
	<div class="notice"><marquee id="buttom_txt">欢迎观看IPTV</marquee><div>
</div>
<%@ include file="servertimehelp.jsp" %>
<div style="visibility:hidden; z-index:-1">
    	<img src="images/search_list_bgon.png"/>              
	</div>
</body>
</html>
