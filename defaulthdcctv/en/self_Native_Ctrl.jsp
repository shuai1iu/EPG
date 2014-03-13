<!-- 文件名：self_Native_Ctrl.jsp -->
<!-- 描  述：本地页面控制层 -->
<!-- 修改人：zhanghui -->
<!-- 修改时间：2010-8-9-->
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="../../keyboard_A2/keydefine.jsp"%>
<%@ include file = "OneKeySwitch.jsp"%>
<%@ include file = "datajsp/self_Native_Data.jsp"%>
<%@ include file = "config/config_native.jsp"%>
<%@ include file="util/util_GetVodType.jsp"%>
<!--%@ include file="util/util_GetGuideChan.jsp"%-->
<%@ include file="config/config_TrailerInVas.jsp"%>
<script type="text/javascript">
//页面焦点位置
var curr_index=<%=curr_Index%>;
//页面大小
var pageSize=6;
//接受视频流ID
//var progId = "<!%=progId%-->";

var mp;

function init()
{	
	//设置焦点框属性	
	iPanel.firstLinkFocus = 5;  
	iPanel.defaultFocusColor = "#FFFF00";
    iPanel.defaultalinkBgColor = "#FFFF00";
    iPanel.focusWidth = "3"; 
	FreeFocus();
	dataBind();
	SetFocus();
	load_iframe();
}
//播放频道
function load_iframe()
{
	if ("<%=NATIVE_TRAILER_ID%>" != "" && "<%=NATIVE_TRAILER_ID%>" != "null" && "<%=NATIVE_TRAILER_ID%>" != null)
	{
		commonPage.location.href = "PlayTrailerInVas.jsp?left=453&top=8&width=178&height=134&type="+
					"<%=NATIVE_TRAILER_TYPE%>"+"&value=" +"<%=NATIVE_TRAILER_ID%>" +"&mediacode="+ "<%=NATIVE_TRAILER_ID%>" +"&contenttype="+ "<%=NATIVE_TRAILER_CONTENTTYPE%>";
	}
	else 
	{
		document.getElementById("nimg2").src = "images/display/chan/notFilm.jpg";
	}
}
//OK事件
function pressOK()
{	
	var tmpStr = new String();			
	tmpStr = 0+","+curr_index+","+0;
	var url;
	switch(curr_index)
	{
		case 0:/*点击本地节目跳转后的页面*/			
			url="<%=LOCAL_VODINFO%>";
			//return 0;
			break;
			
		case 1:/*点击本地应用跳转后的页面*/			
			url="<%=LOCAL_NATIVE%>";
			return 0;
			break;
			
		case 2:
			//此处是视频流，即点击视频播放窗口后的操作，需联系首页视频流页面开发人员统一操作
			url="<%=NATIVE_fullScreenPlayUrl%>";
			break;
			
		default:
			/*根据对象的nativeObj[i].vodType判断：0-电影 1-电视剧
			下标为[curr_index-3]，curr_index是页面焦点，因为第3-5三个id存放的是图片推荐位，所以需要-3
			传参的标识为vodId*/	
			//-----此处引用util/util_GetVodType.jsp页面
			url=getVodURL(curr_index-3);
						
			break;
	}		
	window.location.href = "SaveCurrFocus.jsp?currFoucs=" + tmpStr + "&url=" + url;
}
//详情URL
function getVodURL(num)
{
	var strVodUrl = null;
	
	if (bRecommFilmId[num] != "" && bRecommFilmId[num] != "null" && bRecommFilmId[num] != null)
	{
		strVodUrl = "vod_FilmDetail_List.jsp?FILM_ID=" + bRecommFilmId[num];
	}
	
	return strVodUrl;
}
//向上事件
function pressUp()
{
	//如果焦点不在第一项即左上角
	if(curr_index>0)
	{
		if (curr_index == 3 && ("<%=NATIVE_TRAILER_ID%>" == "" || "<%=NATIVE_TRAILER_ID%>" == "null" || "<%=NATIVE_TRAILER_ID%>" == null))
		{
			return;
		}		
		FreeFocus();
		--curr_index;
		SetFocus();
	}
	else
	{
		return;
	}
}
//向下事件
function pressDown()
{
	//如果焦点不在最后一项即右下角
	if(curr_index<5)
	{
		if (curr_index == 1 && ("<%=NATIVE_TRAILER_ID%>" == "" || "<%=NATIVE_TRAILER_ID%>" == "null" || "<%=NATIVE_TRAILER_ID%>" == null))
		{
			return;
		}
		if (bRecommFilmId[curr_index-2] != "" && bRecommFilmId[curr_index-2] != "null" && null != bRecommFilmId[curr_index-2] && curr_index >= 2 && curr_index < 5)
		{
			FreeFocus();
			++curr_index;
			SetFocus();	
		}
		if(curr_index>=0&&curr_index<2)
		{
			FreeFocus();
			++curr_index;
			SetFocus();
		}		
	}
	else
	{
		return;
	}
}
//向左事件
function pressLeft()
{
	//如果焦点在右侧
	if(curr_index>1)
	{
		FreeFocus();
		curr_index=0;
		SetFocus();
	}
	else
	{
		return;
	}
}
//向右事件
function pressRight()
{
	//如果焦点在左侧
	if(curr_index<2)
	{
		FreeFocus();
		if ("<%=NATIVE_TRAILER_ID%>" == "" || "<%=NATIVE_TRAILER_ID%>" == "null" || "<%=NATIVE_TRAILER_ID%>" == null)
		{	
			if (bRecommFilmId[curr_index-1] != "" && bRecommFilmId[curr_index-1] != "null" && null != bRecommFilmId[curr_index-1] && curr_index == 1 )
			{
				curr_index=3;
			}
		}
		else
		{
			curr_index=2;
		}
		SetFocus();
	}
	else
	{
		return;
	}
}
//数据绑定
function dataBind()
{
	//绑定图片推荐位的图片地址
	for(var i=0,j=3;i<pageSize-3;i++,j++)
	{		
		if(bRecommFilmId[i] == "" || bRecommFilmId[i] == "null" || null == bRecommFilmId[i])
		{
			bRecommFilmPic[i] = "images/display/chan/Notvod.jpg";
		}
		else if (bRecommFilmPic[i] == "" || bRecommFilmPic[i] == null)
		{
			bRecommFilmPic[i] = "images/display/chan/Notpic.jpg";
		}		
		$("nimg"+j).src=bRecommFilmPic[i];
		$("nimg"+j).style.width=178+'px';
		$("nimg"+j).style.height=104+'px';
	}
}
//设置焦点
function SetFocus()
{
	$("hm"+curr_index).style.visibility="visible";
	$("ahm"+curr_index).focus();
}
//释放焦点
function FreeFocus()
{
	$("hm"+curr_index).style.visibility="hidden";
}
//返回事件
function pressBack()
{
	window.location.href = "<%=turnPage.go(-1)%>";
}


/*监听按钮事件*/
document.onirkeypress = grabEvent;
document.onkeypress = grabEvent;

function grabEvent()
{
	var keycode = event.which;
	switch(keycode)
	{
		case <%=KEY_OK%>:
			pressOK();//OK键
			return 0;
			break;
		case <%=KEY_UP%>:
			pressUp();//向上
			return 0;
			break;
		case <%=KEY_DOWN%>:
			pressDown();//向下
			return 0;
			break;
		case <%=KEY_LEFT%>:
			pressLeft();//向左
			return 0;
			break;
		case <%=KEY_RIGHT%>:
			pressRight();//向右
			return 0;
			break;
		case <%=KEY_PAGEUP %>:
			//pageUp();//向上翻页
			return 0;
			break;
		case <%=KEY_PAGEDOWN%>:
			//pageDown();//向下翻页
			return 0;
			break;
		case <%=KEY_BACKSPACE%>:
		case <%=KEY_RETURN%>:
			pressBack();//返回
			return 0;
			break;
		case <%=KEY_MUTE%>:
			setMuteFlag();
			return false;
			
		default:
			videoControl(keycode);
			break;
	}
		return 1;
}


function setMuteFlag()
	{
	
		volumeDivIsShow = true;
		var muteFlag = mp.getMuteFlag();
		
		
		if(muteFlag == 1)
		{
			mp.setMuteFlag(0);
			if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
			{	
				
				document.getElementById("bottomframe").innerHTML = '<table><tr><td><img src="images/playcontrol/playChannel/muteoff.png"></td></tr></table>';
				bottomTimer = setTimeout("hideBottom();", 5000);
			}
			
		}
		else
		{
			mp.setMuteFlag(1);
			if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
			{
				document.getElementById("bottomframe").innerHTML = '<table><tr><td><img src="images/playcontrol/playChannel/muteon.png"></td></tr></table>';
				bottomTimer = setTimeout("hideBottom();", 5000);
			}
		} 
		
		
	}
	
	function hideBottom()
    {
		volumeDivIsShow = false;
       	document.getElementById("bottomframe").innerHTML = "";
    }

function $(argument)
{
    var element = "";
    if (typeof argument == 'string') {
        element = document.getElementById(argument);
    }
    return element;
}
</script>
