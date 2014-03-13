<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="datajsp/database.jsp"%>
<%@ include file = "../../../keyboard_A2/keydefine.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="SZMG_SubscribeSelct" content="szmg_hd" />
    <meta name="page-view-size" content="640*530" />
	<title>SZMG_SubscribeSelct</title>
    <style type="text/css">
		body{
			font-family: sans-serif;
			position:absolute;
			overflow:hidden;
			background-color:transparent;
			background:url('../images/wufashoukan.jpg') no-repeat;
			left:0px;
			top:0px;
			width:640px;
			height:530px;
		}
		.button
		{
			position:absolute;
			width:161px;
			height:86px;
		}
	</style>
    
<script>
	document.onkeypress = eventHandler;
        function init() {
                document.body.style.background = "url(../images/wuquanshoukan.jpg)";
        }

	function doSelect() {
			var temp = "index.jsp"; 
			window.location.href = temp;
	}


	function eventHandler(event) {
		switch (event.which) {
			case <%=KEY_BACKSPACE%>:
			case <%=KEY_RETURN%>:
				window.location.href = "index.jsp";
				break;
			case <%=KEY_OK%>:
				doSelect();
				break;
		}
	}
	window.onload = function() { init(); }
</script>

</head>
<!-- HTML -->
<body scroll="no" id="body">
</body>
</html>
<!-- End Save for Web Slices -->

<!-- JS: handle the keypress and go_forward -->
<script>
		
</script>
