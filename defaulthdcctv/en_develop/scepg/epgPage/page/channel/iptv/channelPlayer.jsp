<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<meta name="page-view-size" content="1280*720" />
<%@ include file="file:///F|/任务5/config/properties.jsp"%>
<%
	String channelName=request.getParameter("channelName")==null?"":request.getParameter("channelName");
	String channelNum=request.getParameter("channelIndex")==null?"":request.getParameter("channelIndex");
	String channelId=request.getParameter("channelID")==null?"":request.getParameter("channelID");
	String curpage=request.getParameter("cpage")==null?"":request.getParameter("cpage");
	String curindex=request.getParameter("index")==null?"":request.getParameter("index");
	
	String channelListFile="../../../../" + datajspname  + "/channelList.jsp";
	String channelProgrameFile="../../../../" + datajspname  + "/channelPrevue.jsp";
	

%>

<%@ include file="file:///F|/任务5/util/channelDateUtil.jsp"%>
<%@include file="file:///F|/任务5/config/code.jsp"%>


<script type="text/javascript">
         //将频道列表全部取出来
		<jsp:include page="<%=channelListFile%>">        
				<jsp:param name="categoryCode" value="<%=channelListCode%>"/> 
				<jsp:param name="varName" value="channelList"/>
				<jsp:param name="fields" value="-1" /> 
				<jsp:param name="pageIndex" value="1" /> 
				<jsp:param name="pageSize" value="-1" />
				<jsp:param name="isBug" value="1" />
		</jsp:include>	
      
      

	   <jsp:include page="<%=channelProgrameFile%>">
				<jsp:param name="channelId" value="<%=channelId%>"/> 
				<jsp:param name="varName" value="channelProgrameList"/>
				<jsp:param name="curdate" value="<%=strDate%>"/>
				<jsp:param name="fields" value="-1" /> 
				<jsp:param name="isBug" value="1" />
		</jsp:include>	
</script>



<script type="text/javascript">
    var  channelId="<%=channelId%>";
    var indexid=parseInt("<%=curindex%>");
    var curpage=parseInt("<%=curpage%>");;
    var channelName="<%=channelName%>";
    var channelNum=parseInt("<%=channelNum%>");
	var mp = new MediaPlayer();
	function goBack(){
		//window.location.href = returnUrl;
	}
	
	function playEnd(){
		mp.stop();
	}
	       
		   
	//重新获取频道列表 和 及其通过频道channelNum 找到channelID 得到channelProgrameList
   	function getChannelInfo(chanNum)
	{
		//$("getChannelInfoFrame").src = "../iframe/getPlayUrlIframe.jsp?contentCode="+contentCode+"&programCode="+programCode;
	}
	
	//data数组 存放频道列表和节目详情,频道号
	function callPlayUrlData(data)
	{
     	mp.leaveChannel();
		channelList=data[0];
		channelProgrameList=data[1];
        channelNum = data[2];
		$("playerFrame").src = "play_channelPlayer.jsp";
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

<frameset rows="100,0" frameborder="no" border="0" framespacing="0">
	<frame name="playerFrame" id="playerFrame" width="0px" height="0px" src="play_channelPlayer.jsp"></frame>
    <frame name="viewFrame" width="1280px" height="720px" src="blank.jsp" ></frame>	
     <frame name="getPlayUrl" id="getPlayUrl" width="1px" height="1px" src="" ></frame>	
    <noframes>
	  <body bgcolor="transparent"><div style="color:red;"></div></body>
    </noframes>
</frameset>
</html>
