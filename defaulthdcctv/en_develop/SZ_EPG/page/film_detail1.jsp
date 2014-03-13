<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>高清电影详情-上海电信应用商城EPG3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<style type="text/css">
<!--
	body{ background:url(../images/bg01.jpg) no-repeat;}
-->


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
</style>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="util/save_focus.jsp"%>
<%@ include file="datajsp/film_detaildata.jsp"%>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
var area0,area1,area2;
var areaid=0,indexid=0;
var begintime = '-1';
var endtime = '-1';
var isbookmark = undefined;
window.onload = function(){	
	area0=AreaCreator(1,2,new Array(-1,-1,-1,1),"area0_list_","className:item item_focus","className:item");
	//area0.doms[0].mylink = "../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&PROGID="+<%=vodid%>+"&returnurl="+escape(location.href);
	area0.doms[1].mylink = returnurl;
	area1=AreaCreator(1,1,new Array(-1,0,-1,-1),"area1_list_","className:item item_focus","className:item");
	area1.stablemoveindex=new Array(-1,"0-1",-1,-1);
	area1.doms[0].domOkEvent=function(){
		getAJAXData("check/page/check_subscribe.jsp?VODID=<%=vodid%>&FATHERID=<%=vodid%>&SUBJECTID=<%=typeid%>&CONTENTTYPE="+ datalist[0].CONTENTTYPE+"&BUSINESSTYPE=1&PLAYTYPE=1",checksubscribe);
	};
	area0.doms[0].domOkEvent=function(){
		getAJAXData("check/page/check_subscribe.jsp?VODID=<%=vodid%>&FATHERID=<%=vodid%>&SUBJECTID=<%=typeid%>&CONTENTTYPE="+ datalist[0].CONTENTTYPE+"&BUSINESSTYPE=1&PLAYTYPE=1",checksubscribe);
	};
	
	
	
	//书签
	   area2 = AreaCreator(1,2,new Array(-1,-1,-1,-1),"div_tip","className:on","className:");
	   area2.doms[0].domOkEvent = function(){
		   location.href = "../../au_PlayFilm.jsp?PROGID=<%=vodid%>&PLAYTYPE=6&CONTENTTYPE=0&BUSINESSTYPE=1&BEGINTIME="+begintime+"&ENDTIME="+endtime+"&returnurl="+escape(location.href);
	   
	   }
	   area2.doms[1].domOkEvent = function(){
		   location.href = "../../au_PlayFilm.jsp?PROGID=<%=vodid%>&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&returnurl="+escape(location.href);
			popup0.closeme();
	   }
	   var popup0 = new Popup("div_tip",new Array(area2));
	   popup0.goBackEvent=function()
	   {
		   this.closeme();
	   }
	   
	pageobj = new PageObj(areaid,indexid,new Array(area0,area1,area2),new Array(popup0));
	pageobj.goBackEvent = function(){
		window.location.href = returnurl;
	}
	initData();
}



function checksubscribe(jsonResult)
{
	
      
	var jsonResult = eval('('+jsonResult+')');
	
	
	if(jsonResult.ALLOWPLAY==false)
	{
	   //更换被动订购购买页面地址为半价特惠包页面
	   var playname="au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&PROGID="+<%=vodid%>+"&returnurl="+escape(location.href);
	   var pageName="check/page/once-buy.jsp?SUBJECTID=<%=typeid%>&VODID=<%=vodid%>&FATHERID=<%=vodid%>&PLAYTYPE=1&CONTENTTYPE="+datalist[0].CONTENTTYPE+"&BUSINESSTYPE=1&returnurl="+escape(location.href)+"&playurl="+escape(playname);
		location.href = pageName;
	}
	else
	{     getAJAXData("../../datajsp/check_bookmark.jsp?vodid=<%=vodid%>",checkBookmark);
		//window.location.href = "../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&PROGID="+<%=vodid%>+"&returnurl="+escape(location.href);
	}
}


function initData(){
	var filmName = datalist[0].VODNAME;
	var filmDirector = datalist[0].DIRECTOR;
	var filmActor = datalist[0].ACTOR;
	var filmIntroduce = datalist[0].INTRODUCE;
	var filmPoster = datalist[0].PICURL;
	
	$('filmName').innerHTML = filmName;
	if(filmDirector!=""&&filmDirector!=null&&filmDirector!='null'&filmDirector!="null"&filmDirector!=undefined){
		$('filmInfo0').innerHTML = '<span>导演：</span>'+filmDirector;
		$('filmInfo1').innerHTML = '<span>演员：</span>'+filmActor;
	}else{
		$('filmInfo0').style.visibility = "hidden";
		$('filmInfo1').style.visibility = "hidden";
		$('filmInfo2').style.top = "43px";
		$('filmInfo3').style.top = "79px";
	}
	if(filmIntroduce.length>=135){
		$('filmInfo3').innerHTML = filmIntroduce.substring(0,135)+"...";
	}else{
		$('filmInfo3').innerHTML = filmIntroduce;
	}
	
	$('typeName').innerHTML = typeName.substring(0,2)+"<span>"+typeName.substring(2)+"</span>";
	$('poster').src = filmPoster;
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
				window.location.href = "../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&PROGID=<%=vodid%>"+"&returnurl="+escape(location.href);
			}
	   }
   }
</script>
</head>

<body>

<!--head-->
<div class="logo">
	<div class="pic"><img src="../images/logo.png" /></div>
	<div id="typeName" class="txt txt-b">&nbsp;<span>影院</span></div>
</div>
<!--head the end-->	


<!--left list-->	
	<!--info-->
	<div class="details">
		<div id="filmName" class="txt txt-title">那些年我们一起追的女孩</div>
		<div class="pic" style="top:35px;"><img src="../images/line.png" /></div>
		<div id="filmInfo0" class="txt txt-info" style="top:43px;visibility: visible;"><span>导演：</span></div>
		<div id="filmInfo1" class="txt txt-info" style="top:79px;visibility: visible;"><span>演员：</span></div>
		<div id="filmInfo2" class="txt txt-info" style="top:115px;"><span>简介：</span></div>
		<div id="filmInfo3" class="txt txt-info" style="top:151px;"></div>
	</div>
	
<!--left list the end-->	

	
<!--r poster-->	
<div class="poster-d">
	<!--焦点 
		class="item item_focus"
	-->
	<div id="area1_list_0" class="item">
		<div class="pic"><img id="poster"/></div>
	</div>
</div>
<!--r poster the end-->		
	
	
	
<!--menu-->	
<div id="area0_list" class="menu" style="left:78px;">
	<!--焦点 
			class="item item_focus"
		-->
	<div id="area0_list_0" class="item item_focus">
		<div class="icon icon08"></div>
		<div class="txt">播放</div>
	</div>
	<div id="area0_list_1" class="item" style="left:111px;">
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
