<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>﻿
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC"%>
<%@ page import="java.io.File"%>﻿
<%!
	//判断海报地址中的图片是否存在
	public String checkPath(String path)
	{
		int index = path.lastIndexOf("/");
		if(index>-1)
		{
			String[] ss=path.split("/");
			String defaultUrl="";
			if(ss.length>3)
			{
				defaultUrl+="jsp/";
				for(int i=2;i<ss.length-1;i++)
				{
					defaultUrl += ss[i];
					defaultUrl += "/";
				}
			}
			String picName = path.substring(index+1);
			String realPath = getServletContext().getRealPath("/");
			String picUrl=realPath+defaultUrl+picName;
			File f = new File(picUrl);
			if(f.exists())
			{
				return path;
			}
		}
		return null;
	}
%>
<%
	JSONArray vodList = new JSONArray();
	MetaData metaData = new MetaData(request);
	ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
	ArrayList resultList = metaData.getVodListByTypeId(recTypeId, 999, 0);
	String tName = (String)metaData.getTypeNameByTypeId(recTypeId);
	if(null != resultList && resultList.size() > 0)
	{
		HashMap map = (HashMap)resultList.get(0);
		if(null != map)
		{
			ArrayList list = (ArrayList)resultList.get(1);
			
			for(int i = 0; i < list.size(); i++)
			{
				HashMap tempMap = (HashMap)list.get(i);
				int vodId = ((Integer)tempMap.get("VODID")).intValue();
				String vodName = (String)tempMap.get("VODNAME");
				int isSitcom = ((Integer)tempMap.get("ISSITCOM")).intValue();
				String[] tagArray = (String[])tempMap.get("TAGARRAY");
			//	System.out.println("-----------tagArray:"+tagArray);
				String tag = "";
				if(tagArray != null && tagArray.length > 0)
				tag = tagArray[0];
				ArrayList subVod = new ArrayList();
				String playUrl = "";
				if(isSitcom == 1)
				{
					subVod = (ArrayList )tempMap.get("SUBVODIDLIST");
					if(subVod !=null && subVod.size()>0)
					{
						int cVodId = ((Integer)subVod.get(0)).intValue();
					//	----pare   --iPlayType:1  iProgId:1352117  iPlayBillId:0  beginTime:0  endTime:20000   productId:0  serviceId:0   contentType:10
						playUrl = serviceHelpHWCTC.getTriggerPlayUrlHWCTC(1,cVodId,0,"0","20000","0","0","10");
					}
				}
				else
				{
					playUrl = serviceHelpHWCTC.getTriggerPlayUrlHWCTC(1,vodId,0,"0","20000","0","0","10");
				}
		//		System.out.println("---pm------------playUrl:"+playUrl);
				if(playUrl != null && playUrl.length() > 0)
				{
					int tmpPosition = playUrl.indexOf("rtsp");
					if(-1 != tmpPosition)
					{
						playUrl = playUrl.substring(tmpPosition,playUrl.length());
					}
				}
				JSONObject tempObj = new JSONObject();
				tempObj.put("vodId", vodId);
				tempObj.put("isSitcom", isSitcom);
				tempObj.put("vodName",vodName);
				tempObj.put("playUrl", playUrl);
				tempObj.put("subVod",subVod);
				tempObj.put("tag",tag);
				vodList.add(tempObj);
				
			}
		}
	}
%>