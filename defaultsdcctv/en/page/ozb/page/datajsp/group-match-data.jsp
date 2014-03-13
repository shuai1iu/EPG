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
<script language="javascript" type="text/javascript">
var typeList = new Array();
<%
	MetaData metadata = new MetaData(request);
	String postertype = "0";
	String matchType = request.getParameter("matchType");
	if(matchType == null || matchType.equals(""))
	{
		//小组赛
		matchType = "group";
	}
	ArrayList typeList = (ArrayList)metadata.getTypeListByTypeId(Match_Vod,-1,0);
	if(typeList!=null&&typeList.size()>1){
		ArrayList resultList = (ArrayList)typeList.get(1);
		int count = 1;
		if(resultList != null)
		{
			for(int i = 0 ;i < resultList.size(); i ++)
			{
				HashMap map = (HashMap)resultList.get(i);
				String defaultPath = "";
				HashMap posterPathMap = (HashMap)map.get("POSTERPATHS");
				//String picPath = getPosterPath(posterPathMap,request,defaultPath,postertype).toString();
				String picPath = getPosterPath(posterPathMap,request,"absolute",postertype).toString();
				if(matchType.equals("group"))
				{
					if(count > 4)
						break;
					++count;
				}
				else if(matchType.equals("knockout"))
				{
					if( i < 4)
						continue;
					
				}
				
	
				%>
				
				var typeItem = {};
				typeItem.typeId = '<%=map.get("TYPE_ID")%>';
				typeItem.typeName = '<%=map.get("TYPE_NAME")%>';
				typeItem.picPath =  '<%=picPath%>';
				typeList.push(typeItem);
				<%
			}
		}
	}
%>
</script>