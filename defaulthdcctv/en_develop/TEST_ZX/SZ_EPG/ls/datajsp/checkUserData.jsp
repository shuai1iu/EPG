<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%
    ArrayList resultList = new ArrayList();
    ServiceHelp serviceHelp = new ServiceHelp(request);
	resultList = serviceHelp.getMonthSuites(0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="page-view-size" content="1280*720" />
<title>无标题文档</title>
</head>
<script type="text/javascript">
function init()
{
    document.getElementById("testText").innerHTML='<%=resultList%>';
	document.getElementById("ensure").focus();
}

function subScribe()
{
	document.getElementById('hidden_frame').src = "ensureSubscribe.jsp?productID=4201";
}

function showResult(resultMap)
{
	 document.getElementById("testText2").innerHTML=resultMap;
}
</script>
<body style="background-color:#FFF; width:1280px; height:720px" onload="init();">
<div id="testText" style="color:#F00; position:absolute; left: 46px; top: 22px; width: 828px; height: 79px;">11111</div>
<div id="testText2" style="color:#F00; position:absolute; left: 46px; top: 500px; width: 828px; height: 79px;">222222</div>
<div style="position:absolute; left: 82px; top: 160px;">
  <div class="link"><a href="#" onclick="subScribe()" id="ensure"><img src="../images/dot.gif" /></a></div>
  <div class="text">订购</div>
</div>
<iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="0" height="0" ></iframe>	
</body>
</html>