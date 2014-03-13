<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>

<%@ include file="../util/util_getPosterPaths.jsp" %>
<%
	JSONObject allJson = new JSONObject();
	MetaData metadata = new MetaData(request);
	if(request.getParameter("ccid")!=null)
	{
		//焦点移动事件
		JSONObject jContent =null;
		Integer ccId = Integer.parseInt(request.getParameter("ccid").toString());
		
		HashMap con_result = (HashMap)metadata.getVodDetailInfo(ccId);
		String postertype = "1";
		HashMap postersMap = (HashMap)con_result.get("POSTERPATHS");
		String picpath = "images/no_picture_259x232.jpg";
		HashMap castMap = (HashMap)con_result.get("CASTMAP");	
		if(castMap!=null&&castMap.get(6)!=null){
			String[] tempCasts = (String[])castMap.get(6);
			StringBuffer actor = new StringBuffer();
			for(String str : tempCasts){
				actor.append(","+str.trim());
			}
			con_result.put("ACTOR","".equals(actor.toString())?null:actor.toString().substring(1));		
		}
		String postpath = getPosterPath(postersMap,request,picpath,postertype).toString();
		con_result.put("PICPATH",postpath);
		//jContent = JSONObject.fromObject(con_result);	
				
		if(con_result!=null)
		{
			jContent = JSONObject.fromObject(con_result);
		}
		allJson.put("Content",jContent);
	}
	else
	{
		//翻页事件
		String vodId = "0";
		String typeId = request.getParameter("cateid")==null?"-1":request.getParameter("cateid");
		Integer curindex = request.getParameter("curindex")==null?0:Integer.parseInt(request.getParameter("curindex"));//当前curindex
	
		//子集id
		int pagesize = 11;
		int curpage = Integer.parseInt(request.getParameter("curpage")==null?"1":request.getParameter("curpage"));
		int pagestart = (curpage-1)*pagesize;
		boolean isfaved = false;
		int pagecount = 0;
		//Integer contenindex = pagesize*(curpage-1)+curindex;
		
		JSONArray jFilms = null;
		JSONObject jContent = null;
	
		//获取列表 
		if(typeId!=null)
		{
			List contentList = metadata.getVodListByTypeId(typeId,pagesize,pagestart);
			if(contentList!=null&&contentList.size()>=2)
			{			
				int counttotal = Integer.parseInt(((HashMap)contentList.get(0)).get("COUNTTOTAL").toString()); //总数
				pagecount = (counttotal-1)/pagesize +1; //获取总页数
				jFilms = JSONArray.fromObject((ArrayList)contentList.get(1));
				List templist = (ArrayList)contentList.get(1);
				if(curindex>=templist.size())
				{
					curindex=templist.size()-1;
				}
				HashMap contentmap =  (HashMap)templist.get(curindex);
				vodId = contentmap.get("VODID").toString();
			}
		}
		//获取内容
		HashMap mediadetailInfo = (HashMap)metadata.getVodDetailInfo(Integer.parseInt(vodId));
		if(mediadetailInfo!=null){
			String postertype = "1";
			HashMap postersMap = (HashMap)mediadetailInfo.get("POSTERPATHS");
			String picpath = "images/no_picture_259x232.jpg";
			String postpath = getPosterPath(postersMap,request,picpath,postertype).toString();
			mediadetailInfo.put("PICPATH",postpath);
			jContent = JSONObject.fromObject(mediadetailInfo);
		}
		//notend 2011年8月20日 15:14:09
		//需要确认：未确认产品包能否查询与购买
		allJson.put("Content",jContent);
		allJson.put("Films",jFilms);
	}
	response.getWriter().print(allJson);
%>