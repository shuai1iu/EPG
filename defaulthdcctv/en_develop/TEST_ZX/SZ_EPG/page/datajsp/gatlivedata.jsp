<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<script>
<%
int curpage=1;
int curindex=0;
int curareaid=0;
int playindex=0;
String returnurl="";
curpage=request.getParameter("curpage")!=null?Integer.parseInt(request.getParameter("curpage")):1;

playindex=request.getParameter("playindex")!=null?Integer.parseInt(request.getParameter("playindex")):0;

curindex=request.getParameter("curindex")!=null?Integer.parseInt(request.getParameter("curindex")):0;

curareaid=request.getParameter("curareaid")!=null?Integer.parseInt(request.getParameter("curareaid")):0;
returnurl=request.getParameter("returnurl")!=null?request.getParameter("returnurl"):"";
String playmode="";

playmode=request.getParameter("playmode")!=null?request.getParameter("playmode"):"tv";
MetaData metaData = new MetaData(request);
ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);

ArrayList result = metaData.getChanListByTypeId("10000100000000090000000000031288",9,0);
ArrayList channel=(ArrayList)result.get(1);

int channelpagesize=10;
int channelcount=channel.size();
int channelpagecount=(channelcount-1)/channelpagesize+1;

int vodpagecount=0;
int vodpagesize=4;
ArrayList list = metaData.getVodListByTypeId("00000100000000090000000000018172", 999, 0);
JSONArray datalist = null;
if(list!=null&&list.size()>1&&((ArrayList)list.get(1)).size()>0){
	        int count = ((Integer)((HashMap)list.get(0)).get("COUNTTOTAL")).intValue(); //总数量
		vodpagecount = (count-1)/vodpagesize+1;
		ArrayList tempList = new ArrayList();
		ArrayList vodList = (ArrayList)list.get(1);
		for(int i=0;i<vodList.size();i++){
			HashMap mapx = (HashMap)vodList.get(i);
			HashMap tempMap = new HashMap();
			String tmpvodid = mapx.get("VODID").toString();
                        int pid =Integer.parseInt(tmpvodid);
			String tmpvodname = mapx.get("VODNAME").toString();
			tempMap.put("VODID",tmpvodid);	
			tempMap.put("VODNAME",tmpvodname);	
			HashMap detailMap = (HashMap)metaData.getVodDetailInfo(Integer.parseInt(tmpvodid));
			HashMap posterMap = (HashMap)(detailMap.get("POSTERPATHS"));
			String playurl = serviceHelpHWCTC.getTriggerPlayUrlHWCTC(1,pid ,pid,"0","0","0","0","0");
			int st=playurl.indexOf("rtsp");//此为单播，需找华为提供组播测试。
			if(-1 != st)
			{
			    playurl=playurl.substring(st,playurl.length());
			}
			tempMap.put("playurl",playurl);	
			if(posterMap!=null){
				//0.缩略图1.海报2.剧照3.图标4.标题图5.广告图6.草图7.背景9.频道图99.其他
				String picUrl = "../../"+getPosterPath(posterMap,"images/display/vod/poster_no_pic.jpg","1",request);
				tempMap.put("PICURL",picUrl);	
		        }
		     tempList.add(tempMap);
	       }
	    datalist= JSONArray.fromObject(tempList);
}
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
	var voddatalist = <%=datalist%>;
	var vodpagecount= <%=vodpagecount%>;
</script>
