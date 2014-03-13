<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
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
<%@ include file="OneKeyPlay.jsp"%>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="datajsp/database.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="save_focus.jsp"%>
<%
int curindex=0;
curindex=request.getParameter("curindex")!=null?Integer.parseInt(request.getParameter("curindex")):0;
MetaData metadata = new MetaData(request);
ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
ServiceHelp serviceHelp = new ServiceHelp(request);
ArrayList appResult = new ArrayList();
try{
    appResult=new MyUtil(request).getVasListData("10000100000000090000000000035650",6);
}catch(Exception e){
}
Object temp = appResult.get(0);

/**
 *description:ȡ����·��
 */
String userTempName = serviceHelp.getUserTemplateName();
String directPageName = "index.jsp";
String path = request.getContextPath();
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() +
path + "/jsp/" + userTempName + "/en/"+ directPageName;
UserProfile upf_Jump = new UserProfile(request);
String user = upf_Jump.getUserId();
String groupId =  upf_Jump.getUserGroupId();	
System.out.println("MyGROUPID=="+groupId);
String[] vasListPic=new String[10];
String[] appUrl = new String[10];	
String[] appIntro = new String[10];		
ArrayList tmpimgVas = new ArrayList();
try{
    tmpimgVas=(ArrayList)metadata.getVasListByTypeId("10000100000000090000000000035650", 6, 0);
}catch(Exception e){
}
if(tmpimgVas!=null && tmpimgVas.size()>1)
{
    ArrayList tmpVasList = (ArrayList)tmpimgVas.get(1);
    if(tmpVasList!=null && tmpVasList.size()>0)
    {
        for(int i=0;i<tmpVasList.size();i++)
        {
            HashMap mapindexx=(HashMap)tmpVasList.get(i);
            int tempindexvasid=(Integer)mapindexx.get("VASID");
            Map mapindex = metadata.getVasDetailInfo(tempindexvasid);
            HashMap postersMap = (HashMap)mapindex.get("POSTERPATHS");
            String postpath = (String)mapindex.get("POSTERPATH");
//            appIntro[i] = mapindex.get("INTRODUCE").toString();
            vasListPic[i] =  getPosterPath(postersMap,request,postpath,"0").toString();
            appUrl[i]=serviceHelp.getVasUrl(tempindexvasid).toString();
        }
    }
}
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>EduIndex_EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<style>
/*application--------------------------------------------*/
.app-list {
	left: 30px;
	position: absolute;
	top: 108px;
}	
.app-list .item {
	background:url(../images/rank/ranking-list-bg.png) no-repeat;
	height:255px;
	left: 0;
	position: absolute;
	top: 0;
	width:380px;
} 
.app-list .item .icon {
	left: 16px;
	position: absolute;
	top: 15px;
	width:380px;
	height:255px;
	
} 

.app-list .item_focus {
	background:url(images/edu_focus.png) no-repeat;
	z-index:2;
        height:285px;
        width:420px;
} 

</style>
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript">
var returnurl=escape(window.location.href);
var area1;
var applist=eval('('+'<%=appResult.get(0)%>'+')'); 
var vasListPic=new Array();
var appUrl=new Array();
var userid_str="<%=user%>";
var STBType =Authentication.CTCGetConfig("STBType");
var groupid = <%=groupId%>;
alert("ok");
var basePath = "<%=basePath%>";
<%for(int i = 0; i < vasListPic.length; i++)
  {%>
      vasListPic[<%=i%>] = '<%=vasListPic[i]%>';
<%}
%>
<%for(int i = 0; i < appUrl.length; i++)
  {%>
     appUrl[<%=i%>] = '<%=appUrl[i]%>';
<%}
%>

window.onload=function()
{
    area1=AreaCreator(2,3,new Array(-1,-1,-1,-1),"area1_list_","className:item item_focus","className:item");
    for(var i=0;i<6;i++)
    {
        area1.doms[i].imgdom=$("area1_img_"+i);
    }
    area1.setfocuscircle(0);
    pageobj=new PageObj(0,indexid!=null?parseInt(indexid):0,new Array(area1),null);
    pageobj.backurl = "index.jsp";
    getdata(applist); 
}

function getdata(data)
{
    if(data.length==undefined || data==null || data.length<1)
    {
	area1.datanum =1;
    }
    else
    {
        area1.datanum = data.length;
        for(i=0;i<area1.doms.length;i++)
	{
            if(i<area1.datanum)
            {
                area1.doms[i].updateimg(vasListPic[i]);
                area1.doms[i].youwannauseobj=data[i].VASID;
		        area1.doms[i].mylink="../../"+appUrl[i];//+location.href;
	         }
	    else
            {
	        area1.doms[i].updateimg("#");
	        }
	}
    }
}

</script>
</head>

<body style="background:url(images/edu/bg.png); background-color:transparent;">
<div class="main">
	
	<!--mid-->
	<div class="app-list">
		<div class="item" id="area1_list_0">
			<div class="icon" id="area1_listImg_0"><img id="area1_img_0" width="380" height="255" /></div>
		</div>
		<div class="item" style=left:400px;" id="area1_list_1">
			<div class="icon" id="area1_listImg_1"><img id="area1_img_1" width="380" height="255" /></div>
		</div>
		<div class="item" style="left:800px;" id="area1_list_2">
			<div class="icon" id="area1_listImg_2"><img id="area1_img_2" width="380" height="255" /></div>
		</div>
		<div class="item" style="top:286px;" id="area1_list_3">
			<div class="icon" id="area1_listImg_3"><img id="area1_img_3" width="380" height="255" /></div>
		</div>
		 <div class="item" style="top:286px;left:400px" id="area1_list_4">
                        <div class="icon" id="area1_listImg_4"><img id="area1_img_4" width="380" height="255" /></div>
                </div>
	         <div class="item" style="top:286px;left:800px" id="area1_list_5">
                        <div class="icon" id="area1_listImg_5"><img id="area1_img_5" width="380" height="255" /></div>
                </div>	
  </div>
</div>
    
</div>
<%@ include file="servertimehelp.jsp" %>
</body>
</html>

