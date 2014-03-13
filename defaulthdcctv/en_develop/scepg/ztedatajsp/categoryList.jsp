<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%
	String parentCategoryCode=request.getParameter("parentCategoryCode")==null?"-1":request.getParameter("parentCategoryCode");
	String varName=request.getParameter("varName")==null?"tempCategoryList":request.getParameter("varName");
	String fields=request.getParameter("fields")==null?"-1":request.getParameter("fields");
	String pageIndex=request.getParameter("pageIndex")==null?"1":request.getParameter("pageIndex");
	String pageSize=request.getParameter("pageSize")==null?"5":request.getParameter("pageSize");
	int totalpage = -1;
	long totalcount = -1;
	
	String isBug=request.getParameter("isBug")==null?"-1":request.getParameter("isBug");
	String isJson=request.getParameter("isJson")==null?"-1":request.getParameter("isJson");

	String categoryListSql = "parentcode='"+ parentCategoryCode + "'";
	String categoryOrder="sortnum desc";
	String path = request.getContextPath();
    String imgPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	int curpage=Integer.parseInt(pageIndex);
    int pageCount=Integer.parseInt(pageSize);
	
	JSONObject jsonVodList = null;
%>
	<ex:search tablename="user_column" fields="*" condition="<%=categoryListSql%>" order="<%=categoryOrder%>" var="categoryList" curpagenum="<%=curpage%>" pagecount="<%=pageCount%>" >
		<%
			totalpage = (Integer) pageContext.getAttribute("pagenums");
    		totalcount =  (Long)pageContext.getAttribute("totalcount");
    		List<Map> categoryList = (List<Map>) pageContext.getAttribute("categoryList");
			
			HashMap fullMap = new HashMap();
			ArrayList categoryDataList=new ArrayList();
			
			fullMap.put("totalSize",totalcount);
		    fullMap.put("curPage",curpage);
		    fullMap.put("totalPage",totalpage);
	
			if(categoryList!=null&&categoryList.size()>0){
				for(int i=0;i<categoryList.size();i++){
					HashMap resultMap = new HashMap();
					Map categoryMap = (Map)categoryList.get(i);
					
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
					
					categoryDataList.add(resultMap);
				}
				
			}
			fullMap.put("categoryList",categoryDataList);
		    jsonVodList = JSONObject.fromObject(fullMap);
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