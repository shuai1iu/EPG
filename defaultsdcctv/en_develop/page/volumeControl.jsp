<div id="volumeDiv" style="width: 400px; height: 50px; position: absolute; left: 140px; top: 420px; background-color: #333;display:none;">
	<div id="actionImg" style="position: absolute; top: 12px; left: 12px; width: 29px; height: 30px;"></div>
	<div style="position: absolute; top: 20px; left: 40px; width: 300px; height: 13px; z-index: 1; background-color: #969696;"></div>
	<div id="progressDiv" style="position: absolute; top: 20px; left: 40px; width: 1px; height: 13px; z-index: 2; background-color: #b72c2c;"></div>
    <div id="volumeNum" style="position: absolute;top: 16px;left: 345px;color: #FFFFFF;font-size: 20px;"></div>
</div>
<img id="audioChannelimg"  style="position:absolute;left:20px;top:8px;" src="#"></img>
<img id="mutecloseimg"  style="position:absolute;left:20px;top:11px;" src="#"></img>
<div style="display: none;">
  <img src="../images/play/volume_down.png"></img>
  <img src="../images/play/volume_up.png"></img>
  <img src="../images/play/mute_stop.png"></img>
  <img src="../images/play/mute_start.png"></img>
  <img src="../images/play/leftvoice.png"></img>
  <img src="../images/play/rightvoice.png"></img>
  <img src="../images/play/centervoice.png"></img>
  <img src="../images/play/muteon.png"></img>
</div>
<script type="text/javascript">
var volumeTimer = -1;
var currentVolume;
var voiceflag;
function changeAudio()
{
    mediaMg.player.switchAudioChannel();
    var audio = mediaMg.player.getCurrentAudioChannel(); 
	if(audio=="0" || audio=="Left"){ audio=0;}
	else if(audio=="1" ||  audio=="Right"){ audio=1;	}
	else if(audio=="2" ||  audio=="JointStereo" ||  audio=="Stereo"){ audio=2;	}
	clearTimeout(voiceflag);
	
	switch(audio)
	{
		
		case 0:
		$("audioChannelimg").src="../images/play/leftvoice.png";
		break;
		case 1:
		$("audioChannelimg").src="../images/play/rightvoice.png";
		break;
		case 2:
		$("audioChannelimg").src="../images/play/centervoice.png";
		break;
		default:
		break;
	}
	voiceflag=setTimeout('$("audioChannelimg").src="../images/play/dot.gif";',5000);
}


function volumeUp(){
	$("mutecloseimg").src="../images/play/dot.gif";
	var volume = mediaMg.player.getVolume();
    if (volume >= 100) {
        volume = 100;
    } else if (volume < 0) {
        volume = 0;
    } else {
        volume += 5;
    }
    currentVolume=volume;
    mediaMg.player.setVolume(volume);
    showVolumeDiv(1,volume);
}

function volumeDown(){
	$("mutecloseimg").src="../images/play/dot.gif";
    var volume = mediaMg.player.getVolume();
    if (volume > 100) {
        volume = 100;
    } else if (volume < 5) {
        volume = 0;
    } else {
        volume -= 5;
    }
    currentVolume=volume;
    mediaMg.player.setVolume(volume);
    showVolumeDiv(0,volume);
}

function setMuteFlag(){
	 
    var muteFlag = mediaMg.player.getMuteFlag();
	var volume;
    if (muteFlag == 1)
    {
        mediaMg.player.setMuteFlag(0);
		volume=mediaMg.player.getVolume();
		showVolumeDiv(2,volume);
		$("mutecloseimg").src="../images/play/dot.gif";
    }
    if (muteFlag == 0)
    {
        mediaMg.player.setMuteFlag(1);
		volume=0;
		showVolumeDiv(3,volume);
		$("mutecloseimg").src="../images/play/muteon.png";
    }
}

function showVolumeDiv(action,volume) {
   clearTimeout(volumeTimer);
   document.getElementById("volumeDiv").style.display = "block";
   
   if (action == 0) {
     if (volume == 0) {
	       document.getElementById("actionImg").innerHTML = "<img src=\"../images/play/mute_stop.png\"></img>";
	   } else {
	       document.getElementById("actionImg").innerHTML = "<img src=\"../images/play/volume_down.png\"></img>";
	   }
   } 
   else if(action == 1){
        document.getElementById("actionImg").innerHTML = "<img src=\"../images/play/volume_up.png\"></img>";
   }else if(action == 2){
   	   document.getElementById("actionImg").innerHTML = "<img src=\"../images/play/mute_start.png\"></img>";
   }else if(action == 3){
   	   document.getElementById("actionImg").innerHTML = "<img src=\"../images/play/mute_stop.png\"></img>";
   }
   
   var percent = parseFloat(volume / 100 , 10);
   var _progressWidth = parseFloat(300 * percent , 10);
   if(_progressWidth <= 0) _progressWidth = 1;
   document.getElementById("progressDiv").style.width = _progressWidth + "px";
   
   volume = volume;
   document.getElementById("volumeNum").innerText =  volume;
   volumeTimer = setTimeout("disableVolumeDiv()",3000);
}

function disableVolumeDiv(){
   document.getElementById("volumeDiv").style.display = "none";
}
</script>
