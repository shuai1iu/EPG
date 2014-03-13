<%@ page import="java.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ include file="codepage.jsp"%>
<script language="javascript"  type="text/javascript">
var jsNewsList = new Array();
var jsImageList = new Array();
var jsNewsRecommandList = new Array();
var typeList = new Array();
var pageSize = 10;
var pageCount = 0;
var pageIndex = 1;
var totalRecord = 0;

<%
	MetaData metaData = new MetaData(request);
	
	String typeCode = request.getParameter("typeid")==null?xinwenpaihangcode:request.getParameter("typeid");
	int tmpPageSize = 0;
	int pageIndex = Integer.parseInt(request.getParameter("pageIndex"));
	int pageSize = 10;
	int pageCount = 0;
	int startRecord = (pageIndex - 1) * pageSize;
	String allNewsTypeId = "";
	ArrayList typeList = metaData.getTypeListByTypeId(typeCode,6,0);
	if(typeList != null && typeList.size() == 2)
	{
		ArrayList typeListInfo = (ArrayList)typeList.get(1);
		if(typeListInfo != null)
		{
			for(int i = 0 ; i < typeListInfo.size(); i ++)
			{
				HashMap typeHash = (HashMap)typeListInfo.get(i);
				if(i == 0)
				{
					allNewsTypeId = (String)typeHash.get("TYPE_ID");
					break;
				}
				%>
				var type = {};
				type.VodName= '<%=typeHash.get("TYPE_NAME")%>';
				type.VodId = '<%=typeHash.get("TYPE_ID")%>';
				typeList.push(type);
				
			<%}
		}
	}
	
	ArrayList resultList = metaData.getVodListByTypeId(allNewsTypeId,pageSize,startRecord); 
	
	if(resultList == null || resultList.size() < 2)
	{
		 String errorPageName = "errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=104";
 %>
 		<jsp:forward page="<%=errorPageName%>" />
 <%}%>
 
 <%
 	ArrayList detailsList = (ArrayList)resultList.get(1);
	%>
	<%
	tmpPageSize = detailsList.isEmpty()? 0: detailsList.size();
	int totalRecord = ((Integer)((HashMap)resultList.get(0)).get("COUNTTOTAL")).intValue();
	//pageCount = (totalRecord-1)/pageSize+1; 
	//pageCount = (int)Math.ceil(totalRecord/pageSize);
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
	 newsObj.VodId = "<%=vodId%>";
	 newsObj.VodName = "<%=vodName%>";
	 jsNewsList.push(newsObj);
	<%}%>
	pageSize = "<%=tmpPageSize%>";
	pageCount = "<%=pageCount%>";
	pageIndex = "<%=pageIndex%>";
	totalRecord = "<%=totalRecord%>";
	<%
		ArrayList recommandList = metaData.getRecommendVodByType(typeCode,3,0);
		if(recommandList != null && recommandList.size() == 2)
		{
			ArrayList recommandDetailList = (ArrayList) recommandList.get(1);
			if(recommandDetailList != null)
			{
				for(int i = 0 ; i < recommandDetailList.size(); i ++ )
				{
					 HashMap recommandHash = (HashMap)recommandDetailList.get(i);
					 String picPath = recommandHash.get("PICPATH").toString().trim();
					 String picId =   recommandHash.get("VODID").toString().trim();
					 String picName = recommandHash.get("VODNAME").toString().trim();
					 
					 
		%>
					var recommandObj = {};
					recommandObj.picId = "<%=picId%>";
					recommandObj.picPath = "<%=picPath%>";
					recommandObj.picName = "<%=picName%>";
					jsNewsRecommandList.push(recommandObj);
					
				<%}
			}
		}
	%>


</script>
