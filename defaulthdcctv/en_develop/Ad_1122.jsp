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
			font-family: SimHei,sans-serif;
			font-weight:bold;
		        color:#ffffff;
                        position:absolute;
			width:142px;
			height:50px;
		}
	</style>
    
<script>
	var returnUrl = '<%=backurl%>';
        var localIp = '<%=localIp%>';

	document.onkeypress = eventHandler;
	var flag = 0;
	function init() {
		flag = 0;
               setWebkitTransform("choice_Dapian", "on.png");
  		displayiDapian();
	}

	function displayDapian(){
		setWebkitTransform("choice_Dapian", "on.png");
		setWebkitTransform("choice_Reju", "off.png");
		setWebkitTransform("choice_Jishi", "off.png");
                setWebkitTransform("choice_Yule", "off.png");
                setWebkitTransform("choice_Huodong", "off.png");
	}
	function displayReju(){
		setWebkitTransform("choice_Dapian", "off.png");
		setWebkitTransform("choice_Reju", "on.png");
		setWebkitTransform("choice_Jishi", "off.png");
        setWebkitTransform("choice_Yule", "off.png");
        setWebkitTransform("choice_Huodong", "off.png");
	}
	function displayJishi(){
		setWebkitTransform("choice_Dapian", "off.png");
		setWebkitTransform("choice_Reju", "off.png");
		setWebkitTransform("choice_Jishi", "on.png");
        setWebkitTransform("choice_Yule", "off.png");
        setWebkitTransform("choice_Huodong", "off.png");
	}
        function displayYule(){
		setWebkitTransform("choice_Dapian", "off.png");
		setWebkitTransform("choice_Reju", "off.png");
		setWebkitTransform("choice_Jishi", "off.png");
        setWebkitTransform("choice_Yule", "on.png");
        setWebkitTransform("choice_Huodong", "off.png");
        }
        function displayHuodong(){
		setWebkitTransform("choice_Dapian", "off.png");
		setWebkitTransform("choice_Reju", "off.png");
		setWebkitTransform("choice_Jishi", "off.png");
        setWebkitTransform("choice_Yule", "off.png");
        setWebkitTransform("choice_Huodong", "on.png");
        }
	function setWebkitTransform(object, value) {
		document.getElementById(object).style.backgroundImage = "url(images/Ad/" + value + ")";
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
			var temp = localIp+"activity/page/activityConfig.jsp?TARGETURL=escape(%22http://219.133.42.109:1137/activityHD/page/activity.jsp%22)";
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

function keyLeft() {
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
        <div class="button" id="choice_Dapian" style="top: 629px; left: 240px; background: url('images/Ad/off.png') no-repeat; text-align: center; font-family: sans-serif; font-size: 24px;line-height: 1.9em;">高清大片</div>
	    <div class="button" id="choice_Reju" style="top: 629px; left: 397px; background: url('images/Ad/off.png') no-repeat; text-align: center; font-size: 24px;line-height: 1.9em;">高清热剧</div>
        <div class="button" id="choice_Jishi" style="top: 629px; left: 564px; background: url('images/Ad/off.png') no-repeat; text-align: center; font-size: 24px;line-height: 1.9em;">高清纪实</div>
        <div class="button" id="choice_Yule" style="top: 629px; left: 736px; background: url('images/Ad/off.png') no-repeat; text-align: center; font-size: 24px;line-height: 1.9em;">高清娱乐</div>
        <div class="button" id="choice_Huodong" style="top: 629px; left: 896px; background: url('images/Ad/off.png') no-repeat; text-align: center; font-family: sans-serif; font-size: 24px;line-height: 1.9em;">活动平台</div>


</div>
</body>
</html>
<!-- End Save for Web Slices -->

<!-- JS: handle the keypress and go_forward -->
<script>
		
</script>
