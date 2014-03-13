<%
/*******************************
* FileName:index.jsp
* Date:20131219
* Description:»ı·Ö¶©¹ºÉÌ³ÇÊ×Ò³
* Author:LS
*******************************/
%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.facade.UserRecord" %>
<%@ page import="com.huawei.iptvmw.epg.facade.service.UserRecordImpl" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="../config/config_TrailerInVas.jsp"%>
<%@ include file="../OneKeyPlay.jsp"%>
<%@ include file="../datajsp/util_AdText.jsp"%>
<%@ include file="../util/util_getPosterPaths.jsp"%>
<%@ include file="../datajsp/database.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>


<%
/*
* Date 20140107
* Author LS
* Dscription »ñÈ¡ÓÃ»§µçĞÅ»ı·Ö
*/
UserRecordImpl recordServiceHelpHWCTC = new UserRecordImpl(request);
Map userRecord = new HashMap();
int iType = 3;
try
{
   userRecord = recordServiceHelpHWCTC.queryRewardPoints(iType);
}
catch(Exception e){

}
int recordPoints = 0;
recordPoints =  (Integer)userRecord.get("AVAILABLE_TELE_REWARD_POINTS");


//Ê×Ò³¹â±ê¼ÇÒäÓë·µ»ØµØÖ·»ñÈ¡
int curindex=0;
curindex=request.getParameter("curindex")!=null?Integer.parseInt(request.getParameter("curindex")):0;
String returnUrl = request.getParameter("returnUrl")!=null?request.getParameter("returnUrl"):"../index.jsp";
//³õÊ¼»¯ËùĞèÀà
MetaData metadata = new MetaData(request);
ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
ServiceHelp serviceHelp = new ServiceHelp(request);

//´Ó»ı·ÖÉÌ³ÇÀ¸Ä¿ÖĞÈ¡³öÏÂÊôÌõÄ¿
ArrayList appResult = new ArrayList();
try{
    appResult=new MyUtil(request).getVasListData("10000100000000090000000000038252",8);
}catch(Exception e){
}

//³õÊ¼»¯ËùÅäVASÍ¼Æ¬Êı×éÓëµØÖ·
String[] vasListPic=new String[10];
String[] vasUrl = new String[10];	
	
ArrayList tmpimgVas = new ArrayList();
try{
    tmpimgVas=(ArrayList)metadata.getVasListByTypeId("10000100000000090000000000038252", 8, 0);
}catch(Exception e){
}

//È¡VASÌõÄ¿µÄÍ¼Æ¬¡¢¼ò½é¡¢Á´½Ó
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
            vasListPic[i] =  getPosterPath(postersMap,request,postpath,"0").toString();
	    vasUrl[i] = serviceHelp.getVasUrl(tempindexvasid);
        }
    }
}


UserProfile userProfile = new UserProfile(request);
String userid = userProfile.getUserId();


%>

<%@ include file="../save_focus.jsp"%>
<%@ include file="../datajsp/codepage.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>æ’è¡Œæ¦œ-ç‚¹æ’­-ç”µå½±62_å¤®è§†é«˜æ¸…EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="../css/common.css" rel="stylesheet" />
<link type="text/css" href="../css/content.css" rel="stylesheet" />
<style>

/*----Ò³ÃæÑùÊ½¶¨Òå-------------------------------------------*/
.app-list {
left: 100px;
position: absolute;
top: 300px;
}	
.app-list .item {
height:181px;
left: 0;
position: absolute;
top: 0;
	width:269px;
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
	background:url(images/jifen_focus.png) no-repeat;
} 

</style>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript" src="../js/gstatj.js"></script>
<script type="text/javascript">
//³õÊ¼»¯·µ»ØµØÖ·£¬ÇøÓò£¬²úÆ·ÁĞ±í¡¢Í¼Æ¬¡¢URLµÈÄÚÈİ
var returnurl='<%=returnUrl%>';
var area0;
var applist=eval('('+'<%=appResult.get(0)%>'+')'); 
var vasListPic=new Array();
var vasUrl= new Array();

<%for(int i = 0; i < vasListPic.length; i++)
  {%>
      vasListPic[<%=i%>] = '<%=vasListPic[i]%>';
<%}
%>


<%for(int i = 0; i< vasUrl.length;i++)
  {%>
     vasUrl[<%=i%>]='<%=vasUrl[i]%>';
<%}
%>

window.onload=function()
{
    gstaFun('<%=userid%>',666);
    //³õÊ¼»¯²úÆ·°üÕ¹Ê¾ÇøÓò
    area0=AreaCreator(2,4,new Array(-1,-1,-1,-1),"area0_list_","className:item item_focus","className:item");
    //½«JSÇøÓòÓëHTMLÔªËØ¶ÔÓ¦
    for(var i=0;i<8;i++)
    {
        area0.doms[i].imgdom=$("area0_img_"+i);
    }
	//ÉèÖÃ¹â±êÒÆ¶¯Ñ­»·
    area0.setfocuscircle(0);
	//×¢²áÒ³ÃæÔªËØ
    pageobj=new PageObj(0,indexid!=null?parseInt(indexid):0,new Array(area0),null);
    //ÉèÖÃ·µ»ØµØÖ·
    pageobj.backurl = returnurl;
    //Í¨¹ıgetdataº¯Êı»ñÈ¡Ò³Ãæ¾ßÌåÄÚÈİ
	getdata(applist);
    //ÎªÒ³Ãæ¸÷ÄÚÈİ³¬Á´½Ó¸³Öµ
    for(i = 0; i < 8;i++)
    {
        area0.doms[i].mylink = "../../../"+vasUrl[i];
    }
}

//¸Ãº¯ÊıÓÃÓÚ¶ÁÈ¡JSPËù´«Êı¾İ²¢½âÎöÎªJSËùĞèÄÚÈİ
function getdata(data)
{
    
    if(data.length==undefined || data==null || data.length<1)
    {
	//µ±Êı¾İ³¤¶ÈÒì³£Ê±£¬½«ÇøÓòÄÚÈİÊıÁ¿ÖÃÎª1
        area0.datanum =1;
    }
    else
    {
	//Êı¾İÕı³£Ê±£¬½«ÇøÓòÄÚÈİÊıÁ¿ÓëÊı¾İ³¤¶ÈÆ¥Åä
        area0.datanum = data.length;
	    for(i=0;i<area0.doms.length;i++)
	    {
            if(i<area0.datanum)
            {
			    //ÎªÓĞÊı¾İµÄÎ»ÖÃ¸½Í¼
                document.getElementById("area0_img_"+i).src ="../"+ vasListPic[i];
            }
	        else
            {
			    //ÎŞÊı¾İµÄÎ»ÖÃÔö¼ÓµæÍ¼
	            area0.doms[i].updateimg("images/weilai.png");
	        }
	    }
    }
}

</script>
</head>

<body style="background:url(images/bg.png); background-color:transparent;">

<div class="main">
<div style = "left:520px;top:235px;position:absolute;text-align:center;"><%=recordPoints%></div>
<!--mid-->
<div class="app-list">
<!--ç„¦ç‚¹ 
class="item item_focus"
-->
<div class="item" id="area0_list_0">
<img id="area0_img_0"  width="270" height="181" />
</div>
<div class="item" style=left:271px;" id="area0_list_1">
<img id="area0_img_1" width="270" height="181" />
</div>
<div class="item" style="left:542px;" id="area0_list_2">
<img id="area0_img_2" width="270" height="181" />
</div>
<div class="item" style="left:811px;" id="area0_list_3">
<img id="area0_img_3" width="270" height="181" />
</div>
<div class="item" style="top:186px;" id="area0_list_4">
<img id="area0_img_4" width="270" height="181" />
</div>
<div class="item" style="top:186px;left:271px" id="area0_list_5">
<img id="area0_img_5" width="270" height="181" />
</div>
<div class="item" style="top:186px;left:542px" id="area0_list_6">
<img id="area0_img_6" width="270" height="181" />
</div>
<div class="item" style="top:186px;left:811px" id="area0_list_7">
<img id="area0_img_7" width="270" height="181" />
</div>
</div>


</div>
</body>
</html>

