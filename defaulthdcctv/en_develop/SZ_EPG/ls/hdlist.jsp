<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>高清大片-上海电信应用商城EPG3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<style type="text/css">
<!--
	body{ background:url(../images/bg02.jpg) no-repeat;}
-->
</style>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="util/save_focus.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<%@ include file="datajsp/hdlistdata.jsp"%>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
var area0,area1,area2,area3,area4,area5;
var areaid = 0,indexid = 0;
window.onload = function(){	
	area0=AreaCreator(1,3,new Array(-1,-1,2,1),"area0_list_","className:item item_focus","className:item");
	area0.doms[0].domOkEvent = function(){
		nextPage();
		pageobj.changefocus(0,0);
	}
	area0.doms[1].domOkEvent = function(){
		prevPage();
		pageobj.changefocus(0,1);
	}
	area0.doms[2].domOkEvent = function(){
		goBack();
	}
	area1=AreaCreator(1,1,new Array(-1,0,2,-1),"area1_list_","className:item item_focus","className:item");
	area1.stablemoveindex=new Array(-1,"0-2","0-1",-1);
	area1.doms[0].contentdom=$("area1_list_0");
	area1.areaInedEvent = function(){
		area1.doms[0].updatecontent("");
	}
	area1.numType = function(num){
		var txt = $("area1_list_0").innerHTML;
		if(txt.length<2){
			area1.doms[0].updatecontent(txt+num);
		}else{
			area1.doms[0].updatecontent(num);
		}
	}
	area1.doms[0].domOkEvent = function(){
		var num = parseInt($("area1_list_0").innerHTML);
		if(!isNaN(num)){
			jumpPage(num);
		}
	}
	area2=AreaCreator(9,2,new Array(0,-1,3,-1),"area2_list_","className:item item_focus","className:item");
	area2.stablemoveindex=new Array("0-0>0,1-1>0",-1,"16-3>0,17-4>0",-1);
	//area2.setstaystyle("className:item",3);
	for(var i=0;i<area2.doms.length;i++){
		area2.doms[i].contentdom = $("area2_txt_"+i);
	}
	area2.changefocusedEvent = function(){
		area5.doms[0].updateimg(datalist[area2.curindex].PICURL);
		area5.doms[0].mylink = "vod_redirect.jsp?vodid="+datalist[area2.curindex].VODID+"&typename="+typename+"&returnurl="+escape(location.href);
	}
	area3=AreaCreator(1,3,new Array(2,-1,-1,4),"area3_list_","className:item item_focus","className:item");
	area3.stablemoveindex=new Array("0-16",-1,-1,-1);
	area3.doms[0].domOkEvent = function(){
		nextPage();
		pageobj.changefocus(3,0);
	}
	area3.doms[1].domOkEvent = function(){
		prevPage();
		pageobj.changefocus(3,1);
	}
	area3.doms[2].domOkEvent = function(){
		goBack();
	}
	area4=AreaCreator(1,1,new Array(2,3,-1,-1),"area4_list_","className:item item_focus","className:item");
	area4.stablemoveindex=new Array("0-17","0-2",-1,-1);
	area4.areaInedEvent = function(){
		area4.doms[0].updatecontent("");
	}
	area4.numType = function(num){
		var txt = $("area4_list_0").innerHTML;
		if(txt.length<2){
			area4.doms[0].updatecontent(txt+num);
		}else{
			area4.doms[0].updatecontent(num);
		}
	}
	area4.doms[0].domOkEvent = function(){
		var num = parseInt($("area4_list_0").innerHTML);
		if(!isNaN(num)){
			jumpPage(num);
		}
	}
	area5=AreaCreator(1,1,new Array(-1,2,-1,-1),"area5_list_","className:item item_focus","className:item");
	area5.doms[0].imgdom=$("area5_img_0");
	if(focusObj!=undefined&&focusObj!="null"){
		areaid = parseInt(focusObj[0].areaid);
		indexid = parseInt(focusObj[0].curindex);
		curpage = parseInt(focusObj[0].curpage);
	}
	pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area0, area1, area2, area3, area4, area5));
	area2.areaOkEvent=function(){
		area2.curpage = curpage;
		saveFocstr(pageobj);  
	}
	pageobj.backurl = returnurl;
	pageobj.pageTurn = function(num){
		if(num == 1){
			nextPage();
		}else if(num == -1){
			prevPage();
		}
	}
	initPage();
}

function initPage(){
	$("typename").innerHTML = typename.substring(0,2)+"&nbsp;<span>"+typename.substring(2)+"</span>";
	area2.datanum = datalist.length;
	if(areaid!=0){
		area5.doms[0].updateimg(datalist[area2.curindex].PICURL);
	}else{
		area5.doms[0].updateimg(defaultpic);
	}
	if(datalist.length>0){
		for(var i=0;i<area2.doms.length;i++){
			if(i<datalist.length){
				$("area2_list_"+i).style.display = "block";
				area2.doms[i].setcontent("",datalist[i].VODNAME,26,true,true);
				area2.doms[i].mylink = "vod_redirect.jsp?vodid="+datalist[i].VODID+"&typeid="+typeid+"&returnurl="+escape(location.href);
			}else{
				$("area2_list_"+i).style.display = "none";
				area2.doms[i].updatecontent("");
				area2.doms[i].mylink = "#";
			}
		}
		var pageinfo = " 页 "+curpage+"/"+pagecount+"页";
		$("pageinfo1").innerHTML = pageinfo;
		$("pageinfo2").innerHTML = pageinfo;
	}
}

function initData(){
	area2.datanum = datalist.length;
	if(datalist.length>0){
		if(area2.curindex>datalist.length-1)		
			pageobj.changefocus(2,0);
		area5.doms[0].updateimg(datalist[area2.curindex].PICURL);
		//area5.doms[0].mylink = "vod_redirect.jsp?vodid="+datalist[area2.curindex].VODID+"&typename="+typename+"&returnurl="+escape(location.href);
		for(var i=0;i<area2.doms.length;i++){
			if(i<datalist.length){
				$("area2_list_"+i).style.display = "block";
				area2.doms[i].setcontent("",datalist[i].VODNAME,26,true,true);
				area2.doms[i].mylink = "vod_redirect.jsp?vodid="+datalist[i].VODID+"&typeid="+typeid+"&returnurl="+escape(location.href);
			}else{
				$("area2_list_"+i).style.display = "none";
				area2.doms[i].updatecontent("");
				area2.doms[i].mylink = "#";
			}
		}
		var pageinfo = " 页 "+curpage+"/"+pagecount+"页";
		$("pageinfo1").innerHTML = pageinfo;
		$("pageinfo2").innerHTML = pageinfo;
	}
}

function loadIframeData(){
	dataFrame.location.href = "<%=path%>datajsp/hdlist_iframedata.jsp?typeid="+typeid+"&curpage="+curpage;
}

function jumpPage(num){
	if(num<1||num>pagecount)
		return;
	curpage = num;
	loadIframeData();
}

function nextPage(){
	if(curpage >= pagecount)
		return;
	jumpPage(curpage+1);
}

function prevPage(){
	if(curpage <= 1)
		return;
	jumpPage(curpage-1);
}

function goBack(){
	window.location.href = pageobj.backurl;
}
</script>
</head>

<body>

<!--head-->
<div class="logo">
	<div class="pic"><img src="../images/logo.png" /></div>
	<div class="txt txt-b" id="typename"></div>
</div>

<div class="adfont"><img src="../images/adfont.png" /></div>
<!--head the end-->	


<!--left list-->	
	<!--pages-->
	<div class="pages">
		<!--焦点 
			class="item item_focus"
		-->
		<div class="p01">
			<div class="item" id="area0_list_0">
				<div class="icon"><img src="../images/icon-next.png" /></div>
				<div class="txt">下 页</div>
			</div>
		</div>
		<div class="p02">
			<div class="item" id="area0_list_1">
				<div class="icon"><img src="../images/icon-prev.png" /></div>
				<div class="txt">上 页</div>
			</div>
		</div>
		<div class="p03">
			<div class="item" id="area0_list_2">
				<div class="icon"><img src="../images/icon-arrow.png" /></div>
				<div class="txt">返 回</div>
			</div>
		</div>
	</div>

	<!--form-->
	<div class="form">
		<div class="txt txt01">跳至</div>
			<!--焦点 
				class="item item_focus"
			-->
		<div class="input">
			<div class="item" id="area1_list_0"></div>
		</div>
		<div class="txt txt02" id="pageinfo1"></div>
	</div>
	
	<!--list-->
	<div class="list">
		<!--焦点 
			class="item item_focus"
		-->
		<div class="item" id="area2_list_0">
			<div class="icon"></div>
			<div class="txt" id="area2_txt_0"></div>
		</div>
		<div class="item" style="left:383px;" id="area2_list_1">
			<div class="icon"></div>
			<div class="txt" id="area2_txt_1"></div>
		</div>
		<div class="item" style="top:53px;" id="area2_list_2">
			<div class="icon"></div>
			<div class="txt" id="area2_txt_2"></div>
		</div>
		<div class="item" style="left:383px;top:53px;" id="area2_list_3">
			<div class="icon"></div>
			<div class="txt" id="area2_txt_3"></div>
		</div>
		<div class="item" style="top:106px;" id="area2_list_4">
			<div class="icon"></div>
			<div class="txt" id="area2_txt_4"></div>
		</div>
		<div class="item" style="left:383px;top:106px;" id="area2_list_5">
			<div class="icon"></div>
			<div class="txt" id="area2_txt_5"></div>
		</div>
		<div class="item" style="top:159px;" id="area2_list_6">
			<div class="icon"></div>
			<div class="txt" id="area2_txt_6"></div>
		</div>
		<div class="item" style="left:383px;top:159px;" id="area2_list_7">
			<div class="icon"></div>
			<div class="txt" id="area2_txt_7"></div>
		</div>
		<div class="item" style="top:212px;" id="area2_list_8">
			<div class="icon"></div>
			<div class="txt" id="area2_txt_8"></div>
		</div>
		<div class="item" style="left:383px;top:212px;" id="area2_list_9">
			<div class="icon"></div>
			<div class="txt" id="area2_txt_9"></div>
		</div>
		<div class="item" style="top:265px;" id="area2_list_10">
			<div class="icon"></div>
			<div class="txt" id="area2_txt_10"></div>
		</div>
		<div class="item" style="left:383px;top:265px;" id="area2_list_11">
			<div class="icon"></div>
			<div class="txt" id="area2_txt_11"></div>
		</div>
		<div class="item" style="top:318px;" id="area2_list_12">
			<div class="icon"></div>
			<div class="txt" id="area2_txt_12"></div>
		</div>
		<div class="item" style="left:383px;top:318px;" id="area2_list_13">
			<div class="icon"></div>
			<div class="txt" id="area2_txt_13"></div>
		</div>
		<div class="item" style="top:371px;" id="area2_list_14">
			<div class="icon"></div>
			<div class="txt" id="area2_txt_14"></div>
		</div>
		<div class="item" style="left:383px;top:371px;" id="area2_list_15">
			<div class="icon"></div>
			<div class="txt" id="area2_txt_15"></div>
		</div>
		<div class="item" style="top:424px;" id="area2_list_16">
			<div class="icon"></div>
			<div class="txt" id="area2_txt_16"></div>
		</div>
		<div class="item" style="left:383px;top:424px;" id="area2_list_17">
			<div class="icon"></div>
			<div class="txt" id="area2_txt_17"></div>
		</div>
	</div>
	
	<!--pages-->
	<div class="pages" style="top:649px;">
		<!--焦点 
			class="item item_focus"
		-->
		<div class="p01">
			<div class="item" id="area3_list_0">
				<div class="icon"><img src="../images/icon-next.png" /></div>
				<div class="txt">下 页</div>
			</div>
		</div>
		<div class="p02">
			<div class="item" id="area3_list_1">
				<div class="icon"><img src="../images/icon-prev.png" /></div>
				<div class="txt">上 页</div>
			</div>
		</div>
		<div class="p03">
			<div class="item" id="area3_list_2">
				<div class="icon"><img src="../images/icon-arrow.png" /></div>
				<div class="txt">返 回</div>
			</div>
		</div>
	</div>
	
	<!--form-->
	<div class="form" style="top:649px;">
		<div class="txt txt01">跳至</div>
			<!--焦点 
				class="item item_focus"
			-->
		<div class="input">
			<div class="item" id="area4_list_0"></div>
		</div>
		<div class="txt txt02" id="pageinfo2"></div>
	</div>
<!--left list the end-->	

	
<!--r poster-->	
<div class="poster-c">
	<!--焦点 
		class="item item_focus"
	-->
	<div class="item" id="area5_list_0">
		<div class="pic"><img id="area5_img_0"/></div>
	</div>
</div>
<!--r poster the end-->		
	
<iframe name="dataFrame" id="dataFrame" width="0px" height="0px"></iframe>
</body>
</html>
