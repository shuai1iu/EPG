<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" buffer="64kb"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%@ page import="org.json.simple.JSONArray"%>
<%@ include file = "util/SubStringFunction.jsp"%>
<%@ include file = "util/util_tool.jsp"%>
<%
	String strVodId = request.getParameter("vodId");
	String strTypeId = "";
	
	if("".equals(strVodId) || strVodId.equals(""))
	{
		strVodId = "0";
	}
	int filmId = Integer.parseInt(strVodId);
	
	MetaData metaData = new MetaData(request);
	Map filmMap = metaData.getVodDetailInfo(filmId);
	JSONObject jsonFilm = null;
	
	if(null != filmMap && filmMap.size() > 1)
	{
		jsonFilm = new JSONObject();
		
		String vodName = getStrTrim(filmMap.get("VODNAME"));//影片名
		String scrollName = subStringFunction(vodName,1,260);
		String director = getStrTrim(filmMap.get("DIRECTOR"));//导演
		String subDirector = "";
		if(null == director || "".equals(director) || "" == director)
		{
			subDirector = "暂无";	
			
		}else
		{
			subDirector = subStringFunction(director,1,260);
		}
		
		String actor = getStrTrim(filmMap.get("ACTOR"));//主演
		String subActor = subStringFunction(actor,1,260);
		String tempintroduce = getStrTrim(filmMap.get("INTRODUCE"));//节目简介
		String introduce = "";
		if(null == tempintroduce || "".equals(tempintroduce) || "" == tempintroduce)
		{
			introduce = "暂无简介";	
			
		}else
		{
			introduce = subStringFunction(tempintroduce,1,1400);
		}
		int subVodLength = 1;
		ArrayList subVod = new ArrayList();
		ArrayList subVodNumList = new ArrayList();
		String isSitcom = getStrTrim(filmMap.get("ISSITCOM"));//连续剧类型(0:非连续剧父集、1:连续剧父集)
		if("1".equals(isSitcom))//如果是连续剧取出连续剧的集数
		{
			subVod = (ArrayList)filmMap.get("SUBVODIDLIST");
			subVodNumList = (ArrayList)filmMap.get("SUBVODNUMLIST");
			//假数据
			/*for(int i=0; i<159; i++)
			{
				subVod.add(subVod.get(0));
				subVodNumList.add((subVodNumList.size()+2));
			}*/
			
			subVodLength = subVod.size();
			if(null != subVod && subVodLength > 0)
			{
				jsonFilm.put("subVodNumList",subVodNumList);
			}
		}
		if(null == subActor || "".equals(subActor))
		{
			subActor = "暂无";
		}
		jsonFilm.put("vodId", filmId);
		jsonFilm.put("vodName", vodName);
		jsonFilm.put("scrollName", scrollName);
		jsonFilm.put("director", subDirector);
		jsonFilm.put("actor", subActor);
		jsonFilm.put("introduce", introduce);
		jsonFilm.put("isSitcom", isSitcom);
		jsonFilm.put("subVodIdList",subVod);
	}
//	System.out.println("-------pm----------jsonFilm:"+jsonFilm);
%>