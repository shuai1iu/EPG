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
 *description:È¡±¾µØÂ·¾¶
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
<title>æ’è¡Œæ¦œ-ç‚¹æ’­-ç”µå½±62_å¤®è§†é«˜æ¸…EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<style>

/*application--------------------------------------------*/
.app-list {
	left: 321px;
	position: absolute;
	top: 108px;
}	
.app-list .item {
	background:url(../images/rank/ranking-list-bg.png) no-repeat;
	height:248px;
	left: 0;
	position: absolute;
	top: 0;
	width:274px;
} 
.app-list .item .icon {
	left: 15px;
	position: absolute;
	top: 15px;
	width:230px;
	height:100px;
	
} 
.app-list .item .txt {
	font-size:30px;
	height:36px;
	line-height:36px;
	left: 20px;
	position: absolute;
	top: 200px;
	width:230px;
	text-align:center;
} 
.app-list .item_focus {
	background:url(images/app_focus.png) no-repeat;
} 


<!--
body{ background1:url(images/mainbg_index.png) no-repeat}
.geton{z-index:3}
.getoff{z-index:1}
-->
</style>
<script type="text/javascript" src="js/gstatj.js"></script>
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript">
var returnurl=escape(window.location.href);
var area0;
var area1;
var applist=eval('('+'<%=appResult.get(0)%>'+')'); 
var vasListPic=new Array();
var appIntro=new Array();
var appUrl=new Array();
var userid_str="<%=user%>";
var STBType =Authentication.CTCGetConfig("STBType");
var groupid = <%=groupId%>;
var basePath = "<%=basePath%>";
var appShowName = "";
var appnum = 0; //·ÇĞĞÒµÓ¦ÓÃÊıÁ¿
var industryAppUrl = "";

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
    gstaFun(userid_str,645);
    area0=AreaCreator(10,1,new Array(-1,-1,-1,1),"area0_list_","className:menuli on","className:menuli");
    area0.setstaystyle("className:menuli current",3);
    area0.doms[0].mylink=indexhref[0];
    area0.doms[1].mylink=indexhref[1];
    area0.doms[2].mylink=indexhref[2];
    area0.doms[3].mylink=indexhref[3];
    area0.doms[4].mylink=indexhref[4];
    area0.doms[5].mylink=indexhref[5];
    area0.doms[6].mylink=indexhref[6];
    area0.doms[7].mylink=indexhref[7];
    area0.doms[8].mylink=indexhref[8];
    area0.doms[9].mylink=indexhref[9];
    area0.setfocuscircle(0);
    area1=AreaCreator(2,3,new Array(-1,0,-1,-1),"area1_list_","className:item item_focus","className:item");
    for(var i=0;i<6;i++)
    {
        area1.doms[i].contentdom = $("area1_listName_"+i);
        area1.doms[i].imgdom=$("area1_img_"+i);
    }
    area1.setfocuscircle(0);
    pageobj=new PageObj(1,indexid!=null?parseInt(indexid):0,new Array(area0,area1),null);
    pageobj.backurl = "index.jsp";
    area0.setdarknessfocus(7);
    if(groupid == 1232)
    {
	    appShowName = "å…‰æ˜ç¿ æ¹–ç¤¾åŒº";
            industryAppUrl = "http://14.29.1.13:8080/epg/login!index.action?tradeId=1232"+"&itvUserId=" + userid_str+ "&endUrl=" + basePath;
	    getdata(applist);
	   getdata_trade();
    }else
    {
        getdata(applist);
    }
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
                var showName = data[i].VASNAME;
                area1.doms[i].updatecontent(showName);			
		if(appIntro[i]==3)//qiezi
		    area1.doms[i].mylink=appUrl[i]+location.href;
		if(appIntro[i]==2)//kalaok
		    area1.doms[i].mylink=appUrl[i]+userid_str+'&endUrl='+location.href; 
		if(appIntro[i]==1)//zhongyou
		    area1.doms[i].mylink=appUrl[i]+STBType+'&user='+userid_str+'&enterURL='+location.href
		appnum = i;
	    }
	    else
            {
	        area1.doms[i].updateimg("#");
	    }
	}
    }
}




/*****************************************
  Tilte È¡ĞĞÒµÓÃ»§Ó¦ÓÃÈë¿ÚÄÚÈİ
  Author ls
  Date 2013-09-04

 ***********************************************/ 


function getdata_trade()
{
    area1.datanum += 1;
    area1.doms[appnum+1].updateimg("industryAppImages/"+groupid+".jpg");
    area1.doms[appnum+1].mylink=industryAppUrl;
    area1.doms[appnum+1].updatecontent(appShowName);
}


		

</script>
</head>

<body style="background:url(images/mainbg.jpg); background-color:transparent;">
<div class="main">
    
	<!--logo-->
	<div class="logo"><img src="images/logo.png" /></div>
	<div class="date" id="currDate"></div>
	<!--menu-->
	<div class="menu"> <!--ç„¦ç‚¹ä¸º class="menuli on"  å½“å‰é€‰ä¸­ä¸º class="menuli current"-->
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_0" style="top:1px"><img src="images/icon_0.png" />é¦–  é¡µ</div> <!--class="menuli on"-->
		<div style="top:55px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_1" style="top:56px"><img src="images/icon_1.png" />é¢‘  é“</div>
		<div style="top:110px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_2" style="top:111px"><img src="images/icon_2.png" />ç‚¹  æ’­</div>
		<div style="top:165px"><img src="images/menu_line.png" /></div>
	    <div class="menuli" id="area0_list_3" style="top:166px"><img src="images/icon_3.png" />ä¸“  é¢˜</div>
		<div style="top:220px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_4" style="top:221px"><img src="images/icon_4.png" />å›  æ”¾</div>
		<div style="top:275px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_5" style="top:276px"><img src="images/icon_5.png" />æ·±  åœ³</div>
		<div style="top:330px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_6" style="top:331px"><img src="images/icon_11new.png" />æ’  è¡Œ</div>
		<div style="top:385px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_7" style="top:386px"><img src="images/icon_7.png" />åº”  ç”¨</div>
		<div style="top:440px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_8" style="top:441px"><img src="images/icon_9.png" />ç©º  é—´</div>
		<div style="top:499px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_9" style="top:500px"><img src="images/icon_10.png" />æœ  ç´¢</div>
		<div style="top:555px"><img src="images/menu_line.png" /></div>
	</div>
	
	
	
	<!--mid-->
	<div class="app-list">
		<!--ç„¦ç‚¹ 
				class="item item_focus"
			-->
		<div class="item" id="area1_list_0">
			<div class="icon" id="area1_listImg_0"><img id="area1_img_0" width="244" height="178" /></div>
			<div class="txt" id="area1_listName_0"></div>
		</div>
		<div class="item" style=left:303px;" id="area1_list_1">
			<div class="icon" id="area1_listImg_1"><img id="area1_img_1" width="244" height="178" /></div>
			<div class="txt" id="area1_listName_1"></div>
		</div>
		<div class="item" style="left:606px;" id="area1_list_2">
			<div class="icon" id="area1_listImg_2"><img id="area1_img_2" width="244" height="178" /></div>
			<div class="txt" id="area1_listName_2"></div>
		</div>
		<div class="item" style="top:286px;" id="area1_list_3">
			<div class="icon" id="area1_listImg_3"><img id="area1_img_3" width="244" height="178" /></div>
			<div class="txt" id="area1_listName_3"></div>
		</div>
		 <div class="item" style="top:286px;left:303px" id="area1_list_4">
                        <div class="icon" id="area1_listImg_4"><img id="area1_img_4" width="244" height="178" /></div>
                        <div class="txt" id="area1_listName_4"></div>
                </div>
	         <div class="item" style="top:286px;left:606px" id="area1_list_5">
                        <div class="icon" id="area1_listImg_5"><img id="area1_img_5" width="244" height="178" /></div>
                        <div class="txt" id="area1_listName_5"></div>
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

