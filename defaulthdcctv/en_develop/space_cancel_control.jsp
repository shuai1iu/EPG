<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="datajsp/space_cancel_data.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<html>
<head>
<script language="javascript" type="text/javascript" src="js/pagecontrol.js"></script>
<script language="javascript" type="text/javascript">
var area0,area1,area2,area3;
var areaid = 1,indexid = 3;
var pagesize = 8;
var curpage = 1;
var pagecount = 1;
if(recordlist.length != 0){
	pagecount = parseInt((recordlist.length-1)/pagesize)+1;
}
function loadData(){ 
	initPage();
	if(recordlist.length==0){
		$("area2_list_0_name").innerHTML = "暂无记录";
		area2.datanum = 1;
	}else{
		bindData(getItmsByPage(recordlist,curpage,pagesize));
	}
}

function bindData(data){	 
	for(var i = 0; i < pagesize; i++){
		if(i<data.length){  
			area2.doms[i].setcontent("",data[i].prodname,12);
			area2.doms[i].mylink = "cancel_order_sure.jsp?prodcode="+data[i].prodcode+"&prodname="+data[i].prodname+"&type="+data[i].type+"&starttime="+data[i].starttime;
			$("area2_list_"+i+"_type").innerHTML = data[i].type;
			$("area2_list_"+i+"_date").innerHTML = data[i].ordertime;
			$("area2_list_"+i+"_price").innerHTML = "取消";
		}else{
			area2.doms[i].mylink = "";
			$("area2_list_"+i+"_name").innerHTML = "";
			$("area2_list_"+i+"_type").innerHTML = "";
			$("area2_list_"+i+"_date").innerHTML = "";
			$("area2_list_"+i+"_price").innerHTML = "";
		}8
	}
	area2.datanum = data.length;
	$("pageinfo").innerHTML = curpage+"/"+pagecount;
}

function initPage() {
	area0 = AreaCreator(10, 1, new Array(-1, -1, -1, 1), "area0_list_", "className:menuli on", "className:menuli");
	area0.setstaystyle("className:menuli current", 3);
	if(areaid!=null&&areaid!=0){
		area0.setdarknessfocus(8);
		$('area0_list_8').className="menuli current";
	}
	area0.doms[0].mylink=indexhref[0];
	area0.doms[1].mylink=indexhref[1];
	area0.doms[2].mylink=indexhref[2];
	area0.doms[3].mylink=indexhref[3];
	area0.doms[4].mylink=indexhref[4];
	area0.doms[5].mylink=indexhref[5];
	area0.doms[6].mylink=indexhref[6];
	area0.doms[7].mylink=indexhref[7];
	area0.doms[9].mylink=indexhref[9];
	area0.setfocuscircle(0);

	area1 = AreaCreator(6,1, new Array(-1,0, -1, 2), "area1_list_", "className:d_li on", "className:d_li");	
	area1.setstaystyle("className:d_li current", 3);

	area1.doms[0].mylink="space_collect.jsp?areaid=1&indexid=0";
	area1.doms[1].mylink="space_bookmarks.jsp?areaid=1&indexid=1";
	area1.doms[2].mylink="space_consumer_records.jsp?areaid=1&indexid=2";
	//area1.doms[3].mylink="space_cancel.jsp?areaid=1&indexid=3";
	area1.doms[4].mylink="space_instructions.jsp?areaid=1&indexid=4";
	area1.doms[5].mylink="space_installed.jsp?areaid=1&indexid=5";
	area2 = AreaCreator(8, 1, new Array(-1, 1, 3, -1), "area2_list_", "className:p_li focus", "className:p_li");
	for(var i=0;i<8;i++){
		area2.doms[i].contentdom = $("area2_list_"+i+"_name");
	}
	area2.areaPageTurnEvent = function(num){
		if(num == 1){
			if(nextPage()){
				area2.changefocus(area2.curindex,false);
				area2.changefocus(0,true);
			}
		}else if(num == -1){
			if(prevPage()){
				area2.changefocus(area2.curindex,false);
				area2.changefocus(0,true);
			}
		}
	}
	area3 = AreaCreator(1, 2, new Array(2, 1, -1, -1), "area3_list_", "className:item item_focus", "className:item");
	area3.stablemoveindex = new Array("0-7,1-7",-1,-1,-1);
	area3.doms[0].domOkEvent=function(){
		prevPage();
	}
	area3.doms[1].domOkEvent=function(){
		nextPage();
	}
	pageobj = new PageObj(areaid, indexid, new Array(area0, area1, area2, area3));
	pageobj.backurl = "index.jsp";
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
