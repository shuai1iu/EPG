<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGErrorCode" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ include file="check_subscribedata.jsp"%>
<%@ include file="util_getPosterPaths.jsp"%>
<%@ include file="codepage.jsp"%>
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
	
	String monthname2="";
	String monthsj2="";
    String monthprice2="";
	String monthservicecode2="";
	String monthcode2="";
	
	int columnpvod=0;
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
	}
	
	if(tempmouseList!=null  && tempmouseList.size()>1){
		monthname2=(String)((HashMap)tempmouseList.get(1)).get("PROD_NAME");
		monthsj2=(String)((HashMap)tempmouseList.get(1)).get("EXPIRE_TIME");
		monthservicecode2=(String)((HashMap)tempmouseList.get(1)).get("SERVICE_CODE");
		monthprice2=(String)((HashMap)tempmouseList.get(1)).get("PROD_PRICE");
		monthcode2=(String)((HashMap)tempmouseList.get(1)).get("PROD_CODE");
	}
	
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <meta name="page-view-size" content="1280*720"/>
    <title>整包购买购买页面 EPG</title>
    <link rel="stylesheet" href="../css/style.css">
    <style>
        body {
            background: #034c7e url("../images/j-bg-orderBlue.jpg") no-repeat;
        }
    </style>
    <script type="text/javascript" src="../../js/pagecontrol.js"></script>
	<script type="text/javascript">
		var area0,area1;
		var areaid = 1,indexid = 0;
		window.onload = function(){
			if(<%=isAllowPPV%>==1){
		    	area0=AreaCreator(1,2,new Array(-1,-1,-1,1),"area0_list","className:item item_focus","className:item");
			    area1=AreaCreator(2,1,new Array(-1,0,-1,-1),"area1_list","className:item item_focus","className:item");
			    pageobj = new PageObj(areaid!=null?parseInt(areaid):1,indexid!=null?parseInt(indexid):0, new Array(area0, area1));
			}else{
				var tempdoms=new Array();
				var tempdom=new DomData("area0_list1");
				tempdoms.push(tempdom);
				area0=new Area(1,tempdoms.length,tempdoms,new Array(-1,-1,-1,1));
				var domsfocusstyle=new Array("className:item item_focus");
		        area0.commonfocusstyle=domsfocusstyle;
		        var domsunfocusstyle=new Array("className:item");
		        area0.commonunfocusstyle=domsunfocusstyle;
			    area1=AreaCreator(2,1,new Array(-1,0,-1,-1),"area1_list","className:item item_focus","className:item");
			    pageobj = new PageObj(1,indexid!=null?parseInt(indexid):0, new Array(area0,area1));
			}
			pageobj.backurl ="<%=returnurl%>";
			area0.doms[1].domOkEvent=function(){
				window.location.href="<%=returnurl%>";
			};
			if(<%=isAllowPPV%>==1){
				area0.doms[0].mylink="order-sure.jsp?isppv=1&price=<%=ppvprice%>&prodname=<%=ppvname%>&prodid=<%=ppvcode%>&serverid=<%=ppvservicecode%>&vodid=<%=sProgId%>&parentvodid=<%=fatherSeriesId%>&url1="+escape(window.location.href)+"&playurl="+escape("<%=playurl%>");
			}
            area1.doms[0].mylink="order-sure.jsp?price=<%=monthprice1%>&prodname=<%=monthname1%>&prodid=<%=monthcode1%>&serverid=<%=monthservicecode1%>&vodid=<%=sProgId%>&parentvodid=<%=fatherSeriesId%>&url1="+escape(window.location.href)+"&playurl="+escape("<%=playurl%>");
			<%if("".equals(monthcode2)){%>
				area1.datanum=1;
				$("prod2").style.display="none";
			<%}else{%>
				area1.doms[1].mylink="order-sure.jsp?price=<%=monthprice2%>&prodname=<%=monthname2%>&prodid=<%=monthcode2%>&serverid=<%=monthservicecode2%>&vodid=<%=sProgId%>&parentvodid=<%=fatherSeriesId%>&url1="+escape(window.location.href)+"&playurl="+escape("<%=playurl%>");
			<%}%>
			<% if(isAllowPPV==0){ %>
				$("area0_list0").style.background = "url(../images/lostPPVBuy.png) center top no-repeat";
				$("area0_list0").innerHTML = "";
			<% }%>
			
		}
    </script>
</head>
<body>
<div class="wrapper">
    
    <!-- S 左侧海报 -->
    <div class="j-postTitle" id="vodname"><%=tempvodname%></div>
    <div class="j-postPic" id="vodposter"><img src="<%=picUrl%>"  width="333px" height="441px"/></div>
    <div class="j-postPrice">
	<%
	  if(isAllowPPV==1){ 
	%>
	资费：<%=ppvprice%>元
    <%} else{ %>
       暂不支持单片订购
    <%}%>
    </div>
    <div class="j-postDateTime">
		<%
          if(isAllowPPV==1){ 
        %>
	 有效期：<%=ppvsj.substring(0,10)%>
        <%} else{ %>
           
        <%}%>
    </div>
    <div class="j-btnA" style="left: 423px; top: 432px;">
        <div class="item" id="area0_list0"><div class="txt">订  购</div></div>
    </div>
    <div class="j-btnA" style="left: 599px; top: 432px;">
        <div class="item" id="area0_list1"><div class="txt">返  回</div></div>
    </div>
    <!-- E 左侧海报 -->
    
    <!-- S 右侧推荐 -->
    <div class="j-recommend j-recommendA">
        <div class="j-recommendTitle"><%=monthname1%></div>
        <div class="j-recommendPrice"><%=monthprice1%></div>
        <div class="j-btnA">
            <div class="item" id="area1_list0"><div class="txt">订  购</div></div>
        </div>
    </div>

    <div id="prod2" class="j-recommend j-recommendB">
		<div class="j-bg"></div>
        <div class="txt" style="left:864px; top:446px; color: #b24509; font-size: 38px ; font-weight: bold; text-align:center; width:350px;"><%=monthname2%></div>
        <div class="j-recommendPrice"><%=monthprice2%></div>
        <div class="j-btnA">
            <div class="item" id="area1_list1"><div class="txt">订  购</div></div>
        </div>
    </div>
    <!-- E 右侧推荐 -->


</div>
</body>
