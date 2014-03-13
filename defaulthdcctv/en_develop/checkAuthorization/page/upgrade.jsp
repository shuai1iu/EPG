4<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGErrorCode" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.net.URLEncoder"%>
<%@ include file="codepage.jsp"%>
<%
    MetaData metadata = new MetaData(request);
    ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
	ServiceHelp  shelp=new ServiceHelp(request); 
	HashMap mediadetailInfo = (HashMap)metadata.getVodDetailInfo(ssvod);
	//新参数用于区分来自半价特惠包订购还是正常订购页
	String url1=request.getRequestURL().toString();
	String urlquerystr=request.getQueryString().toString();
	if(urlquerystr!=null && !urlquerystr.equals("")){
		url1=url1+"?"+urlquerystr;
	}
	request.getSession().setAttribute("url1",url1); 
	int contenttype = 0;
    if(null != mediadetailInfo){
           contenttype = Integer.parseInt(mediadetailInfo.get("CONTENTTYPE").toString());
    }
    else{
           contenttype=1;
    }
	String typesId = request.getParameter("SUBJECTID")==null?"-1":request.getParameter("SUBJECTID");
	
	
	int sProgId = Integer.parseInt(request.getParameter("VODID")); 
	String fatherSeriesId = request.getParameter("FATHERID")==null?"-2":"null".equals(request.getParameter("FATHERID"))?"-2":"-1".equals(request.getParameter("FATHERID"))?"-2":request.getParameter("FATHERID");    
	String returnurl=request.getParameter("returnurl")==null?"../../../../index.jsp":request.getParameter("returnurl");
	String playurl=request.getParameter("playurl")==null?"":request.getParameter("playurl");
	String areaid=request.getParameter("areaid")==null?"0":request.getParameter("areaid");
	String indexid=request.getParameter("indexid")==null?"0":request.getParameter("indexid");

	
	
	
	int sFatherSeriesId = Integer.parseInt(fatherSeriesId);
    // 播放类型  内容类型 业务类型  
    int sPlayType = Integer.parseInt(request.getParameter("PLAYTYPE"));
    int sContentType = Integer.parseInt(request.getParameter("CONTENTTYPE"));
    int sBusinessType = Integer.parseInt(request.getParameter("BUSINESSTYPE"));
	
	
	Map retMap = null;
	
	ArrayList pArray= shelp.getMonthSuites(0);
	int zxvod=1848049;
	int ssvod=1893157;
	String zxprodid="";
	String zxproname="";
	String zxservercode="";
	String zxprice="";
	
	String ssprodid="";
	String ssservercode="";
	String ssproname="";
	String ssprice="";
	
	boolean checkresult=true;
	retMap = serviceHelpHWCTC.authorizationHWCTC(ssvod,1, contenttype,1,"",ssvod);
	int retCode = EPGErrorCode.AUTHORIZATION_DATABASEERROR;   //初始化为数据库异常，防止出现空值
	if(null != retMap && null != retMap.get(EPGConstants.KEY_RETCODE))
	{
		retCode = ((Integer)retMap.get(EPGConstants.KEY_RETCODE)).intValue();
	}
	//授权通过
	if(retCode == EPGErrorCode.SUCCESS)
	{
		checkresult=true;
		
		
		
		
		
		
	}else{
	    checkresult=false;
		HashMap zxresultMap = new HashMap();
		HashMap zxmediadetailInfo = (HashMap)metadata.getVodDetailInfo(zxvod);
		int zxcontenttype= 0;
		if(null != zxmediadetailInfo){
           zxcontenttype = Integer.parseInt(zxmediadetailInfo.get("CONTENTTYPE").toString());
		}
		else{
	       zxcontenttype=1;
		}
		
	    zxresultMap = serviceHelpHWCTC.authorizationHWCTC(zxvod,1, zxcontenttype,1,"",zxvod);
		int zxretCode = EPGErrorCode.AUTHORIZATION_DATABASEERROR;   //初始化为数据库异常，防止出现空值
		ArrayList zxmouseList = new ArrayList();
		if(null != zxresultMap && null != zxresultMap.get(EPGConstants.KEY_RETCODE))
		{
		   zxretCode = ((Integer)zxresultMap.get(EPGConstants.KEY_RETCODE)).intValue();
		}
	    if(zxretCode == 504){
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
				  
		}
		
		
		
		HashMap ssresultMap = new HashMap();
		HashMap ssmediadetailInfo = (HashMap)metadata.getVodDetailInfo(ssvod);
		int sscontenttype=0;
		if(null != ssmediadetailInfo){
           sscontenttype = Integer.parseInt(ssmediadetailInfo.get("CONTENTTYPE").toString());
		}
		else{
	       sscontenttype=1;
		}
		
	    ssresultMap = serviceHelpHWCTC.authorizationHWCTC(ssvod,1, sscontenttype,1,"",ssvod);
		int ssretCode = EPGErrorCode.AUTHORIZATION_DATABASEERROR;   //初始化为数据库异常，防止出现空值
		ArrayList ssmouseList = new ArrayList();
		if(null != ssresultMap && null != ssresultMap.get(EPGConstants.KEY_RETCODE))
		{
		   ssretCode = ((Integer)ssresultMap.get(EPGConstants.KEY_RETCODE)).intValue();
		}
	    if(ssretCode == 504){
			       ssmouseList = (ArrayList) ssresultMap.get("MONTH_LIST");
				   if(ssmouseList!=null && ssmouseList.size()>0){
			           ssprodid = (String) ((HashMap)ssmouseList.get(0)).get("PROD_CODE");
				       ssproname = (String) ((HashMap)ssmouseList.get(0)).get("PROD_NAME");
				       ssservercode = (String) ((HashMap)ssmouseList.get(0)).get("SERVICE_CODE");
				       ssprice = (String) ((HashMap)ssmouseList.get(0)).get("PROD_PRICE");
					   if(ssprice == null || "".equals(ssprice))
					   {
								ssprice = "0";
					   }
				       ssprice=(Integer.parseInt(ssprice)/100)+"";
				   }
				  
		}
		
		
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>标清用户升级为高清用户-深圳IP电视高清专区EPG3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<style type="text/css">
<!--
	body{ background:url(../images/bg03.jpg) no-repeat;}
-->
</style>


<script type="text/javascript" src="../../../js/pagecontrol.js"></script>
<script type="text/javascript">
var area0,area1;
var areaid = 0,indexid = 0;
window.onload = function(){
	area0=AreaCreator(2,1,new Array(-1,-1,1,-1),"area0_list","className:item item_focus","className:item");
	area1=AreaCreator(1,2,new Array(0,-1,-1,-1),"area1_list","className:item item_focus","className:item");
	pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area0, area1));
	pageobj.backurl ="<%=returnurl%>";
	
   area0.doms[0].domOkEvent=function(){
	   window.location.href="order-sure.jsp?price=<%=ssprice%>&prodname=<%=ssproname%>&prodid=<%=ssprodid%>&serverid=<%=ssservercode%>&vodid=<%=ssvod%>&parentvodid=<%=ssvod%>&isurl1=1&playurl="+escape("<%=returnurl%>");
   };
  area0.doms[1].domOkEvent=function(){
	   window.location.href="order-sure.jsp?price=<%=zxprice%>&prodname=<%=zxproname%>&prodid=<%=zxprodid%>&serverid=<%=zxservercode%>&vodid=<%=zxvod%>&parentvodid=<%=zxvod%>&isurl1=1&playurl="+escape("<%=playurl%>");
   };
   
   area1.doms[1].domOkEvent=function(){
	   window.location.href="<%=returnurl%>";
   };
   
   //测试链接
   area1.doms[0].domOkEvent=function(){
	   window.location.href="../../../../HD_experience.jsp?returnurl="+escape(window.location.href);
   };
}
</script>

</head>

<body>
	
<!--order-->	
<div class="order">
	<div class="txt txt01">尊敬的用户：</div>
	<div class="txt txt01" style="top:36px; text-indent:2em;">您目前非高清用户，购买该高清产品需先订购以下任一产品升级为高清用户，谢谢！</div>
	
	<div class="module">
		<div class="txt"><%=ssproname%> <%=ssprice%>元/月</div>
		<div class="btn-a">
			<!--焦点 
				class="item item_focus"
			-->
			<div class="item item_focus" id="area0_list0">
				<div class="link"></div>
				<div class="txt txt-a">订&nbsp;&nbsp;购</div>
			</div>
		</div>
	</div>
	<div class="txt txt02">包含深圳卫视等10路以上高清频道+2小时时移+7天回看+丰富高清节目点播</div>
	<div class="line"></div>
	
	<div class="module" style="top:284px;">
		<div class="txt"><%=zxproname%> <%=zxprice%>元/月</div>
		<div class="btn-a">
			<!--焦点 
				class="item item_focus"
			-->
			<div class="item" id="area0_list1">
				<div class="txt">订&nbsp;&nbsp;购</div>
			</div>
		</div>
	</div>
	<div class="txt txt02" style="top:379px">包含时尚包所有内容+每周持续更新最热、最新的高品质节目（大片、热剧、纪实、娱乐）</div>
	<div class="line" style="top:416px;"></div>
	
	<div class="txt txt03" style="width:620px;">建议在测试节目播放后进行订购</div>
	
	<div class="btn-a" style="left:640px; top:426px;">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area1_list0">
			<div class="txt">测&nbsp;&nbsp;试</div>
		</div>
		<div class="pic" style="left:155px; top:5px;"><img src="../images/line4.png" /></div>
		<div class="item" style="left:171px;" id="area1_list1">
			<div class="txt">返&nbsp;&nbsp;回</div>
		</div>
	</div>
	
</div>
<!--order the end-->	

	
</body>
</html>
