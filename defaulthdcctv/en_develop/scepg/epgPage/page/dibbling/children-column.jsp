<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<%
    String strfile="../../../" + datajspname  + "/vodList.jsp";
	String categoryListFile="../../../" + datajspname  + "/categoryList.jsp";
	String parentCategoryCode=request.getParameter("parentCategoryCode")==null?"-1":request.getParameter("parentCategoryCode");  
	String index=request.getParameter("index")==null?"0":request.getParameter("index");  
    String categoryCode=request.getParameter("categoryCode")==null?"":request.getParameter("categoryCode");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>少儿-栏目- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<link type="text/css" rel="stylesheet" href="../../css/dibbling.css" />
<style type="text/css">
<!--
	body{ background:url(../../images/bg-children.jpg) no-repeat;}
-->
</style>
<%@ include file="../../../config/code.jsp"%>
<%@ include file="../../base.jsp"%>
<script type="text/javascript">
    var index=parseInt("<%=index%>");
	var categoryCode="<%=categoryCode%>";
	var parentCategoryCode="<%=parentCategoryCode%>";
	var childrenCategoryList=null;
    <jsp:include page="<%=categoryListFile%>">             
		<jsp:param name="parentCategoryCode" value="<%=parentCategoryCode%>" /> 
		<jsp:param name="pageIndex" value="1" /> 
		<jsp:param name="pageSize" value="-1" /> 
		<jsp:param name="varName" value="childrenTVCategoryList" />
		<jsp:param name="fileds" value="-1" />
		<jsp:param name="isBug" value="1" />
	</jsp:include>
	
   function callspecialData(data)
	{	
		if(data!=null&&data!="")
		{
			childrenCategoryList=data;
		    initRightCategory();	
		}		
    }

</script>
<script type="text/javascript">
var area0,area1;
var pageobj;
var areaid = 0;
var indexid = parseInt("<%=index%>");
var area1curpage=1;
var pageObj;
var drnessfocus=parseInt("<%=index%>");
var curCategoryList;
var curCategoryCode="";
window.onload=function()
{
     var focusObj=OperatorFocus.getCurFocusAndDelete();			
	 if(focusObj!=undefined && focusObj!="null" && focusObj!=null)
	 {
		 if(focusObj.focusdatas!=undefined && focusObj.focusdatas.length>0)
		 {
			 areaid=focusObj.focusdatas[0].areaid;
			 indexid=focusObj.focusdatas[0].curindex;
			 area1curpage=focusObj.focusdatas[0].curpage;
		 }
			
	 }

	area0=AreaCreator(9, 1, new Array( - 1, -1, -1,  1), "area0_list_", "className:item item_focus", "className:item");
	area0.setfocuscircle(0);
	for(var i=0;i<area0.doms.length;i++)
	{
	    area0.doms[i].contentdom = $("area0_txt_"+i);
	}
	area0.areaOkEvent=function()
	{
	    var categoryCode=childrenTVCategoryList.categoryList[area0.curindex].categoryCode;
		var childrenTVCategoryIframe=$("childrenTVImageIframe");
		area1.curpage=1;
		if(categoryCode=="<%=ChildrenProgCode%>")
		{
			 //跳转到少儿栏目
			 var index=area0.curindex;
			 window.location.href="children-column.jsp?parentCategoryCode="+parentCategoryCode+"&categoryCode="+categoryCode+"&index="+index;	 
		}
		if(categoryCode=="<%=ChildrenSpeciaCode%>")
		{
			 //跳转到精彩专题
			 var index=area0.curindex;
			  window.location.href = "children-special-topic.jsp?parentCategoryCode="+parentCategoryCode+"&categoryCode="+categoryCode+"&index="+index;
		}
		else
		{
			window.location.href="children.jsp?parentCategoryCode="+parentCategoryCode+"&indexid="+area0.curindex;	 
		}
		
    }
	area1=AreaCreator(2, 4, new Array( - 1, 0, -1,  -1), "area1_list_", "className:item item_focus", "className:item");
	area1.datanum=7;
	area1.areaOkEvent=function()
	{
		var categoryCode=childrenCategoryList.categoryList[area1.curindex].categoryCode;
		window.location.href="children-column-detail.jsp?categoryCode="+categoryCode;	
	}
    pageobj = new PageObj(areaid, indexid, new Array(area0,area1));
	pageobj.backurl = OperatorFocus.getLastReturn();
    pageInit();
}  
   
	function pageInit()
	{
		 curCategoryList=getCategoryData(area0.curpage);
		 bindCategorydata(curCategoryList);
		 initVodSrc();		
	}
	function initVodSrc()
	{
		var childrenTVImageIframe=$("childrenTVImageIframe");
		curCategoryCode=curCategoryList[drnessfocus].categoryCode;	 
		childrenTVImageIframe.src="../iframe/getSpecialCategoryFrame.jsp?categoryCode="+curCategoryCode+"&curpage="+area1.curpage+"&pageSize=7";
    }
	//绑定右侧栏目
	function initRightCategory()
	{
		var tvLength=childrenCategoryList.categoryList.length;
		for(var i=0;i<tvLength;i++)
		{		
		    $("area1_list_"+i).style.visibility="visible";
			area1.doms[i].setcontent("",childrenCategoryList.categoryList[i].name,12,true,false);
			$("area1_img_"+i).src = childrenCategoryList.categoryList[i].pictureList.poster;
		};	
		if(tvLength<7)
		{
		    var domsLength=area1.doms.length;
			for(var i=tvLength;i<domsLength;i++ )
			{
				$("area1_list_"+i).style.visibility="hidden";			
			}			
		}	
					  
	}
    //获取左边栏目
    function getCategoryData(currentPage)
    {
	    var length=childrenTVCategoryList.categoryList.length;		  
	    var start=(currentPage-1)*9;
	    var end=(start+9);
	    if(end>=length)
		{   
		   end=length;
		}
		var newList=new Array();
		for(var i=start;i<end;i++)
		{
			newList.push(childrenTVCategoryList.categoryList[i]);  
		}
			return newList;
    }
	//绑定左边栏目
	function bindCategorydata(dataValue)
	{
	    for(i=0;i<9;i++)
		{
		    $("area0_txt_"+i).innerHTML="";
		} 
		for (var j = 0; j< dataValue.length; j++)
		{
			if(dataValue[j] != null)
			{
				area0.doms[j].setcontent("",dataValue[j].name,10,true,false);
			}
		}			
	}
</script>
</head>

<body bgcolor="transparent">

<div class="wrapper">

	<!--nav-->
	<div class="nav-a">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area0_list_0">
			<div class="txt" id="area0_txt_0"></div>
		</div>   
		<div class="item" style="top:60px;"  id="area0_list_1">
			<div class="txt" id="area0_txt_1"></div>
		</div>
		<div class="item" style="top:126px;" id="area0_list_2">
			<div class="txt" id="area0_txt_2"></div>
		</div> 
		<div class="item" style="top:188px;" id="area0_list_3">
			<div class="txt" id="area0_txt_3"></div>
		</div>
		<div class="item" style="top:250px;" id="area0_list_4">
			<div class="txt" id="area0_txt_4"></div>
		</div>
		<div class="item " style="top:315px;" id="area0_list_5">
			<div class="txt" id="area0_txt_5"></div>
		</div>
		<div class="item" style="top:380px;"  id="area0_list_6">
			<div class="txt" id="area0_txt_6"></div>
		</div>
		<div class="item" style="top:436px;"  id="area0_list_7">
			<div class="txt" id="area0_txt_7"></div>
		</div>
		<div class="item" style="top:497px;"  id="area0_list_8">
			<div class="txt" id="area0_txt_8"></div>
		</div>
	</div> 
	<!--nav the end-->
	
		
	
	<!--list-->
	<div class="list-pic-z">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area1_list_0">
			<div class="pic-wrap">
				<div class="pic"><img src=""/></div>
			</div>
			<div class="txt-wrap txt-wrap01">
				<div class="txt" id="area1_txt_0"></div>
			</div>
		</div>
		<div class="item" style="left:237px;" id="area1_list_1">
			<div class="pic-wrap">
				<div class="pic"><img src="" id="area1_img_1"/></div>
			</div>
			<div class="txt-wrap txt-wrap02">
				<div class="txt" id="area1_txt_1"></div>
			</div>
		</div>
		<div class="item" style="left:474px;" id="area1_list_2">
			<div class="pic-wrap">
				<div class="pic"><img src=""  id="area1_img_2"/></div>
			</div>
			<div class="txt-wrap txt-wrap03">
				<div class="txt" id="area1_txt_2"></div>
			</div>
		</div>
	 	<div class="item" style="left:711px;" id="area1_list_3">
			<div class="pic-wrap">
				<div class="pic"><img src=""  id="area1_img_3"/></div>
			</div>
			<div class="txt-wrap txt-wrap04">
				<div class="txt" id="area1_txt_3"></div>
			</div>
		</div>
		<div class="item" style="top:286px;" id="area1_list_4">
			<div class="pic-wrap">
				<div class="pic"><img src="" id="area1_img_4"/></div>
			</div>
			<div class="txt-wrap txt-wrap05">
				<div class="txt" id="area1_txt_4"></div>
			</div>
		</div>
		<div class="item" style="left:237px;top:286px;" id="area1_list_5">
			<div class="pic-wrap">
				<div class="pic"><img src="" id="area1_img_5"/></div>
			</div>
			<div class="txt-wrap txt-wrap06">
				<div class="txt" id="area1_txt_5"></div>
			</div>
		</div>
		<div class="item" style="left:474px;top:286px;" id="area1_list_6">
			<div class="pic-wrap">
				<div class="pic"><img src="" id="area1_img_6" /></div>
			</div>
			<div class="txt-wrap txt-wrap07">
				<div class="txt" id="area1_txt_6">成长在线</div>
			</div>
		</div>
	</div>
	<!--list the end-->
	
	<iframe id="childrenTVImageIframe"  style="width:0px;height:0px;border:0px;" ></iframe> 
</div>
	
</body>
</html>
