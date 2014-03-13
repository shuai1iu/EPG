var isVirtualKey = false; //是否支持虚拟键值
var isUserTrickMode = false; //是否允许用户操作

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
    this.muteFlag = 0; //0: 不使用盒子静音 1:使用盒子静音      
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
    this.maxVolume = 100; //最大音量
    this.voluemScale = 2; //声音刻度
    
    this.timeType = 1; //1:NTP 2:Clock Time

    this.currentTime = 0; //当前时间
    this.totalTime = 0; //总时间
    this.seekScale = 0.03; //时间刻度
    this.seekTimeScale = 0; //定位时间刻度
    this.intervalProgressBar = null; //定时进度条

    this.mediaStr = ""; //媒体播放地址
    //this.isPlay = false;
    this.isAutoEnd = true; //是否自动结束
    this.playUrl = ""; // 播放地址
    
    this.isTimeShift =false; //是否时移
    this.isLive = false; //是否直播
    
    this.playStatus = "play"; // pause //fastForward //fastRewind
	if(this.playStatus == "play")
	{
		this.isPlay = true;
	}
	else
	{
		this.isPlay = false;
	}
    this.speedTimeScale = 0.01; //速度时间刻度 5%
    this.speedTime = 0; //刻度具体值


    //初始化播放
    this.initMediaPlay=function() {
         this.mp = new MediaPlayer();
         if (this.instanceId > 0){
             this.mp.bindNativePlayerInstance(this.instanceId);
         }else{
             this.instanceId = this.mp.getNativePlayerInstanceID();
           }

         this.mp.initMediaPlayer(this.instanceId, this.playListFlag, this.videoDisplayMode, this.height, this.width, this.left, this.top, this.muteFlag, this.nativeUIFlag, this.subtitleFlag, this.videoAlpha, this.cycleFlag, this.randomFlag, this.autoDelFlag);
    
	 }


    //释放媒体对象
    this.releaseMediaPlayer = function() {
      this.mp.releaseMediaPlayer(this.nativePlayerInstanceId);
    }

    //获取简单地址字符串
    this.setSingleMediaStr=function(url) {
        var jsonStr = '[{mediaUrl:"' + url;
        jsonStr += '",mediaCode: "code1",mediaType:2,audioType:1,videoType:1,streamType:1,drmType:1,drmType:1,fingerPrint:0,copyProtection:1,allowTrickmode:1,startTime:0,endTime:5000,entryID:"entry1"}]';
        this.mediaStr=jsonStr;
    }

    //单个影片播放模式
    this.setSinglePlayMode = function (url) {
        this.initMediaPlay();
        this.setSingleMediaStr(url);
        this.playUrl = url;
        this.mp.setSingleMedia(this.mediaStr); //播放单个视频
        this.playSet(); //播放设置
    }
    
    //直播播放模式
    this.setLivePlayMode = function(){
    	 this.initMediaPlay();
    	 this.playSet(); //播放设置
    }


    //播放设置
    this.playSet=function() {
    	  this.mp.playFromStart(); //重头开始播放视频  对于直播即实时播放
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
    }


    //绑定虚拟键值
    this.bindVirtualKeyEvent = function () {
        eval("eventJson = " + Utility.getEvent());
        //alert(eventJson.type);
        var typeStr = eventJson.type;
        switch (typeStr) {
            case "EVENT_MEDIA_ERROR":
                this.ErrorEvent(eventJson);
                break;
            case "EVENT_PLAYMODE_CHANGE":
                this.changeEvent(eventJson);
                break;
            case "EVENT_MEDIA_END":
                this.endEvent(eventJson);
                break;
            case "EVENT_MEDIA_BEGINING":
                this.begingEvent();
                break;
            case "EVENT_GO_CHANNEL":
                this.channelEvent(eventJson);
                break;
            case "EVENT_REMINDER":
                this.reminderEvent(eventJson);
                break;
            case "EVENT_TVMS_MESSAGE":
                this.messageEvent();
                break;
        }
    }

     // 播放,暂停 事件
    this.playOrPauseEvent = function () {
        this.speed = 1;
        if(this.playStatus == "fastForward" || this.playStatus == "fastRewind"){
       	     this.isAutoEnd = true;
	         this.playStatus = "play";
	         //this.playByTime(this.currentTime);
			 this.mp.resume(); //播放
	         MediaPlayerPanel.showPlay();
        }else{      
	        var playMode = this.mp.getPlaybackMode(); //获取模型  //{PlayMode: "Normal Play",Speed:1x}
	        if (playMode.indexOf("Normal Play") > -1){
	            this.mp.pause(); // 暂停
	            this.playStatus = "pause";
	            if(!isVirtualKey){
	              this.isPlay = false;
	              //this.showProgressBar();
	              MediaPlayerPanel.showPause();  
	            }
	        }else {
	            this.mp.resume(); //播放
	            this.playStatus = "play";
				//如果this.isPlay在这里赋值成true,那么一进播放就不会响应声音的加减事件。所以在初始化时赋值。
				this.isPlay = true;
	            this.isAutoEnd = true;
	            if(this.progressBarUIFlag == 0 && !isVirtualKey){
	            	this.clearIntervalProgresssBar();
	              MediaPlayerPanel.showPlay();
	            }
	        }
        }
    }

    //重新播放
    this.rePlayEvent = function () {
        this.speed = 1; //速度重置
        this.volume = this.mp.getVolume(); //音量重置
        this.setSinglePlayMode(this.playUrl);
    }

    //停止播放
    this.dropEvent = function () {
        this.clearIntervalProgresssBar(); //清理定时
        this.currentTime = parseInt(this.mp.getCurrentPlayTime());  //获取当前时间
        this.mp.stop();
        this.isAutoEnd = false; //非自动播放结束
        if(this.progressBarUIFlag == 0)
            MediaPlayerPanel.showStop(this.isAutoEnd,this.currentTime);
    }


    //快进
    this.fastForwardEvent = function () {
      /*  if (this.speed < 1)
            this.speed = 1;
        this.speed *= this.speedScale;
        if (this.speed <= this.maxSpeed) {
            this.mp.fastForward(this.speed);
        } else
            this.speed = this.maxSpeed;
        if(this.progressBarUIFlag == 0 && !isVirtualKey){
        	this.isPlay = false;
        	this.setIntervalProgressBar();
            MediaPlayerPanel.showFastForward(this.speed);
         } */
                
    	if(this.playStatus == "play" || this.playStatus == "pause"){
	        this.currentTime = parseInt(MediaPlayerEx.mp.getCurrentPlayTime());  //获取当前时间
	        this.totalTime = parseInt(MediaPlayerEx.mp.getMediaDuration()); //获取总时长
	    	this.playStatus = "showProgress";
	    	this.speedTime  = parseInt(this.totalTime*this.speedTimeScale);
    	}else{
			return false;
    	}
    	this.isPlay = false;
        MediaPlayerPanel.showProgressBar(this.currentTime,this.totalTime);
    }

    //快退
    this.fastRewindEvent = function () {
      /*  if (this.speed >= 1)
            this.speed = -1;
        this.speed *= this.speedScale;
        if (this.speed >= this.minSpeed) {
            this.mp.fastRewind(this.speed);
        }
        else
            this.speed = this.minSpeed;
        if(this.progressBarUIFlag == 0 && !isVirtualKey){
        	this.isPlay = false;
        	this.setIntervalProgressBar();
            MediaPlayerPanel.showFastRewind(this.speed);
         } */
    	if(this.playStatus == "play" || this.playStatus == "pause"){
	        this.currentTime = parseInt(MediaPlayerEx.mp.getCurrentPlayTime());  //获取当前时间
	        this.totalTime = parseInt(MediaPlayerEx.mp.getMediaDuration()); //获取总时长
	    	this.playStatus = "showProgress";
	    	this.speedTime  = parseInt(this.totalTime*this.speedTimeScale);
    	}else{
			return false;
    	}
    	this.isPlay = false;
        MediaPlayerPanel.showProgressBar(this.currentTime,this.totalTime);
    }

    //增加音量
    this.volumeUpEvent = function () {
        if(!this.isPlay) //非播放状态，禁止调音量
           return;
        this.volume =  this.mp.getVolume(); //获得音量
        this.volume += this.voluemScale;
        if (this.volume > this.maxVolume)
            this.volume = this.maxVolume;
        else {
            this.mp.setVolume(this.volume);
            if(this.nativeUIFlag==0 && this.audioVolumeUIFlag==0)
               MediaPlayerPanel.showVolume(this.volume); //显示声音
        }
    }

    //减少音量
    this.volumeDownEvent = function () {
        if(!this.isPlay) //非播放状态，禁止调音量
           return;
        this.volume =  this.mp.getVolume(); //获得音量
        this.volume -= this.voluemScale;
        if (this.volume < this.minVolume)
            this.volume = this.minVolume;
        else {
            this.mp.setVolume(this.volume);
            if(this.nativeUIFlag==0 && this.audioVolumeUIFlag==0)
               MediaPlayerPanel.showVolume(this.volume); //显示声音
        }
    }

    //静音
    this.setMuteFlagEvent = function () {
        if(!this.isPlay) //非播放状态，禁止调音量
           return;
        if(this.nativeUIFlag==0 && this.muteFlag==0){
          var muteFlagValue = this.mp.getMuteFlag();
          if (muteFlagValue == 0)
             muteFlagValue = 1;
          else
             muteFlagValue = 0;
         this.mp.setMuteFlag(muteFlagValue);
          MediaPlayerPanel.showMuteFlag(muteFlagValue);//显示静音
       }
    }

    // 声道事件
    this.audioChannelEvent=function () {
        if(!this.isPlay) //非播放状态，禁止调声道
           return;
        this.mp.switchAudioChannel(); //循环切换声道
        if(this.nativeUIFlag==0 && this.audioTrackUIFlag==0){
          //Left:左声道  Right:右声道 Stereo:立体声 JointStereo:混音
          var audioChannel = this.mp.getCurrentAudioChannel();
          MediaPlayerPanel.showAudioChannel(audioChannel); //显示声道
        }
    }

    //定位键
    this.seekEvent = function () {
        if(!this.isPlay) //非播放状态，禁止定位
            return;
        if (!this.isOpenSeek) {
            this.isOpenSeek = true;
            if(this.progressBarUIFlag == 0)
          	  this.setIntervalProgressBar();
            MediaPlayerPanel.showSeek();
			this.playStatus = "play"
            //this.mp.pause(); // 暂停
        } else {
            //this.playByTime(this.currentTime); //播放当前时间
            if(this.progressBarUIFlag == 0)
            	this.clearIntervalProgresssBar();
            MediaPlayerPanel.hideSeek();
            this.isOpenSeek = false;
			this.playStatus = "play"
        }
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
        MediaPlayerPanel.showBack(); //显示返回
    }

    //按时间播放
    this.playByTime=function(timestamp) {
		this.playStatus == "play"
		this.isPlay = true;
		//document.getElementById("chengzhichaoTest").innerHTML=this.playStatus;
        this.mp.playByTime(this.timeType, timestamp, this.speed);
        if(this.progressBarUIFlag == 0)
        	this.clearIntervalProgresssBar();
        MediaPlayerPanel.hideSeek();
        this.isOpenSeek = false;
    }

    //显示当前时间
    this.showProgressBar=function() {
	    	if(this.isLive){
	    		var dateTime = new Date();
	    		//alert(MediaPlayerEx.mp.getCurrentPlayTime()+"; "+dateTime+"; "+dateTime.getTime());
	    	}else{
	        this.currentTime = parseInt(MediaPlayerEx.mp.getCurrentPlayTime());  //获取当前时间
	        this.totalTime = parseInt(MediaPlayerEx.mp.getMediaDuration()); //获取总时长
	        MediaPlayerPanel.showProgressBar(this.currentTime,this.totalTime);
	        //MediaPlayerPanel.showProgressBar(this.currentTime,this.totalTime);
	      }
    }

    //更改事件
    this.changeEvent = function (eventJson) {
    	  if(this.isLive && !this.isTimeShift)
    	    this.isTimeShift=true;
        if (this.nativeUIFlag == 0) {
            // 0:stop 1:pause 2:normal play 3:trick mode(快进，快退，慢进，慢退)
            var new_play_mode = eventJson.new_play_mode;
            var new_play_rate = eventJson.new_play_rate;
            //alert(new_play_mode);
            switch (new_play_mode) {
                case 0:
                    break;
                case 1:
                    this.isPlay = false;
                    if (this.progressBarUIFlag == 0 && isVirtualKey){
                        this.showProgressBar();
                        MediaPlayerPanel.showPause(); //显示暂停
                     }
                    break;
                case 2:
                    this.isPlay = true;
                    isUserTrickMode = true;
                    if (this.progressBarUIFlag == 0 && isVirtualKey) {
                        this.clearIntervalProgresssBar();
                        MediaPlayerPanel.showPlay(); //显示播放
                    }
                    break;
                case 3:
                    this.isPlay = false;
                    if (this.progressBarUIFlag == 0 && isVirtualKey) {
                    	  if(new_play_rate<0)
                    	     MediaPlayerPanel.showFastRewind(new_play_rate); //快退
                    	  else
                    	  	  MediaPlayerPanel.showFastForward(new_play_rate);  //快进 
                        this.setIntervalProgressBar();
                    }
                    break;
            }
        }
    }

    //起始事件
    this.begingEvent = function (eventJson) {
        //var entry_id = eventJson.entry_id;
        //onKeyPlay(); //显示播放
        if(this.isLive && this.isTimeShift)
    	    this.isTimeShift=false;
    }

    //结束事件
    this.endEvent = function (eventJson) {
        var entry_id = eventJson.entry_id;
		
        //自动播放完提示
        if (!this.isLive && this.isAutoEnd) {
            //setTimeout("MediaPlayerEx.mp.pause()",100); //暂停播放
            isUserTrickMode = false; //显示界面不能进行其他操作 
			
            MediaPlayerPanel.showStop(this.isAutoEnd,0); //结束
			
        }
        if(this.isLive && this.isTimeShift)
    	    this.isTimeShift=false;
    }


    //频道事件
    this.channelEvent = function (eventJson) {
        var channel_num = eventJson.channel_num; //频道号
        isUserTrickMode = true;
        if(this.isLive && this.isTimeShift)
    	    this.isTimeShift=false;
    	  if(isVirtualKey)  
    	     MediaPlayerPanel.showChannel(channel_num);
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
    this.getChannelNum = function(){
    	 return this.mp.getChannelNum();
    }
    
    //更改频道号
    this.changeChannel = function(num){
    	  var userChannelId = this.getChannelNum();
    	  var newChannel = parseInt(userChannelId)+num;
    	  this.joinChannel(newChannel);
    	  if(!isVirtualKey)  
    	     MediaPlayerPanel.showChannel(newChannel);
    }
    
    //上频道
    this.upChannel = function(){
    	  if(this.isLive)
    	    this.changeChannel(1);
    }
    
    //下频道
    this.downChannel = function(){
    	if(this.isLive)
    	 this.changeChannel(-1);
    }

    //单个播放
    this.singlePlay = function (url) {
       // if(this.allowTrickmodeFlag==0)
       //   MediaKeyEventBind(); //键值绑定
        this.setSinglePlayMode(url); //媒体播放
    }
    
     //单个播放
    this.singleSizePlay = function (url,left,top,width,height) {
         this.videoDisplayMode=0;
         this.left=left;
         this.top=top; 
         this.width=width;
         this.height=height;
         this.setSinglePlayMode(url); //媒体播放
    }
    
    //直播播放
    this.livePlay = function(userChannelId){
    	 this.isLive = true;
    	 this.setLivePlayMode();
    	 this.joinChannel(userChannelId);
    }
    
    this.liveSizePlay = function(userChannelId,left,top,width,height){
    	   this.videoDisplayMode=0;
         this.left=left;
         this.top=top; 
         this.width=width;
         this.height=height;
         this.livePlay(userChannelId);
    }

    //设置定时进度条
    this.setIntervalProgressBar=function() {
        this.clearIntervalProgresssBar(); //清理定时
        this.intervalProgressBar = window.setInterval(this.showProgressBar,1000);
    }

    //清理定时进度条
    this.clearIntervalProgresssBar=function() {
        if (this.intervalProgressBar!=null){
          window.clearInterval(this.intervalProgressBar);
          this.intervalProgressBar = null;
         }
    }
}

var MediaPlayerEx = new MediaPlayerExClass();

//播放容器
function MediaPlayerPanelObj(){
	 this.showPlay = function(){}; //播放
	 this.showPause = function(){}; //暂停
	 this.showProgressBar = function(currentTime,totalTime){}; //进度条
	 this.showFastForward = function(speed){};  //快进
	 this.showFastRewind = function(speed){}; //快退
	 this.showMuteFlag = function(muteFlagValue){};   //静音
	 this.showAudioChannel=function(audioChannel){}; //声道
	 this.showVolume = function(volume){}; //声音
	 this.showStop = function(isAutoEnd,currentTime){}; //停止
	 this.showSeek = function(){}; //显示seek
	 this.hideSeek = function(){}; //关闭seek
	 this.showMediaError =function(message){}; //显示错误信息
	 this.showChannel = function(channelNum){}; //显示频道
	 this.showBack = function(){}; //显示返回
}
function MediaPlayerPanelClass() {}
MediaPlayerPanelClass.prototype = new MediaPlayerPanelObj();
var MediaPlayerPanel = new MediaPlayerPanelClass();



//电信频道初始化
function CTCSetConfig(userChannelID,channelURL,timeShiftURL,channelLogURL){
	 timeShift = 1;
	 if(typeof(channelLogURL)=="undefined")
	    channelLogURL = "";
	 var timeShift = 1;
	 if(typeof(timeShiftURL)=="undefined"){
	 	 timeShift = 0;
	 	 timeShiftURL = "";
	 }  
	 Authentication.CTCSetConfig('Channel','ChannelID="'+userChannelID+'",ChannelName="'+userChannelID+'",UserChannelID="'+userChannelID+'",ChannelURL="'+channelURL+'",TimeShift="'+timeShift+'",ChannelSDP="",TimeShiftURL="'+timeShiftURL+'",ChannelLogoStruct="",ChannelLogURL="'+channelLogURL+'",PositionX="5",PositionY="5",BeginTime="0",Interval="10",Lasting="9",ChannelType="3",ChannelPurchased="0"');
}

//联通频道初始化
function CUSetConfig(userChannelID,channelURL,timeShiftURL,channelLogURL){
	 timeShift = 1;
	 if(typeof(channelLogURL)=="undefined")
	    channelLogURL = "";
	 var timeShift = 1;
	 if(typeof(timeShiftURL)=="undefined"){
	 	 timeShift = 0;
	 	 timeShiftURL = "";
	 }  
	 Authentication.CUSetConfig('Channel','ChannelID="'+userChannelID+'",ChannelName="'+userChannelID+'",UserChannelID="'+userChannelID+'",ChannelURL="'+channelURL+'",TimeShift="'+timeShift+'",ChannelSDP="",TimeShiftURL="'+timeShiftURL+'",ChannelLogoStruct="",ChannelLogURL="'+channelLogURL+'",PositionX="5",PositionY="5",BeginTime="0",Interval="10",Lasting="9",ChannelType="3",ChannelPurchased="0"');
}