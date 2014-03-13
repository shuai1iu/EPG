<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ include file="datajsp/util_AdText.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8" />
<title>节目详情-电视栏目_央视高清EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<%@ include file="datajsp/program_tv_data.jsp" %>
<%@ include file="program_tv_ctrl.jsp" %>
</head>

<body>
<div class="main">	
	<!-- logo -->
	<div class="logo" style="width:1080"><%=typeName %></div>

	<div class="date" id="currDate"></div>

	<!--menu-->
	<div class="menu2">
		<div><img src="images/menu_line.png" /></div>
		<div id="menu0" class="menuli on">栏目信息</div> <!--class="menuli on"-->
		<div><img src="images/menu_line.png" /></div>
		<div id="menu1" class="menuli">播  &nbsp;&nbsp;  放</div>
		<div><img src="images/menu_line.png" /></div>
		<div id="menu2" class="menuli">收  &nbsp;&nbsp;  藏</div>    
		<div><img id ="tmpicon0" src="images/menu_line.png" /></div>
		<div id="menu3" class="menuli">购  &nbsp;&nbsp;  买</div>
		<div><img id ="tmpicon1" src="images/menu_line.png" /></div>
	</div>

	<!--tv-->	
	<div class="dibb"> 
		<div class="tv_choose_intro" style="left:0">
			<div><b>片名：</b><span id="contentname"></span></div>
			<div style="display:none;"><b>价格：</b><span id="contentprise"></span></div>
			<div><b>主持：</b><span id="contentzhuchi"></span></div>
			<div><b>嘉宾：</b><span id="contentjiabin"></span></div>
			<div><img src="images/line2.png" /></div>
			<div class="f24b">内容简介：</div>
			<div class="f24 wid" id="contentdesc"></div>
		</div>	
		<div class="tv_rpic"><img id="img_right" width="259" height="232" /></div>			
	</div>
	
	<!--tv_choose-->	
	<div class="dibb3">
		<div class="f24b">相关节目：</div>
		<div class="line4"><img src="images/line4.png" /></div>
		<div class="film_list3">
			<div id="cate_0"><img src="" id="img_0" width="209" height="186" style="display::none;" /></div>
			<div id="cate_1" style="left:227px"><img src="" id="img_1" width="209" height="186"/></div>
			<div id="cate_2" style="left:454px"><img src="" id="img_2" width="209" height="186"/></div>
			<div id="cate_3" style="left:681px"><img src="" id="img_3" width="209" height="186"/></div>
		</div>
  </div>	
	 <!--bottom_notice-->
	<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>
</div>
<!--popup-->
	
    <div class="popup" id="divshowsale" style="display:none">
		<div class="pop_fee" id="divsaleText">对不起，您未购买本片，请购买后观看。</div>	
		<div class="pop_price" id="divsalePrise">价格：2.00元</div>	
		<div class="pop_btns">	
			<div  id="sele_0">购买本片</div>
			<div>&nbsp;</div>
			<div  id="sele_1">返回</div>
 	  </div>
	  	<div class="pop_btns po1">
			<div id="sele1_0">了解套餐</div>
	  </div>
	</div>


<div class="popup" style="display:none" id="divshow">
		<div class="pop_tip" id="divshowtext"></div>		
	</div>
	<!--popup the end-->
<div style="visibility:hidden; z-index:-1">
    <!--首页左边导航暗焦点--> 
    <iframe id="ctrframe" width="0" height="0"/>
    <img src="images/pic_bg8.png"/>
    <img src="images/menu_bgon.png"/>
</div>
<%@ include file="servertimehelp.jsp" %>
</body>
</html>
