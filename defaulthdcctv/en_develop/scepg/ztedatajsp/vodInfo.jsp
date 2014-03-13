<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%
	String programCode=request.getParameter("programCode")==null?"-1":request.getParameter("programCode");
	String contentCode=request.getParameter("contentCode")==null?"-1":request.getParameter("contentCode");
	String categoryCode1 = request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode");
	String varName=request.getParameter("varName")==null?"tempVodInfo":request.getParameter("varName");
	String fields=request.getParameter("fields")==null?"-1":request.getParameter("fields");
	String isBug=request.getParameter("isBug")==null?"-1":request.getParameter("isBug");
	String isJson=request.getParameter("isJson")==null?"-1":request.getParameter("isJson");
    String vodSql = " columncode='"+ categoryCode1 + "'";
	
	String vodInfoOrder="sortnum desc";
	String path = request.getContextPath();
        String imgPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String vodSql1 = " contentcode='"+contentCode+"'";
	JSONObject jsonVodList = null;
%>
	<ex:params var="inputhash">
		<ex:param name="contentcodeavailable" value="<%=contentCode%>"/>
	</ex:params>
	<ex:search tablename="user_vod_detail" inputparams="${inputhash}" fields="*" order="<%=vodInfoOrder%>" condition="<%=vodSql%>" var="programInfo" curpagenum="1" pagecount="1" >
		<%
    		List<Map> vodInfo = (List<Map>) pageContext.getAttribute("programInfo");
			if(vodInfo==null||vodInfo.size()==0){
				
		%>      
                <ex:params var="typeinfoInputhash">
                      <ex:param name="columnavailable" value="<%=categoryCode1%>"/>
                </ex:params>
				<ex:search tablename="user_vod" inputparams="${typeinfoInputhash}" fields="*" order="<%=vodInfoOrder%>" condition="<%=vodSql1%>" var="programInfo2" curpagenum="1" pagecount="1" >
					<%
						vodInfo = (List<Map>) pageContext.getAttribute("programInfo2");
					%>
				</ex:search>
		<%	
			}
			if(vodInfo!=null&&vodInfo.size()>0){
				HashMap resultMap = new HashMap();
				Map vodMap = (Map)vodInfo.get(0);

				resultMap.put("programCode",programCode);
				resultMap.put("contentCode",vodMap.get("contentcode"));
				
				String programType=(String)vodMap.get("programtype");
				resultMap.put("programType",programType);
				String categoryCode=(String)vodMap.get("columncode");					
				resultMap.put("categoryCode",categoryCode);
				
				if(fields.equals("-1") || fields.indexOf("name") != -1){
					String name=(String)vodMap.get("programname");
					if(name!=null&&name!=""&&name!="null"){
						resultMap.put("name",name);
					}else{
						resultMap.put("name","暂无名称");
					}
				}
				if(fields.equals("-1") || fields.indexOf("sitnum") != -1){
					resultMap.put("sitnum",vodMap.get("seriesnum"));
				}
				if(fields.equals("-1") || fields.indexOf("actorDisplay") != -1){
					resultMap.put("actorDisplay",vodMap.get("actor"));
				}
				if(fields.equals("-1") || fields.indexOf("directDisplay") != -1){
					resultMap.put("directDisplay",vodMap.get("director"));
				}
				if(fields.equals("-1") || fields.indexOf("originalCountry") != -1){
					resultMap.put("originalCountry",vodMap.get("countryname"));
				}
				if(fields.equals("-1") || fields.indexOf("language") != -1){
					resultMap.put("language",vodMap.get("language"));
				}
				if(fields.equals("-1") || fields.indexOf("releaseYear") != -1){
					resultMap.put("releaseYear",((String)vodMap.get("onlinetime")).substring(0, 4));
				}
				if(fields.equals("-1") || fields.indexOf("orgairDate") != -1){
					resultMap.put("orgairDate","");
				}
				if(fields.equals("-1") || fields.indexOf("description") != -1){
					String description=(String)vodMap.get("description");
					if(description!=null&&description!=""&&description!="null"){
						resultMap.put("description",description);
					}else{
						resultMap.put("description","暂无内容");
					}
				}
				if(fields.equals("-1") || fields.indexOf("price") != -1){
					resultMap.put("price",vodMap.get("price"));
				}
				if(fields.equals("-1") || fields.indexOf("viewpoint") != -1){
					resultMap.put("viewpoint",vodMap.get("shortdesc"));
				}
				if(fields.equals("-1") || fields.indexOf("starlevel") != -1){
					resultMap.put("starlevel",vodMap.get("starlevel"));
				}
				if(fields.equals("-1") || fields.indexOf("length") != -1){
					resultMap.put("length",vodMap.get("elapsedtime"));
				}
				if(fields.equals("-1") || fields.indexOf("physicalContentId") != -1){
					String physicalContentId=(String)vodMap.get("physicalcontentid");
					if(physicalContentId!=null&&physicalContentId!=""&&physicalContentId!="null"){
						resultMap.put("physicalContentId",physicalContentId);
					}else{
						resultMap.put("physicalContentId","");
					}
				}
				if(fields.equals("-1") || fields.indexOf("definition") != -1){
					String definition=(String)vodMap.get("definition");
					if(definition!=null&&definition!=""&&definition!="null"){
						resultMap.put("definition",definition);
					}else{
						resultMap.put("definition","");
					}
				}
				if(fields.equals("-1") || fields.indexOf("subVodList") != -1){
					ArrayList serieList=new ArrayList();	//封装数据
					if(("14").equals(programType)){
						String seriesSql=" seriesprogramcode = '"+programCode+"' and columncode='"+categoryCode+"' and programtype=10"; 
						%>
							<ex:search tablename="user_vod" fields="*" order="seriesnum asc" condition="<%=seriesSql%>" var="series">
								<% 
									
									HashMap mediaMap = new HashMap();
									List<Map> series = (List<Map>)pageContext.getAttribute("series");
									if(series!=null&&series.size()>0){
										for (int j = 0; j < series.size(); j++) {
											Map serieMap = (Map) series.get(j);
											HashMap tempvodMap=new HashMap();
											tempvodMap.put("name",serieMap.get("programname"));
											tempvodMap.put("programType",serieMap.get("programtype"));
											tempvodMap.put("programCode",serieMap.get("programcode"));
											tempvodMap.put("contentCode",serieMap.get("contentcode"));
											tempvodMap.put("categoryCode",serieMap.get("columncode"));
											tempvodMap.put("num",j);
											String serieposter1=(String)serieMap.get("poster1");//poster
											String serieposter2=(String)serieMap.get("poster2");//thumb
											String serieposter3=(String)serieMap.get("poster3");//stll
											 
											if(serieposter1.length()>0 && serieposter1.indexOf("../")!=-1){
											   serieposter1=serieposter1.substring(3);
											}
											if(serieposter2.length()>0 && serieposter2.indexOf("../")!=-1){
											   serieposter2=serieposter2.substring(3);
											}
											if(serieposter3.length()>0 && serieposter3.indexOf("../")!=-1){
											   serieposter3=serieposter3.substring(3);
											}
											serieposter1=imgPath+serieposter1;
											serieposter2=imgPath+serieposter2;
											serieposter3=imgPath+serieposter3;
											 
											HashMap seriePosterMap = new HashMap();
											seriePosterMap.put("poster",serieposter1);
											seriePosterMap.put("thumb",serieposter2);
											seriePosterMap.put("still",serieposter3);
											tempvodMap.put("pictureList",seriePosterMap);
											
											serieList.add(tempvodMap);
										}
									}
								 %>
							</ex:search>
						<%
					}
					resultMap.put("subVodList",serieList);
				}
				if(fields.equals("-1") || fields.indexOf("pictureList") != -1){
					String poster1=(String)vodMap.get("poster1");//poster
					String poster2=(String)vodMap.get("poster2");//thumb
					String poster3=(String)vodMap.get("poster3");//stll
					 
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