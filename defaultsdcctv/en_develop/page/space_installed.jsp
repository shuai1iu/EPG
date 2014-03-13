<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="com.huawei.iptvmw.epg.bean.info.UserProfile"%>
<%@page import="com.huawei.iptvmw.epg.facade.bean.ParametersLogin"%>

<%
ParametersLogin login = new ParametersLogin();
UserProfile user = new UserProfile(request);
String user_id = "";
//user_id = login.getUserId();
user_id = (String)session.getAttribute("USERID");

//public String getSign(String accNbr)
	String accNbr = user_id ;
	String businessKey = "HUAWEI";
	String sign = null;
	char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9','a', 'b', 'c', 'd', 'e', 'f' };
	try {
		byte[] strTemp = (accNbr + businessKey).getBytes("utf-8");
		MessageDigest mdTemp = MessageDigest.getInstance("MD5");
		mdTemp.update(strTemp);
		byte[] md = mdTemp.digest();
		int j = md.length;
		char str[] = new char[j * 2];
		int k = 0;
		for (int i = 0; i < j; i++) {
			byte byte0 = md[i];

			str[k++] = hexDigits[byte0 >>> 4 & 15];
			str[k++] = hexDigits[byte0 & 15];
		}
		sign = new String(str);
		 
	} catch (Exception e) {
		e.printStackTrace();
	}
//end
String vodId = "1725353";//hxt 20131204   新深圳IP电视使用指南
//String vodId = "1593709";//深圳IP电视使用指南（标清）
//if (request.getParameter("PROGID") != null && !"".equals(request.getParameter("PROGID")) && !"null".equals(request.getParameter("PROGID"))) {
//	vodId = request.getParameter("PROGID"); 
//}
String toUrl = "/EPG/jsp/defaultsdcctv/en/page/play_controlVod.jsp?PROGID=1725353&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&backurl=/EPG/jsp/defaultsdcctv/en/page/index.jsp?";//hxt 20131204   新深圳IP电视使用指南
//String toUrl = "/EPG/jsp/defaultsdcctv/en/page/play_controlVod.jsp?PROGID=1593709&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&backurl=/EPG/jsp/defaultsdcctv/en/page/index.jsp?";
//if (request.getParameter("toUrl") != null && !"".equals(request.getParameter("toUrl")) && !"null".equals(request.getParameter("toUrl"))) {
//	toUrl = request.getParameter("toUrl"); 
//}
String stbMac = "";//机顶盒MAC
stbMac = user.getSTBMAC();

String stbId = "";//机顶盒ID
stbId = user.getStbId();

String stbIp = "";//机顶盒IP
stbIp = user.getStbIp();

String stbType = "";//机顶盒型号
stbType = login.getStbType();

String epgIp = "";//EPG IP
epgIp = request.getServerName();

//String installedUrl = "http://125.88.107.93:8080/ItvNewUser/VodPlay?acc_nbr=" + user_id + "&vodId=" + vodId + "&Sign=" + sign;
//String installedUrl = "http://125.88.107.93:8080/ItvNewUser/VodPlay?acc_nbr=" + user_id + "&vodId=" + vodId + "&stbMac=" + stbMac + "&stbId=" + stbId + "&stbIp=" + stbIp + "&stbType=" + stbType + "&epgIp=" + epgIp + "&Sign=" + sign;
//System.out.println("installedUrl" + installedUrl);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>装机人员跳转页</title>
<meta name="page-view-size" content="1280*720" />
<script>
	function init()
	{
		// 装机人员统计
		var user_id = '<%=user_id%>';
		var vodid = '<%=vodId%>';
		var sign = '<%=sign%>';
		var stbip = '<%=stbIp%>';
		var epgip = '<%=epgIp%>';
		var stbType= Authentication.CUGetConfig("STBType");
		var stbMac = Authentication.CUGetConfig("MAC");
		var stbId = Authentication.CUGetConfig("STBID");
		
		//js stbIp无法获取故隐藏
		//var stbIp = Authentication.CUGetConfig("IP");
		var installedurl = "http://125.88.99.26:8082/ItvNewUser/VodPlay?acc_nbr=" + user_id + "&vodId=" + vodid + "&stbMac=" + stbMac + "&stbId=" + stbId + "&stbIp=" + stbip + "&stbType=" + stbType + "&epgIp=" + epgip + "&Sign=" + sign;
		document.getElementById("installedIframe").src = installedurl;	
		var tourl = '<%=toUrl%>';
		window.location.href = tourl;
	}
	

</script>
</head>
<body bgcolor="transparent" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="init()">

  <%-- 装机人员记录数据--%>
  <iframe id="installedIframe" style="width:0px; height:0px" style="display:none;"></iframe>

</body>
</html>
