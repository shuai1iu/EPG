<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Activity EPG 2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />

</head>

<body onLoad="goVas()">

<%
UserProfile upf_Jump = new UserProfile(request);
String user = upf_Jump.getUserId();
ServiceHelp serviceHelp_Jump = new ServiceHelp(request);

//��ȡ���ط�������ַ
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/jsp/defaultsdcctv/en/page/index.jsp";
System.out.println("BASEPATH"+basePath);
String itvUserId = (String)session.getAttribute("USERID");
%>

<div class="wrapper">
	<!--menu-->
	<div class="menu">
    </div>
	<!--the end-->
	
</div>	

<script>
if(typeof(iPanel)!= 'undefined'){iPanel.focusWidth = "4"; iPanel.defaultFocusColor = "#2A5BB8";}
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
	location.href="http://125.88.98.144:9090/gd/index_38.jsp?user=<%=itvUserId%>&endUrl=<%=basePath%>";
//	location.href="http://14.29.0.31:8000/ggly/index2.jsp?userId=<%=itvUserId%>&backUrl=<%=basePath%>";
}
</script>
</body>
</html>
