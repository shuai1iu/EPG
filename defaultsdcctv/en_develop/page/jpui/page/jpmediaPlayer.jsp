<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="com.huawei.iptvmw.epg.facade.metadata.CommonImpl" %>
<%@ page import="com.huawei.iptvmw.epg.util.xml.DateUtilities" %>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ include file="keydefine.jsp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%
String chanNum = request.getParameter("chanNum")==null?"0":request.getParameter("chanNum").toString();


%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>play_Controlchannel</title>

<script language="javascript">
var mp = parent.mp;

function initMediaPlay()
{
    var instanceId = mp.getNativePlayerInstanceID();
    var playListFlag = 0;
    var videoDisplayMode = 0,useNativeUIFlag = 0;
    var height = 0,width = 0,left = 0,top = 0;
    var muteFlag = 0;
    var subtitleFlag = 0;
    var videoAlpha = 0;
    var cycleFlag = 0;
    var randomFlag = 0;
    var autoDelFlag = 0;
    mp.initMediaPlayer(instanceId,playListFlag,videoDisplayMode,height,width,left,top,muteFlag,useNativeUIFlag,subtitleFlag,videoAlpha,cycleFlag,randomFlag,autoDelFlag);
}

function init()
{

	initMediaPlay();	
    mp.setNativeUIFlag(1); //0不使UI本地显示 		   1本地显示
    mp.setMuteUIFlag(1);  //0静音图标不显示			    1本地显示  
    mp.setAudioVolumeUIFlag(1);//设置音量调节本地UI的显示标志 0:不允许 1：允许
    mp.setAudioTrackUIFlag(1);
	mp.setProgressBarUIFlag(1);
    mp.setChannelNoUIFlag(0); //0不使频道号本地显示 		   1本地显示
	mp.setAllowTrickmodeFlag(0);//0允许媒体快进，快退，暂停  1本地控制许
    mp.setVideoDisplayArea(0, 0, 0, 0);//全屏显示
    mp.setVideoDisplayMode(1); //1:全屏显示
    mp.refreshVideoDisplay(); //调整视频显示，需要上面两函数配合
    mp.joinChannel(<%=chanNum%>);
}

function destoryMP()
{
	mp.leaveChannel();
	mp.stop();
}
</script>
</head>
<body bgcolor="transparent" leftmargin="0" topmargin="0" onLoad="init()" onUnload="destoryMP()">

</body>
</html>
