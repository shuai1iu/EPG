<%@ page import="java.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%@ page import="net.sf.json.JSONArray" %>
<script language="javascript" type="text/javascript">
var jsItemList = new Array();
var pageSize = 10.0;
var pageCount = 0;
var pageIndex = 1;
var totalRecord = 0;

<%
	MetaData metaData = new MetaData(request);
	String ptypeId = request.getParameter("typeid")==null?"00000100000000090000000000001068":request.getParameter("typeid"); //获取typeid
	
	
	int tmpPageSize = 0;
	int pageIndex = Integer.parseInt(request.getParameter("pageIndex"));
	int pageSize = 10;
	int pageCount = 0;
	int totalRecord = 0;
	int startRecord = (pageIndex - 1) * pageSize;
	ArrayList resultList = metaData.getTypeListByTypeId(ptypeId,pageSize,startRecord); 
	
	if(resultList != null && resultList.size() == 2)
	{
		 //String errorPageName = "errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=104";
 		ArrayList detailsList = (ArrayList)resultList.get(1);
		tmpPageSize = detailsList.isEmpty()? 0: detailsList.size();
	    totalRecord = ((Integer)((HashMap)resultList.get(0)).get("COUNTTOTAL")).intValue();
		//pageCount = (int)Math.ceil(totalRecord/pageSize);
		//pageCount = (totalRecord-1)/pageSize+1;
		if(totalRecord % pageSize == 0)
			pageCount = totalRecord  / pageSize;
		else
			pageCount = totalRecord  / pageSize + 1; 
		for(int i = 0 ;i < detailsList.size() ; i ++)
		{
			 	HashMap itemHash = (HashMap)detailsList.get(i);
		 		if(itemHash == null)
		 		continue;
	   			String typeName = itemHash.get("TYPE_NAME").toString().trim();	
				String typeId = itemHash.get("TYPE_ID").toString().trim();
	 	%>	
				 var itemObj = {};
	 			 itemObj.typeId = "<%=typeId%>";
	 			 itemObj.typeName = "<%=typeName%>";
	             jsItemList.push(itemObj);
		<%}
		}%>

	pageSize = "<%=tmpPageSize%>";
	pageCount = "<%=pageCount%>";
	pageIndex = "<%=pageIndex%>";
	totalRecord = "<%=totalRecord%>";
</script>
