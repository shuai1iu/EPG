<!-- 文件名：query_BookmarkData.jsp -->
<!-- 描  述：获取书签数据页面 -->
<!-- 修改时间：2010-7-27 -->
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.facade.service.BookmarkImpl"%>
<%@ page import="com.huawei.iptvmw.facade.bean.info.BookmarkItem"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ include file="query_IsHasBookMark.jsp"%>
<%@ include file="SubStringFunction.jsp"%>
<script language="javascript"  type="text/javascript">
<%
   int curpage=1;
   int indexid=8;
   int areaid=0;
   int pagecount=1;
   if(request.getParameter("curpage")!=null)
   {
	 curpage = Integer.parseInt(request.getParameter("curpage"));
    }
   if(request.getParameter("indexid")!=null)
   {
	indexid = Integer.parseInt(request.getParameter("indexid"));
   }
   if(request.getParameter("areaid")!=null)
   {
		areaid = Integer.parseInt(request.getParameter("areaid"));
   }
	/*以上做对页面初始化焦点的解析*/
	

    MetaData metaData = new MetaData(request);
	ServiceHelp serviceHelp = new ServiceHelp(request);
	// 得到书签上限
	int bookMarkLimit = serviceHelp.getBookmarkLimit();
	
	// 得到书签
	BookmarkImpl bookmark = new BookmarkImpl(request);
	List list = bookmark.getList();
	HashMap map = null;

    int countTotal = 0;
    if (list != null)
    {
        countTotal = list.size();
       
    }

    // 书签超过上限
	if(countTotal > bookMarkLimit)
	{
%>
        <jsp:forward page="query_BookMarkOutOfLimit.jsp" />
<%
    }
%>
	var bookmarkListTemp = [];
    var tempObj;
	var totalBookmarkList = new Array();

<%
    if(countTotal>0)
	{
	 pagecount=(int)Math.ceil(countTotal/11.0);
	}
	for (int i = 0; i < countTotal; i++)
	{
		BookmarkItem item = (BookmarkItem)list.get(i);
		String superVodId = item.getSuperVodId();
		String progId = item.getContentId();
		String realsitcomNum="";
		if(null!=superVodId && superVodId!="")
		{
			    ArrayList resultList = metaData.getSitcomList(superVodId, 999, 0);
				if(null!=resultList && resultList.size()==2)
				{
				HashMap countMap = (HashMap)resultList.get(0);
				//影片总集数
				int CountTotal = ((Integer)countMap.get(EPGConstants.KEY_COUNT)).intValue();
				if(CountTotal > 0)
				{
					ArrayList sitcomList = (ArrayList)resultList.get(1);	
					//获取记录数
					int fetchNum = sitcomList.size();
					String temp=null;
					HashMap sitcomMap = null;  
					int leng = 0;
					for(int j = 0; j < fetchNum; j++ )
					{
						    sitcomMap = (HashMap)sitcomList.get(j);
						    //子集Id
						    int ivodId=((Integer)sitcomMap.get("VODID")).intValue();
						    String vodId = String.valueOf(ivodId);
							if(vodId.equals(progId))
							{
								int sitcom = ((Integer)sitcomMap.get("SITCOMNUM")).intValue();
								temp = String.valueOf((Integer)sitcomMap.get("SITCOMNUM"));
								leng = temp.length();
								if(leng > 3)
								{
									temp=temp.substring(0,3);
								}
								realsitcomNum = temp;
							}
					 }
				}
				}
		}
		
		String beginTime = item.getBeginTime();
		String endTime = item.getEndTime();
		String progName = item.getName();
		//如果名称过长，截取部分显示
		String progName_cut = subStringFunction(progName, 1, 300);
		
		String progTime = "";
		String progDate = "";
		String progMarkPosition = "";
		String isValid = "1" ;
		//影片无效（如影片被去激活）
		if("".equals(progName))
		{
			isValid = "-1";
			progName = "该影片已经过期，请删除";
			progName_cut = "该影片已经过期，请删除";
		}
		else
		{
			try
			{
			    Map filmInfoMap = metaData.getVodDetailInfo(Integer.parseInt(progId));
			    if (filmInfoMap != null)
			    {
	                progTime = String.valueOf(filmInfoMap.get("ELAPSETIME"))+"分钟";
			    }
			}
	        catch (Exception e)
	        {
	            progTime = "";
	        }
			
			String bookmarkDate = String.valueOf(item.getUpdateTime());
			if (bookmarkDate.length() >= 8)
			{
			    progDate = bookmarkDate.substring(0, 4) + "/";
			    progDate += bookmarkDate.substring(4, 6) + "/";
			    progDate += bookmarkDate.substring(6, 8);
			}
	
			// 判断当前VOD是否含有书签
			HashMap bookMap = isHasBookMark(progId, request);
		    progMarkPosition = (String)bookMap.get("BEGINTIME");
    	    int progMarkInt=0;
            try
            {
            	progMarkInt=Integer.parseInt(progMarkPosition);
            }
            catch(Exception e)
            {
            	progMarkInt=0;
            }
            progMarkInt=progMarkInt/60;
            progMarkPosition=Integer.toString(progMarkInt)+"分钟";
			
		}
		
		
%>
		tempObj = {};
		tempObj.progId = "<%=progId%>";
		tempObj.superVodId = "<%=superVodId%>" ;
		tempObj.realsitcomNum="<%=realsitcomNum%>";
		tempObj.progName = "<%=progName%>";
		tempObj.isValid = "<%=isValid%>";
		tempObj.progTime = "<%=progTime%>";
		tempObj.progDate = "<%=progDate%>";
		tempObj.progMarkPosition = "<%=progMarkPosition%>";
		tempObj.beginTime = "<%=beginTime%>";
		tempObj.endTime = "<%=endTime%>";
		bookmarkListTemp.push(tempObj);
<%
    }
%>
  var areaid=<%=areaid%>;
  var indexid=<%=indexid%>;
  var jscurpage=<%=curpage%>;
  if(parseInt(jscurpage)>parseInt(<%=pagecount%>))
  {
    jscurpage=<%=pagecount%>;
  }
  for (var i =0; i < bookmarkListTemp.length; i++)
  {
	var bookmarkObj = {};
	bookmarkObj.progId =bookmarkListTemp[i].progId;
	bookmarkObj.superVodId =bookmarkListTemp[i].superVodId ;
	bookmarkObj.realsitcomNum=bookmarkListTemp[i].realsitcomNum ;
	bookmarkObj.progName =bookmarkListTemp[i].progName ;
	bookmarkObj.isValid =bookmarkListTemp[i].isValid ;
	bookmarkObj.progTime = bookmarkListTemp[i].progTime ;
	bookmarkObj.progDate = bookmarkListTemp[i].progDate ;
	bookmarkObj.progMarkPosition =  bookmarkListTemp[i].progMarkPosition ;
	bookmarkObj.bookmarkObjType=1;
	bookmarkObj.beginTime = bookmarkListTemp[i].beginTime;
	bookmarkObj.endTime = bookmarkListTemp[i].endTime;
	totalBookmarkList.push(bookmarkObj);
	var bookmarkObjDel= {};
	bookmarkObjDel.progId =bookmarkListTemp[i].progId;
	bookmarkObjDel.superVodId =bookmarkListTemp[i].superVodId;
	bookmarkObjDel.realsitcomNum=bookmarkListTemp[i].realsitcomNum ;
	bookmarkObjDel.progName ="删除" ;
	bookmarkObjDel.isValid =bookmarkListTemp[i].isValid;
	bookmarkObjDel.progTime = bookmarkListTemp[i].progTime;
	bookmarkObjDel.progDate = bookmarkListTemp[i].progDate;
	bookmarkObjDel.progMarkPosition =  bookmarkListTemp[i].progMarkPosition ;
	bookmarkObjDel.bookmarkObjType=2;
	totalBookmarkList.push(bookmarkObjDel);
 }
 if(totalBookmarkList.length==0)
 {
    var bookmarkObTmpjNull = {};
    bookmarkObTmpjNull.progId ="";
	bookmarkObTmpjNull.superVodId ="" ;
	bookmarkObTmpjNull.realsitcomNum="";
	bookmarkObTmpjNull.progName ="暂无记录";
	bookmarkObTmpjNull.isValid ="" ;
	bookmarkObTmpjNull.progTime ="";
	bookmarkObTmpjNull.progDate = "" ;
	bookmarkObTmpjNull.progMarkPosition ="";
	bookmarkObTmpjNull.bookmarkObjType=3;
	totalBookmarkList.push(bookmarkObTmpjNull);
 }
</script>
