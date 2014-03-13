<script>
   var timeIndex = 0;
   refreshServerTime();
   setInterval("refreshServerTime()",60000);
   function refreshServerTime()
   {
	   getAJAXData("servertime.jsp?timeid="+timeIndex,refreshTimeData);
   }

   function refreshTimeData(currSeverTime)
   {
	   $("currDate").innerHTML = "<strong>"+currSeverTime + "</strong>";
	   timeIndex ++;
   }
   
</script>
