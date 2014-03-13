<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*"%> 
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>

<%
	String parentCategoryCode = request.getParameter("parentCategoryCode")==null?"-1":request.getParameter("parentCategoryCode").toString();
	System.out.println("PKITDATA -------------------  CATAGROYCODE"+parentCategoryCode);
	
	String varName = request.getParameter("varName")==null?"tempCategroyList":request.getParameter("varName").toString();
	int pageIndex = Integer.parseInt(request.getParameter("pageIndex")==null?"1":request.getParameter("pageIndex"));
	int pageSize = Integer.parseInt(request.getParameter("pageSize")==null?"5":request.getParameter("pageSize"));
	String fields = request.getParameter("fields")==null?"-1":request.getParameter("fields").toString();
	String isBug = request.getParameter("isBug")==null?"-1":request.getParameter("isBug").toString();
	String isJson = request.getParameter("isJson")==null?"-1":request.getParameter("isJson").toString();
	System.out.println("PKITDATA -------------------  ISBUG  - -- "+isBug);
	int totalPage = -1;
	int curPage = -1;
	int totalSize = -1;
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	
	MetaData metadata = new MetaData(request);
	
	ArrayList ResultList = metadata.getTypeListByTypeId(parentCategoryCode,pageSize,(pageIndex - 1) * pageSize);
	ArrayList fullTypeList = new ArrayList();
	HashMap fullMap = new HashMap();
	JSONObject jsontypeList = null; 
	System.out.println("PKITDATA -------------------  SIZE -- "+ResultList.size());
	if(ResultList != null && ResultList.size() > 1 && ((ArrayList)ResultList.get(1)).size() > 0)
	{
	System.out.println("PKITDATA -------------------  SIZE -2 - -- "+((ArrayList)ResultList.get(1)).size());
		HashMap totalMap = (HashMap)ResultList.get(0);
		totalSize = Integer.parseInt(totalMap.get("COUNTTOTAL").toString());
		curPage = pageIndex;
		totalPage = (totalSize+pageSize-1) / pageSize;
		
		fullMap.put("totalSize",totalSize);
		fullMap.put("curPage",curPage);
		fullMap.put("totalPage",totalPage);
		
		ArrayList ParseResultList = (ArrayList)ResultList.get(1);
		for(int i=0;i<ParseResultList.size();i++){
			HashMap tempMap = (HashMap)ParseResultList.get(i);	
			HashMap resultMap = new HashMap();
			resultMap.put("parentCategoryCode",parentCategoryCode);
			String introduce = (String)tempMap.get("TYPE_INTRODUCE");
			String typeName = (String)tempMap.get("TYPE_NAME");
			System.out.println("PKITDATA -------------------  NAME  - -- "+typeName);
			String categoryType = tempMap.get("SUBJECT_TYPE").toString();
			resultMap.put("categoryCode",(String)tempMap.get("TYPE_ID"));
			int isHasChild = metadata.getSubTypeOrContent((String)tempMap.get("TYPE_ID"));
			if(typeName != null && !typeName.equals("")){
				resultMap.put("name",typeName);
				}else{
					resultMap.put("name","暂无名称");
					}
					
				if(fields.equals("-1") || fields.indexOf("description") != -1){
					if(introduce != null && !introduce.equals("")){
						resultMap.put("description",introduce);
						}else{
							resultMap.put("description","暂无内容");
							}
					}
				if(fields.equals("-1") || fields.indexOf("categoryType") != -1){
					if(categoryType != null && !categoryType.equals("")){
						resultMap.put("categoryType",categoryType);
						}else{
							resultMap.put("categoryType","-1");
							}
					}
				if(fields.equals("-1") || fields.indexOf("isHasChild") != -1){
					resultMap.put("isHasChild",isHasChild);
					}
				if(fields.equals("-1") || fields.indexOf("pictureList") != -1){
					HashMap postPathMap = (HashMap)tempMap.get("POSTERPATHS");
					Iterator iterator = postPathMap.keySet().iterator();
					HashMap resultPosterMap = new HashMap();
					String poster1="";//poster
					String poster2="";//thumb
				    String poster3="";//still
					System.out.println("PKITDATA -------------------  PATHSIZE -- "+postPathMap.size());
					if(postPathMap != null && postPathMap.size() > 0){
						String[] picPathTemp = null;
						int mapLength = 0;		
						String key = null;
						while(iterator.hasNext()) {
							     HashMap tempPicMap = new HashMap();
							     key = (String)iterator.next();
								 if(postPathMap.containsKey(key)){
										mapLength = ((String[]) postPathMap.get(key)).length;
										picPathTemp = new String[mapLength];
										picPathTemp = (String[]) postPathMap.get(key);
										for(int m = 0;m < mapLength; m++){
												String targetPath = picPathTemp[m].replace("../../",basePath+"/EPG/jsp"+"/");
												picPathTemp[m]=targetPath;
											}
										System.out.println("PKITDATA -------------------  PATH -- "+picPathTemp);  
										if(key.equals("0")){
											if(picPathTemp.length>0)
											poster2=picPathTemp[0];
										}
										if(key.equals("1")){
											 if(picPathTemp.length>0)
											 poster1=picPathTemp[0];
										}
										if(key.equals("2")){
											 if(picPathTemp.length>0)
											 poster3=picPathTemp[0];
										}
									
									}
							}
					}
					resultPosterMap.put("poster",poster1);
					resultPosterMap.put("thumb",poster2);
					resultPosterMap.put("still",poster3);	
					resultMap.put("pictureList",resultPosterMap);
			  }
			
			fullTypeList.add(resultMap);	
	   }
  }
  fullMap.put("categoryList",fullTypeList);
  jsontypeList = JSONObject.fromObject(fullMap);
  request.setAttribute(varName,jsontypeList);
%>

<%
if(isBug.equals("1"))
{
		System.out.println(jsontypeList);
}
if(isJson.equals("-1"))
{
%>	
var <%=varName%> = <%=jsontypeList%>;
<%
}
else
{
 response.getWriter().print(jsontypeList.toString());	 
}
%>