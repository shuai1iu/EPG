<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ include file="util/util_converString.jsp"%>
<%
	String progId = request.getParameter("PROGID"); //vod节目id
	int iProgId = 0;
	String playType = request.getParameter("PLAYTYPE"); //播放类型
	int iPlayType = 0;	
	String beginTime = request.getParameter("BOOKMARKTIME"); //节目播放开始时间	
	String vasBeginTime = request.getParameter("beginTime");
	String productId = request.getParameter("PRODUCTID"); //订购产品id	
	String serviceId = request.getParameter("SERVICEID"); //对应服务id		
	String contentType = request.getParameter("CONTENTTYPE");
	String vasFlag = request.getParameter("vasFlag"); //增值页面标志位
	String backurl = request.getParameter("backurl"); //如果是从增值服务页面进入的返回url
	String endTime = request.getParameter("ENDTIEM");
	int iPlayBillId = 0; //节目单编号（可选参数），仅当progId是频道时有效，此处只是为满足接口
	try
	{
		iProgId = Integer.parseInt(progId);
		iPlayType = Integer.parseInt(playType);
	}
	catch(Exception e)
	{
		iProgId = -1;
		iPlayType = -1;
	}
	endTime = checkVariable(endTime, "20000");
	beginTime = checkVariable(beginTime, "0");
	productId = checkVariable(productId, "0");
	serviceId = checkVariable(serviceId, "0");
	contentType = checkVariable(contentType, String.valueOf(EPGConstants.CONTENTTYPE_VOD));
	
	ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
	ServiceHelp serviceHelp = new ServiceHelp(request);
	String playUrl = "";
	if( "1".equals(vasFlag))//增值业务使用老接口
	{
		playUrl = serviceHelp.getTriggerPlayUrl(iPlayType,iProgId,"0");
		playUrl = playUrl + "&playseek="+vasBeginTime+"-"+endTime;
	}
	else
	{
		
		playUrl = serviceHelpHWCTC.getTriggerPlayUrlHWCTC(1,iProgId,iPlayBillId,beginTime,endTime,productId,serviceId,contentType);
	
	}
//	System.out.println("[VOD_PLAYURL]=["+playUrl+"]");
	if(playUrl != null && playUrl.length() > 0)
    {
        int tmpPosition = playUrl.indexOf("rtsp");
        if(-1 != tmpPosition)
		{
			playUrl = playUrl.substring(tmpPosition,playUrl.length());
		}
    }
%>
<script>
	parent.playCommonUrl = "<%=playUrl%>";
	parent.loadFlag = 1;
</script>