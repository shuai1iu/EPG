<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<%@ include file="util/save_focus.jsp"%>
	<%@ include file="datajsp/topiclist_data.jsp"%>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
    <meta name="page-view-size" content="640*530"/>
    <title>专题集合页面 - 央视深圳标清 改版</title>
    <style type="text/css">
        body {
            background: #263150 url("../images/bg02.jpg") no-repeat;
        }
		.mod-bread {
			color: #f1f1f1;
			font-size: 28px;
			font-weight:bold;
			position: absolute;
			left: 20px;
			top: 6px;
		}
    </style>
	<link type="text/css" rel="stylesheet" href="../css/style2.css" />
	<script type="text/javascript" src="../js/pagecontrol.js"></script>
	<script type="text/javascript">
	if (typeof(iPanel) != 'undefined'){iPanel.focusWidth = "2";iPanel.defaultFocusColor = "#FCFF05";}
	var area0;
	var areaid=0;
	var indexid=0;
	window.onload = function(){
		area0=AreaCreator(2,3,new Array(-1,-1,-1,-1),"area0_list_","afocus","ablur");
		for(i=0;i<area0.doms.length;i++) {
			area0.doms[i].imgdom=$("area0_img_"+i);
		}
		area0.setcrossturnpage();
		area0.curpage = focusObj!=undefined&&focusObj!="null"?focusObj[0].curpage:1;
		area0.pagecount = pagecount;
		bindTopiclistData(getItmsByPage(jTopiclist,area0.curpage,area0.doms.length))
		area0.asyngetdata=function(){
			var data = getItmsByPage(jTopiclist,area0.curpage,area0.doms.length);
			bindTopiclistData(data);	
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

    <!-- S 面包屑 -->
    <div class="mod-bread">专题</div>
    <!-- E 面包屑 -->
	

    <!-- S 专题集合 -->
    <div class="thematic">
        <div class="item" style="top:13px;">
            <div class="link"><a href="#" id="area0_list_0"><img src="../images/t.gif" /></a></div>
            <div class="pic"><img id="area0_img_0" width="187" height="151" /></div>
        </div>
        <div class="item" style="left:213px;top:13px;">
            <div class="link"><a href="#" id="area0_list_1"><img src="../images/t.gif" /></a></div>
            <div class="pic"><img id="area0_img_1" width="187" height="151" /></div>
        </div>
        <div class="item" style="left:426px;top:13px;">
            <div class="link"><a href="#" id="area0_list_2"><img src="../images/t.gif" /></a></div>
            <div class="pic"><img id="area0_img_2" width="187" height="151"/></div>
        </div>
		<div class="item" style="top:200px;">
            <div class="link"><a href="#" id="area0_list_3"><img src="../images/t.gif" /></a></div>
            <div class="pic"><img id="area0_img_3" width="187" height="151" /></div>
        </div>
        <div class="item" style="left:213px;top:200px;">
            <div class="link"><a href="#" id="area0_list_4"><img src="../images/t.gif" /></a></div>
            <div class="pic"><img id="area0_img_4" width="187" height="151" /></div>
        </div>
        <div class="item" style="left:426px;top:200px;">
            <div class="link"><a href="#" id="area0_list_5"><img src="../images/t.gif" /></a></div>
            <div class="pic"><img id="area0_img_5" width="187" height="151"/></div>
        </div>
    </div>
    <!-- E 专题集合 -->
	<div class="pages">
		<div class="txt" id="pageinfo" style="top:25px;"></div>
	</div>
</div>
</body>
</html>
