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
	String postertype = "2";
	
	int pagecount = 0;    //页数
	int pagesize = 6;    //每页数据量

	String returnurl = request.getParameter("returnurl")==null?"index.jsp?back=1":request.getParameter("returnurl");

	JSONArray jtopiclist = null;
    ArrayList typeList = (ArrayList)metadata.getTypeListByTypeId(topiccode,-1,0);
    if(typeList!=null&&typeList.size()>1){
		//int count = ((Integer)((HashMap)typeList.get(0)).get("COUNTTOTAL")).intValue(); //总数量
		//pagecount = (count-1)/pagesize+1;
		ArrayList resultList = (ArrayList)typeList.get(1);
		if(resultList != null)
		{
			ArrayList newresultList=new ArrayList();
			for(int i = 0 ;i < resultList.size(); i ++)
			{
				HashMap map = (HashMap)resultList.get(i);
				
				HashMap posterPathMap = (HashMap)map.get("POSTERPATHS");
				String picPath = getPosterPath(posterPathMap,request,"absolute",postertype).toString();
				
				HashMap mapnew=new HashMap();
				mapnew.put("TopicName",map.get("TYPE_NAME"));
				mapnew.put("TopicCode",map.get("TYPE_ID"));
				mapnew.put("TopicPic",picPath);
				String SwitchByIntro = (String)map.get("TYPE_INTRODUCE");
				mapnew.put("TopicType",SwitchByIntro);
				//no表示在16上显示，te 用于区分18大和其他专题
				if("yes".equals(SwitchByIntro)||"te".equals(SwitchByIntro)) 
				newresultList.add(mapnew);			
			}
			jtopiclist = JSONArray.fromObject(newresultList);
		}   
    }
%>
var pagesize = <%=pagesize %>;
var returnurl = '<%=returnurl %>';
var jTopiclist = <%=jtopiclist%>; 
var pagecount = parseInt((jTopiclist.length-1)/pagesize)+1;

function bindTopiclistData(data) {
	for (i = 0; i < area0.doms.length; i++) {
		if (i < data.length) {
			area0.doms[i].updateimg(data[i].TopicPic);
			var StrType = data[i].TopicType;
			if(StrType.indexOf("te")>=0)
				area0.doms[i].mylink = "ori-dibbling-group-two-te.jsp?catacode="+data[i].TopicCode+"&returnurl="+escape(location.href)+"&typenum=4";	//for 18da
			else
				area0.doms[i].mylink = "ori-dibbling-group-two.jsp?catacode="+data[i].TopicCode+"&returnurl="+escape(location.href)+"&typenum=4";
		}else{
			area0.doms[i].updateimg("#");
			area0.doms[i].mylink = "";
		}
	}
	area0.setpageturndata(data.length, pagecount);
	area0.doms[area0.curindex].changefocus(true);
	if(pagecount<=0){
		$('pageinfo').innerHTML = "0/0";
	}else{
		$('pageinfo').innerHTML = area0.curpage+"/"+area0.pagecount;
	}
}
</script>
