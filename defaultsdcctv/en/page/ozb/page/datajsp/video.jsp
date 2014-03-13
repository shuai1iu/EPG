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
<script src="../js/pagecontrolx.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
var area0;
var area1;
var area2;
var area3;






window.onload=function(){
	 refreshServerTime();
     initPage();
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
	jsonvodlist = thisjson;
	bindVODData(jsonvodlist);
}

function initPage() {
		 area0 = AreaCreator(1,6,new Array(-1,-1,2,-1),"menu_a","afocus","ablur");
	     area0.stablemoveindex=new Array(-1,-1,"0-1>0,1-0,2-1,3-1,4-2,5-2",-1);
		 area0.setfocuscircle(1);
		 area0.doms[0].mylink="";
		 area0.doms[1].mylink="group-match.jsp";
		 //area0.doms[2].mylink="video.jsp";
		 area0.doms[3].mylink="";
		 area0.doms[4].mylink="top-scorer.jsp";
		 area0.doms[5].mylink="";
		 area0.setstaystyle("className:",2);
	 
	     area1=AreaCreator(8,1,new Array(-1,-1,-1,2),new Array("area1_link","area1_list"),new Array("className:afocus","className:item item_select"),new Array("className:ablur","className:item"));
		 area1.setstaystyle(new Array("className:ablur","className:item item_select"),3);
		 area1.setfocuscircle(0);
		 area1.setcrossturnpage();
		 for(i=0;i<area1.doms.length;i++) area1.doms[i].contentdom=$("area1_txt"+i);
		 area1.setSimulationAjax(function(){
			bindCateData(getItmsByPage(jsoncatelist,area1.curpage,area1.doms.length));
		 });
		 
		 
		 
		 
		 area2 = AreaCreator(1,3,new Array(0,1,3,-1),"area2_link","afocus","ablur");
		  
		  
		  
		  
		  
		 area3 = AreaCreator(2,4,new Array(0,1,3,-1),"area3_link","afocus","ablur");
		 for(i=0;i<area3.doms.length;i++) area3.doms[i].contentdom=$("area3_txt"+i);
		 for(i=0;i<area3.doms.length;i++) area3.doms[i].imgdom=$("area3_img"+i);
		 
		 area1.dataarea=area3;
		 area3.setTrueAjax("datajsp/vod_data_iframe.jsp?typeid=#(area1.doms[area1.curindex].youwanaobj)",bindData);
		
		
	     area3.areaOkEvent=function(){saveFocstr(pageobj);}  
		 
	  	 pageobj = new PageObj(new Array(area0,area1,area2,area3));
		 pageobj.backurl=returnurl;
	
	      
		 bindCateData(getItmsByPage(jsoncatelist,area1curpage,area1pagesize));
		
		 
		 //bindVodContent(jVodInfo);
		 pageobj.setinitfocus(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):2);
	}
</script>
</head>
<body>

<!--head-->
	<div class="date" id="currDate"></div>
	
	<!--menu-->
	<div class="menu"> <!--当前选中为 class="item wid* item-select"；2字宽为wid1;3字宽为wid2,4字宽为wid3--> 
		<div class="item wid1" id="menu0">
			<div class="link"><a href="#" id="menu_a0"><img src="../images/t.gif" /></a></div>
            <div class="txt">首页</div>
		</div>               
		<div class="item wid3" style="left:63px;" id="menu1">
			<div class="link"><a href="#" id="menu_a1"><img src="../images/t.gif" /></a></div>
            <div class="txt">赛事点播</div>
		</div>
		<div class="item wid3 item-select" style="left:172px;" id="menu2">
			<div class="link"><a href="#" id="menu_a2"><img src="../images/t.gif" /></a></div>
            <div class="txt">精彩视频</div>
		</div>
		<div class="item wid3" style="left:281px;" id="menu3">
			<div class="link"><a href="#" id="menu_a3"><img src="../images/t.gif" /></a></div>
            <div class="txt">球星殿堂</div>	
		</div>
		<div class="item wid2" style="left:390px;" id="menu4">
			<div class="link"><a href="#" id="menu_a4"><img src="../images/t.gif" /></a></div>
            <div class="txt">射手榜</div>	
		</div>
		<div class="item wid1" style="left:475px;" id="menu5">
			<div class="link"><a href="#" id="menu_a5"><img src="../images/t.gif" /></a></div>
            <div class="txt">搜索</div>
		</div>
	</div>
<!--the end-->



<!--nav-->
<div class="video-nav">  <!--不前选中为 class="item item-select"-->
	<div class="item" id="area1_list0">
		<div class="link"><a href="#" id="area1_link0"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt0"></div>
	</div>
	<div class="line" style="top:48px;"></div>
	<div class="item" style="top:50px;" id="area1_list1">
		<div class="link"><a href="#" id="area1_link1"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt1"></div>
	</div>
	<div class="line" style="top:98px;"></div>
	<div class="item" style="top:100px;" id="area1_list2">
		<div class="link"><a href="#" id="area1_link2"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt2"></div>
	</div>
	<div class="line" style="top:148px;"></div>
	<div class="item" style="top:150px;" id="area1_list3">
		<div class="link"><a href="#" id="area1_link3"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt3"></div>
	</div>
	<div class="line" style="top:198px;"></div>
	<div class="item" style="top:200px;" id="area1_list4">
		<div class="link"><a href="#" id="area1_link4"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt4"></div>
	</div>
	<div class="line" style="top:248px;"></div>
	<div class="item" style="top:250px;" id="area1_list5">
		<div class="link"><a href="#"  id="area1_link5"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt5"></div>
	</div>
	<div class="line" style="top:298px;"></div>
	<div class="item" style="top:300px;" id="area1_list6">
		<div class="link"><a href="#" id="area1_link6"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt6"></div>
	</div>
	<div class="line" style="top:348px;"></div>
	<div class="item" style="top:350px;" id="area1_list7">
		<div class="link"><a href="#" id="area1_link7"><img src="../images/t.gif" /></a></div>
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
	<div style="left:102px;">
		<div class="link"><a href="#" id="area2_link1"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img src="../images/btn-next.png" /></div>
	</div>
	<div style="left:195px;"  id="page"></div>
	<div style="left:364px;">
		<div class="link"><a href="#" id="area2_link2"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img src="../images/btn-next.png" /></div>
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
