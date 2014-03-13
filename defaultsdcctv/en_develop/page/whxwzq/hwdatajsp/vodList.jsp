<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*"%> 
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>

<%
	String categoryCode = request.getParameter("categoryCode")==null?"10000100000000090000000000031172":request.getParameter("categoryCode").toString();
	String varName = request.getParameter("varName")==null?"tempVODList":request.getParameter("varName").toString();
	int pageIndex = Integer.parseInt(request.getParameter("pageIndex")==null?"1":request.getParameter("pageIndex"));
	int pageSize = Integer.parseInt(request.getParameter("pageSize")==null?"5":request.getParameter("pageSize"));
	String fields = request.getParameter("fields")==null?"-1":request.getParameter("fields").toString();
	int totalPage = -1;
	int curPage = -1;
	int totalSize = -1;
	String isBug = request.getParameter("isBug")==null?"-1":request.getParameter("isBug").toString();
	String isJson = request.getParameter("isJson")==null?"-1":request.getParameter("isJson").toString();
	
	MetaData metadata = new MetaData(request);
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	
	ArrayList ResultList = metadata.getVodListByTypeId(categoryCode,pageSize,(pageIndex - 1) * pageSize);
	
	HashMap fullMap = new HashMap();
	ArrayList fullList = new ArrayList();
	JSONObject jsonVodList = null;
	
	if(ResultList != null && ResultList.size() > 1 && ((ArrayList)ResultList.get(1)).size() > 0)
	{
		HashMap totalMap = (HashMap)ResultList.get(0);
		totalSize = Integer.parseInt(totalMap.get("COUNTTOTAL").toString());
		curPage = pageIndex;
		totalPage = (totalSize+pageSize-1) / pageSize;
		
		fullMap.put("totalSize",totalSize);
		fullMap.put("curPage",curPage);
		fullMap.put("totalPage",totalPage);
		
		ArrayList ParseResultList = (ArrayList)ResultList.get(1);
		for(int i = 0; i < ParseResultList.size(); i++)
		{
				HashMap tempMap = (HashMap)ParseResultList.get(i);	
				HashMap resultMap = new HashMap();
				
				resultMap.put("categoryCode",categoryCode);
				resultMap.put("programCode",tempMap.get("VODID").toString());
				int vodID = Integer.parseInt(tempMap.get("VODID").toString());
				HashMap vodMap = (HashMap)metadata.getVodDetailInfo(vodID);
				int issitcom = Integer.parseInt(vodMap.get("ISSITCOM").toString());
				String tempContentCode = vodMap.get("CODE").toString();
				
				if(fields.equals("-1") || fields.indexOf("contentCode") != -1)
				{
					if(tempContentCode != null && !tempContentCode.equals(""))
					{
						resultMap.put("contentCode",tempContentCode);
					}
					else
					{
						resultMap.put("contentCode","-1");
					}
				}
				
				if(fields.equals("-1") || fields.indexOf("programType") != -1)
				{
					if(issitcom == 0)
					{
						resultMap.put("programType","1");
					}
					else if(issitcom == 1)
					{
						resultMap.put("programType","14");
					}
					else
					{
						resultMap.put("programType","-1");
					}
				}
				
				String vodName = tempMap.get("VODNAME").toString();
				if(fields.equals("-1") || fields.indexOf("name") != -1)
				{
					if(vodName != null && !vodName.equals(""))
					{
						resultMap.put("name",vodName);
					}
					else
					{
						resultMap.put("name","暂无名称");
					}
				}
			
				String introduce = tempMap.get("INTRODUCE").toString();
				if(fields.equals("-1") || fields.indexOf("description") != -1)
				{
					if(introduce != null && !introduce.equals(""))
					{
						resultMap.put("description",introduce);
					}
					else
					{
						resultMap.put("description","暂无内容");
					}
				}
			
				String definition = tempMap.get("DEFINITION").toString();
				if(fields.equals("-1") || fields.indexOf("definition") != -1)
				{
					if(definition != null && !definition.equals(""))
					{
						resultMap.put("definition",definition);
					}
					else
					{
						resultMap.put("definition","-1");
					}
				}
			
				if(fields.equals("-1") || fields.indexOf("pictureList") != -1)
				{
					HashMap postPathMap = (HashMap)tempMap.get("POSTERPATHS");
					Iterator iterator = postPathMap.keySet().iterator();
					HashMap resultPosterMap = new HashMap();
					String poster1="";//poster
					String poster2="";//thumb
					String poster3="";//still
						
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
		       fullList.add(resultMap);
		}
	   fullMap.put("vodDataList",fullList);
	   jsonVodList = JSONObject.fromObject(fullMap);
	   request.setAttribute(varName,jsonVodList);
  }
%>
<%
if(isBug.equals("-1"))
{
	System.out.println(jsonVodList);
}
if(isJson.equals("-1"))
{
%>	
var <%=varName%> = <%=jsonVodList%>;
<%
}
else
{
 response.getWriter().print(jsonVodList.toString());	 
}
%>
