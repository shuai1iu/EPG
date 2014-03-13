<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page language="java" import="java.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="com.huawei.iptvmw.epg.facade.metadata.CommonImpl" %>
<%@ page import="com.huawei.iptvmw.epg.util.xml.DateUtilities" %>
<%@ include file="keyboard/keydefine.jsp" %>
<%@ include file="config/config_playControl.jsp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%
String returnurl = request.getParameter("returnurl");
String CHANNELNUM = request.getParameter("CHANNELNUM");//预览标识；1:支持 0:不支持
String COMEFROMFLAG = request.getParameter("COMEFROMFLAG");
String CHANNELID = request.getParameter("CHANNELID");
String strControlFlag = request.getParameter("ControlFlag");

%>
<html>
   <script type="text/javascript" src="../js/mediaPlayerEx.js"></script>
   <script type="text/javascript"> 
    
     var mediaManage = new MediaManager();
     var isJoinChannle=true;
	 var returnurl = "<%=returnurl%>";
    
     function goBack(){
		 //设置直播页保存焦点的flag
		 if(returnurl.indexOf('back=1')==-1){
		   if(returnurl.indexOf('?')==-1)
			  returnurl+="?back=1";
		   else
			  returnurl+="&back=1";
		}
    	window.location.href=returnurl;
     }
 
     function keyevent(evt) {
        evt = evt || window.event;
        var keyCode = evt.keyCode ? evt.keyCode : evt.which;
        var ret = false;
        if (window.frames["EPG"].keypress) {
            ret = window.frames["EPG"].keypress(keyCode);
        }
        return 1;
     }
   
   </script>
    <frameset rows="540" frameborder="no" border="0" framespacing="0">
    <frame src="playChannelList.jsp?ControlFlag=<%=strControlFlag%>&CHANNELID=<%=CHANNELID%>&CHANNELNUM=<%=CHANNELNUM%>&COMEFROMFLAG=<%=COMEFROMFLAG%>" name="EPG" scrolling="No" noresize="noresize" id="EPG"/>
    <noframes>
        <body>您的浏览器无法处理框架！</body>
    </noframes>
</frameset>
</html>
