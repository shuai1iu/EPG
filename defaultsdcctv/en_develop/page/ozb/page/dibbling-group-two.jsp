<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视欧洲杯 标清EPG 2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<%@ include file="util/save_focus.jsp"%>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="datajsp/dibbling-group-two_data.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<script src="../js/pagecontrolx.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
var area0,area1,area2,area3;
window.onload=function(){
     initPage();
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
	     area0.stablemoveindex=new Array(-1,-1,"0-1>0,1-0,2-1,3-1,4-2,5-2",-1);
		 area0.setfocuscircle(1);
		 if(parseInt(typenum)==4) $("menu4").className="item wid2";
		 if(parseInt(typenum)==1) $("menu1").className="item wid3";
		 bindNavigatData();
		 
	 	 
         area1=AreaCreator(2,1,new Array(0,-1,-1,3),"area1_link","afocus","ablur");
		 area1.areaOkEvent = function(){
			saveFocstr(pageobj);				
//getAJAXData("datajsp/get_vasurl.jsp?vasid="+area1.doms[area1.curindex].youwanauseobj,turnUrl);
		 };
		 if(parseInt(typenum)==4){
		      area1.stablemoveindex=new Array("0-0>4",-1,-1,"0-2>0,1-0,2-0,3-0,4-0,5-4,6-4,7-4");
		 }
		 else
		 {
			  area1.stablemoveindex=new Array("0-0>1",-1,-1,"0-2>0,1-0,2-0,3-0,4-0,5-4,6-4,7-4");
		 }
		 for(var i=0,l=area1.doms.length;i<l;i++){
			area1.doms[i].imgdom = $('area1_img'+i);
		 } 
		 
		 area2 = AreaCreator(1,3,new Array(0,-1,3,-1),"area2_link","afocus","ablur");
		 if(parseInt(typenum)==4){
		      area2.stablemoveindex=new Array("0-0>4,1-0>4,2-0>4",1,3,-1);
		 }
		 else
		 {
			  area2.stablemoveindex=new Array("0-0>1,1-0>1,2-0>1",1,3,-1);
		 }
		 
		 area2.doms[2].domOkEvent=function(){
			 window.location.href=returnurl;
		 }
		 
		 area3 = AreaCreator(12,1,new Array(2,1,-1,-1),"area3_link","afocus","ablur");
		 for(i=0;i<area3.doms.length;i++) area3.doms[i].contentdom=$("area3_txt"+i);
		
		
		 area3.setSimulationAjax(function(){
			 area3curindex=area3.curindex;
             area3curpage=area3.curpage;
			
			 bindVODData(getItmsByPage(jsonvodlist,area3curpage,area3pagesize));
		 });
		 area3.areaOkEvent=function(){
			if(area3.doms[area3.curindex].youwanauseobj==-1) return;
			saveFocstr(pageobj);
			location.href = "vod-detail.jsp?typeid=<%=typeid%>&vodid="+area3.doms[area3.curindex].youwanauseobj+"&returnurl="+escape(location.href);
		 }  
		 
	  	 pageobj = new PageObj(new Array(area0,area1,area2,area3));
		 pageobj.backurl=returnurl;
	   
	     area3.curpage=area3curpage;
	     area2.doms[0].domOkEvent=function(){
			  if((parseInt(area3curpage)-1)<=0) return;
			  area3curpage=area3curpage-1;
			  area3.curpage=area3curpage;
			  bindVODData(getItmsByPage(jsonvodlist,area3curpage,area3pagesize));
		 }
		  
		 area2.doms[1].domOkEvent=function(){

			  if((parseInt(area3curpage)+1)>area3pagecount) return;
			  area3curpage=area3curpage+1;
			  area3.curpage=area3curpage;
		
			  bindVODData(getItmsByPage(jsonvodlist,area3curpage,area3pagesize));
		 } 
		
		 bindVODData(getItmsByPage(jsonvodlist,area3curpage,area3pagesize));
		 bindRecommendData(jRecommends);
		
		 pageobj.setinitfocus(areaid!=null?parseInt(areaid):3,indexid!=null?parseInt(indexid):0);
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
</head>

<body>

<!--head-->
	<div class="date" id="currDate"></div>
	
	<!--menu-->
	<div class="menu"> <!--当前选中为 class="item wid* item-select"；2字宽为wid1;3字宽为wid2,4字宽为wid3--> 
		<div class="item wid1" id="menu0">
			<div class="link"><a href="#" id="menu_a0"><img src="../images/t.gif" /></a></div>
		</div>               
		<div class="item wid3" style="left:63px;" id="menu1">
			<div class="link"><a href="#" id="menu_a1"><img src="../images/t.gif" /></a></div>
		</div>
		<div class="item wid3" style="left:172px;" id="menu2">
			<div class="link"><a href="#" id="menu_a2"><img src="../images/t.gif" /></a></div>
		</div>
		<div class="item wid3" style="left:281px;" id="menu3">
			<div class="link"><a href="#" id="menu_a3"><img src="../images/t.gif" /></a></div>
		</div>
		<div class="item wid2" style="left:390px;" id="menu4">
			<div class="link"><a href="#" id="menu_a4"><img src="../images/menu05.jpg" /></a></div>
		</div>
		<div class="item wid1" style="left:475px;" id="menu5">
			<div class="link"><a href="#" id="menu_a5"><img src="../images/t.gif" /></a></div>
		</div>
	</div>
<!--the end-->

	
	
<!--dibbling-left-pic-list-->
<div class="goals-pic-list">   
	<div class="item item01" > 
		<div class="link"><a href="#"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="picTypePath" src="#" /></div>
	</div>
	<div class="item" style="top:222px;" id="area1_list0">
		<div class="link"><a href="#" id="area1_link0"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area1_img0"  src="#" /></div>
	</div>
	<div class="item" style="top:333px;" id="area1_list1" >
		<div class="link"><a href="#" id="area1_link1"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area1_img1" src="#" /></div>
	</div>
</div>
<!--the end-->	




<!--page-->
<div class="page" style=" left:181px; top:89px;">  
    <div class="item">
		<div class="link"><a href="#" id="area2_link0"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img src="../images/btn-prev.png" /></div>
	</div> 
	<div style="left:102px;" class="item">
		<div class="link"><a href="#" id="area2_link1"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img src="../images/btn-next.png" /></div>
	</div>
	<div style="left:195px;"  id="page"></div>
	<div style="left:364px;" class="item">
		<div class="link"><a href="#" id="area2_link2"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img src="../images/btn-retrun.png" /></div>
	</div>
</div>
<!--the end-->



	
<!--dibbling-list-->
<div class="goals-list">
	<div class="con"> 
		<div class="item" id="area3_list0">
			<div class="link"><a id="area3_link0" href="#"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area3_txt0"></div>
		</div>
		<div class="item" style="top:32px;" id="area3_list1">
			<div class="link"><a id="area3_link1" href="#"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area3_txt1"></div>
		</div>
		<div class="item" style="top:64px;" id="area3_list2">
			<div class="link"><a id="area3_link2" href="#"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area3_txt2"></div>
		</div>
		<div class="item" style="top:96px;"  id="area3_list3">
			<div class="link"><a id="area3_link3" href="#"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area3_txt3"></div>
		</div>
		<div class="item" style="top:128px;" id="area3_list4">
			<div class="link"><a id="area3_link4" href="#"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area3_txt4"></div>
		</div>
		<div class="item" style="top:160px;" id="area3_list5">
			<div class="link"><a id="area3_link5" href="#"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area3_txt5"></div>
		</div>
		<div class="item" style="top:192px;"  id="area3_list6">
			<div class="link"><a id="area3_link6" href="#"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area3_txt6"></div>
		</div>
		<div class="item" style="top:224px;"  id="area3_list7">
			<div class="link"><a id="area3_link7" href="#"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area3_txt7"></div>
		</div>
		<div class="item" style="top:256px;" id="area3_list8">
			<div class="link"><a  id="area3_link8" href="#"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area3_txt8"></div>
		</div>
		<div class="item" style="top:288px;" id="area3_list9">
			<div class="link"><a id="area3_link9" href="#"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area3_txt9"></div>
		</div>
		<div class="item" style="top:320px;"  id="area3_list10">
			<div class="link"><a id="area3_link10" href="#"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area3_txt10"></div>
		</div>
		<div class="item" style="top:352px;"  id="area3_list11">
			<div class="link"><a id="area3_link11" href="#"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area3_txt11"></div>
		</div>
	</div>
</div>
<!--the end-->	
<%@ include file="servertimehelp.jsp"%>
</body>
</html>
