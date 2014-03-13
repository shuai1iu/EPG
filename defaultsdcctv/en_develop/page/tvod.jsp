<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ include file="playbackcontrol.jsp"%>


<html >
<head>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
 <meta name="page-view-size" content="640*530"/>
 <title></title>
<link rel="stylesheet" type="text/css" href="../css/style.css" />
 <style type="text/css">

        body {

            background: #0d4764 url("../images/body-page-tvod.jpg") no-repeat;

        }
		

    </style>


</head>

<body>
<div class="wrapper">
    <!-- S 面包屑 -->
    <div class="mod-bread">
        回放
    </div>
    <!-- E 面包屑 -->

    <!-- S 时间 -->
    <div class="mod-dataTime" id="currDate"></div>
    <!-- E 时间 -->

    <!-- S 左侧导航 -->
    <div class="leftNav-d">

        <!-- S 向上箭头 -->
        <div class="item-arr-up item-arr-up-disable" style="top:79px;" id="channelPageUp">
            <div class="link"><img src="../images/t.gif" /></div>
        </div>
        <!-- E 向上箭头 -->

        <div class="item" style="top:108px;" id="channel0">

            <div class="txt"><div id="channel00" class="txtcon"></div></div>
        </div>
        <div class="item" style="top:148px;" id="channel1">
           <div class="txt"><div id="channel11" class="txtcon"></div></div>
        </div>
        <div class="item" style="top:188px;" id="channel2">
           <div class="txt"><div id="channel22" class="txtcon"></div></div>
        </div>
        <div class="item" style="top:228px;" id="channel3">
            <div class="txt"><div id="channel33" class="txtcon"></div></div>
        </div>
        <div class="item" style="top:268px;" id="channel44">
            <div class="txt"><div id="channel44" class="txtcon"></div></div>
        </div>
        <div class="item" style="top:308px;" id="channel5">
          <div class="txt"><div id="channel55" class="txtcon"></div></div>
        </div>
        <div class="item" style="top:348px;" id="channel6">
           <div class="txt"><div id="channel66" class="txtcon"></div></div>
        </div>
        <div class="item" style="top:388px;" id="channel7">
            <div class="txt"><div id="channel77" class="txtcon"></div></div>
        </div>

        <!-- S 向下箭头 -->
        <div class="item-arr-down" style="top:439px;" id="channelPageDown">
            <div class="link"><img src="../images/t.gif" /></div>
        </div>
        <!-- E 向下箭头 -->

    </div>
    <!-- E 左侧导航 -->

    <!-- S 日期选项卡 -->
    <div class="tvod-timeTag">
        <div class="item item_select" style="top:216px;" id="date0">
            <div class="link"><a href="#"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="date00">28日</div>
        </div>
        <div class="item" style="top:252px;" id="date1">
            <div class="link"><a href="#"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="date11">29日</div>
        </div>
        <div class="item" style="top:288px;" id="date22">
            <div class="link"><a href="#"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="date22">30日</div>
        </div>
    </div>
    <!-- E 日期选项卡 -->

    <!-- S 播放列表 -->
    <div class="tvod-timeCont">

        <!--
        默认 className = item
        当前选中 className = item item_focus
        不可选中 className = item item-disable
        -->

        <div class="item" style="top:95px;" id="program0">
            <div class="icon">正播：</div>
            <div class="link"><a href="#"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="progarm0_name0">拳王争霸</div>
            <div class="txtTime" id="progarm0_time0">12:45</div>
        </div>
        <div class="item" style="top:136px;" id="program1">
            <div class="icon">正播：</div>
            <div class="link"><a href="#"><img src="../images/t.gif" /></a></div>
          <div class="txt" id="progarm1_name1">拳王争霸</div>
            <div class="txtTime" id="progarm1_time1">12:45</div>
        </div>
        <div class="item item_focus" style="top:177px;" id="program2">
            <div class="icon">正播：</div>
            <div class="link"><a href="#"><img src="../images/t.gif" /></a></div>
            
           <div class="txt" id="progarm2_name2">拳王争霸</div>
            <div class="txtTime" id="progarm2_time2">12:45</div>
        </div>
        <div class="item" style="top:218px;" id="program3">
            <div class="icon">正播：</div>
            <div class="link"><a href="#"><img src="../images/t.gif" /></a></div>
           <div class="txt" id="progarm3_name3">拳王争霸</div>
            <div class="txtTime" id="progarm3_time3">12:45</div>
        </div>
        <div class="item" style="top:259px;" id="program4">
            <div class="icon">正播：</div>
            <div class="link"><a href="#"><img src="../images/t.gif" /></a></div>
           <div class="txt" id="progarm4_name4">拳王争霸</div>
            <div class="txtTime" id="progarm4_time4">12:45</div>
        </div>
        <div class="item item-disable" style="top:300px;" id="program5">
            <div class="icon">正播：</div>
            <div class="link"><a href="#"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="progarm5_name5">拳王争霸</div>
            <div class="txtTime" id="progarm5_time5">12:45</div>
        </div>
        <div class="item item-disable" style="top:341px;" id="progarm6">
            <div class="icon">正播：</div>
            <div class="link"><a href="#"><img src="../images/t.gif" /></a></div>
           <div class="txt" id="progarm6_name6">拳王争霸</div>
            <div class="txtTime" id="progarm6_time6">12:45</div>
        </div>
        <div class="item item-disable" style="top:382px;" id="progarm7">
            <div class="icon">正播：</div>
            <div class="link"><a href="#"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="progarm7_name7">拳王争霸</div>
            <div class="txtTime" id="progarm7_time7">12:45</div>
        </div>
        <div class="item item-disable" style="top:423px;" id="program8">
            <div class="icon">正播：</div>
            <div class="link"><a href="#"><img src="../images/t.gif" /></a></div>
             <div class="txt" id="progarm8_name8">拳王争霸</div>
            <div class="txtTime" id="progarm8_time8">12:45</div>
        </div>

    </div>
    <!-- E 播放列表 -->
</div>
<blockquote>&nbsp;</blockquote>
</body>
<%@ include file="servertimehelp.jsp"%>