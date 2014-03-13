<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" buffer="32kb"%>
<%@ page import="java.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<script language="javascript"  type="text/javascript">
 var jsChannelList = new Array();
 var pageCount = 0;
 var totalRecord = 0;
 <%
   MetaData metaData = new MetaData(request);
   int totalRecord = 0;
   int pageCount = 0;
   ArrayList result = metaData.getChanListByTypeId(gaoqingzhibocode,-1,0);
   ArrayList result1 = metaData.getChanListByTypeId(biaoqingzhibocode,-1,0);
   ArrayList channelList=(ArrayList)result.get(1);
   ArrayList channel1=(ArrayList)result1.get(1);
   channelList.addAll(channel1);
   if(channelList == null )
   {
	   String errorPageName = "errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=104";
 %>
 	<jsp:forward page="<%=errorPageName%>" />
	
   <%}
   else 
   {%>
    <%
	ArrayList filterList = new ArrayList();
    
   for(int i = 0 ;i < channelList.size();i ++)
   {
   		HashMap itemHash = (HashMap)channelList.get(i);
   		if(itemHash == null)
	 	  continue;
		int isTvod =  (Integer)itemHash.get("ISTVOD");
		if(isTvod == 0)
			continue;
		filterList.add(channelList.get(i));
   }
	totalRecord = filterList.size();
	if(totalRecord % 22 == 0)
		pageCount = totalRecord  / 22;
	else
		pageCount = (totalRecord  / 22) + 1;	
	 for(int i = 0 ;i < totalRecord;i ++)
	 {
		HashMap itemHash = (HashMap)filterList.get(i);
   		if(itemHash == null)
	 	  continue;
	 %>
	 var channelObj = {};
	 channelObj.channelId =  '<%=itemHash.get("CHANNELID")%>';
	 channelObj.channelName = '<%=itemHash.get("CHANNELNAME")%>' ;
	 channelObj.channelNumber = '<%=itemHash.get("CHANNELINDEX")%>';
	 channelObj.isNvod = '<%=itemHash.get("ISNVOD")%>';
	 jsChannelList.push(channelObj);
  <% }
  }%>
      pageCount = <%=pageCount%>;
	  totalRecord = <%=totalRecord%>;

</script>