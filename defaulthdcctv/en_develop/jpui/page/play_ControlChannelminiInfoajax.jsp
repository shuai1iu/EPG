<%@ page contentType="text/html; charset =UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page errorPage="ShowException.jsp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.func.STBAction" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="java.util.*" %>
<%@ include file = "SubStringFunction.jsp"%>
<%@ page import="net.sf.json.JSONArray" %>
<%
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
Date currDate = new java.util.Date();
String str_CurrDateTime = formatter.format(currDate);
String currTime = StringDateUtil.getTodaytimeString("yyyyMMddhhmmss");
MetaData metaData = new MetaData(request);
//频道id
String progID = request.getParameter("CHANNELID")==null?"0":request.getParameter("CHANNELID").equals("undefined")?"0":request.getParameter("CHANNELID");

/*********20130905 17:30 ZSZ 增加OSD显示频道号************/
String progNum = request.getParameter("CHANNELNUM")==null?"0":request.getParameter("CHANNELNUM").equals("undefined")?"0":request.getParameter("CHANNELNUM");
/*********20130905 17:30 ZSZ 增加OSD显示频道号************/

int chanId = Integer.parseInt(progID);
//当前频道名称
String channelName = "";
String channelMediaCode ="";

/**************20130912 11:21 ZSZ 增加异常保护**************/
//调用接口获取频道详情
HashMap chanInfoMap = new HashMap();
try{
	chanInfoMap = (HashMap)metaData.getChannelInfo(progID);
}catch(Exception e){

}
/**************20130912 11:21 ZSZ 增加异常保护**************/


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
	count = progMenus.length;
	progTimes=new String[count];
	progNames=new String[count];
	String tempTime = "";

	for(int i = 0; i < count; i++){
		String s=progMenus[i].substring(10,11);
		String[] pros=progMenus[i].split(s);
		try{//20130912 11:13 ZSZ 时间切割去除秒
			tempTime = pros[1].substring(0,5);//节目开始时间
			progTimes[i] = tempTime;
		}catch(Exception e){
			progTimes[i] = pros[1];
		}
		if(pros[2].length()>9)
			progNames[i] = pros[2].substring(0,9);//节目名称
		else
			progNames[i] = pros[2];
	}
	/*******20130909 17:00 ZSZ 修改显示节目单只显示节目名称***********/
}
if(progInfo != null)
{
	HashMap progMap = (HashMap)progInfo.get("CURRPROG");
	if(progMap != null)
	{
		progName = ((String)progMap.get("progName") == null ? "" : (String)progMap.get("progName"));
		if(progName.length()>9)
			progName = progName.substring(0,9);
	}
}
StringBuffer jsonStr = new StringBuffer();
jsonStr.append("{channelinfo:{channelMediaCode:'"+channelMediaCode+"',progName:'"+progName+"',progNum:"+progNum+",channelName:'"+channelName+"'}");
String strprogMenus="";
if(progNames.length>=1){
	 jsonStr.append(",progMenus:[");
	 for(int i=0;i<progNames.length && i<5;i++)
     {    
	      int itemp=1;
	      if(progNames.length>5) {
			  itemp=5;
		  }
		  else{
			  itemp=progNames.length;
		  }
	      if(i==(itemp-1)){
			  strprogMenus="{progName:'"+progNames[i]+"',progTime:'"+progTimes[i]+"'}";
		  }else{
			  strprogMenus="{progName:'"+progNames[i]+"',progTime:'"+progTimes[i]+"'},";
		  }
		  jsonStr.append(strprogMenus);
     }
	 jsonStr.append("]");
}
jsonStr.append("}");
System.out.println(jsonStr.toString());
response.getWriter().print(jsonStr.toString());
%>
