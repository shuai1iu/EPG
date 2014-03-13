<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.func.UserBookmark" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="com.huawei.iptvmw.epg.facade.service.BookmarkImpl"%>
<%@ page import="com.huawei.iptvmw.facade.bean.info.BookmarkItem"%>
<%@ page import="java.util.*" %>
<%
	//得到增加删除字符串
    String progId = request.getParameter("programCode") == null ? "-1" : request.getParameter("programCode");
    String beginTime = request.getParameter("beginTime") == null ? "-1" : request.getParameter("beginTime");
    String endTime = request.getParameter("endTime") == null ? "-1" : request.getParameter("endTime");
	String varName = request.getParameter("varName")==null?"tempAddMark":request.getParameter("varName");
	String isBug = request.getParameter("isBug")==null?"-1":request.getParameter("isBug").toString();
	String isJson = request.getParameter("isJson")==null?"-1":request.getParameter("isJson").toString();
	ServiceHelp serviceHelp = new ServiceHelp(request);
    BookmarkImpl bookmark = new BookmarkImpl(request);
	String supVodId = request.getParameter("fatherId");
    int intsuccess=0;// 0 表示没有成功 1 表示成功   2表示书签已满
	JSONObject bookmarkResult = null;
	HashMap result = new HashMap();
	//书签的上限
    int bookmarkSize = serviceHelp.getBookmarkLimit();
    boolean isBookMark = false ;
	if(null != supVodId)
	{
	   isBookMark = bookmark.isBookmark(progId,supVodId);
	}
	else
	{
	   isBookMark = bookmark.isBookmark(progId,null);
	}
	//当书签的最大容量为0或缺少参数时，增加出错提示信息
    if(progId == null || beginTime == null || endTime==null || bookmarkSize ==0)
    {
        intsuccess=0;
        result.put("result",intsuccess);
    }             
	int tempcountTotal =0; 		
	List<BookmarkItem> tempList = bookmark.getList();
    if(null != tempList)
    {
		tempcountTotal = tempList.size();
	}
    boolean ret = bookmark.addItem(progId,beginTime,endTime,supVodId);
    if( ret == false )
    {
 	   intsuccess=0;
 	   result.put("result",intsuccess);
    }
    else
    {
       intsuccess=1;
       result.put("result",intsuccess);
    }
    //用户已有的书签大于书签的上限时报错
	if(tempList != null)
    {
       if(tempcountTotal >= bookmarkSize && !isBookMark)
        {
            intsuccess=2; 
            result.put("result",intsuccess);
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
