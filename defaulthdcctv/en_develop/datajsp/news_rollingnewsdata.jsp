<%@ page import="java.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<script language="javascript"  type="text/javascript">
var jsNewsList = new Array();
var jsImageList = new Array();
var jsNewsRecommandList = new Array();
var pageSize = 10;
var pageCount = 0;
var pageIndex = 1;
var totalRecord = 0;

<%
	MetaData metaData = new MetaData(request);
	String errorPageName = "errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=104";
	String typeId = request.getParameter("typeid");
	int tmpPageSize = 0;
	int pageIndex = Integer.parseInt(request.getParameter("pageIndex"));
	int pageSize = 10;
	int pageCount = 0;
	int totalRecord = 0;
	int startRecord = (pageIndex - 1) * pageSize;
	
	ArrayList resultList = metaData.getVodListByTypeId(typeId,pageSize,startRecord); 
	if(resultList != null && resultList.size() == 2)
	{
 		ArrayList detailsList = (ArrayList)resultList.get(1);
		tmpPageSize = detailsList.isEmpty()? 0: detailsList.size();
    	totalRecord = ((Integer)((HashMap)resultList.get(0)).get("COUNTTOTAL")).intValue();
	
		if(totalRecord % pageSize == 0)
			pageCount = totalRecord  / pageSize;
		else
			pageCount = totalRecord  / pageSize + 1;
		for(int i = 0 ;i < tmpPageSize ; i ++)
		{
		 	HashMap newsHash = (HashMap)detailsList.get(i);
			 if(newsHash == null)
		 		continue;
	    	String vodName = newsHash.get("VODNAME").toString().trim();	
			String vodId = newsHash.get("VODID").toString().trim();
	 %>	
	 		var newsObj = {};
			newsObj.vodId = "<%=vodId%>";
	 		newsObj.vodName = "<%=vodName%>";
	 		jsNewsList.push(newsObj);
		<%}
	}%>
	pageSize = "<%=tmpPageSize%>";
	pageCount = "<%=pageCount%>";
	pageIndex = "<%=pageIndex%>";
	totalRecord = "<%=totalRecord%>";
</script>
