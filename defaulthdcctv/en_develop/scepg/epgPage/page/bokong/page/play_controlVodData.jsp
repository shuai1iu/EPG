<!-- Copyright (C), pukka Tech. Co., Ltd. -->
<!-- Author:mxr -->
<!-- CreateAt:20120330 -->
<!-- FileName:play_ControleVodData.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>

<%!
	static int MAX_NUM_ONCE = 999;
%>
<%
//从session中获取关键参数
int supportHD = 0 ;
int currIndex=-1;
int totalSitNum=0;
String progId = request.getParameter("progId");
int iProgId = Integer.parseInt(progId);
String categoryCode = request.getParameter("categoryCode");
MetaData metaData = new MetaData(request);
Map vodInfoMap = null;
String preProgId = "-1";//上一个节目id
String preProgNum = "";
String nextProgId = "-1";//下一个节目id
String nextProgNum = "";
String vodName = "暂无";//本vod的名字
String preProgName="暂无";
String nextProgName="暂无";

HashMap allVodMap=new HashMap();
JSONObject  allVodJsonObject=null;
vodInfoMap = metaData.getVodDetailInfo(iProgId);
if(vodInfoMap!= null)
{	
	vodName = (String)vodInfoMap.get("VODNAME");
}	

if(!("-1".equals(categoryCode)))
{		
	currIndex=-1; //用来记录当前vod在数组中的位置	
	ArrayList resultList = metaData.getVodListByTypeId(categoryCode,MAX_NUM_ONCE,0);
	ArrayList subVodList = null;
	if(resultList != null && resultList.size() > 1)
	{
		subVodList = (ArrayList)resultList.get(1);
		allVodMap.put("vodList",subVodList);
	    allVodJsonObject=JSONObject.fromObject(allVodMap);
		
	}
	if(subVodList != null && subVodList.size() > 0)
	{
		totalSitNum = subVodList.size();
		for(int i = 0; i < totalSitNum; i++)
		{
			 Map sitVodMap = (HashMap)subVodList.get(i);
			Integer sitVodId = (Integer)sitVodMap.get("VODID");
			//如果传递进来的progId和当前的子集的ID相等
			if(sitVodId.toString().equals(progId))
			{
				currIndex = i;				
			}
		}	
		if(currIndex - 1 < 0)
		{
			preProgId = "-1";
		}
		else
		{
			Map sitVodMap = (HashMap)subVodList.get(currIndex - 1);			
			Integer sitVodId = (Integer)sitVodMap.get("VODID");
			preProgName=(String)sitVodMap.get("VODNAME");
			preProgNum=Integer.toString(currIndex-1);
			preProgId = sitVodId.toString();
		}
		if(currIndex + 1 >=  totalSitNum)
		{
			nextProgId = "-1";
		}
		else
		{
			Map sitVodMap = (HashMap)subVodList.get(currIndex + 1);
			Integer sitVodId = (Integer)sitVodMap.get("VODID");
			nextProgName=(String)sitVodMap.get("VODNAME");
			nextProgNum = Integer.toString(currIndex + 1);
			nextProgId = sitVodId.toString();
		}
		
		
		
		
	}
	

	
	
	
	
}	

/**************************对节目信息进行截取 start***********************************/

/**************************对节目信息进行截取 end***********************************/	
%>
<script>

var currVodIndex="<%=currIndex%>";
var preProgId = "<%=preProgId%>";//上一个节目id
var preProgNum = "<%=preProgNum%>";
var nextProgId = "<%=nextProgId%>";//下一个节目id
var nextProgNum = "<%=nextProgNum%>";
var vodName = "<%=vodName%>";//本vod的名字
var preProgName="<%=preProgName%>";
var nextProgName="<%=nextProgName%>";
var allVodJsonObject=<%=allVodJsonObject%>;
var totalSitNum="<%=totalSitNum%>";


function copyDataToFather()
{	
	parent.preProgId = preProgId;//上一个节目id
	parent.preProgNum = preProgNum;
	parent.nextProgId = nextProgId;//下一个节目id
	parent.nextProgNum = nextProgNum;
	parent.vodName = vodName;
	parent.preProgName=preProgName;
	parent.nextProgName=nextProgName;
	parent.allVodJsonObject=allVodJsonObject;
	parent.currVodIndex=currVodIndex;
	parent.totalSitNum=totalSitNum;
	
}
copyDataToFather();

parent.createMinEpg();

</script>