<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="save_focus.jsp"%>
<%@ include file="datajsp/vod_data.jsp"%>
<%
String path = request.getRequestURI().substring(0,request.getRequestURI().lastIndexOf("/")+1);   
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>点播改-湖北广电标清EPG2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/indexstyle.css" />
</head>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
var area0,area1;
var returnurl=unescape(window.location.href);
var cruntpage = <%=request.getParameter("curpage")==null?1:Integer.parseInt(request.getParameter("curpage"))%>;
var areaid = <%=request.getParameter("areaid")==null?0:Integer.parseInt(request.getParameter("areaid"))%>;
var indexid = <%=request.getParameter("indexid")==null?0:Integer.parseInt(request.getParameter("indexid"))%>;
var pageobj;
var backfocus=null;
var isTurnPageFlag=0;
var timer;
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

		area0 = AreaCreator(10,1,new Array(-1,-1,-1,1),"area0_list_", "afocus","ablur");
	    area0.pagecount = Math.ceil(contentTotal/10);
		area0.setfocuscircle(0);
		area0.setcrossturnpage();
		for(i=0;i<10;i++)
		{
		   area0.doms[i].contentdom=$("area0_text_"+i);
		}
		var backflag='<%=request.getParameter("back")%>';
		if("1"==backflag||"-1"==backflag)
		{

		  backfocus=getCurFocus("vodindex");
		  if(backfocus[0].areaid==0)
		  {
			  area0.curindex=backfocus[0].curindex;
		      area0.curpage=backfocus[0].curpage;
		  }
		  else
		  {
			  area0.curindex=backfocus[1].curindex;
		      area0.curpage=backfocus[1].curpage;
		  
		  }
		  cruntpage = area0.curpage;
		}
		area0.asyngetdata=function()
		{
			isTurnPageFlag=1;
			 turnpageTypesShowData(this.curpage,typeData);
		}
		
		area0.changefocusingEvent = function()
		{
			$("div_"+this.curindex).className="item";
		}
		
		area0.changefocusedEvent = function()
		{
			if(backfocus!=null)
			{
			   $("div_"+backfocus[1].curindex).className="item";
			}
			$("div_"+this.curindex).className="item item_select";
			if(timer!=undefined)
			clearTimeout(timer);
			timer=setTimeout(getList,500);
		}
		
		area1 = AreaCreator(2,4,new Array(-1,0,-1,-1),"area1_list_", "afocus","ablur");
	    area1.pagecount = Math.ceil(contentTotalList/8);
		for(i=0;i<8;i++)
		{
		   area1.doms[i].contentdom=$("area1_text_"+i);
		   area1.doms[i].imgdom=$("area1_img_"+i);
		}	
	  pageobj=new PageObj(backfocus!=null?backfocus[0].areaid:areaid,backfocus!=null?backfocus[0].curindex:indexid,new Array(area0,area1));
	  pageobj.pageOkEvent=function()
	  {
	  
		var json=createAllFocstr(pageobj);
		
		saveCookie("vodindex",json!=undefined?json:""); 
	  
	  }
	  
	  pageobj.goBackEvent=function()
	  {
		 window.location.href="index.jsp?back=1";
	  }
	 turnpageTypesShowData(cruntpage,typeData);
}

function getList()
{
	var typeid = typeData[(area0.curpage-1)*10+area0.curindex].TUIJIANTYPE_ID;
	$('hidden_frame').src = "<%=basePath%>datajsp/vodListData.jsp?isFirstFlag=1&stratPosition=0&typeID="+typeid;
}

function turnpageTypesShowData(cruntpageNum,typeData)
{
	 var cruntpageNum = cruntpageNum;
	 typeData = typeData;
	 var pageTurnDataList=new Array();
	 var start = (cruntpageNum-1)*10;
	 var size = (typeData.length-start)>=10?10:(typeData.length-start);
	 for(i=0;i<size;i++)
	 {
		pageTurnDataList[i]=typeData[start+i];
	 }
	 bindTypesData(pageTurnDataList);
	
}


function bindTypesData(datavalue)
{
	area0.setpageturndata(datavalue.length, area0.pagecount);
	for(i=0;i<area0.doms.length;i++)
	{
	   if(i<datavalue.length)
	   {
		   area0.doms[i].setcontent("",datavalue[i].TYPE_NAME,8,true,true);
		   area0.doms[i].mylink="vodSecond.jsp?typeid="+datavalue[i].TYPE_ID+"&cateName="+datavalue[i].TYPE_NAME;
	   }
	   else
	   {
		   area0.doms[i].updatecontent("");
		   area0.doms[i].mylink="#";
	   }
	}
	showArrowIcon();
	if(backfocus!=null&&isTurnPageFlag==0)
	{
		$("div_"+backfocus[1].curindex).className="item item_select";
		var typeid = typeData[(backfocus[1].curpage-1)*10+backfocus[1].curindex].TUIJIANTYPE_ID;
		$('hidden_frame').src = "<%=basePath%>datajsp/vodListData.jsp?isFirstFlag=1&stratPosition=0&typeID="+typeid;
	}
}


function bindFilmsData(datavalue)
{
	isTurnPageFlag=0;
	for(i=0;i<area1.doms.length;i++)
	{
	   if(i<datavalue.length)
	   {
		   area1.doms[i].setcontent("",datavalue[i].VODNAME,12);
		   area1.doms[i].updateimg(datavalue[i].POSTERPATHS==undefined?"../images/nopicture.jpg":datavalue[i].POSTERPATHS);
		   if(datavalue[i].ISSITCOM==0)
		   {
		       area1.doms[i].mylink="vod-tv-detail.jsp?vodid="+datavalue[i].VODID+"&returnurl="+returnurl;
		   }
		   else
		   {
			   area1.doms[i].mylink = "vod-zt-detail.jsp?catename=推荐栏&vodid="+datavalue[i].VODID+"&returnurl="+returnurl;
		   
		   }
	   }
	   else
	   {
		   area1.doms[i].updatecontent("");
		   area1.doms[i].mylink="#";
		   
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
</script>
<body bgcolor="transparent">

<!--pagebg-->
<div class="pagebg">
	<div class="pic"><img src="../images/bg-vod.jpg" width="640" height="530" /></div>
</div>
<!--pagebg the end-->



<div class="wrapper">
	<!--head-->
	<div class="txt txt-title" style="top:5px;">点播</div>
	<div class="txt txtDate02" id="currDate"></div>
	<!--head the end-->
	
	
	<!--nav-->
	<div class="btn" id="btn0" style=" left:27px;top:36px; display:none"><img src="../images/arrow-up.png" /></div>
	<div class="nav">
		<!--选中为
				 class="item item_select"
		-->
		<div class="item" id="div_0">
			<div class="link"><a href="#" id="area0_list_0"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_text_0"></div>
        </div>
		<div class="item" id="div_1" style="top:40px;">
			<div class="link"><a href="#" id="area0_list_1"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_text_1"></div>
        </div>
		<div class="item" id="div_2" style="top:80px;">
			<div class="link"><a href="#" id="area0_list_2"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_text_2"></div>
        </div>
		<div class="item" id="div_3" style="top:120px;">
			<div class="link"><a href="#" id="area0_list_3"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_text_3"></div>
        </div>
		<div class="item" id="div_4" style="top:160px;">
			<div class="link"><a href="#" id="area0_list_4"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_text_4"></div>
        </div>
		<div class="item" id="div_5" style="top:200px;">
			<div class="link"><a href="#" id="area0_list_5"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_text_5"></div>
        </div>
		<div class="item" id="div_6" style="top:240px;">
			<div class="link"><a href="#" id="area0_list_6"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_text_6"></div>
        </div>
		<div class="item" id="div_7" style="top:280px;">
			<div class="link"><a href="#" id="area0_list_7"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_text_7"></div>
        </div>
		<div class="item" id="div_8" style="top:320px;">
			<div class="link"><a href="#" id="area0_list_8"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_text_8"></div>
        </div>
		<div class="item" id="div_9" style="top:360px;">
			<div class="link"><a href="#" id="area0_list_9"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_text_9"></div>
        </div>
	</div>
	<div class="btn" id="btn1" style=" left:27px;top:469px; display:none"><img src="../images/arrow-down.png" /></div>
	<!--nav the end-->
	
	
	<!-- list -->
    <div class="list-c">
		<div class="item">
			<div class="link"><a href="#" id="area1_list_0"><img src="../images/t.gif" /></a></div>
            <div class="pic"><img id="area1_img_0" src="#" /></div>
			<div class="txt-wrap">
				<div class="txt" id="area1_text_0"></div>
			</div>
        </div>
		<div class="item" style="left:130px;">
			<div class="link"><a href="#" id="area1_list_1"><img src="../images/t.gif" /></a></div>
            <div class="pic"><img id="area1_img_1" src="#" /></div>
			<div class="txt-wrap">
				<div class="txt" id="area1_text_1"></div>
			</div>
        </div>
		<div class="item" style="left:260px;">
			<div class="link"><a href="#" id="area1_list_2"><img src="../images/t.gif" /></a></div>
            <div class="pic"><img id="area1_img_2" src="#" /></div>
			<div class="txt-wrap">
				<div class="txt" id="area1_text_2"></div>
			</div>
        </div>
		<div class="item" style="left:390px;">
			<div class="link"><a href="#" id="area1_list_3"><img src="../images/t.gif" /></a></div>
            <div class="pic"><img id="area1_img_3" src="#" /></div>
			<div class="txt-wrap">
				<div class="txt" id="area1_text_3"></div>
			</div>
        </div>
		<div class="item" style="top:187px;">
			<div class="link"><a href="#" id="area1_list_4"><img src="../images/t.gif" /></a></div>
            <div class="pic"><img id="area1_img_4" src="#" /></div>
			<div class="txt-wrap">
				<div class="txt" id="area1_text_4"></div>
			</div>
        </div>
		<div class="item" style="left:130px;top:187px;">
			<div class="link"><a href="#" id="area1_list_5"><img src="../images/t.gif" /></a></div>
            <div class="pic"><img id="area1_img_5" src="#" /></div>
			<div class="txt-wrap">
				<div class="txt" id="area1_text_5"></div>
			</div>
        </div>
		<div class="item" style="left:260px;top:187px;">
			<div class="link"><a href="#" id="area1_list_6"><img src="../images/t.gif" /></a></div>
            <div class="pic"><img id="area1_img_6" src="#" /></div>
			<div class="txt-wrap">
				<div class="txt" id="area1_text_6"></div>
			</div>
        </div>
		<div class="item" style="left:390px;top:187px;">
			<div class="link"><a href="#" id="area1_list_7"><img src="../images/t.gif" /></a></div>
            <div class="pic"><img id="area1_img_7" src="#" /></div>
			<div class="txt-wrap">
				<div class="txt" id="area1_text_7"></div>
			</div>
        </div>
    </div>
    <!-- list the end -->
    <iframe name="hidden_frame" id="hidden_frame" style="display:none" width="0" height="0" ></iframe>
	<div id="testText" style="position:absolute; color:#F00; left: 195px; top: 32px; width: 415px; height: 33px;"></div>
</div>	
<%@ include file="servertimehelp.jsp" %>
</body>
</html>