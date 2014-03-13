<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file = "query_IsHasBookMark.jsp"%>
<script>
<%
    JSONObject jsoncontentInfo = null;
	HashMap voddetailInfo = new HashMap();
    int progid = request.getParameter("vodid")==null?1:Integer.parseInt(request.getParameter("vodid"));
	HashMap isbm_result = isHasBookMark(((Integer)progid).toString(),request);
	Boolean hasbookMark = new Boolean("False");  //是否包含书签
	String begintime = "";  //开始时间
	String endtime = "";    //结束时间
	if(isbm_result!=null){
		hasbookMark = new Boolean(isbm_result.get("ISBOOKMARK").toString());
		begintime = isbm_result.get("BEGINTIME").toString();
		endtime = isbm_result.get("ENDTIME").toString();
	}
	voddetailInfo.put("ISBOOKMARK",hasbookMark);
	voddetailInfo.put("BEGINTIME",begintime);
	voddetailInfo.put("ENDTIME",endtime);
	jsoncontentInfo = JSONObject.fromObject(voddetailInfo);
%>
var subVoddetailInfo = <%=jsoncontentInfo%>;
window.parent.checkBookmark(subVoddetailInfo);
</script>