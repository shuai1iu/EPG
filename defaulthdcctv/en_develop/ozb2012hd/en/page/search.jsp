﻿<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视欧洲杯高清3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<%@ include file="util/save_focus.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<%@ include file="datajsp/search_data.jsp"%>
<script type="text/javascript" src="../js/pagecontrolx.js"></script>
<script type="text/javascript">

	//--common var S
	var areaid=0,indexid=5;
	var area0,area1,area2,area3,area4,area5,area6;
	//--common var E
	
	window.onload=function(){
		//--area0 S 上部导航栏
		area0=AreaCreator(1,6,new Array(-1,-1,(jHotkeywords!=undefined&&jHotkeywords!="null")?1:3,-1),"area0_list_","afocus","ablur");
		area0.setfocuscircle(1);
		area0.setstaystyle("className:",2);
		area0.stablemoveindex=new Array(-1,-1,"1-3>0,2-3>3,3-3>6,4-2>0,5-2>0",-1);		
		//--area0 E
		
		//--area1 S 左热词
		area1=AreaCreator(3,1,new Array(0,-1,6,3),"area1_list_","afocus","ablur");
		area1.setstaystyle("className:",3);
		area1.stablemoveindex=new Array(-1,-1,-1,"2-5>0");
		for(var i=0,l=area1.doms.length;i<l;i++){area1.doms[i].contentdom = $("area1_content_"+i);}
		area1.areaOkEvent = function(){
			keyword = this.doms[this.curindex].youwanauseobj;
			hotkeyword = jHotkeywords[this.curindex].TYPE_NAME;
			getAJAXData("datajsp/search_data_iframe.jsp?keyword="+keyword,bindData);
			$("hotkeyword").innerHTML = hotkeyword;
		}
		//--area1 E
		
		//--area2 S 搜索按钮
		area2=AreaCreator(1,1,new Array(0,1,4,-1),"area2_list_","afocus","ablur");
		area2.areaOkEvent = function(){
			getAJAXData("datajsp/search_data_iframe.jsp?keyword="+keyword,bindData);
		}
		//--area2 E
		
		//--area3 S 数字按钮
		area3=AreaCreator(1,10,new Array(2,1,5,4),"area3_list_","afocus","ablur");
		area3.stablemoveindex=new Array(-1,-1,"1-1,2-2,3-3,4-4,5-5,6-6,7-7,8-8,9-9",-1);
		area3.areaOkEvent = function(){
			if($("hotkeyword").innerHTML.length <9){
				var addstr = this.doms[this.curindex].contentdom.innerHTML;				
				hotkeyword += addstr;
		   		$("hotkeyword").innerHTML = hotkeyword;
				keyword += addstr;
		   }
		}
		for(var i=0,l=area3.doms.length;i<l;i++){area3.doms[i].contentdom = $("area3_content_"+i);}
		//--area3 E
		
		//--area4 S 删除按钮
		area4=AreaCreator(1,1,new Array(2,3,5,-1),"area4_list_","afocus","ablur");
		area4.stablemoveindex=new Array(-1,"0-9","0-10",-1);
		area4.areaOkEvent = function(){
			if(hotkeyword.length>0){
				hotkeyword = hotkeyword.substr(0,hotkeyword.length-1);
				$("hotkeyword").innerHTML = hotkeyword;
				keyword = keyword.substr(0,keyword.length-1);
			}
		}
		//--area4 E
		
		//--area5 S 字母按钮
		area5=AreaCreator(2,13,new Array(3,1,6,-1),"area5_list_","afocus","ablur");
		area5.stablemoveindex=new Array("1-1,2-2,3-3,4-4,5-5,6-6,7-7,8-8,9-9,10-4>0,11-4>0,12-4>0",-1,"13-1,14-1,15-1,16-1,17-1,18-1,19-1,20-1,21-1,22-1,23-1,24-1,25-1",-1);
		for(var i=0,l=area5.doms.length;i<l;i++){area5.doms[i].contentdom = $("area5_content_"+i);}
		area5.areaOkEvent = function(){
			if($("hotkeyword").innerHTML.length <9){
				var addstr = this.doms[this.curindex].contentdom.innerHTML;				
				hotkeyword += addstr;
		   		$("hotkeyword").innerHTML = hotkeyword;
				keyword += addstr;
		   }
		}
		//--area5 E
		
		//--area6 S 搜索结果
		area6=AreaCreator(6,1,new Array(5,-1,-1,-1),"area6_list_","afocus","ablur");
		area6.setfocuscircle(0);	
		//area6.setcrossturnpage();
		area6.areaOkEvent = function(){saveFocstr(pageobj)};
		for(var i=0,l=area6.doms.length;i<l;i++){area6.doms[i].contentdom = $( "area6_content_"+i)}
		area6.setSimulationAjax(function(){
			bindSearchResultData(getItmsByPage(jSearchResult,area6.curpage,area6.doms.length));
			}
		);
		//--area6 E
		
		//--Set focus S
		if(focusObj!=undefined&&focusObj!="null"){
			areaid = parseInt(focusObj[0].areaid);
			indexid = parseInt(focusObj[0].curindex);
			area6.curpage = parseInt(focusObj[0].curpage);
		}
		//--Set focus E
		
		//--pageobj S
		pageobj = new PageObj(new Array(area0,area1,area2,area3,area4,area5,area6));
		//pageobj.backurl=returnurl;
		pageobj.backurl=returnurl;
		//--pageobj E
		
		//--binddatas S

		bindNavigatData();
		bindHotKeyWordsData(jHotkeywords);
		if(hotkeyword!=undefined&&hotkeyword!=""){
			bindSearchResultData(getItmsByPage(jSearchResult,area6.curpage,area6.doms.length));
		}else{
			area6.datanum = 0;
		}
		pageobj.setinitfocus(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0);
		refreshServerTime();//时间填充
		//--binddatas E
	}
	
//--common functions S
function getItmsByPage(cptitms,icurpage,ipagesize){
	var reclist=new Array();
	var start = (icurpage-1)*ipagesize;
	for(var i=0;i<ipagesize&&(i+(icurpage-1)*ipagesize)<cptitms.length;i++){
	     reclist[i]=cptitms[start+i];
	}
	return reclist;
}

function bindData(jsonTxt){
	var thisjson = eval('('+jsonTxt+')');
	jSearchResult = thisjson.jSearchResult;
	resultpagecount = thisjson.resultpagecount;
	area6.curpage = 1;
	bindSearchResultData(getItmsByPage(jSearchResult,area6.curpage,area6.doms.length));
}
//--common functions E
</script>
</head>

<body>

<!--head-->
	<div class="date" id="currDate"></div>
	
	<!--menu-->
	<div class="menu"> <!--当前选中为 class="item wid* item-select"；2字宽为wid1;3字宽为wid2,4字宽为wid3--> 
		<div class="item wid1">
			<div class="link"><a href="#" id="area0_list_0"><img src="../images/t.gif" /></a></div>
            <div class="txt">欧洲杯</div>
		</div>               
		<div class="item wid3" style="left:128px;">
			<div class="link"><a href="#" id="area0_list_1"><img src="../images/t.gif" /></a></div>
            <div class="txt">赛事点播</div>
		</div>
		<div class="item wid3" style="left:346px;">
			<div class="link"><a href="#" id="area0_list_2"><img src="../images/t.gif" /></a></div>
            <div class="txt">精彩视频</div>
		</div>
		<div class="item wid3" style="left:564px;">
			<div class="link"><a href="#" id="area0_list_3"><img src="../images/t.gif" /></a></div>
            <div class="txt">球星殿堂</div>	
		</div>
		<div class="item wid2" style="left:782px;">
			<div class="link"><a href="#" id="area0_list_4"><img src="../images/t.gif" /></a></div>
            <div class="txt">射手榜</div>	
		</div>
		<div class="item wid1 item-select" style="left:952px;">
			<div class="link"><a href="#" id="area0_list_5"><img src="../images/t.gif" /></a></div>
            <div class="txt">搜索</div>
		</div>
	</div>
<!--the end-->



<!--hot-words-->
<div class="hot-words">  
	<div class="title">热词</div>
	<div class="line" style="top:48px;"></div>
	<div class="item">
		<div class="link"><a href="#" id="area1_list_0"><img src="../images/t.gif" /></a></div>
        <div class="txt" id="area1_content_0"></div>
	</div>
	<div class="line" style="top:104px;"></div>
	<div class="item" style="top:106px;">
		<div class="link"><a href="#" id="area1_list_1"><img src="../images/t.gif" /></a></div>
        <div class="txt" id="area1_content_1"></div>
	</div>	
	<div class="line" style="top:160px;"></div>
	<div class="item" style="top:162px;">
		<div class="link"><a href="#" id="area1_list_2"><img src="../images/t.gif" /></a></div>
        <div class="txt" id="area1_content_2"></div>
	</div>
	<div class="line" style="top:216px;"></div>
</div>
<!--the end-->



<!--search-box-->
<div class="search-box">
	<div class="search-input">  
		<!--<div class="link"><a href="#"><img src="../images/t.gif" /></a></div>-->
		<div class="txt" id="hotkeyword"></div>
	</div>
	<div class="search-btn">  
		<div class="link"><a href="#" id="area2_list_0"><img src="../images/t.gif" /></a></div>
		<div class="btn"><img src="../images/btn-search.png" /></div>
	</div>
</div>
<!--the end-->



<!--search-num-abc-->
<div class="search-key">  
	<div class="item">
		<div class="link"><a href="#" id="area3_list_0"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area3_content_0">1</div>
	</div>
	<div class="item" style="left:72px;">
		<div class="link"><a href="#" id="area3_list_1"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area3_content_1">2</div>
	</div>
	<div class="item" style="left:144px;">
		<div class="link"><a href="#" id="area3_list_2"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area3_content_2">3</div>
	</div>
	<div class="item" style="left:216px;">
		<div class="link"><a href="#" id="area3_list_3"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area3_content_3">4</div>
	</div>
	<div class="item" style="left:288px;">
		<div class="link"><a href="#" id="area3_list_4"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area3_content_4">5</div>
	</div>
	<div class="item" style="left:360px;">
		<div class="link"><a href="#" id="area3_list_5"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area3_content_5">6</div>
	</div>
	<div class="item" style="left:432px;">
		<div class="link"><a href="#" id="area3_list_6"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area3_content_6">7</div>
	</div>
	<div class="item" style="left:504px;">
		<div class="link"><a href="#" id="area3_list_7"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area3_content_7">8</div>
	</div>
	<div class="item" style="left:576px;">
		<div class="link"><a href="#" id="area3_list_8"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area3_content_8">9</div>
	</div>
	<div class="item" style="left:648px;">
		<div class="link"><a href="#" id="area3_list_9"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area3_content_9">0</div>
	</div>
	<div class="item-del" style="left:720px;">
		<div class="link"><a href="#" id="area4_list_0"><img src="../images/t.gif" /></a></div>
		<div class="txt">删除</div>
	</div>
	
	<div style="top:56px;">
		<div class="item">
			<div class="link"><a href="#" id="area5_list_0"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_0">A</div>
		</div>
		<div class="item" style="left:72px;">
			<div class="link"><a href="#" id="area5_list_1"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_1">B</div>
		</div>
		<div class="item" style="left:144px;">
			<div class="link"><a href="#" id="area5_list_2"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_2">C</div>
		</div>
		<div class="item" style="left:216px;">
			<div class="link"><a href="#" id="area5_list_3"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_3">D</div>
		</div>
		<div class="item" style="left:288px;">
			<div class="link"><a href="#" id="area5_list_4"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_4">E</div>
		</div>
		<div class="item" style="left:360px;">
			<div class="link"><a href="#" id="area5_list_5"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_5">F</div>
		</div>
		<div class="item" style="left:432px;">
			<div class="link"><a href="#" id="area5_list_6"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_6">G</div>
		</div>
		<div class="item" style="left:504px;">
			<div class="link"><a href="#" id="area5_list_7"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_7">H</div>
		</div>
		<div class="item" style="left:576px;">
			<div class="link"><a href="#" id="area5_list_8"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_8">I</div>
		</div>
		<div class="item" style="left:648px;">
			<div class="link"><a href="#" id="area5_list_9"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_9">J</div>
		</div>
		<div class="item" style="left:720px;">
			<div class="link"><a href="#" id="area5_list_10"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_10">K</div>
		</div>
		<div class="item" style="left:792px;">
			<div class="link"><a href="#" id="area5_list_11"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_11">L</div>
		</div>
		<div class="item" style="left:864px;">
			<div class="link"><a href="#" id="area5_list_12"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_12">M</div>
		</div>
	</div>
	
	<div style="top:112px;">
		<div class="item">
			<div class="link"><a href="#" id="area5_list_13"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_13">N</div>
		</div>
		<div class="item" style="left:72px;">
			<div class="link"><a href="#" id="area5_list_14"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_14">O</div>
		</div>
		<div class="item" style="left:144px;">
			<div class="link"><a href="#" id="area5_list_15"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_15">P</div>
		</div>
		<div class="item" style="left:216px;">
			<div class="link"><a href="#" id="area5_list_16"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_16">Q</div>
		</div>
		<div class="item" style="left:288px;">
			<div class="link"><a href="#" id="area5_list_17"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_17">R</div>
		</div>
		<div class="item" style="left:360px;">
			<div class="link"><a href="#" id="area5_list_18"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_18">S</div>
		</div>
		<div class="item" style="left:432px;">
			<div class="link"><a href="#" id="area5_list_19"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_19">T</div>
		</div>
		<div class="item" style="left:504px;">
			<div class="link"><a href="#" id="area5_list_20"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_20">U</div>
		</div>
		<div class="item" style="left:576px;">
			<div class="link"><a href="#" id="area5_list_21"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_21">V</div>
		</div>
		<div class="item" style="left:648px;">
			<div class="link"><a href="#" id="area5_list_22"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_22">W</div>
		</div>
		<div class="item" style="left:720px;">
			<div class="link"><a href="#" id="area5_list_23"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_23">X</div>
		</div>
		<div class="item" style="left:792px;">
			<div class="link"><a href="#" id="area5_list_24"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_24">Y</div>
		</div>
		<div class="item" style="left:864px;">
			<div class="link"><a href="#" id="area5_list_25"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area5_content_25">Z</div>
		</div>
	</div>
</div>
<!--the end-->


	
<!--introduce-->
<div class="introduce"> 
	<div class="item">
		<div class="link"><a href="#" id="area6_list_0"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area6_content_0"></div>
	</div>
	<div class="item" style="top:50px;">
		<div class="link"><a href="#" id="area6_list_1"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area6_content_1"></div>
	</div>
	<div class="item" style="top:90px;">
		<div class="link"><a href="#" id="area6_list_2"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area6_content_2"></div>
	</div>
	<div class="item" style="top:130px;">
		<div class="link"><a href="#" id="area6_list_3"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area6_content_3"></div>
	</div>
	<div class="item" style="top:170px;">
		<div class="link"><a href="#" id="area6_list_4"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area6_content_4"></div>
	</div>
	<div class="item" style="top:210px;">
		<div class="link"><a href="#" id="area6_list_5"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area6_content_5"></div>
	</div>
</div>
<!--the end-->	
	
		

<!--page-->
<div class="page" style="left:145px; top:655px;">  
	<div class="item01" id="result_page">1/1页</div>
</div>
<!--the end-->
<%@ include file="servertimehelp.jsp" %>	
</body>
</html>
