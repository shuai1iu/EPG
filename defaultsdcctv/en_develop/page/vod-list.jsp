<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<%@ include file="util/save_focus.jsp"%>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="datajsp/vod-list_data.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
    <meta name="page-view-size" content="640*530"/>
    <title>点播二级内容列表 | CCTV-IP电视</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <style type="text/css">
        body {
            background: #0d4764 url("../images/body-page-vod-list.jpg") no-repeat;
        }
        .mod-vodlistCont {}
        .mod-vodlistCont .picWrap {
            background-color: #041b29;
            height: 210px;
            width: 150px;
            position: absolute;
            left: 280px;
            top: 95px;
        }
        .mod-vodlistCont .picWrap .pic,
        .mod-vodlistCont .picWrap .pic img {
            height: 204px;
            width: 144px;
        }
        .mod-vodlistCont .picWrap .pic {
            left: 3px;
            top: 3px;
        }
        .mod-vodlistCont .picWrap .icon {
            height: 60px;
            width: 60px;
            right: 3px;
            top: 3px;
        }
        .mod-vodlistCont .txtLine {
            font-size: 18px;
            height: 24px;
			line-height:24px;
            position: absolute;
        }
        .mod-vodlistCont .txtLine .th {
            color: #999;
        }
		.mod-pop-box {
            background: url("../images/pop-432x218-2.png") no-repeat;
            height: 218px;
            width: 432px;
            position: absolute;
            left: 104px;
            top: 142px;
			z-index:12;
        }
		 .mod-pop-box .txt2 {
            font-size: 20px;
            height: 24px;
			left:0;
			position:absolute;
            text-align: center;
            width: 432px;
			z-index:12;
        }
    </style>
<script type="text/javascript" src="../js/pagecontrolx.js"></script>
<script type="text/javascript">
//--common var S
	var areaid=0;
	var indexid=0;
	var area0,popup0,area1;
	var mycurpage=1;
	var isfavsucc = -1; //用于判断收藏是否添加成功 0.添加失败(添加接口失败) 1.添加成功 2.收藏夹已满
	//--common var E
	
    window.onload = function(){
		
		//--area0 S
		area0=AreaCreator(8,1,new Array(-1,-1,-1,1),new Array("area0_list_","area0_list1_"),new Array("className:link onboder","className:item item_select"),new Array("className:link offboder","className:item"));
		area0.setstaystyle(new Array("className:link offboder","className:item item_select"),3);
		/**  area0.asyngetdata = function(dataurl) {
			bindVodData(getItmsByPage(jVodlist,area0.curpage,area0.doms.length));
		}  **/
		area0.setfocuscircle(0);
		area0.setcrossturnpage();
		for(i=0;i<area0.doms.length;i++) area0.doms[i].contentdom=$("area0_txt_"+i);
		area0.setSimulationAjax(function(){
			bindVodData(getItmsByPage(jVodlist,area0.curpage,area0.doms.length));
		});
		/**  area0.changefocusedEvent = function(){
		    if(area0.curpage==mycurpage)
			getAJAXData("datajsp/vod-list_data_iframe.jsp?vodid="+area0.doms[area0.curindex].youwanaobj,bindData);
		    mycurpage=area0.curpage;
		}  **/
		area0.areaOkEvent=function(){saveFocstr(pageobj);}
		//--area0 E
		
	    //--area1 S
		area1=AreaCreator(1,2,new Array(-1,0,-1,-1),"area1_list_","className:onboder","className:offboder");
		area1.doms[0].domOkEvent = function(){
			if(!isfaved){
				getAJAXData("datajsp/space_collectAdd_iframedata.jsp?PROGID="+jVodInfo.VODID+"&PROGTYPE="+jVodInfo.CONTENTTYPE,addCollect);
			}else{
				$("fav_div_status").innerHTML = "节目已收藏，请勿重复收藏";
				pageobj.popups[0].showme();
			}
		}
		area0.dataarea=area1;
		area1.setTrueAjax("datajsp/vod-list_data_iframe.jsp?vodid=#(area0.doms[area0.curindex].youwanaobj)",bindData);
		
		//--area1 E
		
		//--popup0 S
		popup0 = new Popup("fav_div");
	    popup0.closetime = 3;
		popup0.goBackEvent=function(){
		   this.closeme();
	    }
		//--popup0 E
		
		//--Set focus S
		if(focusObj!=undefined&&focusObj!="null"){
			areaid = parseInt(focusObj[0].areaid);
			indexid = parseInt(focusObj[0].curindex);
			area0.curpage = parseInt(focusObj[0].curpage);
		}
		//--Set focus E
		
		//--pageobj S
		pageobj = new PageObj(new Array(area0,area1),new Array(popup0));
		pageobj.backurl=returnurl;
		//--pageobj E
		
		//--common S
		refreshServerTime();//时间填充
		//--common E
		
		//--binddatas S	
		bindVodData(getItmsByPage(jVodlist,area0.curpage,area0.doms.length));
		//bindVodContent(jVodInfo);
		pageobj.setinitfocus(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0);
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

function bindData(jsonTxt){
	var thisjson = eval('('+jsonTxt+')');
	jVodInfo = thisjson;
	bindVodContent(jVodInfo);
}

//添加收藏
function addCollect(resultstr){
	isfavsucc = parseInt(resultstr);
	switch(isfavsucc){
		case 0:
			$("fav_div_status").innerHTML = "添加收藏失败，请稍候再试";
			pageobj.popups[0].showme();
			break;
		case 1:
			isfaved = true;						
			$("fav_div_status").innerHTML = "节目已成功加入收藏";
			isfavsucc = -1;
			pageobj.popups[0].showme();
			break;
		case 2:
			$("fav_div_status").innerHTML = "收藏夹已满，请删除后重试";
			pageobj.popups[0].showme();
			break;
		default:
			break;
	} 	   
}

//删除收藏
function delCollect(resultstr){
	isfavsucc = parseInt(resultstr);
	switch(isfavsucc){
		case 0:
			$("fav_div_status").innerHTML = "移除收藏失败，请稍候再试";
			pageobj.popups[0].showme();
			break;
		case 1:
			isfaved = false;
			$("fav_div_status").innerHTML = "节目已移除收藏";
			$("area1_content_0").innerHTML = "收&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;藏";
			pageobj.popups[0].showme();
			isfavsucc = -1;
			break;
		default:
			break;
	}
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
            <div class="txt" id="area0_txt_0"></div>
        </div>
        <div class="item" style="top:75px;" id="area0_list1_1">
            <div class="link" id="area0_list_1"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_txt_1"></div>
        </div>
        <div class="item" style="top:119px;" id="area0_list1_2">
            <div class="link" id="area0_list_2"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_txt_2"></div>
        </div>
        <div class="item" style="top:163px;" id="area0_list1_3">
            <div class="link" id="area0_list_3"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_txt_3"></div>
        </div>
        <div class="item" style="top:207px;" id="area0_list1_4">
            <div class="link" id="area0_list_4"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_txt_4"></div>
        </div>
        <div class="item" style="top:251px;" id="area0_list1_5">
            <div class="link" id="area0_list_5"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_txt_5"></div>
        </div>
        <div class="item" style="top:295px;" id="area0_list1_6">
            <div class="link" id="area0_list_6"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_txt_6"></div>
        </div>
        <div class="item" style="top:339px;" id="area0_list1_7">
            <div class="link" id="area0_list_7"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_txt_7"></div>
        </div>

        <!-- S 导航分页 -->
        <div class="mod-paging-b" style="left: 56px; top:442px;" id="page"></div>
        <!-- E 导航分页 -->

    </div>
    <!-- E 左侧导航 -->

<!--内容部分-->
    <div class="mod-vodlistCont">

        <!-- S 海报 -->
         <div class="picWrap">
            <div class="pic"><img  id="vod_pst"/></div>
            <div class="icon"></div>
        </div>
        <!-- E 海报 -->

        <!-- S 内容描述 -->
        <div class="txtLine" style="width:165px; left:445px; top:110px;" id="vod_dct"></div>
		<div class="txtLine" style="width:120px; left:490px; top:110px;"></div>
   
        <div class="txtLine" style="width:160px; left:445px; top:160px;" id="vod_act"></div>
		<div class="txtLine" style="width:120px; left:490px; top:160px;"></div>
       
        <div class="txtLine" style="width:60px; left:280px; top:315px;"><span class="th">简介：</span></div>
	    <div class="txtLine" style="width:280px; left:328px; top:315px;" id="introduce"></div>
      
        <!-- E 内容描述 -->

		
		 <!-- S 按钮部分 -->
        <div class="btn-fav" style="position:absolute; left:446px; top:413px;"><img id="area1_list_0" class="offboder" src="../images/btn-fav.png" ></div>
		
       <!-- <div class="btn-recommend" style="position:absolute; left:440px; top:389px;"><a href="#"><img src="../../images/btn-recommend.png" alt="推荐"></a></div>-->
        <!-- E 按钮部分 -->
		
    <!-- S pop_up -->
    <div class="mod-pop-box" id="fav_div" style="display:none;">
		<div class="txt2" style="top:90px;" id="fav_div_status"></div>
    </div>
    <!-- E pop_up -->

</div>
<%@ include file="servertimehelp.jsp" %>
</body>
</html>