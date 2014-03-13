<iframe name="hidden_frame_time" id="hidden_frame_time" style="display:none" width="0" height="0" ></iframe>
<script>
   var timeIndex = 0;
	   refreshServerTime();
	   setInterval("refreshServerTime()",60000);
function refreshServerTime()
   {
	   getAJAXData("servertime.jsp?timeid="+timeIndex,refreshTimeData);
	   //$('hidden_frame_time').src= "servertime.jsp?timeid="+timeIndex;
	
   }

   function refreshTimeData(currSeverTime)
   {
	   $("currDate").innerHTML = "<strong>"+currSeverTime + "</strong>";
	   timeIndex ++;
   }
   
</script>
<script>
	if($("topframe")==undefined){
		document.write('<div id="topframe" style="position:absolute;left:600px; top:20px; width:200px; height:30px; z-index:2; color:green;"></div>');
	}
</script>
