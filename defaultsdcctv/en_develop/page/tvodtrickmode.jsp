<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page language="java" import="java.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="com.huawei.iptvmw.epg.util.xml.DateUtilities" %>
<%@ include file="keyboard/keydefine.jsp" %>
<%@ include file="config/config_playControl.jsp" %>
<%
String strChannelNum = request.getParameter("CHANNELNUM");//预览标识；1:支持 0:不支持
String comeType = request.getParameter("COMEFROMFLAG");
String strChannelId = request.getParameter("CHANNELID");
String strControlFlag = request.getParameter("ControlFlag");
String strtrickMode= request.getParameter("trickMode");
%>
<html>
<script type="text/javascript">
    var strtrickMode="<%=strtrickMode%>";
	var isSeeking = 0;//快进快退的层是否显示 0：为显示 1：已经显示
	var speed = 1;//当前的速度
	var playStat = "play";//当前播放的状态
	var timePerCell = 1;//进度条一个单元格时长
	var mediaTime = 2000;//当前的媒体的总时长
	var currTime;//播放器当前时间点
	var shiftBeginTime;//时移开始点
	var time_check;//进度条定时检测
	var trickmodeDiv = "true";//层是显示 true:可见  false:隐藏
	var mp;	
	
	
	function init(){
		initMediaMg();
		mp=mediaMg.player;
		//mp.setNativeUIFlag(0); //0不使UI本地显示 		   1本地显示
        mp.setProgressBarUIFlag(0);
		mediaTime = mp.getMediaDuration(); 
		timePerCell =  mediaTime / 100;  
		shiftBeginTime =  mediaMg.convertTime(0).substring(0, 5);
		if(mediaMg.currControlFlag==1){
		   $("timeError").innerHTML = "此频道不支持快进";
		}
		else
		{
		   $("timeError").innerHTML = "";
		}
		if(strtrickMode=="rewind"){
		   fastRewind();
		}else{
		   fastForward();
		}
	}
	
	function pressKey_up(){
		if(!isShowQuitDiv) return;
	     upQuitDiv();
	}
	
	function pressKey_down(){
	  	if(!isShowQuitDiv) return;
	    downQuitDiv();
	}
	document.onkeypress = parent.keyevent;
	function keypress(keyval)
	{
		switch(keyval)
		{
			case <%=KEY_TRACK%>:  mediaMg.player.switchAudioChannel(); return 0;
			case <%=KEY_INFO%>:if(trickmodeDiv == "false" && !isShowQuitDiv) createTVodFilm();return 0;
		    case <%=KEY_UP%>:return pressKey_up();
		    case <%=KEY_DOWN%>:return pressKey_down();
		    case <%=KEY_PAGEDOWN%>:pageDown();return false;
		    case <%=KEY_PAGEUP%>:pageUp();return false;
			case <%=KEY_RIGHT%>:if((trickmodeDiv == "false") && (!isShowQuitDiv)) volumeUp();return false;		
		    case <%=KEY_LEFT%>:if((trickmodeDiv == "false") && (!isShowQuitDiv)) volumeDown();return false;
		 	case <%=KEY_VOL_UP%>: if((trickmodeDiv == "false") && (!isShowQuitDiv)) volumeUp();return false; 
			case <%=KEY_VOL_DOWN%>: if((trickmodeDiv == "false") && (!isShowQuitDiv)) volumeDown();return false;
			case <%=KEY_MUTE%>: if((trickmodeDiv == "false") && (!isShowQuitDiv)) setMuteFlag();return false;
			case <%=KEY_STOP%>:pressReturn();break;
			case <%=KEY_RETURN%>:pressReturn();break;
			case <%=KEY_GO_BEGINNING%>:break;	
			case <%=KEY_OK%>:pressOK();break;
			case <%=KEY_IPTV_EVENT%>:goUtility();break;
			case <%=KEY_SWITCH%>:break;//喜爱键	
			case <%=KEY_BLUE%>:mediaMg.player.leaveChannel();mediaMg.player.stop();parent.window.location.href="space_collect.jsp";return 0;
			case <%=KEY_PAUSE_PLAY%>:
			case <%=KEY_POS%>: pauseOrPlay();return false;
			case <%=KEY_FAST_FORWARD%>: fastForward();return false;
			case <%=KEY_FAST_REWIND%>:fastRewind();return false; 			
			case 277:
		    case 1109://点播
				mediaMg.player.stop();parent.window.location.href="vod.jsp?returnurl="; return false;break;
		    case 276:
		    case 1110://回放
				mediaMg.player.stop();parent.window.location.href="playback.jsp?returnurl=";return false;break;
			case 275:
			case 1108://直播
			    mediaMg.player.stop(); parent.window.location.href="live.jsp?returnurl=";return false;break;
		    case 1105://搜索
				mediaMg.player.stop();parent.window.location.href="search.jsp";return false;
			case 281://收藏
				return false;
			default:
				break;
		}
		return true;
	}
	
	function pressOK(){
	  	if(isShowQuitDiv)
		{
		   pressquitOk();
		}
	}
	
	function pauseOrPlay() {
	   if(finishedDivIsShow) return;
	   if(playStat=="play"){
		   if(trickmodeDiv == "true"){
				hideTrickModeDiv();
		   }else{
				window.location.href="tvodpause.jsp?isShow=1&ControlFlag=<%=strControlFlag%>&CHANNELNUM=0&CHANNELID=<%=strChannelId%>&COMEFROMFLAG=<%=comeType%>";
		   }
	   }else{
		 if(trickmodeDiv == "true"){
		   hideTrickModeDiv();
		 }
	     resume();
	   }
	}

    //下页
    function pageDown(){
		if(finishedDivIsShow) return;
		finishedDivIsShow=true;
		mediaMg.gotoEnd();
		if(trickmodeDiv == "true")
		{
		  hideTrickModeDiv();
		}
	}
	
	//上页
    function pageUp(){
		if(finishedDivIsShow) return;
		finishedDivIsShow=false;
		mediaMg.gotoStart();
		if(trickmodeDiv == "true")
		{
		  hideTrickModeDiv();
		}
	}
    //快进
	function fastForward()
    {    
	    if(finishedDivIsShow) return;
		if(trickmodeDiv == "false"){showTrickModeDiv();}
		if(mediaMg.currControlFlag==1){
			$("speenvalue").innerText="";
		 	$("timeError").innerText = "此频道不支持快进";	
			resume();
			clearTimeout(errTimeoutId);
            errTimeoutId = setTimeout('hideTrickModeDiv()', 5000);
			return;
		}
		if(speed >= 32 && playStat == "fastforward"){       
			displaySeekTable();
			resume();
			$("speenvalue").innerText = "PLAY";	
			clearTimeout(errTimeoutId);
            errTimeoutId = setTimeout('hideTrickModeDiv()', 5000);
			return 0;
		} else{
			if(playStat == "play") clearTimeout(errTimeoutId);
			if (playStat == "fastrewind") speed = 1;
			speed = speed * 2;
			playStat = "fastforward";
			mp.fastForward(speed);
			displaySeekTable();
			$("speenvalue").innerText = "快进 "+"X " + speed;				
		}          
    }

	//快退
	function fastRewind()
    {  
	    if(finishedDivIsShow) return;
		if(trickmodeDiv == "false"){showTrickModeDiv();}
		
		if(speed >= 32 && playStat == "fastrewind"){       
			displaySeekTable();
			resume();
			$("speenvalue").innerText = "PLAY";	
			clearTimeout(errTimeoutId);
            errTimeoutId = setTimeout('hideTrickModeDiv()', 5000);
			return 0;
		} else{
			if(playStat == "play") clearTimeout(errTimeoutId);
			if (playStat == "fastforward") speed = 1;
			speed = speed * 2;
			playStat = "fastrewind";
			mp.fastRewind(-speed);
			displaySeekTable();
			$("speenvalue").innerText = "快退 "+"X " + speed;	
		}          
    }
    
    
    //绘制快进快退的图层
    function displaySeekTable()
    {        
        if(isSeeking == 0)
        {
            isSeeking = 1;
            currTime = mp.getCurrentPlayTime();		     
            processSeek(currTime);  
            var formatcurrTime = mediaMg.convertTime(mediaTime);        
            $("fullTime").innerText = formatcurrTime;
            $("beginTime").innerText = shiftBeginTime;  
		}
		checkSeeking();//调用方法检测进度条
	}
	
	//进度条的检测
	function checkSeeking()
    {
		time_check = setTimeout("checkSeeking();",1000);		
		currTime = mp.getCurrentPlayTime();
		processSeek(currTime);	
    }
	function processSeek(_currTime)
    {
        if(_currTime < 0) _currTime = 0;
        var currPlayTime = _currTime;   
        var currCellCount = Math.floor(_currTime / timePerCell); 
		
        if(playStat=="fastforward" && (currCellCount > 98)){
			currCellCount = 100;
        }else if(currCellCount < 0){
            currCellCount = 0;
        }
		var processCurTime = mediaMg.convertTime(currPlayTime); 
		$("currTimeShow").innerText = processCurTime;
        $("td_1").style.width = currCellCount * 3.6;
        $("td_3").style.left = 152+currCellCount * 3.4;	
		if(currCellCount==0 &&  playStat=="fastrewind" ){
			clearTimeout(time_check);
			speed = 1;
            playStat = "play";
			mediaMg.player.gotoStart();
			hideTrickModeDiv();
		}else if(currCellCount ==100){
			clearTimeout(time_check);
			speed = 1;
            playStat = "play";
			mediaMg.player.gotoEnd();
			hideTrickModeDiv();
		}
    }
  
	//恢复正常播放状态
	function resume()
    {
        speed = 1;
        playStat = "play";
        mp.resume();
    }
    
   
  
	//点击返回的操作
	function pressReturn()
	{
	   if(trickmodeDiv == "true"){
		   hideTrickModeDiv();
		   mediaMg.resume();
	   }else{
		    if(isShowQuitDiv){
		      hideQuitDiv();
        	}
			else
			{
		      showQuitDiv();
	        }
	   }
	}

	//隐藏快进快退
	function hideTrickModeDiv()
	{
		//$("timeError").innerText = "";	
		$("speenvalue").innerText="";
	    $("trickmode").style.display = "none";
		trickmodeDiv = "false";
	}
	
	//显示快进快退
	function showTrickModeDiv()
	{
	    $("trickmode").style.display = "block";
		trickmodeDiv = "true";
	}
</script>
<body bgcolor="transparent" onLoad="init();">
<div id="trickmode" style="position:absolute;width:640px;height:140px;left:0;top:390px;background-color:#090202;">
	<div style="font-size:18px;left:252px; position:absolute;top:16px;width:300px;color:#FFFFFF" id="timeError"></div>
	<div id="speenvalue" style="font-size:18px;position:absolute;width:88px;color:#FFFFFF;top:35px;left:10px;">快退X2</div>
	<div id="beginTime" style="position:absolute;width:65px;height:19px;left:100px;top:35px;font-size:22px;color:#FFFFFF"></div>
	<div id="fullTime" style="position:absolute;width:90px;height:19px;left:540px;top:35px;font-size:22px;color:#FFFFFF"></div>
	<div id="td_0" style="position:absolute;left:172px;width:360px;top:40px;height:9px;background-color:#ffffff"></div>
	<div id="td_1" style="position:absolute;left:172px;width:0px;top:40px;height:9px;background-color:#e1981e"></div>
	<div id="td_3" style="position:absolute;left:166px;width:22px;top:33px;height:24px;"><img id="statusImg" src="#"/></div> 
	<!--默认left 156px;-->
	<div id="currTimeShow" style="position:absolute;width:90px;height:19px;left:320px;top:55px;font-size:22px;color:#FFFFFF"></div>
</div>	

<jsp:include page="volumeControl.jsp"></jsp:include>
<jsp:include page="tVodFileinfo.jsp"></jsp:include>
</body>
</html>
