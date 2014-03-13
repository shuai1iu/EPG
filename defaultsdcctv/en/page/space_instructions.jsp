<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
    <meta name="page-view-size" content="640*530"/>
    <title>收藏 | CCTV-IP电视</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
	<style type="text/css">
        body {
            background: #263150 url("../images/body-page-myspace-2.png") no-repeat;
        }
        .guide-title,
        .guide-cont {
            width: 375px;
            position: absolute;
            left: 215px;
        }
        .guide-title {
            font-size: 24px;
            height: 30px;
            text-align: center;
            top: 105px;
        }
        .guide-cont {
            line-height: 160%;
            top: 80px;
        }
    </style>
	<script language="javascript" type="text/javascript" src="../js/pagecontrol.js"></script>
    <script language="javascript" type="text/javascript">
    var area0;
    var backurl="<%=request.getParameter("returnurl")==null?"index.jsp?back=1":request.getParameter("returnurl") %>";
    
    
    //加载主数据
    function loadBody() {
        refreshServerTime();
        //构建菜单区域
        area0 = AreaCreator(6, 1, new Array(-1, -1, -1, -1), "area0_list_", "className:item onboder", "className:item offboder");
        area0.doms[0].mylink="space_collect.jsp?areaid=0&indexid=0";
        area0.doms[1].mylink="space_bookmarks.jsp?areaid=0&indexid=1";
        area0.doms[2].mylink="space_consumer_records.jsp?areaid=0&indexid=2";
		area0.doms[3].mylink="space_cancel.jsp?areaid=0&indexid=3";
        // area0.doms[3].mylink="space_instructions.jsp?areaid=0&indexid=3";
	area0.doms[5].mylink="space_installed.jsp?areaid=0&indexid=5";
        area0.setfocuscircle(0);
	    area0.doms[4].focusstyle=new Array("className:item item_select onboder");
	    area0.doms[4].unfocusstyle=new Array("className:item item_select offboder");
        //end
        pageobj = new PageObj(0, 4, new Array(area0));
        pageobj.goBackEvent=function()
        {
           window.location.href=backurl;
        }
    }
    
    </script>
</head>
<body onLoad="loadBody();">
<div class="wrapper">
    <!-- S 面包屑 -->
    <div class="mod-bread">
        我的空间
    </div>
    <!-- E 面包屑 -->

    <!-- S 时间 -->
    <div class="mod-dataTime" id="currDate"></div>
    <!-- E 时间 -->

    <!-- S 左侧导航 -->
    <div class="leftNav-e">
        <div class="item"  id="area0_list_0" style="top:122px;">
            <div class="txt">收&nbsp;藏</div>
        </div>
        <div class="item" id="area0_list_1" style="top:169px;">
            <div class="txt">书&nbsp;签</div>
        </div>
        <div class="item" id="area0_list_2" style="top:216px;" >
            <div class="txt">订购记录</div>
        </div>
        <div class="item" id="area0_list_3" style="top:263px;" >
            <div class="txt">取消订购</div>
        </div>
        <div class="item item_select" id="area0_list_4" style="top:310px;">
           <div class="txt">操作简介</div>
        </div>
	<div class="item" id="area0_list_5" style="top:360px;">
           <div class="txt">使用指南</div>
        </div>
    </div>
    <!-- E 左侧导航 -->

  
    <!-- S 内容 -->

    <div class="guide-cont">
       &nbsp;&nbsp;用户可通过遥控器上的上下左右键来移动焦点框的位置，高清版电子导航菜单结构采用从左至右的操作方式，使用返回键可返回上一级菜单，使用确认键进入下一级菜单，页面操作过程中，可使用菜单键返回首页，用户在观看点播节目或回看节目过程中，使用前进/后退键进行时移。<br/>&nbsp;&nbsp;观看直播频道，用户可直接输入频道编号快速进入，也可以使用遥控器上的频道按键进行选台操作，使用音量键调节音量大小。观看直播节目时，按信息键了解当前播放节目信息。
       

    </div>
    <!-- E 内容 -->
</div>
</body>
</html>
