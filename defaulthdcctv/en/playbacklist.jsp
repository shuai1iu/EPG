<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ include file="util/save_focus.jsp"%>
<%@ include file="playbacklistcontrol.jsp"%>
<%@ include file="datajsp/playbackpagingData.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>


<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>回放列表_央视高清EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />

</head>

<body onLoad="initPage();">
<div class="main">
	
	<!--logo-->
	<div class="logo">回放</div>
	<div class="date" id="currDate"></div>
	
	
	
	<!--menu-->
  <div class="menu3"><!--焦点为 class="menuli on"  当前选中为 class="menuli current"-->
		<div><img src="images/menu_line.png" /></div>
	<div class="menuli"><div id="channel0" style="width:320px"></div></div> 
		<div><img src="images/menu_line.png" /></div>
	<div class="menuli " ><div id="channel1" style="width:320px"></div></div> 
		<div><img src="images/menu_line.png" /></div>
	<div class="menuli" ><div id="channel2" style="width:320px"></div></div> 
		<div><img src="images/menu_line.png" /></div>
	<div class="menuli"><div id="channel3" style="width:320px"></div></div> 
		<div><img src="images/menu_line.png" /></div>
	<div class="menuli"><div id="channel4" style="width:320px"></div></div> 
		<div><img src="images/menu_line.png" /></div>
	<div class="menuli"><div id="channel5" style="width:320px"></div></div> 
		<div><img src="images/menu_line.png" /></div>
	<div class="menuli"><div id="channel6" style="width:320px"></div></div> 
		<div><img src="images/menu_line.png" /></div>
	<div class="menuli"><div id="channel7" style="width:320px"></div></div> 
		<div><img src="images/menu_line.png" /></div>
	<div class="menuli"><div id="channel8" style="width:320px"></div></div> 
		<div><img src="images/menu_line.png" /></div>
	</div>
	
	
	
	<!--mid-->		
	<div class="playback_date"><!--焦点为 class="d_li on"  当前选中为 class="d_li current"-->
		<div align="center"><img src="images/up.png" /></div>
		<div class="d_li" id="date0"></div>
		<div class="d_li" id="date1"></div>
		<div class="d_li" id="date2"></div>
		<div class="d_li" id="date3"></div>
		<div class="d_li" id="date4"></div>
		<div class="d_li" id="date5"></div>
		<div class="d_li" id="date6"></div>
		<div align="center"><img src="images/down.png" /></div>
	</div>

	
	
	<!--r-->
<div class="channel_list wid2" style=" left:555px;">
		<div>节目列表</div>
		<div><img src="images/line4.png" width="630" /></div>
		<div class="p_li" id="p0"></div>
		<div class="p_li" id="p1"></div>
		<div class="p_li" id="p2"></div>
		<div class="p_li" id="p3"></div>
		<div class="p_li" id="p4"></div>
		<div class="p_li" id="p5"></div>
		<div class="p_li" id="p6"></div>
		<div class="p_li" id="p7"></div>
		<div class="p_li" id="p8"></div>
		<div class="p_li" id="p9"></div>
		<div class="p_li" id="p10"></div>
  </div>
<div class="channel_up"><img  id="pageup"/></div>
  <div class="channel_down"><img id="pagedown" /></div>

	 <!--bottom_notice-->
	<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>
     <iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="0" height="0" ></iframe>
     <iframe name="hidden_frame_channel" id="hidden_frame_channel" style=" display:none" width="0" height="0" ></iframe>
    

</div>
   <div style="visibility:hidden; z-index:-1">
    <!--首页左边导航暗焦点--> 
    <img src="images/menu_bgon2.png"/>
    <img src="images/menu_bgfocuson2.png"/>
     <img src="images/sub_bg2on.png"/>
    <img src="images/sub_bg2focuson.png"/>
    
    </div>
</body>
<%@ include file="servertimehelp.jsp"%>
</html>
