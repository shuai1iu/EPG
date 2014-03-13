<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGErrorCode" %>
<%
    String pageName ="errorinfo.jsp";
	//要播放影片的id
	JSONObject resultjson = null;
	HashMap resultMap = new HashMap();
	ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
    int sProgId = Integer.parseInt(request.getParameter("VODID")); 
	//电视剧父集ID
	String fatherSeriesId = request.getParameter("FATHERID")==null?"-2":"null".equals(request.getParameter("FATHERID"))?"-2":"-1".equals(request.getParameter("FATHERID"))?"-2":request.getParameter("FATHERID");
	int sFatherSeriesId = Integer.parseInt(fatherSeriesId);
    int sContentType = Integer.parseInt(request.getParameter("CONTENTTYPE"));
    int sBusinessType = Integer.parseInt(request.getParameter("BUSINESSTYPE"));
	String productId = request.getParameter("PRODUCTCODE");
	String serviceId = request.getParameter("SERVICECODE"); 
	int prodCont = Integer.parseInt(EPGConstants.SUBSCRIPTION_NOTCONTINUEABLE);
	HashMap orderfilm = null;
	orderfilm = serviceHelpHWCTC.subscribeHWCTC(productId, serviceId, prodCont,sContentType,sProgId,sBusinessType,sFatherSeriesId,1);
    int ret_code = ((Integer)orderfilm.get(EPGConstants.KEY_RETCODE)).intValue();
	//订购成功
    if(ret_code == EPGErrorCode.SUBSCRIPTION_SUCCESSED)
    {
		resultMap.put("isSubscribe",true);
	}
	else
	{
		resultMap.put("isSubscribe",false);
		if(ret_code == 209)//政企用户不允许订购按次产品
		{
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","162");
		} 
		//该用户不支持在线订购
        else if(ret_code == 202)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","151");
        }
		//203 = TEMPLATE_DELETE_FAILED产品将下线，不支持订购
        else if(ret_code == 203)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","122");
        }
		else if(ret_code == EPGErrorCode.SUBSCRIPTION_NETWORKERROR)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","92");
        }
		else if(ret_code == EPGErrorCode.SUBSCRIPTION_FAILED_ALREADYORDER)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","101");
        }
        else if(ret_code == 104)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","101");
        }
		else if(ret_code == 100)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","137");
        }
		else if(ret_code == 101)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","138");
        }
		else if(ret_code == 102)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","139");
        }
		else if(ret_code == 103)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","140");
        }
		else if(ret_code == 105)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","141");
        }
		else if(ret_code == 106)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","142");
        }
		else if(ret_code == 107)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","143");
        }
		else if(ret_code == 108)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","144");
        }
		else if(ret_code == 109)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","145");
        }
		else if(ret_code == 204)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","146");
        }
		else if(ret_code == 205)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","147");
        }
		else if(ret_code == 206)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","148");
        }
		else if(ret_code == 207)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","149");
        }
		else if(ret_code == 208)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","150");
        }
		else if(ret_code == 0x07030001)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","36");
        }
		else if(ret_code ==0x07030100)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","155");
        }
		else if(ret_code ==0x07030200)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","160");
        }
		else if(ret_code ==0x07030300)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","161");
        }
		else if(ret_code ==0x04010004)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","157");
        }
		else if(ret_code ==0x04010899)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","158");
        }
		else if(ret_code ==0x04020888)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","145");
        }
		else if(ret_code ==0x07000005)
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","159");
        }
		else if(ret_code ==210)
		{
			//用户积分点数不够
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","166");
		}
		else if(ret_code ==211)
		{
			//产品不支持积分订购
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","167");
		}
		else if(ret_code ==212)
		{
			//积分订购处理失败
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","168");
		}
		else if(ret_code ==213)
		{
			//不允许退订积分订购的产品
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","169");
		}
		else if(ret_code ==215)
		{
			//不允许用积分续订产品
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","170");
		}
		else if(ret_code ==400)
		{
			//BSS限呼的一个问题
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","171");
		}
        else
        {
			resultMap.put("ERROR_TYPE","2");
			resultMap.put("ERROR_ID","36");
        }
		resultMap.put("PAGENAME",pageName);
	}
	resultjson = JSONObject.fromObject(resultMap);	 //转化为JSON对象
	response.getWriter().print(resultjson);
%>