<!-- Copyright (C), pukka Tech. Co., Ltd. -->
<!-- Author:mxr -->
<!-- ModifBy:20110727 -->
<!-- FileName:play_pageControl.jsp -->
<%-- 
	本页面用于根据播放类型控制播放跳转的页
--%>
<%@ page language="java" errorPage="ShowException.jsp" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<script type="text/javascript" src="js/cookie.js"></script>
<%	
	ServiceHelp serviceHelp = new ServiceHelp(request);
	//内容类型
	String sContentType = request.getParameter("CONTENTTYPE");
	//业务类型
	String sBusinessType = request.getParameter("BUSINESSTYPE");
	//url special链接
	String specialUrl = request.getParameter("specialUrl");
	String logicChannelid = request.getParameter("LOGICCHANNELID");

	//传入产品包ID辅助鉴权页面跳转至play_controlVod_Check 鉴权通过的尊享包页面无此参数
	String sProductId = "";
	System.out.println("!!!!!!!!!!!!!!sProdductId!!!!!!!!!!!!"+sProductId);	
	sProductId = request.getParameter("VIPPRODUCTID");
	int productId = 0;
	if(sProductId != null)
	{
		productId =  Integer.parseInt(sProductId);
	}
	System.out.println("!!!!!!!!!!!!!!AAaAAAAAAAAAAA!!!!!!!!!!!!!"+productId);

	MetaData metaData = new MetaData(request);	
	boolean controlflag = false;
	HashMap typeinfomap = metaData.getTypeInfoByTypeId("10000100000000090000000000041210"); //过滤不能直播不能快进频道
	
	int contentType = Integer.parseInt(sContentType);    
	int businessType = Integer.parseInt(sBusinessType); 
	
	String pageName = "";
	
	String queryStr = request.getQueryString();
	
	
	//下面开始根据内容的类型选择不同的播放页面                                                                           
	if (contentType == EPGConstants.CONTENTTYPE_VOD|| contentType == EPGConstants.CONTENTTYPE_VOD_VIDEO|| contentType == EPGConstants.CONTENTTYPE_VOD_AUDIO)  
	{
		//判断是否从主动订购进入
		String INITFLAG = "0";
		int initFlag = 0;
		if (request.getParameter("INITFLAG") != null && !"".equals(request.getParameter("INITFLAG")) && !"null".equals(request.getParameter("INITFLAG"))) {
			INITFLAG = request.getParameter("INITFLAG");
		}
		try{
			initFlag = Integer.parseInt(INITFLAG);
		}catch(Exception e){
		}
		if(initFlag == 1){
			if(productId == 4201 || productId == 420101){
				pageName = "au_Subscribe_Initiative.jsp?" + queryStr;
			}else
			{
				pageName = "au_Subscribe_Initiative_Prompt.jsp?" + queryStr;
			}
		}else{
			if(productId == 4201 || productId == 420101)
			{
				pageName = "play_controlVod_Check.jsp?" + queryStr;
			}else
			{
				pageName = "play_controlVod.jsp?" + queryStr;
			}
		}
			System.out.println("pageName:"+pageName);	
	
	}
	else if (contentType == EPGConstants.CONTENTTYPE_CHANNEL|| contentType == EPGConstants.CONTENTTYPE_CHANNEL_VIDEO|| contentType == EPGConstants.CONTENTTYPE_CHANNEL_AUDIO)  
	{
		%>
		<script>
		//alert("------选择跳转指向到直播的播放页面去-------");
		</script>
		<%
		System.out.println("play_pageControl:CONTENTTYPE_CHANNEL:"+queryStr);
		//广告屏蔽 
		String sAllowAD = request.getParameter("ALLOWAD");
		int iAllowAD = 1;
		if(null != sAllowAD && !"".equals(sAllowAD))
			iAllowAD = Integer.parseInt(sAllowAD);  
		else
			iAllowAD = 1;	//default for play_ControlChannel.jsp
			
		if (iAllowAD == 0)
			pageName = "play_ControlChannel_sz.jsp?" + queryStr;	//包含广告保护逻辑
		else
			pageName = "play_ControlChannel.jsp?" + queryStr;		//不保护广告
		//pageName="play_ControlChannel.jsp?CHANNELNUM=11&COMEFROMFLAG=0&ISSUB=0&PREVIEWFLAG=0";
	}
	else if (contentType == EPGConstants.CONTENTTYPE_VAS)
	{
		// 如果为增值业务
		if(null == specialUrl)
		{
			//获取增值业务的URL，如果为空将提示用户精彩节目即将播出。
			String chanId = request.getParameter("PROGID");
			int progId = Integer.parseInt(chanId);
			String url = (String)serviceHelp.getVasUrl(progId);
			specialUrl = url ;
			pageName = "play_ControlWebChannel.jsp?jumuUrl=" +url ;
		}
		else
		{
			pageName = specialUrl + "?ISFIRST=1";
		}
	}
	else if (contentType == EPGConstants.CONTENTTYPE_PROGRAM)
	{
		//回放的节目单	  
		//String logicChlid = request.getParameter("LOGICCHANNELID");
		//	System.out.println("**play_pageControl***CONTENTTYPE_PROGRAM*****:"+logicChannelid);
		int iChannelid=Integer.parseInt(logicChannelid == null || "".equals(logicChannelid)?"0":logicChannelid);
	
		if(typeinfomap!=null){
			String introduce = (String)typeinfomap.get("TYPE_INTRODUCE");
			String[] strarray = introduce.split("@");
			for(int i = 0 ;i < strarray.length; i++){
				//	System.out.println("*****num=*****"+strarray[i]);
				if(iChannelid == Integer.parseInt(strarray[i])){
					controlflag = true;
					break;
				}
			}
		}
		if(controlflag)
		{
			//System.out.println("*****play_controlTVod_sz*****");
			pageName = "play_controlTVod_sz.jsp?" + queryStr;
		}
		else
		{
			pageName = "play_controlTVod.jsp?" + queryStr;
		}
	
	}
	else
	{
		pageName = "errorinfo.jsp?ERROR_ID=46&ERROR_TYPE=2";
	}
%>
<script>
	//alert("<%=pageName%>");
</script>
	<jsp:forward page="<%=pageName %>" />
<%

%>





	
	
