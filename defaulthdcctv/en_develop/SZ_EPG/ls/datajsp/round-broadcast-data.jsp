<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<script>
<%
int curpage=1;
int curindex=0;
int curareaid=1;

String returnurl="";
curpage=request.getParameter("curpage")!=null?Integer.parseInt(request.getParameter("curpage")):1;
curindex=request.getParameter("curindex")!=null?Integer.parseInt(request.getParameter("curindex")):0;
curareaid=request.getParameter("curareaid")!=null?Integer.parseInt(request.getParameter("curareaid")):1;
returnurl=request.getParameter("returnurl")!=null?request.getParameter("returnurl"):"index.jsp";

MetaData metaData = new MetaData(request);

ArrayList result = metaData.getChanListByTypeId("10000100000000090000000000031288",Integer.MAX_VALUE,0);
ArrayList channel=(ArrayList)result.get(1);

int channelpagesize=10;
int channelcount=channel.size();
int channelpagecount=(channelcount-1)/channelpagesize+1;

%>
var channelList=new Array();
<%for(int i=0;i<channelcount;i++)
{
   
%>
    var tempObj ={};
	tempObj.UserChannelID = parseInt('<%=((HashMap)channel.get(i)).get("CHANNELINDEX")%>');
	tempObj.ChannelName = '<%=((HashMap)channel.get(i)).get("CHANNELNAME")%>';
	tempObj.ChannelID = <%=((HashMap)channel.get(i)).get("CHANNELID")%>;
	tempObj.IsSubscribed = <%=((HashMap)channel.get(i)).get("ISSUBSCRIBED")%>;
	
	//	alert(tempObj.ChannelName+tempObj.IsSubscribed);
	channelList[<%=i%>] = tempObj;
<%
}
%>
    var channelpagecount=<%=channelpagecount%>;
</script>
