<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ include file = "keyboard/keydefine.jsp"%>
<html>
<%
String progId = request.getParameter("PROGID"); //节目id
int iProgId = 0;	
String channelId = request.getParameter("CHANNELID");//频道id
int iChannelId = 0;
String playType = request.getParameter("PLAYTYPE"); //播放类型
int iPlayType = 0;	
String beginTime = request.getParameter("PROGSTARTTIME"); //节目播放开始时间
String endTime = request.getParameter("PROGENDTIME"); //节目播放结束时间
String productId = request.getParameter("PRODUCTID"); //订购产品id	
String serviceId = request.getParameter("SERVICEID"); //对应服务id	
String price = request.getParameter("ONECEPRICE"); //该产品对应价格	
String contentType = request.getParameter("CONTENTTYPE");
//vasTvod
String vasTvod =request.getParameter("vasTvod");
String strControlFlag=request.getParameter("controlflag");
String goBackUrl = request.getParameter("returnurl");
if(vasTvod == null)
{
	vasTvod="0";
}
String playUrl = ""; //触发机顶盒播放地址
boolean isSucess = true;
/*******************对获取参数进行异常处理 start*************************/
try
{
	iProgId = Integer.parseInt(progId);
	iChannelId = Integer.parseInt(channelId);
	iPlayType = Integer.parseInt(playType);
}
catch(Exception e)
{
	iProgId = -1;
	iChannelId = -1;
	iPlayType = EPGConstants.PLAYTYPE_TVOD;
	isSucess = false;
}
if(beginTime == null || "".equals(beginTime))
{
	beginTime = "0";
}	
if(endTime == null  || "".equals(endTime))
{
	endTime = "0";
}
if(productId == null || "".equals(productId))
{
	productId = "0";
}
if(serviceId == null || "".equals(serviceId))
{
	serviceId = "0";
}	
if(price == null || "".equals(price))
{
	price = "0";
}	
if(contentType == null || "".equals(contentType))
{
	contentType =String.valueOf(EPGConstants.CONTENTTYPE_PROGRAM);
}
String infoDisplay = "errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=26";

/*******************对获取参数进行异常处理 end*************************/
MetaData metaData = new MetaData(request);

ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);

ServiceHelp serviceHelp = new ServiceHelp(request);

int iShowDelayTime = 5000;
try
{
	String showDelayTime = serviceHelp.getMiniEPGDelay ();
	iShowDelayTime = Integer.parseInt(showDelayTime)* 1000;
}
catch(Exception e)
{
	iShowDelayTime = 5000;
}	
/*************************获取播放url start**************************************/
try
{
	if(vasTvod.equals("1"))
	{
		playUrl = serviceHelpHWCTC.getTriggerPlayUrlHWCTC(iPlayType,iChannelId,iProgId,beginTime,endTime,productId,serviceId,contentType)+"&playseek="+beginTime+"-"+endTime;
	}
	else
	{
		playUrl = serviceHelpHWCTC.getTriggerPlayUrlHWCTC(iPlayType,iChannelId,iProgId,beginTime,endTime,productId,serviceId,contentType);
	}
	if(playUrl != null && playUrl.length() > 0)
	{
		int tmpPosition = playUrl.indexOf("rtsp");
		if(-1 != tmpPosition)
		{
			playUrl = playUrl.substring(tmpPosition,playUrl.length());
		}
		else
		{
			isSucess = false;
		}
	}
}
catch(Exception e)
{
	%>
	  <script> location.href="errorinfo.jsp?ERROR_TYPE=1&ERROR_ID=180"; </script>
	<%
}
/*************************获取播放url end**************************************/			

if(!isSucess)
{
	response.sendRedirect(infoDisplay);
}
int itype = 0;
String type=request.getParameter("ECTYPE");	
if(type != null && type !="" && type != "null")
{	
	itype=Integer.parseInt(type);
}
%>
<script type="text/javascript" src="../js/mediaPlayerEx.js"></script>
<script>	
var mediaManage = new MediaManager();
var NextProgyurl;
var PreProgyurl;
var isJoinChannle=true;
var startDate = "";//节目开始日期 
var preProgId = "-1"; //tvod上一集id
var preProgName = "";
var preProgBeginTime = "";
var preProgEndTime = "";
var nextProgId = "-1" //tvod下一集id
var nextProgName = "";
var nextProgBeginTime = "";
var nextProgEndTime = "";
var progName = "";//本节目的名字
var channelName = "";//频道名称
var progTimeBegin = "";//节目开始时间
var progTimeEnd = "";//节目结束时间
var progTimeSpan = ""; //节目开始时间~结束时间
var introduce = "";
var dataIsOk = false; //数据是否准备结束
var channelId=<%=iChannelId%>;
var goBackUrl="<%=goBackUrl%>";
var iPlayType="<%=iPlayType%>";
var contentType="<%=contentType%>";

var playUrl = '<%=playUrl%>';//触发机顶盒播放url
var isBookMark = <%= iPlayType == EPGConstants.PLAYTYPE_ASSESS%>; //是否为书签播放
var currControlFlag=<%=strControlFlag%>;
var beginTime="<%=beginTime%>";

function goBack(){
	window.location.href="<%=goBackUrl%>";
}
function goNext(nexturl){
	window.location.href=nexturl;
}

function keyevent(evt) {
        evt = evt || window.event;
        var keyCode = evt.keyCode ? evt.keyCode : evt.which;
        var ret = false;
        if (window.frames["EPG"].keypress) {
            ret = window.frames["EPG"].keypress(keyCode);
        }
        return 1;
}
</script>
<frameset rows="0,540" frameborder="no" border="0" framespacing="0">
     <frame name="MEDIA" id="MEDIA" src="play_controlTVodData.jsp?progId=<%=iProgId%>&channelId=<%=iChannelId%>"/>
     <frame name="EPG" scrolling="No" noresize="noresize" id="EPG" src="tvodpause.jsp?ControlFlag=<%=strControlFlag%>&CHANNELNUM=0&CHANNELID=<%=iChannelId%>&COMEFROMFLAG=<%=contentType%>"/>
     <noframes>
        <body>您的浏览器无法处理框架！</body>
     </noframes>
</frameset>
</html>
