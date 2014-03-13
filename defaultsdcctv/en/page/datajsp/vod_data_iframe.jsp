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
	MetaData metadata = new MetaData(request);
	String typeid = request.getParameter("typeid")==null?"1":request.getParameter("typeid");
	
	String postertype = "5";
	int catepagecount = 1;    //页数
	int catepagesize = 12;
	int rmdpagesize = 3;
	int [] intSubjectType = {9999,10}; //只需要混合类型的
	int typeFlag = 0; //是否显示定制栏目 0.非定制栏目 1.定制栏目 2.所有栏目
	int contentType = 0; //子栏目视频类型
	
	JSONArray jsoncatelist = null; //子栏目列表
	JSONArray jsonrmdlist = null;  //推荐节目列表
	
	//获取栏目列表
	ArrayList resultList = metadata.getTypeListByTypeId(typeid,-1,0,intSubjectType,typeFlag);
	if(resultList != null && resultList.size() > 1 && ((ArrayList)resultList.get(1)).size() > 0){
		ArrayList tempList = new ArrayList();
		for(Object obj : ((ArrayList)resultList.get(1))){
			HashMap tempmap = new HashMap();
			tempmap.put("TYPE_ID",((HashMap)obj).get("TYPE_ID").toString());
			tempmap.put("TYPE_NAME",((HashMap)obj).get("TYPE_NAME").toString());
			tempList.add(tempmap);
		}
		jsoncatelist = JSONArray.fromObject(tempList);
	}

	//拼接Json
	String Json="({jsoncatelist:"+jsoncatelist+",jsonrmdlist:"+jsonrmdlist+"})";
	response.getWriter().print(Json);
%>	
