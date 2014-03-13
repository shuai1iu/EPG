

//媒体播放对象
function MediaPlayerExClass() {
    this.mp = null; //媒体对象

    this.instanceId = 0; //媒体对象ID
    this.playListFlag = 0; // 0: 单播 1: 播放列表
    this.videoDisplayMode = 1; // 0：指尺寸 1:全屏 2:宽度 3:高度 255：音频
    this.height = 0;
    this.width = 0;
    this.left = 0;
    this.top = 0;
    this.nativeUIFlag = 0; // 0:不使用盒子UI 1:使用盒子UI
    this.muteFlag = 1; //0: 不使用盒子静音 1:使用盒子静音      
    this.subtitleFlag = 0; // 0:不显示字幕  1:显示字幕    
    this.videoAlpha = 0; // 透明度 0：不透明 255:完全透明 透明度根据情况0~255    
    this.cycleFlag = 0;
    this.randomFlag = 0;
    this.autoDelFlag = 0;

    this.audioVolumeUIFlag = 0; //0:不使用盒子声音界面 1:使用盒子声音界面
    this.audioTrackUIFlag = 0; //0:不使用盒子音轨界面 1:使用盒子音轨界面
    this.progressBarUIFlag = 0; // 0:不使用盒子进度条界面 1: 使用盒子进度条界面
    this.channelNoUIFlag = 0; // 0:不使用频道UI 1:使用盒子频道UI
    this.allowTrickmodeFlag = 0; // 0:允许TrickMode操做 1: 不允许TrickMode操做

    this.speed = 1; //速度
    this.speedScale = 2; //速度刻度
    this.minSpeed = -32; //最小速度
    this.maxSpeed = 32; //最大速度
    this.volume = 50; //音量 
    this.minVolume = 0; //最小音量
    this.maxVolume = 90; //最大音量
    this.voluemScale = 5; //声音刻度
    
    this.TSTVBeginTime = 0; //开始时间
    this.TSTVEndTime = 0; //结束时间
    this.TSTVCurrentTime = 0; //当前时间
    this.TSShiftTime=1*3600*1000;//时移时间
    
    this.mediaStr = ""; //媒体播放地址
    this.isAutoEnd = true; //是否自动结束
    this.playUrl = ""; // 播放地址
    
    this.canTimeShift =0; //是否支持时移
    this.UserAuth=0;//用户是否能看此频道
    this.isLive = false; //是否直播
    this.allchannels  ; //所有频道
    this.channelCounts=0  ; //所有频道总数
    this.currentChannelId=0  ; //当前频道id
    this.currentChannelName=""  ; //当前频道名
    this.currChannel_index=0  ; //当前频道所在数组下标
    
    this.STATUS_Play = "Normal Play"; //播放
    this.STATUS_Pause = "Pause"; //暂停
    this.STATUS_Trickmode = "Trickmode"; //快进快退
    this.TS_NTP_DiffMS=0;//盒子 与流媒体时间 差
    
    //速度
    this.getSpeed = function () {
        return this.speed;
    }
    
    //速度
    this.setDefaultSpeed = function () {
        this.speed=1;
    }
    
    
    this.getCurrentPlayTime = function () {
        return this.mp.getCurrentPlayTime();
    }
    
    //静音
    this.getMuteFlagEvent = function () {
        return this.mp.getMuteFlag();
    }
    
    this.getVolume=function ( ) {
      return this.volume;
    }
    
    this.getTSTVCurrentTime=function ( ) {
      return this.TSTVCurrentTime;
    }
    
    this.getTSTVEndTime=function ( ) {
      return this.TSTVEndTime;
    }
    
    this.getTSTVBeginTime=function ( ) {
      return this.TSTVBeginTime;
    }
    
    this.initSTBTimeDiff=function ( ) {
    var TSCurrTime = this.getDateByUTC(this.mp.getCurrentPlayTime()); //TS UTC +0800 Date
    var NTPCurrTime = new Date(); // NTP UTC +0800 Date
    this.TS_NTP_DiffMS = NTPCurrTime.getTime() - TSCurrTime.getTime();
    }
    
    this.setTSTVTime=function() { 
    	if(!this.isLive){
          this.TSShiftTime=this.mp.getMediaDuration();
          this.setMovTSTVTime();
        }else{ 
          this.TSShiftTime=1*3600*1000;
          this.setLiveTSTVTime();
        }
    }
    /*
     * 直播
     */
    this.setLiveTSTVTime=function() 
    {
     
    	this.TSTVBeginTime = new Date();
    	this.TSTVEndTime = new Date();
    	this.TSTVCurrentTime = this.getDateByUTC(this.mp.getCurrentPlayTime());
    	this.TSTVCurrentTime.setTime(this.TSTVCurrentTime.getTime() - this.TS_NTP_DiffMS);
    	this.TSTVBeginTime.setTime(this.TSTVBeginTime.getTime() - this.TS_NTP_DiffMS - this.TSShiftTime );
    	this.TSTVEndTime.setTime(this.TSTVEndTime.getTime() - this.TS_NTP_DiffMS);
    	
    }

    /*
     * 非直播
     */
    this.setMovTSTVTime=function() 
    {
    	this.TSTVBeginTime = new Date();
    	this.TSTVCurrentTime = this.mp.getCurrentPlayTime();
    	this.TSTVEndTime=this.TSShiftTime;
    }
    
    //获得播放器状态 正常播放"Normal Play" "Pause"  "Trickmode"快进
    this.getMediaPlayStatus=function() {
         var playBackModeArr = new Array();
        var state = "";
        var playBackModeStr = this.mp.getPlaybackMode(); 
        playBackModeArr = playBackModeStr.split(",");
        if(playBackModeStr != "")
        {
        var tempArr = playBackModeArr[0].split(":"); 
        var temp = tempArr[1]; 
        var index = temp.indexOf('"'); 
        var index2 = temp.lastIndexOf('"');
        state = temp.substring(index+1,index2);
        }
        return state;
     }

    //初始化播放
    this.initMediaPlay=function( ) {
         this.mp = new MediaPlayer();
         if (this.instanceId > 0){
             this.mp.bindNativePlayerInstance(this.instanceId);
         }else{
             this.instanceId = this.mp.getNativePlayerInstanceID();
           }
         this.playListFlag = 0; // 0: 单播 1: 播放列表
         this.videoDisplayMode = 1; // 0：指尺寸 1:全屏 2:宽度 3:高度 255：音频
         this.height = 0;
         this.width = 0;
         this.left = 0;
         this.top = 0;
         this.nativeUIFlag = 0; // 0:不使用盒子UI 1:使用盒子UI
         this.muteFlag = 0; //0: 不使用盒子静音 1:使用盒子静音      
         this.subtitleFlag = 0; // 0:不显示字幕  1:显示字幕    
    	 this.videoAlpha = 0; // 透明度 0：不透明 255:完全透明 透明度根据情况0~255    
    	 this.cycleFlag = 0;
    	 this.randomFlag = 0;
    	 this.autoDelFlag = 0;
         this.mp.initMediaPlayer(this.instanceId, this.playListFlag, this.videoDisplayMode, this.height, this.width, this.left, this.top, this.muteFlag, this.nativeUIFlag, this.subtitleFlag, this.videoAlpha, this.cycleFlag, this.randomFlag, this.autoDelFlag);
         this.mp.setAllowTrickmodeFlag(0);
         this.mp.refreshVideoDisplay(); 
     }
     
    //初始化播放
    this.initMediaPlayByPara=function(videoDisplayMode,height,width,left,top) {
         this.mp = new MediaPlayer();
         if (this.instanceId > 0){
             this.mp.bindNativePlayerInstance(this.instanceId);
         }else{
             this.instanceId = this.mp.getNativePlayerInstanceID();
           }
           this.videoDisplayMode=videoDisplayMode;
         if(videoDisplayMode==1){
           this.height=0; this.width=0; this.left=0; this.top=0;
         } 
         if(videoDisplayMode==0){
           this.height=height; this.width=width; this.left=left; this.top=top;
         }  
         this.mp.initMediaPlayer(this.instanceId, this.playListFlag, this.videoDisplayMode, this.height, this.width, this.left, this.top, this.muteFlag, this.nativeUIFlag, this.subtitleFlag, this.videoAlpha, this.cycleFlag, this.randomFlag, this.autoDelFlag);
         this.mp.setAllowTrickmodeFlag(0);
         this.mp.refreshVideoDisplay(); 
     }


    //释放媒体对象
    this.releaseMediaPlayer = function() {
      this.mp.stop();
      this.mp.releaseMediaPlayer(this.nativePlayerInstanceId);
    }

    //获取简单地址字符串
    this.getSingleMediaStr=function(url) {
        this.playUrl = url;
        var jsonStr = '[{mediaUrl:"' + url;
        jsonStr += '",mediaCode: "code1",mediaType:2,audioType:1,videoType:1,streamType:1,drmType:1,drmType:1,fingerPrint:0,copyProtection:1,allowTrickmode:1,startTime:0,endTime:5000,entryID:"entry1"}]';
        this.mediaStr=jsonStr;
        return this.mediaStr;
    }

    //单个影片播放模式
    this.playSingleMovie = function (url) {
        this.isLive=false;
        this.mp.setSingleMedia( this.getSingleMediaStr(url) ); //播放单个视频
        this.playSet(0); //播放设置
    }
    
    //单个影片播放模式
    this.playSingleMovieByBook = function (url,BookMark) {
        this.isLive=false;
        this.mp.setSingleMedia( this.getSingleMediaStr(url) ); //播放单个视频
        var book=0;
        if(BookMark!=""){
          book=parseInt(BookMark);
        } 
        this.playSet(book); //播放设置
    }
    
    //直播播放模式
    this.playLive = function(UserChannelID){
    	 this.isLive=true;
    	 this.playSet(0); //播放设置
    	 return this.playChannelID(UserChannelID);
    }
    
    //单播小窗口播放
    this.playSingleLittleMovie = function (url,height,width,left,top) {
         this.initMediaPlayByPara(1,height,width,left,top);
         this.playSingleMovie(url); //媒体播放
         this.playSet(0); //播放设置
    }
    
    //直播小窗口播放
    this.playLittleLive = function(userChannelId,height,width,left,top){
         this.isLive=true;
         this.initMediaPlayByPara(0,height,width,left,top);
         this.joinChannel(userChannelId);
         this.playSet(0); //播放设置
         
    }

    //播放设置
    this.playSet=function(BookMark) {
    	  if(BookMark==0){
    	    this.mp.playFromStart(); //重头开始播放视频  对于直播即实时播放
    	  }else{
    	    this.mp.playByTime(1,BookMark,1); // 
    	  }
    	  
        this.mp.setAllowTrickmodeFlag(this.allowTrickmodeFlag); //是否允许操作
        if (this.nativeUIFlag==0) {
            this.mp.setNativeUIFlag(this.nativeUIFlag); //是否显示UI
            this.mp.setAudioTrackUIFlag(this.audioTrackUIFlag); // 是否显示音轨           
            this.mp.setMuteUIFlag(this.muteFlag); //是否显示 静音      
            this.mp.setAudioVolumeUIFlag(this.audioVolumeUIFlag); //是否显示声音
        }
        //设置播放模式，刷新播放
        this.mp.setVideoDisplayMode(this.videoDisplayMode);
        if (this.videoDisplayMode == 0)
            this.mp.setVideoDisplayArea(this.left, this.top, this.width, this.height)
        this.mp.refreshVideoDisplay();
        this.initSTBTimeDiff();
        this.setTSTVTime( );
        this.mp.setVolume(this.volume);
    }

     // 播放,暂停 事件
    this.playOrPauseEvent = function () {
        this.speed = 1;  
        var status=this.getMediaPlayStatus();
        if (  status==this.STATUS_Play){
         this.mp.pause(); // 暂停
         return media.STATUS_Pause;
        } else {
            this.mp.resume(); //播放
            this.isAutoEnd = true;
            return media.STATUS_Play;
        }
    }
    
    // 播放,暂停 事件
    this.resumePlay = function () {
        this.speed = 1;  
        this.mp.resume(); //播放
        this.isAutoEnd = true;
        return media.STATUS_Play;
    }

    //重新播放
    this.rePlayEvent = function () {
        this.speed = 1; //速度重置
        this.volume = 50; //音量重置
        this.setSinglePlayMode(this.playUrl);
    }

    //停止播放
    this.stopEvent = function () {
        this.clearIntervalProgresssBar(); //清理定时
        this.mp.stop();
        this.isAutoEnd = false; //非自动播放结束
    }


    //快进
    this.fastForwardEvent = function () {
        if (this.speed < 1)
            this.speed = 1;
        this.speed *= this.speedScale;
        if (this.speed <= this.maxSpeed) {
            this.mp.fastForward(this.speed);
        } else {
           this.mp.resume();
           this.speed = 1;
        }
          return this.speed;  
    }

    //快退
    this.fastRewindEvent = function () {
        if (this.speed >= 1)
            this.speed = -1;
        this.speed *= this.speedScale;
        if (this.hoursTimeShift() && this.speed >= this.minSpeed) {
            this.mp.fastRewind(this.speed);
        } else {
           this.mp.resume();
           this.speed = 1;
        }
        return this.speed;
    }
    
    this.hoursTimeShift=function(){
      if(!this.isLive) return true;
      if(((new Date().getTime()-this.TS_NTP_DiffMS)-this.TSTVCurrentTime.getTime())>this.TSShiftTime)
      {
        return false;
      }else{
        return true;
      }
    }

    //增加音量
    this.volumeUpEvent = function () {
        if(this.getMediaPlayStatus()!=this.STATUS_Play) //非播放状态，禁止调音量
           return;
        this.volume =  this.mp.getVolume(); //获得音量
        this.volume += this.voluemScale;
        if (this.volume > this.maxVolume){
          this.volume = this.maxVolume;
        }
            this.mp.setVolume(this.volume);
    }

    //减少音量
    this.volumeDownEvent = function () {
        if(this.getMediaPlayStatus()!=this.STATUS_Play) //非播放状态，禁止调音量
           return;
        this.volume =  this.mp.getVolume(); //获得音量
        this.volume -= this.voluemScale;
        if (this.volume < this.minVolume){
           this.volume = this.minVolume;
         }
           this.mp.setVolume(this.volume);
    }

    //静音
    this.setMuteFlagEvent = function () {
        if(this.getMediaPlayStatus()!=this.STATUS_Play) //非播放状态，禁止调音量
           return;
           
          var muteFlagValue = this.mp.getMuteFlag();
          if (muteFlagValue == 0)
             muteFlagValue = 1;
          else
             muteFlagValue = 0;
         this.mp.setMuteFlag(muteFlagValue);
    }

    // 声道事件
    this.audioChannelEvent=function () {
        if(this.getMediaPlayStatus()!=this.STATUS_Play) //非播放状态，禁止调声道
           return;
        this.mp.switchAudioChannel(); //循环切换声道
        if(this.nativeUIFlag==0 && this.audioTrackUIFlag==0){
          //Left:左声道  Right:右声道 Stereo:立体声 JointStereo:混音
          var audioChannel = this.mp.getCurrentAudioChannel();
        }
    }

    //定位键
    this.getSeekTime = function (tmphour,tmpminute) {
        var tmpstr = this.getRightUTCStrByDateStr(this.TSTVCurrentTime,tmphour,tmpminute,1);
        this.playByTime(tmpstr);
        return tmpstr;
    }
    
    
    //左边界
    this.gotoStartEvent = function(){
      this.mp.gotoStart(); 
    }
    
     //右边界
    this.gotoEndEvent = function(){
      this.mp.gotoEnd();
    }

    //返回事件
    this.backEvent = function () {
        this.mp.pause(); //暂停
        isUserTrickMode = false; //显示界面不能进行其他操作
    }

    //按时间播放
    this.playByTime=function(timestamp) {
        this.mp.playByTime(2, timestamp );
    }
    
    //按时间播放点播
    this.playVodByTime=function(timestamp) {
        this.mp.playByTime(1,timestamp,1);
    }

    //播放频道
    this.joinChannel = function(userChannelId){
    	  this.mp.joinChannel(userChannelId);
    }
    
    //离开当前频道
    this.leaveChannel = function(){
    	 this.mp.leaveChannel();
    }
    
    //获取当前频道号
    this.getCurrentChannelId = function(){
    	 return this.currentChannelId;
    }
    //获取当前频道名
    this.getCurrentChannelName = function(){
    	 return this.currentChannelName;
    }
    //获取当前频道是否时移
    this.getCanTimeShift = function(){
    	 return this.canTimeShift;
    }
    this.getCurrChannelIndex = function(){
    	return this.currChannel_index;
    }
    
    //更改频道号
    this.changeChannel = function(num){
    	  if(this.isLive)
    	  return this.playChannelID(num);
    }
    
    this.nextChannel=function(offset)
    {
		var tmptargetchannel = parseInt(this.currChannel_index) + parseInt(offset);
  		if(tmptargetchannel>this.channelCounts-1)
  		{
  			tmptargetchannel = 0;
  		}
  		if(tmptargetchannel<0)
  		{
  			tmptargetchannel = this.channelCounts-1;
  		}
  		if((tmptargetchannel>=0)&&(tmptargetchannel<=this.channelCounts))
		{		
			  return this.playChannelID( this.allchannels[tmptargetchannel].UserChannelID );
		}
    }
    this.nextChannelAuth=function(offset,isAuth)
    {
		var tmptargetchannel = parseInt(this.currChannel_index) + parseInt(offset);
  		if(tmptargetchannel>this.channelCounts-1)
  		{
  			tmptargetchannel = 0;
  		}
  		if(tmptargetchannel<0)
  		{
  			tmptargetchannel = this.channelCounts-1;
  		}
  		if((tmptargetchannel>=0)&&(tmptargetchannel<=this.channelCounts))
		{		
		    if(isAuth) {
			  return this.playChannelID( this.allchannels[tmptargetchannel].UserChannelID );
			} else {
			  this.currChannel_index=this.getCurUserChannel(this.allchannels[tmptargetchannel].UserChannelID); 
			  //this.playChannelID(0);
			  return 1;	
			}
		}
    }
    
     // UserChannelID TimeShift ChannelName
    this.playChannelID=function (NewChannelID)
    {
       this.currChannel_index=this.getCurUserChannel(NewChannelID); 
       if(this.currChannel_index>-1){
    	   this.UserAuth=this.allchannels[this.currChannel_index].UserAuth;
           this.currentChannelName=this.allchannels[this.currChannel_index].ChannelName;
           this.canTimeShift=this.allchannels[this.currChannel_index].TimeShift;
           this.currentChannelId=this.allchannels[this.currChannel_index].UserChannelID;
           //if(this.UserAuth!=0){
           //  return 1;
          //}
    	   this.mp.joinChannel( this.allchannels[this.currChannel_index].UserChannelID );
    	   return 0;
       }
    }
    
    this.getCurUserChannel=function (channelid)
   {
        try{
            if(this.channelCounts >0)
            {
                for(var i=0;i<this.channelCounts;i++)
               {
                    if(this.allchannels[i].UserChannelID == parseInt(channelid))
                        return i;
               } 
            }
        }catch(err){}
        return -1;
   }
    
    //初始化所有频道
    this.initAllChannels = function(allchannels){
    	 this.allchannels=allchannels;
    	 this.channelCounts=allchannels.length;
    }
    
    
    //上频道
    this.upChannel = function(){
    	  if(this.isLive)
    	    this.nextChannel(1);
    }
    
    //下频道
    this.downChannel = function(){
    	if(this.isLive)
    	 this.nextChannel(-1);
    }
    
    //得到当前是否时移 直播为false 时移为true
    this.getTimeShiftStatus=function (){
     if( this.TSTVCurrentTime >= this.TSTVEndTime){
        return false;
     }else{
         return true;
     }
   }
   
   this.setCurrChannelIndex= function (offset){
   	 this.currChannel_index+=offset;
   } 
    
    //是否正确时移时间
    this.isRightOffTime=function (time,_tmphours,_tmpminutes,offset) {
    var endDate = new Date();
    var startDate = new Date();
    var _tmpDate = new Date();
    startDate.setTime(endDate.getTime()-offset*3600*1000);
    if(endDate.getDay()-startDate.getDay()>0){
      if(parseInt(_tmphours)==23){
       _tmpDate.setDay(startDate.getDay());
      }
    } 
     _tmpDate.setHours(parseInt(_tmphours));　
      _tmpDate.setMinutes(parseInt(_tmpminutes));　　
      _tmpDate.setTime(_tmpDate.getTime());
    
    if((_tmpDate.getTime()-time.getTime())>0)  return false;
    if(((_tmpDate.getTime()-time.getTime())*(-1))>offset*3600*1000) return false;
    return true;
	}

	//得到utc跳转时间
	this.getRightUTCStrByDateStr=function (time,_tmphours,_tmpminutes,offset) {
    var endDate = new Date();
    var startDate = new Date();
    startDate.setTime(endDate.getTime()-offset*3600*1000);
    
    if(endDate.getDay()-startDate.getDay()>0){
      if(parseInt(_tmphours)==23){
       time.setDay(startDate.getDay());
      }
    } 
    time.setHours(parseInt(_tmphours));
    time.setMinutes(parseInt(_tmpminutes));
    time.setTime(time.getTime()-8*3600*1000);
    
    return this.convertUTCTimeString(time);
	}
    
    //本地时间转成utc时间
    this.convertUTCTimeString=function (now) {
    var yy = now.getFullYear(); 
    var mt = (""+(now.getMonth()+1)).length>1?(now.getMonth()+1):("0"+(now.getMonth()+1)); 
    var dd = (""+(now.getDate() )).length>1?(now.getDate() ):("0"+(now.getDate() ));
    var hh = (""+now.getHours()).length>1?(now.getHours()):("0"+now.getHours());
    var mm = (""+now.getMinutes()).length>1?(now.getMinutes()):("0"+now.getMinutes());
    var ss = (""+now.getSeconds()).length>1?(now.getSeconds()):("0"+now.getSeconds()) ;
    //20081014T101625.56Z   
    var dateTime = yy + "" + mt + "" + dd + "T" + hh + "" + mm + "" + ss+".00Z";
    return dateTime;
    }
    
    //utc时间转本地时间
    this.getDateByUTC=function(utcstr) {
    var curDate;
    var curUTCStr = utcstr;
    var ntpdate = new Date();
    if(curUTCStr)
    {
        curUTCStr = utcstr + "";

        var year = curUTCStr.substring(0,4);
        var month = curUTCStr.substring(4,6);
        var day = curUTCStr.substring(6,8);
        var index1 = curUTCStr.indexOf("T");
        var index2 = curUTCStr.length; 
        var hms = curUTCStr.substring(index1+1,index2);
        var hours = hms.substring(0, 2);

        /** 流媒体返回TS的UTC时间不正确 
         *  STB冷重启后第一次调用TS返回UTC+08:00()
         */
        var hoursD8 = (Number(hours) + 8).toString();
        if (Number(hours) == ntpdate.getHours())
            hoursD8 = hours;
        var minutes = hms.substring(2,4);
        var seconds = hms.substring(4,6);
        var dateStr = year + "/" + month + "/" + day + " "
                    + hoursD8 + ":" + minutes + ":" + seconds;
        
        curDate = new Date(dateStr);
    }
    else
        curDate = new Date();
    return curDate;
}
     
     this.getHourMinuteSecond=function (second){
    var tmpret="";
    if(second<0)return "";
    second=parseInt(second);
   var tmphours =parseInt(second/3600);
   var tmpminutes =parseInt(second%3600); 
       tmpminutes = parseInt( tmpminutes/60);
   var tmpseconds = parseInt(second%60);
   
   tmpret += ("00"+tmphours).substring(("00"+tmphours).length-2,("00"+tmphours).length)+":";
   tmpret += ("00"+tmpminutes).substring(("00"+tmpminutes).length-2,("00"+tmpminutes).length)+":";
   tmpret += ("00"+tmpseconds).substring(("00"+tmpseconds).length-2,("00"+tmpseconds).length);
   return tmpret;
}
 
}


     
//电信频道初始化
function CTCGetConfig(name){
	 if(typeof(name)=="undefined")
	    return  "";
	  
	return Authentication.CTCGetConfig(name);
}

//电信频道初始化
function CTCSetConfig(userChannelID,channelURL,timeShiftURL,channelLogURL){
	 if(typeof(channelLogURL)=="undefined")
	    channelLogURL = "";
	 var timeShift = 1;
	 if(typeof(timeShiftURL)=="undefined"){
	 	 timeShift = 0;
	 	 timeShiftURL = "";
	 }  
	 Authentication.CTCSetConfig('Channel','ChannelID="'+userChannelID+'",ChannelName="'+userChannelID+'",UserChannelID="'+userChannelID+'",ChannelURL="'+channelURL+'",TimeShift="'+timeShift+'",ChannelSDP="",TimeShiftURL="'+timeShiftURL+'",ChannelLogoStruct="",ChannelLogURL="'+channelLogURL+'",PositionX="5",PositionY="5",BeginTime="0",Interval="10",Lasting="9",ChannelType="3",ChannelPurchased="0"');
}
 
