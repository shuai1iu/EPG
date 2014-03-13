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
	var area0,area1;
	var totalSubVod = parent.totalSubVod;
	var mp = parent.mp;
	var subVodList=parent.subVodList;
	window.onload = function(){
		window.focus();
		pageInit();
	}
	
	function pageInit(){
		area0 = AreaCreator(1,2,new Array(-1,-1,1,-1),"area0_list_","className:item item_focus","className:item");
		area0.pagecount = Math.ceil(totalSubVod/30)==0?1:Math.ceil(totalSubVod/30);
		area0.broadwiseCrossturnpage = true;
		area0.areaPageTurnEvent = function(){
		area0.datanum = 2;
			var num_1 = (area0.curpage-1)*30+1;
			var num_2 = (area0.curpage-1)*30+15;
			var num_3 = (area0.curpage-1)*30+16;
			var num_4 = ((area0.curpage-1)*30+30)>totalSubVod?totalSubVod:((area0.curpage-1)*30+30);
			$("area0_list_0").innerHTML = num_1+"-"+num_2;
			if(num_3 == num_4){
				$("area0_list_1").innerHTML = num_3+"";
			}else if(num_3 > num_4){
				$("area0_list_1").innerHTML = "";
				area0.datanum = 1;
			}else{
				$("area0_list_1").innerHTML = num_3+"-"+num_4;
			}
		}
		area0.areaOkEvent = function(){
			var num;
			for(i=0;i<15;i++){
				num = ((area0.curpage-1)*2+area0.curindex)*15+i+1;
				$("area1_list_"+i).innerHTML = num;
				if(num > totalSubVod){
					$("area1_list_"+i).style.visibility = "hidden";
				}else{
					$("area1_list_"+i).style.visibility = "visible";
				}
			}
		}
		area1 = AreaCreator(5,3,new Array(0,-1,-1,-1),"area1_list_","className:item item_focus","className:item");
		area1.areaOkEvent = function(){
			var indexNum = parseInt($("area1_list_"+area1.curindex).innerHTML)-1;
			parent.getSubPlayUrl(indexNum,parent.vodInfoData.subVodList[indexNum].programCode,parent.vodInfoData.subVodList[indexNum].contentCode);
		}
		pageobj = new PageObj(0,0,new Array(area0,area1));
		pageobj.goBackEvent = function(){
			mp.resume();
			window.location.href = "blank.jsp";
		}
		$("totalVod").innerHTML="选集(共"+totalSubVod+")";
	
	}
</script>
</head>

<body bgcolor="transparent">

<!--btns-->
<!--<div class="btn" style="left:263px; top:212px; z-index:5;"><img src="../../images/btn-play.png" alt="播放" /></div>-->
<div class="btn" style="left:570px; top:290px;position: absolute;"><img src="../../images/btn-pause.png" alt="暂停" /></div>
<!--btns the end-->



<!--popup side-->
<div class="popup-side">
	<div class="txt-all" style="color:#FFF" id="totalVod">选集(共30集)</div>
	<div class="tv-sub" style="left:40px; top:137px;">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area0_list_0">1-15</div>
		<div class="item" style=" left:90px;" id="area0_list_1">16-30</div>
	</div>
	
	<div class="tv-num02">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area1_list_0">1</div>
		<div class="item" style="left:65px;" id="area1_list_1">2</div>
		<div class="item" style="left:130px;" id="area1_list_2">3</div>
				
		<div class="item" style="top:65px;" id="area1_list_3">4</div>
		<div class="item" style="left:65px;top:65px;" id="area1_list_4">5</div>
		<div class="item" style="left:130px;top:65px;" id="area1_list_5">6</div>
				
		<div class="item" style="top:130px;" id="area1_list_6">7</div>
		<div class="item" style="left:65px;top:130px;" id="area1_list_7">8</div>
		<div class="item" style="left:130px;top:130px;" id="area1_list_8">9</div>
				
		<div class="item" style="top:195px;" id="area1_list_9">10</div>
		<div class="item" style="left:65px;top:195px;" id="area1_list_10">11</div>
		<div class="item" style="left:130px;top:195px;" id="area1_list_11">12</div>
				
		<div class="item" style="top:260px;" id="area1_list_12">13</div>
		<div class="item" style="left:65px;top:260px;" id="area1_list_13">14</div>
		<div class="item" style="left:130px;top:260px;" id="area1_list_14">15</div>
	</div>
	
</div>
<!--popup side the end-->


</body>
</html>
