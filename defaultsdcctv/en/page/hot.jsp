<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视深圳标清 改版EPG2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/style2.css" />
<style type="text/css">
body {
    background: #0d4764 url("../images/bg.jpg") no-repeat;
}
</style>
<%@ include file="util/save_focus.jsp"%>
<%@ include file="datajsp/new-catelist_data.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
if (typeof(iPanel) != 'undefined'){iPanel.focusWidth = "2";iPanel.defaultFocusColor = "#FCFF05";}
var area0,area1,area2,area3;
var areaid=0;
var indexid=0;
window.onload = function(){
	area0=AreaCreator(10,1,new Array(-1,-1,-1,1),"area0_list_","afocus","ablur");
	area0.stablemoveindex=new Array(-1,-1,-1,"0-0,1-0,2-0,3-0,4-0,5-0,6-0,7-2>0,8-2>2,9-2>4");
	var catelist = [{txt:'同步首播',id:'00000100000000090000000000018164'},{txt:'韩剧专场',id:'00000100000000090000000000018300'},{txt:'港台剧场',id:'00000100000000090000000000018165'},{txt:'海外剧场',id:'00000100000000090000000000018453'},{txt:'谍战动作',id:'00000100000000090000000000018167'},{txt:'家庭伦理',id:'00000100000000090000000000018168'},{txt:'军旅革命',id:'00000100000000090000000000018169'},{txt:'都市爱情',id:'00000100000000090000000000018166'},{txt:'古装历史',id:'00000100000000090000000000018170'},{txt:'华数热剧',id:'00000100000000090000000000018391'}];
	var pcatename = "电视剧场";
	for(var i=0;i<catelist.length;i++){
		var txtObj = $("area0_txt_"+i);
		if(txtObj!=undefined)
			txtObj.innerHTML = catelist[i].txt;
		var catename = pcatename + "-" + catelist[i].txt;
		area0.doms[i].mylink="vod_cate_turnpager.jsp?typeid="+catelist[i].id+"&catename="+escape(catename)+"&returnurl="+location.href;
	}
	$('catename').innerHTML = '热剧';

	area1=AreaCreator(1,3,new Array(-1,0,2,-1),"area1_list_","afocus","ablur");
	for(i=0;i<area1.doms.length;i++) {
		area1.doms[i].contentdom=$("area1_txt_"+i);
		area1.doms[i].imgdom=$("area1_img_"+i);
	}
	bindRecommData(jRecommlist);
	area1.stablemoveindex=new Array(-1,-1,"0-0,1-3>0,2-3>1",-1);
	area2=AreaCreator(5,1,new Array(1,0,-1,3),"area2_list_","afocus","ablur");
	area2.stablemoveindex=new Array(-1,"0-7,1-7,2-8,3-9,4-9",-1,-1);
	for(i=0;i<area2.doms.length;i++) {
		area2.doms[i].contentdom=$("area2_txt_"+i);
	}
	bindRankData(jRanklist);
	area3=AreaCreator(1,2,new Array(1,2,-1,-1),"area3_list_","afocus","ablur");
	area3.stablemoveindex=new Array("0-1,1-2",-1,-1,-1);
	for(i=0;i<area3.doms.length;i++) {
		area3.doms[i].imgdom=$("area3_img_"+i);
	}
	bindTopicData(jTopiclist);

	if(focusObj!=undefined&&focusObj!="null"){
		areaid = parseInt(focusObj[0].areaid);
		indexid = parseInt(focusObj[0].curindex);
	}
    pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0,new Array(area0,area1,area2,area3));
	pageobj.backurl=returnurl;
	pageobj.pageOkEvent=function(){
	   saveFocstr(pageobj);      
    }
}

</script>
</head>
<body>
<!--<div class="pagebg"><img src="../images/bg.jpg" width="640" height="530" /></div>-->

<div class="wrapper">
	<!--head-->
	<div id="catename" class="txt txt-headline"></div>
	<!--the end-->
	

	<!--leftcol-->
	<div class="sub">
		<div class="item" style="top:27px;">
			<div class="link"><a href="#" id="area0_list_0"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_txt_0"></div>
		</div>
	</div>
	
		<div class="menu">
		<div class="item">
			<div class="link"><a href="#" id="area0_list_1"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_txt_1"></div>
		</div>
		<div class="pic" style="top:30px;"><img src="../images/line.png" /></div>
		<div class="item" style="top:31px;">
			<div class="link"><a href="#" id="area0_list_2"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_txt_2"></div>
		</div>
		<div class="pic" style="top:61px;"><img src="../images/line.png" /></div>
		<div class="item" style="top:62px;">
			<div class="link"><a href="#" id="area0_list_3"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_txt_3"></div>
		</div>
		<div class="pic" style="top:92px;"><img src="../images/line.png" /></div>
		<div class="item" style="top:93px;">
			<div class="link"><a href="#" id="area0_list_4"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_txt_4"></div>
		</div>
		<div class="pic" style="top:123px;"><img src="../images/line.png" /></div>
		<div class="item" style="top:124px;">
			<div class="link"><a href="#" id="area0_list_5"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_txt_5"></div>
		</div>
		<div class="pic" style="top:154px;"><img src="../images/line.png" /></div>
		<div class="item" style="top:155px;">
			<div class="link"><a href="#" id="area0_list_6"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_txt_6"></div>
		</div>
		<div class="pic" style="top:185px;"><img src="../images/line.png" /></div>
		<div class="item" style="top:186px;">
			<div class="link"><a href="#" id="area0_list_7"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_txt_7"></div>
		</div>
		<div class="pic" style="top:216px;"><img src="../images/line.png" /></div>
		<div class="item" style="top:217px;">
			<div class="link"><a href="#" id="area0_list_8"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area0_txt_8"></div>
		</div>
	</div>
	<!--the end-->
	<div class="btn-left" style="top:455px;">
		<div class="btn"><a href="#" id="area0_list_9"><img src="../images/btn-hot.png" /></a></div>
	</div>
	<!--the end-->
	
	
	<!--rightcol-->
	<div class="list">
		<div class="item">
			<div class="pic"><a href="#" id="area1_list_0"><img id="area1_img_0" width="118" height="163" src="#" /></a></div>
			<div class="txt txt01" id="area1_txt_0"></div>
		</div>
		<div class="item" style="left:160px;">
			<div class="pic"><a href="#" id="area1_list_1"><img id="area1_img_1" width="118" height="163" src="#" /></a></div>
			<div class="txt txt01" id="area1_txt_1"></div>
		</div>
		<div class="item" style="left:320px;">
			<div class="pic"><a href="#" id="area1_list_2"><img id="area1_img_2" width="118" height="163" src="#" /></a></div>
			<div class="txt txt01" id="area1_txt_2"></div>
		</div>
	</div>
	
	<div class="r-top">
		<div class="txt title">排行榜</div>
		<div class="item" style="top:38px;">
			<div class="link"><a href="#" id="area2_list_0"><img src="../images/t.gif" /></a></div>
			<div class="txt-wrap">
				<div class="txt num">1.</div>
				<div class="txt txtt" id="area2_txt_0"></div>
			</div>
		</div>
		<div class="item" style="top:62px;">
			<div class="link"><a href="#" id="area2_list_1"><img src="../images/t.gif" /></a></div>
			<div class="txt-wrap">
				<div class="txt num">2.</div>
				<div class="txt txtt" id="area2_txt_1"></div>
			</div>
		</div>
		<div class="item" style="top:86px;">
			<div class="link"><a href="#" id="area2_list_2"><img src="../images/t.gif" /></a></div>
			<div class="txt-wrap">
				<div class="txt num">3.</div>
				<div class="txt txtt" id="area2_txt_2"></div>
			</div>
		</div>
		<div class="item" style="top:110px;">
			<div class="link"><a href="#" id="area2_list_3"><img src="../images/t.gif" /></a></div>
			<div class="txt-wrap">
				<div class="txt num">4.</div>
				<div class="txt txtt" id="area2_txt_3"></div>
			</div>
		</div>
		<div class="item" style="top:134px;">
			<div class="link"><a href="#" id="area2_list_4"><img src="../images/t.gif" /></a></div>
			<div class="txt-wrap">
				<div class="txt num">5.</div>
				<div class="txt txtt" id="area2_txt_4"></div>
			</div>
		</div>
	</div>
	
	<div class="recommend">
		<div class="txt title">热剧专题</div>
		<div class="item">
			<div class="pic"><a href="#" id="area3_list_0"><img id="area3_img_0" width="120" height="80" src="#" /></a></div>
		</div>
		<div class="item" style="left:160px;">
			<div class="pic"><a href="#" id="area3_list_1"><img id="area3_img_1" width="120" height="80" src="#" /></a></div>
		</div>
	</div>
	<!--the end-->
	
</div>	

</body>
</html>
