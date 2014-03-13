<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.facade.service.BookmarkImpl"%>
<%@ page import="com.huawei.iptvmw.facade.bean.info.BookmarkItem"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="query_IsHasBookMark.jsp"%>
<%@ include file="SubStringFunction.jsp"%>
<%
	int pagecount=1;
	int curpage = Integer.parseInt(request.getParameter("curpage"));
	int pos = curpage * 11 - 11;
	MetaData metaData = new MetaData(request);
	ServiceHelp serviceHelp = new ServiceHelp(request);
	// 得到书签上限
	int bookMarkLimit = serviceHelp.getBookmarkLimit();
	
	// 得到书签
	BookmarkImpl bookmark = new BookmarkImpl(request);
	List list = bookmark.getList();
	HashMap map = null;
    ArrayList BookmarkList=new ArrayList();
    int countTotal = 0;
    if (list != null)
    {
        countTotal = list.size();
    }
    if(countTotal>0)
	{
	  pagecount=(int)Math.ceil(countTotal/11.0);
	}
	for(int i=pos;i<countTotal&&i<(pos+11);i++)
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
			HashMap bookmarkobj = new HashMap();
			bookmarkobj.put("progId",progId);  
	        bookmarkobj.put("superVodId",superVodId);  
			bookmarkobj.put("realsitcomNum",realsitcomNum );  
	        bookmarkobj.put("progName",progName); 
			bookmarkobj.put("isValid",isValid );  
		    bookmarkobj.put("progTime",progTime); 
			bookmarkobj.put("progDate",progDate );  
			bookmarkobj.put("progMarkPosition",progMarkPosition ); 
	        bookmarkobj.put("collentObjType",1); 
			
			BookmarkList.add(bookmarkobj);
			bookmarkobj = new HashMap();
		    bookmarkobj.put("progId",progId);  
	        bookmarkobj.put("superVodId",superVodId);  
			bookmarkobj.put("realsitcomNum",realsitcomNum );  
	        bookmarkobj.put("progName","删除"); 
			bookmarkobj.put("isValid",isValid );  
		    bookmarkobj.put("progTime",progTime); 
			bookmarkobj.put("progDate",progDate );  
			bookmarkobj.put("progMarkPosition",progMarkPosition ); 
	        bookmarkobj.put("collentObjType",2); 
			
			BookmarkList.add(bookmarkobj);
		}
	}
	response.getWriter().print(JSONArray.fromObject(BookmarkList));
%> 