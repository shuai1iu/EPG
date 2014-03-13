<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<%

String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String strfile="../../../" + datajspname  + "/vodList.jsp";
String strFileCate="../../../" + datajspname  + "/categoryList.jsp";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>大体育- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<link type="text/css" rel="stylesheet" href="../../css/dibbling.css" />
<style type="text/css">
<!--
	body{ background:url(../../images/bg-sport01.jpg) no-repeat;}
-->
</style>
	<%@ include file="../../../util/servertime.jsp"%>
	<%@ include file="../../../config/code.jsp"%>
    <%@ include file="../../base.jsp"%>
    <script type="text/javascript">
	
		
		//顶部栏目
		<jsp:include page="<%=strFileCate%>">   
			<jsp:param name="parentCategoryCode" value="<%=largeSportsCatagoryCode%>" /> 
			<jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="8" /> 
			<jsp:param name="varName" value="largeSportsList" />
			<jsp:param name="fileds" value="-1" />
			<jsp:param name="isBug" value="1" />
		</jsp:include>
		
		//专题推荐
		<jsp:include page="<%=strfile%>">
			<jsp:param name="categoryCode" value="<%=largeSportsRecCode%>"/> 
			<jsp:param name="varName" value="recContentList"/>
			<jsp:param name="fields" value="-1" /> 
			<jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="3" />
			<jsp:param name="isBug" value="1" />
		</jsp:include>
		
		//本周最新
		<jsp:include page="<%=strfile%>">
			<jsp:param name="categoryCode" value="<%=largeSportsNewCode%>"/> 
			<jsp:param name="varName" value="newContentList"/>
			<jsp:param name="fields" value="-1" /> 
			<jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="7" />
			<jsp:param name="isBug" value="1" />
		</jsp:include>
		
	
		var area0,area1,area2;
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
			
			area0 = AreaCreator(1,8,new Array(-1,-1,1,-1),"area0_list_","className:item item_focus","className:item");
			for(var i=0;i<area0.doms.length;i++)
			{
				area0.doms[i].contentdom = $("area0_txt_"+i);
			} 
			area0.areaOkEvent = function(){
				var catagoryName=largeSportsList.categoryList[area0.curindex].name; 
				window.location.href="large-sports-list.jsp?parentCategoryCode="+largeSportsList.categoryList[area0.curindex].parentCategoryCode+"&catagoryName="+catagoryName;
			}
			area1 = AreaCreator(1,3,new Array(0,-1,2,-1),"area1_list_","className:item item_focus","className:item");
			area1.pagecount = (Math.ceil(recContentList.totalSize/3)==0?1:Math.ceil(recContentList.totalSize/3))>4?4:Math.ceil(recContentList.totalSize/3);
			area1.broadwiseCrossturnpage = true;
			area1.areaOkEvent = function(){
				window.location.href = "large-sports-detail.jsp?programCode="+recContentList.vodDataList[area0.curindex].programCode+"&contentCode="+recContentList.vodDataList[area0.curindex].contentCode+"&categoryCode="+recContentList.vodDataList[area0.curindex].categoryCode;
			}
			area1.areaPageTurnEvent = function(){
				$("recPageTurn").src = "<%=basePath%>jsp/defaulthdcctv/en_develop/scepg/epgPage/page/iframe/large-sportsIframe.jsp?catagoryCode=<%=largeSportsRecCode%>&pageIndex="+area1.curpage;
			}
			area2 = AreaCreator(1,7,new Array(1,-1,-1,-1),"area2_list_","className:item item_focus","className:item");
			for(var i=0;i<area2.doms.length;i++)
			{
				area2.doms[i].contentdom = $("area2_txt_"+i);
			}  
			area2.areaOkEvent = function(){
				window.location.href = "large-sports-detail.jsp";
			}
			pageobj = new PageObj(areaid, indexid,new Array(area0,area1,area2));
			pageobj.backurl = OperatorFocus.getLastReturn();
			pageobj.pageOkEvent=function()
			{
				OperatorFocus.saveFocstr(pageobj);
			};
			$("time").innerHTML = time2;
			pageInit();
		}
		
		function pageInit(){
			//栏目绑定
			var largeSportsList_Length = largeSportsList.categoryList.length;
			area0.datanum = largeSportsList_Length;
			if(largeSportsList_Length>0)
			{
				for(var i=0;i<8;i++)
				{
					if(i<largeSportsList_Length)
						area0.doms[i].setcontent("",largeSportsList.categoryList[i].name,7,true,false);
					else
						$("area0_txt_"+i).innerHTML = "";
			    };
			};	
			//专题推荐数据绑定
			var recContentList_Length = recContentList.vodDataList.length;
			if(recContentList_Length>0)
			{
				for(var i=0;i<recContentList_Length;i++)
				{
					$("area1_img_"+i).src = recContentList.vodDataList[i].pictureList.poster;
			   };
			};
			
			//最新推荐数据绑定
			var newContentList_Length = newContentList.vodDataList.length;
			if(newContentList_Length>0)
			{
				for(var i=0;i<newContentList_Length;i++)
				{
					area2.doms[i].setcontent("",newContentList.vodDataList[i].name,10,true,false);
					$("area2_img_"+i).src = newContentList.vodDataList[i].pictureList.poster;
			    };
			};	
		}
		
		function recTurnPageBind(recContentList1){
			//专题推荐翻页数据绑定
			var recContentList1_Length = recContentList1.vodDataList.length;
			area1.datanum = recContentList1_Length;
			if(recContentList1_Length>0)
			{
				for(var i=0;i<recContentList1_Length;i++)
				{
					$("area1_img_"+i).src = recContentList1.vodDataList[i].pictureList.poster;
			   };
			};
			
			for(j=0;j<4;j++){
				if((area1.curpage-1) != j)
					$("area1_page_"+j).className = "item";
				else
					$("area1_page_"+(area1.curpage-1)).className = "item item_focus";
			}
		}
	</script>
</head>

<body bgcolor="transparent">

<iframe src="" width="1px;" height="1px" id="recPageTurn"></iframe>

<div class="wrapper">

	<!--head-->
	<div class="txt txt-time02" id="time">15:30</div>
	<!--head the end-->	
	
	
	
	<!--menu-->
	<div class="menu-c">
		<!--焦点 
				class="item item_focus" 
		-->
		<div class="item" id="area0_list_0">
			<div class="txt" id="area0_txt_0"></div>
		</div>
		<div class="item" style="left:150px;" id="area0_list_1">
			<div class="txt" id="area0_txt_1"></div>
		</div>
		<div class="item" style="left:300px;" id="area0_list_2">
			<div class="txt" id="area0_txt_2"></div>
		</div>
		<div class="item" style="left:450px;" id="area0_list_3">
			<div class="txt" id="area0_txt_3"></div>
		</div>
		<div class="item" style="left:600px;" id="area0_list_4">
			<div class="txt" id="area0_txt_4"></div>
		</div>
		<div class="item" style="left:750px;" id="area0_list_5">
			<div class="txt" id="area0_txt_5"></div>
		</div>
		<div class="item" style="left:900px;" id="area0_list_6">
			<div class="txt" id="area0_txt_6"></div>
		</div>
		<div class="item" style="left:1050px;" id="area0_list_7">
			<div class="txt" id="area0_txt_7"></div>
		</div>
	</div>
	<!--menu the end-->		

	
	
	<!--专题推荐-->
	<div class="txt-title04">专题推荐</div>
	<div class="arrow-left">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item"></div>
	</div>
	<div class="list-pic-o">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area1_list_0">
			<div class="link"></div>
			<div class="pic"><img id="area1_img_0" src="" /></div>
		</div>
		<div class="item" style="left:398px;" id="area1_list_1">
			<div class="link"></div>
			<div class="pic"><img id="area1_img_1" src="" /></div>
		</div>
		<div class="item" style="left:796px;" id="area1_list_2">
			<div class="link"></div>
			<div class="pic"><img id="area1_img_2" src="" /></div>
		</div>
	</div>
	<div class="arrow-r">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item item_focus"></div>
	</div>
	
	<div class="point">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item item_focus" id="area1_page_0"></div>
		<div class="item" style="left:62px;" id="area1_page_1"></div>
		<div class="item" style="left:119px;" id="area1_page_2"></div>
		<div class="item" style="left:176px;" id="area1_page_3"></div>
	</div>
	<!--专题推荐 the end-->	
	
	
	
	<!--本周最新-->
	<div class="txt-title04" style="top:531px;">本周最新</div>
	<div class="arrow-left" style="top:603px;">
		<!--焦点 
				class="item item_focus"
		-->
		<!--<div class="item"></div>-->
	</div>
	<div class="list-pic-p">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area2_list_0">
			<div class="link"></div>
			<div class="pic"><img id="area2_img_0" src="" /></div>
			<div class="txt" id="area2_txt_0"></div>
		</div>
		<div class="item" style="left:170px;" id="area2_list_1">
			<div class="link"></div>
			<div class="pic"><img id="area2_img_1" src="" /></div>
			<div class="txt" id="area2_txt_1"></div>
		</div>
		<div class="item" style="left:340px;" id="area2_list_2">
			<div class="link"></div>
			<div class="pic"><img id="area2_img_2" src="" /></div>
			<div class="txt" id="area2_txt_2"></div>
		</div>
		<div class="item" style="left:510px;" id="area2_list_3">
			<div class="link"></div>
			<div class="pic"><img id="area2_img_3" src="" /></div>
			<div class="txt" id="area2_txt_3"></div>
		</div>
		<div class="item" style="left:680px;" id="area2_list_4">
			<div class="link"></div>
			<div class="pic"><img id="area2_img_4" src="" /></div>
			<div class="txt" id="area2_txt_4"></div>
		</div>
		<div class="item" style="left:850px;" id="area2_list_5">
			<div class="link"></div>
			<div class="pic"><img id="area2_img_5" src="" /></div>
			<div class="txt" id="area2_txt_5"></div>
		</div>
		<div class="item" style="left:1020px;" id="area2_list_6">
			<div class="link"></div>
			<div class="pic"><img id="area2_img_6" src="" /></div>
			<div class="txt" id="area2_txt_6"></div>
		</div>
	</div>
	<div class="arrow-r" style="top:603px;">
		<!--焦点 
				class="item item_focus"
		-->
		<!--<div class="item"></div>-->
	</div>
	<!--本周最新 the end-->	
	
</div>
	
</body>
</html>
