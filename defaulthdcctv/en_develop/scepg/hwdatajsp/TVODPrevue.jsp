<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*"%> 
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>

<%
	String channelId = request.getParameter("channelID")==null?"-1":request.getParameter("channelID").toString();
	String varName = request.getParameter("varName")==null?"tempTVODPrevue":request.getParameter("varName").toString();
	String fields = request.getParameter("fields")==null?"-1":request.getParameter("fields").toString();
	String curdate = request.getParameter("curdate")==null?"-1":request.getParameter("curdate").toString();

	String isBug = request.getParameter("isBug")==null?"-1":request.getParameter("isBug").toString();
	String isJson = request.getParameter("isJson")==null?"-1":request.getParameter("isJson").toString();
	
	MetaData metadata = new MetaData(request);
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	
	ArrayList prevueList = new ArrayList();
	JSONArray recChannelBill = null;
	String[] prevue = metadata.getRecBill(Integer.parseInt(channelId),curdate,1);
	
	if(prevue != null && prevue.length > 0)
	{
		for(int i = 0; i < prevue.length; i++)
		{
			HashMap tempMap = new HashMap();
			String[] temp = prevue[i].split("\u007f");
			
			tempMap.put("channelID",channelId);
			String tempDate = temp[0];
			tempMap.put("currDate",tempDate);
			String startTime = temp[1];
			tempMap.put("startTime",startTime);
			String name = temp[2];
			tempMap.put("tvodProgramName",name);
			String endTime = temp[3];
			tempMap.put("endTime",endTime);
			String tvodProgramId = temp[4];
			tempMap.put("tvodProgramId",tvodProgramId);
			String searchCode = temp[6];
			tempMap.put("searchCode",searchCode);
			
			prevueList.add(tempMap);
			
		}
		recChannelBill = JSONArray.fromObject(prevueList);
	}
	
%>

<%
if(isBug.equals("1"))
{
		System.out.println(recChannelBill);
}
if(isJson.equals("-1"))
{
%>	
var <%=varName%> = <%=recChannelBill%>;
<%
}
else
{
 response.getWriter().print(recChannelBill.toString());	 
}
%>