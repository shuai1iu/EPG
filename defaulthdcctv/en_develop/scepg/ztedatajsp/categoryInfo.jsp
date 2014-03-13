<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%
	String categoryCode=request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode");
	String varName=request.getParameter("varName")==null?"tempCategoryInfo":request.getParameter("varName");
	String fields=request.getParameter("fields")==null?"-1":request.getParameter("fields");
	String isBug=request.getParameter("isBug")==null?"-1":request.getParameter("isBug");
	String isJson=request.getParameter("isJson")==null?"-1":request.getParameter("isJson");

	String categoryInfoSql = "columncode='"+ categoryCode + "'";
	String categoryOrder="sortnum desc";
	String path = request.getContextPath();
    String imgPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	JSONObject jsonVodList = null;
%>
	<ex:search tablename="user_column" fields="*" condition="<%=categoryInfoSql%>" order="<%=categoryOrder%>" var="categoryList" curpagenum="1" pagecount="1" >
		<%
    		List<Map> categoryList = (List<Map>) pageContext.getAttribute("categoryList");
	
			if(categoryList!=null&&categoryList.size()>0){
				HashMap resultMap = new HashMap();
				Map categoryMap = (Map)categoryList.get(0);
				
				resultMap.put("categoryCode",categoryMap.get("columncode"));
				resultMap.put("parentCategoryCode",categoryMap.get("parentcode"));
				resultMap.put("categoryType",categoryMap.get("columntype"));					

				if(fields.equals("-1") || fields.indexOf("name") != -1){
					String name=(String)categoryMap.get("columnname");
					if(name!=null&&name!=""&&name!="null"){
						resultMap.put("name",name);
					}else{
						resultMap.put("name","暂无名称");
					}
				}
				if(fields.equals("-1") || fields.indexOf("description") != -1){
					String description=(String)categoryMap.get("description");
					if(description!=null&&description!=""&&description!="null"){
						resultMap.put("description",description);
					}else{
						resultMap.put("description","暂无内容");
					}
				}
				if(fields.equals("-1") || fields.indexOf("isHasChild") != -1){
					resultMap.put("isHasChild",categoryMap.get("subexist"));
				}						
				if(fields.equals("-1") || fields.indexOf("pictureList") != -1){
					String poster1=(String)categoryMap.get("normalposter");//poster
					String poster2=(String)categoryMap.get("smallposter");//thumb
					String poster3=(String)categoryMap.get("bigposter");//still
					 
					if(poster1.length()>0 && poster1.indexOf("../")!=-1){
					   poster1=poster1.substring(3);
					}
					if(poster2.length()>0 && poster2.indexOf("../")!=-1){
					   poster2=poster2.substring(3);
					}
					if(poster3.length()>0 && poster3.indexOf("../")!=-1){
					   poster3=poster3.substring(3);
					}
					poster1=imgPath+poster1;
					poster2=imgPath+poster2;
					poster3=imgPath+poster3;
					 
					HashMap resultPosterMap = new HashMap();
					resultPosterMap.put("poster",poster1);
					resultPosterMap.put("thumb",poster2);
					resultPosterMap.put("still",poster3);
					resultMap.put("pictureList",resultPosterMap);
				}
			    jsonVodList = JSONObject.fromObject(resultMap);
			}
		%>
	</ex:search>
<%
	if(isBug.equals("1")){
		System.out.println(jsonVodList);
	}
	if(isJson.equals("-1")){
%>	
	var <%=varName%> = <%=jsonVodList%>;
<%
	}
	else{
		response.getWriter().print(jsonVodList.toString());	 
	}
%>