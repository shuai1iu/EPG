<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视深圳标清 改版EPG2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/style2.css" />
<style type="text/css">
body {
    background: #0d4764 url("../images/bg02.jpg") no-repeat;
}
</style>
<%@ include file="util/save_focus.jsp"%>
<%@ include file="datajsp/vodlist_data.jsp"%>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
if (typeof(iPanel) != 'undefined'){iPanel.focusWidth = "2";iPanel.defaultFocusColor = "#FCFF05";}
var area0;
var areaid=0;
var indexid=0;
window.onload = function(){
	area0=AreaCreator(2,4,new Array(-1,-1,-1,-1),"area0_list_","afocus","ablur");
	for(i=0;i<area0.doms.length;i++) {
		area0.doms[i].contentdom=$("area0_txt_"+i);
		area0.doms[i].imgdom=$("area0_img_"+i);
	}
	area0.setcrossturnpage();
	area0.curpage = focusObj!=undefined&&focusObj!="null"?focusObj[0].curpage:1;
	area0.pagecount = pagecount;
	bindVodlistData(getItmsByPage(jVodlist,area0.curpage,area0.doms.length))
	area0.asyngetdata=function(){
		bindVodlistData(getItmsByPage(jVodlist,area0.curpage,area0.doms.length));	
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

<body bgcolor="transparent">
<div class="wrapper">
	<!--head-->
	<div class="txt txt-headline" id="catename"></div>
	<!--the end-->
	
	
	<!--list-->
	<div class="list" style="left:15px; top:60px;">
		<div class="item">
			<div class="pic"><a href="#" id="area0_list_0"><img id="area0_img_0" width="118" height="163" src="#" /></a></div>
			<div class="txt txt03" id="area0_txt_0"></div>
		</div>
	  	<div class="item" style="left:150px;">
			<div class="pic"><a href="#" id="area0_list_1"><img id="area0_img_1" width="118" height="163" src="#" /></a></div>
			<div class="txt txt03" id="area0_txt_1"></div>
		</div>
		<div class="item" style="left:300px;">
			<div class="pic"><a href="#" id="area0_list_2"><img id="area0_img_2" width="118" height="163" src="#" /></a></div>
			<div class="txt txt03" id="area0_txt_2"></div>
		</div>
		<div class="item" style="left:450px;">
			<div class="pic"><a href="#" id="area0_list_3"><img id="area0_img_3" width="118" height="163" src="#" /></a></div>
			<div class="txt txt03" id="area0_txt_3"></div> 
		</div>
		<div class="item" style="top:215px;">
			<div class="pic"><a href="#" id="area0_list_4"><img id="area0_img_4" width="118" height="163" src="#" /></a></div>
			<div class="txt txt03" id="area0_txt_4"></div>
		</div>
	  	<div class="item" style="left:150px;top:215px;">
			<div class="pic"><a href="#" id="area0_list_5"><img id="area0_img_5" width="118" height="163" src="#" /></a></div>
			<div class="txt txt03" id="area0_txt_5"></div>
		</div>
		<div class="item" style="left:300px;top:215px;">
			<div class="pic"><a href="#" id="area0_list_6"><img id="area0_img_6" width="118" height="163" src="#" /></a></div>
			<div class="txt txt03" id="area0_txt_6"></div>
		</div>
		<div class="item" style="left:450px;top:215px;">
			<div class="pic"><a href="#" id="area0_list_7"><img id="area0_img_7" width="118" height="163" src="#" /></a></div>
			<div class="txt txt03" id="area0_txt_7"></div>
		</div>
	</div>
	<!--the end-->
	
	
	<!--page-->
	<div class="page" id="pageinfo"></div>
	<!--the end-->
</div>	

</body>
</html>
