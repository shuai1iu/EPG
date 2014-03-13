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

String strIsShow="0"; 
strIsShow= request.getParameter("isShow");
%>
<html>
<head>
<script type="text/javascript" src="../js/registerGlobalKey1.js"></script>
<script type="text/javascript">
    var currChannelNum = <%=strChannelNum%>;//当前直播号
    var currChannelId=<%=strChannelId%>;//当前频道ID
    var currControlFlag=<%=strControlFlag%>; 
	var isShow=<%=strIsShow%>;
	var jumpPos=0;//焦点移动的位置
	var currentBarIndex=20;//进度条索引从1开始
	var barSpeedValue=0;
	var barTuodongValue=0;
	var isShowSeekDiv=false;//是否显示定位DIV
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
	  top.EPG.focus();
	  initMediaMg();
	  if(parent.isJoinChannle==true)
	  {
          mediaMg.initTvodMedia(parent.playUrl);
          mediaMg.playType="tvod";
	      mediaMg.currControlFlag=currControlFlag;
		  if(parent.isBookMark)
		  {
				var type = 1;
				var speed = 1;
				mediaMg.player.playByTime(type,parent.beginTime,speed);
		  }
		  else{
				mediaMg.player.playFromStart();
		  }
		  parent.isJoinChannle=false;
	   }
	   if(mediaMg.currControlFlag==1)
	   {
		 $("timeError").innerHTML = "此频道不支持快进";
	   }
	   else
	   {
		 $("timeError").innerHTML = "";
	   }
	   if(parseInt(isShow)==1){
		  initPause();
		  isShowSeekDiv=true;
		  showHiddenSeek(true);
	   }
    }
	
   //初始化直播 
	 function initPause(){
	  mediaMg.pause();
	  currentMedia=mediaMg.getOriCurrentTime();
   	  mediaTime=mediaMg.getOriMediaTime();
   	  mediaMg.calculate(mediaTime, 60);
	  
	  var fullTime = mediaMg.getMediaTime();
	  $("fullTime").innerText = fullTime;
	  $("beginTime").innerText = mediaMg.convertTime(0).substring(0, 5);
	  
	  var relativeTime=mediaMg.getOriCurrentTime();
	  barSpeedValue=parseInt(360/60);
	  barTuodongValue=parseInt(360/60);
	  currentBarIndex=count;
	  currentBarIndex = focusWhichBar(relativeTime, 60);
	  if(currentBarIndex>60) currentBarIndex=60;
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
	    if(isShowSeekDiv){
   	      if(jumpPos!=0) return;
   	      jumpPos=1;
	      $("td_3img").src="../images/play/btn-pause.png";
		  $("jumpTimeHour").style.backgroundColor="#e1981e";
		}else if(isShowQuitDiv){
			downQuitDiv();
		}
   }
	 
	 //向上移动
	 function  arrowUp()
	 {
		 if(isShowSeekDiv){
	 	   if(jumpPos==0) return;
	 	   resetPauseOrPlay(false);
		 }else if(isShowQuitDiv){
			upQuitDiv();
		 }
		
     }
	 //右键控制
	function pressRight()
	{ 
	   if(!isShowSeekDiv&&!isShowQuitDiv)
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
	       if(!isShowSeekDiv&&!isShowQuitDiv) 
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
	  var type = 1;speed = 1;	playStat = "play";
	  mediaMg.player.playByTime(type,beginTime,speed);
	 
  }
  
  
  function end(){
  	mediaMg.player.gotoEnd();
  }
  
  //隐藏显示定位DIV
  function showHiddenSeek(isshow){
	 if(isshow){
		 $("seekDiv").style.display = "block";
     }else{
		 $("seekDiv").style.display = "none";
	 }
  }
	//点击
  function pressOK(){
	if(isShowSeekDiv==false) 
	{
		if(isShowQuitDiv){
		   	pressquitOk();
		}
	}
	else
	{
		if(jumpPos==0){
			  var focusTime = Math.floor(mediaMg.timeList[currentBarIndex-1]);
			  playByTime(focusTime);
			
		}
		else if(jumpPos==3){
			var inputValueHour = $("jumpTimeHour").innerText;
			var inputValueMin = $("jumpTimeMin").innerText;
			var hour = parseInt(inputValueHour,10);
			var min = parseInt(inputValueMin,10);
			if(inputValueHour==""){inputValueHour="00";}
	        if(inputValueMin==""){inputValueMin="00";}
			if(!mediaMg.checkTVodJumpTime(inputValueHour, inputValueMin)){ 
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
			
			if((mediaMg.currControlFlag==1)&&!mediaMg.isForwardCurrTimeForTVod(inputValueHour, inputValueMin)){ 
			   $("jumpTimeHour").innerText = "";
		       $("jumpTimeMin").innerText = "";
		       $("timeError").innerHTML = "此频道不支持快进！";
		       jumpPos = 1;	   
			   $("jumpTimeHour").style.backgroundColor="#e1981e";
			   $("ensureJump").style.backgroundColor="#090202";
			   return;
			}
			var timeStamp = (parseInt(hour, 10) * 60 + parseInt(min, 10)) * 60;
			playByTime(timeStamp);
	    }else if(jumpPos==4){
		   mediaMg.resume();	
	    }else{
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
    	 bufInput = $("jumpTimeHour").innerText;
		 if(bufInput.length>0){$("jumpTimeHour").innerText=bufInput.substring(0,bufInput.length-1);}
		 else{isShowSeekDiv=false;showHiddenSeek(false);mediaMg.resume();}
      }else if(jumpPos == 2){
         bufInput = $("jumpTimeMin").innerText;
		 if(bufInput.length>0){$("jumpTimeMin").innerText=bufInput.substring(0,bufInput.length-1);}
		 else{isShowSeekDiv=false;showHiddenSeek(false);mediaMg.resume();}
     }
   }
	
	
	//点击返回的操作
	function pressReturn(){
		
		 if(finishedDivIsShow) return;
		 if(isShowSeekDiv){
			if(jumpPos==1 || jumpPos==2){
		        delInputTime();
			}else{
			   	 isShowSeekDiv=false;
	             showHiddenSeek(false);
		         mediaMg.resume();
			}
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
	
	//点击定位键
	function pauseOrPlay(){
		if(finishedDivIsShow) return;
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
		if(finishedDivIsShow) return;
		if(mediaMg.currControlFlag==1)
	    {
           showTrickModeDiv();
	    }
    	else
     	{
	    	window.location.href="tvodtrickmode.jsp?trickMode=forward&ControlFlag=<%=strControlFlag%>&CHANNELNUM=0&CHANNELID=<%=strChannelId%>&COMEFROMFLAG=<%=comeType%>";
	    }
	}
	
	//快退
	function fastRewind(){
	  if(finishedDivIsShow) return;
      window.location.href="tvodtrickmode.jsp?trickMode=rewind&ControlFlag=<%=strControlFlag%>&CHANNELNUM=0&CHANNELID=<%=strChannelId%>&COMEFROMFLAG=<%=comeType%>";
    }
	
	
	//下页
    function pageDown(){
		if(finishedDivIsShow) {
		  return;
		}
		finishedDivIsShow=true;
		mediaMg.gotoEnd();
		if(isShowSeekDiv == true)
		{
		  isShowSeekDiv=false;
	      showHiddenSeek(false);
		}
	}
	//上页
    function pageUp(){
		if(finishedDivIsShow) return;
		finishedDivIsShow=false;
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
		case <%=KEY_INFO%>:if(!isShowSeekDiv && !isShowQuitDiv) createTVodFilm();return 0;
		case <%=KEY_0%>:
		   if(isShowSeekDiv){
			  showInputTime(0);
		   }
		   break;
		case <%=KEY_1%>:
			if(isShowSeekDiv){
			  showInputTime(1);
		    }
		    break;
		case <%=KEY_2%>:
		  if(isShowSeekDiv){
			  showInputTime(2);
		   }
		  break;
		case <%=KEY_3%>:
		   if(isShowSeekDiv){
			  showInputTime(3);
		   }
		   break;
		case <%=KEY_4%>:
			if(isShowSeekDiv){
			  showInputTime(4);
		   }
		   break;
		case <%=KEY_5%>:
			if(isShowSeekDiv){
			  showInputTime(5);
		    }
		    break;
		case <%=KEY_6%>:
			if(isShowSeekDiv){
			  showInputTime(6);
		    }
		    break;
		case <%=KEY_7%>:
		  if(isShowSeekDiv){
			  showInputTime(7);
		   }
		   break;
		case <%=KEY_8%>:
			if(isShowSeekDiv){
			  showInputTime(8);
		   }
			break;
		case <%=KEY_9%>:
		  if(isShowSeekDiv){
			  showInputTime(9);
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
		case <%=KEY_BLUE%>:mediaMg.player.stop();parent.window.location.href="space_collect.jsp";return 0;
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
<div id="seekDiv" style="position:absolute;width:640px;height:140px;left:0;top:390px;background-color:#090202;display:none">
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
 <jsp:include page="normalTvodtrickmode.jsp"></jsp:include>
 <jsp:include page="tVodFileinfo.jsp"></jsp:include>
</body>
</html>
