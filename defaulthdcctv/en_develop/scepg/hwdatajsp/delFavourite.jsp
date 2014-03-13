<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%
	String varName = request.getParameter("varName")==null?"tempDelFav":request.getParameter("varName");
	String isBug = request.getParameter("isBug")==null?"-1":request.getParameter("isBug").toString();
	String isJson = request.getParameter("isJson")==null?"1":request.getParameter("isJson").toString();
	String favoriteType = request.getParameter("favoriteType") == null ? "" : request.getParameter("favoriteType");
	String categoryCode = request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode");
	String programCode = request.getParameter("programCode") == null ? "-1" : request.getParameter("programCode");
	String contentCode = request.getParameter("contentCode")==null?"-1":request.getParameter("contentCode");
	int intfavoriteType=-1;
	if(favoriteType.equals("VOD") ||  favoriteType.equals("TVOD")){
		intfavoriteType=0;
	}
	if(favoriteType.equals("CHAN")){
		intfavoriteType=1;
	}
	
	
	ServiceHelp serviceHelp = new ServiceHelp(request);
	UserProfile userInfo = new UserProfile(request);
	JSONObject favResult = null;
	HashMap result = new HashMap();
    int succ = 0;
    
	if(programCode == null ||intfavoriteType== -1 )
    {
		result.put("result",succ);
    }
	else
	{
		boolean ret = serviceHelp.delFavItem(programCode,String.valueOf(intfavoriteType));
		if( ret == false )
		{
			succ = 0;
			result.put("result",succ);
		}
		else
		{           
			succ = 1;
			result.put("result",succ);
		}     
	}
	favResult = JSONObject.fromObject(result);
	request.setAttribute(varName,favResult);
%>
<%
if(isBug.equals("1"))
{
	System.out.println(favResult);
}
if(isJson.equals("1"))
{
%>	
var <%=varName%> = <%=favResult%>;
<%
}
%>