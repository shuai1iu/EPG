<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视欧洲杯高清3.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="../../../util/save_focus.jsp"%>
<%@ include file="datajsp/dibbling-group-two_data.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<script src="../js/pagecontrolx.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
var area2;
window.onload=function(){
     	initPage(focstr);
	refreshServerTime();
	if($("currDate") != undefined) 
		$("currDate").innerHTML = "<strong>"+strcurdate + "</strong>";
	//document.getElementById('body').style.background=picTypePath;
}

function getItmsByPage(cptitms,icurpage,ipagesize){
	var reclist=new Array();
	var start = (icurpage-1)*ipagesize;
	for(var i=0;i<ipagesize&&(i+(icurpage-1)*ipagesize)<cptitms.length;i++){
	     reclist[i]=cptitms[start+i];
	}
	
	return reclist;
}

function bindNavigatData(){
		var linkArrs = {"index":1};
		area0.doms[0].mylink = "index.jsp";
		if(true){
			area0.doms[1].mylink = "group-match.jsp";
		}else{
			area0.doms[1].mylink = "knockout.jsp";
		}
		area0.doms[2].mylink = "video.jsp";
		area0.doms[3].mylink = "star.jsp";
		area0.doms[4].mylink = "top-scorer.jsp";
		area0.doms[5].mylink = "search.jsp";
		area0.doms[linkArrs[curPage]].mylink = undefined;
}

function initPage() {

		var LinkInfo = topicInfo;
		var LinkInfoArray =  LinkInfo.split("?");
		var TmpLinkLength = LinkInfoArray[4].split(":");	//count:7
		var LinkLength = TmpLinkLength[1];		//7

		var TmpLines = LinkInfoArray[6].split(":");        //line:04
		var Lines = TmpLines[1];              
		var TmpRows = LinkInfoArray[7].split(":");        //row:02
                var Rows = TmpRows[1];              

//		alert(LinkInfoArray[0]);
		var TmpPosArray =  LinkInfoArray[0].split(":");		//pos:{179,271}c{36,178}c{107,224}c{417,239}c{251,306}c{339,281}c{492,282}	
		var PosArray =  TmpPosArray[1].split("c");		//get pos by c {179,271}

		var TmpImgArray =  LinkInfoArray[1].split(":"); 	//img:{61,257}c{57,209}c{61,214}c{60,208}c{59,195}c{61,220}c{58,204}
		var ImgArray =  TmpImgArray[1].split("c");              //get img by c
				
		var tmpP,tmpP_set1,tmpP_set2;
		for(var i=0;i<LinkLength;i++){
			tmpP = PosArray[i];
			tmpP_set1 = tmpP.replace(/\{/,"");
			tmpP_set2 = tmpP_set1.replace(/\}/,"");
			var LastPArray = tmpP_set2.split(",");
			$('pic0_style'+i).style.left = LastPArray[0]+"px"; //hwwebkit	
			$('pic0_style'+i).style.top = LastPArray[1]+"px";	//hwwebkit
//			alert($('pic0_style'+i).style.top);

			tmpP = ImgArray[i];
                        tmpP_set1 = tmpP.replace(/\{/,"");
                        tmpP_set2 = tmpP_set1.replace(/\}/,"");
                        var LastImgArray = tmpP_set2.split(",");
                        $('img0_style'+i).style.width = LastImgArray[0]+"px";  //hwwebkit
                        $('img0_style'+i).style.height = LastImgArray[1]+"px";  //hwwebkit
//                      alert($('img0_style'+i).style.height+'and '+$('img0_style'+i).style.width);
		}
	
//		alert(location.search);
//		alert('Count is:'+LinkLength+' Lines&Rows is:'+Lines+' '+Rows);
		area2 = AreaCreator(Lines,Rows,new Array(-1,-1,-1,-1),"area2_link","afocus","ablur");
		//area2.stablemoveindex=new Array(-1,MoveTag,-1,-1);
		 for(i=0;i<area2.doms.length;i++) area2.doms[i].contentdom=$("area2_txt"+i);
		 	area2.setSimulationAjax(function(){
		 	area2curindex=area2.curindex;
	     	 	area2curpage=area2.curpage;
		 	bindVODData(getItmsByPage(jsonvodlist,area2curpage,area2pagesize));
		 });
		area2.areaOkEvent=function(){
		    	if(area2.doms[area2.curindex].youwanauseobj==-1) return;
			//saveFocstr(pageobj);
			//location.href = "vod-detail.jsp?typeid=<%=typeid%>&vodid="+area2.doms[area2.curindex].youwanauseobj+"&returnurl="+escape(location.href);
			//location.href = "../../../vod_turnpager.jsp?vodid="+area2.doms[area2.curindex].youwanauseobj+"&typeid=<%=typeid%>"+"&returnurl="+escape(location.href);
			var catename = "专题推荐";
			location.href = "../../../vod-tv-detail.jsp?catename="+catename+"&typeid=<%=typeid %>&vodid="+area2.doms[area2.curindex].youwanauseobj+"&returnurl="+escape(location.href);
		 }  
		 
	  	 pageobj = new PageObj(new Array(area2));
		 pageobj.backurl=returnurl;
	   
	     area2.curpage=area2curpage;
		
		 bindVODData(getItmsByPage(jsonvodlist,area2curpage,area2pagesize));
		 //bindRecommendData(jRecommends);
		
		 if(focusObj!="null"&&focusObj!=undefined){
			 alert("focusObj get");
		 }

		 //pageobj.setinitfocus(areaid!=null?parseInt(areaid):2,indexid!=null?parseInt(indexid):1);
		 pageobj.setinitfocus(0,0);
		 
		 document.getElementsByTagName('body')[0].style.backgroundImage='url(' + picTypePath + ')';
		 
}

//common function S
	function turnUrl(url){
		if(url!=undefined&&url!="null"){
			url += ((url.indexOf("?")==-1)?"?":"&")+"returnurl="+escape(location.href);
			location.href = url;
		}
	}
//common funciton E
//<div class="pic" style="left:88px; top:28px;"><a href="#" id="return_button_0";"><img src="../images/btn-return.png" /></a></div>
//<div class="txt" id="area2_txt0"></div>
</script>
	
<style type="text/css">
<!--
	body{ background:url(../images/t.gif) no-repeat;}
-->	
</style>
</head>

<body>
<div class="item">
       <div class="pic" id="pic0_style0"><a href="#" id="area2_link0"><img id="img0_style0" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style1"><a href="#" id="area2_link1"><img id="img0_style1" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style2"><a href="#" id="area2_link2"><img id="img0_style2" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style3"><a href="#" id="area2_link3"><img id="img0_style3" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style4"><a href="#" id="area2_link4"><img id="img0_style4" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style5"><a href="#" id="area2_link5"><img id="img0_style5" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style6"><a href="#" id="area2_link6"><img id="img0_style6" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style7"><a href="#" id="area2_link7"><img id="img0_style7" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style8"><a href="#" id="area2_link8"><img id="img0_style8" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style9"><a href="#" id="area2_link9"><img id="img0_style9" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style10"><a href="#" id="area2_link10"><img id="img0_style10" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style11"><a href="#" id="area2_link11"><img id="img0_style11" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style12"><a href="#" id="area2_link12"><img id="img0_style12" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style13"><a href="#" id="area2_link13"><img id="img0_style13" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style14"><a href="#" id="area2_link14"><img id="img0_style14" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style15"><a href="#" id="area2_link15"><img id="img0_style15" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style16"><a href="#" id="area2_link16"><img id="img0_style16" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style17"><a href="#" id="area2_link17"><img id="img0_style17" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style18"><a href="#" id="area2_link18"><img id="img0_style18" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style19"><a href="#" id="area2_link19"><img id="img0_style19" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style20"><a href="#" id="area2_link20"><img id="img0_style20" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style21"><a href="#" id="area2_link21"><img id="img0_style21" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style22"><a href="#" id="area2_link22"><img id="img0_style22" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style23"><a href="#" id="area2_link23"><img id="img0_style23" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style24"><a href="#" id="area2_link24"><img id="img0_style24" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style25"><a href="#" id="area2_link25"><img id="img0_style25" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style26"><a href="#" id="area2_link26"><img id="img0_style26" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style27"><a href="#" id="area2_link27"><img id="img0_style27" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style28"><a href="#" id="area2_link28"><img id="img0_style28" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style29"><a href="#" id="area2_link29"><img id="img0_style29" src="../images/t.gif" /></a></div>
       <div class="pic" id="pic0_style30"><a href="#" id="area2_link30"><img id="img0_style30" src="../images/t.gif" /></a></div>
</div>
</body>
</htm>
