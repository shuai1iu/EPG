<%@ include file="config/DJ_code.jsp"%>
<%
    String recTypeId = DJDT_TYPE_ID;
    int column = 1;
    try{
        column = Integer.parseInt(request.getParameter("column"));
    }catch(Exception e){
        column = 1;
    }
    if(column == 1)
    {
        recTypeId = DJDT_TYPE_ID;
    }else if(column == 2)
    {
        recTypeId = XXZN_TYPE_ID;
    }else if(column == 3)
    {
        recTypeId = DYFC_TYPE_ID;
    }else if(column == 4)
    {
        recTypeId = HSYS_TYPE_ID;
    }else
    {
        recTypeId = DJDT_TYPE_ID;
    }
    System.out.println("column:"+column);
%>
<%@ include file="datajsp/vod_ListData.jsp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%

/*	TurnPage turnPage = new TurnPage(request);
	turnPage.addUrl();
	ArrayList turnList = turnPage.getTurnList();
	for(int i=0; i<turnList.size(); i++)
	 {
	 	System.out.println(i+"-------------turnList:"+turnList.get(i));
	 }
	String returnUrl = turnPage.go(-1);
	returnUrl = returnUrl.replace("page/tnl/","");*/
        String preFocus = null ==  request.getParameter("PREFOUCS")?"focus_0,0,0":request.getParameter("PREFOUCS");	
//	String preFocus = null == request.getParameter("PREFOUCS") ? (vodList.size() == 0 ? "nav_focus_1,0,0":"focus_0,0,0"): request.getParameter("PREFOUCS");
	System.out.println("where is my focus?"+preFocus);
	String[] focusArray = preFocus.split(",");
	String focusObj = focusArray[0];
	String currPage = focusArray[1];
	String currPlayVod = focusArray[2];
%>
<script>
	var vodList = <%=vodList%>;
	var focusObj = "<%=focusObj%>";
	var currPage = <%=currPage%>;
	var currPlayVod = <%=currPlayVod%>;
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="page-view-size" content="640*530">
<title>党建动态</title>
<style>
	.nav{position:absolute; width:113px; height:50px; left:0px; top:5px;}
	.nav_focus{position:absolute; width:113px; height:30px; left:0px; top:3px;}
	.poster_focus{position:absolute;width:108px;top:383px;height:109px;}
	.list_focus{position:absolute; width:335px; height:30px; left:0px; display:none;}
	.list{position:absolute; width:330px; height:38px; left:0px; display:none;}
	.name{position:absolute;width:320px;height:30px;left:15px;top:0px;color:#4f2300;font-size:20px;line-height:31px; overflow:hidden;}
	.button{position:absolute; width:76px; height:30px;}
	.pagenum{position:absolute;width:55px;height:25px;left:270px;line-height:30px;line-height:30px;font-size:22px;}
	.input{position:absolute; width:52px; height:28px; left:383px; text-align:center; font-size:20px; line-height:28px;}
</style>
</head>
<body onLoad="init()" onUnload="exitPage()" bgcolor="transparent">

<div style="position:absolute; width:635px; height:45px; left:1px; top:95px;">
    <a id="nav_focus_0" href="#" class="nav_focus" style="left:0px;" onClick="gotoPage(0)">
    <img src="images/dot.gif" width="113" height="45"/></a>
    <a id="nav_focus_1" href="#" class="nav_focus" style="left:113px;" onClick="gotoPage(1)">
    <img src="images/dot.gif" width="129" height="45"/></a>
    <a id="nav_focus_2" href="#" class="nav_focus" style="left:244px;" onClick="gotoPage(2)">
    <img src="images/dot.gif" width="129" height="45"/></a>
    <a id="nav_focus_3" href="#" class="nav_focus" style="left:373px;" onClick="gotoPage(3)">
    <img src="images/dot.gif" width="129" height="45"/></a>
    <a id="nav_focus_4" href="#" class="nav_focus" style="left:505px;" onClick="gotoPage(4)">
    <img src="images/dot.gif" width="129" height="45"/></a>
</div>

<img id="downImg_0" src="images/pagedown.jpg" width="73" height="26" style="left:27px; top:155px; position:absolute"/>
<img id="upImg_0" src="images/pageup.jpg" width="73" height="26" style="left:106px; top:155px; position:absolute"/>
<img id="downImg_1" src="images/pagedown.jpg" width="73" height="26" style="left:27px; top:485px; position:absolute"/>
<img id="upImg_1" src="images/pageup.jpg" width="73" height="26" style="left:106px; top:485px; position:absolute"/>
<img src="images/back.png" width="73" height="26" style="left:185px; top:155px; position:absolute"/>
<img src="images/back.png" width="73" height="26" style="left:185px; top:485px; position:absolute"/>

<a id="pageDown_focus_0" href="#" onClick="keyPageDown()" style="left:25px; top:153px;" class="button"><img src="images/dot.gif" width="76" height="30"/></a>
<a id="pageUp_focus_0" href="#" onClick="keyPageUp()" style="left:104px; top:153px;" class="button"><img src="images/dot.gif" width="76" height="30"/></a>
<a href="#" onClick="keyBack()" style="left:183px; top:153px;" class="button"><img src="images/dot.gif" width="76" height="30"/></a>

<a id="pageDown_focus_1" href="#" onClick="keyPageDown()" style="left:25px; top:483px;" class="button"><img src="images/dot.gif" width="76" height="30"/></a>
<a id="pageUp_focus_1" href="#" onClick="keyPageUp()" style="left:104px; top:483px;" class="button"><img src="images/dot.gif" width="76" height="30"/></a>
<a href="#" onClick="keyBack()" style="left:183px; top:483px;" class="button"><img src="images/dot.gif" width="76" height="30"/></a>

<div style="position:absolute; width:249px; height:65px; left:368px; top:400px;"></div>
<div id="currVodName" style="position:absolute; width:240px; height:60px; top:405px; left:370px; z-index:-1;line-height:30px; color:#ffebcd; font-size:23px; overflow:hidden;"></div>

<a id="input_focus0" href="#" class="input" style="top:150px;" onFocus="changeInputObj('input0')" onKeyPress="keyInput()"><img src="images/dot.gif" width="52" height="28"/></a>
<a id="input_focus1" href="#" class="input"  style="top:485px;"onFocus="changeInputObj('input1')" onKeyPress="keyInput()"><img src="images/dot.gif" width="52" height="28"/></a>

<div id="input0" style="top:150px;" class="input"></div>
<div id="input1" style="top:485px;" class="input"></div>

<div id="pageNum0" class="pagenum" style="top:151px;"></div>
<div id="pageNum1" class="pagenum" style="top:485px;"></div>

<div style="position:absolute; width:360px; height:273px; left:26px; top:197px;">
	<div id="list_0" class="list" style="top:0px;">
        <div id="name_0" class="name" ></div>
    </div>
    <div id="list_1" class="list" style="top:39px;">
        <div id="name_1" class="name" ></div>
    </div>
    <div id="list_2" class="list" style="top:78px;">
        <div id="name_2" class="name"></div>
    </div>
    <div id="list_3" class="list" style="top:117px;">
         <div id="name_3" class="name"></div>
    </div>
    <div id="list_4" class="list" style="top:156px;">
        <div id="name_4" class="name"></div>
    </div>
    <div id="list_5" class="list" style="top:194px;">
        <div id="name_5" class="name"></div>
    </div>
    <div id="list_6" class="list" style="top:231px;">
         <div id="name_6" class="name"></div>
    </div>
</div>
<a id="media_focus" href="#" onClick="playVod(currPlayVod%pageSize,true);" style="position:absolute;left:365px; top:190px;"><img src="images/dot.gif" width="245" height="207"/></a>
<!--</div>-->
<div style="position:absolute; width:340px; height:293px; left:24px; top:192px;">
  <a id="focus_0" href="#" class="list_focus" style="top:0px;" onClick="playVod(0)">
  <img src="images/dot.gif" width="340" height="38"/></a>
  <a id="focus_1" href="#" class="list_focus" style="top:40px;" onClick="playVod(1)">
  <img src="images/dot.gif" width="340" height="38"/></a>
  <a id="focus_2" href="#" class="list_focus" style="top:79px;" onClick="playVod(2)">
  <img src="images/dot.gif" width="340" height="38"/></a>
  <a id="focus_3" href="#" class="list_focus" style="top:119px;" onClick="playVod(3)">
  <img src="images/dot.gif" width="340" height="38"/></a>
  <a id="focus_4" href="#" class="list_focus" style="top:158px;" onClick="playVod(4)">
  <img src="images/dot.gif" width="340" height="38"/></a>
  <a id="focus_5" href="#" class="list_focus" style="top:195px;" onClick="playVod(5)">
  <img src="images/dot.gif" width="340" height="38"/></a>
  <a id="focus_6" href="#" class="list_focus" style="top:232px;" onClick="playVod(6)">
  <img src="images/dot.gif" width="340" height="38"/></a>
</div>

<iframe id="vodPlayUrlDataFrame" name="vodPlayUrlDataFrame" style="width:1px; height:1px; display:none;" src=""></iframe>
<iframe id="lxj" name="lxj" src="" style="position:absolute; width:593px; height:375px; left:25px; top:109px; display:none;" frameborder="0"></iframe>
<iframe id="saveFocusFrame" name="saveurlFrame" style="width:1px; height:1px; display:none;" src="" ></iframe>
</body>
<script src="js/Util.js"></script>
<script>
var mp = new MediaPlayer();
var pageSize = 7;
var totalPage = Math.ceil(vodList.length / pageSize);
var currInputObj = "input0";
var sitIndex = 0;
var loadFlag = 0;
var playCommonUrl = "";
var column= <%=column%>;
var backurl = "DJ_index.jsp";
var urlArray = ["DJ_index.jsp?null","DJ_list.jsp?column=1","DJ_list.jsp?column=2","DJ_list.jsp?column=3","DJ_list.jsp?column=4"];
if(column == 1 || column == 2 || column == 3 || column ==4)
{
   document.body.style.backgroundImage = "url(images/list_bg_"+column+".png)";
}else
{
   document.body.style.backgroundImage = "url(images/list_bg_1.png)";  
}
function init()
{
	initMediaPlay();
	showVodList();
	//$("defaultFoucs").style.display = "none";
	if(vodList.length > 0)initPlayVod(currPlayVod);
}
function gotoPage(index)
{
	window.location.href = urlArray[index];
}
function showVodList()
{
	for(var i=pageSize*currPage; i<(currPage+1)*pageSize; i++)
	{
		if(i<vodList.length)
		{
			if(i==0)$("media_focus").style.display = "block";
                        if(vodList[i].vodName.length <= 14)
			{
                            $("name_"+(i-pageSize*currPage)).innerText = vodList[i].vodName;
                        }else
                        {
                            $("name_"+(i-pageSize*currPage)).innerText = vodList[i].vodName.substring(0,14)+"...";
                        }
			$("focus_"+(i-pageSize*currPage)).style.display = "block";
			$("list_"+(i-pageSize*currPage)).style.display = "block";
		}
		else
		{
			if(i==0)$("media_focus").style.display = "none";
			$("focus_"+(i-pageSize*currPage)).style.display = "none";
			$("list_"+(i-pageSize*currPage)).style.display = "none";
		}
	}
	$(focusObj).focus();
	if(vodList.length == 0)
		$("pageNum1").innerText = $("pageNum0").innerText = "1/1";
	else
		$("pageNum1").innerText = $("pageNum0").innerText = (currPage+1)+"/"+totalPage;
	if(currPage == 0)
	{
		$("pageUp_focus_0").style.display = $("pageUp_focus_1").style.display = "none";
		$("upImg_0").src = $("upImg_1").src= "images/pageup_hui.png";
	}
	else
	{
		$("pageUp_focus_0").style.display = $("pageUp_focus_1").style.display = "block";
		$("upImg_0").src = $("upImg_1").src= "images/pageup.png";
	}
	if(currPage == totalPage -1 || vodList.length == 0)
	{
		$("pageDown_focus_0").style.display = $("pageDown_focus_1").style.display = "none";
		$("downImg_0").src = $("downImg_1").src= "images/pagedown_hui.png";
	}
	else
	{
		$("pageDown_focus_0").style.display = $("pageDown_focus_1").style.display = "block";
		$("downImg_0").src = $("downImg_1").src= "images/pagedown.png";
	}
}
function playVod(index,flag)
{
	if(currPlayVod != (index+pageSize*currPage))
	{
		previewVod(index+pageSize*currPage);
	}
	else
	{
		focusObj = flag ? "media_focus" : "focus_"+index;
		backurl = "dangjian/DJ_list.jsp?column="+column+"&PREFOUCS="+focusObj+","+currPage+","+currPlayVod;
		if(vodList[currPlayVod].isSitcom == 1)
		{
			$("lxj").src = "lxj.jsp?vodId="+ vodList[currPlayVod].vodId;
		}
		else 
		{
			window.location.href = "../play_controlVod.jsp?PROGID="+vodList[currPlayVod].vodId+"&backurl="+backurl+"&FATHERSERIESID=-1&PLAYTYPE=1&BEGINTIME=0&PRODUCTID=0&SERVICEID=0&ONECEPRICE=0&CONTENTTYPE=10";
		}
	}
}
function previewVod(dataIndex)
{
	$("list_"+(currPlayVod%pageSize)).style.background = "url(images/dot.gif)";
	currPlayVod = dataIndex;
	//        $("name_"+dataIndex).innerHTML = "<marquee behavior='scroll' height='42' width='90%' startposition='90%'>"+vodList[dataIndex].vodName+"</marquee>";
	if(vodList[dataIndex].vodName.length < 20)
	{
		$("currVodName").innerText = vodList[dataIndex].vodName;
	}else
	{
		$("currVodName").innerHTML = "<marquee behavior='scroll' height='42' width='90%' startposition='90%'>"+vodList[dataIndex].vodName+"</marquee>";
	}
	$("list_"+(dataIndex%pageSize)).style.background = "url(images/play_EC1308A.png) no-repeat right";
	mp.stop();
	sitIndex = 0;
	var playUrl = vodList[dataIndex].playUrl;
	startPlay(playUrl);
}
function initPlayVod(dataIndex)
{
	sitIndex = 0;
	var playUrl = vodList[dataIndex].playUrl;
	startPlay(playUrl);
        if(vodList[dataIndex].vodName.length < 20)
        {
	    $("currVodName").innerText = vodList[dataIndex].vodName;
        }else
        {
            $("currVodName").innerHTML = "<marquee behavior='scroll' height='42' width='90%' startposition='90%'>"+vodList[dataIndex].vodName+"</marquee>";
        }
	$("list_"+(dataIndex%pageSize)).style.background = "url(images/play_EC1308A.png) no-repeat right";

 }
function startPlay(playUrl)
{
	var mediaStr = '[{mediaUrl:"'+ playUrl +'",';
    mediaStr += 'mediaCode: "jsoncode1",';
    mediaStr += 'mediaType:2,';
    mediaStr += 'audioType:1,';
    mediaStr += 'videoType:1,';
    mediaStr += 'streamType:1,';
    mediaStr += 'drmType:1,';
    mediaStr += 'fingerPrint:0,';
    mediaStr += 'copyProtection:1,';
    mediaStr += 'allowTrickmode:1,';
    mediaStr += 'startTime:0,';
    mediaStr += 'endTime:20000,';
    mediaStr += 'entryID:"jsonentry1"}]';
	mp.setSingleMedia(mediaStr); //设置媒体播放器播放媒体内容
	mp.refreshVideoDisplay(); //调整视频显示，需要上面两函数配合 
	mp.playFromStart();
}
function initMediaPlay()
{
	var instanceId = mp.getNativePlayerInstanceID(); //读取本地的媒体播放实例的标识
	var playListFlag = 0; //Media Player 的播放模式。 0：单媒体的播放模式 (默认值)，1: 播放列表的播放模式
	var videoDisplayMode = 1; //MediaPlayer 对象对应的视频窗口的显示模式. 1: 全屏显示2: 按宽度显示，3: 按高度显示
	var height = 0;
	var width = 0;
	var left = 0;
	var top = 0;
	var muteFlag = 0; //0: 设置为有声 (默认值) 1: 设置为静音
	var subtitleFlag = 0; //字幕显示 
	var videoAlpha = 0; //视频的透明度
	var cycleFlag = 0;
	var randomFlag = 0;
	var autoDelFlag = 0;
	var useNativeUIFlag = 1;
	
	//初始话mediaplayer对象
	mp.initMediaPlayer(instanceId,playListFlag,videoDisplayMode,height,width,left,top,muteFlag,useNativeUIFlag,subtitleFlag,videoAlpha,cycleFlag,randomFlag,autoDelFlag);
	mp.setVideoDisplayArea(368,194,250,208);
	mp.setVideoDisplayMode(0);
	mp.setAllowTrickmodeFlag(0); //设置是否允许trick操作。 0:允许 1：不允许
	
	mp.setNativeUIFlag(0); //播放器是否显示缺省的Native UI，  0:允许 1：不允许
	mp.setAudioTrackUIFlag(1);//设置音轨的本地UI显示标志 0:不允许 1：允许
  
	mp.setMuteUIFlag(1); //设置静音的本地UI显示标志 0:不允许 1：允许
	mp.setAudioVolumeUIFlag(1);//设置音量调节本地UI的显示标志 0:不允许 1：允许
}
/*function startPlay(playUrl)
{
	mp.stop();
	initMediaPlay(playUrl);
	mp.playFromStart();
}*/

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
		case 768:keyIptvEvent();return 0;	//KEY_IPTV_EVENT   虚拟事件
		case 8:keyBack();return 0;//返回
		case 259:keyVolUp();return 0;//KEY_VOL_UP       音量加
		case 260:keyVolDown();return 0;//KEY_VOL_DOWN     音量减
		case 261:keyMute();return 0;//KEY_MUTE         静音
		default:return 1;
	}
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
function changeInputObj(obj)
{
	currInputObj = obj;
	$(currInputObj).innerText = "";
}
function deleteNum()
{
	$(currInputObj).innerText="";
}
function inputNum(num)
{
	var value = $(currInputObj).innerText;
	$(currInputObj).innerText = value.length >1 ? num : value+num;
}
function keyPageUp()
{
	if(currPage == 0)return;
	currPage--;
	focusObj = "focus_0";
	showVodList();
	previewVod(pageSize*currPage);
}
function keyPageDown()
{
//	mp.gotoEnd();
	if(currPage == totalPage-1)return;
	currPage++;
	focusObj = "focus_0";
	showVodList();
	previewVod(pageSize*currPage);
}
function jumpPage()
{
	var value = $(currInputObj).innerText;
	if(Number(value)<=totalPage && Number(value) > 0)
	{
		currPage = Number(value)-1;
		focusObj = "focus_0";
		showVodList();
		previewVod(pageSize*currPage);
	}
}
function finishedPlay()
{
	if(vodList[currPlayVod].isSitcom == 1)
	{
		sitIndex++;
		if(sitIndex >= vodList[currPlayVod].subVod.length)sitIndex = 0;
		var subVodId = vodList[currPlayVod].subVod[sitIndex];
		$("vodPlayUrlDataFrame").src= "datajsp/getCommonPlayUrl.jsp?PROGID="+subVodId+"&PLAYTYPE=1&CONTENTTYPE=10";
		playUrlData();
	}
	else
	{
		previewVod(currPlayVod);
	}
}
function playUrlData()
{
	if(loadFlag == 1)
	{
		startPlay(playCommonUrl);
		loadFlag = 0;
	}
	else
	{
		setTimeout(playUrlData,50);
	}
}
function keyIptvEvent()
{

	eval("eventJson="+Utility.getEvent());
	var typeStr = eventJson.type;
	switch(typeStr)
	{	
		case "EVENT_TVMS":
		case "EVENT_TVMS_ERROR":
			return 0;
		case "EVENT_MEDIA_END":
			finishedPlay();
			return 0;
		default:
		//	goUtility(eventJson);
			return 0;
	}
	return true;
}
function keyBack()
{
	window.location.href = "DJ_index.jsp"     //?PREFOUCS=nav_focus_1";
}
function exitPage()
{
	mp.stop();
}

//以下为音量操作代码
function keyMute()
{
	if(mp.getMuteFlag() == 0)
	{
		mp.setMuteFlag(1);
	}
	else
	{
		mp.setMuteFlag(0);
	}
}
function keyVolUp()
{
	mp.setMuteFlag(0);
	changeVolume(5);
}
function keyVolDown()
{
	mp.setMuteFlag(0);
	changeVolume(-5);
}
function changeVolume(num)
{
	var volume = mp.getVolume();
	volume = volume + num;
	volume = volume > 100 ? 100 : volume;
	volume = volume < 0 ? 0 : volume;
	mp.setVolume(volume);
}
</script>
</html>
