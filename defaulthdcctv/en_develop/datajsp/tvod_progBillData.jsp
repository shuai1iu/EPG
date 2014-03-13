<%-- Copyright (C), Huawei Tech. Co., Ltd. --%>
<!-- Author:zhangli -->
<%-- CreateAt:2010-08-03--%>
<%-- FileName:chan_progBillData.jsp --%>

<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ include file="SubStringFunction.jsp" %>

<script type="text/javascript">
    var chanProgListObject = {};
    var chanList = [];
	
</script>

<%!
	

    private static final int CHANNEL_PER_PAGE = 8;

    private void sortChanList(List recChanList)
	{
        Collections.sort(recChanList, new Comparator()
		{
            public int compare(Object o1, Object o2) 
			{
                return ((Integer) ((Map) o1).get("CHANNELINDEX")).intValue() - ((Integer) ((Map) o2).get("CHANNELINDEX")).intValue();
            }
        }
		);
    }
	
	
	private static String addDate(String day, int x) 
    { 
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//24小时制 
        //SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");//12小时制 
        Date date = null; 
        try 
        { 
            date = format.parse(day); 
        } 
        catch (Exception ex)    
        { 
            ex.printStackTrace(); 
        } 
        if (date == null) return ""; 
        Calendar cal = Calendar.getInstance(); 
        cal.setTime(date); 
        cal.add(Calendar.HOUR_OF_DAY, x);//24小时制 
        //cal.add(Calendar.HOUR, x);12小时制 
        date = cal.getTime(); 

        cal = null; 
        return format.format(date); 
    } 
	
	public static String getCustomDate(int delay) {
		return org.apache.commons.lang.time.DateFormatUtils.format(
				org.apache.commons.lang.time.DateUtils.addDays(new Date(),
						delay), "yyyyMMdd");
	}
%>

<%

    
	TurnPage turnPage = new TurnPage(request);
    JSONObject chanProgObj = new JSONObject();
    JSONArray jsonChannelList = new JSONArray();
	
	
 	if (turnPage.getLast().indexOf("tvod_progBillByTimePeriod.jsp") != -1 || turnPage.getLast().indexOf("tvod_progBillByTimePick.jsp") != -1 || turnPage.getLast().indexOf("tvod_progBillByRepertoire.jsp") != -1)  
	{	
        turnPage.removeLast();
    }
    turnPage.addUrl();
	
	
	
	
	
	

    int pageIndex = 0;
    if (request.getParameter("pageIndex") != null && !"".equals(request.getParameter("pageIndex"))) 
	{
        pageIndex = Integer.parseInt(request.getParameter("pageIndex"));
    }
	
    Date today = new Date();
    DateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
	
	SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    Calendar cal = Calendar.getInstance();
    cal.setTime(today);

    //默认日期索引
    int dateIndex = cal.get(Calendar.DAY_OF_YEAR);
	int tempDataIndex =0;
	tempDataIndex =dateIndex;
	int tmpDateIndex =dateIndex;

    if (request.getParameter("dateIndex") != null && !"".equals(request.getParameter("dateIndex")))
	{
        dateIndex = Integer.parseInt(request.getParameter("dateIndex"));
    }
	
	
	
	//
	String preFocus = "";
	if (request.getParameter("preFocus") != null && !"".equals(request.getParameter("preFocus")))
	{
        preFocus = (String)request.getParameter("preFocus");
    }
	
	
	
	int tmpChanId = -999;
	if (request.getParameter("chanId") != null && !"".equals(request.getParameter("chanId")))
	{
        tmpChanId =  Integer.parseInt(request.getParameter("chanId"));
    }
	

	String line = "-1";
	if (request.getParameter("ROW") != null && !"".equals(request.getParameter("ROW")))
	{
        line = (String)request.getParameter("ROW");
    }
	
	
	String status = "";
	if (request.getParameter("STATUS") != null && !"".equals(request.getParameter("STATUS")))
	{
        status = (String)request.getParameter("STATUS");
    }
	
	

	
	
    //当前小时时段间隔
    cal.set(Calendar.MINUTE, 0);
    cal.set(Calendar.SECOND, 0);
    String beginPeriod = format.format(cal.getTime());

	String beginPeriod2 = format2.format(cal.getTime());
	
	String endPeriod2 = addDate(beginPeriod2,1);
	
    if (request.getParameter("beginPeriod") != null && !"".equals(request.getParameter("beginPeriod")))
	{
        beginPeriod = request.getParameter("beginPeriod");
		
    }
	
    //默认日期后一天索引
    int tomorrowIndex = cal.get(Calendar.DAY_OF_YEAR) + 1;
	int row = -1;
    //焦点记忆
    String focusElmId = "";
    String[] focusMemory = turnPage.getPreFoucs();
    if (focusMemory != null) 
	{
        pageIndex = Integer.parseInt(focusMemory[0]);
        beginPeriod = focusMemory[1];
        focusElmId = focusMemory[2];
		
		if(focusMemory.length >=4)
		{
			row = Integer.parseInt(focusMemory[3]);
		}
    }
	
	

	if (request.getParameter("NUM") != null && !"".equals(request.getParameter("NUM")))
	{	
		int chanNumIndex = 0;
        chanNumIndex =  Integer.parseInt(request.getParameter("NUM"));
		focusElmId = ""+chanNumIndex;
		row = chanNumIndex;
    }
	
	
    MetaData metaData = new MetaData(request);
    List resultChanList = new ArrayList();
	
	int length = CHANNEL_PER_PAGE;
    int station = pageIndex * CHANNEL_PER_PAGE;
    try {
        resultChanList = metaData.getRecChan(length, station);
    } catch (Exception e) {
    }
    int allChannelCount = ((Integer) ((HashMap) resultChanList.get(0)).get("COUNTTOTAL")).intValue();
	
	if(allChannelCount <= 0)
	{	turnPage.removeLast();
		
		%>
			<jsp:forward page="InfoDisplay.jsp?ERROR_ID=108&ERROR_TYPE=2" />
		
		<%
	}
	
	
    List recChanList = (List) resultChanList.get(1);

    int channelCount = recChanList.size();
    sortChanList(recChanList);

    int pageNumber = (allChannelCount % CHANNEL_PER_PAGE == 0) ?
            allChannelCount / CHANNEL_PER_PAGE : (allChannelCount / CHANNEL_PER_PAGE + 1);

%>
<script type="text/javascript">
    var page_index = <%=pageIndex%>;
    var channelCount = <%=channelCount%>;
    var channel_per_page = <%=CHANNEL_PER_PAGE%>;
    var page_number = <%=pageNumber%>;
    var begin_period = "<%=beginPeriod%>";
    var date_index = "<%=dateIndex%>";

    var marqueeArr = [];
</script>
<%

    for (int chanIndex = 0; chanIndex < channelCount; chanIndex++)
	{
        Map recChan = (Map) recChanList.get(chanIndex);
        JSONObject jsonType = new JSONObject();
        int channelId = ((Integer) recChan.get("CHANNELID")).intValue();
		
		String tmpChanID = ""+channelId;
		Map channelInfo = metaData.getChannelInfo(tmpChanID);
  	    Map chanInfoHwtct = metaData.getChannelInfoHWCTC(tmpChanID);
		
		String tempChannelName = (String)recChan.get("CHANNELNAME");
		String channelName = subStringFunction(tempChannelName,1,90);
		jsonType.put("channelId",channelId); 
		jsonType.put("channelIndex",channelInfo.get("CHANNELINDEX")); 
		jsonType.put("channelName",channelName); 
		jsonType.put("preview",channelInfo.get("PreviewEnable")); 
		jsonType.put("liveStatus",channelInfo.get("LIVESTATUS")); 
		jsonType.put("subscribe",channelInfo.get("isSubscribe"));
		jsonType.put("channelType",channelInfo.get("CHANNELTYPE")); 
		jsonType.put("isNvod",channelInfo.get("IsNvod"));
		jsonChannelList.add(jsonType);
   // String[] progBill = new String[0];
    String[] recBill = new String[0];


    try {
		
       // progBill = metaData.getProgBill(channelId);
        //此处用getRecBill这种重载形式，对过了当前时间，却没有录制完的节目，也会显示出来，但要注意信息提示
        recBill = metaData.getRecBill(channelId, 1);
       // if (progBill == null) progBill = new String[0];
        if (recBill == null) recBill = new String[0];
    } catch (Exception e) {
    }

    String[] progBillArr = new String[recBill.length];

  //  System.arraycopy(progBill, 0, progBillArr, 0, progBill.length);
    System.arraycopy(recBill, 0, progBillArr, 0, recBill.length);

    Arrays.sort(progBillArr, new Comparator() {
        public int compare(Object o1, Object o2) {
            String prog1 = (String) o1;
            String prog2 = (String) o2;
            String[] progArr1 = prog1.split("\u007f");
            String[] progArr2 = prog2.split("\u007f");
            return progArr2[0].compareTo(progArr1[0]) != 0 ? progArr2[0].compareTo(progArr1[0]) :
                    progArr2[1].compareTo(progArr1[1]);
        }
    });
	JSONArray jsonProgList = new JSONArray();

    for (int i = 0; i < progBillArr.length; i++) {
   
		
        String[] progInfoArr = progBillArr[i].split("\u007f");
			if("2".equals(progInfoArr[8]))continue;
        String[] date = progInfoArr[0].split("-");
        Calendar day = Calendar.getInstance();
        day.set(Integer.parseInt(date[0]), Integer.parseInt(date[1]) - 1, Integer.parseInt(date[2]));
        int index = day.get(Calendar.DAY_OF_YEAR);
		
        //从当前日期起，但当前日期最多到真实时间的第二天
      // if (index <= tomorrowIndex &&
        //      (index == dateIndex || (index == dateIndex - 1 && progInfoArr[3].startsWith("0")))) {
            String[] dateArr = progInfoArr[0].split("-");
            String[] timeBeginArr = progInfoArr[1].split(":");
            String[] timeEndArr = progInfoArr[3].split(":");

            boolean beyond = false;
            String[] endDayArr = new String[0];
            int interval = 0;

           //节目单时长计算
            try {
                DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				
				
				//String tempBeginTime = progInfoArr[1].substring(0,5)+":00";
				
				 Date beginTime = dateFormat.parse(progInfoArr[0] + " " + progInfoArr[1]);
				
				
              //  Date beginTime = dateFormat.parse(progInfoArr[0] + " " + tempBeginTime);
				
				
				//String tempEndTime = progInfoArr[3].substring(0,5)+":00";
               // Date endTime = dateFormat.parse(progInfoArr[0] + " " +tempEndTime);
				
				Date endTime = dateFormat.parse(progInfoArr[0] + " " + progInfoArr[3]);
				
				
				
                
				//如果节目时长小于1分钟，则置为1分钟
				interval = (int) ((endTime.getTime() - beginTime.getTime()) / 1000 /60);
				
				if(interval <=1)
				{
					interval =1;
				}
				

                //节目单跨天
                if (!"0".equals(progInfoArr[1].substring(0, 1)) && "0".equals(progInfoArr[3].substring(0, 1))) {

                    beyond = true;
					
					//String tempBeginTime2 = progInfoArr[1].substring(0,5)+":00";
					Date beginDay = dateFormat.parse(progInfoArr[0] + " " + progInfoArr[1]);
                   
					
                    Calendar beginCal = Calendar.getInstance();
					
                    beginCal.setTime(beginDay);
					
                    beginCal.add(Calendar.DAY_OF_YEAR, 1);
					
                    Date endDay = beginCal.getTime();
                    
					String endDayStr = dateFormat.format(endDay);

					
                    endDayArr = endDayStr.substring(0, endDayStr.indexOf(" ")).split("-");

					endDay = dateFormat.parse(endDayStr.substring(0, endDayStr.indexOf(" ")) + " " + progInfoArr[3]);
					
                    interval = (int) ((endDay.getTime() - beginDay.getTime()) / 1000/60);
					
					//如果节目时长小于1分钟，则置为1分钟
					if(interval <=1)
					{
						interval =1;
					}
					
					
                }
            } catch (ParseException e) {
            }
			
			
			
			
			
			if(tmpChanId == channelId )
			{	
				Date t1 = null;
				t1 = format2.parse(beginPeriod2);//时间段开始时间
				
				Date t2 = null;
				t2 = format2.parse(endPeriod2);//时间段结束时间
			
				String temp1 = progInfoArr[0]+ " "+progInfoArr[1].substring(0, progInfoArr[1].lastIndexOf(":")+3);
				Date begin1 = null;
				begin1 = format2.parse(temp1);//节目开始时间
				
				Date end1 = null;
				String temp2 = progInfoArr[0]+ " "+progInfoArr[3].substring(0, progInfoArr[3].lastIndexOf(":")+3);
				end1 = format2.parse(temp2);//节目结束时间
				
				
				if ((begin1.getTime() < t1.getTime() && end1.getTime() > t2.getTime()) || (begin1.getTime() >= t1.getTime() && begin1.getTime() < t2.getTime()))
				{
					focusElmId = "prog"+progInfoArr[4];
					//break;
				}
				
			}	
			
			
		String prgdate = progInfoArr[0];
		String beginTime = progInfoArr[1].substring(0, progInfoArr[1].lastIndexOf(":"));
		String endTime = progInfoArr[3].substring(0, progInfoArr[3].lastIndexOf(":"));
		//节目单的开始时间11：30
		String tmpProBeginTime1 =progInfoArr[0].replaceAll("-","")+beginTime.replace(":","");
		String tmpProEndTime1 ="0";
	System.out.println("endTime: "+endTime+" ; beginTime: "+beginTime);
		if(Integer.parseInt(endTime.replace(":","")) < Integer.parseInt(beginTime.replace(":",""))) //如果节目单的结束时间小于开始时间那么这个节目单是跨天的时期加1
		{
			tmpProEndTime1 = getCustomDate(dateIndex-tmpDateIndex)+endTime.replace(":","");	
		}
		else
		{
		    tmpProEndTime1 = progInfoArr[0].replaceAll("-","")+endTime.replace(":","");
		}
	
		//节目单的完整开始时间201012021123
		long proBeginTime =Long.parseLong(tmpProBeginTime1);
		//节目单的完整结束时间201012030002
		long proEndTime =Long.parseLong(tmpProEndTime1);
	
		
		//当前开始时间段201012021100
		long currBegTime =Long.parseLong(beginPeriod.substring(0,12));
		String tmpPeriod =beginPeriod.substring(0,4)+"-"+beginPeriod.substring(4,6)+"-"+beginPeriod.substring(6,8)+" "+beginPeriod.substring(8,10)+":"+
		beginPeriod.substring(10,12)+":"+beginPeriod.substring(12,14);
		//System.out.println(tmpPeriod+"=========================="+tmpPeriod);
		String tmpCurrEndTime =addDate(tmpPeriod,1).replaceAll("-","").replaceAll(":","").replaceAll(" ","");
		//当前结束时间段201012021100
		long currEndTime =Long.parseLong(tmpCurrEndTime);
		
		//System.out.println(proBeginTime+":::::2222222222::::::::"+proEndTime);
		//假设节目单不在当前时间段之内，则就不进行数组封装
		if(!(proBeginTime >= currEndTime ||  proEndTime <= currBegTime))
		{
			/*
			if(channelId == 1)
			{
			   
				System.out.println("proBeginTime============"+proBeginTime+"proEndTime=============="+proEndTime+"currBegTime==============="+currBegTime+"currEndTime============"+currEndTime);	
			}
			*/
			String progName = progInfoArr[2];
			String progId = progInfoArr[4];
			String canSubscribe = progInfoArr[5];
			String beginTimeFormat = dateArr[0] + dateArr[1] + dateArr[2] + timeBeginArr[0] + timeBeginArr[1] + timeBeginArr[2];
			String endTimeFormat = (!beyond) ? dateArr[0] + dateArr[1] + dateArr[2] + timeEndArr[0] + timeEndArr[1] + timeEndArr[2] :
		endDayArr[0] + endDayArr[1] + endDayArr[2] + timeEndArr[0] + timeEndArr[1] + timeEndArr[2];
			String progStatus = progInfoArr[8];
			
			JSONObject jsonProg = new JSONObject();
			jsonProg.put("dateIndex",index);
			jsonProg.put("date",prgdate);
			jsonProg.put("beginTime",beginTime);
			jsonProg.put("endTime",endTime);
			jsonProg.put("progId",progId);
			jsonProg.put("progName",progName);
			jsonProg.put("canSubscribe",canSubscribe);
			jsonProg.put("beginTimeFormat",beginTimeFormat);
			jsonProg.put("endTimeFormat",endTimeFormat);
			jsonProg.put("progStatus",progStatus);
			jsonProg.put("interval",interval);
			jsonProgList.add(jsonProg);
		}
			
    }
    //System.out.println("----------jsonProgList:"+jsonProgList.size()+"============channelId=============="+channelId);
	chanProgObj.put("N"+tmpChanID,jsonProgList);
	
	//System.out.println("----------jsonChannelList:"+jsonChannelList);
	//System.out.println("----------chanProgList:"+chanProgList);
	
    }

	String chanListStr = jsonChannelList.toString();
	chanListStr = chanListStr.replace("\"","\'");
	String chanProgStr = chanProgObj.toString();
	chanProgStr = chanProgStr.replace("\"","\'");
	//System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
	//System.out.println("----------chanProgStr:"+chanProgStr);
%>
