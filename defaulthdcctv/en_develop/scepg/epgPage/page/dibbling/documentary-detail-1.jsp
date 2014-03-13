<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<%
String vodListFile="../../../" + datajspname  + "/vodList.jsp";
String categoryListFile="../../../" + datajspname  + "/categoryList.jsp";
String parentCategoryCode=request.getParameter("parentCategoryCode")==null?"-1":request.getParameter("parentCategoryCode");  
String indexid=request.getParameter("curindex")==null?"0":request.getParameter("curindex");  
String categoryName=request.getParameter("categoryName")==null?"":request.getParameter("categoryName");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>纪实 详情页（少剧集）- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<link type="text/css" rel="stylesheet" href="../../css/dibbling.css" />
<style type="text/css">
<!--
	body{ background:url(../../images/bg-doc05.jpg) no-repeat;}
-->
</style>
<%@ include file="../../base.jsp"%>
<script type="text/javascript">
	
	<jsp:include page="<%=categoryListFile%>">             
		<jsp:param name="parentCategoryCode" value="<%=parentCategoryCode%>" /> 
		<jsp:param name="pageIndex" value="1" /> 
		<jsp:param name="pageSize" value="-1" /> 
		<jsp:param name="varName" value="documentaryCategoryList" />
		<jsp:param name="fileds" value="-1" />
		<jsp:param name="isBug" value="1" />
	</jsp:include>
	
	var area0,area1,area2,area3,area4;
	var areaid = 0;
	var indexid = parseInt("<%=indexid%>");
	var area0curpage=1;
	var area1curpage=1;
	var drnessfocus=parseInt("<%=indexid%>");
	var curCategoryList;
	var curCategoryIndex=0;
	var curCategoryPageIndex=1;
	var curCategoryCode="";
	var documentaryContentData=null;
	var simpleOrMuch = false;
	window.onload = function(){
		window.focus();
		var focusObj=OperatorFocus.getCurFocusAndDelete();			
		if(focusObj!=undefined && focusObj!="null" && focusObj!=null)
		{
			if(focusObj.focusdatas!=undefined && focusObj.focusdatas.length>0)
			{
				areaid=focusObj.focusdatas[0].areaid;
				indexid=focusObj.focusdatas[0].curindex;
				area1curpage=focusObj.focusdatas[0].curpage;
			}
			if(focusObj.focusdatas!=undefined && focusObj.focusdatas.length>1)
			{
		
				drnessfocus=focusObj.focusdatas[1].curindex;
				curCategoryIndex=drnessfocus;
				area0curpage=focusObj.focusdatas[1].curpage;
				curCategoryPageIndex=area0curpage;
			}
		}
		
		area0 = AreaCreator(6,1,new Array(-1,-1,-1,1),"area0_list_","className:item item_focus","className:item");
		area0.darknessIndex = drnessfocus;
		area0.setCurSelectDomStyle("className:item item_focus","className:item item_select",3);
		area0.curpage=area0curpage;
		area0.pagecount = Math.ceil(( documentaryCategoryList.categoryList.length/6));	
		area0.endwiseCrossturnpage = true;
		area0.setendwisepageturnattention("pageUp","../../images/arrow-up.png","../../images/t.gif","pageDown","../../images/arrow-down.png","../../images/t.gif");
		for(var i=0;i<area0.doms.length;i++)
		{
			area0.doms[i].contentdom = $("area0_txt_"+i);
		}
		area0.areaPageTurnEvent = function(num)
		{
			curCategoryList=getCategoryDataValue(area0.curpage);
			binCategoryData(curCategoryList);
		};
	//栏目点击事件
		area0.areaOkEvent=function()
		{
			var categoryCode=curCategoryList[area0.curindex].categoryCode;
			var dibTVCategoryIframe=$("documentaryIframe");
			curCategoryIndex=area0.curindex;
			curCategoryPageIndex=area0.curpage;
			curCategoryCode=categoryCode;
			area1.curpage=1;
			if(area2.doms)
				area2.curpage = 1;
			dibTVCategoryIframe.src="../iframe/documentaryIframe.jsp?categoryCode="+curCategoryCode;	
		}
		
		pageInit();
		
			
			$("listSimple").style.visibility = "hidden";
			$("listMuch").style.visibility = "visible";
			area1 = AreaCreator(2,5,new Array(-1,0,2,-1),"area1_lists_","className:item item_focus","className:item");
			area1.areaOkEvent = function(){
				curCategoryList=getCategoryDataValue(area0.curpage);
				$("documentaryIframe").src = "../iframe/documentaryIframe.jsp?categoryCode="+curCategoryList[area0.curindex].categoryCode+"&pageSize=20&curpage="+(area1.curindex+1);

			}
			area2 = AreaCreator(7,1,new Array(1,0,3,-1),"area2_list_","className:item item_focus","className:item");
			area2.pagecount = 3;
			for(var i=0;i<area2.doms.length;i++){
				area2.doms[i].contentdom = $("area2_list_"+i);
			}
			area2.areaPageTurnEvent = function(num){
				var area2CurIndex = (area2.curpage-1)*7;
				for(i=0;i<7;i++){
					var tempArea2CurIndex = area2CurIndex+i;
					if(tempArea2CurIndex<documentaryContentData.vodDataList.length)
						area2.doms[i].setcontent("",documentaryContentData.vodDataList[tempArea2CurIndex].name,70,true,false);
					else
						area2.doms[i].setcontent("","",70,true,false);
				}
				area2.datanum = area2.curpage==area2.pagecount?documentaryContentData.vodDataList.length%7:7;
				$("page").innerHTML = area2.curpage+"/"+area2.pagecount;
			}
			area2.areaOkEvent = function(){
				area2.curpage = 1;
				var area2CurIndex = (area2.curpage-1)*7+area2.curindex;
				$("documentaryIframe").src = "../iframe/gotoPlayIframe.jsp?programCode="+documentaryContentData.vodDataList[area2CurIndex].programCode+"&contentCode="+documentaryContentData.vodDataList[area2CurIndex].contentCode+"&categoryCode="+documentaryContentData.vodDataList[area2CurIndex].categoryCode;	
			}
			area3 = AreaCreator(1,2,new Array(2,0,-1,-1),"area3_list_","className:item item_focus","className:item");
			area3.stablemoveindex = new Array("0-2>6,1-2>6",-1,-1,-1);
			area3.doms[0].domOkEvent = function(){
				area2.pageTurn(-1,2);
			}
			area3.doms[1].domOkEvent = function(){
				area2.pageTurn(1,2);
			}
			area4 = AreaCreator(2,11,new Array(-1,0,-1,-1),"area1_list_","className:item item_focus","className:item");
			area4.areaOkEvent = function(){
				$("documentaryIframe").src = "../iframe/gotoPlayIframe.jsp?programCode="+documentaryContentData.vodDataList[area1.curindex].programCode+"&contentCode="+documentaryContentData.vodDataList[area1.curindex].contentCode+"&categoryCode="+documentaryContentData.vodDataList[area1.curindex].categoryCode;	
			}
			area4.changefocusedEvent = function(){
				 $("filmTitle").innerHTML = documentaryContentData.vodDataList[area4.curindex].name;
				$("filmDescriiption").innerHTML = documentaryContentData.vodDataList[area4.curindex].description;	
			}
			pageobj = new PageObj(areaid,indexid,new Array(area0,area1,area2,area3,area4));
			pageobj.backurl = "documentary.jsp";
			pageobj.pageOkEvent=function()
			{
				OperatorFocus.saveFocstr(pageobj);
			};
			//pageInit();
	}
	
	 //对栏目数据进行分页处理
	function getCategoryDataValue(currentPage)
	{
	    var length=documentaryCategoryList.categoryList.length;
	    var start = (currentPage-1)*6;
	    var end = (start+6);
	    if(end>=length)
		{
	        end=length;
	    }
	    var temptestList=new Array();
	    for(var i=start;i<end;i++)
	    {
			temptestList.push(documentaryCategoryList.categoryList[i]);
	    }
	    return temptestList;
    }

  //绑定栏目
   function binCategoryData(datavalue)
   {
	   area0.datanum=datavalue.length;
	   area0.setendwisepageturndata(area0.datanum,area0.pagecount);
	   for(i=0;i<6;i++)
	   {
		   $("area0_txt_"+i).innerHTML="";
	   }
	   for (var j = 0; j< datavalue.length; j++)
	   {
		   if(datavalue[j] != null)
		   {
			   area0.doms[j].setcontent("",datavalue[j].name,8,true,false);
		   }
	   }
    }
	
	function callVodListData(data,categoryInfo)
	{
		if(data!=null&&data!=""&&categoryInfo!=null&&categoryInfo!=null)
		{
			documentaryContentData=data;
			if(documentaryContentData.totalSize>22){
				
				if(documentaryContentData.vodDataList.length == 22){
				   documentaryContentData.vodDataList.pop();
				   documentaryContentData.vodDataList.pop();
				}
			   simpleOrMuch = false;
			   if(area2.doms){
				   area0.directions = new Array(-1,-1,-1,1);
				   area2.pagecount = Math.ceil(documentaryContentData.vodDataList.length/7);
				   area2.datanum = area2.curpage==area2.pagecount?documentaryContentData.vodDataList.length%7:7;
				   for(i=0;i<7;i++){
					   if(i<area2.datanum)
					 	  area2.doms[i].setcontent("",documentaryContentData.vodDataList[i].name,70,true,false);
					   else
					   	  area2.doms[i].setcontent("","",70,true,false);
				   }
				    $("page").innerHTML = area2.curpage+"/"+area2.pagecount;
			   }else{
					for(i=0;i<7;i++){
						var filmTitleName = documentaryContentData.vodDataList[i].name;
						if(getbytelength(filmTitleName)>70){
							filmTitleName = getcutedstring(filmTitleName,70,false)
						}
						$("area2_list_"+i).innerHTML = filmTitleName;
					}   
			  		 $("page").innerHTML = area2.curpage+"/"+Math.ceil(documentaryContentData.vodDataList.lenth/7);
			   }
			   
			  
			   
			   area1.datanum = Math.ceil(documentaryContentData.totalSize/20);
				for(i=0;i<10;i++){
					if(documentaryContentData.totalSize>((i)*20))
						$("area1_lists_"+i).style.display = "block";
					else
						$("area1_lists_"+i).style.display = "none";
				}
				$("listSimple").style.visibility = "hidden";
			   $("listMuch").style.visibility = "visible";
			}else{
			   simpleOrMuch = true;
			   area0.directions = new Array(-1,-1,-1,4);
			   $("filmTitle").innerHTML = documentaryContentData.vodDataList[curCategoryIndex].name;
			   $("filmDescriiption").innerHTML = documentaryContentData.vodDataList[curCategoryIndex].description;
			   
			   area4.datanum = documentaryContentData.totalSize;
			   for(i=0;i<22;i++){
				   if(i<documentaryContentData.totalSize)
				   		$("area1_list_"+i).style.display = "block";
					else
						$("area1_list_"+i).style.display = "none";
			   }
			   $("listSimple").style.visibility = "visible";
			   $("listMuch").style.visibility = "hidden";
			}
			$("poster").src = categoryInfo.pictureList.poster;
			$("description").innerHTML = categoryInfo.description;
		}	
	}
	
	function gotoPlay(vodInfoData){
		var returnUrl=window.location.href;
		window.location.href="../vodPlayer/vodPlayer.jsp?ParentContentCode="+curContent[pageobj.curareaid].vodDataList[pageobj.areas[pageobj.curareaid].curindex].contentCode+"&programType=1&ParentProgramCode="+vodInfoData.programCode+"&programCode="+vodInfoData.programCode+"&contentCode="+vodInfoData.contentCode+"&returnUrl="+escape(returnUrl)+"&categoryCode="+vodInfoData.categoryCode+"&definition="+vodInfoData.definition;
	}
	
	function pageInit()
	{
	    curCategoryList=getCategoryDataValue(1);
	    binCategoryData(curCategoryList);
	    $("documentaryIframe").src = "../iframe/documentaryIframe.jsp?categoryCode="+curCategoryList[0].categoryCode;
		//window.location.href = "../iframe/documentaryIframe.jsp?categoryCode="+curCategoryList[area0.curindex].categoryCode;
	}

</script>
</head>

<body bgcolor="transparent">

<iframe id="documentaryIframe"  width="1px;" height="1px;" src=""></iframe> 

<div class="wrapper">

	<!--head-->
	<div class="headline" style="color:#dcdcdc;">历史秘闻</div>
	<!--head the end-->

	
	<!--nav-->
	<div class="btn" style="left:103px; top:126px;"><img id="pageUp" src="../../images/arrow-up.png" alt="向上" /></div>
	<div class="nav">
		<!--焦点 
				class="item item_focus"
			选中
				class="item item_select"
		-->
		<div class="item" id="area0_list_0">
			<div class="txt" id="area0_txt_0"></div>
			<div class="icon"></div>
		</div>   
		<div class="item" style="top:70px;" id="area0_list_1">
			<div class="txt" id="area0_txt_1"></div>
			<div class="icon"></div>
		</div>
		<div class="item" style="top:140px;" id="area0_list_2">
			<div class="txt" id="area0_txt_2"></div>
			<div class="icon"></div>
		</div> 
		<div class="item" style="top:210px;" id="area0_list_3">
			<div class="txt" id="area0_txt_3"></div>
			<div class="icon"></div>
		</div>
		<div class="item" style="top:280px;" id="area0_list_4">
			<div class="txt" id="area0_txt_4"></div>
			<div class="icon"></div>
		</div>
		<div class="item" style="top:350px;" id="area0_list_5">
			<div class="txt" id="area0_txt_5"></div>
			<div class="icon"></div>
		</div>
	</div> 
	<div class="btn" style="left:103px; top:594px;"><img id="pageDown" src="../../images/arrow-down.png" alt="向下" /></div>
	<!--nav the end-->
	
	
	
	<!--intro-->
	<div class="doc-intro">
		<div class="pic"><img id="poster" src="" /></div>
		<div class="txt" id="description"></div>	
	</div>
	<!--intro the end-->
	
	<div id="listSimple" style="visibility:visible;">
	
	<!--分集-->
	<div class="tv-num04">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area1_list_0">1</div>
		<div class="item" style="left:66px;" id="area1_list_1">2</div>
		<div class="item" style="left:132px;" id="area1_list_2">3</div>
		<div class="item" style="left:198px;" id="area1_list_3">4</div>
		<div class="item" style="left:264px;" id="area1_list_4">5</div>
		<div class="item" style="left:330px;" id="area1_list_5">6</div>
		<div class="item" style="left:396px;" id="area1_list_6">7</div>
		<div class="item" style="left:462px;" id="area1_list_7">8</div>
		<div class="item" style="left:528px;" id="area1_list_8">9</div>
		<div class="item" style="left:594px;" id="area1_list_9">10</div>
		<div class="item" style="left:660px;" id="area1_list_10">11</div>
		
		<div class="item" style="top:69px;" id="area1_list_11">12</div>
		<div class="item" style="left:66px;top:69px;" id="area1_list_12">13</div>
		<div class="item" style="left:132px;top:69px;" id="area1_list_13">14</div>
		<div class="item" style="left:198px;top:69px;" id="area1_list_14">15</div>
		<div class="item" style="left:264px;top:69px;" id="area1_list_15">16</div>
		<div class="item" style="left:330px;top:69px;" id="area1_list_16">17</div>
		<div class="item" style="left:396px;top:69px;" id="area1_list_17">18</div>
		<div class="item" style="left:462px;top:69px;" id="area1_list_18">19</div>
		<div class="item" style="left:528px;top:69px;" id="area1_list_19">20</div>
		<div class="item" style="left:594px;top:69px;" id="area1_list_20">21</div>
		<div class="item" style="left:660px;top:69px;" id="area1_list_21">22</div>
	</div>
	<!--分集 the end-->
	
	
	
	<!--intro-->
	<div class="doc-intro02">
		<div class="txt txt-tit" id="filmTitle"></div>
		<div class="txt txt-con" id="filmDescriiption"></div>
	</div>
	<!--intro the end-->
	
    </div>
    
    <div id="listMuch" style="visibility:hidden;">
    
    <!--分集-->
	<div class="tv-num05">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area1_lists_0">1-20</div>
		<div class="item" style="left:145px;" id="area1_lists_1">21-40</div>
		<div class="item" style="left:290px;" id="area1_lists_2">41-60</div>
		<div class="item" style="left:445px;" id="area1_lists_3">61-80</div>
		<div class="item" style="left:590px;" id="area1_lists_4">81-100</div>
		
		<div class="item" style="top:70px;" id="area1_lists_5">101-120</div>
		<div class="item" style="left:145px;top:70px;" id="area1_lists_6">121-140</div>
		<div class="item" style="left:290px;top:70px;" id="area1_lists_7">141-160</div>
		<div class="item" style="left:445px;top:70px;" id="area1_lists_8">161-180</div>
		<div class="item" style="left:590px;top:70px;" id="area1_lists_9">181-200</div>
	</div>
	<!--分集 the end-->
	
	
	
	<!--list-->
	<div class="list-m">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area2_list_0"></div>
		<div class="item" style="top:50px;" id="area2_list_1"></div>
		<div class="item" style="top:100px;" id="area2_list_2"></div>
		<div class="item" style="top:150px;" id="area2_list_3"></div>
		<div class="item" style="top:200px;" id="area2_list_4"></div>
		<div class="item" style="top:250px;" id="area2_list_5"></div>
		<div class="item" style="top:300px;" id="area2_list_6"></div>
	</div>
	<!--list the end-->
	
	
	
	<!--pages-->
	<div class="page-a">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area3_list_0">上页</div>
		<div class="txt" style="left:75px;" id="page">1/3</div>
		<div class="item" style="left:111px;" id="area3_list_1">下页</div>
	</div>
	<!--pages the end-->
	</div>
</div>
	
</body>
</html>
