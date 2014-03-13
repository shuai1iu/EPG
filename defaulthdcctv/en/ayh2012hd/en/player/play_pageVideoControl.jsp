<!-- FileName:play_pageVideoControl.jsp -->
<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<script>
if(typeof(iPanel)!= 'undefined'){iPanel.focusWidth = "8"; iPanel.defaultFocusColor = "#2A5BB8";}
var delayTime = 2000;
var lastChannelNotemp = "LastChannelNo";
var lastChannelNo = Authentication.CTCGetConfig(lastChannelNotemp);
var favoriteUrl = 'query_Favorite.jsp?ISFIRST=1';
var searchUrl = 'self_Search.jsp';
var moreUrl = 'vod_Category.jsp?ISFIRST=1';
var hotUrl = 'vod_HotFilmList.jsp?ISFIRST=1';
var channelUrl = "play_ControlChannel.jsp?COMEFROMFLAG=1&CHANNELNUM=";
var chanUrl = "chan_RecordList.jsp?ISFIRST=1";
var tvodUrl = "tvod_progBillByRepertoire.jsp?ISFIRST=1";
var oneKeySwitchJumpUrl = ''; //一键切换跳转url
function videoControl(keyval)
{
	switch(keyval)
	{
		case <%=KEY_BOTTOMLINE%>://直播号下划线
			pressKeyBottomLine();
			break;
		case <%=KEY_0%>:
			pressKeyNum(0);
			break;
		case <%=KEY_1%>:
			pressKeyNum(1);
			break;
		case <%=KEY_2%>:
			pressKeyNum(2);
			break;
		case <%=KEY_3%>:
			pressKeyNum(3);
			break;
		case <%=KEY_4%>:
			pressKeyNum(4);
			break;
		case <%=KEY_5%>:
			pressKeyNum(5);
			break;
		case <%=KEY_6%>:
			pressKeyNum(6);
			break;
		case <%=KEY_7%>:
			pressKeyNum(7);
			break;
		case <%=KEY_8%>:
			pressKeyNum(8);
			break;
		case <%=KEY_9%>:
			pressKeyNum(9);
			break;
		case <%=KEY_BTV%>:
		case <%=KEY_NVOD%>:
				pressKey_oneKeySwitchs("channel");
				return 0;
		case <%=KEY_RED%>:
				pressKey_oneKeySwitchs("channel");
				return 0;
		case <%=KEY_TVOD%>:
				pressKey_oneKeySwitchs("tvod");
				return 0;
		case <%=KEY_GREEN%>:
				pressKey_oneKeySwitchs("tvod");
				return 0;
		case <%=KEY_YELLOW%>:
		case <%=KEY_VOD%>:
				pressKey_oneKeySwitchs("vod");
				return 0;
		case <%=KEY_BLUE%>:	
		case <%=KEY_COMM%>:		
				pressKey_oneKeySwitchs("mySpace");
				return 0;
		case <%=KEY_HELP%>:
				//pressKey_oneKeySwitchs("help");
				return;
		case <%=KEY_FAVORITE%>:
				pressKey_oneKeySwitchs("mySpace");
				return 0;
		case <%=KEY_SEARCH%>:
				pressKey_oneKeySwitchs("search");
				return 0;
		default:
			 break;
	}
	return true;
}
	
	/***********************按键响应 start**************************************************/

function pressKeyNum(num)
{
	if(errorDivIsShow)
	{
		return;
	}
	//showChannelNum(num);20120316
	if(bottomLineCount != 0)
	{			
		if(channelNumCount == bottomLineCount)
		{
			//setTimeout("showJumpInfoAndPause()",delayTime - 1000);20120316
		}
	}
	else
	{
		if(channelInfoDivId != 0)
		{	
			clearTimeout(channelInfoDivId);
			channelInfoDivId = 0;
			
		}
		//channelInfoDivId = setTimeout("showJumpInfoAndPause()",delayTime - 1000);20120316
	}
	
}

function pressKeyBottomLine()
{
	
	if(errorDivIsShow || jumpToChannelInfoIsShow)
	{
		return;
	}
	if(channelInfoDivId != 0)
	{
		clearTimeout(channelInfoDivId);
		channelInfoDivId = 0;
	}
	hideChannelNum();
	showBottomLine();
}

/**
*按下一键切换键，包括四色键
*/
function pressKey_oneKeySwitchs(jumpFlag)
{

	createOneKeySwitch(jumpFlag);

	showOneKeySwitchAndPause();
	

}

/**
*显示跳转到直播层并暂停视频
*/
function showJumpInfoAndPause()
{
	hideAllDiv();
	hideOneKeySwitchJumpInfo();
	pause();
	setTimeout("showJumpToChannelInfo();",500);
}

/**
*显示一键切换层并暂停视频流
*/
function showOneKeySwitchAndPause()
{	
	//alert("0");
	hideJumpToChannelInfo();
	pause();
	//setEPG(); 
	setTimeout("showOneKeySwitchJumpInfo();",500);	
	hideAllDiv();
}
/**
*隐藏一键切换层并暂停视频流
*/
function hideOneKeySwitchDivAndResume()
{
	resume();
	hideOneKeySwitchJumpInfo();	
	
}

/**
*隐藏一键切换层并暂停视频流
*/
function hideJumpToChannelDivAndResume()
{
	resume();
	//setSTB();
	hideJumpToChannelInfo();
}

/***********************按键响应 end**************************************************/

/**
*生成一键切换层
*/
function createOneKeySwitch(jumpFlag)
{
	switch(jumpFlag)
	{
		case 'mySpace':
			oneKeySwitchJumpUrl = favoriteUrl;
			break;
		case 'channel':
			oneKeySwitchJumpUrl = chanUrl;
			break;
		case 'tvod':
			oneKeySwitchJumpUrl = tvodUrl;
			break;
		case 'search':
			oneKeySwitchJumpUrl = searchUrl;
			break;
		case 'vod':
			oneKeySwitchJumpUrl = moreUrl;
			break;
		case 'hot':
			oneKeySwitchJumpUrl = hotUrl;
			break;
		default:
			break;
	}

}

/*********************显示直播号模块 start******************************************/
var channelNum = 0; //用来记录直播号
var cTempChannelNum = ''; //用来记录临时的直播号
var tempChannelNum = 0;
var channelNumCount = 0; //用来记录输入直播号几位
var channelNumIsShow = false;
var channelNumHideId = 0; //直播号延时隐藏id
function showChannelNum(num)
{
	/* 控制直播号与直播下划线之间的关系 */
	if(bottomLineCount != 0)
	{
		if(bottomLineHideId != 0)
		{
			clearTimeout(bottomLineHideId);
			bottomLineHideId == 0;
		}
		
		if(channelNumCount >= bottomLineCount)
		{
			return true;
		}
	}
	
	channelNumCount++;
	
	if(channelNumCount > 3)
	{
		return true;
	}
	
	if(channelNumHideId != 0)
	{
		clearTimeout(channelNumHideId);
		channelNumHideId = 0;
	}
	cTempChannelNum = cTempChannelNum + '' + num;
	tempChannelNum = tempChannelNum * 10 + num;
	
	channelNum = tempChannelNum;
	
	var channelNumDiv = document.getElementById("channelNum");
	
	var divHtml = '<table width=200 height=30><tr align="right"><td><font color=green size=20>';
	divHtml += cTempChannelNum;
	divHtml += '</font></td></tr></table>';
	
	channelNumDiv.innerHTML = divHtml;
	channelNumIsShow = true;
	channelNumHideId = setTimeout("hideChannelNumAndLine()",delayTime);
}

function hideChannelNum()
{
	
	if(!channelNumIsShow)
	{
		return true;
	}
	var channelNumDiv = document.getElementById("channelNum");
	channelNumDiv.innerHTML = '';
	channelNumCount = 0;	
	cTempChannelNum = '';
	tempChannelNum = 0;
	 
	channelNumHideId = 0;
	channelNumIsShow = false;
}

var bottomLineCount = 0; //记录当前页面上的下划线数量
var bottomLineIsShow = false;
var bottomLineHideId = 0; //直播号下划线
function showBottomLine()
{
	bottomLineCount++;
	if(bottomLineCount > 3)
	{
		bottomLineCount = 0;
	}
	
	if(bottomLineHideId != 0)
	{
		clearTimeout(bottomLineHideId);
		bottomLineHideId == 0;
	}

	var bottomLineDiv = document.getElementById("channelBottomLine");
	
	var divHtml = '<table width=200 height=30><tr align="right"><td><font color="green" size="20"  height="30" style="font-weight:900">';
	var tempDivHtml = '';
	for(var i = bottomLineCount;i > 0; i--)
	{
		tempDivHtml += '_'; 
	}
	divHtml += tempDivHtml;
	divHtml += '</font></td></tr></table>';
	
	bottomLineDiv.innerHTML = divHtml;
	bottomLineIsShow = true;
	
	bottomLineHideId = setTimeout("hideBottomLine()",delayTime);
}

function hideBottomLine()
{
	if(!bottomLineIsShow)
	{
		return true;
	}
	
	var bottomLineDiv = document.getElementById("channelBottomLine");
	bottomLineDiv.innerHTML = '';
	
	bottomLineCount = 0;
	bottomLineIsShow = false;
}


/**
*隐藏直播号与直播下划线
*/
function hideChannelNumAndLine()
{
	hideChannelNum();
	hideBottomLine();
}


var jumpToChannelInfoIsShow = false;
var channelInfoDivId = 0; //延时显示直播跳转层id
function showJumpToChannelInfo()
{		
	
	if(bookMarkIsShow())
	{
		//alert("jumpToChannelSBM----");
		jumpToChannelSBM();
	}else
	{
	   //alert("jumpToChannel===");
		jumpToChannel();
	}
	jumpToChannelInfoIsShow = true;
}

function hideJumpToChannelInfo()
{
	if(!jumpToChannelInfoIsShow)
	{
		return true;
	}
	jumpToChannelInfoIsShow = false;
}
/*********************显示直播号模块 end******************************************/
var oneKeySwitchJumpInfoIsShow = false;
function showOneKeySwitchJumpInfo()
{
	if(oneKeySwitchJumpInfoIsShow)
	{
		return true;
		//return 0;
	}
	if(bookMarkIsShow())
	{
		jumpToOneKeySwitchSBM();
	}else
	{
		jumpToOneKeySwitch();
	}	
	oneKeySwitchJumpInfoIsShow = true;
}

function hideOneKeySwitchJumpInfo()
{
	if(!oneKeySwitchJumpInfoIsShow)
	{
		return true;
	}
	oneKeySwitchJumpInfoIsShow = false;
}

function jumpToChannel()
{
	mp.stop();
	
	window.location.href = channelUrl + channelNum;
}

function jumpToChannelSBM()
{
	/*20110822临时屏蔽
	var progTime=mp.getCurrentPlayTime(); //读取当前播放的时间
	var endTime = mp.getMediaDuration(); //该vod播放时长
	
	var SaveReturnUrl="query_BookMarkAction.jsp?ACTION=insert";
	if(fatherId != -1)
	{
		SaveReturnUrl +="&PROGID="+progId+"&BEGINTIME="+progTime+"&SUPVODID="+fatherId + "&ENDTIME="+endTime;	
	}
	else
	{
		SaveReturnUrl +="&PROGID="+progId+"&BEGINTIME="+progTime+ "&ENDTIME="+endTime;
	}
  */
	mp.stop();
	//alert(channelUrl + channelNum);
	window.location.href =  channelUrl + channelNum;
}

function jumpToOneKeySwitch()
{
	mp.stop();
	window.location.href = oneKeySwitchJumpUrl;
}

function jumpToOneKeySwitchSBM()
{

	var progTime=mp.getCurrentPlayTime(); //读取当前播放的时间
	var endTime = mp.getMediaDuration(); //该vod播放时长
	
	var SaveReturnUrl="query_BookMarkAction.jsp?ACTION=insert";
	if(fatherId != -1)
	{
		SaveReturnUrl +="&PROGID="+progId+"&BEGINTIME="+progTime+"&SUPVODID="+fatherId + "&ENDTIME="+endTime;			
	}
	else
	{
		SaveReturnUrl +="&PROGID="+progId+"&BEGINTIME="+progTime+ "&ENDTIME="+endTime;
	}
	mp.stop();
	SaveReturnUrl += "&onekeySwitchTurnPage=" + oneKeySwitchJumpUrl;
	window.location.href = SaveReturnUrl;
}

</script>
<div id="channelNum" style="position:absolute;left:425px; top:8px; width:200px; height:30px; z-index:2">
</div>
<div id="channelBottomLine" style="position:absolute;left:425px; top:10px; width:200px; height:30px; z-index:2">
</div>