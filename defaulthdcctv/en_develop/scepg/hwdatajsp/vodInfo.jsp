<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*"%> 
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>

<%
	MetaData metadata = new MetaData(request);
	int programCode = Integer.parseInt(request.getParameter("programCode")==null?"-1":request.getParameter("programCode"));
	String contentCode = request.getParameter("contentCode")==null?"-1":request.getParameter("contentCode");
	String  categoryCode = request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode");
	
	String varName = request.getParameter("varName")==null?"tempVODInfo":request.getParameter("varName");
	String fields = request.getParameter("fields")==null?"-1":request.getParameter("fields");
	String isBug = request.getParameter("isBug")==null?"-1":request.getParameter("isBug").toString();
	String isJson = request.getParameter("isJson")==null?"-1":request.getParameter("isJson").toString();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	
	HashMap vodInfo = new HashMap();
	JSONObject jsonVodInfo = null;  //节目信息（实际为获取内容信息）
	vodInfo = (HashMap)metadata.getVodDetailInfo(programCode);
	if(vodInfo != null && vodInfo.size() > 0){
		HashMap tempMap = new HashMap();
		tempMap.put("programCode",vodInfo.get("VODID").toString());
		tempMap.put("categoryCode","");
		String code = vodInfo.get("CODE").toString();
		if(fields.equals("-1") || fields.indexOf("contentCode") != -1)
		{
			if(code != null && !code.equals(""))
			{
				tempMap.put("contentCode",code);
			}
			else
			{
				tempMap.put("contentCode","-1");
			}
		}
		String vodName = vodInfo.get("VODNAME").toString();
	    if(vodName != null && !vodName.equals(""))
		{
			tempMap.put("name",vodName);
		}
		else
		{
			tempMap.put("name","暂无名称");
		}
		if(fields.equals("-1") || fields.indexOf("actorDisplay") != -1){
			String actor = (String)vodInfo.get("ACTOR");
			if(actor != null && !actor.equals("")){
				    tempMap.put("actorDisplay",actor);
			}else{
					tempMap.put("actorDisplay","暂无信息");
			}
		}
		if(fields.equals("-1") || fields.indexOf("directDisplay") != -1){
			String direct = (String)vodInfo.get("DIRECTOR");
			if(direct != null && !direct.equals(""))
			{
				    tempMap.put("directDisplay",direct);
			}
			else
			{
					tempMap.put("directDisplay","暂无信息");
			}
		}
		if(fields.equals("-1") || fields.indexOf("description") != -1)
		{
			String introduce = vodInfo.get("INTRODUCE").toString();
			if(introduce != null && !introduce.equals(""))
			{
				    tempMap.put("description",introduce);
			}
			else
			{
					tempMap.put("description","暂无内容");
			}
		}
		if(fields.equals("-1") || fields.indexOf("price") != -1)
		{
			String price = vodInfo.get("VODPRICE").toString();
			if(price != null && !price.equals(""))
			{
				    tempMap.put("price",price);
			}
			else
			{
					tempMap.put("price","暂无价格");
			}
		}
		if(fields.equals("-1") || fields.indexOf("length") != -1){
			String elapseTime = vodInfo.get("ELAPSETIME").toString();
			if(elapseTime != null && !elapseTime.equals(""))
			{
				    tempMap.put("length",elapseTime);
			}
			else
			{
					tempMap.put("length","暂无片长");
			}
		}
		if(fields.equals("-1") || fields.indexOf("definition") != -1){
			String definition = vodInfo.get("DEFINITION").toString();
			if(definition != null && !definition.equals(""))
			{
				    tempMap.put("definition",definition);
			}
			else
			{
					tempMap.put("definition","-1");
			}
		}
		if(fields.equals("-1") || fields.indexOf("pictureList") != -1){
				HashMap postPathMap = (HashMap)vodInfo.get("POSTERPATHS");
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
				tempMap.put("pictureList",resultPosterMap);
		}
		if(fields.equals("-1") || fields.indexOf("subVodList") != -1){
			ArrayList subVodIdList = (ArrayList)vodInfo.get("SUBVODIDLIST");
			ArrayList subVodNumList = (ArrayList)vodInfo.get("SUBVODNUMLIST");
			ArrayList subVODList = new ArrayList();
			if(subVodIdList != null && subVodIdList.size() > 0){
				for(int i = 0; i < subVodIdList.size(); i++){
					HashMap tempVodMap = new HashMap();
					String tempIDStr = subVodIdList.get(i).toString();
					String tempNumStr = subVodNumList.get(i).toString();
					HashMap subvodInfo = (HashMap)metadata.getVodDetailInfo(Integer.parseInt(tempIDStr));
					String submediacode = subvodInfo.get("CODE").toString();
					
					tempVodMap.put("programCode",tempIDStr);
					tempVodMap.put("contentCode",submediacode);
					tempVodMap.put("num",tempNumStr);
					subVODList.add(tempVodMap);
					}
				}
			tempMap.put("subVodList",subVODList);
		}
		if(fields.equals("-1") || fields.indexOf("programType") != -1)
		{
		    int programType = Integer.parseInt(vodInfo.get("ISSITCOM").toString());
			if(programType == 0)
			{
				tempMap.put("programType","1");
			}
			else if(programType == 1)
			{
				tempMap.put("programType","14");
			}
			else
			{
				tempMap.put("programType","-1");
			}
	    }
	  jsonVodInfo = JSONObject.fromObject(tempMap);
  }
%>
<%
if(isBug.equals("1"))
{
	System.out.println(jsonVodInfo);
}
if(isJson.equals("-1"))
{
%>	
var <%=varName%> = <%=jsonVodInfo%>;
<%
}
else
{
 response.getWriter().print(jsonVodInfo.toString());	 
}
%>