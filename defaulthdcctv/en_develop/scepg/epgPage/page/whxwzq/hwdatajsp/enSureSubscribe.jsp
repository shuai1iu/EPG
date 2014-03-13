<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGErrorCode" %>
<%
	//要播放影片的id
	JSONObject resultjson = null;
	HashMap resultMap = new HashMap();
	ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
    int sProgId = Integer.parseInt(request.getParameter("programCode")); 
	String varName = request.getParameter("varName")==null?"tempSureSubCode":request.getParameter("varName").toString();
	//电视剧父集ID
	String fatherSeriesId = request.getParameter("parentCode")==null?"-1":request.getParameter("parentCode");
	int sFatherSeriesId = Integer.parseInt(fatherSeriesId);
    int sContentType = Integer.parseInt(request.getParameter("productContinueType"));
    //int sBusinessType = Integer.parseInt(request.getParameter("BUSINESSTYPE"));
	String productId = request.getParameter("productCode");
	String serviceId = request.getParameter("serviceCode"); 
	int prodCont = Integer.parseInt(EPGConstants.SUBSCRIPTION_NOTCONTINUEABLE);
	HashMap orderfilm = null;
	orderfilm = serviceHelpHWCTC.subscribeHWCTC(productId, serviceId, sContentType,1,sProgId,1,sFatherSeriesId,1);
	//System.out.println("productId:"+productId+";serviceId:"+serviceId+";prodCont:"+prodCont+";sContentType:"+sContentType+";sProgId:"+sProgId+";sBusinessType:"+sBusinessType+";sFatherSeriesId:"+sFatherSeriesId);
	//System.out.println("sss"+orderfilm);
    int ret_code = ((Integer)orderfilm.get(EPGConstants.KEY_RETCODE)).intValue();

%>

var <%=varName%> = <%=ret_code%>;
