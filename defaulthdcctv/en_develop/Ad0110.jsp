<%@ include file = "../../keyboard_A2/keydefine.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
String localIp = request.getParameter("localIp");
String userId = request.getParameter("userId");
String backurl = null == request.getParameter("backUrl")?"index.jsp":request.getParameter("backUrl");
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
			background:url('images/HD3D.png') no-repeat;
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
			width:166px;
			height:50px;
                        background:no-repeat;
		}
	</style>
    
<script>
	var returnUrl = '<%=backurl%>';
        var localIp = '<%=localIp%>';

	document.onkeypress = eventHandler;
	var flag = 0;
	function init() {
		flag = 0;
               setWebkitTransform("choice_more", "HDmorefocus.png");
  		displayMore();
	}

	function displayBack(){
		setWebkitTransform("choice_back", "HDbackfocus.png");
                setWebkitTransform("choice_more", "");
	}
	function displayMore(){
		setWebkitTransform("choice_more", "HDmorefocus.png");
		setWebkitTransform("choice_back", "");
	}
	function setWebkitTransform(object, value) {
		document.getElementById(object).style.backgroundImage = "url(images/" + value + ")";
	}
	function doSelect() {
		switch (flag) {
		case 0:
			var temp = localIp+"index.jsp";
			window.location.href = temp;
			break;
		case 1:
			var temp = returnUrl;
			window.location.href = temp;
			break;
		}
	}



function keyRight() {
		switch (flag) {
		case 0:		//in more status.
			displayBack();
			flag = 1;
			break;
		case 1:		//in back status.
			displayMore();
			flag = 0;
			break;
		}
	}


function keyLeft() {
                switch (flag) {
                case 0:         //in back status.
                        displayMore();
                        flag = 1;
                        break;
                case 1:         //in more status.
                        displayBack();
                        flag = 0;
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
        <div class="button" id="choice_more" style="top: 120px; left: 458px; "></div>
        <div class="button" id="choice_back" style="top: -2px; left: 1126px; "></div>


</div>
</body>
</html>
<!-- End Save for Web Slices -->

<!-- JS: handle the keypress and go_forward -->
<script>
		
</script>
