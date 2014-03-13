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
<%


//获取用于鉴权的垫片ID
int vodid = 0;
vodid = request.getParameter("VODID")==null?0:Integer.parseInt(request.getParameter("VODID"));
//鉴权用户是否已购买当前产品包
ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
Map retCheckMap = null;
retCheckMap = serviceHelpHWCTC.authorizationHWCTC(vodid,1,0,1,"",0);
//checkretCode为鉴权返回值
int checkretCode = 0;  
int checkresult = 0;
if(null != retCheckMap && null != retCheckMap.get(EPGConstants.KEY_RETCODE))
{
	checkretCode = ((Integer)retCheckMap.get(EPGConstants.KEY_RETCODE)).intValue();
}
//若鉴权返回值为0则鉴权结果置为1，否则置为0
if(checkretCode == 0)
{
	checkresult=1;
}else{

	checkresult=0;
}


String pageName = "subscribed.jsp";
//初始化产品包ID、价格、名称
ArrayList prodList = new ArrayList();
String prodId = "";
int prodPrice = 0;
String prodName = "";
//若鉴权结果为1时，跳转至已订购页面，否则获取当前产品包的ID、价格、名称
if(checkresult == 1)
{
%>
   <script>
       <jsp:forward page="<%=pageName%>"/>
   </script>
<%
}else
{
if( null != retCheckMap)
{
    if( 0 != ((ArrayList)(retCheckMap.get("MONTH_LIST"))).size() )
    {
        prodList = (ArrayList) retCheckMap.get("MONTH_LIST");
    }
    else
    { 
        pageName = "subscribe_Failed.jsp";
%>
   <script>
       <jsp:forward page="<%=pageName%>"/>
   </script>
<%
    }
}else
{
        pageName = "subscribe_Failed.jsp";
%>
   <script>
       <jsp:forward page="<%=pageName%>"/>
   </script>
<%

}
        Object temp = prodList.get(0);
        Map monthMap = null;
        monthMap = (Map)temp;

    prodId =  (String)monthMap.get("PROD_CODE");
    System.out.println("PRODID=="+prodId+"|");
    prodPrice =  Integer.parseInt((String)monthMap.get("PROD_PRICE"));
    prodName =  (String)monthMap.get("PROD_NAME");
}

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
			background:url('images/bg_select.png') no-repeat;
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
//初始化返回地址、产品包名称、产品价格
	var returnUrl = "index.jsp";
    var productname;
	var productpoint;
        productpoint = <%=prodPrice%>;
	
        productname = "<%=prodName%>";
	document.onkeypress = eventHandler;
    //设置光标移动标志
	var flag = 1;
	//初始化显示产品名称、价格、光标初始位置与初始标志
	function init() {
		document.getElementById("info_text_1").innerHTML = productname;
		document.getElementById("info_text_2").innerHTML = productpoint;
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
			window.location.href = "subscribeEnsure.jsp?ORDERINFO="+productpoint+"&SHOWNAME="+productname+"&PRODID=<%=prodId%>+&VODID=<%=vodid%>";
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
	//响应遥控器返回、确认、左右键的方法s
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
