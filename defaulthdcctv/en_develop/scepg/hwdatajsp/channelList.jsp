<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*"%> 
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>

<%
	String categoryCode = request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode").toString();
	String varName = request.getParameter("varName")==null?"tempChannelList":request.getParameter("varName").toString();
	int pageIndex = Integer.parseInt(request.getParameter("pageIndex")==null?"1":request.getParameter("pageIndex"));
	int pageSize = Integer.parseInt(request.getParameter("pageSize")==null?"5":request.getParameter("pageSize"));
	String fields = request.getParameter("fields")==null?"-1":request.getParameter("fields").toString();
	
	int totalPage = -1;
	int curPage = -1;
	int totalSize = -1;
	String isBug = request.getParameter("isBug")==null?"-1":request.getParameter("isBug").toString();
	String isJson = request.getParameter("isJson")==null?"-1":request.getParameter("isJson").toString();
	
	MetaData metadata = new MetaData(request);
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	
	ArrayList channelList = metadata.getChanListByTypeId(categoryCode,pageSize,(pageIndex - 1) * pageSize);

	HashMap fullChanMap = new HashMap();
	ArrayList fullChanList = new ArrayList();
	JSONObject jsonChanList = null;

	if(channelList != null && channelList.size() > 1 && ((ArrayList)channelList.get(1)).size() > 0)
	{
		HashMap tempChanMap = (HashMap)channelList.get(0);
		totalSize =(Integer)tempChanMap.get("COUNTTOTAL");
		curPage = pageIndex;
		totalPage = (totalSize+pageSize-1) / pageSize;
		fullChanMap.put("totalSize",totalSize);
		fullChanMap.put("curPage",curPage);
		fullChanMap.put("totalPage",totalPage);
		ArrayList tempChanList = (ArrayList)channelList.get(1);
		for(int i = 0;i < tempChanList.size(); i++)
		{
			HashMap tempMap = (HashMap)tempChanList.get(i);
			HashMap resultMap = new HashMap();
			String channelID = tempMap.get("CHANNELID").toString();
			resultMap.put("channelID",channelID);
			String channelName = tempMap.get("CHANNELNAME").toString();
			if(fields.equals("-1") || fields.indexOf("channelName") != -1)
			{
				if(channelName != null && !channelName.equals(""))
				{
					resultMap.put("channelName",channelName);
				}
				else
				{
					resultMap.put("channelName","暂无名称");
				}
			}
			
			String channelIndex = tempMap.get("CHANNELINDEX").toString();
			if(fields.equals("-1") || fields.indexOf("channelIndex") != -1)
			{
				if(channelIndex != null && !channelIndex.equals(""))
				{
					resultMap.put("channelIndex",channelIndex);
				}
				else
				{
					resultMap.put("channelIndex","-1");
				}
			}	
			String definition = tempMap.get("DEFINITION").toString();
			if(fields.equals("-1") || fields.indexOf("definition") != -1)
			{
				if(definition != null && !definition.equals(""))
				{
					resultMap.put("definition",definition);
				}
			}
			
			String channelType = tempMap.get("CHANNELTYPE").toString();
			if(fields.equals("-1") || fields.indexOf("channelType") != -1)
			{
				if(channelType != null && !channelType.equals(""))
				{
					resultMap.put("channelType",channelType);
				}
				else
				{
					resultMap.put("channelType","-1");
				}
			}
			String isNVOD = tempMap.get("ISNVOD").toString();
			if(fields.equals("-1") || fields.indexOf("isNVOD") != -1)
			{
				if(isNVOD != null && !isNVOD.equals(""))
				{
					resultMap.put("isNVOD",isNVOD);
				}
				else
				{
					resultMap.put("isNVOD","-1");
				}
			}
			String isPltv = tempMap.get("ISPLTV").toString();
			if(fields.equals("-1") || fields.indexOf("isPLTV") != -1)
			{
				if(isPltv != null && !isPltv.equals(""))
				{
					resultMap.put("isPLTV",isPltv);
				}
				else
				{
					resultMap.put("isPLTV","-1");
				}
			}
			String isTvod = tempMap.get("ISTVOD").toString();
			if(fields.equals("-1") || fields.indexOf("isTVOD") != -1)
			{
				if(isTvod != null && !isTvod.equals(""))
				{
					resultMap.put("isTVOD",isTvod);
				}
				else
				{
					resultMap.put("isTVOD","-1");
				}
			}
			fullChanList.add(resultMap);
		}
	fullChanMap.put("channelDataList",fullChanList);
	jsonChanList = JSONObject.fromObject(fullChanMap);
	}
	
%>

<%
if(isBug.equals("1"))
{
		System.out.println(jsonChanList);
}
if(isJson.equals("-1"))
{
%>	
var <%=varName%> = <%=jsonChanList%>;
<%
}
else
{
 response.getWriter().print(jsonChanList.toString());	 
}
%>