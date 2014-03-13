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
	String playurl=request.getParameter("playurl")==null?"":request.getParameter("playurl");
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
		picUrl = "../../"+getPosterPath(posterMap,"images/display/vod/poster_no_pic.jpg","1",request);
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
	
	if(temptimeList!=null  && temptimeList.size()>0){
		ppvname=(String)((HashMap)temptimeList.get(0)).get("PROD_NAME");
		ppvsj=(String)((HashMap)temptimeList.get(0)).get("EXPIRE_TIME");
		ppvservicecode=(String)((HashMap)temptimeList.get(0)).get("SERVICE_CODE");
		ppvprice=(String)((HashMap)temptimeList.get(0)).get("PROD_PRICE");
		ppvcode=(String)((HashMap)temptimeList.get(0)).get("PROD_CODE");
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
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>单片或整包购买-深圳首映专区高清EPG3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<style type="text/css">
<!--
	body{ background:url(../images/bg-order02.jpg) no-repeat;}
	
-->
</style>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
	var area0,area1;
	window.onload = function(){
		
		area0 = AreaCreator(1,2,new Array(-1,-1,-1,1),"area0_list_","className:item item_focus","className:item");
		area1 = AreaCreator(1,1,new Array(-1,0,-1,-1),"area1_list_","className:item item_focus","className:item");
		area1.stablemoveindex = new Array(-1,"0-1",-1,-1);
		area0.doms[0].domOkEvent = function(){
			window.location.href = "order-monthly.jsp?price=<%=zxprice%>&ppvsj=<%=ppvsj%>&prodname=<%=zxname%>&prodid=<%=zxcode%>&serverid=<%=zxservicecode%>&vodid=<%=sProgId%>&parentvodid=<%=fatherSeriesId%>&url1="+escape(window.location.href)+"&playurl="+escape("<%=playurl%>");
		}
		area0.doms[1].domOkEvent = function(){
			window.location.href = "<%=returnurl%>";
		}
		area1.areaOkEvent = function(){
			window.location.href="order-pay.jsp?isppv=1&price=<%=ppvprice%>&ppvsj=<%=ppvsj%>&prodname=<%=ppvname%>&prodid=<%=ppvcode%>&serverid=<%=ppvservicecode%>&vodid=<%=sProgId%>&parentvodid=<%=fatherSeriesId%>&url1="+escape(window.location.href)+"&playurl="+escape("<%=playurl%>");
		}
		pageobj = new PageObj(0,0,new Array(area0,area1),null);	
		pageobj.backurl = "<%=returnurl%>";
		
	}
</script>
</head>

<body>
	
	<!-- S 左侧海报 -->
    <div class="j-postTitle">福尔摩斯</div>
    <div class="j-postPic"><img src="../images/demopic/j-pic-1.jpg" /></div>
	
	<div class="order-new" style="left:402px; top:172px;">
		<div class="txt txt04" style="font-size:22px;">资&nbsp;&nbsp;费：</div>
		<div class="txt txt05" style="font-size:22px; width:190px;"><%=ppvprice%> 元</div>
		<div class="txt txt04" style="top:80px; font-size:22px;">有效期：</div>
		<div class="txt txt05" style="top:80px; font-size:22px; width:190px;"><%=ppvsj%></div>
	</div>
	
    <div class="btn-c" style="left: 457px; top: 435px;">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area0_list_0">
			<div class="txt">订&nbsp;&nbsp;购</div>
		</div>
		<div class="item" style="left:176px;" id="area0_list_1">
			<div class="txt">返&nbsp;&nbsp;回</div>
		</div>
	</div>
    <!-- E 左侧海报 -->
    
	
    <!-- S 右侧推荐 -->
    <div class="j-recommend">
        <div class="j-recommendTitle">深圳IPTV高清尊享包</div>
        <div class="j-recommendPrice"><%=zxprice%></div>
		
        <div class="btn-c" style="left: 992px; top: 465px;">
			<!--焦点 
					class="item item_focus"
			-->
			<div class="item" id="area1_list_0">
			  <div class="txt">订&nbsp;&nbsp;购</div>
			</div>
		</div>
    </div>
	<!-- E 右侧推荐 -->
	
</body>
</html>
