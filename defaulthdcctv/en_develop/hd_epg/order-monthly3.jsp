<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGErrorCode" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>

<%
     String path = request.getContextPath();
     String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	 String returnUrl = request.getParameter("returnUrl") == null ? "HD_index.jsp" : request.getParameter("returnUrl");
	  final  int zxvod=1919990;//  1919990 
	  MetaData metadata = new MetaData(request);
      ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
      

    String SUCCESS_URL="order-monthly2.jsp?returnUrl="+returnUrl;
	String zxprodid="";
	String zxproname="";
	String zxservercode="";
	String zxprice="0";
	int iszxorder=0;
	
	HashMap zxresultMap = new HashMap();
	HashMap zxmediadetailInfo = (HashMap)metadata.getVodDetailInfo(zxvod);
	
	int zxcontenttype= Integer.parseInt(zxmediadetailInfo.get("CONTENTTYPE").toString());
	zxresultMap = serviceHelpHWCTC.authorizationHWCTC(zxvod,1, zxcontenttype,1,"",zxvod);
	int zxretCode = EPGErrorCode.AUTHORIZATION_DATABASEERROR;   //初始化为数据库异常，防止出现空值
	ArrayList zxmouseList = new ArrayList();
		if(null != zxresultMap && null != zxresultMap.get(EPGConstants.KEY_RETCODE))
	{
	   zxretCode = ((Integer)zxresultMap.get(EPGConstants.KEY_RETCODE)).intValue();
	}
	if(zxretCode == 504){
	//开始订购
			   zxmouseList = (ArrayList) zxresultMap.get("MONTH_LIST");
			   if(zxmouseList!=null && zxmouseList.size()>0){
				   zxprodid = (String) ((HashMap)zxmouseList.get(0)).get("PROD_CODE");
				   zxproname = (String) ((HashMap)zxmouseList.get(0)).get("PROD_NAME");
				   zxservercode = (String) ((HashMap)zxmouseList.get(0)).get("SERVICE_CODE");
				   zxprice = (String) ((HashMap)zxmouseList.get(0)).get("PROD_PRICE");
				   if(zxprice == null || "".equals(zxprice))
				   {
							zxprice = "0";
				   }
				   zxprice=(Integer.parseInt(zxprice)/100)+"";
			   }
			  iszxorder=1;
	}else{
		 iszxorder=0;//表示已经订购
		 response.sendRedirect(SUCCESS_URL);
		 return;
	}	

 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>特惠包月2-深圳首映专区高清 EPG3.0</title>
<meta name="page-view-size" content="1280*720" />
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<link type="text/css" rel="stylesheet" href="css/style.css" />
<style type="text/css">
<!--
	body{ background:url(images/bg-order03.jpg) no-repeat;}
-->
</style>
</head>
<script type="text/javascript">
var returnUrl = "<%=returnUrl%>";
window.onload=function(){
  var area0=AreaCreator(1,2,new Array(-1,-1,-1,-1),"area0_list_","className:item item_focus","className:item ");
       area0.areaOkEvent=function(){
		   if(area0.curindex == 0){
			   window.location.href="order-monthly1.jsp?price=<%=zxprice%>&prodname=<%=zxproname%>&CONTENTTYPE=<%=zxcontenttype%>&BUSINESSTYPE=1&PRODUCTCODE=<%=zxprodid%>&SERVICECODE=<%=zxservercode%>&VODID=<%=zxvod%>&FATHERID=<%=zxvod%>&ReturnURL=order-monthly2.jsp&returnurl="+escape(window.location.href+"?returnUrl="+returnUrl); 
			   }else{
				   window.location.href=returnUrl;
				   }
          
      } ;  
         pageobj=new PageObj(0,0,new Array(area0));
         pageobj.goBackEvent=function(){
            window.location.href=returnUrl;
           };
         };
</script>

<body>
    
    	<!--order-->
	<div class="btn-d" style="left:475px;">
		<!--焦点 
				class="item item_focus"
		-->
		<div id="area0_list_0" class="item item_focus">
			<div class="txt">立即订购</div>
		</div>
		<div id="area0_list_1" class="item" style="left:188px;">
			<div class="txt">返&nbsp;回</div>
		</div>
	</div>
	<!--order the end-->
	
	
</body>
</html>
