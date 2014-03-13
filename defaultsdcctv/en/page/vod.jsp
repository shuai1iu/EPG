<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<%@ include file="util/save_focus.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<%@ include file="datajsp/vod_data.jsp"%>
<%@ include file="util/util_getPosterPaths.jsp"%>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<meta name="page-view-size" content="640*530"/>
<title>点播 | CCTV-IP电视</title>
<link rel="stylesheet" type="text/css" href="../css/style.css" />
<style type="text/css">
    body {
        background: #0d4764 url("../images/body-page-vod.jpg") no-repeat;
    }
    .mod-vodContlist {}
    .mod-vodContlist .item {}
    .mod-vodContlist .item,
    .mod-vodContlist .item .link,
    .mod-vodContlist .item .link img,
    .mod-vodContlist .item .txt {
        height: 37px;
        width: 105px;
    }
    .mod-vodContlist .item .txt {
        height: 24px;
        text-align: center;
        top: 8px;
    }
    .mod-vodContlist .item_focus .txt {
        font-weight: bold;
    }
</style>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
	//--common var S
	var areaid=<%=request.getParameter("areaid")%>;
	var indexid=<%=request.getParameter("indexid")%>;
	var area0,area1,area2;
	//--common var E
	
    window.onload = function(){
		refreshServerTime();
		//--area0 S
		area0=AreaCreator(8,1,new Array(-1,-1,-1,1),new Array("area0_list_","area0_list1_"),new Array("className:item item_select","className:link onboder"),new Array("className:item","className:link offboder"));
		area0.setstaystyle(new Array("className:item item_select","className:link offboder"),3);
		for(i=0;i<8;i++)
		   area0.doms[i].contentdom=$("area0_txt_"+i);
		area0.asyngetdata = function(dataurl) {
			bindTypeData(getItmsByPage(jTypelist,area0.curpage,area0.doms.length));
		}
		area0.setpageturnattention("pageup","../images/arr-up.png","../images/arr-up_disable.png","pagedown","../images/arr-down.png","../images/arr-down_disable.png");
		area0.setfocuscircle(0);
		area0.setcrossturnpage();	
		area0.dataarea = area1;
		area0.changefocusingEvent = function(){
			if(area0.dataarea==undefined){
				area0.dataarea = area1;
			}
			area1.curpage = 1;
		}
		
		//--area0 E
		
		//--area1 S
		area1 = AreaCreator(6, 2, new Array(-1, 0, -1, 2), "area1_list_", "className:link onboder", "className:link offboder");
		for(i=0;i<12;i++)
		    area1.doms[i].contentdom=$("area1_txt_"+i);
		area1.setfocuscircle(0);
		area1.setcrossturnpage();
		
		area1.asyngetdata = function(dataurl){
			if(!!dataurl){
				getAJAXData("datajsp/vod_data_iframe.jsp?typeid="+dataurl,bindData);
			}else{
				bindCateData(getItmsByPage(jCatelist,area1.curpage,area1.doms.length));
			}
		}
		
		area1.areaOkEvent = function(){saveFocstr(pageobj);}
		//--area1 E
		
		//--area2 S
		area2 = AreaCreator(3, 1, new Array(-1, 1, -1, -1), "area2_list_","className:link onboder","className:link offboder");
		area2.setfocuscircle(0);
		for(i=0;i<area2.doms.length;i++) 
		{ 
		    area2.doms[i].imgdom=$("area2_pic_"+i);
			//area2.doms[i].contentdom=$("area2_txt_"+i);
		}
		area2.areaOkEvent = function(){saveFocstr(pageobj);}
		//--area2 E
		
		//--pageobj S
		
		if(focusObj!=undefined&&focusObj!="null"){
			areaid = parseInt(focusObj[0].areaid);
			indexid = parseInt(focusObj[0].curindex);
			//alert(areaid+"\n"+indexid);
			if(focusObj[0].areaid == 1){
			    area1.curpage = parseInt(focusObj[0].curpage);
			}
		}
		
		pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area0, area1, area2));
		pageobj.backurl=returnurl;
		//--pageobj E
		
		//--common S
		refreshServerTime();//时间填充
		setDarkFocus();
		//--common E
		
		//--binddatas S	
		//填充1级栏目
		bindTypeData(getItmsByPage(jTypelist,area0.curpage,area0.doms.length));
		bindData(jContents);
		//--binddatas E
	}
	
	
	//--common functions S
//获取0-length以内的随机整数
function creatRandoms(length){return Math.round(Math.random()*length);}

//获取itms数组中，随机size个数的新数组
function getRanItems(itms,size){	
		var newarr = new Array();
		if(itms==undefined||itms[0]=="null"){
			size = 0;
		}else if(size>itms.length){
			size = itms.length;
		}
		
		for(var i = 0;i<size;i++){
			var idx = creatRandoms(itms.length-1);
			newarr[i] = itms[idx];
			itms.splice(idx,1);
		}
		return newarr;
	}
	
function getItmsByPage(cptitms,icurpage,ipagesize){
	var reclist=new Array();
	var start = (icurpage-1)*ipagesize;
	for(var i=0;i<ipagesize&&(i+(icurpage-1)*ipagesize)<cptitms.length;i++){
	     reclist[i]=cptitms[start+i];
	}
	return reclist;
}

//绑定后两级页面
function bindData(txtJson){	
	var thisjson = eval(txtJson);
	jCatelist = thisjson.jsoncatelist;
	catepagecount = Math.floor(((jCatelist.length-1)/(area1.doms.length)))+1;
	jRmdlist= thisjson.jsonrmdlist;
	bindCateData(getItmsByPage(jCatelist,area1.curpage,area1.doms.length));
	if(jRmdlist!="null"&&jRmdlist!=undefined){bindRmdData(jRmdlist,3);}
}
	//--common functions E
</script>
</head>
<body>
<div class="wrapper">

    <!-- S 面包屑 -->
    <div class="mod-bread">
        点播
    </div>
    <!-- E 面包屑 -->

    <!-- S 时间 -->
    <div class="mod-dataTime" id="currDate"></div>
    <!-- E 时间 -->

    <!-- S 左侧导航 -->
    <div class="leftNav-a">

        <!-- S 向上箭头 -->
        <div class="item-arr-up" style="top:75px;">
            <img id="pageup" />
        </div>
        <!-- E 向上箭头 -->

        <div class="item" style="top:61px;" id="area0_list_0">
            <div class="link" id="area0_list1_0"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_txt_0"></div>
        </div>
        <div class="item" style="top:103px;" id="area0_list_1">
            <div class="link" id="area0_list1_1"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_txt_1"></div>
        </div>
        <div class="item" style="top:145px;" id="area0_list_2">
            <div class="link" id="area0_list1_2"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_txt_2"></div>
        </div>
        <div class="item" style="top:187px;" id="area0_list_3">
            <div class="link" id="area0_list1_3"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_txt_3"></div>
        </div>
        <div class="item" style="top:229px;" id="area0_list_4">
            <div class="link" id="area0_list1_4"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_txt_4"></div>
        </div>
        <div class="item" style="top:271px;" id="area0_list_5">
            <div class="link" id="area0_list1_5"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_txt_5"></div>
        </div>
        <div class="item" style="top:313px;" id="area0_list_6">
            <div class="link" id="area0_list1_6"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_txt_6"></div>
        </div>
        <div class="item" style="top:355px;" id="area0_list_7">
            <div class="link" id="area0_list1_7"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_txt_7"></div>
        </div>

        <!-- S 向下箭头 -->
        <div class="item-arr-down" style="top:444px;">
            <img id="pagedown" /></div>
        </div>
        <!-- E 向下箭头 -->
    </div>
    <!-- E 左侧导航 -->

    <!--内容部分-->

    <div class="mod-vodContlist">
        <div class="item" style="left:215px; top:144px;">
            <div class="link" id="area1_list_0"><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_txt_0"></div>
        </div>
        <div class="item" style="left:338px; top:144px;">
            <div class="link" id="area1_list_1"><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_txt_1"></div>
        </div>
        <div class="item" style="left:215px; top:188px;">
            <div class="link" id="area1_list_2"><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_txt_2"></div>
        </div>
        <div class="item" style="left:338px; top:188px;">
            <div class="link" id="area1_list_3"><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_txt_3"></div>
        </div>
        <div class="item" style="left:215px; top:232px;">
            <div class="link" id="area1_list_4"><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_txt_4"></div>
        </div>
        <div class="item" style="left:338px; top:232px;">
            <div class="link" id="area1_list_5"><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_txt_5"></div>
        </div>
        <div class="item" style="left:215px; top:276px;">
            <div class="link" id="area1_list_6"><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_txt_6"></div>
        </div>
        <div class="item" style="left:338px; top:276px;">
            <div class="link" id="area1_list_7"><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_txt_7"></div>
        </div>
        <div class="item" style="left:215px; top:320px;">
            <div class="link" id="area1_list_8"><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_txt_8"></div>
        </div>
        <div class="item" style="left:338px; top:320px;">
            <div class="link" id="area1_list_9"><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_txt_9"></div>
        </div>
        <div class="item" style="left:215px; top:364px;">
            <div class="link" id="area1_list_10"><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_txt_10"></div>
        </div>
        <div class="item" style="left:338px; top:364px;">
            <div class="link" id="area1_list_11"><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_txt_11"></div>
        </div>
    </div>

    <!--S 分页-->
   <div class="mod-paging-a" id="catepage" align="center">
        <!-- 
        <div class="item item_select" style="left: 287px;">
            <div class="link"><img src="../images/t.gif" /></div>
            <div class="txt" id="catepage1"></div>
        </div>
        <div class="item" style="left: 327px;">
            <div class="link"><img src="../images/t.gif" /></div>
            <div class="txt" id="catepage2"></div>
        </div>
         -->
    </div>
    <!--E 分页-->

    <!-- S 电影 -->
    <div class="mod-movieShow">
        <div class="item" style="top: 74px;">
            <div class="link" id="area2_list_0"><img src="../images/t.gif" /></div>
            <!--<div class="txtWrap">
                <div class="txt" id="area2_txt_0"></div>
            </div>-->
            <div class="pic"><img  id="area2_pic_0"/></div>
        </div>
        <div class="item" style="top: 207px;">
            <div class="link" id="area2_list_1"><img src="../images/t.gif" /></div>
             <!--<div class="txtWrap">
                <div class="txt" id="area2_txt_1"></div>
            </div>-->
            <div class="pic"><img  id="area2_pic_1" /></div>
        </div>
        <div class="item" style="top: 340px;">
            <div class="link" id="area2_list_2"><img src="../images/t.gif" /></div>
             <!--<div class="txtWrap">
                <div class="txt" id="area2_txt_2"></div>
            </div>-->
            <div class="pic"><img  id="area2_pic_2" /></div>
        </div>
    </div>
    <!-- E 电影 -->

</div>
<%@ include file="servertimehelp.jsp" %>
</body>
</html>