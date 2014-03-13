<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="com.huawei.iptvmw.epg.bean.info.EpgInfo"%>

<%@page pageEncoding="UTF-8"%>
<%@page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.logger.EPGSysLogger" %>
<%@ page errorPage="ShowException.jsp"%>
<%@ page import="com.huawei.iptvmw.epg.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.*"%>

<%@page import="java.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%
    UserProfile profile = new UserProfile(request);
    String templateName = profile.getTemplate();
    String groupId = profile.getUserGroupId();
    String user = profile.getUserId();
    ServiceHelp serviceHelp = new ServiceHelp(request);
    String userTempName = serviceHelp.getUserTemplateName();
    String directPageName = "page/index.jsp";
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() +
            path + "/jsp/" + userTempName + "/en/"+ directPageName;
	System.out.println("======GROUPID========"+groupId);

String directPlay = request.getParameter("directplay");
String lastChannelNo = request.getParameter("lastchannelNo");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页_央视高清EPG</title>
<meta name="page-view-size" content="640*530" />
<script src="js/registerGlobalKey.js"  language="javascript"></script>
<script type="text/javascript">
    var directPageName = "<%=directPageName%>";
    var groupId = "<%=groupId%>";
    var basePath = "<%=basePath%>";
    var user = "<%=user%>";
    var isFirst = 0;
  
window.onload=function()
{

if( null == directPlay)
{
         isFirst = 1;
}

	if (typeof(iPanel) != 'undefined')
	{
		iPanel.focusWidth = "2";
		iPanel.defaultFocusColor = "#FCFF05";
	}


	if("1241" == groupId)
	{
		directPageName = "http://14.29.1.13:8080/epg/login!index.action?tradeId=" + groupId + "&itvUserId=" + user + "&endUrl=" + basePath;
	window.location.href=directPageName;
	}
	else if("981" == groupId)
        {
                directPageName = "http://14.29.1.13:8080/epg/login!index.action?tradeId=100005&itvUserId=" + user + "&endUrl=" + basePath;
                window.location.href=directPageName;

        }

	else
	{
		window.location.href="page/index.jsp?isFirst=" + isFirst;	
	}


}


</script>
</head>

<body>
</body>
</html>
