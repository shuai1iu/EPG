<!-- 文件名：util_GetGuideChan.jsp -->
<!-- 描  述：导视 -->
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.CategoryContentInfo"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.CategoryTrailer"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.CategoryPoster"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.*"%>
<%@ page import="java.io.*" %>

<html>
<head>
</head>
<%
	
	//接口
	MetaData meta = new MetaData(request);
	ServiceHelp serviceHelp = new ServiceHelp(request);
	ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);

	//获取用户信息
	UserProfile userProfile = new UserProfile(request);
	HashSet userproduct = new HashSet();
	userproduct = userProfile.getMonthProductIdSet();
	
	////判断是否购买高清产品包 
	session.setAttribute("gaoqingFlag","1");
	
	if(null != userproduct &&  userproduct.size() != 0)
	{
         Iterator ite=userproduct.iterator();
        
         while(ite.hasNext())
         {
        	String tmp_id=(String)ite.next();
        	   
            //判断是否为政企用户
			if(tmp_id.equals("100001"))
			{
				session.setAttribute("ZHENGQI","1");	
			}
			
			if( tmp_id.equals("512") || tmp_id.equals("3101"))
			{
				session.setAttribute("gaoqingFlag","0");
				
			}
         } 
	}
	//区域编号
    int areaId = userProfile.getAreaId();
	//用户组编号
	String userGroupId = userProfile.getUserGroupId();
	
	int supportHDtmp = 0 ;
	try
	{
		supportHDtmp = Integer.valueOf((String)session.getAttribute("SupportHD")).intValue();
	}
	catch(Exception ee)
	{
		supportHDtmp = 0 ;
	}
	
	//定义节目ID
	String progId = null;
	//定义Trailer播放的播放类型
	String playType = null;
	String type = "";
	//定义Trailer播放的内容类型
	String strContentType = null;
	//定义Trailer外部编号
	String strTrailerConId = null;

	//定义全屏播放的URL
	String fullScreenPlayUrl = "";
	//暂无图片的图片地址,必须以“images/universal/film”开头
	String noPic = "../../images/universal/film/poster/noPic.jpg";
	//1: Trailer  0: 海报  -1: 既没有Trailer也没海报 
	String trailerFlag = "1";
	//获取首页海报或视频
	CategoryContentInfo categoryInfo = (CategoryContentInfo)meta.getCategoryContent(userGroupId,areaId,"1",false,50,0);
	//判断取数据是否成功
	int returnCode = categoryInfo.getReturnCode();
	//获取数据个数，为空时，countTotal=-1；

	int countTotal = categoryInfo.getCountTotal();
	if(countTotal == -1)
	{
		countTotal = 0;
	}	

	//定义海报图片
	String posterPicUrl[] = new String[countTotal];
	String pictureLinkUrl[] = new String[countTotal];
	//定义VOD的id
	int posterVodId[] = new int[countTotal];
	int posterType[] = new int [countTotal];
	
	String posterURL[] = new String[countTotal];
	String posterPIC[] = new String[countTotal];
	String posterNAME[] = new String[countTotal];
	
	//当取数据成功，并且有数据时
	if(returnCode==0 && countTotal!=0)
	{
		//判断首页内容是海报还是Trailer播放
		int categoryContentType = categoryInfo.getType();
		//视频
		if(categoryContentType==2)
		{
			posterPicUrl = null;
			posterVodId = null;
			trailerFlag = "1";
			CategoryTrailer categoryTrailer = (CategoryTrailer)categoryInfo.getTrailer();
			
			//获取Trailer的id
			int trailerConId = categoryTrailer.getContentID();
			strTrailerConId = trailerConId + "";
			//获取Trailer的内容类型
			int trailerConType = categoryTrailer.getContentType();
			strContentType = trailerConType + "";
			
			//trailerConType=10是VOD,trailerConType=3是频道
			if(trailerConType==10)
			{
				type = "VOD";
				playType = "1";
				progId = strTrailerConId;
				strContentType = "0";
			}
			else if(trailerConType==3)
			{
				type = "CHAN";
				playType = "2";
				progId = strTrailerConId;
			}
			
			//业务类型
			int businessType = EPGConstants.BUSINESSTYPE_LIVETV;
			
			if ((playType != null) && (playType.equals(String.valueOf(EPGConstants.PLAYTYPE_NVOD))))
			{
				businessType = EPGConstants.BUSINESSTYPE_NVOD;//3
			}
			else
			{
				businessType = EPGConstants.BUSINESSTYPE_LIVETV;//2
			}
			//验证chanId,playType
			if ( !EPGUtil.strIsNumber(progId) || !EPGUtil.strIsNumber(playType))
			{
				fullScreenPlayUrl = "InfoDisplay.jsp?ERROR_TYPE=2&ERROR_ID=100";
			}
			//全屏播放,如果Trailer是VOD走VOD的播放流程，如果是频道则走频道的播放流程
			
			if(type.equals("VOD"))
			{
				HashMap vodInfo = (HashMap)meta.getVodDetailInfo(trailerConId);
				if(null != vodInfo && supportHDtmp == 0 &&  ((Integer)vodInfo.get("DEFINITION")).intValue()==1)
				{
					fullScreenPlayUrl = "InfoDisplay.jsp?ERROR_TYPE=2&ERROR_ID=129";
				}
				else
				{
					//fullScreenPlayUrl = "au_PlayFilm.jsp?PROGID=" + progId + "&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=" + businessType;
					fullScreenPlayUrl = "au_PlayFilm.jsp?PROGID=" + progId+ "&PLAYTYPE=" + EPGConstants.PLAYTYPE_VOD + "&CONTENTTYPE=" + strContentType + "&BUSINESSTYPE=" + EPGConstants.BUSINESSTYPE_VOD;
				}
				
			}
			else if(type.equals("CHAN"))
			{
				HashMap chanInfo = (HashMap)meta.getChannelInfo(strTrailerConId);
				if(null != chanInfo && chanInfo.size()>0)
				{
					String channelIndex = ((Integer)chanInfo.get("CHANNELINDEX")).toString();
					fullScreenPlayUrl = "play_ControlAction.jsp?CHANNELNUM="+channelIndex+"&COMEFROMFLAG=5";
				}
			}
		}
	}	
%>