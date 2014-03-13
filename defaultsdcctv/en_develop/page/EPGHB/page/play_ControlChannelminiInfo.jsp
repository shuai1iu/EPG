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
<link type="text/css" rel="stylesheet" href="../css/playstyle.css" />
  <style type="text/css">
        .winTxt {
            color: #f0f0f0;
            height: 40px;
            left: 17px;
            text-align: center;
            position: absolute;
            width: 668px;
        }
        .playbar-c {
            background: url(../images/play/play-page-bg.png) repeat;
            height: 131px;
            width: 640px;
            position: absolute;
            left: 0px;
            top: 399px;
        }
       
        .progress-wrap {
            background: url(../images/play/posbar-192x16.png) 0px 6px no-repeat;
            height: 30px;
            width: 192px;
            position: absolute;
            left: 378px;
            top: 19px;
        }
        .progress-wrap .progress-bar {
            height: 8px;
            width: 184px;
            position: absolute;
            left: 4px;
            top: 10px;
        }
        .progress-wrap .progress-bar .progress-position-read {
            background: url(../images/play/posbar-read.png) 0px 0px no-repeat;
            height: 8px;
            position: absolute;
            top: 0px;
        }

        .progress-sunBox {
            height: 80px;
            width: 184px;
            position: absolute;
            top: 18px;
            left: 351px;
            z-index: 999;
        }
        .progress-moveBox {
            height: 60px;
            width: 60px;
            position: absolute;
            top: 0px;
        }
        .progress-moveBox .pic, .progress-moveBox .pic img {
            height: 30px;
            width: 32px;
        }
        .progress-moveBox .pic {
            background: url(../images/play/posbar-sun.png) no-repeat;
            position: absolute;
            left: 15px;
            top: 0px;
        }
        .progress-moveBox .pic_focus {
            background: url(../images/play/posbar-sun_focus.png) no-repeat;
        }
        .progress-moveBox .txt {
            height: 30px;
            text-align: center;
            width: 60px;
            position: absolute;
            left: 0px;
            top: 28px;
        }

        .proPrevNext {}
        .proPrevNext .item {
            height: 30px;
            width: 610px;
            left: 26px;
        }
        .proPrevNext .item .txt {
            font-size: 22px;
            left: 0px;
            top: 0px;
        }
        .proPrevNext .item .txt .th {
            color: #44c8f5;
        }
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
String progTimeSpan = "";  //当前节目起止时间拼接的字符串
String strIntro = null;    //当前节目简介
String preProgName = "";//上一个节目信息
String nextProgName = "";//下一个节目信息	


String cruntProgStartTime = "";
String cruntProgEndTime = "";
String preProgStratTime = "";
String preProgEndTime = null;
String nextProgStratTime = "";
String nextProgEndTime = null;
String cruntProgStartAllTime="";
String cruntProgEndAllTime = "";
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
		progName = subStringFunction(progName,1,180);
		cruntProgStartTime = ((String)progMap.get("startTime")).substring(8,10)+":"+((String)progMap.get("startTime")).substring(10,12);
		cruntProgEndTime = ((String)progMap.get("endTime")).substring(8,10)+":"+((String)progMap.get("endTime")).substring(10,12);
		cruntProgStartAllTime = (String)progMap.get("startTime");
		cruntProgEndAllTime = (String)progMap.get("endTime");
	}
	progMap = (HashMap)progInfo.get("PREPROG");
	if(progMap != null)
	{
		preProgName = ((String)progMap.get("progName") == null ? "" : (String)progMap.get("progName"));
		preProgName = subStringFunction(preProgName,1,180);
		preProgStratTime = ((String)progMap.get("startTime")).substring(8,10)+":"+((String)progMap.get("startTime")).substring(10,12);
		preProgEndTime = ((String)progMap.get("endTime")).substring(8,10)+":"+((String)progMap.get("endTime")).substring(10,12);
	}
	progMap = (HashMap)progInfo.get("NEXTPROG");
	if(progMap != null)
	{
		nextProgName = ((String)progMap.get("progName") == null ? "" : (String)progMap.get("progName"));
		nextProgName = subStringFunction(nextProgName,1,180);
		nextProgStratTime = ((String)progMap.get("startTime")).substring(8,10)+":"+((String)progMap.get("startTime")).substring(10,12);
		nextProgEndTime = ((String)progMap.get("endTime")).substring(8,10)+":"+((String)progMap.get("endTime")).substring(10,12);
	}
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

var progName = '<%=progName%>';
var cruntProgStartTime = '<%=cruntProgStartTime%>';
var cruntProgEndTime = '<%=cruntProgEndTime%>';
var cruntProgStartAllTime = '<%=cruntProgStartAllTime%>';
var cruntProgEndAllTime = '<%=cruntProgEndAllTime%>';
var preProgName = '<%=preProgName%>';
var preProgStratTime = '<%=preProgStratTime%>';
var nextProgName = '<%=nextProgName%>';
var nextProgStratTime = '<%=nextProgStratTime%>';
<%
for(int i=0;i<count && i<4;i++)
{
	%>
	progNames[<%=i%>]="<%=progNames[i]%>";
	progTimes[<%=i%>]="<%=progTimes[i]%>";
	<%
}
%>

function init()
{
	Authentication.CTCSetConfig("mediacode","<%=channelMediaCode%>");
	if(progName=="")
	{
		progName="暂无节目"
	}
	document.getElementById("cruntProgName").innerHTML = "当前节目："+progName;
	
	
	
	
	             
				 
				 
				 
/*	if(preProgStratTime=="null"||nextProgStratTime=="null")
	{
		preProgStratTime="";
		nextProgStratTime="";
	}
	*/
	if(preProgName=="")
	{
		preProgName="暂无节目"
	}
	
	if(nextProgName=="")
	{
		nextProgName="暂无节目"
	}
			
	 document.getElementById("preProgName").innerHTML = '<span class="th">上一个节目：</span>'+preProgStratTime+" "+preProgName;
	document.getElementById("nextProgName").innerHTML ='<span class="th">下一个节目：</span>'+nextProgStratTime+" "+nextProgName;
	document.getElementById("cruntProgStartTime").innerHTML = cruntProgStartTime;
	document.getElementById("cruntProgEndTime").innerHTML = cruntProgEndTime;
	
	var c_Date = new Date();
	if(cruntProgStartAllTime!=""&&cruntProgEndAllTime!="")
	{
		var s_Date = StrConverDate(cruntProgStartAllTime);
		var e_Date = StrConverDate(cruntProgEndAllTime);
		var s_Time = s_Date.getTime();
		var e_Time = e_Date.getTime();
		var c_Time = c_Date.getTime();
		
		var cTime = parseInt((c_Time-s_Time)/1000,10);
		var progTime = parseInt((e_Time-s_Time)/1000,10);
		document.getElementById("process").style.width = Math.floor(184*(cTime/progTime))+"px";
		document.getElementById("processball").style.left = Math.floor(184*(cTime/progTime))+"px";
	}

}

function StrConverDate(time){
	return new Date(time.substring(0,4),
				   parseInt(time.substring(4,6),10)-1,
				   time.substring(6,8),
				   time.substring(8,10),
				   time.substring(10,12),
				   time.substring(12,14));
}
parent.showFilmInfoFlag = "true";
</script>

<!--<body onLoad="javascript:init_info()" bgcolor="transparent" style="color:#FFFFFF">
  
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
  
</body>-->

<body onLoad="init();">
<div class="wrapper">
    <div class="playbar-c">

        <!--进度条-->
        <div class="progress-wrap">
            <div class="progress-bar">
                <div id="process" class="progress-position-read"></div>   <!--蓝色进度条控制点 单位进度是 43px 例如已读取8个格子的进度 就是 width = 8 * 43px = 344px-->

                <!--

                宽度控制进度  注当宽度为 width:0px 或 width:0% 时，替换为 width:1px; 以解决部分盒子可能会有兼容问题

                -->

            </div>
        </div>

        <div class="progress-sunBox">
            <div id="processball" class="progress-moveBox">   <!--焦点控制点 left   单位进度是 43px 例如锁定第10个格子 就是 left = 10 * 43px = 430px -->

                <!--

                小太阳，当前位置点
                左侧坐标控制进度焦点  注当坐标为 left:0px 或 left:0% 时，替换为 left:1px; 以解决部分盒子可能会有兼容问题

                -->

                <div class="pic"><img src="../images/t.gif" /></div>  <!--焦点图-->
                <!--<div class="txt">00:32</div>-->  <!--对应焦点的时间-->
            </div>
        </div>

        <!--左侧时间-->
        <div class="winTxt" style="left:297px; font-size:14px; top:10px; width:95px; height:30px; text-align: right;" id="cruntProgStartTime"></div>

        <!--右侧时间-->
        <div class="winTxt" style="left:541px; font-size:14px; top:10px; width:84px; height:30px; text-align: left;" id="cruntProgEndTime"></div>

        <!--标题-->
        <div id="cruntProgName" style="left:27px; top:20px; width:351px; height:30px; position:absolute; font-size:22px;"></div>

        <div class="proPrevNext" style="position:absolute; width:613px; height:67px; left: 26px; top: 62px;">
            <div class="item" style="left:0px;top:0px;">
                <div class="txt" id="preProgName"></div>
            </div>
            <div class="item" style="left:0px;top:32px;">
                <div class="txt" id="nextProgName"></div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
