<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<title>本地</title>
<%@ include file="local_ctrl.jsp"%>
</head>
<body>
    <div class="main">
        <!--logo-->
        <div class="logo">
            <img src="images/logo.png" /></div>
           <%@ include file="servertimehelp.jsp" %>
	<div class="date" id="currDate"></div>
        <!--menu-->
        <div class="menu">
            <div><img src="images/menu_line.png" /></div>
			<div class="menuli" id="area0_list_0"><img src="images/icon_0.png" />首  页</div> <!--class="menuli on"-->
			<div><img src="images/menu_line.png" /></div>
			<div class="menuli" id="area0_list_1"><img src="images/icon_1.png" />频  道</div>
			<div><img src="images/menu_line.png" /></div>
			<div class="menuli" id="area0_list_2"><img src="images/icon_2.png" />点  播</div>
			<div><img src="images/menu_line.png" /></div>
       	 	<div class="menuli" id="area0_list_3"><img src="images/icon_3.png" />专  题</div>
			<div><img src="images/menu_line.png" /></div>
			<div class="menuli" id="area0_list_4"><img src="images/icon_4.png" />回  放</div>
			<div><img src="images/menu_line.png" /></div>
			<div class="menuli" id="area0_list_5"><img src="images/icon_5.png" />四  川</div>
			<div><img src="images/menu_line.png" /></div>
        	<div class="menuli" id="area0_list_6"><img src="images/icon_6.png" />成  都</div>
			<div><img src="images/menu_line.png" /></div>
			<div class="menuli" id="area0_list_7"><img src="images/icon_7.png" />应  用</div>
			<div><img src="images/menu_line.png" /></div>
			<div class="menuli" id="area0_list_8"><img src="images/icon_8.png" />套  餐</div>
			<div><img src="images/menu_line.png" /></div>
			<div class="menuli" id="area0_list_9"><img src="images/icon_9.png" />空  间</div>
			<div><img src="images/menu_line.png" /></div>
			<div class="menuli" id="area0_list_10"><img src="images/icon_10.png" />搜  索</div>
			<div><img src="images/menu_line.png" /></div>
        </div>
        <!--mid-->
        <div class="mid_sub">
            <!--焦点为 class="sub on"  当前选中为 class="sub current"-->
            <div>
                <img  id="pageup"/></div>
            <div class="sub" id="area1_list_0">
                 </div>
            <div class="sub" id="area1_list_1">
                </div>
            <div class="sub" id="area1_list_2">
                </div>
            <div class="sub" id="area1_list_3">
                </div>
            <div class="sub" id="area1_list_4">
                </div>
            <div class="sub" id="area1_list_5">
                 </div>
            <div class="sub" id="area1_list_6">
                </div>
            <div class="sub" id="area1_list_7">
                </div>
            <div class="sub" id="area1_list_8">
               </div>
            <div class="sub" id="area1_list_9">
                </div>
            <div class="sub" id="area1_list_10">
             </div>
            <div class="sub" id="area1_list_11">
              </div>
            <div>
                <img id="pagedown" /></div>
        </div>
        <div class="pages" id="page">
            1/2</div>
        <!--r-->
        <div class="r_ad2">
            <div id="area2_list_0">
                <img src="images/temp/4.jpg" id="img0" width="413" height="158" /></div>
            <div id="area2_list_1">
                <img src="images/temp/4.jpg" id="img1" width="413" height="158" /></div>
            <div id="area2_list_2">
                <img src="images/temp/4.jpg" id="img2" width="413" height="158" /></div>
        </div>
        <!--bottom_notice-->
       <div class="notice"><marquee>欢迎收看IPTV</marquee></div>
    </div>
    <iframe name="hidden_frame" id="hidden_frame" style="display: none" width="0" height="0">
    </iframe>
    
    <iframe name="hidden_frame2" id="hidden_frame2" style="display: none" width="0" height="0">
    </iframe>
    <div style="visibility:hidden; z-index:-1">
    <img src="images/menu_bgfocuson.png"/>
    <img src="images/sub_bgfocuson.png"/>
    <img src="images/sub_bgon.png"/>
    <img src="images/pic_bg3.png"/>
    <img src="images/menu_bgon.png"/>
</div>
</body>
</html>