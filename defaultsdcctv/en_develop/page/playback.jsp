<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>


<html>
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

<%@ include file="playbackcontrol.jsp"%>
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
        <div class="item-arr-up" style="top:79px;">
            <img id="channelPageUp" />
        </div>
        <!-- E 向上箭头 -->

        <div class="item" style="top:108px;" id="channel0">
 		<div class="link" id="channel_a0"><img src="../images/t.gif" /></div>
            <div class="txt"><div id="channel00" class="txtcon"></div></div>
        </div>
        <div class="item" style="top:148px;" id="channel1">
        <div class="link" id="channel_a1"><img src="../images/t.gif" /></div>
           <div class="txt"><div id="channel11" class="txtcon"></div></div>
        </div>
        <div class="item" style="top:188px;" id="channel2">
        <div class="link" id="channel_a2"><img src="../images/t.gif" /></div>
           <div class="txt"><div id="channel22" class="txtcon"></div></div>
        </div>
        <div class="item" style="top:228px;" id="channel3">
        <div class="link" id="channel_a3"><img src="../images/t.gif" /></div>
            <div class="txt"><div id="channel33" class="txtcon"></div></div>
        </div>
        <div class="item" style="top:268px;" id="channel4">
        <div class="link" id="channel_a4"><img src="../images/t.gif" /></div>
            <div class="txt"><div id="channel44" class="txtcon"></div></div>
        </div>
        <div class="item" style="top:308px;" id="channel5">
        <div class="link" id="channel_a5"><img src="../images/t.gif" /></div>
          <div class="txt"><div id="channel55" class="txtcon"></div></div>
        </div>
        <div class="item" style="top:348px;" id="channel6">
        <div class="link" id="channel_a6"><img src="../images/t.gif" /></div>
           <div class="txt"><div id="channel66" class="txtcon"></div></div>
        </div>
        <div class="item" style="top:388px;" id="channel7">
        <div class="link" id="channel_a7"><img src="../images/t.gif" /></div>
            <div class="txt"><div id="channel77" class="txtcon"></div></div>
        </div>

        <!-- S 向下箭头 -->
        <div class="item-arr-down" style="top:439px;" >
           <img src="../images/t.gif" id="channelPageDown"/>
        </div>
        <!-- E 向下箭头 -->

    </div>
    <!-- E 左侧导航 -->

    <!-- S 日期选项卡 -->
    <div class="tvod-timeTag">
        <div class="item" style="top:142px;" id="date0">
            <div class="link" id="date_a0"><img src="../images/t.gif" /></div>
            <div class="txt" id="date00"></div>
        </div>
        <div class="item" style="top:178px;" id="date1">
            <div class="link" id="date_a1"><img src="../images/t.gif" /></div>
            <div class="txt" id="date11"></div>
        </div>
        <div class="item" style="top:214px;" id="date2">
            <div class="link" id="date_a2"><img src="../images/t.gif" /></div>
            <div class="txt" id="date22"></div>
        </div>
         <div class="item" style="top:250px;" id="date3">
            <div class="link" id="date_a3"><img src="../images/t.gif" /></div>
            <div class="txt" id="date33"></div>
        </div>
        <div class="item" style="top:286px;" id="date4">
            <div class="link" id="date_a4"><img src="../images/t.gif" /></div>
            <div class="txt" id="date44"></div>
        </div>
        <div class="item" style="top:322px;" id="date5">
            <div class="link" id="date_a5"><img src="../images/t.gif" /></div>
            <div class="txt" id="date55"></div>
        </div>
        <div class="item" style="top:358px;" id="date6">
            <div class="link" id="date_a6"><img src="../images/t.gif" /></div>
            <div class="txt" id="date66"></div>
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
            
            <div class="link" id="program_a0"><img src="../images/t.gif" /></div>
            <div class="txt" id="program0_name0"></div>
            <div class="txtTime" id="program0_time0"></div>
        </div>
        <div class="item" style="top:136px;" id="program1">
            
            <div class="link" id="program_a1"><img src="../images/t.gif" /></div>
          <div class="txt" id="program1_name1"></div>
            <div class="txtTime" id="program1_time1"></div>
        </div>
        <div class="item" style="top:177px;" id="program2">
            
            <div class="link" id="program_a2"><img src="../images/t.gif" /></div>
            
           <div class="txt" id="program2_name2"></div>
            <div class="txtTime" id="program2_time2"></div>
        </div>
        <div class="item" style="top:218px;" id="program3">
       
            <div class="link" id="program_a3"><img src="../images/t.gif" /></div>
           <div class="txt" id="program3_name3"></div>
            <div class="txtTime" id="program3_time3"></div>
        </div>
        <div class="item" style="top:259px;" id="program4">
  
            <div class="link" id="program_a4"><img src="../images/t.gif" /></div>
           <div class="txt" id="program4_name4"></div>
            <div class="txtTime" id="program4_time4"></div>
        </div>
        <div class="item" style="top:300px;" id="program5">

            <div class="link" id="program_a5"><img src="../images/t.gif" /></div>
            <div class="txt" id="program5_name5"></div>
            <div class="txtTime" id="program5_time5"></div>
        </div>
        <div class="item" style="top:341px;" id="program6">
  
            <div class="link" id="program_a6"><img src="../images/t.gif" /></div>
           <div class="txt" id="program6_name6"></div>
            <div class="txtTime" id="program6_time6"></div>
        </div>
        <div class="item" style="top:382px;" id="program7">
    
            <div class="link" id="program_a7"><img src="../images/t.gif" /></div>
            <div class="txt" id="program7_name7"></div>
            <div class="txtTime" id="program7_time7"></div>
        </div>
        <div class="item" style="top:423px;" id="program8">

            <div class="link" id="program_a8"><img src="../images/t.gif" /></div>
             <div class="txt" id="program8_name8"></div>
            <div class="txtTime" id="program8_time8"></div>
        </div>

    </div>
    <!-- E 播放列表 -->
</div>
<div id="pageNum" style="position:absolute; left: 543px; top: 423px; width: 75px; height: 30px; text-align:center; line-height:30px;"></div>
<%@ include file="servertimehelp.jsp"%>
</body>

</html>
<div style="display:none;"><img src="../images/ltd-item_select.jpg"/></div>
