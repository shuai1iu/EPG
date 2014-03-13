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
	orderfilm = serviceHelpHWCTC.subscribeHWCTC(productId, serviceId, 1,sContentType,sProgId,sBusinessType,sFatherSeriesId,1);
	System.out.println("productId:"+productId+";serviceId:"+serviceId+";prodCont:"+prodCont+";sContentType:"+sContentType+";sProgId:"+sProgId+";sBusinessType:"+sBusinessType+";sFatherSeriesId:"+sFatherSeriesId);
	System.out.println("sss"+orderfilm);
    int ret_code = ((Integer)orderfilm.get(EPGConstants.KEY_RETCODE)).intValue();
	String pagename="";
	String url1 = request.getParameter("url1")==null?"":request.getParameter("url1");
	String playurl = request.getParameter("playurl")==null?"":request.getParameter("playurl");
	
	String ReturnURL = request.getParameter("ReturnURL")==null?"":request.getParameter("ReturnURL");
	
	/* if(!ReturnURL.equals("")){
	     response.sendRedirect(ReturnURL);
		 return;
	} */
	
	//订购成功
    if(ret_code == EPGErrorCode.SUBSCRIPTION_SUCCESSED)
    {
		pagename=playurl;
	}else{
		pagename=url1;
		
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>二次确定订购页-深圳IP电视高清专区EPG3.0</title>
<meta name="page-view-size" content="1280*720" />
<script type="text/javascript">
       
 </script>
</head>
<body>
	ReturnURL=<%=ReturnURL%>
    
    
</body>
</html>