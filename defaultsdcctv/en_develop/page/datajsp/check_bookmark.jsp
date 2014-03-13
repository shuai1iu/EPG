<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file = "query_IsHasBookMark.jsp"%>


<%
	//String[] allTypeId 父栏目ID
	JSONObject cresult = new JSONObject();
	Integer vodid = request.getParameter("vodid")==null?1:Integer.parseInt(request.getParameter("vodid"));	
	
	//editing by ty 2011年11月25日 14:52:00
	MetaData metadata = new MetaData(request);
	HashMap mediadetailInfo = (HashMap)metadata.getVodDetailInfo(vodid);
	boolean isSitcom = true;//是否为连续剧
	if(mediadetailInfo!=null){
		isSitcom = !("0".equals(mediadetailInfo.get("ISSITCOM").toString()));
	}
	
	//获取是否有书签
	if(!isSitcom){
		HashMap isbm_result = isHasBookMark(vodid.toString(),request);
		Boolean isbookmark = new Boolean("False");  //是否包含书签
		String begintime = "";  //开始时间
		String endtime = "";    //结束时间
		if(isbm_result!=null){
			isbookmark = new Boolean(isbm_result.get("ISBOOKMARK").toString());
			begintime = isbm_result.get("BEGINTIME").toString();
			endtime = isbm_result.get("ENDTIME").toString();
		}
		cresult.put("isbookmark",isbookmark);
		cresult.put("begintime",begintime);
		cresult.put("endtime",endtime);
	}else{
		cresult.put("isbookmark",false);
	}
	cresult.put("isSitcom",isSitcom);
	response.getWriter().print(cresult);
%>