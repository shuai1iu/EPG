<%@ page contentType="text/html; charset=UTF-8" language="java"
	pageEncoding="UTF-8" buffer="32kb"%>
<%@ page import="java.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%@ include file="codepage.jsp"%>
<script language="javascript" type="text/javascript">

        var jsChannelList = new Array();
		var totalChannelList=new Array();
        <%
		Integer isComFromHD = request.getParameter("isComFromHD")==null?0:Integer.parseInt(request.getParameter("isComFromHD"));//czc  20131223   获取进入回放页面的标识
         MetaData metaData = new MetaData(request);
         int channelPageSize = 9;
         int channelPageCount = 0;
         int channelId = Integer.parseInt(request.getParameter("channelId"));
         int currItemPageIndex=1;
         int currFocusChannelIndex=0;
        
        //getchannelList,custome paging
         //ArrayList channelList = metaData.getChannelListInfo();
		 ArrayList result = new ArrayList();
		 ArrayList result1= new ArrayList();
		 if(isComFromHD==1)//czc  20131223    根据进入的上一个页面不同，显示不同的频道列表页，1表示来自央视精品专区
		 {
			 result = metaData.getChanListByTypeId("10000100000000090000000000039770",-1,0);
			 //result1 = metaData.getChanListByTypeId("-1",-1,0);
		 }
		 else
		 {
		     result = metaData.getChanListByTypeId(gaoqingzhibocode,-1,0);
			 result1 = metaData.getChanListByTypeId(biaoqingzhibocode,-1,0);
		 }
          ArrayList channelList=(ArrayList)result.get(1);
		 if(isComFromHD==0)
		 {
             ArrayList channel1=(ArrayList)result1.get(1);
             channelList.addAll(channel1);
		 }
		  ArrayList filterList = new ArrayList();
          String errorPageName = "errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=104";
          if(channelList == null)
          {%>
          	<jsp:forward page="<%=errorPageName%>" />
          <%}%>
        	
        <%
        	
        	
			for(int i  = 0 ; i < channelList.size() ; i ++)
			{
		
				HashMap item = (HashMap)channelList.get(i);
				int isTvod =  (Integer)item.get("ISTVOD");
				if(isTvod == 0)
					continue;
				filterList.add(channelList.get(i));
			}
			channelPageCount = filterList.size() % channelPageSize;
        	channelPageCount = (channelPageCount == 0 ? filterList.size() / channelPageSize  :  filterList.size() / channelPageSize + 1);
			if(filterList.size()<=channelPageSize)
			{
        		for(int i = 0 ; i < filterList.size(); i ++)
        		{
        			HashMap channelHash = (HashMap)filterList.get(i);
        			if(channelHash == null)
        				continue;
        			int tmpChannelId = Integer.parseInt(channelHash.get("CHANNELID").toString());
        			if(tmpChannelId ==  channelId)
						currFocusChannelIndex=i;
        			%>
        			var channelObj = {};
        			channelObj.channelId = '<%=channelHash.get("CHANNELID")%>';
        			channelObj.channelName = '<%=channelHash.get("CHANNELNAME")%>' ;
        			channelObj.channelNumber = '<%=channelHash.get("CHANNELINDEX")%>';
        			channelObj.isNvod = '<%=channelHash.get("ISNVOD")%>';
        			jsChannelList.push(channelObj);
        		<%}
        		
        	}
        	else
        	{
        		for(int i = 0 ; i < filterList.size(); i ++)
        		{
        			HashMap channelHash = (HashMap)filterList.get(i);
        			if(channelHash == null)
        				continue;
        			int tmpChannelId = Integer.parseInt(channelHash.get("CHANNELID").toString());
        			if(tmpChannelId ==  channelId)
        			{
        			currItemPageIndex = (i / channelPageSize) + 1;
        			int startPos = currItemPageIndex * channelPageSize - channelPageSize;
        			int endPos = startPos + channelPageSize;
        			if(endPos > filterList.size())
        			{
        				endPos = filterList.size();
        				//startPos = endPos - channelPageSize; 
        			}       				
        			for(int k = startPos; k < endPos; k ++)
        			{
        					HashMap itemHash = (HashMap)filterList.get(k);
				         int tmpId = Integer.parseInt(itemHash.get("CHANNELID").toString());
        			     if(tmpId ==  channelId)
        			         currFocusChannelIndex=k-startPos;
        			%>
        					var channelObj = {};
        					channelObj.channelId = '<%=itemHash.get("CHANNELID")%>';
        					channelObj.channelName = '<%=itemHash.get("CHANNELNAME")%>' ;
        					channelObj.channelNumber = '<%=itemHash.get("CHANNELINDEX")%>';
        					channelObj.isNvod = '<%=itemHash.get("ISNVOD")%>';
        					jsChannelList.push(channelObj);
        			 <% 
					 }
        		
					}
        	    } //end for
          } //end else 
		        for(int i = 0 ; i < filterList.size(); i ++)
        		{
        			HashMap channelHash = (HashMap)filterList.get(i);
        			if(channelHash == null)
        				continue;
        			
        			%>
        			var channelObj = {};
        			channelObj.channelId = '<%=channelHash.get("CHANNELID")%>';
        			channelObj.channelName = '<%=channelHash.get("CHANNELNAME")%>' ;
        			channelObj.channelNumber = '<%=channelHash.get("CHANNELINDEX")%>';
        			channelObj.isNvod = '<%=channelHash.get("ISNVOD")%>';
					totalChannelList.push(channelObj);
        		<%}%>
var pagecount = <%=channelPageCount %>;  
currFocusChannelIndex=<%=currFocusChannelIndex%>;
curPageIndex=<%=currItemPageIndex%>;
</script>
