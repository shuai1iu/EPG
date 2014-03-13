<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ include file="datajsp/type_ListData.jsp"%>
<%@ include file="config/TNL_config.jsp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%
	JSONArray JKYSTypeList = getTypeList(metaData,JKYS_TYPE_ID);
	
	TurnPage turnPage = new TurnPage(request);
	turnPage.addUrl();
	String returnUrl = turnPage.go(-1);
//	System.out.println("------------turnPage.go(0):"+turnPage.go(0));
	returnUrl = returnUrl.replace("page/tnl/","");
	String preFocus = null == request.getParameter("PREFOUCS") ? (JKYSTypeList.size() == 0 ? "nav_focus_4,0,0":"poster_focus_0,0,0"): request.getParameter("PREFOUCS");
	String[] focusArray = preFocus.split(",");
	String focusObj = focusArray[0];
%>
<script>
	var JKYSTypeList = <%=JKYSTypeList%>;
	var focusObj = "<%=focusObj%>";
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="page-view-size" content="640*530">
<title>健康饮食</title>
<style>
	.input{position:absolute; width:50px; height:30px; left:330px; text-align:center; font-size:20px; line-height:30px;}
	.nav{position:absolute; width:113px; height:50px; left:0px; top:3px;}
	.nav_focus{position:absolute; width:123px; height:56px;top:3px;}
	.button{position:absolute; width:73px; height:26px;}
	.pagenum{position:absolute;width:85px;height:30px;left:417px;line-height:30px;line-height:30px;font-size:22px;}
	.poster_bg{position:absolute; width:290px; height:176px; display:none;}
	.poster_A{position:absolute; left:0px; top:0px; width:290px; height:174px;}
	.poster{position:absolute; left:5px; top:5px; width:280px; height:164px;}
	.pagenum{position:absolute;width:196px;height:30px;left:417px;line-height:30px;font-size:22px;}
	.poster_name{position:absolute;height:25px; width:280px; top:145px; left:5px;background-color:#000000;color:#FFFFFF;text-align:center;font-size:20px;line-height:25px;
}
</style>
</head>
<body onLoad="init()" onUnload="exitPage()" background="images/jkys/jkys_bg.png">
<!--<img src="images/logo.png" width="84" height="41" style="position:absolute; left:12px; top:7px;"/>-->
<!--<div style="position:absolute; width:600px; height:50px; left:22px; top:50px;">
    <div id="nav_0" class="nav" style=""><img src="images/category/wz_0.png" width="69" height="28" style="position:absolute; left:20px; top:11px;"/></div>
    <div id="nav_1" class="nav" style="left:120px;"><img src="images/category/wz_1.png" width="102" height="29" style="position:absolute; left:6px; top:11px;"/></div>
    <div id="nav_2" class="nav" style="left:241px;"><img src="images/category/wz_2.png" width="101" height="29" style="position:absolute; left:6px; top:11px;"/></div>
    <div id="nav_3" class="nav" style="left:363px;"><img src="images/category/wz_3.png" width="102" height="30" style="position:absolute; left:6px; top:11px;"/></div>
    <div id="nav_4" class="nav" style="left:485px;"><img src="images/category/wz_4.png" width="101" height="30" style="position:absolute; left:6px; top:11px;"/></div>
</div>-->

<div style="position:absolute; width:620px; height:60px; left:9px; top:45px;">
    <a id="nav_focus_0" href="#" class="nav_focus" style="left:5px;" onClick="gotoPage(0)">
    <img src="images/dot.gif" width="122" height="56"/></a>
    <a id="nav_focus_1" href="#" class="nav_focus" style="left:127px;" onClick="gotoPage(1)">
    <img src="images/dot.gif" width="122" height="56"/></a>
    <a id="nav_focus_2" href="#" class="nav_focus" style="left:249px;" onClick="gotoPage(2)">
    <img src="images/dot.gif" width="122" height="56"/></a>
    <a id="nav_focus_3" href="#" class="nav_focus" style="left:371px;" onClick="gotoPage(3)">
    <img src="images/dot.gif" width="122" height="56"/></a>
    <a id="nav_focus_4" href="#" class="nav_focus" style="left:493px;" onClick="gotoPage(4)">
    <img src="images/dot.gif" width="122" height="56"/></a>
</div>


<img id="downImg_0" src="images/pagedown.png" width="73" height="26" style="left:27px; top:115px; position:absolute"/>
<img id="upImg_0" src="images/pageup.png" width="73" height="26" style="left:106px; top:115px; position:absolute"/>
<img src="images/back.png" width="73" height="26" style="left:185px; top:115px; position:absolute"/>

<a id="but_focus_0" href="#" onClick="keyPageDown()" style="left:22px; top:110px;" class="button"><img src="images/dot.gif" width="83" height="36"/></a>
<a id="but_focus_1" href="#" onClick="keyPageUp()" style="left:101px; top:110px;" class="button"><img src="images/dot.gif" width="83" height="36"/></a>
<a id="but_focus_2" href="#" onClick="keyBack()" style="left:180px; top:110px;" class="button"><img src="images/dot.gif" width="83" height="36"/></a>

<!--<div style="position:absolute; width:50px; height:30px; left:285px; top:114px; font-size:24px; line-height:30px;">跳至</div>
<div style="position:absolute; width:50px; height:30px; left:387px; top:114px; font-size:24px; line-height:30px;">页</div>-->

<a id="input_focus0" href="#" class="input" style="top:109px;" onFocus="changeInputObj('input0')" onKeyPress="keyInput()"><img src="images/dot.gif" width="60" height="38"/></a>
<div id="input0" style="top:114px;" class="input"></div>

<!--<a href="#" style="position:absolute; width:50px; height:30px; left:335px; top:114px;"><img src="images/input.png" width="50" height="28"/></a>-->
<div id="pageNum" class="pagenum" style="top:114px;"></div>


<div id="poster_bg_0" style="left:27px; top:150px;" class="poster_bg">
    <img id="poster_0" src="" width="280" height="164" class="poster"/>
    <a id="poster_focus_0" href="#" class="poster_A" onClick="showVodList(0)"><img src="images/dot.gif" width="290" height="174"/></a>
</div>
<div id="poster_bg_1" style="left:322px; top:150px;" class="poster_bg">
    <img id="poster_1" src="" width="280" height="164" class="poster"/>
    <a id="poster_focus_1" href="#" class="poster_A" onClick="showVodList(1)"><img src="images/dot.gif" width="290" height="174"/></a>
</div>
<div id="poster_bg_2" style="left:27px; top:329px;" class="poster_bg">
    <img id="poster_2" src="" width="280" height="164" class="poster"/>
    <a id="poster_focus_2" href="#" class="poster_A" onClick="showVodList(2)"><img src="images/dot.gif" width="290" height="174"/></a>
</div>
<div id="poster_bg_3" style="left:322px; top:329px;" class="poster_bg">
    <img id="poster_3" src="" width="280" height="164" class="poster"/>
    <a id="poster_focus_3" href="#" class="poster_A" onClick="showVodList(3)"><img src="images/dot.gif" width="290" height="174"/></a>
</div>

<iframe id="saveFocusFrame" name="saveurlFrame" style="width:1px; height:1px; display:none;" src="" ></iframe>

</body>
<script src="js/Util.js"></script>
<script>
var index = 0;
var currPage = 0;
var pageSize = 4;
var totalPage = Math.ceil(JKYSTypeList.length / pageSize);
var url = "";
var urlArray = ["TNL_Category.jsp?null","TNL_hjjd.jsp?null","TNL_xkck.jsp?null","TNL_syhm.jsp?null","TNL_jkys.jsp?null"];
function init()
{
	showJKYSPoster();
	$(focusObj).focus();
}
function gotoPage(index)
{
	window.location.href = urlArray[index];
}
function showJKYSPoster()
{
	for(var i=pageSize*currPage; i<(currPage+1)*pageSize; i++)
	{
		if(i<JKYSTypeList.length)
		{
			$("poster_"+(i-pageSize*currPage)).src = "../../"+JKYSTypeList[i].typeImg;
			$("poster_bg_"+(i-pageSize*currPage)).style.display = "block";
		}
		else
		{
			$("poster_bg_"+(i-pageSize*currPage)).style.display = "none";
		}
	}
	if(JKYSTypeList.length == 0)
		$("pageNum").innerText = "1/1 页";
	else
		$("pageNum").innerText = (currPage+1)+"/"+totalPage+" 页";
	if(currPage == 0)
	{
		$("but_focus_1").style.display = "none";
		$("upImg_0").src = "images/pageup_hui.png";
	}
	else
	{
		$("but_focus_1").style.display = "block";
		$("upImg_0").src = "images/pageup.png";
	}
	if(currPage == totalPage -1 || JKYSTypeList.length == 0)
	{
		$("but_focus_0").style.display = "none";
		$("downImg_0").src = "images/pagedown_hui.png";
	}
	else
	{
		$("but_focus_0").style.display = "block";
		$("downImg_0").src = "images/pagedown.png";
	}
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
		case 33:keyPageUp();return 0;	//KEY_PAGEUP    上页
		case 34:keyPageDown();return 0;//KEY_PAGEDOWN  下页
		case 8:keyBack();return 0;//返回
		default:return 1;
	}
}
function keyPageUp()
{
	if(currPage == 0)return;
	currPage--;
	showJKYSPoster();
}
function keyPageDown()
{
	if(currPage == totalPage-1)return;
	currPage++;
	showJKYSPoster();
}
function keyInput()
{
	var val = event.which ? event.which : event.keyCode;
	switch(val)
	{
		case 48:inputNum(0);return 0;	//KEY_0  数字键0
		case 49:inputNum(1);return 0;	//KEY_1  数字键1
		case 50:inputNum(2);return 0;	//KEY_2  数字键2
		case 51:inputNum(3);return 0;	//KEY_3  数字键3
		case 52:inputNum(4);return 0;	//KEY_4  数字键4
		case 53:inputNum(5);return 0;	//KEY_5  数字键5
		case 54:inputNum(6);return 0;	//KEY_6  数字键6
		case 55:inputNum(7);return 0;	//KEY_7  数字键7
		case 56:inputNum(8);return 0;	//KEY_8  数字键8
		case 57:inputNum(9);return 0;	//KEY_9  数字键9
		case 8:deleteNum();return 0;	//返回键
		case 13:jumpPage();return 0;    //ok键
		default:return 1;
	}
}
function deleteNum()
{
	$("input0").innerText="";
}
function inputNum(num)
{
	var value = $("input0").innerText;
	$("input0").innerText = value.length >1 ? num : value+num;
}
function jumpPage()
{
	var value = $("input0").innerText;
	if(Number(value)<=totalPage && Number(value) > 0)
	{
		currPage = Number(value)-1;
		showVodList();
	}
	else
	{
		$("currVodName").innerText = "输入有误";
	}
}
function keyBack()
{
	window.location.href = "TNL_Category.jsp?PREFOUCS=nav_focus_4";
}
function showVodList(index)
{
	focusObj = "poster_focus_"+index;
	saveFocus();
	var name = "健康饮食 >> "+ JKYSTypeList[index + pageSize*currPage].typeName;
	url = "TNL_vodList.jsp?typeId="+JKYSTypeList[index+pageSize*currPage].typeId+"&nameFlag=2";
	window.location.href = "saveCurrFocus.jsp?preFoucs="+focusObj+"&url="+url;
}
/*function saveFocus()
{
	$("saveFocusFrame").src = "datajsp/saveCurrFocus.jsp?preFoucs="+focusObj;
}*/
</script>
</html>