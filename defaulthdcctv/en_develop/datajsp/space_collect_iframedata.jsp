<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="SubStringFunction.jsp"%>
<%
	int curpage = Integer.parseInt(request.getParameter("curpage"));
    int pos = curpage * 11 - 11;
	MetaData metaData = new MetaData(request);
	ServiceHelp serviceHelp = new ServiceHelp(request);
	//得到收藏列表的数目
	int favLimit = serviceHelp.getFavouriteLimit();	
	ArrayList result=null;
    ArrayList collentList=new ArrayList();
	int countTotal = 0;
	int pagecount=1;
	ArrayList favList = serviceHelp.getFavList();
    if(favList == null)
    {
	   countTotal = 0;
    }
    else
    { 
	   //收藏总数
		countTotal = ((Integer)((HashMap)favList.get(0)).get("COUNTTOTAL")).intValue();
		result = (ArrayList)favList.get(1);
		pagecount=(int)Math.ceil(countTotal/11.0);
    }
	if(countTotal >0)  
	{
		
		for(int i=pos;i<countTotal&&i<(pos+11);i++)
		{   
		
			int tempProgId = ((Integer)((HashMap)result.get(i)).get("PROG_ID")).intValue();
			int tempProgType = ((Integer)((HashMap)result.get(i)).get("PROG_TYPE")).intValue();
			String tempProgName = (String)((HashMap)result.get(i)).get("PROG_NAME");
			String progTime = "";
			//影片是否有效，如果后台去激活后会出现
			String isValid = "1" ;
			//影片无效，给用户提示
			if("".equals(tempProgName))
			{
				isValid = "-1" ;
				tempProgName = "该影片已经过期，请删除";
			}
			else
			{
				Map filmInfoMap = metaData.getVodDetailInfo(tempProgId); 
				if (filmInfoMap != null)
				{
					progTime = String.valueOf(filmInfoMap.get("ELAPSETIME")) + "分钟";
				}
	        }
			HashMap collentobj = new HashMap();
			collentobj.put("progId",tempProgId);  
	        collentobj.put("progType",tempProgType);  
			collentobj.put("progName",tempProgName );  
	        collentobj.put("isValid",isValid); 
			collentobj.put("progTime",progTime );  
	        collentobj.put("collentObjType",1); 
			collentList.add(collentobj);
			collentobj = new HashMap();
		    collentobj.put("progId",tempProgId);  
	        collentobj.put("progType",tempProgType);  
			collentobj.put("progName","删除");  
	        collentobj.put("isValid",isValid); 
			collentobj.put("progTime",progTime );  
	        collentobj.put("collentObjType",2); 
			collentList.add(collentobj);
	    }
	}
	response.getWriter().print(JSONArray.fromObject(collentList));
%>