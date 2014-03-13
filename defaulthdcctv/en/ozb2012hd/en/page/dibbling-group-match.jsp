<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视欧洲杯高清3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<script src="../js/pagecontrolx.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
var returnurl = '<%=request.getParameter("returnurl")%>';
var area0,area1,area2;
window.onload = function() {
	initPage();
}
function initPage() {
	  area0 = AreaCreator(1,6,new Array(-1,-1,1,-1),"menu_a","afocus","ablur");
	  area0.setfocuscircle(1);
	  area0.doms[0].mylink="index.jsp";
	  area0.doms[2].mylink="video.jsp";
	  area0.doms[3].mylink="star.jsp";
	  area0.doms[4].mylink="archer-rank.jsp";
	  area0.doms[5].mylink="search.jsp";
	  area0.setstaystyle("className:",2);
	  
	  area1 =  AreaCreator(1,2,new Array(0, -1, 2, -1),"match_a","afocus","ablur");
	  area1.setstaystyle("className:", 2);
	  
	  area2 =  AreaCreator(2, 2, new Array(1, -1, -1, -1),"postpic_a","afocus","ablur");
	  area0.setfocuscircle(1);
	  
	  pageobj = new PageObj(new Array(area0,area1,area2));
	 
	 
}
</script>
<style type="text/css">
<!--
	body{ background:url(../images/bg3.jpg) no-repeat;}

-->
</style>
</head>

<body>

<!--head-->
	<div class="date">17:30</div>
	
	<!--menu-->
	<div class="menu"> <!--当前选中为 class="item wid* item-select"；2字宽为wid1;3字宽为wid2,4字宽为wid3--> 
		<div class="item wid1">
			<div class="link"><a href="#" id="menu_a0"><img src="../images/t.gif" /></a></div>
            <div class="txt">首页</div>
		</div>               
		<div class="item wid3 item-select" style="left:128px;">
			<div class="link"><a href="#" id="menu_a1"><img src="../images/t.gif" /></a></div>
            <div class="txt">赛事点播</div>
		</div>
		<div class="item wid3" style="left:346px;">
			<div class="link"><a href="#" id="menu_a2"><img src="../images/t.gif" /></a></div>
            <div class="txt">精彩视频</div>
		</div>
		<div class="item wid3" style="left:564px;">
			<div class="link"><a href="#" id="menu_a3"><img src="../images/t.gif" /></a></div>
            <div class="txt">球星殿堂</div>	
		</div>
		<div class="item wid2" style="left:782px;">
			<div class="link"><a href="#" id="menu_a4"><img src="../images/t.gif" /></a></div>
            <div class="txt">射手榜</div>	
		</div>
		<div class="item wid1" style="left:952px;">
			<div class="link"><a href="#" id="menu_a5"><img src="../images/t.gif" /></a></div>
            <div class="txt">搜索</div>
		</div>
	</div>
<!--the end-->


	
	
<!--小组赛-->
<div class="dibbling-sub"> <!--默认为 class="item" , 当前选中为 class="item item-select"-->
	<div class="item item-select">
		<div class="link"><a href="#" id="match_a0"><img src="../images/t.gif" /></a></div>
		<div class="txt">小组赛</div>
	</div>
	<div class="item" style="left:230px;">
		<div class="link"><a href="#" id="match_a1"><img src="../images/t.gif" /></a></div>
		<div class="txt">淘汰赛</div>
	</div>
</div>
<!--the end-->	




<!--推荐区-->
<div class="dibbling-recommend">  
	<div class="item">
		<div class="link"><a href="#" id="postpic_a0"><img src="../images/t.gif" /></a></div>
     	<div class="pic"><img src="../images/temp/pic-539X205.png" /></div>
	</div>
	<div class="item" style="left:598px;">
		<div class="link"><a href="#" id="postpic_a1"><img src="../images/t.gif" /></a></div>
     	<div class="pic"><img src="../images/temp/pic-539X205.png" /></div>
	</div>
	<div class="item" style="top:250px;">
		<div class="link"><a href="#" id="postpic_a2"><img src="../images/t.gif" /></a></div>
     	<div class="pic"><img src="../images/temp/pic-539X205.png" /></div>
	</div>
	<div class="item" style="left:598px;top:250px;">
		<div class="link"><a href="#" id="postpic_a3"><img src="../images/t.gif" /></a></div>
     	<div class="pic"><img src="../images/temp/pic-539X205.png" /></div>
	</div>
</div>
<!--the end-->	
		
</body>
</html>
