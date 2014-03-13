<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ include file="package_control.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>
<html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<style>
<!--
	body { background:url(images/bg.jpg) no-repeat}
	.r-poster {
		height:518px;
		left:312px;
		position:absolute; 
		top:102px;
		width:890px;
	}
	.r-poster .pic {
		height:518px;
		left:0;
		position:absolute; 
		top:0;
		width:890px;
	}
	.r-poster .pic img {
		height:483px;
		left:16px;
		position:absolute; 
		top:16px;
		width:858px;
	}
	.r-poster div.on {
		background:url(images/package-poster-bgon.png) no-repeat;
	}
-->
</style>
</head>
<body  onLoad="loadData();">
<div class="main"> 
	<!--logo--> 
	<div class="logo"><img src="images/logo.png" /></div> 
	<div class="date" id="currDate"></div>

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
		<div class="menuli" id="area0_list_6" style="top:331px"><img src="images/icon_7.png" />应  用</div>
		<div style="top:385px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_7" style="top:386px"><img src="images/icon_8.png" />套  餐</div>
		<div style="top:440px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_8" style="top:441px"><img src="images/icon_9.png" />空  间</div>
		<div style="top:499px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_9" style="top:500px"><img src="images/icon_10.png" />搜  索</div>
		<div style="top:555px"><img src="images/menu_line.png" /></div>
	</div>
	<!--film-->	
	<div class="dibb" style="width:850px" id="dibblist"> 
		<div class="arrow"><img id="pageup" src="images/up.png" /></div> 
		<div class="package_list"> 
			<div class="bg" id="area1_list_0"> 
				<img id="area1_list_img0" src="" width="690" height="148" /> 
				<div id="area1_list_text0" class="f"></div> 
		    </div> 
			<div class="bg" style="top:168px"  id="area1_list_1"> 
				<img id="area1_list_img1" src="" width="690" height="148" /> 
			  <div id="area1_list_text1" class="f"></div> 
			</div> 
			<div class="bg"  style="top:336px" id="area1_list_2"> 
				<img id="area1_list_img2" src="" width="690" height="148" /> 
				<div id="area1_list_text2" class="f"></div> 
			</div> 
		</div> 
		<div class="arrow" style="top:535px"><img id="pagedown" src="images/down.png" /></div> 
    </div> 
	<div class="pages3" id="pagearea">1/2</div> 
    
    <!--r-poster--->
	<div class="r-poster" id="dibbdetail" style="display:none"> <!--焦点为 class="pic on" -->
		<div class="pic on"><img id="imgdibbdetail" src="*" /></div> <!--poster01.jpg/poster02.jpg/poster03.jpg-->
	</div>

	 <!--bottom_notice-->
	<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>
    <iframe name="hidden_frame" id="hidden_frame"  style=" display:none" width="0" height="0" ></iframe>
</div> 
    <div style="visibility:hidden; z-index:-1">
    <!--首页左边导航暗焦点--> 
     <img src="images/menu_bgon.png"/>
     <img src="images/menu_bgfocuson.png"/>
     <img src="images/pic_bg10on.png"/>
     <img src="images/temp/packimgBack.jpg"/>
     <img src="images/temp/packimg2Back.jpg"/>
     <img src="images/temp/packimg3Back.jpg"/>
    </div>
    <%@ include file="servertimehelp.jsp" %>
</body> 
</html> 