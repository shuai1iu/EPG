<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视欧洲杯 标清EPG 2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<%@ include file="util/save_focus.jsp"%>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="datajsp/vod_data.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<script src="../js/pagecontrolx.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
var area0,area1,area2,area3;
var fanye=false,liandong=true;

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

function bindData(jsonTxt){
	jsonvodlist=new Array();
	var thisjson = eval('('+jsonTxt+')');
	
	jsonvodlist = thisjson.jsonvodlist;
	area3pagecount=thisjson.jsonpage;
	area3pagesize=8;
	area3.curpage=1;
	area3.curindex=0;
	area3curindex=area3.curindex;
	area3curpage=area3.curpage;
	bindVODData(getItmsByPage(jsonvodlist,area3curpage,area3pagesize));
   
}
function bindNavigatData(){
		var linkArrs = {"index":2};
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
		area0.doms[linkArrs[2]].mylink = undefined;
}
function initPage() {
		 area0 = AreaCreator(1,6,new Array(-1,-1,2,-1),"menu_a","afocus","ablur");
	     area0.stablemoveindex=new Array(-1,-1,"0-0,1-0,2-1,3-1,4-2,5-2",-1);
		 area0.setfocuscircle(1);
		 
		 bindNavigatData();
		 
	 	 
         area1=AreaCreator(8,1,new Array(0,-1,-1,3),new Array("area1_link","area1_list"),
		 new Array("afocus","className:item"),new Array("ablur","className:item"));
		
		
		 area1.setcrossturnpage();
		 area1.stablemoveindex=new Array(0,-1,-1,"0-0,1-0,2-0,3-0,4-0,5-4,6-4,7-4");
		 area1.setstaystyle(new Array("ablur","className:item item-select"),3);
		 if(jsoncatelist.length!=0){
			 area1.setdarknessfocus(area1curindex);
		 }
		
		 area1.curpage=area1curpage;
		 for(i=0;i<area1.doms.length;i++) area1.doms[i].contentdom=$("area1_txt"+i);
		 area1.setSimulationAjax(function(){
			bindCateData(getItmsByPage(jsoncatelist,area1.curpage,area1.doms.length));
		 });
		 
		 
		 
		 area2 = AreaCreator(1,3,new Array(0,-1,3,-1),"area2_link","afocus","ablur");
		 area2.stablemoveindex=new Array("0-0>2,1-0>2,2-0>2",-1,3,-1);
		  
		 area2.doms[2].domOkEvent=function(){
			 window.location.href=returnurl;
		 }
		 area3 = AreaCreator(2,4,new Array(2,1,-1,-1),"area3_link","afocus","ablur");
		 for(i=0;i<area3.doms.length;i++) area3.doms[i].contentdom=$("area3_txt"+i);
		 for(i=0;i<area3.doms.length;i++) area3.doms[i].imgdom=$("area3_img"+i);
		 
		 area1.dataarea=area3;
		 area3.setTrueAjax("datajsp/vod_data_iframe.jsp?typeid=#(area1.doms[area1.curindex].youwanaobj)&area3curpage=#(area3.curpage)",bindData);
		 
		 
		 
		 area3.setSimulationAjax(function(){
			 area3curindex=area3.curindex;
             area3curpage=area3.curpage;
			
			 bindVODData(getItmsByPage(jsonvodlist,area3curpage,area3pagesize));
		 });
		
	     area3.areaOkEvent=function(){
			if(area3.doms[area3.curindex].youwanaobj==-1) return;
			saveFocstr(pageobj);
			location.href = "vod-detail.jsp?typeid="+ area1.doms[area1.curindex].youwanaobj +"&vodid="+area3.doms[area3.curindex].youwanaobj+"&returnurl="+escape(location.href);
		 }  
		 // area3.setcrossturnpage();
	  	 pageobj = new PageObj(new Array(area0,area1,area2,area3));
		 pageobj.backurl=returnurl;
	     area3.curpage=area3curpage;
		 area3.parentarea=area1;
	     area2.doms[0].domOkEvent=function(){
			  if((parseInt(area3curpage)-1)<=0) return;
			  area3curpage=area3curpage-1;
			  area3.curpage=area3curpage;
			  bindVODData(getItmsByPage(jsonvodlist,area3curpage,area3pagesize));
		 }
		  
		 area2.doms[1].domOkEvent=function(){
			  //alert(area3.pageturn);
			//  area3.pagego(2);
			
			  if((parseInt(area3curpage)+1)>area3pagecount) return;
			  area3curpage=area3curpage+1;
			  area3.curpage=area3curpage;
		
			  bindVODData(getItmsByPage(jsonvodlist,area3curpage,area3pagesize));
		 } 
		 if(jsoncatelist!=null){
		   bindCateData(getItmsByPage(jsoncatelist,area1curpage,area1pagesize));
		 }
		 if(jsonvodlist!=null){
		  
		   bindVODData(getItmsByPage(jsonvodlist,area3curpage,area3pagesize));
		 }
		 if(jsonvodlist!=null){
		   pageobj.setinitfocus(areaid!=null?parseInt(areaid):3,indexid!=null?parseInt(indexid):0);
		 }
		 else{
		   pageobj.setinitfocus(0,2);
		 }
		//alert(jsonvodlist[0].PICPATH);
	}
</script>
</head>
<body>
    <div style="visibility:hidden; z-index:-1">
        <!--首页左边导航暗焦点--> 
        <img src="../images/nav-bgon.jpg"/>
    </div>
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
			<div class="link"><a href="#" id="menu_a2"><img src="../images/menu03.jpg" /></a></div>
		</div>
		<div class="item wid3" style="left:281px;">
			<div class="link"><a href="#" id="menu_a3"><img src="../images/t.gif" /></a></div>	
		</div>
		<div class="item wid2" style="left:390px;">
			<div class="link"><a href="#" id="menu_a4"><img src="../images/t.gif" /></a></div>
		</div>
		<div class="item wid1" style="left:475px;">
			<div class="link"><a href="#" id="menu_a5"><img src="../images/t.gif" /></a></div>
		</div>
	</div>
   <!--the end-->


<!--nav-->
<div class="video-nav">  <!--不前选中为 class="item item-select"-->
	<div class="item" id="area1_list0">
		<div class="link"><a href="#"  id="area1_link0"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt0"></div>
	</div>
	<div class="line" style="top:48px;"></div>
	<div class="item" style="top:50px;" id="area1_list1">
		<div class="link" ><a id="area1_link1" href="#" ><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt1"></div>
	</div>
	<div class="line" style="top:98px;"></div>
	<div class="item" style="top:100px;" id="area1_list2">
		<div class="link" ><a id="area1_link2" href="#" ><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt2"></div>
	</div>
	<div class="line" style="top:148px;"></div>
	<div class="item" style="top:150px;" id="area1_list3" >
		<div class="link" ><a id="area1_link3" href="#" ><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt3"></div>
	</div>
	<div class="line" style="top:198px;"></div>
	<div class="item" style="top:200px;" id="area1_list4">
		<div class="link" ><a id="area1_link4" href="#" ><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt4"></div>
	</div>
	<div class="line" style="top:248px;"></div>
	<div class="item" style="top:250px;" id="area1_list5">
		<div class="link" ><a  id="area1_link5" href="#"  ><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt5"></div>
	</div>
	<div class="line" style="top:298px;"></div>
	<div class="item" style="top:300px;" id="area1_list6">
		<div class="link" ><a id="area1_link6" href="#" ><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt6"></div>
	</div>
	<div class="line" style="top:348px;"></div>
	<div class="item" style="top:350px;" id="area1_list7">
		<div class="link" ><a id="area1_link7" href="#" ><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt7"></div>
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
	
	
	
	
<!--video-list-->
<div class="video-list">  
	<div class="item" id="area3_list0">
		<div class="link"><a id="area3_link0" href="#"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area3_img0" src="#" /></div>
		<div class="txt" id="area3_txt0"></div>
	</div>
	<div class="item" style="left:117px;" id="area3_list1">
		<div class="link"><a href="#" id="area3_link1"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area3_img1" src="#" /></div>
		<div class="txt" id="area3_txt1"></div>
	</div>
	<div class="item" style="left:234px;" id="area3_list2">
		<div class="link"><a href="#" id="area3_link2"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area3_img2" src="#" /></div>
		<div class="txt" id="area3_txt2"></div>
	</div>
	<div class="item" style="left:351px;" id="area3_list3">
		<div class="link"><a href="#" id="area3_link3"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area3_img3" src="#" /></div>
		<div class="txt" id="area3_txt3"></div>
	</div>
	<div class="item" style="top:202px;" id="area3_list4">
		<div class="link"><a href="#" id="area3_link4"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area3_img4" src="#" /></div>
		<div class="txt" id="area3_txt4"></div>
	</div>
	<div class="item" style="left:117px;top:202px;" id="area3_list5">
		<div class="link"><a href="#" id="area3_link5"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area3_img5" src="#" /></div>
		<div class="txt" id="area3_txt5"></div>
	</div>
	<div class="item" style="left:234px;top:202px;" id="area3_list6">
		<div class="link"><a href="#" id="area3_link6"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area3_img6" src="#" /></div>
		<div class="txt" id="area3_txt6"></div>
	</div>
	<div class="item" style="left:351px;top:202px;" id="area3_list7">
		<div class="link"><a href="#" id="area3_link7"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area3_img7" src="#" /></div>
		<div class="txt" id="area3_txt7"></div>
	</div>
</div>

<%@ include file="servertimehelp.jsp" %>
<!--the end-->	
</body>
</html>
