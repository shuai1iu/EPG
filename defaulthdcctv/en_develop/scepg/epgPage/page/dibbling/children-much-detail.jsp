<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%
    String vodListFile="../../../" + datajspname  + "/vodList.jsp";
	String strFile="../../../" + datajspname  + "/vodInfo.jsp";
    String programCode=request.getParameter("programCode")==null?"":request.getParameter("programCode");  
    String contentCode=request.getParameter("contentCode")==null?"":request.getParameter("contentCode"); 
	String categoryCode=request.getParameter("categoryCode")==null?"":request.getParameter("categoryCode");  
	String strBookMarkFile="../../../" + datajspname  + "/checkBookMark.jsp";
    String strFavouriteFile="../../../" + datajspname  + "/checkFavourite.jsp"; 

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>少儿-多集详情- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<link type="text/css" rel="stylesheet" href="../../css/dibbling.css" />
<style type="text/css">
<!--
	body{ background:url(../../images/bg-children03.jpg) no-repeat;}
-->
</style>
<%@ include file="../../base.jsp"%>
<%@ include file="../../../config/code.jsp"%>
<script type="text/javascript">

	//绑定影片具体信息
	<jsp:include page="<%=strFile%>">
		<jsp:param name="programCode" value="<%=programCode%>" /> 
		<jsp:param name="contentCode" value="<%=contentCode%>" /> 
		<jsp:param name="categoryCode" value="<%=categoryCode%>" /> 
		<jsp:param name="varName" value="vodInfoData" /> 
		<jsp:param name="isBug" value="1" />
	</jsp:include>


    //绑定页面右边三部影片
	<jsp:include page="<%=vodListFile%>">             
		<jsp:param name="categoryCode" value="<%=childrenMuchDetailRightCode%>"/> 
		<jsp:param name="varName" value="muchDetailVodList"/>
		<jsp:param name="fields" value="-1" /> 
		<jsp:param name="pageIndex" value="0" /> 
		<jsp:param name="pageSize" value="3" />
		<jsp:param name="isBug" value="1" />
	</jsp:include>
	
	
	//判断是否有收藏
	<jsp:include page="<%=strFavouriteFile%>">             
		<jsp:param name="programCode" value="<%=programCode%>" />
		<jsp:param name="categoryCode" value="<%=categoryCode%>"/> 
		<jsp:param name="varName" value="tempFavourite"/>
		<jsp:param name="favoriteType" value="VOD" />
	</jsp:include>
	<%
		Boolean  tempFavourite = new Boolean("False");
		if(request.getAttribute("tempFavourite")!=null){
			tempFavourite = (Boolean)request.getAttribute("tempFavourite");
		}
	%>
	var isfaved=<%=tempFavourite%>;

</script>

<script type="text/javascript">

var area0,area1,area2,area3;
var pageobj;
var areaid=0;
var indexid=0;
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
		}
	}
	
	area0 = AreaCreator(1,3,new Array(-1,-1,1,3),"area0_list_","className:item item_focus","className:item");
	area0.doms[1].domOkEvent=function()
	{
		if(!isfaved)
		{
			$("actionFrame").src="../iframe/spaceCollectAddIframe.jsp?programCode="+vodInfoData.programCode+"&favoriteType=VOD";
		}
		else
		{
			$("actionFrame").src="../iframe/spaceCollectDelIframe.jsp?programCode="+vodInfoData.programCode+"&favoriteType=VOD";
		}
		
	}
	area0.doms[2].domOkEvent=function()
	{
		var returnUrl=window.location.href;
		window.location.href="../vodPlayer/vodPlayer.jsp?ParentContentCode=<%=contentCode%>&programType=14&ParentProgramCode="+vodInfoData.programCode+"&programCode="+vodInfoData.programCode+"&contentCode="+vodInfoData.contentCode+"&returnUrl="+escape(returnUrl)+"&categoryCode="+vodInfoData.categoryCode+"&definition="+vodInfoData.definition;
    }
	area1 = AreaCreator(1,3,new Array(0,-1,2,3),"area1_list_","className:item item_focus","className:item");
    area1.areaOkEvent = function()
	{
		var vodLength = vodInfoData.subVodList.length;
		if((area1.curindex+1) != area1.datanum)
		{
		    area2.datanum = 30;
		}else
		{
			area2.datanum = (vodLength!=0&&vodLength%30==0)?30:vodLength%30;
		}
		for(i=0;i<30;i++)
		{
			$("area2_list_"+i).innerHTML = area1.curindex*30+(i+1)+"";
			if(i<area2.datanum)
			{
				$("area2_list_"+i).style.visibility = "visible";
			}else
			{
				$("area2_list_"+i).style.visibility = "hidden";
			}
		}
	}
	area2 = AreaCreator(3,10,new Array(1,-1,-1,3),"area2_list_","className:item item_focus","className:item");
    area2.areaOkEvent = function()
	{
		window.location.href = "../vodPlayer/vodPlayer.jsp?ParentContentCode=<%=contentCode%>&ParentProgramCode=<%=programCode%>&returnUrl="+escape(window.location.href)+"&totalSubVod="+vodInfoData.subVodList.length+"&programType=14&programCode="+vodInfoData.subVodList[area2.curindex].programCode+"&contentCode="+vodInfoData.subVodList[area2.curindex].contentCode+"&categoryCode="+vodInfoData.categoryCode+"&definition="+vodInfoData.definition;
	}
	
	area3 = AreaCreator(3,1,new Array(-1,0,-1,-1),"area3_list_","className:item item_focus","className:item");
	area3.areaOkEvent=function()
	{
		if(muchDetailVodList.vodDataList[area2.curindex].programType == 1)
		{
		    window.location.href = "children-single-detail.jsp?programCode="+muchDetailVodList.vodDataList[area2.curindex].programCode+"&contentCode="+muchDetailVodList.vodDataList[area2.curindex].contentCode+"&categoryCode="+muchDetailVodList.vodDataList[area2.curindex].categoryCode;				
		}else
		{
		    window.location.href = "children-much-detail.jsp?programCode="+muchDetailVodList.vodDataList[area0.curindex].programCode+"&contentCode="+muchDetailVodList.vodDataList[area0.curindex].contentCode+"&categoryCode="+muchDetailVodList.vodDataList[area0.curindex].categoryCode;			   
		}
	};	

	pageobj = new PageObj(0, 0, new Array(area0,area1,area2,area3));
	pageInit();
	pageobj.backurl = OperatorFocus.getLastReturn();
	

}

	function pageInit()
	{
		vodinfo();
		vodInit();
		if(!isfaved)
	    {
		    $("area0_list_1").innerHTML = "收藏";
	    }
	    else
	    {
		    $("area0_list_1").innerHTML = "移除收藏";
	    }
	};
	
	
	
    //绑定影片信息
	function vodinfo()
	{
		$("vodImage").src = vodInfoData.pictureList.poster;
		$("vodName").innerHTML = vodInfoData.name;
		$("vodPrice").innerHTML = vodInfoData.price;
		$("vodDirector").innerHTML = vodInfoData.directDisplay;
		$("vodActor").innerHTML = vodInfoData.actorDisplay;
		$("vodDetail").innerHTML = vodInfoData.description.length>80?(vodInfoData.description.substring(0,80)+"..."):vodInfoData.description;
	 	var vodLength = vodInfoData.subVodList.length;
		$("vodTotal").innerHTML = "共"+vodLength+"集";
	
		area1.datanum = Math.ceil(vodLength/30)==0?1:Math.ceil(vodLength/30);
		for(i=0;i<area1.datanum;i++)
		{
			$("area1_list_"+i).style.visibility = "visible";
		}
		area2.datanum = vodLength>30?30:vodLength;
		for(j=29;j>=area2.datanum;j--){
			$("area2_list_"+j).style.visibility = "hidden";
		}
		for(var i=0;i<3;i++)
		{
			if(vodLength>i*30&&vodLength<=30*(i+1))
			{
				$("area1_list_"+i).innerHTML=(i*30+1)+"-"+vodLength;
		    }
	    }
	
	
	}
	
	
	//绑定右边三部影片
	function vodInit()
	{
	   var muchDetailVodListlength = muchDetailVodList.vodDataList.length;
	   for(i=0;i<muchDetailVodListlength;i++)
	   {
		  $("area3_img_"+i).src = muchDetailVodList.vodDataList[i].pictureList.poster;
	   };	
    }
	
	//添加收藏
    function addCollect(resultstr)
	{
	   isfavsucc = parseInt(resultstr.result);
	   isdofav();
    }

    //删除收藏
    function delCollect(resultstr)
    {
	   isfavsucc = parseInt(resultstr.result);
	   dodelfav();
    }
	
	
	function isdofav()
	{
	     switch(isfavsucc){
			case 0:
						//	$("div_fav0").innerHTML = "添加收藏失败，请稍候再试";
				 break;
			case 1:
				isfaved = true;					
				$("area0_list_1").innerHTML = "移除收藏";
						//	$("div_fav0").innerHTML = "节目已成功加入收藏";
						//	isfavsucc = -1;
						//	pageobj.popups[1].showme();
				break;
			case 2:
						//	$("div_fav0").innerHTML = "收藏夹已满，请删除后重试";
						//	pageobj.popups[1].showme();
				break;
				default:
				break;
				} 	   
	 }
	
	function dodelfav()
	{
		switch(isfavsucc){
		   case 0:
				//	$("div_fav0").innerHTML = "移除收藏失败，请稍候再试";
			    break;
			case 1:
				isfaved = false;
				$("area0_list_1").innerHTML = "收藏";
					//pageobj.popups[1].showme();
					//isfavsucc = -1;
					//succ = -1;
					break;
			default:
					break;
		   }
	}



</script>
</head>
<body bgcolor="transparent">
<div class="wrapper">

	<!--head-->
	<div class="pic" style="left:47px; top:41px;"><img src="../../images/title-program.png" /></div>
	<!--head the end-->	
	
		
	
	<!--detail-->
	<div class="pic" style="left:54px; top:148px;"><img id="vodImage" src="" width="235" height="335" /></div>
	
		<div class="detail-font">
			<div class="txt txt01"><text id="vodName">猫和老鼠</text></div>
			<div class="txt txt02">售价：￥<span><text id="vodPrice">5</text></span>.0</div>
			<div class="txt txt03" style="top:50px;">导演：</div>
			<div class="txt txt04" style="top:50px;"><text id="vodDirector">沙恩·布莱克</text></div>
			<div class="txt txt03" style="top:86px;">主演：</div>
			<div class="txt txt04" style="top:86px;"><text id="vodActor">小罗伯特·唐尼 / 格温妮丝·帕特洛 / 唐·钱德尔  盖·皮尔斯 / 王学圻 / 范冰冰</text></div>
			<div class="txt txt05"><text id="vodDetail">剧情简介</text></div>
		</div>
		
		<!--btns-->
		<div class="page-b" style="left:542px; top:431px;">
			<!--焦点 
					class="item item_focus"
			-->
			<div class="item" id="area0_list_0">订&nbsp;购</div>
			<div class="item" style="left:135px;" id="area0_list_1">收&nbsp;藏</div>
			<div class="item" style="left:270px;" id="area0_list_2">书签播放</div>
		</div>
		
		<!--选集-->
		<div class="anthology-b">
			<div class="tv-sub-b">
				<!--焦点 
						class="item item_focus"
				-->
				<div class="item" style="visibility:hidden"  id="area1_list_0">1-30</div>
				<div class="item" style=" left:130px;visibility:hidden"  id="area1_list_1">31-60</div>
				<div class="item" style=" left:260px;visibility:hidden"  id="area1_list_2">61-70</div>
				<div class="txt txt-all" id="vodTotal">共76集</div>
			</div>
			<div class="tv-num06">
				<!--焦点 
						class="item item_focus"
				-->
				<div class="item" id="area2_list_0">1</div>
				<div class="item" style="left:55px;" id="area2_list_1">2</div>
				<div class="item" style="left:110px;" id="area2_list_2">3</div>
				<div class="item" style="left:165px;" id="area2_list_3">4</div>
				<div class="item" style="left:220px;" id="area2_list_4">5</div>
				<div class="item" style="left:275px;" id="area2_list_5">6</div>
				<div class="item" style="left:330px;" id="area2_list_6">7</div>
				<div class="item" style="left:385px;" id="area2_list_7">8</div>
				<div class="item" style="left:440px;" id="area2_list_8">9</div>
				<div class="item" style="left:495px;" id="area2_list_9">10</div>
				
				<div class="item" style="top:42px;" id="area2_list_10">11</div>
				<div class="item" style="left:55px;top:42px;" id="area2_list_11">12</div>
				<div class="item" style="left:110px;top:42px;" id="area2_list_12">13</div>
				<div class="item" style="left:165px;top:42px;" id="area2_list_13">14</div>
				<div class="item" style="left:220px;top:42px;" id="area2_list_14">15</div>
				<div class="item" style="left:275px;top:42px;" id="area2_list_15">16</div>
				<div class="item" style="left:330px;top:42px;" id="area2_list_16">17</div>
				<div class="item" style="left:385px;top:42px;" id="area2_list_17">18</div>
				<div class="item" style="left:440px;top:42px;" id="area2_list_18">19</div>
				<div class="item" style="left:495px;top:42px;" id="area2_list_19">20</div>
				
				<div class="item" style="top:84px;" id="area2_list_20">21</div>
				<div class="item" style="left:55px;top:84px;" id="area2_list_21">22</div>
				<div class="item" style="left:110px;top:84px;" id="area2_list_22">23</div>
				<div class="item" style="left:165px;top:84px;" id="area2_list_23">24</div>
				<div class="item" style="left:220px;top:84px;" id="area2_list_24">25</div>
				<div class="item" style="left:275px;top:84px;" id="area2_list_25">26</div>
				<div class="item" style="left:330px;top:84px;" id="area2_list_26">27</div>
				<div class="item" style="left:385px;top:84px;" id="area2_list_27">28</div>
				<div class="item" style="left:440px;top:84px;" id="area2_list_28">29</div>
				<div class="item" style="left:495px;top:84px;" id="area2_list_29">30</div>
			</div>
		</div>
	<!--detail the end-->
	
	
	
	<!--相关推荐 & r-->
	<div class="list-pic-y">
		<div class="txt txt-tit">相关推荐</div>
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" style="top:20px;" id="area3_list_0">
			<div class="link"></div>
			<div class="pic"><img id="area3_img_0" src="" /></div>
		</div>
		<div class="item" style="top:218px;"  id="area3_list_1">
			<div class="link"></div>
			<div class="pic"><img id="area3_img_1" src="" /></div>
		</div>
		<div class="item" style="top:416px;"  id="area3_list_2">
			<div class="link"></div>
			<div class="pic"><img id="area3_img_2" src="" /></div>
		</div>
	</div>
	
	<div class="cover-children"><img src="../../images/cover02.png" /></div>
	<!--相关推荐 & r the end-->	

	
</div>
	
</body>
</html>
