<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGErrorCode" %>
<%
    ServiceHelp serviceHelp = new ServiceHelp(request);
    ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
	JSONObject jsonResult = null;
	String pageName ="errorinfo.jsp";
    String typesId = request.getParameter("TYPE_ID")==null?"-1":"null".equals(request.getParameter("SUBJECTID"))?"-1":request.getParameter("SUBJECTID");
	//要播放影片的id
    int sProgId = Integer.parseInt(request.getParameter("VODID")); 
	//电视剧父集ID
	String fatherSeriesId = request.getParameter("FATHERID")==null?"-2":"null".equals(request.getParameter("FATHERID"))?"-2":"-1".equals(request.getParameter("FATHERID"))?"-2":request.getParameter("FATHERID");
	int sFatherSeriesId = Integer.parseInt(fatherSeriesId);
    // 播放类型  内容类型 业务类型  
    int sPlayType = Integer.parseInt(request.getParameter("PLAYTYPE"));
    int sContentType = Integer.parseInt(request.getParameter("CONTENTTYPE"));
    int sBusinessType = Integer.parseInt(request.getParameter("BUSINESSTYPE"));
	ArrayList timeList = new ArrayList();
	ArrayList mouseList = new ArrayList();
	ArrayList pointList = new ArrayList();
	String sProductCode=null;
	String sServiceId=null;
	String sPrice=null;
    Map retMap = null;
	HashMap resultMap = new HashMap();
	if(sProgId==sFatherSeriesId)
	{
		//电影订购
	    retMap = serviceHelpHWCTC.authorizationHWCTC(sProgId,sPlayType, sContentType, sBusinessType,typesId,sFatherSeriesId);
	}
	else
	{
		//连续剧订购
		retMap = serviceHelpHWCTC.authorizationHWCTC(sFatherSeriesId,sPlayType, sContentType, sBusinessType,typesId,sFatherSeriesId);
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
				pointList = (ArrayList) retMap.get("PREORDERED_PRODLIST");
				
				//resultMap.put("PROD_NAME",timeList.size());
				if(timeList!=null && timeList.size()>0)
				{
					resultMap.put("PROD_NAME",((HashMap)timeList.get(0)).get("PROD_NAME"));
					sProductCode = (String) ((HashMap)timeList.get(0)).get("PROD_CODE");
					sServiceId = (String) ((HashMap)timeList.get(0)).get("SERVICE_CODE");
					sPrice = (String) ((HashMap)timeList.get(0)).get("PROD_PRICE");
					if(sPrice == null || "".equals(sPrice))
					{
						sPrice = "0";
					}
					resultMap.put("PROD_CODE",sProductCode);
					resultMap.put("SERVICE_CODE",sServiceId);
					resultMap.put("PROD_PRICE",(Integer.parseInt(sPrice)/100)+"元");
				}
				if(mouseList!=null && mouseList.size()>0)
				{
					resultMap.put("PROD_NAME",((HashMap)mouseList.get(0)).get("PROD_NAME"));
					sProductCode = (String) ((HashMap)mouseList.get(0)).get("PROD_CODE");
					sServiceId = (String) ((HashMap)mouseList.get(0)).get("SERVICE_CODE");
					sPrice = (String) ((HashMap)mouseList.get(0)).get("PROD_PRICE");
					if(sPrice == null || "".equals(sPrice))
					{
						sPrice = "0";
					}
					resultMap.put("PROD_CODE",sProductCode);
					resultMap.put("SERVICE_CODE",sServiceId);
					resultMap.put("PROD_PRICE",(Integer.parseInt(sPrice)/100)+"元");
				}
				if(pointList!=null && pointList.size()>0)
				{
					resultMap.put("PROD_NAME",((HashMap)pointList.get(0)).get("PROD_NAME"));
					sProductCode = (String) ((HashMap)pointList.get(0)).get("PROD_CODE");
					sServiceId = (String) ((HashMap)pointList.get(0)).get("SERVICE_CODE");
					sPrice = (String) ((HashMap)pointList.get(0)).get("PROD_PRICE");
					if(sPrice == null || "".equals(sPrice))
					{
						sPrice = "0";
					}
					resultMap.put("PROD_CODE",sProductCode);
					resultMap.put("SERVICE_CODE",sServiceId);
					resultMap.put("PROD_PRICE",(Integer.parseInt(sPrice)/100)+"元");
				}
				String endTime_onceArr = serviceHelp.getServiceExpireTime(sProductCode,sServiceId);
				String endTime_once = endTime_onceArr.substring(0,4) + "年" + endTime_onceArr.substring(4,6) + "月" 
		+ endTime_onceArr.substring(6,8)+ "日" +  endTime_onceArr.substring(8,10) + ":" + endTime_onceArr.substring(10,12);
				resultMap.put("EXPIRE_TIME",endTime_once);
			}
	    }
	}
	
	jsonResult = JSONObject.fromObject(resultMap);	 //转化为JSON对象
	response.getWriter().print(jsonResult);
%>