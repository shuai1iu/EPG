<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file="datajsp/group-match-data.jsp"%>
<%@ include file="util/save_focus.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视欧洲杯 标清EPG 2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<style type="text/css">
<!--
	body{ background:url(../images/bg3.jpg) no-repeat;}
	
-->
</style>
<script src="../js/pagecontrol.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
var returnurl = '<%=request.getParameter("returnurl")%>';
var area0;
var area1;
var area2;
var areaid;
var indexid;

	window.onload = function() {
	    refreshServerTime();
		initPage();
		loadPicture();
		
	}
	
	function loadPicture()
	{
		
		area2.datanum = typeList.length;
		 for (var i = 0; i < area2.doms.length; i++)
		 {
			 if (i < typeList.length)
			 {
				 
				 
	
				  if(typeList[i].picPath == "" || typeList[i].picPath == null)
				  	area2.doms[i].updateimg ("../images/temp/pic-250X154.jpg");
				  else
				  {
					 area2.doms[i].updateimg(typeList[i].picPath);
				  	//area2.doms[i].src = typeList[i].picPath;
					area2.doms[i].dataurlorparam = typeList[i].typeId;
					//alert(area2.doms[i].src);
				  }
				  
			 }
			 else
			 {
				//area2.doms[i].src = "../images/temp/pic-250X154.jpg";
			 }
		 }
	}
	
	function initPage() {
		
		if(focusObj!=undefined&&focusObj!="null")
		{
				areaid = parseInt(focusObj[0].areaid);
				indexid = parseInt(focusObj[0].curindex);
		}
	  area0 = AreaCreator(1,6,new Array(-1,-1,1,-1),"menu_a","afocus","ablur");
	
	  area0.setfocuscircle(1);
	  area0.doms[0].mylink="index.jsp";
	  area0.doms[2].mylink="video.jsp";
	  area0.doms[3].mylink="star.jsp";
	  area0.doms[4].mylink="top-scorer.jsp";
	  area0.doms[5].mylink="search.jsp";
	  area0.setstaystyle("className:",2);
	  //area0.setstaystyle(new Array("className:item wid3 item-select", "className:link offboder"), 2);
	  area1 =  AreaCreator(1,2,new Array(0, -1, 2, -1),"match_a","afocus","ablur");
	  area1.setstaystyle("className:", 2);
	  area1.stablemoveindex=new Array("0-0>1,1-0>1",-1,2,-1);
	  
	  
	  area1.doms[0].mylink="";
	  area1.doms[1].mylink="knockout.jsp?matchType=knockout&returnurl="+escape("group-match.jsp?matchType=group");
	  area1.setfocuscircle(1);
	  area1.areaOkEvent = function()
	  {
	  }
	  area2 =  AreaCreator(2, 2, new Array(1, -1, -1, -1),"postpic_a","afocus","ablur");
	  area2.areaOkEvent = function()
	  {
		 saveFocstr(pageobj);
		 var url =  "dibbling-group-two.jsp?catacode="+area2.doms[area2.curindex].dataurlorparam + "&typenum=1" +"&returnurl="+escape("group-match.jsp?matchType=group");
		 //alert(url);
	  	location.href = url;
	  }
	 
	  area2.setfocuscircle(1);
	  for(var i = 0 ; i < area2.doms.length;i ++)
	  {
		  
		   area2.doms[i].imgdom = $("pic"+i+i+"");
	  }
	  pageobj = new PageObj(areaid!=null?parseInt(areaid):2,indexid!=null?parseInt(indexid):0, new Array(area0, area1, area2));
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
	<div class="date" id="currDate"></div>
	
	<!--menu-->
	<div class="menu"> <!--当前选中为 class="item wid* item-select"；2字宽为wid1;3字宽为wid2,4字宽为wid3--> 
		<div class="item wid1" id="menu0">
			<div class="link" ><a href="#" id="menu_a0"><img src="../images/t.gif" /></a></div>
		</div>               
		<div class="item wid3" style="left:63px;" id="menu1" >
			<div class="link" ><a href="#" id="menu_a1"><img src="../images/menu02.jpg" /></a></div>
		</div>
		<div class="item wid3" style="left:172px;" id="menu2">
			<div class="link"  ><a href="#" id="menu_a2"><img src="../images/t.gif" /></a></div>
		</div>
		<div class="item wid3" style="left:281px;" id="menu3">
			<div class="link" ><a href="#" id="menu_a3"><img src="../images/t.gif" /></a></div>
		</div>
		<div class="item wid2" style="left:390px;" id="menu4">
			<div class="link" ><a href="#" id="menu_a4"><img src="../images/t.gif" /></a></div>
		</div>
		<div class="item wid1" style="left:475px;" id="menu5">
			<div class="link" ><a href="#" id="menu_a5"><img src="../images/t.gif" /></a></div>
		</div>
	</div>
<!--the end-->


	
	
<!--小组赛-->
<div class="dibbling-sub"> <!--默认为 class="item" , 当前选中为 class="item item-select"-->
	<div class="item item-select" id="match0">
		<div class="link" ><a href="#" id="match_a0"><img src="../images/t.gif" /></a></div>
		<div class="txt">小组赛</div>
	</div>
	<div class="item" style="left:190px;" id="match1">
		<div class="link" ><a href="#" id="match_a1"><img src="../images/t.gif" /></a></div>
		<div class="txt">淘汰赛</div>
	</div>
</div>
<!--the end-->	




<!--推荐区-->
<div class="dibbling-recommend">  
	<div class="item" id="postpic0">
		<div class="link" ><a href="#" id="postpic_a0"><img src="../images/t.gif" /></a></div>
     	<div class="pic"><img  id="pic00"  /></div>
	</div>
	<div class="item" style="left:281px;" id="postpic1">
		<div class="link" ><a href="#" id="postpic_a1"><img src="../images/t.gif" /></a></div>
     	<div class="pic" ><img id="pic11"/></div>
	</div>
	<div class="item" style="top:189px;" id="postpic2">
		<div class="link" ><a href="#" id="postpic_a2"><img src="../images/t.gif" /></a></div>
     	<div class="pic" ><img id="pic22" /></div>
	</div>
	<div class="item" style="left:281px;top:189px;" id="postpic3">
		<div class="link" ><a href="#" id="postpic_a3"><img src="../images/t.gif" /></a></div>
     	<div class="pic" ><img  id="pic33"/></div>
	</div>
</div>
<!--the end-->	
<%@ include file="servertimehelp.jsp"%>
</body>
</html>