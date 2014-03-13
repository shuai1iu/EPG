<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="database.jsp"%>
<script>

<%
ArrayList focus=getFocus("clive",request);
String backflag=request.getParameter("back");

HashMap areas=new HashMap();
if("1".equals(backflag))
{
if(focus!=null)
{
   for(int i=0;i<focus.size();i++)
   {
	   HashMap foc=(HashMap)focus.get(i);
	   areas.put(""+foc.get("areaid"),foc);
   }
}
}
int curpage=1;
if(!areas.isEmpty())
{
	
	if(areas.get("1")!=null)
	{
		curpage=Integer.parseInt((((HashMap)areas.get("1")).get("curpage")).toString());
	}
	else
	{
		curpage=Integer.parseInt((((HashMap)areas.get("0")).get("curpage")).toString());
	}
}
int curindex=((!areas.isEmpty()&&areas.get("1")!=null)?Integer.parseInt((((HashMap)areas.get("1")).get("curindex")).toString()):0);
//String[][] imgs={{"PICPATH","images/temp/15.jpg"}};
//String[] texts={"name","sex"};
//ArrayList array=new MyUtil(request).getVodListSimulateData(texts,imgs,20);
MetaData metaData = new MetaData(request);
ArrayList result = metaData.getChanListByTypeId(biaoqingzhibocode,-1,0);
//ArrayList result1 = metaData.getChanListByTypeId(gaoqingzhibocode,-1,0);
ArrayList channel=(ArrayList)result.get(1);
//ArrayList channel1=(ArrayList)result1.get(1);
//channel.addAll(channel1);
//把高清放前面需求
/*
ArrayList channel1=(ArrayList)result.get(1);
ArrayList channel=new ArrayList();
ArrayList s=new ArrayList();
for(int i=channel1.size()-1;i>=0;i--)
{
    HashMap map = (HashMap)channel1.get(i);
	int channelid=Integer.parseInt(map.get("CHANNELINDEX").toString());
	if(channelid>=1201&&channelid<=1209)
	{
		 s.add(map);
		 channel.add(0,channel1.get(i));	
	}
}
for(int i=0;i<s.size();i++)
{
    channel1.remove(s.get(i));	
}
channel.addAll(channel1);
*/
int count=channel.size();
int pagecount=(count-1)/8+1;
//ArrayList xx=new ArrayList();
//for(int i=0;i<19;i++)
//xx.add(channel.get(i));
//3.0盒子转换不了超过20条的数据量，修改为手动转换
//JSONArray channelList = JSONArray.fromObject(channel);
///修改20111228   ****添加焦点记忆
HashMap firstChannel=(HashMap)channel.get((!areas.isEmpty()&&areas.get("1")!=null)?Integer.parseInt((((HashMap)areas.get("1")).get("curindex")).toString())+8*(curpage-1):0);
int firstChannelID=Integer.parseInt(firstChannel.get("CHANNELID").toString());
//获得当前日期
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
java.util.Date currDate = new java.util.Date();
String str_CurrDateTime = formatter.format(currDate);
///修改20111228   ****添加焦点记忆
ArrayList recBill=metaData.getChannelRecBill(firstChannelID,3,0,-1,"-1");
int recpagecount=0;
JSONArray recChannelBill=null;
if(!new MyUtil().help(recBill))
{
HashMap temp=(HashMap)recBill.get(0);
int reccount=Integer.parseInt(temp.get("COUNTTOTAL").toString());
recpagecount=(reccount-1)/3+1;
recChannelBill = JSONArray.fromObject(recBill.get(1));
}
%>
var channelList=new Array();
<%for(int i=0;i<count;i++)
{
%>
    var tempObj ={};
	tempObj.ISTVOD= '<%=((HashMap)channel.get(i)).get("ISTVOD")%>';
	tempObj.UserChannelID = <%=((HashMap)channel.get(i)).get("CHANNELINDEX")%>;
	tempObj.ChannelName = '<%=((HashMap)channel.get(i)).get("CHANNELNAME")%>';
	tempObj.ChannelID = <%=((HashMap)channel.get(i)).get("CHANNELID")%>;
	tempObj.IsSubscribed = <%=((HashMap)channel.get(i)).get("ISSUBSCRIBED")%>;
	//alert(tempObj.ChannelName+tempObj.IsSubscribed);
	channelList.push(tempObj);
<%
}
%>
    var reclist=eval('('+'<%=recChannelBill%>'+')');
    var reccount='<%=recpagecount%>';
    var totallist=channelList;
    var pagecount='<%=pagecount%>';
</script>
