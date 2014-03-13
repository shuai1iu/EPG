<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="java.util.*"%>
<%	
	String path = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getRequestURI().substring(0,request.getRequestURI().lastIndexOf("/")+1);
	MetaData metadata = new MetaData(request);
	int curpage = 1;
	int pagesize = 18;
	int pagecount = 0;
	if(focstr!=null){
		String focObj = String.valueOf(getState(analyticFocStr(focstr),"0","curpage"));
		curpage = (focObj==null||focObj.equals("null"))?1:Integer.parseInt(focObj);	
	}
	String returnurl = request.getParameter("returnurl")!=null?request.getParameter("returnurl"):"index.jsp";
	String typeid = request.getParameter("typeid");
	String typename = "";
	if(metadata.getTypeInfoByTypeId(typeid)!=null){
		HashMap typeinfo = (HashMap)metadata.getTypeInfoByTypeId(typeid);
		typename = typeinfo.get("TYPENAME").toString();
	}
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
	ArrayList list2 = metadata.getVodListByTypeId(typeid, 9999, 0);
	if(list2!=null&&list2.size()>1&&((ArrayList)list2.get(1)).size()>0){
		int count = ((Integer)((HashMap)list2.get(0)).get("COUNTTOTAL")).intValue(); //总数量
		pagecount = (count-1)/pagesize+1;
	}
	
	String defaultpic = "";
	int defvasid = -1;
	if(typeid.equals(gaoqingdapian)){
		defvasid = dapiandefvas;
	}else if(typeid.equals(gaoqingreju)){
		defvasid = rejudefvas;
	}else if(typeid.equals(gaoqingyule)){
		defvasid = yuledefvas;
	}else if(typeid.equals(gaoqingjishi)){
		defvasid = jishidefvas;
	}
	HashMap detailMap = (HashMap)metadata.getVasDetailInfo(defvasid);
	if(detailMap!=null){
		HashMap posterMap = (HashMap)detailMap.get("POSTERPATHS");
		//0.缩略图1.海报2.剧照3.图标4.标题图5.广告图6.草图7.背景9.频道图99.其他
		String picPath = "../../"+getPosterPath(posterMap,"images/display/vod/poster_no_pic.jpg","1",request);
		defaultpic = picPath;
	}			
%>
<script type="text/javascript">
	var returnurl = unescape("<%=returnurl%>");
	var curpage = <%=curpage%>;
	var pagesize = <%=pagesize%>;
	var pagecount = <%=pagecount%>;
	var typeid = "<%=typeid%>";
	var typename = "<%=typename%>";
	var datalist = <%=datalist%>;
	var defaultpic = "<%=defaultpic%>";
</script>