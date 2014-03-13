<!-- 文件名：CategoryIndex.jsp -->
<!-- 版  权：Copyright 2005-2007 Huawei Tech. Co. Ltd. All Rights Reserved. -->
<!-- 描  述：EPG首页 -->
<!-- 修改人：sunmofei -->
<!-- 修改时间：2009-2-10 -->
<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="ShowException.jsp"%>
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
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%@ page import="java.io.*" %>
<%@ taglib uri="/WEB-INF/stbOperation.tld" prefix="STBOperation" %>
<html>
<head>
</head>

<%
	
    //接口
	MetaData meta = new MetaData(request);
	ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
	
	//获取用户信息
	UserProfile userProfile_copy = new UserProfile(request);
	HashSet userproduct = new HashSet();
	
	//区域编号
    int areaId_copy = userProfile_copy.getAreaId();
	//用户组编号
	String userGroupId_copy = userProfile_copy.getUserGroupId();
	
	String noPic = "../../images/universal/film/poster/noPic.jpg";
	
	//获取首页广告位数据，返回指定起始位置的首页广告信息
	ArrayList AdvertisementList_copy = meta.getAdvertisementList(userGroupId_copy,areaId_copy,50,0,false);
	
	//用于保存广告的url和图片
	String [][]AdvertisementArr_copy=null;
	ArrayList AdList_copy=new ArrayList();
	//首页广告总数
	int AdTotal_copy=0;
	if(AdvertisementList_copy!=null && AdvertisementList_copy.size()>=2)
	{
		//获取首页广告信息，具体信息由HashMap封装		
		AdList_copy = (ArrayList)AdvertisementList_copy.get(1);
		AdTotal_copy = AdList_copy.size();
		if(AdTotal_copy > 4)
		AdTotal_copy = 4;
		
		AdvertisementArr_copy = new String[AdTotal_copy][2];
		//获取具体的广告信息
		for(int i=0;i<AdTotal_copy;i++)
		{
			HashMap AdMap=(HashMap)AdList_copy.get(i);
			if(AdMap.get("URL")!=null)
			{	
				//存储具体的广告url
				//AdvertisementArr[i][0] = "special/"+AdMap.get("URL").toString().trim();
				AdvertisementArr_copy[i][0] = AdMap.get("URL").toString().trim();
			}
			if(AdMap.get("PICTURE")!=null)
			{
				//存储具体的广告图片
				String tmpAdImg = AdMap.get("PICTURE").toString().trim();
				//判断最后得到的图片是否存在
				String ad_path = request.getRealPath("/");
				int num_AdMap = tmpAdImg.lastIndexOf("images/universal/film");
				if(num_AdMap>0)
				{
					String str_AdMap = tmpAdImg.substring(num_AdMap);
					str_AdMap = "jsp/"+str_AdMap;
					File images_ad = new File(ad_path+str_AdMap);
					if(!images_ad.exists())
					{
						tmpAdImg = "images/common/Notpic.jpg";//此图片一定要存在。
					}
				}
				AdvertisementArr_copy[i][1] = tmpAdImg;
			}
		}
	}
	
	


%>
	
	<script>
	var advUrl = new Array(); // 地址
	var advPic = new Array(); // 图片
	
	<%
	for(int i=0;i<AdvertisementArr_copy.length;i++)
	{
		
	%>
	
	advUrl[<%=i%>] = "<%=AdvertisementArr_copy[i][0]%>";
	advPic[<%=i%>] = "<%=AdvertisementArr_copy[i][1]%>";
	
	<%
	}
%>
	</script>
