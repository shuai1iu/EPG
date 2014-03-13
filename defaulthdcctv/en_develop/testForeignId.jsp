<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%
MetaData metaData = new MetaData(request);
HashMap VodId = metaData.getContentDetailInfoByForeignSN("00000001000000010000000002793301",0);
String rtspChan = request.getParameter("RTSPCHAN");
System.out.println(rtspChan);
System.out.println("VODID====" + VodId);
Object mediaMap = VodId.get("VODFILES");
ArrayList mMediaMap = (ArrayList)mediaMap;
System.out.println("mediaMap==" + mMediaMap.get(0));
Map vodId = metaData.getContentDetailInfoByForeignSN("00000001000000010000000002793301",0);
int iVodId = (Integer) vodId.get("VODID");
System.out.println("VODID===" + iVodId);
System.out.println("MAPVOD===" + vodId);
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="page-view-size" content="1280*720">
<title>RTSP播放</title>
</head>
<body  bgcolor="transparent">
</body>
<script>

window.onload=function()
{
 alert(<%=iVodId%>);
 window.location.href=au_PlayFilm.jsp?PROGID=<%=iVodId%>&PLAYTYPE=1&CONTENTTYPE=10&BUSINESSTYPE=1&returnurl=index.jsp;

}

</script>
</html>
