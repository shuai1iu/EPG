<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%
	String categoryCode=request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode");
	String varName=request.getParameter("varName")==null?"tempChannelList":request.getParameter("varName");
	String fields=request.getParameter("fields")==null?"-1":request.getParameter("fields");
	String pageIndex=request.getParameter("pageIndex")==null?"1":request.getParameter("pageIndex");
	String pageSize=request.getParameter("pageSize")==null?"5":request.getParameter("pageSize");
	int totalpage = -1;
	long totalcount = -1;
	
	String isBug=request.getParameter("isBug")==null?"-1":request.getParameter("isBug");
	String isJson=request.getParameter("isJson")==null?"-1":request.getParameter("isJson");

	String channelListSql =  " columncode='"+ categoryCode + "'";
	String channelOrder = "usermixno asc";
	
	int curpage=Integer.parseInt(pageIndex);
    int pageCount=Integer.parseInt(pageSize);
	
	JSONObject jsonVodList = null;
%>
	<ex:search tablename="user_channel" fields="*" condition="<%=channelListSql%>" order="<%=channelOrder%>" var="channelList" curpagenum="<%=curpage%>" pagecount="<%=pageCount%>" >
		<%
			totalpage = (Integer) pageContext.getAttribute("pagenums");
    		totalcount =  (Long)pageContext.getAttribute("totalcount");
    		List<Map> channelList = (List<Map>) pageContext.getAttribute("channelList");
			
			HashMap fullMap = new HashMap();
			ArrayList channelDataList=new ArrayList();
			
			fullMap.put("totalSize",totalcount);
		    fullMap.put("curPage",curpage);
		    fullMap.put("totalPage",totalpage);
	
			if(channelList!=null&&channelList.size()>0){
				for(int i=0;i<channelList.size();i++){
					HashMap resultMap = new HashMap();
					Map channelMap = (Map)channelList.get(i);
					
					String channelID=(String)channelMap.get("channelcode");
					resultMap.put("channelID",channelID);
					resultMap.put("channelName",channelMap.get("channelname"));
					resultMap.put("channelIndex",channelMap.get("usermixno"));	
						
					if(fields.equals("-1") || fields.indexOf("channelType") != -1){
						resultMap.put("channelType",channelMap.get("channeltype"));
					}
					if(fields.equals("-1") || fields.indexOf("isTVOD") != -1 || fields.indexOf("isPLTV") != -1 || fields.indexOf("isNVOD") != -1 || fields.indexOf("definition") != -1){
						String channelDetailSql=" channelcode='"+channelID+"' ";
						%>
						<ex:params var="inputhash">
							<ex:param name="channelcode" value="<%=channelID%>"/>
						</ex:params>
						<ex:search tablename="user_channel_detail" inputparams="${inputhash}" fields="*" condition="<%=channelDetailSql%>" order="mixno asc" var="channelDetailList" curpagenum="1" pagecount="1" >
							<%
								List<Map> channelDetailList = (List<Map>) pageContext.getAttribute("channelDetailList");
								if(channelDetailList!=null&&channelDetailList.size()>0){
									Map channelDetailMap = (Map)channelDetailList.get(0);
									if(fields.equals("-1") || fields.indexOf("definition") != -1){
										resultMap.put("definition",channelDetailMap.get("definition"));
									}
									if(fields.equals("-1") || fields.indexOf("isTVOD") != -1){
										resultMap.put("isTVOD",channelDetailMap.get("tvodenable"));
									}
									if(fields.equals("-1") || fields.indexOf("isPLTV") != -1){
										resultMap.put("isPLTV",channelDetailMap.get("timeshiftenable"));
									}
									if(fields.equals("-1") || fields.indexOf("isNVOD") != -1){
										resultMap.put("isNVOD","");
									}	
								}
							%>
						</ex:search>
						<%
					}					
					channelDataList.add(resultMap);
				}
				fullMap.put("channelDataList",channelDataList);
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