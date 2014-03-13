<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGSysParam"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page errorPage="ShowException.jsp"%>
<%@ page import="com.huawei.iptvmw.epg.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="datajsp/database.jsp"%>
<%@ include file = "../../keyboard_A2/keydefine.jsp" %>
<%@page import="com.huawei.iptvmw.epg.bean.info.EpgInfo"%>
<%@ page import="com.huawei.iptvmw.logger.EPGSysLogger" %>
<%@page import="java.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.facade.bean.info.UserSubscribe" %>
<%@ page import="com.huawei.iptvmw.facade.bean.info.MonthInfoItem" %>
<%@ page import="javax.servlet.http.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<title>深圳IP电视行业应用EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<%
StringBuffer queryStrbuf = new StringBuffer();
queryStrbuf.append("TEMPLATENAME=0&").append(request.getQueryString());
String queryStr = queryStrbuf.toString();

TurnPage turnPage = new TurnPage(request);
String returnUrl = "";
if (request.getParameter("backurl") != null && !"".equals(request.getParameter("backurl")) && !"null".equals(request.getParameter("backurl")))
{
        returnUrl = request.getParameter("backurl");
}
else
{
        returnUrl = turnPage.getLast();
}



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

%>
<head>
        <meta name="SZMG_IndustryAppSelect" content="szmg_hd" />
    <meta name="page-view-size" content="1280*720" />
        <title>SZMG_SubscribeSelct</title>
    <style type="text/css">
              
				.title
				{
						left:350px;
						font-size:40px;
						top:50px;
                        position:absolute;
                        width:4000px;
                        height:50px;
				}
				
                .applist
                {
			text-align:left;	
		        left:50px;
			top:150px;
                        position:absolute;
                        width:229px;
                        height:70px;
			line-height:70px;
               		background:url(images/industrAppShow_focus.png) no-repeat;
		 }
	
        </style>

<script>
        var returnUrl = "index.jsp";
        var groupId = '<%=groupId%>';
	var user = '<%=user%>';
  	var basepath = '<%=basePath%>'; 


        document.onkeypress = eventHandler;

        function doSelect() {
                        var temp = "http://14.29.1.13:8080/epg/login!index.action?tradeId=1232"+"&itvUserId="+user+"&endUrl="+basepath;
                        window.location.href = temp;
        }


        function eventHandler(event) {
                switch (event.which) {
                        case <%=KEY_BACKSPACE%>:
                        case <%=KEY_RETURN%>:
                                window.location.href = returnUrl;
                                break;
                        case <%=KEY_OK%>:
                                doSelect();
                                break;
                }
        }
        window.onload = function() { init(); }
</script>

</head>
<body style="background:url(images/bg.jpg) no-repeat; background-color:transparent;">
<!-- HTML -->
<body scroll="no" id="body">
<div class = "title">
<div>娣卞湷IP鐢佃琛屼笟搴旂敤灞曠ず椤甸潰</div>
</div>
<div class = "applist">
<div style="top:20px;left:20px;width:300px;" id="industryApp_0"  />  1.鍏夋槑缈犳箹绀惧尯</div>
</div>

</body>
</html>
<!-- End Save for Web Slices -->

<!-- JS: handle the keypress and go_forward -->
<script>

</script>
