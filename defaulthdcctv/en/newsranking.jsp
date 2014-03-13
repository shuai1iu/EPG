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
		<div class="menuli current" id="news3">新闻排行</div>
		<div><img src="images/menu_line.png" /></div>
	</div>
	
 
 
 
	<!--mid-->
	<div class="news_pic">
		<div class="bgon"><img src="images/temp/14.jpg" width="226" height="169" /></div>
		<div class="bg"><img src="images/temp/14.jpg" width="226" height="169" /></div>
		<div class="bg"><img src="images/temp/14.jpg" width="226" height="169" /></div>
	</div>
	
	
	
	
	
	<!--r-->
	<div class="channel_list wid2" style=" left:580px;">
		<div class="title2">新闻列表</div>
		<div class="padtb"><img src="images/line4.png" width="630" /></div>
		<div class="p_li on" id="newslist0">1.特别呈现</div>
		<div class="p_li" id="newslist1">2.发现之路</div>
		<div class="p_li" id="newslist2">3.道德观察：观察世间百态</div>
		<div class="p_li" id="newslist3">4.动漫说法</div>
		<div class="p_li" id="newslist4">5.法律讲堂：专家主题讲座</div>
		<div class="p_li" id="newslist5">6.法治视界</div>
		<div class="p_li" id="newslist6">7.天网</div>
		<div class="p_li" id="newslist7">8.心理访谈：关注心理健康</div>
		<div class="p_li" id="newslist8" >9.一线</div>
		<div class="p_li" id="newslist9">10.法律讲堂：专家主题讲座</div>
  </div>
  <div class="pages4" id="page">1/10</div>
  <div class="channel_up"><img src="images/up.png" /></div>
  <div class="channel_down"><img src="images/down.png" /></div>
	
	
	
	
	 <!--bottom_notice-->
	<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>
    <iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="0" height="0" ></iframe>
 
</div>
 
</body>
<%@ include file="servertimehelp.jsp"%>

</html>