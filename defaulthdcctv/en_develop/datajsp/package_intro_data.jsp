<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>

<script language="javascript"  type="text/javascript">
<%
String returnurl="package.jsp"; 
String packageBack="#";
int isorder=1;
if(request.getParameter("isorder")!=null)
{
	isorder = Integer.parseInt(request.getParameter("isorder"));
}
if(request.getParameter("returnurl")!=null)
{
	returnurl =request.getParameter("returnurl");
}
if(request.getParameter("packageBack")!=null)
{
	packageBack =request.getParameter("packageBack");
}

%>
   var packageimg = '<%=packageBack%>';
   var isorder =<%=isorder%>;
   var returnurl='<%=returnurl%>';
</script>