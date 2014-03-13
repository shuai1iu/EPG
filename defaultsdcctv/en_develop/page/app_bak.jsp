<%@ page contentType="text/html; " language="java" pageEncoding="UTF-8" %>
<%@ include file="datajsp/codepage.jsp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="config/config_TrailerInVas.jsp"%>
<%@ include file="OneKeyPlay.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="datajsp/database.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<%
int curindex=0;
curindex=request.getParameter("curindex")!=null?Integer.parseInt(request.getParameter("curindex")):0;
MetaData metadata = new MetaData(request);
ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
ServiceHelp serviceHelp = new ServiceHelp(request);
ArrayList appResult = new ArrayList();

//得到集合
try{
	appResult = new MyUtil(Request).getVasListData("00000100000000090000000000018812",6);
}catch(Exception e){
	System.out.println("该对象不存在");
}

String userTempName = serviceHelp.getUserTemplateName();
String directPageName = "index.jsp";
String path = request.getContextPath();
//@param basePath基本路径
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() +
path + "/jsp/" + userTempName + "/en/"+ directPageName;

UserProfile upf_Jump = new UserProfile(request);
String user = upf_Jump.getUserId();
String groupId =  upf_Jump.getUserGroupId();	
System.out.println("MyGROUPID**********************==========================================================*******"+groupId);
System.out.println(++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++);
System.out.println("***************************++++++++++++++++++++++========================");

String[] vasListPic=new String[10];//图片路径
String[] appUrl = new String[10];	
String[] appIntro = new String[10];	//基本信息
System.out.println("Count:"+appResult.get(0));

%>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
    <meta name="page-view-size" content="640*530"/>
    <title>CCTV-IP电视</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <style type="text/css">
        body {
            background: #0d4764 url("../images/build.jpg") no-repeat;
        }
    </style>
    <script language="javascript" type="text/javascript" src="../js/pagecontrol.js"></script>
    <script language="javascript" type="text/javascript">
	    var  area0 = AreaCreator(1, 1, new Array(-1, -1, -1, -1), "area0_list_", "className:logo", "className:logo");
	    pageobj = new PageObj(0, 0, new Array(area0));
	    pageobj.goBackEvent=function()
        {
           window.location.href="index.jsp?back=1";
        }
	</script>
</head>
<body>
<div class="wrapper">

	<!-- S LOGO -->
    <div class="logo" id="area0_list_0"><img src="../images/logo.png" /></div>
    <!-- E LOGO -->
	
</div>
</body>
</html>
