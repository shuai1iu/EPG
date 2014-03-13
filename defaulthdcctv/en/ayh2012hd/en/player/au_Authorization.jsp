<!-- FileName:au_Authorization.jsp -->
<%-- 
	本页面用授权
--%>
<%@ page language="java" errorPage="ShowException.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC"%>
<%@ page import="com.huawei.iptvmw.epg.bean.func.UserService" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGErrorCode" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="java.net.URLEncoder"%>
<%@ taglib uri="/WEB-INF/ca.tld" prefix="ca" %>
<html>
<head>
<title>SubscribeSelect</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<%!
	//配置进入订购前是否需要密码，0：永远不需要密码，1：一定要密码，2：根据观看级别确定是否需要密码
	final static int needPwdBeforeSub = 2;
	//展示订购列表时的配置 0:表示只展示按次产品, 1:表示只展示包时长产品, 2:只展示积分消费,3:表示展示所有产品
	int showType = 3;
	//频道是否支持在线包月订购，-1：不支持，1：支持
	int isChanSubscribe = 1;
%>
<%
    TurnPage turnPage = new TurnPage(request);
	turnPage.addUrl();
	ServiceHelp serviceHelp = new ServiceHelp(request);
	ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
	//是否可以预览 1，支持，0不支持
	String sPreviewAble = request.getParameter("PREVIEWFLAG");
	int previewAble = 0 ;
	try
	{
		 previewAble = Integer.parseInt(sPreviewAble);
	}
	catch(Exception e)
	{
		previewAble = 0 ;
	}
	//是否为预览的标示位
	String pigFlag = request.getParameter("PIGFLAG");
	
	//回看节目单过来的时候的频道ID
	String strProChanID = request.getParameter("CHANNELID");
	//要跳转的页面
    String playPageUrl = turnPage.go(0);
	//栏目号
	String typesId = request.getParameter("TYPE_ID")==null?"-1":"null".equals(request.getParameter("TYPE_ID"))?"-1":request.getParameter("TYPE_ID");
	//要播放影片的id
    String sProgId = request.getParameter("PROGID"); 
	//电视剧父集ID
	String sFatherSeriesId = request.getParameter("FATHERSERIESID")==null?"-2":"null".equals(request.getParameter("FATHERSERIESID"))?"-2":"-1".equals(request.getParameter("FATHERSERIESID"))?"-2":request.getParameter("FATHERSERIESID");
    // 播放类型  内容类型 业务类型  
    String sPlayType = request.getParameter("PLAYTYPE");
    String sContentType = request.getParameter("CONTENTTYPE");
    String sBusinessType = request.getParameter("BUSINESSTYPE");
    //是否续订标示
	String programOrder = request.getParameter("PROGRAM_ORDER");
    //电视剧标志
	String isTVSeriesFlag = request.getParameter("ISTVSERIESFLAG");
	int proChanID = -1;
	if(strProChanID != null) //回看节目的频道
	{
		proChanID = Integer.parseInt(strProChanID);
	}
    int progId = Integer.parseInt(sProgId);
    int playType = Integer.parseInt(sPlayType);
    int contentType = Integer.parseInt(sContentType);
    int businessType = Integer.parseInt(sBusinessType);
	int fatherSeriesId = -2;
	if ("1".equals(isTVSeriesFlag) || !"-2".equals(sFatherSeriesId)) 
	{
		if (null != sFatherSeriesId && !"".equals(sFatherSeriesId)) 
		{
			fatherSeriesId = Integer.parseInt(sFatherSeriesId);
		}
	}
	//以上部分都是在获取参数值
    String serviceType = (String)session.getAttribute("SERVICETYPE");
    
    if ( serviceType == null || serviceType.trim().length() == 0 )
    {
        serviceType = "-1";
		session.setAttribute("SERVICETYPE","-1");
    }
	serviceType = "-1";
	
	%>
    <!--更新数字证书授权-->
	<ca:updateCAEntitlement playType="<%=playType%>" progId="<%=progId%>"/>
	<%
	//再把progId还原成录播频道的节目单ID
    progId = Integer.parseInt(sProgId);
    if(contentType == EPGConstants.CONTENTTYPE_PROGRAM &&(businessType == EPGConstants.BUSINESSTYPE_LIVETV|| businessType ==  EPGConstants.BUSINESSTYPE_NVOD))     
    {
		
		%>
		<script>
			//alert("录播频道的节目单");
		</script>
		<%
		//增加页面超时的异常保护
		if(null != programOrder && programOrder.equalsIgnoreCase("false")&& serviceHelp.isSubscribeProgram(progId,contentType,businessType))	
		{
			programOrder = "true";
			%> 
			 <jsp:forward page="<%=turnPage.go(0)%>"/>
			<%
		}
    }
	UserService userService = new UserService(request);
	UserProfile userProfile = new UserProfile(request);
	String userId = userProfile.getUserId();
	String userToken = userProfile.getUserToken();
	String stbMac = userProfile.getSTBMAC();
	int lang = userProfile.getLang();
	String stbIp = userProfile.getStbIp();
	Map retMap = null;
  
    String pageName ="errorinfo.jsp";

	StringBuffer queryStr = new StringBuffer();
	queryStr.append(request.getQueryString());

	pageName = "play_pageControl.jsp?" + queryStr.toString();
	%>
	<jsp:forward page="<%= pageName %>" />
	<%
	
%>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="transparent">
    <table width="640" height="530" border="0">
        <tr>
            <td align="center" style="font-size:36px;color:#FFFFFF; font-family:黑体">页面授权处理中. 请稍候...</td>
        </tr>
    </table>
</body>	
</html>