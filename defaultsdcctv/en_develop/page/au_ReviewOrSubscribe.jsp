<%-- Copyright (C), pukka Tech. Co., Ltd. --%>
<%-- Author:mxr --%>
<%-- CreateAt:20110802 --%>
<%-- FileName:an_RevieworSubscribe.jsp --%>
<%-- 
	本页面判断是否可以预览和或者是否已经订购
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" buffer="32kb" %>
<%@ page errorPage="ShowException.jsp"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGSysParam"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGErrorCode" %>
<%@ include file="datajsp/SubStringFunction.jsp"%>
<%@ include file="keyboard/keydefine.jsp"%>
<%@ include file = "OneKeySwitch.jsp" %>
<%@ include file="config/config_PlayFilm.jsp"%>
 <%@ include file="util/save_focus.jsp"%>
<html>
<link href="./css/stylesheet.css" rel="stylesheet" type="text/css">
<head>
<style>
	body
	{
		color:white;
	}
</style>
<script>
if(typeof(iPanel) != 'undefined')
{
	iPanel.firstLinkFocus=0;  
}
var divStr = "";
var previewFlag = false;
var flag = 0;
</script>
<%
	TurnPage turnPage = new TurnPage(request);
	String strBackUrl = request.getParameter("returnurl");
	if(strBackUrl!=""&&strBackUrl!=null)
	{
		//strBackUrl +="&back=1";
		turnPage.addUrl(strBackUrl);
	}
	String qureyString = request.getQueryString();
	String[] strInfo = turnPage.getPreFoucs();
	int progIndex = 0;
	if(strInfo != null && strInfo.length == 1)
	{	
		if(strInfo[0] != null)
		{
			progIndex = Integer.parseInt(strInfo[0]);
		}
	}
	String strprogid = (String)request.getParameter("PROGID");
	MetaData metaData = new MetaData(request);
	//直播直播图片路径
	String PICTURE = "";
	//直播简介
	String INTRODUCE="";
	String ChannelPurchased = "0";
	String StrTemp = "该直播暂无简介";

	HashMap chanInfo = new HashMap();
	HashMap chanInfoHW = new HashMap();
	chanInfo = metaData.getChannelInfo(strprogid);	
	if(chanInfo != null)
	{
		INTRODUCE = (String)chanInfo.get("INTRODUCE");
		PICTURE = (String)chanInfo.get("LOGOURL");
	}	
	if(INTRODUCE!=null && !INTRODUCE.equals(""))
	{
		StrTemp = subStringFunction(INTRODUCE,4,265);
	}
	
	ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
	String playBillId = request.getParameter( "PROGID" );
	
    if (playBillId == null)
    {
        playBillId = "";
    }
    else
    {
        playBillId = playBillId.trim();
    }

	String sProgId = request.getParameter("PROGID"); 
	int progId = Integer.parseInt(sProgId);
	String sPlayType = request.getParameter("PLAYTYPE");
	int playType = Integer.parseInt(sPlayType);
	String sContentType = request.getParameter("CONTENTTYPE");
	int contentType = Integer.parseInt(sContentType);
	String sBusinessType = request.getParameter("BUSINESSTYPE");	
	int businessType = Integer.parseInt(sBusinessType);
	//是否可以预览 1，支持，0不支持
	String XqureyString="";
	String sPreviewAble = request.getParameter("PREVIEWFLAG");
	
	if (contentType == EPGConstants.CONTENTTYPE_CHANNEL
                 || contentType == EPGConstants.CONTENTTYPE_CHANNEL_VIDEO
                 || contentType == EPGConstants.CONTENTTYPE_CHANNEL_AUDIO)
    {
	       String[] tempFocus = new String[]{};
	       tempFocus =qureyString.split("&");
		   for(int i=0;i<tempFocus.length;i++)
		   {
		       if(i==5)
			   {
			       continue;
			   }
			   if(i<tempFocus.length-1)
			   {
			       XqureyString+=tempFocus[i]+"&";
			   }
			   else if(i==tempFocus.length-1)
			   {
			       XqureyString+=tempFocus[i];
			   }
		       
		   }     
    } 
	else
	{
	    XqureyString=qureyString;
	}
	//是否可以预览 1，已订购，0未订购
	//String isSubscribe = request.getParameter("ISSUB");
	String isSubscribe = "0";
	
	String tvod = request.getParameter("TVOD");

	//栏目号
	String typesId = request.getParameter("TYPE_ID")==null?"-1":"null".equals(request.getParameter("TYPE_ID"))?"-1":request.getParameter("TYPE_ID");
	//电视剧父集ID
	String sFatherSeriesId = request.getParameter("FATHERSERIESID")==null?"-2":"null".equals(request.getParameter("FATHERSERIESID"))?"-2":"-1".equals(request.getParameter("FATHERSERIESID"))?"-2":request.getParameter("FATHERSERIESID");
	//电视剧标志
	String isTVSeriesFlag = request.getParameter("ISTVSERIESFLAG");
	
	int fatherSeriesId = -2;
	if ("1".equals(isTVSeriesFlag) || !"-2".equals(sFatherSeriesId)) 
	{
		if (null != sFatherSeriesId && !"".equals(sFatherSeriesId)) 
		{
			fatherSeriesId = Integer.parseInt(sFatherSeriesId);
		}
	}
	
	//自己判断是否订购，不用传过来的是否订购标志
	Map retMap = null;
	
	retMap = serviceHelpHWCTC.authorizationHWCTC(progId, playType, contentType,businessType, typesId, fatherSeriesId);
	
	int retCode = EPGErrorCode.AUTHORIZATION_DATABASEERROR;   //初始化为数据库异常，防止出现空值

	if(null != retMap && null != retMap.get(EPGConstants.KEY_RETCODE))
    {
        retCode = ((Integer)retMap.get(EPGConstants.KEY_RETCODE)).intValue();
    }
	
	if( retCode == EPGErrorCode.SUCCESS ) isSubscribe ="1";


	//isSubscribe = "0"; 
	int previewAble = 0 ;
	try
	{
		 previewAble = Integer.parseInt(sPreviewAble);
	}
	catch(Exception e)
	{
		previewAble = 0 ;
	}
	//已订购 或者如果是回放节目单，则略过此页面
	if(isSubscribe.equals("1") || "1".equals(tvod))
	{	
		String pageName = "au_PlayFilm.jsp?" + qureyString;
		turnPage.removeLast();	
		%>
			 <jsp:forward page="<%=pageName%>"/>
		<%	
	}//支持预览
	else if(previewAble == 1)
	{
		%>
		<script>
			previewFlag = true;
        </script>
		<%
	}//不支持预览
	else if(previewAble != 1)
	{	
		%>
		<script>  
			previewFlag = false;
			flag =1;
        </script>
		<%		
	}
%>

<script>
<!--
	if(typeof(iPanel) != 'undefined')
	{
		iPanel.firstLinkFocus=0;  
	}
	
    document.onirkeypress = keyEvent;
    document.onkeypress = keyEvent;
    function keyEvent()
    {
        var val = event.which ;
        return keypress(val);
    }
    function keypress(key_val)
    {
       
     }
	
	function pressKey_left()
	{	
	
	}
	function pressKey_right()
	{	
		
	}
	
	
    function FocusRem()
    {	
		
    }
    
	function goPreview()
	{
		
	}
	function goSubscribe()
	{
		
	}
	
	function goBack()
    {
       
    }
	
    function setFocus(elm)
    {	
		
    }

	function freeFocus(elm)
	{	
		
	}
    /**
     *初始化页面
    */	
	function init_page()
    {
		
    }
	
	function initButton(elm)
	{		
		
	}
	
   -->
</script>

</head>
<body  topmargin="0" bottommargin="0" leftmargin="0" rightmargin="0" background="#" onLoad="">

</body>
<div style=" visibility:hidden">

</div>

</html>
