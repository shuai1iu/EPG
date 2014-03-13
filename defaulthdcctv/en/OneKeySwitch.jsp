<html>
<head>
</head>

<script>
	var lastChannelNotemp = "LastChannelNo";
    var lastChannelNo = Authentication.CTCGetConfig(lastChannelNotemp);
	var clearouttime = 3000;
	var vodId ="-1";
	var bottomLineNum = 0;
	var numCount = 0;
	var bottomLineAllNum = 3;
	var bottomLineHideTime = "";
	var Search=0;
	var main_path;
	
	if(document.location.href.lastIndexOf("/special/")==-1)
	{
		main_path = document.location.href.substring(0,document.location.href.lastIndexOf("/")+1);
	}
	else
	{
		main_path = document.location.href.substring(0,document.location.href.lastIndexOf("special"));
	}

	function videoControl(keyval,isSearch)
	{	
		
	
		Search=isSearch;
		switch(keyval)
		{
		    case <%=KEY_0%>:
				inputNum(0);
				return 0;
            case <%=KEY_1%>:
				inputNum(1);
				return 0;
            case <%=KEY_2%>:
				inputNum(2);
				return 0;
            case <%=KEY_3%>:
				inputNum(3);
				return 0;
            case <%=KEY_4%>:
				inputNum(4);
				return 0;
            case <%=KEY_5%>:
				inputNum(5);
				return 0;
            case <%=KEY_6%>:
				inputNum(6);
				return 0;
            case <%=KEY_7%>:
				inputNum(7);
				return 0;
            case <%=KEY_8%>:
				inputNum(8);
				return 0;
            case <%=KEY_9%>:
				inputNum(9);
				return 0;		
			case 283://??
				showBottomLine();
				break;
			case 0x300: 
				eval("eventJson = " + Utility.getEvent());
            	top.TVMS.dealKeyEvent(eventJson);           	
            	return 0; 
			//KEY_BTV  KEY_RED Ч?	
			case <%=KEY_RED%>:
			
					//forwordURL(lastChannelNo);//? 
					
					//var favoUrl = "query_Favorite.jsp?ISFIRST=1";//? vod
					var favoUrl = "chan_RecordList.jsp?ISFIRST=1";//? vod
					window.location.href=favoUrl;
					return 0;
					
			case <%=KEY_BTV%>:
			case <%=KEY_NVOD%>:
				 	var favoUrl = "chan_RecordList.jsp?ISFIRST=1";//? vod
					window.location.href=favoUrl;
					return 0;
			case <%=KEY_TVOD%>:
				    var favoUrl = "tvod_progBillByTimePeriod.jsp";//? vod
					window.location.href=favoUrl;
					return 0;
				    
				  
				  
			//KEY_TVOD  KEY_GREEN Ч? 
			case <%=KEY_GREEN%>:
			
					//var favoUrl = main_path+"self_Search.jsp?ISFIRST=1";//?
					var favoUrl = main_path+"tvod_progBillByRepertoire.jsp?ISFIRST=1";//?
					window.location.href=favoUrl;
					return 0;
			//KEY_VOD  KEY_YELLOW Ч?
			case <%=KEY_YELLOW%>:
			case <%=KEY_VOD%>:
					var favoUrl = main_path+"vod_Category.jsp?MainPage=1&INDEXPAGE=0"+"&ISFIRST=1&subjectType=10|0|4|9999";
					window.location.href=favoUrl;
					return 0;
			//KEY_INFO_URL  KEY_BLUE Ч?	
			case <%=KEY_BLUE%>:
			case <%=KEY_COMM%>:
			
					var favoUrl = main_path+"query_Favorite.jsp?ISFIRST=1";//?
					window.location.href=favoUrl;
					return 0;
			
			case <%=KEY_SEARCH%>:
					var favoUrl = main_path+"self_Search.jsp?ISFIRST=1";//
					window.location.href=favoUrl;     
					return 0;
			case <%=KEY_FAVORITE%>:
					var favoUrl = main_path+"query_Favorite.jsp?ISFIRST=1";//?
					window.location.href=favoUrl;
					return 0;
					
			
			default:
				    return 1;
		}
	}
	var number = 0;
	var timeID = 0;
	var sNumber = "";
	var tmpcount = 0;

	function inputNum(chanNum)
	{
		tmpcount++;
		if(bottomLineNum !=0)
		{
			if(numCount >= bottomLineNum )
			{
				return;
			}
		}
		clearTimeout(timeID);
		clearTimeout(bottomLineHideTime);
		
		bottomLineHideTime = setTimeout("hideBottomLine()",clearouttime);
		numCount++;
		var Nober= number * 10 + chanNum;
		
	
		if(Nober<1000 && tmpcount<=3)
		{
			number = number * 10 + chanNum;

			
			sNumber = sNumber+""+chanNum;
		}
		channelNumAction(sNumber);
		
	
		
		timeID = setTimeout("forwordURL("+ number +")", 1000);
	}
	
	function channelNumAction(num)
    {
        var tabdef = '<table width=200 height=30><tr align="right"><td><font color=green size=20 font-family:黑体>';
        tabdef += num;
        tabdef += '</font></td></tr></table>';
        document.getElementById("showNum").innerHTML=tabdef;
    }
	
	function forwordURL(indx)
	{
		if(numCount < bottomLineNum)
		{
			sNumber = "";
			number  = 0 ;
			tmpcount   = 0 ;
			return;
		}
		//var favoUrl = main_path+"category_DirectPlay.jsp?channelNum="+indx;//?
	
		var favoUrl = main_path+"ChanDirectAction.jsp?chanNum="+indx+"&isSearch="+Search;
		window.location.href=favoUrl;
	}
	
	function showBottomLine()//283
	{
		hideNum();
		if(timeID != "")
		{
			clearTimeout(timeID);
		}
		if(bottomLineHideTime != "")
		{
			clearTimeout(bottomLineHideTime);
		}
		
		if(bottomLineNum < bottomLineAllNum)
		{
			bottomLineNum++;
		}
		else
		{
			bottomLineNum = 0;
		}
		var strBottom = '';
		
		for(var i = 0; i < bottomLineNum; i++)
		{
			
			strBottom += '_';
		}
		
		strBottom += '';
		var tabdef = '<table width=200 height=30><tr align="right"><td><font color=green size=20 font-family:黑体>';
        tabdef += strBottom;
        tabdef += '</font></td></tr></table>';

		document.getElementById("topframe_bottomLine").innerHTML = tabdef;
		bottomLineHideTime = setTimeout("hideBottomLine()",clearouttime);
	}
	
	function hideBottomLine()
	{
		hideNum();
		document.getElementById("topframe_bottomLine").innerHTML = "";
		bottomLineNum = 0;
	}
	
	function hideNum()
	{
		document.getElementById("showNum").innerHTML = "";
		numCount = 0;
		number = 0;
	}

</script>

<div id="showNum"             style="position:absolute;left:375px; top:8px; width:200px; height:30px; z-index:5"></div>
<div id="topframe_bottomLine" style="position:absolute;left:375px; top:8px; width:200px; height:30px; z-index:5"></div>

</html>