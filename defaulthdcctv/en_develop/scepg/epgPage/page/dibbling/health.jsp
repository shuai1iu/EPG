<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<%
String strfile="../../../" + datajspname  + "/vodList.jsp";
String strFileCate="../../../" + datajspname  + "/categoryList.jsp";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>健康- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<style type="text/css">
<!--
	body{ background:url(../../images/bg-d07.jpg) no-repeat;}
-->
</style>
<%@ include file="../../../util/servertime.jsp"%>
<%@ include file="../../../config/code.jsp"%>
<%@ include file="../../base.jsp"%>
<script type="text/javascript">
	//左边四部影片
		<jsp:include page="<%=strfile%>">
			<jsp:param name="categoryCode" value="<%=healthLeftVodCode%>"/> 
			<jsp:param name="varName" value="dibblingLeftName"/>
			<jsp:param name="fields" value="-1" /> 
			<jsp:param name="pageIndex" value="0" /> 
			<jsp:param name="pageSize" value="4" />
			<jsp:param name="isBug" value="1" />
		</jsp:include>
		
		//中间三个栏目
		<jsp:include page="<%=strFileCate%>">             
			<jsp:param name="parentCategoryCode" value="<%=healthCatagoryCenterUpCode%>" /> 
			<jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="3" /> 
			<jsp:param name="varName" value="dibblingCatagoryCenterUpName" />
			<jsp:param name="fileds" value="-1" />
			<jsp:param name="isBug" value="1" />
		</jsp:include>
				
		//中下热播推荐
		<jsp:include page="<%=strfile%>">             
			<jsp:param name="categoryCode" value="<%=healthCenterDVodCode%>" /> 
			<jsp:param name="varName" value="dibblingCenterDVodName" /> 
			<jsp:param name="pageIndex" value="0" /> 
			<jsp:param name="pageSize" value="5" />
			<jsp:param name="fields" value="-1" />
		</jsp:include>
		
		//右下主编推荐
		<jsp:include page="<%=strfile%>">
			<jsp:param name="categoryCode" value="<%=healthRightDVodCode%>" /> 
			<jsp:param name="varName" value="dibblingRightDVodName" /> 
			<jsp:param name="pageIndex" value="0" /> 
			<jsp:param name="pageSize" value="1" />
			<jsp:param name="fields" value="-1" />
		</jsp:include>	 
		  
		//右上最新上线
		<jsp:include page="<%=strfile%>">
			<jsp:param name="categoryCode" value="<%=healthRightUVodCode%>" /> 
			<jsp:param name="varName" value="dibblingRightUVodName" /> 
			<jsp:param name="pageIndex" value="0" /> 
			<jsp:param name="pageSize" value="6" />
			<jsp:param name="fields" value="-1" />
			<jsp:param name="isBug" value="1" />
		</jsp:include>
				
		//中间下栏目
		<jsp:include page="<%=strFileCate%>">   
			<jsp:param name="parentCategoryCode" value="<%=healthCatagoryCenterCode%>" /> 
			<jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="10" /> 
			<jsp:param name="varName" value="dibblingCatagoryCenterName" />
			<jsp:param name="fileds" value="-1" />
			<jsp:param name="isBug" value="1" />
		</jsp:include>
		
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
		for(var i=0;i<area0.doms.length;i++)
		{
			area0.doms[i].contentdom = $("area0_txt_"+i);
		}  
		area0.areaInedEvent = function()
		{
			$("menu_a").style.visibility = "hidden";
			$("menu_b").style.visibility = "hidden";
			pageobj.curareaid = 0;
			pageobj.areas[0].changefocus(area0.curindex,true);
		};
		area0.areaOkEvent=function()
		{  
			if(dibblingLeftName.vodDataList[area0.curindex].programType == 1)
			{
			   window.location.href = "detail-single.jsp?programCode="+dibblingLeftName.vodDataList[area0.curindex].programCode+"&contentCode="+dibblingLeftName.vodDataList[area0.curindex].contentCode+"&categoryCode="+dibblingLeftName.vodDataList[area0.curindex].categoryCode;				
			}else
			{
			   window.location.href = "detail-much.jsp?programCode="+dibblingLeftName.vodDataList[area0.curindex].programCode+"&contentCode="+dibblingLeftName.vodDataList[area0.curindex].contentCode+"&categoryCode="+dibblingLeftName.vodDataList[area0.curindex].categoryCode;			   
			}
		};		
		area1 = AreaCreator(1,3,new Array(-1,0,2,4),"area1_list_","className:item item_focus","className:item");
		area1.changefocusedEvent = function()
		{
			 $("themeImage").src = bibblingCenterImage[area1.curindex]; 
		};
		area1.areaOkEvent = function()
		{
			var parentCategoryCode=dibblingCatagoryCenterUpName.categoryList[area1.curindex].parentCategoryCode;
			window.location.href="dibbling-tv.jsp?parentCategoryCode="+parentCategoryCode;
		};
		
		area2 = AreaCreator(1,3,new Array(1,0,3,4),"area2_list_","className:item item_focus","className:item");
		for(var i=0;i<area2.doms.length;i++)
		{
			area2.doms[i].contentdom = $("area2_txt_"+i);
		}
		area2.areaOkEvent=function()
		{  
			if(dibblingCenterDVodName.vodDataList[area2.curindex].programType == 1)
			{
			   window.location.href = "detail-single.jsp?programCode="+dibblingCenterDVodName.vodDataList[area2.curindex].programCode+"&contentCode="+dibblingCenterDVodName.vodDataList[area2.curindex].contentCode+"&categoryCode="+dibblingCenterDVodName.vodDataList[area2.curindex].categoryCode;
			}else{
			   window.location.href = "detail-much.jsp?programCode="+dibblingCenterDVodName.vodDataList[area2.curindex].programCode+"&contentCode="+dibblingCenterDVodName.vodDataList[area2.curindex].contentCode+"&categoryCode="+dibblingCenterDVodName.vodDataList[area2.curindex].categoryCode;
			}
		};    
		area3 = AreaCreator(2,5,new Array(2,0,-1,5),"area3_list_","className:item item_focus","className:item");
		for(var i=0;i<area3.doms.length;i++)
		{
			area3.doms[i].contentdom = $("area3_list_"+i);
		}
		area3.areaOkEvent = function()
		{
			var parentCategoryCode=dibblingCatagoryCenterName.categoryList[area3.curindex].parentCategoryCode;
			var categoryName=dibblingCatagoryCenterName.categoryList[area3.curindex].name;
			var curindex=area3.curindex; 
			window.location.href="dibbling-tv.jsp?parentCategoryCode="+parentCategoryCode+"&categoryName="+categoryName+"&curindex="+curindex;
		};
		area4 = AreaCreator(6,1,new Array(-1,1,5,-1),"area4_list_","className:item item_focus","className:item");
		area4.stablemoveindex=new Array(-1,"0-1>2,1-1>2,2-1>2,3-1>2,4-1>2,5-1>2",-1,-1);
		for(var i=0;i<area4.doms.length;i++)
		{
			area4.doms[i].contentdom = $("area4_list_"+i);
		}
		area4.areaOkEvent=function()
		{  		
			if(dibblingRightUVodName.vodDataList[area4.curindex].programType == 1)
			{
				window.location.href = "detail-single.jsp?programCode="+dibblingRightUVodName.vodDataList[area4.curindex].programCode+"&contentCode="+dibblingRightUVodName.vodDataList[area4.curindex].contentCode+"&categoryCode="+dibblingRightUVodName.vodDataList[area4.curindex].categoryCode;				
			}else
			{
				window.location.href = "detail-much.jsp?programCode="+dibblingRightUVodName.vodDataList[area4.curindex].programCode+"&contentCode="+dibblingRightUVodName.vodDataList[area4.curindex].contentCode+"&categoryCode="+dibblingRightUVodName.vodDataList[area4.curindex].categoryCode;
			}
		};
		
		area5 = AreaCreator(1,1,new Array(4,2,-1,-1),"area5_list_","className:item item_focus","className:item");
		area5.stablemoveindex=new Array("0-4>5","0-2>2",-1,-1);
		area5.areaOkEvent=function()
		{  
			if(dibblingRightDVodName.vodDataList[area5.curindex].programType == 1)
			{
				window.location.href = "detail-single.jsp?programCode="+dibblingRightDVodName.vodDataList[area5.curindex].programCode+"&contentCode="+dibblingRightDVodName.vodDataList[area5.curindex].contentCode+"&categoryCode="+dibblingRightDVodName.vodDataList[area5.curindex].categoryCode;				
			}else
			{
				window.location.href = "detail-much.jsp?programCode="+dibblingRightDVodName.vodDataList[area5.curindex].programCode+"&contentCode="+dibblingRightDVodName.vodDataList[area5.curindex].contentCode+"&categoryCode="+dibblingRightDVodName.vodDataList[area5.curindex].categoryCode;
			}
		};

		area6 = AreaCreator(9,1,new Array(-1,-1,-1,0),"area6_list_","className:item item_focus","className:item");
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
		};
		area6.areaIningEvent = function()
		{
			$("menu_a").style.visibility = "visible";
			$("area6_list_2").className = "item";
			area6.doms[2].unfocusstyle = new Array("className:item");
		};

		area7 = AreaCreator(8,1,new Array(-1,6,-1,-1),"area7_list_","className:item item_focus","className:item");	
		//area7.pagecount = Math.ceil((dibblingMenuName.categoryList.length/8));
		area7.pagecount = Math.ceil((area7Data.length/8));
		area7.endwiseCrossturnpage = true;
		if(area7page==2)
	    area7.curpage=area7page;
		area7.areaPageTurnEvent = function(num)
		{
			 bindata(getDataValue(area7.curpage));
		};
		for(var i=0;i<area7.doms.length;i++)
		{
			 area7.doms[i].contentdom = $("area7_txt_"+i);
		}	
		area7.areaOutedEvent = function()
		{
			$("menu_b").style.visibility = "hidden";
			area6.directions = new Array(-1,-1,-1,0);
		};
		area7.areaInedEvent = function()
		{
			$("area6_list_2").className = "item item_select";
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
		
			
		pageobj = new PageObj(areaid, indexid, new Array(area0,area1,area2,area3,area4,area5,area6,area7));
		pageobj.backurl = "dibbling.jsp";
		initTime();
		pageInit();
		pageobj.pageOkEvent=function()
		{
			OperatorFocus.saveFocstr(pageobj);
		};
 };
		function hideDiv()
		{
			$("menu_a").style.visibility = "hidden";
			$("menu_b").style.visibility = "hidden";
			$("area7_list_"+area7.curindex).className = "item";
			$("area6_list_"+area6.curindex).className = "item";
		}
		function initTime()
		{
			$("timeDate").innerHTML = time1;
			$("time").innerHTML = time2;	
		};
		
		function pageInit()
		{	
		   //左侧影片数据绑定
			var dibblingLeftNameLength = dibblingLeftName.vodDataList.length;
			if(dibblingLeftNameLength>0)
			{
				for(var i=0;i<dibblingLeftNameLength;i++)
				{
					area0.doms[i].setcontent("",dibblingLeftName.vodDataList[i].name,14,true,false);
					$("area0_img_"+i).src = dibblingLeftName.vodDataList[i].pictureList.poster;
			   };
			};
		   //中间三部影片栏目绑定
		   var catagoryCenterUpNameLength = dibblingCatagoryCenterUpName.categoryList.length;
		   if(catagoryCenterUpNameLength>0)
		   {
			   for(i=0;i<catagoryCenterUpNameLength;i++)
			   {
				$("area1_txt_"+i).innerHTML=dibblingCatagoryCenterUpName.categoryList[i].name;
			   };
			   $("themeImage").src =bibblingCenterImage[0];
		   }; 
		  //中下热播推荐	
		   var dibblingCenterDVodNameLength=dibblingCenterDVodName.vodDataList.length;
		   if(dibblingCenterDVodNameLength>0)
		   {			   
			   for(var i=0;i<dibblingCenterDVodNameLength;i++)
			   {
				   area2.doms[i].setcontent("",dibblingCenterDVodName.vodDataList[i].name,5,true,false);
				   $("area2_img_"+i).src = dibblingCenterDVodName.vodDataList[i].pictureList.poster;
			   };			  
		   };   
			//中间栏目绑定
			var catagoryCenterNameLength = dibblingCatagoryCenterName.categoryList.length;
			for(i=0;i<catagoryCenterNameLength;i++)
			{
				area3.doms[i].setcontent("",dibblingCatagoryCenterName.categoryList[i].name,8,true,false);
			};
			//右下主编推荐
			var dibblingRightDVodNameLength=dibblingRightDVodName.vodDataList.length;
			if(dibblingRightDVodNameLength>0)
			{
			   for(var i=0;i<dibblingRightDVodNameLength;i++)
			   { 
				   var description=dibblingRightDVodName.vodDataList[i].description;
				   $("area5_txt_"+i).innerHTML =description.substr(0,28) ;
				   $("area5_img_"+i).src = dibblingRightDVodName.vodDataList[i].pictureList.poster;
			   };			  
			};
		   //右上最新上线
		   var dibblingRightUVodNameLength = dibblingRightUVodName.vodDataList.length;
		   for(i=0;i<dibblingRightUVodNameLength;i++)
		   {   
				area4.doms[i].setcontent("",dibblingRightUVodName.vodDataList[i].name,8,true,false);
		   };	
		  //绑定左边主菜单点播菜单项		
		  // bindata(getDataValue(area7.curpage));
		  //通过写死数据绑定左边主菜单点播菜单项
		  bindata(getDataValue(area7.curpage));
		
	};
		 
	/*     //通过接口返回的数据填充 左边主菜单点播菜单项	
		   function getDataValue(currentPage){
		   var length=dibblingMenuName.categoryList.length;		  
		   var start=(currentPage-1)*8;
		   var end=(start+8);
		   if(end>=length){   
			end=length;
		   }
		   var newList=new Array();
		   for(var i=start;i<end;i++){
			 newList.push(dibblingMenuName.categoryList[i].name);  
		   }
		   return newList;
		}*/
		
		
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
	<div class="headline-shade">健康生活</div>
	<div class="headline">健康生活</div>
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

	
	
	<!--预告片 & Left-->
	<div class="txt-title02">健康栏目</div>
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
			<div class="pic"><img id="area0_img_3" src="" /></div>
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
		<div class="item" style="left:228px;top:40px;" id="area3_list_7"> </div>
		<div class="item" style="left:342px;top:40px;" id="area3_list_8"></div>
		<div class="item" style="left:456px;top:40px;" id="area3_list_9"></div>
	</div>
	<!--list Font&LINK mid the end-->
	
	
	
	<!--list 最新上线-->
	<div class="txt-title02" style="left:1005px; top:98px;">引进专区</div>
	<div class="list-d list-d02">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area4_list_0"></div>
		<div class="item" style="top:41px;" id="area4_list_1"></div>
		<div class="item" style="top:82px;" id="area4_list_2"></div>
		<div class="item" style="top:123px;" id="area4_list_3"></div>
		<div class="item" style="top:164px;" id="area4_list_4"></div>
		<div class="item" style="top:205px;" id="area4_list_5"></div>
	</div>
	<!--list the end-->
	
	
	
	<!--时尚前沿 & r-->
	<div class="txt-title02" style="left:1005px; top:445px;">时尚前沿</div>
	<div class="list-pic-n">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area5_list_0">
			<div class="pic"><img id="area5_img_0" src="" /></div>
		</div>
	</div>
	<!--时尚前沿 & r the end-->	
	
	
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
