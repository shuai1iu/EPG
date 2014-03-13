<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%@ include file="datajsp/type_ListData.jsp"%>
<%@ include file="config/TNL_config.jsp"%>
<%@ include file="datajsp/getVasData.jsp"%>
<%!
	public String getReturnUrl(TurnPage turnPage)
	{
		String returnUrl = turnPage.go(0);
		while(returnUrl.indexOf("tnl/") != -1)
		{
			turnPage.removeLast();
			returnUrl = turnPage.go(0);
		}
		returnUrl = "../"+returnUrl;
		return returnUrl;
	}
%>
<%
	JSONArray YSZDTypeList = getTypeList(metaData,YSZD_TYPE_ID);
	JSONArray WDXYTypeList = getTypeList(metaData,WDXY_TYPE_ID);
	
	TurnPage turnPage = new TurnPage(request);
	String returnUrl = getReturnUrl(turnPage);
	turnPage.addUrl();
	String preFocus = null == request.getParameter("PREFOUCS") ? "nav_focus_0" : request.getParameter("PREFOUCS");
	String[] focusArray = preFocus.split(",");
	String focusObj = focusArray[0];
//	System.out.println("------------focusObj:"+focusObj);
%>
<script>
	var focusObj = "<%=focusObj%>";
	var YSZDTypeList = <%=YSZDTypeList%>;
	var WDXYTypeList = <%=WDXYTypeList%>;
	var returnUrl = "<%=returnUrl%>";
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="page-view-size" content="640*530">
<title>天年乐首页</title>
<style>
	body{ background:url(images/category/category_bg.jpg) no-repeat;}
	div{ overflow:hidden}
	.nav{position:absolute; width:113px; height:50px; left:0px; top:3px;}
	.nav_focus{position:absolute; width:118px; height:55px; left:0px; top:3px;}
	.poster_focus{position:absolute;width:108px;top:383px;height:109px;}
</style>
</head>
<body onLoad="init();" onUnload="exitPage()">
<!--<a href="#" id="defaultFoucs" style="position:absolute; left:0px; top:0px;"><img src="images/dot.gif" width="1" height="1"/></a>-->
<!--<img src="images/logo.png" width="84" height="41" style="position:absolute; left:12px; top:7px;"/>-->
<!--<img src="images/category/wz_5.png" width="87" height="23" style="position:absolute; left:45px; top:350px;"/>
<img src="images/category/wz_6.png" width="85" height="23" style="position:absolute; left:391px; top:351px;"/>-->

<!--<div style="position:absolute; width:600px; height:50px; left:22px; top:50px;">
    <div id="nav_0" class="nav" style=""><img src="images/category/wz_0.png" width="69" height="28" style="position:absolute; left:20px; top:11px;"/></div>
    <div id="nav_1" class="nav" style="left:120px;"><img src="images/category/wz_1.png" width="102" height="29" style="position:absolute; left:6px; top:11px;"/></div>
    <div id="nav_2" class="nav" style="left:241px;"><img src="images/category/wz_2.png" width="101" height="29" style="position:absolute; left:6px; top:11px;"/></div>
    <div id="nav_3" class="nav" style="left:363px;"><img src="images/category/wz_3.png" width="102" height="30" style="position:absolute; left:6px; top:11px;"/></div>
    <div id="nav_4" class="nav" style="left:485px;"><img src="images/category/wz_4.png" width="101" height="30" style="position:absolute; left:6px; top:11px;"/></div>
</div>-->

<div style="position:absolute; width:610px; height:60px; left:15px; top:45px;">
    <a id="nav_focus_0" href="#" class="nav_focus" style="left:2px;" onClick="gotoPage(0)">
    <img src="images/dot.gif" width="118" height="55"/></a>
    <a id="nav_focus_1" href="#" class="nav_focus" style="left:124px;" onClick="gotoPage(1)">
    <img src="images/dot.gif" width="118" height="55"/></a>
    <a id="nav_focus_2" href="#" class="nav_focus" style="left:246px;" onClick="gotoPage(2)">
    <img src="images/dot.gif" width="118" height="55"/></a>
    <a id="nav_focus_3" href="#" class="nav_focus" style="left:368px;" onClick="gotoPage(3)">
    <img src="images/dot.gif" width="118" height="55"/></a>
    <a id="nav_focus_4" href="#" class="nav_focus" style="left:490px;" onClick="gotoPage(4)">
    <img src="images/dot.gif" width="118" height="55"/></a>
</div>

<a id="poster_focus_0" href="#" onClick="playVod(0);" style="position:absolute; width:369px; height:214px; left:35px; top:114px;">
	<img id="poster_0" src="" width="371" height="216"/></a>
<a id="poster_focus_1" href="#" onClick="playVod(1);" style="position:absolute; width:179px; height:103px; left:423px; top:115px;">
	<img id="poster_1" src="" width="179" height="103"/></a>
<a id="poster_focus_2" href="#" onClick="playVod(2);" style="position:absolute; width:179px; height:103px; left:423px; top:225px;">
	<img id="poster_2" src="" width="179" height="103"/></a>
    
<a id="poster_focus0_0" href="#" style="left:37px;" onClick="showVodList(0,0)" class="poster_focus">
	<img id="poster0_0" width="108" height="109" src=""/></a>
<a id="poster_focus0_1" href="#" style="left:148px;" onClick="showVodList(0,1)" class="poster_focus">
	<img id="poster0_1" width="108" height="109" src=""/></a>
<a id="poster_focus0_2" href="#" style="left:259px;" onClick="showVodList(0,2)" class="poster_focus">
	<img id="poster0_2" width="108" height="109" src=""/></a>
<a id="poster_focus1_0" href="#" style="left:386px;" onClick="showVodList(1,0)" class="poster_focus">
	<img id="poster1_0" width="108" height="109" src=""/></a>
<a id="poster_focus1_1" href="#" style="left:495px;" onClick="showVodList(1,1)" class="poster_focus">
	<img id="poster1_1" width="108" height="109" src=""/></a>
    
<iframe id="saveFocusFrame" name="saveurlFrame" style="width:1px; height:1px;  display:none;" src="" ></iframe>
</body>
<script src="js/Util.js"></script>
<script>
	var isNeedSaveUrl = true;
	var url = "";
	var urlArray = ["TNL_Category.jsp?null","TNL_hjjd.jsp?null","TNL_xkck.jsp?null","TNL_syhm.jsp?null","TNL_jkys.jsp?null"];
	function init()
	{
		showPoster();
		showYSZDPoster();
		showWDXYPoster();
		$(focusObj).focus();
	}
	function gotoPage(index)
	{
		window.location.href = urlArray[index];
	}
	function showPoster()
	{
		for(var i=0; i<3;i++)
		{
			if(i<vasList.length)
				$("poster_"+i).src = "../"+vasList[i].imgUrl;
			else
				$("poster_focus_"+i).style.display = "none";
		}
	}
	function showYSZDPoster()
	{
		for(var i=0; i<3;i++)
		{
			if(i<YSZDTypeList.length)
				$("poster0_"+i).src = "../"+YSZDTypeList[i].typeImg;
			else
				$("poster_focus0_"+i).style.display = "none";
		}
	}
	function showWDXYPoster()
	{
		for(var i=0; i<2;i++)
		{
			if(i<WDXYTypeList.length)
				$("poster1_"+i).src = "../"+WDXYTypeList[i].typeImg;
			else
				$("poster_focus1_"+i).style.display = "none";
		}
	}
	function showVodList(index,pos)
	{
		focusObj = "poster_focus"+index+"_"+pos;
		var nameObj = [{typeName:"养生之道",dataObj:YSZDTypeList},{typeName:"舞动夕阳",dataObj:WDXYTypeList}];
//		var name = nameObj[index].typeName +" >> "+ nameObj[index].dataObj[pos].typeName;
		url = "TNL_vodList.jsp?typeId="+nameObj[index].dataObj[pos].typeId+"&nameFlag="+index;
		window.location.href = "saveCurrFocus.jsp?preFoucs="+focusObj+"&url="+url;
	}
	function playVod(index)
	{
		focusObj = "poster_focus_"+index;
		var backurl = encodeURIComponent("tnl/TNL_Category.jsp?PREFOUCS="+focusObj);
	//	var IdArray = ["1273005","1639215","1224734"];
		url = vasList[index].url+"&backurl="+backurl;
	//	url = "vod_Action.jsp?vodId="+IdArray[index]+"&backurl="+backurl;
		window.location.href = "saveCurrFocus.jsp?preFoucs="+focusObj+"&url="+url;
	}
	function keyBack()
	{
		window.location.href = returnUrl;
	}
	document.onkeypress = keyEvent;
	function keyEvent()
	{
		var val = event.which ? event.which : event.keyCode;
		return keypress(val);
	}
	function keypress(keycode)
	{
		switch(keycode)
		{
			case 8:keyBack();return 0;//返回
			default:return 1;
		}
	}
	/*function saveFocus()
	{
		saveFocusFrame.location.href = "datajsp/saveCurrFocus.jsp?preFoucs="+focusObj;
	}*/
</script>
</html>