<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="save_focus.jsp"%>
<%@ include file="datajsp/livedata.jsp"%>
<%
String path = request.getRequestURI().substring(0,request.getRequestURI().lastIndexOf("/")+1);   
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>直播-湖北广电标清EPG2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/indexstyle.css" />
</head>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
var area0,area1,area2;
var returnurl=unescape(window.location.href);
var cruntpage = <%=request.getParameter("curpage")==null?1:Integer.parseInt(request.getParameter("curpage"))%>;
var areaid = <%=request.getParameter("areaid")==null?0:Integer.parseInt(request.getParameter("areaid"))%>;
var indexid = <%=request.getParameter("indexid")==null?0:Integer.parseInt(request.getParameter("indexid"))%>;
var pageobj;
var backfocus=null;
var isTurnPageFlag=0;
var channelTypeData=[{TYPENAME:"全部",TYPEID:"00000100000000090000000000015842"},
                     {TYPENAME:"湖北",TYPEID:"00000100000000090000000000015840"},
					 {TYPENAME:"央视",TYPEID:"00000100000000090000000000015842"},
					 {TYPENAME:"卫视",TYPEID:"00000100000000090000000000015840"},
					 {TYPENAME:"专业",TYPEID:"00000100000000090000000000015842"},
					 {TYPENAME:"轮播",TYPEID:"00000100000000090000000000015840"},
					 {TYPENAME:"高清",TYPEID:"00000100000000090000000000015842"}]
window.onload = function()
{
	  if(returnurl.indexOf('back=1')==-1)
	  {
		  if(returnurl.indexOf('?')==-1)
			 returnurl+="?back=1";
		  else
			 returnurl+="&back=1";
	  }
	  
	   returnurl=escape(returnurl);

		area0 = AreaCreator(7,1,new Array(-1,-1,-1,1),"area0_list_", "afocus","ablur");
		area0.setfocuscircle(0);
		for(i=0;i<7;i++)
		{
		   area0.doms[i].contentdom=$("area0_text_"+i);
		}
		var backflag='<%=request.getParameter("back")%>';
		area0.changefocusingEvent = function()
		{
			$("divType_"+this.curindex).className="item";
		}
		
		area0.changefocusedEvent = function()
		{
			$("divType_"+this.curindex).className="item item_select";
			var timer;
			if(timer!=undefined)
			clearTimeout(timer);
			timer=setTimeout(getChnnelList,500);
		}
		
		area1 = AreaCreator(10,1,new Array(-1,0,-1,-1),"area1_list_", "afocus","ablur");
	    area1.pagecount = Math.ceil(contentTotalList/10);
		
		area1.changefocusingEvent = function()
		{
			$("divChannelList_"+this.curindex).className="item";
		}
		
		area1.changefocusedEvent = function()
		{
			$("divChannelList_"+this.curindex).className="item item_select";
			var playtimer;
			if(playtimer!=undefined)
			clearTimeout(playtimer);
			playtimer=setTimeout(setTimePlay,500);
			
			var timer;
			if(timer!=undefined)
			clearTimeout(timer);
			timer=setTimeout(getProgramList,500);
		}
		
		for(i=0;i<10;i++)
		{
		   area1.doms[i].contentdom=$("area1_text_"+i);
		   area1.doms[i].numdom=$("area1_num_"+i);
		}
		
		area2 = AreaCreator(10,1,new Array(-1,0,-1,-1),"area1_list_", "afocus","ablur");
	    //area2.pagecount = Math.ceil(contentTotalList/10);
		
			
	  pageobj=new PageObj(backfocus!=null?backfocus[0].areaid:areaid,backfocus!=null?backfocus[0].curindex:indexid,new Array(area0,area1,area2));
	  pageobj.pageOkEvent=function()
	  {
		var json=createAllFocstr(pageobj);
	  }
	  
	  pageobj.goBackEvent=function()
	  {
		 window.location.href="index.jsp?back=1";
	  }
	 bindTypesData(channelTypeData);
	 bindChannelList(jsonChannelList);
	 $("divChannelList_"+area1.curindex).className="item item_select";
	 setTimeout("load_iframe()",400);
	 getProgramList();
}

function getChnnelList()
{
	var typeid = channelTypeData[area0.curindex].TYPEID;
	$('hidden_frame').src = "<%=basePath%>datajsp/livedata.jsp?isFirstFlag=1&stratPosition="+(area1.curpage-1)*10+"&typeID="+typeid;
}

function getProgramList()
{
	$('hidden_frame').src ="<%=basePath%>datajsp/liveasyndata.jsp?channelid="+jsonChannelList[area1.curindex].CHANNELID;
}

function setTimePlay()
{
	if(playPage.mp!=null && playPage.mp!=undefined )
	{
		playPage.mp.joinChannel(jsonChannelList[area1.curindex].CHANNELINDEX);
		playPage.mp.setVideoDisplayArea(263,87,355,266); 
		playPage.mp.setVideoDisplayMode(0);
		playPage.mp.refreshVideoDisplay();
	}
}
function bindTypesData(datavalue)
{
	for(i=0;i<area0.doms.length;i++)
	{
	   if(i<datavalue.length)
	   {
		   area0.doms[i].setcontent("",datavalue[i].TYPENAME,4,true,true);
	   }
	   else
	   {
		   area0.doms[i].updatecontent("");
	   }
	}
}


function bindChannelList(datavalue)
{
	var start = (area1.curpage-1)*10;
	var size = (contentTotalList-start)>=10?10:(contentTotalList-start);
	area1.setpageturndata(size, area1.pagecount);
	for(i=0;i<area1.doms.length;i++)
	{
	   if(i<datavalue.length)
	   {
		   var tmpSeq = "" + (datavalue[i].CHANNELINDEX);
		   var tmpStr = "";
		   if (tmpSeq.length == 1)
		   {
				tmpStr = "00";
		   }
		   else if(tmpSeq.length == 2)
		   {
				tmpStr = "0";
		   }
		   area1.doms[i].numdom.innerHTML=tmpStr +(datavalue[i].CHANNELINDEX);
		   area1.doms[i].setcontent("",datavalue[i].CHANNELNAME,12);
		   area1.doms[i].mylink="play_ControlChannel.jsp?CHANNELNUM="datavalue[i].CHANNELINDEX+"&COMEFROMFLAG=1&returnurl="+escape(location.href);
		   if(datavalue[i].ISTVOD=="0")
		   {
			  area2.doms[i].mylink="#"; 
		   }
		   else
		   {
			  area2.doms[i].mylink="playback.jsp?channelId="+datavalue[i].CHANNELID+"&returnurl="+escape(returnurl);
		   }
	   }
	   else
	   {
		   area1.doms[i].updatecontent("");
		   area1.doms[i].numdom.innerHTML="";
		   area1.doms[i].mylink="#";
	   }
	}
}

function bindProgram(recChannelBill)
{
	for(var i =0 ;i<4; i++)
	{
		if(i<recChannelBill.length)
	   {
		   var time=recChannelBill[i].starttime.substring(0,5);
		   $("programTime_"+i).innerHTML = time;
		   $("programName_"+i).innerHTML = recChannelBill[i].proname;
		   
	   }
	   else
	   {
		   $("programTime_"+i).innerHTML = "";
		   $("programName_"+i).innerHTML = "暂无节目";
	   
	   
	   }
	}
}
function showArrowIcon()
{
	if(area0.pagecount<=1)
	{
		$("btn0").style.display = "none";
		$("btn1").style.display = "none";
	}
	else
	{
		$("btn0").style.display = "block";
		$("btn1").style.display = "block";
	}

}

function load_iframe()
{
    playPage.location.href = "PlayTrailerInVas.jsp?left=263&top=87&width=355&height=266&type=CHAN&value=41&mediacode=41&contenttype=1&liveid="+jsonChannelList[area1.curindex].CHANNELINDEX;
}
</script>
<body bgcolor="transparent">

<!--pagebg-->
<div class="pagebg">
	<div class="pic"><img src="../images/bg-live01.jpg" width="640" height="55" /></div>
	<div class="pic" style="top:55px;"><img src="../images/bg-live02.jpg" width="217" height="475" /></div>
	<div class="pic" style="top:55px; left:623px;"><img src="../images/bg-live03.jpg" width="17" height="295" /></div>
	<div class="pic" style="top:350px; left:217px;"><img src="../images/bg-live04.jpg" width="423" height="180" /></div>
</div>
<!--pagebg the end-->



<div class="wrapper">
	<!--head-->
	<div class="txt txt-title" style="top:5px;">直播</div>
	<div class="txt txtDate02">2013-12-03 10:31</div>
	<!--head the end-->
	
	
	<!--nav-->
	<div class="nav-b">
		<!--选中为
				 class="item item_select"
		-->
		<div class="item" id="divType_0">
			<div class="link"><a href="#" id="area0_list_0"><img src="../images/t.gif" /></a></div>
			<div class="txt">全部</div>
        </div>
		<div class="item" id="divType_1" style="top:42px;">
			<div class="link"><a href="#" id="area0_list_1"><img src="../images/t.gif" /></a></div>
			<div class="txt">湖北</div>
        </div>
		<div class="item" id="divType_2" style="top:84px;">
			<div class="link"><a href="#" id="area0_list_2"><img src="../images/t.gif" /></a></div>
			<div class="txt">央视</div>
        </div>
		<div class="item" id="divType_3" style="top:126px;">
			<div class="link"><a href="#" id="area0_list_3"><img src="../images/t.gif" /></a></div>
			<div class="txt">卫视</div>
        </div>
		<div class="item" id="divType_4" style="top:168px;">
			<div class="link"><a href="#" id="area0_list_4"><img src="../images/t.gif" /></a></div>
			<div class="txt">专业</div>
        </div>
		<div class="item" id="divType_5" style="top:210px;">
			<div class="link"><a href="#" id="area0_list_5"><img src="../images/t.gif" /></a></div>
			<div class="txt">轮播</div>
        </div>
		<div class="item" id="divType_6" style="top:252px;">
			<div class="link"><a href="#" id="area0_list_6"><img src="../images/t.gif" /></a></div>
			<div class="txt">高清</div>
        </div>
	</div>
	<!--nav the end-->
	
	
	<!--nav-->
	<div class="nav-d">
		<!--选中为
				 class="item item_select"
		-->
		<div class="item" id="divChannelList_0">
			<div class="icon"><a href="#" id="area2_list_0"><img src="../images/icon-back.png" /></a></div>
			<div class="link"><a href="#" id="area1_list_0"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_0">001</div>
			<div class="txt" id="area1_text_0">CCTV-1</div>
        </div>
		<div class="item" id="divChannelList_1" style="top:42px;">
			<div class="icon"><a href="#" id="area2_list_1"><img src="../images/icon-back.png" /></a></div>
			<div class="link"><a href="#" id="area1_list_1"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_1">002</div>
			<div class="txt" id="area1_text_1">CCTV-2</div>
        </div>
		<div class="item" id="divChannelList_2" style="top:84px;">
			<div class="icon"><a href="#" id="area2_list_2"><img src="../images/icon-back.png" /></a></div>
			<div class="link"><a href="#" id="area1_list_2"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_2">003</div>
			<div class="txt" id="area1_text_2">CCTV-3</div>
        </div>
		<div class="item" id="divChannelList_3" style="top:126px;">
			<div class="icon"><a href="#" id="area2_list_3"><img src="../images/icon-back.png" /></a></div>
			<div class="link"><a href="#" id="area1_list_3"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_3">004</div>
			<div class="txt" id="area1_text_3">CCTV-4</div>
        </div>
		<div class="item" id="divChannelList_4" style="top:168px;">
			<div class="icon"><a href="#" id="area2_list_4"><img src="../images/icon-back_gray.png" /></a></div>
			<div class="link"><a href="#" id="area1_list_4"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_4">005</div>
			<div class="txt" id="area1_text_4">CCTV-5</div>
        </div>
		<div class="item" id="divChannelList_5" style="top:210px;">
			<div class="icon"><a href="#" id="area2_list_5"><img src="../images/icon-back.png" /></a></div>
			<div class="link"><a href="#" id="area1_list_5"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_5">006</div>
			<div class="txt" id="area1_text_5">CCTV-新闻</div>
        </div>
		<div class="item" id="divChannelList_6" style="top:251px;">
			<div class="icon"><a href="#" id="area2_list_6"><img src="../images/icon-back.png" /></a></div>
			<div class="link"><a href="#" id="area1_list_6"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_6">007</div>
			<div class="txt" id="area1_text_6">CCTV-艺术</div>
        </div>
		<div class="item" id="divChannelList_7" style="top:292px;">
			<div class="icon"><a href="#" id="area2_list_7"><img src="../images/icon-back.png" /></a></div>
			<div class="link"><a href="#" id="area1_list_7"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_7">008</div>
			<div class="txt" id="area1_text_7">CCTV-新闻</div>
        </div>
		<div class="item" id="divChannelList_8" style="top:333px;">
			<div class="icon"><a href="#" id="area2_list_8"><img src="../images/icon-back.png" /></a></div>
			<div class="link"><a href="#" id="area1_list_8"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_8">009</div>
			<div class="txt" id="area1_text_8">CCTV-综艺</div>
        </div>
		<div class="item" id="divChannelList_9" style="top:372px;">
			<div class="icon"><a href="#" id="area2_list_9"><img src="../images/icon-back.png" /></a></div>
			<div class="link"><a href="#" id="area1_list_9"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_9">010</div>
			<div class="txt" id="area1_text_9">CCTV-NEW</div>
        </div>
	</div>
	
	<div class="pages" style="left:90px; top:484px; text-align:center;">1/25</div>
	<!--nav the end-->
		
	
	<!-- video-->
    <div class="video-live">
		<!--<div class="link"><a href="#"><img src="../images/t.gif" /></a></div>-->
		<!--<div class="pic"><img src="../images/demopic/video-406X295.jpg" /></div>
		<div class="btn"><img src="../images/btn-play02.png" alt="播放" /></div>-->
        <iframe id="playPage" name="playPage" frameborder="0" height="1px" width="1px"></iframe>
    </div>
    <!-- video the end -->
	
	
	<!-- list r-->
    <div class="list-f">
		<div class="title">正在播放</div>
		<div class="item">
			<div class="time" id="programTime_0"></div>
			<div class="txt" id="programName_0"></div>
        </div>
    </div>
	<div class="list-f" style="top:394px;">
		<div class="title">即将播放</div>
		<div class="item item_gray">
			<div class="time" id="programTime_1"></div>
			<div class="txt" id="programName_1"></div>
        </div>
		<div class="item item_gray" style="top:28px;">
			<div class="time" id="programTime_2"></div>
			<div class="txt" id="programName_2"></div>
        </div>
		<div class="item item_gray" style="top:56px;">
			<div class="time" id="programTime_3"></div>
			<div class="txt" id="programName_3"></div>
        </div>
    </div>
	<!-- list r the end -->
	
	
<iframe name="hidden_frame" id="hidden_frame" style="display:none" width="0" height="0" ></iframe>	
</div>	
</body>
</html>
