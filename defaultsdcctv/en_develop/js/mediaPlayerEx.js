function MediaManager(){
	this.player;
	this.numCount = 0;
    this.number = 0;
	this.strNumber="";
	this.chanList = [];
	this.currChannelNum=0;
	this.currChannelId=0;
	this.currControlFlag=0;
	this.totalChannel = -1;//直播总个数
    this.totalListPages = 0;//直播列表总页
    this.currListPage = 0;//直播列表当前
	this.currChannelIndex=-1;
	this.chanListFocus=0;
	this.shiftTimeList=new Array();
	this.timeList=new Array();
	this.mediaCurrent=new Array();
	
	
	this.channelIds = new Array();//直播id号
    this.channelNames = new Array();	//直播名称
    this.channelNums = new Array();//直播号，对比是否存在直播的参考
    this.channelNumsShow = new Array();//用来显示的直播号数组
    this.channelCode = new Array();//直播的MediaCode
	
	
	this.speed = 1;
    this.playStat = "play";
    this.playType = "tv";
	this.shiftStatus = 1;
	
	this.getPlayer = function() {
        if (!this.player) {
            this.player = new MediaPlayer();
        }
        return this.player;
    };
	
	this.getMediaTime = function() {
        return this.convertTime(this.player.getMediaDuration());
    };
	
    this.getOriMediaTime = function() {
        return this.player.getMediaDuration() < 0 ? 0 : this.player.getMediaDuration();
    };
	
	this.isForwardCurrTimeForTVod=function(pHour, pMin)
    {
		var tmpCurrTime = parseInt(this.player.getCurrentPlayTime());
		
		pHour = pHour.replace(/^0*/, "");
		if(pHour == ""){pHour = "0";}
		pMin = pMin.replace(/^0*/, "");        
		if(pMin == ""){pMin = "0";}
		var alltime=pHour*3600+pMin*60;
		return (alltime <= tmpCurrTime);
    };
	
	this.getOriCurrentTime = function() {
        return this.player.getCurrentPlayTime();
    };
	
	this.computCurrentLiveTime = function(utcTime) {
         var hour = parseInt(utcTime.substr(9, 2));
         var min = parseInt(utcTime.substr(11, 2));
    	 return (hour+8)+":"+min;
    };
	 this.initChannelMedia = function() {
    	this.initMediaPlay();
    	this.player.leaveChannel();
        this.player.setAllowTrickmodeFlag(0);
        this.player.setCycleFlag(0);
        this.player.setProgressBarUIFlag(0);
        this.player.setNativeUIFlag(0);
        this.player.setAudioVolumeUIFlag(0);
        this.player.setAudioTrackUIFlag(0);
        this.player.setMuteUIFlag(0);
        this.player.setChannelNoUIFlag(0);
		this.player.setVideoDisplayMode(1);
        this.player.refreshVideoDisplay();
    };
	this.getCurrJSTime = function() {
        var currTime = new Date();
        var min = currTime.getMinutes();
        var sec = currTime.getSeconds();
        if (sec >= 30) currTime.setMinutes(min + 1);
        var hour = currTime.getHours();
        min = currTime.getMinutes();
        if (hour < 10) hour = "0" + hour;
        if (min < 10) min = "0" + min;
        return hour + ":" + min;
    };
	
	this.parseUtcTime = function(utcTime) {
        var year = parseInt(utcTime.substr(0, 4));
        var month = parseInt(utcTime.substr(4, 2));
        var day = parseInt(utcTime.substr(6, 2));
        var hour = parseInt(utcTime.substr(9, 2));
        var min = parseInt(utcTime.substr(11, 2));
        var sec = parseInt(utcTime.substr(13, 2));
        if (month == 0) month = parseInt(utcTime.substr(5, 1));
        if (day == 0) day = parseInt(utcTime.substr(7, 1));
        if (hour == 0) hour = parseInt(utcTime.substr(10, 1));
        if (min == 0) min = parseInt(utcTime.substr(12, 1));
        if (sec == 0) sec = parseInt(utcTime.substr(14, 1));
        return new Date(year, month - 1, day, hour + 8, min, sec);
    };
	
	
	
	//秒数换成时间 格式为00:00
	this.convertTime=function(time) {
        if (undefined == time || time.length == 0) {
            time = this.player.getMediaDuration();
        }
        time = parseInt(time, 10);
        var returnTime = "";
        var time_second = "";
        var time_min = "";
        var time_hour = "";
        time_second = String(time % 60);
        var tempIndex = -1;
        tempIndex = (String(time / 60)).indexOf(".");
        if (tempIndex != -1) {
            time_min = (String(time / 60)).substring(0, tempIndex);
            tempIndex = -1;
        } else {
            time_min = String(time / 60);
        }
        tempIndex = (String(time_min / 60)).indexOf(".");
        if (tempIndex != -1) {
            time_hour = (String(time_min / 60)).substring(0, tempIndex);
            tempIndex = -1;
        } else {
            time_hour = String(time_min / 60);
        }
        time_min = String(time_min % 60);
        if ("" == time_hour || 0 == time_hour) {
            time_hour = "00";
        }
        if ("" == time_min || 0 == time_min) {
            time_min = "00";
        }
        if ("" == time_second || 0 == time_second) {
            time_second = "00";
        }
        if (time_hour.length == 1) {
            time_hour = "0" + time_hour;
        }
        if (time_min.length == 1) {
            time_min = "0" + time_min;
        }
        if (time_second.length == 1) {
            time_second = "0" + time_second;
        }
        returnTime = time_hour + ":" + time_min ;
        return returnTime;
   }
	  
   this.getShiftBeginTime=function() {
        var currTime = new Date();
        var beginTime = new Date(currTime.getTime() - this.getOriMediaTime() * 1000);
        var min = beginTime.getMinutes();
        var sec = beginTime.getSeconds();
        if (sec >= 30) beginTime.setMinutes(min + 1);
        var hour = beginTime.getHours();
        min = beginTime.getMinutes();
        if (hour < 10) hour = "0" + hour;
        if (min < 10) min = "0" + min;
        return hour + ":" + min;
   }
	
	this.getChanShiftTimes=function(time){
	    if (time == undefined || time == "") time = 0;
	    var currTime = new Date();
	    var beginTime = new Date(currTime.getTime() - (this.getOriMediaTime() - time) * 1000);
	    var min = beginTime.getMinutes();
	    var sec = beginTime.getSeconds();
	    if (sec >= 30) beginTime.setMinutes(min + 1);
	    var hour = beginTime.getHours();
	    min = beginTime.getMinutes();
	    if (hour < 10) hour = "0" + hour;
	    if (min < 10) min = "0" + min;
	    return hour + ":" + min;
	}
	
	//根据时移时间段获取该时间段的播放时间
	this.getShiftTimeByTime=function(time){
	    if (time == undefined || time == "") time = 0;
	    var currTime = new Date();
	    var dateobj = new Date(currTime.getTime() - (this.getOriMediaTime() - time) * 1000);
	    
	    var sec = dateobj.getSeconds();
	    var min = dateobj.getMinutes();
	    var hour = dateobj.getHours();
	    if (sec >= 5) dateobj.setMinutes(min + 1);
	    dateobj.setHours(hour - 8);
	    
		 var year =  dateobj.getFullYear();
		 var month = dateobj.getMonth() + 1;
		 var day = dateobj.getDate();
		 hour = dateobj.getHours();
		 min = dateobj.getMinutes();
		 if (month < 10) month = "0" + month;
		 if (day < 10) day = "0" + day;
		 if (hour < 10) hour = "0" + hour;
		 if (min < 10) min = "0" + min;
		 var timeStamp = "" +  year + month + day + "T" + hour + min + "00" + "Z";
		 return timeStamp;
	}
	
	this.getRelativeTime = function(currPlayTime) {
        currPlayTime = this.parseUtcTime(currPlayTime);
        var currTime = new Date();
        var beginTime = new Date(currTime.getTime() - this.getOriMediaTime() * 1000);
        return (currPlayTime.getTime() - beginTime.getTime()) / 1000;
    };
	
	this.initMediaPlay = function () {
		  if(this.player==null){
		    this.player = new MediaPlayer();
			var instanceId = this.player.getNativePlayerInstanceID();
            var playListFlag = 0;
            var videoDisplayMode = 1;
            var height = 0;
			var width = 0;
			var left = 0;
			var top = 0;
			var muteFlag = 0;
			var subtitleFlag = 0;
			var videoAlpha = 0;
			var cycleFlag = 0;
			var randomFlag = 0;
			var autoDelFlag = 0;
			var useNativeUIFlag = 1;
	        this.player.initMediaPlayer(instanceId, playListFlag, videoDisplayMode, height, width, left, top, muteFlag, useNativeUIFlag, subtitleFlag, videoAlpha, cycleFlag, randomFlag, autoDelFlag);
		  }
		
    };
	
	
	 this.initTvodMedia = function(tvodUrl){
    	this.initMediaPlay();
        this.json = '[{mediaUrl:"' + tvodUrl + '",mediaCode:"jsoncode1",mediaType:2,audioType:1,videoType:1,streamType:1,drmType:1,fingerPrint:0,copyProtection:1,allowTrickmode:1,startTime:0,endTime:20000,entryID:"jsonentry1"}]';
        this.player.leaveChannel();
        this.player.setSingleMedia(this.json);
		
        this.player.setAllowTrickmodeFlag(0);
        this.player.setCycleFlag(0);
        this.player.setProgressBarUIFlag(0);
        this.player.setNativeUIFlag(0);
        this.player.setAudioVolumeUIFlag(0);
        this.player.setAudioTrackUIFlag(0);
        this.player.setMuteUIFlag(0);
        this.player.setChannelNoUIFlag(0);
		this.player.setVideoDisplayMode(1);
        this.player.refreshVideoDisplay();
    };
	
	this.pause = function() {
        this.speed = 0;
        this.playStat = "pause";
        this.player.pause();
        if (this.playType == "tv") this.shiftStatus = 1;
    };
	
   this.resume = function() {
        this.speed = 1;
        this.playStat = "play";
        this.player.resume();
    };
	
	this.gotoStart=function(){
		this.player.gotoStart();
		if(this.playType == "tv") this.shiftStatus=1;
	};
	
	this.gotoEnd=function(){
		this.player.gotoEnd();
		if(this.playType == "tv") this.shiftStatus=0;
	};
	
	//计算时移的时间段
	this.calculate=function(mediaPeriod, count) {
		this.timeList=new Array();
		this.shiftTimeList=new Array();
		this.mediaCurrent=new Array();
	    if (mediaPeriod != 0) {
	        var time_per_square = mediaPeriod / count;
		    for (var i = 0; i <= count; i++) {
	             this.timeList[i] = i * time_per_square;
				 if (this.playType == "tv"){
	               this.shiftTimeList[i] =this.getShiftTimeByTime(Math.floor(this.timeList[i]));
	               this.mediaCurrent[i] = this.getChanShiftTimes(Math.floor(this.timeList[i]));
				 }else{
				   this.mediaCurrent[i] = this.convertTime(Math.floor(this.timeList[i]));
				 }
	        }
	    }
	};
	this.playByTime = function(time) {
        var type = 1;
        this.speed = 1;
        this.playStat = "play";
        time = parseInt(time, 10);
        this.player.playByTime(type, time, this.speed);
    };
	
	this.playChan=function(channelnum){
		this.player.joinChannel(channelnum);
    };
	
	this.isNum=function(s){
	    var nr1=s,flg=0,cmp="0123456789",tst ="";
	    for (var i=0,l=nr1.length;i<l;i++){
		  tst=nr1.substring(i,i+1)
		  if (cmp.indexOf(tst)<0)
		   { 
			   flg++;
		   }
	    }
	    if (flg == 0){return true;}
	    else{return false;}
   };
   
   this.isEmpty=function(s){
	   return ((s == undefined) || (s == "") || (s == null) || (s.length == 0));
   };
   
   this.isInMediaTime=function(pHour, pMin)
   {
		var currTime = new Date();   
		var inputTime = new Date();  
		var shiftLength=this.getOriMediaTime();
		var beginTime = new Date(currTime.getTime() - shiftLength * 1000);// 如果读到时间为零则取1小时
		pHour = pHour.replace(/^0*/, "");
		if(pHour == ""){pHour = "0";}
		pMin = pMin.replace(/^0*/, "");        
		if(pMin == ""){pMin = "0";}
		inputTime.setHours(parseInt(pHour));  
		inputTime.setMinutes(parseInt(pMin));
		inputTime.setSeconds(0);
		return  (((beginTime.getTime() - inputTime.getTime()) <= 0) && ((currTime.getTime() - inputTime.getTime()) > 0));
   };
   
   this.isInTVodMediaTime=function(pHour, pMin)
   {
		pHour = pHour.replace(/^0*/, "");
		if(pHour == ""){pHour = "0";}
		pMin = pMin.replace(/^0*/, "");        
		if(pMin == ""){pMin = "0";}
		var alltime=pHour*3600+pMin*60
		return (alltime <= this.getOriMediaTime());
   }
   
   this.checkTVodJumpTime=function(pHour, pMin)
   {        
		if(this.isEmpty(pHour)){
			return false;
		}
		else if(!this.isNum(pHour))
		{ 
		   return false;
		}
		if(this.isEmpty(pMin))
		{ 
		   return false;
		}
		else if(!this.isNum(pMin))
		{
			return false;
	    }
		else if(!this.isInTVodMediaTime(pHour, pMin))
		{ 
		  return false;
		}
		else{
			return true;
		}
   };
   this.checkJumpTime=function(pHour, pMin){
	   if(this.isEmpty(pHour)||!this.isNum(pHour)||this.isEmpty(pMin)||!this.isNum(pMin)||!this.isInMediaTime(pHour, pMin)||parseInt(pHour)>=24||parseInt(pMin)>=60)
	   {return false;}
	   else{return true;}
   };
   this.isForwardCurrTime=function(pHour, pMin)
   {
	    var realcurrTime = new Date();  
		var currentTime = this.getOriCurrentTime();//获取当前播放时间
		var currTime1 =currentTime.substring(0,8)+currentTime.substring(9,15);
		var value1=currTime1.substring(0,4);
		var value2=currTime1.substring(4,6);
		var value3=currTime1.substring(6,8);
		var value4=currTime1.substring(8,10);
		var value5=currTime1.substring(10,12); 
		var oldTime =value4+":"+value5+":00";
		var temDate = value2+'/'+value3+'/'+value1+' '+oldTime;
		var T =new Date(Date.parse(temDate));
		var t=Date.parse(T)+28800*1000;
		T.setTime(t);
		var inputTime = new Date(); 
		pHour = pHour.replace(/^0*/, "");
		if(pHour == "")
		{
			pHour = "0";
		}
		pMin = pMin.replace(/^0*/, "");        
		if(pMin == "")
		{
			pMin = "0";
		}
		inputTime.setHours(parseInt(pHour));  
		inputTime.setMinutes(parseInt(pMin));
		inputTime.setSeconds(0);
	    return (((T.getTime() - inputTime.getTime()) <= 0) && ((realcurrTime.getTime() - inputTime.getTime()) > 0));
    };
}