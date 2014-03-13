<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<%
String vodListFile="../../../" + datajspname  + "/vodList.jsp";
String strFileCate="../../../" + datajspname  + "/categoryList.jsp";
String categoryCode=request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode"); 
String categoryName=request.getParameter("categoryName")==null?"":request.getParameter("categoryName"); 

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新闻列表（导航栏）- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<style type="text/css">
<!--
	body{ background:url(../../images/bg-s01.jpg) no-repeat;}
-->
</style>
<%@ include file="../../../util/servertime.jsp"%>
<%@ include file="../../../config/code.jsp"%>
<%@ include file="../../base.jsp"%>
<script type="text/javascript">


<jsp:include page="<%=vodListFile%>">             
	<jsp:param name="categoryCode" value="<%=categoryCode%>"/> 
	<jsp:param name="varName" value="newsListVod"/>
	<jsp:param name="pageIndex" value="1" /> 
	<jsp:param name="pageSize" value="8" />
</jsp:include>


function callVodListData(data)
{
	if(data!=null&&data!="")
	{
		newsListVod=data;
		initVodList();	
		initCurPgTotaPg();
		area0.pagecount = newsListVod.totalPage;	
		area0.datanum=newsListVod.vodDataList.length;		
	}
}



</script>
<script type="text/javascript">

var area2Data=["新闻联播","军事报道","防务新观察","今日关注","军情观察室","新闻调查","焦点访谈","晚间新闻",
                     "新闻1＋1","新闻周刊","世界周刊","环球视线","东方时空","风云对话","时事开讲","海峡两岸",
					 "冷暖人生","看见","面对面","锵锵三人行","凤凰大视野","时事直通车","时事亮亮点","社会能见度",
					 "一虎一席谈","环球人物周刊","专题"];

var area0,area1,area2;
var pageobj;
var areaid=0;
var indexid=0;
var area0curpage=1;
var curCategoryCode="";
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
			 area0curpage=focusObj.focusdatas[0].curpage;
		}
		
	}
	
	area0 = AreaCreator(4,2,new Array(-1,1,-1,-1),"area0_list_","className:item item_focus","className:item");
	for(i=0;i<area0.doms.length;i++)
	{
		area0.doms[i].contentdom = $("area0_txt_"+i);
    }	
	initClassName();
	initfocusstyle();
	area0.areaInedEvent = function()
	{
		$("menu-a").style.visibility = "hidden";
		$("menu-b").style.visibility = "hidden";
		pageobj.curareaid = 0;
		pageobj.areas[0].changefocus(area0.curindex,true);
	};
	area0.endwiseCrossturnpage = true;	
	area0.curpage=area0curpage;
	area0.pagecount = newsListVod.totalPage;	
	area0.areaPageTurnEvent = function(num)
	{	
	    var categoryCode=newsListVod.vodDataList[area0.curindex].categoryCode;
		var getNewsVodIframe=$("getNewsVodIframe");
		getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+categoryCode+"&curpage="+ area0.curpage+"&pageSize=8";  
	};
	area0.areaOkEvent=function()
	{
		var contentCode=newsListVod.vodDataList[area0.curindex].contentCode;
		var programCode=newsListVod.vodDataList[area0.curindex].programCode;
		var categoryCode=newsListVod.vodDataList[area0.curindex].categoryCode;
		var definition=newsListVod.vodDataList[area0.curindex].definition;
		var returnUrl=window.location.href;
		window.location.href="../vodPlayer/vodPlayer.jsp?ParentContentCode="+contentCode+"&programType=1&ParentProgramCode="+programCode+"&programCode="+programCode+"&contentCode="+contentCode+"&returnUrl="+escape(returnUrl)+"&categoryCode="+categoryCode+"&definition="+definition;

    }
	area1 = AreaCreator(8,1,new Array(-1,-1,-1,0),"area1_list_","className:item item_focus","className:item");
	area1.areaIningEvent = function()
	{
		$("menu-a").style.visibility = "visible";
		area1.doms[0].unfocusstyle = new Array("className:item");
	};
	area1.doms[0].domOkEvent=function()
	{
		$("menu-b").style.visibility = "visible";
		area1.directions = new Array(-1,-1,-1,2);
		area1.doms[0].unfocusstyle = new Array("className:item item_select");
	}
	area1.doms[1].domOkEvent=function()
	{
		var getNewsVodIframe=$("getNewsVodIframe");
		var curCategoryCode="<%=newsListcategoryCode1%>";
		getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+curCategoryCode+"&paqeSize=8";  
	}
	area1.doms[2].domOkEvent=function()
	{
		var getNewsVodIframe=$("getNewsVodIframe");
		var curCategoryCode="<%=newsListcategoryCode2%>";
		getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+curCategoryCode+"&paqeSize=8";  
	}
	area1.doms[3].domOkEvent=function()
	{
		var getNewsVodIframe=$("getNewsVodIframe");
		var curCategoryCode="<%=newsListcategoryCode3%>";
		getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+curCategoryCode+"&paqeSize=8";  
	}
	area1.doms[4].domOkEvent=function()
	{
		var getNewsVodIframe=$("getNewsVodIframe");
		var curCategoryCode="<%=newsListcategoryCode4%>";
		getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+curCategoryCode+"&paqeSize=8";  
	}
	area1.doms[5].domOkEvent=function()
	{
		var getNewsVodIframe=$("getNewsVodIframe");
		var curCategoryCode="<%=newsListcategoryCode5%>";
		getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+curCategoryCode+"&paqeSize=8";  
	}
	area1.doms[6].domOkEvent=function()
	{
		var getNewsVodIframe=$("getNewsVodIframe");
		var curCategoryCode="<%=newsListcategoryCode6%>";
		getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+curCategoryCode+"&paqeSize=8";  
	}
	area1.doms[7].domOkEvent=function()
	{
		var getNewsVodIframe=$("getNewsVodIframe");
		var curCategoryCode="<%=newsListcategoryCode7%>";
		getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+curCategoryCode+"&paqeSize=8";  
	}
	
	area2 = AreaCreator(8,1,new Array(-1,1,-1,-1),"area2_list_","className:item item_focus","className:item");
	area2.areaOutedEvent = function()
	{
		$("menu-b").style.visibility = "hidden";
		area1.directions = new Array(-1,-1,-1,0);
	};
	area2.pagecount = Math.ceil((area2Data.length/8));
	area2.endwiseCrossturnpage = true;
	area2.areaPageTurnEvent = function(num)
	{
	    bindata(getDataValue(area2.curpage));
	};
	area2.doms[0].domOkEvent=function()
	{
		var getNewsVodIframe=$("getNewsVodIframe");
		if(area2.curpage==1)
			getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode0%>"+"&paqeSize=8";  
		else if(area2.curpage==2)
           getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode8%>"+"&paqeSize=8";  	
		else if(area2.curpage==3)
	       getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode16%>"+"&paqeSize=8";  
		else
		   getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode24%>"+"&paqeSize=8"; 		
	}
	area2.doms[1].domOkEvent=function()
	{
		var getNewsVodIframe=$("getNewsVodIframe");
		if(area2.curpage==1)
			getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode1%>"+"&paqeSize=8";  
		else if(area2.curpage==2)
           getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode9%>"+"&paqeSize=8";  	
		else if(area2.curpage==3)
	       getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode17%>"+"&paqeSize=8";  
		else
		   getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode25%>"+"&paqeSize=8"; 	
	}
	area2.doms[2].domOkEvent=function()
	{
		var getNewsVodIframe=$("getNewsVodIframe");
		if(area2.curpage==1)
			getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode2%>"+"&paqeSize=8";  
		else if(area2.curpage==2)
           getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode10%>"+"&paqeSize=8";  	
		else if(area2.curpage==3)
	       getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode18%>"+"&paqeSize=8";  
		else
		   getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode26%>"+"&paqeSize=8";
	}
	area2.doms[3].domOkEvent=function()
	{
		var getNewsVodIframe=$("getNewsVodIframe");
		if(area2.curpage==1)
			getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode3%>"+"&paqeSize=8";  
		else if(area2.curpage==2)
           getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode11%>"+"&paqeSize=8";  	
		else
	       getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode19%>"+"&paqeSize=8";  
	}
	area2.doms[4].domOkEvent=function()
	{
		var getNewsVodIframe=$("getNewsVodIframe");
		if(area2.curpage==1)
			getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode4%>"+"&paqeSize=8";  
		else if(area2.curpage==2)
           getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode12%>"+"&paqeSize=8";  	
		else
	       getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode20%>"+"&paqeSize=8";  
	}
	area2.doms[5].domOkEvent=function()
	{
		var getNewsVodIframe=$("getNewsVodIframe");
		if(area2.curpage==1)
			getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode5%>"+"&paqeSize=8";  
		else if(area2.curpage==2)
           getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode13%>"+"&paqeSize=8";  	
		else
	       getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode21%>"+"&paqeSize=8";  
	}
	area2.doms[6].domOkEvent=function()
	{
		var getNewsVodIframe=$("getNewsVodIframe");
		if(area2.curpage==1)
			getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode6%>"+"&paqeSize=8";  
		else if(area2.curpage==2)
           getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode14%>"+"&paqeSize=8";  	
		else
	       getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode22%>"+"&paqeSize=8"; 
	}
	area2.doms[7].domOkEvent=function()
	{
		var getNewsVodIframe=$("getNewsVodIframe");
		if(area2.curpage==1)
			getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode7%>"+"&paqeSize=8";  
		else if(area2.curpage==2)
           getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode15%>"+"&paqeSize=8";  	
		else
	       getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+"<%=newListMenuVodCode23%>"+"&paqeSize=8";  	
	}
	
	pageobj = new PageObj(areaid, indexid, new Array(area0,area1,area2));
	pageobj.pageOkEvent=function()
	{
	    OperatorFocus.saveFocstr(pageobj);
	};
	pageobj.backurl= OperatorFocus.getLastReturn();
	pageInit();

}

    function pageInit()
	{
		if(area0curpage!=1)
		{
			var categoryCode=newsListVod.vodDataList[area0.curindex].categoryCode;
		    var getNewsVodIframe=$("getNewsVodIframe");
		    getNewsVodIframe.src="../iframe/dibTVImageIframe.jsp?categoryCode="+categoryCode+"&curpage="+ area0.curpage+"&pageSize=8"; 	
		}else
		{
			initVodList();
		}
		initTime();
	    initCurPgTotaPg();
		bindata(getDataValue(area2.curpage));
		
	}
	
	function initTime()
	{
		$("timeDate").innerHTML = time1;
		$("time").innerHTML = time2;	
	};
   
    function initCurPgTotaPg()
    {
	   $("curPage").innerHTML=newsListVod.curPage;
	   $("totalPage").innerHTML=newsListVod.totalPage;
    }
	
	function initVodList()
	{
		var tvLength=newsListVod.vodDataList.length;	
		for(var i=0;i<tvLength;i++)
		{		
			$("area0_list_"+i).style.visibility="visible";
			$("area0_img_"+i).src = newsListVod.vodDataList[i].pictureList.poster;
			area0.doms[i].setcontent("",newsListVod.vodDataList[i].name,46,true,false);	
		};	
		if(tvLength<10)
		{
			var domsLength=area0.doms.length;
			for(var i=tvLength;i<domsLength;i++)
			{
				$("area0_list_"+i).style.visibility="hidden";			
			}			
		}				  
	}
   
   
 
	//初始化area0的calssName
    function initClassName()
    {
        for(var i=0;i<4;i++)
        {
            if((i%2)==0)
            {
                $("area0_list_"+i*2).className="item item-a";
                $("area0_list_"+(i*2+1)).className="item item-a";
            }
            else
            {
                $("area0_list_"+i*2).className="item item-b";
                $("area0_list_"+(i*2+1)).className="item item-b";
            }
        }
     }

    //初始化失去或得到焦点的样式
    function initfocusstyle()
    {
		for(var i=0;i<4;i++)
        {  
          if((i%2)==0)
          {
              area0.doms[i*2].focusstyle = new Array("className:item item_focus");
              area0.doms[i*2].unfocusstyle = new Array("className:item item-a");
              area0.doms[i*2+1].focusstyle = new Array("className:item item_focus");
              area0.doms[i*2+1].unfocusstyle = new Array("className:item item-a");
          }
          else
          {
              area0.doms[i*2].focusstyle = new Array("className:item item_focus item-b");
              area0.doms[i*2].unfocusstyle = new Array("className:item item-b");
              area0.doms[i*2+1].focusstyle = new Array("className:item item_focus item-b");
              area0.doms[i*2+1].unfocusstyle = new Array("className:item item-b");
          }
        }

     }
	 
	 

	function getDataValue(currentPage)
	{
		var length=area2Data.length;		  
		var start=(currentPage-1)*8;
		var end=(start+8);
		if(end>=length)
		{   
		  end=length;
		}
		var newList=new Array();
		for(var i=start;i<end;i++)
		{
		   newList.push(area2Data[i]);  
		}
	 return newList;
   }
  
  function bindata(dataValue)
  {
	  area2.datanum=dataValue.length;
	  area2.setendwisepageturndata(area2.datanum,area2.pagecount);			   
	  for(i=0;i<8;i++)
	  {
		  $("area2_txt_"+i).innerHTML="";
	  } 
	  for (var j = 0; j< dataValue.length; j++)
	  {
		  if(dataValue[j] != null)
		  {
			  $("area2_txt_"+j).innerHTML=dataValue[j];
		  }
	  }
  
   }




</script>





</head>

<body bgcolor="transparent">

<div class="wrapper">

	<!--head-->
	<div class="headline-shade"><%=categoryName%></div>
	<div class="headline"><%=categoryName%></div>
	<div class="date">
		<div class="txt" id="timeDate">05/27</div>
		<div class="txt txt-time" style="top:22px;" id="time">11:15</div>
	</div>
	<!--head the end-->
	
	
	
	<!--menu-->
	<div class="menu-b" id="menu-a" style="left:0; z-index:8; visibility:hidden">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area1_list_0"  style="top:60px;">
			<div class="txt" id="area1_txt_0">名&nbsp;&nbsp;栏</div>
		</div>
		<div class="item" id="area1_list_1" style="top:115px;">
			<div class="txt" id="area1_txt_1">国&nbsp;&nbsp;内</div>
		</div>
		<div class="item" id="area1_list_2" style="top:170px;">
			<div class="txt" id="area1_txt_2">国&nbsp;&nbsp;际</div>
		</div>
		<div class="item" id="area1_list_3" style="top:225px;">
			<div class="txt" id="area1_txt_3">社&nbsp;&nbsp;会</div>
		</div>
		<div class="item" id="area1_list_4" style="top:280px;">
			<div class="txt" id="area1_txt_4">财&nbsp;&nbsp;经</div>
		</div>
		<div class="item" id="area1_list_5" style="top:335px;">
			<div class="txt" id="area1_txt_5">军&nbsp;&nbsp;事</div>
		</div>
		<div class="item item-a" id="area1_list_6" style="top:390px;">
			<div class="txt" id="area1_txt_6">娱&nbsp;&nbsp;乐</div>
		</div>
		<div class="item item-b" id="area1_list_7" style="top:445px;">
			<div class="txt" id="area1_txt_7">体&nbsp;&nbsp;育</div>
		</div>
	</div>
	
	<div class="menu-b" id="menu-b" style="left:190px; visibility:hidden" >
		<div class="btn" style="top:65px; left:80px;"><img src="../../images/arrow-up.png" /></div>
		<div class="btn" style="top:530px; left:80px;"><img src="../../images/arrow-down.png" /></div>
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area2_list_0" style="top:95px;">
			<div class="txt" id="area2_txt_0">新闻联播</div>
		</div>
		<div class="item" id="area2_list_1" style="top:150px;">
			<div class="txt" id="area2_txt_1">军事报道</div>
		</div>
		<div class="item" id="area2_list_2" style="top:205px;">
			<div class="txt" id="area2_txt_2">防务新观察</div>
		</div>
		<div class="item" id="area2_list_3" style="top:260px;">
			<div class="txt" id="area2_txt_3">今日关注</div>
		</div>
		<div class="item" id="area2_list_4" style="top:315px;">
			<div class="txt" id="area2_txt_4">军情观察室</div>
		</div>
		<div class="item" id="area2_list_5" style="top:370px;">
			<div class="txt" id="area2_txt_5">新闻调查</div>
		</div>
		<div class="item"  id="area2_list_6" style="top:425px;">
			<div class="txt" id="area2_txt_6">焦点访谈</div>
		</div>
		<div class="item"  id="area2_list_7" style="top:480px;">
			<div class="txt" id="area2_txt_7">晚间新闻</div>
		</div>
	</div>
	<!--menu the end-->		
	
	
	
	<!--list-->
	<div class="list-pic-j">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area0_list_0">
			<div class="pic"><img id="area0_img_0" src="" /></div>
			<div class="txt" id="area0_txt_0"></div>
		</div>
		<div class="item" id="area0_list_2" style="top:130px;">
			<div class="pic"><img  id="area0_img_2" src="" /></div>
			<div class="txt" id="area0_txt_2"></div>
		</div>
		<div class="item" id="area0_list_4" style="top:260px;">
			<div class="pic"><img id="area0_img_4" src="" /></div>
			<div class="txt" id="area0_txt_4"></div>
		</div>
		<div class="item" id="area0_list_6" style="top:390px;">
			<div class="pic"><img id="area0_img_6" src="" /></div>
			<div class="txt" id="area0_txt_6"></div>
		</div>
		<div class="item" id="area0_list_1" style="left:545px;">
			<div class="pic"><img  id="area0_img_1" src="" /></div>
			<div class="txt" id="area0_txt_1"></div>
		</div>
		<div class="item" id="area0_list_3" style="left:545px;top:130px;">
			<div class="pic"><img id="area0_img_3" src="" /></div>
			<div class="txt" id="area0_txt_3"></div>
		</div>
		<div class="item" id="area0_list_5" style="left:545px;top:260px;">
			<div class="pic"><img id="area0_img_5" src="" /></div>
			<div class="txt" id="area0_txt_5"></div>
		</div>
		<div class="item" id="area0_list_7" style="left:545px;top:390px;">
			<div class="pic"><img id="area0_img_7" src="" /></div>
			<div class="txt" id="area0_txt_7"></div>
		</div>
	</div>
	<!--list the end-->
	
	
	
	<!--pages-->
	<div class="pages-side">
		<div class="txt txt-current" id="curPage">2</div>
		<div class="txt" style="top:156px;" id="totalPage">5</div>
	</div>
	<!--pages the end-->	
	
	
	
	<!--跑马灯-->
	<div class="marquee02">
		<div class="txt txt01">新闻公告: </div>  
		<div class="txt txt02"><marquee>第85届奥斯卡金像奖于北京时间2月25日上午(美国当地时间2月24日下午)在</marquee></div>
	</div>
	<!--跑马灯 the end-->
	
    <iframe id="getNewsVodIframe"  style="width:0px;height:0px;border:0px;" ></iframe>
</div>

</body>
</html>
