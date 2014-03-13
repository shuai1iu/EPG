<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGErrorCode" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ include file="check_subscribedata.jsp"%>
<%@ include file="util_getPosterPaths.jsp"%>

<%
String returnurl=request.getParameter("returnurl")==null?"":request.getParameter("returnurl");
//	String playurl=request.getParameter("playUrl")==null?"":request.getParameter("playurl");
String playurl = null == request.getParameter("playurl")?(null == (String)session.getAttribute("playurl")? "": (String)session.getAttribute("playurl")):request.getParameter("playurl"); 
System.out.println("returnurl======"+ returnurl);
System.out.println("playurl=====" + playurl);
MetaData metadata = new MetaData(request);
HashMap detailMap =null;
String tempvodname="";
if(sProgId!=sFatherSeriesId){
	detailMap =  (HashMap)metadata.getVodDetailInfo(sFatherSeriesId);
}else{
	detailMap =  (HashMap)metadata.getVodDetailInfo(sProgId);
}
if(detailMap.get("VODNAME")!=null){
	tempvodname = detailMap.get("VODNAME").toString();
}
HashMap posterMap = (HashMap)(detailMap.get("POSTERPATHS"));
String picUrl = "";
if(posterMap!=null){
	//0.缩略图1.海报2.剧照3.图标4.标题图5.广告图6.草图7.背景9.频道图99.其他
	picUrl = "../../../"+getPosterPath(posterMap,"../../../defaultgdsd/en/page/shouying/images/display/vod/poster_no_pic.jpg","1",request);
}

ArrayList temptimeList=(ArrayList)resultMap.get("timeList");
ArrayList tempmouseList=(ArrayList)resultMap.get("mouseList");
String ppvname="";
String ppvsj="";
String ppvprice="";
String ppvservicecode="";
String ppvcode="";

String monthname1="";
String monthsj1="";
String monthprice1="";
String monthservicecode1="";
String monthcode1="";

String zxname="";
String zxsj="";
String zxprice="";
String zxservicecode="";
String zxcode="";

String columnpname="";
String columnpsj="";
String columnpprice="";
String columnpservicecode="";
String columnpcode="";
int isAllowPPV=0;

if(temptimeList!=null  && temptimeList.size()>0){
	ppvname=(String)((HashMap)temptimeList.get(0)).get("PROD_NAME");
	ppvsj=(String)((HashMap)temptimeList.get(0)).get("EXPIRE_TIME");
	ppvservicecode=(String)((HashMap)temptimeList.get(0)).get("SERVICE_CODE");
	ppvprice=(String)((HashMap)temptimeList.get(0)).get("PROD_PRICE");
	ppvcode=(String)((HashMap)temptimeList.get(0)).get("PROD_CODE");
	isAllowPPV=1;
}

if(tempmouseList!=null  && tempmouseList.size()>0){
	monthname1=(String)((HashMap)tempmouseList.get(0)).get("PROD_NAME");
	monthsj1=(String)((HashMap)tempmouseList.get(0)).get("EXPIRE_TIME");
	monthservicecode1=(String)((HashMap)tempmouseList.get(0)).get("SERVICE_CODE");
	monthprice1=(String)((HashMap)tempmouseList.get(0)).get("PROD_PRICE");
	monthcode1=(String)((HashMap)tempmouseList.get(0)).get("PROD_CODE");
	zxname=monthname1;
	zxsj=monthsj1;
	zxprice=monthprice1;
	zxservicecode=monthservicecode1;
	zxcode=monthcode1;
}
System.out.println("HERE");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>订购-深圳标清首映EPG2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/styleorder.css" />

<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
var area0;
window.onload = function(){
	area0 = AreaCreator(2,1,new Array(-1,-1,-1,-1),"area0_list_","className:item item_focus","className:item");
	area0.doms[0].domOkEvent = function(){
		window.location.href="order-monthly.jsp?price=<%=zxprice%>&ppvsj=<%=ppvsj%>&prodname=<%=zxname%>&prodid=<%=zxcode%>&serverid=<%=zxservicecode%>&vodid=<%=sProgId%>&parentvodid=<%=fatherSeriesId%>&url1="+escape(window.location.href)+"&playurl="+escape("<%=playurl%>");
	}
	area0.doms[1].domOkEvent = function(){
		window.location.href="order-pay.jsp?isppv=1&price=<%=ppvprice%>&ppvsj=<%=ppvsj%>&prodname=<%=ppvname%>&prodid=<%=ppvcode%>&serverid=<%=ppvservicecode%>&vodid=<%=sProgId%>&parentvodid=<%=fatherSeriesId%>&url1="+escape(window.location.href)+"&playurl="+escape("<%=playurl%>");
	}

	if(<%=isAllowPPV%>==0){
		area0.datanum = 1;
		$("title_ppv").innerHTML = "暂不支持单片订购";
		$("endTime_ppv").style.display = "none";
		$("desc_ppv").style.display = "none";
		$("order_ppv").style.display = "none";
	}

	pageobj = new PageObj(0,0,new Array(area0),null);	
	pageobj.backurl = "<%=returnurl%>";

}
</script>
</head>

<body bgcolor="transparent">

<!--pagebg-->
<div class="pagebg">
<div class="pic"><img src="../images/bg-order01.jpg" width="640" height="530" /></div>
</div>
<!--pagebg the end-->



<div class="wrapper">

<!--order-->
<div class="order">
<div class="txt txt-title" id="title"><%=tempvodname%></div>

<div class="pic-shade">
<div class="pic"><img src="<%=picUrl%>" /></div>
</div>

<div class="con">
<div class="icon"></div>
<div class="txt txt01"><%=zxname%> <%=zxprice%> 元</div>
<div class="txt txt02">百部院线热片随意看</div>
<!--焦点 
class="item item_focus"
-->
<div class="item" id="area0_list_0">
<div class="txt">订 &nbsp;购</div>
</div>
</div>

<div class="con" style="top:171px;">
<div class="txt txt01" style="top:48px;" id="title_ppv"><%=ppvname%> <%=ppvprice%> 元</div>
<div class="line"><img src="../images/line.png" width="332" height="2" /></div>
<div class="txt txt03" style="display:block" id="endTime_ppv"><span>有效期</span> <%=ppvsj%></div>
<div class="txt txt02" style="display:block" id="desc_ppv">48小时内可反复观看</div>
<!--焦点 
class="item item_focus"
-->
<div class="item" id="area0_list_1">
<div class="txt" style="display:block" id="order_ppv">订 &nbsp;购</div>
</div>
</div>
</div>
<!--order the end-->

</div>	

</body>
</html>
