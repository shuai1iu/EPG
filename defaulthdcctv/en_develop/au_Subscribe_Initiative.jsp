<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.facade.service.BookmarkImpl" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.Integer"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*" %>
<%@ include file = "util/util_getPosterPaths.jsp"%>
<%@ include file = "../../keyboard_A2/keydefine.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>主动购买页</title>
<meta name="page-view-size" content="1280*720" />
<script> 
var yearList = new Array();
var monthList = new Array();
var dateList = new Array();
<%
StringBuffer queryStrbuf = new StringBuffer();
queryStrbuf.append(request.getQueryString());
String queryStr = queryStrbuf.toString();
TurnPage turnPage = new TurnPage(request);
String returnUrl = "";
if (request.getParameter("backurl") != null && !"".equals(request.getParameter("backurl")) && !"null".equals(request.getParameter("backurl"))) {
    	returnUrl = request.getParameter("backurl");
}else{
        returnUrl = turnPage.getLast();
 }
String strFilmId = "";
if (request.getParameter("PROGID") != null && !"".equals(request.getParameter("PROGID")) && !"null".equals(request.getParameter("PROGID"))) {
	strFilmId = request.getParameter("PROGID");
}

ArrayList productList = new ArrayList();
try{
	HashMap retMap = (HashMap) session.getAttribute("RETMAPSH");

	if(retMap.get("TIMES_LIST") != null){
		productList.addAll((ArrayList)retMap.get("TIMES_LIST"));
	}
	if(retMap.get("MONTH_LIST") != null){		
		productList.addAll((ArrayList)retMap.get("MONTH_LIST"));
	}
	if(retMap.get("PREORDERED_PRODLIST") != null){
		productList.addAll((ArrayList)retMap.get("PREORDERED_PRODLIST"));
	}
	String tempProdEndTime = null;
	String year = null;
	String month = null;
	String date = null;
	for(int i=0; i<productList.size(); i++){
		HashMap productInfo = (HashMap)productList.get(i);
		String prodID = (String)productInfo.get("PROD_CODE");
		String serviceId = (String)productInfo.get("SERVICE_CODE");
		String prodBeginTime = (String)productInfo.get("productStartTime");	//产品包开始时间
		String prodEndTime = (String)productInfo.get("productEndTime");		//产品包结束时间

		if (prodEndTime != null && prodEndTime.length() != 0){
			year	=	prodEndTime.substring(0,4);
			month	=	prodEndTime.substring(4,6);
			date	=	prodEndTime.substring(6,8);
		}
		%>
		<!-- 完成数据的封装 -->
		yearList[<%=i%>] = '<%=year%>';
		monthList[<%=i%>] = '<%=month%>';
		dateList[<%=i%>] = '<%=date%>';
		<%
	}
}catch(Exception e){
	%>
		<jsp:forward page="au_Subscribe_Initiative_Prompt.jsp" />
	<%
}
%>
//SubInit_buy_on.png				付费购买高亮
//SubInit_buy_off.png				付费购买去高亮
//SubInit_back_on.png			返回高亮
//SubInit_back_off_up.png		上返回去高亮
//SubInit_back_off_down.png	下返回去高亮
//SubInit_try_on.png				测试高亮
//SubInit_try_off.png				测试去高亮
var flag = 0;//0表示返回，1表示确认或测试
var flag2 = 0;//0表示焦点在下，1表示焦点在上
document.onkeypress = eventHandler;
var returnurl = '<%=returnUrl%>';
function init(){
	flag	=	1;
	flag2	=	1;
	displayBuy();
	document.getElementById("year").innerHTML	=	yearList[0];
	document.getElementById("month").innerHTML	=	monthList[0];
	document.getElementById("date").innerHTML	=	dateList[0];
}
//上返回键
function displayBack(){
	setWebkitTransform("choice_back_up", "SubInit_back_on.png");
	setWebkitTransform("choice_back_down", "SubInit_back_off_down.png");
	setWebkitTransform("choice_buy", "SubInit_buy_off.png");
	setWebkitTransform("choice_try", "SubInit_try_off.png");
}
function displayBuy(){
	setWebkitTransform("choice_back_up", "SubInit_back_off_up.png");
	setWebkitTransform("choice_back_down", "SubInit_back_off_down.png");
	setWebkitTransform("choice_buy", "SubInit_buy_on.png");
	setWebkitTransform("choice_try", "SubInit_try_off.png");
}
function displayTry(){
	setWebkitTransform("choice_back_up", "SubInit_back_off_up.png");
	setWebkitTransform("choice_back_down", "SubInit_back_off_down.png");
	setWebkitTransform("choice_buy", "SubInit_buy_off.png");
	setWebkitTransform("choice_try", "SubInit_try_on.png");
}
//下返回键
function displayBack2(){
	setWebkitTransform("choice_back_up", "SubInit_back_off_up.png");
	setWebkitTransform("choice_back_down", "SubInit_back_on.png");
	setWebkitTransform("choice_buy", "SubInit_buy_off.png");
	setWebkitTransform("choice_try", "SubInit_try_off.png");
}
function setWebkitTransform(object, value) {
		document.getElementById(object).style.backgroundImage = "url(images/" + value + ")";
}

function doSelect() {
	if(flag2 == 1){
		switch (flag) {
			case 0:
				var temp = returnurl;
				window.location.href = temp;
				break;
			case 1:
				var temp = "au_SubscribeEnsure.jsp?RETURNFLAG=1&PROGID=1561817&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIR=1&backurl=SZ_EPG/page/index.jsp";
				window.location.href = temp;
				break;
		}
	}else if(flag2 ==0){
		switch (flag) {
			case 0:	
				var temp = returnurl;
				window.location.href = temp;
				break;
			case 1:	
				var temp = "HD_experience.jsp?returnurl=" + returnurl;
				window.location.href = temp;
				break;
		}
	}
}

function keyRight() {
	if(flag2 == 1){
		switch (flag) {
			case 0:	
				displayBuy();
				flag = 1;
				break;
			case 1:	
				displayBack();
				flag = 0;
				break;
		}
	}else if(flag2 ==0){
		switch (flag) {
			case 0:	
				displayTry();
				flag = 1;
				break;
			case 1:	
				displayBack2();
				flag = 0;
				break;
		}
	}
}

function keyLeft() {
	if(flag2 == 1){
		switch (flag) {
			case 0:	
				displayBuy();
				flag = 1;
				break;
			case 1:	
				displayBack();
				flag = 0;
				break;
		}
	}else if(flag2 ==0){
		switch (flag) {
			case 0:	
				displayTry();
				flag = 1;
				break;
			case 1:	
				displayBack2();
				flag = 0;
				break;
		}
	}
}

function keyUp(){
	switch(flag2){
		case 0:
			displayBuy();
			flag2 = 1;
			flag = 1;
			break;
		case 1:
			displayTry();
			flag2 = 0;
			flag = 1;
			break;
	}
}
function keyDown(){
	switch(flag2){
		case 0:
			displayBuy();
			flag2 = 1;
			flag = 1;
			break;
		case 1:
			displayTry();
			flag2 = 0;
			flag = 1;
			break;
	}
}

function eventHandler(event) {
	switch (event.which) {
		case <%=KEY_BACKSPACE%>:
		case <%=KEY_RETURN%>:
			window.location.href = returnurl;
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
		case <%=KEY_UP%>:
			keyUp();
			break;
		case <%=KEY_DOWN%>:
			keyDown();
			break;
	}
}

</script>
</head>
<body bgcolor="transparent" leftmargin="0px" topmargin="0px" marginwidth="0px" marginheight="0px" style="background-color: transparent"  onLoad="init();">
<div class = "showTime" style="visibility:visible; width:1280px; height:720px; position:absolute; z-index:21; background:url('images/SubInit_bg.png') no-repeat;">
<!--
	<div class = "time" id = "year" style = "font-size:21px; color:#000; position:absolute; width:55px; height24px; top:282px; left:283px; text-align:center; overflow:hidden;">2014</div>
	<div class = "time" id = "month" style = "font-size:21px; color:#000; position:absolute; width:55px; height24px; top:282px; left:342px; text-align:center; overflow:hidden;">12</div>
	<div class = "time" id = "date" style = "font-size:21px; color:#000; position:absolute; width:55px; height24px; top:282px; left:386px; text-align:center; overflow:hidden;">31</div>
-->

	<div class="button" id="choice_buy" style=" position:absolute; width:132px; height:62px; top:437px; left:611px; background:url('images/SubInit_buy_off.png') no-repeat;"></div>
	<div class="button" id="choice_back_up" style="position:absolute; width:132px; height:62px; top:437px; left:856px; background:url('images/SubInit_back_off_up.png') no-repeat; "></div>
	<div class="button" id="choice_try" style=" position:absolute; width:132px; height:62px; top:576px; left:850px; background:url('images/SubInit_buy_off.png') no-repeat;"></div>
	<div class="button" id="choice_back_down" style="position:absolute; width:132px; height:62px; top:576px; left:999px; background:url('images/SubInit_back_off_down.png') no-repeat; "></div>
</div>
</body>
</html>
