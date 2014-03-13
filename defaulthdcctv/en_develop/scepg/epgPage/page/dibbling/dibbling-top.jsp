<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<%
String vodListFile="../../../" + datajspname  + "/vodList.jsp";
String categoryCode=request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode");  
String indexid=request.getParameter("curindex")==null?"0":request.getParameter("curindex");  
String categoryName=request.getParameter("categoryName")==null?"":request.getParameter("categoryName");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>点播-栏目TOP榜- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<style type="text/css">
<!--
	body{ background:url(../../images/bg-s01.jpg) no-repeat;}
-->
</style>
<%@ include file="../../../util/servertime.jsp"%>
<%@ include file="../../base.jsp"%>
<script type="text/javascript" src="../../js/pagecontrol_1.0.4.js"></script>
<script type="text/javascript">
	<jsp:include page="<%=vodListFile%>">   
		    <jsp:param name="categoryCode" value="<%=categoryCode%>"/> 
			<jsp:param name="varName" value="dibTOPVodList"/>
			<jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="6" />
			<jsp:param name="fields" value="-1" /> 
			<jsp:param name="isBug" value="1" />
	</jsp:include>
	
	
	function callVodListData(data)
	{
	  	if(data!=null&&data!="")
	   {  
	       dibTOPVodList=data;
	       initVodList();
		   initCurPgTotPage();
	       area0.pagecount = dibTOPVodList.totalPage;	
	       area0.datanum=dibTOPVodList.vodDataList.length;
	   }	
		
    }
	
</script>
<script type="text/javascript">
var area0;
var pageobj;
var areaid = 0;
var indexid = 0;
var area0curpage=1;
var curCategoryCode="<%=categoryCode%>";
window.onload=function()
{
	var focusObj=OperatorFocus.getCurFocusAndDelete();
	if(focusObj!=undefined && focusObj!="null" && focusObj!=null)
	{
		if(focusObj.focusdatas!=undefined && focusObj.focusdatas.length>0)
		{				
			areaid=focusObj.focusdatas[0].areaid;
			indexid=focusObj.focusdatas[0].curindex;
			area0curpage=focusObj.focusdatas[0].curpage;
		}
	}
	area0 = AreaCreator(2,3,new Array(-1,-1,-1,-1),"area0_list_","className:item item_focus","className:item");
	for(var i=0;i<area0.doms.length;i++)
	{
		area0.doms[i].contentdom = $("area0_txt_"+i);
	}
	area0.areaOkEvent=function()
	{	
		if(dibTOPVodList.vodDataList[area0.curindex].programType == 1)
		{
			window.location.href = "detail-single.jsp?programCode="+dibTOPVodList.vodDataList[area0.curindex].programCode+"&contentCode="+dibTOPVodList.vodDataList[area0.curindex].contentCode+"&categoryCode="+dibTOPVodList.vodDataList[area0.curindex].categoryCode;
		}else
		{
			window.location.href = "detail-much.jsp?programCode="+dibTOPVodList.vodDataList[area0.curindex].programCode+"&contentCode="+dibTOPVodList.vodDataList[area0.curindex].contentCode+"&categoryCode="+dibTOPVodList.vodDataList[area0.curindex].categoryCode;
		}	
	}
	area0.endwiseCrossturnpage = true;	
	area0.curpage=area0curpage;
	area0.pagecount = dibTOPVodList.totalPage;
	area0.areaPageTurnEvent = function(num)
	{	
		var getdibTopTVODIfame=$("getdibTopTVODIfame");
		getdibTopTVODIfame.src="../iframe/dibTVImageIframe.jsp?categoryCode="+curCategoryCode+"&curpage="+ area0.curpage+"&pageSize=6";  
	};
	
	
	pageobj = new PageObj(areaid, indexid, new Array(area0));
	pageInit();
	pageobj.pageOkEvent=function()
	{
		OperatorFocus.saveFocstr(pageobj);
	};
	if(area0curpage!=1)
	{
		initReturnVod();
	}
	pageobj.backurl = OperatorFocus.getLastReturn();
	
}

function pageInit()
{
	initTime();
	initCurPgTotPage();
	initVodList();
}
//初始化时间
function initTime()
{
	$("timeDate").innerHTML = time1;
	$("time").innerHTML = time2;	
};
function initCurPgTotPage()
{
	 $("dibTOPCurPage").innerHTML = dibTOPVodList.curPage;
	 $("dibTOPTotalPage").innerHTML = dibTOPVodList.totalPage;	
}


 //绑定影片列表
function initVodList()
{
	var tvLength=dibTOPVodList.vodDataList.length;	
	for(var i=0;i<tvLength;i++)
	{		
		var name= dibTOPVodList.vodDataList[i].name;
		$("area0_list_"+i).style.visibility="visible";
		area0.doms[i].setcontent("",dibTOPVodList.vodDataList[i].name,12,true,false);
		$("area0_img_"+i).src = dibTOPVodList.vodDataList[i].pictureList.poster;
	};	

	if(tvLength<6)
	{
		var domsLength=area0.doms.length;
		for(var i=tvLength;i<domsLength;i++)
		{
			$("area0_list_"+i).style.visibility="hidden";			
		}			
	}
				  
} 


function initReturnVod()
{
	var getdibTopTVODIfame=$("getdibTopTVODIfame");
	getdibTopTVODIfame.src="../iframe/dibTVImageIframe.jsp?categoryCode="+curCategoryCode+"&curpage="+ area0.curpage+"&pageSize=6";  
}
	
</script>

</head>

<body bgcolor="transparent">

<div class="wrapper">

	<!--head-->
	<div class="headline-shade"><%=categoryName%></div>
	<div class="headline"><%=categoryName%></div>
	<div class="date">
		<div class="txt" id="timeDate">05/27</div>
		<div class="txt txt-time" style="top:22px;" id="time">11:15</div>
	</div>
	<!--head the end-->
	
	
	
	<!--list-->
	<div class="list-pic-h">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area0_list_0">
			<div class="pic"><img  id="area0_img_0" src="../../images/demopic/pic-294X166.jpg" /></div>
			<div class="txt" id="area0_txt_0">我爱记歌词</div>
		</div>
		<div class="item" style="left:377px;" id="area0_list_1">
			<div class="pic"><img id="area0_img_1" src="../../images/demopic/pic-294X166.jpg" /></div>
			<div class="txt" id="area0_txt_1">快乐大本营</div>
		</div>
		<div class="item" style="left:754px;" id="area0_list_2">
			<div class="pic"><img id="area0_img_2" src="../../images/demopic/pic-294X166.jpg" /></div>
			<div class="txt" id="area0_txt_2">我爱记歌词</div>
		</div>
		<div class="item" style="top:294px;" id="area0_list_3">
			<div class="pic"><img id="area0_img_3" src="../../images/demopic/pic-294X166.jpg" /></div>
			<div class="txt" id="area0_txt_3">快乐大本营</div>
		</div>
		<div class="item" style="left:377px;top:294px;" id="area0_list_4">
			<div class="pic"><img id="area0_img_4" src="../../images/demopic/pic-294X166.jpg" /></div>
			<div class="txt" id="area0_txt_4">我爱记歌词</div>
		</div>
		<div class="item" style="left:754px;top:294px;" id="area0_list_5">
			<div class="pic"><img id="area0_img_5" src="../../images/demopic/pic-294X166.jpg" /></div>
			<div class="txt" id="area0_txt_5">快乐大本营</div>
		</div>
	</div>
	<!--list the end-->
	
	
	
	<!--pages-->
	<div class="pages-side">
		<div class="txt txt-current" id="dibTOPCurPage">2</div>
		<div class="txt" style="top:156px;" id="dibTOPTotalPage">5</div>
	</div>
	<!--pages the end-->	
	
	<iframe id="getdibTopTVODIfame"  style="width:0px;height:0px;border:0px;" ></iframe> 

</div>

</body>
</html>
