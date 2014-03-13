<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*"%>
<%@ include file="keyboard/keydefine.jsp"%>
<%@ page import="com.huawei.iptvmw.epg.util.*"%>
<%@ include file="datajsp/codepage.jsp"%>
<html>
<script>
if (typeof(iPanel) != 'undefined'){iPanel.focusWidth = "2";iPanel.defaultFocusColor = "#FCFF05";}
<%  
	//接口
    TurnPage turnPage = new TurnPage(request);
    ServiceHelp serviceHelp = new ServiceHelp(request);
    MetaData metaData = new MetaData(request);
    ServiceHelpHWCTC serviceHelphwctc = new ServiceHelpHWCTC(request);
	//Trailer播放界面的位置以及大小
    int left = 0;
    int top = 0;
    int width = 640;
    int height = 530;
	int liveid = 1;
	if (request.getParameter("left") != null && !"".equals(request.getParameter("left")))
	{
    	left = Integer.parseInt(request.getParameter("left")) ;
    }
	if (request.getParameter("top") != null && !"".equals(request.getParameter("top")))
    {
		top = Integer.parseInt(request.getParameter("top")) ;
    }
	if (request.getParameter("width") != null && !"".equals(request.getParameter("width")))
    {
		width = Integer.parseInt(request.getParameter("width"));
    }
	if (request.getParameter("height") != null && !"".equals(request.getParameter("height")))
    {
		height = Integer.parseInt(request.getParameter("height"));
	}
	if (request.getParameter("liveid") != null && !"".equals(request.getParameter("liveid")))
    {
		liveid = Integer.parseInt(request.getParameter("liveid"));
	}
	String cut = "0";//窗口视频是否视频
	if(EPGUtil.isValidateUser(request))
	{
		cut = "0";	
	}
	else
	{
		cut = "1";
	}
	//播放类型
    String type = "";
	int typeid = -1;
	String mediacode = "";//节目外部编号
	String value = "";//节目ID
	String strContentType = ""; //播放内容类型
	HashMap ht = new HashMap();//根据内容类型获得对应的内容类型值
	ht.put("VOD","0");
	ht.put("CHAN","1");
	ht.put("TVOD","300");
	HashMap urlparam = new HashMap();//根据播放类型获得对应的播放类型值
	urlparam.put("VOD" ,"1");
	urlparam.put("CHAN","2");
	urlparam.put("TVOD","4");
	//需要的参数：type 播放类型，mediacode 节目外部编号，value 节目id，contenttype 内容类型
    if (request.getParameter("type") != null && !"".equals(request.getParameter("type")))
	{
    	type = request.getParameter("type");
		if(ht.containsKey(type)){typeid = Integer.parseInt((String)ht.get(type));}
	}
	if (request.getParameter("mediacode") != null && !"".equals(request.getParameter("mediacode")))
	{
    	mediacode = request.getParameter("mediacode");
    }
	if (request.getParameter("value") != null && !"".equals(request.getParameter("value")))
	{
    	value = request.getParameter("value");
    }
	if (request.getParameter("contenttype") != null && !"".equals(request.getParameter("contenttype")))
	{
    	strContentType = request.getParameter("contenttype");
    }
		
	/*暂时屏蔽掉20110815*/
	if((value.equals("") && mediacode.equals("")) || typeid == -1) {
	 %>
	    <jsp:forward page="errorinfo.jsp?ERROR_ID=23&ERROR_TYPE=1"/>
	 <%
	}
	String progId = value;//节目id
	
	int progIndex = -1;//节目单编号（可选参数），仅当progId是频道时有效
	
	if(type.equals("TVOD")) //如果是TVOD，根据传来的proid赋值给节目编号progIndex
	{
		progIndex = Integer.parseInt(progId);
	}

	HashMap result = null;
	if(value.equals(""))
	{
		//根据传入的内容的外部编号和内容类型，查找内容的详细信息
		result = metaData.getContentDetailInfoByForeignSN(mediacode,typeid);
		if(result != null)
		{
			if(type.equals("CHAN"))
			{
				progId = ((Integer)result.get("CHANNELID")).toString();
			}else if(type.equals("VOD"))
			{
				progId = ((Integer)result.get("VODID")).toString();
			}
		}
	}
	if(progId.equals("") || progId == null)
	{
		%>
		//alert("PROGI为null");
	    //这里需错误页面
		<%
	}
	//如果播放类型为频道，则根据节目id获取节目单编号
    if(type.equals("CHAN"))
	{
		Map channelInfo = metaData.getChannelInfo(progId);
		if (channelInfo.get("CHANNELINDEX") != null)
		{
			progIndex = ((Integer)channelInfo.get("CHANNELINDEX")).intValue();
		}

	}
	else   //播放类型不是频道的情况下，如果播放节目的ID为空，则赋值
	{
		if(value.equals(""))
		{ 
			progId = ((Integer)result.get("VODID")).toString();
		}
	}
	//根据播放类型获得播放类型值
	int parameter = Integer.parseInt((String)urlparam.get(type));

	String playUrl = null;
	if(type.equals("VOD"))
	{

		HashMap vodInfo = (HashMap)metaData.getVodDetailInfo(Integer.parseInt(progId));
		//根据播放类型等，获取触发节目播放的URL
		playUrl = serviceHelphwctc.getTriggerPlayUrlHWCTC(parameter,Integer.parseInt(progId),progIndex,"0","0","0","0",strContentType);
	}
	else if(type.equals("CHAN"))
	{

		HashMap chanInfo = (HashMap)metaData.getChannelInfo(progId);
		//根据播放类型等，获取触发节目播放的URL
		playUrl = serviceHelphwctc.getTriggerPlayUrlHWCTC(parameter,5,progIndex,"0","0","0","0",strContentType);
	}
	if(playUrl != null && playUrl.length() > 0) //对获得的URL进行处理，得到MediaPlayer需要的url值
    {
		int st=playUrl.indexOf("rtsp");//此为单播，需找华为提供组播测试。
		%>
	   // alert("<%=playUrl%>");
		<%
		if(-1 != st)
		{
			playUrl=playUrl.substring(st,playUrl.length());    
		}
	}
	%>
var cut = "<%=cut%>";

var mp = new MediaPlayer();
var json = '[{mediaUrl:"<%=playUrl%>",';
json +=	'mediaCode: "<%=mediacode%>",';
json +=	'mediaType:1,';
json +=	'audioType:1,';
json +=	'videoType:3,';
json +=	'streamType:2,';
json +=	'drmType:1,';
json +=	'fingerPrint:0,';
json +=	'copyProtection:1,';
json +=	'allowTrickmode:0,';
json +=	'startTime:0,';
json +=	'endTime:10000.3,';
json +=	'entryID:"jsonentry1"}]';
var playStat = "";
var speed = 0;

var channelIndex = <%=progIndex%>;
var playtype = '<%=type%>';
    
/**
*页面初始化
*/
function init()
{	
	initMediaPlay();
	if(playtype == "CHAN")
	{ 
		mp.leaveChannel();
	}
	mp.setSingleMedia(json);
	mp.setAllowTrickmodeFlag(0);
	mp.setNativeUIFlag(1);
	mp.setMuteUIFlag(0);
	if(cut=="1")
	{
		document.getElementById("notice").src = 'images/temp/1.jpg';
		return;	
	}
	play();
	parent.mp = mp;
}
    
/**
*初始化MediaPlay的属性
*/
function initMediaPlay()
{
	var instanceId = mp.getNativePlayerInstanceID();
	var playListFlag = 0;
	var videoDisplayMode = 0;
	var height = 0;
	var width = 0;
	var left = 0;
	var top = 0;
	var muteFlag = 0;
	var subtitleFlag = 0;
	var videoAlpha = 0;
	var cycleFlag = 0;
	var randomFlag = 0;
	var autoDelFlag = 0;        
	var useNativeUIFlag = 1;
	mp.initMediaPlayer(instanceId,playListFlag,videoDisplayMode,height,width,left,top,muteFlag,useNativeUIFlag,subtitleFlag,videoAlpha,cycleFlag,randomFlag,autoDelFlag);
	mp.setChannelNoUIFlag(0);
	mp.setAllowTrickmodeFlag(0); //设置是否允许trick操作。 0:允许 1：不允许
	mp.setNativeUIFlag(0); //播放器是否显示缺省的Native UI，  0:允许 1：不允许
//	mp.setAudioTrackUIFlag(1);//设置音轨的本地UI显示标志 0:不允许 1：允许
        mp.setAudioTrackUIFlag(0); //ztewebkit
//	mp.setMuteUIFlag(1); //设置静音的本地UI显示标志 0:不允许 1：允许
        mp.setMuteUIFlag(0); //ztewebkit
//	mp.setAudioVolumeUIFlag(1);//设置音量调节本地UI的显示标志 0:不允许 1：允许
        mp.setAudioVolumeUIFlag(0); //ztewebkit
}


/**
*开始播放
*/
function play()
{
	  //mp.setVideoDisplayArea(179,92,280,206);
	  mp.setVideoDisplayArea(<%=left%>,<%=top%>,<%=width%>,<%=height%>);
	  mp.setVideoDisplayMode(0);
	  mp.refreshVideoDisplay();
	  if(playtype == "CHAN")
	  {
		   mp.joinChannel(parseInt('<%=liveid%>'));//channelIndex 20111220修改深圳
	  }
	  if(playtype == "VOD"||playtype == "TVOD") 
	  {
		  mp.playFromStart();
	  }
}
	
/**
*如果是频道，则需要加入直播
*/
function joinChannel(index)
{
	channelIndex = index;
	mp.leaveChannel();
	mp.joinChannel(index);
}

/**
*停止播放
*/
function destoryMP()
{
	if(playtype == "CHAN") mp.leaveChannel();
	mp.stop();
}

function getPic()
{
	document.getElementById("notice").src = 'images/temp/1.jpg';
}
</script>
<body bgcolor="transparent" leftmargin="0" topmargin="0" onLoad="init()" onUnload="destoryMP()">

</body>
</html>
