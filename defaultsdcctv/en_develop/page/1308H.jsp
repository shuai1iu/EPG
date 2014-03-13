<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%
    UserProfile profile = new UserProfile(request);
    String groupId = profile.getUserGroupId();
     System.out.println("======GROUPID========"+groupId);
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="page-view-size" content="640*530">
<title>RTSP播放</title>
</head>
<body onLoad="init()" onUnload="exitPage()" bgcolor="transparent">
</body>
<script>
var STBType =Authentication.CTCGetConfig("STBType");
var groupId = <%=groupId%>;
if(STBType == "EC1308H_pub" && groupId == "1232")
{
	window.location.href = "index.jsp";
}else
{
	 window.location.href = "rtspPlay.jsp?RTSPCHAN=escape('rtsp://58.60.146.6/PLTV/88888895/224/3221227202/10000100000000060000000000966366_0.smil')";
}
</script>
</html>
