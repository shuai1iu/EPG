<!-- 文件名：space_collectAdd_iframedata.jsp -->
<!-- 描  述：添加收藏控制页面 -->
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>
<%
			ServiceHelp serviceHelp = new ServiceHelp(request);
			UserProfile userInfo = new UserProfile(request);
			TurnPage turnPage = new TurnPage(request);
			String pageName = "InfoDisplay.jsp?ERROR_ID=45";
            String progId = request.getParameter("PROGID");
            String progType = request.getParameter("PROGTYPE");
			//收藏夹容量
            int favoSize = serviceHelp.getFavouriteLimit();
			//保存修改
            ArrayList userFavo= (ArrayList)userInfo.getFavorite();   
			int succ = 0;  
            if(progId == null ||progType== null || favoSize == 0)
            {
			 
            }
			else
			{
		    	//增加插入操作时，判断收藏夹是否已满
				if(userFavo != null)
				{
					if(userFavo.size() >= favoSize)
					{
						 succ=2;
					}
					else if(userFavo.size() < favoSize )
					{
						boolean ret = serviceHelp.insFavItem(progId,progType);
						if(ret == false)
						{
							succ=0;
						}
						else if(ret == true)
						{           
							succ=1;              
						} 
					}
				}
		  }
	      response.getWriter().print(succ);	     
%>
