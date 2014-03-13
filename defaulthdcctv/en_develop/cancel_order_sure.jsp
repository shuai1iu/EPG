<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视高清EPG</title>
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/style.css" rel="stylesheet" />
<%
	String prodname = request.getParameter("prodname");
	String prodcode = request.getParameter("prodcode");
	String starttime = request.getParameter("starttime");
	String type = request.getParameter("type");
	String jumpurl = "";
	if("产品".equals(type)){
		jumpurl = "cancel_order_result.jsp?prodcode="+prodcode+"&prodname="+prodname+"&starttime="+starttime+"&type="+type;
	}else{
		UserProfile profile = new UserProfile(request);
		String redirectUrl = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/jsp/defaulthdcctv/en_develop/cancel_order_result.jsp";
		String userId = profile.getUserId();
		String userToken = profile.getUserToken();
		jumpurl="http://14.29.1.46:8080/ACS/vas/serviceorder?SPID=&UserID="+userId+"&ProductID="+prodcode+"&UserToken="+userToken+"&Action=4&OrderMode=1&ContinueType=1&ReturnURL="+redirectUrl;
	}
%>
</head>

<body>
<div class="wrapper">
	<!--head-->
	<div class="txt txt-headline">取消续订</div>
	<!--the end-->
	
	
	<!--cancel-->
	<div class="cancel">
		<div class="txt txt-tit">取消续订</div>
	  	<div class="txt txt-con" id="pomptTxt">尊敬的用户，您即将取消续订的<%=type%>是<%=prodname%>。</div>
	</div>
	<!--the end-->
	
	
	<!--btn-->
	<div class="btns">
		<div class="item">
			<div class="link"><a href="<%=jumpurl%>"><img src="images/t.gif" /></a></div>
			<div class="txt">确认</div>
		</div>
		<div class="item" style="left:260px;"> 
			<div class="link"><a href="space_cancel.jsp?areaid=1&indexid=3"><img src="images/t.gif" /></a></div>
			<div class="txt">返回</div>
		</div>
	</div>
	<!--the end-->
</div>	

</body>
</html>
