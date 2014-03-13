<%-- FileName:au_SubscribeSelect.jsp --%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGSysParam"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ include file = "../../keyboard_A2/keydefine.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
    //页面跳转
	StringBuffer queryStrbuf = new StringBuffer();
	queryStrbuf.append("TEMPLATENAME=0&").append(request.getQueryString());
	//queryStr.append("&PRODUCTID=" ).append(sProdId).append("&SERVICEID=").append(sServiceId).append("&ONECEPRICE=").append(sPrice);*/
	String queryStr = queryStrbuf.toString();
	
    	TurnPage turnPage = new TurnPage(request);  
	String returnUrl = "";
	if (request.getParameter("backurl") != null && !"".equals(request.getParameter("backurl")) && !"null".equals(request.getParameter("backurl"))) 
    {
    	returnUrl = request.getParameter("backurl");
    }
    else
    {
        returnUrl = turnPage.getLast();
    }
%>
<head>
	<meta name="SZMG_SubscribeSelct" content="szmg_hd" />
    <meta name="page-view-size" content="1280*720" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>SZMG_SubscribeSelct</title>
    <style type="text/css">
		body{
			font-family: sans-serif;
			position:absolute;
			overflow:hidden;
			background-color:transparent;
			background:url('images/bg.jpg') no-repeat;
			left:0px;
			top:0px;
			width:1280px;
			height:720px;
		}
		.button
		{
			position:absolute;
			width:266px;
			height:77px;
		}
		#choices
		{
			position:absolute;
			top:569px;
			left:320px;
		}
		#infomation
		{
			font-family: sans-serif;
			position:absolute;
			top:200px;
			left:90px;
		}
		#info_title
		{
			position:absolute;
			width:1100px;
			height:48px;
			font-size:40px;
			color:#FFFFFF;
			text-align:center;
			font-weight:bold;
			overflow:hidden;
		}
		.texts
		{
			position:absolute;
			width:1100px;
			height:35px;
			font-size:30px;
			color:#FFFFFF;
			text-align:center;
			font-weight:normal;
			overflow:hidden;
		}
	</style>
    
<script>
	var returnUrl = '<%=returnUrl%>';
	//alert(returnUrl);
	
	document.onkeypress = eventHandler;
	var flag = 3;
	function init() {
		flag=1;
		displayTry();
	}
	function displayBack(){
		setWebkitTransform("choice_back", "SubscribeSelect_back_on.jpg");
		setWebkitTransform("choice_try", "SubscribeSelect_try_off.jpg");
		setWebkitTransform("choice_buy", "SubscribeSelect_buy_off.jpg");
	}
	function displayTry(){
		setWebkitTransform("choice_back", "SubscribeSelect_back_off.jpg");
		setWebkitTransform("choice_try", "SubscribeSelect_try_on.jpg");
		setWebkitTransform("choice_buy", "SubscribeSelect_buy_off.jpg");
	}
	function displayBuy(){
		setWebkitTransform("choice_back", "SubscribeSelect_back_off.jpg");
		setWebkitTransform("choice_try", "SubscribeSelect_try_off.jpg");
		setWebkitTransform("choice_buy", "SubscribeSelect_buy_on.jpg");
	}
	function setWebkitTransform(object, value) {
		document.getElementById(object).style.backgroundImage = "url(images/" + value + ")";
	}
	
	function doSelect() {
		switch (flag) {
		case 0:
			var temp = "au_SubscribeEnsure.jsp?"+'<%=queryStr%>';
			window.location.href = temp;
			break;
		case 1:
			var temp = "HD_experience.jsp?"+'<%=queryStr%>';
			window.location.href = temp;
			break;
		case 2:
			window.location.href = returnUrl;
			break;
		}
	}

	function keyRight() {
		switch (flag) {
		case 0:		//in buy_on status.
			displayTry();
			flag = 1;
			break;
		case 1:		//in try_on status.
			displayBack();
			flag = 2;
			break;
		case 2:		//in back_on status.
			displayBuy();
			flag = 0;
			break;
		}
	}

	function keyLeft() {
		switch (flag) {
		case 0:		//in Buy_on status.
			displayBack();
			flag = 2;
			break;
		case 1:		//in try_on status.
			displayBuy();
			flag = 0;
			break;
		case 2:		//in back_on status.
			displayTry();
			flag = 1;
			break;
		}
	}
	function eventHandler(event) {
		switch (event.which) {
			case <%=KEY_BACKSPACE%>:
			case <%=KEY_RETURN%>:
				window.location.href = returnUrl;
				break;
			case <%=KEY_OK%>:
				doSelect();
				break;
			case <%=KEY_RIGHT%>:
				keyRight();
				break;
			case <%=KEY_LEFT%>:
				keyLeft();
				break;
		}
	}
	window.onload = function() { init(); }
</script>

</head>
<!-- HTML -->
<body scroll="no">
<div id="infomation" style="visibility:visible;">
	<div id="info_title">您尚未订购高清时尚包（10元/月）</div>
    <div class="texts" id="info_text_1" style="top:60px;"></div>
    <div class="texts" id="info_text_2" style="top:95px;">10路高清直播，5000小时高清影视点播节目等着你！</div>
    <div class="texts" id="info_text_3" style="top:130px;"></div>
    <div class="texts" id="info_text_4" style="top:165px;">点击高清体验区，体验精彩高清节目！</div>
</div>
<div id="choices" style="visibility:visible;">
        <div class="button" id="choice_buy" style="top:0px; left:0px; background:url('images/SubscribeSelect_buy_off.jpg') no-repeat;"></div>
	<div class="button" id="choice_try" style="top:0px; left:306px; background:url('images/SubscribeSelect_try_off.jpg') no-repeat; "></div>
        <div class="button" id="choice_back" style="top:0px; left:612px; background:url('images/SubscribeSelect_back_off.jpg') no-repeat; "></div>
</div>
</body>
</html>
<!-- End Save for Web Slices -->

<!-- JS: handle the keypress and go_forward -->
<script>
		
</script>
