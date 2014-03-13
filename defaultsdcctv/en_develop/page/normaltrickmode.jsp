<div id="stoptrickmode" style="position:absolute;width:640px;height:140px;left:0;top:390px;background-color:#090202;display:none">
	<div style="font-size:18px;left:252px; position:absolute;top:16px;width:300px;color:#FFFFFF" id="timeError">此频道不支持快进</div>
	<div style="font-size:20px;position:absolute;width:80px;color:#FFFFFF;top:35px;left:18px;"></div>
	<div id="trickbeginTime" style="position:absolute;width:65px;height:19px;left:100px;top:35px;font-size:22px;color:#FFFFFF"></div>
	<div id="trickfullTime" style="position:absolute;width:90px;height:19px;left:540px;top:35px;font-size:22px;color:#FFFFFF"></div>
	<div id="trick0" style="position:absolute;left:166px;width:360px;top:40px;height:9px;background-color:#ffffff"></div>
	<div id="trick1" style="position:absolute;left:166px;width:0px;top:40px;height:9px;background-color:#e1981e"></div>
	<div id="trick3" style="position:absolute;left:156px;width:22px;top:33px;height:24px;"><img id="statusImg" src="#"/></div> 
	<!--默认left 156px;-->
	<div id="trickcurrTimeShow" style="position:absolute;width:90px;height:19px;left:320px;top:55px;font-size:22px;color:#FFFFFF"></div>
</div>
<script type="text/javascript">
   var mediaTime;
   function getRelativeTime(currPlayTime)
    {   
    	currPlayTime = parseUtcTime(currPlayTime);		
    	var currTime = new Date(); 
    	var beginTime = new Date(currTime.getTime() - mediaTime * 1000);
    	var relativeTime = (currPlayTime.getTime() - beginTime.getTime())/1000;
    	return relativeTime;
    } 
    // 解析UTC时间为一日期对象
    function parseUtcTime(utcTime)
    {
    	var year = parseInt(utcTime.substr(0, 4));
    	var month = parseInt(utcTime.substr(4, 2));
    	var day = parseInt(utcTime.substr(6, 2));
    	var hour = parseInt(utcTime.substr(9, 2));
    	var min = parseInt(utcTime.substr(11, 2));
    	var sec = parseInt(utcTime.substr(13, 2)); 
    
    	// 处理parseInt("0X")等于零的问题
    	if (month == 0) month = parseInt(utcTime.substr(5,1));
    	if (day == 0) day = parseInt(utcTime.substr(7,1));
    	if (hour == 0) hour = parseInt(utcTime.substr(10,1));
    	if (min == 0) min = parseInt(utcTime.substr(12,1));
    	if (sec == 0) sec = parseInt(utcTime.substr(14,1));
        	 	
   	 	var d =  new Date(year, month -1, day, hour + 8, min, sec);  
		return d;   	 	
    }  
	//得到当前时间  hour:min
	function getCurrTime1()
    {	
    	var currTime = new Date();    	
    	var min = currTime.getMinutes();
    	var sec = currTime.getSeconds();
    	if (sec >= 30) currTime.setMinutes(min + 1);
    	var hour = currTime.getHours();
    	min = currTime.getMinutes();

    	if (hour < 10) hour = "0" + hour;
    	if (min < 10) min = "0" + min;    	
    	return hour + ":" + min;
    }
	 //获得时移开始点  hour:min
    function getShiftBeginTime1()
    {
    	var currTime = new Date();      
    	var beginTime = new Date(currTime.getTime() -  mediaTime* 1000);
    	var min = beginTime.getMinutes();
    	var sec = beginTime.getSeconds();
    	if (sec >= 30) beginTime.setMinutes(min + 1);   	
    	var hour = beginTime.getHours();
    	min = beginTime.getMinutes();
    	if (hour < 10) hour = "0" + hour;
    	if (min < 10) min = "0" + min;   	
    	return hour + ":" + min;    	
    }

	function showTrickModeDiv(){
		 mediaTime=mediaMg.getOriMediaTime();
		 document.getElementById("stoptrickmode").style.display="block";
		 var currTime = getCurrTime1();        
         document.getElementById("trickfullTime").innerText = currTime;
         document.getElementById("trickbeginTime").innerText = getShiftBeginTime1();  
		
		 var currTime = mediaMg.player.getCurrentPlayTime();	
		 
		 processSeek(currTime);
		 clearTimeout(showTrickTimeoutId);
         showTrickTimeoutId = setTimeout('document.getElementById("stoptrickmode").style.display="none"', 2000);
	}
	
	function getCurrPlayTime(currPlayTime)
    {
    	currPlayTime = parseUtcTime(currPlayTime);	
    	var sec = currPlayTime.getSeconds();  
    	var hour = currPlayTime.getHours();
    	var min = currPlayTime.getMinutes();
        if (sec >= 30)
        {
           min = min + 1;
           if(min == 60){
              min = 59;
           }
        }
    	if (hour < 10) hour = "0" + hour;
    	if (min < 10) min = "0" + min;
    	return hour + ":" + min;    	
    } 
	
	function processSeek(_currTime)
    {
		var timePerCell =  mediaTime/ 100;  
        if(_currTime < 0) _currTime = 0;
        var currPlayTime = _currTime;   
        _currTime = getRelativeTime(_currTime); // 得到到前播放相对时间，单位秒 
        var currCellCount = Math.floor(_currTime / timePerCell); 
        if(currCellCount > 100){
            currCellCount = 100;
        }else if(currCellCount < 0){
            currCellCount = 0;
        }
		var processCurTime;
		if(parseInt(_currTime,10)>=3000){
			processCurTime=document.getElementById("trickfullTime").innerText;
		}else{
		    processCurTime = getCurrPlayTime(currPlayTime); 
		}
		document.getElementById("trickcurrTimeShow").innerText = processCurTime;
        document.getElementById("trick1").style.width = currCellCount * 3.6;
        document.getElementById("trick3").style.left = 156+currCellCount * 3.4;	
	} 
</script>

