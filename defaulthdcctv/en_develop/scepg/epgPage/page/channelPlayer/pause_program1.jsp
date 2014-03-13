<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>选集- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<!--<link type="text/css" rel="stylesheet" href="../../css/style.css" />-->
<style>
.popup-side {
	background:url(../../images/side-bg.png) no-repeat;
	left: 960px;
	position: absolute;
	top: 0;
	height: 720px;
    width: 320px;
}
.popup-side .txt-all {
	position: absolute;
	font-size: 30px;
	left:40px;
	top:90px;
	width: 270px;
}
.tv-sub {
	left: 31px;
	position: absolute; 
	top: 12px; 
}
.tv-sub .item  {
	position: absolute; 
	color: #d1d1d1;
	font-size: 30px;
	line-height:30px;
	height: 30px;
	width: 90px;
	top:-9px;
}
.tv-sub .item_focus {
	position: absolute; 
	color: #f18c09;
}
.tv-num02 {
	left: 32px;
	position: absolute; 
	top: 179px;
}
.tv-num02 .item  {
	background: url(../../images/num-bg02.png) no-repeat;
	color:#afadad;
	font-size: 30px;
	line-height: 70px;
	text-align: center;
	height: 70px;
	width: 70px;
	position: absolute;
}
.tv-num02 .item_focus {
	background: url(../../images/num-bg02_focus.png) no-repeat;
	color:#e5e4e4;
	font-size: 36px;
	font-weight:bold;
	position: absolute;
}
</style>
<script type="text/javascript" src="../../js/pagecontrol_1.0.4.js"></script>
<script type="text/javascript">
	var area0;
	var mp = parent.mp;
	window.onload = function(){
		window.focus();
	    pageInit();
	}
	function pageInit(){
		area0 = AreaCreator(1,1,new Array(-1,-1,-1,-1),"area0_list_","className:btn","className:btn");
		area0.areaOkEvent = function(){
			mp.resume();
			window.location.href = "blank.jsp";
		}
		pageobj = new PageObj(0,0,new Array(area0));
		pageobj.goBackEvent = function(){
			mp.resume();
			window.location.href = "blank.jsp";
		}
	}
</script>
</head>

<body bgcolor="transparent">

<!--btns-->
<!--<div class="btn" style="left:263px; top:212px; z-index:5;"><img src="../../images/btn-play.png" alt="播放" /></div>-->
<div class="btn" id="area0_list_0" style="left:570px; top:290px;position: absolute;"><img src="../../images/btn-pause.png" alt="暂停" /></div>
<!--btns the end-->
</body>
</html>
