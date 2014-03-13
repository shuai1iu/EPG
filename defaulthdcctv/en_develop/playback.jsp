<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ include file="util/save_focus.jsp"%>
<%@ include file="playbackcontrol.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>

<html >
<head>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- ZTE -->
<meta name="page-view-size" content="1280*720" />
<title></title>
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
</head>

<body onLoad="initPage();">
<div class="main">
	
	<!--logo-->
	<div class="logo"><img src="images/logo.png" /></div>
	<div class="date" id="currDate"></div>
	
	
	
	<!--menu-->
	<div class="menu"> <!--焦点为 class="menuli on"  当前选中为 class="menuli current"-->
        <div><img src="images/menu_line.png" /></div>
        <div class="menuli" id="area0_list_0" style="top:1px"><img src="images/icon_0.png" />首  页</div> <!--class="menuli on"-->
        <div style="top:55px"><img src="images/menu_line.png" /></div>
        <div class="menuli" id="area0_list_1" style="top:56px"><img src="images/icon_1.png" />频  道</div>
        <div style="top:110px"><img src="images/menu_line.png" /></div>
        <div class="menuli" id="area0_list_2" style="top:111px"><img src="images/icon_2.png" />点  播</div>
        <div style="top:165px"><img src="images/menu_line.png" /></div>
        <div class="menuli" id="area0_list_3" style="top:166px"><img src="images/icon_3.png" />专  题</div>
        <div style="top:220px"><img src="images/menu_line.png" /></div>
        <div class="menuli" id="area0_list_4" style="top:221px"><img src="images/icon_4.png" />回  放</div>
        <div style="top:275px"><img src="images/menu_line.png" /></div>
        <div class="menuli" id="area0_list_5" style="top:276px"><img src="images/icon_5.png" />深  圳</div>
        <div style="top:330px"><img src="images/menu_line.png" /></div>
        <div class="menuli" id="area0_list_6" style="top:331px"><img src="images/icon_11new.png" />排  行</div>
        <div style="top:385px"><img src="images/menu_line.png" /></div>
        <div class="menuli" id="area0_list_7" style="top:386px"><img src="images/icon_7.png" />应  用</div>
        <div style="top:440px"><img src="images/menu_line.png" /></div>
        <div class="menuli" id="area0_list_8" style="top:441px"><img src="images/icon_9.png" />空  间</div>
        <div style="top:499px"><img src="images/menu_line.png" /></div>
        <div class="menuli" id="area0_list_9" style="top:500px"><img src="images/icon_10.png" />搜  索</div>
        <div style="top:555px"><img src="images/menu_line.png" /></div>
        </div>
	
	
	<!--mid-->	
	<div class="channel_sub" style="top:120px"> 
		<div class="sub" id="channel0"></div><!--class="on"-->
		<div class="sub" id="channel2"></div>
		<div class="sub" id="channel4"></div>
		<div class="sub" id="channel6"></div>
		<div class="sub" id="channel8"></div>
		<div class="sub" id="channel10"></div>
		<div class="sub" id="channel12"></div>
		<div class="sub" id="channel14"></div>
		<div class="sub" id="channel16"></div>
		<div class="sub" id="channel18"></div>
        <div class="sub" id="channel20"></div>
	</div>

	
	
	<!--r-->
	<div class="channel_sub2">
		<div class="sub" id="channel1"></div><!--class="on"-->
		<div class="sub" id="channel3"></div>
		<div class="sub" id="channel5"></div>
		<div class="sub" id="channel7"></div>
		<div class="sub" id="channel9"></div>
		<div class="sub" id="channel11"></div>
		<div class="sub" id="channel13"></div>
		<div class="sub" id="channel15"></div>
		<div class="sub" id="channel17"></div>
		<div class="sub" id="channel19"></div>
		<div class="sub" id="channel21"></div>
    </div>
    <div class="channel_up2"><img src="images/up.png"  id="pageup"/></div>
    <div class="channel_down2"><img src="images/down.png" id="pagedown" /></div>
  
    <div class="pages2" style=" left:1100px" id="page"></div>
  
	
	
	 <!--bottom_notice-->
	<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>
    <iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="0" height="0" ></iframe>
  
  

</div>
<!--初始化加载图片-->
    <div style="visibility:hidden; z-index:-1">
    <!--首页左边导航暗焦点--> 
    <img src="images/menu_bgon.png"/>
    <img src="images/menu_bgfocuson.png"/>
    </div>

</body>
<%@ include file="servertimehelp.jsp"%>
</html>
