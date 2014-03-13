<%@ include file = "../../keyboard_A2/keydefine.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
String localIp = request.getParameter("localIp");
String userId = request.getParameter("userId");
String backurl = request.getParameter("backUrl");
System.out.println(localIp+"||"+userId+"||"+backurl);
%>
<head>
	<meta name="SZMG_SubscribeSelct" content="szmg_hd" />
    <meta name="page-view-size" content="1280*720" />
	<title>SZMG_SubscribeSelct</title>
    <style type="text/css">
		body{
			font-family: sans-serif;
			position:absolute;
			overflow:hidden;
			background-color:transparent;
			background:url('images/Ad/bg.jpg') no-repeat;
			left:0px;
			top:0px;
			width:1280px;
			height:720px;
		}
		.button
		{
			position:absolute;
			width:161px;
			height:86px;
		}
	</style>
    
<script>
	var returnUrl = '<%=backurl%>';
        var localIp = '<%=localIp%>';

	document.onkeypress = eventHandler;
	var flag = 0;
	function init() {
		flag = 0;
  		displayiDapian();
	}

	function displayDapian(){
		setWebkitTransform("choice_Dapian", "Dapian_on.jpg");
		setWebkitTransform("choice_Reju", "Reju_off.jpg");
		setWebkitTransform("choice_Jishi", "Jishi_off.jpg");
        setWebkitTransform("choice_Yule", "Yule_off.jpg");
        setWebkitTransform("choice_Huodong", "Huodong_off.jpg");
	}
	function displayReju(){
		setWebkitTransform("choice_Dapian", "Dapian_off.jpg");
		setWebkitTransform("choice_Reju", "Reju_on.jpg");
		setWebkitTransform("choice_Jishi", "Jishi_off.jpg");
        setWebkitTransform("choice_Yule", "Yule_off.jpg");
        setWebkitTransform("choice_Huodong", "Huodong_off.jpg");
	}
	function displayJishi(){
		setWebkitTransform("choice_Dapian", "Dapian_off.jpg");
		setWebkitTransform("choice_Reju", "Reju_off.jpg");
		setWebkitTransform("choice_Jishi", "Jishi_on.jpg");
        setWebkitTransform("choice_Yule", "Yule_off.jpg");
        setWebkitTransform("choice_Huodong", "Huodong_off.jpg");
	}
        function displayYule(){
		setWebkitTransform("choice_Dapian", "Dapian_off.jpg");
		setWebkitTransform("choice_Reju", "Reju_off.jpg");
		setWebkitTransform("choice_Jishi", "Jishi_off.jpg");
        setWebkitTransform("choice_Yule", "Yule_on.jpg");
        setWebkitTransform("choice_Huodong", "Huodong_off.jpg");
        }
        function displayHuodong(){
		setWebkitTransform("choice_Dapian", "Dapian_off.jpg");
		setWebkitTransform("choice_Reju", "Reju_off.jpg");
		setWebkitTransform("choice_Jishi", "Jishi_off.jpg");
        setWebkitTransform("choice_Yule", "Yule_off.jpg");
        setWebkitTransform("choice_Huodong", "Huodong_on.jpg");
        }
	function setWebkitTransform(object, value) {
		document.getElementById(object).style.backgroundImage = "url(images/" + value + ")";
	}
	function doSelect() {
		switch (flag) {
		case 0:
			var temp = localIp+"SZ_EPG/page/hdlist.jsp?typeid=10000100000000090000000000031171";
			window.location.href = temp;
			break;
		case 1:
			var temp = localIp+"SZ_EPG/page/hdlist.jsp?typeid=10000100000000090000000000031172";
			window.location.href = temp;
			break;
		case 2:
			var temp = localIp+"SZ_EPG/page/hdlist.jsp?typeid=10000100000000090000000000031173";
			window.location.href = temp;
			break;
        case 3:         //in try_on status.
			var temp = localIp+"SZ_EPG/page/hdlist.jsp?typeid=10000100000000090000000000031174";
			window.location.href = temp;
			break;
        case 4:         //in back_on status.
			var temp = "";
			window.location.href = temp;
			break;
		}
	}



function keyRight() {
		switch (flag) {
		case 0:		//in Dapian_on status.
			displayReju();
			flag = 1;
			break;
		case 1:		//in Reju_on status.
			displayJishi();
			flag = 2;
			break;
		case 2:		//in Jishi_on status.
			displayYule();
			flag = 3;
			break;
        case 3:         //in Yule_on status.
            displayHuodong();
            flag = 4;
            break;
        case 4:         //in Huodong_on status.
            displayDapian();
            flag = 0;
            break;
		}
	}

function keyRight() {
		switch (flag) {
		case 0:		//in Dapian_on status.
			displayHuodong();
			flag = 4;
			break;
		case 1:		//in Reju_on status.
			displayDapian();
			flag = 0;
			break;
		case 2:		//in Jishi_on status.
			displayReju();
			flag = 1;
			break;
        case 3:         //in Yule_on status.
            displayJishi();
            flag = 2;
            break;
        case 4:         //in Huodong_on status.
            displayYule();
            flag = 3;
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
<body scroll="no" id="body">
<div id="choices" style="visibility:visible;">
        <div class="button" id="choice_Dapian" style="top:0px; left:0px; background:url('images/Dapian_off.jpg') no-repeat;"></div>
	    <div class="button" id="choice_Reju" style="top:0px; left:306px; background:url('images/Reju_off.jpg') no-repeat; "></div>
        <div class="button" id="choice_Jishi" style="top:0px; left:612px; background:url('images/Jishi_off.jpg') no-repeat; "></div>
        <div class="button" id="choice_Yule" style="top:0px; left:306px; background:url('images/Yule_off.jpg') no-repeat; "></div>
        <div class="button" id="choice_Huodong" style="top:0px; left:612px; background:url('images/Huodong_off.jpg') no-repeat; "></div>


</div>
</body>
</html>
<!-- End Save for Web Slices -->

<!-- JS: handle the keypress and go_forward -->
<script>
		
</script>
