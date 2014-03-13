<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视欧洲杯高清3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<%@ include file="util/save_focus.jsp"%>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="datajsp/vod_data.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<script src="../js/pagecontrolx.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
var area0,area1,area2;
var fanye=false,liandong=true;
window.onload=function(){
     initPage(focstr);
	 //refreshServerTime();
	 
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
	area2pagecount=thisjson.jsonpage;
	area2pagesize=10;
	area2.curpage=1;
	area2.curindex=0;
	area2curindex=area2.curindex;
	area2curpage=area2.curpage;
	bindVODData(getItmsByPage(jsonvodlist,area2curpage,area2pagesize));
   
}
function bindNavigatData(){
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
}
function initPage(){
	area0 = AreaCreator(1,6,new Array(-1,-1,2,-1),"menu_a","afocus","ablur");
//	alert(area0.curpage);
	area0.stablemoveindex=new Array(-1,-1,"0-0,1-0,2-1,3-1,4-2,5-2",-1);
	area0.setfocuscircle(1);
	bindNavigatData();
	
	area1=AreaCreator(8,1,new Array(0,-1,-1,2),new Array("area1_link","area1_list"),new Array("afocus","className:item"),new Array("ablur","className:item"));
	area1.setstaystyle(new Array("ablur","className:item item-select"),3);
	area1.setfocuscircle(0);
	area1.setcrossturnpage();
	if(jsoncatelist.length!=0){
			 area1.setdarknessfocus(area1curindex);
	}
	area1.curpage=area1curpage;
	for(i=0;i<area1.doms.length;i++) area1.doms[i].contentdom=$("area1_txt"+i);
	area1.setSimulationAjax(function(){
		bindCateData(getItmsByPage(jsoncatelist,area1.curpage,area1.doms.length));
	});
		 
	area2 = AreaCreator(2,5,new Array(0,1,-1,-1),"area2_link","afocus","ablur");
	for(i=0;i<area2.doms.length;i++) area2.doms[i].contentdom=$("area2_txt"+i);
	for(i=0;i<area2.doms.length;i++) area2.doms[i].imgdom=$("area2_img"+i); 
	area1.dataarea=area2;
	area2.setTrueAjax("datajsp/vod_data_iframe.jsp?typeid=#(area1.doms[area1.curindex].youwanaobj)&area2curpage=#(area2.curpage)",bindData);	 
	area2.setSimulationAjax(function(){
		area2curindex=area2.curindex;
        area2curpage=area2.curpage;	
		bindVODData(getItmsByPage(jsonvodlist,area2curpage,area2pagesize));
	});
		
	area2.areaOkEvent=function(){
		saveFocstr(pageobj);
		location.href = "vod-detail.jsp?typeid="+ area1.doms[area1.curindex].youwanaobj +"&vodid="+area2.doms[area2.curindex].youwanaobj+"&returnurl="+escape(location.href);
	}  
	 pageobj = new PageObj(new Array(area0,area1,area2));
	 pageobj.backurl=returnurl;
     area2.curpage=area2curpage;
	 bindCateData(getItmsByPage(jsoncatelist,area1curpage,area1pagesize));
		
	 bindVODData(getItmsByPage(jsonvodlist,area2curpage,area2pagesize))
		 
	
	 pageobj.setinitfocus(areaid!=null?parseInt(areaid):2,indexid!=null?parseInt(indexid):0);
	   //  alert(area0);
}
</script>
</head>

<body>

<!--head-->
	<div class="date"></div>
	
	<!--menu-->
	<div class="menu"> <!--当前选中为 class="item wid* item-select"；2字宽为wid1;3字宽为wid2,4字宽为wid3--> 
		<div class="item wid1" id="menu0">
			<div class="link"><a href="#" id="menu_a0"><img src="../images/t.gif" /></a></div>
            <div class="txt">首页</div>
		</div>               
		<div class="item wid3" style="left:128px;" id="menu1">
			<div class="link"><a href="#" id="menu_a1"><img src="../images/t.gif" /></a></div>
            <div class="txt">赛事点播</div>
		</div>
		<div class="item wid3 item-select" style="left:346px;" id="menu2">
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



<!--nav-->
<div class="video-nav">  <!--不前选中为 class="item item-select"-->
	<div class="item item-select" id="area1_list0">
		<div class="link"><a href="#" id="area1_link0"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt0"></div>
	</div>
	<div class="line" style="top:66px;"></div>
	<div class="item" style="top:68px;"  id="area1_list1">
		<div class="link"><a href="#" id="area1_link1"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt1"></div>
	</div>
	<div class="line" style="top:134px;"></div>
	<div class="item" style="top:136px;" id="area1_list2">
		<div class="link"><a href="#" id="area1_link2"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt2"></div>
	</div>
	<div class="line" style="top:202px;"></div>
	<div class="item" style="top:204px;" id="area1_list3">
		<div class="link"><a href="#" id="area1_link3"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt3"></div>
	</div>
	<div class="line" style="top:270px;"></div>
	<div class="item" style="top:272px;" id="area1_list4">
		<div class="link"><a href="#" id="area1_link4"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt4"></div>
	</div>
	<div class="line" style="top:338px;"></div>
	<div class="item" style="top:340px;" id="area1_list5">
		<div class="link"><a href="#" id="area1_link5"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt5"></div>
	</div>
	<div class="line" style="top:406px;"></div>
	<div class="item" style="top:408px;" id="area1_list6">
		<div class="link"><a href="#" id="area1_link6"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt6"></div>
	</div>
	<div class="line" style="top:474px;"></div>
	<div class="item" style="top:476px;" id="area1_list7">
		<div class="link"><a href="#" id="area1_link7"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area1_txt7"></div>
	</div>
</div>
<!--the end-->


	
<!--video-list-->
<div class="video-list">  
	<div class="item" id="area2_list0">
		<div class="link"><a href="#" id="area2_link0"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img0" src="" /></div>
		<div class="txt" id="area2_txt0"></div>
	</div>
	<div class="item" style="left:186px;" id="area2_list1">
		<div class="link"><a href="#" id="area2_link1"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img1" src="" /></div>
		<div class="txt" id="area2_txt1"></div>
	</div>
	<div class="item" style="left:372px;" id="area2_list2">
		<div class="link"><a href="#" id="area2_link2"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img2" src="" /></div>
		<div class="txt" id="area2_txt2"></div>
	</div>
	<div class="item" style="left:558px;" id="area2_list3">
		<div class="link"><a href="#" id="area2_link3"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img3" src="" /></div>
		<div class="txt" id="area2_txt3"></div>
	</div>
	<div class="item" style="left:744px;" id="area2_list4">
		<div class="link"><a href="#" id="area2_link4"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img4" src="" /></div>
		<div class="txt" id="area2_txt4"></div>
	</div>
	<div class="item" style="top:278px;" id="area2_list5">
		<div class="link"><a href="#" id="area2_link5"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img5" src="" /></div>
		<div class="txt" id="area2_txt5"></div>
	</div>
	<div class="item" style="left:186px;top:278px;" id="area2_list6">
		<div class="link"><a href="#" id="area2_link6"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img6" src="" /></div>
		<div class="txt" id="area2_txt6"></div>
	</div>
	<div class="item" style="left:372px;top:278px;" id="area2_list7">
		<div class="link"><a href="#" id="area2_link7"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img7" src="" /></div>
		<div class="txt" id="area2_txt7"></div>
	</div>
	<div class="item" style="left:558px;top:278px;" id="area2_list8">
		<div class="link"><a href="#" id="area2_link8"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img8" src="" /></div>
		<div class="txt" id="area2_txt8"></div>
	</div>
	<div class="item" style="left:744px;top:278px;" id="area2_list9">
		<div class="link"><a href="#" id="area2_link9"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img9" src="" /></div>
		<div class="txt" id="area2_txt9"></div>
	</div>
</div>
<!--the end-->	



<!--page-->
<div class="page" style=" left:337px; top:668px;">  
	<div class="item02" id="page"></div>
</div>
<!--the end-->
		
</body>
</html>
