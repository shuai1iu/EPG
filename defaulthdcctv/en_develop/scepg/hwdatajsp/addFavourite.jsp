<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%
	String varName = request.getParameter("varName")==null?"tempAddFav":request.getParameter("varName");
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
	//收藏夹容量
    int favoSize = serviceHelp.getFavouriteLimit();
	//保存修改
    ArrayList userFavo= (ArrayList)userInfo.getFavorite();   
	int succ = 0;  
    if(programCode == null ||intfavoriteType== -1 || favoSize == 0)
    {
			 result.put("result",succ);
    }
	else
		{
		 //增加插入操作时，判断收藏夹是否已满
			if(userFavo != null)
			{
				if(userFavo.size() >= favoSize)
				{
					succ=2;
					result.put("result",succ);
				}
				else if(userFavo.size() < favoSize )
				{
					boolean ret = serviceHelp.insFavItem(programCode,String.valueOf(intfavoriteType));
					if(ret == false)
					{
						succ=0;
						result.put("result",succ);
					}
					else if(ret == true)
					{           
						succ=1;   
						result.put("result",succ);           
					} 
				}
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
