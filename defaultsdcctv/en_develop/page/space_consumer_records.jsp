<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="space_consumer_records_control.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
    <meta name="page-view-size" content="640*530"/>
    <title>计费 | CCTV-IP电视</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <style type="text/css">
        body {
            background: #263150 url("../images/bg-order.png") no-repeat;
        }
        .myspace-list {
			left: 189px;
			position: absolute;
            top: 79px;
		}
		.myspace-list .item,
        .myspace-list .item .link,
        .myspace-list .item .link img {
            height: 30px;
            width: 430px;
        }
        .myspace-list .item {
            left:0;
			top:0;
        }
        .myspace-list .item .txt {
            left: 10px;
			line-height:30px;
			width:150px;
        }
		.myspace-list .item .txtType,
        .myspace-list .item .txtTime,
        .myspace-list .item .txtPrice {
            line-height:30px;
            position: absolute;
        }
		.myspace-list .item .txtType {
            width: 60px;
            left: 165px;
			text-align:center;
        }
        .myspace-list .item .txtTime {
            color: #525d7b;
            width: 110px;
            left: 240px;
			text-align:center;
        }
        .myspace-list .item .txtPrice {
            color: #92c035;
            width: 70px;
            left: 360px;
			text-align:center;
        }
        .mod-paging-b {
            text-align: center;
            width: 426px;
            left: 185px;
            top: 436px;
        }
    </style>
</head>
<body onLoad="loadBody();">
<div class="wrapper">
    <!-- S 面包屑 -->
    <div class="mod-bread">
        我的空间
    </div>
    <!-- E 面包屑 -->

    <!-- S 时间 -->
    <!--<div class="mod-dataTime">2011年5月30日 星期三 13:10</div>-->
    <!-- E 时间 -->

    <!-- S 左侧导航 -->
    <div class="leftNav-e">
        <div class="item" style="top:122px;">
            <div class="link"><a href="#" id="area0_list_0"><img src="../images/t.gif" /></a></div>
            <div class="txt">收&nbsp;藏</div>
        </div>
        <div class="item" style="top:169px;">
            <div class="link"><a href="#" id="area0_list_1"><img src="../images/t.gif" /></a></div>
            <div class="txt">书&nbsp;签</div>
        </div>
        <div class="item item_select" style="top:216px;">
            <div class="link"><a href="#" id="area0_list_2"><img src="../images/t.gif" /></a></div>
            <div class="txt">订购记录</div>
        </div>
        <div class="item" style="top:263px;">
            <div class="link"><a href="#" id="area0_list_3"><img src="../images/t.gif" /></a></div>
            <div class="txt">取消包月</div>
        </div>
		<div class="item" style="top:310px;">
            <div class="link"><a href="#" id="area0_list_4"><img src="../images/t.gif" /></a></div>
            <div class="txt">操作简介</div>
        </div>
		<div class="item" style="top:357px;">
            <div class="link"><a href="#" id="area0_list_5"><img src="../images/t.gif" /></a></div>
            <div class="txt">使用指南</div>
        </div>
    </div>
    <!-- E 左侧导航 -->


	<!-- S 右侧列表 -->
	<div class="myspace-list">
        <div class="item">
            <div class="txt">产品名称</div>
			<div class="txtType">类型</div>
            <div class="txtTime" style="color:#fff;">日期</div>
            <div class="txtPrice" style="color:#fff;">价格</div>
        </div>
	</div>
	
    <div class="myspace-list" style="top:125px;">
        <div class="item">
            <div class="link"><a href="#" id="area1_list_0"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="area1_list_0_name"></div>
			<div class="txtType" id="area1_list_0_type"></div>
            <div class="txtTime" id="area1_list_0_date"></div>
            <div class="txtPrice" id="area1_list_0_price"></div>
        </div>
        <div class="item" style="top:32px;">
            <div class="link"><a href="#" id="area1_list_1"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="area1_list_1_name"></div>
			<div class="txtType" id="area1_list_1_type"></div>
            <div class="txtTime" id="area1_list_1_date"></div>
            <div class="txtPrice" id="area1_list_1_price"></div>
        </div>
		<div class="item" style="top:64px;">
            <div class="link"><a href="#" id="area1_list_2"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="area1_list_2_name"></div>
			<div class="txtType" id="area1_list_2_type"></div>
            <div class="txtTime" id="area1_list_2_date"></div>
            <div class="txtPrice" id="area1_list_2_price"></div>
        </div>
		<div class="item" style="top:96px;">
            <div class="link"><a href="#" id="area1_list_3"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="area1_list_3_name"></div>
			<div class="txtType" id="area1_list_3_type"></div>
            <div class="txtTime" id="area1_list_3_date"></div>
            <div class="txtPrice" id="area1_list_3_price"></div>
        </div>
		<div class="item" style="top:128px;">
            <div class="link"><a href="#" id="area1_list_4"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="area1_list_4_name"></div>
			<div class="txtType" id="area1_list_4_type"></div>
            <div class="txtTime" id="area1_list_4_date"></div>
            <div class="txtPrice" id="area1_list_4_price"></div>
        </div>
		<div class="item" style="top:160px;">
            <div class="link"><a href="#" id="area1_list_5"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="area1_list_5_name"></div>
			<div class="txtType" id="area1_list_5_type"></div>
            <div class="txtTime" id="area1_list_5_date"></div>
            <div class="txtPrice" id="area1_list_5_price"></div>
        </div>
		<div class="item" style="top:192px;">
            <div class="link"><a href="#" id="area1_list_6"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="area1_list_6_name"></div>
			<div class="txtType" id="area1_list_6_type"></div>
            <div class="txtTime" id="area1_list_6_date"></div>
            <div class="txtPrice" id="area1_list_6_price"></div>
        </div>
		<div class="item" style="top:224px;">
            <div class="link"><a href="#" id="area1_list_7"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="area1_list_7_name"></div>
			<div class="txtType" id="area1_list_7_type"></div>
            <div class="txtTime" id="area1_list_7_date"></div>
            <div class="txtPrice" id="area1_list_7_price"></div>
        </div>
		<div class="item" style="top:256px;">
            <div class="link"><a href="#" id="area1_list_8"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="area1_list_8_name"></div>
			<div class="txtType" id="area1_list_8_type"></div>
            <div class="txtTime" id="area1_list_8_date"></div>
            <div class="txtPrice" id="area1_list_8_price"></div>
        </div>
		<!--
		<div class="item" style="top:288px;">
            <div class="link"><a href="#" id="area1_list_9"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="area1_list_9_name"></div>
			<div class="txtType" id="area1_list_9_type"></div>
            <div class="txtTime" id="area1_list_9_date"></div>
            <div class="txtPrice" id="area1_list_9_price"></div>
        </div>
		-->
       <div class="mod-paging-b" style="left:0px;top:311px;" id="pageinfo">
        </div>
    </div>
	<!-- E 右侧列表 -->
	
	
</div>
</body>
</html>