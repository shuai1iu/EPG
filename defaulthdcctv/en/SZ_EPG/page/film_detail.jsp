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
</style>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="util/save_focus.jsp"%>
<%@ include file="datajsp/film_detaildata.jsp"%>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
var area0,area1;
var areaid=0,indexid=0;

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
	
	pageobj = new PageObj(areaid,indexid,new Array(area0,area1));
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
	   var playname="../../../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&PROGID="+<%=vodid%>+"&returnurl="+escape(location.href);
	   var pageName="check/page/buy.jsp?SUBJECTID=<%=typeid%>&VODID=<%=vodid%>&FATHERID=<%=vodid%>&PLAYTYPE=1&CONTENTTYPE="+datalist[0].CONTENTTYPE+"&BUSINESSTYPE=1&returnurl="+escape(location.href)+"&playurl="+escape(playname);
		location.href = pageName;
	}
	else
	{
		window.location.href = "../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&ISVIP=1&PROGID="+<%=vodid%>+"&returnurl="+escape(location.href);
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

	
</body>
</html>
