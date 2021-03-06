﻿<!-- FileName:play_ControlChannelListTv.jsp -->
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page errorPage="ShowException.jsp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ page import="java.util.*" %>
<%@ include file = "../datasource/SubStringFunction.jsp"%>
<%@ include file="../datasource/property.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title></title>
</head>
<%
String channelID = request.getParameter("CHANNELID");
String channelNum = request.getParameter("CHANNELNUM");
String comeType = request.getParameter("COMEFROMFLAG");	
MetaData metaData = new MetaData(request);
ServiceHelp serviceHelp = new ServiceHelp(request);								  
int listSizeStr = 0;                                     //频道个数
int currChanIndex = -1;                                  //当前频道索引 初始值为-1
//调用接口获得频道列表，旧方式
//ArrayList recChanList = metaData.getChannelListInfo();

//下面分开分别为计算高清和标清的总和
ArrayList result = metaData.getChanListByTypeId(gaoqingzhibocode,-1,0);//高清直播CODE
ArrayList result1 = metaData.getChanListByTypeId(biaoqingzhibocode,-1,0);//标清直播CODE
ArrayList recChanList=(ArrayList)result.get(1);
ArrayList channel1=(ArrayList)result1.get(1);
recChanList.addAll(channel1);//得到所有的
listSizeStr = recChanList.size();//频道个数
TreeMap chanNumMap = new TreeMap();//存储频道号以及对应的频道信息的有序map
HashMap chanInfo = new HashMap();
for(int i=0; i<listSizeStr; i++)
{
	chanInfo = (HashMap)recChanList.get(i);
	Integer chanIndex = (Integer)chanInfo.get("CHANNELINDEX");//频道顺序号
	chanNumMap.put(chanIndex, chanInfo);
}	    	
int[] chanIds = new int[listSizeStr];//频道ID数组
String[] chanCode = new String[listSizeStr];
String[] chanNames = new String[listSizeStr];//频道名称数组
int[] chanNums = new int[listSizeStr];//频道号数组, 播放时使用
int[] isSub = new int[listSizeStr];//频道授权数组
boolean[] isControlled = new boolean[listSizeStr];//是否受控级别 (true:受控  false:不受控)
int[] pltvStatus = new int[listSizeStr];//频道激活时移状态(时移状态: 1激活 0去激活)
String[] chanUrls = new String[listSizeStr];//授权通过的URL链接
String[] isSubPreview = new String[listSizeStr];
//int[] isOrder = new int[listSizeStr];
int realSize = 0;
Iterator iter = chanNumMap.keySet().iterator();
int tmpchannelNum=Integer.parseInt(channelNum)+1000;//为找到焦点而修改，因为下发的减了1000，但是平台接口没有减去1000
while(iter.hasNext())
{
	Integer key = (Integer)iter.next();
	chanInfo = (HashMap)chanNumMap.get(key);
	//过滤高清
	/*20110815临时屏蔽掉,如果需要过滤时开启
	String SupportHD = (String)session.getAttribute("SupportHD");
	if("0".equals(SupportHD))
	{
		Integer iDEFINITION = (Integer)chanInfo.get("DEFINITION");
		if(iDEFINITION != null)
		{
			int DEFINITION = iDEFINITION.intValue();
			//2为标清，1为高清
			if(1==DEFINITION )
			{
				continue;
			}
		}
	}
	*/
	String chanName = (String)chanInfo.get("CHANNELNAME");
	chanNames[realSize] = subStringFunction(chanName,1,130);
	chanIds[realSize] = ((Integer)chanInfo.get("CHANNELID")).intValue();
	chanCode[realSize] = "";//(String)chanInfo.get("CODE");
	chanNums[realSize] = ((Integer)chanInfo.get("CHANNELINDEX")).intValue();//采用的CHANNELINDEX来装载播放号
	if(null != channelID && !"null".equals(channelID))
	{
		if(channelID.equals(String.valueOf(chanIds[realSize]))){
			currChanIndex = realSize;
		}
	}else{
	        //channelNum.equals(String.valueOf(chanNums[realSize]))
		if(tmpchannelNum==chanNums[realSize]){		
			currChanIndex = realSize;
		}
	}
	isSub[realSize] = 1;// ((Integer)chanInfo.get("ChannelPurchased")).intValue();
	pltvStatus[realSize] = ((Integer)chanInfo.get("PLTVSTATUS")).intValue();
	isControlled[realSize] = serviceHelp.isControlledOrLocked(true,false,EPGConstants.CONTENTTYPE_CHANNEL_VIDEO,chanIds[realSize]);//是否受控
	isSubPreview[realSize] = "";//(String)chanInfo.get("PreviewEnableHWCTC");
	realSize++;
}
//判断频道是否加锁
int[] isLock = new int[realSize];
ArrayList lockInfo = serviceHelp.getLockList();
if(lockInfo != null && lockInfo.size() > 1)
{
	lockInfo = (ArrayList)lockInfo.get(1);
	for(int i=0; i<lockInfo.size(); i++)
	{
		HashMap tmpMap = (HashMap)lockInfo.get(i);
		int lockId = Integer.parseInt((String)tmpMap.get("PROG_ID"));
		int lockType = ((Integer)tmpMap.get("PROG_TYPE")).intValue();
		if(lockType == EPGConstants.CONTENTTYPE_CHANNEL)
		{
			for(int j=0; j<realSize; j++)
			{
				if(lockId == chanIds[j]){
					isLock[j] = 1 ; 
					break;
				}
			}
		 }
	}
}
%>
<script language="javascript">	
function getInt(num)
{
	num = num + "";
	var i = num.indexOf(".");
	var currpage = num.substring(0,i);
	return parseInt(currpage,10);
}
var tempChannelNum;
</script>
<%  
for(int i=0; i<realSize; i++)
{
%>
	<script>
	parent.channelIds[<%=i%>] = '<%=chanIds[i]%>';
	parent.channelNames[<%=i%>] = '<%=chanNames[i]%>';
	tempChannelNum = <%=chanNums[i]%>;
	parent.channelNums[<%=i%>] = tempChannelNum-1000;//20120412修改,播放使用值
	tempChannelNum=tempChannelNum-1000;
	if(tempChannelNum<10){
		tempChannelNum = "00"+tempChannelNum;
	}else if(tempChannelNum > 9 && tempChannelNum < 100){
		tempChannelNum = "0"+tempChannelNum;
	}
	parent.channelNumsShow[<%=i%>] = tempChannelNum;
	parent.isSub[<%=i%>] = '<%=isSub[i]%>';
	parent.pltvStatus[<%=i%>] = '<%=pltvStatus[i]%>';
	parent.channelUrls[<%=i%>] = '<%=chanUrls[i]%>';
	parent.isLock[<%=i%>] = '<%=isLock[i]%>';
	parent.isControlled[<%=i%>] = '<%=isControlled[i]%>';
	parent.channelCode[<%=i%>] = '<%=chanCode[i]%>';
	parent.isSubPreview[<%=i%>] = '<%=isSubPreview[i]%>'; 
	</script>		
<%        
 }
%>
<script>
var currIndex = '<%=currChanIndex%>';//当前的下标
var comeType = '<%=comeType%>';//直播来源 3表示页面快捷键
parent.currChannelIndex = currIndex;
parent.chanListFocus = currIndex;
parent.totalChannel = '<%=realSize-1%>';
var totalPage = '<%= Math.round(realSize/(float)13 + 0.4999f)%>';//总共多少页
parent.totalListPages = totalPage;
//当前是第几页
if(currIndex % 13 == 0){
	parent.currListPage = currIndex / 13;
}else{
	parent.currListPage = getInt(currIndex / 13);
}
parent.init_page();
parent.showInfo();//MITIEPG数据
parent.getDataFlag = "true";
if(typeof(iPanel)!= 'undefined'){iPanel.focusWidth = "8"; iPanel.defaultFocusColor = "#2A5BB8";}
//频道或数字键进入 且 已定购  直接播放
if (comeType != 0 && 3 != parent.isSub[currIndex])
{
	parent.joinChannel(parent.currChannelNum);
	return;
}
//开机进直播、预览 需验证
parent.authtication(currIndex);
if("false" == parent.lockPlay){return;}
parent.joinChannel(parent.currChannelNum);
</script>
</html>
