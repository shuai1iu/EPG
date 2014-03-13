<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file="datajsp/top-score-data.jsp"%>
<%@ include file="util/save_focus.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视欧洲杯高清3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<script src="../js/pagecontrol.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
var areaid;
var indexid;
var returnurl = '<%=request.getParameter("returnurl")%>';
var area0,area1,area2;
var areaid;
var indexid;
window.onload=function(){
	 refreshServerTime();
	 initPage();
	 loadData();
}
//加载数据
function loadData()
{
		 area1.datanum = groupList.length;
		 for (var i = 0; i < area1.doms.length; i++)
		 {
			 if (i < groupList.length)
			 {
				  if(groupList[i].picPath == "" || groupList[i].picPath == null)
				  {
				  	area1.doms[i].updateimg("../images/standings-c.png");
					
				  }
				  else
				  {
					 area1.doms[i].updateimg(groupList[i].picPath);
					 area1.doms[i].dataurlorparam = groupList[i].typeId;
				  }
			 }
			 else
			 {
				//area2.doms[i].src = "../images/temp/pic-250X154.jpg";
			 }
		 }
		// alert(picList.length);
		 if(picList != null && picList.length != 0)
		 {
			 $("topscorer0_pic0").src = picList[0].picPath;
			 if(picList.length == 2)
			 {
			 	 area2.doms[0].updateimg( picList[1].picPath);
			  	 area2.doms[0].dataurlorparam = picList[1].typeId;
			 }
		 }		 
}
function initPage(){
	 if(focusObj!=undefined&&focusObj!="null")
	 {
		areaid = parseInt(focusObj[0].areaid);
		indexid = parseInt(focusObj[0].curindex);
	 }
	 area0 = AreaCreator(1,6,new Array(-1,-1,1,-1),"menu_a","afocus","ablur");
	 area0.setfocuscircle(1);
     area0.setfocuscircle(1);
     area0.doms[0].mylink="index.jsp";
     area0.doms[1].mylink="dibbling-group-match.jsp";
     area0.doms[2].mylink="video.jsp";
     area0.doms[3].mylink="star.jsp";
     // area0.doms[4].mylink="top-scorer.jsp";
     area0.doms[5].mylink="search.jsp";
     area0.setstaystyle("className:",2);
  
	 area1 =  AreaCreator(1,4,new Array(0, -1, 2, -1),"group_a","afocus","ablur");
	 for(var i = 0 ; i < area1.doms.length;i ++)
	 {
		 area1.doms[i].imgdom = $("group"+i+"_pic" +  i);
		 //area1.doms[i].contentdom = $("group"+i);
	 }
	  
	 area1.areaOkEvent = function()
	 {
		saveFocstr(pageobj);
		var url = "dibbling-group-two.jsp?catacode="+area1.doms[area1.curindex].dataurlorparam +"&returnurl="+escape("top-scorer.jsp") + "&typenum=4";
		
		location.href = url;
	 }
	 area1.setfocuscircle(1);
	 
	 area2 =  AreaCreator(1,1,new Array(1, 1, -1, 1),"goalcollection_a","afocus","ablur");
	 area2.areaOkEvent = function()
	  {
		 saveFocstr(pageobj);
		
		 if( area2.doms[area2.curindex].dataurlorparam != undefined && 
		 area2.doms[area2.curindex].dataurlorparam !="undefined")
	  		location.href = "dibbling-group-two.jsp?catacode="+area2.doms[area2.curindex].dataurlorparam + "&typenum=4";
	  }
	 
	  pageobj = new PageObj(areaid!=null?parseInt(areaid):1,indexid!=null?parseInt(indexid):0, new Array(area0, area1, area2));
	  setDarkFocus();
      if(returnurl != null && returnurl != undefined && returnurl != "" && returnurl != "null")
			pageobj.backurl = returnurl;
	  else
			pageobj.backurl = "index.jsp";
}
</script>
</head>

<body>

<!--head-->
	<div class="date">17:30</div>
	
	<!--menu-->
	<div class="menu"> <!--当前选中为 class="item wid* item-select"；2字宽为wid1;3字宽为wid2,4字宽为wid3--> 
		<div class="item wid1">
			<div class="link"><a href="#" id="menu_a0"><img src="../images/t.gif" /></a></div>
            <div class="txt">首页</div>
		</div>               
		<div class="item wid3" style="left:128px;">
			<div class="link"><a href="#" id="menu_a1"><img src="../images/t.gif" /></a></div>
            <div class="txt">赛事点播</div>
		</div>
		<div class="item wid3" style="left:346px;">
			<div class="link"><a href="#" id="menu_a2"><img src="../images/t.gif" /></a></div>
            <div class="txt">精彩视频</div>
		</div>
		<div class="item wid3" style="left:564px;">
			<div class="link"><a href="#" id="menu_a3"><img src="../images/t.gif" /></a></div>
            <div class="txt">球星殿堂</div>	
		</div>
		<div class="item wid2 item-select" style="left:782px;">
			<div class="link"><a href="#" id="menu_a4"><img src="../images/t.gif" /></a></div>
            <div class="txt">射手榜</div>	
		</div>
		<div class="item wid1" style="left:952px;">
			<div class="link"><a href="#" id="menu_a5"><img src="../images/t.gif" /></a></div>
            <div class="txt">搜索</div>
		</div>
	</div>
<!--the end-->

	
	
<!--各组积分排名-->
<div class="archer-title1"><img src="../images/archer-title1.png" /></div>

<div class="archer-list" id="group0">
	<div class="group">
		<div class="link"><a href="#"  id="group_a0"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img  id="group0_pic0"/></div>
	</div>
	
	<div class="group" style="left:315px;" id="group1">
		<div class="link"><a href="#"  id="group_a1"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img  id="group0_pic1" /></div>
	</div>
	
	<div class="group" style="left:630px;" id="group2">
		<div class="link"><a href="#"  id="group_a2"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img  id="group0_pic2" /></div>
	</div>
	
	<div class="group" style="left:945px;" id="group3">
		<div class="link"><a href="#"  id="group_a3"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img  id="group0_pic3"  /></div>
	</div>
</div>
<!--the end-->	



	
<!--射手榜TOP5-->
<div class="archer-title2"><img src="../images/archer-title2.png" /></div>

<div class="archer-top" id="topscorer0">
	<div class="link"><a href="#" id="topscorer_a0"><img src="../images/t.gif" /></a></div>
	<div class="pic"><img id="topscorer0_pic0"/></div>
</div>
<!--the end-->	




<!--进球集锦-->
<div class="archer-pic"  id="goalcollection0">
	<div class="item"> 
		<div class="link"><a href="#" id="goalcollection_a0"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="goalcollection0_pic0"/></div>
	</div>
</div>
<!--the end-->	

		
</body>
</html>
