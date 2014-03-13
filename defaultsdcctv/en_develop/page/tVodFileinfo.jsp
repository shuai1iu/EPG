<div id="errorInfo" style="position:absolute; left:425px; top:48px; font-size:28px; color:#00ff00;"></div>
<div id="tvodFilmDiv"  style="position:absolute;top:399px;width:100%;background:url(../images/play/play-page-bg.png) repeat-x;height:131px;line-height:35px;left:0;display:none;">
    <div id="progName" style="left:28px;position:absolute;top:14px;color:#fff;"></div>
    <div id="progTimeBegin" style="font-size:14px;height:20px;line-height:20px;left:365px;position:absolute;top:3px;color:#fff;"></div>
    <div style="background:url(../images/play/progress-barbg2.png) no-repeat;height:35px;left:375px;position:absolute;top:14px;width:207px;"></div>
    <div id="bar_0" style="position:absolute;top:14px;left:375px;width:11px;height:35px;background:url(../images/play/progress-baron-l.png) no-repeat;"></div>
    <div id="bar_1" style="position:absolute;top:14px;background:url(../images/play/progress-baron.png) no-repeat;left:385px;width:0px;height:35px;"></div>
    <div  id="progTimeEnd"  style="font-size:14px;height:20px;line-height:20px;left:550px;position:absolute;top:3px;color:#fff;color:#fff;"></div>
    <div style="height:1px;line-height:1px;left:10px;position:absolute; top:52px;"><img src="../images/line.png" /></div>
    <div id="channelName" style="left:28px;position:absolute;top:55px;color:#fff;"></div>
    <div id="preTvodName" style="left:290px;position:absolute;top:55px;color:#fff;"></div>
    <div id="nextTvodName" style="left:290px;position:absolute;top:90px;color:#fff;"></div>
</div>

<div id="quitDiv" style="background: url(../images/play/pop-bg2.gif) no-repeat;font-size:22px;height:262px;left:135px;position:absolute;top:135px;width:380px;display:none;">
	<div style="left:115px;position:absolute;top:72px;width:155px;">
			<div id="quit_0"  style="height:35px;line-height:35px;position:absolute;top:0;text-align:center; width:155px;color:#fff;">继续观看</div>
		 </div>
		 <div style="left:115px;position:absolute;top:72px;width:155px;text-align:center;">
			<div id="quit_1" style="height:35px;line-height:35px;position:absolute;top:60px;text-align:center;left:0; width:155px;color:#fff;">结束观看
         </div>
	</div>
</div>

<div id="finishedBackground" style="background: url(../images/play/pop-bg2.gif) no-repeat;font-size:22px;height:262px;left:150px;position:absolute;top:135px;width:380px;display:none;">
    <div style="font-size:26px;left:10px;position:absolute;text-align:center;top:120px;width:360px;align:center;color:#fff;">3秒后自动播放下一节目</div>
</div>

<div id="OUTquitDiv" style="background: url(../images/play/pop-bg2.gif) no-repeat;font-size:22px;height:262px;left:150px;position:absolute;top:135px;width:380px;display:none;">
    <div style="font-size:26px;left:10px;position:absolute;text-align:center;top:120px;width:360px;align:center;color:#fff;">谢谢观看</div>
</div>
<script type="text/javascript" src="../js/mediaPlayerEx.js"></script>
<script type="text/javascript">
var isShowQuitDiv=false;
var tvodFilmIsShow=false;
var finishedDivIsShow=false;
var tvodFilmShowTimer;
var mediaMg;
var quitpos=0;

function downQuitDiv(){
	if(quitpos==0){
		 quitpos=1;
		 $("quit_0").style.background="url()";
		 $("quit_1").style.background="url(../images/btn_bg.png)";
		 
	}else{
		quitpos=0;
		$("quit_0").style.background="url(../images/btn_bg.png)";
		$("quit_1").style.background="url()";
	}
}

function pressquitOk(){
	if(quitpos==0){
		hideQuitDiv();
		mediaMg.resume();
	}else if(quitpos==1){
		mediaMg.player.stop();
		parent.goBack();
	}
}

function upQuitDiv(){
	if(quitpos==0){
		 quitpos=1;
		 $("quit_0").style.background="url()";
		 $("quit_1").style.background="url(../images/btn_bg.png)";
		 
	}else{
		quitpos=0;
		$("quit_0").style.background="url(../images/btn_bg.png)";
		$("quit_1").style.background="url()";
	}
}
function initMediaMg(){
	mediaMg=parent.mediaManage;
}

function sp_convertTime(_time)
{
	if(_time!=null && _time!=""){
		return _time.substring(0,2)+":"+_time.substring(2,4);
	}
	return "";
}


function createTVodFilm()
{
	
    $("preTvodName").innerHTML ="上一个节目："+sp_convertTime(parent.preProgBeginTime)+"&nbsp;"+parent.preProgName; //ztewebkit
    $("nextTvodName").innerHTML = "下一个节目："+sp_convertTime(parent.nextProgBeginTime)+"&nbsp;"+parent.nextProgName; //ztewebkit
	var paogTimes=parent.progTimeSpan.split("~");
	$("progTimeBegin").innerText =paogTimes[0];
	$("progTimeEnd").innerText = paogTimes[1];
	$("progName").innerText = "当前节目："+parent.progName;
    $("channelName").innerText = "当前频道："+parent.channelName;
	processTVodFilmSeek(mediaMg.player.getCurrentPlayTime())
	showTvodFilm();
}

//信息键OSD上时间进度控制
function processTVodFilmSeek(_currTime)
{
	//如果入参时间为空，则取当前时长
	var mediaTime = mediaMg.player.getMediaDuration();
	var timePerCell = mediaTime / 100;
	if(null == _currTime || _currTime.length == 0){ _currTime = mediaMg.player.getCurrentPlayTime();}
	if(_currTime < 0){ _currTime = 0;}
	if(_currTime>mediaTime){ _currTime=mediaTime;}
	var tempIndex = -1;
	tempIndex = (String(_currTime / timePerCell)).indexOf(".");
	if(tempIndex != -1){ 
	    currCellCount = (String(_currTime / timePerCell)).substring(0,tempIndex);
	}
	else{  
	    currCellCount = String(_currTime / timePerCell);
	}
	if (timePerCell == 0){
		 currCellCount  = 0;
    }
	if(currCellCount > 100){
		currCellCount = 100;
	}
	if(currCellCount < 0){
		currCellCount = 0;
	}
	if(currCellCount >= 100){ 
	   $("bar_1").style.width = 195; 
	}
	else if(currCellCount<=0){ 
	  $("bar_1").style.width = 0;
	}
	else{
	  $("bar_1").style.width = currCellCount * 1.95;
    }
}

function $(domid){
	return document.getElementById(domid);	
}

function showTvodFilm(){
	if(tvodFilmIsShow) return;
	tvodFilmIsShow=true;
	clearTimeout(tvodFilmShowTimer);
	$("tvodFilmDiv").style.display = "block";
	tvodFilmShowTimer = setTimeout('tvodFilmIsShow=false;$("tvodFilmDiv").style.display = "none";',5000);
}

function hiddenTvodFilm(){
	if(!tvodFilmIsShow) return;
   	tvodFilmIsShow=false;
	$("tvodFilmDiv").style.display = "none";
}

//事件响应
function goUtility()
{
	eval("eventJson = " + Utility.getEvent());
	var typeStr = eventJson.type;
	switch(typeStr)
	{  
		case "EVENT_MEDIA_ERROR":$("errorInfo").innerHTML=eventJson;clearError();break;
		case "EVENT_MEDIA_END":finishedDivIsShow=true;finishedPlay();break;
		default : break;
	}
	return true;
}


function clearError(){
    clearTimeout(errorTimeoutId);
    errorTimeoutId = setTimeout('$("errorInfo").innerHTML = "&nbsp;"', 3000);
}


function finishedPlay(){
	if(parent.nextProgId != "-1")
	{
	  $("finishedBackground").style.display = "block";
	  mediaMg.player.stop();
	  setTimeout(goNextProg,3000);
	}
	else 
	{
		$("OUTquitDiv").style.display = "block";
		mediaMg.player.stop();
	    setTimeout(antoQuit,3000);
	}
}


function goNextProg(){
    parent.NextProgyurl="au_PlayFilm.jsp?controlflag=" +parent.currControlFlag +"&PROGID=" + parent.nextProgId +"&PLAYTYPE="+parent.iPlayType  + "&CONTENTTYPE="+ parent.contentType +"&BUSINESSTYPE=5&PROGSTARTTIME=" + (parent.startDate+parent.nextProgBeginTime) +"&PROGENDTIME=" + (parent.startDate+parent.nextProgEndTime) + "&CHANNELID=" + parent.channelId+"&returnurl="+parent.goBackUrl;
	 parent.goNext(parent.NextProgyurl);	
}



function showQuitDiv(){
	mediaMg.player.pause();
	quitpos=0;
	$("quit_0").style.background="url(../images/btn_bg.png)";
	$("quit_1").style.background="url()";
    $("quitDiv").style.display="block";
	isShowQuitDiv=true;
}

function hideQuitDiv(){
    $("quitDiv").style.display="none";
	isShowQuitDiv=false;
}

function antoQuit()
{
	mediaMg.player.stop();
	parent.goBack();
}
</script>
