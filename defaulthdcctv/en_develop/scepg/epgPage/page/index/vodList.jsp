<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*"%> 
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>

<%
	String categoryCode = request.getParameter("categoryCode")==null?"10000100000000090000000000031172":request.getParameter("categoryCode").toString();
	String varName = request.getParameter("varName")==null?"tempCategroyList":request.getParameter("varName").toString();
	int pageIndex = Integer.parseInt(request.getParameter("pageIndex")==null?"0":request.getParameter("pageIndex"));
	int pageSize = Integer.parseInt(request.getParameter("pageSize")==null?"5":request.getParameter("pageSize"));
	String fields = request.getParameter("fields")==null?"-1":request.getParameter("fields").toString();
	int totalPage = -1;
	int curPage = -1;
	int totalSize = -1;
	String isBug = request.getParameter("isBug")==null?"-1":request.getParameter("isBug").toString();
	String isJson = request.getParameter("isJson")==null?"-1":request.getParameter("isJson").toString();
	
	MetaData metadata = new MetaData(request);
	
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
						int tempIndex = 0;
						ArrayList PicList = new ArrayList();
						
						if(postPathMap != null && postPathMap.size() > 0){
							String[] picPathTemp = null;
							int mapLength = 0;		
									
							while(iterator.hasNext()) {
								HashMap tempPicMap = new HashMap();
								if(postPathMap.containsKey(tempIndex+"")){
									mapLength = ((String[]) postPathMap.get(tempIndex+"")).length;
									picPathTemp = new String[mapLength];
									picPathTemp = (String[]) postPathMap.get(tempIndex+"");
									String tempPicStr = null;
									for(int j = 0;j < mapLength; i++){
										tempPicStr += picPathTemp[j] + ";";
										}
									tempPicMap.put("url",tempPicStr);
									tempPicMap.put("type",tempIndex+"");
									PicList.add(tempPicMap);
									tempIndex++;
									}
								}
							}
						resultMap.put("pictureList",PicList);
				}
		       fullList.add(resultMap);
		}
	   fullMap.put("vodDataList",fullList);
	   jsonVodList = JSONObject.fromObject(fullMap);
  }
%>
<%
if(isBug.equals("1"))
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
