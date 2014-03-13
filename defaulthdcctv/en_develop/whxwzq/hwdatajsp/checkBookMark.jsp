<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.func.UserBookmark" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="java.util.*"%>

<%
	String programCode = request.getParameter("programCode")==null?"-1":request.getParameter("programCode");
	String varName = request.getParameter("varName")==null?"tempBookMark":request.getParameter("varName");
	String isBug = request.getParameter("isBug")==null?"-1":request.getParameter("isBug").toString();
	String isJson = request.getParameter("isJson")==null?"-1":request.getParameter("isJson").toString();
	UserBookmark bookmark = new UserBookmark(request);
	Boolean  isbookmark = new Boolean("False");	
	ArrayList bookmarkList = bookmark.getBookmarkList();
	ArrayList bookList = new ArrayList();
	HashMap item = new HashMap();
	HashMap resultMap = new HashMap();
	String tempBeginTime = "-1";
	String tempEndTime ="-1";
	JSONObject jsonBookMark = null;
	
	if(bookmarkList != null && bookmarkList.size() > 1)
	{
		HashMap temp = (HashMap)bookmarkList.get(0);
		bookList = (ArrayList)bookmarkList.get(1); 
		int  countTotal = ((Integer)temp.get("COUNTTOTAL")).intValue();
		for(int i = 0; i < countTotal; i++)
		   { 
			  item = (HashMap)bookList.get(i);
			  String tempid = (String)item.get("PROG_ID");
			  if(tempid.equals(programCode))
			  { 
				 isbookmark = new Boolean("True");
				 tempBeginTime = (String)item.get("BEGINTIME");
				 tempEndTime = (String)item.get("ENDTIME");
				 break; 
			  } 
		   }	
	}
	resultMap.put("ISBOOKMARK",isbookmark);
	resultMap.put("BEGINTIME",tempBeginTime);
	resultMap.put("ENDTIME",tempEndTime);
	
	jsonBookMark = JSONObject.fromObject(resultMap);
%>
<%
if(isBug.equals("1"))
{
	System.out.println(jsonBookMark);
}
if(isJson.equals("-1"))
{
%>	
var <%=varName%> = <%=jsonBookMark%>;
<%
}
else
{
 response.getWriter().print(jsonBookMark.toString());	 
}
%>
