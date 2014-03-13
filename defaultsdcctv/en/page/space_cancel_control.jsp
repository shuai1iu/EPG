<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="datajsp/space_cancel_data.jsp"%>
<html>
<head>
<script language="javascript" type="text/javascript" src="../js/pagecontrol.js"></script>
<script language="javascript" type="text/javascript">
if (typeof(iPanel) != 'undefined'){iPanel.focusWidth = "2";iPanel.defaultFocusColor = "#FCFF05";}
var area0,area1;
var areaid = 0,indexid = 3;
var pagesize = 9;
var curpage = 1;
var pagecount = 1;
if(recordlist.length != 0){
	pagecount = parseInt((recordlist.length-1)/pagesize)+1;
}
function loadBody(){ 
	initPage();
	if(recordlist.length==0){
		$("area1_list_0_name").innerHTML = "暂无记录";
		area1.datanum = 1;
	}else{
		bindData(getItmsByPage(recordlist,curpage,pagesize));
	}
}

function bindData(data){	 
	for(var i = 0; i < pagesize; i++){
		if(i<data.length){  
			area1.doms[i].setcontent("",data[i].prodname,12);
			area1.doms[i].mylink = "cancel_order_sure.jsp?prodcode="+data[i].prodcode+"&prodname="+data[i].prodname+"&type="+data[i].type+"&starttime="+data[i].starttime;
			$("area1_list_"+i+"_type").innerHTML = data[i].type;
			$("area1_list_"+i+"_date").innerHTML = data[i].ordertime;
			$("area1_list_"+i+"_price").innerHTML = "取消";
		}else{
			area1.doms[i].mylink = "";
			$("area1_list_"+i+"_name").innerHTML = "";
			$("area1_list_"+i+"_type").innerHTML = "";
			$("area1_list_"+i+"_date").innerHTML = "";
			$("area1_list_"+i+"_price").innerHTML = "";
		}
	}
	area1.datanum = data.length;
	$("pageinfo").innerHTML = "<span class='current'>"+curpage+"</span>/"+pagecount;
}

function initPage() {
    refreshServerTime();
    area0 = AreaCreator(6, 1, new Array(-1, -1, -1, 1), "area0_list_", "afocus", "ablur");
    area0.doms[0].mylink="space_collect.jsp?areaid=0&indexid=0";
    area0.doms[1].mylink="space_bookmarks.jsp?areaid=0&indexid=1";
    area0.doms[2].mylink="space_consumer_records.jsp?areaid=0&indexid=2";
	//area0.doms[3].mylink="space_cancel.jsp?areaid=0&indexid=3";
	area0.doms[4].mylink="space_instructions.jsp?areaid=0&indexid=4";
	area0.doms[5].mylink="space_installed.jsp?areaid=0&indexid=5";
    area0.setfocuscircle(0);
   
   area1 = AreaCreator(9, 1, new Array(-1,0, -1, -1), "area1_list_", "afocus", "ablur");
   for(var i=0;i<pagesize;i++){
		area1.doms[i].contentdom = $("area1_list_"+i+"_name");
	}
   area1.setfocuscircle(0);
   area1.areaPageTurnEvent = function(num){
		if(num == 1){
			if(nextPage()){
				area1.changefocus(area1.curindex,false);
				area1.changefocus(0,true);
			}
		}else if(num == -1){
			if(prevPage()){
				area1.changefocus(area1.curindex,false);
				area1.changefocus(0,true);
			}
		}
	}
    pageobj = new PageObj(areaid, indexid, new Array(area0, area1));
	pageobj.backurl = "index.jsp?back=1";
}

function prevPage(){
	if(1 == pagecount)
		return false;
	if(curpage>1){
		curpage--;	
	}else{
		curpage = pagecount;
	}
	bindData(getItmsByPage(recordlist,curpage,pagesize));
	return true;
}

function nextPage(){
	if(1 == pagecount)
		return false;
	if(curpage<pagecount){
		curpage++;		
	}else{
		curpage = 1;
	}
	bindData(getItmsByPage(recordlist,curpage,pagesize));
	return true ;
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
</html>
