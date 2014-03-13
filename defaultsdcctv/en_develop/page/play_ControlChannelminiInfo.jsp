<%@ page contentType="text/html; charset =UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page errorPage="ShowException.jsp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.func.STBAction" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="java.util.*" %>
<%@ include file = "datajsp/SubStringFunction.jsp"%>
<%@ page import="net.sf.json.JSONArray" %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title></title>
<link type="text/css" rel="stylesheet" href="../css/content.css" />
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
String preProgName = "";//上一个节目信息
String nextProgName = "";//下一个节目信息	

int progNums = 0;   //调用接口获得频道节目信息
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
if (typeof(iPanel) != 'undefined') {
iPanel.focusWidth = "2";
iPanel.defaultFocusColor = "#FCFF05";
}
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
{     //    top.document.getElementById("filmInfo1").style.visibility = "visible";//ztewebkit	
    //    top.document.getElementById("filmInfo1").style.display = "block";//ztewebkit
	Authentication.CTCSetConfig("mediacode","<%=channelMediaCode%>");	
	document.getElementById("title").innerText = "当前：<%=channelName%>";
	document.getElementById("currprog").innerText = "<%=progName%>";
	for(var i=0,l=progNames.length;i<l;i++)
	{
		document.getElementById("progName_"+i).innerText=progNames[i];
		//document.getElementById("time_"+i).innerText=progTimes[i];
	}
}
parent.showFilmInfoFlag = "true";
</script>

<body onLoad="javascript:init_info()" bgcolor="transparent" style="color:#FFFFFF">
  
  <div class="live-item">
		<div class="con2"> 
			<div id="title">当前频道：CCTV1 </div>            
			<div>当前节目：</div>
			<div id="currprog"></div>
			<div>下一节目：</div>
			<div id="progName_0"></div>
            <div id="progName_1"></div>
            <div id="progName_2"></div>
            <div id="progName_3"></div>
		</div>
	</div>
  
</body>
</html>
