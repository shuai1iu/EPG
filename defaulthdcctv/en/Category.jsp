<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页_央视高清EPG</title>
<meta name="page-view-size" content="1280*720" />
<style type="text/css">
body{background-color:#000}
</style>
<script src="js/registerGlobalKey.js"  language="javascript"></script>
<script type="text/javascript" src="js/gstatj.js"></script>
<script type="text/javascript">
<%
String directPlay = request.getParameter("directplay");
String lastChannelNo = request.getParameter("lastchannelNo");
UserProfile userProfile = new UserProfile(request);
String userid = userProfile.getUserId();
%>

var lastChannelNo = <%=lastChannelNo%> ;
var directPlay = <%=directPlay%>;
var isFirst = 0;


window.onload=function()
{
    gstaFun('<%=userid%>',635);
/*如果directPlay不为空值，则说明该页面是开机第一次进入*/
    if( null != directPlay)
    {
         isFirst = 1;
    }

	if ("1" == directPlay && "" != lastChannelNo && null != lastChannelNo)
	{   
		window.location.href="play_ControlChannel.jsp?CHANNELNUM="+lastChannelNo+"&COMEFROMFLAG=1&returnurl=index.jsp";

	}
	else
	{
		window.location.href="index.jsp?isFirst="+ isFirst;
	}
}
</script>
</head>

<body>
</body>
</html>
