<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>高清尊享新增二级栏目列表页-深圳IP电视高清专区EPG3.0</title>
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
<%@ include file="datajsp/hd-listdata.jsp"%>
<script type="text/javascript" src="../js/pagecontrol_play.js"></script>
<script type="text/javascript">
var area0,area1,area2,area3,area4,area5;
var tempdata = [{"typename":"新闻啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊频道","typeid":"001"},{"typename":"金色童年","typeid":"002"},{"typename":"最新上线","typeid":"003"},{"typename":"电影天地","typeid":"004"},{"typename":"电视剧集","typeid":"005"}];
var areaid = 0,indexid = 3;
window.onload = function(){	
	area0=AreaCreator(8,1,new Array(-1,-1,-1,1),"area0_list_","className:item item_focus","className:item");
	for(var i=0;i<area0.doms.length;i++){
		area0.doms[i].contentdom = $("area0_txt_"+i);
	}
	area0.setstaystyle("className:item item_focus",3);

	area1=AreaCreator(1,3,new Array(-1,0,3,2),"area1_list_","className:item item_focus","className:item");
	area1.doms[0].domOkEvent = function(){
		nextPage();
		pageobj.changefocus(0,0);
	}
	area1.doms[1].domOkEvent = function(){
		prevPage();
		pageobj.changefocus(0,1);
	}
	area1.doms[2].domOkEvent = function(){
		goBack();
	}
	
	area1.stablemoveindex=new Array(-1,-1,-1,-1);
	
	area2=AreaCreator(1,1,new Array(-1,1,3,-1),"area2_list_","className:item item_focus","className:item");
	area2.stablemoveindex=new Array(-1,"0-2",-1,-1);
	area2.doms[0].contentdom=$("area2_list_0");
	area2.areaInedEvent = function(){
		area2.doms[0].updatecontent("");
	}
	area2.numType = function(num){
		var txt = $("area2_list_0").innerHTML;
		if(txt.length<2){
			area2.doms[0].updatecontent(txt+num);
		}else{
			area2.doms[0].updatecontent(num);
		}
	}
	area2.doms[0].domOkEvent = function(){
		var num = parseInt($("area2_list_0").innerHTML);
		if(!isNaN(num)){
			jumpPage(num);
		}
	}
	area3=AreaCreator(9,1,new Array(1,0,4,-1),"area3_list_","className:item item_focus","className:item");
	area3.stablemoveindex=new Array(-1,-1,-1,-1);
	for(var i=0;i<area3.doms.length;i++){
		area3.doms[i].contentdom = $("area3_txt_"+i);
	}
	/*area2.changefocusedEvent = function(){
		area5.doms[0].updateimg(datalist[area2.curindex].PICURL);
		area5.doms[0].mylink = "vod_redirect.jsp?vodid="+datalist[area2.curindex].VODID+"&typename="+typename+"&returnurl="+escape(location.href);
	}*/
	area4=AreaCreator(1,3,new Array(3,0,-1,5),"area4_list_","className:item item_focus","className:item");
	area4.stablemoveindex=new Array("0-8",-1,-1,-1);
	area4.doms[0].domOkEvent = function(){
		nextPage();
		pageobj.changefocus(3,0);
	}
	area4.doms[1].domOkEvent = function(){
		prevPage();
		pageobj.changefocus(3,1);
	}
	area4.doms[2].domOkEvent = function(){
		goBack();
	}
	area5=AreaCreator(1,1,new Array(3,4,-1,-1),"area5_list_","className:item item_focus","className:item");
	area5.stablemoveindex=new Array("0-8","0-2",-1,-1);
	area5.areaInedEvent = function(){
		area5.doms[0].updatecontent("");
	}
	area5.numType = function(num){
		var txt = $("area5_list_0").innerHTML;
		if(txt.length<2){
			area5.doms[0].updatecontent(txt+num);
		}else{
			area5.doms[0].updatecontent(num);
		}
	}
	area5.doms[0].domOkEvent = function(){
		var num = parseInt($("area5_list_0").innerHTML);
		if(!isNaN(num)){
			jumpPage(num);
		}
	}
	if(focusObj!=undefined&&focusObj!="null"){
		areaid = parseInt(focusObj[0].areaid);
		indexid = parseInt(focusObj[0].curindex);
		curpage = parseInt(focusObj[0].curpage);
	}
	pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area0, area1, area2, area3, area4, area5));
	area3.areaOkEvent=function(){
		area3.curpage = curpage;
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
	//initPage();
}

function bindarea0data(num){
	if(num == 0){
		var temp1 = tempdata[tempdata.length - 1];
		tempdata.splice(0,0,temp1);		
		tempdata.splice(tempdata.length - 1,1);
		getdata(tempdata);
		}else if(num == 2){
			var temp2 = tempdata[0];
			tempdata.splice(0,1);
			tempdata.push(temp2);
			getdata(tempdata);	
			}else{
				 getdata(tempdata);
				}
	}
function getdata(data){
		for(var i = 0; i < area0.doms.length; i++){
			if(i < data.length && data[i] != null){
				area0.doms[i].setcontent("",data[i].typename,12,true,false);
			}else{
				area0.doms[i].updatecontent("");
				}
			}
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
	<div class="txt txt-b">高清&nbsp;<span>娱乐</span></div>
</div>

<div class="adfont"><img src="../images/adfont.png" /></div>
<!--head the end-->	



<!--nav-->	
<div class="nav">
	<!--<div class="item item_focus" style="top:292px;"></div>--> <!--焦点移动层-->
	<!--焦点 
			class="item item_focus"
		-->
	<div id="area0_list_0" class="item">
		<div id="area0_txt_0" class="txt">最新上线</div>
	</div>
	<div id="area0_list_1" class="item" style="top:70px;">
		<div id="area0_txt_1" class="txt">演唱会</div>
	</div>
	<div id="area0_list_2" class="item" style="top:140px;">
		<div id="area0_txt_2" class="txt">动作警匪</div>
	</div>
	<div id="area0_list_3" class="item" style="top:210px;">
		<div id="area0_txt_3" class="txt">2013快乐男声</div>
	</div>
	<div id="area0_list_4" class="item" style="top:280px;">
		<div id="area0_txt_4" class="txt">喜剧搞笑</div>
	</div>
	<div id="area0_list_5" class="item" style="top:350px;">
		<div id="area0_txt_5" class="txt">战争戏剧</div>
	</div>
	<div id="area0_list_6" class="item" style="top:420px;">
		<div id="area0_txt_6" class="txt">动作电影</div>
	</div>
	<div id="area0_list_7" class="item" style="top:490px;">
		<div id="area0_txt_7" class="txt">动作电影</div>
	</div>
</div>
<!--nav the end-->	



<!-- mid list-->	
	<!--pages-->
	<div class="pages" style="left:278px;">
		<!--焦点 
			class="item item_focus"
		-->
		<div class="p01">
			<div id="area1_list_0" class="item">
				<div class="icon"><img src="../images/icon-next.png" /></div>
				<div class="txt">下 页</div>
			</div>
		</div>
		<div class="p02">
			<div id="area1_list_1" class="item">
				<div class="icon"><img src="../images/icon-prev.png" /></div>
				<div class="txt">上 页</div>
			</div>
		</div>
		<div class="p03">
			<div id="area1_list_2" class="item">
				<div class="icon"><img src="../images/icon-arrow.png" /></div>
				<div class="txt">返 回</div>
			</div>
		</div>
	</div>

	<!--form-->
	<div class="form" style="left:624px;">
		<div class="txt txt01">跳至</div>
			<!--焦点 
				class="item item_focus"
			-->
		<div class="input">
			<div id="area2_list_0" class="item">34</div>
		</div>
		<div  id="pageContent1" class="txt txt02"> 页 1/64页</div>
	</div>
	
	<!--list-->
	<div class="list list-a">
		<!--焦点 
			class="item item_focus"
		-->
		<div id="area3_list_0" class="item">
			<div class="icon"></div>
			<div id="area3_txt_0" class="txt">第二十二条婚规</div>
		</div>
		<div id="area3_list_1" class="item" style="top:53px;">
			<div class="icon"></div>
			<div id="area3_txt_1" class="txt">黄铜茶壶</div>
		</div>
		<div id="area3_list_2" class="item" style="top:106px;">
			<div class="icon"></div>
			<div id="area3_txt_2" class="txt">爱神来了</div>
		</div>
		<div id="area3_list_3" class="item" style="top:159px;">
			<div class="icon"></div>
			<div id="area3_txt_3" class="txt">爱神来了爱神来了爱神来了爱神来</div>
		</div>
		<div id="area3_list_4" class="item" style="top:212px;">
			<div class="icon"></div>
			<div id="area3_txt_4" class="txt">爱神来了</div>
		</div>
		<div id="area3_list_5" class="item" style="top:265px;">
			<div class="icon"></div>
			<div id="area3_txt_5" class="txt">爱神来了</div>
		</div>
		<div id="area3_list_6" class="item" style="top:318px;">
			<div class="icon"></div>
			<div id="area3_txt_6" class="txt">钢铁侠3</div>
		</div>
		<div id="area3_list_7" class="item" style="top:371px;">
			<div class="icon"></div>
			<div id="area3_txt_7" class="txt">爱神来了</div>
		</div>
		<div id="area3_list_8" class="item" style="top:424px;">
			<div class="icon"></div>
			<div id="area3_txt_8" class="txt">爱神来了</div>
		</div>
	</div>
	
	<!--pages-->
	<div class="pages" style=" left:278px;top:649px;">
		<!--焦点 
			class="item item_focus"
		-->
		<div class="p01">
			<div id="area4_list_0" class="item">
				<div class="icon"><img src="../images/icon-next.png" /></div>
				<div class="txt">下 页</div>
			</div>
		</div>
		<div class="p02">
			<div id="area4_list_1" class="item">
				<div class="icon"><img src="../images/icon-prev.png" /></div>
				<div class="txt">上 页</div>
			</div>
		</div>
		<div class="p03">
			<div id="area4_list_2" class="item">
				<div class="icon"><img src="../images/icon-arrow.png" /></div>
				<div class="txt">返 回</div>
			</div>
		</div>
	</div>
	
	<!--form-->
	<div class="form" style="left:624px;top:649px;">
		<div class="txt txt01">跳至</div>
			<!--焦点 
				class="item item_focus"
			-->
		<div class="input">
			<div id="area5_list_0" class="item">34</div>
		</div>
		<div id="pageContent2" class="txt txt02"> 页 1/64页</div>
	</div>
<!-- mid list the end-->	

	
	
<!--r poster-->	
<div class="poster-c">
	<!--焦点 
		class="item item_focus"
	-->
	<div class="item">
		<div class="pic"><img id="showPIC" src="../images/demopic/pic-391X515.jpg" /></div>
	</div>
</div>
<!--r poster the end-->		
	
	
</body>
</html>
