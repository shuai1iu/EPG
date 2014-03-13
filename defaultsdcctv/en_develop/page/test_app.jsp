<%@ page contentType="text/html; " language="java" pageEncoding="UTF-8" %>
<%@ include file="datajsp/codepage.jsp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="datajsp/database.jsp"%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<%
UserProfile forGetUser = new UserProfile(request);
String userID = forGetUser.getUserId();

int currPage=1;
int curindex=0;
int areaid=0;
int pageSize = 6;

curindex=request.getParameter("curindex")!=null?Integer.parseInt(request.getParameter("curindex")):0;
areaid=request.getParameter("areaid")!=null?Integer.parseInt(request.getParameter("areaid")):0;
currPage=request.getParameter("currPage")!=null?Integer.parseInt(request.getParameter("currPage")):1; 

MetaData metadata = new MetaData(request);
ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
ServiceHelp serviceHelp = new ServiceHelp(request);
ArrayList appResult = new ArrayList();

//得到集合

String userTempName = serviceHelp.getUserTemplateName();
String directPageName = "index.jsp";
String path = request.getContextPath();
//@param basePath基本路径
String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() +
path + "/jsp/" + userTempName + "/en/"+ directPageName;

UserProfile upf_Jump = new UserProfile(request);
String user = upf_Jump.getUserId();
String groupId =  upf_Jump.getUserGroupId();	
ArrayList allVasList = new ArrayList();
ArrayList tempImgVas = new ArrayList();
try{
	tempImgVas = (ArrayList)metadata.getVasListByTypeId("10000100000000090000000000035250",6,0);
} catch(Exception e){
}

Integer countTotal = (Integer)((HashMap)tempImgVas.get(0)).get("COUNTTOTAL");
int pageAmount = pageSize*currPage > countTotal ? (countTotal%pageSize) : pageSize;
int pageBegin = (currPage-1)*pageSize;

if(tempImgVas!=null&&tempImgVas.size()>1){
   ArrayList tempVasList = (ArrayList)tempImgVas.get(1);
   if(tempVasList!=null&&tempVasList.size()>0)
   {
       for(int i=pageBegin;i<(pageBegin+pageAmount);i++)
       {
           HashMap tempMap = new HashMap();
           Map list = (HashMap)tempVasList.get(i);
		   
           int tempVasId = (Integer)list.get("VASID");
           Map mapInfo = (HashMap)metadata.getVasDetailInfo(tempVasId);
		   HashMap posterMap = (HashMap)mapInfo.get("POSTERPATHS");
           String postPath = (String)mapInfo.get("POSTERPATH");
           
	   String vasName = (String)list.get("VASNAME");
	   String appIntro = mapInfo.get("INTRODUCE").toString();
           String vasListPic=  getPosterPath(posterMap,request,postPath,"0").toString();
           String appUrl = serviceHelp.getVasUrl(tempVasId).toString();
		   
		   tempMap.put("VASNAME",vasName);
		   tempMap.put("INTRODUCE",appIntro);
		   tempMap.put("PIC",vasListPic);
		   tempMap.put("URL",appUrl);
		   allVasList.add(tempMap);
       }
   }
}
JSONArray allVasJson = JSONArray.fromObject(allVasList);

%>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<meta name="page-view-size" content="640*530"/>
<title>CCTV-IP电视</title>
<link type="text/css" href="../../../defaultgdsd/en/css/common.css" rel="stylesheet" />
<link type="text/css" href="../../../defaultgdsd/en/css/content.css" rel="stylesheet" />
<style type="text/css">
		 
</style>
<script language="javascript" type="text/javascript" src="../js/pagecontrol.js"></script>
	<script language="javascript" type="text/javascript">
var returnurl = escape(window.location.href);
	
	var userId_str = "<%=user%>";
	var basePath = "<%=basePath%>";
	var indexid=<%=curindex%>;
	var areaid=<%=areaid%>;
	var pageSize=<%=pageSize%>;
        var countTotal = <%=countTotal%>;        
	var currPage=<%=currPage%>;
	var area0;
	var STBTtype = Authentication.GTGGetConfig("STBType");
    var STBType =Authentication.CTCGetConfig("STBType");
	var jVaslist = eval('('+'<%=allVasJson%>'+')'); //传入js的allVasList
	

window.onload=function()
{
	area0 = AreaCreator(2,3, new Array(-1, -1, -1, -1), "area0_list_", "className:on","className:bg");
	area0.setfocuscircle(0);
	pageobj = new PageObj(areaid,indexid!=null?parseInt(indexid):0,new Array(area0),null);
	pageobj.goBackEvent=function()
	{
        backurl = "index.jsp?back=1";
		window.location.href = backurl;
	};
        area0.areaPageTurnEvent = function(num){
			  if(num == -1){
				pageUp();
				}else{
					pageDown();
					}
			};
	getdata_trade(jVaslist,area0);
		
};

function pageUp()
{
   
    if(currPage>1)
	{
	    location.href = "test_app.jsp?currPage="+(currPage-1);
	}
}

function pageDown()
{
     if(currPage<(countTotal/pageSize))
	 {
	   location.href = "test_app.jsp?currPage="+(currPage+1);
	 }
}
function getdata_trade(itms,area)
    {
        area0.datanum = itms.length;
        $("pageNum").innerHTML = Math.ceil(countTotal/pageSize)+"/"+currPage;
		for(var i=0;i<itms.length;i++)
		{
				$("area0_list_"+i).style.display = "block";
				area0.doms[i].contentdom = $("area0_txt_"+i);
				area0.doms[i].imgdom=$("area0_img_"+i);
			
				var showName = itms[i].VASNAME;
				area0.doms[i].updatecontent(""+showName);	
				area0.doms[i].updateimg("../"+itms[i].PIC);
                                if("中国游戏中心"==itms[i].VASNAME)
                                {
                                    itms[i].URL = itms[i].URL+STBType+'&user='+userId_str+'&enterURL=';
                                }
                                else if("卡拉OK"==itms[i].VASNAME)
                                {
                                     itms[i].URL = itms[i].URL+userId_str+'&endUrl=';
                                }
				area0.doms[i].mylink = itms[i].URL+location.href;
		}
	}



</script>
</head>
<body>
<div class="wrapper">

<!-- S LOGO -->
<div class="logo">应用</div>
<div class="date" id="currDate" style="left:340px; width:290px"></div>
<div class="line"><img src="../../../defaultgdsd/en/images/line.png" width="100%" /></div>
<!-- E LOGO -->
</div>
<div id="test" style="position:absolute;top:250px">hahah</div>
<div class="app_list" style="top:80;left:20px;">
	 <div class="bg" id="area0_list_0" style="display:none;">
          <div class="pic"><img id="area0_img_0" src="#" width="173" height="112" /></div>
          <div class="name" id="area0_txt_0" style="border-top:10px;line-height:43px;"></div>
        </div>
        <div class="bg" id="area0_list_1" style="left:197px;display:none;">
          <div class="pic"><img id="area0_img_1" src="#" width="173" height="112" /></div>
          <div class="name" id="area0_txt_1" style="border-top:10px"></div>
        </div>
        <div class="bg" id="area0_list_2" style="left:394px;display:none;">
          <div class="pic"><img id="area0_img_2" src="#" width="173" height="112" /></div>
          <div class="name" id="area0_txt_2" style="border-top:10px"></div>
        </div>
        <div class="bg" id="area0_list_3" style="top:188px;display:none;">
          <div class="pic"><img id="area0_img_3" src="#" width="173" height="112" /></div>
          <div class="name" id="area0_txt_3" style="border-top:10px"></div>
        </div>
        <div class="bg" id="area0_list_4" style="left:197px;top:188px;display:none;">
          <div class="pic"><img id="area0_img_4" src="#" width="173" height="112" /></div>
          <div class="name" id="area0_txt_4" style="border-top:10px"></div>
        </div>
        <div class="bg" id="area0_list_5" style="left:394px;top:188px;display:none;">
          <div class="pic"><img id="area0_img_5" src="#" width="173" height="112" /></div>
          <div class="name" id="area0_txt_5" style="border-top:10px"></div>
        </div>
</div>
<div style="position:absolute;top:440px;left:50%" id="pageNum">1/1</div>
<!--footer-->
<div class="line" style="top:467px"><img src="../../../defaultgdsd/en/images/line.png" width="100%" /></div>
	<div class="direction">	
		<div style="left:43px;"><img src="../../../defaultgdsd/en/images/iconb03.png" /></div>	
		<div style=" top:5px;left:95px;">选择频道</div>
		<div style=" top:5px;left:222px;"><img src="../../../defaultgdsd/en/images/btn-page.png" /></div>	
		<div style=" top:5px;left:325px;">翻页</div>
	</div>
<%@ include file="servertimehelp.jsp" %>
</body>
</html>
