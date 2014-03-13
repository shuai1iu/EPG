<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ include file="news_rollingcontrol.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
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
	<div class="playback_date"><!--焦点为 class="d_li on"  当前选中为 class="d_li current"-->
		<div align="center"><img src="images/up.png"  id="catalogpageup"/></div>
		<div class="d_li2" id="item0"></div>
		<div class="d_li2" id="item1"></div>
		<div class="d_li2" id="item2"></div>
		<div class="d_li2" id="item3"></div>
		<div class="d_li2" id="item4"></div>
		<div class="d_li2" id="item5"></div>
		<div class="d_li2" id="item6"></div>
		<div class="d_li2" id="item7"></div>
		<div class="d_li2" id="item8"></div>
		<div class="d_li2" id="item9"></div>
		<div align="center"><img src="images/down.png" id="catalogpagedown" /></div>
	</div>
 
	
	
	<!--r-->
	<div class="channel_list wid2" style=" left:555px;">
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
  <div class="pages4" id="page"></div>
  <div class="channel_up"><img src="images/up_gray.png"  id="pageup"/></div>
  <div class="channel_down"><img src="images/down_gray.png"  id="pagedown"/></div>
  
  
	
	
	 <!--bottom_notice-->
	<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>
    <iframe name="hidden_frame_item" id="hidden_frame_item" style=" display:none" width="0" height="0" ></iframe>
     <iframe name="hidden_frame_news" id="hidden_frame_news" style=" display:none" width="0" height="0" ></iframe>
 
</div>
  <div style="visibility:hidden; z-index:-1">
    <!--首页左边导航暗焦点--> 
    <img src="images/menu_bgon.png"/>
    <img src="images/menu_bgfocuson.png"/>
     <img src="images/sub_bg2on.png"/>
    <img src="images/sub_bg2focuson.png"/>
    
    </div>
</body>
<%@ include file="servertimehelp.jsp"%>
</html>
