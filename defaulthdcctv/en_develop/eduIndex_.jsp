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
<%@ include file="config/config_TrailerInVas.jsp"%>
<%@ include file="OneKeyPlay.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="datajsp/database.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<%@ include file="save_focus.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<%
int curindex=0;
curindex=request.getParameter("curindex")!=null?Integer.parseInt(request.getParameter("curindex")):0;
MetaData metadata = new MetaData(request);
ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
ServiceHelp serviceHelp = new ServiceHelp(request);
ArrayList appResult = new ArrayList();
try{
    appResult=new MyUtil(request).getVasListData("10000100000000090000000000035250",6);
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
    tmpimgVas=(ArrayList)metadata.getVasListByTypeId("10000100000000090000000000035250", 6, 0);
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
            appIntro[i] = mapindex.get("INTRODUCE").toString();
            vasListPic[i] =  getPosterPath(postersMap,request,postpath,"0").toString();
            appUrl[i]=serviceHelp.getVasUrl(tempindexvasid).toString();
        }
    }
}

	
	

%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>教育页面_央视高清EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<style>

/*application--------------------------------------------*/
.app-list {
	left: 120px;
	position: absolute;
	top: 108px;
}	
.app-list .item {
	background:url(../images/rank/ranking-list-bg.png) no-repeat;
	height:248px;
	left: 0;
	position: absolute;
	top: 0;
	width:350px;
} 
.app-list .item .icon {
	left: 0px;
	position: absolute;
	top: 0px;
	width:350px;
	height:248px;
	
} 

.app-list .item_focus {
	background:url(images/app_focus.png) no-repeat;
} 


<!--
body{ background1:url(../images/rank/ranking-list-bg.png) no-repeat}
.geton{z-index:3}
.getoff{z-index:1}
-->
</style>
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript">
var returnurl=escape(window.location.href);
var area0;
var applist=eval('('+'<%=appResult.get(0)%>'+')'); 
var vasListPic=new Array();
var appIntro=new Array();
var appUrl=new Array();
var userid_str="<%=user%>";
var STBType =Authentication.CTCGetConfig("STBType");
var groupid = <%=groupId%>;
var basePath = "<%=basePath%>";



<%for(int i = 0; i < vasListPic.length; i++)
  {%>
      vasListPic[<%=i%>] = '<%=vasListPic[i]%>';
<%}
%>

<%for(int i = 0; i < appIntro.length; i++)
  {%>
      appIntro[<%=i%>] = '<%=appIntro[i]%>';
<%}
%>

<%for(int i = 0; i < appUrl.length; i++)
  {%>
     appUrl[<%=i%>] = '<%=appUrl[i]%>';
<%}
%>

window.onload=function()
{
    area0=AreaCreator(2,3,new Array(-1,0,-1,-1),"area0_list_","className:item item_focus","className:item");
    for(var i=0;i<6;i++)
    {
        area0.doms[i].imgdom=$("area0_img_"+i);
    }
    area0.setfocuscircle(0);
    pageobj=new PageObj(0,indexid!=null?parseInt(indexid):0,new Array(area0),null);
    pageobj.backurl = "index.jsp";
   }

function getdata(data)
{
    if(data.length==undefined || data==null || data.length<1)
    {
	area0.datanum =1;
    }
    else
    {
        area0.datanum = data.length;
        for(i=0;i<area0.doms.length;i++)
	{
            if(i<area0.datanum)
            {
                area0.doms[i].updateimg(vasListPic[i]);
                area0.doms[i].youwannauseobj=data[i].VASID;
		if(appIntro[i]==3)//qiezi
		    area0.doms[i].mylink=appUrl[i]+location.href;
		if(appIntro[i]==2)//kalaok
		    area0.doms[i].mylink=appUrl[i]+userid_str+'&endUrl='+location.href; 
		if(appIntro[i]==1)//zhongyou
		    area0.doms[i].mylink=appUrl[i]+STBType+'&user='+userid_str+'&enterURL='+location.href
		appnum = i;
	    }
	    else
            {
	        area0.doms[i].updateimg("#");
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
		<!--焦点 
				class="item item_focus"
			-->
		<div class="item" id="area0_list_0">
			<div class="icon" id="area0_listImg_0"><img id="area0_img_0" width="350" height="248" /></div>
			
		</div>
		<div class="item" style=left:353px;" id="area0_list_0">
			<div class="icon" id="area0_listImg_1"><img id="area0_img_1" width="350" height="248"/></div>
		
		</div>
		<div class="item" style="left:706px;" id="area0_list_2">
			<div class="icon" id="area0_listImg_2"><img id="area0_img_2" width="350" height="248" /></div>
			
		</div>
		<div class="item" style="top:286px;" id="area0_list_3">
			<div class="icon" id="area0_listImg_3"><img id="area0_img_3"width="350" height="248" /></div>
			
		</div>
		 <div class="item" style="top:286px;left:353px" id="area0_list_4">
                        <div class="icon" id="area0_listImg_4"><img id="area0_img_4" width="350" height="248" /></div>
                       
                </div>
	         <div class="item" style="top:286px;left:706px" id="area0_list_5">
                        <div class="icon" id="area0_listImg_5"><img id="area0_img_5" width="350" height="248" /></div>
                        
                </div>	
  </div>
</div>
	
	
	
	

	
	
	
	<!--bottom_notice-->
<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>
    
</div>
<iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="1px" height="1px" ></iframe>
<%@ include file="servertimehelp.jsp" %>
</body>
</html>

