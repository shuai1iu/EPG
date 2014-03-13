<%@ include file="config/DJ_code.jsp"%>
<% String recTypeId = INDEX_TYPE_ID;%>
<%@ include file="datajsp/vod_ListData.jsp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%
/*
	TurnPage turnPage = new TurnPage(request);
	turnPage.addUrl();
	ArrayList turnList = turnPage.getTurnList();
	for(int i=0; i<turnList.size(); i++)
	 {
	 	System.out.println(i+"-------------turnList:"+turnList.get(i));
	 }
	String returnUrl = turnPage.go(-1);
	returnUrl = returnUrl.replace("page/tnl/","");
*/
        String returnUrl = null == request.getParameter("returnurl") ? "../education.jsp" : request.getParameter("returnurl");
	System.out.println("returnUrl===="+returnUrl);
	String preFocus = null == request.getParameter("PREFOUCS") ? (vodList.size() == 0 ? "nav_focus_1,0,0":"focus_0,0,0"): request.getParameter("PREFOUCS");
	String[] focusArray = preFocus.split(",");
	System.out.println("prefocus:"+preFocus+",1:"+focusArray[0]+",2:"+focusArray[1]+",3:"+focusArray[2]);
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
        body{ background:url(images/DJ_index.png) no-repeat;z-index:-10}
	.nav{position:absolute; width:113px; height:50px; left:0px; top:5px;}
	.nav_focus{position:absolute; width:113px; height:30px; left:0px; top:0px;}
	.poster_focus{position:absolute;width:108px;top:383px;height:109px;}
	.list_focus{position:absolute; width:255px; height:35px; left:-5px; display:none;}
	.item{position:absolute; width:255px; height:45px; left:0px; display:none;}
	.name{position:absolute;width:260px;height:35px;left:8px;top:10px;font-size:20px;line-height:31px; overflow:hidden;}

</style>
</head>
<body onLoad="init()" onUnload="exitPage()" bgcolor="transparent">

<div style="position:absolute; width:635px; height:45px; left:1px; top:98px;">
    <a id="nav_focus_0" href="#" class="nav_focus" style="left:0px;" onClick="gotoPage(0)">
    <img src="images/dot.gif" width="113" height="45"/></a>
    <a id="nav_focus_1" href="#" class="nav_focus" style="left:113px;" onClick="gotoPage(1)">
    <img src="images/dot.gif" width="129" height="45"/></a>
    <a id="nav_focus_2" href="#" class="nav_focus" style="left:246px;" onClick="gotoPage(2)">
    <img src="images/dot.gif" width="129" height="45"/></a>
    <a id="nav_focus_3" href="#" class="nav_focus" style="left:373px;" onClick="gotoPage(3)">
    <img src="images/dot.gif" width="129" height="45"/></a>
    <a id="nav_focus_4" href="#" class="nav_focus" style="left:505px;" onClick="gotoPage(4)">
    <img src="images/dot.gif" width="129" height="45"/></a>
</div>
<div style="position:absolute; width:290px; height:240px; left:15px; top:190px;z-index:2">
    <div id="play_0" style="position:absolute;left:260px;top:13px;display:none;"><img src="images/play.png" /></div>
    <div id="play_1" style="position:absolute;left:260px;top:63px;display:none;"><img src="images/play.png" /></div>
    <div id="play_2" style="position:absolute;left:260px;top:113px;display:none;"><img src="images/play.png" /></div>
    <div id="play_3" style="position:absolute;left:260px;top:163px;display:none;"><img src="images/play.png" /></div>
    <div id="play_4" style="position:absolute;left:260px;top:213px;display:none;"><img src="images/play.png" /></div>

    <div id="list_0" class="list" style="top:0px;">
        <div id="name_0" class="name" style="top:5px;"></div>
    </div>
    <div id="list_1" class="list" style="top:80px;">
        <div id="name_1" class="name" style="top:55px;"></div>
    </div>
    <div id="list_2" class="list" style="top:124px;">
        <div id="name_2" class="name" style="top:105px;"></div>
    </div>
    <div id="list_3" class="list" style="top:111px;">
         <div id="name_3" class="name" style="top:155px;"></div>
    </div>
    <div id="list_4" class="list" style="top:148px;">
        <div id="name_4" class="name" style="top:205px;"></div>
    </div>
  </div>
</div>
<a id="media_focus" href="#" onClick="playVod(currPlayVod%pageSize,true);" style="position:absolute;left:300px; top:186px;"><img src="images/dot.gif" width="320" height="245"/></a>
<!--</div>-->
<div style="position:absolute; width:275px; height:238px; left:20px; top:190px;">
  <a id="focus_0" href="#" class="list_focus" style="top:0px;" onClick="playVod(0)">
  <img src="images/dot.gif" width="283" height="40"/></a>
  <a id="focus_1" href="#" class="list_focus" style="top:50px;" onClick="playVod(1)">
  <img src="images/dot.gif" width="283" height="40"/></a>
  <a id="focus_2" href="#" class="list_focus" style="top:100px;" onClick="playVod(2)">
  <img src="images/dot.gif" width="283" height="40"/></a>
  <a id="focus_3" href="#" class="list_focus" style="top:150px;" onClick="playVod(3)">
  <img src="images/dot.gif" width="283" height="40"/></a>
  <a id="focus_4" href="#" class="list_focus" style="top:200px;" onClick="playVod(4)">
  <img src="images/dot.gif" width="283" height="40"/></a>

</div>

<iframe id="vodPlayUrlDataFrame" name="vodPlayUrlDataFrame" style="width:1px; height:1px; display:none;" src=""></iframe>
<iframe id="lxj" name="lxj" src="" style="position:absolute; width:593px; height:375px; left:25px; top:109px; display:none;" frameborder="0"></iframe>
<iframe id="saveFocusFrame" name="saveurlFrame" style="width:1px; height:1px; display:none;" src="" ></iframe>
</body>
<script src="js/Util.js"></script>
<script>
var mp = new MediaPlayer();
var pageSize = 5;
var totalPage = Math.ceil(vodList.length / pageSize);
var currInputObj = "input0";
var loadFlag = 0;
var playCommonUrl = "";
var backurl = "<%=returnUrl%>";
var urlArray = ["DJ_index.jsp?null","DJ_list.jsp?column=1","DJ_list.jsp?column=2","DJ_list.jsp?column=3","DJ_list.jsp?column=4"];
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
			if(vodList[i].vodName.length < 13)
                        {
			    $("name_"+(i-pageSize*currPage)).innerText = vodList[i].vodName;
                        }else
			{
                            $("name_"+(i-pageSize*currPage)).innerText = vodList[i].vodName.substring(0,12)+"...";
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
		backurl = "dangjian/DJ_index.jsp?PREFOUCS="+focusObj+","+currPage+","+currPlayVod;
		window.location.href = "../play_controlVod.jsp?PROGID="+vodList[currPlayVod].vodId+"&FATHERSERIESID=-1&PLAYTYPE=1&BEGINTIME=0&PRODUCTID=0&SERVICEID=0&ONECEPRICE=0&CONTENTTYPE=10&backurl="+backurl;
	}
}
function previewVod(dataIndex)
{
	$("list_"+(currPlayVod%pageSize)).style.background = "url(images/dot.gif)";
	currPlayVod = dataIndex;
	for(i = 0 ;i < 5 ;i++)
	{
		if(vodList[i].vodName.length < 11)
		{
			$("name_"+(i-pageSize*currPage)).innerHTML = vodList[i].vodName;
		}else
		{
			$("name_"+(i-pageSize*currPage)).innerHTML = vodList[i].vodName.substring(0,11)+"...";
		}
	}

	mp.stop();
	for(var j = 0;j < pageSize;j++)
	{
		$("play_"+ j).style.display = "none";
	}
	$("play_"+(dataIndex%pageSize)).style.display = "block";
        mp.stop();
        var playUrl = vodList[dataIndex].playUrl;
        startPlay(playUrl);
}

function initPlayVod(dataIndex)
{
	var playUrl = vodList[dataIndex].playUrl;
	startPlay(playUrl);
        if(vodList[i].vodName.length < 11)
        { 
             $("name_"+(i-pageSize*currPage)).innerHTML = vodList[i].vodName;
        }else
        {
                $("name_"+(i-pageSize*currPage)).innerHTML = vodList[i].vodName.substring(0,11)+"...";
        }         
        $("name_"+dataIndex).innerHTML = vodList[dataIndex].vodName;
        for(var j = 0;j < pageSize;j++)
        {
                $("play_"+j).style.display = "none";
        }
         $("play_"+(dataIndex%pageSize)).style.display = "block";

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
	mp.setVideoDisplayArea(300,186,320,245);
	mp.setVideoDisplayMode(0);
	mp.setAllowTrickmodeFlag(0); //设置是否允许trick操作。 0:允许 1：不允许
	
	mp.setNativeUIFlag(0); //播放器是否显示缺省的Native UI，  0:允许 1：不允许
	mp.setAudioTrackUIFlag(1);//设置音轨的本地UI显示标志 0:不允许 1：允许
  
	mp.setMuteUIFlag(1); //设置静音的本地UI显示标志 0:不允许 1：允许
	mp.setAudioVolumeUIFlag(1);//设置音量调节本地UI的显示标志 0:不允许 1：允许
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
		case 768:keyIptvEvent();return 0;	//KEY_IPTV_EVENT   虚拟事件
		case 8:keyBack();return 0;//返回
		case 259:keyVolUp();return 0;//KEY_VOL_UP       音量加
		case 260:keyVolDown();return 0;//KEY_VOL_DOWN     音量减
		case 261:keyMute();return 0;//KEY_MUTE         静音
		default:return 1;
	}
}
function finishedPlay()
{
	previewVod(currPlayVod);
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
	window.location.href = backurl;
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
//	mp.gotoEnd();
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
