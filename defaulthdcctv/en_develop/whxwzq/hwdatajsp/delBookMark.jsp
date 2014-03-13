<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.facade.service.BookmarkImpl"%>
<%@ page import="com.huawei.iptvmw.facade.bean.info.BookmarkItem"%>
<%@ page import="java.util.*" %>
<%
	String varName = request.getParameter("varName")==null?"tempDelMark":request.getParameter("varName");
	String isBug = request.getParameter("isBug")==null?"-1":request.getParameter("isBug").toString();
	String isJson = request.getParameter("isJson")==null?"-1":request.getParameter("isJson").toString();
	String supVodId = request.getParameter("fatherId");
	String progId = request.getParameter("programCode");  
		
    BookmarkImpl bookmark = new BookmarkImpl(request);
	JSONObject bookmarkResult = null;
	HashMap result = new HashMap();
	int succ = 0;
	if(progId == null)
	{
	  succ = 0;
	  result.put("result",succ);
	}
	else
	{
		BookmarkItem item = new BookmarkItem();
		List<BookmarkItem> delList = new ArrayList();
		item.setContentId(progId);
		item.setSuperVodId(supVodId);
		delList.add(item);
		boolean ret = bookmark.deleteItems(delList);
		
		if(ret == false)
		{
			succ = 0;
			result.put("result",succ);
		}
		else
		{
			succ = 1;
			result.put("result",succ);
		}
	}
	
bookmarkResult = JSONObject.fromObject(result);
%>

<%
if(isBug.equals("1"))
{
	System.out.println(bookmarkResult);
}
if(isJson.equals("-1"))
{
%>	
var <%=varName%> = <%=bookmarkResult%>;
<%
}
else
{
 response.getWriter().print(bookmarkResult.toString());	 
}
%>