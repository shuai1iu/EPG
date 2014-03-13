<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%
	String varName = request.getParameter("varName")==null?"tempAddFav":request.getParameter("varName");
	String isBug = request.getParameter("isBug")==null?"-1":request.getParameter("isBug").toString();
	String isJson = request.getParameter("isJson")==null?"-1":request.getParameter("isJson").toString();
	String progId = request.getParameter("programCode") == null ? "-1" : request.getParameter("programCode");
	String progType = request.getParameter("programType") == null ? "-1" : request.getParameter("programType");
	
	
	ServiceHelp serviceHelp = new ServiceHelp(request);
	UserProfile userInfo = new UserProfile(request);
	JSONObject favResult = null;
	HashMap result = new HashMap();
    int succ = 0;
    
	if(progId == null ||progType== null )
    {
		result.put("result",succ);
    }
	else
	{
		boolean ret = serviceHelp.delFavItem(progId,progType);
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
%>
<%
if(isBug.equals("1"))
{
	System.out.println(favResult);
}
if(isJson.equals("-1"))
{
%>	
var <%=varName%> = <%=favResult%>;
<%
}
else
{
 response.getWriter().print(favResult.toString());	 
}
%>