<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="keyDefine/keydefine.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>快进快退- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<!--<link type="text/css" rel="stylesheet" href="../../css/style.css" />-->
<style>
.progress-bar {
	left: 148px;
	position: absolute;
	top: 0;
}
.progress-bar .txt-time {
	position: absolute;
	color:#8f8b84;
	font-size:24px;
	top: 24px;
	width: 120px;
}
.progress-bar .barBg {
	background:url(../images/play/bar-bg.png) repeat;
	left: 116px;
	position: absolute;
	top: 6px;
	height: 60px;
    width: 750px;
}
.progress-bar .bar {
	background:url(../../images/play/bar.png) repeat;
	left: 0;
	position: absolute;
	top: 0;
	height: 60px;
}
.operate {
	left: 432px;
	position: absolute;
	top: 42px;
}
.operate .btn,
.operate .btn img {
	height: 90px;
    width: 90px;
}
.bottom {
	background:url(../../images/bottom-bg.png) repeat;
	left: 0;
	position: absolute;
	top: 566px;
	height: 154px;
    width: 1280px;
}

</style>

<% 
	String status = request.getParameter("status");
%>
<script type="text/javascript">
	document.onkeypress = keyEvent;
	//document.onkeydown = keyEvent;
	function keyEvent()
	{
		var val = event.which ? event.which : event.keyCode;
		return keypress(val);
	}
    
    function keypress(keyval){
    	//parent.keypress(keyval);
		switch(keyval){
			case <%=KEY_0%>:inputNum(0);break;
		    case <%=KEY_1%>:inputNum(1);break;
		    case <%=KEY_2%>:inputNum(2);break;
		    case <%=KEY_3%>:inputNum(3);break;
		    case <%=KEY_4%>:inputNum(4);break;
		    case <%=KEY_5%>:inputNum(5);break;
		    case <%=KEY_6%>:inputNum(6);break;
		    case <%=KEY_7%>:inputNum(7);break;
		    case <%=KEY_8%>:inputNum(8);break;
		    case <%=KEY_9%>:inputNum(9);break;
			case <%=KEY_CHANNEL_UP%>:addChannel(); break;//加直播
	     	case <%=KEY_CHANNEL_DOWN%>:decChannel();break;//减直播
			case <%=KEY_RIGHT%>:pressRight();break;//右
		    case <%=KEY_LEFT%>:pressLeft();break;//左
		    case <%=KEY_DOWN%>:arrowDown();return false;//上
		    case <%=KEY_UP%>:arrowUp();return false;//下
			case <%=KEY_PAGEDOWN%>:pageDown();return false;break; 
		    case <%=KEY_PAGEUP%>:pageUp();return false;break;
			case <%=KEY_VOL_UP%>:volumeUp();return false; 
		    case <%=KEY_VOL_DOWN%>:volumeDown();return false;
		    case <%=KEY_MUTE%>:setMuteFlag();return false; //静音键
		    case <%=KEY_STOP%>:stopKey();break;
		    case <%=KEY_RETURN%>:pressReturn();break;//返回键
			case <%=KEY_OK%>:pressOK();return false;break;
		    case <%=KEY_IPTV_EVENT%>:goUtility();break;
			case <%=KEY_INFO_URL%>:shwoFilmInfo();break;//信息键
			case <%=KEY_POS%>:pauseOrPlay();return false;
			case <%=KEY_FAST_FORWARD%>:fastForward();return false;
	        case <%=KEY_FAST_REWIND%>:fastRewind();return false; 
			case <%=KEY_TRACK%>: changeAudio();  break;
			
		/*	
			
			case <%=KEY_UP%>:break;
			case <%=KEY_DOWN%>:	 break;
			case <%=KEY_LEFT%>: moveLeft();break;
			case <%=KEY_RIGHT%>: moveRight(); break;
			case <%=KEY_OK%>:ok(); break;
			case <%=KEY_RETURN%>:cancel(); break;
		    case <%=KEY_POS%>:
			case <%=KEY_PAUSE_PLAY%>:playOrPause();break;	
			case <%=KEY_FAST_FORWARD%>:fastForward();break;
			case <%=KEY_FAST_REWIND%>: //回退事件fastReward(); break; 
			case <%=KEY_PAGEUP%>:pageUp();break;	 
			case <%=KEY_PAGEDOWN%>:pageDown();break;	
			case <%=KEY_STOP%>:window.location.href="exit_sure.jsp"; break;
			case <%=KEY_IPTV_EVENT%>: parent.goUtility();break;
		}*/
		resetTimer();
		return true;
	}
</script>
<script>
	
	var mp = parent.mp;
	var timer;
	var playStatus = "play";
	var curFocus = 2;
	var speed = 1;
	var curPlayTime = 0;  //当前时间
	var totlePlayTime = parseInt(mp.getMediaDuration());  //总时长;
	
	window.onload = function(){
		window.focus();
		if(playStatus == "play")
			timer = setTimeout("goBack()",5000);
		refurbishTime();
	}
	
	function moveLeft(){
		if(curFocus!=0){
			clearFocus();
			curFocus --;
			showFocus();
		}
	}

	function moveRight(){
		if(curFocus!=4){
			clearFocus();
			curFocus ++;
			showFocus();
		}
	}
	
	function ok(){
		switch(curFocus){
			case 0:
			case 4:
			    
				break;
			case 1:
				fastReward();
				break;
			case 3:
				fastForward();
				break;
			case 2:
				pauseOrPlay();
				break;
		}
	}
	
	function pauseOrPlay(){
		speed = 1;
		if(playStatus != "play"){
			mp.resume();
			playStatus = "play";
			$("fastOrRewindStat").innerHTML = "";
		}else{
			mp.pause();
			playStatus = "pause";
			$("fastOrRewindStat").innerHTML = "暂停";
		}
	}
	
	function fastForward(){
		if(speed >= 32 || playStatus == "fastRewind"){
			mp.resume();
			$("fastOrRewindStat").innerHTML = "";
			playStatus = "play";
			speed = 1;
			return 0;
		}else{
			speed = speed * 2;
			playStatus = "fastForward";
			$("fastOrRewindStat").innerHTML = ">> x"+speed;
			mp.fastForward(speed);	
		}
	}
	
	function fastReward(){
		if(speed >= 32 || playStatus == "fastForward"){
			mp.resume();
			$("fastOrRewindStat").innerHTML = "";
			playStatus = "play";
			speed = 1;
			return 0;
		}else{
			speed = speed * 2;
			playStatus = "fastRewind";
			$("fastOrRewindStat").innerHTML = "<< x"+speed;
			mp.fastRewind(-speed);
		}
	}
	
	function cancel(){
		if(playStatus != "play"){
			mp.resume();
			$("fastOrRewindStat").innerHTML = "";
		}
		window.location.href = "blank.jsp";
	}
	
	function clearFocus(){
		var tempSrc = $("focus_"+curFocus).src;
		if(tempSrc.indexOf("_focus.png") != -1){
			tempSrc = tempSrc.substring(0,tempSrc.indexOf("_focus.png"));
			$("focus_"+curFocus).src = tempSrc+".png";
		}
	}
	
	function showFocus(){
		var tempSrc = $("focus_"+curFocus).src;
		if(tempSrc.indexOf("_focus.png") == -1){
			tempSrc = tempSrc.substring(0,tempSrc.indexOf(".png"));
			$("focus_"+curFocus).src = tempSrc+"_focus.png";
		}
	}
	
	function resetTimer(){
		if(timer!=undefined && timer!=null){
			clearTimeout(timer);	
		}
		if(pauseFlag==0){
			timer = setTimeout("goBack()",5000);
		}
	}
	
	function goBack(){
		if(pauseFlag == 1)
			mp.resume();
		window.location.href="blank.jsp";
	}
	
	function refurbishTime(){
		curPlayTime = parseInt(mp.getCurrentPlayTime());
		var width = curPlayTime/totlePlayTime;
		var width1 = (width*750-23)+"px";
		var width2 = (width*750)+"px";
		if(width<0)
			width = "0px";
		else
			width = width*100+"%"; 
		$("progressWidth").style.width = width2; 
		$("progressPointLeft").style.left = width1;
		var currentTimeStr = timeFormat(curPlayTime);
		var totalTimeStr = timeFormat(totlePlayTime);
		$("curPlayTime").innerHTML = currentTimeStr;
		$("totlePlayTime").innerHTML = totalTimeStr;
		setTimeout("refurbishTime()",1000);
	}
	
	function $(id) {
		return document.getElementById(id);
	}
	
	function timeFormat(time) {
      var hour = parseInt(time / 3600);
      time = parseInt(time % 3600);
      var minute = parseInt(time / 60);
      time = parseInt(time % 60);
      var second = parseInt(time);

      var timeStr = "";
      if (hour < 10)
          timeStr += "0";
      timeStr += hour + ":";
      if (minute < 10)
          timeStr += "0";
      timeStr += minute+":";
      if (second < 10)
          timeStr += "0";
      timeStr += second;
      return timeStr;
  }
</script>
</head>

<body bgcolor="transparent">

<!--bottom-->
<div class="bottom">
	<div class="progress-bar">
		<div class="txt txt-time" id="curPlayTime"></div>
		<div class="barBg">
			<div class="bar" style=" width:0px;" id="progressWidth"></div> <!--总宽度为750px: 75*N--> 
			<div class="btn" style=" left:-23px;position: absolute;" id="progressPointLeft"><img src="../../images/play/btn-point.png" /></div> <!--总宽度为750px: 75*N-23 --> 
		</div>
		<div class="txt txt-time" style=" color:#f2f2f2; left:883px;" id="totlePlayTime"></div>
        
	</div>
	<div class="txt txt-time" style="left:1100px;top:90px;position: absolute;color:#FFF;" id="fastOrRewindStat"></div>
	<div class="operate">
		<!--
			焦点为： 在原图名称上加_focus
		-->
		<div class="btn" style="position: absolute;"><img id="focus_0" src="../../images/play/btn-pre.png" alt="上个" /></div>
		<div class="btn" style="left:81px;position: absolute;"><img id="focus_1" src="../../images/play/btn-rewind.png" alt="快退" /></div>
		<div class="btn" style="left:162px;position: absolute;"><img id="focus_2" src="../../images/play/btn-pause_focus.png" alt="暂停"  /></div>
		<div class="btn" style="left:243px;position: absolute;"><img id="focus_3" src="../../images/play/btn-fast.png" alt="快进" /></div>
		<div class="btn" style="left:324px;position: absolute;"><img id="focus_4" src="../../images/play/btn-next.png" alt="下个" /></div>
	</div>
</div>
<!--bottom the end-->


</body>
</html>
