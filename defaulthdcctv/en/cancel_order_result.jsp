<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
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
	String result = request.getParameter("Result");
	String description = request.getParameter("Description");
	String cancelResult = "";
	if(result==null){
		ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
		int contentId = 0;
		//1 为取消自动续订
		int cancelType = 1;
		//0为视频VOD
		int contentType = 0;
		//1为VOD
		int businessType = 1;
		String serviceId = "";
		Map orderMap = (HashMap)serviceHelpHWCTC.cancelOrderHWCTC(prodcode,cancelType,serviceId,contentType,contentId,businessType,starttime);
		int ret_code = ((Integer) orderMap.get("RETCODE")).intValue();
		String tempResult = (String) orderMap.get("RETMSG");
		System.out.println("prodcode----------------------------"+prodcode);
		System.out.println("description----------------------------"+tempResult);
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
	}else{
		System.out.println("prodcode----------------------------"+prodcode);
		System.out.println("description----------------------------"+description);
		if("0".equals(result)){
			cancelResult = "尊敬的用户，您成功取消续订了！";	
		}else{
			cancelResult = "尊敬的用户，取消续订失败，详情请咨询10000号！";	
		}
	}
%>
</head>

<body bgcolor="transparent">
<div class="wrapper">
	<!--head-->
	<div class="txt txt-headline">取消续订</div>
	<!--the end-->
	
	
	<!--cancel-->
	<div class="cancel">
		<div class="txt txt-tit">取消续订</div>
	  	<div class="txt txt-con02" id="pomptTxt"><%=cancelResult%></div>
	</div>
	<!--the end-->
	
	
	<!--btn-->
	<div class="btns">
		<div class="item" style="left:129px;">
			<div class="link"><a href="space_cancel.jsp?areaid=1&indexid=3"><img src="../images/t.gif" /></a></div>
			<div class="txt">确认</div>
		</div>
	</div>
	<!--the end-->
</div>	

</body>
</html>
