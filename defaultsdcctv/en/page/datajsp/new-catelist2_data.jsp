<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
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
<script type="text/javascript">
<%
	MetaData metadata = new MetaData(request);
	String typeid = request.getParameter("typeid");
	String catename = request.getParameter("catename")==null?"推荐栏目":request.getParameter("catename");
	HashMap typeinfo =  (HashMap)metadata.getTypeInfoByTypeId(typeid);
	String parentId = typeinfo.get("PARENTID").toString();
	String returnurl = request.getParameter("returnurl")==null?"vod_turnpager.jsp?typeid="+parentId:request.getParameter("returnurl");
	int[] intSubjectType = {9999};

	int pagecount = 0;    //页数
	int pagesize = 6;    //每页数据量

	
	JSONArray jsoncatelist = null;
	
	ArrayList cateresultList = metadata.getTypeListByTypeId(typeid,-1,0,intSubjectType);
	if(cateresultList != null && cateresultList.size() > 1 && ((ArrayList)cateresultList.get(1)).size() > 0){
		int count = ((Integer)((HashMap)cateresultList.get(0)).get("COUNTTOTAL")).intValue(); //总数量
		pagecount = (count-1)/pagesize+1;
		ArrayList tempList = new ArrayList();
		ArrayList tempResultList = (ArrayList)cateresultList.get(1);
		for(int i = 0;i<tempResultList.size();i++){
			HashMap tempmap = new HashMap();
			HashMap mapx=(HashMap)tempResultList.get(i);
			tempmap.put("TYPE_ID",mapx.get("TYPE_ID").toString());
			tempmap.put("TYPE_NAME",mapx.get("TYPE_NAME").toString());		
			tempList.add(tempmap);		
		}	
		jsoncatelist = JSONArray.fromObject(tempList);
	}
	
%>
var pagesize = <%=pagesize %>;
var pagecount = <%=pagecount %>;
var jCatelist = <%=jsoncatelist%>
var returnurl = '<%=returnurl %>';
var catename = '<%=catename %>';
var typeid = '<%=typeid%>';
//填充栏目
function bindCateData(data) {
		catename=unescape(catename);
	    if(catename=="推荐栏目"){
			$('catename').innerHTML = '推荐栏目';
		}else{
			var tmpname=catename.split('-');
			$('catename').innerHTML = tmpname[0]+'-<span>'+tmpname[1]+'</span>';
		}
        for (i = 0; i < area0.doms.length; i++) {
            if (i < data.length) {
				area0.doms[i].setcontent("",data[i].TYPE_NAME,12);
				area0.doms[i].mylink="vodlist.jsp?typeid="+data[i].TYPE_ID+"&catename="+escape(catename+"-"+data[i].TYPE_NAME)
										+"&returnurl="+escape(location.href);
            }else{
                area0.doms[i].updatecontent("");
			}
        }
		area0.setpageturndata(data.length, pagecount);
		area0.doms[area0.curindex].changefocus(true);

		if(pagecount<=0){
			$('pageinfo').innerHTML = "0<span>/0</span>";
		}else{
			$('pageinfo').innerHTML = area0.curpage+"<span>/"+area0.pagecount+"</span>";
		}
}
</script>
