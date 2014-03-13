<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ taglib uri="/WEB-INF/extendtag.tld" prefix="ex"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%
	String channelID=request.getParameter("channelID")==null?"-1":request.getParameter("channelID");
	String varName=request.getParameter("varName")==null?"tempChannelPrevue":request.getParameter("varName");
	String fields=request.getParameter("fields")==null?"-1":request.getParameter("fields");
	String pageIndex=request.getParameter("pageIndex")==null?"1":request.getParameter("pageIndex");
	String pageSize=request.getParameter("pageSize")==null?"5":request.getParameter("pageSize");
	String isBug=request.getParameter("isBug")==null?"-1":request.getParameter("isBug");
	String isJson=request.getParameter("isJson")==null?"-1":request.getParameter("isJson");
	
	Date currDate = new Date();
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd");
    String str_CurrDateTime = formatter.format(currDate);
	
	int totalpage = -1;
	long totalcount = -1;

	String channelPrevueSql =  "channelcode='"+channelID+"' and begintime like '"+str_CurrDateTime+"%'";
	
	int curpage=Integer.parseInt(pageIndex);
    int pageCount=Integer.parseInt(pageSize);
	
	JSONObject jsonVodList = null;
%>
	<ex:search tablename="user_channelprevue" fields="*" order="begintime asc" condition="<%=channelPrevueSql%>" var="prevueList" curpagenum="<%=curpage%>" pagecount="<%=pageCount%>">
		<%
			totalpage = (Integer) pageContext.getAttribute("pagenums");
    		totalcount =  (Long)pageContext.getAttribute("totalcount");
    		List<Map> prevueList = (List<Map>) pageContext.getAttribute("prevueList");
			
			HashMap fullMap = new HashMap();
			ArrayList channelPrevueList=new ArrayList();
			
			fullMap.put("totalSize",totalcount);
		    fullMap.put("curPage",curpage);
		    fullMap.put("totalPage",totalpage);
	
			if(prevueList!=null&&prevueList.size()>0){
				for(int i=0;i<prevueList.size();i++){
					HashMap resultMap = new HashMap();
					Map channelPrevueMap = (Map)prevueList.get(i);
					
					resultMap.put("prevueId",channelPrevueMap.get("prevueid"));
					resultMap.put("startTime",channelPrevueMap.get("begintime"));
					resultMap.put("endTime",channelPrevueMap.get("endtime"));					
					resultMap.put("prevueName",channelPrevueMap.get("prevuename"));	
					
					if(fields.equals("-1") || fields.indexOf("currDate") != -1){
						resultMap.put("currDate",str_CurrDateTime);
					}
					if(fields.equals("-1") || fields.indexOf("channelID") != -1){
						resultMap.put("channelID",channelPrevueMap.get("channelcode"));
					}
					if(fields.equals("-1") || fields.indexOf("searchCode") != -1){
						resultMap.put("searchCode",channelPrevueMap.get("searchkey"));
					}
					channelPrevueList.add(resultMap);
				}
				fullMap.put("channelPrevueList",channelPrevueList);
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
