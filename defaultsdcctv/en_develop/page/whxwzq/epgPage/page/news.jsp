<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<%
String vodListFile="../../../" + datajspname  + "/vodList.jsp";
String strFileCate="../../../" + datajspname  + "/categoryList.jsp";
String strFile="../../../" + datajspname  + "/vodInfo.jsp";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新闻- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<style type="text/css">
<!--
	body{ background:url(../../images/bg-d04.jpg) no-repeat;}
-->
</style>
<%@ include file="../../../util/servertime.jsp"%>
<%@ include file="../../../config/code.jsp"%>
<%@ include file="../../base.jsp"%>
<script type="text/javascript">
	
		//左边新闻专题(area0)
	  	<jsp:include page="<%=vodListFile%>">   
		    <jsp:param name="categoryCode" value="<%=newsLiftCode%>"/> 
			<jsp:param name="varName" value="newsCatagorLiftnewList"/>
			<jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="4" />
			<jsp:param name="fields" value="-1" /> 
			<jsp:param name="isBug" value="1" />
		</jsp:include>


      //中间上三栏目(area1)
		<jsp:include page="<%=strFileCate%>">   
			<jsp:param name="parentCategoryCode" value="<%=newsLeftCenterUpCode%>" /> 
			<jsp:param name="pageIndex" value="1" />
			<jsp:param name="pageSize" value="3" />
			<jsp:param name="varName" value="newsCatagoryCenterUpList" />
			<jsp:param name="fileds" value="-1" />
			<jsp:param name="isBug" value="1" />
		</jsp:include>


		
		//中间中三部影片 根据栏目code取影片然后直接播放(area2)
		<jsp:include page="<%=vodListFile%>">             
				<jsp:param name="categoryCode" value="<%=newsLeftCenterCode%>"/> 
				<jsp:param name="varName" value="newsCatagoryCenterList"/>
				<jsp:param name="pageIndex" value="1" /> 
				<jsp:param name="pageSize" value="3" />
				<jsp:param name="fields" value="-1" /> 
				<jsp:param name="isBug" value="1" />
		</jsp:include>

		//中间最下面栏目(area3)
		<jsp:include page="<%=strFileCate%>">   
			<jsp:param name="parentCategoryCode" value="<%=newsLeftCenterDwCode%>" /> 
			<jsp:param name="pageIndex" value="1" />
			<jsp:param name="pageSize" value="12" />
			<jsp:param name="varName" value=" newsCatagoryDownArea3List" />
			<jsp:param name="fileds" value="-1" />
			<jsp:param name="isBug" value="1" />
		</jsp:include>
		
		
		//右边新闻每日TOP榜(area4)
		<jsp:include page="<%=vodListFile%>">             
				<jsp:param name="categoryCode" value="<%=newsRightUpCode%>"/> 
				<jsp:param name="varName" value="newsCatagoryRightTOPList"/>
				<jsp:param name="pageIndex" value="1" /> 
				<jsp:param name="pageSize" value="1" />
				<jsp:param name="fields" value="-1" /> 
				<jsp:param name="isBug" value="1" />
		</jsp:include>
		
		
		//右边下面栏目
		<jsp:include page="<%=strFileCate%>">   
			<jsp:param name="parentCategoryCode" value="<%=newsRightDwCode%>" /> 
			<jsp:param name="pageIndex" value="1" />
			<jsp:param name="pageSize" value="8" />
			<jsp:param name="varName" value="newsCatagoryRightDwList" />
			<jsp:param name="fileds" value="-1" />
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
	area0.areaInedEvent = function()
	{
		$("menu_a").style.visibility ="hidden";
		$("menu_b").style.visibility ="hidden";
		pageobj.curareaid = 0;
		pageobj.areas[0].changefocus(area0.curindex,true);
	};
	area0.setfocuscircle(0);
	for(i=0;i<area0.doms.length;i++)
	{
		area0.doms[i].contentdom = $("area0_txt_"+i);
    }
	area0.areaOkEvent=function()
	{
		
		var returnUrl=window.location.href;
		var contentCode=newsCatagorLiftnewList.vodDataList[area0.curindex].contentCode;
		var programCode=newsCatagorLiftnewList.vodDataList[area0.curindex].programCode;
		var categoryCode=newsCatagorLiftnewList.vodDataList[area0.curindex].categoryCode;
		var definition=newsCatagorLiftnewList.vodDataList[area0.curindex].description;
		window.location.href="../vodPlayer/vodPlayer.jsp?ParentContentCode="+contentCode+"&programType=1&ParentProgramCode="+programCode+"&programCode="+programCode+"&contentCode="+contentCode+"&returnUrl="+escape(returnUrl)+"&categoryCode="+categoryCode+"&definition="+definition;

	}
    area1 = AreaCreator(1,3,new Array(-1,0,2,4),"area1_list_","className:item item_focus","className:item");
	for(i=0;i<area1.doms.length;i++)
	{
		area1.doms[i].contentdom = $("area1_txt_"+i);
    }
	area1.changefocusedEvent=function()
	{
		$("themeImage").src=newsCatagoryCenterUpList.categoryList[area1.curindex].pictureList.poster;
	}
	area1.areaOkEvent=function()
	{
		//goto->news-list.jsp
		 var categoryCode = newsCatagoryCenterUpList.categoryList[area1.curindex].categoryCode;
		 var categoryName=newsCatagoryCenterUpList.categoryList[area1.curindex].name;
		 window.location.href="news-list.jsp?categoryCode="+categoryCode+"&categoryName="+categoryName;
	}
	area2 = AreaCreator(1,3,new Array(1,0,3,4),"area2_list_","className:item item_focus","className:item");
	for(i=0;i<area2.doms.length;i++)
	{
		area2.doms[i].contentdom = $("area2_txt_"+i);
    }
	area2.areaOkEvent=function()
	{
		var returnUrl=window.location.href;
		var contentCode=newsCatagoryCenterList.vodDataList[area2.curindex].contentCode;
		var programCode=newsCatagoryCenterList.vodDataList[area2.curindex].programCode;
		var categoryCode=newsCatagoryCenterList.vodDataList[area2.curindex].categoryCode;
		var definition=newsCatagoryCenterList.vodDataList[area2.curindex].description;
		window.location.href="../vodPlayer/vodPlayer.jsp?ParentContentCode="+contentCode+"&programType=1&ParentProgramCode="+programCode+"&programCode="+programCode+"&contentCode="+contentCode+"&returnUrl="+escape(returnUrl)+"&categoryCode="+categoryCode+"&definition="+definition;
	}
	
	
    area3 = AreaCreator(3,4,new Array(2,-1,-1,4),"area3_list_","className:item item_focus","className:item");
	for(var i=0;i<area3.doms.length;i++)
	{
		area3.doms[i].contentdom = $("area3_txt_"+i);
    }	
	area3.areaOkEvent=function()
	{
		var categoryCode=newsCatagoryDownArea3List.categoryList[area3.curindex].categoryCode;
		var categoryName=newsCatagoryDownArea3List.categoryList[area3.curindex].name;
		window.location.href="news-list.jsp?categoryCode="+categoryCode+"&categoryName="+categoryName;
	}
	
	area4 = AreaCreator(1,1,new Array(-1,1,5,-1),"area4_list_","className:item item_focus","className:item");
	for(var i=0;i<area4.doms.length;i++)
	{
		area4.doms[i].contentdom = $("area4_txt_"+i);
    }	
	area4.areaOkEvent=function()
	{
		var returnUrl=window.location.href;
		var contentCode=newsCatagoryRightTOPList.vodDataList[area4.curindex].contentCode;
		var programCode=newsCatagoryRightTOPList.vodDataList[area4.curindex].programCode;
		var categoryCode=newsCatagoryRightTOPList.vodDataList[area4.curindex].categoryCode;
		var definition=newsCatagoryRightTOPList.vodDataList[area4.curindex].description;
		window.location.href="../vodPlayer/vodPlayer.jsp?ParentContentCode="+contentCode+"&programType=1&ParentProgramCode="+programCode+"&programCode="+programCode+"&contentCode="+contentCode+"&returnUrl="+escape(returnUrl)+"&categoryCode="+categoryCode+"&definition="+definition;	
	}
	
	area5 = AreaCreator(4,2,new Array(5,2,6,-1),"area5_list_","className:item item_focus","className:item");
/*	area5.areaOkEvent=function()
	{
		//除去名栏
		var curindex=area5.curindex+1;
		var categoryCode=newsCatagoryRightDwList.categoryList[curindex].categoryCode;
		var categoryName=newsCatagoryRightDwList.categoryList[curindex].name;
		window.location.href="news-list.jsp?categoryCode="+categoryCode+"&categoryName="+categoryName;
	}*/
	


	area5.doms[0].domOkEvent=function()
	{
		window.location.href="news-list.jsp?categoryCode="+"<%=newsListcategoryCode1%>"+"&categoryName=国内";
	}
	area5.doms[1].domOkEvent=function()
	{
		window.location.href="news-list.jsp?categoryCode="+"<%=newsListcategoryCode2%>"+"&categoryName=国际";
	}
	area5.doms[2].domOkEvent=function()
	{
		window.location.href="news-list.jsp?categoryCode="+"<%=newsListcategoryCode3%>"+"&categoryName=社会";
	}
	area5.doms[3].domOkEvent=function()
	{
		window.location.href="news-list.jsp?categoryCode="+"<%=newsListcategoryCode4%>"+"&categoryName=财经";
	}
	area5.doms[4].domOkEvent=function()
	{
		window.location.href="news-list.jsp?categoryCode="+"<%=newsListcategoryCode5%>"+"&categoryName=军事";
	}
	area5.doms[5].domOkEvent=function()
	{
		window.location.href="news-list.jsp?categoryCode="+"<%=newsListcategoryCode6%>"+"&categoryName=娱乐";
	}
	area5.doms[6].domOkEvent=function()
	{
		window.location.href="news-list.jsp?categoryCode="+"<%=newsListcategoryCode7%>"+"&categoryName=体育";
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
		var returnUrl = "../dibbling/index.jsp?areaid=6&indexid=0";
		window.location.href = "../index/index.jsp?returnUrl="+escape(returnUrl);
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
	area6.doms[7].domOkEvent = function()
	{
		window.location.href = "../space/space.jsp?";	
	}
	
	area7 = AreaCreator(8,1,new Array(-1,6,-1,-1),"area7_list_","className:item item_focus","className:item");
	area7.areaOutedEvent = function()
	{
		$("menu_b").style.visibility = "hidden";
		area6.directions = new Array(-1,-1,-1,0);
	};
	for(var i=0;i<area7.doms.length;i++)
	{
		area7.doms[i].contentdom = $("area7_txt_"+i);
    }	
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
			window.location.href="sports.jsp";
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
			var catagoryName=area7Data[1];
			window.location.href="dibbling-tv.jsp?parentCategoryCode="+"<%=HdViewCode%>"+"&catagoryName="+catagoryName;	
		}
	}
	area7.doms[2].domOkEvent=function()
	{
		if(area7.curpage==2)
		{
			window.location.href="health.jsp";	
		}else
		{
			var catagoryName=area7Data[2]; 
			window.location.href="dibbling-tv.jsp?parentCategoryCode="+"<%=movieWorld%>"+"&catagoryName="+catagoryName;
		}
			
	}
	area7.doms[3].domOkEvent=function()
	{
		if(area7.curpage==1)
		{
			var catagoryName=area7Data[3]; 
			window.location.href="dibbling-tv.jsp?parentCategoryCode="+"<%=TVTheatre%>"+"&catagoryName="+catagoryName;	
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
	pageobj.backurl= OperatorFocus.getLastReturn();
	pageInit();
	pageobj.pageOkEvent=function()
	{
		OperatorFocus.saveFocstr(pageobj);
	};
}

    function pageInit()
	{
		 bindata(getDataValue(area7.curpage));
		 bindArea0Data();
		 bindArea1Data();
		 bindArea2Data();
		 bindArea3Data();
		 bindArea4Data();
		// bindArea5Data();
		 initTime();
	}

    //绑定area0
    function bindArea0Data()
	{
		var length = newsCatagorLiftnewList.vodDataList.length;
		if(length>0)
		{
			for(i=0;i<length;i++)
		    {
				area0.doms[i].setcontent("",newsCatagorLiftnewList.vodDataList[i].name,8,true,false);
				$("area0_img_"+i).src=newsCatagorLiftnewList.vodDataList[i].pictureList.poster;
		    };
		}; 	
	}
	
	//绑定area1
	function bindArea1Data()
	{
		var length = newsCatagoryCenterUpList.categoryList.length;
		if(length>0)
		{
			for(i=0;i<length;i++)
		    {
				area1.doms[i].setcontent("",newsCatagoryCenterUpList.categoryList[i].name,8,true,false);
		    };
		    $("themeImage").src=newsCatagoryCenterUpList.categoryList[0].pictureList.poster;
		}; 	
	}
  
    //绑定area2
    function bindArea2Data()
	{
		
	    var length = newsCatagoryCenterList.vodDataList.length;
		if(length>0)
		{
			for(i=0;i<length;i++)
		    {
				area2.doms[i].setcontent("",newsCatagoryCenterList.vodDataList[i].name,8,ture,false);
				$("area2_img_"+i).src=newsCatagoryCenterList.vodDataList[i].pictureList.poster;
		    };
		}; 
		
	}
 
    function bindArea3Data()
	{
		var length = newsCatagoryDownArea3List.categoryList.length;
		if(length>0)
		{
			for(i=0;i<length;i++)
		    {
				area3.doms[i].setcontent("",newsCatagoryDownArea3List.categoryList[i].name,8,true,false);
		    };
			
			if(length<12)
	        {
		        var domsLength=area3.doms.length;
		        for(var i=length;i<domsLength;i++)
		        {
			      $("area3_list_"+i).style.visibility="hidden";			
		        }			
	        }
			
		}; 
	}
	function bindArea4Data()
	{
		var length = newsCatagoryRightTOPList.vodDataList.length;
		if(length>0)
		{
			for(i=0;i<length;i++)
		    {
				area4.doms[i].setcontent("",newsCatagoryRightTOPList.vodDataList[i].name,14,true,false);
				var description=newsCatagoryRightTOPList.vodDataList[i].description;
				$("area4_info_0").innerHTML=description.length>11?description.substring(0,9)+"...":description;
		    };
		}; 	
	}
	
	/*function bindArea5Data()
	{
		var length = newsCatagoryRightDwList.categoryList.length-1;
		if(length>0)
		{
			for(i=0;i<length;i++)
		    {
				$("area5_list_"+i).innerHTML=newsCatagoryRightDwList.categoryList[i+1].name;
		    };
		}; 	
	}*/
    function initTime()
	{
		$("timeDate").innerHTML = time1;
		$("time").innerHTML = time2;	
	};
  
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

</script>



</head>

<body bgcolor="transparent">

<div class="wrapper">

	<!--head-->
	<div class="headline-shade">新闻频道</div>
	<div class="headline">新闻频道</div>
	<div class="date">
			<div class="txt" id="timeDate">05/27</div>
			<div class="txt txt-time" style="top:22px;" id="time">11:15</div>
    </div>
	<!--head the end-->	
	
	
	
	<!--menu-->
	<div class="btn-menu">
		<div class="item"><img src="../../images/btn-menu.png" /></div>
	</div>
	<!--menu the end-->		

	
	
	<!--新闻专题 & Left-->
	<div class="txt-title02">新闻专题</div>
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
	<!--新闻专题 & Left the end-->	
	
	
	
	<!--新闻头条-->
	<div class="txt-title03">新闻头条</div>
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
	<!--新闻头条 the end-->
	
	
	
	<!--热播推荐 & mid-->
	<div class="txt-title03" style="top:431px;">新闻连连看</div>
	<div class="list-pic-k" style="left:387px; top:441px;">
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
	<div class="list-h">
		<!--焦点 
				class="item item_focus"
		-->        
		<div class="item" id="area3_list_0"><div class="txt" id="area3_txt_0"></div></div>
		<div class="item" id="area3_list_1" style="left:140px;"><div class="txt" id="area3_txt_1"></div></div>
		<div class="item" id="area3_list_2" style="left:280px;"><div class="txt" id="area3_txt_2"></div></div>
		<div class="item" id="area3_list_3" style="left:420px;"><div class="txt" id="area3_txt_3"></div></div>
		
		<div class="item" style="top:30px;" id="area3_list_4"><div class="txt" id="area3_txt_4"></div></div>
		<div class="item" style="left:140px;top:30px;" id="area3_list_5"><div class="txt" id="area3_txt_5"></div></div>
		<div class="item" style="left:280px;top:30px;" id="area3_list_6"><div class="txt" id="area3_txt_6"></div></div>
		<div class="item" style="left:420px;top:30px;" id="area3_list_7"><div class="txt" id="area3_txt_7"></div></div>
		
		<div class="item" style="top:60px;" id="area3_list_8"><div class="txt" id="area3_txt_8"></div></div>
		<div class="item" style="left:140px;top:60px;" id="area3_list_9"><div class="txt" id="area3_txt_9"></div></div>
		<div class="item" style="left:280px;top:60px;" id="area3_list_10"><div class="txt" id="area3_txt_10"></div></div>
		<div class="item" style="left:420px;top:60px;" id="area3_list_11"><div class="txt" id="area3_txt_11"></div></div>
	</div>
	<!--list Font&LINK mid the end-->
	
	
	
	<!--头条-->
	<div class="txt-title02" style="left:1005px; top:98px;">新闻每日TOP榜</div>
	<div class="list-pic-l">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area4_list_0">
			<div class="icon"><img src="../../images/icon-first.png" /></div>
			<div class="pic"><img id="area4_img_0" src="" /></div>
			<div class="txt" id="area4_txt_0"></div>
		</div>
	</div>
	<div class="txt" style=" color:#a49f9f; font-size:18px;left:1008px; top:277px; width:230px;">推荐理由:</div>
	<div class="txt" style=" color:#ccc; font-size:20px; left:1008px; top:304px; width:230px;" id="area4_info_0"></div>
	<!--头条 the end-->
	
	
	<!--list 栏目分类-->
	<div class="list-i">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area5_list_0">国内</div>
		<div class="item" style="left:80px;" id="area5_list_1">国际</div>
		<div class="item" style="top:41px;" id="area5_list_2">社会</div>
		<div class="item" style="left:80px;top:41px;" id="area5_list_3">财经</div>
		<div class="item" style="top:83px;" id="area5_list_4">军事</div>
		<div class="item" style="left:80px;top:83px;" id="area5_list_5">娱乐</div>
		<div class="item" style="top:123px;" id="area5_list_6">体育</div>
	</div>
	<!--list 栏目分类 the end-->
	
	
	
	<!--主编小结 & r-->
	<div class="txt" style=" color:#a49f9f; font-size:18px;left:1008px; top:588px; width:230px;"><%--主编小结:--%></div>
	<div class="txt" style=" color:#ccc; font-size:18px; line-height:24px; left:1008px; top:616px; width:230px;"><%--《食品安全法》将启动修订,注食品安全关注健康。--%></div>
	<!--主编小结 & r the end-->	
	
    
    
<!--menu-->
<div class="menu-a" id="menu_a" style="visibility:hidden">
<!--焦点 
class="item item_focus" icon**.png 焦点为原图名上加：_focus
选中	
class="item item_select"  
-->
<div class="item item_select" id="area6_list_0">
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
<div class="txt">本&nbsp;地</div>
</div>
<div class="item" style="top:337px;" id="area6_list_5">
<div class="icon"><img src="../../images/menu/icon06.png" /></div>
<div class="txt">应&nbsp;用</div>
</div>
<div class="item" style="top:393px;" id="area6_list_6">
<div class="icon"><img src="../../images/menu/icon07.png" /></div>
<div class="txt">套&nbsp;餐</div>
</div>
<div class="item" style="top:449px;" id="area6_list_7">
<div class="icon"><img src="../../images/menu/icon08.png" /></div>
<div class="txt">空&nbsp;间</div>
</div>
<div class="item" style="top:505px;" id="area6_list_8">
<div class="icon"><img src="../../images/menu/icon09.png" /></div>
<div class="txt">搜&nbsp;索</div>
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
