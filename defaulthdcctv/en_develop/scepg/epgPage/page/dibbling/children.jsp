<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<%
String vodListFile="../../../" + datajspname  + "/vodList.jsp";
String categoryListFile="../../../" + datajspname  + "/categoryList.jsp";
String parentCategoryCode=request.getParameter("parentCategoryCode")==null?"-1":request.getParameter("parentCategoryCode");  
String indexid=request.getParameter("curindex")==null?"0":request.getParameter("curindex");  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>少儿- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<link type="text/css" rel="stylesheet" href="../../css/dibbling.css" />
<style type="text/css">
<!--
	body{ background:url(../../images/bg-children.jpg) no-repeat;}
-->
</style>
<%@ include file="../../../util/servertime.jsp"%>
<%@ include file="../../../config/code.jsp"%>
<%@ include file="../../base.jsp"%>
<script type="text/javascript">
var dibblingTVVodName=null;
 //左边栏目列表
<jsp:include page="<%=categoryListFile%>">             
	<jsp:param name="parentCategoryCode" value="<%=parentCategoryCode%>" /> 
	<jsp:param name="pageIndex" value="1" /> 
	<jsp:param name="pageSize" value="9" /> 
	<jsp:param name="varName" value="dibblingTVCategoryName" />
</jsp:include>
			
function callVodListData(data)
{
	if(data!=null&&data!="")
	{
	   dibblingTVVodName=data;
	   initVodImage();	
	   $("recordPage").innerHTML = dibblingTVVodName.curPage+"/"+dibblingTVVodName.totalPage;
	   area1.pagecount = dibblingTVVodName.totalPage;	
	   area1.datanum=dibblingTVVodName.vodDataList.length;		
	}	
		
}

				
var area0,area1;	
var areaid = 0;
var indexid = parseInt("<%=indexid%>");
var area0curpage=1;
var area1curpage=1;
var drnessfocus=parseInt("<%=indexid%>");
var curCategoryList;
var curCategoryIndex=0;
var curCategoryPageIndex=1;
var curCategoryCode="";
var parentCategoryCode="<%=parentCategoryCode%>";
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
	    if(focusObj.focusdatas!=undefined && focusObj.focusdatas.length>1)
	    {
	
		    drnessfocus=focusObj.focusdatas[1].curindex;
		    curCategoryIndex=drnessfocus;
		    area0curpage=focusObj.focusdatas[1].curpage;
		    curCategoryPageIndex=area0curpage;
	    }
    }
	area0 = AreaCreator(6,1,new Array(-1,-1,-1,1),"area0_list_","className:item item_focus","className:item");		
	area0.setstaystyle("className:item",3);
	area0.setdarknessfocus(drnessfocus);
	for(var i=0;i<area0.doms.length;i++)
	{
	    area0.doms[i].contentdom = $("area0_txt_"+i);
	}			
//栏目点击事件
	area0.areaOkEvent=function()
	{
		var categoryCode=curCategoryList[area0.curindex].categoryCode;
		var dibTVCategoryIframe=$("dibTVImageIframe");
		curCategoryIndex=area0.curindex;
		curCategoryPageIndex=area0.curpage;
		curCategoryCode=categoryCode;
		area1.curpage=1;
		if(curCategoryCode=="<%=ChildrenProgCode%>")
		{
			 window.location.href="children-column.jsp?parentCategoryCode="+parentCategoryCode+"&categoryCode="+categoryCode+"&index="+curCategoryIndex;
			
		}else if(curCategoryCode=="<%=ChildrenSpeciaCode%>")
		{
			 window.location.href = "children-special-topic.jsp?parentCategoryCode="+parentCategoryCode+"&categoryCode="+categoryCode+"&index="+curCategoryIndex;
		}
		else
		{
			 dibTVCategoryIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+curCategoryCode;	
		}
		
	}		
	  
	area1 = AreaCreator(2,5,new Array(-1,0,-1,-1),"area1_list_","className:item item_focus","className:item");
	area1.areaOkEvent=function()
	{
		area0.curindex=curCategoryIndex;
		area0.curpage=curCategoryPageIndex;
		OperatorFocus.saveFocstr(pageobj);
		if(dibblingTVVodName.vodDataList[area1.curindex].programType == 1)
		{
			window.location.href = "children-single-detail.jsp?programCode="+dibblingTVVodName.vodDataList[area1.curindex].programCode+"&contentCode="+dibblingTVVodName.vodDataList[area1.curindex].contentCode+"&categoryCode="+dibblingTVVodName.vodDataList[area1.curindex].categoryCode;			
		}
		else
		{
			window.location.href = "children-much-detail.jsp?programCode="+dibblingTVVodName.vodDataList[area1.curindex].programCode+"&contentCode="+dibblingTVVodName.vodDataList[area1.curindex].contentCode+"&categoryCode="+dibblingTVVodName.vodDataList[area1.curindex].categoryCode;
		}
 
    }

	area1.endwiseCrossturnpage = true;	
	area1.curpage=area1curpage;
	area1.areaPageTurnEvent = function(num)
	{	
		var dibTVImageIframe=$("dibTVImageIframe");
		dibTVImageIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+curCategoryCode+"&curpage="+ area1.curpage;  
	};
    pageobj = new PageObj(areaid, indexid, new Array(area0,area1));

    pageobj.backurl = OperatorFocus.getLastReturn();
    pageInit();		
};

	function pageInit()
	{
	    //栏目绑定	
	    curCategoryList=getCategoryDataValue(area0.curpage);
	    binCategoryData(curCategoryList);
	    initVodSrc();//初始化图片请求iframe
	}

    //对栏目数据进行分页处理
	function getCategoryDataValue(currentPage)
	{
	    var length=dibblingTVCategoryName.categoryList.length;
	    var start = (currentPage-1)*9;
	    var end = (start+9);
	    if(end>=length)
		{
	        end=length;
	    }
	    var temptestList=new Array();
	    for(var i=start;i<end;i++)
	    {
			temptestList.push(dibblingTVCategoryName.categoryList[i]);
	    }
	    return temptestList;
    }

  //绑定栏目
   function binCategoryData(datavalue)
   {
	   area0.datanum=datavalue.length;
	   area0.setendwisepageturndata(area0.datanum,area0.pagecount);
	   for(i=0;i<9;i++)
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

  function initVodSrc()
  {
	  var categoryCode=curCategoryList[drnessfocus].categoryCode;	 
	  var dibTVCategoryIframe=$("dibTVImageIframe");
	  curCategoryCode=categoryCode;
	  dibTVCategoryIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+curCategoryCode+"&curpage="+area1.curpage;
  }

  //绑定影片列表
  function initVodImage()
  {
	  var tvLength=dibblingTVVodName.vodDataList.length;	
	  for(var i=0;i<tvLength;i++)
	  {		
		  var name= dibblingTVVodName.vodDataList[i].name;
		  $("area1_list_"+i).style.visibility="visible";
		  $("area1_txt_"+i).innerHTML = name.length>6?name.substr(0,6):name;	
		  $("area1_img_"+i).src = dibblingTVVodName.vodDataList[i].pictureList.poster;
	  };	
  
	  if(tvLength<10)
	  {
		  var domsLength=area1.doms.length;
		  for(var i=tvLength;i<domsLength;i++)
		  {
			  $("area1_list_"+i).style.visibility="hidden";			
		  }			
	  }
					
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
		<div class="item" style="top:60px;" id="area0_list_1">
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
		<div class="item" style="top:315px;" id="area0_list_5">
			<div class="txt" id="area0_txt_5"></div>
		</div>
		<div class="item" style="top:380px;" id="area0_list_6">
			<div class="txt" id="area0_txt_6"></div>
		</div>
		<div class="item" style="top:436px;" id="area0_list_7">
			<div class="txt" id="area0_txt_7"></div>
		</div>
		<div class="item" style="top:497px;" id="area0_list_8">
			<div class="txt" id="area0_txt_8"></div>
		</div>
	</div> 
	<!--nav the end-->
	
		
	
	<!--list-->
	<div class="list-pic-w">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area1_list_0">
			<div class="pic"><img id="area1_img_0" src="" /></div>
			<div class="txt" id="area1_txt_0"></div>
		</div>
		<div class="item" style="left:194px;" id="area1_list_1">
			<div class="pic"><img id="area1_img_1" src="" /></div>
			<div class="txt" id="area1_txt_1"></div>
		</div>  
		<div class="item" style="left:388px;" id="area1_list_2">
			<div class="pic"><img id="area1_img_2" src="" /></div>
			<div class="txt" id="area1_txt_2"></div>
		</div>
		<div class="item" style="left:582px;" id="area1_list_3">
			<div class="pic"><img id="area1_img_3" src="" /></div>
			<div class="txt" id="area1_txt_3"></div>
		</div>
		<div class="item" style="left:776px;" id="area1_list_4">
			<div class="pic"><img id="area1_img_4" src="" /></div>
			<div class="txt" id="area1_txt_4"></div>
		</div>
		
		<div class="item" style="top:277px;" id="area1_list_5">
			<div class="pic"><img id="area1_img_5" src="" /></div>
			<div class="txt" id="area1_txt_5"></div>
		</div>
		<div class="item" style="left:194px;top:277px;" id="area1_list_6">
			<div class="pic"><img id="area1_img_6" src="" /></div>
			<div class="txt" id="area1_txt_6"></div>
		</div>  
		<div class="item" style="left:388px;top:277px;" id="area1_list_7">
			<div class="pic"><img id="area1_img_7" src="" /></div>
			<div class="txt" id="area1_txt_7"></div>
		</div>
		<div class="item" style="left:582px;top:277px;" id="area1_list_8">
			<div class="pic"><img id="area1_img_8" src="" /></div>
			<div class="txt" id="area1_txt_8"></div>
		</div>
		<div class="item" style="left:776px;top:277px;" id="area1_list_9">
			<div class="pic"><img id="area1_img_9" src="" /></div>
			<div class="txt" id="area1_txt_9"></div>
		</div>
	</div>
	<!--list the end-->
	
	
	
	<!--pages-->
	<div class="pages-side03">
		<div class="btn"><img src="../../images/btn-ladybug.png" /></div>
		<div class="txt" id="recordPage">1/5</div>
	</div>
	<!--pages the end-->	
	<iframe id="dibTVImageIframe"  style="width:0px;height:0px;border:0px;" ></iframe> 
	
</div>
	
</body>
</html>
