  <%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGSysParam"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="datajsp/database.jsp"%>
<%@ include file = "../../keyboard_A2/keydefine.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	StringBuffer queryStrbuf = new StringBuffer();
	queryStrbuf.append("TEMPLATENAME=0&").append(request.getQueryString());
	String queryStr = queryStrbuf.toString();
	
    	TurnPage turnPage = new TurnPage(request);  
	String returnUrl = "";
	String typeid = "";
	if (request.getParameter("backurl") != null && !"".equals(request.getParameter("backurl")) && !"null".equals(request.getParameter("backurl"))) 
    {
    	returnUrl = request.getParameter("backurl");
    }
    else
    {
        returnUrl = turnPage.getLast();
    }
    	typeid = request.getParameter("typeid");


MetaData metadata = new MetaData(request);
String[] backgroundPic = new String[1];
String vasurl = "";


ArrayList tmpiframeVas=(ArrayList)metadata.getVasListByTypeId("10000100000000090000000000032131", 1, 0);
if(tmpiframeVas!=null)
{
	ArrayList tmpiframeVasInfo = (ArrayList)tmpiframeVas.get(1);
	if(tmpiframeVasInfo!=null&&tmpiframeVasInfo.size()>0)
	{
		HashMap mapindexx=(HashMap)tmpiframeVasInfo.get(0);
		int tempindexvasid=(Integer)mapindexx.get("VASID");

		ServiceHelp serviceHelpxx = new ServiceHelp(request);
		if(serviceHelpxx!=null)
		{
			vasurl=serviceHelpxx.getVasUrl(tempindexvasid);
			Map mapindex = metadata.getVasDetailInfo(tempindexvasid);
			backgroundPic[0]=mapindex.get("POSTERPATH").toString();
		}
	}
}

%>
<head>
	<meta name="SZMG_SubscribeSelct" content="szmg_hd" />
    <meta name="page-view-size" content="1280*720" />
	<title>SZMG_SubscribeSelct</title>
    <style type="text/css">
		body{
			font-family: sans-serif;
			position:absolute;
			overflow:hidden;
			background-color:transparent;
			background:url('images/vipExperience.jpg') no-repeat;
			left:0px;
			top:0px;
			width:1280px;
			height:720px;
		}
		.button
		{
			position:absolute;
			width:161px;
			height:86px;
		}
	</style>
    
<script>
	var returnUrl = '<%=returnUrl%>';
	var typeId = '<%=typeid%>';
	var backgroundPic='<%=backgroundPic[0]%>';
	
	document.onkeypress = eventHandler;
	var flag = 0;
	function init() {
	
		document.body.style.background = "url("+backgroundPic+")";
}

	function doSelect() {
			var temp = "/EPG/jsp/defaulthdcctv/en_develop/SZ_EPG/page/hdlist.jsp?typeid=" + typeId + "&returnurl=../../index.jsp?back=1"; 
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
<!-- HTML -->
<body scroll="no">
</body>
</html>
<!-- End Save for Web Slices -->

<!-- JS: handle the keypress and go_forward -->
<script>
		
</script>
