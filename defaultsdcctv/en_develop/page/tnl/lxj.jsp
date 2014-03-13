<%@ include file="datajsp/vod_FimlDetail_Data.jsp"%>
<script>
	var vodInfo = <%=jsonFilm%>;
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style>
	body{color:#FFFFFF;background:url(images/lxj_bg.png);}
	.nav{position:absolute; width:113px; height:50px; left:0px; top:0px;}
	.button{position:absolute; width:83px; height:36px;}
	.pagenum{position:absolute;width:85px;height:30px;left:417px;line-height:30px;line-height:30px;font-size:22px;}
	.poster_bg{position:absolute; width:290px; height:176px;}
	.poster_A{position:absolute; left:5px; top:5px; width:276px; height:160px;}
	.num{position:absolute; width:35px; height:35px; font-size:22px; line-height:35px; text-align:center;}
	.num_focus{position:absolute; width:45px; height:45px;}
</style>
</head>
<body onLoad="init();" onUnload="exitPage()" bgcolor="transparent"> 

<!--<div style="position:absolute; width:593px; height:375px; left:0px; top:0px;"></div>-->
<div style="position:absolute; width:593px; height:375px; left:0px; top:0px;">
    <img id="downImg_0" src="images/pagedown.png" width="73" height="26" style="left:174px; top:200px; position:absolute"/>
    <img id="upImg_0" src="images/pageup.png" width="73" height="26" style="left:253px; top:200px; position:absolute"/>
    
    <img id="downImg_1" src="images/lxj/down_hui.png" width="14" height="8" style="left:543px; top:312px; position:absolute"/>
    <img id="upImg_1" src="images/lxj/up_hui.png" width="14" height="8" style="left:543px; top:281px; position:absolute"/>
    <img src="images/back.png" width="73" height="26" style="left:332px; top:200px; position:absolute"/>

    
    <a id="but_focus_0" href="#" onClick="keyPageDown()" style="left:169px; top:195px;" class="button"><img src="images/dot.gif" width="83" height="36"/></a>
    <a id="but_focus_1" href="#" onClick="keyPageUp()" style="left:248px; top:195px;" class="button"><img src="images/dot.gif" width="83" height="36"/></a>
    
    <a id="but_focus_2" href="#" onClick="keyBack()" style="left:327px; top:195px;" class="button"><img src="images/dot.gif" width="83" height="36"/></a>
    
    <div id="vodName" style="position:absolute; width:571px; height:34px; left:9px; top:21px; font-size:26px; text-align:center; line-height:34px; overflow:hidden;"></div>
    <div style="position:absolute; width:80px; height:25px; top:83px; left:42px; font-size:20px;">简&nbsp;&nbsp;&nbsp;&nbsp;介：</div>
    <div id="introduce" style="position:absolute; width:508px; height:78px; top:111px; left:42px; line-height:27px; font-size:20px;overflow:hidden;"></div>

    <div style="position:absolute; width:476px; height:105px; top:248px; left:51px;">
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
    <div style="position:absolute; width:496px; height:125px; top:238px; left:41px;">
        <a href="#" id="num_focus_0" style=" left:5px; top:5px;" onClick="playVod(0);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_1" style=" left:54px; top:5px;" onClick="playVod(1);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_2" style=" left:103px; top:5px;" onClick="playVod(2);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_3" style=" left:152px; top:5px;" onClick="playVod(3);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_4" style=" left:201px; top:5px;" onClick="playVod(4);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_5" style=" left:250px; top:5px;" onClick="playVod(5);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_6" style=" left:299px; top:5px;" onClick="playVod(6);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_7" style=" left:348px; top:5px;" onClick="playVod(7);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_8" style=" left:397px; top:5px;" onClick="playVod(8);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_9" style=" left:446px; top:5px;" onClick="playVod(9);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        
        <a href="#" id="num_focus_10" style=" left:5px; top:42px;" onClick="playVod(10);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_11" style=" left:54px; top:42px;" onClick="playVod(11);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_12" style=" left:103px; top:42px;" onClick="playVod(12);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_13" style=" left:152px; top:42px;" onClick="playVod(13);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_14" style=" left:201px; top:42px;" onClick="playVod(14);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_15" style=" left:250px; top:42px;" onClick="playVod(15);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_16" style=" left:299px; top:42px;" onClick="playVod(16);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_17" style=" left:348px; top:42px;" onClick="playVod(17);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_18" style=" left:397px; top:42px;" onClick="playVod(18);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_19" style=" left:446px; top:42px;" onClick="playVod(19);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        
        <a href="#" id="num_focus_20" style=" left:5px; top:79px;" onClick="playVod(20);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_21" style=" left:54px; top:79px;" onClick="playVod(21);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_22" style=" left:103px; top:79px;" onClick="playVod(22);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_23" style=" left:152px; top:79px;" onClick="playVod(23);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_24" style=" left:201px; top:79px;" onClick="playVod(24);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_25" style=" left:250px; top:79px;" onClick="playVod(25);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_26" style=" left:299px; top:79px;" onClick="playVod(26);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_27" style=" left:348px; top:79px;" onClick="playVod(27);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_28" style=" left:397px; top:79px;" onClick="playVod(28);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
        <a href="#" id="num_focus_29" style=" left:446px; top:79px;" onClick="playVod(29);" class="num_focus"><img src="images/dot.gif" width="45" height="45"/></a>
    </div>
</div>


</body>
<script src="js/Util.js"></script>
<script>
var currPage = 0;
var pageSize = 30;
var totalPage = Math.ceil(vodInfo.subVodNumList.length / pageSize);
var area = vodInfo.subVodNumList.length == 0 ? 0 : 1;
var index = vodInfo.subVodNumList.length == 0 ? 2 : 0;
var url = window.location.href;
var vodId = Util.getURLParameter("vodId", url)==""?"-1":Util.getURLParameter("vodId", url);
function init()
{
	showVodDetail();
	this.focus();
	parent.$("lxj").style.display = "block";
	setFocus();
}
function showVodDetail()
{
	$("vodName").innerText = vodInfo.vodName;
	$("introduce").innerHTML= "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+vodInfo.introduce;
	showSitNum();
}
function showSitNum()
{
//	$("vodName").innerText = vodInfo.subVodNumList.length;
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
	if(vodInfo.subVodNumList.length>0){area = 1; index = 0;}
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
	parent.saveFocus();
	parent.window.location.href = "../play_controlVod.jsp?PROGID="+vodInfo.subVodIdList[index+pageSize*currPage]+"&FATHERSERIESID="+vodId+"&PLAYTYPE=1&BEGINTIME=0&PRODUCTID=0&SERVICEID=0&ONECEPRICE=0&CONTENTTYPE=10&backurl="+parent.backurl;
}
function keyBack()
{
	parent.focus();
	parent.$(parent.focusObj).focus();
	parent.$("lxj").src = "";
	parent.$("lxj").style.display = "none";
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
	showSitNum();
}
function keyPageDown()
{
//	mp.gotoEnd();
	if(currPage == totalPage-1)return;
	currPage++;
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