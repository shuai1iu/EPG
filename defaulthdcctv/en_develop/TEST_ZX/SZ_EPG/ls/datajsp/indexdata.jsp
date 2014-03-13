<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="java.util.*"%>
<%
	String epgPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/EPG/jsp/";
	ServiceHelp serviceHelp = new ServiceHelp(request);
	MetaData metadata = new MetaData(request);
	ArrayList list = metadata.getVasListByTypeId(shouyecode1, 1, 0);
	JSONArray datalist1 = null;
	
	if(list!=null&&list.size()>1&&((ArrayList)list.get(1)).size()>0){
		ArrayList tempList = new ArrayList();
		ArrayList vasList = (ArrayList)list.get(1);
		for(int i=0;i<vasList.size();i++){
			HashMap tempMap =(HashMap) ((HashMap)vasList.get(i)).clone(); //克隆出来修改
			Integer vasid = (Integer)(tempMap.get("VASID"));
			HashMap detailMap = (HashMap)metadata.getVasDetailInfo(vasid);
			if(detailMap!=null){
				HashMap posterMap = (HashMap)detailMap.get("POSTERPATHS");
				//0.缩略图1.海报2.剧照3.图标4.标题图5.广告图6.草图7.背景9.频道图99.其他
				String picPath = "../../"+getPosterPath(posterMap,"images/display/vod/poster_no_pic.jpg","5",request);
				tempMap.put("VASPIC",picPath);	
			}
			String vasurl = epgPath + serviceHelp.getVasUrl(vasid);
			tempMap.put("VASURL",vasurl);			
			tempList.add(tempMap);
		}
		datalist1 = JSONArray.fromObject(tempList);
	}
	
	ArrayList list2 = metadata.getVasListByTypeId(shouyecode2, 4, 0);
	JSONArray datalist2 = null;
	
	if(list2!=null&&list2.size()>1&&((ArrayList)list2.get(1)).size()>0){
		ArrayList tempList = new ArrayList();
		ArrayList vasList = (ArrayList)list2.get(1);
		for(int i=0;i<vasList.size();i++){
			HashMap tempMap =(HashMap) ((HashMap)vasList.get(i)).clone(); //克隆出来修改
			Integer vasid = (Integer)(tempMap.get("VASID"));
			HashMap detailMap = (HashMap)metadata.getVasDetailInfo(vasid);
			if(detailMap!=null){
				HashMap posterMap = (HashMap)detailMap.get("POSTERPATHS");
				String picPath = "../../"+getPosterPath(posterMap,"images/display/vod/poster_no_pic.jpg","5",request);
				tempMap.put("VASPIC",picPath);
			}
			String vasurl = epgPath + serviceHelp.getVasUrl(vasid);
			tempMap.put("VASURL",vasurl);			
			tempList.add(tempMap);
		}
		datalist2 = JSONArray.fromObject(tempList);
	}
%>
<script type="text/javascript">
	var datalist1 = <%=datalist1%>;
	var datalist2 = <%=datalist2%>;
</script>