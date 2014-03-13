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
    String bookMarkType = request.getParameter("bookMarkType") == null ? "" : request.getParameter("bookMarkType");
	String categoryCode = request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode");
	String programCode = request.getParameter("programCode") == null ? "-1" : request.getParameter("programCode");
	String parentProgramCode = request.getParameter("parentProgramCode") == null ? "-1" : request.getParameter("parentProgramCode");
	String contentCode = request.getParameter("contentCode")==null?"-1":request.getParameter("contentCode");
	int intbookMarkType=-1;
	if(bookMarkType.equals("VOD") ||  bookMarkType.equals("TVOD")){
		intbookMarkType=0;
	}
	if(bookMarkType.equals("CHAN")){
		intbookMarkType=1;
	}
	
    String breakPoint = request.getParameter("breakPoint") == null ? "-1" : request.getParameter("breakPoint");
    String totalTime = request.getParameter("totalTime") == null ? "-1" : request.getParameter("totalTime");
	String varName = request.getParameter("varName")==null?"tempAddMark":request.getParameter("varName");
	String isBug = request.getParameter("isBug")==null?"-1":request.getParameter("isBug").toString();
	String isJson = request.getParameter("isJson")==null?"1":request.getParameter("isJson").toString();
	ServiceHelp serviceHelp = new ServiceHelp(request);
    BookmarkImpl bookmark = new BookmarkImpl(request);
	
    int intsuccess=0;// 0 表示没有成功 1 表示成功   2表示书签已满
	JSONObject bookmarkResult = null;
	HashMap result = new HashMap();
	//书签的上限
    int bookmarkSize = serviceHelp.getBookmarkLimit();
    boolean isBookMark = false ;
	if(null != parentProgramCode)
	{
	   isBookMark = bookmark.isBookmark(programCode,parentProgramCode);
	}
	else
	{
	   isBookMark = bookmark.isBookmark(programCode,null);
	}
	//当书签的最大容量为0或缺少参数时，增加出错提示信息
    if(programCode == null || breakPoint == null || totalTime==null || bookmarkSize ==0)
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
    boolean ret = bookmark.addItem(programCode,breakPoint,totalTime,parentProgramCode);
    if(ret == false)
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
	request.setAttribute(varName,bookmarkResult);
%>
<%
if(isBug.equals("1"))
{
	System.out.println(bookmarkResult);
}
if(isJson.equals("1"))
{
%>	
var <%=varName%> = <%=bookmarkResult%>;
<%
}
%>
