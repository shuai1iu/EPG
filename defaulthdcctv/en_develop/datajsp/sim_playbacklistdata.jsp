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
int pageSize = 11;
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
	Calendar  cal = Calendar.getInstance();
	cal.add(Calendar.DAY_OF_MONTH,1);
	Date beforeDate = cal.getTime();
	String str_currDate = formatter.format(currDate);
	String time = formatter.format(beforeDate);
	System.out.println("==========Time================="+beforeDate);



	ArrayList channelDateList=new ArrayList();
	int i = 0;
	while(currDate.compareTo(beforeDate) <= 0 )
	{
		HashMap mydate=new HashMap();
		mydate.put("date24",formatter.format(beforeDate));
		mydate.put("dateChinese",formatterChinese.format(beforeDate));
		channelDateList.add(mydate);
		cal.add(Calendar.DAY_OF_MONTH,1);
		beforeDate = cal.getTime();	
		i++;

		if(i > 6)
			break;



	}


	JSONArray jsonDateList = JSONArray.fromObject(channelDateList);
	System.out.println("==========isonDateList================="+jsonDateList);
	response.getWriter().print(jsonDateList); 

}

if(currarea.equals("1"))
{
	int currCount = 1;
	int pageIndex = Integer.parseInt(request.getParameter("pageIndex"));

	   String get_beforeDate = request.getParameter("beforedate");

	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	Date tempDate1 = formatter.parse(get_beforeDate);
	System.out.println("==========tempDate================="+tempDate1);
//对tempDate1减9天然后转回数字存为get_currDate
	 Calendar rightNow = Calendar.getInstance();
	rightNow.setTime(tempDate1);
	rightNow.add(Calendar.DAY_OF_YEAR,-6);
	Date tempDate2 = rightNow.getTime();
	String get_currDate = formatter.format(tempDate2);
	System.out.println("!!!!!!!!!!!!!!!!get_currDate!!!!!!!!!!!!!!"+get_currDate);
	System.out.println("==========get_beforeDate================="+get_beforeDate);

	int startRecord = (pageIndex - 1) * pageSize;
	System.out.println("==========startRecord================="+startRecord);

	String[] prgrmLists = metaData.getProgBill(Integer.parseInt(channelId),get_beforeDate);
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
		System.out.println("==========List================="+temp[2]);
	String endTime = temp[3];
	String tmpprogramId = temp[4];
	String isSubcript = temp[5];
	String serchCode = temp[6];
	String extendPosition = temp[7];
	String statusFlag = temp[8];
	if(i<1&&"00".equals(startTime.split(":")[0]))
	{
		String tmpStartTime = get_currDate+(startTime.split(":"))[0]+(startTime.split(":"))[1]+(startTime.split(":"))[2];
		String tmpprogramendTime = get_currDate+(endTime.split(":"))[0]+(endTime.split(":"))[1]+(endTime.split(":"))[2];
		
		prgrmListsdetail.put("PROGNAME",tmpprogramName);
		prgrmListsdetail.put("PROGRAMID",Integer.valueOf(tmpprogramId));
		prgrmListsdetail.put("STARTTIME",tmpStartTime);
		prgrmListsdetail.put("ENDTIME",tmpprogramendTime);
		prgrmListsdetail.put("STATUS",Integer.valueOf(statusFlag));
		prgrmListsdetail.put("ISCONTROLLED",Integer.valueOf("0"));
		prgrmListsdetail.put("ISSERVICED",Integer.valueOf(isSubcript));
		prgrmdetailList.add(prgrmListsdetail);
	}
	else if(i<prgrmLists.length-1)
	{
		 String tmpStartTime = newFomatStartDate+(startTime.split(":"))[0]+(startTime.split(":"))[1]+(startTime.split(":"))[2];
		  String tmpprogramendTime = get_currDate+(endTime.split(":"))[0]+(endTime.split(":"))[1]+(endTime.split(":"))[2];
		  prgrmListsdetail.put("PROGNAME",tmpprogramName);
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
		if(i==prgrmLists.length-1&&("00".equals(startTime.split(":")[0]))==false)
		{
		  String tmpStartTime = newFomatStartDate+(startTime.split(":"))[0]+(startTime.split(":"))[1]+(startTime.split(":"))[2];
		  String tmpprogramendTime = get_currDate+(endTime.split(":"))[0]+(endTime.split(":"))[1]+(endTime.split(":"))[2];
		  prgrmListsdetail.put("PROGNAME",tmpprogramName);
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
	 System.out.println("==========ListDetail================="+prgrmListsdetail);
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
		String tmpDate = get_currDate + "000000";
		  System.out.println("!!!!!!!!!!!!!!tmpDate!!!!!!!!!!!!"+tmpDate);
		String maxDate = get_beforeDate + "235959";
		  System.out.println("==========maxDate================="+maxDate);
		for(int i = 0 ; i < detailList.size() ; i ++)

		{
			  System.out.println("==========DetailList================="+detailList.size());
			int status =  (Integer)((HashMap)detailList.get(i)).get("STATUS");
			System.out.println("==========Status================="+status);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String startTime = (String)((HashMap)detailList.get(i)).get("STARTTIME");
			 System.out.println("==========StartTime================="+startTime);
			Date startTimeFormat = sdf.parse(startTime);
			Date currDateFormat = sdf.parse(tmpDate);
			Date maxDateFormat = sdf.parse(maxDate);
			//int resultCompare = startTimeFormat.compareTo(currDateFormat);
			 System.out.println("==========StartTimeFormat================="+startTimeFormat);
			 System.out.println("==========CurrDateFotmat================="+currDateFormat);
			 System.out.println("==========MaxDateFotmat================="+maxDateFormat); 	
			if( startTimeFormat.compareTo(currDateFormat) >= 0 && startTimeFormat.compareTo(maxDateFormat) <= 0)
			{
				if(status == 0 ) //节目单与录播单不同
					filterList.add(detailList.get(i));
			System.out.println("==========FilterList================="+filterList.get(i));
			}
			 System.out.println("==========IIIII================="+i);
		}
				
		totalRecord = filterList.size();
		System.out.println("==========filterList================="+filterList.size());
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
		      System.out.println("==========IIIIListDetail================="+i);
		    ++ currCount;
		}
		  System.out.println("==========Listresult================="+resultList);
		JSONArray jsondetailList = JSONArray.fromObject(resultList);
		  System.out.println("==========jsonDetailList================="+jsondetailList);
		JSONObject result = new JSONObject();
		result.put("data",jsondetailList);
		  System.out.println("==========Result================="+result);
		result.put("count",pageCount);
		response.getWriter().print(result);
}
	
}
%>
