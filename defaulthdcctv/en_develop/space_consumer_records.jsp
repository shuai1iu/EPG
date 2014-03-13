<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="space_consumer_records_control.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>空间-订购记录_央视高清EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<style type="text/css">
<!--
.order-list{ 
	background:url(images/order-con-bg.png) no-repeat;
	position:absolute; 
	top:103px; 
	left:548px; 
	height:550px;
	width:695px;
}
.order-list .txt,.order-list .p_li {
	line-height:66px;
	left:0;
	position:absolute;
	top:0;
	height:66px;
	width:695px;
}
.order-list .focus{ background:url(images/order-list-bg_focus.png) no-repeat;}
.order-list .txt01 {
	left:20px;
	width:230px;
}
.order-list .txt02 {
	left:260px;
	text-align:center;
	width:100px;
}
.order-list .txt03 {
	color:#414e69;
	left:370px;
	text-align:center;
	width:200px;
}
.order-list .txt04 {
	color:#a7d54b;
	left:580px;
	text-align:center;
	width:100px;
}
.order-list .p_li_title,
.order-list .p_li_title .txt {
	color:#ededed;
	font-size:24px;
	line-height:38px;
	height:38px;
	top:2px;
}
.pages6 {
	left:815px;
	position:absolute;
	top:615px;
}
.pages6 .item,
.pages6 .txt {
	line-height:38px;
	left:0;
	position:absolute;
	top:0;
	text-align:center;
	height:38px;
}
.pages6 .item {
	background:url(images/page-bg.png) no-repeat;
	color:#04334f;
	font-size:16px;
	width:59px;
}
.pages6 .txt {
	font-size:20px;
	left:55px;
	width:50px;
}
.pages6 .item_focus {
	background:url(images/page-bg_focus.png) no-repeat;
	color:#fff;
}
-->
</style>
</head>

<body onLoad="loadData();">
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
		<div class="menuli" id="area0_list_6" style="top:331px"><img src="images/icon_11new.png" />排  行</div>   <!--20130909 hxt 增加排行入口-->
		<div style="top:385px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_7" style="top:386px"><img src="images/icon_7.png" />应  用</div>   <!--20130909 hxt 将应用入口下移-->
		<div style="top:440px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_8" style="top:441px"><img src="images/icon_9.png" />空  间</div>
		<div style="top:499px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_9" style="top:500px"><img src="images/icon_10.png" />搜  索</div>
		<div style="top:555px"><img src="images/menu_line.png" /></div>
	</div>
	
	<div class="playback_date pb1"><!--焦点为 class="d_li on"  当前选中为 class="d_li current"-->
		<div class="d_li" id="area1_list_0">我的收藏</div>
		<div class="d_li" id="area1_list_1">我的书签</div>
		<div class="d_li" id="area1_list_2">订购记录</div>
		<div class="d_li" id="area1_list_3">取消包月</div>
		<div class="d_li" id="area1_list_4">操作简介</div>
		<div class="d_li" id="area1_list_5">使用指南</div>
	</div>



	<!--r-->
	<div class="order-list"> 
		<div class="p_li p_li_title">
			<div class="txt txt01">产品名称</div>
			<div class="txt txt02">类型</div>  
			<div class="txt txt03">日期</div>  
			<div class="txt txt04">价格</div>   
		</div>
	</div>
	<div class="order-list"> <!--默认为 class="p_li"；焦点为 class="p_li focus"-->
		<div class="p_li" style="top:50px" id="area2_list_0">
			<div class="txt txt01" id="area2_list_0_name"></div>
			<div class="txt txt02" id="area2_list_0_type"></div>  
			<div class="txt txt03" id="area2_list_0_date"></div>  
			<div class="txt txt04" id="area2_list_0_price"></div>   
		</div>
		<div class="p_li" style="top:105px" id="area2_list_1">
			<div class="txt txt01" id="area2_list_1_name"></div>
			<div class="txt txt02" id="area2_list_1_type"></div>  
			<div class="txt txt03" id="area2_list_1_date"></div>  
			<div class="txt txt04" id="area2_list_1_price"></div>   
		</div>
		<div class="p_li" style="top:160px" id="area2_list_2">
			<div class="txt txt01" id="area2_list_2_name"></div>
			<div class="txt txt02" id="area2_list_2_type"></div>  
			<div class="txt txt03" id="area2_list_2_date"></div>  
			<div class="txt txt04" id="area2_list_2_price"></div>    
		</div>
		<div class="p_li" style="top:215px" id="area2_list_3">
			<div class="txt txt01" id="area2_list_3_name"></div>
			<div class="txt txt02" id="area2_list_3_type"></div>  
			<div class="txt txt03" id="area2_list_3_date"></div>  
			<div class="txt txt04" id="area2_list_3_price"></div>     
		</div>
		<div class="p_li" style="top:270px" id="area2_list_4">
			<div class="txt txt01" id="area2_list_4_name"></div>
			<div class="txt txt02" id="area2_list_4_type"></div>  
			<div class="txt txt03" id="area2_list_4_date"></div>  
			<div class="txt txt04" id="area2_list_4_price"></div>    
		</div>
		<div class="p_li" style="top:325px" id="area2_list_5">
			<div class="txt txt01" id="area2_list_5_name"></div>
			<div class="txt txt02" id="area2_list_5_type"></div>  
			<div class="txt txt03" id="area2_list_5_date"></div>  
			<div class="txt txt04" id="area2_list_5_price"></div>    
		</div>
		<div class="p_li" style="top:375px" id="area2_list_6">
			<div class="txt txt01" id="area2_list_6_name"></div>
			<div class="txt txt02" id="area2_list_6_type"></div>  
			<div class="txt txt03" id="area2_list_6_date"></div>  
			<div class="txt txt04" id="area2_list_6_price"></div>    
		</div>
		<div class="p_li" style="top:430px" id="area2_list_7">
			<div class="txt txt01" id="area2_list_7_name"></div>
			<div class="txt txt02" id="area2_list_7_type"></div>  
			<div class="txt txt03" id="area2_list_7_date"></div>  
			<div class="txt txt04" id="area2_list_7_price"></div>    
		</div>
		<!--<div class="p_li" style="top:160px">
			
		</div>-->
	</div>
	
	<!--pages-->
	<div class="pages6">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area3_list_0">上页</div>
		<div class="txt" id="pageinfo"></div>
		<div class="item" style="left:103px;" id="area3_list_1">下页</div>
	</div>	
	<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>
</div>
<div style="visibility:hidden; z-index:-1">
    <!--首页左边导航暗焦点--> 
     <img src="images/menu_bgon.png"/>
     <img src="images/menu_bgfocuson.png"/>
     <img src="images/sub_bg2on.png"/>
</div>
</body>
</html>
