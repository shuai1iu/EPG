<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="keyDefine/keydefine.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<meta name="page-view-size" content="1280*720" />
<%@ include file="../../../config/properties.jsp"%>
<%
	String returnUrl = request.getParameter("returnUrl")==null?"":request.getParameter("returnUrl");
	String channelID = request.getParameter("channelID")==null?"":request.getParameter("channelID");
    String channelNum = request.getParameter("channelNum")==null?"":request.getParameter("channelNum");
	
%>
<script type="text/javascript" src="../../js/pagecontrol_1.0.4.js"></script>
<script type="text/javascript">

    
	var channelID="<%=channelID%>";
	var returnUrl = "<%=returnUrl%>";
	
    var channelNum="<%=channelNum%>";
	var mp = new MediaPlayer();
	
	//播放影片的总时长
	var chanStartTime=parseInt(mp.getMediaDuration(),10);
	
	function goBack()
	{
		window.location.href = returnUrl;
	}
	
	function playEnd()
	{
		mp.leaveChannel();
	}

	function goUtility(){
    	eval("eventJson = " + Utility.getEvent());
    	var typeStr = eventJson.type;
    	switch(typeStr){
			case 'EVENT_FIRST_I_FRAME'://b700 V2U
    		case "EVENT_MEDIA_BEGINING"://b700 V2A
    			
    			break;
            case "EVENT_MEDIA_ERROR":
            	goBack();
            	break;
            case "EVENT_MEDIA_END":
				playEnd();
                break;
            default :
                return 1;
        }
        return 1;
    }
</script>
</head>

<frameset rows="0,100" frameborder="no" border="0" framespacing="0">
	<frame name="playerFrame" id="playerFrame" width="0px" height="0px" src="mediaPlayer1.jsp"></frame>
    <frame name="viewFrame" width="1280px" height="720px" src="blank1.jsp" ></frame>	
    <frame name="getPlayUrl" id="getPlayUrl" width="1px" height="1px" src="" ></frame>	
    <noframes>
	  <body bgcolor="transparent"><div style="color:red;"></div></body>
    </noframes>
</frameset>
</html>
