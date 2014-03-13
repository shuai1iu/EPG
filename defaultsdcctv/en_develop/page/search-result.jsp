<%@ page contentType="text/html; charset=UTF-8" language="java"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ include file="datajsp/search-result-data.jsp" %>
<%@ include file="datajsp/codepage.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>深圳标清EPG 2.0</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/common.css" />
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
var area0;
var area1;
var words ='<%=request.getParameter("words")%>';
var searchType= '<%=request.getParameter("searchType")%>';
window.onload = function()
{
	refreshServerTime();
	initPage();
	
	//alert(searchType);
}

function clearRight()
{
	for(var i = 0 ;i< area1.doms.length; i ++)
	{
			area1.doms[i].updatecontent("");
	}
}

function loadData(data,pageCount)
{

	var left = new Array();
	var right = new Array();
	if(data.length <= 7)
	{
		left = data;
		clearRight();
	}
	else
	{
		for(var i = 0 ; i < data.length; i ++)
		{
			if(i < 7)
				left.push(data[i]);
			else
				right.push(data[i]);
		}
	}
	area0.setpageturndata(left.length,parseInt(pageCount));
    area1.setpageturndata(right.length,parseInt(pageCount));
	setValue(left,right);

}

function setValue(left,right)
{

	for(var i = 0 ;i<area0.doms.length; i ++)
	{
		if(i < left.length)
		{
			//alert(left[i].vodName);
			area0.doms[i].setcontent("",left[i].vodName,18,true,false);
			area0.doms[i].mylink="vod_turnpager.jsp?vodid="+left[i].vodId;
		}
		else
		{
			area0.doms[i].updatecontent("");
		}
	}

	for(var i = 0 ;i< area1.doms.length; i ++)
	{

		if(i < right.length)
		{
			area1.doms[i].setcontent("",right[i].vodName,18,true,false);
			area1.doms[i].mylink="vod_turnpager.jsp?vodid="+right[i].vodId;
		}
		else
		{
			area1.doms[i].updatecontent("");
		}
	}
}

function pagerData(area,pageCount)
{
	var list=new Array();
	var start = (area.curpage-1)*14;
	var size = totalRecord-start;
	for(var i = 0; i <size; i++)
	{
		list[i]=programList[start+i];
	}
	loadData(list,pageCount);
}

function initPage()
{
	area0 = AreaCreator(7,1,new Array(-1,-1,-1,1),"pl","className:search-li on","className:search-li");
	for (var i = 0; i < 7; i++) 
	{
		area0.doms[i].contentdom = $("pl" + i + i);
	}
	area0.asyngetdata=function()
	{
		 area1.curpage = area0.curpage;
		 pagerData(area0,pageCount);
	}
   //area0.stablemoveindex = new Array(-1,-1,-1,"0-0,1-1,2-2,3-3,4-4,5-5,6-6");
    area1 = AreaCreator(7,1,new Array(-1,0,-1,-1),"pr","className:search-li on","className:search-li");
	for (var i = 0; i < 7; i++) 
	{
		area1.doms[i].contentdom = $("pr" + i + i);
	}
	area1.asyngetdata=function()
	{
		 area0.curpage = area1.curpage;
		 pagerData(area1,pageCount);
	}
	//area1.stablemoveindex = new Array(-1,"0-0,1-1,2-2,3-3,4-4,5-5,6-6",-1,-1);
	pageobj = new PageObj(0, 0, new Array(area0,area1));
	pageobj.backurl = "search.jsp?words="+words;
	
	if(pageCount != 0)
		$("pager").innerHTML = area0.curpage + "/" + pageCount;
	$("totalcount").innerHTML = "共搜索到"+totalRecord + "个节目";
	pagerData(area0,pageCount);
	
}
</script>
</head>
<body>



<!--head-->

	<div class="logo">搜索结果</div>

	<div id="currDate" class="date"></div>

	<div class="line"><img src="../images/line.png" width="100%" /></div>

<!--the end-->

<!--point-->

	<div class="point2" id="totalcount"></div>

<!--the end-->
<!--search-list-->

	<div class="search-list" id="left"> <!-- 当前选中为 class="menuli on"-->
		<div><img src="../images/line3.png" /></div>

		<div style="top:1px;" class="search-li on" id="pl0"><div id="pl00"></div></div>

		<div style="top:40px;" ><img src="../images/line3.png" /></div>

		<div style="top:41px;" class="search-li"  id="pl1"><div id="pl11"></div></div>

		<div style="top:80px;"><img src="../images/line3.png" /></div>

		<div style="top:81px;" class="search-li"  id="pl2"><div id="pl22"></div></div>

		<div style="top:120px;"><img src="../images/line3.png" /></div>

		<div style="top:121px;" class="search-li"  id="pl3"><div  id="pl33"></div></div>

		<div style="top:160px;"><img src="../images/line3.png" /></div>

		<div style="top:161px;" class="search-li"  id="pl4"><div id="pl44"></div></div>

		<div style="top:200px;"><img src="../images/line3.png" /></div>

		<div style="top:201px;" class="search-li" id="pl5"><div id="pl55"></div></div>

		<div style="top:240px;"><img src="../images/line3.png" /></div>

		<div style="top:241px;" class="search-li"  id="pl6"><div id="pl66"></div></div>

		<div style="top:280px;"><img src="../images/line3.png" /></div>

	</div>

	<div class="search-list" style="left:310px" id="right"> <!-- 当前选中为 class="menuli current"-->

		<div><img src="../images/line3.png" /></div>

		<div style="top:1px;" class="search-li" id="pr0"><div id="pr00"></div></div>

		<div style="top:40px;"><img src="../images/line3.png" /></div>

		<div style="top:41px;" class="search-li" id="pr1"><div id="pr11"></div></div>

		<div style="top:80px;"><img src="../images/line3.png" /></div>

		<div style="top:81px;" class="search-li" id="pr2"><div id="pr22"></div></div>

		<div style="top:120px;"><img src="../images/line3.png" /></div>

		<div style="top:121px;" class="search-li" id="pr3"><div id="pr33"></div></div>

		<div style="top:160px;"><img src="../images/line3.png" /></div>

		<div style="top:161px;" class="search-li" id="pr4"><div id="pr44"></div></div>

		<div style="top:200px;"><img src="../images/line3.png" /></div>

		<div style="top:201px;" class="search-li" id="pr5"><div id="pr55"></div></div>

		<div style="top:240px;"><img src="../images/line3.png" /></div>

		<div style="top:241px;" class="search-li" id="pr6"><div id="pr66"></div></div>

		<div style="top:280px;"><img src="../images/line3.png" /></div>
	</div>
	<div class="page" id="pager"></div>
<!--the end-->
<!--footer-->

	<div class="line" style="top:467px"><img src="../images/line.png" width="100%" /></div>

	<div class="direction">	
	<div><img src="../images/iconb01.png" /></div>	
	<div style=" top:5px;left:60px;">选择节目</div>
	<div style=" top:5px;left:182px;"><img src="../images/btn-page.png" /></div>	
	<div style=" top:5px;left:285px;">翻页</div>		
	</div>

<!--the end-->	

</body>
<%@ include file="servertimehelp.jsp" %>
</html>
