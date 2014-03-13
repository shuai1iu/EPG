
<script>
   var timeIndex = 0;
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
