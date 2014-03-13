<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="../util/util_getPosterPaths.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>


<script>
<%
////////////////////////////////////////////////
	MetaData metadata = new MetaData(request);
	ArrayList typeList = (ArrayList)metadata.getVodListByTypeId(testcode1,-1,0);
	ArrayList newresultList=new ArrayList();
	String picPath = "";
	if(typeList!=null&&typeList.size()>1){
		ArrayList resultList = (ArrayList)typeList.get(1);
		if(resultList != null){
			for(int i = 0 ;i < resultList.size(); i ++){
				HashMap map = (HashMap)resultList.get(i);
					HashMap posterPathMap = (HashMap)map.get("POSTERPATHS");	
					HashMap mapnew = new HashMap();
					
					HashMap tmptype=new HashMap();
					if(!posterPathMap.isEmpty()){
						Iterator iter = posterPathMap.entrySet().iterator(); 
						while (iter.hasNext()) { 
								Map.Entry entry = (Map.Entry) iter.next(); 
								Object key = entry.getKey(); 
								Object val = getPosterPath(posterPathMap,request,picPath,"1").toString();
								tmptype.put("type"+key,val);
						} 	
					}
					mapnew.put("POSTERPATHS",tmptype);
					newresultList.add(mapnew);
					
					//HashMap testMap = (HashMap)newresultList.get(i);
					//System.out.println(testMap.get("POSTERPATHS"));
					//System.out.println("size:" + newresultList.size());
			}
		}
	}
////////////////////////////////////////////////

%>
</script>
