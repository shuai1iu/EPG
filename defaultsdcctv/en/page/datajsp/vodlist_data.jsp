<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="../util/util_getPosterPaths.jsp"%>
<%@ include file="database.jsp"%>
<%@ include file="codepage.jsp"%>
<script type="text/javascript">
<%
	MetaData metadata = new MetaData(request);
	String postertype = "1";
	
	int pagecount = 0;    //页数
	int pagesize = 8;    //每页数据量

	String typeid = request.getParameter("typeid");
	String catename = request.getParameter("catename")==null?"推荐栏目":request.getParameter("catename");
	HashMap typeinfo =  (HashMap)metadata.getTypeInfoByTypeId(typeid);
	String parentId = typeinfo.get("PARENTID").toString();
	HashMap parentinfo =  (HashMap)metadata.getTypeInfoByTypeId(parentId);
	String rootId = parentinfo.get("PARENTID").toString();
	String returnurl = request.getParameter("returnurl");
	if(returnurl == null)
		returnurl = rootId.equals(animationtypeid)?"vod-catelist.jsp?typeid="+parentId+"&catename="+catename:"vod_turnpager.jsp?typeid="+parentId;
	JSONArray jvodlist = null;
	ArrayList vodlist = (ArrayList)metadata.getVodListByTypeId(typeid,-1,0);
	if(vodlist!=null && vodlist.size() > 1 && ((ArrayList)vodlist.get(1)).size() > 0){
		int count = ((Integer)((HashMap)vodlist.get(0)).get("COUNTTOTAL")).intValue(); //总数量
		pagecount = (count-1)/pagesize+1;
		ArrayList tempList = new ArrayList();
		ArrayList vod_list = (ArrayList)vodlist.get(1);
		for(int i = 0;i<vod_list.size();i++){		
			HashMap mapx=(HashMap)vod_list.get(i);
			HashMap tempmap = new HashMap();
			String tmpvodid = mapx.get("VODID").toString();
			String tmpvodname = mapx.get("VODNAME").toString();
			tempmap.put("VODID",tmpvodid);	
			tempmap.put("VODNAME",tmpvodname);	
			HashMap mediadetailInfo = (HashMap)metadata.getVodDetailInfo(Integer.parseInt(tmpvodid));
			HashMap postersMap = (HashMap)(mediadetailInfo.get("POSTERPATHS"));
			String picpath = (String)mediadetailInfo.get("PICPATH");
			String postpath =  getPosterPath(postersMap,request,picpath,postertype).toString();
			tempmap.put("POSTERPATH","../"+postpath);
			tempmap.put("PICPATH","../"+picpath);
			tempList.add(tempmap);
		}
		jvodlist = JSONArray.fromObject(tempList);
	}	
%>
var pagesize = <%=pagesize %>;
var pagecount = <%=pagecount %>;
var returnurl = '<%=returnurl %>';
var catename = '<%=catename %>';
var jVodlist = <%=jvodlist%>; 
var typeid = '<%=typeid%>';
function bindVodlistData(data) {
	for (i = 0; i < area0.doms.length; i++) {
		if (i < data.length) {
			area0.doms[i].setcontent("",data[i].VODNAME,12);
			area0.doms[i].updateimg(data[i].POSTERPATH);
			area0.doms[i].mylink="vod-tv-detail.jsp?vodid="+data[i].VODID+"&catename="+catename+"&typeid=<%=typeid%>"+"&returnurl="+location.href;
		}else{
			area0.doms[i].updatecontent("");
			area0.doms[i].updateimg("#");
			area0.doms[i].mylink = "";
		}
	}
	area0.setpageturndata(data.length, pagecount);
    area0.doms[area0.curindex].changefocus(true);

	catename=unescape(catename); 
	$('catename').innerHTML = catename;
	if(pagecount<=0){
		$('pageinfo').innerHTML = "0<span>/0</span>";
	}else{
		$('pageinfo').innerHTML = area0.curpage+"<span>/"+area0.pagecount+"</span>";
	}	
}
</script>
