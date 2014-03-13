<%
/*******
* Date 20131219
* Description 积分商城订购操作页
* Author LS
*******/
%>

<%@ page language="java"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGErrorCode" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.net.URLEncoder"%>
<%@ taglib uri="/WEB-INF/ca.tld" prefix="ca" %>
<html>
<style>
	body,td,th {
	font-family:黑体;
	}
</style>
<head>
<title>EnsureSubscribeResult</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<%
    ServiceHelp serviceHelp = new ServiceHelp(request);
	ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
	MetaData metaData = new MetaData(request);
	
	String isIntegration = request.getParameter("ISINTEGRATION");
	
	//播放类型
	String strPlayType = "";
    strPlayType = request.getParameter("PLAYTYPE");
    //产品的id
	String prodId = "";
    prodId = request.getParameter("PRODUCTID");
    //频道对应的服务编号
	String serviceId = "";
	serviceId = request.getParameter("SERVICEID");
    //价格
	//String prodPrice = request.getParameter("ONECEPRICE");
	//superVodID父集编号 节目所属的栏目，如果为“-1”，表示所有栏目
	int superVodID = -2;
 
    //prodPrice = URLEncoder.encode(prodPrice,"UTF-8");

	// 1表示是从主动订购页进入\
	int returnflag = 0;
	if (request.getParameter("RETURNFLAG") != null && !"".equals(request.getParameter("RETURNFLAG")) && !"null".equals(request.getParameter("RETURNFLAG"))) {
		returnflag = Integer.parseInt((String)request.getParameter("RETURNFLAG"));
	}

	//内容类型
	String contentTypeStr = "";
    contentTypeStr = request.getParameter("CONTENTTYPE");
    // 业务类型
	String businessTypeStr = "";
    businessTypeStr = request.getParameter("BUSINESSTYPE");
	//节目编号，可以是频道和VOD
	String progId = "";
    progId = request.getParameter("PROGID");
	
	//电视剧父集ID
	String sFatherSeriesId = "";
	sFatherSeriesId = request.getParameter("FATHERSERIESID");
	//是否为连续剧标示
	String isTVSeriesFlag = "";
	isTVSeriesFlag = request.getParameter("ISTVSERIESFLAG");
	
	int fatherSeriesId = -2;
	if("1".equals(isTVSeriesFlag))
	{
    	if(null != sFatherSeriesId && !"".equals(sFatherSeriesId))
    	{
    	    fatherSeriesId = Integer.parseInt(sFatherSeriesId);
    	}
	}
    int prodCont = Integer.parseInt(EPGConstants.SUBSCRIPTION_CONTINUEABLE);
    int contentType =  0;
    int businessType =  0;
    int contentId =  0;
    try
    {
        prodCont = Integer.parseInt((String)request.getParameter("SELECTPRODCONT"));
        contentType =  Integer.parseInt(contentTypeStr);
        businessType =  Integer.parseInt(businessTypeStr);
        contentId =  Integer.parseInt(progId);
    }
    catch(Exception e)
    {
        prodCont = Integer.parseInt(EPGConstants.SUBSCRIPTION_CONTINUEABLE);
    }
    
    int playType = EPGConstants.PLAYTYPE_VOD;
    try
    {
        playType = Integer.parseInt(strPlayType);
    }
    catch(Exception e)
    {
        playType = EPGConstants.PLAYTYPE_VOD;
    }
%>    

<ca:updateCAEntitlement playType="<%=playType%>" productId="<%=prodId%>"/>

<%

    String pageName = "subscribe_Failed.jsp";
    TurnPage turnPage = new TurnPage(request);
    //进行产品的订购
    HashMap orderfilm = null;
	//积分订购
	if("1".equals(isIntegration))
	{
		System.out.println("isTVSeriesFlag:isIntegration=1");
                System.out.println("Parameter:ProdId=="+prodId+"|ServiceId="+serviceId+"|continueType="+prodCont+"|ContentType="+contentType+"|ContentId="+contentId+"|BusinessType="+businessType+"|supVod="+fatherSeriesId+"|OrderMode="+3);		
		orderfilm = serviceHelpHWCTC.subscribeHWCTC(prodId, serviceId, prodCont,contentType,contentId,businessType,fatherSeriesId,3);
		System.out.println(orderfilm);
	}
	else if("2".equals(isIntegration))
	{
		System.out.println("isTVSeriesFlag:isIntegration=2");
		orderfilm = serviceHelpHWCTC.subscribeHWCTC(prodId+"", serviceId, prodCont,contentType,contentId,businessType,fatherSeriesId,3);
	}
	//连续剧订购
   	else if("1".equals(isTVSeriesFlag))
	{
		System.out.println("!!!!isTVSeriesFlag:fatherSeriesId=1!!!!");
		orderfilm = serviceHelpHWCTC.subscribeHWCTC(prodId+"", serviceId, prodCont,contentType,contentId,businessType,fatherSeriesId,1);
	}
	//非连续剧的订购
	else
	{
		System.out.println("isTVSeriesFlag:else [normal]");
		orderfilm = serviceHelpHWCTC.subscribeHWCTC(prodId+"", serviceId, prodCont,contentType,contentId,businessType,superVodID,1);
	}

        System.out.println("JIFENDINGGOU==="+orderfilm);	
    int ret_code = ((Integer)orderfilm.get(EPGConstants.KEY_RETCODE)).intValue();
	session.removeAttribute("RETMAPSH");
	//System.out.println("ret_code="+ret_code+"--isIntegration="+isIntegration+"--isTVSeriesFlag="+isTVSeriesFlag);
    //订购成功
    if(ret_code == EPGErrorCode.SUBSCRIPTION_SUCCESSED)
    {
        turnPage.removeLast();
        turnPage.removeLast();
		//turnPage.removeLast();
        if(turnPage.go(0).indexOf("au_ReviewOrSubscribe.jsp")!=-1)
        {
        	turnPage.removeLast();
        }
        if(out!=null && out.getBufferSize()!=0)
        {
        	out.clearBuffer();
        }
		String channelId = "";
        if(contentType == EPGConstants.CONTENTTYPE_PROGRAM &&(businessType == EPGConstants.BUSINESSTYPE_LIVETV
                || businessType ==  EPGConstants.BUSINESSTYPE_NVOD))
        {
            
            HashMap billRecord = metaData.getPlayBillInfo(contentId);
            
            if(null != billRecord)
            {
                channelId = billRecord.get("CHANNELID").toString();
            }
        }
		
        		 //只有播放直播频道的时候才会传CHANTYPE字段，所以如果能得到chanType，说明需要将定购成功后的频道信息写入机顶盒
		 String chanType = "";
		 String userChannelId = "";
         chanType = request.getParameter("CHANTYPE");
		 userChannelId = request.getParameter("USERCHANID");
         //音频或视频频道写入机顶盒
         if(null != chanType && (chanType.equals("1") || chanType.equals("2")))
         {
             HashMap channelInfo = (HashMap)metaData.getChannelInfoHWCTC(progId);
             if(null != channelInfo)
             {
				 
				
				%>
					<script>
						var iRet = Authentication.CTCSetConfig ('Channel','ChannelID="<%=channelInfo.get("ChannelID")%>",
						ChannelName="<%=channelInfo.get("ChannelName")%>",UserChannelID="<%=userChannelId%>",
						ChannelURL="<%=channelInfo.get("ChannelURL")%>",TimeShift="<%=channelInfo.get("TimeShift")%>",
						TimeShiftLength="<%=channelInfo.get("TimeShiftLength")%>",ChannelSDP="<%=channelInfo.get("ChannelSDP")%>",
						TimeShiftURL="<%=channelInfo.get("TimeShiftURL")%>",ChannelType="<%=chanType%>",
						IsHDChannel="<%=channelInfo.get("IsHDChannel")%>",PreviewEnable="<%=channelInfo.get("PreviewEnable")%>",
						ChannelPurchased="<%=channelInfo.get("ChannelPurchased")%>",ChannelLocked="<%=channelInfo.get("ChannelLocked")%>",
						ChannelLogURL="<%=channelInfo.get("ChannelLogURL")%>",PositionX="<%=channelInfo.get("PositionX")%>",
						PositionY="<%=channelInfo.get("PositionY")%>",BeginTime="<%=channelInfo.get("BeginTime")%>",
						Interval="<%=channelInfo.get("Interval")%>",Lasting="<%=channelInfo.get("Lasting")%>",
						ActionType="<%=channelInfo.get("ActionType")%>"');
					</script>
				<%
            }
         }
         //页面频道写入机顶盒
         if(null != chanType && chanType.equals("3"))
         {
             HashMap vasInfo = (HashMap)metaData.getVasDetailInfo(contentId);
			 String vasUrl = "";
             vasUrl = serviceHelp.getVasUrl(contentId);
             String isLock = "0";  //未受控或上锁
             if(null != vasInfo && null != vasUrl)
             {
                 if(serviceHelp.isControlledOrLocked(true,true,EPGConstants.PROGRAMTYPE_VAS,contentId))
                 {
                     isLock = "1";
                 }

				%>
					<script>
						var iRet = Authentication.CTCSetConfig ('Channel','ChannelID="<%=progId%>",
						ChannelName="<%=vasInfo.get("VASNAME")%>",UserChannelID="<%=userChannelId%>",
						ChannelURL="<%=vasUrl%>",TimeShift="<%=String.valueOf(EPGConstants.CHANNEL_ISPLTV_NO)%>",
						TimeShiftLength="0",ChannelSDP="<%=vasUrl%>",TimeShiftURL="<%=vasUrl%>",ChannelType="<%=chanType%>",
						IsHDChannel="<%=String.valueOf(EPGConstants.ISHDCHANNEL_NO)%>",PreviewEnable="<%=String.valueOf(EPGConstants.CHANPREVIEW_YES)%>",
						ChannelPurchased="<%=String.valueOf(EPGConstants.CHANNELSTATUS_NORMAL)%>",ChannelLocked="<%=isLock%>",
						ChannelLogURL="",PositionX="",PositionY="",BeginTime="",Interval="",Lasting="",
						ActionType="<%=String.valueOf(EPGConstants.CHANACTIONTYPE_ADD)%>"');
					</script>
				<%                 
             }
         }
        //订购成功进入要播控分流页面
		StringBuffer queryStr = new StringBuffer();
		queryStr.append(request.getQueryString());
		//为1时返回订购成功提示
		String prevPageUrl = "";


        if(1 == returnflag){
			prevPageUrl = "au_Subscribe_Initiative_Prompt.jsp?" + queryStr.toString();
		
		}
		else{
			prevPageUrl = "subscribe_Success.jsp";
		}
	%>
		<script>
				<jsp:forward page="<%= prevPageUrl %>"/>;
		</script>
		<%
    }
    else
    { 
		if(ret_code == 209)//政企用户不允许订购按次产品
		{
				pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=162";
		} 
		//该用户不支持在线订购
        else if(ret_code == 202)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=151";
        }
		//203 = TEMPLATE_DELETE_FAILED产品将下线，不支持订购
        else if(ret_code == 203)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=122";
        }
		else if(ret_code == EPGErrorCode.SUBSCRIPTION_NETWORKERROR)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=92";
        }
		else if(ret_code == EPGErrorCode.SUBSCRIPTION_FAILED_ALREADYORDER)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=101";
        }
        else if(ret_code == 104)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=101";
        }
		else if(ret_code == 100)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=137";
        }
		else if(ret_code == 101)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=138";
        }
		else if(ret_code == 102)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=139";
        }
		else if(ret_code == 103)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=140";
        }
		else if(ret_code == 105)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=141";
        }
		else if(ret_code == 106)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=142";
        }
		else if(ret_code == 107)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=143";
        }
		else if(ret_code == 108)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=144";
        }
		else if(ret_code == 109)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=145";
        }
		else if(ret_code == 204)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=146";
        }
		else if(ret_code == 205)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=147";
        }
		else if(ret_code == 206)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=148";
        }
		else if(ret_code == 207)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=149";
        }
		else if(ret_code == 208)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=150";
        }
		else if(ret_code == 0x07030001)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=36";
        }
		else if(ret_code ==0x07030100)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=155";
        }
		else if(ret_code ==0x07030200)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=160";
        }
		else if(ret_code ==0x07030300)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=161";
        }
		else if(ret_code ==0x04010004)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=157";
        }
		else if(ret_code ==0x04010899)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=158";
        }
		else if(ret_code ==0x04020888)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=145";
        }
		else if(ret_code ==0x07000005)
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=159";
        }
		else if(ret_code ==210)
		{
			//用户积分点数不够
			pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=166";
		}
		else if(ret_code ==211)
		{
			//产品不支持积分订购
			pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=167";
		}
		else if(ret_code ==212)
		{
			//积分订购处理失败
			pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=168";
		}
		else if(ret_code ==213)
		{
			//不允许退订积分订购的产品
			pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=169";
		}
		else if(ret_code ==215)
		{
			//不允许用积分续订产品
			pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=170";
		}
		else if(ret_code ==400)
		{
			//BSS限呼的一个问题
			pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=171";
		}
        else
        {
        	pageName = pageName+"?ERROR_TYPE=2&ERROR_ID=36";
        }
%>
       <jsp:forward page="<%= pageName %>"/>
<%
    }
%>
<body bgcolor="black">
</body>
</html>
