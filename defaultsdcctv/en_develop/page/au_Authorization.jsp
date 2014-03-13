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
<%@ include file="config/config_PlayFilm.jsp"%>
<html>
<head>
<title>SubscribeSelect</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
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
    //下面开授权

	if ("1".equals(isTVSeriesFlag) || !"-2".equals(sFatherSeriesId)) 
	{
		%>
			<script>
					//alert("isTVSeriesFlag");
			</script>
		<%
		retMap = serviceHelpHWCTC.authorizationHWCTC(fatherSeriesId,playType, contentType, businessType, typesId,fatherSeriesId);
	}
	else if (EPGConstants.PLAYTYPE_VAS == playType) 
	{
		%>
			<script>
					//alert("PLAYTYPE_VAS");
			</script>
		<%
		retMap = serviceHelpHWCTC.authorizationHWCTC(progId, playType, contentType,businessType, typesId, fatherSeriesId);
	} 
	else if (EPGConstants.PLAYTYPE_TVOD == playType) 
	{
		%>
			<script>
					//alert("PLAYTYPE_TVOD");
			</script>
		<%
		retMap = serviceHelpHWCTC.authorizationHWCTC(progId, playType, contentType,businessType, typesId, fatherSeriesId);
	} 
	else 
	{	
	
	    String typeid="00000100000000090000000000001261";
		%>
			<script>
		//	alert("contentType:<%=contentType%> and businessType:<%=businessType%> and typesId;<%=typesId%> and fatherSeriesId:<%=fatherSeriesId%>");
			</script>
		<%
		retMap = serviceHelpHWCTC.authorizationHWCTC(progId, playType,contentType, businessType, typeid, fatherSeriesId);
	}

	int retCode = EPGErrorCode.AUTHORIZATION_DATABASEERROR;   //初始化为数据库异常，防止出现空值
	
	if(null != retMap && null != retMap.get(EPGConstants.KEY_RETCODE))
    {
        retCode = ((Integer)retMap.get(EPGConstants.KEY_RETCODE)).intValue();
    }


//��ѯδ�����İ�
ArrayList monthList = (ArrayList) retMap.get("MONTH_LIST");

Integer mProdIdInt = 0;  //���Ա��������Ŀ
String mProdPrice = "";
String mProdName = "";
if(null != monthList && monthList.size()>0)
{
        Object mProdIdObject = monthList.get(0);
        Map monthMap = null;
        monthMap = (Map)mProdIdObject;

        String mProdId = (String) monthMap.get("PROD_CODE");
        //      δ��������code
        mProdIdInt = Integer.parseInt(mProdId);
        mProdPrice = (String) monthMap.get("PROD_PRICE");
        mProdName = (String) monthMap.get("PROD_NAME");
}
System.out.println("monthList===" + monthList);
System.out.println("mProdIdInt===" + mProdIdInt);
System.out.println("RETCODE===" + retCode);
	
    String pageName ="errorinfo.jsp";
	//retCode = 504;
	if( retCode == 0 )
    {
		//turnPage.removeLast();
		//如果播放一个未到时间的节目单，进入提示页面
		if (contentType == EPGConstants.CONTENTTYPE_PROGRAM)
		{
			String progStartTime = request.getParameter( "PROGSTARTTIME" );
			if (progStartTime == null)
			{
				progStartTime = "";
			}
			String currTime = StringDateUtil.getTodaytimeString("yyyyMMddhhmmss");
			if(currTime.compareTo(progStartTime) < 0)
			{
				pageName = pageName + "?ERROR_ID=32&ERROR_TYPE=2";
				%>
					<jsp:forward page="<%=pageName%>"/>
				<%
			}
		}
		if(out!=null && out.getBufferSize()!=0)
		{
			out.clearBuffer();
		}
		String sProdId = (String) retMap.get("PROD_CODE");
		String sServiceId = (String) retMap.get("SERVICE_CODE");
		String sPrice = (String) retMap.get("PROD_PRICE");
		if(sPrice == null || "".equals(sPrice))
		{
			sPrice = "0";
		}
		sPrice = URLEncoder.encode(sPrice,"UTF-8");
		StringBuffer queryStr = new StringBuffer();
		queryStr.append(request.getQueryString());
		queryStr.append("&PRODUCTID=" ).append(sProdId).append("&SERVICEID=").append(sServiceId).append("&ONECEPRICE=").append(sPrice);
		pageName = "play_pageControl.jsp?" + queryStr.toString();
		%>
		<jsp:forward page="<%= pageName %>" />
        <%
	}
	if (retCode == 0x04010004)//0x04010004：用户不存在或非法用户
	{
		//turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=157";
		%>
		<jsp:forward page="<%=pageName%>"/>
		<%
	}
	else if(isChanSubscribe == -1 && (EPGConstants.PLAYTYPE_LIVE == playType || EPGConstants.PLAYTYPE_VAS == playType))
	{		
		//turnPage.removeLast();				
		request.setAttribute("RETMAP",retMap);
		
		String jumpPage = "au_ReviewOrSubscribe.jsp?" + request.getQueryString();
		%>
		<jsp:forward page="<%=jumpPage%>"/>
		<%
	}
	else if (retCode == 0x07020001)//没有可以订购的产品
	{
		//turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=154";
		%>
		<jsp:forward page="<%=pageName%>"/>
		<%
	}
	else if (retCode == 0x07020100)//0x07020100：数据库异常
	{	
		//turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=155";
		%>
		<jsp:forward page="<%=pageName%>"/>
		<%
	}
	else if (retCode == 0x07020200)//0x07020200：操作超时
	{
		//turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=171";
		%>
		<jsp:forward page="<%=pageName%>"/>
		<%
	}
	else if (retCode == 0x04010899)//0x04010899：用户令牌非法
	{
		//turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=158";
		%>
		<jsp:forward page="<%=pageName%>"/>
		<%
	}
	else if (retCode == 0x07000005) //0x07000005 传入的参数错误
	{	
		//turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=159";
		%>
		<jsp:forward page="<%=pageName%>"/>
		<%
	}
	else if (retCode == 0x07000006) //0x07000006 解码出现异常
	{
		//turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=153";
		//这句打印信息不要删掉，需求就是这样，没有为什么。
		System.out.println("userid="+userId+",stbMac="+stbMac);
		%>
		<script>
			tempKey = Authentication.CTCGetConfig('identityEncode');
			var pageName =  "<%=pageName%>";
			pageName = pageName + "&tempKey="+ tempKey;
			window.location.href = pageName;
		</script>
		<%
	}	
	else if (retCode == 400) //BSS限呼的一个问题
	{
		//turnPage.removeLast();	
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=171";
		%>
		<jsp:forward page="<%=pageName%>"/>
		<%
	}
	//如果是TVOD时跳转到提示页面，不支持在线订购,不能订购该产品，请到营业厅办理或者拨打10000号咨询
	/*else if(EPGConstants.PLAYTYPE_TVOD == playType)
	{
		turnPage.removeLast();
		pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=163";
	%>
	<script>
			<jsp:forward page="<%=pageName%>"/>
	</script>
	<%

	}	*/
	else if (retCode == 0x07020002||retCode ==500||retCode ==501||retCode ==502||retCode ==503||retCode ==504)
	{
		/*ArrayList timeList = (ArrayList) retMap.get("TIMES_LIST");
		ArrayList mouseList = (ArrayList) retMap.get("MONTH_LIST");
		ArrayList pointList = (ArrayList) retMap.get("PREORDERED_PRODLIST");
		boolean flag = false ;
		if(timeList!=null && timeList.size()>0)
		{
			flag = true ;
		}
		if(mouseList!=null && mouseList.size()>0)
		{
			flag = true ;
		}
		if(pointList!=null && pointList.size()>0)
		{
			flag = true ;
		}*/
		if( retCode == 500)
		{
			//turnPage.removeLast();
			pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=135";
		}
		else if(retCode == 501)//产品不存在或状态不可用
		{
			//turnPage.removeLast();
			pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=125";
		} 
		else if(retCode == 502)//服务不存在或状态不可用
		{
			//turnPage.removeLast();
			pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=126";
		}
		else if( retCode == 503)//订购的产品不在使用期内
		{
			//turnPage.removeLast();
			pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=127";
		}
		if(retCode == 504)//用户没有订购相应产品或订购关系已失效或未生效
		{
                    if(4353 == mProdIdInt)
                    {
             System.out.println("PRODINT===" + mProdIdInt);
                        turnPage.removeLast();
                        String goback = turnPage.go(0);
                        String play_url = "../../../defaultsdcctv/en_develop/page/au_PlayFilm.jsp?PROGID="+sProgId;
                        play_url+="&FATHERSERIESID="+sProgId;
                        play_url+="&CONTENTTYPE="+sContentType;
                        play_url+="&BUSINESSTYPE=1";
                        play_url+="&PLAYTYPE=1";
                        pageName = "../../../defaultgdsd/en/page/shouying/page/order.jsp?SUBJECTID="+typesId+"&VODID="+sProgId+"&FATHERID="+sProgId+"&PLAYTYPE=1&CONTENTTYPE="+sContentType+"&BUSINESSTYPE=1";
                        %>
                        <script>
                            var pageName =  "<%=pageName%>";
                            window.location.href = pageName+"&playurl="+escape('<%=play_url%>&returnurl='+escape('<%=goback%>'))+"&returnurl="+escape("<%=goback%>");
                        </script>
                      <%
                    }else
                    {
                          System.out.println("PRodInt===" + mProdIdInt);
			//turnPage.removeLast();
			pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=136";
                    }
		} 
		%>
			<script>
					<jsp:forward page="<%=pageName%>"/>
			</script>
		<%
	}		
	else
	{
		//turnPage.removeLast();		
		pageName = pageName + "?ERROR_TYPE=2&ERROR_ID=26";
	}
%>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="transparent">
    <table width="640" height="530" border="0">
        <tr>
            <td align="center" style="font-size:36px;color:#FFFFFF; font-family:黑体">页面授权处理中. 请稍候...<%=pageName %></td>
        </tr>
    </table>
</body>	
</html>
