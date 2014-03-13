<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视深圳标清 改版EPG2.0</title>
<meta name="page-view-size" content="640*530" />
<style type="text/css">
body {
    background: #0d4764 url("../images/bg02.jpg") no-repeat;
}
</style>
<link type="text/css" rel="stylesheet" href="../css/style2.css" />
<%@ include file="util/save_focus.jsp"%>
<%@ include file="datajsp/new-catelist2_data.jsp"%>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
if (typeof(iPanel) != 'undefined'){iPanel.focusWidth = "2";iPanel.defaultFocusColor = "#FCFF05";}
var area0;
var areaid=0;
var indexid=0;
window.onload = function(){
	area0=AreaCreator(2,3,new Array(-1,-1,-1,-1),"area0_list_","afocus","ablur");
	for(i=0;i<area0.doms.length;i++) {
		area0.doms[i].contentdom=$("area0_txt_"+i);
		area0.doms[i].imgdom=$("area0_img_"+i);
	}
	area0.setcrossturnpage();
	area0.curpage = focusObj!=undefined&&focusObj!="null"?focusObj[0].curpage:1;
	area0.pagecount = pagecount;
	bindCateData(getItmsByPage(jCatelist,area0.curpage,area0.doms.length))
	area0.asyngetdata=function(){
		bindCateData(getItmsByPage(jCatelist,area0.curpage,area0.doms.length))
	};	
	if(focusObj!=undefined&&focusObj!="null"){
		areaid = parseInt(focusObj[0].areaid);
		indexid = parseInt(focusObj[0].curindex);
	}
    pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0,new Array(area0));
	pageobj.backurl=returnurl;
	pageobj.pageOkEvent=function(){
	   saveFocstr(pageobj);    
    }
}

function getItmsByPage(cptitms,icurpage,ipagesize){
	var reclist=new Array();
	var start = (icurpage-1)*ipagesize;
	for(var i=0;i<ipagesize&&(i+start)<cptitms.length;i++){
	     reclist[i]=cptitms[start+i];
	}
	return reclist;
}
</script>
</head>

<body>
<div class="wrapper">

	<!--head-->
	<div id="catename" class="txt txt-headline-a"></div>
	<!--the end-->
	
	
	<!--list-->
	<div class="list-room">
		<div class="item">
			<div class="pic"><img id="area0_img_0" src="../images/classroom01.png" /></div>
			<div class="txt-wrap"><a href="#" id="area0_list_0"><img src="../images/classroom-titbg.png" /></a></div>
			<div class="txt" id="area0_txt_0"></div>
		</div>
	  	<div class="item" style="left:210px;">
			<div class="pic"><img id="area0_img_1" src="../images/classroom02.png" /></div>
			<div class="txt-wrap"><a href="#" id="area0_list_1"><img src="../images/classroom-titbg.png" /></a></div>
			<div class="txt" id="area0_txt_1"></div>
		</div>
		<div class="item" style="left:420px;">
			<div class="pic"><img id="area0_img_2" src="../images/classroom03.png" /></div>
			<div class="txt-wrap"><a href="#" id="area0_list_2"><img src="../images/classroom-titbg.png" /></a></div>
			<div class="txt" id="area0_txt_2"></div>
		</div>
		<div class="item" style="top:208px;">
			<div class="pic"><img id="area0_img_3" src="../images/classroom04.png" /></div>
			<div class="txt-wrap"><a href="#" id="area0_list_3"><img src="../images/classroom-titbg.png" /></a></div>
			<div class="txt" id="area0_txt_3"></div>
		</div>
	  	<div class="item" style="left:210px;top:208px;">
			<div class="pic"><img id="area0_img_4" src="../images/classroom05.png" /></div>
			<div class="txt-wrap"><a href="#" id="area0_list_4"><img src="../images/classroom-titbg.png" /></a></div>
			<div class="txt" id="area0_txt_4"></div>
		</div>
		<div class="item" style="left:420px;top:208px;">
			<div class="pic"><img id="area0_img_5" src="../images/classroom06.png" /></div>
			<div class="txt-wrap"><a href="#" id="area0_list_5"><img src="../images/classroom-titbg.png" /></a></div>
			<div class="txt" id="area0_txt_5"></div>
		</div>
	</div>
	<!--the end-->
	
	
	<!--page-->
	<div id="pageinfo" class="page"></div>
	<!--the end-->
	
</div>	

</body>
</html>
