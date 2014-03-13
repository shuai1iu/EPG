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
	//String month1 = StringDateUtil.getTodaytimeString("yyyymm");
//	String month3 = StringDateUtil.adjustMonth(month1, -2);
//	Map retMap = (HashMap)serviceHelp.queryOrderHWCTC(month3,month1);
//	HashMap prodMap = new HashMap();
//	int ret_code = ((Integer) retMap.get("RETCODE")).intValue();
//	if (retMap!=null && ret_code == EPGErrorCode.SEARCHBILL_SUCCESSED)
//	{
//		String[] prodCode = (String[])retMap.get("PROD_CODE");
//		String[] prodName = (String[])retMap.get("PROD_DES");
//		String allProdsId = "";
//		String allProdName ="";
//		for(int i = 0;i<prodCode.length;i++)
//		{
//			allProdsId = prodCode[i];
//			allProdName = prodName[i];
//			prodMap.put(allProdsId,allProdName);
//		}
//	}
	HashMap prodMap = new HashMap();
    prodMap.put("123321","卡拉OK包月");
    prodMap.put("4305","深圳IPTV亲子早教动画");
	prodMap.put("4306","深圳IPTV儿歌故事会");
	prodMap.put("4307","深圳IPTV入学必备课程");
	prodMap.put("4308","深圳IPTV中少期刊-TV版");
	prodMap.put("4309","深圳IPTV培生朗文少儿英语启蒙班");
	prodMap.put("4310","深圳IPTV早教律动");
	prodMap.put("4311","深圳IPTV卡卡益智动画");
	prodMap.put("4312","深圳IPTV小学同步辅导");
	prodMap.put("4313","深圳IPTV培生朗文少儿英语基础班");
	prodMap.put("4314","深圳IPTV培生朗文少儿英语进阶班");
	prodMap.put("4315","深圳IPTV小学魅力英语");
	prodMap.put("4316","深圳IPTV小学奥数");
	prodMap.put("4317","深圳IPTV中考考前冲刺");
	prodMap.put("4318","深圳IPTV初中专项突破");
	prodMap.put("4319","深圳IPTV高考考前冲刺");
	prodMap.put("4320","深圳IPTV高中专项突破");
    //ServiceHelpHWCTC serviceHelp = new ServiceHelpHWCTC(request);
	ServiceHelp sh = new ServiceHelp(request);
	TurnPage turnPage = new TurnPage(request);
         
	UserProfile userProfile = new UserProfile(request);
	UserSubscribe subInfo = userProfile.getSubscribeList();
	List<MonthInfoItem> subMonthList = (List<MonthInfoItem>)subInfo.getMonthInfoList();
	HashMap prgdListsdetail;
	ArrayList prgdLists = new ArrayList();
	String year = "";
	String month ="";
	String day = "";
	String tempTime = "";
	
	List monthProdId = new ArrayList();
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
		//String tempProdName ="11111111111111111111";
		if(tempProdName != null)
		{
		//	tempProdName = "1";
	//	}
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
	//ServiceHelpHWCTC serviceHelp = new ServiceHelpHWCTC(request); 
//	UserProfile userProfile = new UserProfile(request);
//	UserSubscribe subInfo = userProfile.getSubscribeList();
//	List<MonthInfoItem> subMonthList = (List<MonthInfoItem>)subInfo.getMonthInfoList();
//	String month1 = StringDateUtil.getTodaytimeString("yyyymm");
//	String month3 = StringDateUtil.adjustMonth(month1, -2);
//	Map retMap = (HashMap)serviceHelp.queryOrderHWCTC(month3,month1);
//	String[] prodCode = new String[1];
//    String[] prodName = new String[1];
//    String[] price = new String[1];
//	String[] price_cut = new String[1];
//    String[] ordertime = new String[1];
//	String[] prodName_cut = new String[1];	
//	String[] isOrder = new String[1];
//	int[] orderType = new int[1];
//	String[] startTime = new String[1];
//    int countTotal= 0;
//    int ret_code = ((Integer) retMap.get("RETCODE")).intValue();
//	if(ret_code != EPGErrorCode.SEARCHBILL_SUCCESSED && ret_code != 0x07060001)
//	{
//		
		//String pageName = "InfoDisplay.jsp?ERROR_TYPE=2&ERROR_ID=171";        
%>
     var billList = [];
	 var countTotal = <%=monthListSize%>;
	 var recordList=[];
	 var jscurpage=<%=curpage%>;
     var indexid=<%=indexid%>;
     var areaid=<%=areaid%>;
<%
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
