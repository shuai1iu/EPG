<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="keyboard/keydefine.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>高清轮播-深圳IP电视高清专区EPG3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<style type="text/css">
<!--
	body{ background:url(../images/bg03.gif) no-repeat;}
-->
</style>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<%@ include file="datajsp/round-broadcast-data.jsp"%>
<%@ include file="util/save_focus.jsp"%>
<script type="text/javascript">
	var area0,area1,area2,area3,area4;
	var areaid = <%=curareaid%>;
	var indexid = <%=curindex%>;
	var curpage=<%=curpage%>;
	var returnurl="<%=returnurl%>";
	var tempChannelList=new Array();
	var volumeDivIsShow = false;//音量层
	var voiceIsShow=false;
	var volume = 20;
	var bottomTimer = "";
	var mp = new MediaPlayer();
	
function initMediaPlay()
{
	var instanceId = mp.getNativePlayerInstanceID();
	var playListFlag = 0;
	var videoDisplayMode = 1,useNativeUIFlag = 1;
	var height = 460,width = 865,left = 370,top = 145;
	var muteFlag = 0;
	var subtitleFlag = 0;
	var videoAlpha = 0;
	var cycleFlag = 0;
	var randomFlag = 0;
	var autoDelFlag = 0;
	mp.initMediaPlayer(instanceId,playListFlag,videoDisplayMode,height,width,left,top,muteFlag,useNativeUIFlag,subtitleFlag,videoAlpha,cycleFlag,randomFlag,autoDelFlag);
	//mp.setSingleMedia(mediaStr); //设置媒体播放器播放媒体内容
	mp.setAllowTrickmodeFlag(0); //设置是否允许trick操作。 0:允许 1：不允许
	mp.setNativeUIFlag(0); //播放器是否显示缺省的Native UI，  0:允许 1：不允许
	mp.setAudioTrackUIFlag(1);//设置音轨的本地UI显示标志 0:不允许 1：允许
	mp.setMuteUIFlag(1); //设置静音的本地UI显示标志 0:不允许 1：允许
	mp.setAudioVolumeUIFlag(1);//设置音量调节本地UI的显示标志 0:不允许 1：允许
	mp.setVideoDisplayArea(370, 145, 865, 460);//全屏显示*/
	mp.setVideoDisplayMode(0); //1:全屏显示
	mp.setCycleFlag(1);
	mp.refreshVideoDisplay(); //调整视频显示，需要上面两函数配合 
}
function playChannel(lastChan){
	mp.joinChannel(lastChan);

}
function destoryMP(){
	var instanceId = mp.getNativePlayerInstanceID();
	mp.stop();
	mp.releaseMediaPlayer(instanceId);
}
	//音量控制
function volumeUp()
{
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){mp.setMuteFlag(0);}
	if(voiceIsShow){hideMute();}
	volume = mp.getVolume(); 
	volume += 5;
	if(volume > 100){volume = 100;}
	mp.setVolume(volume);  
	if(mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
	{
		if(bottomTimer){clearTimeout(bottomTimer);}
		genVolumeTable(volume);
		bottomTimer = setTimeout(hideBottom, 5000);
	}
}
function hideBottom()
{
	$("bottomframe").innerHTML = "";
	volumeDivIsShow = false;
}
function genVolumeTable(volume)
{
	var tableDef = '<table width="850px" border="0" cellpadding="0" cellspacing="0"><tr>';
	volume = parseInt(volume / 5);
	for (i = 0; i < 40; i++)
	{
		if (i % 2 == 0)
		{
			tableDef += '<td width="12" height="30"></td>';
		}
		else
		{
			if ( i / 2 < volume)
			{
				tableDef += '<td width="15" height="35"><img src="images/playerimages/sound_focus.jpg" width="15" height="35" /></td>';
			}
			else
			{
				tableDef += '<td width="15" height="35"><img src="images/playerimages/sound.jpg" width="15" height="35" /></td>';
			}
		}
	}
	tableDef += '<td width="20px"></td><td width="40px"><img src="images/playerimages/volume.gif"></td><td width="40px" style="color:white;font-size:28">' + volume + '</td>';
	tableDef += '</tr></table>'; 
	$("bottomframe").innerHTML = tableDef;    	
}
function volumeDown()
{	
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){mp.setMuteFlag(0);}
	if(voiceIsShow){hideMute();}
	volume = mp.getVolume();
	volume -= 5;	
	if(volume < 0){volume = 0;}
	mp.setVolume(volume);  
	if(mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
	{
		clearTimeout(bottomTimer);
		bottomTimer = "";
		genVolumeTable(volume);
		bottomTimer = setTimeout(hideBottom, 5000);
	}
}

function setMuteFlag()
{
	if(bottomTimer){clearTimeout(bottomTimer);}
	voiceIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){
		mp.setMuteFlag(0);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
		{
			$("voice").src="images/playcontrol/playChannel/muteoff.png";
			bottomTimer = setTimeout(hideMute, 5000);
		}
	}else{
		mp.setMuteFlag(1);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
		{
			$("voice").src="images/playcontrol/playChannel/muteon.png";
		}
	} 
	if(volumeDivIsShow){hideBottom();}    
}
function hideMute()
{
	$("voice").src = "#";
	voiceIsShow = false;
}
	
	window.onload = function(){	
		if(channelpagecount > 1){
			area3=AreaCreator(1,2,new Array(-1,-1,1,0), "area3_list_","className:item item_focus","className:item");
			area4=AreaCreator(1,2,new Array(1,-1,-1,2), "area4_list_","className:item item_focus","className:item");
			area4.stablemoveindex=new Array("0-9,1-9,2-9",-1,-1,-1);
			
			area3.doms[1].domOkEvent=function(){
			if((curpage-1)<1){
				curpage=channelpagecount;
				tempChannelList=getItmsByPage(channelList,curpage,10);
				initChannelData(tempChannelList);
				}else{
					curpage=curpage-1;
					tempChannelList=getItmsByPage(channelList,curpage,10);
					initChannelData(tempChannelList);
					}
		};
			area3.doms[0].domOkEvent=function(){
				 if((curpage+1)>channelpagecount){
					 curpage = 1;
					 tempChannelList=getItmsByPage(channelList,curpage,10);
					 initChannelData(tempChannelList);
					 }else{
						 curpage=curpage+1;
						 tempChannelList=getItmsByPage(channelList,curpage,10);
						 initChannelData(tempChannelList);
						 }
				 
			};
			area4.doms[1].domOkEvent=function(){
				if((curpage-1)<1){
					curpage=channelpagecount;
					tempChannelList=getItmsByPage(channelList,curpage,10);
					initChannelData(tempChannelList);
					}else{
						curpage=curpage-1;
						tempChannelList=getItmsByPage(channelList,curpage,10);
						initChannelData(tempChannelList);
						}
			};
			area4.doms[0].domOkEvent=function(){
			 if((curpage+1)>channelpagecount){
				 curpage = 1;
				 tempChannelList=getItmsByPage(channelList,curpage,10);
				 initChannelData(tempChannelList);
				 }else{
					 curpage=curpage+1;
					 tempChannelList=getItmsByPage(channelList,curpage,10);
					 initChannelData(tempChannelList);
					 }
		};
		
			}
		area1=AreaCreator(10,1,new Array(0,-1,2,-1), "area1_list_","className:item item_focus","className:item");
		area0=AreaCreator(1,1,new Array(-1,3,1,-1), "area0_list_","className:item item_focus","className:item");
		area0.stablemoveindex=new Array(-1,"0-1",-1,-1);
		
		area2=AreaCreator(1,1,new Array(1,4,-1,-1), "area2_list_","className:item item_focus","className:item");
		area2.stablemoveindex=new Array("0-9,1-9,2-9","0-1",-1,-1);
		
		for(var i=0;i<area1.doms.length;i++){
		   area1.doms[i].contentdom = $("area1_name_"+i);
		}
		
		if(channelpagecount > 1){
			pageobj = new PageObj(areaid!=null?parseInt(areaid):1,indexid!=null?parseInt(indexid):0, new Array(area0, area1, area2, area3, area4));
			}else{
				pageobj = new PageObj(areaid!=null?parseInt(areaid):1,indexid!=null?parseInt(indexid):0, new Array(area0, area1, area2));
				$("prev").src = "../images/icon-prev-gray.png";
				$("prev2").src = "../images/icon-prev-gray.png";
				$("next").src = "../images/icon-next-gray.png";
				$("next2").src = "../images/icon-next-gray.png";
				}
		
		pageobj.backurl = returnurl;
		pageobj.pageVolChangeEvent = function(num){
			if(num == 1){
				volumeUp();
				}else{
					volumeDown();
					}
		};
		pageobj.pageSetMuteFlagEvent = function(){
			setMuteFlag();
			}
		area0.doms[0].domOkEvent=function(){
			 window.location.href = returnurl;
		};
		area2.doms[0].domOkEvent=function(){
			 window.location.href = returnurl;
		};
			//area2分页
		area1.pageTurn = function(num){
			if(channelpagecount <= 1){return;}
			if(num == 1){
				if((curpage+1)>channelpagecount){
					 curpage = 1;
					 tempChannelList=getItmsByPage(channelList,curpage,10);
					 initChannelData(tempChannelList);
				 }else{
					 curpage=curpage+1;
					 tempChannelList=getItmsByPage(channelList,curpage,10);
					 initChannelData(tempChannelList);
					 }
			}else if(num == -1){
				if((curpage-1)<1){
					curpage=channelpagecount;
					tempChannelList=getItmsByPage(channelList,curpage,10);
					initChannelData(tempChannelList);
				}else{
					curpage=curpage-1;
					tempChannelList=getItmsByPage(channelList,curpage,10);
					initChannelData(tempChannelList);
					}
			}
		 };
	 
		initPage();
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
	 function initPage(){
		 if(channelpagecount <= 1){
				$("area3_list_0").className = "item item_lost";
				$("area3_list_1").className = "item item_lost";
				$("area4_list_0").className = "item item_lost";
				$("area4_list_1").className = "item item_lost";
				}
		 initMediaPlay();
		 tempChannelList=getItmsByPage(channelList,curpage,10);
		 initChannelData(tempChannelList);
	}
	  //初始化直播频道列表
	function initChannelData(datachannel){
		area1.datanum = datachannel.length;
		playChannel(parseInt(datachannel[area1.curindex].UserChannelID)-1000);
		for(var i=0;i<area1.doms.length;i++){
			if(datachannel[i] != null){
				$("area1_list_"+i).style.display = "block";
				area1.doms[i].setcontent("",datachannel[i].ChannelName,20,true,true);
				area1.doms[i].youwannauseobj=datachannel[i].ChannelID;
				area1.doms[i].focusEvent=function(){
					   playChannel(parseInt(datachannel[area1.curindex].UserChannelID)-1000);
					};
				area1.doms[i].domOkEvent=function(){
					var channelNum = parseInt(datachannel[area1.curindex].UserChannelID)-1000;
					var tempURL = null;
					if(location.href.indexOf('?')==-1){
						tempURL = location.href + "?curpage=" + curpage + "&curindex=" + area1.curindex;
						}else{
							var tUrl = location.href.substring(0,location.href.indexOf('?'));
							tempURL = tUrl + "?curpage=" + curpage + "&curindex=" + area1.curindex;
							}
					
					window.location.href = "play_ControlChannel.jsp?CHANNELNUM="+ channelNum +"&COMEFROMFLAG=1&ISSUB=1&returnurl="+escape(tempURL);
						   }
				}else{
					$("area1_list_"+i).style.display = "none";
					area1.doms[i].updatecontent("");
					}
			}
			$("pageContent").innerHTML = curpage+"/"+channelpagecount;
			$("pageContent2").innerHTML = curpage+"/"+channelpagecount;
	
	}
</script>
</head>

<body onunload="destoryMP()" style="background-color:transparent;">

<!--head-->
<div class="logo">
	<div class="pic"><img src="../images/logo.png" /></div>
	<div class="txt txt-b">高清&nbsp;<span>轮播</span></div>
</div>

<div class="adfont"><img src="../images/adfont.png" /></div>
<!--head the end-->	


<!--left list-->	
	<!--pages-->
	<div class="pages-b">
		<!--焦点 
			class="item item_focus"
		-->
		<div class="p01">
			<div id="area3_list_0" class="item">
				<div class="icon"><img id="next" src="../images/icon-next.png" /></div>
				<div class="txt">下 页</div>
			</div>
		</div>
		<div class="p-num">
			<div id="pageContent" class="txt">1/10</div>
		</div>
		<div class="p02">
			<div id="area3_list_1" class="item">
				<div class="icon"><img  id="prev" src="../images/icon-prev.png" /></div>
				<div class="txt">上 页</div>
			</div>
		</div>
		<div class="p03">
			<div id="area0_list_0" class="item">
				<div class="icon"><img src="../images/icon-arrow.png" /></div>
				<div id="backbtn" class="txt">返 回</div>
			</div>
		</div>
	</div>
	
	<!--list-->
	<div class="column-list">
		<!--焦点 
			class="item item_focus"
		-->
		<div class="pic"><img src="../images/line2.png" /></div>
		<div id="area1_list_0" class="item" style="top:1px;">
			<div id="area1_name_0" class="txt">亚洲影院</div>
		</div>
		<div class="pic" style="top:41px;"><img src="../images/line2.png" /></div>
		<div id="area1_list_1" class="item" style="top:42px;">
			<div id="area1_name_1" class="txt">欧美影院</div>
		</div>
		<div class="pic" style="top:82px;"><img src="../images/line2.png" /></div>
		<div id="area1_list_2" class="item" style="top:83px;">
			<div id="area1_name_2" class="txt">欧美影院</div>
		</div>
		<div class="pic" style="top:123px;"><img src="../images/line2.png" /></div>
		<div id="area1_list_3" class="item" style="top:124px;">
			<div id="area1_name_3" class="txt">欧美影院</div>
		</div>
		<div class="pic" style="top:164px;"><img src="../images/line2.png" /></div>
		<div id="area1_list_4" class="item" style="top:165px;">
			<div id="area1_name_4" class="txt">欧美影院</div>
		</div>
		<div class="pic" style="top:205px;"><img src="../images/line2.png" /></div>
		<div id="area1_list_5" class="item" style="top:206px;">
			<div id="area1_name_5" class="txt">欧美影院</div>
		</div>
		<div class="pic" style="top:246px;"><img src="../images/line2.png" /></div>
		<div id="area1_list_6" class="item" style="top:247px;">
			<div id="area1_name_6" class="txt">欧美影院</div>
		</div>
		<div class="pic" style="top:287px;"><img src="../images/line2.png" /></div>
		<div id="area1_list_7" class="item" style="top:288px;">
			<div id="area1_name_7" class="txt">欧美影院</div>
		</div>
		<div class="pic" style="top:328px;"><img src="../images/line2.png" /></div>
		<div id="area1_list_8" class="item" style="top:329px;">
			<div id="area1_name_8" class="txt">欧美影院</div>
		</div>
		<div class="pic" style="top:369px;"><img src="../images/line2.png" /></div>
		<div id="area1_list_9" class="item" style="top:370px;">
			<div id="area1_name_9" class="txt">欧美影院</div>
		</div>
		<div class="pic" style="top:410px;"><img src="../images/line2.png" /></div>
	</div>
	
	<!--pages-->
	<div class="pages-b" style="top:617px;">
		<!--焦点 
			class="item item_focus"
		-->
		<div class="p01">
			<div id="area4_list_0" class="item">
				<div class="icon"><img id="next2" src="../images/icon-next.png" /></div>
				<div class="txt">下 页</div>
			</div>
		</div>
		<div class="p-num">
			<div id="pageContent2" class="txt">1/10</div>
		</div>
		<div class="p02">
			<div id="area4_list_1" class="item">
				<div class="icon"><img id="prev2" src="../images/icon-prev.png" /></div>
				<div class="txt">上 页</div>
			</div>
		</div>
		<div class="p03">
			<div id="area2_list_0" class="item">
				<div class="icon"><img src="../images/icon-arrow.png" /></div>
				<div id="backbtn2" class="txt">返 回</div>
			</div>
		</div>
	</div>
	
<!--left list the end-->	

	
<!--r video-->	
<div class="video">
	<!--焦点 
		class="item item_focus"
	-->
	<div class="item item_focus">
		<div class="link"></div>
		<div class="pic"></div>
		<div id="bottomframe" style="position:absolute; left:15px; top:425px; z-index:9;">
			
		</div>
	</div>
</div>
<!--r video the end-->
<div style="position:absolute; left:30px; top:15px; width:54px; height:66px; z-index:3;"><img id="voice" src="images/dot.gif"/></div>
	
</body>
</html>
