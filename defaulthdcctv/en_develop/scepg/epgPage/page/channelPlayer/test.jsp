<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="keyDefine/keydefine.jsp"%>

<html>
<head>
<meta name="page-view-size" content="1280*720" />
<script type="text/javascript">
document.onkeypress = keyEvent;
function keyEvent()
{
	var val = event.which ? event.which : event.keyCode;
	return keypress(val);
}

function keypress(keyval){
	switch(keyval){
			case <%=KEY_UP%>:		
				 
				 break;
			case <%=KEY_DOWN%>:	
				
				 break;
			case <%=KEY_LEFT%>:
				 moveLeft();
				 break;
			case <%=KEY_RIGHT%>:
				 moveRight();
				 break;
			case <%=KEY_OK%>:
				 playOrPause();
				 break;
			case <%=KEY_RETURN%>:
				 cancel();
				 break;
		    case <%=KEY_POS%>:
			case <%=KEY_PAUSE_PLAY%>:
				 playOrPause();
				 break;	
			case <%=KEY_FAST_FORWARD%>:
				 fastForward();
				 break;
			case <%=KEY_FAST_REWIND%>: //回退事件
				 fastReward();
				 break; 
			case <%=KEY_PAGEUP%>:
				 pageUp();
				 break;	 
			case <%=KEY_PAGEDOWN%>:
				 pageDown();
				 break;	
			case <%=KEY_STOP%>:
				 window.location.href="exit_sure.jsp";
				 break;
			case <%=KEY_IPTV_EVENT%>:
				 parent.goUtility();
				 break;
		}
		return true;
}
</script>
<script type="text/javascript">
var mp = parent.mp;
var speed=1;
var curPlayTime = 0;//当前时间
var playStatus = "play";//记录播放状态
var totalPlayTime = parseInt(mp.getMediaDuration());  //计算影片的总时间长;
var timer; 
window.onload=function()
{
	if(playStatus=="play")
	{
		timer=setTimeout("goToBack()",5000);
	}
	refurbishTime();
}


	function fastReward()
	{
		
		if(speed >= 32)
		{
			mp.resume();
			speed = 1;
			return 0;
		}else
		{
			speed = speed * 2;
			mp.fastForward(-speed);	
		}
		playStatus="reward";
		//回退到结束 该如何处理
	}
	
    function fastForward()
	{
		if(speed >= 32)
		{
			mp.resume();
			playStatus = "play";
			speed = 1;
			return 0;
		}else
		{
			speed = speed * 2;
			playStatus = "fastForward";
			mp.fastForward(speed);	
		}
	}
	
	
	
    function goBack()
	{
		mp.resume();
		window.location.href="blank.jsp";
	}

	function pauseOrPlay()
	{
		speed = 1;
		if(playStatus!= "play")
		{
			mp.resume();
			playStatus = "play";
		}else
		{
			mp.pause();
			playStatus = "pause";
		}
	}
	
	/*	function refurbishTime(){
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
	}*/

</script>
















