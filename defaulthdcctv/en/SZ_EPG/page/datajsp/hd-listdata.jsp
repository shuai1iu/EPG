<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="java.util.*"%>
<%	
	String path = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getRequestURI().substring(0,request.getRequestURI().lastIndexOf("/")+1);
	MetaData metadata = new MetaData(request);
	int curpage = request.getParameter("curpage")!=null?Integer.parseInt(request.getParameter("curpage")):1;
	int pagesize = 9;
	int pagecount = 0;
	int tempIndex = -1;
//	if(focstr!=null){
//		String focObj = String.valueOf(getState(analyticFocStr(focstr),"0","curpage"));
//		curpage = (focObj==null||focObj.equals("null"))?1:Integer.parseInt(focObj);	
//	}
	String returnurl = request.getParameter("returnurl")!=null?request.getParameter("returnurl"):"index.jsp";
	String sonTypeid = request.getParameter("sonTypeid")!=null?request.getParameter("sonTypeid"):null;
	String typeid = request.getParameter("typeid");
	String typename = "";
	
	int [] intSubjectType = {9999}; //只需要混合类型的
	int typeFlag = 2; //是否显示定制栏目 0.非定制栏目 1.定制栏目 2.所有栏目
	String fristTypeID = null;
	ArrayList allOriResultList = metadata.getTypeListByTypeId(typeid,-1,0);
	JSONArray tempdata = null;
	ArrayList fullTypeList = new ArrayList();
	if(allOriResultList != null && allOriResultList.size() > 1 && ((ArrayList)allOriResultList.get(1)).size() > 0){
		ArrayList ParseResultList = (ArrayList)allOriResultList.get(1);
		for(int i=0;i<ParseResultList.size();i++){
			HashMap tempMap = (HashMap)ParseResultList.get(i);	
			String introduce = (String)tempMap.get("TYPE_INTRODUCE");
			if(introduce!=null){
				HashMap resultMap = new HashMap();
				if(i == 3){fristTypeID = (String)tempMap.get("TYPE_ID");}
				if(sonTypeid != null && sonTypeid.equals((String)tempMap.get("TYPE_ID"))){
					tempIndex = i;
					}
				resultMap.put("TYPEID",(String)tempMap.get("TYPE_ID"));
				resultMap.put("TYPENAME",(String)tempMap.get("TYPE_NAME"));
				fullTypeList.add(resultMap);	//add需要的数据到fullTypeList 
			}
		}
		if(sonTypeid != null && tempIndex != -1){
			fristTypeID = sonTypeid;
			if(tempIndex < 3){
				for(int j = 0; j < 3-tempIndex; j++){
					HashMap testMap = (HashMap)fullTypeList.remove(fullTypeList.size() - (j + 1));
					fullTypeList.add(0,testMap);
					}
				}else if(tempIndex > 3){
					for(int k = 0; k < tempIndex - 3; k++){
						HashMap testMap = (HashMap)fullTypeList.remove(k);
						fullTypeList.add(testMap);
						}
					}
			}
		tempdata = JSONArray.fromObject(fullTypeList);
		}

	if(metadata.getTypeInfoByTypeId(typeid)!=null){
		HashMap typeinfo = (HashMap)metadata.getTypeInfoByTypeId(typeid);
		typename = typeinfo.get("TYPENAME").toString();
	}
	ArrayList list = metadata.getVodListByTypeId(fristTypeID, pagesize, (curpage-1)*pagesize);
	JSONArray datalist = null;
	if(list!=null&&list.size()>1&&((ArrayList)list.get(1)).size()>0){
		int count = ((Integer)((HashMap)list.get(0)).get("COUNTTOTAL")).intValue(); //总数量
		pagecount = (count-1)/pagesize+1;
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
	var tempdata = <%=tempdata%>;
	var returnurl = unescape("<%=returnurl%>");
	var curpage = <%=curpage%>;
	var pagesize = <%=pagesize%>;
	var pagecount = <%=pagecount%>;
	var typeid = "<%=fristTypeID%>";
	var farTypeid = "<%=typeid%>";
	var typename = "<%=typename%>";
	var datalist = <%=datalist%>;
	var defaultpic = "<%=defaultpic%>";
</script>
