<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="util_getPosterPaths.jsp"%>

<%
	MetaData metadata = new MetaData(request);
	ArrayList reyingResult = metadata.getVodListByTypeId(shouyereying,4,0);
	ArrayList renqiResult = metadata.getVodListByTypeId(shouyerenqi,2,0);
	ArrayList tuijianResult = metadata.getVasListByTypeId(shouyetuijian,2,0);
	JSONArray ryjsonList = null;
	JSONArray rqjsonList = null;
	JSONArray tjjsonList = null;
	
	if(reyingResult != null && reyingResult.size() > 1 && ((ArrayList)reyingResult.get(1)).size() > 0){
		ArrayList tempList = new ArrayList();
		ArrayList vodList = (ArrayList)reyingResult.get(1);
		
		for(int i=0;i<vodList.size();i++){
			HashMap mapx = (HashMap)vodList.get(i);
			HashMap tempMap = new HashMap();
			String tmpvodid = mapx.get("VODID").toString();
            int pid = Integer.parseInt(tmpvodid);
			String tmpvodname = mapx.get("VODNAME").toString();
			tempMap.put("VODID",tmpvodid);	
			tempMap.put("VODNAME",tmpvodname);	
			HashMap detailMap = (HashMap)metadata.getVodDetailInfo(Integer.parseInt(tmpvodid));
			String isSitcom = detailMap.get("ISSITCOM").toString();
			tempMap.put("ISSITCOM",isSitcom);
			HashMap posterMap = (HashMap)(detailMap.get("POSTERPATHS"));

			if(posterMap!=null){
				//0.缩略图1.海报2.剧照3.图标4.标题图5.广告图6.草图7.背景9.频道图99.其他
				if(i == 0){
					String picUrl = getPosterPath(posterMap,"images/demopic/pic-173X231.jpg","5",request);
					tempMap.put("PICURL",picUrl);
					}else{
						String picUrl = getPosterPath(posterMap,"images/demopic/pic-173X231.jpg","1",request);
						tempMap.put("PICURL",picUrl);
					}	
		        }
		     tempList.add(tempMap);
	       }
		
		ryjsonList = JSONArray.fromObject(tempList);
		}
	if(renqiResult != null && renqiResult.size() > 1 && ((ArrayList)renqiResult.get(1)).size() > 1){
		ArrayList tempList = new ArrayList();
		ArrayList vodList = (ArrayList)renqiResult.get(1);
		
		for(int i=0;i<vodList.size();i++){
			HashMap mapx = (HashMap)vodList.get(i);
			HashMap tempMap = new HashMap();
			String tmpvodid = mapx.get("VODID").toString();
            int pid = Integer.parseInt(tmpvodid);
			String tmpvodname = mapx.get("VODNAME").toString();
			tempMap.put("VODID",tmpvodid);	
			tempMap.put("VODNAME",tmpvodname);	
			HashMap detailMap = (HashMap)metadata.getVodDetailInfo(Integer.parseInt(tmpvodid));
			String isSitcom = detailMap.get("ISSITCOM").toString();
			tempMap.put("ISSITCOM",isSitcom);
			HashMap posterMap = (HashMap)(detailMap.get("POSTERPATHS"));

			if(posterMap!=null){
				//0.缩略图1.海报2.剧照3.图标4.标题图5.广告图6.草图7.背景9.频道图99.其他
				String picUrl = getPosterPath(posterMap,"images/demopic/pic-173X231.jpg","1",request);
				tempMap.put("PICURL",picUrl);	
		        }
		     tempList.add(tempMap);
	       }
		
		rqjsonList = JSONArray.fromObject(tempList);
		}
	if(tuijianResult != null && tuijianResult.size() > 1 && ((ArrayList)tuijianResult.get(1)).size() > 1){
		ArrayList tempList = new ArrayList();
		ArrayList vodList = (ArrayList)tuijianResult.get(1);
		
		for(int i=0;i<vodList.size();i++){
			HashMap mapx = (HashMap)vodList.get(i);
			HashMap tempMap = new HashMap();
			String tmpvasid = mapx.get("VASID").toString();
            int pid = Integer.parseInt(tmpvasid);
			String tmpvodname = mapx.get("VASNAME").toString();
			tempMap.put("VASID",tmpvasid);	
			tempMap.put("VASNAME",tmpvodname);	
			ServiceHelp servicehelp = new ServiceHelp(request);
			String vasurl=servicehelp.getVasUrl(Integer.parseInt(tmpvasid));
			tempMap.put("VASURL",vasurl);
			HashMap detailMap = (HashMap)metadata.getVasDetailInfo(Integer.parseInt(tmpvasid));
			HashMap posterMap = (HashMap)(detailMap.get("POSTERPATHS"));

			if(posterMap!=null){
				//0.缩略图1.海报2.剧照3.图标4.标题图5.广告图6.草图7.背景9.频道图99.其他
				String picUrl = getPosterPath(posterMap,"images/demopic/pic-173X231.jpg","5",request);
				tempMap.put("PICURL",picUrl);	
		        }
		     tempList.add(tempMap);
	       }
		
		tjjsonList = JSONArray.fromObject(tempList);
		}

%>
