<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGErrorCode" %>
<%
	String varName = request.getParameter("varName")==null?"tempAuth":request.getParameter("varName");
	String isBug = request.getParameter("isBug")==null?"-1":request.getParameter("isBug").toString();
	String isJson = request.getParameter("isJson")==null?"-1":request.getParameter("isJson").toString();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	
    String typesId = request.getParameter("definition")==null?"-1":request.getParameter("definition");
	//要播放影片的id
    int sProgId = Integer.parseInt(request.getParameter("programCode") == null ? "-1" : request.getParameter("programCode")); 
	//电视剧父集ID
	int parentCode = Integer.parseInt(request.getParameter("parentCode") == null ? "-1" : request.getParameter("parentCode")); 
	
	String fatherSeriesId = request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode");
	
    
    ServiceHelp serviceHelp = new ServiceHelp(request);
    ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
	JSONObject jsonResult = null;
	String pageName ="errorinfo.jsp";
    
    
	ArrayList timeList = new ArrayList();
	ArrayList mouseList = new ArrayList();
	ArrayList pointList = new ArrayList();
	String sProductCode=null;
	String sServiceId=null;
	String sPrice=null;
	String startTime=null;
    Map retMap = null;
	HashMap resultMap = new HashMap();
	if(sProgId==parentCode)
	{
		//电影订购
	    retMap = serviceHelpHWCTC.authorizationHWCTC(sProgId, 1, 0, 1,fatherSeriesId,parentCode);
	}
	else
	{
		//连续剧订购
		retMap = serviceHelpHWCTC.authorizationHWCTC(fatherSeriesId, 1, 0, 1,fatherSeriesId,parentCode);
	}
	int retCode = EPGErrorCode.AUTHORIZATION_DATABASEERROR;   //初始化为数据库异常，防止出现空值
	if(null != retMap && null != retMap.get(EPGConstants.KEY_RETCODE))
	{
		retCode = ((Integer)retMap.get(EPGConstants.KEY_RETCODE)).intValue();
	}
	//授权通过
	if(retCode == EPGErrorCode.SUCCESS)
	{
		resultMap.put("ALLOWPLAY",true);
	}
	else
	{
		//授权不通过的判断
		resultMap.put("ALLOWPLAY",false);
		if (retCode == 0x04010004)//0x04010004：用户不存在或非法用户
	    {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","157");
			resultMap.put("PAGENAME","pageName");
		}
		else if (retCode == 0x07020001)//没有可以订购的产品
	    {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","154");
			resultMap.put("PAGENAME","pageName");
	    }
	    else if (retCode == 0x07020100)//0x07020100：数据库异常
	    {
		    resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","155");
			resultMap.put("PAGENAME","pageName");
	    }
		else if (retCode == 0x07020200)//0x07020200：操作超时
		{
		    resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","171");
			resultMap.put("PAGENAME","pageName");
		}
		else if (retCode == 0x04010899)//0x04010899：用户令牌非法
		{
		    resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","158");
			resultMap.put("PAGENAME","pageName");
	    }
		else if (retCode == 0x07000005) //0x07000005 传入的参数错误
		{
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","159");
			resultMap.put("PAGENAME","pageName");
	     }
		else if (retCode == 0x07000006) //0x07000006 解码出现异常
		{	
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","153");
			resultMap.put("PAGENAME","pageName");
		}
		else if (retCode == 400) //BSS限呼的一个问题
	    {
		    resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","171");
			resultMap.put("PAGENAME","pageName");
	    }
	    else if (retCode == 0x07020002||retCode ==500||retCode ==501||retCode ==502||retCode ==503||retCode ==504)
	    {
			if(retCode == 500)
			{
				resultMap.put("ERROR_TYPE","2");
			    resultMap.put("ERROR_ID","135");
				resultMap.put("PAGENAME","pageName");
			}
			else if(retCode == 501)//产品不存在或状态不可用
			{
				resultMap.put("ERROR_TYPE","2");
			    resultMap.put("ERROR_ID","125");
				resultMap.put("PAGENAME","pageName");
			} 
			else if(retCode == 502)//服务不存在或状态不可用
			{
				resultMap.put("ERROR_TYPE","2");
			    resultMap.put("ERROR_ID","126");
				resultMap.put("PAGENAME","pageName");
			}
			else if(retCode == 503)//订购的产品不在使用期内
			{
				resultMap.put("ERROR_TYPE","2");
			    resultMap.put("ERROR_ID","127");
				resultMap.put("PAGENAME","pageName");
			}
			else if(retCode == 504)//用户没有订购相应产品或订购关系已失效或未生效
			{
				resultMap.put("ISSUBSCRIBE",false);
				timeList = (ArrayList) retMap.get("TIMES_LIST");
				mouseList = (ArrayList) retMap.get("MONTH_LIST");
				ArrayList tempList = new ArrayList();
				if(timeList!=null && timeList.size()>0)
				{
					
					for(int i=0;i<timeList.size();i++){
						HashMap timeresultMap = new HashMap();
						timeresultMap.put("productName",((HashMap)timeList.get(i)).get("PROD_NAME"));
						sProductCode = (String) ((HashMap)timeList.get(i)).get("PROD_CODE");
						sServiceId = (String) ((HashMap)timeList.get(i)).get("SERVICE_CODE");
						sPrice = (String) ((HashMap)timeList.get(i)).get("PROD_PRICE");
						startTime = (String) ((HashMap)timeList.get(i)).get("productStartTime");
						String productContinueType = (String) ((HashMap)timeList.get(i)).get("PROD_CONTINUEABLE");
						String productIntroduce = (String) ((HashMap)timeList.get(i)).get("PROD_INTRODUCE");
						if(sPrice == null || "".equals(sPrice))
						{
							sPrice = "0";
						}
						timeresultMap.put("productCode",sProductCode);
						timeresultMap.put("serviceCode",sServiceId);
						timeresultMap.put("productPrice",(Integer.parseInt(sPrice)/100)+"");
						String endTime_onceArr = serviceHelp.getServiceExpireTime(sProductCode,sServiceId);
				        String endTime_once = endTime_onceArr.substring(0,4) + "-" + endTime_onceArr.substring(4,6) + "-" 
		+ endTime_onceArr.substring(6,8)+ " " +  endTime_onceArr.substring(8,10) + ":" + endTime_onceArr.substring(10,12);
		
						String startTime_once = startTime.substring(0,4) + "-" + startTime.substring(4,6) + "-" 
		+ startTime.substring(6,8)+ " " +  startTime.substring(8,10) + ":" + startTime.substring(10,12);
				        timeresultMap.put("productEndTime",endTime_once);
				        timeresultMap.put("productStartTime",startTime_once);
				        timeresultMap.put("productType","0");
				        timeresultMap.put("productContinueType",productContinueType);
				        timeresultMap.put("productIntroduce",productIntroduce);
						tempList.add(timeresultMap);
					}
				}
				if(mouseList!=null && mouseList.size()>0)
				{
					for(int i=0;i<mouseList.size();i++){
						HashMap mouseresultMap = new HashMap();
						mouseresultMap.put("productName",((HashMap)mouseList.get(i)).get("PROD_NAME"));
						sProductCode = (String) ((HashMap)mouseList.get(i)).get("PROD_CODE");
						sServiceId = (String) ((HashMap)mouseList.get(i)).get("SERVICE_CODE");
						sPrice = (String) ((HashMap)mouseList.get(i)).get("PROD_PRICE");
						startTime = (String) ((HashMap)timeList.get(i)).get("productStartTime");
						String productContinueType = (String) ((HashMap)timeList.get(i)).get("PROD_CONTINUEABLE");
						String productIntroduce = (String) ((HashMap)timeList.get(i)).get("PROD_INTRODUCE");
						if(sPrice == null || "".equals(sPrice))
						{
							sPrice = "0";
						}
						mouseresultMap.put("productCode",sProductCode);
						mouseresultMap.put("serviceCode",sServiceId);
						mouseresultMap.put("productPrice",(Integer.parseInt(sPrice)/100)+"");
						String endTime_onceArr = serviceHelp.getServiceExpireTime(sProductCode,sServiceId);
				        String endTime_once = endTime_onceArr.substring(0,4) + "-" + endTime_onceArr.substring(4,6) + "-" 
		+ endTime_onceArr.substring(6,8)+ " " +  endTime_onceArr.substring(8,10) + ":" + endTime_onceArr.substring(10,12);
		
						String startTime_once = startTime.substring(0,4) + "-" + startTime.substring(4,6) + "-" 
		+ startTime.substring(6,8)+ " " +  startTime.substring(8,10) + ":" + startTime.substring(10,12);
				        mouseresultMap.put("productEndTime",endTime_once);
				        mouseresultMap.put("productStartTime",startTime_once);
				        mouseresultMap.put("productType","1");
				        mouseresultMap.put("productContinueType",productContinueType);
				        mouseresultMap.put("productIntroduce",productIntroduce);
				        tempList.add(mouseresultMap);
					}
					
				}
				resultMap.put("productlist",tempList);
			}
	    }
	}
	
	jsonResult = JSONObject.fromObject(resultMap);	 //转化为JSON对象
	
%>

<%
if(isBug.equals("1"))
{
	System.out.println(jsonResult);
}
if(isJson.equals("-1"))
{
%>	
var <%=varName%> = <%=jsonResult%>;
<%
}
else
{
 response.getWriter().print(jsonResult.toString());	 
}
%>
