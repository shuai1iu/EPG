<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>电视剧详情-上海电信应用商城EPG3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<style type="text/css">
<!--
	body{ background:url(../images/bg01.jpg) no-repeat;}
	
	.popup,.popup2{ position:absolute; top:170px; left:290px; width:700px; height:380px; z-index:99}
	.popup{ background:url(../../images/popup_bg.png) no-repeat}
	.popup2{ background:url(../../images/popup_bg2.png) no-repeat}
.pop_fee,.pop_tip,.pop_price,.pop_buy{ position:absolute; left:80px; width:545px; text-align:center; line-height:46px}
	.pop_fee{ top:60px}
	.pop_tip{ top:170px}
	.pop_price{ top:120px}
	.pop_buy{ top:90px}
.pop_btns{ position:absolute; top:221px; left:120px; width:500px}
	.po1,.po2{ left:270px!important; width:160px!important}
	.po1{top:290px!important}
	.po2,.po3{top:250px!important}
	.po4{top:180px!important}
.pop_btns div,.btns div{ float:left; width:151px; height:39px; line-height:39px; text-align:center}
.pop_btns div.on,.btns div.on{ background:url(../../images/btn_bg.png) no-repeat}
	.btns{ position:absolute; top:40px; right:90px}
	.btns2{ position:absolute; top:630px; left:290px; width:750px}
	.btns2 div{ float:left; text-align:center; width:350px; height:40px; line-height:40px}
	.btns2 div.on{ background:url(../../images/channel_subon.png) no-repeat}
		.b2_po{ left:180px!important; width:350px!important}
		
	.btns3{ padding:35px 0;}
	.btns3 div{ float:left; text-align:center; width:214px; height:46px; line-height:46px}
	.btns3 div.on{ background:url(../../images/sub_bg3on.png) no-repeat}	
	
.disno{ display:none}
-->
</style>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="util/save_focus.jsp"%>
<%@ include file="datajsp/tv_detaildata.jsp"%>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
var area0,area1,area2,area3,area4;
var areaid = 0;
var indexid = 0;
var curpage = 1;
var pagesize = 30;
var pagecount = parseInt((data.SERIECOUNT-1)/pagesize)+1;
var tempdatalist=new Array();
var isselectplay=false;

var begintime = '-1';
var endtime = '-1';
var isbookmark = undefined;

window.onload = function(){
	area0=AreaCreator(1,2,new Array(-1,-1,1,3),"area0_list_","className:item item_focus","className:item");
	area0.doms[0].domOkEvent = function(){
		nextPage();
	}
	area0.doms[1].domOkEvent = function(){
		prevPage();
	}
	area1=AreaCreator(2,15,new Array(0,-1,2,3),"area1_list_","className:item item_focus","className:item");
	for(var i=0;i<area1.doms.length;i++){
		area1.doms[i].contentdom = $("area1_list_"+i);
	}
	area2=AreaCreator(1,1,new Array(1,-1,-1,3),"area2_list_","className:item item_focus","className:item");
	area2.doms[0].domOkEvent = function(){
		window.location.href = returnurl;
	}
	area3=AreaCreator(1,1,new Array(-1,0,-1,-1),"area3_list_","className:item item_focus","className:item");
	area3.stablemoveindex=new Array(-1,"0-1",-1,-1);
	area3.doms[0].imgdom=$("area3_img_0");
	if(focusObj!=undefined&&focusObj!="null"){
		areaid = parseInt(focusObj[0].areaid);
		indexid = parseInt(focusObj[0].curindex);
		curpage = parseInt(focusObj[0].curpage);
	}
	
	//书签
	   area4 = AreaCreator(1,2,new Array(-1,-1,-1,-1),"div_tip","className:on","className:");
	   area4.doms[0].domOkEvent = function(){
		   location.href = "../../au_PlayFilm.jsp?PROGID=<%=vodid%>&PLAYTYPE=6&CONTENTTYPE=0&BUSINESSTYPE=1&BEGINTIME="+begintime+"&ENDTIME="+endtime+"&returnurl="+escape(location.href);
		   
		   if(isselectplay){
					window.location.href = "../../au_PlayFilm.jsp?PLAYTYPE=6&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&BEGINTIME="+begintime+"&ENDTIME="+endtime+"&PROGID="+data.SERIES[0].SERIEID+"&FATHERSERIESID="+vodid+"&returnurl="+escape(location.href);
					}else{
					window.location.href = "../../au_PlayFilm.jsp?PLAYTYPE=6&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&BEGINTIME="+begintime+"&ENDTIME="+endtime+"&PROGID="+tempdatalist[area1.curindex].SERIEID+"&FATHERSERIESID="+vodid+"&returnurl="+escape(location.href);
					}
	   
	   }
	   area4.doms[1].domOkEvent = function(){
		   if(isselectplay){
			window.location.href = "../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&PROGID="+data.SERIES[0].SERIEID+"&FATHERSERIESID="+vodid+"&returnurl="+escape(location.href);
			}else{
			window.location.href = "../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&PROGID="+tempdatalist[area1.curindex].SERIEID+"&FATHERSERIESID="+vodid+"&returnurl="+escape(location.href);
			}
			popup0.closeme();
	   }
	   var popup0 = new Popup("div_tip",new Array(area4));
	   popup0.goBackEvent=function()
	   {
		   this.closeme();
	   }
	   
	pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area0,area1,area2,area3,area4),new Array(popup0));
	pageobj.pageOkEvent=function(){
		area1.curpage = curpage;
		saveFocstr(pageobj);  
	}
	pageobj.backurl = returnurl;
	pageobj.pageTurn = function(num){
		if(num == 1){
			nextPage();
		}else if(num == -1){
			prevPage();
		}
	}
	initPage();
}
function initPage(){
	
	$("typename").innerHTML = typename.substring(0,2)+"&nbsp;<span>"+typename.substring(2)+"</span>"
	$("vodname").innerHTML = data.VODNAME;
	if(data.DIRECTOR==""||data.DIRECTOR==undefined){
		$("introduce").style.top = "43px";
		$("content").style.top = "79px";
		$("content").innerHTML = data.INTRODUCE;
	}else{
		$("director").innerHTML = "<span>导演：</span>"+data.DIRECTOR;
		$("actor").innerHTML = "<span>演员：</span>"+data.ACTOR;
		if(data.INTRODUCE.length>80){
			$("content").innerHTML = data.INTRODUCE.substring(0,75)+"...";
		}else{
			$("content").innerHTML = data.INTRODUCE;
		}
	}
	area3.doms[0].updateimg(data.PICURL);
	area3.doms[0].mylink = "../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&PROGID="+data.SERIES[0].SERIEID+"&FATHERSERIESID="+vodid+"&returnurl="+escape(location.href);
	
	
	/*area3.doms[0].domOkEvent=function(){
		isselectplay=true;
		getAJAXData("check/page/check_subscribe.jsp?VODID=" + data.SERIES[0].SERIEID + "&FATHERID=" + vodid +"&SUBJECTID=<%=typeid%>&CONTENTTYPE="+  data.CONTENTTYPE+"&BUSINESSTYPE=1&PLAYTYPE=1",checksubscribe);
	};*/
	initData(getItmsByPage(data.SERIES,curpage,pagesize));
}


function checksubscribe(jsonResult)
{
	//alert(jsonResult);
	var jsonResult = eval('('+jsonResult+')');
	//jsonResult.ALLOWPLAY=false;
	
	if(jsonResult.ALLOWPLAY==false)
	{
	   var playname="";
	   var pageName="";
	   if(isselectplay){
	        //更换被动订购页面为半价特惠包页面 20131127 
		   playname="../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&PROGID="+data.SERIES[0].SERIEID+
	                "&FATHERSERIESID=" +  vodid +"&returnurl="+escape(location.href);
	       pageName="check/page/once-buy.jsp?SUBJECTID=<%=typeid%>&VODID="+ data.SERIES[0].SERIEID +"&FATHERID=" + vodid  +"&PLAYTYPE=1&CONTENTTYPE="+data.CONTENTTYPE+"&BUSINESSTYPE=1&returnurl="+escape(location.href)+"&playurl="+escape(playname);		
					
	   }else{
	       //更换被动订购页面为半价特惠包页面 20131127 
		   playname="../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&PROGID="+tempdatalist[area1.curindex].SERIEID+
	                "&FATHERSERIESID=" +  vodid +"&returnurl="+escape(location.href);
		   pageName="check/page/once-buy.jsp?SUBJECTID=<%=typeid%>&VODID="+ tempdatalist[area1.curindex].SERIEID +"&FATHERID=" + vodid  +"&PLAYTYPE=1&CONTENTTYPE="+data.CONTENTTYPE+"&BUSINESSTYPE=1&returnurl="+escape(location.href)+"&playurl="+escape(playname);
	  }
	   location.href = pageName;
	}
	else
	{
		if(isselectplay){
			//window.location.href = "../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&PROGID="+data.SERIES[0].SERIEID+"&FATHERSERIESID="+vodid+"&returnurl="+escape(location.href);
			getAJAXData("../../datajsp/check_bookmark.jsp?vodid="+data.SERIES[0].SERIEID,checkBookmark);
		}else{
		    //window.location.href = "../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&PROGID="+tempdatalist[area1.curindex].SERIEID+"&FATHERSERIESID="+vodid+"&returnurl="+escape(location.href);
			getAJAXData("../../datajsp/check_bookmark.jsp?vodid="+tempdatalist[area1.curindex].SERIEID,checkBookmark);
		}
	}
}


function initData(datalist){
	tempdatalist=new Array();
	tempdatalist=datalist;
	area1.datanum = datalist.length;
	$("pageinfo").innerHTML = curpage + "/" + pagecount;
	for(var i=0;i<area1.doms.length;i++){
		if(i<datalist.length){
			if(area1.curindex>datalist.length-1)		
				pageobj.changefocus(1,0);
			$("area1_list_"+i).style.display = "block";
			area1.doms[i].updatecontent(datalist[i].SERIENUM);
			//area1.doms[i].mylink = "../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&PROGID="+datalist[i].SERIEID+"&FATHERSERIESID="+vodid+"&returnurl="+escape(location.href);
			area1.doms[i].domOkEvent=function(){
		         if(isselectplay){
					window.location.href = "../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&PROGID="+data.SERIES[0].SERIEID+"&FATHERSERIESID="+vodid+"&returnurl="+escape(location.href);
				}else{
					window.location.href = "../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&PROGID="+tempdatalist[area1.curindex].SERIEID+"&FATHERSERIESID="+vodid+"&returnurl="+escape(location.href);
				}
        	};
		}else{
			$("area1_list_"+i).style.display = "none";
			area1.doms[i].updatecontent("");
			area1.doms[i].mylink = "#";
		}
	}	
}

//查找书签
function checkBookmark(resultstr){
	var resultmsg = eval('('+resultstr+')');
	isbookmark = resultmsg.isbookmark;
	begintime = resultmsg.begintime;
	endtime = resultmsg.endtime;
	getbookmark();
}

 //获取书签并播放
   function getbookmark(){
	   if(isbookmark==undefined){
		   setTimeout("getbookmark()",500);
	   }else{
		   if(isbookmark==true){  //判断是否有书签
				pageobj.popups[0].showme();
			}else{			
					if(isselectplay){
					window.location.href = "../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&PROGID="+data.SERIES[0].SERIEID+"&FATHERSERIESID="+vodid+"&returnurl="+escape(location.href);
					}else{
					window.location.href = "../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&PROGID="+tempdatalist[area1.curindex].SERIEID+"&FATHERSERIESID="+vodid+"&returnurl="+escape(location.href);
					}
			}
	   }
   }
   
function nextPage(){
	if(curpage<pagecount){
		curpage++;
		initData(getItmsByPage(data.SERIES,curpage,pagesize));
	}
}

function prevPage(){
	if(curpage>1){
		curpage--;
		initData(getItmsByPage(data.SERIES,curpage,pagesize));
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

<!--head-->
<div class="logo">
	<div class="pic"><img src="../images/logo.png" /></div>
	<div class="txt txt-b" id="typename"></div>
</div>
<!--head the end-->	


<!--left list-->	
	<!--info-->
	<div class="details">
		<div class="txt txt-title" id="vodname"></div>
		<div class="pic" style="top:35px;"><img src="../images/line.png" /></div>
		<div class="txt txt-info" style="top:43px;" id="director"></div>
		<div class="txt txt-info" style="top:79px;" id="actor"></div>
		<div class="txt txt-info" style="top:115px;" id="introduce"><span>简介：</span></div>
		<div class="txt txt-info" style="top:151px;" id="content"></div>
	</div>
	
	<!--pages-->
	<div class="pages-a">
		<!--焦点 
			class="item item_focus"
		-->
		<div class="item" id="area0_list_0">
			<div class="icon"><img src="../images/icon-arrow-r.png" /></div>
			<div class="txt">下页</div>
		</div>
		<div class="txt txt-num" id="pageinfo"></div>
		<div class="item" style="left:138px;" id="area0_list_1">
			<div class="icon"><img src="../images/icon-arrow-l.png" /></div>
			<div class="txt">上页</div>
		</div>
	</div>
	
	<!--set-->
	<div class="tv-num">
		<!--焦点 
			class="item item_focus"
		-->
		<div class="item" id="area1_list_0"></div>
		<div class="item" style="left:45px;" id="area1_list_1"></div>
		<div class="item" style="left:90px;" id="area1_list_2"></div>
		<div class="item" style="left:135px;" id="area1_list_3"></div>
		<div class="item" style="left:180px;" id="area1_list_4"></div>
		<div class="item" style="left:225px;" id="area1_list_5"></div>
		<div class="item" style="left:270px;" id="area1_list_6"></div>
		<div class="item" style="left:315px;" id="area1_list_7"></div>
		<div class="item" style="left:360px;" id="area1_list_8"></div>
		<div class="item" style="left:405px;" id="area1_list_9"></div>
		<div class="item" style="left:450px;" id="area1_list_10"></div>
		<div class="item" style="left:495px;" id="area1_list_11"></div>
		<div class="item" style="left:540px;" id="area1_list_12"></div>
		<div class="item" style="left:585px;" id="area1_list_13"></div>
		<div class="item" style="left:630px;" id="area1_list_14"></div>
		
		<div class="item" style="top:48px;" id="area1_list_15"></div>
		<div class="item" style="left:45px;top:48px;" id="area1_list_16"></div>
		<div class="item" style="left:90px;top:48px;" id="area1_list_17"></div>
		<div class="item" style="left:135px;top:48px;" id="area1_list_18"></div>
		<div class="item" style="left:180px;top:48px;" id="area1_list_19"></div>
		<div class="item" style="left:225px;top:48px;" id="area1_list_20"></div>
		<div class="item" style="left:270px;top:48px;" id="area1_list_21"></div>
		<div class="item" style="left:315px;top:48px;" id="area1_list_22"></div>
		<div class="item" style="left:360px;top:48px;" id="area1_list_23"></div>
		<div class="item" style="left:405px;top:48px;" id="area1_list_24"></div>
		<div class="item" style="left:450px;top:48px;" id="area1_list_25"></div>
		<div class="item" style="left:495px;top:48px;" id="area1_list_26"></div>
		<div class="item" style="left:540px;top:48px;" id="area1_list_27"></div>
		<div class="item" style="left:585px;top:48px;" id="area1_list_28"></div>
		<div class="item" style="left:630px;top:48px;" id="area1_list_29"></div>
	</div>
	
<!--left list the end-->	

	
<!--r poster-->	
<div class="poster-d">
	<!--焦点 
		class="item item_focus"
	-->
	<div class="item" id="area3_list_0">
		<div class="pic"><img id="area3_img_0" /></div>
	</div>
</div>
<!--r poster the end-->		
	
	
	
<!--menu-->	
<div class="menu" style="left:78px;">
	<!--焦点 
			class="item item_focus"
		-->
	<div class="item" id="area2_list_0">
		<div class="icon icon07"></div>
		<div class="txt">返回</div>
	</div>
</div>
<!--menu the end-->			
	
    
              
              
               
               
               
<div class="popup" id="div_tip" style="display:none">    	
    <div class="pop_fee">是否从书签处开始播放？</div>		
    <div class="pop_btns">	
        <div id="div_tip0" class="on">书签播放</div>
        <div>&nbsp;</div>
        <div id="div_tip1">从头播放</div>
    </div>
</div>               
                      
                      
</body>
</html>
