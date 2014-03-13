<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%
	 String keyword = request.getParameter("keyword");
	 
	 JSONArray jsonSearchResult = null; //搜索结果
	 int resultpagecount = 1;
	 int pagesize = 6;
	 int isSubVod = 1;
	 
	 if(keyword!=null){
		ServiceHelp svcHelp = new ServiceHelp(request);
	 	List searchlist = svcHelp.searchFilmsByCode(keyword,0,-1,isSubVod);
		if(searchlist!=null&&searchlist.size()>1){
			int count = ((Integer)((HashMap)searchlist.get(0)).get("COUNTTOTAL")).intValue(); //总数量
	    	resultpagecount = (count-1)/pagesize+1;
			ArrayList searchresultlist = (ArrayList)searchlist.get(1);
			if(searchresultlist!=null){
				ArrayList tempSearchresult = new ArrayList();
				for(int i=0,l=searchresultlist.size();i<l;i++){
					HashMap tempMap = new HashMap();
					tempMap.put("vodName",((HashMap)searchresultlist.get(i)).get("vodName"));
					tempMap.put("vodId",((HashMap)searchresultlist.get(i)).get("vodId"));
					tempSearchresult.add(tempMap);
				}
				jsonSearchResult = JSONArray.fromObject(tempSearchresult);
			}
		}
	 }
	 
	 response.getWriter().print("{jSearchResult:"+jsonSearchResult+",resultpagecount:"+resultpagecount+"}");
%>