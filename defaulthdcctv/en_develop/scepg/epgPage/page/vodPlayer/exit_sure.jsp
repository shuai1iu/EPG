<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="keyDefine/keydefine.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>节目确认退出- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<!--<link type="text/css" rel="stylesheet" href="../../css/style.css" />-->
<style>
/*.popup {
	background:url(../../images/trans30.png) repeat;
	left: 0;
	position: absolute;
	top: 0;
	height: 720px;
    width: 1280px;
}*/
.popup .conBg02 {
	background:url(../../images/popup-bg02.png) no-repeat;
}
.popup .con {
	left: 375px;
	position: absolute;
	top: 161px;
	height: 290px;
    width: 530px;
}
.popup .con .txt-b{
	left:20px;
	text-align:center;
	width: 490px;
}
.popup .con .txt-b {
	color:#adaaaa;
	font-size:24px;
	top: 172px;
}
.btn-d .item .txt {
	color:#bdbdbb;
	font-size:24px;
	text-align:center;
	top:13px;
	line-height:50px;
	height:50px;
}
.btn-d {
	left: 142px;
	position: absolute;
	top: 45px;
}
.btn-d .item {
	background:url(../../images/btn04.png) no-repeat;
	height:76px;
	width:246px;
}
.btn-d .item .txt {
	position: absolute;
	width:246px;
}
.btn-d .item_focus {
	position: absolute;
	background:url(../../images/btn04_focus.png) no-repeat;
}
.btn-d .item_focus .txt {
	position: absolute;
	color:#e9e9ea;
}
.bottom {
	background:url(../../images/bottom-bg.png) repeat;
	left: 0;
	position: absolute;
	top: 566px;
	height: 154px;
    width: 1280px;
}
</style>

<script type="text/javascript">
	document.onkeypress = keyEvent;
	//document.onkeydown = keyEvent;
	function keyEvent()
	{
		var val = event.which ? event.which : event.keyCode;
		return keypress(val);
	}
	function keypress(keyval){
		switch(keyval){
			case <%=KEY_LEFT%>:
				
				break;
			case <%=KEY_RIGHT%>:
				
				break;
			case <%=KEY_UP%>:		
				 moveUp();
				 break;
			case <%=KEY_DOWN%>:	
				 moveDown();
				 break;
			case <%=KEY_OK%>:
				ok();
				break;
			case <%=KEY_RETURN%>:
				cancel();
				break;
		}
	}
</script>
<script type="text/javascript">
	var mp = parent.mp;
	window.onload = function(){
		
		window.focus();
	};
	
	var curFocus = 0;
	
	function moveUp(){
		if(curFocus==1){
			$("ok").className = "item item_focus";
			$("mark").className = "item";
			curFocus = 0;
		}
	}
	
	function moveDown(){
		if(curFocus==0){
			$("ok").className = "item";
			$("mark").className = "item item_focus";
			curFocus = 1;
		}
	}
	
	function ok(){
		if(curFocus==0){
			parent.goBack();
		}else if(curFocus==1){
			var currentTime = mp.getCurrentPlayTime();
			var totalTime=parseInt(mp.getMediaDuration());  //总时长;
			if(currentTime==undefined)
				currentTime = 0;
			parent.addBookMark(currentTime,totalTime);
		}

	}

	function cancel(){
		mp.resume();
		window.location.href="blank.jsp";
		
	}

	function $(id) {
		return document.getElementById(id);
	}
</script>

</head>

<body bgcolor="transparent">


<!--popup layer-->
<div class="popup">
	<div class="con conBg02">
		<div class="btn-d">
			<!--焦点 
					class="item item_focus"
			-->
			<div class="item item_focus" style="position:absolute" id="ok">
				<div class="txt">结束观看</div>
			</div>
			<div class="item" style="top:70px;position:absolute" id="mark">
				<div class="txt">加入书签并退出</div>
			</div>
		</div>
		<div class="txt txt-b" style="position:absolute;top:240px;">按"返回"键继续观看</div>
	</div>
</div>
<!--popup layer the end-->




<!--bottom-->
<div class="bottom">
	<div style="position:absolute;left:78px;top:18px;"><img src="../../images/demopic/ad-1125X105.jpg" /></div>
</div>
<!--bottom the end-->
	
</body>
</html>
