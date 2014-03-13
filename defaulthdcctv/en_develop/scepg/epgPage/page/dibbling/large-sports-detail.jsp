<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>大体育 详情页- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<link type="text/css" rel="stylesheet" href="../../css/dibbling.css" />
<style type="text/css">
<!--
	body{ background:url(../../images/bg-sport03.jpg) no-repeat;}
-->
</style>
<%
String programCode = request.getParameter("programCode")==null?"-1":request.getParameter("programCode");
String contentCode = request.getParameter("contentCode")==null?"-1":request.getParameter("contentCode");
String categoryCode = request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode");
String strFile="../../../" + datajspname  + "/vodInfo.jsp";
String strFileVodList = "../../../" + datajspname  + "/vodList.jsp";
%>

	<%@ include file="../../../util/servertime.jsp"%>
	<%@ include file="../../../config/code.jsp"%>
    <%@ include file="../../base.jsp"%>
    <script type="text/javascript">
	
		<jsp:include page="<%=strFile%>">
			<jsp:param name="programCode" value="<%=programCode%>" /> 
			<jsp:param name="contentCode" value="<%=contentCode%>" />
			<jsp:param name="categoryCode" value="<%=categoryCode%>" />
			<jsp:param name="varName" value="vodInfoData" /> 
			<jsp:param name="isBug" value="1" />
		</jsp:include>
		
		//下侧推荐影片
		<jsp:include page="<%=strFileVodList%>">
			<jsp:param name="categoryCode" value="<%=bottomRecCode%>" /> 
			<jsp:param name="varName" value="bottomVodList" /> 
			<jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="5" />
			<jsp:param name="fields" value="-1" />
			<jsp:param name="isBug" value="1" />
		</jsp:include>
	
		var area0,area1;
		var areaid = 0;
		var indexid = 0;
		window.onload = function(){
			
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
			
			area0 = AreaCreator(1,6,new Array(-1,-1,1,-1),"area0_list_","className:item item_focus","className:item");
			area0.areaOkEvent = function(){
				window.location.href = "../vodPlayer/vodPlayer.jsp?ParentContentCode=<%=contentCode%>&ParentProgramCode=<%=programCode%>&returnUrl="+escape(window.location.href)+"&totalSubVod="+vodInfoData.subVodList.length+"&programType=14&programCode="+vodInfoData.subVodList[area0.curindex].programCode+"&contentCode="+vodInfoData.subVodList[area0.curindex].contentCode+"&categoryCode="+vodInfoData.categoryCode+"&definition="+vodInfoData.definition;
			}
			area1 = AreaCreator(1,5,new Array(0,-1,-1,-1),"area1_list_","className:item item_focus","className:item");
			for(var i=0;i<area1.doms.length;i++)
			{
				area1.doms[i].contentdom = $("area1_txt_"+i);
			}
			area1.areaOkEvent = function(){
				window.location.href = "large-sports-detail.jsp";
			}
			
			pageobj = new PageObj(areaid, indexid,new Array(area0,area1));
			pageobj.backurl = OperatorFocus.getLastReturn();
			pageobj.pageOkEvent=function()
			{
				OperatorFocus.saveFocstr(pageobj);
			};
			pageInit();
		}
		
		function pageInit(){
			//详情数据绑定
			$("poster").src = vodInfoData.pictureList.poster;
			var vodLength = vodInfoData.subVodList.length;
			area0.datanum = vodLength>6?6:(vodLength==0?1:vodLength);
			for(j=5;j>=area0.datanum;j--){
				$("area0_list_"+j).style.visibility = "hidden";
			}
			
	   
			//推荐位数据绑定
			var bottomVodList_Length = bottomVodList.vodDataList.length;
			if(bottomVodList_Length>0)
			{
				for(var i=0;i<bottomVodList_Length;i++)
				{
					area1.doms[i].setcontent("",bottomVodList.vodDataList[i].name,12,true,false);
					$("area1_img_"+i).src = bottomVodList.vodDataList[i].pictureList.poster;
			   };
			};
		}
	</script>
</head>

<body bgcolor="transparent">

<div class="wrapper">

	<!--head-->
	<div class="headline-shade">NBA</div>
	<div class="headline">NBA</div>
	<!--<div class="date">
		<div class="txt">05/27</div>
		<div class="txt txt-time" style="top:22px;">11:15</div>
	</div>-->
	<!--head the end-->


	
	<!--海报-->
	<div class="list-pic-r">
		<div class="pic"><img id="poster" src="../../images/demopic/pic-192X264.jpg" /></div>
	</div>
	<!--海报 the end-->
	
	
	<!--分集-->
	<div class="tv-num03">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area0_list_0">01</div>
		<div class="item" id="area0_list_1" style="left:68px;">02</div>
		<div class="item" id="area0_list_2" style="left:136px;">03</div>
		<div class="item" id="area0_list_3" style="left:204px;">04</div>
		<div class="item" id="area0_list_4" style="left:272px;">05</div>
		<div class="item" id="area0_list_5" style="left:340px;">06</div>
	</div>
	<!--分集 the end-->
	
	
	 <!--信息名称-->
	<div class="sports-name">
		<div class="txt">费城勇士队</div>
		<div class="txt" style="left:349px;">休斯顿小牛队</div>
	</div>
	<!--信息名称 the end-->
	
	
	
	<!--相关推荐-->
	<div class="txt-title04" style=" left:253px; top:407px; font-size:24px;">相关推荐</div>
	<div class="arrow-left" style=" left:224px; top:520px;">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item"></div>
	</div>
	<div class="list-pic-s">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area1_list_0">
			<div class="pic"><img id="area1_img_0" src="" /></div>
			<div class="txt" id="area1_txt_0"></div>
		</div>
		<div class="item" style="left:157px;" id="area1_list_1">
			<div class="pic"><img id="area1_img_1" src="" /></div>
			<div class="txt" id="area1_txt_1"></div>
		</div>
		<div class="item" style="left:314px;" id="area1_list_2">
			<div class="pic"><img id="area1_img_2" src="" /></div>
			<div class="txt" id="area1_txt_2"></div>
		</div>
		<div class="item" style="left:471px;" id="area1_list_3">
			<div class="pic"><img id="area1_img_3" src="" /></div>
			<div class="txt" id="area1_txt_3"></div>
		</div>
		<div class="item" style="left:628px;" id="area1_list_4">
			<div class="pic"><img id="area1_img_4" src="" /></div>
			<div class="txt" id="area1_txt_4"></div>
		</div>
	</div>
	<div class="arrow-r" style=" left:1041px; top:520px;">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item"></div>
	</div>
	<!--相关推荐 the end-->	
	
	
</div>
	
</body>
</html>
