<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../../../config/properties.jsp"%>
<%
String strFile="../../../" + datajspname  + "/vodInfo.jsp";
String vodListFile="../../../" + datajspname  + "/vodList.jsp";         
String programCode = request.getParameter("programCode")==null?"-1":request.getParameter("programCode");
String contentCode = request.getParameter("contentCode")==null?"-1":request.getParameter("contentCode");
String categoryCode = request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode");
String strBookMarkFile="../../../" + datajspname  + "/checkBookMark.jsp";
String strFavouriteFile="../../../" + datajspname  + "/checkFavourite.jsp";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>节目详情-单集- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<style type="text/css">
<!--
body{ background:url(../../images/bg-d03.jpg) no-repeat;}
-->
</style>
<%@ include file="../../../config/code.jsp"%>
<%@ include file="../../base.jsp"%>
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
		<jsp:param name="categoryCode" value="<%=detailSingleVodCode%>"/> 
		<jsp:param name="varName" value="detailSingleVodName"/>
		<jsp:param name="fields" value="-1" /> 
		<jsp:param name="pageIndex" value="0" /> 
		<jsp:param name="pageSize" value="3" />
		<jsp:param name="isBug" value="1" />
	</jsp:include>
	
	//判断是否有书签
	<jsp:include page="<%=strBookMarkFile%>">             
		<jsp:param name="categoryCode" value="<%=categoryCode%>"/> 
		<jsp:param name="programCode" value="<%=programCode%>" />  
		<jsp:param name="bookMarkType" value="VOD" />
		<jsp:param name="varName" value="tempBookMark"/>
	</jsp:include>
	<%
		JSONObject tempBookMark=new JSONObject();
		if(request.getAttribute("tempBookMark")!=null){
			tempBookMark = (JSONObject)request.getAttribute("tempBookMark");
		}
	%>
	
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
	var area0,area1;
	var pageobj;
	var areaid = 0;
	var indexid = 0;
	var programCode=getParameter("programCode");
	var isfavsucc = -1; //用于判断收藏是否添加成功 0.添加失败(添加接口失败) 1.添加成功 2.收藏夹已满
window.onload = function()
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
	area0 = AreaCreator(1,3,new Array(-1,-1,-1,1),"area0_list_","className:item item_focus","className:item");
	area0.doms[1].domOkEvent=function()
	{
		if(!isfaved)
		{  
		    //alert(1);
			$("actionFrame").src="../iframe/spaceCollectAddIframe.jsp?programCode="+vodInfoData.programCode+"&favoriteType=VOD";
		}
		else
		{
			$("actionFrame").src="../iframe/spaceCollectDelIframe.jsp?programCode="+vodInfoData.programCode+"&favoriteType=VOD";
		}
		
	}
	area0.doms[2].domOkEvent=function(){
			var returnUrl=window.location.href;
			window.location.href="../vodPlayer/vodPlayer.jsp?ParentContentCode=<%=contentCode%>&programType=1&ParentProgramCode="+vodInfoData.programCode+"&programCode="+vodInfoData.programCode+"&contentCode="+vodInfoData.contentCode+"&returnUrl="+escape(returnUrl)+"&categoryCode="+vodInfoData.categoryCode+"&definition="+vodInfoData.definition;
	}
	area1 = AreaCreator(3,1,new Array(-1,0,-1,-1),"area1_list_","className:item item_focus","className:item");
	area1.stablemoveindex = new Array(-1,"0-2,1-2,2-2",-1,-1);
	area1.areaOkEvent=function()
	{
		//事件  
		if(detailSingleVodName.vodDataList[area1.curindex].programType==1)
		{ 
			window.location.href = "detail-single.jsp?programCode="+detailSingleVodName.vodDataList[area1.curindex].programCode+"&contentCode="+detailSingleVodName.vodDataList[area1.curindex].contentCode+"&categoryCode="+detailSingleVodName.vodDataList[area1.curindex].categoryCode;
		}else
		{
			window.location.href = "detail-much.jsp?programCode="+detailSingleVodName.vodDataList[area1.curindex].programCode+"&contentCode="+detailSingleVodName.vodDataList[area1.curindex].contentCode+"&categoryCode="+detailSingleVodName.vodDataList[area1.curindex].categoryCode;
		}
	}	
	pageobj = new PageObj(areaid, indexid, new Array(area0,area1));
	pageobj.pageOkEvent=function(){
	   OperatorFocus.saveFocstr(pageobj);
	};
//	alert(OperatorFocus.getLastReturn());
	pageobj.backurl = OperatorFocus.getLastReturn();
	pageInit();
	};


function pageInit()
{
	$("vodImage").src = vodInfoData.pictureList.poster;
	$("vodName").innerHTML = vodInfoData.name;
	$("vodPrice").innerHTML = vodInfoData.price;
	$("vodDirector").innerHTML = vodInfoData.directDisplay;
	$("vodActor").innerHTML = vodInfoData.actorDisplay;
	$("vodDetail").innerHTML = vodInfoData.description.length>80?(vodInfoData.description.substring(0,80)+"..."):vodInfoData.description;
	vodInit();
	
	if(!isfaved)
	{
		$("menu0").innerHTML = "收藏";
	}
	else
	{
		$("menu0").innerHTML = "移除";
	}
} ;

function vodInit()
{
	//右上相关推荐
	var detailSingleVodNameLength = detailSingleVodName.vodDataList.length;
	for(i=0;i<detailSingleVodNameLength;i++)
	{
		$("area1_img_"+i).src = detailSingleVodName.vodDataList[i].pictureList.poster;
	};	
}
function getParameter(parameter)
{
	var url=window.location.search;
	var intUrl = url.indexOf("?"); 
	var urlRight = url.substr(intUrl + 1); 
	var arrTmp = urlRight.split("&"); 
	for(var i = 0; i < arrTmp.length; i++)
	{
	var arrTemp = arrTmp[i].split("="); 
		if(arrTemp[0] == parameter)
		{
			return arrTemp[1]; 
		 }
	}
return 0; 
}


//添加收藏
function addCollect(resultstr){
	  //alert(resultstr);
	isfavsucc = parseInt(resultstr.result);
	isdofav();
}

//删除收藏
function delCollect(resultstr){
	isfavsucc = parseInt(resultstr.result);
	dodelfav();
}

function isdofav(){
		   switch(isfavsucc){
					case 0:
					//	$("div_fav0").innerHTML = "添加收藏失败，请稍候再试";
						break;
					case 1:
						isfaved = true;					
						$("menu0").innerHTML = "移除";
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

function dodelfav(){
	   switch(isfavsucc){
			case 0:
			//	$("div_fav0").innerHTML = "移除收藏失败，请稍候再试";
				break;
			case 1:
				isfaved = false;
				$("menu0").innerHTML = "收藏";
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
<div class="headline-shade">节目详情</div>
<div class="headline">节目详情</div>
<!--head the end-->



<!--detail-->
<div class="detail">
<div class="pic pic-poster" ><img  id="vodImage" src="../../images/demopic/pic-269X385.jpg" /></div>
<div class="txt txt01"><text id="vodName"></text></div>
<div class="txt txt02" style="left:747px;">售价：￥<span><text id="vodPrice">5</text></span>.0</div>
<div class="txt txt03" style="top:50px;"><span>导演：</span><text id="vodDirector"></text> </div>
<div class="txt txt03" style="top:86px;"><span>主演：</span><text id="vodActor"></text></div>
<div class="pic" style="left: 296px;top:174px;"><img src="../../images/line.png" width="600" height="1" /></div>
<div class="txt txt03" style="top:185px;"><text id="vodDetail"></text></div>
</div>

<!--btns-->
<div class="btn-a">
<!--焦点 
class="item item_focus"
-->
<div class="item" id="area0_list_0">
<div class="icon"><img src="../../images/icon01.png" /></div>
<div class="txt">订购</div>
</div>
<div class="item" style="left:145px;" id="area0_list_1">
<div class="icon"><img src="../../images/icon02.png" /></div>
<div class="txt" id="menu0">收藏</div>
</div>
</div>
<div class="btn-b">
<!--焦点 
class="item item_focus"
不可点
class="item item_no"
-->
<div class="item item_no" id="area0_list_2">
<div class="icon"><img src="../../images/icon03.png" /></div>

<div class="txt"><%if("false".equals(tempBookMark.get("IsBookMark").toString())){%>播放<%}else{%>书签播放<%}%></div>
</div>
</div>
<div class="btn-c">
<!--焦点 
class="item item_focus"
-->
<!--<div class="item" id="area1_list_0">
<div class="txt">上集</div>
</div>
<div class="item" style="left:145px;" id="area1_list_1">
<div class="txt">下集</div>
</div>-->
</div>
<!--detail the end-->	


<!--相关推荐 & r-->
<div class="list-pic-g">
<div class="txt txt-tit">相关推荐</div>
<!--焦点 
class="item item_focus"
-->
<div class="item" id="area1_list_0">
<div class="pic"><img id="area1_img_0" src="../../images/demopic/pic-132X190.jpg" /></div>
</div>
<div class="item" style="top:260px;" id="area1_list_1">
<div class="pic"><img id="area1_img_1" src="../../images/demopic/pic-132X190.jpg" /></div>
</div>
<div class="item" style="top:480px;" id="area1_list_2">
<div class="pic"><img id="area1_img_2" src="../../images/demopic/pic-132X190.jpg" /></div>
</div>
<div class="cover"><img src="../../images/cover.png" /></div>
</div>

<div class="btn-e">
<!--焦点 
class="item item_focus"
-->
<div class="item">
<div class="btn btn-up"><!--向上--></div>
</div>
<div class="item item_focus" style="top:560px;">
<div class="btn btn-down"><!--向下--></div>
</div>
</div>
<!--相关推荐 & r the end-->	

</div>
 <iframe id="actionFrame"  style="width:0px;height:0px;border:0px;" ></iframe>

</body>
</html>
