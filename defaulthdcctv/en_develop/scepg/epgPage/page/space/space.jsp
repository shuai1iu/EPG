<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>空间- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<style type="text/css">
<!--
	body{ background:url(../../images/bg-d02.jpg) no-repeat;}
-->
</style>
<%@ include file="../../../util/servertime.jsp"%>
<%@ include file="../../base.jsp"%>
<script type="text/javascript">

var spaceAllVodData="";
function callProgrameList(data)
{
    area1.pagecount =Math.ceil(data.countTotal/6);	
	area1.datanum=2*data.collentList.length;
	$("spaceCurpage").innerHTML = area1.curpage;
	$("spaceTotalpage").innerHTML =Math.ceil(data.countTotal/6);
	initFavoritedData(data);
    spaceAllVodData=data;
}

function initFavoritedVod(data)
{
  if(data==1)
  {
	  initFavoritedList();//重新初始化收藏的影片
  }
}

   
var area0,area1;
var pageobj;
var areaid=0;
var indexid=0;
var isfavsucc=-1;
window.onload=function()
{
	area0 = AreaCreator(4,1,new Array(-1,-1,-1,1),"area0_list_","className:item item_select","className:item");
	area1 = AreaCreator(3,4,new Array(-1,0,-1,-1),"area1_list_","className:item item_focus","className:item");
	area1.curpage=1;
	area1.endwiseCrossturnpage = true;
	area1.pagecount =1;	
	area1.areaPageTurnEvent=function(num)
	{ 
		var spaceAllFavorited=$("spaceAllFavorited");
		spaceAllFavorited.src="../iframe/spaceAllFavorited.jsp?curpage="+area1.curpage;	
	}

   area1.areaOkEvent=function()
   {
	   
		if(area1.curindex%2==0&&spaceAllVodData.collentList[area1.curindex/2].programType==1)
		{
			window.location.href="../dibbling/detail-single.jsp?programCode="+spaceAllVodData.collentList[area1.curindex/2].programCode;
		}
		else if(area1.curindex%2==0&&spaceAllVodData.collentList[area1.curindex/2].programType==14)
		{
			window.location.href="../dibbling/detail-much.jsp?programCode="+spaceAllVodData.collentList[area1.curindex/2].programCode;
		}
		else
		{
			var spaceCollectDelIframe=$("spaceCollectDelIframe");
			var programCode= spaceAllVodData.collentList[(area1.curindex-1)/2].programCode;
		    spaceCollectDelIframe.src="../iframe/spaceCollectDelIframe.jsp?programCode="+programCode+"&favoriteType=VOD";	
		}
		
		
	}
	

	pageobj = new PageObj(areaid, indexid, new Array(area0,area1));
	pageobj.backurl="../index/index.jsp";
	pageInit();
	
}

function pageInit()
{
	initFavoritedList();
	initTime();
}
function initFavoritedList()
{
	var spaceAllFavorited=$("spaceAllFavorited");
    spaceAllFavorited.src="../iframe/spaceAllFavorited.jsp?curpage=1";	
}

//删除收藏
function delCollect(resultstr){
	isfavsucc = parseInt(resultstr.result);
	dodelfav();
}

function dodelfav(){
	   switch(isfavsucc){
			case 0:
			
				break;
			case 1:
				initFavoritedList();
				break;
			default:
				break;
	   }
}

function initFavoritedData(data)
{
	for(var i=0;i<data.collentList.length;i++)
	{
	    $("area1_txt_"+i*2).innerHTML=data.collentList[i].progName.length>8?data.collentList[i].progName.substr(0,5)+"...":data.collentList[i].progName;	
	    $("area1_img_"+i*2).src=data.collentList[i].picUrl;
		$("area1_div_"+i).style.visibility="visible";
    }
	if(data.collentList.length<6)
	{
		for(var i=data.collentList.length;i<6;i++)
		{
			$("area1_div_"+i).style.visibility="hidden";			
		}		
	}
}


  //初始化时间
function initTime()
{
	 $("timeDate").innerHTML = time1;
	 $("time").innerHTML = time2;	
};



</script>
</head>
<body bgcolor="transparent">

<div class="wrapper">

	<!--head-->
	<div class="headline-shade">空间</div>
	<div class="headline">空间</div>
	<div class="date">
		<div class="txt" id="timeDate" >05/27</div>
		<div class="txt txt-time" style="top:22px;" id="time">11:15</div>
	</div>
	<!--head the end-->

	
	
	<!--nav-->
	<div class="nav">
		<!--焦点 
				class="item item_focus"
			选中
				class="item item_select"
		-->
		<div class="item item_select" id="area0_list_0">
			<div class="txt">我的收藏</div>
			<div class="icon"></div>
		</div>   
		<div class="item" style="top:70px;" id="area0_list_1">
			<div class="txt">我的书签 </div>
			<div class="icon"></div>
		</div>
		<div class="item" style="top:140px;" id="area0_list_2">
			<div class="txt">消费记录</div>
			<div class="icon"></div>
		</div> 
		<div class="item" style="top:210px;" id="area0_list_3">
			<div class="txt">操作指南</div>
			<div class="icon"></div>
		</div>
	</div> 
	<!--nav the end-->
	
		
	
	<!--list-->
	<div class="list-pic-i">
		<div class="mold" id="area1_div_0">
			<div class="pic-shade">
				<!--焦点 
						class="item item_focus"
				-->
				<div class="item" id="area1_list_0">
					<div class="pic"><img id="area1_img_0" src="" /></div>
				</div>
			</div>
			<div class="txt txt01" id="area1_txt_0"></div>
			<div class="txt txt02"></div>
			<div class="btn-c">
				<!--焦点 
						class="item item_focus"
				-->
				<div class="item" id="area1_list_1">
					<div class="txt">取消收藏</div>
				</div>
			</div>
		</div>
		<div class="mold" style="left:445px;" id="area1_div_1">
			<div class="pic-shade">
				<!--焦点 
						class="item item_focus"
				-->
				<div class="item" id="area1_list_2">
					<div class="pic"><img id="area1_img_2" src="" /></div>
				</div>
			</div>
			<div class="txt txt01" id="area1_txt_2"></div>
			<div class="txt txt02"></div>
			<div class="btn-c">
				<!--焦点 
						class="item item_focus"
				-->
				<div class="item" id="area1_list_3">
					<div class="txt">取消收藏</div>
				</div>
			</div>
		</div>
		<div class="mold" style="top:200px;" id="area1_div_2">
			<div class="pic-shade">
				<!--焦点 
						class="item item_focus"
				-->
				<div class="item" id="area1_list_4">
					<div class="pic"><img id="area1_img_4" src="" /></div>
				</div>
			</div>
			<div class="txt txt01" id="area1_txt_4"></div>
			<div class="txt txt02"></div>
			<div class="btn-c">
				<!--焦点 
						class="item item_focus"
				-->
				<div class="item" id="area1_list_5">
					<div class="txt">取消收藏</div>
				</div>
			</div>
		</div>
		<div class="mold" style="left:445px;top:200px;" id="area1_div_3">
			<div class="pic-shade">
				<!--焦点 
						class="item item_focus"
				-->
				<div class="item" id="area1_list_6">
					<div class="pic"><img id="area1_img_6" src="" /></div>
				</div>
			</div>
			<div class="txt txt01" id="area1_txt_6"></div>
			<div class="txt txt02"></div>
			<div class="btn-c">
				<!--焦点 
						class="item item_focus"
				-->
				<div class="item" id="area1_list_7">
					<div class="txt">取消收藏</div>
				</div>
			</div>
		</div>
		<div class="mold" style="top:400px;" id="area1_div_4">
			<div class="pic-shade">
				<!--焦点 
						class="item item_focus"
				-->
				<div class="item" id="area1_list_8">
					<div class="pic"><img id="area1_img_8" src="" /></div>
				</div>
			</div>
			<div class="txt txt01" id="area1_txt_8"></div>
			<div class="txt txt02"></div>
			<div class="btn-c">
				<!--焦点 
						class="item item_focus"
				-->
				<div class="item" id="area1_list_9">
					<div class="txt">取消收藏</div>
				</div>
			</div>
		</div>
		<div class="mold" style="left:445px;top:400px;" id="area1_div_5">
			<div class="pic-shade">
				<!--焦点 
						class="item item_focus"
				-->
				<div class="item" id="area1_list_10">
					<div class="pic"><img id="area1_img_10" src="" /></div>
				</div>
			</div>
			<div class="txt txt01" id="area1_txt_10"></div>
			<div class="txt txt02"></div>
			<div class="btn-c">
				<!--焦点 
						class="item item_focus"
				-->
				<div class="item" id="area1_list_11">
					<div class="txt">取消收藏</div>
				</div>
			</div>
		</div>
	</div>
	<!--list the end-->
	
	
	
	<!--pages-->
	<div class="pages-side">
		<div class="txt txt-current" id="spaceCurpage">2</div>
		<div class="txt" style="top:156px;" id="spaceTotalpage">5</div>
	</div>
	<!--pages the end-->	
	
	<iframe id="spaceAllFavorited"  style="width:0px;height:0px;border:0px;" ></iframe> 
    <iframe id="spaceCollectDelIframe"  style="width:0px;height:0px;border:0px;" ></iframe> 
	
</div>
	
</body>
</html>