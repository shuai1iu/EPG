<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="save_focus.jsp"%>
<%
String path = request.getRequestURI().substring(0,request.getRequestURI().lastIndexOf("/")+1);   
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
String currDateTime1 = request.getParameter("currDateTime")==null?"":request.getParameter("currDateTime");
String cruntChannelID1 = request.getParameter("cruntChannelID")==null?"":request.getParameter("cruntChannelID");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>回放-湖北广电标清EPG2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/indexstyle.css" />
</head>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
var area0,area1,area2,area3;
var returnurl=unescape(window.location.href);
var areaid = <%=request.getParameter("areaid")==null?0:Integer.parseInt(request.getParameter("areaid"))%>;
var indexid = <%=request.getParameter("indexid")==null?0:Integer.parseInt(request.getParameter("indexid"))%>;
var pageobj;
var backfocus=null;
var temppageTurnDataList=new Array();
var tempchnnalList=new Array();
var tempDateList = new Array();
var tempProgramList = new Array();
var temppageTurnProgramList = new Array();
//已经录好的条数
var recPrevueLength;
var cruntChannelID="<%=cruntChannelID1%>";
var currDateTime = "<%=currDateTime1%>";
//从直播进来时需要的数据
var area0curindex=<%=request.getParameter("area0curindex")==null?0:Integer.parseInt(request.getParameter("area0curindex"))%>;
var area1curindex=<%=request.getParameter("area1curindex")==null?0:Integer.parseInt(request.getParameter("area1curindex"))%>;
var area1cruntpage = <%=request.getParameter("area1cruntpage")==null?1:Integer.parseInt(request.getParameter("area1cruntpage"))%>;


                 
				 
				 
				 
				 
				 
var channelTypeData=[{TYPENAME:"全部",TYPEID:"00000100000000090000000000015842"},
                     {TYPENAME:"湖北",TYPEID:" 10000100000000090000000000039770"},
					 {TYPENAME:"央视",TYPEID:"00000100000000090000000000015842"},
					 {TYPENAME:"卫视",TYPEID:"10000100000000090000000000039770"},
					 {TYPENAME:"专业",TYPEID:"00000100000000090000000000015842"},
					 {TYPENAME:"轮播",TYPEID:"10000100000000090000000000039770"},
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
		
		area1 = AreaCreator(10,1,new Array(-1,0,-1,2),"area1_list_", "afocus","ablur");
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
			  timer=setTimeout(getDateAndProgramList,500);
		}
		
		area2 = AreaCreator(3,1,new Array(-1,1,-1,3),"area2_list_", "afocus","ablur");
		for(var i=0;i<3;i++)
		{
		   area2.doms[i].contentdom=$("area2_text_"+i);
		}
		
		area2.changefocusingEvent = function()
		{
			$("divDateList_"+area2.curindex).className="item";
			
		}
		
		area2.changefocusedEvent = function()
		{
			area3.curpage=1;
	        area3.curindex=0;
			cruntChannelID="";
			currDateTime="";
			$("divDateList_"+area2.curindex).className="item item_select";
			var timer;
			if(timer!=undefined)
			clearTimeout(timer);
			timer=setTimeout(getProgramListList,500);
		}
		
		area3 = AreaCreator(10,1,new Array(-1,2,-1,-1),"programList_", "afocus","ablur");
		
		for(var i=0;i<10;i++)
		{
		   area3.doms[i].contentdom=$("programName_"+i);
		   area3.doms[i].timedom=$("programTime_"+i);
		}
		area3.setcrossturnpage();
		
		area3.asyngetdata=function()
		{
			turnPageProgramList(tempProgramList);
		}
		
	  var backflag='<%=request.getParameter("back")%>';
	  var tempAreaIndex;
	  if("1"==backflag||"-1"==backflag)
	  {
		  backfocus=getCurFocus("playBcakIndex");
		  area3.curindex=backfocus[0].curindex;
		  area3.curpage=backfocus[0].curpage;
		  area0.curindex=backfocus[1].curindex;
		  area1.curindex=backfocus[2].curindex;
		  area1.curpage=backfocus[2].curpage;
		  area2.curindex=backfocus[3].curindex;
		  $("divType_"+area0.curindex).className="item item_select";
		  $("divChannelList_"+area1.curindex).className="item item_select";
		  tempAreaIndex = area0.curindex;
	  }
	  $("divDateList_"+area2.curindex).className="item item_select";
	  //areaid等于1表示从直播页面跳转过来的
	  if(areaid==1)
	  {
		  area0.curindex= area0curindex;
		  area1.curindex=area1curindex;
		  area1.curpage= area1cruntpage;
		  $("divType_"+area0.curindex).className="item item_select";
	  }
	  bindTypesData(channelTypeData);
	  getChnnelList();
	  pageobj=new PageObj(backfocus!=null?backfocus[0].areaid:areaid,backfocus!=null?backfocus[0].curindex:indexid,new Array(area0,area1,area2,area3));
	  pageobj.pageOkEvent=function()
	  {
		var json=createAllFocstr(pageobj);
		saveCookie("playBcakIndex",json!=undefined?json:"");
	  }
	  
	  pageobj.goBackEvent=function()
	  {
		  if(areaid==1)
	      {
		     window.location.href="live1.jsp?back=1";
		  }
		  else
		  {
			  window.location.href="index.jsp?back=1";
		  }
	  }
}

function getChnnelList()
{
	var typeid = channelTypeData[area0.curindex].TYPEID;
	$('hidden_frame').src = "<%=basePath%>datajsp/playBackData.jsp?typeID="+typeid+"&cruntChannelID="+cruntChannelID+"&currDateTime="+currDateTime;
}

function getDateAndProgramList()
{
	if(temppageTurnDataList.length!=0)
	{
	    $('hidden_frame').src ="<%=basePath%>datajsp/playBackDateAndProgramData.jsp?channelid="+temppageTurnDataList[area1.curindex].CHANNELID;
	}
}


function getProgramListList()
{
	if(tempDateList.length!=0)
	{
	   $('hidden_frame').src ="<%=basePath%>datajsp/playBackProgramListData.jsp?channelid="+temppageTurnDataList[area1.curindex].CHANNELID+"&currDateTime="+tempDateList[tempDateList.length-1-area2.curindex].date24;
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
	  for(var i=0;i<size;i++)
	 {
		pageTurnDataList[i]=jsonChannelList[start+i];
	 }
	 temppageTurnDataList = pageTurnDataList;
	 bindChannelList(temppageTurnDataList);

}

function turnPageProgramList(jsonprevueList)
{
	area3.pagecount = Math.ceil(jsonprevueList.length/10);
	var pageTurnDataList=new Array();
	 var start = (area3.curpage-1)*10;
	 var size = (jsonprevueList.length-start)>=10?10:(jsonprevueList.length-start);
	  for(var i=0;i<size;i++)
	 {
		pageTurnDataList[i]=jsonprevueList[start+i];
	 }
	 temppageTurnProgramList = pageTurnDataList;
	 bandprogramData(temppageTurnProgramList);

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
	   }
	   else
	   {
		   area1.doms[i].updatecontent("");
		   area1.doms[i].numdom.innerHTML="";
		   area1.doms[i].mylink="javascript:#";
	   }
	}
	
	showArrowIcon();
	showPageNum();
	//showArrowIcon();
	/*var timer;
	if(timer!=undefined)
	clearTimeout(timer);
	timer=setTimeout(getProgramList,500);*/
}

function bandDateData(datavalue)
{
	tempDateList = datavalue;
	for(var i=0;i<area2.doms.length;i++)
	{
	  if(i<datavalue.length)
	   {
		  area2.doms[i].setcontent("",datavalue[datavalue.length-1-i].dateChinese.substring(8,11));	
	   }
	   else
	   {
		  area2.doms[i].updatecontent("");
	   }
	}
}

function bandprogramData(datavalue)
{
	area3.setpageturndata(datavalue.length, area3.pagecount);
	//已经录好的条数
	var tempNUM = recPrevueLength%10;
	var temppageNUM = Math.ceil(recPrevueLength/10);
	for(var i=0;i<area3.doms.length;i++)
	{
		if(i<datavalue.length)
		{
			area3.doms[i].timedom.innerHTML=datavalue[i].startTime.substring(0,5);
			area3.doms[i].setcontent("",datavalue[i].tvodProgramName,16);
		}
		else
		{
			area3.doms[i].timedom.innerHTML="";
			area3.doms[i].updatecontent("");
		}
	}
	
	for(var i=0;i<area3.doms.length;i++)
	{
		if((area3.curpage==temppageNUM&&i>=tempNUM&&tempNUM!=0))
		{
			$("divProgram_"+i).className="item item_gray";
			area3.doms[i].mylink="javascript:#";
			$("programIcon_"+tempNUM).style.display="block";
		}
		else if(area3.curpage>temppageNUM)
		{
			$("divProgram_"+i).className="item item_gray";
			area3.doms[i].mylink="javascript:#";
			$("programIcon_"+tempNUM).style.display="none";
		
		}
		else
		{
			$("divProgram_"+i).className="item";
			$("programIcon_"+tempNUM).style.display="none";
			//area3.doms[i].mylink="live1.jsp?returnurl="+escape("playback.jsp?back=1&cruntChannelID="+temppageTurnDataList[area1.curindex].CHANNELID+"&currDateTime="+tempDateList[tempDateList.length-1-area2.curindex].date24);
			//document.getElementById("testText").innerHTML=datavalue[i].tvodProgramId+"---"+datavalue[i].endTime+"---"+datavalue[i].channelID+"---"+datavalue[i].startTime;
			
			area3.doms[i].mylink="au_ReviewOrSubscribe.jsp?PROGID=" + datavalue[i].tvodProgramId + "&PLAYTYPE=4&CONTENTTYPE=300&&BUSINESSTYPE=5&PROGSTARTTIME="+datavalue[i].startTime+"&PROGENDTIME="+datavalue[i].endTime + "&ISSUB=1&PREVIEWFLAG=1&TVOD=1&CHANNELID="+datavalue[i].channelID+"&returnurl="+escape("playback.jsp?back=1&cruntChannelID="+temppageTurnDataList[area1.curindex].CHANNELID+"&currDateTime="+tempDateList[tempDateList.length-1-area2.curindex].date24);
		}
	}
	showProgramNUM();
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

function showProgramNUM()
{
	if(area3.pagecount>0)
	{
	   $("pageProgramNUM").style.display="block";
	   $("pageProgramNUM").innerHTML=area3.curpage+"/"+area3.pagecount;
	}
	else
	{
		$("pageProgramNUM").style.display="none";
	}
}
</script>
<body bgcolor="transparent">

<!--pagebg-->
<div class="pagebg">
	<div class="pic"><img src="../images/bg-playback.jpg" width="640" height="530" /></div>
</div>
<!--pagebg the end-->



<div class="wrapper">
	<!--head-->
	<div class="txt txt-title" style="top:5px;">回放</div>
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
    <div class="btn" id="upArrow" style=" left:127px; top:51px;"><img src="../images/arrow-up02.png" /></div>
	<div class="nav-c">
		<!--选中为
				 class="item item_select"
		-->
		<div class="item" id="divChannelList_0">
            <div class="link"><a href="#" id="area1_list_0"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_0"></div>
			<div class="txt" id="area1_text_0"></div>
        </div>
		<div class="item" id="divChannelList_1" style="top:42px;">
			<div class="link"><a href="#" id="area1_list_1"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_1"></div>
			<div class="txt" id="area1_text_1"></div>
        </div>
		<div class="item" id="divChannelList_2" style="top:84px;">
			<div class="link"><a href="#" id="area1_list_2"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_2"></div>
			<div class="txt" id="area1_text_2"></div>
        </div>
		<div class="item" id="divChannelList_3" style="top:126px;">
			<div class="link"><a href="#" id="area1_list_3"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_3"></div>
			<div class="txt" id="area1_text_3"></div>
        </div>
		<div class="item" id="divChannelList_4" style="top:168px;">
			<div class="link"><a href="#" id="area1_list_4"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_4"></div>
			<div class="txt" id="area1_text_4"></div>
        </div>
		<div class="item" id="divChannelList_5" style="top:210px;">
			<div class="link"><a href="#" id="area1_list_5"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_5"></div>
			<div class="txt" id="area1_text_5"></div>
        </div>
		<div class="item" id="divChannelList_6" style="top:251px;">
			<div class="link"><a href="#" id="area1_list_6"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_6"></div>
			<div class="txt" id="area1_text_6"></div>
        </div>
		<div class="item" id="divChannelList_7" style="top:292px;">
			<div class="link"><a href="#" id="area1_list_7"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_7"></div>
			<div class="txt" id="area1_text_7"></div>
        </div>
		<div class="item" id="divChannelList_8" style="top:333px;">
			<div class="link"><a href="#" id="area1_list_8"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_8"></div>
			<div class="txt" id="area1_text_8"></div>
        </div>
		<div class="item" id="divChannelList_9" style="top:372px;">
			<div class="link"><a href="#" id="area1_list_9"><img src="../images/t.gif" /></a></div>
			<div class="num" id="area1_num_9"></div>
			<div class="txt" id="area1_text_9"></div>
        </div>
	</div>
	<div class="btn" id="downArrow" style=" left:127px; top:468px;"><img src="../images/arrow-down02.png" /></div>
	<div class="pages" id="pageNum" style="left:90px; top:484px; text-align:center;"></div>
	<!--nav the end-->
		
	
	<!-- list date-->
    <div class="list-d">
		<!--选中为
				 class="item item_select"
		-->
        <div class="item" id="divDateList_0">
			<div class="link"><a href="#" id="area2_list_0"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area2_text_0"></div>
        </div>
		<div class="item" id="divDateList_1" style="top:36px;">
			<div class="link"><a href="#" id="area2_list_1"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area2_text_1"></div>
        </div>
		<div class="item" id="divDateList_2" style="top:72px;">
			<div class="link"><a href="#" id="area2_list_2"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area2_text_2"></div>
        </div>
    </div>
    <!-- list date the end -->
	
	
	<!-- list r-->
    <div class="list-e">
		<div class="item" id="divProgram_0">
			<div class="link"><a href="#" id="programList_0"><img src="../images/t.gif" /></a></div>
            <div class="icon" id="programIcon_0"><img src="../images/icon-point.png" /></div>
			<div class="time" id="programTime_0"></div>
			<div class="txt" id="programName_0"></div>
        </div>
		<div class="item" id="divProgram_1" style="top:40px;">
			<div class="link"><a href="#" id="programList_1"><img src="../images/t.gif" /></a></div>
            <div class="icon" id="programIcon_1"><img src="../images/icon-point.png" /></div>
			<div class="time" id="programTime_1"></div>
			<div class="txt" id="programName_1"></div>
        </div>
		<div class="item" id="divProgram_2" style="top:80px;">
			<div class="link"><a href="#" id="programList_2"><img src="../images/t.gif" /></a></div>
            <div class="icon" id="programIcon_2"><img src="../images/icon-point.png" /></div>
			<div class="time" id="programTime_2"></div>
			<div class="txt" id="programName_2"></div>
        </div>
		<div class="item" id="divProgram_3" style="top:120px;">
			<div class="link"><a href="#" id="programList_3"><img src="../images/t.gif" /></a></div>
            <div class="icon" id="programIcon_3"><img src="../images/icon-point.png" /></div>
			<div class="time" id="programTime_3"></div>
			<div class="txt" id="programName_3"></div>
        </div>
		<div class="item" id="divProgram_4" style="top:160px;">
			<div class="link"><a href="#" id="programList_4"><img src="../images/t.gif" /></a></div>
            <div class="icon" id="programIcon_4"><img src="../images/icon-point.png" /></div>
			<div class="time" id="programTime_4"></div>
			<div class="txt" id="programName_4"></div>
        </div>
		<div class="item" id="divProgram_5" style="top:200px;">
			<div class="link"><a href="#" id="programList_5"><img src="../images/t.gif" /></a></div>
            <div class="icon" id="programIcon_5"><img src="../images/icon-point.png" /></div>
			<div class="time" id="programTime_5"></div>
			<div class="txt" id="programName_5"></div>
        </div>
		<div class="item" id="divProgram_6" style="top:240px;">
			<div class="link"><a href="#" id="programList_6"><img src="../images/t.gif" /></a></div>
            <div class="icon" id="programIcon_6"><img src="../images/icon-point.png" /></div>
			<div class="time" id="programTime_6"></div>
			<div class="txt" id="programName_6"></div>
        </div>
		<div class="item" id="divProgram_7" style="top:280px;">
			<div class="link"><a href="#" id="programList_7"><img src="../images/t.gif" /></a></div>
            <div class="icon" id="programIcon_7"><img src="../images/icon-point.png" /></div>
			<div class="time" id="programTime_7"></div>
			<div class="txt" id="programName_7"></div>
        </div>
		<div class="item" id="divProgram_8" style="top:320px;">
			<div class="link"><a href="#" id="programList_8"><img src="../images/t.gif" /></a></div>
            <div class="icon" id="programIcon_8"><img src="../images/icon-point.png" /></div>
			<div class="time" id="programTime_8"></div>
			<div class="txt" id="programName_8"></div>
        </div>
		<div class="item" id="divProgram_9" style="top:360px;">
			<div class="link"><a href="#" id="programList_9"><img src="../images/t.gif" /></a></div>
            <div class="icon" id="programIcon_9"><img src="../images/icon-point.png" /></div>
			<div class="time" id="programTime_9"></div>
			<div class="txt" id="programName_9"></div>
        </div>
    </div>
	
	<div class="pages" id="pageProgramNUM" style="left:370px; top:484px; text-align:center;"></div>
    <!-- list r the end -->
	
	
<iframe name="hidden_frame" id="hidden_frame" style="display:none" width="0" height="0" ></iframe>
<div id="testText" style="position:absolute; color:#F00; left: 20px; top: 29px; width: 602px; height: 21px;"></div>	
</div>	
<%@ include file="servertimehelp.jsp" %>
</body>
</html>
