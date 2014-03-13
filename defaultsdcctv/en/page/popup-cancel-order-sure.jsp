<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视深圳标清 改版EPG2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/style3.css" />
<%
	String progName = request.getParameter("progName");
	String prodId = request.getParameter("prodId");
	String prodBeginTime = request.getParameter("beginTime");
    ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
	int contentId = 0;
	//1 为取消自动续订
	int cancelType = 1;
	//0为视频VOD
	int contentType = 0;
	//1为VOD
	int businessType = 1;
	String serviceId = "";
	Map orderMap = (HashMap)serviceHelpHWCTC.cancelOrderHWCTC(prodId,cancelType,serviceId,contentType,contentId,businessType,prodBeginTime);
	int ret_code = ((Integer) orderMap.get("RETCODE")).intValue();
	String cancelResult = "";
	String tempResult = (String) orderMap.get("RETMSG");
	if(ret_code == 0)
	{
		cancelResult = "尊敬的用户，您成功取消续订了！";	
	}
	else if(tempResult.equals("product is not Continueable Subscription."))
	{
		cancelResult = "尊敬的用户，您订购的包月产品已为非自动续订！";	
	}
	else
	{
		cancelResult = "尊敬的用户，取消续订失败，详情请咨询10000号！";	
	}
%>
<script language="javascript" type="text/javascript">
var area0;
var cancelResult = "<%=cancelResult%>"
function loadData()
{
	document.getElementById("textProgname").innerHTML=cancelResult;
}

function goto(num)
{
	if(num==0)
	{
		window.location.href="space_cancel.jsp?areaid=1&indexid=3";
	}
}
</script>
</head>

<body bgcolor="transparent" onLoad="loadData();">
<div class="wrapper" style="background:url(../images/bg03.jpg) no-repeat;">
	<!--head-->
	<div class="txt txt-headline" style="font-size:28px; font-weight:bold;">取消续订</div>
	<!--the end-->
	
	
	<!--cancel-->
	<div class="cancel">
		<div class="txt txt-tit">取消续订</div>
	  	<div class="txt txt-con02" id="textProgname"></div>
	</div>
	<!--the end-->
	
	
	<!--btn-->
	<div class="btns">
		<div class="item" style="left:129px;">
			<div class="link"><a href="#" onClick="goto(0);"><img src="../images/t.gif" /></a></div>
			<div class="txt">确认</div>
		</div>
	</div>
	<!--the end-->
</div>	

</body>
</html>
