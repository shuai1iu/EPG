<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="keyDefine/keydefine.jsp"%>
<html>
<head>
<meta name="page-view-size" content="1280*720" />
<script type="text/javascript">
    var channelNum=parent.channelNum;
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
			case <%=KEY_0%>:parent.getChannelInfo(0);break;
		    case <%=KEY_1%>:parent.getChannelInfo(1);break;
		    case <%=KEY_2%>:parent.getChannelInfo(2);break;
		    case <%=KEY_3%>:parent.getChannelInfo(3);break;
		    case <%=KEY_4%>:parent.getChannelInfo(4);break;
		    case <%=KEY_5%>:parent.getChannelInfo(5);break;
		    case <%=KEY_6%>:parent.getChannelInfo(6);break;
		    case <%=KEY_7%>:parent.getChannelInfo(7);break;
		    case <%=KEY_8%>:parent.getChannelInfo(8);break;
		    case <%=KEY_9%>:parent.getChannelInfo(9);break;
			case <%=KEY_CHANNEL_UP%>:addChannel(); break;//加直播
	     	case <%=KEY_CHANNEL_DOWN%>:decChannel();break;//减直播
			case <%=KEY_RIGHT%>:
			     window.location.href="control_panel.jsp?status=fast_forward";
			     break;
		    case <%=KEY_LEFT%>:
			     window.location.href="control_panel.jsp?status=fast_reward";
				 break;
		    case <%=KEY_DOWN%>:addChannel();break;
		    case <%=KEY_UP%>:decChannel();break;
	
			case <%=KEY_VOL_UP%>:volumeUp();break; 
		    case <%=KEY_VOL_DOWN%>:volumeDown();break;
		    case <%=KEY_MUTE%>:setMuteFlag();break;
			
			
		    case <%=KEY_STOP%>:
			     mp.pause();
			     window.location.href="pause_program.jsp?status=play_pause";
				 break;
	
		    case <%=KEY_RETURN%>:pressReturn();break;//返回键
			case <%=KEY_OK%>:
	              //显示频道列表;
				  break;
		    case <%=KEY_IPTV_EVENT%>:goUtility();break;
			case <%=KEY_INFO_URL%>:shwoFilmInfo();break;//信息键
			case <%=KEY_POS%>:pauseOrPlay();return false;
			case <%=KEY_FAST_FORWARD%>:
			   window.location.href="control_panel.jsp?status=fast_forward";
			   return false;
	        case <%=KEY_FAST_REWIND%>:
			   window.location.href="control_panel.jsp?status=fast_reward";
			   return false; 
			case <%=KEY_TRACK%>: changeAudio();  break;
		}

}
</script>
<script type="text/javascript">
	var volume = 20;
    var mute = 0;
	var volumeDivIsShow = false;
	var bottomTimer = null;
	//增加音量
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
	//减少音量
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
	
	//静音
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
	
	

	
	//加频道
	function addChannel()
	{
		var curChannelNum=channelNum++;
		parent.getChannelInfo(curChannelNum);	
	}
	//减频道
	function decChannel()
	{
		var curChannelNum=channelNum++;
		parent.getChannelInfo(curChannelNum);	
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