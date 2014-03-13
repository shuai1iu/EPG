<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="../../../config/properties.jsp"%>
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
<title>少儿-单集详情- 四川央视概念版高清EPG4.0</title>
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
		<jsp:param name="categoryCode" value="<%=childrenSigDetailRightCode%>"/> 
		<jsp:param name="varName" value="singleDetailVodList"/>
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



</script>

<script type="text/javascript">

var area0,area1;
var pageobj;
var areaid = 0;
var indexid = 0;
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
	
	area0=AreaCreator(1, 3, new Array( - 1, -1, -1,  1), "area0_list_", "className:item item_focus", "className:item");
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
		window.location.href="../vodPlayer/vodPlayer.jsp?ParentContentCode=<%=contentCode%>&programType=1&ParentProgramCode="+vodInfoData.programCode+"&programCode="+vodInfoData.programCode+"&contentCode="+vodInfoData.contentCode+"&returnUrl="+escape(returnUrl)+"&categoryCode="+vodInfoData.categoryCode+"&definition="+vodInfoData.definition;
    }
	area1=AreaCreator(3, 1, new Array( - 1, 0, -1,  -1), "area1_list_", "className:item item_focus", "className:item");
    area1.areaOkEvent=function()
	{
		if(singleDetailVodList.vodDataList[area1.curindex].programType == 1)
		{
		    window.location.href = "children-single-detail.jsp?programCode="+singleDetailVodList.vodDataList[area1.curindex].programCode+"&contentCode="+singleDetailVodList.vodDataList[area2.curindex].contentCode+"&categoryCode="+singleDetailVodList.vodDataList[area2.curindex].categoryCode;				
		}else
		{
		    window.location.href = "children-much-detail.jsp?programCode="+singleDetailVodList.vodDataList[area1.curindex].programCode+"&contentCode="+singleDetailVodList.vodDataList[area0.curindex].contentCode+"&categoryCode="+singleDetailVodList.vodDataList[area0.curindex].categoryCode;			   
		}
	};	

	pageobj = new PageObj(areaid, indexid, new Array(area0,area1));
	pageobj.backurl = OperatorFocus.getLastReturn();
	pageInit();
	
}
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
		    $("area0_list_1").innerHTML = "收藏";
	    }
	    else
	    {
		    $("area0_list_1").innerHTML = "移除收藏";
	    }
	};
	
	
    //绑定右边三部影片
	function vodInit()
	{
	   var singleDetailVodListlength = singleDetailVodList.vodDataList.length;
	   for(i=0;i<singleDetailVodListlength;i++)
	   {
		  $("area1_img_"+i).src = singleDetailVodList.vodDataList[i].pictureList.poster;
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
			<div class="txt txt01"><text id="vodName">马达加斯加3</text></div>
			<div class="txt txt02">售价：￥<span><text id="vodPrice">5</text></span>.0</div>
			<div class="txt txt03" style="top:50px;">导演：</div>
			<div class="txt txt04" style="top:50px;"><text id="vodDirector">沙恩·布莱克</text></div>
			<div class="txt txt03" style="top:86px;">主演：</div>
			<div class="txt txt04" style="top:86px;"><text id="vodActor">小罗伯特·唐尼 / 格温妮丝·帕特洛 / 唐·钱德尔  盖·皮尔斯 / 王学圻 / 范冰冰</text></div>
			<div class="txt txt05"><text id="vodDetail">剧情简介:</text></div>
		</div>
		
		<!--btns-->
		<div class="page-b" style="left:438px; top:491px;">
			<!--焦点 
					class="item item_focus"
			-->
			<div class="item" id="area0_list_0">订&nbsp;购</div>
			<div class="item " style="left:135px;" id="area0_list_1">收&nbsp;藏</div>
			<div class="item" style="left:270px;" id="area0_list_2"><%if("false".equals(tempBookMark.get("IsBookMark").toString())){%>播放<%}else{%>书签播放<%}%></div>
		</div>
	<!--detail the end-->
	
	
	
	<!--相关推荐 & r-->
	<div class="list-pic-y">
		<div class="txt txt-tit">相关推荐</div>
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" style="top:20px;" id="area1_list_0">
			<div class="link"></div>
			<div class="pic"><img src=""  id="area1_img_0"/></div>
		</div>
		<div class="item" style="top:218px;"  id="area1_list_1">
			<div class="link"></div>
			<div class="pic"><img src=""  id="area1_img_1" /></div>
		</div>
		<div class="item" style="top:416px;"  id="area1_list_2">
			<div class="link"></div>
			<div class="pic"><img src=""   id="area1_img_2"/></div>
		</div>
	</div>
	
	<div class="cover-children"><img src="../../images/cover02.png" /></div>
	<!--相关推荐 & r the end-->	
	
	 <iframe id="actionFrame"  style="width:0px;height:0px;border:0px;" ></iframe>
</div>
	
</body>
</html>
