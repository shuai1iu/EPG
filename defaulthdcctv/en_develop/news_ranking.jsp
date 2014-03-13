<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ include file="newsrankingcontrol.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<title></title>
</head>

<body onLoad="initPage();">
<div class="main">
	
	<!--logo-->
	<div class="logo">新闻</div>
   <div class="date" id="currDate"></div>
	
	
	
	<!--menu-->
	<div class="menu2">
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="news0">滚动新闻</div> <!--焦点为class="menuli on"-->
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="news1">焦点新闻</div> <!--当前选中为class="menuli current"-->
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="news2">新闻名栏</div>    
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="news3">新闻排行</div>
		<div><img src="images/menu_line.png" /></div>
	</div>
	
 
 
 
	<!--mid-->
	<div class="news_pic">
		<div class="bg" id="pic0"><img src="" width="226" height="169" style="display:none;" /></div>
		<div class="bg" id="pic1"><img src="" width="226" height="169" style="display:none;" /></div>
		<div class="bg" id="pic2"><img src="" width="226" height="169" style="display:none;" /></div>
	</div>
	
	
	
	
	
	<!--r-->
	<div class="channel_list wid2" style=" left:580px;">
		<div class="title2">新闻列表</div>
		<div class="padtb"><img src="images/line4.png" width="630" /></div>
		<div class="p_li" id="newslist0"></div>
		<div class="p_li" id="newslist1"></div>
		<div class="p_li" id="newslist2"></div>
		<div class="p_li" id="newslist3"></div>
		<div class="p_li" id="newslist4"></div>
		<div class="p_li" id="newslist5"></div>
		<div class="p_li" id="newslist6"></div>
		<div class="p_li" id="newslist7"></div>
		<div class="p_li" id="newslist8" ></div>
		<div class="p_li" id="newslist9"></div>
  </div>
  <div class="pages" id="page"></div>
  <div class="channel_up" ><img id="pageup" src="images/up.png" /></div>
  <div class="channel_down"><img  id="pagedown" src="images/down.png" /></div>
	
	
	
	
	<!--bottom_notice-->
	<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>
    <iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="0" height="0" ></iframe>
 
</div>
 
</body>
<%@ include file="servertimehelp.jsp"%>

</html>