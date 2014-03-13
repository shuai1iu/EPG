<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>


<%@ include file="save_focus.jsp"%>
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
var returnurl ="<%=request.getParameter("returnurl")==null?"":request.getParameter("returnurl")%>";
if(returnurl=="")
{
  returnurl=unescape(window.location.href);
}
var areaid = <%=request.getParameter("areaid")==null?0:Integer.parseInt(request.getParameter("areaid"))%>;
var indexid = <%=request.getParameter("indexid")==null?0:Integer.parseInt(request.getParameter("indexid"))%>;
var pageobj;
var backfocus=null;
var temppageTurnDataList=new Array();
var tempchnnalList=new Array();
var channelTypeData=[{TYPENAME:"全部",TYPEID:"00000100000000090000000000015842"},
                     {TYPENAME:"湖北",TYPEID:"10000100000000090000000000039770"},
					 {TYPENAME:"央视",TYPEID:"00000100000000090000000000015842"},
					 {TYPENAME:"卫视",TYPEID:""},
					 {TYPENAME:"专业",TYPEID:""},
					 {TYPENAME:"轮播",TYPEID:"10000100000000090000000000007697"},
					 {TYPENAME:"高清",TYPEID:""}]
window.onload = function()
{
	  if(returnurl.indexOf('back=1')==-1)
	  {
		  if(returnurl.indexOf('?')==-1)
			 returnurl+="?back=1";
		  else
			 returnurl+="&back=1";
	  }
	  
	   //returnurl=escape(returnurl);

		area0 = AreaCreator(7,1,new Array(-1,-1,-1,1),"area0_list_", "afocus","ablur");
		area0.setfocuscircle(0);
		for(var i=0;i<7;i++)
		{
		   area0.doms[i].contentdom=$("area0_text_"+i);
		}
		area0.changefocusingEvent = function()
		{
			$("divType_"+this.curindex).className="item";
		}
		area0.changefocusedEvent = function()
		{
			area1.curpage=1;
			$("divChannelList_"+area1.curindex).className="item";
	        area1.curindex=0;
	        $("divChannelList_"+area1.curindex).className="item item_select";
			if(tempAreaIndex!=undefined)
			{
				$("divType_"+tempAreaIndex).className="item";
			}
			$("divType_"+this.curindex).className="item item_select";
			var timer;
			if(timer!=undefined)
			clearTimeout(timer);
			timer=setTimeout(getChnnelList,700);
		}
		
		area1 = AreaCreator(10,1,new Array(-1,2,-1,-1),"area1_list_", "afocus","ablur");
		area1.stablemoveindex=new Array(-1,"0-2>0,1-2>1,2-2>2,3-2>3,4-2>4,5-2>5,6-2>6,7-2>7,8-2>8,9-2>9",-1,-1);
		for(var i=0;i<10;i++)
		{
		   area1.doms[i].contentdom=$("area1_text_"+i);
		   area1.doms[i].numdom=$("area1_num_"+i);
		}
		area1.setcrossturnpage();
		area1.asyngetdata=function()
		{
			turnPageShowChnnnelList(tempchnnalList);
		}
		
		area1.changefocusingEvent = function()
		{
			$("divChannelList_"+this.curindex).className="item";
		}
		
		area1.changefocusedEvent = function()
		{
			
			$("divChannelList_"+this.curindex).className="item item_select";
			  var timer;
			  if(timer!=undefined)
			  clearTimeout(timer);
			  timer=setTimeout(getProgramList,500);
			
			  var playtimer;
			  if(playtimer!=undefined)
			  clearTimeout(playtimer);
			  playtimer=setTimeout(setTimePlay,500);
		}
		area2 = AreaCreator(10,1,new Array(-1,0,-1,1),"area2_list_", "afocus","ablur");
		area2.stablemoveindex=new Array(-1,-1,-1,"0-1>0,1-1>1,2-1>2,3-1>3,4-1>4,5-1>5,6-1>6,7-1>7,8-1>8,9-1>9");
		for(var i=0;i<10;i++)
		{
		   area2.doms[i].imgdom=$("area2_icon_"+i);
		}
	    //area2.pagecount = Math.ceil(contentTotalList/10);	
		 //setTimeout("load_iframe()",400);
		 
	  var backflag='<%=request.getParameter("back")%>';
	  var tempAreaIndex;
	  if("1"==backflag||"-1"==backflag)
	  {
		  backfocus=getCurFocus("liveIndex");
		  if(backfocus[0].areaid==1)
		  {
			  area1.curindex=backfocus[0].curindex;
			  area1.curpage=backfocus[0].curpage;
			  area0.curindex=backfocus[1].curindex;
			  area2.curindex=backfocus[2].curindex;
			  $("divType_"+area0.curindex).className="item item_select";
			  $("divChannelList_"+area1.curindex).className="item item_select";
			  tempAreaIndex = area0.curindex;
		  }
		  else if(backfocus[0].areaid==2)
		  {
			  area1.curindex=backfocus[2].curindex;
			  area1.curpage=backfocus[2].curpage;
			  area0.curindex=backfocus[1].curindex;
			  area2.curindex=backfocus[0].curindex;
			  $("divType_"+area0.curindex).className="item item_select";
			  $("divChannelList_"+area1.curindex).className="item item_select";
			  tempAreaIndex = area0.curindex;
		  }
	  }
	  
	  bindTypesData(channelTypeData);
	  getChnnelList();
	  pageobj=new PageObj(backfocus!=null?backfocus[0].areaid:areaid,backfocus!=null?backfocus[0].curindex:indexid,new Array(area0,area1,area2));
	  pageobj.pageOkEvent=function()
	  {
		var json=createAllFocstr(pageobj);
		saveCookie("liveIndex",json!=undefined?json:"");
	  }
	  
	  pageobj.goBackEvent=function()
	  {
		 window.location.href="index.jsp?back=1";
	  }
}

function getChnnelList()
{
	var typeid = channelTypeData[area0.curindex].TYPEID;
	$('hidden_frame').src = "<%=basePath%>datajsp/livedata.jsp?typeID="+typeid;
}

function getProgramList()
{
	if(temppageTurnDataList.length!=0)
	{
	   $('hidden_frame').src ="<%=basePath%>datajsp/channelProgram.jsp?channelid="+temppageTurnDataList[area1.curindex].CHANNELID;
	}
	else
	{
		
		bindProgram(temppageTurnDataList);
	}
}

function setTimePlay()
{
	if(playPage.mp!=null && playPage.mp!=undefined&&temppageTurnDataList.length!=0)
	{
		playPage.mp.joinChannel(temppageTurnDataList[area1.curindex].CHANNELINDEX);
		playPage.mp.setVideoDisplayArea(217,55,406,295); 
		playPage.mp.setVideoDisplayMode(0);
		playPage.mp.refreshVideoDisplay();
	}
	else
	{
		playPage.mp.setVideoDisplayArea(217,55,406,295); 
		playPage.mp.setVideoDisplayMode(0);
		playPage.mp.refreshVideoDisplay();
		playPage.mp.leaveChannel();
	    playPage.mp.stop();
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


function turnPageShowChnnnelList(jsonChannelList)
{
	area1.pagecount = Math.ceil(jsonChannelList.length/10);
	var pageTurnDataList=new Array();
	 var start = (area1.curpage-1)*10;
	 var size = (jsonChannelList.length-start)>=10?10:(jsonChannelList.length-start);
	  for(i=0;i<size;i++)
	 {
		pageTurnDataList[i]=jsonChannelList[start+i];
	 }
	 temppageTurnDataList = pageTurnDataList;
	 bindChannelList(temppageTurnDataList);

}

function bindChannelList(datavalue)
{
	area1.setpageturndata(datavalue.length, area1.pagecount);
	for(var i=0;i<area1.doms.length;i++)
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
		   area1.doms[i].setcontent("",datavalue[i].CHANNELNAME,8);
		   area1.doms[i].mylink="play_ControlChannel.jsp?CHANNELNUM="+(datavalue[i].CHANNELINDEX)+"&COMEFROMFLAG=1&returnurl="+escape("live1.jsp?back=1");
		   if(datavalue[i].ISTVOD=="0")
		   {
			  area2.doms[i].mylink="javascript:#";
			  area2.doms[i].updateimg("../images/icon-back_gray.png"); 
		   }
		   else
		   {
			  area2.doms[i].updateimg("../images/icon-back.png");
			  area2.doms[i].mylink="playback.jsp?channelId="+datavalue[i].CHANNELID+"&area0curindex="+area0.curindex+"&area1curindex="+i+"&area1cruntpage="+area1.curpage+"&areaid=1&indexid="+i;
		   }
	   }
	   else
	   {
		   area1.doms[i].updatecontent("");
		   area1.doms[i].numdom.innerHTML="";
		   area1.doms[i].mylink="javascript:#";
		   area2.doms[i].mylink="javascript:#";
		   area2.doms[i].updateimg("../images/t.gif");
	   }
	}
	
	showArrowIcon();
	showPageNum();
	
	/*var playtimer;
	if(playtimer!=undefined)
	clearTimeout(playtimer);
	playtimer=setTimeout(setTimePlay,500);*/
	//setTimeout("load_iframe()",400);
			  
	var timer;
	if(timer!=undefined)
	clearTimeout(timer);
	timer=setTimeout(getProgramList,500);
}

function bindProgram(recChannelBill)
{
	for(var i =0;i<4;i++)
	{
		if(i<recChannelBill.length)
	   {
		   var time=recChannelBill[i].starttime.substring(0,5);
		   $("programTime_"+i).innerHTML = time;
		   
		   if(getbytelength(recChannelBill[i].proname)<14)
		   {
		       $("programName_"+i).innerHTML=recChannelBill[i].proname;
		   }
		   else
		   {
			   $("programName_"+i).innerHTML="<marquee scrollamount='2'>"+recChannelBill[i].proname+"</marquee>";
		   }
		   
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
	if(area1.pagecount<=1)
	{
		$("upArrow").style.display="none";
		$("downArrow").style.display="none";
		
	}
	else
	{
		if(area1.curpage==1)
		{
			$("upArrow").style.display="none";
		    $("downArrow").style.display="block";
		
		}
		else if(area1.curpage==area1.pagecount)
		{
			$("upArrow").style.display="block";
		    $("downArrow").style.display="none";
		}
		else
		{
			$("upArrow").style.display="block";
		    $("downArrow").style.display="block";
		}
	}

}


function showPageNum()
{
	if(area1.pagecount>0)
	{
	   $("pageNum").style.display="block";
	   $("pageNum").innerHTML=area1.curpage+"/"+area1.pagecount;
	}
	else
	{
		$("pageNum").style.display="none";
	}
}
function load_iframe()
{
	if(temppageTurnDataList.length!=0)
	{
       playPage.location.href = "PlayTrailerInVas.jsp?left=217&top=55&width=406&height=295&type=CHAN&value=41&mediacode=41&contenttype=1&liveid="+(temppageTurnDataList[area1.curindex].CHANNELINDEX);
	}
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
	<div class="txt txtDate02" id="currDate"></div>
	<!--head the end-->
	
	
	<!--nav-->
	<div class="nav-b">
		<!--选中为
				 class="item item_select"
		-->
		<div class="item" id="divType_0">
			<div class="link"><a href="#" id="area0_list_0"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_text_0"></div>
        </div>
		<div class="item" id="divType_1" style="top:42px;">
			<div class="link"><a href="#" id="area0_list_1"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_text_1"></div>
        </div>
		<div class="item" id="divType_2" style="top:84px;">
			<div class="link"><a href="#" id="area0_list_2"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_text_2"></div>
        </div>
		<div class="item" id="divType_3" style="top:126px;">
			<div class="link"><a href="#" id="area0_list_3"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_text_3"></div>
        </div>
		<div class="item" id="divType_4" style="top:168px;">
			<div class="link"><a href="#" id="area0_list_4"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_text_4"></div>
        </div>
		<div class="item" id="divType_5" style="top:210px;">
			<div class="link"><a href="#" id="area0_list_5"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_text_5"></div>
        </div>
		<div class="item" id="divType_6" style="top:252px;">
			<div class="link"><a href="#" id="area0_list_6"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_text_6"></div>
        </div>
	</div>
	<!--nav the end-->
	
	
	<!--nav-->
	<div class="nav-d">
		<!--选中为
				 class="item item_select"
		-->
        <div class="btn" id="upArrow" style="left:73px; top:-16px;"><img src="../images/arrow-up02.png" /></div>
		<div class="item" id="divChannelList_0">
<div class="icon"><a href="#" id="area2_list_0"><img id="area2_icon_0" src="../images/icon-back.png" /></a></div>
			<div class="link"><a href="#" id="area1_list_0"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_0"></div>
			<div class="txt" id="area1_text_0"></div>
        </div>
		<div class="item" id="divChannelList_1" style="top:42px;">
			<div class="icon"><a href="#" id="area2_list_1"><img id="area2_icon_1" src="../images/icon-back.png" /></a></div>
			<div class="link"><a href="#" id="area1_list_1"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_1"></div>
			<div class="txt" id="area1_text_1"></div>
        </div>
		<div class="item" id="divChannelList_2" style="top:84px;">
			<div class="icon"><a href="#" id="area2_list_2"><img id="area2_icon_2" src="../images/icon-back.png" /></a></div>
			<div class="link"><a href="#" id="area1_list_2"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_2"></div>
			<div class="txt" id="area1_text_2"></div>
        </div>
		<div class="item" id="divChannelList_3" style="top:126px;">
			<div class="icon"><a href="#" id="area2_list_3"><img id="area2_icon_3" src="../images/icon-back.png" /></a></div>
			<div class="link"><a href="#" id="area1_list_3"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_3"></div>
			<div class="txt" id="area1_text_3"></div>
        </div>
		<div class="item" id="divChannelList_4" style="top:168px;">
			<div class="icon"><a href="#" id="area2_list_4"><img id="area2_icon_4" src="../images/icon-back.png" /></a></div>
			<div class="link"><a href="#" id="area1_list_4"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_4"></div>
			<div class="txt" id="area1_text_4"></div>
        </div>
		<div class="item" id="divChannelList_5" style="top:210px;">
			<div class="icon"><a href="#" id="area2_list_5"><img id="area2_icon_5" src="../images/icon-back.png" /></a></div>
			<div class="link"><a href="#" id="area1_list_5"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_5"></div>
			<div class="txt" id="area1_text_5"></div>
        </div>
		<div class="item" id="divChannelList_6" style="top:251px;">
			<div class="icon"><a href="#" id="area2_list_6"><img id="area2_icon_6" src="../images/icon-back.png" /></a></div>
			<div class="link"><a href="#" id="area1_list_6"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_6"></div>
			<div class="txt" id="area1_text_6"></div>
        </div>
		<div class="item" id="divChannelList_7" style="top:292px;">
			<div class="icon"><a href="#" id="area2_list_7"><img id="area2_icon_7" src="../images/icon-back.png" /></a></div>
			<div class="link"><a href="#" id="area1_list_7"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_7"></div>
			<div class="txt" id="area1_text_7"></div>
        </div>
		<div class="item" id="divChannelList_8" style="top:333px;">
			<div class="icon"><a href="#" id="area2_list_8"><img id="area2_icon_8" src="../images/icon-back.png" /></a></div>
			<div class="link"><a href="#" id="area1_list_8"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_8"></div>
			<div class="txt" id="area1_text_8"></div>
        </div>
		<div class="item" id="divChannelList_9" style="top:372px;">
			<div class="icon"><a href="#" id="area2_list_9"><img id="area2_icon_9" src="../images/icon-back.png" /></a></div>
			<div class="link"><a href="#" id="area1_list_9"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_9"></div>
			<div class="txt" id="area1_text_9"></div>
        </div>
        
        <div class="btn" id="downArrow" style="left:73px; top:400px;"><img src="../images/arrow-down02.png" /></div>
	</div>
<div class="pages" id="pageNum" style="left:90px; top:484px; text-align:center;"></div>
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
<div id="testText" style="position:absolute; color:#F00; left: 20px; top: 29px; width: 602px; height: 21px;"></div>	
</div>
<%@ include file="servertimehelp.jsp" %>	
</body>
</html>
