<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../config/properties.jsp"%>
<%
String vodListFile="../../" + datajspname  + "/vodList.jsp";
String categoryCode=request.getParameter("categoryCode")==null?"":request.getParameter("categoryCode");
String areaid=request.getParameter("areaid")==null?"0":request.getParameter("areaid");
String indexid=request.getParameter("indexid")==null?"0":request.getParameter("indexid");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>名栏-新闻联播-湖北广电标清EPG2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/common.css" />
<style type="text/css">
.video {
	left:355px;
	position:absolute;
	top:127px;
}
/*.video .link,
.video .link img,*/
.video .pic {
	height:207px;
    width:263px;
}
.list {
	left:16px;
	position:absolute;
	top:142px;
}
.list .item {
	height:37px;
	width:328px;
}
.list .item .txt {
	color:#000;
	font-size:20px;
	line-height:37px;
	left:15px;
	width:310px;
} 
/*.list .item_focus {
	background:url(../images/list01_select.png) no-repeat;
}*/ 
.list .item_select {
	background:url(../images/list01_select.png) no-repeat;
}
.list .item_select .txt {
	color:#fff;
}
</style>
<script type="text/javascript">

<jsp:include page="<%=vodListFile%>">             
	<jsp:param name="categoryCode" value="00000100000000090000000000001064" /> 
	<jsp:param name="pageIndex" value="1" /> 
	<jsp:param name="pageSize" value="10" /> 
	<jsp:param name="varName" value="colNewsVodList" />
	<jsp:param name="fileds" value="-1" />
	<jsp:param name="isBug" value="1" />
</jsp:include>


function callVodListData(data)
{
	for(var i=0;i<data.vodDataList.length;i++)
	{
		$("area1_txt_"+i).innerHTML=data.vodDataList[i].name;
	}
}

</script>
<script type="text/javascript">
var pageobj=new Object();
function $(id) 
{
   return document.getElementById(id);
}

var area0={selectpage:1,selectindex:0,curindex:0,stadyindex:0,datanum:2,curpage:1,pagenum:1};
var area1={selectpage:1,selectindex:0,curindex:0,stadyindex:0,datanum:10,curpage:1,pagenum:1};
var area2={selectpage:1,selectindex:0,curindex:0,stadyindex:0,datanum:2,curpage:1,pagenum:1};


var curr_focus=0;   
var curareaindex=0;
var curindex=0;
pageobj.curareaindex=0;
pageobj.curindex=0;
pageobj.areas=new Array();
pageobj.areas.push(area0);
pageobj.areas.push(area1);
pageobj.areas.push(area2);



area0.changefocusEvent = function(stepvalue)
{
     if(stepvalue==1)
     {
        $("area0_img_0").src="../images/btn-prev02.png";
        $("area0_img_1").src="../images/btn-next02_gray.png";    
        area0.curindex=stepvalue+area0.curindex;
     }
     else if(stepvalue==-1)
     {
        $("area0_img_0").src="../images/btn-prev02_gray.png"; 
        $("area0_img_1").src="../images/btn-next02.png";
        area0.curindex=stepvalue+area0.curindex;
     }
     else if(stepvalue==0)
     {
        $("area0_img_0").src="../images/btn-prev02.png";
		$("area0_img_1").src="../images/btn-next02.png";
        pageobj.curareaindex=1;
        pageobj.curindex=0;
        setFocus(area1.curindex);
     }
    
};


area1.changefocusEvent = function(stepvalue)
{
     if(area1.curindex==0&&stepvalue==-1)
     {
        $("area0_img_0").src="../images/btn-prev02_gray.png";
        pageobj.curareaindex=0;
        pageobj.curindex=0;
        freeFocus(area1.curindex);
     }else if(area1.curindex==9&&stepvalue==1)
     {
        $("area2_img_0").src="../images/btn-prev02_gray.png";
        pageobj.curareaindex=2;
        pageobj.curindex=0;
        freeFocus(area1.curindex);
     }
     else
     {
        freeFocus(area1.curindex);
        area1.curindex=stepvalue+area1.curindex;
        setFocus(area1.curindex); 
     } 
};

area2.changefocusEvent = function(stepvalue)
{
     if(stepvalue==1)
     {
        $("area2_img_0").src="../images/btn-prev02.png";
        $("area2_img_1").src="../images/btn-next02_gray.png";    
        area2.curindex=stepvalue+area2.curindex;
     }
     else if(stepvalue==-1)
     {
        $("area2_img_0").src="../images/btn-prev02_gray.png"; 
        $("area2_img_1").src="../images/btn-next02.png";
        area2.curindex=stepvalue+area2.curindex;
     }
     else if(stepvalue==0)
     {
        $("area2_img_0").src="../images/btn-prev02.png";
        pageobj.curareaindex=1;
        pageobj.curindex=9;
        setFocus(area1.curindex);
     }
    
};


pageobj.backurl="news.jsp?areaid="+<%=areaid%>+"&indexid="+<%=indexid%>;

//释放焦点
function freeFocus(focusIndex)
{
	if($("area1_list_" + focusIndex)!=undefined)
	{
		$("area1_list_"+focusIndex).className="item";
	}
}	
//获得焦点
function setFocus(focusIndex)
{
	if($( "area1_list_" + focusIndex)!=undefined)
	{
		$("area1_list_"+focusIndex).className="item item_select";
	}
}	


pageobj.move=function(direction){
	switch(direction){
		   case 0:{
			   if(pageobj.curareaindex==1)
			   {
				    pageobj.areas[pageobj.curareaindex].changefocusEvent(-1);
				   
			   }else if(pageobj.curareaindex==2)
			   {
				    pageobj.areas[pageobj.curareaindex].changefocusEvent(0);
				   
			   }else  if(pageobj.curareaindex==3)
			   {
				    pageobj.areas[pageobj.curareaindex].changefocusEvent(-1);
				   
			   }
			   break;   
		   }
		   case 1:{
		        if(pageobj.curareaindex==0)
	            {
	                pageobj.areas[pageobj.curareaindex].changefocusEvent(-1);
	            }
	            else if(pageobj.curareaindex==2){
				    pageobj.areas[pageobj.curareaindex].changefocusEvent(-1);
	            }
			    break; 
		   }
		   case 2:{
			    if(pageobj.curareaindex==0){
				    pageobj.areas[pageobj.curareaindex].changefocusEvent(0);
				}else  if(pageobj.curareaindex==1)
				{
				    pageobj.areas[pageobj.curareaindex].changefocusEvent(1);
				}
		       break;   
		   }
		   case 3:{
			    if(pageobj.curareaindex==0)
			    {
		           pageobj.areas[pageobj.curareaindex].changefocusEvent(1);
			    }
			    else if(pageobj.curareaindex==2)
			    {
		           pageobj.areas[pageobj.curareaindex].changefocusEvent(1);
			    }
			    break; 
			}
	  }
 };
 
 
 

window.onload = function()
{
  // pageInit();
}

function pageInit()
{
	//initColNewsSrc();
}

//初始化新闻列表
function bindColNewsList()
{
	//$("getColumnNewsFrame").src="../iframe/getColumnNewsFrame.jsp?categoryCode=9999&curpage=1&pageSize=10";  
	
}




	var KEY_BACK = 8;
	var KEY_ENTER=13;
	var KEY_OK =13;
	var KEY_HELP = 284;
	var KEY_LEFT=37;
	var KEY_UP=38;
	var KEY_RIGHT=39;
	var KEY_DOWN=40;

	document.onkeypress = keyEvent;
	//document.onkeydown = keyEvent;
	function keyEvent()
	{
		var val = event.which ? event.which : event.keyCode;
		return keypress(val);
	}
	function keypress(keyval)
	{
		switch(keyval)
		{
		    case 119:
			case 87: //up
			case KEY_UP:			
				pageobj.move(0);
				break;
			
			case 97:
			case 65: //left
			case KEY_LEFT: 
				pageobj.move(1);
				break;
			case 115:
			case 83: //down
			case KEY_DOWN:
				pageobj.move(2);
				break;
		    case 100:
			case 68: //right
			case KEY_RIGHT: //right
				pageobj.move(3);
				break;
			case 13:
			case KEY_OK: //enter
				pageobj.ok();
				break;
			case 32:    // 空格
			case KEY_BACK:
				pageobj.goBack();
				break;
		    default:return 0;
		}
		return 0;
	}

</script>
</head>
<jsp:include page="../iframe/getColumnNewsFrame.jsp" />
<body bgcolor="transparent">
<!--pagebg-->
<div class="pagebg">
	<div class="pic"><img src="../images/bg-news-column01.jpg" width="640" height="127" /></div>
	<div class="pic" style="top:127px;"><img src="../images/bg-news-v02.jpg" width="355" height="207" /></div>
	<div class="pic" style="top:127px; left:618px;"><img src="../images/bg-news-v03.jpg" width="22" height="207" /></div>
	<div class="pic" style="top:334px;"><img src="../images/bg-news-v04.jpg" width="640" height="196" /></div>
</div>
<!--pagebg the end-->

<div class="wrapper">
	<!-- head -->
	<div class="txt" style="color:#000;font-size:27px;font-weight:bold;left:39px;top:53px;width:560px;">名栏-新闻联播</div>
	<!-- head the end -->

	
	<!-- page -->
	<div class="page-a">
		<!--灰色为
				btn-prev02_gray.png
				btn-next02_gray.png
		-->	
		<div class="item" id="area0_list_0"><a href="#"><img id="area0_img_0" src="../images/btn-prev02_gray.png" alt="上页" width="88" height="36" /></a></div>
		<div class="item" style="left:100px;" id="area0_list_1"><a href="#"><img id="area0_img_1" src="../images/btn-next02.png" alt="下页" width="88" height="36" /></a></div>
	</div>
	<div class="txt" style="color:#000; font-size:18px; left:229px; top:102px; text-align:right; width:100px;">1/2页</div>
	<!-- page the end-->
	
	
	<!-- list -->
    <div class="list">
		<!--焦点为
				class="item item_focus" 
			选中为
				class="item item_select" 
		-->	
		<div class="item" id="area1_list_0">
			<div class="link"><a href="#"><img src="../images/t.gif" width="328" height="37" /></a></div>
			<div class="txt" id="area1_txt_0">${colNewsVodList.vodDataList[0].name} </div>
		</div>
		<div class="item" style="top:32px;" id="area1_list_1">
			<div class="link"><a href="#"><img src="../images/t.gif" width="328" height="37" /></a></div>
			<div class="txt" id="area1_txt_1">${colNewsVodList.vodDataList[1].name} </div>
		</div>
		<div class="item" style="top:64px;" id="area1_list_2">
			<div class="link"><a href="#"><img src="../images/t.gif" width="328" height="37" /></a></div>
			<div class="txt" id="area1_txt_2">${colNewsVodList.vodDataList[2].name}</div>
		</div>
		<div class="item" style="top:96px;" id="area1_list_3">
			<div class="link"><a href="#"><img src="../images/t.gif" width="328" height="37" /></a></div>
			<div class="txt" id="area1_txt_3">${colNewsVodList.vodDataList[3].name}</div>
		</div>
		<div class="item" style="top:128px;" id="area1_list_4">
			<div class="link"><a href="#"><img src="../images/t.gif" width="328" height="37" /></a></div>
			<div class="txt" id="area1_txt_4">${colNewsVodList.vodDataList[4].name}</div>
		</div>
		<div class="item" style="top:160px;" id="area1_list_5">
			<div class="link"><a href="#"><img src="../images/t.gif" width="328" height="37" /></a></div>
			<div class="txt" id="area1_txt_5">${colNewsVodList.vodDataList[5].name}</div>
		</div>
		<div class="item" style="top:192px;" id="area1_list_6">
			<div class="link"><a href="#"><img src="../images/t.gif" width="328" height="37" /></a></div>
			<div class="txt" id="area1_txt_6">${colNewsVodList.vodDataList[6].name}</div>
		</div>
		<div class="item" style="top:224px;" id="area1_list_7">
			<div class="link"><a href="#"><img src="../images/t.gif" width="328" height="37" /></a></div>
			<div class="txt" id="area1_txt_7">${colNewsVodList.vodDataList[7].name}</div>
		</div>
		<div class="item" style="top:256px;" id="area1_list_8">
			<div class="link"><a href="#"><img src="../images/t.gif" width="328" height="37" /></a></div>
			<div class="txt" id="area1_txt_8">${colNewsVodList.vodDataList[8].name} </div>
		</div>
		<div class="item" style="top:288px;" id="area1_list_9">
			<div class="link"><a href="#"><img src="../images/t.gif" width="330" height="37" /></a></div>
			<div class="txt" id="area1_txt_9">${colNewsVodList.vodDataList[9].name}</div>
		</div>
	</div>
	<!-- list the end -->
	
	
	<!-- page -->
	<div class="page-a" style="top:468px;">
		<!--灰色为
				btn-prev02_gray.png
				btn-next02_gray.png
		-->	
		<div class="item " id="area2_list_0"><a href="#"><img id="area2_img_0" src="../images/btn-prev02.png" alt="上页" width="88" height="36" /></a></div>
		<div class="item" style="left:100px;" id="area2_list_1"><a href="#"><img id="area2_img_1" src="../images/btn-next02.png" alt="下页" width="88" height="36" /></a></div>
	</div>
	<!-- page the end-->
	
	
	<!-- video-->
	<div class="btn" style="left:544px; top:92px;"><a href="#"><img src="../images/full-screen.png" width="75" height="25" /></a></div>
    <div class="video">
		<div class="link"><a href="#"><img src="../images/t.gif" width="263" height="207" /></a></div>
		<div class="pic"><img src="../images/demopic/video-263X207.jpg" /></div>
		<div class="btn" style="left:86px;top:58px;z-index:10;"><img src="../images/btn-play.png" alt="播放" /></div>
    </div>
	
	<div class="txt" style="color:#084284; font-size:24px; line-height:30px; left:355px; top:395px; text-align:center; width:263px;">2014年02月07日</div>
	<div class="txt" style="color:#084284; font-size:24px; line-height:30px; left:355px; top:435px; text-align:center; width:263px;">《新闻联播》 </div>
    <!-- video the end -->
	<iframe id="getColumnNewsFrame"  style="width:0px;height:0px;border:0px;" ></iframe> 
</div>	

</body>
</html>
