<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<%@ include file="keyDefine/keydefine.jsp"%>
<%
 
	 String programId = request.getParameter("channelID")==null?"":request.getParameter("channelID");
	 String getPlayUrlFile="../../../" + datajspname  + "/getPlayURL.jsp";	  
	 String returnUrl = request.getParameter("returnUrl")==null?"":request.getParameter("returnUrl");
	 System.out.println("********programId***1***programId*********1**"+programId+"====returnUrl"+returnUrl);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<script type="application/javascript" src="../../js/MediaPlayer.js"></script>
<script type="text/javascript">
         var returnUrl="<%=returnUrl%>";
         <jsp:include page="<%=getPlayUrlFile%>">
			<jsp:param name="type" value="CHAN" />
			<jsp:param name="value" value="<%=programId%>" />  
			<jsp:param name="isBug" value="1" />
	      </jsp:include>	
		  
		function init()
	    {	  
		    playUrl = "rtsp://220.181.168.185:5541/mp4/2013henanfenghui/zhibo/cctv1.ts";
			play(0,0,1280,720);
			
	    }
		function destoryMP()
        {
            mp.stop();
        }
		function goBack()
		{
		    window.location.href = returnUrl;
	    }
</script>


<script type="text/javascript">
	document.onkeypress = keyEvent;
	//document.onkeydown = keyEvent;
	function keyEvent()
	{
		var val = event.which ? event.which : event.keyCode;
		return keypress(val);
	}

	function keypress(keyval)
	{

		switch(keyval)
		{
			case <%=KEY_MUTE%>:
				 setMuteFlag();
				 break;
			case <%=KEY_VOL_UP%>:
				 volumeUp();
				 break;
			case <%=KEY_VOL_DOWN%>:
				 volumeDown();
				 break;
	
			case <%=KEY_RETURN%>:
			case 32:
				 goBack();
				 break;
			default:
				break;		
		}
		return true;
	}

</script>
<script type="text/javascript">


</script>


</head>
<body bgcolor="transparent" onload="init()" onUnload="destoryMP()">
   <div style="width:440px ;height:207px;top:240px;left:400px;position:absolute;visibility:hidden;" id="loaddiv">
   		<img src="../../images/loading.jpg" width="440px"  height="207px"/>
   </div>
   <div id="bottomframe" style="position:absolute;left:60px; top:530px; width:1200px; height:190px;color:green;font-size:36;z-index:10;"></div>
   <div id="voice_div" style="position:absolute;width:200px; height:200px; top:50px; left:50px; display:none; z-index:10;">
		<img id="voice" src="../../images/icon-mute.png"/>
   </div>
</body>
</html>
