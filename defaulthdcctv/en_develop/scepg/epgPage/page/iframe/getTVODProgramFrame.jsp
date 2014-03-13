<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<%
 
   	 String tVODProgrameFile="../../../" + datajspname  + "/TVODPrevue.jsp";
     String channelId = request.getParameter("channelID")==null?"":request.getParameter("channelID");
	 String curdate = request.getParameter("curdate")==null?"":request.getParameter("curdate");
	 String getPlayUrlFile="../../../" + datajspname  + "/getPlayURL.jsp";	 

	 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>getChannelListFrame</title>
<script type="text/javascript">

	
   		<jsp:include page="<%=tVODProgrameFile%>">
				<jsp:param name="channelId" value="<%=channelId%>"/> 
				<jsp:param name="varName" value="tVODProgrameList"/>
				<jsp:param name="curdate" value="<%=curdate%>"/>
				<jsp:param name="fields" value="-1" /> 
				<jsp:param name="isBug" value="1" />
		</jsp:include>	
		
		  function init()
		  {
               parent.callTVODProgram(tVODProgrameList);
          }
	

</script>
</head>
<body onload="init()">
</body>
</html>
