<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<%@ include file="../common/golbal.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>深圳奥运专题高清3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="<%=static_url%>/css/style.css" />
<script>
document.onkeypress = keyEvent;
function keyEvent()
{
	var val = event.which ? event.which : event.keyCode;
	return keypress(val);
}
function keypress(keyval)
{
	switch(keyval)
	{
		case 8:
			goBack();
			break;
	} 
}
function goBack(){
	 var url="index.jsp";
	 window.location.href=url ;
	}
</script>
</head>

<body>
<% String currentPageId = "_1006"; %>

<%@ include file="../common/head.jsp" %>

	<div class="medals-list-pic">
        <div class="pic">
		<!--<iframe id="playscreen" src="http://119.147.52.183:8081/2012/Medals.html" frameborder="0" top="400" width="1191" height="528" allowtransparency="true" style="background:transparent" >
		</iframe>-->
        <img src="<%=static_url%>/images/medals-pic-1191X528.jpg" / width="1191px" height="528px">	
		</div>
	</div>


</body>
</html>
