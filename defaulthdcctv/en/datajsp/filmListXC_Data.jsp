<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" buffer="32kb"%>
<%@ page import="java.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ include file = "SubStringFunction.jsp"%>
<%@ include file = "../util/util_getPosterPaths.jsp"%>
<%@ include file="../configXC/config_xinchan.jsp"%>
<script type="text/javascript">
var vodProgList=[];
<%

    String TypeId="";
    TurnPage turnPage = new TurnPage(request);
    MetaData metaData = new MetaData(request);
    String TypeFlag=(null==(String)request.getParameter("TYPEFLAG")?"0":(String)request.getParameter("TYPEFLAG"));
	if("0".equals(TypeFlag))
	{
		TypeId=TYPEID_0;
	}
	else if("1".equals(TypeFlag))
	{
		TypeId=TYPEID_1;
	}
	else if ("2".equals(TypeFlag))
	{
		TypeId=TYPEID_2;
	}
	System.out.println("TypeId="+TypeId);
    ArrayList vodinfoList= metaData.getVodListByTypeId(TypeId,999,0);
	System.out.println("vodinfoList="+vodinfoList);
	if(vodinfoList==null ||vodinfoList.size()!=2)
	{
	    turnPage.removeLast();
%>
       parent.location.href = "../InfoDisplay.jsp?ERROR_ID=25&ERROR_TYPE=2";
<%
    }
    else
	{
	    ArrayList realvodinfoList = (ArrayList)vodinfoList.get(1);
		if(realvodinfoList!=null && realvodinfoList.size()>0)
		{
		    int vodSize = realvodinfoList.size();
		    for(int i=0;i<vodSize;i++)
		    {
				HashMap realvodinfoListmap = (HashMap)realvodinfoList.get(i);
				//获取点播节目Id
				int vodId=((Integer)realvodinfoListmap.get("VODID")).intValue();
				//获取点播节目名称
				String vodName = (String)realvodinfoListmap.get("VODNAME");
				String subvodName = subStringFunction((String)realvodinfoListmap.get("VODNAME"),1,240);
				//海报信息
			    HashMap picpathTemp = (HashMap)realvodinfoListmap.get("POSTERPATHS"); 
			    String picPath = getPosterPath(picpathTemp,request);
			    if(picPath=="false")
			    {
			        picPath="images/display/vod/poster_no_pic.jpg";
			    }
%>
                var tempObject = {};
		        tempObject.vodId = "<%=vodId%>";
		        tempObject.vodName = "<%=vodName%>";
				tempObject.subvodName = "<%=subvodName%>";
				tempObject.vodPoster= "<%=picPath%>";
				tempObject.isType= "0";
		        vodProgList.push(tempObject);
<%						
		    }
		}
		else 
		{
%>
             var tempObject = {};
		     tempObject.vodName = "暂无数据";
			 tempObject.subvodName = "暂无数据";
			 tempObject.vodPoster= "";
			 tempObject.isType= "0";
		     vodProgList.push(tempObject);
<%
		}	
	}
%>
parent.dataFlag=1;
parent.data=vodProgList;
parent.dataOK();
</script>