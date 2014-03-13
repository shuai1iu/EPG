<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="com.huawei.iptvmw.epg.facade.metadata.CommonImpl" %>
<%@ page import="com.huawei.iptvmw.epg.util.xml.DateUtilities" %>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ include file="keydefine.jsp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>play_Controlchannel</title>
<style type="text/css"> 
body { background-color:#000; font-family:"Microsoft YaHei"; font-size:22px; color:#fff;  margin:0px; padding:0px; width:640px; height:530px; overflow:hidden; position:relative;}
div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,p,th,td {margin:0; padding:0}
pre,em,i,textarea,input,font{font-size:12px; font-weight:normal; font-style:normal}
img {border:0; margin:0}
button, input, select, textarea { font-size:100%;}
</style>
</head>
<script language="javascript">
    var mp = parent.mp;
    var channellist=parent.channellist;
	var area0index=parent.area0index;
	var area1index=parent.area1index;
	var area2index=parent.area2index;
	var channelcode=parent.channelcode;
	var channelid=parent.channelid;
	var icurrentchannel="";
	var channelJptimeID;
	var tempShowMsgTimer;
	var shiftFlag = parent.shiftFlag;
	
    window.onload = function(){
	  window.focus();
	  setSTB();//2014/1/27
    };

	//左右键机顶盒控制
	function setSTB()
	{
		Authentication.CTCSetConfig("key_ctrl_ex", "1");
	}
	//左右键EPG控制
	function setEPG()
	{
		Authentication.CTCSetConfig("key_ctrl_ex", "0");
	}


	document.onkeypress = keyEvent;
	function keyEvent()
	{
		var val = event.which ? event.which : event.keyCode;
		return keypress(val);
	}
	function keypress(keyval)
	{
		switch(keyval)
		{
			
			case <%=KEY_0%>:
				inputNum(0);
				return 0;			
				break;
			case <%=KEY_1%>:
				inputNum(1);
				return 0;	
				break;
			case <%=KEY_2%>:
				inputNum(2);
				return 0;	
				break;
			case <%=KEY_3%>:
				inputNum(3);
				return 0;	
				break;
			case <%=KEY_4%>:
				inputNum(4);
				return 0;	
				break;
			case <%=KEY_5%>:
				inputNum(5);
				return 0;
				break;
			case <%=KEY_6%>:
				inputNum(6);
				return 0;
				break;
			case <%=KEY_7%>:
				inputNum(7);
				return 0;
				break;
			case <%=KEY_8%>:
				inputNum(8);
				return 0;
				break;
			case <%=KEY_9%>:
				inputNum(9);
				return 0;
				break;
			case <%=KEY_UP%>: //2014/1/27
			case <%=KEY_CHANNEL_UP%>: addChannel();break;	//加直播
			case <%=KEY_DOWN%>: //2014/1/27
			case <%=KEY_CHANNEL_DOWN%>: decChannel();break;//减直播
			case <%=KEY_PAGEDOWN%>:gotoEnd();return false;
			case <%=KEY_PAGEUP%>:gotoStart();return false;
			case <%=KEY_RETURN%>:pressReturn();break;
			case <%=KEY_OK%>:pressOK();break;
			case <%=KEY_IPTV_EVENT%>:goUtility();break;
		}
		return true;
	}
	
	function inputNum(tempvalue){
		showChannnum();
		clearTimeout(channelJptimeID);
		icurrentchannel=icurrentchannel+tempvalue;
		$("topframenum").innerHTML=icurrentchannel;
		channelJptimeID = setTimeout("playJoinChannel()", 3000);// 3秒钟之后切换直播
		
	}
	
	function gotoStart()
	{
		 mp.gotoStart();
	}
	
    function gotoEnd()
	{
		mp.gotoEnd();
	}	
	
    //离开当前直播
	function stopChannel()
	{	
		mp.leaveChannel();
	}	
    
	function playJoinChannel(){
		var tempindex=getChanIndexByNum(icurrentchannel);
		if(tempindex==-1){
			showChannnum();
		    $("topframenum").innerHTML="频道号不存在！";
			icurrentchannel="";
			tempShowMsgTimer = setTimeout("hiddenChannnum();", 5000);
		}else{
			area0index=tempindex;
			parent.area0index=tempindex;
			//parent.area0.curindex=area0index;
			icurrentchannel="";
			joinChannel(channellist[area0index]);
		}
	}
	
	//加减频道
	function addChannel()
	{
		var totalChannel=channellist.length;
		stopChannel();//先离开上一个直播
		if(totalChannel-1 == area0index){area0index = 0;}//是否直播是最后一个直播，如果是应该切到第一个直播
		else{area0index++;}
		parent.area0index=area0index;
		//parent.area0.curindex=area0index;
		joinChannel(channellist[area0index]);
	}
	
	function  joinChannel(tempchannel){
		showChannnum();
		mp.joinChannel(tempchannel.channelid);
		parent.channelid=tempchannel.channelid;
		parent.channelcode=tempchannel.channelcode;
		$("topframenum").innerHTML=tempchannel.channelid;
		tempShowMsgTimer = setTimeout("hiddenChannnum();", 5000);
	}
	
	//向下切直播 函数中注意先后顺序
	function decChannel()
	{
		var totalChannel=channellist.length;
		stopChannel();//离开上一个直播	
		if(0 == area0index){area0index = totalChannel-1;}//是否直播是第一个直播，如果是应该切到最后一个直播
		else{area0index--;}
		parent.area0index=area0index;
		//parent.area0.curindex=area0index;
		joinChannel(channellist[area0index]);
   }	
	
	 //返回dom对象
  function $(elementid){
	  return document.getElementById(elementid);  
  }
	//事件响应
	function goUtility()
	{
		eval("eventJson = " + Utility.getEvent());
		var typeStr = eventJson.type;
		switch(typeStr)
		{  
			case "EVENT_MEDIA_ERROR": showMediaError(); tempShowMsgTimer = setTimeout("hiddenMediaError();", 3000);break;
			case "EVENT_PLAYMODE_CHANGE":break;		  
			case "EVENT_PLTVMODE_CHANGE":playModeChange(eventJson);return false;
			case "EVENT_MEDIA_BEGINING":
				 return false;
			case "EVENT_MEDIA_END":
				return false;
			default :
				 break;
		}
		return true;
	}

	//播放模式变化
	function playModeChange(eventJson)
	{
		var stat = eventJson.service_type;
		if (stat == 1)//进入时移
		{
			shiftFlag = 1;
		}
		if (stat == 0)//返回直播
		{
			shiftFlag = 0;
		}
	}
	
	function pressReturn()
	{	
		if(shiftFlag == 0)
			parent.goBack();
		else
			mp.gotoEnd();
	}


	function destoryMP()
	{
		mp.leaveChannel();
		mp.stop();
	}


	//ok键
	function pressOK()
	{	
		parent.shiftFlag = shiftFlag;
	   window.location.href="playJPChannel.jsp?channelid="+ channellist[area0index].channelid +"&channelcode=" + channellist[area0index].channelcode+"&area0index="+ area0index +"&area1index="+ area1index +"&area2index="+area2index+"&ishownum=0";
	}	
	
	function showMediaError()
    {	
	  $("errorDiv").style.display = "block";
	}
	
	//隐藏错误提示信息
	function hiddenMediaError()
	{
	   $("errorDiv").style.display = "none";
    }
	
	
	function showChannnum()
    {	
	  $("topframe").style.display = "block";
	}
	
	//隐藏错误提示信息
	function hiddenChannnum()
	{
	   $("topframe").style.display = "none";
	   $("topframenum").innerHTML="";
    }
	
	//通过直播号比对出索引，判断直播是否存在
	function getChanIndexByNum(tempchanNum)
	{
		var chanIndex = -1;
		for (var i = 0; i < channellist.length; i++){
			if (parseInt(tempchanNum) == parseInt(channellist[i].channelid)){
				chanIndex = i;
				break;
			}
		}
		return chanIndex;
	}
	
</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="transparent"  style="background:transparent;">

<!-- 右上显示直播号-->
<div id="topframe" style="position:absolute;left:180px; top:8px; width:200px; height:30px; z-index:1;display:none">
<table width="280" height="40"><tr align="center"><td style="color:#006600;font-size:28px;" id="topframenum"></td></tr></table>
</div>


<!--系统错误提示-->
<div id="errorDiv" style="position:absolute; left:120px; top:315px; width:400px; height:70px; z-index:1;display:none">
  <table width="400px" height="80" border="0">
    <tr>
      <td width="400px" align="center"  style="color:#006600;font-size:28px;">系统错误，请切换直播或稍候再试！</td>
    </tr>
  </table>
</div>

</body>
</html>
