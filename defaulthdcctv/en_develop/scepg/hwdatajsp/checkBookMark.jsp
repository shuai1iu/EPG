<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.func.UserBookmark" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="java.util.*"%>

<%
	String categoryCode = request.getParameter("categoryCode")==null?"":request.getParameter("categoryCode").toString();
	String programCode = request.getParameter("programCode")==null?"-1":request.getParameter("programCode");
	String contentCode = request.getParameter("contentCode")==null?"-1":request.getParameter("contentCode");
	String bookMarkType = request.getParameter("bookMarkType") == null ? "" : request.getParameter("bookMarkType");
	int intbookMarkType=-1;
	if(bookMarkType.equals("VOD") ||  bookMarkType.equals("TVOD")){
		intbookMarkType=0;
	}
	if(bookMarkType.equals("CHAN")){
		intbookMarkType=1;
	}
	String varName = request.getParameter("varName")==null?"tempBookMark":request.getParameter("varName");
	String isBug = request.getParameter("isBug")==null?"-1":request.getParameter("isBug").toString();
	String isJson = request.getParameter("isJson")==null?"1":request.getParameter("isJson").toString();
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
	resultMap.put("IsBookMark",isbookmark);
	resultMap.put("breakPoint",tempBeginTime);
	resultMap.put("totalTime",tempEndTime);
	
	jsonBookMark = JSONObject.fromObject(resultMap);
	request.setAttribute(varName,jsonBookMark);
%>
<%
if(isBug.equals("1"))
{
	System.out.println(jsonBookMark);
}
if(isJson.equals("1"))
{
%>	
var <%=varName%> = <%=jsonBookMark%>;
<%
}
%>
