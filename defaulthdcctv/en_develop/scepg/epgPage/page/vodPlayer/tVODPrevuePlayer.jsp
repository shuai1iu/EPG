<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<%@ include file="keyDefine/keydefine.jsp"%>
<%
 
	 String programId = request.getParameter("tvodProgramId")==null?"":request.getParameter("tvodProgramId");
	 String startTime = request.getParameter("startTime")==null?"":request.getParameter("startTime");
	 String endTime = request.getParameter("endTime")==null?"":request.getParameter("endTime");
	 String returnUrl = request.getParameter("returnUrl")==null?"":request.getParameter("returnUrl");
	 String getPlayUrlFile="../../../" + datajspname  + "/getPlayURL.jsp";	 
	 
	 
	  
	 System.out.println("********programId***********1**"+programId+"====startTime"+startTime+"********"+endTime);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<script type="application/javascript" src="../../js/MediaPlayer.js"></script>
<script type="text/javascript">
         var returnUrl="<%=returnUrl%>";
         <jsp:include page="<%=getPlayUrlFile%>">
			<jsp:param name="type" value="TVOD" />
			<jsp:param name="value" value="<%=programId%>" /> 
			<jsp:param name="startTime" value="<%=startTime%>" /> 
			<jsp:param name="endTime" value="<%=endTime%>" />  
			<jsp:param name="isBug" value="1" />
	     </jsp:include>	
		  
	
	
	
	
	
</script>


<script type="text/javascript">
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
