<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%
int len = 0;
MetaData metaData = new MetaData(request);
String currarea = request.getParameter("currarea");
String channelId = request.getParameter("channelId");
int liveStartIndex = 1;//直播节目单开始于第几个
int pageSize = 9999;
int totalRecord = 0;
int pageCount = 0;
if(currarea.equals("0"))
{
HashMap timeHash = metaData.getChannelInfo(channelId);
len = Integer.parseInt(timeHash.get("RECORDLENGTH").toString());
int timeShiftLength = (int)len / 60;
if(timeShiftLength < 1)
timeShiftLength = 1;
timeShiftLength = (int)timeShiftLength / 60 / 24;
SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
SimpleDateFormat formatterChinese = new SimpleDateFormat("yyyy年M月d日");
Date currDate = new java.util.Date();
// currDate.setMinutes(timeShiftLength);
Calendar  cal = Calendar.getInstance();
cal.add(Calendar.DAY_OF_MONTH, -timeShiftLength);
//cal.add(Calendar.DAY_OF_MONTH,1);
Date beforeDate = cal.getTime();
String time = formatter.format(beforeDate);
ArrayList channelDateList=new ArrayList();
while(beforeDate.compareTo(currDate) <= 0 )
{
	  			//timeList += formatterChinese.format(beforeDate) + ",";
HashMap mydate=new HashMap();
mydate.put("date24",formatter.format(beforeDate));
mydate.put("dateChinese",formatterChinese.format(beforeDate));
channelDateList.add(mydate);
cal.add(Calendar.DAY_OF_MONTH,1);
beforeDate = cal.getTime();	
}
JSONArray jsonDateList = JSONArray.fromObject(channelDateList);
response.getWriter().print(jsonDateList); 
}
	 
if(currarea.equals("1"))
{
int currCount = 1;
int pageIndex = Integer.parseInt(request.getParameter("pageIndex"));
String currDate = request.getParameter("currdate");
int startRecord = (pageIndex - 1) * pageSize;
//ArrayList programList = (ArrayList) metaData.getRecBill(Integer.parseInt(channelId),currDate,0);
//metaData.getRecBill(Integer.parseInt(channelId));
// metaData.getChanBill(Integer.parseInt(channelId));
//metaData.getRecBill(Integer.parseInt(channelId),currDate);


String[] prgrmLists = metaData.getRecBill(Integer.parseInt(channelId),currDate,0);
HashMap prgrmListsdetail;
ArrayList prgrmdetailList = new ArrayList();
ArrayList programList = new ArrayList();
for( int i =0; i<prgrmLists.length;i++)
{
	prgrmListsdetail = new HashMap();
	String[] temp = prgrmLists[i].split("\u007f"); //每个节目的具体信息
	String tmpStartDate = temp[0]; 
	String newFomatStartDate = (tmpStartDate.split("-"))[0]+(tmpStartDate.split("-"))[1]+(tmpStartDate.split("-"))[2];
    	String startTime = temp[1];
	String tmpprogramName = temp[2];
	String endTime = temp[3];
	String tmpprogramId = temp[4];
	String isSubcript = temp[5];
	String serchCode = temp[6];
	String extendPosition = temp[7];
	String statusFlag = temp[8];
	if(i<1&&"00".equals(startTime.split(":")[0]))
	{
		String tmpStartTime = currDate+(startTime.split(":"))[0]+(startTime.split(":"))[1]+(startTime.split(":"))[2];
		String tmpprogramendTime = currDate+(endTime.split(":"))[0]+(endTime.split(":"))[1]+(endTime.split(":"))[2];
		prgrmListsdetail.put("PROGNAME",tmpprogramName);
		prgrmListsdetail.put("LiveSTATUS",0);
		
		prgrmListsdetail.put("PROGRAMID",Integer.valueOf(tmpprogramId));
		prgrmListsdetail.put("STARTTIME",tmpStartTime);
		prgrmListsdetail.put("ENDTIME",tmpprogramendTime);
		prgrmListsdetail.put("STATUS",Integer.valueOf(statusFlag));
		prgrmListsdetail.put("ISCONTROLLED",Integer.valueOf("0"));
		prgrmListsdetail.put("ISSERVICED",Integer.valueOf(isSubcript));
		System.out.println("tvodwangss"+tmpStartTime);
		prgrmdetailList.add(prgrmListsdetail);
	}
	else if(i<prgrmLists.length-1)
	{
		 String tmpStartTime = newFomatStartDate+(startTime.split(":"))[0]+(startTime.split(":"))[1]+(startTime.split(":"))[2];
		  String tmpprogramendTime = currDate+(endTime.split(":"))[0]+(endTime.split(":"))[1]+(endTime.split(":"))[2];
		  prgrmListsdetail.put("PROGNAME",tmpprogramName);
		   prgrmListsdetail.put("LiveSTATUS",0);
		  prgrmListsdetail.put("PROGRAMID",Integer.valueOf(tmpprogramId));
		  prgrmListsdetail.put("STARTTIME",tmpStartTime);
		  prgrmListsdetail.put("ENDTIME",tmpprogramendTime);
		  prgrmListsdetail.put("STATUS",Integer.valueOf(statusFlag));
		  prgrmListsdetail.put("ISCONTROLLED",Integer.valueOf("0"));
		  prgrmListsdetail.put("ISSERVICED",Integer.valueOf(isSubcript));
		  prgrmdetailList.add(prgrmListsdetail);
		  	System.out.println("tvodwangss"+tmpStartTime);
	}
	else
	{
		if(i==prgrmLists.length-1&&("00".equals(startTime.split(":")[0]))==false)
		{
		  String tmpStartTime = newFomatStartDate+(startTime.split(":"))[0]+(startTime.split(":"))[1]+(startTime.split(":"))[2];
		  String tmpprogramendTime = currDate+(endTime.split(":"))[0]+(endTime.split(":"))[1]+(endTime.split(":"))[2];
		  prgrmListsdetail.put("PROGNAME",tmpprogramName);
		  prgrmListsdetail.put("LiveSTATUS",0);
		  prgrmListsdetail.put("PROGRAMID",Integer.valueOf(tmpprogramId));
		  prgrmListsdetail.put("STARTTIME",tmpStartTime);
		  prgrmListsdetail.put("ENDTIME",tmpprogramendTime);
		  prgrmListsdetail.put("STATUS",Integer.valueOf(statusFlag));
		  prgrmListsdetail.put("ISCONTROLLED",Integer.valueOf("0"));
		  prgrmListsdetail.put("ISSERVICED",Integer.valueOf(isSubcript));
		  prgrmdetailList.add(prgrmListsdetail);
		}
		else
		{
			continue;
		}
	}
 }
 System.out.println("wassdf"+currDate);
 java.text.SimpleDateFormat progformatter = new java.text.SimpleDateFormat("yyyyMMdd");
 Date currproDate = new java.util.Date();
 String str_CurrDateTime = progformatter.format(currproDate);
 if(str_CurrDateTime.equals(currDate))
 {
       String[] recProgBill=metaData.getProgBill(Integer.parseInt(channelId),str_CurrDateTime);

        int recProgcount=0;
        if(recProgBill!=null)
		{
			 recProgcount=recProgBill.length;
			 for(int i=0;i<recProgBill.length;i++)
			 {
				 String temps=recProgBill[i].substring(10,11);
				 
				 
				 String[] temppros=recProgBill[i].split(temps);
				 HashMap tempprogmap = new HashMap();
				 String tempSTARTTIME=temppros[0].replaceAll("-","")+temppros[1].replaceAll(":","");
				 String tempENDTIME=temppros[0].replaceAll("-","")+temppros[3].replaceAll(":","");
				 tempprogmap.put("STARTTIME",tempSTARTTIME);
				 tempprogmap.put("PROGNAME",temppros[2]);
				 tempprogmap.put("ENDTIME",tempENDTIME);
				 tempprogmap.put("PROGRAMID",temppros[4]);
				 tempprogmap.put("ISSERVICED",temppros[5]);
				 tempprogmap.put("STATUS",1);
				 tempprogmap.put("ISCONTROLLED",Integer.valueOf("0"));
				 if(i==0){
				    tempprogmap.put("LiveSTATUS",2);
					liveStartIndex = prgrmdetailList.size()+1;
				 }else{
				    tempprogmap.put("LiveSTATUS",1);
				 }
				 //System.out.println("tvodwangss1"+temppros[0]);
				 prgrmdetailList.add(tempprogmap);
			 }
		}
 }
HashMap total = new HashMap();
total.put("COUNTTOTAL",prgrmLists.length);
programList.add(total);
programList.add(prgrmdetailList);
if(programList != null && programList.size() == 2)
{
		HashMap totalHash  = (HashMap) programList.get(0);
		ArrayList detailList = (ArrayList) programList.get(1);
		ArrayList filterList = new ArrayList();
		String tmpDate = currDate + "000000";
		String maxDate = currDate + "235959";
		for(int i = 0 ; i < detailList.size() ; i ++)
		{
			int status =  (Integer)((HashMap)detailList.get(i)).get("STATUS");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String startTime = (String)((HashMap)detailList.get(i)).get("STARTTIME");
			Date startTimeFormat = sdf.parse(startTime);
			Date currDateFormat = sdf.parse(tmpDate);
			Date maxDateFormat = sdf.parse(maxDate);
			//int resultCompare = startTimeFormat.compareTo(currDateFormat);
			if( startTimeFormat.compareTo(currDateFormat) >= 0 && startTimeFormat.compareTo(maxDateFormat) <= 0)
			{
				if(status == 1 )
					filterList.add(detailList.get(i));
			}
		}
				
		totalRecord = filterList.size();
		if(totalRecord % pageSize == 0)
			pageCount = totalRecord  / pageSize;
		else
			pageCount = (totalRecord  / pageSize) + 1;
		ArrayList resultList = new ArrayList();
		for(int  i = startRecord  ; i < filterList.size() ; i ++)
		{
			if(currCount  == (pageSize + 1) )
   				break;
		    resultList.add(filterList.get(i));
		    ++ currCount;
		}
		JSONArray jsondetailList = JSONArray.fromObject(resultList);
		JSONObject result = new JSONObject();
		result.put("data",jsondetailList);
		result.put("count",pageCount);
		result.put("livestart",liveStartIndex);
		//System.out.println("tvodwangss"+result);
		response.getWriter().print(result);
}
	
}
%>
