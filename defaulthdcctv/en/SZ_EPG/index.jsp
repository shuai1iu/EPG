<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页-上海电信应用商城EPG3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<style type="text/css">
<!--
	body{ background:url(../images/bg01.jpg) no-repeat;}
-->
</style>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="util/save_focus.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<%@ include file="datajsp/indexdata.jsp"%>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
var area0,area1,area2;
var areaid = 2,indexid = 1;
window.onload = function(){
	area0=AreaCreator(1,1,new Array(-1,-1,2,1),"area0_list_","className:item item_focus","className:item");
	area0.doms[0].imgdom=$("area0_img_0");
	area1=AreaCreator(2,2,new Array(-1,0,2,-1),"area1_list_","className:item item_focus","className:item");
	for(var i=0;i<area1.doms.length;i++){
		area1.doms[i].imgdom=$("area1_img_"+i);
	}
	area1.stablemoveindex=new Array(-1,-1,"2-3,3-5",-1);
	area2=AreaCreator(1,6,new Array(0,-1,-1,-1),"area2_list_","className:item item_focus","className:item");
	area2.stayindexdir = 1;
	area2.doms[0].mylink = "../../index.jsp?back=1";
	area2.doms[1].mylink = "hdlist.jsp?typeid=<%=gaoqingdapian%>";
	area2.doms[2].mylink = "hdlist.jsp?typeid=<%=gaoqingreju%>";
	area2.doms[3].mylink = "hdlist.jsp?typeid=<%=gaoqingjishi%>";
	area2.doms[4].mylink = "hdlist.jsp?typeid=<%=gaoqingyule%>";
	//area2.doms[5].mylink = "../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&INITFLAG=1&RRETURNFLAG=1&BUSINESSTYPE=1&ISVIP=1&PROGID=1659159&FATHERSERIESID=1659590&backurl=/EPG/jsp/defaulthdcctv/en/SZ_EPG/page/index.jsp";
//	area2.doms[5].mylink ="check/page/packages.jsp";
    //更换半价特惠包页面入口
    area2.doms[5].mylink = "check/page/activityVIP.jsp";
	area2.stablemoveindex=new Array("3-1>2,4-1>2,5-1>3",-1,-1,-1);
	if(focusObj!=undefined&&focusObj!="null"){
		areaid = parseInt(focusObj[0].areaid);
		indexid = parseInt(focusObj[0].curindex);
	}
	pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area0, area1, area2));
	pageobj.backurl = "../../index.jsp?back=1";
	pageobj.pageOkEvent=function(){
		saveFocstr(pageobj);  
	}
	initData();
}
function initData(){
	area0.doms[0].updateimg(datalist1[0].VASPIC);
	area0.doms[0].mylink = datalist1[0].VASURL;
	for(var i=0;i<area1.doms.length;i++){
		area1.doms[i].updateimg(datalist2[i].VASPIC);
		area1.doms[i].mylink = datalist2[i].VASURL;
	}
}
</script>
</head>

<body>

<!--head-->
<div class="logo">
	<div class="pic"><img src="../images/logo.png" /></div>
	<div class="pic"  style="left:300px;"><img src="../images/discount_banner.png" /></div>
</div>
</div>
<div style="color:#525252;font-size:24px;height:36px;line-height:36px;left:238px; position:absolute;top:47px;width:200px;">尊享视界</div>

<div class="adfont"><img src="../images/adfont.png" /></div>
<!--head the end-->	


<!--poster-->	
<div class="poster-a">
	<!--焦点 
		class="item item_focus"
	-->
	<div class="item" id="area0_list_0">
		<div class="link"></div>
		<div class="pic"><img id="area0_img_0"/></div>	
	</div>
</div>

<div class="poster-b">
	<!--焦点 
		class="item item_focus"
	-->
	<div class="item" id="area1_list_0">
		<div class="link link01"></div>
		<div class="pic"><img id="area1_img_0"/></div>		
	</div>
</div>

<div class="poster-b" style="left:945px;">
	<!--焦点 
		class="item item_focus"
	-->
	<div class="item" id="area1_list_1">
		<div class="link link01"></div>
		<div class="pic"><img id="area1_img_1"/></div>	
	</div>
</div>

<div class="poster-b" style="top:340px;">
	<!--焦点 
		class="item item_focus"
	-->
	<div class="item" id="area1_list_2">
		<div class="link link02"></div>
		<div class="pic"><img id="area1_img_2"/></div>
	</div>
</div>

<div class="poster-b" style="left:945px;top:340px;">
	<!--焦点 
		class="item item_focus"
	-->
	<div class="item" id="area1_list_3">
		<div class="link link02"></div>
		<div class="pic"><img id="area1_img_3"/></div>
	</div>
</div>
<!--poster the end-->	

	
<!--menu-->	
<div class="menu">
	<!--焦点 
			class="item item_focus"
		-->
	<div class="item" id="area2_list_0">
		<div class="icon icon01"></div>
		<div class="txt">首页</div>
	</div>
	<div class="item" style="left:189px;" id="area2_list_1">
		<div class="icon icon02"></div>
		<div class="txt">高清大片</div>
	</div>
	<div class="item" style="left:378px;" id="area2_list_2">
		<div class="icon icon03"></div>
		<div class="txt">高清热剧</div>
	</div>
	<div class="item" style="left:567px;" id="area2_list_3">
		<div class="icon icon05"></div>
		<div class="txt">高清纪实</div>
	</div>
	<div class="item" style="left:756px;" id="area2_list_4">
		<div class="icon icon04"></div>
		<div class="txt">高清娱乐</div>
	</div>
	<div class="item" style="left:945px;" id="area2_list_5">
		<div class="icon icon06"></div>
		<div class="icon" style="left:32px;top:2px;width:53px;height:53px;"><img src="../images/menu/discount.png" /></div>
		<div class="txt">订购</div>
	</div>
</div>
<!--menu the end-->		
	
	
</body>
</html>
