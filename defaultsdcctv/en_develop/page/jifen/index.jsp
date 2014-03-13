<%
/*******************************
* FileName:index.jsp
* Date:20131219
* Description:积分订购商城首页
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
* Dscription ��ȡ�û����Ż���
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



//首页光标记忆与返回地址获取
int curindex=0;
curindex=request.getParameter("curindex")!=null?Integer.parseInt(request.getParameter("curindex")):0;
String returnUrl = request.getParameter("returnUrl")!=null?request.getParameter("returnUrl"):"../index.jsp";
//初始化所需类
MetaData metadata = new MetaData(request);
ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
ServiceHelp serviceHelp = new ServiceHelp(request);
//从积分商城栏目中取出下属条目
ArrayList appResult = new ArrayList();
try{
    appResult=new MyUtil(request).getVasListData("10000100000000090000000000038850",8);
}catch(Exception e){
}

//初始化所配VAS图片数组与地址
String[] vasListPic=new String[10];
String[] vasUrl = new String[10];	
	
ArrayList tmpimgVas = new ArrayList();
try{
    tmpimgVas=(ArrayList)metadata.getVasListByTypeId("10000100000000090000000000038850", 8, 0);
}catch(Exception e){
}

System.out.println("TEMPVAS==="+tmpimgVas);

//取VAS条目的图片、简介、链接
if(tmpimgVas!=null && tmpimgVas.size()>1)
{
    ArrayList tmpVasList = (ArrayList)tmpimgVas.get(1);
    System.out.println("TEMPVASLIST==="+tmpVasList);
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





%>

<%@ include file="../save_focus.jsp"%>
<%@ include file="../datajsp/codepage.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>排行榜-点播-电影62_央视高清EPG</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" href="../css/common.css" rel="stylesheet" />
<link type="text/css" href="../css/content.css" rel="stylesheet" />
<style>

/*application--------------------------------------------*/
.app-list {
left: 20px;
position: absolute;
top: 200px;
}	
.app-list .item {
height:133px;
left: 0;
position: absolute;
top: 10;
	width:198px;
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
<script type="text/javascript" src="../../js/pagecontrol.js"></script>
<script type="text/javascript">
//初始化返回地址，区域，产品列表、图片、URL等内容
var returnurl='<%=returnUrl%>';
var area0;
var applist=eval('('+'<%=appResult.get(0)%>'+')'); 
var vasListPic=new Array();
var vasUrl = new Array();
var recordPoints = <%=recordPoints%>;
var STBType=Authentication.CTCGetConfig("STBType");
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
    //初始化产品包展示区域
    area0=AreaCreator(2,3,new Array(-1,-1,-1,-1),"area0_list_","className:item item_focus","className:item");
    //将JS区域与HTML元素对应
    for(var i=0;i<6;i++)
    {
        area0.doms[i].imgdom=$("area0_img_"+i);
    }
	//设置光标移动循环
    area0.setfocuscircle(0);
    document.getElementById("jifentxt").innerHTML = recordPoints;
	//注册页面元素
    pageobj=new PageObj(0,indexid!=null?parseInt(indexid):0,new Array(area0),null);
    //设置返回地址
    pageobj.backurl = returnurl;
    //通过getdata函数获取页面具体内容
	getdata(applist);
    //为页面各内容超链接赋值
    for(i = 0; i < 6;i++)
    {

        area0.doms[i].mylink = "../../../../"+vasUrl[i];
    }
	if(STBType=="EC1308_pub"){
	document.getElementById("jifentxt").style.left = "-90px";
        }
}

//该函数用于读取JSP所传数据并解析为JS所需内容
function getdata(data)
{
    if(data.length==undefined || data==null || data.length<1)
    {
	//当数据长度异常时，将区域内容数量置为1
	    area0.datanum =1;
    }
    else
    {
	//数据正常时，将区域内容数量与数据长度匹配
        area0.datanum = data.length;
        for(i=0;i<6;i++)
	    {
            if(i<area0.datanum)
            {
			    //为有数据的位置附图
		        document.getElementById("area0_img_"+i).src ="../../"+ vasListPic[i];
            }
	    else
            {
			    //无数据的位置增加垫图
	            area0.doms[i].updateimg("images/weilai.png");
	        }
	    }
    }
}
		

</script>
</head>

<body style="background:url(images/bg.png) no-repeat; background-color:transparent;">
<div class="main">
<div id="jifentxt" style = "left:240px;top:160px;position:absolute;text-align:center;font-size:20px;color:#FFFFFF"></div>
<!--mid-->
<div class="app-list">
<!--焦点 
class="item item_focus"
-->
<div class="item" id="area0_list_0">
<img id="area0_img_0"  width="198" height="133" />
</div>
<div class="item" style=left:200px;" id="area0_list_1">
<img id="area0_img_1" width="198" height="133" />
</div>
<div class="item" style="left:400px;" id="area0_list_2">
<img id="area0_img_2" width="198" height="133" />
</div>

<div class="item" style="top:146px;" id="area0_list_3">
<img id="area0_img_3" width="198" height="133" />
</div>
<div class="item" style="top:146px;left:200px" id="area0_list_4">
<img id="area0_img_4" width="198" height="133" />
</div>
<div class="item" style="top:146px;left:400px" id="area0_list_5">
<img id="area0_img_5" width="198" height="133" />
</div>

</div>

</div>
</body>
</html>

