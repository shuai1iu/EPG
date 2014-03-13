<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="space_consumer_records_control.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<style type="text/css">
<!--
.channel_list .txt,.channel_list .p_li {
	left:0;
	position:absolute;
	top:0;
	width:682px;
}
.channel_list .focus{ background:url(images/list-bg-focus.png) no-repeat;}
.channel_list .txt01 {
	left:20px;
	width:340px;
}
.channel_list .txt02 {
	color:#476781;
	left:370px;
	text-align:center;
	width:190px;
}
.channel_list .txt03 {
	color:#a7d54b;
	left:580px;
	width:90px;
}
-->
</style>
</head>

<body  onLoad="loadData();">
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
		<div class="menuli" id="area0_list_6" style="top:331px"><img src="images/icon_7.png" />应  用</div>
		<div style="top:385px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_7" style="top:386px"><img src="images/icon_8.png" />套  餐</div>
		<div style="top:440px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_8" style="top:441px"><img src="images/icon_9.png" />空  间</div>
		<div style="top:499px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_9" style="top:500px"><img src="images/icon_10.png" />搜  索</div>
		<div style="top:555px"><img src="images/menu_line.png" /></div>
	</div>
  <!--mid-->		
	<div class="playback_date pb1"><!--焦点为 class="d_li on"  当前选中为 class="d_li current"-->
		<div class="d_li" id="area1_list_0">我的收藏</div>
		<div class="d_li" id="area1_list_1">我的书签</div>
		<div class="d_li" id="area1_list_2">订购记录</div>
		<div class="d_li" id="area1_list_3">取消包月</div>
		<div class="d_li" id="area1_list_4">操作指南</div>
	</div>
	
	<!--r-->
	<!--<div class="channel_list wid2 ch1">
		<div align="center" ><img id="pageup" src="images/up.png" /></div>
		<div class="p_li" id="area2_list_0"></div>
		<div class="p_li" id="area2_list_1"></div>
		<div class="p_li" id="area2_list_2"></div>
		<div class="p_li" id="area2_list_3"></div>
		<div class="p_li" id="area2_list_4"></div>
		<div class="p_li" id="area2_list_5"></div>
		<div class="p_li" id="area2_list_6"></div>
		<div class="p_li" id="area2_list_7"></div>
		<div class="p_li" id="area2_list_8"></div>
		<div class="p_li" id="area2_list_9"></div>
		<div class="p_li" id="area2_list_10"></div>
		<div align="center" ><img  id="pagedown" src="images/down.png" /></div>
  </div>-->
	
	<!--<div class="channel_list wid3 ch2">
		<div class="p_li" id="area3_list_0"></div>
		<div class="p_li" id="area3_list_1"></div>
		<div class="p_li" id="area3_list_2"></div>
		<div class="p_li" id="area3_list_3"></div>
		<div class="p_li" id="area3_list_4"></div>
		<div class="p_li" id="area3_list_5"></div>
		<div class="p_li" id="area3_list_6"></div>
		<div class="p_li" id="area3_list_7"></div>
		<div class="p_li" id="area3_list_8"></div>
		<div class="p_li" id="area3_list_9"></div>
		<div class="p_li" id="area3_list_10"></div>
  </div>-->
  
  <!--r-->
	<div class="channel_list ch1"> <!--默认为 class="p_li"；焦点为 class="p_li focus"-->
		<div class="p_li" id="area2_list_0" style="top:30px">
			<div class="txt txt01" id="area5_list_0"></div>
			<div class="txt txt02" id="area4_list_0"></div>  
			<div class="txt txt03" id="area3_list_0"></div>   
		</div>
		<div class="p_li" id="area2_list_1" style="top:75px">
			<div class="txt txt01" id="area5_list_1"></div>
			<div class="txt txt02" id="area4_list_1"></div>  
			<div class="txt txt03" id="area3_list_1"></div>   
		</div>
		<div class="p_li" id="area2_list_2" style="top:120px">
			<div class="txt txt01" id="area5_list_2"></div>
			<div class="txt txt02" id="area4_list_2"></div>  
			<div class="txt txt03" id="area3_list_2"></div>   
		</div>
		<div class="p_li" id="area2_list_3" style="top:165px">
			<div class="txt txt01" id="area5_list_3"></div>
			<div class="txt txt02" id="area4_list_3"></div>  
			<div class="txt txt03" id="area3_list_3"></div>   
		</div>
		<div class="p_li" id="area2_list_4" style="top:210px">
			<div class="txt txt01" id="area5_list_4"></div>
			<div class="txt txt02" id="area4_list_4"></div>  
			<div class="txt txt03" id="area3_list_4"></div>   
		</div>
		<div class="p_li" id="area2_list_5" style="top:255px">
			<div class="txt txt01" id="area5_list_5"></div>
			<div class="txt txt02" id="area4_list_5"></div>  
			<div class="txt txt03" id="area3_list_5"></div>   
		</div>
		<div class="p_li" id="area2_list_6" style="top:300px">
			<div class="txt txt01" id="area5_list_6"></div>
			<div class="txt txt02" id="area4_list_6"></div>  
			<div class="txt txt03" id="area3_list_6"></div>   
		</div>
		<div class="p_li" id="area2_list_7" style="top:345px">
			<div class="txt txt01" id="area5_list_7"></div>
			<div class="txt txt02" id="area4_list_7"></div>  
			<div class="txt txt03" id="area3_list_7"></div>   
		</div>
		<div class="p_li" id="area2_list_8" style="top:390px">
			<div class="txt txt01" id="area5_list_8"></div>
			<div class="txt txt02" id="area4_list_8"></div>  
			<div class="txt txt03" id="area3_list_8"></div>   
		</div>
		<div class="p_li" id="area2_list_9" style="top:435px">
			<div class="txt txt01" id="area5_list_9"></div>
			<div class="txt txt02" id="area4_list_9"></div>  
			<div class="txt txt03" id="area3_list_9"></div>   
		</div>
		<div class="p_li" id="area2_list_10" style="top:480px">
			<div class="txt txt01" id="area5_list_10"></div>
			<div class="txt txt02" id="area4_list_10"></div>  
			<div class="txt txt03" id="area3_list_10"></div>   
		</div>
	</div>
	<!--bottom_notice-->
	<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>
    <iframe name="hidden_frame" id="hidden_frame"  style=" display:none" width="0" height="0" ></iframe>
 </div>
<div style="visibility:hidden; z-index:-1">
    <!--首页左边导航暗焦点--> 
     <img src="images/menu_bgon.png"/>
     <img src="images/menu_bgfocuson.png"/>
     <img src="images/sub_bg2on.png"/>
</div>
</body>
</html>
