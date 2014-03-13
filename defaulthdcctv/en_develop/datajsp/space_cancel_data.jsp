<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" buffer="32kb" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
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
	filterSet.add("4100");
	filterSet.add("4102");
	filterSet.add("4103");
	filterSet.add("4200");
	filterSet.add("420001");
	filterSet.add("420101");
	filterSet.add("4201");
	String QUERYGET_URL="http://14.29.1.46:8080/ACS/vas/queryOrderedPackage";	
	UserProfile userProfile = new UserProfile(request);
	String  userId = userProfile.getUserId();
	String  userToken = userProfile.getUserToken();
		String queryResult = "{}";
	URL postUrl = null;
	HttpURLConnection connection = null;
	DataOutputStream outdata = null;
	BufferedReader reader = null;
	try {
		postUrl=new URL(QUERYGET_URL);
		connection=(HttpURLConnection)postUrl.openConnection();
		connection.setDoInput(true);
		connection.setDoOutput(true);
		connection.setConnectTimeout(5000);  
		connection.setRequestMethod("POST");
		connection.setUseCaches(false);
		connection.setInstanceFollowRedirects(true);
		connection.connect();
		outdata=new DataOutputStream(connection.getOutputStream());
		String requestXml="{userToken:'"+userToken +"',userId:'"+ userId + "',spId:''}";
		outdata.writeBytes(requestXml); 
		outdata.flush();	
		reader = new BufferedReader(new InputStreamReader(
		connection.getInputStream(),"UTF-8"));
		StringBuilder sb=new StringBuilder();
		String lines="";
		while((lines=reader.readLine())!=null){
			 sb.append(lines);		 
		}		
		queryResult=sb.toString();
	}catch(Exception e){
		
	}finally{
		if(outdata!=null){
			try {
				outdata.close();
			} catch (IOException e) {
				e.printStackTrace();
			} 
		}
		if(reader!=null){
			try {
				reader.close();
			} catch (IOException e) {
				e.printStackTrace();
			}	
		}
		if(connection!=null){
			connection.disconnect();
		}
	}
	JSONObject resultJson = JSONObject.fromObject(queryResult);
	List queryList = new ArrayList();
	if(resultJson.get("result")!=null){
		int resultCode = (Integer)resultJson.get("result");
		if(resultCode==0){
			queryList = (List)resultJson.get("packages");
			//套餐包含基础包也需要过滤掉
			boolean basicFlag = false;
			for(int i=0;i<queryList.size();i++){
				Map tempMap = new HashMap();
				Map dataMap = (Map)queryList.get(i);
				List prodList = (List)dataMap.get("products");
				for(int j=0;j<prodList.size();j++){
					Map prodMap = (Map)prodList.get(j);
					String tempCode = prodMap.get("productId").toString();
					if(filterSet.contains(tempCode)){
						basicFlag = true;
						break;
					}
					filterSet.add(tempCode);
				}
				if(basicFlag){
					break;
				}
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
				if(Integer.parseInt(endtime[i].substring(0,4))<2099||filterSet.contains(prodCode[i]))
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
	if(ret_code == EPGErrorCode.SEARCHBILL_SUCCESSED){
		if (retMap!=null && ret_code == EPGErrorCode.SEARCHBILL_SUCCESSED){
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
%>
<script language="javascript"  type="text/javascript">
	var recordlist = <%=jRecordList%>;
</script>	
