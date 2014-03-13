<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.Integer"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*" %>
<%@ include file = "../../keyboard_A2/keydefine.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>已购买提示页</title>
<meta name="page-view-size" content="1280*720" />
<script> 
<%
String returnUrl = "";
if (request.getParameter("backurl") != null && !"".equals(request.getParameter("backurl")) && !"null".equals(request.getParameter("backurl"))) {
    	returnUrl = request.getParameter("backurl");
}else{
        returnUrl = "SZ_EPG/page/index.jsp";
 }
%>
document.onkeypress = eventHandler;
var returnurl = '<%=returnUrl%>';
function init(){

}

function doSelect() {
		var temp = returnurl;
		window.location.href = temp;
		break;
}

function eventHandler(event) {
	switch (event.which) {
		case <%=KEY_BACKSPACE%>:
		case <%=KEY_RETURN%>:
			window.location.href = returnurl;
			break;
		case <%=KEY_OK%>:
			doSelect();
			break;
	}
}

</script>
</head>
<body bgcolor="transparent" leftmargin="0px" topmargin="0px" marginwidth="0px" marginheight="0px" style="background-color: transparent"  onLoad="init();">
<div class = "showTime" style="visibility:visible; width:1280px; height:720px; position:absolute; z-index:21; background:url('images/SubInit_Prompt_bg.png') no-repeat;">
</div>
</body>
</html>
