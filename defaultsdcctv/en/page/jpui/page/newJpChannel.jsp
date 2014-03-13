<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONArray"%>
<%@ page import="net.sf.json.JSONObject"%>
<%
    String channelcode = request.getParameter("channelcode")==null?"":request.getParameter("channelcode").toString();
	String area0index = request.getParameter("area0index")==null?"0":request.getParameter("area0index").toString();
	String area1index = request.getParameter("area1index")==null?"0":request.getParameter("area1index").toString();
	String area2index = request.getParameter("area2index")==null?"0":request.getParameter("area2index").toString();
	String channelid = request.getParameter("channelid")==null?"":request.getParameter("channelid").toString();
    String isfromtvod = request.getParameter("isfromtvod")==null?"0":request.getParameter("isfromtvod").toString();
	String returnurl = request.getParameter("returnurl")==null?"../../index.jsp":request.getParameter("returnurl").toString();
	JSONArray recChannelBill=null;
	MetaData metaData = new MetaData(request);
   
    ArrayList result=new ArrayList();
    ArrayList result1=new ArrayList();
    result = metaData.getChanListByTypeId("10000100000000090000000000039770",4,0);
    result1=(ArrayList)result.get(1);
    

	
	ArrayList recChanList=new ArrayList();
	
	for(int j=0;j<result1.size();j++)
	{
		HashMap chanInfomap = (HashMap)result1.get(j);
		String tempchannelcode =String.valueOf(chanInfomap.get("CHANNELID"));
		int tempchannelid = ((Integer)chanInfomap.get("CHANNELINDEX")).intValue()-1000;
		String tempchannelname = String.valueOf(chanInfomap.get("CHANNELNAME"));
		HashMap chanInfomap1 = new HashMap();
		chanInfomap1.put("channelname",tempchannelname);
		chanInfomap1.put("channelid",tempchannelid);
		chanInfomap1.put("channelcode",tempchannelcode);
		
		 if(channelcode.equals("") && j==0){
			channelcode=tempchannelcode;
		}
		if(channelid.equals("") && j==0){
			channelid=String.valueOf(tempchannelid);
		}
		recChanList.add(chanInfomap1);
	}  
	recChannelBill = JSONArray.fromObject(recChanList);
 %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<script type="text/javascript">
 var returnurl = "<%=returnurl%>";
 var STBType = Authentication.CTCGetConfig("STBType");
 if(STBType.indexOf("EC1308_pub")!=-1){
	window.location.href = "../../play_ControlChannelJP.jsp?CHANNELNUM=13&COMEFROMFLAG=1&returnurl=index.jsp";
 }
 var mp = new MediaPlayer();
 var channellist=eval('('+'<%=recChannelBill%>'+')');
 var area0index=<%=area0index%>;
 var area1index=<%=area1index%>;
 var area2index=<%=area2index%>;
 var isfromtvod=<%=isfromtvod%>;
 var channelcode="<%=channelcode%>";
 var channelid="<%=channelid%>";
 var shiftFlag = 0;
 //回退
 function goBack(){
	window.location.href = returnurl;
 }
 
 //跳转到指定页面
 function goToUrl(temptourl){
	 mp.stop();
	 mp.leaveChannel();
	 mp.releaseMediaPlayer(mp.getNativePlayerInstanceID());
	 var tempurl=window.location.href;
	 if(tempurl.indexOf("?")!=-1){
		 var tempindex=tempurl.indexOf("?");
		 tempurl=tempurl.substring(0,tempindex);
	 }
	 tempurl=tempurl+"?channelid="+channelid+"&channelcode="+channelcode+"&area0index="+area0index+"&area1index="+area1index+"&area2index="+area2index+"&isfromtvod=1&returnurl="+returnurl;
	 window.location.href = temptourl+"&returnurl="+escape(tempurl);
 }
 
</script>
</head>
 <frameset rows="0,100" frameborder="no" border="0" framespacing="0">
    <frame name="playerFrame" width="0px" height="0px" src="jpmediaPlayer.jsp?chanNum=<%=channelid%>"></frame>
	<frame name="viewFrame" width="640px" height="530px" src="playJPChannel.jsp?ishownum=1&channelid=<%=channelid%>&channelcode=<%=channelcode%>&area0index=<%=area0index%>&area1index=<%=area1index%>&area2index=<%=area2index%>" scrolling="no"></frame>
    <noframes>
	  <body bgcolor="transparent"></body>
    </noframes>
</frameset>
</html>
