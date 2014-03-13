<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><%@ include file="../common/golbal.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>标清点播</title>
<%@ include file="../datasource/datasource.jsp" %>
<%
   DataSource dataSource = new DataSource(request); 
   
    int left = 0;
    int top = 0;
    int width = 680;
    int height = 381;
	String categoryId = "";
	if (request.getParameter("_left") != null && !"".equals(request.getParameter("_left")))
	{
    	left = Integer.parseInt(request.getParameter("_left")) ;
    }
	if (request.getParameter("_top") != null && !"".equals(request.getParameter("_top")))
    {
		top = Integer.parseInt(request.getParameter("_top")) ;
    }
	if (request.getParameter("_width") != null && !"".equals(request.getParameter("_width")))
    {
		width = Integer.parseInt(request.getParameter("_width"));
    }
	if (request.getParameter("_height") != null && !"".equals(request.getParameter("_height")))
    {
		height = Integer.parseInt(request.getParameter("_height"));
	}
	if (request.getParameter("categoryId") != null && !"".equals(request.getParameter("categoryId")))
    {
		categoryId = dataSource.huaWeiUtil.getString(request.getParameter("categoryId"));
	}

	String progId = request.getParameter("progId");
	int iProgId = Integer.parseInt(progId);
	
	//栏目下面的所有的影片轮播的方式处理
	List vodList = new ArrayList();
	List vodPlayUrl = new ArrayList();
	if(categoryId!=null&&categoryId!=""){
		   EpgResult vodLists=dataSource.getVodInfoListByTypeId(1,10,categoryId,"0");
		   if(vodLists!=null&&vodLists.getResultcode()==0&&vodLists.getDatas()!=null) {
			   vodList = (List)vodLists.getDatas();
			   int vodlen = vodList.size();
			   int vodId = 0;
			   String vodUrl = "";
			   for(int i = 0;i < vodlen;i++){
					vodId = dataSource.huaWeiUtil.getInt(((TblCmsProgram)vodList.get(i)).getDsubvodidlist().get(0));
					vodUrl = dataSource.getVodUrl(1,vodId,1,"0","200000","0","0","0");
				    if(vodUrl != null && vodUrl.length() > 0)
					{
						int tmpPosition = vodUrl.indexOf("rtsp");
						if(-1 != tmpPosition)
						{
							vodUrl = vodUrl.substring(tmpPosition,vodUrl.length());
						}
					}
				    vodPlayUrl.add(vodUrl);
			   }
		   }
	}else{
		String playUrl = dataSource.getVodUrl(1,iProgId,1,"0","200000","0","0","0");
		if(playUrl != null && playUrl.length() > 0)
		{
			int tmpPosition = playUrl.indexOf("rtsp");
			if(-1 != tmpPosition)
			{
				playUrl = playUrl.substring(tmpPosition,playUrl.length());
			}
		}
		vodPlayUrl.add(playUrl);
	}

	//playUrl = serviceHelpHWCTC.getTriggerPlayUrlHWCTC(1,96785890,1,"0","200000","0","0","0");
%>
<script>
var subNum = 0;//当前的集数
var totalNum = 1;//总集数
var mediaStr = "";
var backUrl = "<%=static_en%>/page/index.jsp";
var playUrl ='<%=vodPlayUrl.get(0)%>';
var playUrlList = new Array();
<%
 if(vodPlayUrl!=null && vodPlayUrl.size()>0)
 {
	int len = vodPlayUrl.size();
	for(int i=0;i<len;i++){ 
		%>
		playUrlList[<%=i%>] = "<%=vodPlayUrl.get(i)%>";
		<% 
 	}
	%>
	totalNum = <%=len %>;
	<%
 }
%>

/******************在iframe页面赋值的参数 end********************************/
function initMediaStr(){
	mediaStr = '[';
	for(var i=2;i>=0;i--){
		playUrl = playUrlList[i];
		mediaStr = '{mediaUrl:"'+ playUrl +'",';
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
		mediaStr += 'entryID:"jsonentry1"}';
		if(i>0){mediaStr += ',';}
	}
	mediaStr += ']';
}
	
var mp = new MediaPlayer();//播放器对象	
/**
*初始化mediaPlay对象
*/
function initMediaPlay()
{
    var instanceId = mp.getNativePlayerInstanceID();
    var playListFlag = 1;
    var videoDisplayMode = 1,useNativeUIFlag = 1;
    var height = <%=height%>,width = <%=width%>,left = <%=left%>,top = <%=top%>;
    var muteFlag = 0;
    var subtitleFlag = 0;
    var videoAlpha = 0;
    var cycleFlag = 0;
    var randomFlag = 0;
    var autoDelFlag = 0;
    mp.initMediaPlayer(instanceId,playListFlag,videoDisplayMode,height,width,left,top,muteFlag,useNativeUIFlag,subtitleFlag,videoAlpha,cycleFlag,randomFlag,autoDelFlag);
}
/**
*播放
*/
function init()
{
	initMediaPlay();
	pkPlay();
	parent.mp = mp;
}

function pkPlay(){
	initMediaStr();
	mp.SingleOrPlayListMode(1);//1:设置列表播放的方式
	mp.setSingleMedia(mediaStr); //设置媒体播放器播放媒体内容
    mp.setNativeUIFlag(0); //0不使UI本地显示 		   1本地显示
    mp.setMuteUIFlag(0);  //0静音图标不显示			    1本地显示  
    mp.setAudioVolumeUIFlag(0);//设置音量调节本地UI的显示标志 0:不允许 1：允许
    mp.setAudioTrackUIFlag(0);
	mp.setProgressBarUIFlag(0);
	mp.setCycleFlag(0);//循环播放
   
	mp.setAllowTrickmodeFlag(0);//0允许媒体快进，快退，暂停  1本地控制
	mp.setVideoDisplayMode(0); //1:全屏显示
    mp.refreshVideoDisplay(); //调整视频显示，需要上面两函数配合 
	mp.playFromStart();
	//alert(mp.getPlaylist());
	//alert("/*/"+mp.getMediaCount());
}

function addUrl(){
	for(var i=0;i<4;i++){
		subNum++;
		initMediaStr();
		mp.addSingleMedia(-1,mediaStr);
		//mp.setSingleMedia(mediaStr);
	}
}

function unload(){
	mp.stop();
}

document.onkeypress = keyEvent;  
function keyEvent(){
	var val = event.which ? event.which : event.keyCode;
	return keypress(val);
}	
function keypress(keyval){
	switch(keyval)
	{
		case 768:goUtility();break;
		case 264:fastForward();return false;//快进
		default:
			return 0;
	}
	return true;
}
function goUtility(){	
	eval("eventJson = " + Utility.getEvent());
	var typeStr = eventJson.type;
	alert(typeStr);
	switch(typeStr)
	{	
		case "EVENT_MEDIA_ERROR":return false;
		case "EVENT_PLAYMODE_CHANGE":break;	 	
		case "EVENT_MEDIA_END":goonPlay();return false;break;
		case "EVENT_MEDIA_BEGINING":return false;break;
		default :break;	
	}
	return true;
}
var speed = 1;
function fastForward(){
   speed = speed * 2;
   if(speed>32){speed=2;}
   mp.fastForward(speed);  
}
function goonPlay(){
	subNum++ ;alert(subNum);
	if(subNum > = totalNum){subNum = 0 ;}
    pkPlay();
}

</script>
<body bgcolor="transparent" leftmargin="0" topmargin="0" onLoad="init()" style="color:#FFF" onunload="unload()">
<center><div id="alert"></div></center>
</body>
</html>
<script type="text/javascript" src="<%=static_url%>/js/cookie.js"></script>