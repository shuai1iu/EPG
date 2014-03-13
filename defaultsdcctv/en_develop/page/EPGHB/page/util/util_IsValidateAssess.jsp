<%-- Copyright (C), Huawei Tech. Co., Ltd. --%>
<!-- Author:weizhigang44037 -->
<%-- CreateAt:2007-11-12 --%>
<%-- FileName:CategorySubject.jsp --%>

<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGErrorCode" %>


<%!
	//测试片花的播放路径是否正确		
	private boolean isValidAssess(String AssessId,HttpServletRequest request)
	{
	    if(AssessId == null)
		{
		    return false;
		}
		String  progId = AssessId;
		boolean flag = false;  //结果的返回值
		int     iProgId = -1;
		try
		{
			iProgId = Integer.parseInt(progId);
		}
		catch(Exception e)
		{
			flag = false;
			return flag;
		}
		if(iProgId == -1)
		{
		  	flag = false;
			return flag;
		}
		//是否支持高清 0:表示不支持高清 1:表示支持高清
		String supportHD = "0" ;
		try
		{
			supportHD = (String)request.getSession().getAttribute("SupportHD")==null?"0":(String)request.getSession().getAttribute("SupportHD");
		}
		catch(Exception ee)
		{
			supportHD = "0" ;
		}
		
		//片花的高清处理
		MetaData metaData = new MetaData(request);
		// 调用MetaData获取影片详细信息
		Map filmInfoMap = metaData.getVodDetailInfo(iProgId);
		if(filmInfoMap != null && filmInfoMap.size() != 0 )
		{
		   String definition = filmInfoMap.get("DEFINITION").toString().trim();
		   if("1".equals(definition) && "0".equals(supportHD))
		   {
		        flag = false;
				return flag;
		   }
		}
		else
		{
		    //该片花不存在
		    flag = false;
			return flag;
		}
		//当STB支持高清，或者该STB不支持高清并且该片花不是高清时进行下边的操作；
		
		//片花高清处理的结束
		
		ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
	
		int     iPlayType     = EPGConstants.PLAYTYPE_ASSESS;
		int     icontentType  = EPGConstants.CONTENTTYPE_VOD;
		int     ibusinessType = EPGConstants.BUSINESSTYPE_VOD;         
		
		String productId = "-1";	
		String serviceId = "-1";			
		
		String  endTime = "20000"; //播放结束时间
		int     iPlayBillId = 0; //节目单编号（可选参数），仅当progId是频道时有效，此处只是为满足接
		String	beginTime = "0";
		String  playUrl = serviceHelpHWCTC.getTriggerPlayUrlHWCTC(iPlayType,iProgId,iPlayBillId,beginTime,endTime,productId,serviceId,String.valueOf(icontentType));	
		if(playUrl != null && playUrl.length() > 0)
    	{
            int tmpPosition = playUrl.indexOf("rtsp");
			if(-1 != tmpPosition)
			{
			     flag = true;
			}
			else
			{
				 flag  = false;
			}
		}
		else
		{
			 flag  = false;
		}
		
	    return flag;
	}
%>
