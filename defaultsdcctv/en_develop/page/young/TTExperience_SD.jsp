<%-- FileName:TTExperience_HD.jsp --%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGSysParam"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file = "keyboard/keydefine.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	StringBuffer queryStrbuf = new StringBuffer();
	queryStrbuf.append("TEMPLATENAME=0&").append(request.getQueryString());
	String queryStr = queryStrbuf.toString();
	TurnPage turnPage = new TurnPage(request);  
	String returnUrl = "/EPG/jsp/defaultsdcctv/en/page/index.jsp";
	String toUrl = "index.html";
	//returnUrl = request.getParameter("backurl");
	//toUrl = request.getParameter("tourl");
	//System.out.println("returnUrl:" + returnUrl + " toUrl:" + toUrl);
%>

<head>
	<meta name="SZMG_SubscribeSelct" content="szmg_hd" />
    <meta name="page-view-size" content="640*530" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>Ã‘Ã‘ªÓ∂Ø“≥_HD</title>
	<style type="text/css">
		body{
			font-family: sans-serif;
			position:absolute;
			overflow:hidden;
			background-color:transparent;
			background:url('images/TTExperience_SD.jpg') no-repeat;
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
	var returnurl = '<%=returnUrl%>';
	var tourl = '<%=toUrl%>';

	
	document.onkeypress = eventHandler;
	function doSelect() {
			var temp = tourl; 
			window.location.href = temp;
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
	window.onload = function(){
		setTimeout("doSelect()",5*1000);
	}
	</script>
</head>
<!-- HTML -->
<body scroll="no">
</body>
</html>
<!-- End Save for Web Slices -->

<!-- JS: handle the keypress and go_forward -->
<script>
		
</script>
