<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.util.*"%>
<%@ page import="java.util.*"%>

<%
    ServiceHelp serviceHelp = new ServiceHelp(request);
    MetaData metaData = new MetaData(request);
    ServiceHelpHWCTC serviceHelphwctc = new ServiceHelpHWCTC(request);
    String categoryCode=request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode");
	String breakpoint=request.getParameter("breakpoint")==null?"0":request.getParameter("breakpoint");
	String definition=request.getParameter("definition")==null?"0":request.getParameter("definition");
	String varName = request.getParameter("varName")==null?"playUrl":request.getParameter("varName");
	//播放类型
    String type = "";
    String startTime = "";
    String endTime = "";
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
		if(type.equals("VOD"))
		{
			strContentType = "0";
		}
		else if(type.equals("CHAN"))
		{
			strContentType = "1";
		}
		else if(type.equals("TVOD"))
		{
			strContentType = "300";
		}
		else
		{
			strContentType = "-1";
		}
		
	}
	if (request.getParameter("mediacode") != null && !"".equals(request.getParameter("mediacode")))
	{
    	mediacode = request.getParameter("mediacode");
    }
	if (request.getParameter("value") != null && !"".equals(request.getParameter("value")))
	{
    	value = request.getParameter("value");
    }
	if (request.getParameter("startTime") != null && !"".equals(request.getParameter("startTime")))
	{
    	startTime = request.getParameter("startTime");
    }
    if (request.getParameter("endTime") != null && !"".equals(request.getParameter("endTime")))
	{
    	endTime = request.getParameter("endTime");
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
			}else if(type.equals("TVOD"))
			{
				progId = ((Integer)result.get("PROGID")).toString();
			}
		}
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
		playUrl = serviceHelphwctc.getTriggerPlayUrlHWCTC(parameter,Integer.parseInt(progId),progIndex,"0","0","0","0",strContentType);
	}
	else if(type.equals("TVOD"))
	{
		playUrl = serviceHelphwctc.getTriggerPlayUrlHWCTC(parameter,Integer.parseInt(progId),progIndex,startTime,endTime,"0","0",strContentType);
	}
	if(playUrl != null && playUrl.length() > 0) //对获得的URL进行处理，得到MediaPlayer需要的url值
    {
		int st=playUrl.indexOf("rtsp");//此为单播，需找华为提供组播测试。
		if(-1 != st)
		{
			playUrl=playUrl.substring(st,playUrl.length());    
		}
	}
%>

var <%=varName%> ="<%=playUrl%>";