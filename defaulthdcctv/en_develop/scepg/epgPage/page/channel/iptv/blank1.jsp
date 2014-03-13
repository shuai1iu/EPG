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

	function keypress(keyval)
	{
		if(keyval == <%=KEY_IPTV_EVENT%>)
		{
			parent.goUtility();
		}
		switch(keyval)
		{
			case <%=KEY_BOTTOMLINE%>:showBottomLine();break;//直播号下划线
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
			case <%=KEY_VOL_UP%>:volumeUp();return false; //----------------------1
		    case <%=KEY_VOL_DOWN%>:volumeDown();return false;//-------------------1
		    case <%=KEY_MUTE%>:setMuteFlag();return false; //静音键----------------1
		    case <%=KEY_STOP%>:stopKey();break;
		    case <%=KEY_RETURN%>:pressReturn();break;//返回键
			case <%=KEY_OK%>:pressOK();return false;break;
		    case <%=KEY_IPTV_EVENT%>:goUtility();break;
			case <%=KEY_INFO_URL%>:shwoFilmInfo();break;//信息键
			case <%=KEY_POS%>:pauseOrPlay();return false;
			case <%=KEY_FAST_FORWARD%>:fastForward();return false;
	        case <%=KEY_FAST_REWIND%>:fastRewind();return false; 
			case <%=KEY_TRACK%>: changeAudio();  break;
			
			case <%=KEY_MUTE%>:
				 setMuteFlag();    //静音
				 break;
			case <%=KEY_VOL_UP%>:  //增音
				 volumeUp();
				 break;
			case <%=KEY_VOL_DOWN%>://减音
				 volumeDown();
				 break;
			case <%=KEY_FAST_FORWARD%>://直播状态下 不能快进
			     window.location.href="seek_bar1.jsp?status=fast_forward";
				 break;
			case <%=KEY_FAST_REWIND%>: //直播状态下 可以回退
				 window.location.href="seek_bar1.jsp?status=fast_reward";
				 break;
			case <%=KEY_POS%>:
			case <%=KEY_PAUSE_PLAY%>:
			case <%=KEY_OK%>:
			     mp.pause();
			     if(parent.programType=="1")
				 {
				    window.location.href="pause_program.jsp?status=play_pause";
				 }
				 else{
				    window.location.href="pause.jsp?status=play_pause";
				 }
				 break;	 
			case <%=KEY_PAGEUP%>:
				 window.location.href="seek_bar.jsp?status=page_up";
				 break;	 
			case <%=KEY_PAGEDOWN%>:
				 window.location.href="seek_bar.jsp?status=page_down";
				 break;
			case <%=KEY_LEFT%>:
				 window.location.href="seek_bar.jsp?status=fast_reward";
				 break;
			case <%=KEY_RIGHT%>:
			//	 window.location.href="seek_bar.jsp?status=fast_forward"; //直播状态下 不能快进
				 break;
			case <%=KEY_STOP%>:
			case <%=KEY_RETURN%>:
			case 32:
				 mp.pause();
				 window.location.href="exit_sure.jsp";
				 break;
			case <%=KEY_INFO%>:
				//showProgramInfo();
				break;
			default:
				break;		
		}
		return true;
	}
</script>
<script type="text/javascript">
	var volume = 20;
    var mute = 0;
	var volumeDivIsShow = false;
	var bottomTimer = null;
	function volumeUp()
	{
		hideVoice();
		volumeDivIsShow = true;
		var muteFlag = mp.getMuteFlag();
		if(muteFlag == 1){mp.setMuteFlag(0);}//muteFlag == 1 静音 恢复成正常状态
		volume = mp.getVolume();  //获取音量
		volume += 5;
		if(volume >= 100){volume = 100;}
		mp.setVolume(volume);   //设置音量
		if (mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
		{
			if(bottomTimer!=null)
				clearTimeout(bottomTimer);
			bottomTimer = null;
			genVolumeTable(volume);
			bottomTimer = setTimeout(hideBottom, 5000);
		}
	}
	function volumeDown()
	{	
		hideVoice();
		volumeDivIsShow = true;
		var muteFlag = mp.getMuteFlag();
		if(muteFlag == 1)
		{
			mp.setMuteFlag(0);
		}
		volume = mp.getVolume();
		volume -= 5;	
		if(volume <= 0)
		{
			volume = 0;    
		}
		mp.setVolume(volume);  
		if (mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
		{
			if(bottomTimer!=null)
				clearTimeout(bottomTimer);
			bottomTimer = null;
			genVolumeTable(volume);
			bottomTimer = setTimeout(hideBottom, 5000);
		}
	}
	function hideBottom()
	{
		volumeDivIsShow = false;
		$("bottomframe").innerHTML = "";
	}
	function hideVoice()
	{
		$("voice_div").style.display="none";
	}
	
	function genVolumeTable(volume)
    {
    	var tableDef = '<table width="980px" border="0" cellpadding="0" cellspacing="0"><tr>';
    	volume = parseInt(volume / 5);
  
    	for (i = 0; i < 40; i++)
    	{
    		if (i % 2 == 0)
    		{
    			tableDef += '<td width="20px" height="54px" bgcolor="transparent"></td>';
    		}
    		else
    		{
    			if ( i / 2 < volume)
    			{
    				tableDef += '<td width="20px" height="54px" bgcolor="#00ff00"></td>';
    			}
    			else
    			{
    				tableDef += '<td width="20px" height="54px" bgcolor="cccccc"></td>';
    			}
    		}
    	}

    	tableDef += '<td width="20px"></td><td width="40px"><img border="0" src="images/playcontrol/playVod/volume.gif"></td><td width="40px" style="color:white;font-size:28">' + volume + '</td>';

    	tableDef += '</tr></table>';

    	$("bottomframe").innerHTML = tableDef;
    }
	function setMuteFlag()
	{
		hideBottom();
		bottomTimer = null; 
		volumeDivIsShow = true;
		var muteFlag = mp.getMuteFlag();
		if(muteFlag == 1)
		{
			mp.setMuteFlag(0);
			     //不能使用player本地的UI显示功能  不能使用了player本地的UI显示功能
			if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
			{
				$("voice_div").style.display="none";
			}
		}
		else
		{
			mp.setMuteFlag(1);
			if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
			{
				$("voice_div").style.display="block";
			}
		}      
	}
	
	function initMuteIcon(){
		var muteFlag = mp.getMuteFlag();
		if(muteFlag == 1){
			if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
			{
				$("voice_div").style.display="block";
			}
		}
	}
	
	
	function showBottomLine()
	{
		//直播下划线
			if("false" == channelListFlag){return;}
	if(hideNumTimer){clearTimeout(hideNumTimer);}
	hideChannelNum();
	if(bottomLineHideTime){clearTimeout(bottomLineHideTime);}
	if(bottomLineNum < bottomLineAllNum){bottomLineNum++;}
	else{bottomLineNum = 0;}
	var strBottom = '<table width=200 height=30><tr align="right"><td><font color="green" size="20"  height="10" style="font-weight:900">';
	for(var i = 0; i < bottomLineNum; i++)
	{
		strBottom += '_';
	}
	strBottom += '</font></td></tr></table>';
	$("topframe_bottomLine").innerHTML = strBottom;
	if(bottomLineHideTime){clearTimeout(bottomLineHideTime);}
	bottomLineHideTime = setTimeout(hideBottomLine,<%=DEFAULT_HIDEINFO_TIME%>);
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
	function  inputNum(i)
	{
		
	    //定义全局变量
		number=number*10+i; // 连续按两次1  number 就变成11 
	
		
		clearTimeout(timeID);
		//3秒后在执行
	    timeID = setTimeout("playByChannelNum("+ number +")", 3000);
		
		/**
		  根据直播号 获取 添加到joinChannel的参数
		*/
		mp.joinChannel("XXX");    
		
		//执行完毕 需要吧
		number=0;
		
	}

	
	
    function $(id)
    {
		return document.getElementById(id);
    }
	
</script>
<script type="text/javascript">
   var mp = parent.mp;
   window.onload = function(){
	  window.focus();
       //if(parent.beginflag)
	   //initMuteIcon();
       //showloading();
    };
	
   function showloading(){
	  if(parent.beginflag){
	  	 return;
	  }
      $("loaddiv").style.visibility = "visible";
   }

   function hideloading(){
      $("loaddiv").style.visibility = "hidden";
      initMuteIcon();
      setTimeout("showProgramInfo()",2000);
   }
   
   function $(id) {
	  return document.getElementById(id);
   }
   
</script>
</head>
<body bgcolor="transparent">
   <div style="width:440px ;height:207px;top:240px;left:400px;position:absolute;visibility:hidden;" id="loaddiv">
   		<img src="../../images/loading.jpg" width="440px"  height="207px"/>
   </div>
   <div id="bottomframe" style="position:absolute;left:60px; top:530px; width:1200px; height:190px;color:green;font-size:36;z-index:10;"></div>
   <div id="voice_div" style="position:absolute;width:200px; height:200px; top:50px; left:50px; display:none; z-index:10;">
		<img id="voice" src="../../images/icon-mute.png"/>
   </div>
</body>
</html>