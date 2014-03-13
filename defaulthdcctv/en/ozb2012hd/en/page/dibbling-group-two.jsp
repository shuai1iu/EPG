<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视欧洲杯高清3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<%@ include file="util/save_focus.jsp"%>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="datajsp/dibbling-group-two_data.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<script src="../js/pagecontrolx.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
var area0,area1,area2;
window.onload=function(){
     initPage(focstr);
	 refreshServerTime();
	 $("currDate").innerHTML = "<strong>"+strcurdate + "</strong>";
	 
}

function getItmsByPage(cptitms,icurpage,ipagesize){
	var reclist=new Array();
	var start = (icurpage-1)*ipagesize;
	for(var i=0;i<ipagesize&&(i+(icurpage-1)*ipagesize)<cptitms.length;i++){
	     reclist[i]=cptitms[start+i];
	}
	
	return reclist;
}

function bindNavigatData(){
		var linkArrs = {"index":1};
		area0.doms[0].mylink = "index.jsp";
		if(true){
			area0.doms[1].mylink = "group-match.jsp";
		}else{
			area0.doms[1].mylink = "knockout.jsp";
		}
		area0.doms[2].mylink = "video.jsp";
		area0.doms[3].mylink = "star.jsp";
		area0.doms[4].mylink = "top-scorer.jsp";
		area0.doms[5].mylink = "search.jsp";
		area0.doms[linkArrs[curPage]].mylink = undefined;
}

function initPage() {
		 area0 = AreaCreator(1,6,new Array(-1,-1,2,-1),"menu_a","afocus","ablur");
	     area0.stablemoveindex=new Array(-1,-1,"0-1>0",-1);
		 area0.setfocuscircle(1);
		 if(parseInt(typenum)==4) $("menu4").className="item wid2 item-select";
		 if(parseInt(typenum)==1) $("menu1").className="item wid3 item-select";
		 bindNavigatData();
		 
	 	 
         area1=AreaCreator(2,1,new Array(0,-1,-1,2),"area1_link","afocus","ablur");
		 area1.areaOkEvent = function(){
			saveFocstr(pageobj);				
			//getAJAXData("datajsp/get_vasurl.jsp?vasid="+area1.doms[area1.curindex].youwanauseobj,turnUrl);
		 };
		 area1.stablemoveindex=new Array(1,-1,-1,"0-2>0,1-0,2-0,3-0,4-0,5-4,6-4,7-4");
		 for(var i=0,l=area1.doms.length;i<l;i++){
			area1.doms[i].imgdom = $('area1_img'+i);
		 } 
		 
		 area2 = AreaCreator(12,1,new Array(0,1,-1,-1),"area2_link","afocus","ablur");
		 area2.stablemoveindex=new Array("0-1",-1,-1,-1);
		 for(i=0;i<area2.doms.length;i++) area2.doms[i].contentdom=$("area2_txt"+i);
		
		
		 area2.setSimulationAjax(function(){
			 area2curindex=area2.curindex;
             area2curpage=area2.curpage;
			
			 bindVODData(getItmsByPage(jsonvodlist,area2curpage,area2pagesize));
		 });
		 area2.areaOkEvent=function(){
		    if(area2.doms[area2.curindex].youwanauseobj==-1) return;
			saveFocstr(pageobj);
			location.href = "vod-detail.jsp?typeid=<%=typeid%>&vodid="+area2.doms[area2.curindex].youwanauseobj+"&returnurl="+escape(location.href);
		 }  
		 
	  	 pageobj = new PageObj(new Array(area0,area1,area2));
		 pageobj.backurl=returnurl;
	   
	     area2.curpage=area2curpage;
		
		 bindVODData(getItmsByPage(jsonvodlist,area2curpage,area2pagesize));
		 bindRecommendData(jRecommends);
		
		 pageobj.setinitfocus(areaid!=null?parseInt(areaid):1,indexid!=null?parseInt(indexid):0);
}

//common function S
	function turnUrl(url){
		if(url!=undefined&&url!="null"){
			url += ((url.indexOf("?")==-1)?"?":"&")+"returnurl="+escape(location.href);
			location.href = url;
		}
	}
//common funciton E
</script>
<style type="text/css">
<!--
	body{ background:url(../images/bg1.jpg) no-repeat;}
-->
</style>
</head>

<body>

<!--head-->
	<div class="date" id="currDate"></div>
	<!--menu-->
	<div class="menu"> <!--当前选中为 class="item wid* item-select"；2字宽为wid1;3字宽为wid2,4字宽为wid3--> 
		<div class="item wid1" id="menu0">
			<div class="link"><a href="#" id="menu_a0"><img src="../images/t.gif" /></a></div>
            <div class="txt">欧洲杯</div>
		</div>               
		<div class="item wid3" style="left:128px;" id="menu1">
			<div class="link"><a href="#" id="menu_a1"><img src="../images/t.gif" /></a></div>
            <div class="txt">赛事点播</div>
		</div>
		<div class="item wid3" style="left:346px;" id="menu2">
			<div class="link"><a href="#" id="menu_a2"><img src="../images/t.gif" /></a></div>
            <div class="txt">精彩视频</div>
		</div>
		<div class="item wid3" style="left:564px;" id="menu3">
			<div class="link"><a href="#" id="menu_a3"><img src="../images/t.gif" /></a></div>
            <div class="txt">球星殿堂</div>	
		</div>
		<div class="item wid2" style="left:782px;" id="menu4">
			<div class="link"><a href="#" id="menu_a4"><img src="../images/t.gif" /></a></div>
            <div class="txt">射手榜</div>	
		</div>
		<div class="item wid1" style="left:952px;" id="menu5">
			<div class="link"><a href="#" id="menu_a5"><img src="../images/t.gif" /></a></div>
            <div class="txt">搜索</div>
		</div>
	</div>
<!--the end-->

	
	
<!--dibbling-left-pic-list-->
<div class="goals-pic-list">   
	<div class="item item01"> 
		<div class="link"><a href="#"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="picTypePath" /></div>
	</div>
	<div class="item" style="top:296px;">
		<div class="link"><a href="#" id="area1_link0"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area1_img0"  /></div>
	</div>
	<div class="item" style="top:447px;">
		<div class="link"><a href="#" id="area1_link1"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area1_img1"  /></div>
	</div>		
</div>
<!--the end-->	


	
<!--dibbling-list-->
<div class="goals-list">
	<div class="con"> 
		<div class="item">
			<div class="link"><a href="#" id="area2_link0"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area2_txt0"></div>
		</div>
		<div class="item" style="top:43px;">
			<div class="link"><a href="#" id="area2_link1"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area2_txt1"></div>
		</div>
		<div class="item" style="top:86px;">
			<div class="link"><a href="#" id="area2_link2"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area2_txt2"></div>
		</div>
		<div class="item" style="top:129px;">
			<div class="link"><a href="#" id="area2_link3"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area2_txt3"></div>
		</div>
		<div class="item" style="top:172px;">
			<div class="link"><a href="#" id="area2_link4"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area2_txt4"></div>
		</div>
		<div class="item" style="top:215px;">
			<div class="link"><a href="#" id="area2_link5"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area2_txt5"></div>
		</div>
		<div class="item" style="top:258px;">
			<div class="link"><a href="#" id="area2_link6"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area2_txt6"></div>
		</div>
		<div class="item" style="top:301px;">
			<div class="link"><a href="#" id="area2_link7"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area2_txt7"></div>
		</div>
		<div class="item" style="top:344px;">
			<div class="link"><a href="#" id="area2_link8"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area2_txt8"></div>
		</div>
		<div class="item" style="top:387px;">
			<div class="link"><a href="#" id="area2_link9"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area2_txt9"></div>
		</div>
		<div class="item" style="top:430px;">
			<div class="link"><a href="#" id="area2_link10"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area2_txt10"></div>
		</div>
		<div class="item" style="top:473px;">
			<div class="link"><a href="#" id="area2_link11"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area2_txt11"></div>
		</div>
	</div>
	<!--page-->
	<div class="page">  
		<div class="item01"  id="page">1/1页</div>
	</div>
	<!--the end-->
	
</div>
<!--the end-->	
<%@ include file="servertimehelp.jsp"%>
</body>
</html>
