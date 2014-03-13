<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file="datajsp/group-match-data.jsp"%>
<%@ include file="util/save_focus.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视欧洲杯高清3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<style type="text/css">
<!--
	body{ background:url(../images/bg4.jpg) no-repeat;}
-->
</style>
<script src="../js/pagecontrolx.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
var returnurl = '<%=request.getParameter("returnurl")%>';
var area0,area1,area2,area3,area4;
var areaid;
var indexid;
window.onload = function() {
	initPage();
}
function initPage() {
	area0 = AreaCreator(1,6,new Array(-1,-1,1,-1),"menu_a","afocus","ablur");
	area0.setfocuscircle(1);
	area0.doms[0].mylink="index.jsp";
	area0.doms[2].mylink="video.jsp";
	area0.doms[3].mylink="star.jsp";
	area0.doms[4].mylink="top-scorer.jsp";
	area0.doms[5].mylink="search.jsp";
	area0.setstaystyle("className:",2);
	
	area1 =  AreaCreator(1,2,new Array(0, -1, 2, -1),"match_a","afocus","ablur");
	area1.setstaystyle("className:", 2);
	area1.setfocuscircle(1);
	
	area2 =  AreaCreator(1, 2, new Array(1, -1, 3, 3),"area2_team_a","afocus","ablur");
	area2.stablemoveindex = new Array(-1,-1,"1-2",-1);
	
	area3 =  AreaCreator(1, 3, new Array(2, -1, 4, 4),"area3_team_a","afocus","ablur");
	area3.stablemoveindex = new Array("2-1",-1,"2-1",-1);
	
	area4 =  AreaCreator(1, 2, new Array(3, -1, 2, 2),"area4_team_a","afocus","ablur");
	area4.stablemoveindex = new Array("1-2",-1,-1,-1);
	pageobj = new PageObj(new Array(area0, area1, area2,area3,area4));
	  if(returnurl != null && returnurl != undefined && returnurl != "" && returnurl != "null")
	  {
	    	pageobj.backurl = "../url.html";
	  }else
	  {
	  		pageobj.backurl = "index.jsp";
	  }	
}
</script>
</head>

<body>

<!--head-->
	<div class="date">17:30</div>
	
	<!--menu-->
	<div class="menu"> <!--当前选中为 class="item wid* item-select"；2字宽为wid1;3字宽为wid2,4字宽为wid3--> 
		<div class="item wid1">
			<div class="link"><a href="#" id="menu_a0"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="menu00">首页</div>
		</div>               
		<div class="item wid3 item-select" style="left:128px;">
			<div class="link"><a href="#" id="menu_a1"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="menu11">赛事点播</div>
		</div>
		<div class="item wid3" style="left:346px;">
			<div class="link"><a href="#" id="menu_a2"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="menu22">精彩视频</div>
		</div>
		<div class="item wid3" style="left:564px;">
			<div class="link"><a href="#" id="menu_a3"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="menu33">球星殿堂</div>	
		</div>
		<div class="item wid2" style="left:782px;">
			<div class="link"><a href="#" id="menu_a4"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="menu44">射手榜</div>	
		</div>
		<div class="item wid1" style="left:952px;">
			<div class="link"><a href="#" id="menu_a5"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="menu55">搜索</div>
		</div>
	</div>
<!--the end-->


	
	
<!--淘汰赛-->
<div class="dibbling-sub"> <!--默认为 class="item" , 当前选中为 class="item item-select"-->
	<div class="item" id="match0">
		<div class="link"><a href="#"  id="match_a0"><img src="../images/t.gif" /></a></div>
		<div class="txt">小组赛</div>
	</div>
	<div class="item item-select" style="left:230px;" id="match1">
		<div class="link"><a href="#"  id="match_a1"><img src="../images/t.gif" /></a></div>
		<div class="txt">淘汰赛</div>
	</div>
</div>
<!--the end-->	




<!--词条-->
<div class="knockout-list">   
	<div class="item item01" id="area2_team0">
		<div class="link"><a href="#" id="area2_team_a0"><img src="../images/t.gif" /></a></div>
        <div class="txt" id="area2_team00">克罗地亚VS意大利</div>
	</div>
	<div class="item item01" style="left:995px;" id="area2_team1">
		<div class="link"><a href="#" id="area2_team_a1"><img src="../images/t.gif" /></a></div>
        <div class="txt" id="area2_team11">荷兰VS葡萄牙</div>
	</div>
	<div class="item item02" style="left:126px; top:165px;" id="area3_team0">
		<div class="link"><a href="#" id="area3_team_a0"><img src="../images/t.gif" /></a></div>
        <div class="txt" id="area3_team00">德国VS意大利</div>
	</div>
	<div class="item item03" style="left:482px; top:127px;" id="area3_team1">
		<div class="link"><a href="#" id="area3_team_a1"><img src="../images/t.gif" /></a></div>
        <div class="txt" id="area3_team11">德国VS荷兰</div>
	</div>
	<div class="item item02" style="left:829px; top:165px;" id="area3_team2">
		<div class="link"><a href="#" id="area3_team_a2"><img src="../images/t.gif" /></a></div>
        <div class="txt" id="area3_team22">荷兰VS英格兰</div>
	</div>
	<div class="item item01" style="top:337px;" id="area4_team0">
		<div class="link"><a href="#" id="area4_team_a0"><img src="../images/t.gif" /></a></div>
        <div class="txt" id="area4_team00">德国VS法国</div>
	</div>
	<div class="item item01" style="left:995px; top:337px;" id="area4_team1">
		<div class="link"><a href="#" id="area4_team_a1"><img src="../images/t.gif" /></a></div>
        <div class="txt" id="area4_team11">英格兰VS希腊</div>
	</div>
</div>
<!--the end-->	
		
</body>
</html>
