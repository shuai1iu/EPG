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
<%
	MetaData metadata = new MetaData(request);
	
	String typeid= request.getParameter("typeid")==null?"-1":request.getParameter("typeid");
	
	int[] intSubjectType = {9999};
	
	JSONArray jsonvodlist = null;
	
	int isSubTypeOrContent = metadata.getSubTypeOrContent(typeid); //获取下级栏目类型（0.内容，1.栏目）
	if(isSubTypeOrContent==0){
		ArrayList vodresultlist = (ArrayList)metadata.getVodListByTypeId(typeid,-1,0);
		if(vodresultlist!=null && vodresultlist.size() > 1 && ((ArrayList)vodresultlist.get(1)).size() > 0){
			ArrayList tempList = new ArrayList();
			for(Object obj : ((ArrayList)vodresultlist.get(1))){
				HashMap tempmap = new HashMap();
				String tmptypeid = ((HashMap)obj).get("VODID").toString();
				String tmptypename = ((HashMap)obj).get("VODNAME").toString();
				tempmap.put("VODID",tmptypeid);	
				tempmap.put("VODNAME",tmptypename);		
				tempList.add(tempmap);
			}
			jsonvodlist = JSONArray.fromObject(tempList);
		}
	}else if(isSubTypeOrContent==1){
		ArrayList typeresultList = metadata.getTypeListByTypeId(typeid,-1,0,intSubjectType);
		if(typeresultList != null && typeresultList.size() > 1 && ((ArrayList)typeresultList.get(1)).size() > 0){
			ArrayList tempList = new ArrayList();
			for(int i = 0;i<((ArrayList)typeresultList.get(1)).size();i++){	
				HashMap tempmap = new HashMap();
				Object obj = ((ArrayList)typeresultList.get(1)).get(i);
				tempmap.put("TYPE_ID",((HashMap)obj).get("TYPE_ID").toString());
				tempmap.put("TYPE_NAME",((HashMap)obj).get("TYPE_NAME").toString());		
				tempList.add(tempmap);		
			}
			jsonvodlist = JSONArray.fromObject(tempList);
		}
	}
	response.getWriter().print(jsonvodlist);
%>	
