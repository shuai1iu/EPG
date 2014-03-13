<!-- 文件名：query_ConsumeData.jsp -->
<!-- 描  述：账单查询页面 -->
<!-- 修改时间：2010-7-27 -->
<%@ page contentType="text/html; charset=UTF-8" language="java" buffer="32kb" %>
<%@page pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGErrorCode"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.facade.bean.info.UserSubscribe" %>
<%@ page import="com.huawei.iptvmw.facade.bean.info.MonthInfoItem" %>

<%@ page import="java.lang.Double"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ include file="SubStringFunction.jsp"%>
<script language="javascript"  type="text/javascript">
<%
	int curpage=1;
    int indexid=8;
    int areaid=0;
    int pagecount=1;
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
<%

    ServiceHelpHWCTC serviceHelp = new ServiceHelpHWCTC(request); 

	HashMap prodMap = new HashMap();
    prodMap.put("123321","卡拉OK包月");
    prodMap.put("4305","亲子早教动画");
	prodMap.put("4306","儿歌故事会");
	prodMap.put("4307","入学必备课程");
	prodMap.put("4308","中少期刊-TV版");
	prodMap.put("4309","培生朗文少儿英语启蒙班");
	prodMap.put("4310","早教律动");
	prodMap.put("4311","卡卡益智动画");
	prodMap.put("4312","小学同步辅导");
	prodMap.put("4313","培生朗文少儿英语基础班");
	prodMap.put("4314","培生朗文少儿英语进阶班");
	prodMap.put("4315","小学魅力英语");
	prodMap.put("4316","小学奥数");
	prodMap.put("4317","中考考前冲刺");
	prodMap.put("4318","初中专项突破");
	prodMap.put("4319","高考考前冲刺");
	prodMap.put("4320","高中专项突破");
	
	
    //ServiceHelpHWCTC serviceHelp = new ServiceHelpHWCTC(request);
	ServiceHelp sh = new ServiceHelp(request);
	TurnPage turnPage = new TurnPage(request);
         
	UserProfile userProfile = new UserProfile(request);
	UserSubscribe subInfo = userProfile.getSubscribeList();

	System.out.println("subInfo======"+subInfo);
	List<MonthInfoItem> subMonthList = (List<MonthInfoItem>)subInfo.getMonthInfoList();

	System.out.println("subMonthList===="+subMonthList);
	HashMap prgdListsdetail;
	ArrayList prgdLists = new ArrayList();
	String year = "";
	String month ="";
	String day = "";
	String tempTime = "";
	//用于显示的订购产品ID
	List monthProdId = new ArrayList();
    //用于显示的订购产品名称
	List monthProdName = new ArrayList();
	//用于显示的订购开始时间
	List monthProdBeginTime = new ArrayList();
	//用户取消续订的开始时间
	List monthProdCancelTime = new ArrayList();
	
	//用户订购的所有产品数
	int monthCount =  subMonthList.size();
	//用户实际订购了包月产品数
	int monthListSize = 0;
	for (int i = 0;i<monthCount;i++)
	{
		prgdListsdetail = new HashMap();
		MonthInfoItem monthInfoItem =(MonthInfoItem) subMonthList.get(i);
		String prodId = monthInfoItem.getProductId();
		String prodEndTime = monthInfoItem.getSerEndTime();
		String prodBeginTime = monthInfoItem.getSerBeginTime();
		String tempProdName = (String)prodMap.get(prodId);
	    if(tempProdName != null)
		{
		    if(!tempProdName.equals("1") && Integer.parseInt(prodEndTime.substring(0,4))>=2099)
		    {
			    year = prodBeginTime.substring(0,4);
			    month =prodBeginTime.substring(4,6);
			    day = prodBeginTime.substring(6,8);
			    tempTime = year+"/"+month+"/"+day;
			    prgdListsdetail.put("productName",tempProdName);
			    prgdListsdetail.put("productId",prodId);				
			    prgdListsdetail.put("prodBeginTime",prodBeginTime);
			    prgdListsdetail.put("prodEndTime",prodEndTime);
			    prgdLists.add(prgdListsdetail);		
			    monthListSize++;
		    }
	    }
	}

%>
     var billList = [];
	 var countTotal = <%=monthListSize%>;
	 var recordList=[];
	 var jscurpage=<%=curpage%>;
     var indexid=<%=indexid%>;

     var areaid=<%=areaid%>;

 if(parseInt(jscurpage)>parseInt(<%=pagecount%>))
  {
    jscurpage=<%=pagecount%>;
  }
<%  int counta=monthListSize;
    if(counta>0)
	{
	 pagecount=(int)Math.ceil(counta/11.0);
	}
	
				for(int j = 0;j < monthListSize; j++)
				{
%>
					var tempObj ={};
					tempObj.prodName = "<%=((HashMap)prgdLists.get(j)).get("productName")%>";
					tempObj.prodId = "<%=((HashMap)prgdLists.get(j)).get("productId")%>";
					tempObj.startTime  = "<%=((HashMap)prgdLists.get(j)).get("prodBeginTime")%>" ;
					tempObj.cancelTime  = "<%=((HashMap)prgdLists.get(j)).get("prodEndTime")%>" ;
					
					//把数据对象放入数组
					billList.push(tempObj);
<%
				}
%>
 var pos = parseInt(jscurpage) * 11 - 11;
 for (var i = pos; i < billList.length && i<(pos+11); i++)
 {
	var recordObj = {};
	recordObj.prodId =billList[i].prodId;
	recordObj.prodName = billList[i].prodName;
	recordObj.cancelTime  = billList[i].cancelTime;
    recordObj.startTime  = billList[i].startTime;
	recordList.push(recordObj);
}
if(recordList.length==0)
{
	var recordObjNull={};
    recordObjNull.prodId ="";
	recordObjNull.prodName ="暂无记录";
	recordObjNull.cancelTime  ="";
	recordObjNull.startTime  ="";
	recordList.push(recordObjNull);
}
</script>
