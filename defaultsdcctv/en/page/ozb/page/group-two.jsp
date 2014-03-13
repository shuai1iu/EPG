<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视欧洲杯 标清EPG 2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<script src="../js/pagecontrol.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
//menu
var area0;
//prev
var area1;
//next
var area2;
//return
var area3;
//list
var area4;
//pic
var area5;
var menuid='<%=request.getParameter("menuid")%>';
var areaid;
var indexid;

	window.onload = function() {
	    refreshServerTime();
		initPage();
	}
	
	function initPage() {
	  area0 = AreaCreator(1,6,new Array(-1,-1,1,-1),"menu_a","afocus","ablur");
	
	  area0.setfocuscircle(1);
	  area0.doms[0].mylink="";
	  area0.doms[1].mylink="group-match.jsp";
	  area0.doms[2].mylink="";
	  area0.doms[3].mylink="";
	  area0.doms[4].mylink="top-scorer.jsp";
	  area0.doms[5].mylink="";
	  area0.setstaystyle("className:",2);
	  //area0.setstaystyle(new Array("className:item wid3 item-select", "className:link offboder"), 2);
	  //prev
	  area1 =  AreaCreator(1,3,new Array(0, 3, 2, 3),"btn","afocus","ablur");
	  area1.areaOkEvent = function()
	  {
	  	alert("button");
	  }
	  
	  /*//next
	  area2 =  AreaCreator(1,1,new Array(0, 1, 4, 3),"btnnext","afocus","ablur");
	  area2.areaOkEvent = function()
	  {
	  	alert("next");
	  }
	  //return
	  area3 =  AreaCreator(1,1,new Array(0, 2, 4, 5),"btnreturn","afocus","ablur");
	  area3.areaOkEvent = function()
	  {
	  	alert("return");
	  }*/
	  area2 =  AreaCreator(12,1,new Array(1, 3, -1, 3),"list_a","afocus","ablur");
	  area2.areaOkEvent = function()
	  {
	  	alert("list");
	  }
	  //pic
	  area3 =  AreaCreator(3,1,new Array(0, 2, -1, 2),"pic_a","afocus","ablur");
	  area3.areaOkEvent = function()
	  {
	  	alert("pic");
	  }
	  area3.setfocuscircle(0);
	
	
	   var tmpMenuId = "1";
	  if(tmpMenuId != null && tmpMenuId !="null")
	  {
	  	tmpMenuId = menuid;
	  	var className = "";
	  	if( tmpMenuId == "1")
	  	{
	  		className = "item wid3 item-select";
	  		$("menu1").className= className;
	  		$("menu4").className= "item wid2";
	    }
	  		
	  	else if(tmpMenuId == "4")
	  	{
	  		className = "item wid2 item-select";
	  		$("menu4").className= className;
	  		$("menu1").className= "item wid3";
	  	}//pageobj.changefocus(0,tmpMenuId,true);
	  	
	  }
	    pageobj = new PageObj(0,parseInt(tmpMenuId), new Array(area0, area1, area2,area3));
 		 pageobj.backurl ="../url.html";
	}
</script>
</head>

<body>

<!--head-->
	<div class="date" id="currDate"></div>
	
	<!--menu-->
	<div class="menu"> <!--当前选中为 class="item wid* item-select"；2字宽为wid1;3字宽为wid2,4字宽为wid3--> 
		<div class="item wid1" id="menu0">
			<div class="link" ><a href="#" id="menu_a0"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="menu00">首页</div>
		</div>               
		<div class="item wid3" style="left:63px;" id="menu1" >
			<div class="link" ><a href="#" id="menu_a1"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="menu11">赛事点播</div>
		</div>
		<div class="item wid3" style="left:172px;" id="menu2">
			<div class="link"  ><a href="#" id="menu_a2"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="menu22">精彩视频</div>
		</div>
		<div class="item wid3" style="left:281px;" id="menu3">
			<div class="link" ><a href="#" id="menu_a3"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="menu33">球星殿堂</div>	
		</div>
		<div class="item wid2" style="left:390px;" id="menu4">
			<div class="link" ><a href="#" id="menu_a4"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="menu44">射手榜</div>	
		</div>
		<div class="item wid1" style="left:475px;" id="menu5">
			<div class="link" ><a href="#" id="menu_a5"><img src="../images/t.gif" /></a></div>
            <div class="txt" id="menu55">搜索</div>
		</div>
	</div>
<!--the end-->

	
	
<!--dibbling-left-pic-list-->
<div class="goals-pic-list">   
	<div class="item item01" id="pic0"> 
		<div class="link"><a href="#" id="pic_a0"><img src="../images/t.gif" /></a></div>
		<div class="pic" id="pic00"><img src="../images/temp/pic-147X204.jpg" /></div>
	</div>
	<div class="item" style="top:222px;" id="pic1">
		<div class="link"><a href="#"  id="pic_a1"><img src="../images/t.gif" /></a></div>
		<div class="pic" id="pic11"><img src="../images/temp/pic-147X95.jpg" /></div>
	</div>
	<div class="item" style="top:333px;" id="pic2">
		<div class="link"><a href="#" id="pic_a2"><img src="../images/t.gif" /></a></div>
		<div class="pic" id="pic22"><img src="../images/temp/pic-147X95.jpg" /></div>
	</div>
</div>
<!--the end-->	




<!--page-->
<div class="page" style=" left:181px; top:89px;">  
	<div class="item" >
		<div class="link" ><a href="#" id="btn0"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img src="../images/btn-prev.png" /></div>
	</div> 
	<div style="left:102px;"  class="item">
		<div class="link" ><a href="#" id="btn1"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img src="../images/btn-next.png" /></div>
	</div>
	<div style="left:195px;" id="pager">1/3页</div>
	<div style="left:364px;" class="item">
		<div class="link" ><a href="#" id="btn2"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img src="../images/btn-retrun.png" /></div>
	</div>
</div>
<!--the end-->



	
<!--dibbling-list-->
<div class="goals-list">
	<div class="con"> 
		<div class="item" id="list0">
			<div class="link"><a href="#" id="list_a0"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="list0_text0">1.&nbsp;幻灯：里贝里穆勒拼抢 完胜拜仁队友后交.</div>
		</div>
		<div class="item" style="top:32px;" id="list1">
			<div class="link"><a href="#" id="list_a1"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="list1_text1">2.&nbsp;勒夫直言不满输球过程</div>
		</div>
		<div class="item" style="top:64px;" id="list2">
			<div class="link"><a href="#" id="list_a2""><img src="../images/t.gif" /></a></div>
			<div class="txt" id="list2_text2">3.&nbsp;众新秀急躁反衬黑珍珠可靠</div>
		</div>
		<div class="item" style="top:96px;" id="list3">
			<div class="link"><a href="#" id="list_a3"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="list3_text3">4.&nbsp;穆勒：全队踢球几无章法.</div>
		</div>
		<div class="item" style="top:128px;" id="list4">
			<div class="link"><a href="#" id="list_a4"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="list4_text4">5.&nbsp;勒夫直言不满输球过程</div>
		</div>
		<div class="item" style="top:160px;" id="list5">
			<div class="link"><a href="#" id="list_a5"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="list5_text5">6.&nbsp;三狮新帅叹球队太稚嫩</div>
		</div>
		<div class="item" style="top:192px;" id="list6">
			<div class="link"><a href="#" id="list_a6"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="list6_text6">7.&nbsp;全队踢球几无章法</div>
		</div>
		<div class="item" style="top:224px;" id="list7">
			<div class="link"><a href="#" id="list_a7" ><img src="../images/t.gif" /></a></div>
			<div class="txt" id="list7_text7">8.&nbsp;全队踢球几无章法</div>
		</div>
		<div class="item" style="top:256px;" id="list8">
			<div class="link"><a href="#" id="list_a8"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="list8_text8">9.&nbsp;全队踢球几无章法</div>
		</div>
		<div class="item" style="top:288px;" id="list9">
			<div class="link"><a href="#" id="list_a9"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="list9_text9">10.&nbsp;全队踢球几无章法</div>
		</div>
		<div class="item" style="top:320px;" id="list10">
			<div class="link"><a href="#" id="list_a10"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="list10_text10">11.&nbsp;全队踢球几无章法</div>
		</div>
		<div class="item" style="top:352px;" id="list11">
			<div class="link"><a href="#" id="list_a11"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="list11_text11">12.&nbsp;全队踢球几无章法</div>
		</div>
	</div>
</div>
<!--the end-->	

<%@ include file="servertimehelp.jsp"%>
		
</body>
</html>