<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>s
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ include file="../util/util_getPosterPaths.jsp"%>
<%@ include file="SubStringFunction.jsp"%>
<html>
<head>
<%
int curpage=1;
int indexid=6;
int areaid=0;
int pagecount=1;
if(request.getParameter("curpage")!=null)
{
	curpage = Integer.parseInt(request.getParameter("curpage"));
}
if(request.getParameter("indexid")!=null)
{
	indexid = Integer.parseInt(request.getParameter("indexid"));
}
if(request.getParameter("areaid")!=null)
{
	areaid = Integer.parseInt(request.getParameter("areaid"));
}
MetaData metaData = new MetaData(request);
/** 每次最多下发6数据 */
int intLength = 6;
/** 默认取数据开始位置为0 */
int intStation = 0;	// 应用的增值业务列表
List resultList = null;
ArrayList list = null;
int countTotal = 0;
boolean hasNoData = false;
intStation=(curpage-1)*6;
resultList  = metaData.getVasListByTypeId("00000100000000090000000000001041", 999, 0);
if (resultList != null && resultList.size() == 2)
{
	Map countMap1 = (HashMap)resultList.get(0);
	countTotal = ((Integer)countMap1.get("COUNTTOTAL")).intValue();
	pagecount=(int)Math.ceil(countTotal/6.0);
}


for (int i = 0; i < 1; i++)
{
	// 根据应用栏目ID查找Vas列表
	resultList  = metaData.getVasListByTypeId("00000100000000090000000000001041", intLength, intStation);
	if (resultList != null && resultList.size() == 2)
	{
		    Map countMap = (HashMap)resultList.get(0);
			countTotal = ((Integer)countMap.get("COUNTTOTAL")).intValue();
		    list = (ArrayList)resultList.get(1);
	}
	// 开始位置超过数据总数的情况下
	if (intStation >= countTotal && countTotal > 0)
    {
	        intStation = 0;
	        hasNoData = true;
	        i--;
	  }
 }
int listSize = 0;	
if (list != null)
{
        listSize = list.size();
}
 ServiceHelp serviceHelp = new ServiceHelp(request);
 HashMap map = null;
%>
<script language="javascript"  type="text/javascript">
    var countTotal = <%=countTotal%>; 
	var appList = [];
	var tempObj;
	var jsCurrPage =<%=curpage%>;
    var areaid=<%=areaid%>;
    var indexid=<%=indexid%>;  
<%
	for (int i = 0; i < listSize; i++)
	{
        map = (HashMap)list.get(i);
        String vasName = (String)map.get("VASNAME");
		if( vasName==null || vasName=="" )
		{
			continue;
		}
 
		int vasId = ((Integer)map.get("VASID")).intValue();
		Map vasInfo = metaData.getVasDetailInfo(vasId);
		String vasImage = getPosterPath((HashMap)vasInfo.get("POSTERPATHS"), "images/service/application/noappinfo.jpg", request);

		String vasCode=(String)vasInfo.get("CODE");
		// 获取增值业务的URL，如果为空将提示用户精彩节目即将播出
		String vasUrl = serviceHelp.getVasUrl(vasId);
		if (vasUrl == null || "".equals(vasUrl))
		{			
			vasUrl = "InfoDisplay.jsp?ERROR_ID=22&ERROR_TYPE=2";
		}
		
		
%>
	    tempObj = {};
		tempObj.vasId = "<%=vasId%>";
	    tempObj.appImage = "<%=vasImage%>"; 
	    tempObj.appName = "<%=vasName%>";
	    tempObj.appURL = "<%=vasUrl%>"; 
		tempObj.vasCode = "<%=vasCode%>";
	    appList.push(tempObj);
<%
	}
%>
if(appList.length==0)
{
  var tempObj1={};
  tempObj1.vasId = "0";
  tempObj1.appImage = "#"; 
  tempObj1.appName = "暂无记录暂无记录";
  tempObj1.appURL = "#"; 
  tempObj1.vasCode = "0";
  appList.push(tempObj1);
}
 window.parent.getdata(appList,pagecount);
</script>
</head>
<body>
</body>
</html>