<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ include file="codepage.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>深圳活动EPG 3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
</head>

<body bgcolor="transparent" onLoad="goVas()">
<%

//判断是否尊享包
    MetaData metadata = new MetaData(request);
    ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);

        //尊享整包
        String zxprodid="";
        String zxproname="";
        String zxservercode="";
        String zxprice="0";
        int iszxorder=0;
        HashMap zxresultMap = new HashMap();
        HashMap zxmediadetailInfo = (HashMap)metadata.getVodDetailInfo(zxvod);
        int zxcontenttype= Integer.parseInt(zxmediadetailInfo.get("CONTENTTYPE").toString());
        zxresultMap = serviceHelpHWCTC.authorizationHWCTC(zxvod,1, zxcontenttype,1,"",zxvod);
        int zxretCode = 1;   //初始化为数据库异常，防止出现空值
        ArrayList zxmouseList = new ArrayList();
        if(null != zxresultMap && null != zxresultMap.get(EPGConstants.KEY_RETCODE))
        {
           zxretCode = ((Integer)zxresultMap.get(EPGConstants.KEY_RETCODE)).intValue();
        }
        if(zxretCode == 504){
                 iszxorder=1;
        }else{
                 iszxorder=0;
        }




String targetUrl = request.getParameter("TARGETURL");
String pageId = request.getParameter("pageId");
String returnUrl = "";
UserProfile upf_Jump = new UserProfile(request);
String user = upf_Jump.getUserId();
ServiceHelp serviceHelp_Jump = new ServiceHelp(request);
String userToken = upf_Jump.getUserToken();
System.out.println(userToken);

//获取本地服务器地址
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/jsp/defaulthdcctv/en/index.jsp";
String localIP = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/jsp/defaulthdcctv/en/";
String itvUserId = (String)session.getAttribute("USERID");

    if (request.getParameter("returnurl") != null && !"".equals(request.getParameter("returnurl")) && !"null".equals(request.getParameter("returnurl")))
    {
        returnUrl = localIP + request.getParameter("returnurl");
    }
    else
    {
        returnUrl = localIP+"SZ_EPG/page/index.jsp";
     }


%>
<!--menu-->
	<div class="menu">
	</div>
<!--the end-->
<script>

var targetUrl = unescape(<%=targetUrl%>);

if (typeof(iPanel) != 'undefined')
{
	iPanel.focusWidth = 4;
	iPanel.defaultFocusColor = "#FCFF05";
}
document.onkeypress = keyEvent;
function keyEvent()
{
var val = event.which ? event.which : event.keyCode;
return keypress(val);
}
function keypress(keyval)
{
	switch(keyval)
	{
		
		case 8:
		goBack();
		return 1; 
		break;
		default:
		return 1;
	
	} 
}
function goBack(){
	backUrl = "../../special_topic.jsp";
	location.href = backUrl ;
}
function goVas(){
/**
	* Title 可配置入口地址的活动页面
	* Author LS
	* Date 2013-11-05
**/
if(<%=iszxorder%>==1)
{
	location.href="http://219.133.42.109:1137/VasPGOrder/page/once-buy.jsp?localIp=<%=localIP%>&userId=<%=itvUserId%>&userToken=<%=userToken%>&backUrl=<%=returnUrl%>&pageId=<%=pageId%>";  //可配置入口定制
}else
{
          location.href="buy-tipslast.jsp";
}

}
</script>
</body>
</html>
