<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%
	String JP_TYPE_ID="10000100000000090000000000009279,10000100000000090000000000005118,10000100000000090000000000009428,10000100000000090000000000006303,10000100000000090000000000010775,10000100000000090000000000008270";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页-菜单弹出- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<style>
/* =S Css Reset
----------------------------------------------- */
body, div, h1, h2, h3, h4, h5, h6, button, input, textarea, th, td { margin: 0; padding: 0; }
body, div, button, input, select, textarea { font-size: 22px; font-family: SimHei,sans-serif; line-height: 100%; }
h1, h2, h3, h4, h5, h6 { font-size: 100%; }
a { text-decoration: none; }
fieldset, img { border: 0; }
button, input, select, textarea { font-size:100%; }

/* =S Global
----------------------------------------------- */
.item, .link, .txt-wrap, .txt, .btn, .icon, .pic, .cover, .num, .win { 
	left: 0;
	position:absolute;
	top: 0;
}
.link { z-index: 9;}
.txt { z-index: 7;}
.txt-wrap { z-index: 6;}
.icon { z-index: 5;}
.cover { z-index: 4;}
.pic { z-index: 3;}
.btn { z-index:8;}

body, .wrapper {
    height: 720px;
    width: 1280px;
    background: transparent;
    /*overflow: hidden;*/
    position: relative;
}
body {
   /* background-color: #000;*/
    color: #f0f0f0;
}
.wrapper,.pagebg {
	left: 0;
	position: absolute;
	top: 0;
}
.wrapper {
	z-index: 2;
}
.pagebg {
	z-index: 1;
}
.logo {
	left: 74px;
	position: absolute; 
	top: 16px; 
}
.date {
	left: 1137px;
	position: absolute;
	top: 20px;
}
.date .txt {
	color:#c1c0c5;
	text-align:right;
	height:22px;
	width:100px;
}
.date .txt-time {
	color:#e2e1e1;
	font-size:26px;
}

/* index ----------------------------------------------- */
.btn-menu {
	left:0;
	position:absolute; 
	top:192px; 
}
.title {
	left:0;
	position:absolute; 
	top:99px;
	z-index:5;
}
.menu-a {
	background:url(../../images/menu-bg01.png) no-repeat;
	left:0;
	position:absolute; 
	top:120px; 
	height:600px;
	width:251px;
	z-index:10;
}
.menu-a .item {
	height:60px;
	width:220px;
	top:57px;
}
.menu-a .item .icon,
.menu-a .item .icon img {
	height:50px;
	width:60px;
}
.menu-a .item .icon {
	left:23px;
	top:4px;
}
.menu-a .item .txt {
	font-size:26px;
	line-height:60px;
	left:105px;
	width:100px;
}
.menu-a .item_focus {
	background:url(../../images/menu-bg_focus.png) no-repeat;
}
.menu-a .item_focus .txt {
	color:#ffde00;
	font-size:28px;
}
.menu-a .item_select {
	background:url(../../images/menu-bg_select.png) no-repeat;
}
.menu-a .item_select .txt {
	color:#efa423;
}


/*list-pic----------------------------------------------------*/
.list-pic-a {
	left:83px;
	position:absolute;
	top:89px;
}
.list-pic-a .item {
	height:144px;
	width:232px;
}
.list-pic-a .item .pic,
.list-pic-a .item .pic img {
	height:113px;
	width:196px;
}
.list-pic-a .item .pic {
	left:18px;
	top:15px;
}
.list-pic-a .item .txt {
	background:url(../../images/trans70.png) repeat;
	text-align:center;
	line-height:44px;
	left: 18px;
	top: 84px;
	height:44px;
	width:196px;
}
.list-pic-a .item_focus {
	background:url(../../images/picBg01_focus.png) no-repeat;
}
.list-pic-a .item_focus .pic,
.list-pic-a .item_focus .pic img {
	height:123px;
	width:212px;
}
.list-pic-a .item_focus .pic {
	left:10px;
	top:10px;
}
.list-pic-a .item_focus .txt {
	left: 10px;
	top: 89px;
	width:212px;
}
.list-pic-b {
	left:316px;
	position:absolute;
	top:422px;
}
.list-pic-b .item {
	height:120px;
	width:214px;
}
.list-pic-b .item .pic,
.list-pic-b .item .pic img {
	height:100px;
	width:194px;
}
.list-pic-b .item .pic {
	left:10px;
	top:10px;
}
.list-pic-b .item .txt {
	background:url(../../images/trans70.png) repeat;
	text-align:center;
	line-height:40px;
	left: 10px;
	top: 70px;
	height:40px;
	width:194px;
}
.list-pic-b .item_focus {
	background:url(../../images/picBg02_focus.png) no-repeat;
}
.list-pic-c {
	left:927px;
	position:absolute;
	top:539px;
}
.list-pic-c .item {
	height:125px;
	width:323px;
}
.list-pic-c .item .pic,
.list-pic-c .item .pic img {
	height:105px;
	width:303px;
}
.list-pic-c .item .pic {
	left:10px;
	top:10px;
}
.list-pic-c .item .txt {
	background:url(../../images/trans70.png) repeat;
	text-align:center;
	line-height:40px;
	left: 10px;
	top: 75px;
	height:40px;
	width:303px;
}
.list-pic-c .item_focus {
	background:url(../../images/picBg03_focus.png) no-repeat;
}

/*list----------------------------------------------------*/
.list-a {
	left:331px;
	position:absolute;
	top:547px;
}
.list-a .item {
	color:#74bbf8;
	font-size:24px;
	text-align:center;
	line-height:30px;
	height:30px;
	width:110px;
}
/*.list-a .item_focus {
	background:url(../images/bord01_focus.png) no-repeat;
}*/
.list-a .item-a {
	width:125px;
}
.list-b {
	left:337px;
	position:absolute;
	top:614px;
}
.list-b .item {
	color:#dbe9fa;
	font-size:24px;
	text-align:center;
	line-height:40px;
	height:40px;
	width:110px;
}
/*.list-b .item_focus {
	background:url(../../images/bord02_focus.png) no-repeat;
}*/
.list-c {
	background:url(../../images/r-top-bg.jpg) no-repeat;
	left:933px;
	position:absolute;
	top:141px;
	height:366px;
	width:308px;
}
.list-c .item {
	color:#ccc;
	line-height:48px;
	left:20px;
	height:48px;
	width:125px;
}
/*.list-c .item_focus {
	background:url(../../images/bord03_focus.png) no-repeat;
}*/
.list-a .item_focus,
.list-b .item_focus,
.list-c .item_focus,
.list-d .item_focus,
.list-f .item_focus .txt {
	color:#ffde00;
}

/*video----------------------------------------------------*/
.video {
	left: 315px;
	position: absolute;
	top: 74px;
}
.video .item {
	height:360px;
	width:623px;
}
.video .item .pic {
	left:10px;
	top:10px;
	height:340px;
	width:603px;
}
.video .item_focus {
	background:url(../../images/video_focus.png) no-repeat;
}
.video .item .btn {
	left:265px;
	top:134px;
}
.video-channel {
	left: 719px;
	position: absolute;
	top: 116px;
}
.video-channel .item {
	height:320px;
	width:420px;
}
.video-channel .item .pic {
	left:10px;
	top:10px;
	height:300px;
	width:400px;
}
.video-channel .txt {
	font-size:26px;
	font-weight:bold;
	left:10px;
	top:312px;
	text-align:center;
	line-height:60px;
	height:60px;
	width:400px;
}
.video-channel .item_focus {
	background:url(../../images/video02_focus.png) no-repeat;
}

/*marquee----------------------------------------------------*/
.bottom-marquee {
	color:#fff;
	left: 80px;
	position:absolute;
	top: 673px;
	height:24px;
	width:1160px;
}
.marquee {
	background:url(../../images/marquee-bg.png) no-repeat;
	left: 263px;
	position:absolute;
	top: 649px;
	height:42px;
	width:942px;
}
.marquee .txt,
.marquee02 .txt {
	line-height:42px;
	height:42px;
}
.marquee .txt01,
.marquee02 .txt01 {
	color:#b3b399;
	left:60px;
	width:110px;
}
.marquee .txt02 {
	color:#a2a29f;
	left:190px;
	width:735px;
}
.marquee02 {
	background:url(../../images/marquee-bg02.png) no-repeat;
	left: 113px;
	position:absolute;
	top: 639px;
	height:42px;
	width:1052px;
}
.marquee02 .txt02 {
	color:#a2a29f;
	left:190px;
	width:850px;
}
.sub-a {
	left:933px;
	position:absolute; 
	top:79px; 
}
.sub-a .item,
.sub-a .item .txt {
	height:62px;
	width:308px;
}
.sub-a .item .txt-a {
	background:url(../../images/r-tit-new.jpg) no-repeat;
}
.sub-a .item_focus .txt-b {
	background:url(../../images/r-tit-top.jpg) no-repeat;
}

</style>
<style type="text/css">
<!--
	/*body{ background:url(../../images/) no-repeat;}*/
-->
</style>
<%@ include file="../../../config/properties.jsp"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String strFile="../../../" + datajspname  + "/vodList.jsp";
String strFileCate="../../../"+ datajspname +"/categoryList.jsp";
%>
<%@ include file="../../../util/servertime.jsp"%>
<%@ include file="../../../config/code.jsp"%>
<script type="text/javascript">
		//左侧影片列表
       <jsp:include page="<%=strFile%>">
            <jsp:param name="categoryCode" value="<%=leftVodCode%>" /> 
		    <jsp:param name="varName" value="leftVodList" /> 
		    <jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="4" />
			<jsp:param name="fields" value="-1" />
			<jsp:param name="isBug" value="1" />
       </jsp:include>
		
		//中间影片列表
		<jsp:include page="<%=strFile%>">
            <jsp:param name="categoryCode" value="<%=centerVodCode%>" /> 
		    <jsp:param name="varName" value="centerVodList" />
		    <jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="3" />
			<jsp:param name="fields" value="-1" />
       </jsp:include>
	   
	   //最新上线影片列表
	   <jsp:include page="<%=strFile%>">
            <jsp:param name="categoryCode" value="<%=newVodCode%>" /> 
		    <jsp:param name="varName" value="newVodList" /> 
		    <jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="14" />
			<jsp:param name="fields" value="-1" />
       </jsp:include>
	   
	   //top榜影片列表
	   <jsp:include page="<%=strFile%>">
            <jsp:param name="categoryCode" value="<%=topVodCode%>" /> 
		    <jsp:param name="varName" value="topVodList" /> 
		    <jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="14" />
			<jsp:param name="fields" value="-1" />
       </jsp:include>
	   
	   //重磅推荐
	   <jsp:include page="<%=strFile%>">
            <jsp:param name="categoryCode" value="<%=recVodCode%>" /> 
		    <jsp:param name="varName" value="recVodList" /> 
		    <jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="1" />
			<jsp:param name="fields" value="-1" />
       </jsp:include>
	   
	   //栏目（area3）
	   <jsp:include  page="<%=strFileCate%>">
			<jsp:param name="parentCategoryCode" value="<%=categoryCode1%>" /> 
			<jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="10" /> 
			<jsp:param name="varName" value="categoryListData1" />
			<jsp:param name="fileds" value="-1" />
			<jsp:param name="isBug" value="1" />
  		</jsp:include>
		
		//栏目（area4）
	   <jsp:include  page="<%=strFileCate%>">
			<jsp:param name="parentCategoryCode" value="<%=categoryCode2%>" /> 
			<jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="5" /> 
			<jsp:param name="varName" value="categoryListData2" />
			<jsp:param name="fileds" value="-1" />
			<jsp:param name="isBug" value="1" />
  		</jsp:include>
</script>
<script type="application/javascript" src="../../js/MediaPlayer.js"></script>
<%@ include file="../../base.jsp"%>
<script type="application/javascript">
	var area0,area1,area2,area3,area4,area5,area6,area7,area8;
	var t;
	var area1_index = 0;
	var isBack = getParameter("isBack");
	var iReturnUrl = "index.jsp";
	var areaid = parseInt(getParameter("areaid"));
	var indexid = parseInt(getParameter("indexid"));
	var channelIndex="12";
	var returnUrl = window.location.href;
	returnUrl = returnUrl.substring(0,returnUrl.indexOf("?"));	
	window.onload = function(){
		window.focus();
		var focusObj=OperatorFocus.getCurFocusAndDelete();
		if(focusObj!=undefined && focusObj!="null" && focusObj!=null)
	    {
			if(focusObj.focusdatas!=undefined && focusObj.focusdatas.length>0)
			{				
				 areaid=focusObj.focusdatas[0].areaid;
			     indexid=focusObj.focusdatas[0].curindex;
			}
		}
		area0 = AreaCreator(4,1,new Array(-1,8,-1,1),"area0_list_","className:item item_focus","className:item");
		for(var i=0;i<area0.doms.length;i++){
			area0.doms[i].contentdom = $("area0_txt_"+i);
		}
		area0.areaOkEvent = function(){
			if(leftVodList.vodDataList[area0.curindex].programType == 1){
				window.location.href = "../dibbling/detail-single.jsp?programCode="+leftVodList.vodDataList[area0.curindex].programCode+"&contentCode="+leftVodList.vodDataList[area0.curindex].contentCode+"&categoryCode="+leftVodList.vodDataList[area0.curindex].categoryCode;
			}else{
				window.location.href = "../dibbling/detail-much.jsp?programCode="+leftVodList.vodDataList[area0.curindex].programCode+"&contentCode="+leftVodList.vodDataList[area0.curindex].contentCode+"&categoryCode="+leftVodList.vodDataList[area0.curindex].categoryCode;
			}
		}
		
		area1 = AreaCreator(1,1,new Array(-1,0,2,5),"area1_list_","className:item item_focus","className:item");
		area1.areaOkEvent = function(){

			window.location.href ="../channel/channelPlayer.jsp?channelIndex="+channelIndex;
		}
		
		area2 = AreaCreator(1,3,new Array(1,0,3,6),"area2_list_","className:item item_focus","className:item");
		for(var i=0;i<area2.doms.length;i++){
			area2.doms[i].contentdom = $("area2_txt_"+i);
		}
		area2.areaOkEvent= function(){
		    if(centerVodList.vodDataList[area2.curindex].programType == 1){
				window.location.href = "../dibbling/detail-single.jsp?programCode="+centerVodList.vodDataList[area2.curindex].programCode+"&contentCode="+centerVodList.vodDataList[area2.curindex].contentCode+"&categoryCode="+centerVodList.vodDataList[area2.curindex].categoryCode;
			}else{
				window.location.href = "../dibbling/detail-much.jsp?programCode="+centerVodList.vodDataList[area2.curindex].programCode+"&contentCode="+centerVodList.vodDataList[area2.curindex].contentCode+"&categoryCode="+centerVodList.vodDataList[area2.curindex].categoryCode;
			}
		}
		area3 = AreaCreator(2,5,new Array(2,0,4,7),"area3_list_","className:item item_focus","className:item");
		//area3.slitherParam=new Array("area3_focus",0,0,120,30,10,40,10);
		area3.stablemoveindex = new Array(-1,-1,"5-0,6-1,7-2,8-3,9-4",-1);
		for(var i=0;i<area3.doms.length;i++){
			area3.doms[i].contentdom = $("area3_list_"+i);
		}
	
	    area3.areaOkEvent = function(){
				var parentCategoryCode=categoryListData1.categoryList[area3.curindex].parentCategoryCode;
				var categoryName=categoryListData1.categoryList[area3.curindex].name;
				var curindex=area3.curindex;
			    window.location.href="../dibbling/dibbling-tv.jsp?parentCategoryCode="+parentCategoryCode+"&categoryName="+categoryName+"&curindex="+curindex;
		};
	
	
		area4 = AreaCreator(1,5,new Array(3,0,-1,7),"area4_list_","className:item item_focus","className:item");
		//area4.slitherParam=new Array("area4_focus",0,0,117,0,10,40,0);
		area4.stablemoveindex = new Array("0-5,1-6,2-7,3-8,4-9",-1,-1,-1);
		for(var i=0;i<area4.doms.length;i++){
			area4.doms[i].contentdom = $("area4_list_"+i);
		}
		area4.areaOkEvent = function(){
				var parentCategoryCode=categoryListData2.categoryList[area4.curindex].parentCategoryCode;
			    var categoryName=categoryListData1.categoryList[area4.curindex].name;
				var curindex=area4.curindex;
			    window.location.href="../dibbling/dibbling-tv.jsp?parentCategoryCode="+parentCategoryCode+"&categoryName="+categoryName+"&curindex="+curindex;;
		};

		area5 = AreaCreator(1,2,new Array(-1,1,6,-1),"area5_list_","className:item item_focus","className:item");
		area5.setstaystyle("",2);
		area5.setdarknessfocus(0);
		area5.changefocusedEvent = function(){
			if(area5.curindex==0){
				newVodBind();
			}else{
				topVodBind();
			}
		}
		
		area6 = AreaCreator(7,2,new Array(5,1,7,-1),"area6_list_","className:item item_focus","className:item");
		//area6.slitherParam=new Array("area6_focus",10,0,150,49,10,50,20);
		for(var i=0;i<area6.doms.length;i++){
			area6.doms[i].contentdom = $("area6_list_"+i);
		}
		
		area6.areaOkEvent = function()
		{
			var returnUrl=window.location.href;
		    var contentCode=topVodList.vodDataList[area6.curindex].contentCode;
	     	var programCode=topVodList.vodDataList[area6.curindex].programCode;
		    var categoryCode=topVodList.vodDataList[area6.curindex].categoryCode;
            var programType=topVodList.vodDataList[area6.curindex].programType;
			
			if(programType== 1){
				window.location.href = "../dibbling/detail-single.jsp?programCode="+programCode+"&contentCode="+contentCode+"&categoryCode="+categoryCode;
			}else{
				window.location.href = "../dibbling/detail-much.jsp?programCode="+programCode+"&contentCode="+contentCode+"&categoryCode="+categoryCode;
			}
		}
		
		
		
		
		
		area7 = AreaCreator(1,1,new Array(6,3,-1,-1),"area7_list_","className:item item_focus","className:item");
		for(var i=0;i<area7.doms.length;i++){
			area7.doms[i].contentdom = $("area7_txt_"+i);
		}
		area7.areaOkEvent = function(){
			
			var returnUrl=window.location.href;
		    var contentCode=recVodList.vodDataList[area7.curindex].contentCode;
	     	var programCode=recVodList.vodDataList[area7.curindex].programCode;
		    var categoryCode=recVodList.vodDataList[area7.curindex].categoryCode;
            var programType=recVodList.vodDataList[area7.curindex].programType;
			
			if(programType== 1){
				window.location.href = "../dibbling/detail-single.jsp?programCode="+programCode+"&contentCode="+contentCode+"&categoryCode="+categoryCode;
			}else{
				window.location.href = "../dibbling/detail-much.jsp?programCode="+programCode+"&contentCode="+contentCode+"&categoryCode="+categoryCode;
			}
		}
		area8 = AreaCreator(9,1,new Array(-1,-1,-1,0),"area8_list_","className:item item_focus","className:item");
		area8.areaIningEvent = function(){
			$("menuTitle").style.visibility = "visible";
			$("menuText").style.visibility = "visible";
		}
		area8.goBackEvent = function(){
			clearTimeout(t);
			$("menuTitle").style.visibility = "hidden";
			$("menuText").style.visibility = "hidden";
			pageobj.changefocus(0,area0.curindex);
			return true;
		}
		area8.changefocusedEvent = function(){
			clearTimeout(t);
			t = setTimeout("hideDiv()",5000);
		}
		area8.doms[0].domOkEvent = function(){
			window.location.href = window.location.href;	
		}
		area8.doms[1].domOkEvent = function(){
			window.location.href = "../channel/channel.jsp";	
		}
		area8.doms[2].domOkEvent = function(){
			window.location.href = "../dibbling/dibbling.jsp";	
		}
		area8.doms[3].domOkEvent = function(){
			window.location.href = "../space/special-topic.jsp";
		}
		area8.doms[4].domOkEvent = function()
	    {
		   window.location.href = "../../../../vod_JPTypeList.jsp?TYPE_ID="+"<%=JP_TYPE_ID%>";
	    }
	    area8.doms[5].domOkEvent = function()
	    {
		   window.location.href = "../../../../pkit_local/indexpkit.jsp";
	    }
		area8.doms[6].domOkEvent = function(){
			window.location.href = "../space/space.jsp?";	
		}
		//帮助直接跳入空间的操作指南
		area8.doms[8].domOkEvent = function(){
			window.location.href = "../space/space.jsp?index=3";	
		}
		
		area8.areaOutedEvent = function(){
			clearTimeout(t);
			$("menuTitle").style.visibility = "hidden";
			$("menuText").style.visibility = "hidden";
			//pageobj.changefocus(0,area0.curindex);
		}
		if(areaid==8)
		{
			showDiv();
		}
		pageobj = new PageObj(areaid, indexid, new Array(area0,area1,area2,area3,area4,area5,area6,area7,area8));
		pageobj.pageOkEvent=function(){
			//OperatorFocus.saveDarfocus("indexfocus",pageobj);//首页焦点保存
			OperatorFocus.saveFocstr(pageobj);
		};
		

		if($("menuTitle").style.visibility=="visible"&&$("menuTitle").style.visibility=="visible")
		{
			t = setTimeout("hideDiv()",5000);
		}
		

		initTime();
		pageInit();
		indexPlay();
		pageobj.changefocus(areaid,indexid);
		//$("demomarquee").innerHTML=areaid+":"+indexid;
		
	}
	
	function pageInit(){
		 leftVodBind();
		 centerVodBind();
		 newVodBind();
		 topVodBind();
		 recVodBind();
		 categoryBind1();
		 categoryBind2();
	}
	
	//左侧影片数据绑定
	function leftVodBind(){
		var leftListLength = leftVodList.vodDataList.length;
		for(i=0;i<leftListLength;i++){
			area0.doms[i].setcontent("",leftVodList.vodDataList[i].name,14,true,false);
			//$("area0_img_"+i).src = leftVodList.vodDataList[i].pictureList.poster;
		}
	}
	
	//中间影片数据绑定
	function centerVodBind(){
		var centerListLength = centerVodList.vodDataList.length;
		for(i=0;i<centerListLength;i++){
			area2.doms[i].setcontent("",centerVodList.vodDataList[i].name,14,true,false);
			//$("area2_img_"+i).src = centerVodList.vodDataList[i].pictureList.poster;
		}
	}
	
	//最新上线影片数据绑定
	function newVodBind(){
		var newListLength = newVodList.vodDataList.length;
		for(i=0;i<newListLength;i++){
			$("area6_list_"+i).style.display="block";
			area6.doms[i].setcontent("",newVodList.vodDataList[i].name,8,true,false);
		}
		if(newListLength<14)
	    {
		  var domsLength=area6.doms.length;
		  for(var i=newListLength;i<domsLength;i++)
		  {
			  $("area6_list_"+i).style.display="none";			
		  }			
	    }
	}
	
	//top榜影片数据绑定
	function topVodBind(){
		var topListLength = topVodList.vodDataList.length;
		for(i=0;i<topListLength;i++){
			$("area6_list_"+i).style.display="display";
			area6.doms[i].setcontent("",topVodList.vodDataList[i].name,8,true,false);
		}
		if(topListLength<14)
	    {
		  var domsLength=area6.doms.length;
		  for(var i=topListLength;i<domsLength;i++)
		  {
			  $("area6_list_"+i).style.display="none";			
		  }			
	    }
		
	}
	
	//推荐影片数据绑定
	function recVodBind(){
		var recListLength = recVodList.vodDataList.length;
		for(i=0;i<recListLength;i++){
			area7.doms[i].setcontent("",recVodList.vodDataList[i].name,18,true,false);
			$("area7_img_"+i).src = recVodList.vodDataList[i].pictureList.poster;
		}
	}
	
	//area3栏目据绑定
	function categoryBind1(){
		var length1 = categoryListData1.categoryList.length;
		for(i=0;i<length1;i++){
			area3.doms[i].setcontent("",categoryListData1.categoryList[i].name,8,true,false);
		}
	}
	
	//area4栏目据绑定
	function categoryBind2(){
		var length2 = categoryListData2.categoryList.length;
		for(i=0;i<length2;i++){
			area4.doms[i].setcontent("",categoryListData2.categoryList[i].name,8,true,false);
		}
	}
	
	function initTime(){
		$("timeDate").innerHTML = time1;
		$("time").innerHTML = time2;	
	}
	
	function indexPlay(){
		//playUrl = "rtsp://192.168.2.7/HD01.ts";
		//playUrl = "rtsp://220.181.168.185:5541/mp4/2013henanfenghui/zhibo/cctv1.ts";
		userchannelid=channelIndex;
		play(325,84,603,340);
	}
	
	function hideDiv(){
		$("menuTitle").style.visibility = "hidden";
		$("menuText").style.visibility = "hidden";
		pageobj.changefocus(0,area0.curindex);
	}
	
	
	function showDiv()
	{
		$("menuTitle").style.visibility = "visible";
		$("menuText").style.visibility = "visible";
		
	}
	function destoryMP()
	{
		var instanceId = mp.getNativePlayerInstanceID();
	//	mp.stop();
	    mp.leaveChannel()
		mp.releaseMediaPlayer(instanceId);
	}
	
	function getParameter(parameter){
		var url=window.location.search;
		var intUrl = url.indexOf("?"); 
		var urlRight = url.substr(intUrl + 1); 
		var arrTmp = urlRight.split("&"); 
		for(var i = 0; i < arrTmp.length; i++) {
		var arrTemp = arrTmp[i].split("="); 
			if(arrTemp[0] == parameter){
				return arrTemp[1]; 
			}
		}
		return 0; 
	}
</script>
</head>

<body bgcolor="transparent" onUnload="destoryMP()">

<!--pagebg-->
<div class="pagebg">
	<div class="pic"><img src="../../images/bg-index01.jpg" width="1280" height="84" /></div>
	<div class="pic" style="top:84px;"><img src="../../images/bg-index02.jpg" width="325" height="636" /></div>
	<div class="pic" style="left:928px;top:84px;"><img src="../../images/bg-index03.jpg" width="352" height="340" /></div>
	<div class="pic" style="left:325px;top:424px;"><img src="../../images/bg-index04.jpg" width="955" height="296" /></div>
</div>
<!--pagebg the end-->



<div class="wrapper">

	<!--head-->
	<div class="logo"><img src="../../images/logo.png" /></div>
	<div class="date">
			<div class="txt" id="timeDate">05/27</div>
			<div class="txt txt-time" style="top:22px;" id="time">11:15</div>
    </div>
	<!--head the end-->	
	
	<!--menu-->
	<div class="btn-menu">
		<div class="item"><img src="../../images/btn-menu.png" /></div>
	</div>
	<!--menu the end-->	
	
	<!--menu-->
	<div class="title" style="visibility:hidden" id="menuTitle"><img src="../../images/menu/title-hd.png" /></div>
	<div class="menu-a" style="visibility:hidden"  id="menuText">
		<!--焦点 
				class="item item_focus" icon**.png 焦点为原图名上加：_focus
			选中	
				class="item item_select"  
		-->
		<div class="item" id="area8_list_0">
			<div class="icon"><img src="../../images/menu/icon01.png" /></div>
			<div class="txt">首&nbsp;页</div>
		</div>
		<div class="item" style="top:113px;" id="area8_list_1">
			<div class="icon"><img src="../../images/menu/icon02.png" /></div>
			<div class="txt">频&nbsp;道</div>
		</div>
		<div class="item" style="top:169px;" id="area8_list_2">
			<div class="icon"><img src="../../images/menu/icon03.png" /></div>
			<div class="txt">点&nbsp;播</div>
		</div>
		<div class="item" style="top:225px;" id="area8_list_3">
			<div class="icon"><img src="../../images/menu/icon04.png" /></div>
			<div class="txt">专&nbsp;题</div>
		</div>
		<div class="item" style="top:281px;" id="area8_list_4">
			<div class="icon"><img src="../../images/menu/icon05.png" /></div>
			<div class="txt">四&nbsp;川</div>
		</div>
		<div class="item" style="top:337px;" id="area8_list_5">
			<div class="icon"><img src="../../images/menu/icon06.png" /></div>
			<div class="txt">成&nbsp;都</div>
		</div>
		<div class="item" style="top:393px;" id="area8_list_6">
			<div class="icon"><img src="../../images/menu/icon07.png" /></div>
			<div class="txt">空&nbsp;间</div>
		</div>
		<div class="item" style="top:449px;" id="area8_list_7">
			<div class="icon"><img src="../../images/menu/icon08.png" /></div>
			<div class="txt">搜&nbsp;索</div> 
		</div>
		<div class="item" style="top:505px;" id="area8_list_8">
			<div class="icon"><img src="../../images/menu/icon09.png" /></div>
			<div class="txt">帮&nbsp;帮</div>   
		</div>
	</div>
	<!--menu the end-->		
	
	
	
	<!--list-pic & Left-->
	<div class="list-pic-a">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area0_list_0">
			<div class="pic"><img id="area0_img_0" src="${leftVodList.vodDataList[0].pictureList.poster}" /></div>
			<div class="txt" id="area0_txt_0"></div>
		</div>
		<div class="item" style="top:138px;" id="area0_list_1">
			<div class="pic"><img id="area0_img_1" src="${leftVodList.vodDataList[1].pictureList.poster}" /></div>
			<div class="txt" id="area0_txt_1"></div>
		</div>
		<div class="item" style="top:276px;" id="area0_list_2">
			<div class="pic"><img id="area0_img_2" src="${leftVodList.vodDataList[2].pictureList.poster}" /></div>
			<div class="txt" id="area0_txt_2"></div>
		</div>
		<div class="item" style="top:414px;" id="area0_list_3">
			<div class="pic"><img id="area0_img_3" src="${leftVodList.vodDataList[3].pictureList.poster}" /></div>
			<div class="txt" id="area0_txt_3"></div>
		</div>
	</div>
	<!--list-pic & Left the end-->		
	
	
	
	<!--video-->
	<div class="video">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area1_list_0">
			<div class="pic"></div>
			<div class="btn"></div>
		</div>
	</div>
	<!--video the end-->		
	
	
	
	<!--list-pic & mid-->
	<div class="list-pic-b">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area2_list_0">
			<div class="pic"><img id="area2_img_0" src="${centerVodList.vodDataList[0].pictureList.poster}" /></div>
			<div class="txt" id="area2_txt_0"></div>
		</div>
		<div class="item" style="left:204px;" id="area2_list_1">
			<div class="pic"><img id="area2_img_1" src="${centerVodList.vodDataList[1].pictureList.poster}" /></div>
			<div class="txt" id="area2_txt_1"></div>
		</div>
		<div class="item" style="left:408px;" id="area2_list_2">
			<div class="pic"><img id="area2_img_2" src="${centerVodList.vodDataList[2].pictureList.poster}" /></div>
			<div class="txt" id="area2_txt_2"></div>
		</div>
	</div>
	<!--list-pic & mid the end-->		
	
	
	
	<!--list Font&LINK mid-->
	<div class="list-a">
    	<!--<div class="item item_focus" id="area3_focus" style="visibility:hidden"></div>-->  <!--焦点框移动层-->
		<!--焦点 
				class="item item_focus"
		-->        
		<div class="item" id="area3_list_0"></div>
		<div class="item" style="left:120px;" id="area3_list_1"></div>
		<div class="item" style="left:240px;" id="area3_list_2"></div>
		<div class="item" style="left:360px;" id="area3_list_3"></div>
		<div class="item" style="left:480px;" id="area3_list_4"></div>
		
		<div class="item" style="top:30px;" id="area3_list_5"></div>
		<div class="item" style="left:120px;top:30px;" id="area3_list_6"></div>
		<div class="item" style="left:240px;top:30px;" id="area3_list_7"></div>
		<div class="item" style="left:360px;top:30px;" id="area3_list_8"></div>
		<div class="item" style="left:480px;top:30px;" id="area3_list_9"></div>
	</div>
	<!--list Font&LINK mid the end-->
	
	
	
	<!--list Font&LINK mid-->
	<div class="list-b">
    	<!--<div class="item item_focus" id="area4_focus" style="visibility:hidden"></div>-->  <!--焦点框移动层-->
		<!--焦点 
				class="item item_focus"
		-->        
		<!--<div class="pic" id="area4_list_0"><img src="../../images/icon-ppv.png" width="105" height="58" /></div>-->
		<div class="item" id="area4_list_0"></div>
		<div class="item" style="left:117px;" id="area4_list_1"></div>
		<div class="item" style="left:234px;" id="area4_list_2"></div>
		<div class="item" style="left:351px;" id="area4_list_3"></div>
		<div class="item" style="left:468px;" id="area4_list_4"></div>
	</div>
	<!--list Font&LINK mid the end-->
	
	
	
	<!--list 最新上线&TOP榜-->
	<div class="sub-a">
		<!--
			class="item" 为是最新上线 
			class="item item_focus" 为TOP榜
		-->
		<div class="item" id="area5_list_0">
			<div class="txt txt-a"><!--最新上线--></div>
		</div>
		<div class="item" id="area5_list_1">
			<div class="txt txt-b"><!--TOP榜--></div>
		</div>
	</div>
	
	<div class="list-c">		
    	<!--<div class="item item_focus" style="left:10px;top:245px;visibility:hidden;" id="area6_focus"></div>-->  <!--焦点框移动层-->	
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area6_list_0"></div>
		<div class="item" style="top:48px;" id="area6_list_2"></div>
		<div class="item" style="top:98px;" id="area6_list_4"></div>
		<div class="item" style="top:147px;" id="area6_list_6"></div>
		<div class="item" style="top:196px;" id="area6_list_8"></div>
		<div class="item" style="top:245px;" id="area6_list_10"></div>
		<div class="item" style="top:293px;" id="area6_list_12"></div>
		
		<div class="item" style="left:160px;" id="area6_list_1"></div>
		<div class="item" style="top:48px;left:160px;" id="area6_list_3"></div>
		<div class="item" style="top:98px;left:160px;" id="area6_list_5"></div>
		<div class="item" style="top:147px;left:160px;" id="area6_list_7"></div>
		<div class="item" style="top:196px;left:160px;" id="area6_list_9"></div>
		<div class="item" style="top:245px;left:160px;" id="area6_list_11"></div>
		<div class="item" style="top:293px;left:160px;" id="area6_list_13"></div>
	</div>
	<!--list the end-->
	
	
	
	<!--重磅推荐-->
	<div class="list-pic-c">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area7_list_0">
			<div class="pic"><img id="area7_img_0" src="${recVodList.vodDataList[0].pictureList.poster}" /></div>
			<div class="txt" id="area7_txt_0"></div>
		</div>
	</div>
	<!--重磅推荐 the end-->		
	
	
	
	<!--跑马灯-->
	<div class="bottom-marquee"><marquee id="demomarquee">热播大剧:  《赵氏孤儿案》《天真遇到现实》《复仇者联盟》《冰河世纪3：恐龙的黎明》《被解救的姜戈》持续热播，更多好剧敬请关注</marquee></div>
	<!--跑马灯 the end-->
	
	
</div>
	
</body>
</html>
