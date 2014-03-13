<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ include file="SubStringFunction.jsp"%>
<script language="javascript"  type="text/javascript">
<%
int curpage=1;
int indexid=8;
int areaid=0;

if(request.getParameter("curpage")!=null)
{
	curpage = Integer.parseInt(request.getParameter("curpage"));
}
if(request.getParameter("indexid")!=null)
{
	indexid = Integer.parseInt(request.getParameter("indexid"));
}
if(request.getParameter("areaid")!=null)
{
	areaid = Integer.parseInt(request.getParameter("areaid"));
}
%>

   var scrollText = "汪森山的空间";
   var strinstruText="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用户可通过遥控器上的上下左右键来移动焦点框的位置，高清版电子导航菜单结构采用从左至右的操作方式，使用返回键可返回上一级菜单，使用确认键进入下一级菜单，页面操作过程中，可使用菜单键返回首页，用户在观看点播节目或回看节目过程中，使用前进/后退键进行时移。<br/>&nbsp;&nbsp;&nbsp;&nbsp;观看直播频道，用户可直接输入频道编号快速进入，也可以使用遥控器上的频道按键进行选台操作，使用音量键调节音量大小。在观看直播节目时，按信息键了解当前播放节目信息。";
   var jscurpage=<%=curpage%>;
   var indexid=<%=indexid%>;
   var areaid=<%=areaid%>;
</script>