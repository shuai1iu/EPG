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
<%@ include file="../util/util_getPosterPaths.jsp"%>

<% 	
    //editing by ty
	//2011年10月18日 11:13:00
	MetaData metadata = new MetaData(request);
	JSONArray jsontypelist= null;
	JSONArray jsonrmdlist = null;
	JSONObject cresult = new JSONObject();
	
	String typeId = "-1";
	int countTotal = 0;
	int pagecount = 0;    //页数
	int pagesize = 12;    //每页数据量
	int curpage = Integer.parseInt(request.getParameter("curpage")==null?"1":request.getParameter("curpage"));
	String str="";
	int [] intSubjectType = {9999}; //只需要混合类型的
	int typeFlag = 2; //是否显示定制栏目 0.非定制栏目 1.定制栏目 2.所有栏目
	int contentType = 0; //子栏目视频类型
	int curindex = Integer.parseInt(request.getParameter("curindex")==null?"0":request.getParameter("curindex"));
	int pagestart = (curpage-1)*pagesize; //开始位置
	String subtypeId = "-1";
	
	if(request.getParameter("ctypeid")!=null){
	}else{		
		//获取栏目列表
		ArrayList resultList = metadata.getTypeListByTypeId(typeId,pagesize,pagestart,intSubjectType);
		if(resultList == null || resultList.size() < 2 || ((ArrayList)resultList.get(1)).size() == 0)
		{
			str ="暂无数据";
		}else{
			ArrayList typeList = (ArrayList)resultList.get(1);
			if(typeList.size()>0){
				if(curindex>=typeList.size()){
					curindex = typeList.size()-1;
				}
				HashMap tmpmap = (HashMap)typeList.get(curindex);
				subtypeId = tmpmap.get("TYPE_ID").toString();
			}
			jsontypelist = JSONArray.fromObject(typeList);
			int typeSize = typeList.isEmpty()? 0: typeList.size();
			int count = ((Integer)((HashMap)resultList.get(0)).get("COUNTTOTAL")).intValue(); //总数量
			pagecount = (count-1)/pagesize+1;
		}
	
		cresult.put("jsontypelist",jsontypelist);
		//response.getWriter().print("{'jsontypelist':'"+jsontypelist+"','jsonrmdlist':'"+jsonrmdlist+"'}");
	}
	response.getWriter().print(cresult);
	response.getWriter().flush();
	response.getWriter().close();
%>