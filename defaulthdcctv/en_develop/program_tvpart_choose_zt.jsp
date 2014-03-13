<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="util/save_focus.jsp"%>
<%@ include file="datajsp/program_tvpart_choose_data.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-

transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>节目详情-电视栏目-播放选择_央视高清EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<%@ include file="program_tvpart_choose_zt_ctrl.jsp"%>
</head>

<body>
<div class="main">
	
	<!--logo-->
	<div class="logo" style="width:1080;"><%=typeName %></div>
	<div class="date" id="currDate"></div>

	<!--menu-->
	<div class="menu2"> <!--焦点为 class="menuli on"  当前选中为 class="menuli current"-->
		<div><img src="images/menu_line.png" /></div>
		<div id="menu1" class="menuli">专题信息</div> <!--class="menuli on"-->
		<div><img src="images/menu_line.png" /></div>
		<div id="menu0" class="menuli">播  &nbsp;&nbsp; 放</div>
		<div><img src="images/menu_line.png" /></div>
		<div id="menu2" class="menuli">收  &nbsp;&nbsp;  藏</div>    
		<div><img id ="tmpicon0" src="images/menu_line.png" /></div>
		<div id="menu3" class="menuli">购  &nbsp;&nbsp;  买</div>
		<div><img id ="tmpicon1" src="images/menu_line.png" /></div>
	</div>
	<!--list-->
	<div class="choose_list">
		<div align="center"><img id="pageup" /></div>
		<div class="ch_li" id="content_0"></div>
		<div class="ch_li" id="content_1"></div>
		<div class="ch_li" id="content_2"></div>
		<div class="ch_li" id="content_3"></div>
		<div class="ch_li" id="content_4"></div>
		<div class="ch_li" id="content_5"></div>
		<div class="ch_li" id="content_6"></div>
		<div class="ch_li" id="content_7"></div>
		<div class="ch_li" id="content_8"></div>
		<div class="ch_li" id="content_9"></div>
		<div class="ch_li" id="content_10"></div>
		<div align="center"><img id="pagedown" /></div>
	</div>
    <div class="pages" style="left:856px" id="page"></div>
	<div class="line5"><img src="images/lines5.png" /></div>
	<!--side_r-->	
	<div class="side_r">
		<div><img id="img_right" width="259" height="232" /></div>
		<div><b>主持：</b><span id="zhuchi"></span></div>
		<div><b>嘉宾：</b><span id="jiabin"></span></div>
		<div class="f24b">内容简介：</div>
		<div id="desc" style="overflow:hidden; height:200px;"></div>
	</div>
		
	
	
	 <!--bottom_notice-->
	<div class="notice" id="pao"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>

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

<!-- book mark -->
	<div class="popup" id="div_tip" style="display:none;">    	
		<div class="pop_fee">是否从书签处开始播放？</div>		
		<div class="pop_btns">
			<div id="div_tip0" class="on">书签播放</div>
			<div>&nbsp;</div>
			<div id="div_tip1">从头播放</div>
	    </div>
    </div>   

<div class="popup" style="display:none" id="divshow">
		<div class="pop_tip" id="divshowtext"></div>		
	</div>
	<!--popup the end-->
         <iframe name="hidden_frame" id="hidden_frame" style="display: none" width="0" height="0">
    </iframe>
    <div style="visibility:hidden; z-index:-1">
    <!--首页左边导航暗焦点--> 
    <img src="images/list_bgon.png"/>
    <img src="images/menu_bgfocuson.png"/>
    <img src="images/menu_bgon.png"/>
</div>
<%@ include file="servertimehelp.jsp" %>
</body>
</html>
