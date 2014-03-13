<iframe name="hidden_frame_time" id="hidden_frame_time" style="display:none" width="0" height="0" ></iframe>
<script>
   var timeIndex = 0;
	   refreshServerTime();
	  // setInterval("refreshServerTime()",60000);
function refreshServerTime()
   {
	   $('hidden_frame_time').src= "servertime.jsp?timeid="+timeIndex;
	
   }

   function refreshTimeData(currSeverTime)
   {
	   $("currDate").innerHTML = "<strong>"+currSeverTime + "</strong>";
	   timeIndex ++;
   }
   
</script>