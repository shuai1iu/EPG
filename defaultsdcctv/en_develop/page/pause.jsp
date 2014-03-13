<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page language="java" import="java.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="com.huawei.iptvmw.epg.facade.metadata.CommonImpl" %>
<%@ page import="com.huawei.iptvmw.epg.util.xml.DateUtilities" %>
<%@ include file="keyboard/keydefine.jsp" %>
<%@ include file="config/config_playControl.jsp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%
String strChannelNum = request.getParameter("CHANNELNUM");//预览标识；1:支持 0:不支持
String comeType = request.getParameter("COMEFROMFLAG");
String strChannelId = request.getParameter("CHANNELID");
String strControlFlag = request.getParameter("ControlFlag");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<script type="text/javascript">
    var currChannelNum = <%=strChannelNum%>;//当前直播号
    var currChannelId=<%=strChannelId%>;//当前频道ID
    var currControlFlag=<%=strControlFlag%>; 
	var jumpPos=0;//焦点移动的位置
	var currentBarIndex=20;//进度条索引从1开始
	var barSpeedValue=0;
	var barTuodongValue=0;
	var isShowSeekDiv=true;//是否显示定位DIV
	var mediaTime;
	var currentMedia;
	var inputErrorcls;
    var errmessage="此频道不支持快进";
	//计算时间
	function focusWhichBar(time, count) {
	    var index = 0;
	    for (var i = 0; i <= count; i++) {
	         if (parseInt(mediaMg.timeList[i], 10) - parseInt(time, 10) > 0) {
	             index = i;
	             break;
	         } 
	    }
	    if (index == 0) return 0;
	    if ((parseInt(time, 10) - parseInt(mediaMg.timeList[index - 1], 10)) < (parseInt(mediaMg.timeList[index], 10) - parseInt(time, 10))) {
	        return (index - 1);
	    } else {
	        return index;
	    }
	}
	
    //页面初始化
    function init(){
	  initMediaMg();
      initPause();	 
	  
	  if(mediaMg.currControlFlag==1){
		 $("timeError").innerHTML = "此频道不支持快进";
	  }
	  else
	  {
		 $("timeError").innerHTML = "";
	  }
    }
	 
	 //初始化直播 
	 function initPause(){
	  mediaMg.pause();
	  currentMedia=mediaMg.getOriCurrentTime();
   	  mediaTime=mediaMg.getOriMediaTime();
   	  mediaMg.calculate(mediaTime, 20);
   	  $("beginTime").innerHTML = mediaMg.getShiftBeginTime();
	  $("fullTime").innerHTML = mediaMg.getCurrJSTime();
	  
      var relativeTime=mediaMg.getRelativeTime(currentMedia);
	  barSpeedValue=parseInt(360/20);
	  barTuodongValue=parseInt(360/20);
	  currentBarIndex=count;
	  currentBarIndex = focusWhichBar(relativeTime, 20);
	  if(currentBarIndex>20) currentBarIndex=20;
	  
      $("currTimeShow").innerHTML =mediaMg.mediaCurrent[currentBarIndex];
      $("td_1").style.width = currentBarIndex *barSpeedValue;
	  $("td_3").style.left =146+currentBarIndex * barTuodongValue;
	}
	 
	
	 
	 //时间定位框输入数值
	 function showInputTime(id)
	 {
   	 var bufInput;	
     if(jumpPos == 1)
     {
    	  bufInput = $("jumpTimeHour").innerText;
		    if(bufInput == " ")
		    { 
		    	 bufInput = "";
		    }
        else if(bufInput.length<2){ 
			    $("jumpTimeHour").innerText = bufInput+id;
			    if(($("jumpTimeHour").innerText).length==2){pressRight();}
		    }
    }
    else if(jumpPos == 2)
    {
        bufInput = $("jumpTimeMin").innerText;
		    if(bufInput == " "){bufInput = "";}
        else if(bufInput.length<2)
        {
			      $("jumpTimeMin").innerText = bufInput+id;
			      if(($("jumpTimeMin").innerText).length==2)
			      {
			      	pressRight();
			      }
		    }       	
    }
   }
   
   //向下移动
   function arrowDown()
   {
	    if(!isShowSeekDiv)  
		{
			decChannel();
			return;
		}
   	    if(jumpPos!=0) return;
   	    jumpPos=1;
	    $("td_3img").src="../images/play/btn-pause.png";
		$("jumpTimeHour").style.backgroundColor="#e1981e";
   }
	 
	 //向上移动
	 function  arrowUp()
	 {
		 if(!isShowSeekDiv)  
		 {
			addChannel();
			return;
		 }
	 	 if(jumpPos==0) return;
	 	 resetPauseOrPlay(false);
		
     }
	 //右键控制
	function pressRight()
	{ 
	  if(!isShowSeekDiv)  
	   {
		   volumeUp();
		   return;
	   }
		if(jumpPos == 1){
			$("jumpTimeHour").style.backgroundColor="#ffffff";
			$("jumpTimeMin").style.backgroundColor="#e1981e";
			jumpPos ++;
		}else if(jumpPos == 2){
			$("jumpTimeMin").style.backgroundColor="#ffffff";
		    $("ensureJump").style.backgroundColor="#e1981e";
			jumpPos ++;
		}else if(jumpPos == 3){
			$("ensureJump").style.backgroundColor="#090202";
			$("cancelJump").style.backgroundColor="#e1981e";
			jumpPos ++;
		}else if(jumpPos==0){
			if(mediaMg.currControlFlag==1){
			  $("timeError").innerHTML = "此频道不支持快进！";
			  return;	
			}
			 currentBarIndex++;
			 if(currentBarIndex>mediaMg.mediaCurrent.length) {
				  currentBarIndex=mediaMg.mediaCurrent.length;
				  return;
			 }
			 $("currTimeShow").innerHTML = mediaMg.mediaCurrent[currentBarIndex-1];
			 $("td_1").style.width = currentBarIndex *barSpeedValue;
			 $("td_3").style.left =146+currentBarIndex * barTuodongValue;
		}
	 }
	
	//左键控制，一键跳转层
	function pressLeft()
	{	
	       if(!isShowSeekDiv)  
		   {
			   volumeDown();
			   return;
		   }
	       if(jumpPos == 2){
				$("jumpTimeMin").style.backgroundColor="#ffffff";
			  $("jumpTimeHour").style.backgroundColor="#e1981e";
				jumpPos --;
		   }else if(jumpPos == 3){
		  	$("ensureJump").style.backgroundColor="#090202";
			  $("jumpTimeMin").style.backgroundColor="#e1981e";
				jumpPos --;
			}else if(jumpPos == 4){
				$("cancelJump").style.backgroundColor="#090202";
				$("ensureJump").style.backgroundColor="#e1981e";
				jumpPos --;
			}else if(jumpPos==0){
				 currentBarIndex--;
				 if(currentBarIndex<=0) {
					  currentBarIndex=1;
				 	  return;
				 }
				 $("currTimeShow").innerHTML = mediaMg.mediaCurrent[currentBarIndex-1];
                 $("td_1").style.width = currentBarIndex *barSpeedValue;
	             $("td_3").style.left =146+currentBarIndex * barTuodongValue;
			}
			return false;
	}
	//时移时间跳转
  function playByTime(beginTime)
  {       
	  var type = 2;speed = 1;	playStat = "play";
	  mediaMg.player.playByTime(type,beginTime,speed);
	 
  }
  
  //回到直播流
  function end(){
  	mediaMg.player.gotoEnd();
  }
  
  //隐藏显示定位DIV
  function showHiddenSeek(isshow){
	 if(isshow){
		 $("seekDiv").style.visibility = "visible";
     }else{
		 $("seekDiv").style.visibility = "hidden";
	 }
  }
	//点击
  function pressOK(){
	if(isShowSeekDiv==false) 
	{
		window.location.href="playChannelList.jsp?ishow=1&ControlFlag=" +mediaMg.currControlFlag + "&CHANNELNUM=" + mediaMg.currChannelNum+"&CHANNELID="+ mediaMg.currChannelId +"&COMEFROMFLAG=<%=comeType%>";
	}
	else
	{
		if(jumpPos==0){
			 var shiftTime = mediaMg.shiftTimeList[currentBarIndex-1];
			 if (mediaTime - mediaMg.getRelativeTime(shiftTime) <= 0) {
				
				 mediaMg.gotoStart();
			   
			 } else {
				 
				 playByTime(shiftTime);
			 }
		}
		else if(jumpPos==3){
			var inputValueHour = $("jumpTimeHour").innerText;
			var inputValueMin = $("jumpTimeMin").innerText;
			var hour = parseInt(inputValueHour,10);
			var min = parseInt(inputValueMin,10);
			if(inputValueHour==""){inputValueHour="00";}
	        if(inputValueMin==""){inputValueMin="00";}
			if(!mediaMg.checkJumpTime(inputValueHour, inputValueMin)){ 
			   $("jumpTimeHour").innerText = "";
		       $("jumpTimeMin").innerText = "";
		       $("timeError").innerHTML = "时间输入不合理";
		       jumpPos = 1;	   
			   $("jumpTimeHour").style.backgroundColor="#e1981e";
			   $("ensureJump").style.backgroundColor="#090202";
			   clearTimeout(inputErrorcls);
			   if(mediaMg.currControlFlag==1){
                   inputErrorcls = setTimeout('$("timeError").innerHTML = errmessage', 3000);
			   }else{
				   inputErrorcls = setTimeout('$("timeError").innerHTML = "&nbsp;"', 3000);
			   }
			   return;
			}
			
			if((mediaMg.currControlFlag==1)&&mediaMg.isForwardCurrTime(inputValueHour, inputValueMin)){ 
			   $("jumpTimeHour").innerText = "";
		       $("jumpTimeMin").innerText = "";
		       $("timeError").innerHTML = "此频道不支持快进";
		       jumpPos = 1;	   
			   $("jumpTimeHour").style.backgroundColor="#e1981e";
			   $("ensureJump").style.backgroundColor="#090202";
			   return;
			}
			var dateobj = new Date();
			dateobj.setHours(hour - 8);
	
			var year =  dateobj.getFullYear();  
			var month = dateobj.getMonth() + 1;
			var day = dateobj.getDate(); 
			hour = dateobj.getHours();
			
			if (month < 10) month = "0" + month;
			if (day < 10) day = "0" + day;
			if (hour < 10) hour = "0" + hour;
			if (min < 10) min = "0" + min;
			var timeStamp = "" +  year + month + day + "T" + hour + min + "00" + "Z";
			playByTime(timeStamp);
		}else if(jumpPos==4){
		   mediaMg.resume();	
		}else
		{
			return;
		}
		parent.isJoinChannle=false;
		isShowSeekDiv=false;
		resetPauseOrPlay(true);
		showHiddenSeek(false);
	 }
  }
    
	 //重置播放暂停焦点
	function resetPauseOrPlay(isClearHour)
	{
		jumpPos=0;
		if(isClearHour){
		 $("jumpTimeHour").innerText="";
		 $("jumpTimeMin").innerText="";
		}
		$("td_3img").src="../images/play/btn-pause_focus.png";
	    $("jumpTimeHour").style.backgroundColor="#ffffff";
		$("jumpTimeMin").style.backgroundColor="#ffffff";
		$("ensureJump").style.backgroundColor="#090202";
		$("cancelJump").style.backgroundColor="#090202";
	}
	
	function delInputTime()
    {
	  var bufInput;	
      if(jumpPos == 1){
		  var tempHour = $("jumpTimeHour").innerHTML;
		if(tempHour == null || tempHour == "" || tempHour == undefined){
			isShowSeekDiv=false;
	        showHiddenSeek(false);
		    mediaMg.resume();
			}else{
			 bufInput = $("jumpTimeHour").innerText;
			 if(bufInput.length>0){$("jumpTimeHour").innerText=bufInput.substring(0,bufInput.length-1);}
			}
      }else if(jumpPos == 2){
		  var tempMinute = $("jumpTimeMin").innerHTML;
		if(tempMinute == null || tempMinute == "" || tempMinute == undefined){
			isShowSeekDiv=false;
	        showHiddenSeek(false);
		    mediaMg.resume();
			}else{
			bufInput = $("jumpTimeMin").innerText;
			if(bufInput.length>0){$("jumpTimeMin").innerText=bufInput.substring(0,bufInput.length-1);}
			}
     }
   }
	
	//点击返回的操作
	function pressReturn(){
		 if(isShowSeekDiv){
			if(jumpPos==1 || jumpPos==2){
		        delInputTime();
			}else{
			   	 isShowSeekDiv=false;
	             showHiddenSeek(false);
		         mediaMg.resume();
			}
	     }else{
		   if(mediaMg.shiftStatus==1){
			   mediaMg.player.gotoEnd();
			   mediaMg.shiftStatus=0;
		   }else{
			   mediaMg.player.leaveChannel();
			   var browserAgent = navigator.userAgent;
			   if (browserAgent.indexOf("WebKit") == -1) 
			   { 
					mediaMg.player.stop();
			   }
	           parent.goBack();	
		   }
	    }
	 }
	
	//点击定位键
	function pauseOrPlay(){
		if(isShowSeekDiv){
		  isShowSeekDiv=false;
	      showHiddenSeek(false);
		  mediaMg.resume();	
		}
		else{
		  initPause();
		  isShowSeekDiv=true;
	      showHiddenSeek(true);
		
		}
	}
	
	function fastForward(){
		if(mediaMg.currControlFlag==1)
	    {
           showTrickModeDiv();
	    }
    	else
     	{
	    	window.location.href="trickmode.jsp?trickMode=forward&ControlFlag=" +mediaMg.currControlFlag + "&CHANNELNUM=" + mediaMg.currChannelNum+"&CHANNELID="+ mediaMg.currChannelId +"&COMEFROMFLAG=<%=comeType%>";
	    }
	}
	
	//快退
	function fastRewind(){
      window.location.href="trickmode.jsp?trickMode=rewind&ControlFlag=" +mediaMg.currControlFlag + "&CHANNELNUM=" + mediaMg.currChannelNum+"&CHANNELID="+ mediaMg.currChannelId +"&COMEFROMFLAG=<%=comeType%>";
    }
	
	
	//下页
    function pageDown(){
		mediaMg.gotoEnd();
		if(isShowSeekDiv == true)
		{
		  isShowSeekDiv=false;
	      showHiddenSeek(false);
		}
	}
	//上页
    function pageUp(){
		mediaMg.player.pause();
		mediaMg.gotoStart();
		if(isShowSeekDiv == true)
		{
		  isShowSeekDiv=false;
	      showHiddenSeek(false);
		}
	}
   document.onkeypress = parent.keyevent;
	 //按键事件
   function keypress(keyval)
   {
	  switch(keyval)
	  {
		case <%=KEY_TRACK%>: changeAudio();return 0;
		case <%=KEY_INFO%>:if(!isShowSeekDiv) createFilmInfo();return 0;
		case <%=KEY_0%>:
		   if(isShowSeekDiv){
			  showInputTime(0);
		   }
		   else {
			  inputNum(0);
		   }
	    	break;
		case <%=KEY_1%>:
			if(isShowSeekDiv){
			  showInputTime(1);
		   }
		   else {
			  inputNum(1);
		   }
			break;
		case <%=KEY_2%>:
		  if(isShowSeekDiv){
			  showInputTime(2);
		   }
		   else {
			  inputNum(2);
		   }
			break;
		case <%=KEY_3%>:
		   if(isShowSeekDiv){
			  showInputTime(3);
		   }
		   else {
			  inputNum(3);
		   }
			break;
		case <%=KEY_4%>:
			if(isShowSeekDiv){
			  showInputTime(4);
		   }
		   else {
			  inputNum(4);
		   }
			break;
		case <%=KEY_5%>:
			if(isShowSeekDiv){
			  showInputTime(5);
		   }
		   else {
			  inputNum(5);
		   }
			break;
		case <%=KEY_6%>:
			if(isShowSeekDiv){
			  showInputTime(6);
		   }
		   else {
			  inputNum(6);
		   }
			break;
		case <%=KEY_7%>:
		  if(isShowSeekDiv){
			  showInputTime(7);
		   }
		   else {
			  inputNum(7);
		   }
			break;
		case <%=KEY_8%>:
			if(isShowSeekDiv){
			  showInputTime(8);
		   }
		   else {
			  inputNum(8);
		   }
			break;
		case <%=KEY_9%>:
		  if(isShowSeekDiv){
			  showInputTime(9);
		   }
		   else {
			  inputNum(9);
		   }
		  break;
		case 280:
		 if(isShowSeekDiv){
			if(jumpPos==1 || jumpPos==2){
		        delInputTime();
			}
		  } 
		  break;
		case <%=KEY_PAGEDOWN%>:pageDown();return false;break;
		case <%=KEY_PAGEUP%>:pageUp();return false;break;
		case <%=KEY_CHANNEL_UP%>: if(!isShowSeekDiv)  addChannel();break;	//加直播
		case <%=KEY_CHANNEL_DOWN%>:if(!isShowSeekDiv) decChannel();break;//减直播
		case <%=KEY_PAUSE_PLAY%>:
		case <%=KEY_POS%>: pauseOrPlay();return false;
		case <%=KEY_RIGHT%>:pressRight();return false;		
		case <%=KEY_LEFT%>:pressLeft();return false;
        case <%=KEY_DOWN%>:arrowDown();return false;
		case <%=KEY_UP%>:arrowUp();return false;
		case <%=KEY_VOL_UP%>:volumeUp();return false; 
		case <%=KEY_VOL_DOWN%>:volumeDown();return false;
		case <%=KEY_MUTE%>:setMuteFlag();return false;
		case <%=KEY_STOP%>:pressReturn();break;
		case <%=KEY_RETURN%>:pressReturn();break;
		case <%=KEY_GO_BEGINNING%>:break;	
		case <%=KEY_OK%>:pressOK();break;
		case <%=KEY_IPTV_EVENT%>:goUtility();break;	
		case <%=KEY_BLUE%>:mediaMg.player.leaveChannel();mediaMg.player.stop();parent.window.location.href="space_collect.jsp";return 0;
		case <%=KEY_FAST_FORWARD%>:if(!isShowSeekDiv)  fastForward();return false;
		case <%=KEY_FAST_REWIND%>:if(!isShowSeekDiv)   fastRewind();return false; 			
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
	  mediaMg.player.stop();parent.window.location.href="search.jsp";return 0;
	  default:
			break;
	}
	return true;
}

</script>
</head>
<body bgcolor="transparent" onLoad="init();">
<div id="seekDiv" style="position:absolute;width:640px;height:140px;left:0;top:390px;background-color:#090202;visibility:visible;">
	    <div style="font-size:18px;left:252px; position:absolute;top:16px;width:300px;color:#FFFFFF" id="timeError"></div>
        <div id="beginTime" style="position:absolute;width:65px;height:19px;left:75px;top:35px;font-size:22px;color:#FFFFFF"></div>
	    <div id="fullTime" style="position:absolute;width:90px;height:19px;left:540px;top:35px;font-size:22px;color:#FFFFFF"></div>
	    <div id="td_0" style="position:absolute;left:166px;width:365px;top:40px;height:9px;background-color:#ffffff"></div>
	    <div id="td_1" style="position:absolute;left:166px;width:0px;top:40px;height:9px;background-color:#e1981e"></div>
	    <div id="td_3" style="position:absolute;left:146px;width:22px;top:33px;height:24px;"><img id="td_3img" src="../images/play/btn-pause_focus.png"/></div> <!--默认left 156px;-->
      <div id="currTimeShow" style="position:absolute;width:90px;height:19px;left:320px;top:55px;font-size:22px;color:#FFFFFF"></div>
        
      <div id="jumpTimeDiv" style="position:absolute;width:600px;height:45px;left:20px;top:90px;font-size:20px;color:#FFFFFF;">
	        <div id="jumpTimeHour" style="position:absolute;left:160px;width:75px;top:2px;height:28px;background-color:#ffffff;color:#000000;text-align:center;"></div>
	        <div style="position:absolute;left:240px;width:25px;top:2px;height:20px;text-align:center;">时</div>
	        <div id="jumpTimeMin" style="position:absolute;left:280px;width:75px;top:2px;height:28px;background-color:#ffffff;color:#000000;text-align:center;"></div>
	        <div style="position:absolute;left:360px;width:25px;top:2px;height:20px;text-align:center;">分</div>
               <div id="inputDecr" style="position:absolute;width:120px;height:20px;left:35px;top:2px;text-align:center;font-size:20px;color:#FFFFFF;">请输入时间</div>
	       <div id="ensureJump" style="position:absolute;width:75px;height:30px;left:425px;top:2px;background-color:#090202;">
	         <div style="font-size: 20px;font-weight: bold;color: #ffffff;padding-top: 5px;text-align: center;width: 75px;">跳转</div>
	       </div>
	      <div id="cancelJump" style="position:absolute;width:75px;height:30px;left:520px;top:2px;background-color:#090202;">
	         <div style="font-size: 20px;font-weight: bold;color: #ffffff;padding-top: 5px;text-align: center;width: 75px;">取消</div>
	       </div>
      </div>
 </div>	
 <div style="display: none;">
  <img src="../images/play/btn-pause.png"></img>
  <img src="../images/play/btn-pause_focus.png"></img>
 </div>
 <jsp:include page="volumeControl.jsp"></jsp:include>
 <jsp:include page="showChanInfo.jsp"></jsp:include>
 <jsp:include page="normaltrickmode.jsp"></jsp:include>
</body>
</html>
