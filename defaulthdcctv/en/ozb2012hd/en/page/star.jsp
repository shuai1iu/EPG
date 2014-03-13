<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视欧洲杯高清3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<%@ include file="util/save_focus.jsp"%>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="datajsp/star_data.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<script src="../js/pagecontrolx.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
var area0,area1;
window.onload=function(){
    initPage();
	refreshServerTime();
	$("currDate").innerHTML = "<strong>"+strcurdate + "</strong>";
	//alert(jsonvodlist[0].PICPATH);
}

//分页
function getItmsByPage(cptitms,icurpage,ipagesize){
	var reclist=new Array();
	var start = (icurpage-1)*ipagesize;
	for(var i=0;i<ipagesize&&(i+(icurpage-1)*ipagesize)<cptitms.length;i++){
	     reclist[i]=cptitms[start+i];
	}
	return reclist;
}
function initPage(){
	//导航部分
	area0 = AreaCreator(1,6,new Array(-1,-1,1,-1),"menu_a","afocus","ablur");
	area0.stablemoveindex=new Array(-1,-1,"0-0,1-0,2-0,3-0,4-0,5-0",-1);
    area0.setfocuscircle(1);
	bindNavigatData();
	//数据部分
	area1 = AreaCreator(2,6,new Array(0,-1,-1,-1),"area1_link","afocus","ablur");
	area1.stablemoveindex=new Array("0-3,1-3,2-3,3-3,4-3,5-3",-1,-1,-1);
	for(i=0;i<area1.doms.length;i++) area1.doms[i].contentdom=$("area1_txt"+i);
    for(i=0;i<area1.doms.length;i++) area1.doms[i].imgdom=$("area1_img"+i);
    area1.setSimulationAjax(function(){
			 area1curindex=area1.curindex;
             area1curpage=area1.curpage;
			
			 bindVODData(getItmsByPage(jsonvodlist,area1curpage,area1pagesize));
	});
	 area1.areaOkEvent=function(){
		saveFocstr(pageobj);
		location.href = "vod-detail.jsp?typeid=<%=typeid%>"+"&vodid="+area1.doms[area1.curindex].youwanaobj+"&returnurl="+escape(	location.href);
    } 
	
	pageobj = new PageObj(new Array(area0,area1));
	pageobj.backurl=returnurl;

	area1.curpage=area1curpage;
	bindVODData(getItmsByPage(jsonvodlist,area1curpage,area1pagesize));
    pageobj.setinitfocus(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):2);
	
}
</script>
</head>

<body>

<!--head-->
	<div class="date" id="currDate"></div>
	
	<!--menu-->
	<div class="menu"> <!--当前选中为 class="item wid* item-select"；2字宽为wid1;3字宽为

wid2,4字宽为wid3--> 
		<div class="item wid1" id="menu0">
			<div class="link"><a href="#" id="menu_a0"><img 

src="../images/t.gif" /></a></div>
            <div class="txt">欧洲杯</div>
		</div>               
		<div class="item wid3" style="left:128px;"  id="menu1">
			<div class="link"><a href="#" id="menu_a1"><img 

src="../images/t.gif" /></a></div>
            <div class="txt">赛事点播</div>
		</div>
		<div class="item wid3" style="left:346px;" id="menu2">
			<div class="link"><a href="#" id="menu_a2"><img 

src="../images/t.gif" /></a></div>
            <div class="txt">精彩视频</div>
		</div>
		<div class="item wid3 item-select" style="left:564px;" id="menu3">
			<div class="link"><a href="#" id="menu_a3"><img 

src="../images/t.gif" /></a></div>
            <div class="txt">球星殿堂</div>	
		</div>
		<div class="item wid2" style="left:782px;" id="menu4">
			<div class="link"><a href="#" id="menu_a4"><img 

src="../images/t.gif" /></a></div>
            <div class="txt">射手榜</div>	
		</div>
		<div class="item wid1" style="left:952px;" id="menu5">
			<div class="link"><a href="#" id="menu_a5"><img 

src="../images/t.gif" /></a></div>
            <div class="txt">搜索</div>
		</div>
	</div>
<!--the end-->

	
	
<!--video-list-->
<div class="star-list">  
	<div class="item" id="area1_list0">
		<div class="link"><a href="#" id="area1_link0"><img src="../images/t.gif" 

/></a></div>
		<div class="pic"><img src="" id="area1_img0" /></div>
		<div class="txt" id="area1_txt0"></div>
	</div>
	<div class="item" style="left:205px;" id="area1_list1">
		<div class="link"><a href="#" id="area1_link1"><img src="../images/t.gif" 

/></a></div>
		<div class="pic"><img id="area1_img1" src="" /></div>
		<div class="txt" id="area1_txt1"></div>
	</div>
	<div class="item" style="left:410px;" id="area1_list2">
		<div class="link"><a href="#" id="area1_link2"><img src="../images/t.gif" 

/></a></div>
		<div class="pic"><img id="area1_img2" src="" /></div>
		<div class="txt" id="area1_txt2"></div>
	</div>
	<div class="item" style="left:615px;" id="area1_list3">
		<div class="link"><a href="#" id="area1_link3"><img src="../images/t.gif" 

/></a></div>
		<div class="pic"><img id="area1_img3" src="" /></div>
		<div class="txt" id="area1_txt3"></div>
	</div>
	<div class="item" style="left:820px;" id="area1_list4">
		<div class="link"><a href="#" id="area1_link4"><img src="../images/t.gif" 

/></a></div>
		<div class="pic"><img id="area1_img4" src="" /></div>
		<div class="txt" id="area1_txt4"></div>
	</div>
	<div class="item" style="left:1025px;" id="area1_list5">
		<div class="link"><a href="#" id="area1_link5"><img src="../images/t.gif" 

/></a></div>
		<div class="pic"><img id="area1_img5" src="" /></div>
		<div class="txt" id="area1_txt5"></div>
	</div>
	<div class="item" style="top:285px;" id="area1_list6">
		<div class="link"><a href="#" id="area1_link6"><img src="../images/t.gif" 

/></a></div>
		<div class="pic"><img id="area1_img6" src="" /></div>
		<div class="txt" id="area1_txt6"></div>
	</div>
	<div class="item" style="left:205px;top:285px;" id="area1_list7">
		<div class="link"><a href="#" id="area1_link7"><img src="../images/t.gif" 

/></a></div>
		<div class="pic"><img id="area1_img7" src="" /></div>
		<div class="txt" id="area1_txt7"></div>
	</div>
	<div class="item" style="left:410px;top:285px;" id="area1_list8">
		<div class="link"><a href="#" id="area1_link8"><img src="../images/t.gif" 

/></a></div>
		<div class="pic"><img id="area1_img8" src="" /></div>
		<div class="txt" id="area1_txt8"></div>
	</div>
	<div class="item" style="left:615px;top:285px;" id="area1_list9">
		<div class="link"><a href="#" id="area1_link9"><img src="../images/t.gif" 

/></a></div>
		<div class="pic"><img id="area1_img9" src="" /></div>
		<div class="txt" id="area1_txt9"></div>
	</div>
	<div class="item" style="left:820px;top:285px;" id="area1_list10">
		<div class="link"><a href="#" id="area1_link10"><img src="../images/t.gif" 

/></a></div>
		<div class="pic"><img id="area1_img10" src="" /></div>
		<div class="txt" id="area1_txt10"></div>
	</div>
	<div class="item" style="left:1025px;top:285px;" id="area1_list11">
		<div class="link"><a href="#" id="area1_link11"><img src="../images/t.gif" 

/></a></div>
		<div class="pic"><img id="area1_img11" src="" /></div>
		<div class="txt" id="area1_txt11"></div>
	</div>
</div>
<!--the end-->	



<!--page-->
<div class="page" style="left:145px; top:673px;">  
	<div class="item01" id="page"></div>
</div>
<!--the end-->
<%@ include file="servertimehelp.jsp" %>	
</body>
</html>
