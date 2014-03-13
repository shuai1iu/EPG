<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="datajsp/playbacklistdata.jsp"%>
<html>
<head>
<script type="text/javascript" language="javascript">
var currarea = '<%=request.getParameter("currarea")%>';

if(currarea == "0")
{
	window.parent.getDateData(channelDateList);
}
if(currarea == "1")
{
	window.parent.getProgramData(programList,pageCount);
}
	
	
</script>
</head>
</html>