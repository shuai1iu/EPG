<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="net.sf.json.JSONArray"%>
<%@ page import="net.sf.json.JSONObject"%>
<%@ include file="database.jsp"%>

<%@ include file="../../util/util_getPosterPaths.jsp"%>

<script>
<%
   
   //修改为动态的获取数据
   int pageSize=15;
   String postertype = "2";
   ArrayList newresultList=new ArrayList();
   MetaData metadata = new MetaData(request);
   ArrayList typeList = (ArrayList)metadata.getTypeListByTypeId(zhuanti,-1,0);
   if(typeList!=null&&typeList.size()>1){
		ArrayList resultList = (ArrayList)typeList.get(1);
		if(resultList != null)
		{
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
				//JUST FOR TEST!!!!!!! hhr
				if("no".equals(SwitchByIntro)) 
				newresultList.add(mapnew);
				
			}
		}   
   }
   
   
  /*  int pageSize=3;
    ArrayList newresultList=new ArrayList();
	for(int i=0;i<zhuanticode.length;i++)
	{ 
		String[] res=zhuanticode[i].split("==");
		String Name=res[0];
		String Value=res[1];
		String Pic=res[2];
		HashMap map=new HashMap();
		map.put("TopicName",Name);
		map.put("TopicCode",Value);
		map.put("TopicPic",Pic);
		newresultList.add(map);
	}*/
	
%>
var topicList=new Array();
<%for(int i=0;i<newresultList.size();i++)
{
%>
    var tempObj ={};
	tempObj.TopicName = '<%=((HashMap)newresultList.get(i)).get("TopicName")%>';
	tempObj.TopicCode = '<%=((HashMap)newresultList.get(i)).get("TopicCode")%>';
	tempObj.TopicPic = '<%=((HashMap)newresultList.get(i)).get("TopicPic")%>';
	tempObj.TopicType = '<%=((HashMap)newresultList.get(i)).get("TopicType")%>';
	topicList[<%=i%>] = tempObj;
<%
}
%>
var totallist=topicList;
var pagesize = <%=pageSize%>;
var pagecount = parseInt((totallist.length-1)/pagesize)+1;
</script>
