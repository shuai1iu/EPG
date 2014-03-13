<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="com.huawei.iptvmw.epg.facade.service.BookmarkImpl"%>
<%@ page import="com.huawei.iptvmw.facade.bean.info.BookmarkItem"%>
<%@ page import="java.util.*" %>
<script>
<%
	ServiceHelp serviceHelp = new ServiceHelp(request);
    UserProfile userInfo = new UserProfile(request);
    MetaData meta = new MetaData(request);
    BookmarkImpl bookmark = new BookmarkImpl(request);
	String supVodId = request.getParameter("SUPVODID");
    ArrayList bookmarkList = new ArrayList();
    int intsuccess=0;// 0 表示没有成功 1 表示成功   2表示书签已满
	//得到增加删除字符串
    String progId = request.getParameter("PROGID");
    String beginTime = request.getParameter("BEGINTIME");
    String endTime = request.getParameter("ENDTIME");
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
    }             
	int tempcountTotal =0; 		
	List<BookmarkItem> tempList = bookmark.getList();
    if(bookmarkList != null && null != tempList)
    {
		tempcountTotal = tempList.size();
	}
	//用户已有的书签大于书签的上限时报错
	if(tempList != null)
    {
       if(tempcountTotal >= bookmarkSize && !isBookMark)
        {
            intsuccess=2; 
        }
    }
    boolean ret = bookmark.addItem(progId,beginTime,endTime,supVodId);
    if( ret == false )
    {
 	   intsuccess=0;
    }
    else
    {
       intsuccess=1;
    }
	//response.getWriter().print(intsuccess);	     
%>

var intsuccess;
if(<%=intsuccess%>!=null)
{
   intsuccess=eval('('+'<%=intsuccess%>'+')');
}
window.parent.getJson(intsuccess);
</script>
