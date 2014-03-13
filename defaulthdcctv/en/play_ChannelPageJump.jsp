<!-- Copyright (C), pukka Tech. Co., Ltd. -->
<!-- Author:mxr -->
<!-- CreateAt:20110905 --> 
<!-- FileName:play_ChannelPageJump.jsp -->

<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<script>
	 if (typeof(iPanel) != 'undefined')
	  {
		iPanel.focusWidth = "4";
		iPanel.defaultFocusColor = "#FCFF05";
	  }
	
	var favoriteUrl = 'query_Favorite.jsp?ISFIRST=1';
	var searchUrl = 'self_Search.jsp';
	var moreUrl = 'vod_Category.jsp?ISFIRST=1';
	var hotUrl = 'vod_HotFilmList.jsp?ISFIRST=1';
	var channelUrl = "play_ControlAction.jsp?COMEFROMFLAG=1&CHANNELNUM=";
	var chanUrl = "chan_RecordList.jsp?ISFIRST=1";
	var tvodUrl = "tvod_progBillByRepertoire.jsp?ISFIRST=1";
	
	
	//一键切换跳转url
	var oneKeySwitchJumpUrl = ''; 
	function videoControl(keyval)
	{	
	  	
		switch(keyval)
        {
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
			case 0x300:   
            		top.TVMS.dealKeyEvent();           	
            		return 0; 
			default:
				break;
		}
		return true;
	}
	
	//按下一键切换键，包括四色键
	function pressKey_oneKeySwitchs(jumpFlag)
	{
		createOneKeySwitch(jumpFlag);
		setTimeout("showOneKeySwitchJumpInfo();",500);
	}

	function jumpOut()
	{
	
		stopChannel();
		mp.leaveChannel();
		mp.stop();
		if(oneKeySwitchJumpInfoIsShow)
		{
			hideOneKeySwitchJumpInfo();
		}
		//setEPG();
		/** add直播信息统 begin **/
		//此出赋值,以防在destoryMP方法中再上报一次
		shiftQuitFlag = 1;
		//如果是预览，不上报
		if(isSubPreview[currChannelIndex] == 1 && isSub[currChannelIndex] == 3)
		{
			stopChannel();
			window.location.href = oneKeySwitchJumpUrl;
			return;
		}
		//时移状态下跳转
		if(null != pr2)
    	{	
			if(business_type == back_type)
			{
    	   		pr2.servletSubmit("2","removeOnPlayUser",pr2.progId);
			}
			else
			{
				pr2.servletSubmit("1","removeOnPlayUser",pr2.progId);
			}
    	}
	   	/** add直播信息统计  end **/ 
		window.location.href = oneKeySwitchJumpUrl;
	}
	
	//生成一键切换层
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
	
	var oneKeySwitchJumpInfoIsShow = false;
	function showOneKeySwitchJumpInfo()
	{
		//1、一键跳转层显示的话，频道列表消失
		//清空频道列表
		if(oneKeySwitchJumpInfoIsShow)
		{
			return ;
		}

		if("false" == channelListFlag)
		{
			hiddenChannelList();
		}	
		//如果miniepg显示，先清空
		if("true" == infoFlag)
		{
			clearTimeout(hiddenTimer);
			hiddenFilmInfo();
		}
		if(quitDivIsShow)
		{
			hideQuitDiv();
		}
		jumpOut();
		oneKeySwitchJumpInfoIsShow = true;
	}
	
	function hideOneKeySwitchJumpInfo()
	{
		if(!oneKeySwitchJumpInfoIsShow)
		{
			return true;
		}
		//setSTB();

		oneKeySwitchJumpInfoIsShow = false;
	}
	

		
</script>

<div id="oneKeySwitchJumpInfo" style="position:absolute; left:10px; top:213px; width:620px; height:300px; display:none; z-index:2">
	<table align="center" border="0">
		<tr>
			<td id="jumpInfo" align="center">
			</td>
		</tr>
		<tr><td height="10"></td></tr>
		<tr>
			<td>
			<table align="center">
				<tr>
					<td>
						<img id="atLeftFocus" src="images/playcontrol/playChannel/sure1.gif"/>
					</td>
					<td>
						<img id="atRightFocus" src="images/playcontrol/playChannel/cancel.gif"/>
					</td>
				</tr>
			</table>
		</td>
		</tr>
	</table>
</div>

