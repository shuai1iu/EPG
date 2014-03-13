<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file = "keyboard/keydefine.jsp"%>
<html>
<%
	System.out.println("======================================test_trailer===========================");
	System.out.println("=============================================================================");
	System.out.println("=============================================================================");
	ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
	
/*	String[] progId = new String[2];//栏目id
	String[] playType = new String[2];//播放方式
	String[] beginTime = new String[2];//开始时间
	String[] endTime = new String[2];//结束时间
	String[] productId  = new String[2];//产品id
	String[] serviceId = new String[2];//服务id
	String[] contentType = new String[2];//内容方式
*/	
	int progId = 0;//栏目id
	int playType = 0;//播放方式
	String beginTime = new String();//开始时间
	String endTime = new String();//结束时间
	String productId  = new String();//产品id
	//String[] serviceId = new String[];//服务id
	String contentType = new String();//内容方式
	String playUrl = "";
	
	MetaData meta1 = new MetaData(request);

	ArrayList tempVodList = new ArrayList();
	//内容集合
	ArrayList contList = new ArrayList();
	try
		{
		tempVodList = (ArrayList)meta1.getVodListByTypeId("10000100000000090000000000038771",6,0);
		}catch(Exception e)
		{
		 System.out.println("============================获取tvod异常=========================");
		}
		
	if(tempVodList!=null&&tempVodList.size()>0)
		{
			contList = (ArrayList)tempVodList.get(1);
			System.out.println("=======================================contList====================="+contList);
			HashMap content1 = (HashMap)contList.get(0);
			System.out.println("=======================================content1====================="+content1);
			Integer VodId = (Integer)content1.get("VODID");
			HashMap total = (HashMap)tempVodList.get(0);
			
			List trailers = (List)content1.get("CLIPFILES");
			
			
			//vodDetail 正片的详细信息
			Map vodDetail = meta1.getVodDetailInfo(VodId);
			
			//tralerDetail 片花的详细信息
			//Map tralerDetail = meta1.getVodDetailInfo(trailerId);
			
			progId = VodId;
			playType = 1;
			beginTime = (String)vodDetail.get("STARTTIME");
			endTime = (String)vodDetail.get("ENDTIME");
			productId = "0";
			String[] serviceId = (String[])vodDetail.get("SERVICEID");
			contentType = contentType =String.valueOf(EPGConstants.CONTENTTYPE_VOD);
					
			//获取url
			playUrl =  serviceHelpHWCTC.
			getTriggerPlayUrlHWCTC(playType,progId,0,beginTime,endTime,productId,serviceId[0],contentType);
			playUrl = playUrl.substring(12);
			//playBillId只是对频道号有用
		}
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页_央视高清EPG</title>
<meta name="page-view-size" content="1280*720" />
<script	type="text/javascript">
var mp = new MediaPlayer();
//var playUrl = "rtsp://58.60.146.6/PLTV/88888895/224/3221227202/10000100000000060000000000966366_0.smil";
var playUrl = "<%=playUrl%>";
var mediaStr = '[{mediaUrl:"'+ playUrl +'",';
    mediaStr += 'mediaCode: "jsoncode1",';
    mediaStr += 'mediaType:2,';
    mediaStr += 'audioType:1,';
    mediaStr += 'videoType:1,';
    mediaStr += 'streamType:1,';
    mediaStr += 'drmType:1,';
    mediaStr += 'fingerPrint:0,';
    mediaStr += 'copyProtection:1,';
    mediaStr += 'allowTrickmode:1,';
    mediaStr += 'startTime:0,';
    mediaStr += 'endTime:20000,';
    mediaStr += 'entryID:"jsonentry1"}]';
   

function initMediaPlay()
{
    var instanceId = mp.getNativePlayerInstanceID(); //读取本地的媒体播放实例的标识
    var playListFlag = 0; //Media Player 的播放模式。 0：单媒体的播放模式 (默认值)，1: 播放列表的播放模式
    var videoDisplayMode = 1; //MediaPlayer 对象对应的视频窗口的显示模式. 1: 全屏显示2: 按宽度显示，3: 按高度显示
    var height = 0;
    var width = 0;
    var left = 0;
    var top = 0;
    var muteFlag = 0; //0: 设置为有声 (默认值) 1: 设置为静音
    var subtitleFlag = 0; //字幕显示 
    var videoAlpha = 0; //视频的透明度
    var cycleFlag = 0;
    var randomFlag = 0;
    var autoDelFlag = 0;
    var useNativeUIFlag = 1;

    //初始话mediaplayer对象
    mp.initMediaPlayer(instanceId,playListFlag,videoDisplayMode,height,width,left,top,muteFlag,useNativeUIFlag,subtitleFlag,videoAlpha,cycleFlag,randomFlag,autoDelFlag);
    mp.setVideoDisplayArea(0,0,1280,720);
    mp.setVideoDisplayMode(0);
    mp.setAllowTrickmodeFlag(0); //设置是否允许trick操作。 0:允许 1：不允许

    mp.setNativeUIFlag(0); //播放器是否显示缺省的Native UI，  0:允许 1：不允许
    mp.setAudioTrackUIFlag(1);//设置音轨的本地UI显示标志 0:不允许 1：允许

    mp.setMuteUIFlag(1); //设置静音的本地UI显示标志 0:不允许 1：允许
    mp.setAudioVolumeUIFlag(1);//设置音量调节本地UI的显示标志 0:不允许 1：允许
    	alert(<%=beginTime%>);
	alert(playUrl);
	mp.setSingleMedia(mediaStr); //设置媒体播放器播放媒体内容
    mp.refreshVideoDisplay(); //调整视频显示，需要上面两函数配合 
    mp.playFromStart();
	}

document.onkeypress = keyEvent;
function keyEvent()
{
    var val = event.which ? event.which : event.keyCode;
    return keypress(val);
}
function keypress(keycode)
{
    switch(keycode)
    {
 	case 8:keyBack();return 0;//返回
	case 259:keyVolUp();return 0;//KEY_VOL_UP       音量加
	case 260:keyVolDown();return 0;//KEY_VOL_DOWN     音量减
	case 261:keyMute();return 0;//KEY_MUTE         静音
	default:return 1;
    }
}


</script>

</head>
<body onload="initMediaPlay()" bgcolor="transparent">
<div>this is my div</div>
</body>
</html>
