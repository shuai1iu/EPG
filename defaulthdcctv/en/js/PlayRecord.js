<script>
function PlayRecordStat(type)
{	
	// 提交标志.防止同一页面反复提交
	this.flag = 0;
	this.beginTime = 0;
	this.endTime = 0;
	this.elapseTime = 0;
	this.playType = type;
	this.progId = 0;
	this.pop = "";
	this.timeShift = 0;
	
	this.shiftState = 0;
	this.shiftBeginTime = 0;
	this.shiftEndTime = 0;
	
	this.submit = function(nextUrl)
	{
      if(this.progId == "-1" || "null" == this.progId)
	    {
	       window.location = nextUrl;
	    }
	    if (this.beginTime == 0)
		{
			return;
		}
		
		if (this.flag == 1)
		{
			return;
		}
		else
		{
			this.flag = 1;
		}
		
		this.endShift();
		
		this.endTime = new Date();
		this.elapseTime = Math.round((this.endTime - this.beginTime)/1000);						
		this.beginTime = formatDate(this.beginTime);
		this.endTime = formatDate(this.endTime);
		var submitDef = "";
		submitDef += "PlayRecord.jsp?playRecord=" + this.beginTime + "|";
		submitDef += this.endTime + "|" + this.elapseTime + "|";
		submitDef += this.playType+ "|" + this.progId + "|";
		submitDef += this.pop + "|" + this.timeShift;
		if (nextUrl != undefined && nextUrl != "undefined")
		{
			submitDef += "&pageName=" + nextUrl;
		}
		
		window.location = submitDef;
		
	};	
	
	
	this.localSubmit = function()
	{
	    // add by wangshengli 2008-06-28 AB4D06927  begin
	    //防止频道不存在时，提交播放统计信息
	    if(this.progId == "-1")
	    {
	        return;
	    }
	    // add by wangshengli 2008-06-28 AB4D06927  end
		if (this.beginTime == 0)
		{
			return;
		}
		
		if (this.flag == 1)
		{
			return;
		}
		else
		{
			this.flag = 1;
		}
		
		this.endShift();
				
		this.endTime = new Date();
		this.elapseTime = Math.round((this.endTime - this.beginTime)/1000);
						
		this.beginTime = formatDate(this.beginTime);
		this.endTime = formatDate(this.endTime);
		var submitDef = "";
		submitDef += "PlayRecord.jsp?playRecord=" + this.beginTime + "|";
		submitDef += this.endTime + "|" + this.elapseTime + "|";
		submitDef += this.playType+ "|" + this.progId + "|";
		submitDef += this.pop + "|" + this.timeShift;		
		document.getElementById("prFrame").src = submitDef;
		
	};
	
	 /*******add by jiangdanian for IPTV MEM V100R001C03B310 at 2008-05-17 begin****/
	this.servletSubmit = function(status,type,chan)
	{
	    // add by wangshengli 2008-06-28 AB4D06927  begin
	    //防止频道不存在时，提交播放统计信息
		if(chan == "-1")
		{
		    return;
		}
		// add by wangshengli 2008-06-28 AB4D06927  end
		
		var submitDef = "";
		submitDef += "/EPG/jsp/EPGServlet?action_type=PLAYRECORD&recordType="+type+"&progId="+chan+"&playType="+status;
		document.getElementById("onPrFrame").src = submitDef;
	};
	
	//在一个页面执行两次提交需要通过两个iframe，所以这里用两个提交方法
	this.servletSubmit2 = function(status,type,chan,nextChan)
	{
	    // add by wangshengli 2008-06-28 AB4D06927  begin
	    //防止频道不存在时，提交播放统计信息
		if(chan == "-1" || nextChan == "-1")
		{
		    return;
		}
		// add by wangshengli 2008-06-28 AB4D06927  end
		
		var submitDef = "";
		submitDef += "/EPG/jsp/EPGServlet?action_type=PLAYRECORD&recordType="+type+"&progId="+chan+"&playType="+status+"&nextChan="+nextChan;
		document.getElementById("onPrFrame2").src = submitDef;
	};
	
	/********add by jiangdanian for IPTV MEM V100R001C03B310 at 2008-05-17 end****/
	
	this.endShift = function()
	{
		if (this.shiftState == 0)
		{
			return;
		}
		
		this.shiftState = 0;
		this.shiftEndTime = new Date();
		this.timeShift += Math.round((this.shiftEndTime - this.shiftBeginTime)/1000);
	};
	
	this.beginShift = function()
	{
		if (this.shiftState == 1)
		{
			return;
		}
		else
		{
			this.shiftState = 1;
			this.shiftBeginTime = new Date();
		}
	};
}


function formatDate(dateobj)
{
	var year = dateobj.getYear();
	var month = dateobj.getMonth() + 1;
	var day = dateobj.getDate();
	var hour = dateobj.getHours();
	var min = dateobj.getMinutes();
	var sec = dateobj.getSeconds();
	
	if (month < 10)
		month = "0" + month;
	if (day < 10)
		day = "0" + day;
	if (hour < 10)
		hour = "0" + hour;
	if (min < 10)
		min = "0" + min;
			if (sec < 10)
		sec = "0" + sec;

	var dateStr = "" + year  + month  + day + hour  + min  + sec;
	
	return dateStr;
}

</script>