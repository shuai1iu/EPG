<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" buffer="32kb" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.facade.bean.info.UserSubscribe" %>
<%@ page import="com.huawei.iptvmw.facade.bean.info.MonthInfoItem" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%
	JSONArray jRecordList = null;
	List recordList = new ArrayList();
	//过滤基础包和套餐里包含的产品包
	Set filterSet = new HashSet();
	String QUERYGET_URL="http://14.29.1.46:8080/ACS/vas/queryOrderedPackage";	
	UserProfile userProfile = new UserProfile(request);
	String  userId = userProfile.getUserId();
	String  userToken = userProfile.getUserToken();
	URL postUrl=new URL(QUERYGET_URL);
    HttpURLConnection connection=(HttpURLConnection)postUrl.openConnection();
    connection.setDoInput(true);
    connection.setDoOutput(true);
    connection.setConnectTimeout(5000);  
    connection.setRequestMethod("POST");
    connection.setUseCaches(false);
    connection.setInstanceFollowRedirects(true);
    connection.connect();
    DataOutputStream outdata=new DataOutputStream(connection.getOutputStream());
    String requestXml="{userToken:'"+userToken +"',userId:'"+ userId + "',spId:''}";
    outdata.writeBytes(requestXml); 
    outdata.flush();
    outdata.close(); 
    BufferedReader reader = new BufferedReader(new InputStreamReader(
	connection.getInputStream(),"UTF-8"));
	StringBuilder sb=new StringBuilder();
	String lines="";
	while((lines=reader.readLine())!=null){
		 sb.append(lines);		 
	}
	reader.close();
	connection.disconnect();	
    String queryResult=sb.toString();
	JSONObject resultJson = JSONObject.fromObject(queryResult);
	List queryList = new ArrayList();
	int resultCode = (Integer)resultJson.get("result");
	if(resultCode==0){
		queryList = (List)resultJson.get("packages");
		for(int i=0;i<queryList.size();i++){
			Map tempMap = new HashMap();
			Map dataMap = (Map)queryList.get(i);
			tempMap.put("prodcode", dataMap.get("packageId").toString());
			tempMap.put("prodname", dataMap.get("packageName").toString());
			tempMap.put("price", dataMap.get("fee").toString());		
			tempMap.put("type", "套餐");
			String startTime = dataMap.get("startTime").toString();
			String endTime = dataMap.get("endTime").toString();
			if(startTime == null||startTime.equals("")){
				startTime = "未知";
			}
			else{	
				String year = startTime.substring(0,4);
				String month = startTime.substring(4,6);
				String day = startTime.substring(6,8);
				startTime = year+"/"+month+"/"+day;
			}
			tempMap.put("ordertime", startTime);
			recordList.add(tempMap);
			List prodList = (List)dataMap.get("products");
			for(int j=0;j<prodList.size();j++){
				Map prodMap = (Map)prodList.get(j);
				filterSet.add(prodMap.get("productId").toString());
			}
		}
	}

	ServiceHelp serviceHelp = new ServiceHelp(request);
	Map retMap = serviceHelp.queryOrderInfoByProfile();
	String[] prodCode = new String[1];
    String[] prodName = new String[1];
    String[] price = new String[1];
    String[] ordertime = new String[1];
	String[] endtime = new String[1];
    int countTotal= 0;
    int ret_code = ((Integer) retMap.get("RETCODE")).intValue();
	if(ret_code == 0){
		countTotal = ((String[])retMap.get("PROD_CODE")).length;
		if(countTotal != 0){			
			prodCode = (String[])retMap.get("PROD_CODE");
			prodName = (String[])retMap.get("PROD_DES");
			price = (String[])retMap.get("PROD_PRICE");
			ordertime = (String[])retMap.get("PROD_BEGINTIME");		
			endtime = (String[])retMap.get("PROD_ENDTIME");	
			for(int i = 0; i < countTotal; i++){	
				if(filterSet.contains(prodCode[i]))
					continue;
				String tempTime = "未知";
				String tempName = "未知";
				String preName1 = "深圳IP电视";
				String preName2 = "深圳IPTV";
				int tempindex = -1;
				if(ordertime[i] != null&&!ordertime[i].equals("")){
					String year = ordertime[i].substring(0,4);
					String month = ordertime[i].substring(4,6);
					String day = ordertime[i].substring(6,8);
					tempTime = year+"/"+month+"/"+day;
				}
				if(prodName[i].indexOf(preName1) != -1 || prodName[i].indexOf(preName2) != -1){
					tempName = prodName[i].substring(6);
				}
				Map tempMap = new HashMap();
				tempMap.put("prodcode", prodCode[i]);
				tempMap.put("prodname", tempName);
				tempMap.put("price", price[i]);
				tempMap.put("starttime", ordertime[i]);
				tempMap.put("ordertime", tempTime);
				tempMap.put("type", "产品");
				recordList.add(tempMap);
			}
		}	
	}
	
	/*
	MetaData metaData = new MetaData(request);
	UserSubscribe subInfo = userProfile.getSubscribeList();
	List<MonthInfoItem> subMonthList = (List<MonthInfoItem>)subInfo.getMonthInfoList();
	for (int i = 0;i<subMonthList.size();i++)
	{
		MonthInfoItem monthInfoItem =(MonthInfoItem) subMonthList.get(i);
		System.out.println("monthInfoItem----"+monthInfoItem);
		String prodCode = monthInfoItem.getProductId();
		String prodEndTime = monthInfoItem.getSerEndTime();
		String prodBeginTime = monthInfoItem.getSerBeginTime();
		String prodName = metaData.getProductNameByProductId(prodCode);
		if(filterSet.contains(prodCode))
			continue;
		if(prodName != null && !prodName.equals("1") && Integer.parseInt(prodEndTime.substring(0,4))>=2099)
		{
			String year = prodBeginTime.substring(0,4);
			String month =prodBeginTime.substring(4,6);
			String day = prodBeginTime.substring(6,8);
			String tempTime = year+"/"+month+"/"+day;
			Map tempMap = new HashMap();
			tempMap.put("prodcode", prodCode);
			tempMap.put("prodname", prodName);
			//tempMap.put("price", price);
			tempMap.put("ordertime", tempTime);
			tempMap.put("starttime", prodBeginTime);
			tempMap.put("type", "产品");
			recordList.add(tempMap);
		}
	}*/

	/*
	ServiceHelpHWCTC serviceHelp = new ServiceHelpHWCTC(request); 
	String month1 = StringDateUtil.getTodaytimeString("yyyymm");
	String month3 = StringDateUtil.adjustMonth(month1, -2);
	Map retMap = (HashMap)serviceHelp.queryOrderHWCTC(month3,month1);
	String[] prodCode = new String[1];
    String[] prodName = new String[1];
    String[] price = new String[1];
    String[] ordertime = new String[1];
    int countTotal= 0;
    int ret_code = ((Integer) retMap.get("RETCODE")).intValue();
	if(ret_code == 0){
		countTotal = ((String[])retMap.get("PROD_CODE")).length;
		if(countTotal != 0){			
			prodCode = (String[])retMap.get("PROD_CODE");
			prodName = (String[])retMap.get("PROD_DES");
			price = (String[])retMap.get("PROD_PRICE");
			ordertime = (String[])retMap.get("PROD_BEGINTIME");			
			for(int i = 0; i < countTotal; i++){	
				if(filterSet.contains(prodCode[i]))
					continue;
				if(ordertime[i] == null||ordertime[i].equals("")){
					ordertime[i] = "未知";
				}
				else{	
					String year = ordertime[i].substring(0,4);
					String month = ordertime[i].substring(4,6);
					String day = ordertime[i].substring(6,8);
					String tempTime = year+"/"+month+"/"+day;
					ordertime[i] = tempTime;
				}
				Map tempMap = new HashMap();
				tempMap.put("prodcode", prodCode[i]);
				tempMap.put("prodname", prodName[i]);
				tempMap.put("price", price[i]);
				tempMap.put("ordertime", ordertime[i]);
				tempMap.put("type", "产品");
				recordList.add(tempMap);
			}
		}	
	}*/

    jRecordList = JSONArray.fromObject(recordList);
	System.out.println("jRecordList----"+jRecordList);

	//jRecordList----[{"starttime":"20131126185814","price":"1500","prodcode":"4353","prodname":"深圳IPTV首映","ordertime":"2013/11/26","type":"产品"},{"starttime":"20131129000000","price":"3000","prodcode":"4302","prodname":"深圳IPTV高清纪实","ordertime":"2013/11/29","type":"产品"},{"starttime":"20131129000000","price":"3000","prodcode":"4300","prodname":"深圳IPTV高清大片","ordertime":"2013/11/29","type":"产品"},{"starttime":"20120530173855","price":"3000","prodcode":"4100","prodname":"深圳IP电视30元/月","ordertime":"2012/05/30","type":"产品"},{"starttime":"20131129000000","price":"2000","prodcode":"4303","prodname":"深圳IPTV高清娱乐","ordertime":"2013/11/29","type":"产品"},{"starttime":"20131129000000","price":"2000","prodcode":"4301","prodname":"深圳IPTV高清热剧","ordertime":"2013/11/29","type":"产品"}]

%>
<script language="javascript"  type="text/javascript">
	var recordlist = <%=jRecordList%>;
</script>	
