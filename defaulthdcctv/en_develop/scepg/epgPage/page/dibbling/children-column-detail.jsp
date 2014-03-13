<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<%
    String vodListFile="../../../" + datajspname  + "/vodList.jsp";
    String categoryListFile="../../../" + datajspname  + "/categoryList.jsp";
    String categoryCode=request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode");  
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>少儿-栏目详情- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<link type="text/css" rel="stylesheet" href="../../css/dibbling.css" />
<style type="text/css">
<!--
	body{ background:url(../../images/bg-children02.jpg) no-repeat;}
-->
</style>
<%@ include file="../../base.jsp"%>
<%@ include file="../../../config/code.jsp"%>
<script type="text/javascript">
//绑定左边影片的名称
	<jsp:include page="<%=vodListFile%>">             
		<jsp:param name="categoryCode" value="<%=categoryCode%>"/> 
		<jsp:param name="varName" value="chiDetLiftVodList"/>
		<jsp:param name="fields" value="-1" /> 
		<jsp:param name="pageIndex" value="1" /> 
		<jsp:param name="pageSize" value="-1" />
		<jsp:param name="isBug" value="1" />
	</jsp:include>

//绑定页面右边三部影片
	<jsp:include page="<%=vodListFile%>">             
		<jsp:param name="categoryCode" value="<%=childColDetailRightCode%>"/> 
		<jsp:param name="varName" value="childDetailVodList"/>
		<jsp:param name="fields" value="-1" /> 
		<jsp:param name="pageIndex" value="1" /> 
		<jsp:param name="pageSize" value="3" />
		<jsp:param name="isBug" value="1" />
	</jsp:include>

</script>
<script type="text/javascript">
var area0,area1,area2;
var pageobj;
var curpage=1;
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
			 curpage=focusObj.focusdatas[0].curpage;
		}
	}
	area0=AreaCreator(12, 1, new Array( - 1, -1, -1,  1), "area0_list_", "className:item item_focus", "className:item");
	area0.areaOkEvent=function()
	{	
		var index=(curpage-1)*12+area0.curindex;
	    if(chiDetLiftVodList.vodDataList[index].programType == 1)
		{
			window.location.href = "children-single-detail.jsp?programCode="+chiDetLiftVodList.vodDataList[index].programCode+"&contentCode="+chiDetLiftVodList.vodDataList[index].contentCode+"&categoryCode="+chiDetLiftVodList.vodDataList[index].categoryCode;			
		}
		else
		{
			window.location.href = "children-much-detail.jsp?programCode="+chiDetLiftVodList.vodDataList[index].programCode+"&contentCode="+chiDetLiftVodList.vodDataList[index].contentCode+"&categoryCode="+chiDetLiftVodList.vodDataList[index].categoryCode;
		}		
	}
	
	
	area1=AreaCreator(2, 1, new Array( - 1, 0, -1,  2), "area1_list_", "className:item item_focus", "className:item");
	
    area1.doms[0].domOkEvent=function()
	{
	    curpage--;
		if(curpage<1)
		{
			curpage=1;
			
		}
		area0.curindex=0;
		bindata(getDataValue(curpage));	
     }
	
    area1.doms[1].domOkEvent=function()
	{
		var pagecount=Math.ceil((childrenTVCategoryList.length/12));
	    curpage++;
		if(curpage>pagecount)
		{
			curpage=pagecount;
		}
		area0.curindex=0;
		bindata(getDataValue(curpage));	
    }
	area2=AreaCreator(3, 1, new Array( - 1, 1, -1,  -1), "area2_list_", "className:item item_focus", "className:item");
	area2.areaOkEvent=function()
	{
		if(childDetailVodList.vodDataList[area2.curindex].programType == 1)
		{
		    window.location.href = "children-single-detail.jsp?programCode="+childDetailVodList.vodDataList[area2.curindex].programCode+"&contentCode="+childDetailVodList.vodDataList[area2.curindex].contentCode+"&categoryCode="+childDetailVodList.vodDataList[area2.curindex].categoryCode;				
		}else
		{
		    window.location.href = "children-much-detail.jsp?programCode="+childDetailVodList.vodDataList[area0.curindex].programCode+"&contentCode="+childDetailVodList.vodDataList[area0.curindex].contentCode+"&categoryCode="+childDetailVodList.vodDataList[area0.curindex].categoryCode;			   
		}
	};		
	pageobj = new PageObj(areaid, indexid, new Array(area0,area1,area2));
	pageobj.backurl = OperatorFocus.getLastReturn();
	pageInit();
	
}
   function pageInit()
   {
	    bindata(getDataValue(curpage));
		vodInit();//右边相关影片推荐
   }
   


   //获取左边12条影片的名称		
    function getDataValue(currentPage)
	{
		var length=chiDetLiftVodList.vodDataList.length;		  
		var start=(currentPage-1)*12;
		var end=(start+12);
		if(end>=length)
		{   
			end=length;
		}
		var newList=new Array();
	    for(var i=start;i<end;i++)
		{
			newList.push(chiDetLiftVodList.vodDataList[i]);  
		}
			return newList;
	}
	
	//绑定左边栏目		
	function bindata(dataValue)
	{
		area0.datanum=dataValue.length;
		area0.setendwisepageturndata(area0.datanum,area0.pagecount);			   
	    for(i=0;i<12;i++)
		{
		   $("area0_list_"+i).innerHTML="";
		} 
		for (var j = 0; j< dataValue.length; j++)
		{
			if(dataValue[j] != null)
			{
				$("area0_list_"+j).innerHTML=dataValue[j].name;
			}
		}
			
    }
    //右边三部相关推荐
    function vodInit()
	{
	   var childDetailVodListLength = childDetailVodList.vodDataList.length;
	   for(i=0;i<childDetailVodListLength;i++)
	   {
		  $("area2_img_"+i).src = childDetailVodList.vodDataList[i].pictureList.poster;
	   };	
    }



</script>
</head>

<body bgcolor="transparent">
<div class="wrapper">

	<!--head-->
	<div class="pic" style="left:47px; top:41px;"><img src="../../images/title-column.png" /></div>
	<!--head the end-->	
	
		
	
	<!--detail-->
	<div class="pic" style="left:50px; top:144px;"><img src="../../images/demopic/pic-349X284.jpg" width="349" height="284" /></div>
	
		<!--list-->
		<div class="list-n">
			<!--焦点 
					class="item item_focus"
			-->
			<div class="item" id="area0_list_0">大耳朵图图（第一季）</div>
			<div class="item" style="top:45px;"  id="area0_list_1">大耳朵图图（第一季）</div>
			<div class="item" style="top:90px;"  id="area0_list_2">大耳朵图图（第一季）</div>
			<div class="item" style="top:135px;" id="area0_list_3">大耳朵图图（第一季）</div>
			<div class="item" style="top:180px;" id="area0_list_4">大耳朵图图（第一季）</div>
			<div class="item" style="top:225px;" id="area0_list_5">大耳朵图图（第一季）</div>
			<div class="item" style="top:270px;" id="area0_list_6">大耳朵图图（第一季）</div>
			<div class="item" style="top:315px;" id="area0_list_7">玩具总动员（第二季）</div>
			<div class="item" style="top:360px;" id="area0_list_8">大耳朵图图（第一季）</div>
			<div class="item" style="top:405px;" id="area0_list_9">喜羊羊与灰太狼（第二季）</div>
			<div class="item" style="top:450px;" id="area0_list_10">大耳朵图图（第一季）</div>
			<div class="item" style="top:495px;" id="area0_list_11">玩具总动员（第二季）</div>			
		</div>
		
		
		<!--btns-->
		<div class="page-b">
			<!--焦点 
					class="item item_focus"
			-->
			<div class="item" id="area1_list_0">上&nbsp;页</div>
			<div class="item" style="top:80px;" id="area1_list_1">下&nbsp;页</div>
		</div>
	<!--detail the end-->
	
	
	
	<!--相关推荐 & r-->
	<div class="list-pic-y">
		<div class="txt txt-tit">相关推荐</div>
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" style="top:20px;" id="area2_list_0">
			<div class="link"></div>
			<div class="pic"><img id="area2_img_0" src="../../images/demopic/pic-135X191.jpg" /></div>
		</div>
		<div class="item" style="top:218px;" id="area2_list_1">
			<div class="link"></div>
			<div class="pic"><img id="area2_img_1" src="../../images/demopic/pic-135X191.jpg" /></div>
		</div>
		<div class="item" style="top:416px;" id="area2_list_2">
			<div class="link"></div>
			<div class="pic"><img id="area2_img_2" src="../../images/demopic/pic-135X191.jpg" /></div>
		</div>
	</div>
	
	<div class="cover-children"><img src="../../images/cover02.png" /></div>
	<!--相关推荐 & r the end-->	
	
	
</div>
	
</body>
</html>
