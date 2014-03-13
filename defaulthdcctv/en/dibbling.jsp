<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ include file="datajsp/util_AdText.jsp"%>
<%@ include file="util/save_focus.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<title>点播</title>
<%@ include file="datajsp/codepage.jsp"%>
<%@ include file="dibbling_ctrl.jsp"%>
<%@ include file="datajsp/dibbling_data.jsp"%>
<%@ include file="util/util_getPosterPaths.jsp"%>
</head>
<body>
    <div class="main">
        <!--logo-->
        <div class="logo">
            <img src="images/logo.png" /></div>
           
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
        <div class="mid_sub">
            <!--焦点为 class="sub on"  当前选中为 class="sub current"-->
            <div>
                <img id="pageup" /></div>
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
                <img id="pagedown"  /></div>
        </div>
        <div class="pages" id="page">
            </div>
        <!--r-->
        <div class="r_ad2">
            <div id="area2_list_0" style="top:-25px">
                <img src="#" id="img0" width="413" height="158" style="" /></div>
            <div id="area2_list_1" style="top:158px">
                <img src="#" id="img1" width="413" height="158"  /></div>
            <div id="area2_list_2"  style="top:338px">
                <img src="#" id="img2" width="413" height="158"  /></div>
        </div>
       <!--bottom_notice-->
	<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>
    </div>
    <iframe name="hidden_frame" id="hidden_frame" style="display: none" width="0" height="0">
    </iframe>
    
    <iframe name="hidden_frame2" id="hidden_frame2" style="display: none" width="0" height="0">
    </iframe>
    
    <div style="visibility:hidden; z-index:-1">
    <!--首页左边导航暗焦点--> 
    <img src="images/menu_bgfocuson.png"/>
    <img src="images/sub_bgfocuson.png"/>
    <img src="images/sub_bgon.png"/>
    <img src="images/pic_bg3.png"/>
    <img src="images/menu_bgon.png"/>
</div>
<%@ include file="servertimehelp.jsp" %>
</body>
</html>