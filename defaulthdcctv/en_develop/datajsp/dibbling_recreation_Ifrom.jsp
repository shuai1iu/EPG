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
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>

<%@ include file="../util/util_getPosterPaths.jsp" %>
<%

	String subtypeStr = "10000100000000090000000000039676;10000100000000090000000000039677;10000100000000090000000000023718;00000100000000090000000000016919;00000100000000090000000000016920;10000100000000090000000000024253;10000100000000090000000000024252";
	String Json ="";
	int PageSize = 6;
	int countTotalPage = 0;
	int countTotal = 0;
	String CateFrist = request.getParameter("cateid");
	int pageindex =  Integer.parseInt(request.getParameter("pageindex"));
	MetaData metaData = new MetaData(request);
    int[] intSubjectType = {9999};
	int star = (pageindex-1)*PageSize;
	String listJson="";//数据的解析
	
				
	//获取栏目下面的剧集
	int subtype = metaData.getSubTypeOrContent(CateFrist); //判断下级是栏目还是内容 1.栏目 0.内容 0x07010000.空
	if(subtype==1)
	{
		PageSize = 6;
		star = (pageindex-1)*PageSize;
		ArrayList resultList1 = metaData.getTypeListByTypeId(CateFrist,PageSize,star,intSubjectType);
		if(resultList1 == null || resultList1.size() < 2 || ((ArrayList)resultList1.get(1)).size() == 0)
		{
			countTotal=100;
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
				String vodpath = listCon.get("TYPE_PICPATH").toString().trim();
				String vodId = listCon.get("TYPE_ID").toString().trim();
				String vodNames = listCon.get("TYPE_NAME").toString().trim();
				//获取图片
				HashMap temp2=(HashMap)listCon.get("POSTERPATHS");  //获取当前对象的POSTERPATHS
				vodpath = getPosterPath(temp2,request,vodpath,"2");
				if(i!=0)
				{
					listJson+=",{'vodpath':'"+vodpath+"','vodId':'"+vodId+"','vodName':'"+vodNames+"'}";
				}
				else
				{
					listJson+="{'vodpath':'"+vodpath+"','vodId':'"+vodId+"','vodName':'"+vodNames+"'}";
				}
			}
		}
	}
	else if(subtype==0)
	{
		if(subtypeStr.indexOf(CateFrist)!=-1){
			PageSize = 10;
		}else{
			PageSize = 6;
		}
		star = (pageindex-1)*PageSize;
		ArrayList resultList2 = metaData.getVodListByTypeId(CateFrist,PageSize,star);
		if(resultList2 == null || resultList2.size() < 2 || ((ArrayList)resultList2.get(1)).size() == 0)
		{
			countTotal = 100;
		}
		else
		{
			ArrayList contentList = (ArrayList)resultList2.get(1);
			int typeSize = contentList.isEmpty()? 0: contentList.size();
			countTotal = ((Integer)((HashMap)resultList2.get(0)).get("COUNTTOTAL")).intValue();
			countTotalPage = (countTotal-1)/PageSize+1;
			for(int i=0;i<typeSize;i++)
			{
				HashMap listCon = (HashMap)contentList.get(i);
				String vodpath = listCon.get("PICPATH").toString().trim();
				String vodId = listCon.get("VODID").toString().trim();
				String vodNames = listCon.get("VODNAME").toString().trim();
				
				//获取图片
				HashMap temp2=(HashMap)listCon.get("POSTERPATHS");  //获取当前对象的POSTERPATHS
				vodpath = getPosterPath(temp2,request,vodpath,"1","2");
				if(i!=0)
				{
					listJson+=",{'vodpath':'"+vodpath+"','vodId':'"+vodId+"','vodName':'"+vodNames+"'}";
				}
				else
				{
					listJson+="{'vodpath':'"+vodpath+"','vodId':'"+vodId+"','vodName':'"+vodNames+"'}";
				}
			}
		}
	}
	else if(subtype==0x07010000)
	{
					//空
	}
	//拼接Json
	Json="({'listJson':["+listJson+"],'countTotalPage':[{'value':'"+countTotalPage+"'}],'subtype':[{'value':'"+subtype+"'}],'PageSize':"+PageSize+"})";
	response.getWriter().print(Json);
%>	
