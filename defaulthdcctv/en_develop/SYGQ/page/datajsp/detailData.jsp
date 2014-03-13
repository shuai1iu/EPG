<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file = "query_IsHasBookMark.jsp"%>
<%@ include file="../util/util_getPosterPaths.jsp"%>
<script>
<%
	MetaData metadata = new MetaData(request);
	String postertype = "1";
	int progid = request.getParameter("vodid")==null?1:Integer.parseInt(request.getParameter("vodid"));
	String typeid = request.getParameter("typeid")==null?"":request.getParameter("typeid").toString();
	JSONObject jsoncontentInfo = null;
	HashMap mediadetailInfo = (HashMap)metadata.getVodDetailInfo(progid);
	HashMap voddetailInfo = new HashMap();
	if(mediadetailInfo!=null){
		int isStitcom = (Integer)mediadetailInfo.get("ISSITCOM");
		int contentType = (Integer)mediadetailInfo.get("CONTENTTYPE");
		int vodid = (Integer)mediadetailInfo.get("VODID");
		int assessid = (Integer)mediadetailInfo.get("ASSESSID");
		int isAssess = (Integer)mediadetailInfo.get("ISASSESS");
		String vodName = (String)mediadetailInfo.get("VODNAME");
		HashMap postersMap = (HashMap)mediadetailInfo.get("POSTERPATHS");
		String director = (String)mediadetailInfo.get("DIRECTOR");
		String introduce = (String)mediadetailInfo.get("INTRODUCE");
		String picpath = (String)mediadetailInfo.get("PICPATH");
		String postpath = getPosterPath(postersMap,request,picpath,postertype).toString();
		voddetailInfo.put("POSTPATH","../"+postpath);
		voddetailInfo.put("PICPATH","../"+picpath);
		voddetailInfo.put("DIRECTOR",director);
		voddetailInfo.put("INTRODUCE",introduce);
		voddetailInfo.put("ISSITCOM",isStitcom);
		voddetailInfo.put("CONTENTTYPE",contentType);
		voddetailInfo.put("VODID",vodid);
		voddetailInfo.put("VODNAME",vodName);
		voddetailInfo.put("ISASSESS",isAssess);
		voddetailInfo.put("ASSESSID",assessid);
		HashMap castMap = (HashMap)mediadetailInfo.get("CASTMAP");	
		if(castMap!=null&&castMap.get(6)!=null)
		{
			String[] tempCasts = (String[])castMap.get(6);
			StringBuffer actor = new StringBuffer();
			for(String str : tempCasts){
				actor.append(","+str.trim());
			}
			voddetailInfo.put("ACTOR","".equals(actor.toString())?null:actor.toString().substring(1));		
		}
		if(isStitcom == 1)
		{
			ArrayList subVodIdList = (ArrayList)mediadetailInfo.get("SUBVODIDLIST");
			ArrayList subVodNumList = (ArrayList)mediadetailInfo.get("SUBVODNUMLIST");
			voddetailInfo.put("SUBVODIDLIST",subVodIdList);
			voddetailInfo.put("SUBVODNUMLIST",subVodNumList);
		}
		else
		{
			HashMap isbm_result = isHasBookMark(((Integer)mediadetailInfo.get("VODID")).toString(),request);
			Boolean isbookmark = new Boolean("False");  //是否包含书签
			String begintime = "";  //开始时间
			String endtime = "";    //结束时间
			if(isbm_result!=null){
				isbookmark = new Boolean(isbm_result.get("ISBOOKMARK").toString());
				begintime = isbm_result.get("BEGINTIME").toString();
				endtime = isbm_result.get("ENDTIME").toString();
			}
			voddetailInfo.put("ISBOOKMARK",isbookmark);
			voddetailInfo.put("BEGINTIME",begintime);
			voddetailInfo.put("ENDTIME",endtime);
		}
		jsoncontentInfo = JSONObject.fromObject(voddetailInfo);	 //转化为JSON对象
	}
%>
var mediadetailInfo = <%=jsoncontentInfo%>;
</script>