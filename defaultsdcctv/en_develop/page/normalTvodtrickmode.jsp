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
   function showTrickModeDiv(){
		 mediaTime=mediaMg.getOriMediaTime();
		 document.getElementById("stoptrickmode").style.display="block";
		 document.getElementById("trickfullTime").innerText =   mediaMg.getMediaTime();
         document.getElementById("trickbeginTime").innerText =  mediaMg.convertTime(0).substring(0, 5);  
		 var currTime = mediaMg.player.getCurrentPlayTime();	
		 processSeek(currTime);
		 clearTimeout(showTrickTimeoutId);
         showTrickTimeoutId = setTimeout('document.getElementById("stoptrickmode").style.display="none"', 2000);
	}
	
	
	
	function processSeek(_currTime)
    {
		var timePerCell =  mediaTime/ 100;  
        if(_currTime < 0) _currTime = 0;
        var currCellCount = Math.floor(_currTime / timePerCell); 
        if(currCellCount > 100){
            currCellCount = 100;
        }else if(currCellCount < 0){
            currCellCount = 0;
        }
		var processCurTime;
	    processCurTime=mediaMg.convertTime(_currTime).substring(0, 5);  
		document.getElementById("trickcurrTimeShow").innerText = processCurTime;
        document.getElementById("trick1").style.width = currCellCount * 3.6;
        document.getElementById("trick3").style.left = 152+currCellCount * 3.4;	
	} 
</script>

