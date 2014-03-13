<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
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
	//收藏夹容量
    int favoSize = serviceHelp.getFavouriteLimit();
	//保存修改
    ArrayList userFavo= (ArrayList)userInfo.getFavorite();   
	int succ = 0;  
    if(progId == null ||progType== null || favoSize == 0)
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
					boolean ret = serviceHelp.insFavItem(progId,progType);
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
