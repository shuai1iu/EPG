<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*" errorPage="ShowException.jsp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.*"%>
<%@ page import="java.io.*" %>
<%!   //首页导视窗口配置数据
     final static String CATEGORY_TRAILER_ID="601";//所配视频ID
	 final static String CATEGORY_TRAILER_TYPE="CHAN";//"CHAN"直播 "VOD"点播  
     final static String CATEGORY_TRAILER_CONTENTTYPE="1";//"1"为直播，"0"为点播
	
%>

<%
            MetaData meta = new MetaData(request);
			//首页
			int supportHDtmp = 0 ;
			try
			{
				supportHDtmp = Integer.valueOf((String)session.getAttribute("SupportHD")).intValue();
			}
			catch(Exception ee)
			{
				supportHDtmp = 0 ;
			}
			String CATEGORY_fullScreenPlayUrl="errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=145";
			String CHANNEL_fullScreenPlayUrl="errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=145";
			String VOD_fullScreenPlayUrl="errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=145";
			String NATIVE_fullScreenPlayUrl="errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=145";
			if(CATEGORY_TRAILER_ID!=null)
			{
				int trailerConId=Integer.parseInt(CATEGORY_TRAILER_ID);
				if(CATEGORY_TRAILER_TYPE.equals("VOD")) //窗口视频为点播的情况
				{
					HashMap vodInfo = (HashMap)meta.getVodDetailInfo(trailerConId);
					if(null != vodInfo && supportHDtmp == 0 &&  ((Integer)vodInfo.get("DEFINITION")).intValue()==1)
					{
						CATEGORY_fullScreenPlayUrl= "errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=129";
					}
					else
					{
						CATEGORY_fullScreenPlayUrl = "au_PlayFilm.jsp?PROGID=" + CATEGORY_TRAILER_ID+
						"&PLAYTYPE=" + EPGConstants.PLAYTYPE_VOD+ "&CONTENTTYPE=" + CATEGORY_TRAILER_CONTENTTYPE 
						+ "&BUSINESSTYPE=" + EPGConstants.BUSINESSTYPE_VOD;
					}
				}
				else if(CATEGORY_TRAILER_TYPE.equals("CHAN"))  //窗口视频为直播的情况
				{
					HashMap chanInfo = (HashMap)meta.getChannelInfo(CATEGORY_TRAILER_ID);
					
					if(null != chanInfo && chanInfo.size()>0)
					{
						String channelIndex = ((Integer)chanInfo.get("CHANNELINDEX")).toString();
						CATEGORY_fullScreenPlayUrl = "play_ControlChannel.jsp?CHANNELNUM="+channelIndex+"&COMEFROMFLAG=0";
					     %>
						    <script>//alert("<%=CATEGORY_fullScreenPlayUrl%>");</script>
						 <%
					}
				}
			
			}
				
			
%>
