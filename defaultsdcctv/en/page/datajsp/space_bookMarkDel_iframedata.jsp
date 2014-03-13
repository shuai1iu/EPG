<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="com.huawei.iptvmw.epg.facade.service.BookmarkImpl"%>
<%@ page import="com.huawei.iptvmw.facade.bean.info.BookmarkItem"%>
<%@ page import="java.util.*" %>
<%
	TurnPage turnPage = new TurnPage(request);
    BookmarkImpl bookmark = new BookmarkImpl(request);
	String supVodId = request.getParameter("SUPVODID");
    String pageName = "../InfoDisplay.jsp?ERROR_ID=84";
	String progId = request.getParameter("PROGID");  
	int succ = 0;
	if(progId == null)
	{
	  succ = 0;
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
		}
		else
		{
			succ = 1;
		}
	}
	response.getWriter().print(succ);	 
%>

