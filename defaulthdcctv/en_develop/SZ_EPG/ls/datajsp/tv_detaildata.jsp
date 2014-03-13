<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="java.util.*"%>
<%	
	MetaData metadata = new MetaData(request);
	String returnurl = request.getParameter("returnurl")!=null?request.getParameter("returnurl"):"index.jsp";
	String typeid = request.getParameter("typeid");
	String typename = "";
	if(metadata.getTypeInfoByTypeId(typeid)!=null){
		HashMap typeinfo = (HashMap)metadata.getTypeInfoByTypeId(typeid);
		typename = typeinfo.get("TYPENAME").toString();
	}
	int vodid = Integer.parseInt(request.getParameter("vodid"));
	HashMap detailMap = (HashMap)metadata.getVodDetailInfo(vodid);
	JSONObject data = null;
	HashMap dataMap = new HashMap();
	dataMap.put("VODNAME",detailMap.get("VODNAME").toString());
	dataMap.put("CONTENTTYPE",detailMap.get("CONTENTTYPE").toString());
	if(detailMap.get("DIRECTOR")!=null)
		dataMap.put("DIRECTOR",detailMap.get("DIRECTOR").toString());
	/*
	if(detailMap.get("ACTOR")!=null)
		dataMap.put("ACTOR",detailMap.get("ACTOR").toString());
	*/
	if(detailMap.get("CASTMAP")!=null){
		HashMap castMap = (HashMap)detailMap.get("CASTMAP");	
		if(castMap!=null&&castMap.get(6)!=null){
			String[] tempCasts = (String[])castMap.get(6);
			StringBuffer actor = new StringBuffer();
			if(tempCasts.length>0){
				for(String str : tempCasts){
					actor.append("  "+str.trim());
				}
				dataMap.put("ACTOR",actor.toString().substring(1));
			}
		}
	}
	if(detailMap.get("INTRODUCE")!=null)
		dataMap.put("INTRODUCE",detailMap.get("INTRODUCE").toString());
	HashMap posterMap = (HashMap)(detailMap.get("POSTERPATHS"));
	if(posterMap!=null){
		//0.缩略图1.海报2.剧照3.图标4.标题图5.广告图6.草图7.背景9.频道图99.其他
		String picUrl = "../../"+getPosterPath(posterMap,"images/display/vod/poster_no_pic.jpg","1",request);
		dataMap.put("PICURL",picUrl);	
	}
	ArrayList resultList = metadata.getSitcomList(String.valueOf(vodid), 999, 0);
	ArrayList series = new ArrayList();
	if(resultList != null && resultList.size()>1&&((ArrayList)resultList.get(1)).size()>0){
		int count = ((Integer)((HashMap)resultList.get(0)).get("COUNTTOTAL")).intValue(); //总数量
		dataMap.put("SERIECOUNT",count);
		ArrayList serieList = (ArrayList)resultList.get(1);
		if(serieList != null){
			for(int k=0; k<serieList.size(); k++){
				Map serieMap = (HashMap)serieList.get(k);
				HashMap hm = new HashMap();
				hm.put("SERIEID",serieMap.get("VODID").toString());
				hm.put("SERIENUM",serieMap.get("SITCOMNUM").toString());
				
				series.add(hm);
			}
		}
	}
	dataMap.put("SERIES",series);
	data = JSONObject.fromObject(dataMap);
%>
<script type="text/javascript">
	var returnurl = unescape("<%=returnurl%>");
	var typename = "<%=typename%>";
	var vodid = "<%=vodid%>";
	var data = <%=data%>;
</script>