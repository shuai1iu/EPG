<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>深圳高清EPG最终版-直播港澳台3 EPG2.0</title>
<meta name="page-view-size" content="640*530" />
<style type="text/css">
/* =S Css Reset
----------------------------------------------- */
body, div, h1, h2, h3, h4, h5, h6, button, input, textarea, th, td { margin:0px; padding:0px; }
body, div, button, input, select, textarea { font-size:20px; font-family: SimHei,sans-serif; line-height: 100%; }
h1, h2, h3, h4, h5, h6 { font-size: 100%; }
a { text-decoration: none; }
fieldset, img { border: 0px; }
button, input, select, textarea { font-size:100%; }

/* =S Global
----------------------------------------------- */
.item, .link, .txt-wrap, .txt, .btn, .icon, .pic, .pic-shade, .num, .win { position:absolute;}
.link { left: 0px; top: 0px; z-index:9;}
.txt { left: 0px; z-index:7;}
.txt-wrap { z-index:6;}
.icon { z-index:5;}
.pic-shade { z-index:4;}
.pic { z-index:3;}
.btn { text-align: center;}
body {
	color: #f1f1f1;
    height: 530px;
    width: 640px;
    /*background: transparent;*/
    overflow: hidden;
    position: relative;
}
.wrapper,.pagebg {
	left: 0px;
	position:absolute;
	top:0;
}
.wrapper {
    height: 530px;
    width: 640px;
	z-index:2;
}
.pagebg {
	z-index:1;
}

/*live----------------------------------------------------*/
.got-hotChannel {
	left:20px;
	position:absolute;
	top:17px;
}
.got-hotChannel .txt-title {
	color:#7cc9e6;
	font-size:20px;
	height:30px;
	line-height:30px;
	text-align:center;
	width:160px;
}
.got-hotChannel .item,
.got-hotChannel .item .pic,
.got-hotChannel .item .pic img {
	height:46px;
    width:112px;
}
.got-hotChannel .item .link {
	height:43px;
    width:111px;
}
.got-hotChannel .item_focus .link {
	background:url(../images/focus-111X43.png) no-repeat;
}
.got-hotChannel .item_select .link {
	background:url(../images/select-111X43.png) no-repeat;
}
.got-hotChannel .item { 
	left:23px;
	top:36px;
}
.got-video {
	left:200px;
	position:absolute;
	top:17px;
}
.got-video .item {
	border:solid 3px #0a3247;
}
.got-video .item,
.got-video .item .pic {
	height:305px;
    width:405px;
}
.got-video .item_focus {
	border:solid 3px #fff200;
}
/*.got-video .item .link {
	height:311px;
    width:411px;
}
.got-video .item_focus .link {
	background:url(../images/focus-411X311.png) no-repeat;
}*/
.got-liveList {
	left:200px;
	position:absolute;
	top:338px;
}
.got-liveList .item,
.got-liveList .item .link,
.got-liveList .item .link img {
   height:32px;
   width:372px;
}
.got-liveList .item {
	background:url(../images/live-listBg.png) no-repeat;
	top:1px;
}
.got-liveList .item .txt {
	font-size:20px;
	height:32px;
	line-height:28px;
	left:12px;
    width:345px;
}
.got-liveList .item .link {
	height:28px;
    width:370px;
}
.got-liveList .item_focus .link {
	background:url(../images/focus-370X28.png) no-repeat;
}
.got-liveList .item_select .link {
	background:url(../images/select-370X28.png) no-repeat;
}
.got-liveList .item_lost .link {
	background:url(../images/lost-370X28.png) no-repeat;
}
.got-page {
	left:572px;
	position:absolute;
	top:338px;
}
.got-page .item .pic {
	left:0;
	height:64px;
    width:41px;
	top:1px;
}
.got-page .item .link {
	height:65px;
    width:42px;
}
.got-page .item_focus .link {
	background:url(../images/focus-42X65.png) no-repeat;
}
.got-page .item_select .link {
	background:url(../images/select-42X65.png) no-repeat;
}
.got-notice {
	left:52px;
	position:absolute;
	top:485px;
}
.got-notice .txt {
	font-size:16px;
	height:32px;
	line-height:32px;
	width:585px;
}
</style>

<%@ include file="util/util_getPosterPaths.jsp"%>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript" src="../js/MediaPlayer.js"></script>
<%@ include file="datajsp/gatlivedata.jsp"%>
<script type="text/javascript">
var area0,area1,area2,area3;

var areaid = <%=curareaid%>;
var indexid = <%=curindex%>;
var curpage=<%=curpage%>;
var returnurl="<%=returnurl%>";
var tempvodlist=new Array();
var playmode="<%=playmode%>";
var playindex=<%=playindex%>;
var curplaypage=<%=curpage%>;
var playvodid='';
var playurl='';
window.onload = function(){	
    area0=AreaCreator(7,1,new Array(-1,-1,-1,1),"area0_list","className:item item_focus","className:item");
	area1=AreaCreator(1,1,new Array(-1,0,2,-1),"area1_list","className:item item_focus","className:item");
	area2=AreaCreator(4,1,new Array(1,0,-1,3), "area2_list","className:item item_focus","className:item");
	area2.stablemoveindex=new Array(-1,"0-0>6,1-0>6,2-0>6,3-0>6",-1,"0-3>0,1-3>0,2-3>1,3-3>1");
	for(var i=0;i<area2.doms.length;i++){
	   area2.doms[i].contentdom = $("area2_txt"+i);
	}
	
	area3=AreaCreator(2,1,new Array(1,2,-1,-1),"area3_list","className:item item_focus","className:item");
	area3.doms[0].domOkEvent=function(){
		 if((curpage-1)<1) return;
		 curpage=curpage-1;
	     tempvodlist=getItmsByPage(voddatalist,curpage,4);
	     initVodData(tempvodlist);
		
	};
	
	area3.doms[1].domOkEvent=function(){
		 if((curpage+1)>vodpagecount) return;
		 curpage=curpage+1;
		 tempvodlist=getItmsByPage(voddatalist,curpage,4);
	     initVodData(tempvodlist);
		
	};
	
	
	pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area0, area1, area2,area3 ));
	pageobj.backurl = returnurl;
	
	
	//area2分页
    area2.pageTurn = function(num){
		if(num == 1){
			 if((curpage+1)>vodpagecount) return;
			 curpage=curpage+1;
			 tempvodlist=getItmsByPage(voddatalist,curpage,4);
	         initVodData(tempvodlist);
		}else if(num == -1){
			 if((curpage-1)<1) return;
			  curpage=curpage-1;
			  tempvodlist=getItmsByPage(voddatalist,curpage,4);
	          initVodData(tempvodlist);
		}
     };
	pageobj.pageOkEvent=function(){
		 if(pageobj.curareaid!=3){
			 var strurl=location.href;
			 if(strurl.indexOf("?")!=-1){
				 strurl=strurl.substring(0,strurl.indexOf("?"));
			 }
			 strurl=strurl+"?playmode="+playmode+"&curpage="+curplaypage+"&curareaid=" +pageobj.curareaid +"&curindex=" +pageobj.areas[pageobj.curareaid].curindex  + "&playindex="+playindex+"&returnurl="+returnurl;
			 if(playmode=="tv"){
				 window.location.href="../../au_PlayFilm.jsp?isfromgat=1&PROGID=" + channelList[playindex].ChannelID + "&PLAYTYPE=2&ISSUB=1&CONTENTTYPE=3&&BUSINESSTYPE=2&ALLOWAD=1&CHANNELNUM="+(channelList[playindex].UserChannelID-1000)+"&COMEFROMFLAG=1&returnurl="+escape(strurl);
			}else{
				window.location.href ="../../au_PlayFilm.jsp?PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&PROGID="+ playvodid  +"&returnurl="+escape(strurl);
			}
		}
	};
   
	 pageobj.pageVolChangeEvent=function(num)
	 {
	   if(num==-1)
			 volumeDown();
	   else if(num==1)
			 volumeUp();
	}
	pageobj.pageSetMuteFlagEvent=setMuteFlag;
	
	pageobj.mediaPlayEndEvent=function(){
		if(playurl!=''){
			 play(playurl);
		}
	};
	
	initPage();
	if(areaid==0 && indexid==0){
		$("area0_list0").className="item item_focus";
	}
  }


function initPage(){
	 tempvodlist=getItmsByPage(voddatalist,curpage,4);
	 initVodData(tempvodlist);
	 initChannelData(channelList);
	 if(playmode=="tvod"){
	     playvodid=tempvodlist[playindex].VODID;
	 }
	 if(playmode=="tv"){
		 playChannel(parseInt(channelList[playindex].UserChannelID)-1000);
	 }else{
		 playurl=tempvodlist[playindex].playurl;
		 play(tempvodlist[playindex].playurl);
	 }
}

//数组分页
function getItmsByPage(cptitms,icurpage,ipagesize){
		var reclist=new Array();
		var start = (icurpage-1)*ipagesize;
		for(var i=0;i<ipagesize&&(i+(icurpage-1)*ipagesize)<cptitms.length;i++){
			 reclist[i]=cptitms[start+i];
		}
		return reclist;
}

//初始化点播节目
function initVodData(datavod){
	if(curpage==vodpagecount){
		$("pageim1").src="../images/btn-next-gray.png";
	}else{
		$("pageim1").src="../images/btn-next.png";
	}
	if(curpage==1){
		$("pageim0").src="../images/btn-prev-gray.png";
	}
	else
	{
		 $("pageim0").src="../images/btn-prev.png";
	}
	
	area2.datanum = datavod.length;
	
	if(area2.datanum<4 && pageobj.curareaid==2){
		area2.curindex=area2.datanum-1;
		$("area2_list"+area2.curindex).className="item item_focus";
	}
		
	if(datavod.length>0){
		for(var i=0;i<area2.doms.length;i++){
			if(i<datavod.length){
				$("area2_list"+i).style.display = "block";
				area2.doms[i].setcontent("",datavod[i].VODNAME,34,true,false);
				area2.doms[i].focusEvent=function(){
				   playindex=area2.curindex;
		           curplaypage=curpage;
		           playvodid=tempvodlist[playindex].VODID;
				   playurl=tempvodlist[area2.curindex].playurl;
		           play(tempvodlist[area2.curindex].playurl);
				};
				
			}else{
				$("area2_list"+i).style.display = "none";
				area2.doms[i].updatecontent("");
			}
		}
	}
}

//初始化直播频道列表
function initChannelData(datachannel){
	area0.datanum = datachannel.length;
	if(datachannel.length>0){
	    for(var i=0;i<area0.doms.length;i++){
			 if(i<datachannel.length)
			 {
				$("area0_list"+i).style.display = "block";
				area0.doms[i].focusEvent=function(){
				   playindex=area0.curindex;
		           curplaypage=1;
				  // $("area2_txt1").innerHTML=channelList[playindex].UserChannelID;
		           playChannel(parseInt(channelList[area0.curindex].UserChannelID)-1000);
				};
			}
			else{
				$("area0_list"+i).style.display = "none";
			}
		}
	}
  
}

function goBack(){
	window.location.href = pageobj.backurl;
}

function closemp(){
	destoryMP();
}

var volumeDivIsShow = false;
var volume = 20;
function volumeUp()
{
	hideVoice();
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1)
	{
		mp.setMuteFlag(0);
	}
	volume = mp.getVolume(); 
	volume += 5;
	if(volume >= 100)
	{
		volume = 100;             
	}
	mp.setVolume(volume);  
	if (mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
	{
		clearTimeout(bottomTimer);
		bottomTimer = "";
		genVolumeTable(volume);
		bottomTimer = setTimeout("hideBottom();", 5000);
	}
}
function volumeDown()
{	
    hideVoice();
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1)
	{
		mp.setMuteFlag(0);
	}
	volume = mp.getVolume();
	volume -= 5;	
	if(volume <= 0)
	{
		volume = 0;    
	}
	mp.setVolume(volume);  
	if (mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
	{
		clearTimeout(bottomTimer);
		bottomTimer = "";
		genVolumeTable(volume);
		bottomTimer = setTimeout("hideBottom();", 5000);
	}
}
function hideBottom()
{
	volumeDivIsShow = false;
	document.getElementById("bottomframe").innerHTML = "";
}
function hideVoice()
{
	document.getElementById("voice").src="images/playcontrol/playChannel/dot.gif";
}
function genVolumeTable(volume)
{
	var tableDef = '<table width="530px" border="0" cellpadding="0" cellspacing="0"><tr>';
	volume = parseInt(volume / 5);
	for (i = 0; i < 40; i++)
	{
		if (i % 2 == 0)
		{
			tableDef += '<td width="12px" height="54px" bgcolor="transparent"></td>';
		}
		else
		{
			if ( i / 2 < volume)
			{
				tableDef += '<td width="12px" height="54px" bgcolor="#00ff00"></td>';
			}
			else
			{
				tableDef += '<td width="12px" height="54px" bgcolor="cccccc"></td>';
			}
		}
	}
	tableDef += '<td width="20px"></td><td width="40px" style="color:white;font-size:28">' + volume + '</td>';
	tableDef += '</tr></table>'; 
	document.getElementById("bottomframe").innerHTML = tableDef;    	
}
function setMuteFlag()
{
	hideBottom();
	clearTimeout(voiceTimer);
	bottomTimer = ""; 
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1)
	{
		mp.setMuteFlag(0);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
		{
		
			document.getElementById("voice").src="images/playcontrol/playChannel/muteoff.png";
			voiceTimer = setTimeout(hideVoice, 5000);
		}
	}
	else
	{
		mp.setMuteFlag(1);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
		{
			
			document.getElementById("voice").src="images/playcontrol/playChannel/muteon.png";
			voiceTimer = setTimeout("hideVoice();", 5000);
		}
	}      
}
</script>
</head>

<body bgcolor="transparent" onunload="destoryMP()">

<!--pagebg-->
<div class="pagebg">
	<div class="pic"><img src="../images/bg-live.gif" width="640" height="530" /></div>
</div>
<!--pagebg the end-->


<div class="wrapper">
	
	<!-- videoList -->
    <div class="got-hotChannel">
		<div class="txt txt-title">热点频道</div>
		<!--
			焦点 class="item item_focus"
			当前选中时  class="item item_select"
		-->
        <div class="item" id="area0_list0">
			<div class="link"></div>
			<div class="pic"><img src="../images/logo-1.png" /></div>
        </div>
		<div class="item" style="top:82px;"  id="area0_list1">
			<div class="link"></div>
			<div class="pic"><img src="../images/logo-2.png" /></div>
        </div>
		<div class="item" style="top:128px;" id="area0_list2">
			<div class="link"></div>
			<div class="pic"><img src="../images/logo-3.png" /></div>
        </div>
		<div class="item" style="top:174px;" id="area0_list3">
			<div class="link"></div>
			<div class="pic"><img src="../images/logo-4.png" /></div>
        </div>
		<div class="item" style="top:220px;" id="area0_list4">
			<div class="link"></div>
			<div class="pic"><img src="../images/logo-5.png" /></div>
        </div>
		<div class="item" style="top:266px;" id="area0_list5">
			<div class="link"></div>
			<div class="pic"><img src="../images/logo-6.png" /></div>
        </div>
		<div class="item" style="top:312px;" id="area0_list6">
			<div class="link"></div>
			<div class="pic"><img src="../images/logo-7.png" /></div>
        </div>


	</div>
	<!-- video the end -->
	
	<div class="pic" style=" left:7px; top:371px;"><img src="../images/gaotlogo.png" /></div>

	
	<!-- video -->
    <div class="got-video">
		<!--
			焦点 class="item item_focus"
		-->
        <div class="item" id="area1_list0">
			<div class="link"></div>
			
		</div>
    </div>
    <!-- video the end -->
	
	
	
	<!-- liveList -->
    <div class="got-liveList">
		<!--
			焦点 class="item item_focus"
			当前选中时  class="item item_select"
		-->
        <div class="item" id="area2_list0">
			<div class="link"></div>
			<div class="txt"  id="area2_txt0"></div>
        </div>
		<div class="item" style="top:34px;"  id="area2_list1">
			<div class="link"></div>
			<div class="txt"  id="area2_txt1"></div>
        </div>
		<div class="item" style="top:69px;"   id="area2_list2">
			<div class="link"></div>
			<div class="txt"  id="area2_txt2"></div>
        </div>
		<div class="item" style="top:103px;"  id="area2_list3">
			<div class="link"></div>
			<div class="txt"  id="area2_txt3"></div>
        </div>
    </div>
	
	
	<div class="got-page">
		<!--
			焦点 class="item item_focus"
		-->
		<div class="item" id="area3_list0">
			<div class="link"></div>
			<div class="pic"><img  id="pageim0" src="../images/btn-prev.png" /></div>
		</div>
		<div class="item" style="top:68px" id="area3_list1">
			<div class="link"></div>
			<div class="pic"><img id="pageim1"  src="../images/btn-next.png" /></div>
		</div>
	</div>
    <!-- liveList the end -->
	
	<!-- notice -->
	<div class="got-notice">
		<div class="txt">选择节目或者视频窗口按确定键，进入全屏播放</div>
	</div>
	<!-- notice the end -->
</div>
<div id="bottomframe" style="position:absolute;left:60px; top:400px; width:530px; height:130px; z-index:3"></div>
<div style="position:absolute; left:560px; top:25px; width:54px; height:66px; z-index:3;">
<img id="voice" src="images/playcontrol/playChannel/dot.gif"/></div>
</body>
</html>
