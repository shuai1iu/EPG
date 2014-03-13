<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视欧洲杯 标清EPG 2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<%@ include file="util/save_focus.jsp"%>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="datajsp/star_data.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<script src="../js/pagecontrolx.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
var area0,area1,area2;

window.onload=function(){
	 initPage();
}

function bindNavigatData(){
		var linkArrs = {"index":3};
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

function getItmsByPage(cptitms,icurpage,ipagesize){
	var reclist=new Array();
	var start = (icurpage-1)*ipagesize;
	for(var i=0;i<ipagesize&&(i+(icurpage-1)*ipagesize)<cptitms.length;i++){
	     reclist[i]=cptitms[start+i];
	}
	
	return reclist;
}


function initPage() {
    area0 = AreaCreator(1,6,new Array(-1,-1,1,-1),"menu_a","afocus","ablur");
    area0.stablemoveindex=new Array(-1,-1,"0-0,1-0,2-1,3-1,4-1,5-1",-1);
    area0.setfocuscircle(1);
    bindNavigatData();
 
    area1 = AreaCreator(1,2,new Array(0,-1,2,-1),"area1_link","afocus","ablur");
    area1.setfocuscircle(1);
    area1.stablemoveindex=new Array("0-0>3,1-0>3",-1,"0-0,1-1",-1);
    
    area2 = AreaCreator(2,5,new Array(1,-1,-1,-1),"area2_link","afocus","ablur");
    for(i=0;i<area2.doms.length;i++) area2.doms[i].contentdom=$("area2_txt"+i);
    for(i=0;i<area2.doms.length;i++) area2.doms[i].imgdom=$("area2_img"+i);
   
    area2.setSimulationAjax(function(){
			 area2curindex=area2.curindex;
             area2curpage=area2.curpage;
			
			 bindVODData(getItmsByPage(jsonvodlist,area2curpage,area2pagesize));
	});
    area2.areaOkEvent=function(){
		saveFocstr(pageobj);
		location.href = "vod-detail.jsp?typeid=<%=typeid%>"+"&vodid="+area2.doms[area2.curindex].youwanaobj+"&returnurl="+escape(location.href);
    } 
	
	area1.doms[0].domOkEvent=function(){
			  if((parseInt(area2curpage)-1)<=0) return;
			  area2curpage=area2curpage-1;
			  area2.curpage=area2curpage;
			  bindVODData(getItmsByPage(jsonvodlist,area2curpage,area2pagesize));
	}
		  
	area1.doms[1].domOkEvent=function(){
		  //alert(area3.pageturn);
		//  area3.pagego(2);
		
		  if((parseInt(area2curpage)+1)>area2pagecount) return;
		  area2curpage=area2curpage+1;
		  area2.curpage=area2curpage;
	
		  bindVODData(getItmsByPage(jsonvodlist,area2curpage,area2pagesize));
	} 
	
	pageobj = new PageObj(new Array(area0,area1,area2));
    pageobj.backurl=returnurl;

	area2.curpage=area2curpage;
	bindVODData(getItmsByPage(jsonvodlist,area2curpage,area2pagesize));
    pageobj.setinitfocus(areaid!=null?parseInt(areaid):2,indexid!=null?parseInt(indexid):0);
    refreshServerTime();
	$("currDate").innerHTML = "<strong>"+strcurdate + "</strong>";
}
</script>
</head>

<body>

<!--head-->
	<div class="date" id="currDate"></div>
	
	<!--menu-->
	<div class="menu"> <!--当前选中为 class="item wid* item-select"；2字宽为wid1;3字宽为wid2,4字宽为wid3--> 
		<div class="item wid1">
			<div class="link"><a href="#" id="menu_a0"><img src="../images/t.gif" /></a></div>
		</div>               
		<div class="item wid3" style="left:63px;">
			<div class="link"><a href="#" id="menu_a1"><img src="../images/t.gif" /></a></div>
		</div>
		<div class="item wid3" style="left:172px;">
			<div class="link"><a href="#" id="menu_a2"><img src="../images/t.gif" /></a></div>
		</div>
		<div class="item wid3" style="left:281px;">
			<div class="link"><a href="#" id="menu_a3"><img src="../images/menu04.jpg"  /></a></div>	
		</div>
		<div class="item wid2" style="left:390px;">
			<div class="link"><a href="#" id="menu_a4"><img src="../images/t.gif" /></a></div>
		</div>
		<div class="item wid1" style="left:475px;">
			<div class="link"><a href="#" id="menu_a5"><img src="../images/t.gif" /></a></div>
		</div>
	</div>
   <!--the end-->




<!--page-->
<div class="page" style=" left:40px; top:89px;">  
	<div class="item">
		<div class="link"><a id="area1_link0" href="#"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img src="../images/btn-prev.png" /></div>
	</div> 
	<div style="left:102px;" class="item">
		<div class="link"><a id="area1_link1" href="#"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img src="../images/btn-next.png" /></div>
	</div>
	<div style="left:195px;" id="page"></div>
	<!--<div style="left:364px;">
		<div class="link"><a href="#"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img src="../images/btn-next.png" /></div>
	</div>-->
</div>
<!--the end-->
	

	
	
<!--video-list-->
<div class="star-list">  
	<div class="item" id="area2_list0">
		<div class="link"><a id="area2_link0" href="#"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img0" src="#" /></div>
		<div class="txt" id="area2_txt0"></div>
	</div>
	<div class="item" style="left:123px;" id="area2_list1">
		<div class="link"><a id="area2_link1" href="#"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img1" src="#" /></div>
		<div class="txt" id="area2_txt1"></div>
	</div>
	<div class="item" style="left:246px;" id="area2_list2">
		<div class="link"><a id="area2_link2"  href="#"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img2" src="#" /></div>
		<div class="txt" id="area2_txt2"></div>
	</div>
	<div class="item" style="left:369px;" id="area2_list3">
		<div class="link"><a id="area2_link3" href="#"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img3" src="#" /></div>
		<div class="txt" id="area2_txt3"></div>
	</div>
	<div class="item" style="left:492px;" id="area2_list4">
		<div class="link"><a id="area2_link4" href="#"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img4" src="#" /></div>
		<div class="txt" id="area2_txt4"></div>
	</div>
	<div class="item" style="top:202px;" id="area2_list5">
		<div class="link"><a id="area2_link5" href="#"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img5" src="#" /></div>
		<div class="txt" id="area2_txt5"></div>
	</div>
	<div class="item" style="left:123px;top:202px;" id="area2_list6">
		<div class="link"><a id="area2_link6" href="#"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img6" src="#" /></div>
		<div class="txt" id="area2_txt6"></div>
	</div>
	<div class="item" style="left:246px;top:202px;" id="area2_list7">
		<div class="link"><a id="area2_link7" href="#"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img7" src="#" /></div>
		<div class="txt" id="area2_txt7"></div>
	</div>
	<div class="item" style="left:369px;top:202px;"  id="area2_list8">
		<div class="link"><a id="area2_link8" href="#"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img8" src="#" /></div>
		<div class="txt" id="area2_txt8"></div>
	</div>
	<div class="item" style="left:492px;top:202px;"  id="area2_list9">
		<div class="link"><a id="area2_link9" href="#"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img9" src="#" /></div>
		<div class="txt" id="area2_txt9"></div>
	</div>
</div>
<!--the end-->	
<%@ include file="servertimehelp.jsp" %>	
</body>
</html>