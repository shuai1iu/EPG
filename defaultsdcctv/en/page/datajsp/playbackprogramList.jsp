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
	String channelId = request.getParameter("channelId");
	int pageSize = 9;
	int totalRecord = 0;
	int pageCount = 0;
	int currCount = 1;
	int pageIndex = Integer.parseInt(request.getParameter("pageIndex"));
	int startRecord = (pageIndex - 1) * pageSize;
	String currDate = request.getParameter("currdate");
	
//ArrayList programList = (ArrayList) metaData.getChannelRecBill(Integer.parseInt(channelId),-1,-1,-1,currDate);
//////////////////////////////////////////////////////

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
		String tmpprogramendTime = currDate+(endTime.split(":"))[0]+(endTime.split(":"))[1]+(endTime.split(":"))[2];
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
			String tmpprogramendTime = currDate+(endTime.split(":"))[0]+(endTime.split(":"))[1]+(endTime.split(":"))[2];
			prgrmListsdetail.put("PROGNAME",tmpprogramName);
			prgrmListsdetail.put("PROGRAMID",Integer.valueOf(tmpprogramId));
			prgrmListsdetail.put("STARTTIME",tmpStartTime);
			prgrmListsdetail.put("ENDTIME",tmpprogramendTime);
			prgrmListsdetail.put("STATUS",Integer.valueOf(statusFlag));
			prgrmListsdetail.put("ISCONTROLLED",Integer.valueOf("0"));
			prgrmListsdetail.put("ISSERVICED",Integer.valueOf(isSubcript));
			prgrmdetailList.add(prgrmListsdetail);
		}
		/*
		else
		{
			prgrmdetailList.add(prgrmListsdetail);
		}
		else
		{
			continue;
		}
		*/
	}

}
HashMap total = new HashMap();
total.put("COUNTTOTAL",prgrmLists.length);
programList.add(total);
programList.add(prgrmdetailList);
//////////////////////////////////////////////////////	
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
		response.getWriter().print(result);
		
	}

%>
 	
