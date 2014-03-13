<%
/*********************
* fileName:play_ControlChannelName.jsp
* Time:20130905 9:45
* Author:ZSZ
* description:新增频道名称显示
*********************/
%>

<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ include file = "datajsp/SubStringFunction.jsp"%>

<%
	//频道个数
	int listSizeStr = 0; 
	//当前频道索引 初始值为-1
    int currChanIndex = -1; 
	//存储频道号以及对应的频道信息的有序map
	TreeMap chanNumMap = new TreeMap();
	//存储频道名称相关信息
	HashMap chanInfo = new HashMap();
	

	MetaData nameData = new MetaData(request);

	//调用接口获得频道列表
	/*********20130912 10:25 ZSZ 增加code异常保护*********/ 
	List HDChannelList = new ArrayList();
	List SDChannelList = new ArrayList();
	List tempHDList = new ArrayList();
	List tempSDList = new ArrayList();
	try{
		HDChannelList = nameData.getChanListByTypeId("00000100000000090000000000015840",-1,0);
		//HDChannelList = nameData.getChanListByTypeId("0000010000000009000000000001584",-1,0);错误测试数据
		tempHDList = (ArrayList)HDChannelList.get(1);
	}catch(Exception e){

	}
	try{
		SDChannelList = nameData.getChanListByTypeId("00000100000000090000000000015842",-1,0);
		//SDChannelList = nameData.getChanListByTypeId("0000010000000009000000000001584",-1,0);错误测试数据
		tempSDList = (ArrayList)SDChannelList.get(1);
	}catch(Exception e){

	}
	/*********20130912 10:25 ZSZ 增加code异常保护*********/ 

	//得到高标清列表
	ArrayList tempList = new ArrayList();
	tempList.addAll(tempHDList);
	tempList.addAll(tempSDList);

	//得到高标清总数
	listSizeStr = tempList.size();

	//频道号数组,
	int[] chanNums = new int[listSizeStr];
	//频道名称数组
	String[] chanNames = new String[listSizeStr];

	for(int i=0; i<listSizeStr; i++){
		chanInfo = (HashMap)tempList.get(i);//20130827修改排序把高清频道放前面
		Integer chanIndex = (Integer)chanInfo.get("CHANNELINDEX");//频道顺序号
		//chanNumMap.put(chanIndex, chanInfo);
		chanNumMap.put(i, chanInfo);//20130827修改排序把高清频道放前面
	}	    
	
	Iterator it = chanNumMap.keySet().iterator();
	int realSize = 0;
	while(it.hasNext()){
		Integer key = (Integer)it.next();
		chanInfo = (HashMap)chanNumMap.get(key);
		//频道名称
		String chanName = (String)chanInfo.get("CHANNELNAME");
		chanNames[realSize] = subStringFunction(chanName,1,130);
		chanNums[realSize] = (((Integer)chanInfo.get("CHANNELINDEX")).intValue())-1000;	//跟显示同步频道号减少1000
		realSize++;
	}
%>
	<script>
	var showchannelNames = new Array();
	var showchannelNums = new Array();
	</script>
<%
	for(int i=0; i<realSize; i++){
%>
	<script>
	showchannelNames[<%=i%>] = '<%=chanNames[i]%>';
	showchannelNums[<%=i%>] = <%=chanNums[i]%>;
	</script>		
<%        
 }
%>
