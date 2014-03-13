<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<%
String vodListFile="../../../" + datajspname  + "/vodList.jsp";
String strFileCate="../../../" + datajspname  + "/categoryList.jsp";

String strFile="../../../" + datajspname  + "/vodInfo.jsp";
String JP_TYPE_ID="10000100000000090000000000009279,10000100000000090000000000005118,10000100000000090000000000009428,10000100000000090000000000006303,10000100000000090000000000010775,10000100000000090000000000008270";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>娱乐时尚- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<style type="text/css">
<!--
	body{ background:url(../../images/bg-d06.jpg) no-repeat;}
-->
</style>
<%@ include file="../../../util/servertime.jsp"%>
<%@ include file="../../../config/code.jsp"%>
<%@ include file="../../base.jsp"%>
<script type="text/javascript" src="../../js/pagecontrol_1.0.4.js"></script>
<script type="text/javascript">
        //左边新闻专题(area0)
	  	<jsp:include page="<%=vodListFile%>">   
		    <jsp:param name="categoryCode" value="<%=entTamentleftCode%>"/> 
			<jsp:param name="varName" value="enterTMCatgLiftList"/>
			<jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="4" />
			<jsp:param name="fields" value="-1" /> 
			<jsp:param name="isBug" value="1" />
		</jsp:include>
		
		 //中间上三栏目(area1)
		<jsp:include page="<%=strFileCate%>">   
			<jsp:param name="parentCategoryCode" value="<%=entTamentCenterUpCode%>" /> 
			<jsp:param name="pageIndex" value="1" />
			<jsp:param name="pageSize" value="3" />
			<jsp:param name="varName" value="enterTMCatgCenterUpList" />
			<jsp:param name="fileds" value="-1" />
			<jsp:param name="isBug" value="1" />
		</jsp:include>
		
		//中间中三部影片 根据栏目code取影片然后直接播放(area2)
		<jsp:include page="<%=vodListFile%>">             
				<jsp:param name="categoryCode" value="<%=entTamentCenterCode%>"/> 
				<jsp:param name="varName" value="enterTMCatgCenterList"/>
				<jsp:param name="pageIndex" value="1" /> 
				<jsp:param name="pageSize" value="3" />
				<jsp:param name="fields" value="-1" /> 
				<jsp:param name="isBug" value="1" />
		</jsp:include>
		
		//中间最下面栏目(area3)
		<jsp:include page="<%=strFileCate%>">   
			<jsp:param name="parentCategoryCode" value="<%=entTamentCenterDownCode%>" /> 
			<jsp:param name="pageIndex" value="1" />
			<jsp:param name="pageSize" value="10" />
			<jsp:param name="varName" value="enterTMCatgCenterDownList" />
			<jsp:param name="fileds" value="-1" />
			<jsp:param name="isBug" value="1" />
		</jsp:include>
		
		
	   //右边MV(area4)
		<jsp:include page="<%=vodListFile%>">             
				<jsp:param name="categoryCode" value="<%=entTamentRightUpCode%>"/> 
				<jsp:param name="varName" value="enterTMCatgRightUpList"/>
				<jsp:param name="pageIndex" value="1" /> 
				<jsp:param name="pageSize" value="1" />
				<jsp:param name="fields" value="-1" /> 
				<jsp:param name="isBug" value="1" />
		</jsp:include>
		
		//右边综艺TOP榜(area5)
		
		<jsp:include page="<%=vodListFile%>">   
		    <jsp:param name="categoryCode" value="<%=entTamentRightDownCode%>"/> 
			<jsp:param name="varName" value="enterTMCatgRightDownList"/>
			<jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="5" />
			<jsp:param name="fields" value="-1" /> 
			<jsp:param name="isBug" value="1" />
		</jsp:include>
		
		
</script>

<script type="text/javascript">
var area0,area1,area2,area3,area4,area5,area6,area7;
var pageobj;
var area7Data=["新闻频道","高清视场","电影天地","电视剧场","娱乐时尚","金色童年","法治空间","科教记录","第一体育","财经视界","健康生活"];
var bibblingCenterImage=new Array();
var areaid = 0;
var indexid = 0;
var area7page=1;
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
			area7page=focusObj.focusdatas[0].curpage;
		}
	}
	area0 = AreaCreator(4,1,new Array(-1,6,-1,1),"area0_list_","className:item item_focus","className:item");
	area0.setfocuscircle(0);
	for(i=0;i<area0.doms.length;i++)
	{
		area0.doms[i].contentdom = $("area0_txt_"+i);
    }
	area0.areaOkEvent=function()
	{  
	    if(enterTMCatgLiftList.vodDataList[area0.curindex].programType == 1)
		{
			window.location.href = "detail-single.jsp?programCode="+enterTMCatgLiftList.vodDataList[area0.curindex].programCode+"&contentCode="+enterTMCatgLiftList.vodDataList[area0.curindex].contentCode+"&categoryCode="+enterTMCatgLiftList.vodDataList[area0.curindex].categoryCode;			
		}
		else
		{
			window.location.href = "detail-much.jsp?programCode="+enterTMCatgLiftList.vodDataList[area0.curindex].programCode+"&contentCode="+enterTMCatgLiftList.vodDataList[area0.curindex].contentCode+"&categoryCode="+enterTMCatgLiftList.vodDataList[area0.curindex].categoryCode;
		}
	}
	area0.areaInedEvent = function()
	{
		clearTimeout(t);
		$("menu_a").style.visibility = "hidden";
		$("menu_b").style.visibility = "hidden";
		pageobj.curareaid = 0;
		pageobj.areas[0].changefocus(area0.curindex,true);
	};
    area1 = AreaCreator(1,3,new Array(-1,0,2,4),"area1_list_","className:item item_focus","className:item");
	for(i=0;i<area1.doms.length;i++)
	{
		area1.doms[i].contentdom = $("area1_txt_"+i);
    }
	area1.changefocusedEvent=function()
	{		
		$("themeImage").src=enterTMCatgCenterUpList.categoryList[area1.curindex].pictureList.poster;
	}
	area2 = AreaCreator(1,3,new Array(1,0,3,4),"area2_list_","className:item item_focus","className:item");
	for(i=0;i<area2.doms.length;i++)
	{
		area2.doms[i].contentdom = $("area2_txt_"+i);
    }
	area2.areaOkEvent=function()
	{
	    if(enterTMCatgCenterList.vodDataList[area2.curindex].programType == 1)
		{
			window.location.href = "detail-single.jsp?programCode="+enterTMCatgCenterList.vodDataList[area2.curindex].programCode+"&contentCode="+enterTMCatgCenterList.vodDataList[area2.curindex].contentCode+"&categoryCode="+enterTMCatgCenterList.vodDataList[area2.curindex].categoryCode;			
		}
		else
		{
			window.location.href = "detail-much.jsp?programCode="+enterTMCatgCenterList.vodDataList[area2.curindex].programCode+"&contentCode="+enterTMCatgCenterList.vodDataList[area2.curindex].contentCode+"&categoryCode="+enterTMCatgCenterList.vodDataList[area2.curindex].categoryCode;
		}
      
	}
    area3 = AreaCreator(2,5,new Array(2,0,-1,5),"area3_list_","className:item item_focus","className:item");
	area3.areaOkEvent=function()
	{
		 var  parentCategoryCode=enterTMCatgCenterDownList.categoryList[area3.curindex].parentCategoryCode;
	     var categoryCode=enterTMCatgCenterDownList.categoryList[area3.curindex].categoryCode;
	     var categoryName=enterTMCatgCenterDownList.categoryList[area3.curindex].name;
		 if(categoryCode=="10000100000000090000000000006783"||categoryCode=="10000100000000090000000000003089"||categoryCode=="00000100000000090000000000001689")
		 {
			 window.location.href="dibbling-tv.jsp?parentCategoryCode="+parentCategoryCode+"&categoryName="+categoryName+"&curindex="+area3.curindex; 
		 }else
		 {
			 window.location.href="dibbling-top.jsp?categoryCode="+categoryCode+"&categoryName="+categoryName;		 
		 }
	}		
	
	area4 = AreaCreator(1,1,new Array(-1,1,5,-1),"area4_list_","className:item item_focus","className:item");
	area4.areaOkEvent=function()
	{
	    if(enterTMCatgRightUpList.vodDataList[area4.curindex].programType == 1)
		{
			window.location.href = "detail-single.jsp?programCode="+enterTMCatgRightUpList.vodDataList[area4.curindex].programCode+"&contentCode="+enterTMCatgRightUpList.vodDataList[area4.curindex].contentCode+"&categoryCode="+enterTMCatgRightUpList.vodDataList[area4.curindex].categoryCode;			
		}
		else
		{
			window.location.href = "detail-much.jsp?programCode="+enterTMCatgRightUpList.vodDataList[area4.curindex].programCode+"&contentCode="+enterTMCatgRightUpList.vodDataList[area4.curindex].contentCode+"&categoryCode="+enterTMCatgRightUpList.vodDataList[area4.curindex].categoryCode;
		}
	
	
	}
	
	area5 = AreaCreator(5,1,new Array(4,2,-1,-1),"area5_list_","className:item item_focus","className:item");
	area5.areaOkEvent=function()
	{
	    if(enterTMCatgRightDownList.vodDataList[area5.curindex].programType == 1)
		{
			window.location.href = "detail-single.jsp?programCode="+enterTMCatgRightDownList.vodDataList[area5.curindex].programCode+"&contentCode="+enterTMCatgRightDownList.vodDataList[area5.curindex].contentCode+"&categoryCode="+enterTMCatgRightDownList.vodDataList[area5.curindex].categoryCode;			
		}
		else
		{
			window.location.href = "detail-much.jsp?programCode="+enterTMCatgRightDownList.vodDataList[area5.curindex].programCode+"&contentCode="+enterTMCatgRightDownList.vodDataList[area5.curindex].contentCode+"&categoryCode="+enterTMCatgRightDownList.vodDataList[area5.curindex].categoryCode;
		}
	
	
	}
	area6 = AreaCreator(9,1,new Array(-1,-1,-1,0),"area6_list_","className:item item_focus","className:item");
	area6.areaIningEvent = function()
	{
	    $("menu_a").style.visibility = "visible";
		$("area6_list_2").className = "item";
		area6.doms[2].unfocusstyle = new Array("className:item");
	};
	area6.doms[0].domOkEvent=function()
	{

		window.location.href = "../index/index.jsp";
	};
	area6.doms[1].domOkEvent=function()
	{	
		 window.location.href="../channel/channel.jsp";	
	};
	area6.doms[2].domOkEvent=function()
	{
		$("menu_b").style.visibility = "visible";
		area6.directions = new Array(-1,-1,-1,7);
		area6.doms[2].unfocusstyle = new Array("className:item item_select");
	}
	area6.doms[3].domOkEvent = function()
	{
		window.location.href = "../space/special-topic.jsp";
	}
	area6.doms[4].domOkEvent = function()
    {
	   window.location.href = "../../../../vod_JPTypeList.jsp?TYPE_ID="+"<%=JP_TYPE_ID%>";
    }
    area6.doms[5].domOkEvent = function()
    {
	   window.location.href = "../../../../pkit_local/indexpkit.jsp";

    }
	area6.doms[6].domOkEvent = function()
	{
		window.location.href = "../space/space.jsp?";	
	}
	area6.doms[8].domOkEvent = function()
	{
		window.location.href = "../space/space.jsp?index=3";	
	}
	
	
	
	area6.changefocusedEvent = function()
	{
		clearTimeout(t);
		t = setTimeout("hideDiv()",5000);
	}
	area7 = AreaCreator(8,1,new Array(-1,6,-1,-1),"area7_list_","className:item item_focus","className:item");
	for(var i=0;i<area7.doms.length;i++)
	{
		area7.doms[i].contentdom = $("area7_txt_"+i);
    }	
    area7.areaOutedEvent = function()
	{
		$("menu_b").style.visibility = "hidden";
		area6.directions = new Array(-1,-1,-1,0);
	};
	area7.pagecount = Math.ceil((area7Data.length/8));
	area7.endwiseCrossturnpage = true;
	if(area7page==2)
	area7.curpage=area7page;
	area7.areaPageTurnEvent = function(num)
	{
		bindata(getDataValue(area7.curpage));		 
	};
	area7.doms[0].domOkEvent=function()
	{
		if(area7.curpage==2)
		{
			window.location.href="large-sports.jsp";
		}else
		{
			window.location.href="news.jsp";	
		}
		
	}
	area7.doms[1].domOkEvent=function()
	{
		if(area7.curpage==2)
		{
			window.location.href="economics.jsp";
		}else
		{
			var categoryName=area7Data[1];
		   window.location.href="dibbling-tv.jsp?parentCategoryCode="+"<%=HdViewCode%>"+"&categoryName="+categoryName;	
		}
		
	}
	area7.doms[2].domOkEvent=function()
	{
		if(area7.curpage==2)
		{
			window.location.href="health.jsp";	
		}else
		{
			var categoryName=area7Data[2]; 
			window.location.href="dibbling-tv.jsp?parentCategoryCode="+"<%=movieWorld%>"+"&categoryName="+categoryName;
		}
		
	}
	area7.doms[3].domOkEvent=function()
	{
		if(area7.curpage==1)
		{
			var categoryName=area7Data[3]; 
			window.location.href="dibbling-tv.jsp?parentCategoryCode="+"<%=TVTheatre%>"+"&categoryName="+categoryName;	
		}
		
	}
	area7.doms[4].domOkEvent=function()
	{
		if(area7.curpage==1)
		{
			window.location.href="entertainment.jsp";
		}
			
	}
	area7.doms[5].domOkEvent=function()
	{
		if(area7.curpage==1)
		{
		   window.location.href="childhood.jsp";
		}
			
	}
	area7.doms[6].domOkEvent=function()
	{
		if(area7.curpage==1)
		{
		   window.location.href="legal-system.jsp";
		}
			
	}
	area7.doms[7].domOkEvent=function()
	{
		if(area7.curpage==1)
		{
			window.location.href="documentary.jsp";	
		}
		
	}
	
	area7.changefocusedEvent = function()
	{
		clearTimeout(t);
		t = setTimeout("hideDiv()",5000);
	}
	
	
	if(areaid==6)
	{
		$("menu_a").style.visibility = "visible";
	}
	if(areaid==7)
	{
		$("menu_a").style.visibility = "visible";
		$("menu_b").style.visibility = "visible";
		$("area6_list_2").className = "item item_select";
		area6.doms[2].unfocusstyle = new Array("className:item item_select");
	}
	pageobj = new PageObj(areaid, indexid, new Array(area0,area1,area2,area3,area4,area5,area6,area7));
	pageobj.backurl=OperatorFocus.getLastReturn();
	pageobj.pageOkEvent=function()
	{
		OperatorFocus.saveFocstr(pageobj);
	};
	pageInit();
	if($("menu_a").style.visibility=="visible")
	{
		t=setTimeout("hideDiv()",5000);
	}
	

}


    function pageInit()
	{
		 bindata(getDataValue(area7.curpage));
		 bindArea0Data();
		 bindArea1Data();
		 bindArea2Data();
		 bindArea3Data();
		 bindArea4Data();
		 bindArea5Data();
	}
	//绑定area0 四部影片
	function bindArea0Data()
	{
		var length=enterTMCatgLiftList.vodDataList.length;
		if(length>0)
		{
			for(i=0;i<length;i++)
		    {
				area0.doms[i].setcontent("",enterTMCatgLiftList.vodDataList[i].name,6,false,false);
				$("area0_img_"+i).src=enterTMCatgLiftList.vodDataList[i].pictureList.poster;
		    };
		}; 	
	}
		
	//绑定area1
	function bindArea1Data()
	{
		var length = enterTMCatgCenterUpList.categoryList.length;
		if(length>0)
		{
			for(i=0;i<length;i++)
		    {
				area1.doms[i].setcontent("",enterTMCatgCenterUpList.categoryList[i].name,10,true,false);
		    };
		    $("themeImage").src=enterTMCatgCenterUpList.categoryList[0].pictureList.poster;
		}; 
		
	}


	
	//绑定area2
	function bindArea2Data()
	{
		
	    var length = enterTMCatgCenterList.vodDataList.length;
		if(length>0)
		{
			for(i=0;i<length;i++)
		    {
				area2.doms[i].setcontent("",enterTMCatgCenterList.vodDataList[i].name,8,true,false);
				$("area2_img_"+i).src=enterTMCatgCenterList.vodDataList[i].pictureList.poster;
		    };
		}; 
		
	}
		

	
	//绑定area3
	function bindArea3Data()
	{
		var length = enterTMCatgCenterDownList.categoryList.length;
		if(length>0)
		{
			for(i=0;i<length;i++)
		    {
				var name=enterTMCatgCenterDownList.categoryList[i].name;
				$("area3_list_"+i).innerHTML=name.length>4?name.substring(0,3)+"..":name;
		    };
			if(length<10)
	        {
		        var domsLength=area3.doms.length;
		        for(var i=length;i<domsLength;i++)
		        {
			      $("area3_list_"+i).style.visibility="hidden";			
		        }			
	        }
		}; 
		
	}
	
	
	//绑定area4 
	function bindArea4Data()
	{
		var length = enterTMCatgRightUpList.vodDataList.length;
		if(length>0)
		{
			$("area4_img_0").src=enterTMCatgRightUpList.vodDataList[0].pictureList.poster;	
		}
		
	}
	
	
	

	//绑定area5
	function bindArea5Data()
	{
		var length = enterTMCatgRightDownList.vodDataList.length;
		if(length>0)
		{
			for(i=0;i<length;i++)
		    {
				var name=enterTMCatgRightDownList.vodDataList[i].name;
				$("area5_list_"+i).innerHTML=name.length>9?name.substring(0,8)+"...":name;   
		    };
			if(length<5)
	        {
		        var domsLength=area5.doms.length;
		        for(var i=length;i<domsLength;i++)
		        {
			      $("area5_list_"+i).style.visibility="hidden";			
		        }			
	        }
		}; 
	}
	
	
	
	
	
	
    function getDataValue(currentPage)
	{
		var length=area7Data.length;		  
		var start=(currentPage-1)*8;
		var end=(start+8);
		if(end>=length)
		{
			end=length;
		}
		var newList=new Array();
		for(var i=start;i<end;i++)
		{
			newList.push(area7Data[i]);  
		}
		return newList;
	}
	function bindata(dataValue)
	{
		area7.datanum=dataValue.length;
		area7.setendwisepageturndata(area7.datanum,area7.pagecount);			   
		for(i=0;i<8;i++)
		{
			$("area7_txt_"+i).innerHTML="";
		} 
		for (var j = 0; j< dataValue.length; j++)
		{
		   	if(dataValue[j] != null)
			{
				area7.doms[j].setcontent("",dataValue[j],10,false,false);
			}
		}
		
	}

    function hideDiv()
	{
		$("menu_a").style.visibility = "hidden";
		$("menu_b").style.visibility = "hidden";
		$("area6_list_2").className = "item";
		area6.doms[2].unfocusstyle = new Array("className:item");
		pageobj.changefocus(0,area0.curindex);
	}
	



</script>


</head>
<body bgcolor="transparent">

<div class="wrapper">

	<!--head-->
	<div class="headline-shade">娱乐时尚</div>
	<div class="headline">娱乐时尚</div>
	<div class="date">
			<div class="txt">05/27</div>
			<div class="txt txt-time" style="top:22px;">11:15</div>
    </div>
	<!--head the end-->	
	
	
	
	<!--menu-->
	<div class="btn-menu">
		<div class="item"><img src="../../images/btn-menu.png" /></div>
	</div>
	<!--menu the end-->		

	
	
	<!--预告片 & Left-->
	<div class="txt-title02">精彩节目</div>
	<div class="list-pic-k">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area0_list_0">
			<div class="link"></div>
			<div class="pic"><img id="area0_img_0" src="" /></div>
			<div class="txt txt01" id="area0_txt_0"></div>
		</div>
		<div class="item" style="top:131px;" id="area0_list_1">
			<div class="link"></div>
			<div class="pic"><img id="area0_img_1" src="" /></div>
			<div class="txt txt01" id="area0_txt_1"></div>
		</div>
		<div class="item" style="top:262px;" id="area0_list_2">
			<div class="link"></div>
			<div class="pic"><img id="area0_img_2" src="" /></div>
			<div class="txt txt01" id="area0_txt_2"></div>
		</div>
		<div class="item" style="top:393px;" id="area0_list_3">
			<div class="link"></div>
			<div class="pic"><img  id="area0_img_3" src="" /></div>
			<div class="txt txt01" id="area0_txt_3"></div>
		</div>
	</div>
	<!--预告片 & Left the end-->	
	
	
	
	<!--专题-->
	<div class="txt-title03">精选专题</div>
	<div class="poster-a">
		<div class="pic"><img id="themeImage" src="" /></div>
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area1_list_0">
			<div class="txt sub01" id="area1_txt_0"></div>
		</div>
		<div class="item" style="left:187px;" id="area1_list_1">
			<div class="txt sub02" id="area1_txt_1"></div>
	  </div>
		<div class="item" style="left:373px;" id="area1_list_2">
			<div class="txt sub03" id="area1_txt_2"></div>
		</div>
	</div>
	<!--专题 the end-->
	
	
	
	<!--热播推荐 & mid-->
	<div class="txt-title03" style="top:431px;">热门推荐</div>
	<div class="list-pic-k" style="left:387px; top:451px;">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area2_list_0">
			<div class="pic"><img id="area2_img_0" src="" /></div>
			<div class="txt txt02" id="area2_txt_0"></div>
		</div>
		<div class="item" style="left:195px;" id="area2_list_1">
			<div class="pic"><img id="area2_img_1" src="" /></div>
			<div class="txt txt02" id="area2_txt_1"></div>
		</div>
		<div class="item" style="left:390px;" id="area2_list_2">
			<div class="pic"><img id="area2_img_2" src="" /></div>
			<div class="txt txt02" id="area2_txt_2"></div>
		</div>
	</div>
	<!--热播推荐 & mid the end-->	
	
	
	
	<!--list Font&LINK mid-->
	<div class="list-a" style=" left:405px; top:596px;">
		<!--焦点 
				class="item item_focus"
		-->        
		<div class="item" id="area3_list_0"></div>
		<div class="item" style="left:114px;" id="area3_list_1"></div>
		<div class="item" style="left:228px;" id="area3_list_2"></div>
		<div class="item" style="left:342px;" id="area3_list_3"></div>
		<div class="item" style="left:456px;" id="area3_list_4"></div>
		
		<div class="item" style="top:40px;" id="area3_list_5"></div>
		<div class="item" style="left:114px;top:40px;" id="area3_list_6"></div>
		<div class="item" style="left:228px;top:40px;" id="area3_list_7"></div>
		<div class="item" style="left:342px;top:40px;" id="area3_list_8"></div>
		<div class="item" style="left:456px;top:40px;" id="area3_list_9"></div>
	</div>
	<!--list Font&LINK mid the end-->
	
	
	
	<!--音乐-->
	<div class="txt-title02" style="left:1005px; top:98px;">音乐MV</div>
	<div class="list-pic-m">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area4_list_0">
			<div class="pic"><img id="area4_img_0" src="" /></div>
		</div>
	</div>
	<!--音乐 the end-->
	
	
	
	<!--TOP榜 & r-->
	<div class="txt-title02" style="left:1005px; top:409px;">综艺TOP榜</div>
	<div class="list-d list-d02" style="top:455px;">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area5_list_0"></div>
		<div class="item" style="top:41px;" id="area5_list_1"></div>
		<div class="item " style="top:82px;" id="area5_list_2"></div>
		<div class="item" style="top:123px;" id="area5_list_3"></div>
		<div class="item" style="top:164px;" id="area5_list_4"></div>
	</div>
	<!--TOP榜 & r the end-->	
	
	    
    
<!--menu-->
<div class="menu-a" id="menu_a" style="visibility:hidden">
<!--焦点 
class="item item_focus" icon**.png 焦点为原图名上加：_focus
选中	
class="item item_select"  
-->
<div class="item" id="area6_list_0">
<div class="icon"><img src="../../images/menu/icon01.png" /></div>
<div class="txt">首&nbsp;页</div>
</div>
<div class="item" style="top:113px;" id="area6_list_1">
<div class="icon"><img src="../../images/menu/icon02.png" /></div>
<div class="txt">频&nbsp;道</div>
</div>
<div class="item" style="top:169px;" id="area6_list_2">
<div class="icon"><img src="../../images/menu/icon03.png" /></div>
<div class="txt">点&nbsp;播</div>
</div>
<div class="item" style="top:225px;" id="area6_list_3">
<div class="icon"><img src="../../images/menu/icon04.png" /></div>
<div class="txt">专&nbsp;题</div>
</div>
<div class="item" style="top:281px;" id="area6_list_4">
<div class="icon"><img src="../../images/menu/icon05.png" /></div>
<div class="txt">四&nbsp;川</div>
</div>
<div class="item" style="top:337px;" id="area6_list_5">
<div class="icon"><img src="../../images/menu/icon06.png" /></div>
<div class="txt">成&nbsp;都</div>
</div>
<div class="item" style="top:393px;" id="area6_list_6">
<div class="icon"><img src="../../images/menu/icon07.png" /></div>
<div class="txt">空&nbsp;间</div>
</div>
<div class="item" style="top:449px;" id="area6_list_7">
<div class="icon"><img src="../../images/menu/icon08.png" /></div>
<div class="txt">搜&nbsp;索</div>
</div>
<div class="item" style="top:505px;" id="area6_list_8">
<div class="icon"><img src="../../images/menu/icon09.png" /></div>
<div class="txt">帮&nbsp;助</div>
</div>
</div>

<div class="menu-b" id="menu_b" style="visibility:hidden">
<div class="btn" style="top:65px; left:80px;"><img id="pageUp" src="../../images/arrow-up.png" /></div>
<div class="btn" style="top:530px; left:80px;"><img id="pageDown" src="../../images/arrow-down.png" /></div>
<!--焦点 
class="item item_focus"
-->
<div class="item" style="top:95px;" id="area7_list_0">
<div class="txt" id="area7_txt_0">新闻频道</div>
</div>
<div class="item" style="top:150px;" id="area7_list_1">
<div class="txt" id="area7_txt_1">电影天地</div>
</div>
<div class="item" style="top:205px;" id="area7_list_2">
<div class="txt" id="area7_txt_2">电视剧场</div>
</div>
<div class="item" style="top:260px;" id="area7_list_3">
<div class="txt" id="area7_txt_3">娱乐时尚</div>
</div>
<div class="item" style="top:315px;" id="area7_list_4">
<div class="txt" id="area7_txt_4">金色童年</div>
</div>
<div class="item" style="top:370px;" id="area7_list_5">
<div class="txt" id="area7_txt_5">法治空间</div>
</div>
<div class="item" style="top:425px;" id="area7_list_6">
<div class="txt" id="area7_txt_6">科教纪录</div>
</div>
<div class="item" style="top:480px;" id="area7_list_7">
<div class="txt" id="area7_txt_7">第一体育</div>
</div>
</div>
<!--menu the end-->		

</div>
	
</body>
</html>
