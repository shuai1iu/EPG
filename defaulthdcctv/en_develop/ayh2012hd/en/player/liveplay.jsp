<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><%@ include file="../common/golbal.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>标清直播</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="<%=static_url%>/css/style.css" />
<link type="text/css" rel="stylesheet" href="<%=static_url%>/css/play.css" />
<script type="text/javascript" src="<%=static_url%>/js/common.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/commonevent.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/mediaPlayerEx.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/ajax_common.js"></script>
<style type="text/css">
<!--
/*play*/
.play-btn {
	height:200px;
	left:267px; 
	position:absolute; 
	top:191px;
	width:108px;
}
.play-btn .icon {
	height:108px;
	left:0; 
	position:absolute; 
	top:0;
	width:108px;
}
.play-btn .xnum {
	font-size:36px;
	left:0; 
	position:absolute; 
	top:115px;
	text-align:center;
	width:108px;
}
.play-page {
	background:url(<%=static_url%>/images/play/bg-play-bottombg.png) repeat-x;
	font-size:20px;
	height:192px;
	left:0; 
	position:absolute; 
	top:338px;
	width:640px;
}
.play-page div {
	left:0; 
	position:absolute; 
	top:0;
}
.play-page .play-bar {
	left:91px; 
	position:absolute; 
	top:7px;
	width:465px;
}
.play-page .play-bar .time{
	background:url(<%=static_url%>/images/play/play-time-bg.png) no-repeat;
	height:30px;
	line-height:23px;
	width:90px;
}
.play-page .play-bar .bar {
	background:url(<%=static_url%>/images/play/play-bar-bg.png) no-repeat;
	height:30px;
	top:30px;
	width:465px;
}
.play-page .play-bar .bar .item {
	height:30px;
	width:26px;
}
.play-page .play-bar .intro {
	top:70px;
}
.play-page .play-bar .intro span { color:#a3a4a7;}
.play-page .operate {
	left:72px; 
	position:absolute; 
	top:127px;
	width:550px;
}
.play-page .operate div {
	height:39px;
	line-height:39px;
}
.play-page .operate .item{
	background:url(<%=static_url%>/images/play/input-bg.png) no-repeat;
	height:39px;
	left:142px;
	width:54px;
}
.play-page .operate .itemon{
	background:url(<%=static_url%>/images/play/input-bgon.png) no-repeat;
}
.play-page .operate .item .txt{
	height:27px;
	line-height:27px;
	left:4px;
	top:4px;
	text-align:center;
	width:42px;
}
-->
</style>
</head>
<body style="background:transparent;" onload="onPageLoad();"  onunload="onPageUnload();">
<%@ include file="../datasource/datasource.jsp"%>
<%@ include file="../datasource/property.jsp"%>
<% DataSource dataSource=new DataSource(request); 
String postertype = "0";//0：海报
String categoryid=request.getParameter("categoryid"); 
String categoryname=request.getParameter("categoryname");
String programid=request.getParameter("id");
EpgResult epgResult=dataSource.getVodInfo(categoryid,categoryname,programid,"-1",postertype);
TblCmsProgram vod=new TblCmsProgram();
   if(epgResult!=null&&epgResult.getResultcode()==0&&epgResult.getDatas()!=null){
	   vod=(TblCmsProgram)epgResult.getOneObject();
   }
%>
<span style="color:red" id="showInfo" style="visibility:hidden"></span>

<!--主动结束播放-->
<div class="play-popup" id="container_handexit"  style="visibility:hidden">
	<div class="btn btn-select">  <!--当前选中为 class="btn btn-select"-->
		<div class="link"><a href="#;" onclick="goBack();"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">结束观看</div>
	</div>
	<div class="btn" style="top:80px;">
		<div class="link"><a href="#;" onclick="cancel()"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">继续观看</div>
	</div>
</div>	
<!--the end-->	 

<!--系统错误-->
<div class="system-error" id="container_playerror" style="visibility:hidden">
	<div class="tit01">
		<div class="icon"><img src="<%=static_url%>/images/icon-pop-notice.png" /></div>
		<div class="txt">视频无法播放!</div>
	</div>
	<div class="tit02">请按返回按钮返回首页</div>
	<div class="tit02" style="top:82px;">如返回首页不成功请与运营商联系</div>
	<div class="btn">
		<div class="link"><a href="index.jsp" ><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">返回首页</div>
	</div>
</div>	
<!--the end-->	


<!--电视剧主动播放结束-->
<div class="play-popup play-popup02" id="container_handexit2" style="visibility:hidden">   <!--当前选中为 class="btn btn-select"-->
	 <!--
	 	class="btn"
	    class="btn btn02"
	    class="btn btn03"
	 -->
	<div class="btn btn02">
		<div class="link"><a href="#"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">上一集</div>
	</div>
	<div class="btn btn03 btn-select" style="left:148px;">
		<div class="link"><a href="#;" onclick="goBack()"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">返回</div>
	</div>
	<div class="btn" style="left:148px;top:80px;">
		<div class="link"><a href="#"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">继续观看</div>
	</div>
	<div class="btn btn02" style="left:288px;">
		<div class="link"><a href="#"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">下一集</div>
	</div>
</div>	
<!--the end-->	


<!--电视剧正常播放结束-->
<div class="play-prompted" id="container_playend2" style="visibility:hidden">
	<div class="tit01">
		<div class="txt">下一集《生活大爆炸》15</div>
	</div>
	<div class="tit02">10秒后自动返回</div>
	<div class="btn btn-select">  <!--当前选中为 class="btn btn-select"-->
		<div class="link"><a href="#"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">播放</div>
	</div>
	<div class="btn" style="left:328px;">
		<div class="link"><a href="#;" onclick="goBack()"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">返回</div>
	</div>
</div>	
<!--the end-->	

<!--节目正常播放结束-->
<div class="play-prompted" id="container_playend" style="visibility:hidden">
	<div class="tit01">
		<div class="txt02">谢谢收看</div>
	</div>
	<div class="tit02">5秒后自动返回</div>
</div>	
<!--the end-->

	
<!--图标-->
	<div class="play-btn" id="container_speed" style="visibility:hidden">
		<div class="icon"><img src="<%=static_url%>/images/play/icon-fast-forward.png" title="快进" id="_currentPic"/></div>
		<div class="xnum" id="_currentSpeed">2x</div>
	</div>
<!--the end-->	
	
<!--图标-->
	<div class="play-btn" id="container_muteflag" style="visibility:hidden">
		<div class="icon"><img src="<%=static_url%>/images/play/icon-mute.png" title="静音" /></div>-->
	</div>
<!--the end-->			
	
<!--play-->
<div class="play-page" id="container_position"  style="visibility:hidden">
	<div class="play-bar">
		<div class="time" style="left:1px;" id="_posselecttime">00:18:15</div> <!--bar的item的left值减去40-->
		<div class="bar">
			<div class="item" style="left:1px;" id="_playitem"><img src="<%=static_url%>/images/play/play-bar-on.png" /></div> <!-- 每单位格宽为23px，共19格， 总宽为437px，-->
		</div>
		<div class="intro">
			<div style="width:280px;"></div>
			<div style="left:290px"><span id="_posstartTime">00:18:45</span>/<span id="_posendTime">00:18:45</span></div>
		</div>
	</div>
	<div class="operate">
		<div>输入定位时间： </div>  
		<div class="item">
			<div class="txt" id="_showhours"></div>
		</div> 
		<div style="left:200px;">时 </div>  
		<div class="item itemon" style="left:232px;">
			<div class="txt" id="_showminute"></div>
		</div>
		<div style="left:289px;">分 </div> 
		<div style="left:328px;"><a href="#;" onclick="gotoTime()"><img src="<%=static_url%>/images/play/btn-jump.jpg" /></a></div>
		<div style="left:418px;"><a href="#;" onclick="showPosition()"><img src="<%=static_url%>/images/play/btn-reset.jpg" /></a></div>  
	</div>
</div>
 
<%  
   EpgResult epgResult2=dataSource.getChannels(1,60,biaoqingzhibocode);
    
   List channels=new ArrayList();
   if(epgResult2!=null&&epgResult2.getResultcode()==0&&epgResult2.getDatas()!=null){
	   channels=(List)epgResult2.getDatas();
   }
%>
<script type="text/javascript">
var currentSelectObjectId="";
var currentObjectId=""; 
var media=new MediaPlayerExClass();
var linkMap=new Map(); 
var channels = [];
<% if(channels.size()>0) {
	TblCmsChannel channel=null;
	for(int i=0;i<channels.size();i++){ 
	 channel=(TblCmsChannel)channels.get(i);%>
	 var tempObj ={};
	    tempObj.UserAuth= 1;
		tempObj.TimeShift= 1;
		tempObj.UserChannelID = <%=channel.getDchannelnumber() %>;
		tempObj.ChannelName = '<%=channel.getDname() %>';
		channels.push(tempObj);
	<%}
} %>
media.initAllChannels(channels);

function onPageLoad(){
	//showInfo.innerHTML="1id:"+userchannelid+""+media.currChannel_index; //测试时开启
	var userchannelid="";
    var para=window.location.search;
    para=para.replace('?','');
    var strs=para.split("&"); 
    var temp=""; 
    for(var i=0;i<strs.length;i++){
      temp=strs[i].split("=");
      if( temp[0]=="userchannelid" ){ userchannelid=parseInt(temp[1]);continue; }
       
    }
    // showInfo.innerHTML="1id:"+userchannelid+""+media.currChannel_index; 
     keyBinds();
    // showInfo.innerHTML="2id:"+userchannelid+""+media.currChannel_index;
     media.initMediaPlay();
    // showInfo.innerHTML="3id:"+userchannelid+""+media.currChannel_index;
     media.playLive(userchannelid);
    // showInfo.innerHTML="4id:"+userchannelid+""+media.currChannel_index;
}

function onPageUnload(){
 media.releaseMediaPlayer();
}
 

BaseProcess.prototype.clearFocus_EVENT=function(){ 
	  if("container_handexit22"==currentSelectObjectId || "container_handexit23"==currentSelectObjectId || "container_handexit24"==currentSelectObjectId 
	     || currentSelectObjectId=="container_handexit32"  || currentSelectObjectId=="container_bookmark0" || currentSelectObjectId=="container_bookmark1" ){
	     document.getElementById(currentSelectObjectId).className="btn-265x55";
	     return ;
	  }
	  if("_hours"==currentSelectObjectId || "_minute"==currentSelectObjectId){
	     document.getElementById(currentSelectObjectId).className="inputTxt";
	     return ;
	  }
	  if("_selectitem"==currentSelectObjectId){
	     _selectitem.className="progress-moveBox-nofocus";
	     showSelecPostion2();
	     return ;
	  }
	  if("container_handexit2"==currentSelectObjectId){
	     document.getElementById(currentSelectObjectId).className="btn-265x55";
	     return ;
	  }
	  document.getElementById(currentSelectObjectId).className="btn-125x41";
	}
	BaseProcess.prototype.showFocus_EVENT=function(){
	   if("container_handexit22"==currentSelectObjectId || "container_handexit23"==currentSelectObjectId || "container_handexit24"==currentSelectObjectId 
	     || currentSelectObjectId=="container_handexit32"  || currentSelectObjectId=="container_bookmark0" || currentSelectObjectId=="container_bookmark1" ){
	     document.getElementById(currentSelectObjectId).className="btn-265x55 btn-265x55_focus";
	     return ;
	  }
	   if("_hours"==currentSelectObjectId || "_minute"==currentSelectObjectId){
	     document.getElementById(currentSelectObjectId).className="inputTxt inputTxt_focus";
	     //if("_hours"==currentSelectObjectId) _showhours.innerHTML="";
	     //if("_minute"==currentSelectObjectId) _showminute.innerHTML="";
	     return ;
	  }
	   if("_selectitem"==currentSelectObjectId){
	     _selectitem.className="progress-moveBox";
	     showSelecPostion2();
	     return ;
	  }
	  if("container_handexit2"==currentSelectObjectId){
	     document.getElementById(currentSelectObjectId).className="btn-265x55 btn-265x55_focus";
	     return ;
	  }
	   document.getElementById(currentSelectObjectId).className="btn-125x41 btn-125x41_focus";
	}

	//帮助 信息
	BaseProcess.prototype.KEY_HELP_INFO_EVENT=function(){
	     if( isDivShow() ){  return ; }
	     hiddenAllDiv();
	     if(container_info.style.visibility=="visible"){
	      container_info.style.visibility="hidden";
	    }else{
	      _movDuration.innerHTML=media.getHourMinuteSecond(media.getTSTVEndTime());
	      container_info.style.visibility="visible";
	      media.setTSTVTime();
	      container_info_currenttime.innerHTML="当前时间："+media.getHourMinuteSecond(media.getTSTVCurrentTime());
	    }
	    autoHiddenAllDiv();
	}

	function showSpeed(){  
	  media.setTSTVTime();
	 _currentSpeed.innerHTML=media.getSpeed()+"X";
	 if(media.getSpeed()>0){
	   _currentPic.src="<%=static_url%>/images/play/icon-fast-forward.png";
	 }else{
	   _currentPic.src="<%=static_url%>/images/play/icon-fast-reverse.png";
	 }
	 container_speed.style.visibility="visible";
	}
	var peritem=0;
	var playitem=0;
	function showPosition(){  
	  media.setTSTVTime();
	  if(media.isLive){
		  _posendTime.innerHTML=new DateFormat(media.getTSTVEndTime()).format("hh:mi:ss") ; 
		  _posstartTime.innerHTML=new DateFormat(media.getTSTVBeginTime()).format("hh:mi:ss") ;  
		  _posselecttime.innerHTML= new DateFormat(media.getTSTVCurrentTime()).format("hh:mi:ss") ;
	  }else{
		  _posendTime.innerHTML=media.getHourMinuteSecond(media.getTSTVEndTime()); 
		  _posstartTime.innerHTML=media.getHourMinuteSecond(media.getTSTVBeginTime());  
		  _posselecttime.innerHTML=media.getHourMinuteSecond(media.getTSTVCurrentTime());
		  } 
	 
	 
	 peritem=Math.floor(media.TSShiftTime/20);
	 playitem=Math.ceil((media.getTSTVEndTime()-media.getTSTVCurrentTime())/peritem);
	 if(media.isLive){playitem=19-playitem;}
	 if(playitem==20){playitem=19;}
	 if(playitem==0){
	   _playitem.style.width="1px";
	   _posselecttime.style.left="1px";
	 }else{
	   _playitem.style.width=(playitem*23)+"px";
	   _posselecttime.style.left=(playitem*23)+"px";
	 }
	 container_position.style.visibility="visible";
	 showSelecPostion ( );
	 lostFocus ( );
	 startFlushTime();
	}

	function showPositionTime(){
		media.setTSTVTime();
		  if(media.isLive){
			  _posendTime.innerHTML=new DateFormat(media.getTSTVEndTime()).format("hh:mi:ss") ; 
			  _posstartTime.innerHTML=new DateFormat(media.getTSTVBeginTime()).format("hh:mi:ss") ;  
			  _posselecttime.innerHTML= new DateFormat(media.getTSTVCurrentTime()).format("hh:mi:ss") ;
		  }else{
			  _posendTime.innerHTML=media.getHourMinuteSecond(media.getTSTVEndTime()); 
			  _posstartTime.innerHTML=media.getHourMinuteSecond(media.getTSTVBeginTime());  
			  _posselecttime.innerHTML=media.getHourMinuteSecond(media.getTSTVCurrentTime());
			  }

		  var _temptime=media.getTSTVEndTime()- (playitem*peritem);
		  if(media.isLive){ _temptime=media.getTSTVEndTime()- ((19-playitem)*peritem);}
		  _posselecttime.innerHTML=new DateFormat( _temptime ).format("hh:mi:ss");
		  _showminute.innerHTML=_posselecttime.innerHTML.split(":")[1];
		  _showhours.innerHTML=_posselecttime.innerHTML.split(":")[0];
		   
	}

	function showSelecPostion ( ){ 
	  showSelecPostion2();
	}

	function showSelecPostion2 ( ){ 
		  if(playitem<0){playitem=19;}
	  if(playitem>19){playitem=0;}
	  if(playitem==0){
		  _playitem.style.left="1px";
		  _posselecttime.style.left="1px";
	 }else{
		 _playitem.style.left=(playitem*23)+"px";
		 _posselecttime.style.left=(playitem*23)+"px";
	 }
	  
	 currentSelectObjectId="_selectitem"; 
	 var _temptime=media.getTSTVEndTime()- (playitem*peritem);
	 if(media.isLive){ _temptime=media.getTSTVEndTime()- ((19-playitem)*peritem);}
	 _posselecttime.innerHTML=new DateFormat( _temptime ).format("hh:mi:ss");
	 _showminute.innerHTML=_posselecttime.innerHTML.split(":")[1];
	 _showhours.innerHTML=_posselecttime.innerHTML.split(":")[0];
	}

	function lostFocus ( ){ 
	   //document.getElementById("_hours").className="inputTxt";
	   //document.getElementById("_minute").className="inputTxt";
	   //document.getElementById("container_position0").className="btn-125x41";
	   //document.getElementById("container_position1").className="btn-125x41";
	}


	// 
	BaseProcess.prototype.PLAYMODE_CHANGE_EVENT=function(){

	}

	//静音
	BaseProcess.prototype.KEY_MUTE_EVENT=function(){
	   processMUTE();
	}

	//停止
	BaseProcess.prototype.KEY_STOP_EVENT=function(){
	   userBack();
	}

	//定位
	BaseProcess.prototype.KEY_SEEK_EVENT=function(){
	   //stopFlushTime();
	   //if(media.playOrPauseEvent()==media.STATUS_Pause){
	   //  showPosition(); 
	   //}else{
	   //  hiddenAllDiv(); 
	   //}
	}

	//播放 暂停
	BaseProcess.prototype.KEY_PLAY_EVENT=function(){
	   playOrPause();
	}


	function playNextChannel(action){
		  if(isOverrideOk()==false) {
		      hiddenAllDiv();
		   }
		   nextChannel(action);
		   //showChannelNum();
		}

		  //频道+
		BaseProcess.prototype.KEY_CHANNELUP_EVENT=function(){
			media.nextChannel(1);
		}
		  //频道-
		BaseProcess.prototype.KEY_CHANNELDOWN_EVENT=function(){
			media.nextChannel(-1);
		}

	function playOrPause(){
	  stopFlushTime();
	   if(media.playOrPauseEvent()==media.STATUS_Pause){
	     showPosition(); 
	   }else{
	     hiddenAllDiv(); 
	   }
	}

	function startForward(){
	   hiddenAllDiv();
	   var result=media.fastForwardEvent();
	   if(result==1){  stopFlushTime();PLAYTYPE=2; return; }
	   startFlushTime();
	}

	function startRewind(){
	   hiddenAllDiv();
	   var result=media.fastRewindEvent();
	   if(result==1){  stopFlushTime();PLAYTYPE=2; return; }
	   startFlushTime();
	}

	//快进
	BaseProcess.prototype.KEY_FASTFORWARD_EVENT=function(){
	   startForward();
	   PLAYTYPE=3;
	}
	//快退
	BaseProcess.prototype.KEY_FASTREWIND_EVENT=function(){
	   startRewind();
	   PLAYTYPE=3;
	}

	var PLAYTYPE=2;
	//当媒体播放器，发生异常时触发
	BaseProcess.prototype.MEDIA_ERROR_EVENT=function( errorCode ){
	    if(errorCode == 18 || errorCode == 21){
	      mediaEnd();
	      return;
	     }
	    container_playerror.style.visibility="visible";
	}

	function saveErrorInfo(txt){
	}

	//当媒体播放器中的媒体播放到末端时触发
	BaseProcess.prototype.MEDIA_END_EVENT=function(){
	     mediaEnd();
	}

	//声道切换
	BaseProcess.prototype.KEY_AUDIO_TRACK_EVENT=function(){
	     media.audioChannelEvent();
	}

	//当媒体播放器中的媒体播放到起始端时触发
	BaseProcess.prototype.MEDIA_BEGINING_EVENT=function(){
	    if(container_speed.style.visibility=="visible"   ){
	    media.setDefaultSpeed();
	    stopFlushTime();
	   }
	}
	//上页 左边界  
	BaseProcess.prototype.KEY_PAGEUP_EVENT=function(){
	   media.gotoStartEvent();
	   stopFlushTime();
	}
	//下页 右边界
	BaseProcess.prototype.KEY_PAGEDOWN_EVENT=function(){
	   media.gotoEndEvent();
	   stopFlushTime();
	}

	//向上
	BaseProcess.prototype.KEY_UP_EVENT=function() {
		//media.volumeUpEvent();
	   //showVolumeBar();
	   autoHiddenAllDiv();	
	}
	//向下
	BaseProcess.prototype.KEY_DOWN_EVENT=function() {
	   //media.volumeDownEvent();
	   //showVolumeBar();
	   autoHiddenAllDiv();
	}  
	//左  _selectitem
	BaseProcess.prototype.KEY_LEFT_EVENT=function(){
	 
		   if(container_position.style.visibility=="visible"  ){
			     playitem=playitem-1;
		     showSelecPostion ( );
		     return ;
	   }
	   if( !isDivShow() || container_speed.style.visibility=="visible" ){
	     //startRewind();
	     return ;
	   }
	   this.moveFocus(3);
	}


	//右
	BaseProcess.prototype.KEY_RIGHT_EVENT=function(){
		 
		   if(container_position.style.visibility=="visible" ){
			   playitem=playitem+1; 
		     showSelecPostion ( ); 
	     return ;
	   }
	   if( !isDivShow() || container_speed.style.visibility=="visible" ){
	      //startForward();
	      return ;
	   }  
	   this.moveFocus(1);
	}

	// enter
	BaseProcess.prototype.KEY_OK_EVENT=function(){
	    if(container_position.style.visibility=="visible"  ){
	        gotoTime();
	    }else{
	      this.doSelect();
	    }
	}

	//数字键  _hours  _minute  _showhours  _showminute
	BaseProcess.prototype.KEY_CHANNELUP_NUMBER_EVENT=function(num){
	    if(container_position.style.visibility=="visible" && ("_hours"==currentSelectObjectId || "_minute"==currentSelectObjectId) ){
	     if("_hours"==currentSelectObjectId){
		      if(_showhours.innerHTML==""||_showhours.innerHTML.length<2){
		         _showhours.innerHTML=_showhours.innerHTML+""+num;
		      }else{
		         _showhours.innerHTML="";
		      }
	     }
	     if("_minute"==currentSelectObjectId){
		      if(_showminute.innerHTML==""||_showminute.innerHTML.length<2){
		         _showminute.innerHTML=_showminute.innerHTML+""+num;
		      }else{
		          _showminute.innerHTML="";
		      }
	     }
	   }
	}

	function deleteInputNum(){
	  if(container_position.style.visibility=="visible"   ){
	     if("_hours"==currentSelectObjectId){
		      var str=""+_showhours.innerHTML;
		      str=str.substring(0,str.length-1);
		      _showhours.innerHTML=str;
	     }
	     if("_minute"==currentSelectObjectId){
		      var str=""+_showminute.innerHTML;
		      str=str.substring(0,str.length-1);
		      _showminute.innerHTML=str;
	     }
	   }
	}


	//加音量
	BaseProcess.prototype.KEY_VOLUP_EVENT=function(){
	   media.volumeUpEvent();
	   //showVolumeBar();
	   autoHiddenAllDiv();
	   if( media.getMuteFlagEvent()==1 ){
	       processMUTE();
	   }
	}

	function processMUTE(){
	   media.setMuteFlagEvent();
	   if( media.getMuteFlagEvent()==1 ){
	       container_muteflag.style.visibility="visible";
	   }else{
	       container_muteflag.style.visibility="hidden";
	   }
	}

	//减音量  
	BaseProcess.prototype.KEY_VOLDOWN_EVENT=function(){
	   media.volumeDownEvent();
	   //showVolumeBar();
	   autoHiddenAllDiv();
	   if( media.getMuteFlagEvent()==1 ){
	       processMUTE();
	   }
	}

	//声道切换
	BaseProcess.prototype.KEY_AUDIO_TRACK_EVENT=function(){
	   media.audioChannelEvent();
	}
	 
	//返回
	BaseProcess.prototype.KEY_BACK_EVENT=function(){
	   if(container_speed.style.visibility=="visible" ||container_position.style.visibility=="visible"  ){
	     if(media.getMediaPlayStatus()!=media.STATUS_Play){
	     stopFlushTime();
	     media.resumePlay(); 
	   } 
	   hiddenAllDiv(); 
	     return ;
	   }
	   
	   if(container_position.style.visibility=="visible"   ){
		   stopFlushTime();
		   media.resumePlay();
		   hiddenAllDiv();   
	     return ;
	   }
	   
	   if( isDivShow() ){
	     hiddenAllDiv();
	     return ;
	   }else{
	     userBack();
	     
	   }
	}

	function userBack(){
		 userBackMov();
	}

	function userBackMov(){
	   hiddenAllDiv();
	   currentSelectObjectId="container_handexit0";
	   initFocus();
	   document.getElementById("container_handexit1").className="btn-125x41";
	   document.getElementById("container_handexit2").className="btn-265x55";
	   container_handexit.style.visibility="visible";
	   
	}
	 
	function userBackEpisode(){
	   hiddenAllDiv();
	   currentSelectObjectId="container_handexit23";
	   document.getElementById("container_handexit21").className="btn-125x41";
	   document.getElementById("container_handexit22").className="btn-265x55";
	   document.getElementById("container_handexit23").className="btn-265x55 btn-265x55_focus";
	   document.getElementById("container_handexit24").className="btn-265x55";
	   container_handexit2.style.visibility="visible";
	   
	}

	function hiddenAllDiv(){
	 container_speed.style.visibility="hidden";
	 //container_info.style.visibility="hidden";
	 container_handexit.style.visibility="hidden";
	 container_playend.style.visibility="hidden";
	 container_handexit2.style.visibility="hidden";
	 //container_handexit3.style.visibility="hidden";
	 container_playerror.style.visibility="hidden";
	 //container_volume.style.visibility="hidden";
	 container_position.style.visibility="hidden";
	}

	function isDivShow(){
	 if(container_speed.style.visibility=="visible"
	     //||container_info.style.visibility=="visible"
	     ||container_handexit.style.visibility=="visible"
	     ||container_playend.style.visibility=="visible"  
	     ||container_handexit2.style.visibility=="visible"
	     //||container_handexit3.style.visibility=="visible"
	     ||container_playerror.style.visibility=="visible"
	     //||container_volume.style.visibility=="visible"
	     ||container_position.style.visibility=="visible"
	     //||container_bookmark.style.visibility=="visible" 
	         ){
	     return true;
	     }
	  return false;
	}

	function isOverrideOk(){
	 if(container_speed.style.visibility=="visible"
	     ||container_handexit.style.visibility=="visible"
	     ||container_playend.style.visibility=="visible"
	     ||container_handexit2.style.visibility=="visible"
	     //||container_handexit3.style.visibility=="visible"
	     ||container_playerror.style.visibility=="visible"){
	  return false;
	 }
	 return true;
	}

	function initFocus(){
	 var obj=document.getElementById(currentSelectObjectId) ;
	 if(obj!=undefined&&obj!=null){
	   obj.className="btn-125x41 btn-125x41_focus";
	 }else{
	   currentSelectObjectId=currentObjectId;
	 } 
	}

	function goBack(){
		//window.history.go(-1);
		var backUrl = getURLtoCookie("channelPlay");
		 backUrl = (backUrl!="")?backUrl:"<%=static_en%>/page/index.jsp";
		 location.href = backUrl ;
	}

	function cancel(){
	 hiddenAllDiv(); 
	 stopFlushTime();
	 if(media.getMediaPlayStatus()!=media.STATUS_Play){
	     media.resumePlay(); 
	   }else{
	     hiddenAllDiv(); 
	   }
	}

	function cancelandplay(){
	 cancel();
	 media.playOrPauseEvent();
	}


	var _isFlushTime=0;
	function startFlushTime(){
		if(container_position.style.visibility=="visible" ){
			showPositionTime();
	    }else{
	    	showSpeed();
	        }

		 
	 if(_isFlushTime!=0){
	   clearInterval(_isFlushTime);
	   _isFlushTime=0;
	 }
	 if(container_position.style.visibility=="visible" ){
		 _isFlushTime = setInterval(showPositionTime,1000*60 ); 
	 }else{
		//_isFlushTime = setInterval(showSpeed,1500);
	     }
	 
	}
	function stopFlushTime(){
	 hiddenAllDiv();
	 if(_isFlushTime!=0){
	   clearInterval(_isFlushTime);
	   _isFlushTime=0;
	 }
	}


	function showVolumeBar(){
	 if(container_volume.style.visibility=="hidden"){
	       container_volume.style.visibility="visible";
	 }
	 _volumeBar.style.width=(media.getVolume()/5)*42+"px";
	}

	var timer_autoHiddenAllDiv = 0;
	   function autoHiddenAllDiv()
	   {
	        if(timer_autoHiddenAllDiv != 0)
	        {
	            clearTimeout(timer_autoHiddenAllDiv);
	            timer_autoHiddenAllDiv = 0;
	        }
	        timer_autoHiddenAllDiv = setTimeout(hiddenAllDiv,3000);
	   }

	function gotoTime(){ 
	 var showhours=_showhours.innerHTML==""?0:_showhours.innerHTML;
	 var showminute=_showminute.innerHTML==""?0:_showminute.innerHTML;
	 if(showhours.substring(0,1)=="0"){showhours=showhours.substring(1,showhours.length) }
	 if(showminute.substring(0,1)=="0"){showminute=showminute.substring(1,showminute.length) }
	 var hours=parseInt(showhours)*3600 ;
	 hours+=parseInt(showminute)*60 ;
	 if(hours==undefined||hours==null){
	   _showhours.innerHTML="";
	   _showminute.innerHTML="";
	   //_showPostionErrInfo.innerHTML="请输入正确定位时间：";
	   return;
	 }
	 if(hours<0||hours>media.getTSTVEndTime()){
	   _showhours.innerHTML="";
	   _showminute.innerHTML="";
	   //_showPostionErrInfo.innerHTML="请输入正确定位时间：" ;
	   return;
	 }
	 if(media.isLive){
		 var gotoTime=new Date();
		 gotoTime.setHours(parseInt(showhours));
		 gotoTime.setMinutes(parseInt(showminute));
		 media.playVodByTime( media.convertUTCTimeString(gotoTime ) );
		 }else{
			 media.playVodByTime(hours);
		 }
	 
	 //_showPostionErrInfo.innerHTML="输入定位时间：";
	 hiddenAllDiv();
	 stopFlushTime();
	}

	function showError(){
	  container_playerror.style.visibility="visible";
	  setTimeout(goIndex,2000);
	}

	function goIndex(){
	 window.location.href="<%=ctx%>/index/index.do";
	}


	function mediaEnd(){
		 if(container_speed.style.visibility=="visible"   ){
		     stopFlushTime();
		   }
		   	//电视剧连续播放
		    <%if ("2".equals(vod.getDprogramtype()) ){ %>
		        
		        <%if ("".equals("")){ %> 
		    	window.location.href = '$ctx/vod/play.do?CMSMediaId=$nextobj.MediaID&MediaType=$MediaType&MediaParentID=$MediaParentID&CatalogID=$CatalogID&IsFree=$nextobj.IsFree&RN=$nextobj.EpisodeIndex'; 
		    	<%}else{%>
		        container_handexit3.style.visibility="visible";
		        currentSelectObjectId="container_handexit32";
		        document.getElementById(currentSelectObjectId).className="btn-265x55 btn-265x55_focus";
		        <%} %>
		    <%}else{%>
		        container_playend.style.visibility="visible";
	            currentSelectObjectId="container_playend";
		    <%} %>   
		    setTimeout(goBack,5000);
		}
</script>
</body>
<script type="text/javascript" src="<%=static_url%>/js/cookie.js"></script>
</html>
