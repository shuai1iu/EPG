<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGSysParam"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGSysParam"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC"%>
<%@ page import="java.net.URLEncoder"%>
<%@ include file = "../../../../keyboard_A2/keydefine.jsp" %>
<%@ include file = "../datajsp/SubStringFunction.jsp"%>
<%
//从上一页面传入产品包信息、名称、价格、垫片ID等内容
int orderInfo = request.getParameter("ORDERINFO")!=null?Integer.parseInt(request.getParameter("ORDERINFO")):0;
String orderName = request.getParameter("SHOWNAME");
System.out.println(orderName);
String prodId = request.getParameter("PRODID");
prodId = prodId.replaceAll(" ","");
String vodid = request.getParameter("VODID"); 
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="���ֶ���ѡ��" content="szmg_hd" />
<meta name="page-view-size" content="640*530" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>SZMG_SubscribeSelct</title>
<style type="text/css">
body{
	font-family: sans-serif;
position:fixed;
overflow:hidden;
	 background-color:transparent;
background:url('images/bg_ensure.png') no-repeat;
left:0px;
top:0px;
width:1280px;
height:720px;
}
.button
{
position:absolute;
width:145px;
height:56px;
}
#choices
{
position:absolute;
top:376px;
left:134px;
}
#infomation
{
	font-family: sans-serif;
position:absolute;
top:95px;
left:90px;
}
#info_title
{
position:absolute;
width:800px;
height:48px;
       font-size:40px;
color:#FFFFFF;
      text-align:center;
      font-weight:bold;
overflow:hidden;
}
.name
{
position:absolute;
width:150px;
height:35px;
       font-size:30px;
color:#C7F6FF;
      text-align:right;
      font-weight:bold;
overflow:hidden;
}
.texts
{
position:absolute;
width:300px;
height:35px;
left:200px;
     font-size:30px;
color:#FFFFFF;
      text-align:left;
      font-weight:normal;
overflow:hidden;
}
</style>

<script>
var returnUrl = "index.jsp";
document.onkeypress = eventHandler;
var flag = 1;
function init() {
	//初始化显示产品名称、价格、光标初始位置与初始标志
	document.getElementById("info_text_1").innerHTML = "<%=orderName%>";
	document.getElementById("info_text_2").innerHTML = <%=orderInfo%> ;
	document.getElementById("info_text_3").innerHTML = endTimeArray[0];
	flag=1;
	displayBack();
}
//选中返回时的光标效果
function displayBack(){
	setWebkitTransform("choice_back", "red.png");
	setWebkitTransform("choice_buy", "green.png");
}
//选中购买时的光标效果	
function displayBuy(){
	setWebkitTransform("choice_back", "green.png");
	setWebkitTransform("choice_buy", "red.png");
}
//光标移动时的图片变化
function setWebkitTransform(object, value) {
	document.getElementById(object).style.backgroundImage = "url(images/" + value + ")";
}
//按确定键所执行方法
function doSelect() {
	switch (flag) {
		case 1:
			//光标位置为1时按确认键跳转至返回地址
			window.location.href = returnUrl;
			break;
		case 2:
			//光标位置为2时按确认键跳转至二次订购页面
			window.location.href = "au_SubscribeEnsureResult.jsp?PRODUCTID=<%=prodId%>&SELECTPRODCONT=0&TEMPLATENAME=0&PROGID=<%=vodid%>&PLAYTYPE=1&CONTENTTYPE=10&ISINTEGRATION=2&BUSINESSTYPE=1&returnurl=index.jsp";
			break;
	}
}

function keyRight() {
	switch (flag) {
		case 1:		
			//光标位置为1时按右键光标移动至购买键，同时将位置标志置为2
			displayBuy();
			flag = 2;
			break;
		case 2:		
			//光标位置为2时按右键光标移动至购买键，同时将位置标志置为1		
			displayBack();
			flag = 1;
			break;
	}
}

function keyLeft() {
	switch (flag) {
		case 1:	
			//光标位置为1时按左键光标移动至购买键，同时将位置标志置为2
			displayBuy();
			flag = 2;
			break;
		case 2:		
			//光标位置为2时按左键光标移动至购买键，同时将位置标志置为2
			displayBack();
			flag = 1;
			break;
	}
}
//响应遥控器返回、确认、左右键的方法
function eventHandler(event) {
	switch (event.which) {
		case <%=KEY_BACKSPACE%>:
		case <%=KEY_RETURN%>:
			window.location.href = returnUrl;
			break;
		case <%=KEY_OK%>:
			doSelect();
			break;
		case <%=KEY_RIGHT%>:
			keyRight();
			break;
		case <%=KEY_LEFT%>:
			keyLeft();
			break;
	}
}
window.onload = function() { init(); }
</script>

</head>
<!-- HTML -->
<body scroll="no">
<div id="infomation" style="visibility:visible;">

<div class="texts" id="info_text_1" style="top:80px;font-weight:bold;"></div>
<div class="texts" id="info_text_2" style="top:125px;"></div>
</div>
<div id="choices" style="visibility:visible;">
<div class="button" id="choice_buy" style="line-height:47px;font-size:28px;color:#C7F6FF;text-align:center;font-weight:bold;top:10px; left:0px; background:url('images/green.png') no-repeat; ">积分订购</div>
<div class="button" id="choice_back" style="line-height:47px;font-size:28px;color:#C7F6FF;text-align:center;font-weight:bold;top:10px; left:286px; background:url('images/green.png') no-repeat; ">返回</div>
</div>
<!--
<div id="warming" style="visibility:visible;position:absolute;width:1159px;height:108px;font-size:28px;color:#FFFFFF;text-align:center;font-weight:bold;left: 62px;top: 395px;">
请确认播放"高清体验区"内的节目时是否流畅。如播放不流畅，请联系10000号，确认您的IP电视业务账号速率达到高清节目播放标准后订购。
</div>
-->
</body>
</html>
<!-- End Save for Web Slices -->

<!-- JS: handle the keypress and go_forward -->
<script>

</script>
