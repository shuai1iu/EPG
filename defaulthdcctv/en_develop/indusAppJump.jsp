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
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.facade.bean.info.UserSubscribe" %>
<%@ page import="com.huawei.iptvmw.facade.bean.info.MonthInfoItem" %>
<%@ page import="javax.servlet.http.*" %>
<%
    UserProfile profile = new UserProfile(request);
    String templateName = profile.getTemplate();
    String groupId = profile.getUserGroupId();
    String user = profile.getUserId();
    ServiceHelp serviceHelp = new ServiceHelp(request);
    ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
    String userTempName = serviceHelp.getUserTemplateName();
    String directPageName = "index.jsp";
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() +
            path + "/jsp/" + userTempName + "/en/"+ directPageName;
	Map orderedMap = null;
	String month1 = StringDateUtil.getTodaytimeString("yyyymm");
	String month3 = StringDateUtil.adjustMonth(month1, -2);
	UserProfile userProfile = new UserProfile(request);
	UserSubscribe subInfo = userProfile.getSubscribeList();
	System.out.println("=======SuscribeList===="+subInfo);
	List<MonthInfoItem> subMonthList = (List<MonthInfoItem>)subInfo.getMonthInfoList();



	System.out.println("-================GROUPIDINCATEGORY====="+groupId);



		%>

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
		var groupId = "<%=groupId%>";
		var directPageName = "<%=directPageName%>";
		var groupId = "<%=groupId%>";
		var basePath = "<%=basePath%>";
		var user = "<%=user%>";
window.onload=function()
{

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
	else if("1232 == groupId")
        {
                directPageName = "http://14.29.1.13:8080/epg/login!index.action?tradeId="+groupId+"&itvUserId=" + user + "&endUrl=" + basePath;
                window.location.href=directPageName;
        } 
	else {
		window.location.href="index.jsp";
	}
}
</script>
</head>

<body>
</body>
</html>
