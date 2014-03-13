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
		shiftBeginTime = getShiftBeginTime();
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
	document.onkeypress = parent.keyevent;
	function keypress(keyval)
	{
		switch(keyval)
		{
			case <%=KEY_TRACK%>: changeAudio();return 0;
			case <%=KEY_INFO%>:if(trickmodeDiv == "false") createFilmInfo();return 0;
			case <%=KEY_0%>:
		       if(trickmodeDiv == "false") inputNum(0);
			   break;
		    case <%=KEY_1%>:
			  if(trickmodeDiv == "false")  inputNum(1);
			   break;
		    case <%=KEY_2%>:
		       if(trickmodeDiv == "false")  inputNum(2);
			   break;
		    case <%=KEY_3%>:
			   if(trickmodeDiv == "false")  inputNum(3);
			   break;
			case <%=KEY_4%>:
			   if(trickmodeDiv == "false")  inputNum(4);
				break;
			case <%=KEY_5%>:
			    if(trickmodeDiv == "false")  inputNum(5);
				break;
			case <%=KEY_6%>:
				if(trickmodeDiv == "false")  inputNum(6);
				break;
			case <%=KEY_7%>:
			    if(trickmodeDiv == "false")  inputNum(7);
				break;
			case <%=KEY_8%>:
				if(trickmodeDiv == "false")  inputNum(8);
				break;
			case <%=KEY_9%>:
				 if(trickmodeDiv == "false") inputNum(9);
			    break;
			case <%=KEY_PAGEDOWN%>:pageDown();return false;
		    case <%=KEY_PAGEUP%>:pageUp();return false;
			case <%=KEY_RIGHT%>:if(trickmodeDiv == "false") volumeUp();return false;		
		    case <%=KEY_LEFT%>:if(trickmodeDiv == "false") volumeDown();return false;
		    case <%=KEY_DOWN%>:if(trickmodeDiv == "false") decChannel();return false;
		    case <%=KEY_UP%>:if(trickmodeDiv == "false") addChannel();return false;
			case <%=KEY_CHANNEL_UP%>: if(trickmodeDiv == "false") addChannel();break;	//加直播
			case <%=KEY_CHANNEL_DOWN%>: if(trickmodeDiv == "false") decChannel();break;//减直播
			case <%=KEY_VOL_UP%>: if(trickmodeDiv == "false") volumeUp();return false; 
			case <%=KEY_VOL_DOWN%>: if(trickmodeDiv == "false") volumeDown();return false;
			case <%=KEY_MUTE%>: if(trickmodeDiv == "false") setMuteFlag();return false;
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
	  	 if(playStat=="play"){
			 window.location.href="playChannelList.jsp?ishow=1&ControlFlag=" +mediaMg.currControlFlag + "&CHANNELNUM=" + mediaMg.currChannelNum+"&CHANNELID="+ mediaMg.currChannelId +"&COMEFROMFLAG=<%=comeType%>";
		 }
	}
	
	function pauseOrPlay() {
		
	   if(playStat=="play"){
		   if(trickmodeDiv == "true"){
				hideTrickModeDiv();
		   }else{
				window.location.href="pause.jsp?ControlFlag=" +mediaMg.currControlFlag + "&CHANNELNUM=" + mediaMg.currChannelNum+"&CHANNELID="+ mediaMg.currChannelId +"&COMEFROMFLAG=<%=comeType%>";
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
		mediaMg.gotoEnd();
		if(trickmodeDiv == "true")
		{
		  hideTrickModeDiv();
		}
	}
	
	//上页
    function pageUp(){
		mediaMg.gotoStart();
		if(trickmodeDiv == "true")
		{
		  hideTrickModeDiv();
		}
	}
    //快进
	function fastForward()
    {    
	    
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
            currTime = getCurrTime();        
            $("fullTime").innerText = currTime;
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
        _currTime = getRelativeTime(_currTime); // 得到到前播放相对时间，单位秒 
        var currCellCount = Math.floor(_currTime / timePerCell); 
		
        if(playStat=="fastforward" && (currCellCount > 98)){
			
			currCellCount = 100;
        }else if(currCellCount < 0){
            currCellCount = 0;
        }
		var processCurTime = getCurrPlayTime(currPlayTime); 
		$("currTimeShow").innerText = processCurTime;
        $("td_1").style.width = currCellCount * 3.6;
        $("td_3").style.left = 166+currCellCount * 3.4;	
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

    function getRelativeTime(currPlayTime)
    {   
    	currPlayTime = parseUtcTime(currPlayTime);		
    	var currTime = new Date(); 
    	var beginTime = new Date(currTime.getTime() - mediaTime * 1000);
    	var relativeTime = (currPlayTime.getTime() - beginTime.getTime())/1000;
    	return relativeTime;
    } 
    // 解析UTC时间为一日期对象
    function parseUtcTime(utcTime)
    {
    	var year = parseInt(utcTime.substr(0, 4));
    	var month = parseInt(utcTime.substr(4, 2));
    	var day = parseInt(utcTime.substr(6, 2));
    	var hour = parseInt(utcTime.substr(9, 2));
    	var min = parseInt(utcTime.substr(11, 2));
    	var sec = parseInt(utcTime.substr(13, 2)); 
    
    	// 处理parseInt("0X")等于零的问题
    	if (month == 0) month = parseInt(utcTime.substr(5,1));
    	if (day == 0) day = parseInt(utcTime.substr(7,1));
    	if (hour == 0) hour = parseInt(utcTime.substr(10,1));
    	if (min == 0) min = parseInt(utcTime.substr(12,1));
    	if (sec == 0) sec = parseInt(utcTime.substr(14,1));
        	 	
   	 	var d =  new Date(year, month -1, day, hour + 8, min, sec);  
		return d;   	 	
    }  
	//恢复正常播放状态
	function resume()
    {
        speed = 1;
        playStat = "play";
        mp.resume();
    }
    
    //得到当前时间  hour:min
	function getCurrTime()
    {	
    	var currTime = new Date();    	
    	var min = currTime.getMinutes();
    	var sec = currTime.getSeconds();
    	if (sec >= 30) currTime.setMinutes(min + 1);
    	var hour = currTime.getHours();
    	min = currTime.getMinutes();

    	if (hour < 10) hour = "0" + hour;
    	if (min < 10) min = "0" + min;    	
    	return hour + ":" + min;
    }
    function getCurrPlayTime(currPlayTime)
    {
    	currPlayTime = parseUtcTime(currPlayTime);	
    	var sec = currPlayTime.getSeconds();  
    	var hour = currPlayTime.getHours();
    	var min = currPlayTime.getMinutes();
        if (sec >= 30)
        {
           min = min + 1;
           if(min == 60){
              min = 59;
           }
        }
    	if (hour < 10) hour = "0" + hour;
    	if (min < 10) min = "0" + min;
    	return hour + ":" + min;    	
    } 
    //获得时移开始点  hour:min
    function getShiftBeginTime()
    {
    	var currTime = new Date();      
    	var beginTime = new Date(currTime.getTime() - mediaTime * 1000);
    	var min = beginTime.getMinutes();
    	var sec = beginTime.getSeconds();
    	if (sec >= 30) beginTime.setMinutes(min + 1);   	
    	var hour = beginTime.getHours();
    	min = beginTime.getMinutes();
    	if (hour < 10) hour = "0" + hour;
    	if (min < 10) min = "0" + min;   	
    	return hour + ":" + min;    	
    }

	//点击返回的操作
	function pressReturn()
	{
	   if(trickmodeDiv == "true"){
		   hideTrickModeDiv();
		   mediaMg.resume();
	   }else{
		   if(mediaMg.shiftStatus==1){
			   mediaMg.player.gotoEnd();
			   mediaMg.shiftStatus=0;
			   
		   }else{
			   parent.goBack();	
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
<jsp:include page="showChanInfo.jsp"></jsp:include>
</body>
</html>
