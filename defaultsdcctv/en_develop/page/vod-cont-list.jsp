<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<%@ include file="util/save_focus.jsp"%>
<%@ include file="datajsp/vod-cont-list_data.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<meta name="page-view-size" content="640*530"/>
<title>点播三级内容列表 | CCTV-IP电视</title>
<link rel="stylesheet" type="text/css" href="../css/style.css" />
<style type="text/css">
body {
    background: #0d4764 url("../images/body-page-vod-list.jpg") no-repeat;
}
.mod-vodlistCont {}
.mod-vodlistCont .picWrap {
	background-color: #041b29;
	height: 100px;
	width: 314px;
	position: absolute;
	left: 276px;
	top: 95px;
}
.mod-vodlistCont .picWrap .pic,
.mod-vodlistCont .picWrap .pic img {
	height: 94px;
	width: 308px;
}
.mod-vodlistCont .picWrap .pic {
	left: 3px;
	top: 3px;
}
.mod-vodlistCont .bd {}
.mod-vodlistCont .bd .item .link,
.mod-vodlistCont .bd .item .link img {
	height: 34px;
	width: 330px;
}
.mod-vodlistCont .bd .item {
	left: 269px;
}
.mod-vodlistCont .bd .item .txt {
	height: 24px;
	width: 314px;
	left: 8px;
	top: 8px;
}
</style>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
	//--common var S
	var areaid=0;
	var indexid=0;
	var area0,area1;
	//--common var E
	
    window.onload = function(){
		//--area0 S
		area0=AreaCreator(8,1,new Array(-1,-1,-1,1),new Array("area0_list_","area0_list1_"),new Array("className:link onboder","className:item item_select"),new Array("className:link offboder","className:item"));
		area0.setstaystyle(new Array("className:item item_select","className:link offboder"),3);
		for(var i=0;i<area0.doms.length;i++){area0.doms[i].contentdom=$('area0_content_'+i);}
		area0.setstaystyle(new Array("className:link offboder","className:item item_select"),3);
		area0.asyngetdata = function(dataurl) {
			bindCateData(getItmsByPage(jCatelist,area0.curpage,area0.doms.length));
		}
		area0.setfocuscircle(0);
		area0.setcrossturnpage();		
		area0.changefocusingEvent = function(){
			if(area0.dataarea==undefined){
				area0.dataarea = area1;
			}
			area1.curpage = 1;
		}
		//--area0 E
		
		//--area1 S
		area1 = AreaCreator(8, 1, new Array(-1, 0, -1, -1), "area1_list_", "className:link onboder", "className:link offboder");
		for(var i=0;i<area1.doms.length;i++){area1.doms[i].contentdom=$('area1_content_'+i);}
		area1.setfocuscircle(0);
		area1.setcrossturnpage();
		area1.areaOkEvent=function(){saveFocstr(pageobj);}
		area1.asyngetdata = function(dataurl){
			if(!!dataurl){
				getAJAXData("datajsp/vod-cont-list_data_iframe.jsp?typeid="+dataurl,bindData);
			}else{
				bindVodData(getItmsByPage(jVodlist,area1.curpage,area1.doms.length));
			}
		}
		//--area1 E
		
		//--设置焦点和状态
		if(focusObj!=undefined&&focusObj!="null"){			
			areaid = parseInt(focusObj[0].areaid);
			indexid = parseInt(focusObj[0].curindex);
			area0.curpage = parseInt(focusObj[1].curpage);
			area0.curindex = parseInt(focusObj[1].curindex);
			area1.curpage = parseInt(focusObj[0].curpage);
			area1.curindex = parseInt(focusObj[0].curindex);
		}else{
			area0.curpage = cur_area0_page;
			indexid = cur_area0_index;
		}
		
		//--pageobj S
		pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area0, area1));
		pageobj.backurl=returnurl;
		//--pageobj E
		
		//--common S
		setDarkFocus();
		refreshServerTime();//时间填充
		//--common E
		
		//--binddatas S	
		//填充1级栏目
		bindCateData(getItmsByPage(jCatelist,area0.curpage,area0.doms.length));
		bindVodData(getItmsByPage(jVodlist,area1.curpage,area1.doms.length));
		//--binddatas E
	}
	
	
	//--common functions S	
function getItmsByPage(cptitms,icurpage,ipagesize){
	var reclist=new Array();
	var start = (icurpage-1)*ipagesize;
	for(var i=0;i<ipagesize&&(i+(icurpage-1)*ipagesize)<cptitms.length;i++){
	     reclist[i]=cptitms[start+i];
	}
	return reclist;
}

function bindData(txtJson){
	jVodlist = eval('('+txtJson+')');
	vodpagecount = Math.floor(((jVodlist.length-1)/(area1.doms.length)))+1;
	bindVodData(getItmsByPage(jVodlist,area1.curpage,area1.doms.length));
}

	//--common functions E
</script>
</head>
<body>
<div class="wrapper">

    <!-- S 面包屑 -->
    <div class="mod-bread" id="catename">
    </div>
    <!-- E 面包屑 -->

    <!-- S 时间 -->
    <div class="mod-dataTime" id="currDate"></div>
    <!-- E 时间 -->

    <!-- S 左侧导航 -->
    <div class="leftNav-b">

        <div class="item" style="top:31px;" id="area0_list1_0">
            <div class="link" id="area0_list_0"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_content_0"></div>
        </div>
        <div class="item" style="top:75px;" id="area0_list1_1">
            <div class="link" id="area0_list_1"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_content_1"></div>
        </div>
        <div class="item" style="top:119px;" id="area0_list1_2">
            <div class="link" id="area0_list_2"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_content_2"></div>
        </div>
        <div class="item" style="top:163px;" id="area0_list1_3">
            <div class="link" id="area0_list_3"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_content_3"></div>
        </div>
        <div class="item" style="top:207px;" id="area0_list1_4">
            <div class="link" id="area0_list_4"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_content_4"></div>
        </div>
        <div class="item" style="top:251px;" id="area0_list1_5">
            <div class="link" id="area0_list_5"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_content_5"></div>
        </div>
        <div class="item" style="top:295px;" id="area0_list1_6">
            <div class="link" id="area0_list_6"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_content_6"></div>
        </div>
        <div class="item" style="top:339px;" id="area0_list1_7">
            <div class="link" id="area0_list_7"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_content_7"></div>
        </div>

        <!-- S 导航分页 -->
        <div class="mod-paging-b" style="left: 56px; top:442px;" id="catalogspage"></div>
        <!-- E 导航分页 -->

    </div>
    <!-- E 左侧导航 -->

    <!--内容部分-->
    <div class="mod-vodlistCont">

        <!-- S 海报 -->
        <!--<div class="picWrap">
            <div class="pic"><img src="../../images/demopic/pic-308x94-1.jpg" /></div>
        </div>-->
        <!-- E 海报 -->

        <!-- S 内容描述 -->
        <div class="bd">
            <div class="item" style="top:82px;">
                <div class="link"  id="area1_list_0"><img src="../images/t.gif" /></div>
                <div class="txt" id="area1_content_0"></div>
            </div>
            <div class="item" style="top:124px;">
                <div class="link" id="area1_list_1"><img src="../images/t.gif" /></div>
                <div class="txt" id="area1_content_1"></div>
            </div>
            <div class="item" style="top:166px;">
                <div class="link" id="area1_list_2"><img src="../images/t.gif" /></div>
                <div class="txt" id="area1_content_2"></div>
            </div>
            <div class="item" style="top:208px;">
                <div class="link" id="area1_list_3"><img src="../images/t.gif" /></div>
                <div class="txt" id="area1_content_3"></div>
            </div>
            <div class="item" style="top:250px;">
                <div class="link" id="area1_list_4"><img src="../images/t.gif" /></div>
                <div class="txt" id="area1_content_4"></div>
            </div>
             <div class="item" style="top:292px;">
                <div class="link" id="area1_list_5"><img src="../images/t.gif" /></div>
                <div class="txt" id="area1_content_5"></div>
            </div>
             <div class="item" style="top:334px;">
                <div class="link" id="area1_list_6"><img src="../images/t.gif" /></div>
                <div class="txt" id="area1_content_6"></div>
            </div>
             <div class="item" style="top:376px;">
                <div class="link" id="area1_list_7"><img src="../images/t.gif" /></div>
                <div class="txt" id="area1_content_7"></div>
            </div>

        </div>
        <!-- E 内容描述 -->

        <!-- S 导航分页 -->
        <div class="mod-paging-b" style="left: 255px; top:430px; width: 356px; text-align: center;"  id="vodspage"></div>
        <!-- E 导航分页 -->

    </div>

</div>
<%@ include file="servertimehelp.jsp" %>	
</body>
</html>