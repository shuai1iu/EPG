<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*"%> 
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>

<%
	MetaData metadata = new MetaData(request);
	String categoryCode = request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode").toString();
	String varName = request.getParameter("varName")==null?"tempCategroy":request.getParameter("varName").toString();
	String fields = request.getParameter("fields")==null?"-1":request.getParameter("fields").toString();
	String isBug = request.getParameter("isBug")==null?"-1":request.getParameter("isBug").toString();
	String isJson = request.getParameter("isJson")==null?"-1":request.getParameter("isJson").toString();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	
	HashMap typeInfo = null;
	JSONObject jsontypeInfo = null;  //栏目信息（实际为获取内容信息）
	if(!categoryCode.equals("-1"))
	{
		  HashMap tempMap = new HashMap();
		  typeInfo = metadata.getTypeInfoByTypeId(categoryCode);
	      if(typeInfo != null && typeInfo.size() > 0)
		  {
			 int isHasChild = metadata.getSubTypeOrContent(categoryCode);
			 if(fields.equals("-1") || fields.indexOf("isHasChild") != -1)
			 {
				tempMap.put("isHasChild",isHasChild);
		     }
		     tempMap.put("categoryCode",categoryCode);
			 tempMap.put("parentCategoryCode","");
		     String typeName = (String)typeInfo.get("TYPENAME");
		     if(typeName != null && !typeName.equals(""))
			 {
			      tempMap.put("name",typeName);
			 }
			 else
			 {
				tempMap.put("name","暂无名称");
			 }
				
		     String description = (String)typeInfo.get("INTRODUCE");
		     if(fields.equals("-1") || fields.indexOf("description") != -1)
			 {
			    if(description != null && !description.equals(""))
				{
				     tempMap.put("description",description);
				}else
				{
					tempMap.put("description","暂无内容");
				}
			}
		
		    String categoryType = (String)typeInfo.get("SUBJECTTYPE");
		    if(fields.equals("-1") || fields.indexOf("categoryType") != -1)
			{
			    if(categoryType != null && !categoryType.equals(""))
				{
				   tempMap.put("categoryType",categoryType);
				}
				else
				{
					tempMap.put("categoryType","-1");
				}
			}
		
		    if(fields.equals("-1") || fields.indexOf("pictureList") != -1)
			{
				HashMap postPathMap = (HashMap)typeInfo.get("POSTERPATHS");
				Iterator iterator = postPathMap.keySet().iterator();
				HashMap resultPosterMap = new HashMap();
				String poster1="";//poster
				String poster2="";//thumb
				String poster3="";//still
				if(postPathMap != null && postPathMap.size() > 0)
				{
						String[] picPathTemp = null;
						int mapLength = 0;		
						String key = null;
						  while(iterator.hasNext()) 
						  {  
								HashMap tempPicMap = new HashMap();
								key = (String)iterator.next();
								if(postPathMap.containsKey(key))
								{
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
				tempMap.put("pictureList",resultPosterMap);
			}

		jsontypeInfo=JSONObject.fromObject(tempMap);
		if(isBug.equals("1"))
		{
			System.out.println(jsontypeInfo);
		}
    }
 }
%>
<%
if(isJson.equals("-1"))
{
%>	
var <%=varName%> = <%=jsontypeInfo%>;
<%
}
else
{
 response.getWriter().print(jsontypeInfo.toString());	 
}
%>