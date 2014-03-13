<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<script>
<%
    String productId = request.getParameter("productID");
	String serviceId = productId;
	int prodCont = Integer.parseInt(EPGConstants.SUBSCRIPTION_NOTCONTINUEABLE);
    HashMap resultMap= new HashMap();
    ServiceHelp serviceHelp = new ServiceHelp(request);
	ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
	//resultMap = serviceHelp.subscribe(productId,serviceId,0);
	resultMap = serviceHelpHWCTC.subscribeHWCTC(productId, serviceId, prodCont,0,0,0,-2,1);
%>
var resultMap = "<%=resultMap%>";
window.parent.showResult(resultMap);
</script>