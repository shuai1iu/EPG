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
<script type="text/javascript">
<%
/*
    @description 接收directplay用于判断开机进入EPG还是直播频道，以及是否为开机第一次进入首页，接收lastChannelNo确定开机进入哪个频道，groupId为探针提供用户分组信息
	@author ks
	@date 2014-02-14
*/
UserProfile profile = new UserProfile(request);
String groupId = profile.getUserGroupId();

String directPlay = request.getParameter("directplay");
String lastChannelNo = request.getParameter("lastchannelNo");
System.out.println("aaa"+directPlay);
%>

var lastChannelNo = <%=lastChannelNo%> ;
var directPlay = <%=directPlay%>;
var user = Authentication.CTCGetConfig("UserID");
var STBType = Authentication.CTCGetConfig("STBType");


window.onload=function()
{
/*当directPlay不为空时即开机第一次访问该页面，此时发送开机探针*/
if( null != directPlay)
{
        document.getElementById("log_frame").src = "http://219.133.42.99:8080/EPG_Statistics/EPG_BOOT.jsp?userID="+user+"&EPG_TYPE=HD&STB_TYPE="+ STBType + "&GROUP=" + <%=groupId%>;
}

	if ("1" == directPlay && "" != lastChannelNo && null != lastChannelNo)
	{   /*判断directplay值为1，并且lastchannelNo有值，则跳转到频道播放页面*/
		window.location.href="play_ControlChannel.jsp?CHANNELNUM="+lastChannelNo+"&COMEFROMFLAG=1&returnurl=index.jsp";

	}
	else
	{
		window.location.href="index.jsp";
	}
}
</script>
</head>

<body>
<!--隐藏iframe用于发送探针--->
<iframe id="log_frame" name = "log_frame" src="" style="width:1px;height:1px;display:none"></iframe>
</body>
</html>
