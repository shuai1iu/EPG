<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<%
	String channelListFile="../../../" + datajspname  + "/channelList.jsp";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>频道直播- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<style>
/* =S Css Reset
----------------------------------------------- */
body, div, h1, h2, h3, h4, h5, h6, button, input, textarea, th, td { margin: 0; padding: 0; }
body, div, button, input, select, textarea { font-size: 22px; font-family: SimHei,sans-serif; line-height: 100%; }
h1, h2, h3, h4, h5, h6 { font-size: 100%; }
a { text-decoration: none; }
fieldset, img { border: 0; }
button, input, select, textarea { font-size:100%; }

/* =S Global
----------------------------------------------- */
.item, .link, .txt-wrap, .txt, .btn, .icon, .pic, .cover, .num, .win { 
	left: 0;
	position:absolute;
	top: 0;
}
.link { z-index: 9;}
.txt { z-index: 7;}
.txt-wrap { z-index: 6;}
.icon { z-index: 5;}
.cover { z-index: 4;}
.pic { z-index: 3;}
.btn { z-index:8;}

body, .wrapper {
    height: 720px;
    width: 1280px;
    background: transparent;
    /*overflow: hidden;*/
    position: relative;
}
body {
   /* background-color: #000;*/
    color: #f0f0f0;
}
.wrapper,.pagebg {
	left: 0;
	position: absolute;
	top: 0;
}
.wrapper {
	z-index: 2;
}
.pagebg {
	z-index: 1;
}
.logo {
	left: 74px;
	position: absolute; 
	top: 16px; 
}
.date {
	left: 1137px;
	position: absolute;
	top: 20px;
}
.date .txt {
	color:#c1c0c5;
	text-align:right;
	height:22px;
	width:100px;
}
.date .txt-time {
	color:#e2e1e1;
	font-size:26px;
}

/* index ----------------------------------------------- */
.btn-menu {
	left:0;
	position:absolute; 
	top:192px; 
}
.title {
	left:0;
	position:absolute; 
	top:99px;
	z-index:5;
}
.menu-a {
	background:url(../../images/menu-bg01.png) no-repeat;
	left:0;
	position:absolute; 
	top:120px; 
	height:600px;
	width:251px;
	z-index:10;
}
.menu-a .item {
	height:60px;
	width:220px;
	top:57px;
}
.menu-a .item .icon,
.menu-a .item .icon img {
	height:50px;
	width:60px;
}
.menu-a .item .icon {
	left:23px;
	top:4px;
}
.menu-a .item .txt {
	font-size:26px;
	line-height:60px;
	left:105px;
	width:100px;
}
.menu-a .item_focus {
	background:url(../../images/menu-bg_focus.png) no-repeat;
}
.menu-a .item_focus .txt {
	color:#ffde00;
	font-size:28px;
}
.menu-a .item_select {
	background:url(../../images/menu-bg_select.png) no-repeat;
}
.menu-a .item_select .txt {
	color:#efa423;
}
.menu-b {
	background:url(../../images/menu-bg02.png) no-repeat;
	left:215px;
	position:absolute; 
	top:120px; 
	height:600px;
	width:210px;
	z-index:9;
}
.menu-b .item {
	height:55px;
	width:190px;
	top:57px;
}
.menu-b .item .txt {
	font-size:26px;
	line-height:55px;
	text-align:center;
	width:190px;
}
.menu-b .item_focus {
	background:url(../../images/menu-bg02_focus.png) no-repeat;
}
.menu-b .item_focus .txt {
	color:#ffde00;
	font-size:28px;
}
.menu-b .item_select {
	background:url(../../images/menu-bg02_select.png) no-repeat;
}
.menu-b .item_select .txt {
	color:#efa423;
}


/*list----------------------------------------------------*/
.list-e {
	left:427px;
	position:absolute;
	top:126px;
}
.list-e .item {
	height:58px;
	width:237px;
}
.list-e .item .num,
.list-e .item .txt {
	font-size:26px;
	line-height:49px;
	height:49px;
}
.list-e .item .num {
	color:#9a9996;
	left:22px;
	position:absolute;
	top:0;
	width:70px;
}
.list-e .item .txt {
	left:92px;
	width:140px;
}
.list-e .item_focus {
	background:url(../../images/list01_focus.png) no-repeat;
}
.list-f {
	left:737px;
	position:absolute;
	top:520px;
}
.list-f .item {
	height:38px;
}
.list-f .item .txt {
	font-size:26px;
	line-height:38px;
	height:38px;
}
.list-f .item .txt01 {
	width:100px;
}
.list-f .item .txt02 {
	left:100px;
	width:295px;
}
.list-a .item_focus,
.list-b .item_focus,
.list-c .item_focus,
.list-d .item_focus,
.list-f .item_focus .txt {
	color:#ffde00;
}

/*video----------------------------------------------------*/
.video {
	left: 315px;
	position: absolute;
	top: 74px;
}
.video .item {
	height:360px;
	width:623px;
}
.video .item .pic {
	left:10px;
	top:10px;
	height:340px;
	width:603px;
}
.video .item_focus {
	background:url(../../images/video_focus.png) no-repeat;
}
.video .item .btn {
	left:265px;
	top:134px;
}
.video-channel {
	left: 719px;
	position: absolute;
	top: 116px;
}
.video-channel .item {
	height:320px;
	width:420px;
}
.video-channel .item .pic {
	left:10px;
	top:10px;
	height:300px;
	width:400px;
}
.video-channel .txt {
	font-size:26px;
	font-weight:bold;
	left:10px;
	top:312px;
	text-align:center;
	line-height:60px;
	height:60px;
	width:400px;
}
.video-channel .item_focus {
	background:url(../../images/video02_focus.png) no-repeat;
}

/*marquee----------------------------------------------------*/
.bottom-marquee {
	color:#fff;
	left: 80px;
	position:absolute;
	top: 673px;
	height:24px;
	width:1160px;
}
.marquee {
	background:url(../../images/marquee-bg.png) no-repeat;
	left: 263px;
	position:absolute;
	top: 649px;
	height:42px;
	width:942px;
}
.marquee .txt,
.marquee02 .txt {
	line-height:42px;
	height:42px;
}
.marquee .txt01,
.marquee02 .txt01 {
	color:#b3b399;
	left:60px;
	width:110px;
}
.marquee .txt02 {
	color:#a2a29f;
	left:190px;
	width:735px;
}
.marquee02 {
	background:url(../../images/marquee-bg02.png) no-repeat;
	left: 113px;
	position:absolute;
	top: 639px;
	height:42px;
	width:1052px;
}
.marquee02 .txt02 {
	color:#a2a29f;
	left:190px;
	width:850px;
}
.pages-side {
	background:url(../../images/side-page-bg.png) no-repeat;
	left: 1206px;
	position: absolute;
	top: 111px;
	height:570px;
	width:42px;
}
.pages-side .txt {
	color:#bfbfbf;
	font-size:24px;
	left:7px;
	top:118px;
	text-align:center;
	line-height:38px;
	height:38px;
	width:30px;
}
.pages-side .txt-current {
	color:#e5e5e5;
	font-weight:bold;
}
</style>
<style type="text/css">
<!--
	/*body{ background:url(../../images/) no-repeat;}*/
-->
</style>
<%@ include file="../../../util/servertime.jsp"%>
<%@ include file="../../../util/channelDateUtil.jsp"%>
<%@ include file="../../../config/code.jsp"%>
<%@ include file="../../base.jsp"%>
<script type="text/javascript">
         //将频道列表全部取出来
		<jsp:include page="<%=channelListFile%>">
				<jsp:param name="categoryCode" value="<%=channelListCode%>"/> 
				<jsp:param name="varName" value="channelList"/>
				<jsp:param name="fields" value="-1" /> 
				<jsp:param name="pageIndex" value="1" /> 
				<jsp:param name="pageSize" value="-1" />
				<jsp:param name="isBug" value="1" />
		</jsp:include>		
		
		//area2改变焦点获取播放地址和获取节目单        
		function callProgrameList(data)
		{
			 var channelID=getChannelListValue(area2.curpage)[area2.curindex].channelID;//第一页第一个频道
		     var channelIndex=getChannelListValue(area2.curpage)[area2.curindex].channelIndex;//第一页第一个频道
			 mp.leaveChannel();
	         mp.joinChannel(parseInt(channelIndex));
	         mp.setVideoDisplayArea(719,116,420,320); 
	         mp.setVideoDisplayMode(0);
	         mp.refreshVideoDisplay();
		     var programeDataList=data;
		     $("channelTime").innerHTML=programeDataList[1].startTime.substr(0,5);
	         $("programeName").innerHTML=programeDataList[1].tvodProgramName;
		     $("channelTime1").innerHTML=programeDataList[2].startTime.substr(0,5);
	         $("programeName1").innerHTML=programeDataList[2].tvodProgramName;
			 $("txtCurrentProdName").innerHTML="正在播出: "+programeDataList[0].tvodProgramName;
	   }
			
</script>
<script type="application/javascript" src="../../js/MediaPlayer.js"></script>
<script type="text/javascript">
var area0,area1,area2;
var pageobj;
var areaid = 2;
var indexid = 0;
var area2curpage=1;

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
			area2curpage=focusObj.focusdatas[0].curpage;
		}
	 }
     area0=AreaCreator(9, 1, new Array( - 1, -1, -1,  1), "area0_list_", "className:item item_focus", "className:item");
	// area0.setdarknessfocus(1);
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
     area1.stablemoveindex=new Array(-1,"0-1,1-1",2,-1);
     area1.setdarknessfocus(0);

     area1.changefocusedEvent=function()
     {
		 if(area1.curindex==0)
		 {
			 //初始化绑定频道列表
			 binChannelListData(getChannelListValue(1),1);
			 area2.curpage=1;  
		 }
		 if(area1.curindex==1)
		 {
			 window.location.href="channel-playback.jsp";
		 }
       
    };

     area2=AreaCreator(10, 1, new Array( - 1, 1, -1, -1), "area2_list_", "className:item item_focus", "className:item");
	 for(i=0;i<area2.doms.length;i++)
	 {
		 area2.doms[i].contentdom = $("area2_txt_"+i);		
	 }
	 
	 area2.curpage=area2curpage;
	 area2.pagecount =Math.ceil((channelList.channelDataList.length/10));	
	 area2.endwiseCrossturnpage = true;  
     area2.areaPageTurnEvent = function(num)
	 {	 
	    if(area1.curindex==0)
	    {  //绑定频道列表
	       binChannelListData(getChannelListValue(area2.curpage),area2.curpage);
		   initPageSize();
	    }	
	 };
	
	 area2.changefocusedEvent=function()
	 {
		 var programFrame=$("getChannelProgramFrame");
	     var index= area2.curpage;
	    if(area1.curindex==0)
	    {   //根据频道ID和当前日期获取节目单
			var channelID=getChannelListValue(index)[area2.curindex].channelID;
		    programFrame.src="../iframe/getChannelProgramFrame.jsp?channelID="+channelID+"&curdate="+"<%=strDate%>";    
			                
	    }	
	 }
	 var mp = new MediaPlayer();
	 area2.areaOkEvent=function()
	 {
		 var cpage=area2.curpage;
		 var index=area2.curindex;
		 if(area1.curindex==0)
		 {
			//根据频道ID获取播放地址
			//var channelID=getChannelListValue(index)[area2.curindex].channelID;	
			//window.location.href="../vodPlayer/vodChannelPlayer.jsp?channelID="+channelID+"&returnUrl="+escape(location.href);	
		      var channelIndex=getChannelListValue(cpage)[index].channelIndex;
			  var channelName=getChannelListValue(cpage)[index].channelName;
			  var channelID=getChannelListValue(cpage)[index].channelID; 
		      window.location.href ="channelPlayer.jsp?channelIndex="+channelIndex+"&channelID="+channelID+"&returnUrl="+escape(location.href);
			  //这里直接传入全屏播放：
		 }
	 }
	 

     pageobj = new PageObj(areaid, indexid, new Array(area0,area1,area2));
	 pageobj.backurl = OperatorFocus.getLastReturn();
     pageInit();
	 pageobj.pageOkEvent=function()
	 {
		OperatorFocus.saveFocstr(pageobj);
	 };
};
	function pageInit()
	{    
	     //初始化绑定频道列表
		 binChannelListData(getChannelListValue(area2curpage),area2curpage);
		 //初始化时间
		 initTime();
		 //初始化播放小窗口
	     init_play();
		 //初始化当前页/总页数
		 initPageSize();
	
	}
	
	//对频道列表进行分页处理
	function getChannelListValue(currentPage)
	{
		var length=channelList.channelDataList.length;
		var start = (currentPage-1)*10;
		var end = (start+10);
		if(end>=length)
		{
			end=length;  
		}
		var temptestList=new Array();
		for(var i=start;i<end;i++)
		{
			temptestList.push(channelList.channelDataList[i]);
		}
		return temptestList;
	}
	   
	//绑定频道列表
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
	
	
	function init_play()
	{
	    //为了播放暂时没传 channelIndex : "1201"
		 var channelID=getChannelListValue(area2.curpage)[area2.curindex].channelID;//第一页第一个频道
		 var channelIndex=getChannelListValue(area2.curpage)[area2.curindex].channelIndex;//第一页第一个频道
		//playUrl = "rtsp://220.181.168.185:5541/mp4/2013henanfenghui/zhibo/cctv1.ts";
		userchannelid=channelIndex;
		play(719,116,420,320);
	}
	function destoryMP(){
		var instanceId = mp.getNativePlayerInstanceID();
	//	mp.stop();
	    mp.leaveChannel()
		mp.releaseMediaPlayer(instanceId);
	}
	
	
</script>
</head>
<body bgcolor="transparent" onUnload="destoryMP()">

<!--pagebg-->
<div class="pagebg">
	<div class="pic"><img src="../../images/bg-c01.jpg" width="729" height="720" /></div>
	<div class="pic" style="left:729px;"><img src="../../images/bg-c02.jpg" width="551" height="126" /></div>
	<div class="pic" style="left:729px;top:126px;"><img src="../../images/bg-c03.png" width="400" height="300" /></div>
	<div class="pic" style="left:1129px;top:126px;"><img src="../../images/bg-c04.jpg" width="151" height="300" /></div>
	<div class="pic" style="left:729px;top:426px;"><img src="../../images/bg-c05.jpg" width="551" height="294" /></div>
</div>
<!--pagebg the end-->



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
		<div class="item"  style="top:260px;" id="area1_list_0">
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
			<div class="num" id="area2_num_0">012</div>
			<div class="txt" id="area2_txt_0"></div>
		</div>   
		<div class="item" style="top:46px;" id="area2_list_1">
			<div class="num" id="area2_num_1">013</div>
			<div class="txt" id="area2_txt_1"></div>
		</div>
		<div class="item" style="top:92px;" id="area2_list_2">
			<div class="num" id="area2_num_2">014</div>
			<div class="txt" id="area2_txt_2"></div>
		</div> 
		<div class="item" style="top:138px;" id="area2_list_3">
			<div class="num" id="area2_num_3">015</div>
			<div class="txt" id="area2_txt_3"></div>
		</div>
		<div class="item" style="top:184px;" id="area2_list_4">
			<div class="num" id="area2_num_4">016</div>
			<div class="txt" id="area2_txt_4"></div>
		</div>
		<div class="item" style="top:230px;" id="area2_list_5">
			<div class="num" id="area2_num_5">017</div>
			<div class="txt" id="area2_txt_5"></div>
		</div>
		<div class="item" style="top:276px;" id="area2_list_6">
			<div class="num" id="area2_num_6">018</div>
			<div class="txt" id="area2_txt_6"></div>
		</div>
		<div class="item" style="top:322px;" id="area2_list_7">
			<div class="num" id="area2_num_7">019</div>
			<div class="txt" id="area2_txt_7"></div>
		</div>
		<div class="item" style="top:368px;" id="area2_list_8">
			<div class="num" id="area2_num_8">020</div>
			<div class="txt" id="area2_txt_8"></div>
		</div>
		<div class="item" style="top:414px;" id="area2_list_9">
			<div class="num" id="area2_num_9">021</div>
			<div class="txt" id="area2_txt_9"></div>
		</div>
	</div>
	<div class="btn" style="left:526px; top:608px;"><img src="../../images/arrow-down.png" alt="向下" /></div>
	<!--list 频道 the end-->
		
	
	
	<!--video-->
	<div class="video-channel">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item">
			<div class="pic"></div>
		</div>
		<div class="txt" id="txtCurrentProdName"></div>
	</div>
	<!--video the end-->
	
	
	
	<!--list 节目单-->
	<div class="list-f">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item">
			<div class="txt txt01" id="channelTime"></div>
			<div class="txt txt02" id="programeName"></div>
		</div>   
		<div class="item" style="top:38px;">
			<div class="txt txt01" id="channelTime1"></div>
			<div class="txt txt02" id="programeName1"></div>
		</div>
	</div>
	<!--list the end-->	
	
	<!--pages-->
	<div class="pages-side">
		<div class="txt txt-current" id="currentchannePage">1</div>
		<div class="txt" style="top:156px;" id="channelTotalPage">5</div>
	</div>
	<!--pages the end-->
		
	  <iframe id="getChannelProgramFrame"  style="width:0px;height:0px;border:0px;" ></iframe> 
      <iframe id="getChannelPlayUrlFrame"  style="width:0px;height:0px;border:0px;" ></iframe> 
      
   
</div>
	
</body>
</html>
