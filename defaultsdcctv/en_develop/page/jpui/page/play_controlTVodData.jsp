<!-- Copyright (C), pukka Tech. Co., Ltd. -->
<!-- Author:mxr -->
<!-- CreateAt:20120410 -->
<!-- FileName:playControleVodData.jsp -->

<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ include file = "SubStringFunction.jsp"%>
<%!
/**
 * 录播节目的的节目单有可能是跨年和跨天的，根据节目单开始日期返回结束时间
 * @param dateString 格式:YYYYMMDD
 */
//String getEndTime(String _year,String _month,String _day)
String getEndTime(String dateString)
{
	String tmpYear = "";
	String tmpMonth = "";
	String tmpday = "";
	int year = -1;
	int month = -1;
	int day = -1;
	try
	{
		year = Integer.parseInt(dateString.substring(0,4));
		month = Integer.parseInt(dateString.substring(4,6));
		day = Integer.parseInt(dateString.substring(6,8));
	}
	catch(Exception exception)
	{
	}
	boolean isRun = false; //是否是闰年
	if(year % 4 == 0 && year % 100 != 0 || year % 400 == 0)
	{
		isRun = true;
	}
	if(month == 2)
	{
		if(day == 28)
		{
			if(isRun)
			{
				day = 29;
			}
			else
			{
				month = month + 1;
				day = 1;
			}
		}
		else if(day == 29)
		{
			month = month + 1;
			day = 1;
		}
		else
		{
			day = day + 1;
		}
	}
	else if(month == 4 || month == 6 || month == 9 || month == 11)
	{
		if(day == 30)
		{
			day = 1;
			month = month + 1;
		}
		else
		{
			day = day + 1;
		}
	}
	else
	{
		if(day == 31)
		{
			if(month == 12)
			{
				year = year + 1;
				day = 1;
				month = 1;
			}
			else
			{
				day = 1;
				month = month + 1;
			}
		}
		else
		{
			day = day + 1;
		}
	}

	if(month < 10)
	{
		tmpMonth = "0" + month;
	}
	else
	{
		tmpMonth = "" + month;
	}

	if(day < 10)
	{
		tmpday = "0" + day;
	}
	else
	{
		tmpday = "" + day;
	}
	return "" + year + tmpMonth + tmpday;
}
%>
<%
MetaData metaData = new MetaData(request);	 
String progId = request.getParameter("progId");
int iProgId = Integer.parseInt(progId);
String channelId = request.getParameter("channelId");
int iChannelId = Integer.parseInt(channelId);

Map progInfo = (HashMap)metaData.getProgDetailInfo(iProgId);
String strIntro = (String)progInfo.get("INTRODUCE");
strIntro = (null == strIntro)?"暂无介绍":subStringFunction(strIntro,2,400);

int playType = EPGConstants.PLAYTYPE_TVOD;

//处理频道
String channelName = "";
HashMap chanInfoMap = metaData.getChannelInfo(channelId);

String tvodMediaCode =(String)progInfo.get("CODE");

int liveStatus = 1;
if(null == chanInfoMap)
{
	channelName = "";
}
else
{
	String tmpChannelName = (String)chanInfoMap.get("CHANNELNAME");
	liveStatus = ((Integer)chanInfoMap.get("LIVESTATUS")).intValue();
	channelName = subStringFunction(tmpChannelName,1,110);
}
String startDate = "";

String progName = "暂无";
String progTimeBegin = "";
String progTimeEnd = "";
String progTimeSpan = "";

String preProgName = "暂无";
String preProgBeginTime = "";
String preProgEndTime = "";
String preProgId = "-1";

String nextProgName = "暂无";
String nextProgBeginTime = "";
String nextProgEndTime = "";
String nextProgId = "-1";

String[] tmpprog = metaData.getRecBill(iChannelId);//获得该频道所有录播节目

String[] progStartTime = null; // 需要传递
String[] progEndTime = null;   // 需要传递

String[] progNames = null;
String[] progIds = null;
String[] isOrdered = null; //是否可订购标志 1、可以 0、不可以
String[] elapseTime = null;

String[] disProgStartDateArr = null; // 需要显示的开始日期
String[] disProgStartTimeArr = null; // 需要显示的开始时间
String[] disProgEndDateArr = null;   // 需要显示的结束日期
String[] disProgEndTimeArr = null;   // 需要显示的结束时间
int progSize = 0;  //录播节目数量
int currIndex = 0; //当前播录播节目 在结果集中的索引
if(null != tmpprog)
{
	progSize = tmpprog.length;
	progStartTime = new String[progSize];
	progEndTime = new String[progSize];
	progNames = new String[progSize];
	progIds = new String[progSize];
	isOrdered = new String[progSize];
	disProgStartTimeArr = new String[progSize];
	disProgEndTimeArr = new String[progSize];
	elapseTime = new String[progSize];
	for(int i = 0; i < progSize; i++)
	{
		String[] temp = tmpprog[i].split("\u007f"); //每个节目的具体信息
		String tmpStartDate = temp[0]; //开始日期
		String tmpStartTime = temp[1]; //开始时间
		String tmpEndtDate = "";       //结束日期
		String tmpEndTime = temp[3];   //结束时间
		progIds[i] = temp[4];
		isOrdered[i]  = temp[5];
		//页面显示的一个节目的开始时间和结束时间
		disProgStartTimeArr[i] = temp[1].substring(0,5);
		disProgEndTimeArr[i] = temp[3].substring(0,5);
		tmpStartDate = temp[0].substring(0,4) + temp[0].substring(5,7) + temp[0].substring(8,10);
		if(i == 0){
			startDate = tmpStartDate;
		}
		tmpStartTime = temp[1].substring(0,2) + temp[1].substring(3,5) + temp[1].substring(6,8);
		progNames[i] = temp[2];
		tmpEndtDate = tmpStartDate;
		tmpEndTime = temp[3].substring(0,2) + temp[3].substring(3,5) + temp[3].substring(6,8);
		if (tmpStartTime.compareTo(tmpEndTime) >= 0) //跨天
		{
			tmpEndtDate = getEndTime(tmpStartDate);
		}
		progStartTime[i] = tmpStartTime;  //传参  tmpStartDate + tmpStartTime
		progEndTime[i] = tmpEndTime; //传参  tmpEndtDate + tmpEndTime; 
		//计算当前节目时长
	}
	for(int j = 0; j < progSize; j++)
	{
		if(progId.equals(progIds[j]))
		{
			//当前节目信息
			currIndex = j;
			progName = subStringFunction(progNames[currIndex],1,110);
			progTimeSpan = disProgStartTimeArr[j] + "~" + disProgEndTimeArr[j];
		}
	}
	if(currIndex - 1 < 0){
		preProgName = "";
	}else{
		preProgId = progIds[currIndex - 1];
		preProgName = subStringFunction(progNames[currIndex - 1],1,115);
		preProgBeginTime = progStartTime[currIndex - 1];
		preProgEndTime = progEndTime[currIndex - 1];
	}if(currIndex + 1 >=  progSize){
		nextProgName = "";
	}else{
		nextProgId = progIds[currIndex + 1];
		nextProgName = subStringFunction(progNames[currIndex + 1],1,115);
		nextProgBeginTime = progStartTime[currIndex + 1];
		nextProgEndTime = progEndTime[currIndex + 1];
	}
}
%>
<script>
if (typeof(iPanel) != 'undefined')
  {
	iPanel.focusWidth = "4";
	iPanel.defaultFocusColor = "#FCFF05";
  }
var startDate = "<%=startDate%>";//节目开始日期
var preProgId = "<%=preProgId%>";//上一个节目id
var preProgName = "<%=preProgName%>";
var preProgBeginTime = "<%=preProgBeginTime%>";
var preProgEndTime = "<%=preProgEndTime%>";
var nextProgId = "<%=nextProgId%>";//下一个节目id
var nextProgName = "<%=nextProgName%>";
var nextProgBeginTime = "<%=nextProgBeginTime%>";
var nextProgEndTime = "<%=nextProgEndTime%>";
var progName = "<%=progName%>";//节目名
var channelName = "<%=channelName%>";//频道名
var progTimeBegin = "<%=progTimeBegin%>";//节目开始时间
var progTimeEnd = "<%=progTimeEnd%>";//节目结束时间
var progTimeSpan = "<%=progTimeSpan%>"; //当前vod的集
var introduce = "<%=strIntro%>"; //节目介绍
/**
*将数据赋值到父页面
*/
function copyDataToFather()
{	
	parent.startDate = startDate;
	parent.preProgId = preProgId;//上一个节目id
	parent.preProgName = preProgName;
	parent.nextProgId = nextProgId;//下一个节目id
	parent.nextProgName = nextProgName;
	parent.progName = progName;//本vod的名字
	parent.channelName = channelName;//导演
	parent.progTimeBegin = progTimeBegin;
	parent.progTimeEnd = progTimeEnd;//节目结束时间
	parent.introduce = introduce;//介绍信息
	parent.progTimeSpan = progTimeSpan; //节目的开始时间与结束时间
	parent.introduce = introduce;
	parent.preProgBeginTime = preProgBeginTime;
	parent.preProgEndTime = preProgEndTime;
	parent.nextProgBeginTime = nextProgBeginTime;
	parent.nextProgEndTime = nextProgEndTime;
}
copyDataToFather();
parent.dataIsOk = true;
parent.createMinEpg();
</script>