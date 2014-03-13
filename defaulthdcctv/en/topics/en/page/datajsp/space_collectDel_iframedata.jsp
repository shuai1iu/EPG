<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil" %>

<%
			ServiceHelp serviceHelp = new ServiceHelp(request);
			UserProfile userInfo = new UserProfile(request);
			TurnPage turnPage = new TurnPage(request);
			String pageName = "InfoDisplay.jsp?ERROR_ID=45";
            String progId = request.getParameter("PROGID");
            String progType = request.getParameter("PROGTYPE");
		    int succ = 0;
		    if(progId == null ||progType== null )
            {
		       succ = 0;
            }
			else
			{
			    boolean ret = serviceHelp.delFavItem(progId,progType);
			    if( ret == false )
				{
					succ = 0;
				}
				else
				{           
					succ = 1;
				}     
			}
            response.getWriter().print(succ);	       
%>
