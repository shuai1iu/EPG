<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%
    UserProfile profile = new UserProfile(request);
    String groupId = profile.getUserGroupId();
     System.out.println("======GROUPID========"+groupId);
	String chanNum = request.getParameter("CHANNELNUM");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="page-view-size" content="640*530">
<title>RTSP播放</title>
</head>
<body onLoad="init()" onUnload="exitPage()" bgcolor="transparent">
</body>
<script>
var groupId = <%=groupId%>;
var chanNum = <%=chanNum%>;
if(groupId == "1301")
{
	window.location.href = "fenzutishi.jsp";
}else
{
	 window.location.href = "play_ControlChannel.jsp?CHANNELNUM="+chanNum+"&COMEFROMFLAG=1&returnurl=index.jsp";
}
</script>
</html>
