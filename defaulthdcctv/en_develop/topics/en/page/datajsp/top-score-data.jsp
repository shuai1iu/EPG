<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="codepage.jsp"%>
<%@ include file="../util/util_getPosterPaths.jsp"%>
<script type="text/javascript" language="javascript">
var groupList = new Array();
var picList = new Array();

<%
	MetaData metadata = new MetaData(request);
	String postertype = "0";
	String typeId = "";//top-score-catalogcode;
	int pageSize = 4;
	ArrayList typeList = (ArrayList)metadata.getTypeListByTypeId(Match_Vod,-1,0);
	
	int totalRecord = ((Integer)((HashMap)typeList.get(0)).get("COUNTTOTAL")).intValue(); 	//总数量
	int count = 1;
	int pageCount = 0;
	if(totalRecord % pageSize == 0)
		pageCount = totalRecord  / pageSize;
	else
		pageCount = (totalRecord  / pageSize) + 1;
	if(typeList!=null&&typeList.size()>1){
		
		ArrayList resultList = (ArrayList)typeList.get(1);
		if(resultList != null)
		{
			for(int i = 0 ;i < resultList.size(); i ++)
			{
				if(count > 4)
						break;
					++count;
				HashMap map = (HashMap)resultList.get(i);
				String defaultPath = "";
				HashMap posterPathMap = (HashMap)map.get("POSTERPATHS");
				String picPath = getPosterPath(posterPathMap,request,"absolute",postertype).toString();
				
	
				%>
				var typeItem = {};
				typeItem.typeId = '<%=map.get("TYPE_ID")%>';
				typeItem.typeName = '<%=map.get("TYPE_NAME")%>';
				typeItem.picPath =  '<%=picPath%>';
				groupList.push(typeItem);
				<%
			}
		}
	}
%>

/*******************************************/
<%

	  
	  /*ArrayList topScoreTypeList = (ArrayList)metadata.getTypeListByTypeId(Top_Score,-1,0);
	  if(topScoreTypeList != null && topScoreTypeList.size() == 2)
	  {
		  ArrayList topScoreResultList = (ArrayList)topScoreTypeList.get(1);
		  if(topScoreResultList != null)
		  {
			  for(int i = 0 ;i < topScoreResultList.size(); i ++)
			  {
			  HashMap map = (HashMap)topScoreResultList.get(i);
			  String defaultPath = "";
			  String tmpPosterType = "0";
			  if( i == 1)
				  tmpPosterType = "2";
			  HashMap posterPathMap = (HashMap)map.get("POSTERPATHS");
			  String picPath = getPosterPath(posterPathMap,request,defaultPath,tmpPosterType).toString();
			  %>
			  var picItem = {};
			  picItem.typeId = '<%=map.get("TYPE_ID")%>';
			  picItem.typeName = '<%=map.get("TYPE_NAME")%>';
			  picItem.picPath =  '../../'+'<%=picPath%>';
			  picList.push(picItem);
			  
		  <%
		  }
	  }
	}
	*/
	HashMap goalCollectionItem = (HashMap) metadata.getTypeInfoByTypeId(Top_Score);
	if(goalCollectionItem != null)
	{
		HashMap posterPathMap = (HashMap)goalCollectionItem.get("POSTERPATHS");
		//left pic
		String leftPicPath = getPosterPath(posterPathMap,request,"absolute","3").toString();
		
		String rightPicPath =getPosterPath(posterPathMap,request,"absolute","2").toString();
		%>
		 var leftItem = {};
		 leftItem.typeId = '<%=Top_Score%>';
		 leftItem.picPath =  '<%=leftPicPath%>';
		 picList.push(leftItem);
		 var rightItem = {};
		 rightItem.typeId = '<%=Top_Score%>';
		 rightItem.picPath =  '<%=rightPicPath%>';
		 picList.push(rightItem);
		<%
		
	}
%>


</script>
</script>