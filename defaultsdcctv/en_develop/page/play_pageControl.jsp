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
	String logicChannelid = request.getParameter("channelNumber");
	int iChannelid=Integer.parseInt(logicChannelid == null || "".equals(logicChannelid)?"0":logicChannelid);
	
    int contentType = Integer.parseInt(sContentType);    
    int businessType = Integer.parseInt(sBusinessType); 
      
	String pageName = "";
	
	String queryStr = request.getQueryString();
	MetaData metaData = new MetaData(request);
	boolean controlflag = false;
	HashMap typeinfomap = metaData.getTypeInfoByTypeId("10000100000000090000000000041210"); //过滤不能直播不能快进频道
	if(typeinfomap!=null){
		  String introduce = (String)typeinfomap.get("TYPE_INTRODUCE");
		  String[] strarray = introduce.split("@");
		  for(int i = 0 ;i < strarray.length; i++){
		  		
				if((iChannelid - 1000) == Integer.parseInt(strarray[i])){
					controlflag = true;
					break;
				}
		  }
		}


    //下面开始根据内容的类型选择不同的播放页面                                                                           
    if (contentType == EPGConstants.CONTENTTYPE_VOD|| contentType == EPGConstants.CONTENTTYPE_VOD_VIDEO|| contentType == EPGConstants.CONTENTTYPE_VOD_AUDIO)       
    {
        pageName = "play_controlVod.jsp?" + queryStr;
    }
    else if (contentType == EPGConstants.CONTENTTYPE_CHANNEL|| contentType == EPGConstants.CONTENTTYPE_CHANNEL_VIDEO|| contentType == EPGConstants.CONTENTTYPE_CHANNEL_AUDIO)  
    {
        %>
		<script>
			alert("------选择跳转指向到直播的播放页面去-------");
		</script>
		<%
		pageName = "play_ControlChannel.jsp?" + queryStr;
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
		if(controlflag){
			pageName = "playTVod.jsp?" + queryStr+"&controlflag=1";
		}else{
			pageName = "playTVod.jsp?" + queryStr+"&controlflag=0";
		}
    }else if (contentType == 7000)
    {
        //回放的节目单
		if(controlflag){
			pageName = "playTVod.jsp?" + queryStr+"&controlflag=1";
		}else{
			pageName = "playTVod.jsp?" + queryStr+"&controlflag=0";
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

	
	
	
	
	
	
