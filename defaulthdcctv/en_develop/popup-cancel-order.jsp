<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视高清EPG</title>
<link type="text/css" href="css/common.css" rel="stylesheet" />

<link type="text/css" href="css/style.css" rel="stylesheet" />
<%
	String progName = request.getParameter("progName");
	String prodId = request.getParameter("prodId");
	String prodBeginTime = request.getParameter("beginTime");
%>
<script language="javascript" type="text/javascript">
var area0;
var progName = '<%=progName%>';
var prodId = '<%=prodId%>';
var prodBeginTime = '<%=prodBeginTime%>';
var returnurl = "space_cancel.jsp?areaid=1&indexid=3";
function goto(num)
{
	if(num==0)
	{
		window.location.href="popup-cancel-order-sure.jsp?prodId="+prodId+"&progName="+progName+"&beginTime="+prodBeginTime;
	}
	else
	{
		window.location.href=returnurl;
	}
}
function loadData()
{
	document.getElementById("textProgname").innerHTML="尊敬的用户，您即将取消续订的产品是"+progName+"。";
}

</script>
</head>

<body onLoad="loadData();">
<div class="wrapper">
	<!--head-->
	<div class="txt txt-headline">取消续订</div>
	<!--the end-->
	
	
	<!--cancel-->
	<div class="cancel">
		<div class="txt txt-tit">取消续订</div>
	  	<div class="txt txt-con" id="textProgname"></div>
	</div>
	<!--the end-->
	
	
	<!--btn-->
	<div class="btns">
		<div class="item">
			<div class="link"><a href="#" onclick="goto(0)"><img src="images/t.gif" /></a></div>
			<div class="txt">确认</div>
		</div>
		<div class="item" style="left:260px;"> 
			<div class="link"><a href="#" onclick="goto(1)"><img src="images/t.gif" /></a></div>
			<div class="txt">返回</div>
		</div>
	</div>
	<!--the end-->
</div>	

</body>
</html>
