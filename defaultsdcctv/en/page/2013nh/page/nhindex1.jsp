<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视春晚EPG 2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />

<style type="text/css">
<!--
	body { background:url(../images/bg1.jpg) no-repeat;}
-->
</style>
</head>

<body>

<%
String itvUserId = (String)session.getAttribute("USERID");
%>

<div class="wrapper">
	<!--menu-->
	<div class="menu">
       <div class="pic"style="top:50px;left:200px;"><a href="dibbling_turnpager.jsp?typeid=10000100000000090000000000026654&returnurl=../../../defaultsdcctv/en/page/2013nh/page/nhindex1.jsp"><img src="../images/xingfu.png" /></a></div>
	   <div class="pic" style=" top:185px;left:145px; "><a href="dibbling_turnpager.jsp?typeid=10000100000000090000000000026653&returnurl=../../../defaultsdcctv/en/page/2013nh/page/nhindex1.jsp"><img  src="../images/daju.png" /></a></div>
	   <div class="pic" style=" top:100px;left:90px;"><a href="dibbling_turnpager.jsp?typeid=10000100000000090000000000026655&returnurl=../../../defaultsdcctv/en/page/2013nh/page/nhindex1.jsp"><img src="../images/dianying.png" /></a></div>
	   <div class="pic" style=" top:260px;left:40px;"><a href="dibbling_turnpager.jsp?typeid=10000100000000090000000000026652&returnurl=../../../defaultsdcctv/en/page/2013nh/page/nhindex1.jsp"><img src="../images/geshou.png" /></a></div>
    </div>
	<!--the end-->

</div>	

<script>
if(typeof(iPanel)!= 'undefined'){iPanel.focusWidth = "4"; iPanel.defaultFocusColor="#FFFF00";}
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
		return 1; 
		break;
		default:
		return 1;
	
	} 
}
function goBack(){
	backUrl = "../../index.jsp";
	location.href = backUrl ;
}
function goVas(){
	location.href="http://14.31.15.70:8001/EPG.aspx?itvno=<%=itvUserId%>&endUrl="+location.href;
}
</script>
</body>
</html>
