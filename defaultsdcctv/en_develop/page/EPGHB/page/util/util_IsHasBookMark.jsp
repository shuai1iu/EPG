<%-- Copyright (C), Huawei Tech. Co., Ltd. --%>
<!-- Author:renxiaoming -->
<%-- CreateAt:2009-02-04 --%>
<%-- FileName:IsBookMark.jsp --%>
<%-- 页面作用：判断是否是某个VOD是否含有书签 --%>


<%@ page import="com.huawei.iptvmw.epg.bean.func.UserBookmark" %>
<%@ page import="java.util.*"%>
<%!
	//判断某个VOD是否含有书签	
	private HashMap isHasBookMark(String strFilmId,HttpServletRequest request)
	{
		//判断是否书签的操作
		Boolean  isbookmark = new Boolean("False");	
		UserBookmark bookmark = new UserBookmark(request);
		ArrayList bookmarkList = bookmark.getBookmarkList();
		ArrayList bookList = new ArrayList();
		HashMap item = new HashMap();
		HashMap resultMap = new HashMap();
		String  tempBeginTime = "-1";
		if(bookmarkList != null )
		{	   
		   HashMap temp = (HashMap)bookmarkList.get(0);
		   bookList = (ArrayList)bookmarkList.get(1); 
		   int  countTotal = ((Integer)temp.get("COUNTTOTAL")).intValue();
		   for(int i = 0; i < countTotal; i++)
		   { 
			  item = (HashMap)bookList.get(i);
			  String tempid = (String)item.get("PROG_ID");
			  if(tempid.equals(strFilmId))
			  { 
				 isbookmark = new Boolean("True");
				 tempBeginTime = (String)item.get("BEGINTIME");
				 break; 
			  } 
		   }
		}
		resultMap.put("ISBOOKMARK",isbookmark);
		resultMap.put("BEGINTIME",tempBeginTime);
		//判断书签结束
		return  resultMap;
			
	}	
	
%>
