<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="datajsp/moreListData.jsp"%>
<%@ include file="util/save_focus.jsp"%>
<%
 
  String path = request.getRequestURI().substring(0,request.getRequestURI().lastIndexOf("/")+1);   
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>更多-深圳首映专区高清 EPG3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<style type="text/css">
<!--
	body{ background:url(../images/bg-common.jpg) no-repeat;}
-->
</style>

<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
var area0,area1,area2,area3;
var pageobj;
var areaid = 1,indexid = 0;
var cruntpage="";
var area0_numString ="";
var area2_numString ="";
var temppageTurnList=new Array();
var returnurl = '<%=request.getParameter("returnurl")==null?"index.jsp":request.getParameter("returnurl")%>';
var cateName = '<%=request.getParameter("cateName")==null?"":request.getParameter("cateName")%>';
var cateNamePosition;

window.onload = function()
{
	
	area1 = AreaCreator(2,4,new Array(0,-1,2,-1),"area1_list_","className:item item_focus","className:item");
	//area2.stablemoveindex=new Array("4-0>3","4-0>3","0-1>0","3-0>4");
	//area1.setfocuscircle(1);
	area1.pagecount = Math.ceil(contentTotal/8);
	for(i=0;i<8;i++)
	{
	   //area1.doms[i].contentdom=$("area1_text_"+i);
	   area1.doms[i].imgdom=$("area1_icon_"+i);
	}
	area1.areaOkEvent = function()
	{
		if(temppageTurnList[area1.curindex].VODID!=undefined)
		{
			window.location.href="detail.jsp?vodid="+temppageTurnList[area1.curindex].VODID+"&cateNamePosition="+cateNamePosition+"&returnurl="+escape(location.href)+"&typeid=<%=typeId%>";
			saveFocstr(pageobj);
		}
	}
	
	        
			
			
	//area2.setcrossturnpage();
	area1.asyngetdata=function()
	{
		//turnpageShowData(this.curpage)
		$('hidden_frame').src = "<%=basePath%>datajsp/moreListData.jsp?renQiORTuijianFlag=<%=renQiORTuijianFlag%>&isFirstFlag=1&stratPosition="+(this.curpage-1)*8;
		//getAJAXData("datajsp/moreListData.jsp?stratPosition="+(this.curpage-1)*8+"&isFirstFlag=1",bindFilmsData);
		
	}
	
	area0 = AreaCreator(1,4,new Array(-1,-1,1,-1),"area0_list_","className:item item_focus","className:item");
	area0.areaOkEvent = function()
	{
		if(area0.curindex==0)
		{
			area1.pageTurn(1);
			$("area1_list_"+area2.curindex).className="item";
		}
		else if(area0.curindex==1)
		{
		    area1.pageTurn(-1);
			$("area1_list_"+area2.curindex).className="item";
		}
		else if(area0.curindex==3)
		{
			if(area0_numString!=""&&area0_numString.charAt(0)!=0&&area0_numString.length<=4
			   &&area0_numString>0&&area0_numString<=area1.pagecount)
			{
				area1.curpage=parseInt(area0_numString);
			    $('hidden_frame').src = "<%=basePath%>datajsp/moreListData.jsp?renQiORTuijianFlag=<%=renQiORTuijianFlag%>&isFirstFlag=1&stratPosition="+(area1.curpage-1)*8;
			}
			else
			{
				area0_numString="";
			    $("area0_list_3").innerHTML = area0_numString;
			}
		}
		else
		{
			window.location.href=returnurl;
		}
		
	}
	
	area0.goBackEvent = function()
	{
		if(area0.curindex==3)
		{
			if(area0_numString!="")
			{
				pageobj.backurl=undefined;
				area0_numString=area0_numString.substring(0,area0_numString.length-1);
				$("area0_list_3").innerHTML = area0_numString;
			}else{
				window.location.href = returnurl;
			}
		}
		else
		{
		   pageobj.backurl=returnurl;
		}
	}
	
	
	   
	   
	area2 = AreaCreator(1,4,new Array(1,-1,-1,-1),"area2_list_","className:item item_focus","className:item");
	area2.areaOkEvent = function()
	{
		if(area2.curindex==0)
		{
			area1.pageTurn(1);
			$("area1_list_"+area2.curindex).className="item";
		}
		else if(area2.curindex==1)
		{
		    area1.pageTurn(-1);
			$("area1_list_"+area2.curindex).className="item";
		}
		else if(area2.curindex==3)
		{
			if(area2_numString!=""&&area2_numString.charAt(0)!=0&&area2_numString.length<=4
			   &&area2_numString>0&&area2_numString<=area1.pagecount)
			{
				area1.curpage=parseInt(area2_numString);
			    $('hidden_frame').src = "<%=basePath%>datajsp/moreListData.jsp?renQiORTuijianFlag=<%=renQiORTuijianFlag%>&isFirstFlag=1&stratPosition="+(area1.curpage-1)*8;
			}
			else
			{
				area2_numString="";
			    $("area2_list_3").innerHTML = area2_numString;
			}
		}
		else
		{
			window.location.href=returnurl;
		}
	}
	
	area2.goBackEvent = function()
	{
		if(area2.curindex==3)
		{
			if(area2_numString!="")
			{
				pageobj.backurl=undefined;
				area2_numString=area2_numString.substring(0,area2_numString.length-1);
				$("area2_list_3").innerHTML = area2_numString;
			}else{
				window.location.href = returnurl;
			}
		}
		else
		{
		   pageobj.backurl=returnurl;
		}
	}
	
	area1.goBackEvent = function()
	{
		pageobj.backurl=returnurl;
	}
	
	if(focusObj!=undefined&&focusObj!="null")
	{
		areaid = parseInt(focusObj[0].areaid);
		indexid = parseInt(focusObj[0].curindex);
		cruntpage = parseInt(focusObj[0].curpage);
	}
	
	pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area0,area1,area2),null);
	if('<%=renQiORTuijianFlag%>'=="renQi")
	{
	    $("title").innerHTML ="人气";
		cateName="人气";
		cateNamePosition=8;
	}
	else
	{
	    $("title").innerHTML ="推荐";
		cateName="推荐";
		cateNamePosition=9;
	}
	pageobj.pageNumTypeEvent=function(num)
	{
	    showPageNUM(num);
    }
	
	if(cruntpage!=""&&cruntpage!=1)
	{
		area1.curpage = cruntpage;
		$('hidden_frame').src = "<%=basePath%>datajsp/moreListData.jsp?renQiORTuijianFlag=<%=renQiORTuijianFlag%>&isFirstFlag=1&stratPosition="+(area1.curpage-1)*8;
	}
	else
	{
	    bindFilmsData(moreDataList);
	}
}

function bindFilmsData(datavalue)
{
	temppageTurnList=datavalue;
	var start = (area1.curpage-1)*8;
	var size = (contentTotal-start)>=8?8:(contentTotal-start);
	area1.setpageturndata(size, area1.pagecount);
	//document.getElementById("testText").innerHTML=datavalue.length;
	if(area1.pagecount<=1)
	{
		area0.doms[0].setCanFocus(false,2);
		area2.doms[0].setCanFocus(false,2);
		area0.doms[1].setCanFocus(false,2);
		area2.doms[1].setCanFocus(false,2);
		$("areaGray0_list_0").style.display="block";
		$("areaGray2_list_0").style.display="block";
		$("areaGray0_list_1").style.display="block";
		$("areaGray2_list_1").style.display="block";
	}
	else
	{
		if(area1.curpage == 1)
		{
			area0.doms[0].setCanFocus(true);
			area2.doms[0].setCanFocus(true);
			area0.doms[1].setCanFocus(false,2);
			area2.doms[1].setCanFocus(false,2);
			$("areaGray0_list_0").style.display="none";
			$("areaGray2_list_0").style.display="none";
			$("areaGray0_list_1").style.display="block";
			$("areaGray2_list_1").style.display="block";
			if(pageobj.curareaid == 0&&area0.curindex==1)
			{
				pageobj.changefocus(0,0);
				$("areaGray0_list_1").style.display="block";
			}
			if(pageobj.curareaid == 2&&area2.curindex==1)
			{
				pageobj.changefocus(2,0);
				$("areaGray2_list_1").style.display="block";
			}
		}
		else if(area1.curpage == area1.pagecount)
		{
			area0.doms[1].setCanFocus(true);
			area2.doms[1].setCanFocus(true);
			area0.doms[0].setCanFocus(false,1);
			area2.doms[0].setCanFocus(false,1);
		/*	$("area1_list_0").className="item item_not";
			$("area3_list_0").className="item item_not";*/
			$("areaGray0_list_1").style.display="none";
			$("areaGray2_list_1").style.display="none";
			$("areaGray0_list_0").style.display="block";
			$("areaGray2_list_0").style.display="block";
			if(pageobj.curareaid == 0&&area0.curindex==0)
			{
				pageobj.changefocus(0,1);
				$("areaGray0_list_0").style.display="block";
			}
			if(pageobj.curareaid == 2&&area2.curindex==0)
			{
				pageobj.changefocus(2,1);
				$("areaGray2_list_0").style.display="block";
			}
		
		}
		else
		{
			area0.doms[0].setCanFocus(true);
			area0.doms[1].setCanFocus(true);
			area2.doms[0].setCanFocus(true);
			area2.doms[1].setCanFocus(true);
			$("areaGray0_list_1").style.display="none";
			$("areaGray2_list_1").style.display="none";
			$("areaGray0_list_0").style.display="none";
			$("areaGray2_list_0").style.display="none";
		}
	}
	for(i=0;i<area1.doms.length;i++)
	{
	   if(i<datavalue.length)
	   {
		  //area1.doms[i].setcontent("",datavalue[i].VODNAME,8,true,true);
		  area1.doms[i].updateimg(datavalue[i].POSTERPATHS==undefined?"../images/nopicture.jpg":"../"+datavalue[i].POSTERPATHS);
		  $("area1_list_"+i).style.display="block";
	   }
	   else
	   {
		   //area1.doms[i].updatecontent("暂无数据");
		   area1.doms[i].updateimg("#");
		   $("area1_list_"+i).style.display="none";
	   }
	}
	
	if(datavalue.length>0)
	{ 
	    $("page_1").innerHTML = "页"+area1.curpage+"/"+area1.pagecount+"页";
		$("page_2").innerHTML = "页"+area1.curpage+"/"+area1.pagecount+"页";
	}
	else
	{
		$("page_1").innerHTML = "";
		$("page_2").innerHTML = "";
	}
}

function showPageNUM(num)
{
	if(pageobj.curareaid==0&&area0.curindex==3&&area0_numString.length<4)
	{
		area0_numString =area0_numString+num;
		$("area0_list_3").innerHTML = area0_numString;
	}
	
	if(pageobj.curareaid==2&&area2.curindex==3&&area2_numString.length<4)
	{
		area2_numString =area2_numString+num;
		$("area2_list_3").innerHTML = area2_numString;
	}

}

      
	  
	  
</script>

</head>

<body>
	
	<!--title-->
	<div class="title">
		<div class="icon"><img src="../images/icon01.png" /></div>
		<div class="txt" id="title"></div>
	</div>
	<!--title the end-->
	
	
	
	<!--pages-->
	<div class="pages">
		<!--焦点 
				class="item item_focus"
			灰色/不可用
				class="item item_not"
		-->
        <div class="btn">
			<div class="item" id="area0_list_0">下页</div>
            <div class="item item_not" id="areaGray0_list_0" style="display:none">下页</div>
			<div class="item" id="area0_list_1" style="left:109px;">上页</div>
            <div class="item item_not" id="areaGray0_list_1" style="left:109px;display:none">上页</div>
			<div class="item" id="area0_list_2" style="left:218px;">返回</div>
		</div>
		<div class="input">
			<div class="txt">跳转至</div>
			<div class="item" id="area0_list_3" style="left:75px;"></div>
			<div class="txt" style="left:165px;" id="page_1"></div>
		</div>
	</div>
	<!--pages the end-->
	
	
	
	<!--list-->
	<div class="list-a">
		<!--焦点 
				class="item item_focus"
		-->
        <div class="item" id="area1_list_0">
			<div class="pic"><img id="area1_icon_0" src="#" /></div>
			<!--<div class="txt-wrap">
				<div class="txt" id="area1_text_0"></div>
			</div>-->
		</div>
		<div class="item" id="area1_list_1" style="left:307px;">
			<div class="pic"><img id="area1_icon_1" src="#" /></div>
			<!--<div class="txt-wrap">
				<div class="txt" id="area1_text_1"></div>
			</div>-->
		</div>
		<div class="item" id="area1_list_2" style="left:614px;">
			<div class="pic"><img id="area1_icon_2" src="#" /></div>
			<!--<div class="txt-wrap">
				<div class="txt" id="area1_text_2"></div>
			</div>-->
		</div>
		<div class="item" id="area1_list_3" style="left:921px;">
			<div class="pic"><img id="area1_icon_3" src="#" /></div>
			<!--<div class="txt-wrap">
				<div class="txt" id="area1_text_3"></div>
			</div>-->
		</div>
		<div class="item" id="area1_list_4" style="top:226px;">
			<div class="pic"><img id="area1_icon_4" src="#" /></div>
			<!--<div class="txt-wrap">
				<div class="txt" id="area1_text_4"></div>
			</div>-->
		</div>
		<div class="item" id="area1_list_5" style="left:307px;top:226px;">
			<div class="pic"><img id="area1_icon_5" src="#" /></div>
			<!--<div class="txt-wrap">
				<div class="txt" id="area1_text_5"></div>
			</div>-->
		</div>
		<div class="item" id="area1_list_6" style="left:614px;top:226px;">
			<div class="pic"><img id="area1_icon_6" src="#" /></div>
			<!--<div class="txt-wrap">
				<div class="txt" id="area1_text_6"></div>
			</div>-->
		</div>
		<div class="item" id="area1_list_7" style="left:921px;top:226px;">
			<div class="pic"><img id="area1_icon_7" src="#" /></div>
			<!--<div class="txt-wrap">
				<div class="txt" id="area1_text_7"></div>
			</div>-->
		</div>
	</div>
	<!--list the end-->
	
	
	
	<!--pages-->
	<div class="pages" style="top:654px;">
		<!--焦点 
				class="item item_focus"
			灰色/不可用
				class="item item_not"
		-->
        <div class="btn">
			<div class="item" id="area2_list_0">下页</div>
            <div class="item item_not" id="areaGray2_list_0" style="display:none">下页</div>
			<div class="item" id="area2_list_1" style="left:109px;">上页</div>
            <div class="item item_not" id="areaGray2_list_1" style="left:109px;display:none">上页</div>
			<div class="item" id="area2_list_2" style="left:218px;">返回</div>
		</div>
		<div class="input">
			<div class="txt">跳转至</div>
			<div class="item" id="area2_list_3" style="left:75px;"></div>
			<div class="txt" style="left:165px;" id="page_2"></div>
		</div>
	</div>
	<!--pages the end-->
	
	<iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="0" height="0" ></iframe>
</body>
</html>
