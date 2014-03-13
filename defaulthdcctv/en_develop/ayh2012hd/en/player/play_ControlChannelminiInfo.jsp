<%@ page contentType="text/html; charset =UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page errorPage="ShowException.jsp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.func.STBAction" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="java.util.*" %>
<%@ include file = "../datasource/SubStringFunction.jsp"%>
<%@ page import="net.sf.json.JSONArray" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title></title>
<style type="text/css">
.channel_msg{ position:absolute;top:0px; right:0px; background:url(playerimages/channel_OSD_rbg.png) repeat-y; width:360px; height:720px; padding-left:0px; line-height:46px}
.channel_msg div.title{ font-size:30px; padding:60px 0 10px 50px}
.channel_msg div.mar{  font-size:26px;padding-left:50px}
.channel_msg div.line {text-align:right;}
</style>
</head>
<%
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
Date currDate = new java.util.Date();
String str_CurrDateTime = formatter.format(currDate);
String currTime = StringDateUtil.getTodaytimeString("yyyyMMddhhmmss");
MetaData metaData = new MetaData(request);
//频道id
String progID = request.getParameter("CHANNELID")==null?"0":request.getParameter("CHANNELID").equals("undefined")?"0":request.getParameter("CHANNELID");
int chanId = Integer.parseInt(progID);
//当前频道名称
String channelName = "";
String channelMediaCode ="";
//调用接口获取频道详情
HashMap chanInfoMap = (HashMap)metaData.getChannelInfo(progID);
if(null != chanInfoMap)
{
	String tmpChannelName = (String)chanInfoMap.get("CHANNELNAME");
	channelName = subStringFunction(tmpChannelName,1,130);
	channelMediaCode= (String)chanInfoMap.get("CODE");
}
//当前节目信息
String progName = "";
String progTimeBegin = "";
String progTimeEnd = "";
String progTimeSpan = "";  //当前节目起止时间拼接的字符串
String time = "";          //当前节目时间长度
String strIntro = null;    //当前节目简介
//上一个节目信息
String preProgName = "";
//下一个节目信息	
String nextProgName = "";
//调用接口获得频道节目信息
int progNums = 0;  
HashMap progInfo = metaData.getChannelProgInfo(chanId,currTime);
String[] progMenus = metaData.getProgBill(chanId,str_CurrDateTime);
ArrayList list=new ArrayList();
int count=0;
//这里定义为4是因为目前只显示4条记录
String[] progTimes=null;
String[] progNames=null;
if(progMenus!=null)
{
	count=progMenus.length;
    progTimes=new String[count];
	progNames=new String[count];
	for(int i=0;i<count;i++)
    {
		progTimes[i]=progMenus[i].substring(11,19);
		progNames[i]=subStringFunction(progMenus[i].substring(20,36),1,150);
    }
}
if(progInfo != null)
{
	HashMap progMap = (HashMap)progInfo.get("CURRPROG");
	if(progMap != null)
	{
		progName = ((String)progMap.get("progName") == null ? "" : (String)progMap.get("progName"));
		progName = subStringFunction(progName,1,130);
	}
	progMap = (HashMap)progInfo.get("PREPROG");
	/*if(progMap != null)
	{
		preProgName = ((String)progMap.get("progName") == null ? "" : (String)progMap.get("progName"));
		preProgName = subStringFunction(preProgName,1,130);
	}
	progMap = (HashMap)progInfo.get("NEXTPROG");
	if(progMap != null)
	{
		nextProgName = ((String)progMap.get("progName") == null ? "" : (String)progMap.get("progName"));
		nextProgName = subStringFunction(nextProgName,1,130);
	}*/
}
strIntro = (null == strIntro) ? " " : subStringFunction(strIntro,2,390);
%>
<script>
var progNamesLength=<%=count%>;
var progNames=new Array();
var progTimes=new Array();
<%
for(int i=0;i<count && i<4;i++)
{
	%>
	progNames[<%=i%>]="<%=progNames[i]%>";
	progTimes[<%=i%>]="<%=progTimes[i]%>";
	<%
}
%>
function init_info()
{	
	Authentication.CTCSetConfig("mediacode","<%=channelMediaCode%>");
	document.getElementById("currprog").innerText = "<%=progName%>";
	document.getElementById("title").innerText = "<%=channelName%>";
	for(var i=0;i<progNames.length;i++)
	{
		document.getElementById("progName_"+i).innerText=progNames[i];
		document.getElementById("time_"+i).innerText=progTimes[i];
	}
}
parent.showFilmInfoFlag = "true";
</script>

<body onLoad="javascript:init_info()" bgcolor="transparent" style="color:#FFFFFF">
    <div class="channel_msg">
		<div class="title" id="title"></div>
		<div class="mar">当前节目:</div>
		<div class="line"><img src="playerimages/menu_line.png" /></div>
		<div class="mar" id="currprog"></div>
		<div class="line"><img src="playerimages/menu_line.png" /></div>
		<div class="mar">节目单:</div>
		<div class="line"><img src="playerimages/menu_line.png" /></div>
		<div class="mar" id="time_0"></div>
		<div class="line"><img src="playerimages/menu_line.png" /></div>
		<div class="mar" id="progName_0"></div>
		<div class="line"><img src="playerimages/menu_line.png" /></div>
		<div class="mar" id="time_1"></div>
		<div class="line"><img src="playerimages/menu_line.png" /></div>
		<div class="mar" id="progName_1"></div>
		<div class="line"><img src="playerimages/menu_line.png" /></div>
		<div class="mar" id="time_2"></div>
		<div class="line"><img src="playerimages/menu_line.png" /></div>
		<div class="mar" id="progName_2"></div>
		<div class="line"><img src="playerimages/menu_line.png" /></div>
		<div class="mar" id="time_3"></div>
		<div class="line"><img src="playerimages/menu_line.png" /></div>
		<div class="mar" id="progName_3"></div>		
  </div>
</body>
</html>
