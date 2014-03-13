<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="java.util.*"%>
<%@ include file="../util/util_getPosterPaths.jsp"%>
<%	
	MetaData metadata = new MetaData(request);
	int curpage = Integer.parseInt(request.getParameter("curpage"));
	String typeid = request.getParameter("typeid");
	int pagesize = 18;
	ArrayList list = metadata.getVodListByTypeId(typeid, pagesize, (curpage-1)*pagesize);
	JSONArray datalist = null;
	if(list!=null&&list.size()>1&&((ArrayList)list.get(1)).size()>0){
		ArrayList tempList = new ArrayList();
		ArrayList vodList = (ArrayList)list.get(1);
		for(int i=0;i<vodList.size();i++){
			HashMap mapx = (HashMap)vodList.get(i);
			HashMap tempMap = new HashMap();
			String tmpvodid = mapx.get("VODID").toString();
			String tmpvodname = mapx.get("VODNAME").toString();
			tempMap.put("VODID",tmpvodid);	
			tempMap.put("VODNAME",tmpvodname);	
			HashMap detailMap = (HashMap)metadata.getVodDetailInfo(Integer.parseInt(tmpvodid));
			HashMap posterMap = (HashMap)(detailMap.get("POSTERPATHS"));
			if(posterMap!=null){
				//0.缩略图1.海报2.剧照3.图标4.标题图5.广告图6.草图7.背景9.频道图99.其他
				String picUrl = "../../"+getPosterPath(posterMap,"images/display/vod/poster_no_pic.jpg","1",request);
				tempMap.put("PICURL",picUrl);	
			}
			tempList.add(tempMap);
		}
		datalist= JSONArray.fromObject(tempList);
	}
	
%>
<script type="text/javascript">
	parent.datalist = <%=datalist%>;
	parent.initData();
</script>