<!-- FileName:play_ControlAction.jsp -->
<%-- 
	直播控制页面来着
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page errorPage="ShowException.jsp" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%@ page import="java.util.*" %>
<%@ include file="config/config_playControl.jsp" %>

<%
	String comeType = request.getParameter("COMEFROMFLAG");
	String isSub = request.getParameter("ISSUB");
	String previewFlag = request.getParameter("PREVIEWFLAG");
	boolean isTrue = false;
	boolean flag = false;//高清标识，false为高清
	boolean definitionFlag = false;
	isTrue = EPGUtil.isValidateUser(request);
	//预览标识；1:支持 0:不支持
    String strChannelNum = request.getParameter("CHANNELNUM");
	String pageName = "";
	if(false == isTrue)
	{
		%>
		<jsp:forward page="errorinfo.jsp?ERROR_ID=153&ERROR_TYPE=2"/>
		<%		
	}
	else
	{
		if(null != strChannelNum && !"".equals(strChannelNum) && strChannelNum.trim().length() > 0)
		{
	       //开机播放、vas播放
			if("0".equals(comeType) && 0 == IS_DEFINITION_OPENPLAY)
			{
			 	pageName = "play_ControlChannel.jsp?"+request.getQueryString();
			}
			//频道列表 数字键进入（已经做过处理相当于是从频道列表进来）
			else if("2".equals(comeType) || "3".equals(comeType))
			{
				
				pageName = "au_ReviewOrSubscribe.jsp?"+request.getQueryString();
			}
			else
			{ 
				MetaData metaData = new MetaData(request);
				ArrayList recChanList = metaData.getChannelListInfo();
				int listSizeStr = recChanList.size();
				HashMap chanInfo = new HashMap();
				for(int i=0; i<listSizeStr; i++)
				{
					chanInfo = (HashMap)recChanList.get(i);
					/*过滤高清,如果是高清EPG就不用这段来过滤
					String SupportHD = (String)session.getAttribute("SupportHD");//高清为1
					if("0".equals(SupportHD))
					{
						Integer iDEFINITION = (Integer)chanInfo.get("DEFINITION");
						if(iDEFINITION != null)
						{
							int DEFINITION = iDEFINITION.intValue();
							//2为标清，1为高清
							if(1==DEFINITION)
							{
								String chanIndex = ((Integer)chanInfo.get("UserChannelID")).toString();
								if(chanIndex.equals(strChannelNum))
								{
									definitionFlag = true;
								}
								continue;
							}
						}
					}*/
					int channelId = ((Integer)chanInfo.get("ChannelID")).intValue();
					int isSubScribed = ((Integer)chanInfo.get("isSubscribe")).intValue();
					String previewAble = "0" ;
					try
					{
						previewAble = (String)chanInfo.get("PreviewEnableHWCTC");
					}
					catch(Exception e)
					{
						previewAble = "0" ;
					}
					String chanIndex = ((Integer)chanInfo.get("UserChannelID")).toString();
					
					if(chanIndex.equals(strChannelNum))
					{
						if(1 == ((Integer)chanInfo.get("IsNvod")).intValue())
						{	
							pageName = "au_ReviewOrSubscribe.jsp?PROGID=" + channelId +"&CHANNELNUM="+chanIndex+"&ISSUB="+isSubScribed+ "&PLAYTYPE=" + EPGConstants.PLAYTYPE_NVOD + "&CONTENTTYPE=" + EPGConstants.CONTENTTYPE_CHANNEL_VIDEO +"&PREVIEWFLAG="+previewAble+ "&BUSINESSTYPE=" + EPGConstants.BUSINESSTYPE_NVOD;
						}
						else
						{
							pageName= "au_ReviewOrSubscribe.jsp?PROGID=" + channelId +"&CHANNELNUM="+chanIndex+"&ISSUB="+isSubScribed+ "&PLAYTYPE=" + EPGConstants.PLAYTYPE_LIVE + "&CONTENTTYPE=" + EPGConstants.CONTENTTYPE_CHANNEL_VIDEO +"&PREVIEWFLAG="+previewAble + "&BUSINESSTYPE=" + EPGConstants.BUSINESSTYPE_LIVETV;
						}
						flag = true;
					}
				}	
			}
			%>
				<script>
				//alert("pageName----------<%=pageName%>");
                </script>
              <jsp:forward page="<%=pageName%>"/>
			<%
		}
	}
		
%>
