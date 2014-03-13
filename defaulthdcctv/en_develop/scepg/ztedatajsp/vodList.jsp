<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%
	String categoryCode=request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode");
	String varName=request.getParameter("varName")==null?"tempVodList":request.getParameter("varName");
	String fields=request.getParameter("fields")==null?"-1":request.getParameter("fields");
	String pageIndex=request.getParameter("pageIndex")==null?"1":request.getParameter("pageIndex");
	String pageSize=request.getParameter("pageSize")==null?"5":request.getParameter("pageSize");
	int totalpage = -1;
	long totalcount = -1;
	
	String isBug=request.getParameter("isBug")==null?"-1":request.getParameter("isBug");
	String isJson=request.getParameter("isJson")==null?"-1":request.getParameter("isJson");

	String vodSql="columncode='"+categoryCode+ "' and (programtype=1 or programtype=14)";
	String vodOrder="sortnum desc";
	String path = request.getContextPath();
    String imgPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	int curpage=Integer.parseInt(pageIndex);
    int pageCount=Integer.parseInt(pageSize);
	
	JSONObject jsonVodList = null;
%>
	<ex:search tablename="user_vod" fields="*" order="<%=vodOrder%>" condition="<%=vodSql%>" var="programlist" curpagenum="<%=curpage%>" pagecount="<%=pageCount%>" >
		<%
			totalpage = (Integer) pageContext.getAttribute("pagenums");
    		totalcount =  (Long)pageContext.getAttribute("totalcount");
    		List<Map> vodData = (List<Map>) pageContext.getAttribute("programlist");
			
			HashMap fullMap = new HashMap();
			ArrayList vodDataList=new ArrayList();
			
			fullMap.put("totalSize",totalcount);
		    fullMap.put("curPage",curpage);
		    fullMap.put("totalPage",totalpage);
	
			if(vodData!=null&&vodData.size()>0){
				for(int i=0;i<vodData.size();i++){
					HashMap resultMap = new HashMap();
					Map vodMap = (Map)vodData.get(i);
					
					String programCode=(String)vodMap.get("programcode");
					resultMap.put("programCode",programCode);
					String contentCode=(String)vodMap.get("contentcode");
					resultMap.put("contentCode",contentCode);
					String programType=(String)vodMap.get("programtype");
					resultMap.put("programType",programType);					
					resultMap.put("categoryCode",categoryCode);
					if(fields.equals("-1") || fields.indexOf("name") != -1){
						String name=(String)vodMap.get("programname");
						if(name!=null&&name!=""&&name!="null"){
							resultMap.put("name",name);
						}else{
							resultMap.put("name","暂无名称");
						}
					}
					if(fields.equals("-1") || fields.indexOf("description") != -1){
						String description=(String)vodMap.get("description");
						if(description!=null&&description!=""&&description!="null"){
							resultMap.put("description",description);
						}else{
							resultMap.put("description","暂无内容");
						}
					}					
					if(fields.equals("-1") || fields.indexOf("definition") != -1){
						String definitionSql="columncode='"+categoryCode+"'";
						%>
							<ex:params var="inputhash">
								<ex:param name="contentcodeavailable" value="<%=contentCode%>"/>
							</ex:params>
							<ex:search tablename="user_vod_detail" inputparams="${inputhash}" fields="*" order="<%=vodOrder%>" condition="<%=definitionSql%>" var="programinfo" curpagenum="1" pagecount="1" >
							  <%
							     List vodDetail = (List) pageContext.getAttribute("programinfo");
							     if(vodDetail != null &&vodDetail.size()>0)
							     {
							         Map tempdetail=(Map)vodDetail.get(0);
							         resultMap.put("definition",tempdetail.get("definition"));
									 if(fields.equals("-1") || fields.indexOf("physicalContentId") != -1){
										resultMap.put("physicalContentId",tempdetail.get("physicalcontentid"));
									}
							      }
					         %>
							</ex:search>
						<%
						if(("14").equals(programType)){
							resultMap.put("definition","");	
						}
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
					
					vodDataList.add(resultMap);
				}
				fullMap.put("vodDataList",vodDataList);
			    jsonVodList = JSONObject.fromObject(fullMap);
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