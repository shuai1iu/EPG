<%@ include file="datajsp/vod_FimlDetail_Data.jsp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%!
	public String getReturnUrl(TurnPage turnPage)
	{
		String returnUrl = turnPage.go(0);
		while(returnUrl.indexOf("au_Authorization.jsp") != -1)
		{
			turnPage.removeLast();
			turnPage.removeLast();
			returnUrl = turnPage.go(0);
		}
		returnUrl = returnUrl.replace("tnl/","");
		if(returnUrl.indexOf("?") == -1)
		{
			returnUrl = returnUrl.replace(".jsp",".jsp?");
		}	
		return returnUrl;
	}
%>
<%
	TurnPage turnPage = new TurnPage(request);
	String returnUrl = getReturnUrl(turnPage);
	String preFocus = null == request.getParameter("PREFOUCS") ? ((jsonFilm.get("subVodNumList") == null || ((ArrayList)jsonFilm.get("subVodNumList")).size() == 0) ? "0,2,0":"1,0,0"): request.getParameter("PREFOUCS");
	String[] focusArray = preFocus.split(",");
	String area = focusArray[0];
	String index = focusArray[1];
	String currPage = focusArray[2];
	
	String vodId = null == request.getParameter("vodId") ? "-1" : request.getParameter("vodId");
%>
<script>
	var vodInfo = <%=jsonFilm%>;
	var returnUrl = "<%=returnUrl%>";
	var currPage = <%=currPage%>;
	var vodId = <%=vodId%>;
	var area = <%=area%>;
	var index = <%=index%>;
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="page-view-size" content="640*530">
<title>怀旧经典</title>
<style>
	body{color:#000000;}
	div{ overflow:hidden;}
	.nav{position:absolute; width:113px; height:50px; left:0px; top:0px;}
	.button{position:absolute; width:76px; height:30px;}
	.pagenum{position:absolute;width:85px;height:30px;left:417px;line-height:30px;line-height:30px;font-size:22px;}
	.poster_bg{position:absolute; width:290px; height:176px;}
	.poster_A{position:absolute; left:5px; top:5px; width:276px; height:160px;}
	.num{position:absolute; width:35px; height:35px; font-size:22px; line-height:35px; text-align:center;}
	.num_focus{position:absolute; width:40px; height:38px;}
</style>
</head>
<body onLoad="init();" onUnload="exitPage()" background="images/lxj/lxj_bg_1.jpg">


 	<img id="downImg_0" src="images/pagedown.png" width="73" height="26" style="left:174px; top:292px; position:absolute"/>
    <img id="upImg_0" src="images/pageup.png" width="73" height="26" style="left:253px; top:292px; position:absolute"/>
    
    <img id="downImg_1" src="images/lxj/down_hui.png" width="14" height="8" style="left:570px; top:404px; position:absolute"/>
    <img id="upImg_1" src="images/lxj/up_hui.png" width="14" height="8" style="left:570px; top:373px; position:absolute"/>
     <img src="images/back.png" width="73" height="26" style="left:332px; top:292px; position:absolute"/>

    
    <a id="but_focus_0" href="#" onClick="keyPageDown()" style="left:172px; top:290px;" class="button"><img src="images/dot.gif" width="76" height="30"/></a>
    <a id="but_focus_1" href="#" onClick="keyPageUp()" style="left:251px; top:290px;" class="button"><img src="images/dot.gif" width="76" height="30"/></a>
    
    <a id="but_focus_2" href="#" onClick="keyBack()" style="left:330px; top:290px;" class="button"><img src="images/dot.gif" width="76" height="30"/></a>
    
<div id="vodName" style="position:absolute; width:571px; height:34px; left:26px; top:40px; font-size:26px; text-align:center; line-height:34px;"></div>
<div style="position:absolute; width:80px; height:25px; top:108px; left:72px; font-size:20px;">导&nbsp;&nbsp;&nbsp;&nbsp;演：</div>
<div style="position:absolute; width:80px; height:25px; top:138px; left:72px; font-size:20px;">主&nbsp;&nbsp;&nbsp;&nbsp;演：</div>
<div id="actor" style="position:absolute; width:422px; height:25px; top:108px; left:172px; font-size:20px;"></div>
<div id="director" style="position:absolute; width:422px; height:25px; top:138px; left:172px; font-size:20px;"></div>

<div style="position:absolute; width:80px; height:25px; top:168px; left:72px; font-size:20px;">简&nbsp;&nbsp;&nbsp;&nbsp;介：</div>
<div id="introduce" style="position:absolute; width:523px; height:78px; top:196px; left:72px; line-height:27px; font-size:20px;"></div>


<div style="position:absolute; width:476px; height:105px; top:335px; left:74px;">
	<div id="num0" style=" left:0px; top:0px;" class="num"></div>
        <div id="num1" style=" left:49px; top:0px;" class="num"></div>
        <div id="num2" style=" left:98px; top:0px;" class="num"></div>
        <div id="num3" style=" left:147px; top:0px;" class="num"></div>
        <div id="num4" style=" left:196px; top:0px;" class="num"></div>
        <div id="num5" style=" left:245px; top:0px;" class="num"></div>
        <div id="num6" style=" left:294px; top:0px;" class="num"></div>
        <div id="num7" style=" left:343px; top:0px;" class="num"></div>
        <div id="num8" style=" left:392px; top:0px;" class="num"></div>
        <div id="num9" style=" left:441px; top:0px;" class="num"></div>
        
        <div id="num10" style=" left:0px; top:37px;" class="num"></div>
        <div id="num11" style=" left:49px; top:37px;" class="num"></div>
        <div id="num12" style=" left:98px; top:37px;" class="num"></div>
        <div id="num13" style=" left:147px; top:37px;" class="num"></div>
        <div id="num14" style=" left:196px; top:37px;" class="num"></div>
        <div id="num15" style=" left:245px; top:37px;" class="num"></div>
        <div id="num16" style=" left:294px; top:37px;" class="num"></div>
        <div id="num17" style=" left:343px; top:37px;" class="num"></div>
        <div id="num18" style=" left:392px; top:37px;" class="num"></div>
        <div id="num19" style=" left:441px; top:37px;" class="num"></div>
        
        <div id="num20" style=" left:0px; top:74px;" class="num"></div>
        <div id="num21" style=" left:49px; top:74px;" class="num"></div>
        <div id="num22" style=" left:98px; top:74px;" class="num"></div>
        <div id="num23" style=" left:147px; top:74px;" class="num"></div>
        <div id="num24" style=" left:196px; top:74px;" class="num"></div>
        <div id="num25" style=" left:245px; top:74px;" class="num"></div>
        <div id="num26" style=" left:294px; top:74px;" class="num"></div>
        <div id="num27" style=" left:343px; top:74px;" class="num"></div>
        <div id="num28" style=" left:392px; top:74px;" class="num"></div>
        <div id="num29" style=" left:441px; top:74px;" class="num"></div>
</div>
<div style="position:absolute; width:496px; height:125px; top:328px; left:67px;">
		<a href="#" id="num_focus_0" style=" left:5px; top:5px;" onClick="playVod(0);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_1" style=" left:54px; top:5px;" onClick="playVod(1);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_2" style=" left:103px; top:5px;" onClick="playVod(2);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_3" style=" left:152px; top:5px;" onClick="playVod(3);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_4" style=" left:201px; top:5px;" onClick="playVod(4);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_5" style=" left:250px; top:5px;" onClick="playVod(5);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_6" style=" left:299px; top:5px;" onClick="playVod(6);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_7" style=" left:348px; top:5px;" onClick="playVod(7);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_8" style=" left:397px; top:5px;" onClick="playVod(8);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_9" style=" left:446px; top:5px;" onClick="playVod(9);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        
        <a href="#" id="num_focus_10" style=" left:5px; top:42px;" onClick="playVod(10);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_11" style=" left:54px; top:42px;" onClick="playVod(11);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_12" style=" left:103px; top:42px;" onClick="playVod(12);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_13" style=" left:152px; top:42px;" onClick="playVod(13);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_14" style=" left:201px; top:42px;" onClick="playVod(14);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_15" style=" left:250px; top:42px;" onClick="playVod(15);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_16" style=" left:299px; top:42px;" onClick="playVod(16);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_17" style=" left:348px; top:42px;" onClick="playVod(17);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_18" style=" left:397px; top:42px;" onClick="playVod(18);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_19" style=" left:446px; top:42px;" onClick="playVod(19);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        
        <a href="#" id="num_focus_20" style=" left:5px; top:77px;" onClick="playVod(20);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_21" style=" left:54px; top:77px;" onClick="playVod(21);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_22" style=" left:103px; top:77px;" onClick="playVod(22);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_23" style=" left:152px; top:77px;" onClick="playVod(23);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_24" style=" left:201px; top:77px;" onClick="playVod(24);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_25" style=" left:250px; top:77px;" onClick="playVod(25);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_26" style=" left:299px; top:77px;" onClick="playVod(26);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_27" style=" left:348px; top:77px;" onClick="playVod(27);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_28" style=" left:397px; top:77px;" onClick="playVod(28);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
        <a href="#" id="num_focus_29" style=" left:446px; top:77px;" onClick="playVod(29);" class="num_focus"><img src="images/dot.gif" width="40" height="38"/></a>
</div>
<iframe id="saveFocusFrame" name="saveurlFrame" style="width:1px; height:1px; display:none;" src="" ></iframe>
</body>
<script src="js/Util.js"></script>
<script>
var pageSize = 30;
var totalPage = Math.ceil(vodInfo.subVodNumList.length / pageSize)
function init()
{
	showVodDetail();
	setFocus();
}
function showVodDetail()
{
	$("vodName").innerText = vodInfo.vodName;
	$("introduce").innerHTML= "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+vodInfo.introduce;
	$("actor").innerHTML= vodInfo.actor;
	$("director").innerHTML= vodInfo.director;
	showSitNum();
}
function showSitNum()
{
	for(var i=pageSize*currPage; i<(currPage+1)*pageSize; i++)
	{
		if(i<vodInfo.subVodNumList.length)
		{
			$("num"+(i-pageSize*currPage)).innerText = Util.addZero(vodInfo.subVodNumList[i],2);
			$("num_focus_"+(i-pageSize*currPage)).style.display = "block";
		}
		else
		{
			$("num"+(i-pageSize*currPage)).innerText = "";
			$("num_focus_"+(i-pageSize*currPage)).style.display = "none";
		}
	}
	setFocus();
	if(currPage == 0)
	{
		$("but_focus_1").style.display = "none";
		$("upImg_0").src = "images/pageup_hui.png";
		$("upImg_1").src = "images/lxj/up_hui.png";
	}
	else
	{
		$("but_focus_1").style.display = "block";
		$("upImg_0").src = "images/pageup.png";
		$("upImg_1").src = "images/lxj/up.png";
	}
	if(currPage == totalPage -1 || vodInfo.subVodNumList.length == 0)
	{
		$("but_focus_0").style.display = "none";
		$("downImg_0").src = "images/pagedown_hui.png";
		$("downImg_1").src = "images/lxj/down_hui.png";
	}
	else
	{
		$("but_focus_0").style.display = "block";
		$("downImg_0").src = "images/pagedown.png";
		$("downImg_1").src = "images/lxj/down.png";
	}
}
function playVod(index)
{
//	saveFocus();
	var backurl = encodeURIComponent("tnl/TNL_lxj.jsp?vodId="+vodId+"&PREFOUCS="+area+","+index+","+currPage);
	window.location.href = "../play_controlVod.jsp?PROGID="+vodInfo.subVodIdList[index+pageSize*currPage]+"&FATHERSERIESID="+vodId+"&PLAYTYPE=1&BEGINTIME=0&PRODUCTID=0&SERVICEID=0&ONECEPRICE=0&CONTENTTYPE=10&returnurl="+backurl;
//	window.location.href = "../au_PlayFilm.jsp?PROGID="+vodInfo.subVodIdList[index+pageSize*currPage]+"&ISTVSERIESFLAG=1&FATHERSERIESID="+vodId+"&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&returnurl="+backurl;
}
/*function saveFocus()
{
	$("saveFocusFrame").src = "datajsp/saveCurrFocus.jsp?preFoucs="+area+","+index+","+currPage;
}*/
function keyBack()
{
//	parent.$("lxj").src = "";
//	parent.$(parent.currFocusObj).focus();
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
		case 38:keyUp();return 0;    //KEY_UP    向上
		case 40:keyDown();return 0;	//KEY_DOWN  向下
		case 37:keyLeft();return 0;	//KEY_LEFT  向左
		case 39:keyRight();return 0;	//KEY_RIGHT 向右
		case 33:keyPageUp();return 0;	//KEY_PAGEUP    上页
		case 34:keyPageDown();return 0;//KEY_PAGEDOWN  下页
		case 8:keyBack();return 0; //KEY_BACK  返回
		case 768:keyIptvEvent();return 0;	//KEY_IPTV_EVENT   虚拟事件
		default:return 1;
	}
}
function keyPageUp()
{
	if(currPage == 0)return;
	currPage--;
	area = 1;
	index = 0;
	showSitNum();
	
}
function keyPageDown()
{
//	mp.gotoEnd();
	if(currPage == totalPage-1)return;
	currPage++;
	area = 1;
	index = 0;
	showSitNum();
}
function keyUp()
{
	if(area == 1)
	{
		if(index < 10)
		{
			area = 0;
			index = 2;
		}
		else
		{
			index = index - 10;
		}
		setFocus();
	}
}
function keyDown()
{
	if(area == 0)
	{
		area = 1;
		index = 0;
		setFocus();
	}
	else if(area == 1)
	{
		if(index > 19 && currPage != (totalPage-1))
		{
			keyPageDown();
		}
		else
		{
			index = index + 10;
			if(index > (vodInfo.subVodNumList.length-1)%pageSize && currPage == (totalPage-1))index = (vodInfo.subVodNumList.length-1)%pageSize;
			setFocus();	
		}
	}
}
function keyLeft()
{
	if(index == 0)return;
	if(area == 0)
	{
		if(index == 2)
		{
			if(currPage != 0)index = 1;
			else if(currPage != totalPage -1)index = 0;
		}
		else if(index == 1)
		{
			if(currPage != totalPage -1)index = 0;
		}
	}
	else if(area == 1)
	{
		index--;
	}
	setFocus();
}
function keyRight()
{
	if(area == 0 && index == 2)return;
	else if(area == 1 && index >= (vodInfo.subVodNumList.length-1)%pageSize && currPage == (totalPage-1))return;
	if(area == 0)
	{
		if(index == 0)
		{
			if(currPage != 0)index = 1;
			else index = 2;
		}
		else
		{
			index++;
		}
	}
	else if(area == 1)
	{
		index++;
	}
	setFocus();
}
function setFocus()
{
	if(area == 0)
	{
		$("but_focus_"+index).focus();
	}
	else if(area == 1)
	{
		$("num_focus_"+index).focus();
	}
}
</script>
</html>