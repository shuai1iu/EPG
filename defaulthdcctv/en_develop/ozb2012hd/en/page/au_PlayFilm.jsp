
<!-- FileName:au_playFilm.jsp -->
<%-- 
	本页面用于判断媒体是个否存在及判断是否有父母锁的存在，没有直接进入页面授权，有父母锁走父母锁流程,目前还有判读传递进来的ID的对于的媒体是否过期或者存在的作用
--%>
<%@ page language="java" errorPage="ShowException.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.facade.service.*" %>
<%@page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ include file="config/config_PlayFilm.jsp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ include file="util/save_focus.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<TITLE>PlayFilm</TITLE>
</head>
<%	
//从url获取到progId，playType，contentType，businessType
String sProgId = request.getParameter("PROGID"); 	// 影片ID,	
String sPlayType = request.getParameter("PLAYTYPE");// 播放类型
String sContentType = request.getParameter("CONTENTTYPE"); // 内容类型
String sBusinessType = request.getParameter("BUSINESSTYPE"); // 业务类型	
String goBackUrl=request.getParameter("returnurl");//返回路径
String pageName = "";
TurnPage turnPage = new TurnPage(request);
turnPage.addUrl(goBackUrl);

//验证影片的编号是否为数字 如果不是数字则给出提示
if ( !EPGUtil.strIsNumber(sProgId) || !EPGUtil.strIsNumber(sPlayType)|| !EPGUtil.strIsNumber(sContentType)  || !EPGUtil.strIsNumber(sBusinessType))
{
	%>
	<jsp:forward page="errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=159" />
	<%
}
int progId = Integer.parseInt(sProgId);
int playType = Integer.parseInt(sPlayType);
int contentType = Integer.parseInt(sContentType);    
int businessType = Integer.parseInt(sBusinessType); 

MetaData metaData = new MetaData(request);
ServiceHelp serviceHelp = new ServiceHelp(request);
Map progInfoMap = null;
	
//获取影片的信息 验证影片是否存在  如果不存在给出提示信息，如果存在的话验证父母控制。
if (contentType == EPGConstants.CONTENTTYPE_VOD  || contentType == EPGConstants.CONTENTTYPE_VOD_VIDEO || contentType == EPGConstants.CONTENTTYPE_VOD_AUDIO)    
{
	 %>
	<script>
		alert("我是点播类型");
	</script>
	<%
		progInfoMap = metaData.getVodDetailInfo(progId);//情况一：根据VOD节目编号获取VOD节目详细信息
	 %>
	<script>
		alert("progId---<%=progId%>");
	</script>
	<%
}
else if ( contentType == EPGConstants.CONTENTTYPE_CHANNEL
		|| contentType == EPGConstants.CONTENTTYPE_CHANNEL_VIDEO
		|| contentType == EPGConstants.CONTENTTYPE_CHANNEL_AUDIO)
{
	 %>
	<script>
		alert("我是直播频道的类型");
	</script>
	<%
	progInfoMap = metaData.getChannelInfo(String.valueOf(progId));//情况二：根据频道id获取频道信息
}
else if ( contentType == EPGConstants.CONTENTTYPE_PROGRAM )
{
	%>
	<script>
		alert("我是直节目单的类型");
	</script>
	<%
	progInfoMap = metaData.getProgDetailInfo(progId);//情况三：根据节目单编号获取该节目单详细信息
}
else if ( contentType == EPGConstants.CONTENTTYPE_VAS )
{
	  %>
	<script>
		alert("我增值业务类型");
	</script>
	<%
	progInfoMap = metaData.getVasDetailInfo(progId);//情况四：根据增值业务编号获取增值业务详细信息
}
if ( playType != EPGConstants.PLAYTYPE_ASSESS &&( progInfoMap == null || progInfoMap.size() == 0) )//内容不存在或已过期      
{
	%>
	<script>
		alert("内容不存在或已过期");
		parent.location.href = "errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=70";
	</script>
	<%
}
else  
{
	//内容存在，接下来验证父母控制级别及锁管理
	/***********************判断是否需要父母锁开始************************************/
	/**目前直接屏蔽
	boolean isControlled = true;
	//needPwdBeforeSub 在配置文件config.jsp中配置 0：永远不需要密码，1：一定要密码，2：根据观看级别确定是否需要密码
	if(needPwdBeforeSub == 0)
	{
		isControlled = false;
	}
	else if(needPwdBeforeSub == 1)
	{
		isControlled = true;
	}
	else
	{
		if (playType == EPGConstants.PLAYTYPE_ASSESS)  //片花播放
		{
			int fatherProgId = -1;
			try
			{
				fatherProgId = Integer.parseInt(request.getParameter("FATHERPROGID"));
			}
			catch(Exception e)
			{
				fatherProgId = -1;
			}
			//判断用户播放的节目是否受限
			isControlled = serviceHelp.isControlledOrLocked(true, true, contentType, fatherProgId);
		}
		else
		{
			//判断用户播放的节目是否受限
			isControlled = serviceHelp.isControlledOrLocked(true, true, contentType, progId);
		}
	}  
	**/
	/***********************判断是否需要父母锁结束************************************************/		
	pageName = "au_Authorization.jsp?" + request.getQueryString();
	//pageName = "play_controlVod.jsp?" + request.getQueryString();
	//存在锁管理或父母控制的话进入密码认证页面，不存在的话进入授权认证页面进行授权认证。
	/**目前没有父母锁，因此此段屏蔽
	if ( isControlled )
	{
		pageName = "au_PassCheck.jsp?"+request.getQueryString()+"&returnurl="+pageName ;
		%>
			<jsp:forward page="<%=pageName%>"/>;
		<%
	}
	**/
	%>
	<jsp:forward page="<%=pageName%>"/>;
	<%
}
%>
    <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="transparent">
    <table width="640" height="520" border="0">
        <tr>
            <td align="center" style="font-size:36px;color:#FFFFFF; font-family:黑体">验证处理中. 请稍候...</td>
        </tr>
    </table>
    </body>	
</html>