<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<%@ include file="../util/util_getPosterPaths.jsp" %>
<%	//update by Evans Date:2011/10/18	
	String Json ="";
	int Pageindex =  Integer.parseInt(request.getParameter("pageindex"));
	String CateID = request.getParameter("typeid");
	int PageSize = 10;
	int countTotalPage = 0;
	int countTotal = 0;
	//获取栏目下面的剧集
	String listJson="";
	MetaData metaData = new MetaData(request);
	ArrayList resultList1 =  metaData.getVodListByTypeId(CateID,PageSize,(Pageindex-1)*PageSize);
	if(resultList1 == null || resultList1.size() < 2 || ((ArrayList)resultList1.get(1)).size() == 0)
	{
	 	countTotal = 100;
	}
	else
	{
		ArrayList contentList = (ArrayList)resultList1.get(1);
		int typeSize = contentList.isEmpty()? 0: contentList.size();
		countTotal = ((Integer)((HashMap)resultList1.get(0)).get("COUNTTOTAL")).intValue();
		countTotalPage = (countTotal-1)/PageSize+1;  
		for(int i=0;i<typeSize;i++)
		{
			HashMap listCon = (HashMap)contentList.get(i);
			String vodpath = listCon.get("PICPATH").toString().trim();
			String vodId = listCon.get("VODID").toString().trim();
			
			//String vodpath="";//获取图片数据
			HashMap temp2=(HashMap)listCon.get("POSTERPATHS");  //获取当前对象的POSTERPATHS
			vodpath = getPosterPath(temp2,request,vodpath,"1");
			if(i!=0)
			{
				listJson+=",{'vodpath':'"+vodpath+"','vodId':'"+vodId+"'}";
			}
			else
			{
				listJson+="{'vodpath':'"+vodpath+"','vodId':'"+vodId+"'}";
			}
		}
	}
	Json="({'listJson':["+listJson+"],'countTotalPage':[{'value':'"+countTotalPage+"'}]})";
	response.getWriter().print(Json);
%>
