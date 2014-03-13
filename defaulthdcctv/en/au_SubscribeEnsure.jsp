<%-- FileName:au_SubscribeEnsure.jsp --%>
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
<%@ include file = "../../keyboard_A2/keydefine.jsp" %>
<%@ include file = "datajsp/SubStringFunction.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<script>
    var orderinfo = new Array();
	var isScroll = new Array();
	var orderinfo1 = new Array();
    var priceArr = new Array();
	var endTimeArray = new Array();

<%
    //页面跳转
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
	
	int flag = 0;
	int flag2 = 0;
	//电视剧标志
	String isTvseriesFlag = request.getParameter("ISTVSERIESFLAG");
	String fatherId = request.getParameter("FATHERSERIESID");
	String sProgId = request.getParameter("PROGID"); 
	String prodID0 = sProgId;
	int progId = Integer.parseInt(sProgId);
	ServiceHelp serviceHelp = new ServiceHelp(request);
	MetaData metaData = new MetaData(request);
	ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
	//栏目号
	String typesId = request.getParameter("TYPE_ID")==null?"-1":"null".equals(request.getParameter("TYPE_ID"))?"-1":request.getParameter("TYPE_ID");
	 // 播放类型  内容类型 业务类型
	String sPlayType = request.getParameter("PLAYTYPE");
	String  vasName= request.getParameter("VASNAME");
	//String sContentType = request.getParameter("CONTENTTYPE");
	//String sBusinessType = request.getParameter("BUSINESSTYPE");
	//int contentType = Integer.parseInt(sContentType);	
    //int businessType = Integer.parseInt(sBusinessType);
	int playType = Integer.parseInt(sPlayType);
	int showProductType = 3;
	HashMap film=null;
	//Map retMap = null;
	int fatherSeriesId = -2;
	HashMap retMap = (HashMap) session.getAttribute("RETMAPSH");
	//HashMap retHashMap = (HashMap)request.getAttribute("RETMAP");
	//System.out.println("retHashMap="+retHashMap);
	//System.out.println(fatherSeriesId+"---"+playType+"---"+contentType+"---"+businessType+"---"+typesId+"---"+fatherSeriesId+"---"+progId+"---");
	/*if ("1".equals(isTvseriesFlag) || !"-2".equals(fatherId)) 
	{
		retMap = serviceHelpHWCTC.authorizationHWCTC(fatherSeriesId,playType, contentType, businessType, typesId,fatherSeriesId);
		
		//retMap = serviceHelpHWCTC.authorizationHWCTC(progId,playType, contentType, businessType, typesId,fatherSeriesId);
	}
	else if (EPGConstants.PLAYTYPE_VAS == playType) 
	{
		retMap = serviceHelpHWCTC.authorizationHWCTC(progId, playType, contentType,businessType, typesId, fatherSeriesId);
	} 
	else if (EPGConstants.PLAYTYPE_TVOD == playType) 
	{
		retMap = serviceHelpHWCTC.authorizationHWCTC(progId, playType, contentType,businessType, typesId, fatherSeriesId);
	} 
	else 
	{	
		retMap = serviceHelpHWCTC.authorizationHWCTC(progId, playType,contentType, businessType, typesId, fatherSeriesId);
	}*/
	//System.out.println("                                           retMap===="+retMap);
	
	if(playType == EPGConstants.PLAYTYPE_VOD||playType==EPGConstants.PLAYTYPE_BOOKMARK)
	{
		 //showProductType = showType;
		 
		 if(isTvseriesFlag!=null && fatherId != null && "1".equals(isTvseriesFlag))
		 {
			int intFatherId = Integer.parseInt(fatherId);
			film = (HashMap)metaData.getVodDetailInfo(intFatherId);
		 }
		else
		{
			film = (HashMap)metaData.getVodDetailInfo(progId); 
		}
	}
	if(playType == EPGConstants.PLAYTYPE_TVOD)
	{
		 film = (HashMap)metaData.getPlayBillInfo(progId);
	}
	if(playType == 2)
	{
		film = (HashMap)metaData.getChannelInfo(sProgId);
		//showProductType = 1;
	}
	if(playType == EPGConstants.PLAYTYPE_VAS)
	{
		film = (HashMap)metaData.getVasDetailInfo(progId);
	}
	String progName= "";
	String vodPrice = "0";
	String vodPrices = "0";
	if(film != null)
	{
		vodPrice = (String)(film.get("VODPRICE")==null?"0":film.get("VODPRICE"));
		
		vodPrices = (String)(film.get("VODPRICE")==null?"0":film.get("VODPRICE"));
		

		if(playType == EPGConstants.PLAYTYPE_VOD||playType==EPGConstants.PLAYTYPE_BOOKMARK)
		{
			progName = (String)(EPGUtil.swapHtmlStr(film.get("VODNAME").toString(),23,1));
		}
		else if(playType==2)
		{
			progName = (String)(EPGUtil.swapHtmlStr(film.get("CHANNELNAME").toString(),23,1));
		}
		else if(playType == EPGConstants.PLAYTYPE_VAS)
		{
			progName = (String)(EPGUtil.swapHtmlStr(film.get("VASNAME").toString(),23,1));
		}
		else
		{
			progName = (String)(EPGUtil.swapHtmlStr(film.get("PROGRAMNAME").toString(),23,1));
		}
	}
	if(progName == null  || progName.equals(""))
	{
		progName = vasName;
	}
	ArrayList productList = new ArrayList();
	//当配置项不为 0 ,1 ,2,3的时候 默认的为包月按次都展示。
	if( showProductType != 0 && showProductType != 1 && showProductType != 2 && showProductType != 3)
	{
		if(retMap.get("TIMES_LIST") != null)
		{
			productList.addAll((ArrayList)retMap.get("TIMES_LIST"));
		}
		if(retMap.get("MONTH_LIST") != null)
		{
			productList.addAll((ArrayList)retMap.get("MONTH_LIST"));
		}
	}
	if( showProductType == 0)//0表示只展示点播产品
	{
		productList = (ArrayList)retMap.get("TIMES_LIST");
	}
	if( showProductType == 1)//1表示只展示包月产品
	{
		productList = (ArrayList)retMap.get("MONTH_LIST");
	}
	if(showProductType == 2) //2只展示积分消费
	{
		productList = (ArrayList)retMap.get("PREORDERED_PRODLIST");
	}
	if( showProductType == 3)//3表示展示所有产品
	{
		if(retMap.get("TIMES_LIST") != null)
		{
			productList.addAll((ArrayList)retMap.get("TIMES_LIST"));
			ArrayList timeList = (ArrayList)retMap.get("TIMES_LIST");
			flag = timeList.size();
		}
		if(retMap.get("MONTH_LIST") != null)
		{		
			productList.addAll((ArrayList)retMap.get("MONTH_LIST"));
			ArrayList mouseList = (ArrayList)retMap.get("MONTH_LIST");
			flag2 = mouseList.size();
		}
		if(retMap.get("PREORDERED_PRODLIST") != null)
		{
			productList.addAll((ArrayList)retMap.get("PREORDERED_PRODLIST"));
			ArrayList pointList = (ArrayList)retMap.get("PREORDERED_PRODLIST");
		}
	}
	//System.out.println("--------"+productList+"--------productList="+productList.size());
	if(productList == null || productList.size() == 0)
	{
		turnPage.removeLast();
		%>
			<jsp:forward page="errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=80" />
		<%		
	}
	int prodLength = productList.size();

	String queryStr = request.getQueryString();
	for(int i=0; i<productList.size(); i++)
	{
		HashMap productInfo = (HashMap)productList.get(i);
		String prodDesc = (String)productInfo.get("PROD_DESCRIBE");
		int prodCont = -1;
		if(null!=productInfo.get("PROD_CONTINUEABLE"))
		{
			prodCont = ((Integer)productInfo.get("PROD_CONTINUEABLE")).intValue();
		}
		else
		{
			prodCont = -1;
		}
		//int prodCont = ((Integer)productInfo.get("PROD_CONTINUEABLE")).intValue();
	
		if(null == prodDesc || "null".equals(prodDesc))
        {
            prodDesc = "";  
        }
        else
        {
            prodDesc = EPGUtil.swapHtmlStr(prodDesc,50,3);
        }
		
		String prodName = (String)productInfo.get("PROD_NAME");
		String prodName1 = (String)productInfo.get("PROD_NAME");
		if (prodName != null)
    	{
    	    //prodName = EPGUtil.swapHtmlStr(prodName,20,1);
			prodName = subStringFunction(prodName,1,500);
    	}
		
		//0表示不需要滚动,1表示需要滚动
		int isScroll = 0;
		if(!prodName.equals(prodName1))
		{
			isScroll = 1;
		}		
		
		String prodPrice="0";
		String tempProdPrice="0";
		String cdrPrice="0";
		
		
		prodPrice = (String)productInfo.get("PROD_PRICE");
		
		
				
		cdrPrice  = (String)productInfo.get("PROD_PRICE");
		if(prodPrice==null)
		{
			prodPrice="0";
		}
		else
		{
			try
			{
				double num = Double.parseDouble(prodPrice);
				
				num = num/100;
				if (prodPrice != null) 
				{
					prodPrice = EPGUtil.swapHtmlStr(num+"",17, 1);
					tempProdPrice = prodPrice;
					
				}
			} 
			catch (Exception ex) 
			{
				prodPrice = EPGUtil.swapHtmlStr(prodPrice,17, 1);
		
				prodPrice = prodPrice;
				tempProdPrice = prodPrice;
				
				
				
			}
		}
		//是否支持续订
		
	
		if(prodCont == 0 && (playType == EPGConstants.PLAYTYPE_VOD||playType==EPGConstants.PLAYTYPE_BOOKMARK))
		{
		    if(vodPrice==null)
			{
				vodPrice="0";
			}
			else
			{
				try
				{
					double num = Double.parseDouble(vodPrices);
					num = num/100;
					if (vodPrice != null) 
					{
						vodPrice = EPGUtil.swapHtmlStr(num+"",17, 1);
						
					}
				} 
				catch (Exception ex) 
				{
					vodPrice = EPGUtil.swapHtmlStr(vodPrice,17, 1);
				}

			}	
			/*if(!"0.0".equals(prodPrice))
			{
				prodPrice = vodPrice;
				
				
				
				if(prodPrice != "" && prodPrice !=null)
				{
					double tempPrice = Double.parseDouble(prodPrice) / 100;
					prodPrice = "" +tempPrice;
				}
				
				
			}*/
			prodPrice = vodPrice;
			cdrPrice  = vodPrices +"元";
			
			
			
		}
		 
		String prodPriceTemp = cdrPrice; 
		if(cdrPrice !=null)    
        {
        	if(cdrPrice.indexOf("'") >= 0)
        	{
        		prodPriceTemp = cdrPrice.replaceAll("'","\\\\'");
        	}
            //由于价格中可能包含中文，需要对价格进行编码
        	prodPriceTemp = URLEncoder.encode(prodPriceTemp,"UTF-8");
		}
		else
		{
			prodPrice = "0";
			prodPriceTemp = "0";
		}
		// 获取 产品编码 服务编号 可订购产品有效期的开始时间 可订购产品有效期的结束时间
		String prodID = (String)productInfo.get("PROD_CODE");
		String serviceId = (String)productInfo.get("SERVICE_CODE");
		String prodBeginTime = (String)productInfo.get("productStartTime");
		String prodEndTime = (String)productInfo.get("productEndTime");
		String tempProdEndTime = null;
	
		if(i==0){
			prodID0=prodID;
		}

		if(prodCont == 0)
		{
			tempProdEndTime = serviceHelp.getServiceExpireTime(prodID,serviceId);
			if (tempProdEndTime == null || tempProdEndTime.length() == 0)
			{
				tempProdEndTime = "本次有效";
			}
			else
			{
				tempProdEndTime = tempProdEndTime.substring(0,4) + "-" + tempProdEndTime.substring(4,6) + "-" + tempProdEndTime.substring(6,8) ;
				//+ " " +  tempProdEndTime.substring(8,10) + ":" 
				//+tempProdEndTime.substring(10,12) + ":" + tempProdEndTime.substring(12,14);
			}
		}
		else
		{
			if(prodEndTime != null && prodEndTime.length() > 8)
			{
				tempProdEndTime = prodEndTime.substring(0,4) + "-" + prodEndTime.substring(4,6) + "-" 
				+ prodEndTime.substring(6,8);
			}
		}
		%>
				<!-- 完成数据的封装 -->
				orderinfo[<%=i%>] = '<%=prodName%>';
				orderinfo1[<%=i%>] = '<%=prodName1%>';
				priceArr[<%=i%>] = '<%=prodPrice%>';
				endTimeArray[<%=i%>] = '<%=tempProdEndTime%>';
		<%
	}
	String url1 = "";  
    String url = "au_SubscribeEnsureResult.jsp?" + "PRODUCTID=" +prodID0 + "&SELECTPRODCONT=" + EPGConstants.SUBSCRIPTION_CONTINUEABLE + "&" + request.getQueryString();
System.out.println("url:" + url);    
url1 = url ;
%>
</script>
<head>
	<meta name="SZMG_SubscribeEnsure" content="szmg_hd" />
    <meta name="page-view-size" content="1280*720" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>SZMG_SubscribeSelct</title>
    <style type="text/css">
		body{
			font-family: sans-serif;
			position:absolute;
			overflow:hidden;
			background-color:transparent;
			background:url('images/SubscribeEnsure_bg_2.png') no-repeat;
			left:0px;
			top:0px;
			width:1280px;
			height:720px;
		}
		.button
		{
			position:absolute;
			width:266px;
			height:77px;
		}
		#choices
		{
			position:absolute;
			top:446px;
			left:614px;
		}
		#infomation
		{
			font-family: sans-serif;
			position:absolute;
			top:150px;
			left:390px;
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
			width:600px;
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
	var returnUrl = '<%=returnUrl%>';
	
	document.onkeypress = eventHandler;
	var flag = 1;
	function init() {
		//alert("in init");
		document.getElementById("info_text_1").innerHTML = orderinfo1[0];
		document.getElementById("info_text_2").innerHTML = priceArr[0]+ "元";
		document.getElementById("info_text_3").innerHTML = endTimeArray[0];
		flag=1;
		displayBack();
		/*
		$("program_name").innerText = program_name;
		$("money_name").innerText = prodPrice + "元";
		$("validate_name").innerText = prodEndTime;
		$("introduce").innerText = prodDesc;
		setFocus("return");
		if(isCreditsPayable === false)return;
		$("credits_pay").style.display = "block";
		*/
	}
	function displayBack(){
		setWebkitTransform("choice_back", "SubscribeEnsure_back_on_2.png");
		setWebkitTransform("choice_buy", "SubscribeEnsure_buy_off_2.png");
	}
	function displayBuy(){
		setWebkitTransform("choice_back", "SubscribeEnsure_back_off_2.png");
		setWebkitTransform("choice_buy", "SubscribeEnsure_buy_on_2.png");
	}
	function setWebkitTransform(object, value) {
		document.getElementById(object).style.backgroundImage = "url(images/" + value + ")";
	}
	
	function doSelect() {
		switch (flag) {
		case 0:
			//var ppv = programInfo[1];
			//var temp = ppv[0].ppvUrl + "&isFromVis=" + isFromVis;
			//window.location = temp;
			break;
		case 1:
			//alert(returnUrl);
			window.location.href = returnUrl;
			break;
		case 2:
			window.location.href = "<%=url1%>";
			break;
		}
	}

	function keyRight() {
		switch (flag) {
		case 1:		//in back_on status.
			displayBuy();
			flag = 2;
			break;
		case 2:		//in buy_on status.
			displayBack();
			flag = 1;
			break;
		}
	}

	function keyLeft() {
		switch (flag) {
		case 1:		//in back_on status.
			displayBuy();
			flag = 2;
			break;
		case 2:		//in buy_on status.
			displayBack();
			flag = 1;
			break;
		}
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
	<div id="info_title" style="visibility:hidden;">购买确认：</div>
    <div class="name" id="info_name_1" style="top:80px;">套餐名：</div>
    <div class="name" id="info_name_2" style="top:125px;">资费：</div>
    <div class="name" id="info_name_3" style="top:170px;visibility:hidden;">有效期：</div>
    <div class="texts" id="info_text_1" style="top:80px;font-weight:bold;"></div>
    <div class="texts" id="info_text_2" style="top:125px;"></div>
    <div class="texts" id="info_text_3" style="top:170px;visibility:hidden;"></div>
</div>
<div id="choices" style="visibility:visible;">
	<div class="button" id="choice_buy" style="top:0px; left:0px; background:url('images/SubscribeEnsure_buy_off_2.png') no-repeat; "></div>
    <div class="button" id="choice_back" style="top:0px; left:306px; background:url('images/SubscribeEnsure_back_off_2.png') no-repeat; "></div>
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
