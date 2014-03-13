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
			background:url('../images/syex.jpg') no-repeat;
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
	function doSelect() {
			var temp = "../../../defaultgdsd/en/page/shouying/page/index.jsp?returnurl=../../../../../defaultsdcctv/en/page/index.jsp"; 
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
</script>

</head>
<body scroll="no" id="body">
</body>
</html>
