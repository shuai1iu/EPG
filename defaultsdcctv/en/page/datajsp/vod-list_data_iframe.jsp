<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="../util/util_getPosterPaths.jsp" %>
<%
	MetaData metadata = new MetaData(request);
	Integer vodid = (request.getParameter("vodid")==null||"undefined".equals(request.getParameter("vodid")))?1:Integer.parseInt(request.getParameter("vodid"));
	JSONObject jsonvodinfo = null;
	String postertype = "1";
	
	//获取内容详情
	boolean isfaved = false;
	HashMap mediadetailInfo = (HashMap)metadata.getVodDetailInfo(vodid);
	if(mediadetailInfo!=null){
		HashMap postersMap = (HashMap)(mediadetailInfo.get("POSTERPATHS"));
		String picpath = (String)mediadetailInfo.get("PICPATH").toString();
		String postpath =  getPosterPath(postersMap,request,picpath,postertype).toString();
		mediadetailInfo.put("POSTERPATHS","../"+postpath);
		mediadetailInfo.put("PICPATH","../"+picpath);
		HashMap castMap = (HashMap)mediadetailInfo.get("CASTMAP");	
		if(castMap!=null&&castMap.get(6)!=null){
			String[] tempCasts = (String[])castMap.get(6);
			StringBuffer actor = new StringBuffer();
			for(String str : tempCasts){
				actor.append(","+str.trim());
			}
			mediadetailInfo.put("ACTOR","".equals(actor.toString())?null:actor.toString().substring(1));		
		}
		String tempDir = (String)mediadetailInfo.get("DIRECTOR");
		tempDir = tempDir!=null?tempDir.trim():null;
		mediadetailInfo.put("DIRECTOR",tempDir);
		ServiceHelp shelper = new ServiceHelp(request);
		int contentid = Integer.parseInt(mediadetailInfo.get("VODID").toString());
		int contenttype = Integer.parseInt(mediadetailInfo.get("CONTENTTYPE").toString());
		isfaved = shelper.isFavorited(contentid,contenttype);  //是否已收藏
		mediadetailInfo.put("ISFAVED",isfaved);
		jsonvodinfo = JSONObject.fromObject(mediadetailInfo);
	}
	response.getWriter().print(jsonvodinfo);
%>	
