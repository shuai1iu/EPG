<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="keyDefine/keydefine.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<meta name="page-view-size" content="1280*720" />
<%@ include file="../../../config/properties.jsp"%>
<%
	String returnUrl = request.getParameter("returnUrl")==null?"":request.getParameter("returnUrl");
	String programCode = request.getParameter("programCode")==null?"-1":request.getParameter("programCode");
	String programType = request.getParameter("programType")==null?"-1":request.getParameter("programType");
	String categoryCode=request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode");
	String ParentProgramCode = request.getParameter("ParentProgramCode")==null?"-1":request.getParameter("ParentProgramCode");
	String ParentContentCode = request.getParameter("ParentContentCode")==null?"-1":request.getParameter("ParentContentCode");
	String contentCode = request.getParameter("contentCode")==null?"-1":request.getParameter("contentCode");
    String strFile="../../../" + datajspname  + "/vodInfo.jsp";
	String getPlayUrlFile="../../../" + datajspname  + "/getPlayURL.jsp";
	String definition=request.getParameter("definition")==null?"0":request.getParameter("definition");
	String breakpoint=request.getParameter("breakpoint")==null?"0":request.getParameter("breakpoint");
	
	
	String programId = request.getParameter("tvodProgramId")==null?"":request.getParameter("tvodProgramId");
    String startTime = request.getParameter("startTime")==null?"":request.getParameter("startTime");
	String endTime = request.getParameter("endTime")==null?"":request.getParameter("endTime");
    String strBookMarkFile="../../../" + datajspname  + "/checkBookMark.jsp";

	
%>
<script type="text/javascript" src="../../js/pagecontrol_1.0.4.js"></script>
<script type="text/javascript">
   <% if(programId!=""&&startTime!=""&&endTime!=""){%>
	   
	     <jsp:include page="<%=getPlayUrlFile%>">
			<jsp:param name="type" value="TVOD" />
			<jsp:param name="value" value="<%=programId%>" /> 
			<jsp:param name="startTime" value="<%=startTime%>" /> 
			<jsp:param name="endTime" value="<%=endTime%>" />  
			<jsp:param name="isBug" value="1" />
	     </jsp:include>	
	   
	   
	   <%}else{%>
	   
	   <jsp:include page="<%=strFile%>">
			<jsp:param name="programCode" value="<%=ParentProgramCode%>" /> 
			<jsp:param name="varName" value="vodInfoData" /> 
			<jsp:param name="isBug" value="1" />
			<jsp:param name="contentCode" value="<%=ParentContentCode%>" />
		    <jsp:param name="categoryCode" value="<%=categoryCode%>" />
	   </jsp:include>
	

	
	 <jsp:include page="<%=getPlayUrlFile%>">
		<jsp:param name="type" value="VOD" />
		<jsp:param name="categoryCode" value="<%=categoryCode%>" />
		<jsp:param name="mediacode" value="<%=contentCode%>" /> 
		<jsp:param name="definition" value="<%=definition%>" /> 
		<jsp:param name="breakpoint" value="<%=breakpoint%>" /> 
		<jsp:param name="value" value="<%=programCode%>" />  
		<jsp:param name="isBug" value="1" />
	</jsp:include>
	  
	   <%}%>
	   
	//判断是否有书签
	<jsp:include page="<%=strBookMarkFile%>">             
		<jsp:param name="categoryCode" value="<%=categoryCode%>"/> 
		<jsp:param name="programCode" value="<%=programCode%>" />  
		<jsp:param name="bookMarkType" value="VOD" />
		<jsp:param name="varName" value="tempBookMark"/>
	</jsp:include>
	<%
		JSONObject tempBookMark=new JSONObject();
		if(request.getAttribute("tempBookMark")!=null){
			tempBookMark = (JSONObject)request.getAttribute("tempBookMark");
		}
	%> 
	
	
	var tempBookMark=<%=tempBookMark%>;
    var ParentProgramCode="<%=ParentProgramCode%>";
	var contentCode="<%=contentCode%>";
	var programCode="<%=programCode%>";
	var programType="<%=programType%>";
	var categoryCode="<%=categoryCode%>";
	var returnUrl = "<%=returnUrl%>";
	var totalSubVod =0;
	var indexNum=0;
	if(programType=="1")
	{
		totalSubVod =0;
	}else{
		totalSubVod=vodInfoData.subVodList.length;
	}
 //   var playUrl = "rtsp://220.181.168.185:5541/mp4/2013henanfenghui/zhibo/cctv1.ts";
	var mp = new MediaPlayer();
	
	function goBack(){
		window.location.href = returnUrl;
	}
	
	function addBookMarkResult(datavalue){
		var isbooksucc = parseInt(datavalue.result);
		if(isbooksucc==1){
		
			  goBack();
		}
	}
	
	function playEnd(){
		mp.stop();
	}
	       
    function getSubPlayUrl(tempindexNum,tempprogramCode,tempcontentCode){
		programCode=tempprogramCode;
		contentCode=tempcontentCode;
		indexNum=tempindexNum;
		$("getPlayUrl").src = "../iframe/getPlayUrlIframe.jsp?contentCode="+contentCode+"&programCode="+programCode;
	}
	
	function addBookMark(temppoint,temptotalTime){
		$("getPlayUrl").src ="../iframe/spaceBookMarkAddIframe.jsp?programCode="+programCode +"&categoryCode="+ categoryCode + 
		"&parentProgramCode="+ParentProgramCode+"&contentCode="+ contentCode+"&breakPoint="+temppoint+"&totalTime="+temptotalTime;
	}  
	
	function callPlayUrlData(curPlayUrl){
		mp.stop();
		playUrl = curPlayUrl;
		
		$("playerFrame").src = "mediaPlayer.jsp";
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
	<frame name="playerFrame" id="playerFrame" width="0px" height="0px" src="mediaPlayer.jsp"></frame>
    <frame name="viewFrame" width="1280px" height="720px" src="blank.jsp" ></frame>	
    <frame name="getPlayUrl" id="getPlayUrl" width="1px" height="1px" src="" ></frame>	
    <noframes>
	  <body bgcolor="transparent"><div style="color:red;"></div></body>
    </noframes>
</frameset>
</html>
