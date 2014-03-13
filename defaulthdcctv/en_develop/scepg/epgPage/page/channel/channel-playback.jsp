<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<% 
	String channelListFile="../../../" + datajspname  + "/channelList.jsp";

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>频道回放- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<style type="text/css">
<!--
	body{ background:url(../../images/bg-c00.jpg) no-repeat;}
-->
</style>
<%@ include file="../../../util/servertime.jsp"%>
<%@ include file="../../../util/channelDateUtil.jsp"%>
<%@ include file="../../../config/code.jsp"%>
<%@ include file="../../base.jsp"%>
<script type="text/javascript">

       var tVODProgrameList=null; 
        //将频道列表全部取出来
		<jsp:include page="<%=channelListFile%>">
				<jsp:param name="categoryCode" value="<%=channelListCode%>"/> 
				<jsp:param name="varName" value="channelList"/>
				<jsp:param name="fields" value="-1" /> 
				<jsp:param name="pageIndex" value="1" /> 
				<jsp:param name="pageSize" value="-1" />
				<jsp:param name="isBug" value="1" />
		</jsp:include>	
		
		function callTVODProgram(data)
		{
		    tVODProgrameList=data;
			/*for(var i=0;i<10;i++)
			{
				if(i<tVODProgrameList.length)
				{	
			      $("area4_num_"+i).innerHTML=(tVODProgrameList[i].startTime).substring(0,5);
				  area4.doms[i].setcontent("",tVODProgrameList[i].tvodProgramName,7,true,false);
			
				}else
				{
				  $("area4_num_"+i).innerHTML="";
				  $("area4_txt_"+i).innerHTML="";				
				}
			}*/
			
			 binTVODProgramListData(getTVODProgramListValue(area4.curpage)) ;
			
			 area4.pagecount =Math.ceil((tVODProgrameList.length/10));		
	    }
</script>
<script type="text/javascript">

var area0,area1,area2,area3,area4;
var pageobj;
var areaid = 3;
var indexid = 0;
var drnessfocus=0;
var drness2focus=0;
var area2curpage=1;
var area4curpage=1;
var area5curpage=0;
var currentResult="<%=currentResult%>".split(",");
var resultNum="<%=resultNum%>".split(",");
window.onload=function()
{
	 window.focus();
	 var focusObj=OperatorFocus.getCurFocusAndDelete();
     if(focusObj!=undefined && focusObj!="null" && focusObj!=null)
	 {
		if(focusObj.focusdatas!=undefined && focusObj.focusdatas.length>0)
		{				
			areaid=focusObj.focusdatas[0].areaid;
			indexid=focusObj.focusdatas[0].curindex;
			area4curpage=focusObj.focusdatas[0].curpage;
			area5curpage=focusObj.focusdatas[0].curpage;

		}
	   if(focusObj.focusdatas!=undefined && focusObj.focusdatas.length>1)
	   {
	
		   drnessfocus=focusObj.focusdatas[3].curindex;
		   drness2focus=focusObj.focusdatas[2].curindex;
		   area2curpage=focusObj.focusdatas[2].curpage;
	    }
	 }
     area0=AreaCreator(9, 1, new Array( - 1, -1, -1,  1), "area0_list_", "className:item item_focus", "className:item");
	 area0.setstaystyle("className:item",3);
	 area0.doms[0].domOkEvent=function()
	 {
		 window.location.href="../index/index.jsp";
	 }
	 area0.doms[1].domOkEvent=function()
	 {
		 window.location.href="channel.jsp";
	 }
	 area0.doms[2].domOkEvent=function()
	 {
		 window.location.href="../dibbling/dibbling.jsp";
	 }
     area1=AreaCreator(2, 1, new Array( - 1, 0, -1, 2), "area1_list_", "className:item item_focus", "className:item");
     area1.stablemoveindex=new Array(-1,"0-1,1-1",-1,-1);
     area1.setdarknessfocus(1);
	 area1.setstaystyle("className:item",3);
	 area1.changefocusedEvent=function()
     {
		 if(area1.curindex==0)
		 {
			 window.location.href="channel.jsp";			
		 }
		 if(area1.curindex==1)
		 {
			 //初始化绑定频道列表
			 binChannelListData(getChannelTVODListValue(1),1);
			 area2.curpage=1;  
		 }
       
    };
	 
	 
	 
     area2=AreaCreator(10, 1, new Array( - 1, 1, -1, 3), "area2_list_", "className:item item_select", "className:item");
	 for(i=0;i<area2.doms.length;i++)
	 {
		 area2.doms[i].contentdom = $("area2_txt_"+i);		
	 }
	 area2.setdarknessfocus(drness2focus);
     area2.setstaystyle("className:item",3);
	 area2.curpage=area2curpage;
	 area2.pagecount =Math.ceil((getAllTVODList().length/10));	
	 area2.endwiseCrossturnpage = true;  
	 area2.areaPageTurnEvent = function(num)
	 {
	    if(area1.curindex==1)
	    { 
		   //绑定频道列表
	       binChannelListData(getChannelTVODListValue(area2.curpage),area2.curpage);
		   //初始化当前页/总页数 		   
		   initPageSize() ;
	
	    }
		
	 }; 
	 area2.changefocusedEvent=function()
	 {     
	       //area2改变焦点刷新节目单
           var index=area2.curpage;
		   var channelID=getChannelTVODListValue(index)[area2.curindex].channelID;	
	       var programFrame=$("getTVODProgramFrame");
		   programFrame.src="../iframe/getTVODProgramFrame.jsp?channelID="+channelID+"&curdate="+resultNum[0];    

	 }

     area3=AreaCreator(7, 1, new Array( - 1, 2, -1, 4), "area3_list_", "className:item item_focus", "className:item");
	 for(i=0;i<area3.doms.length;i++)
	 {
		 area3.doms[i].contentdom = $("area3_txt_"+i);		
	 }
     area3.setdarknessfocus(drnessfocus);
     area3.setstaystyle("className:item",3);
	
	 area3.changefocusedEvent=function()
	 {
		 //area3改变焦点刷新节目单
		  var index=area2.curpage;
		  var channelID=getChannelTVODListValue(index)[area2.curindex].channelID;	
	      var programFrame=$("getTVODProgramFrame");
		  programFrame.src="../iframe/getTVODProgramFrame.jsp?channelID="+channelID+"&curdate="+resultNum[area3.curindex];     
	 }
	 
 
     area4=AreaCreator(10, 1, new Array( - 1, 3, -1, -1), "area4_list_", "className:item item_focus", "className:item");
	 for(i=0;i<area4.doms.length;i++)
	 {
		 area4.doms[i].contentdom = $("area4_txt_"+i);		
	 }
	 
	 area4.curpage=area4curpage;
	 area4.pagecount =1;
	 area4.endwiseCrossturnpage = true;  
	 area4.areaPageTurnEvent = function()
	 {   
	     //绑定节目单
		 binTVODProgramListData(getTVODProgramListValue(area4.curpage)) ;
	 }
	 if(area5curpage!=0)
	 {
		   var index=area2.curpage;
		   var channelID=getChannelTVODListValue(index)[area2.curindex].channelID;	
	       var programFrame=$("getTVODProgramFrame");
		   programFrame.src="../iframe/getTVODProgramFrame.jsp?channelID="+channelID+"&curdate="+resultNum[area3.curindex];
		 
	 }

	
	 area4.areaOkEvent=function()
	 {
         //到播放页面后获取播放地址实现播放
	     var tvodProgramId= getTVODProgramListValue(area4.curpage)[area4.curindex].tvodProgramId;
		 var startTime= getTVODProgramListValue(area4.curpage)[area4.curindex].startTime;
		 var endTime=getTVODProgramListValue(area4.curpage)[area4.curindex].endTime;
	     window.location.href="../vodPlayer/vodPlayer.jsp?programType=1&tvodProgramId="+tvodProgramId+"&startTime="+startTime+"&endTime="+endTime+"&returnUrl="+escape(location.href);
		 
     }
	 area1.areaInedEvent=function()
     {
        $("area3_list_"+area3.curindex).className="item";
     
     };
     area2.areaInedEvent=function()
     {
        $("area1_list_"+area1.curindex).className="item item_select";
     
     };
     area3.areaInedEvent=function()
     {
        $("area2_list_"+area2.curindex).className="item item_select";
     
     };
     area4.areaInedEvent=function()
     {
        $("area3_list_"+area3.curindex).className="item item_select";
     };
     
	 
     pageobj = new PageObj(areaid, indexid, new Array(area0,area1,area2,area3,area4));
	 pageobj.backurl =OperatorFocus.getLastReturn();
     pageInit();
	 pageobj.pageOkEvent=function()
	 {
		OperatorFocus.saveFocstr(pageobj);
	 };
     
     
     
};

	function pageInit()
	{   
	     //初始化频道列表
		 binChannelListData(getChannelTVODListValue(area2.curpage),area2.curpage);
		 //初始化时间
		 initTime(); 
		 //初始化area3
		 initCalendar();
		 //初始化当前页/总页数
		 initPageSize();
	}



	//找到全部能录播的频道
	function getAllTVODList()
	{
		var tVODTotalList=new Array();	
		var length=channelList.channelDataList.length;
		for(var i=0;i<length;i++)
		{
			if(channelList.channelDataList[i].isTVOD=="1")
			{
				tVODTotalList.push(channelList.channelDataList[i]);
			}
		}
		return tVODTotalList;
		
    }
	
		
    //对录播列表进行分页处理
    function getChannelTVODListValue(currentPage)
	{
		var allTVODList=getAllTVODList();
		var length=allTVODList.length;
		var start = (currentPage-1)*10;
		var end = (start+10);
		if(end>=length)
		{
			end=length;  
		}
		var temptestList=new Array();
		for(var i=start;i<end;i++)
		{
			temptestList.push(allTVODList[i]);
		}
		return temptestList;
	}
    


	//绑定录播频道列表
	function binChannelListData(datavalue,currentPage)
	{ 
	    var initNum="000";
		area2.datanum=datavalue.length;
		area2.setendwisepageturndata(area2.datanum,area2.pagecount);
		for(i=0;i<10;i++)
		{
			$("area2_txt_"+i).innerHTML="";
			$("area2_num_"+i).innerHTML="";
		}
		for(var j = 0; j< datavalue.length; j++) 
		{
			if(datavalue[j] != null)
			{
			    area2.doms[j].setcontent("",datavalue[j].channelName,6,true,false);
				var contentNum=initNum+""+datavalue[j].channelIndex;
		        $("area2_num_"+j).innerHTML=contentNum.substr(contentNum.length-3,3);
			}
		}
					
    }
	
	
	//对节目进行分页处理
	function getTVODProgramListValue(currentPage)
	{
		var totaltVODList=tVODProgrameList;
		var length=totaltVODList.length;
		var start = (currentPage-1)*10;
		var end = (start+10);
		if(end>=length)
		{
			end=length;  
		}
		var temptestList=new Array();
		for(var i=start;i<end;i++)
		{
			temptestList.push(totaltVODList[i]);
		}
		return temptestList;
	}
    
	//绑定录播节目
	function binTVODProgramListData(datavalue)
	{ 
	   
	   	area4.datanum=datavalue.length;
		area4.setendwisepageturndata(area4.datanum,area4.pagecount);
		for(var i=0;i<10;i++)
		{
			$("area4_txt_"+i).innerHTML="";
			$("area4_num_"+i).innerHTML="";
		}
		for(var j = 0; j< datavalue.length; j++) 
		{
			if(datavalue[j] != null)
			{
			    area4.doms[j].setcontent("",datavalue[j].tvodProgramName,7,true,false);
		       $("area4_num_"+j).innerHTML=(datavalue[j].startTime).substring(0,5);
			}
		}
					
    }
	
	
	//获取节目列表
	function getProgramsList()
	{
		var index=area2.curpage;
		var channelID=getChannelTVODListValue(index)[area2.curindex].channelID;	
		programFrame.src="../iframe/getTVODProgramFrame.jsp?channelID="+channelID+"&curdate="+resultNum[area3.curindex];
	}
	
	//初始化area3日期
	function initCalendar()
	{
		for(var i=0;i<area3.doms.length;i++)
		{
	        $("area3_txt_"+i).innerHTML=currentResult[i];
		
		}

	}
	
	//初始化时间
    function initTime()
	{
		$("timeDate").innerHTML = time1;
		$("time").innerHTML = time2;	
	};
	
	
    //初始化当前页/总页数
	function initPageSize()
	{
	   $("currentchannePage").innerHTML = area2.curpage;
	   $("channelTotalPage").innerHTML = Math.ceil((channelList.channelDataList.length/10));
	
	}
	
	





</script>
</head>

<body bgcolor="transparent">

<div class="wrapper">

	<!--head-->
	<div class="logo"><img src="../../images/logo.png" /></div>
	<div class="date">
			<div class="txt" id="timeDate">05/27</div>
			<div class="txt txt-time" style="top:22px;" id="time">11:15</div>
    </div>
	<!--head the end-->	
	
	
	
	<!--menu-->
	<div class="menu-a">
		<!--焦点 
				class="item item_focus" icon**.png 焦点为原图名上加：_focus
			选中	
				class="item item_select"  
		-->
		<div class="item" id="area0_list_0">
			<div class="icon"><img src="../../images/menu/icon01.png" /></div>
			<div class="txt">首&nbsp;页</div>
		</div>
		<div class="item" style="top:113px;" id="area0_list_1">
			<div class="icon"><img src="../../images/menu/icon02_focus.png" /></div>
			<div class="txt">频&nbsp;道</div>
		</div>
		<div class="item" style="top:169px;" id="area0_list_2">
			<div class="icon"><img src="../../images/menu/icon03.png" /></div>
			<div class="txt">点&nbsp;播</div>
		</div>
		<div class="item" style="top:225px;" id="area0_list_3">
			<div class="icon"><img src="../../images/menu/icon04.png" /></div>
			<div class="txt">专&nbsp;题</div>
		</div>
		<div class="item" style="top:281px;" id="area0_list_4">
			<div class="icon"><img src="../../images/menu/icon05.png" /></div>
			<div class="txt">本&nbsp;地</div>
		</div>
		<div class="item" style="top:337px;" id="area0_list_5">
			<div class="icon"><img src="../../images/menu/icon06.png" /></div>
			<div class="txt">应&nbsp;用</div>
		</div>
		<div class="item" style="top:393px;" id="area0_list_6">
			<div class="icon"><img src="../../images/menu/icon07.png" /></div>
			<div class="txt">套&nbsp;餐</div>
		</div>
		<div class="item" style="top:449px;" id="area0_list_7">
			<div class="icon"><img src="../../images/menu/icon08.png" /></div>
			<div class="txt">空&nbsp;间</div>
		</div>
		<div class="item" style="top:505px;" id="area0_list_8">
			<div class="icon"><img src="../../images/menu/icon09.png" /></div>
			<div class="txt">搜&nbsp;索</div>
		</div>
	</div>
	
	<div class="menu-b">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" style="top:260px;" id="area1_list_0">
			<div class="txt">直播频道</div>
		</div>
		<div class="item" style="top:315px;" id="area1_list_1">
			<div class="txt">回看频道</div>
		</div>
	</div>
	<!--menu the end-->		
	
	
	
	<!--list 频道-->
	<div class="btn" style="left:526px; top:80px;"><img src="../../images/arrow-up.png" alt="向上" /></div>
	<div class="list-e">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area2_list_0">
			<div class="num" id="area2_num_0"></div>
			<div class="txt" id="area2_txt_0"></div>
		</div>   
		<div class="item" style="top:46px;" id="area2_list_1">
			<div class="num" id="area2_num_1"></div>
			<div class="txt" id="area2_txt_1"></div>
		</div>
		<div class="item" style="top:92px;" id="area2_list_2">
			<div class="num" id="area2_num_2"></div>
			<div class="txt" id="area2_txt_2"></div>
		</div> 
		<div class="item" style="top:138px;" id="area2_list_3">
			<div class="num" id="area2_num_3"></div>
			<div class="txt" id="area2_txt_3"></div>
		</div>
		<div class="item" style="top:184px;" id="area2_list_4">
			<div class="num" id="area2_num_4"></div>
			<div class="txt" id="area2_txt_4"></div>
		</div>
		<div class="item" style="top:230px;" id="area2_list_5">
			<div class="num" id="area2_num_5"></div>
			<div class="txt" id="area2_txt_5"></div>
		</div>
		<div class="item" style="top:276px;" id="area2_list_6">
			<div class="num" id="area2_num_6"></div>
			<div class="txt" id="area2_txt_6"></div>
		</div>
		<div class="item" style="top:322px;" id="area2_list_7">
			<div class="num" id="area2_num_7"></div>
			<div class="txt" id="area2_txt_7"></div>
		</div>
		<div class="item" style="top:368px;" id="area2_list_8">
			<div class="num" id="area2_num_8"></div>
			<div class="txt" id="area2_txt_8"></div>
		</div>
		<div class="item" style="top:414px;" id="area2_list_9">
			<div class="num" id="area2_num_9"></div>
			<div class="txt" id="area2_txt_9"></div>
		</div>
	</div>
	<div class="btn" style="left:526px; top:608px;"><img src="../../images/arrow-down.png" alt="向下" /></div>
	<!--list 频道 the end-->
	
	
	
	<!--list 日期-->
	<div class="btn" style="left:750px; top:80px;"><img src="../../images/arrow-up.png" alt="向上" /></div>
	<div class="list-k">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area3_list_0">
			<div class="txt" id="area3_txt_0"></div>
		</div>   
		<div class="item" style="top:46px;" id="area3_list_1">
			<div class="txt" id="area3_txt_1"></div>
		</div>
		<div class="item" style="top:92px;" id="area3_list_2">
			<div class="txt" id="area3_txt_2"></div>
		</div> 
		<div class="item" style="top:138px;" id="area3_list_3">
			<div class="txt" id="area3_txt_3"></div>
		</div>
		<div class="item" style="top:184px;" id="area3_list_4">
			<div class="txt" id="area3_txt_4"></div>
		</div>
		<div class="item" style="top:230px;" id="area3_list_5">
			<div class="txt" id="area3_txt_5"></div>
		</div>
		<div class="item" style="top:276px;" id="area3_list_6">
			<div class="txt" id="area3_txt_6"></div>
		</div>
		<!--
		<div class="item" style="top:322px;">
			<div class="txt">5月26日</div>
		</div>
		<div class="item" style="top:368px;">
			<div class="txt">5月26日</div>
		</div>
		<div class="item" style="top:414px;">
			<div class="txt">5月26日</div>
		</div>-->
	</div>
	<div class="btn" style="left:750px; top:608px;"><img src="../../images/arrow-down.png" alt="向下" /></div>
	<!--list 日期 the end-->
	
	
	
	<!--list 节目-->
	<div class="btn" style="left:1002px; top:80px;"><img src="../../images/arrow-up.png" alt="向上" /></div>
	<div class="list-l">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area4_list_0">
			<div class="num" id="area4_num_0"></div>
			<div class="txt" id="area4_txt_0"></div>
		</div>   
		<div class="item" style="top:46px;" id="area4_list_1">
			<div class="num" id="area4_num_1"></div>
			<div class="txt" id="area4_txt_1"></div>
		</div>
		<div class="item" style="top:92px;" id="area4_list_2">
			<div class="num" id="area4_num_2"></div>
			<div class="txt" id="area4_txt_2"></div>
		</div> 
		<div class="item" style="top:138px;" id="area4_list_3">
			<div class="num" id="area4_num_3"></div>
			<div class="txt" id="area4_txt_3"></div>
		</div>
		<div class="item" style="top:184px;" id="area4_list_4">
			<div class="num" id="area4_num_4"></div>
			<div class="txt" id="area4_txt_4"></div>
		</div>
		<div class="item" style="top:230px;" id="area4_list_5">
			<div class="num" id="area4_num_5"></div>
			<div class="txt" id="area4_txt_5"></div>
		</div>
		<div class="item" style="top:276px;" id="area4_list_6">
			<div class="num" id="area4_num_6"></div>
			<div class="txt" id="area4_txt_6"></div>
		</div>
		<div class="item" style="top:322px;" id="area4_list_7">
			<div class="num" id="area4_num_7"></div>
			<div class="txt" id="area4_txt_7"></div>
		</div>
		<div class="item" style="top:368px;" id="area4_list_8">
			<div class="num" id="area4_num_8"></div>
			<div class="txt" id="area4_txt_8"></div>
		</div>
		<div class="item" style="top:414px;" id="area4_list_9">
			<div class="num" id="area4_num_9"></div>
			<div class="txt" id="area4_txt_9"></div>
		</div>
	</div>
	<div class="btn" style="left:1002px; top:608px;"><img src="../../images/arrow-down.png" alt="向下" /></div>
	<!--list 节目 the end-->
		
	
	
	<!--pages-->
	<div class="pages-side">
		<div class="txt txt-current" id="currentchannePage">2</div>
		<div class="txt" style="top:156px;" id="channelTotalPage">5</div>
	</div>
	<!--pages the end-->
	 <iframe id="getTVODProgramFrame"  style="width:0px;height:0px;border:0px;" ></iframe> 	
	
</div>
	
</body>
</html>
