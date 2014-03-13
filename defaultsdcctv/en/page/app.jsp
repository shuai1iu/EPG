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
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="datajsp/database.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<%
UserProfile forGetUser = new UserProfile(request);
String userID = forGetUser.getUserId();

int curpage=1;
int curindex=0;
int areaid=0;

curindex=request.getParameter("curindex")!=null?Integer.parseInt(request.getParameter("curindex")):0;
areaid=request.getParameter("areaid")!=null?Integer.parseInt(request.getParameter("areaid")):0;
curpage=request.getParameter("curpage")!=null?Integer.parseInt(request.getParameter("curpage")):0;
MetaData metadata = new MetaData(request);
ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
ServiceHelp serviceHelp = new ServiceHelp(request);
ArrayList appResult = new ArrayList();
//得到集合
try{
	appResult = new MyUtil(request).getVasListData("10000100000000090000000000035250",6);
}catch(Exception e){
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


String[] vasListPic=new String[6];//图片路径
String[] appUrl = new String[6];	
String[] appIntro = new String[6];	//基本信息
ArrayList tempImgVas = new ArrayList();
try{
	tempImgVas = (ArrayList)metadata.getVasListByTypeId("10000100000000090000000000035250",6,0);
} catch(Exception e){
}

System.out.println("tempImgVas====="+tempImgVas.size());

if(tempImgVas!=null&&tempImgVas.size()>1){
   ArrayList tempVasList = (ArrayList)tempImgVas.get(1);
   if(tempVasList!=null&&tempVasList.size()>0)
   {
       for(int i=0;i<tempVasList.size();i++)
       {
           Map list = (HashMap)tempVasList.get(i);
           int tempVasId = (Integer)list.get("VASID");
           Map mapInfo = (HashMap)metadata.getVasDetailInfo(tempVasId);
           HashMap posterMap = (HashMap)mapInfo.get("POSTERPATHS");
           String postPath = (String)mapInfo.get("POSTERPATH");
           appIntro[i] = mapInfo.get("INTRODUCE").toString();
           vasListPic[i] =  getPosterPath(posterMap,request,postPath,"0").toString();
           appUrl[i] = serviceHelp.getVasUrl(tempVasId).toString();
       }
   }
}


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
	var  vasListPic = new Array();// 图片路径
	var  appIntro = new Array();//产品信息 
	var  appUrl= new Array();
	var userId_str = "<%=user%>";
	var STBTtype = Authentication.GTGGetConfig("STBType");
	var basePath = "<%=basePath%>";
	
	var indexid=<%=curindex%>;

	var areaid=<%=areaid%>;
	var appNum = 0;
	var applist=eval('('+'<%=appResult.get(0)%>'+')'); 
	var area0;
        var STBType =Authentication.CTCGetConfig("STBType");
	<%for(int i=0;i<vasListPic.length;i++)
{%>
	vasListPic[<%=i%>]='<%=vasListPic[i]%>';
	<%}%>

	<%for(int i=0;i<appIntro.length;i++)
{%>
	appIntro[<%=i%>]='<%=appIntro[i]%>';
	<%}%>

	<%for(int i=0;i<appUrl.length;i++)
{%>
	appUrl[<%=i%>]='<%=appUrl[i]%>';
	<%
	}%>

window.onload=function()
{
	area0 = AreaCreator(2,3, new Array(-1, -1, -1, -1), "area0_list_", "className:on","className:bg");
	area0.setfocuscircle(0);
	pageobj = new PageObj(areaid,indexid!=null?parseInt(indexid):0,new Array(area0),null);
	pageobj.goBackEvent=function()
	{
		window.location.href="index.jsp?back=1";
	};
	
	getdata_trade(applist,area0);
		
};
var appname=0;
function getdata_trade(data,area)
    {
	
		area0.datanum=data.length;
		for(var i=0;i<area0.doms.length;i++)
		{
			
			if(i<area0.datanum)
			{
				$("area0_list_"+i).style.display = "block";
				area0.doms[i].contentdom = $("area0_txt_"+i);
				area0.doms[i].imgdom=$("area0_img_"+i);
			
				var showName = data[i].VASNAME;
				area0.doms[i].updatecontent(""+showName);	
				area0.doms[i].updateimg("../"+vasListPic[i]);
                                if("中国游戏中心"==data[i].VASNAME)
                                {
                                    appUrl[i] = appUrl[i]+STBType+'&user='+userId_str+'&enterURL=';
                                }
                                else if("卡拉OK"==data[i].VASNAME)
                                {
                                     appUrl[i] = appUrl[i]+userId_str+'&endUrl=';
                                                                   
                                }
				area0.doms[i].mylink = appUrl[i]+location.href;
			}
			else
			{
				 area0.doms[i].updateimg("#");
			}
			
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

<div class="app_list" style="top:80;left:20px;">
	 <div class="bg" id="area0_list_0" style="display:none;">
          <div class="pic"><img id="area0_img_0" src="#" width="173" height="112" /></div>
          <div class="name" id="area0_txt_0" style="border-top:10px;line-height:43px;"></div>
        </div>
        <div class="bg" id="area0_list_1" style="left:197px;idisplay:none;">
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
