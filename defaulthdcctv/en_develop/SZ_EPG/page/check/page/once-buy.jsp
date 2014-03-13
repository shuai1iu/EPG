<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.DataOutputStream"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%      
      UserProfile profile = new UserProfile(request);
	  String  UserID = profile.getUserId();
	  String  UserToken=profile.getUserToken();
	 
      String typesId = request.getParameter("SUBJECTID")==null?"-1":request.getParameter("SUBJECTID");
	  //要播放影片的id
	  int sProgId = Integer.parseInt(request.getParameter("VODID")==null?"1":request.getParameter("VODID")); 
	  //电视剧父集ID
	  String fatherSeriesId = request.getParameter("FATHERID")==null?"-2":"null".equals(request.getParameter("FATHERID"))?"-2":"-1".equals(request.getParameter("FATHERID"))?"-2":request.getParameter("FATHERID");
	  int sFatherSeriesId = Integer.parseInt(fatherSeriesId);
	  // 播放类型  内容类型 业务类型  
	  int sPlayType = Integer.parseInt(request.getParameter("PLAYTYPE")==null?"1":request.getParameter("PLAYTYPE"));
	  int sContentType = Integer.parseInt(request.getParameter("CONTENTTYPE")==null?"1":request.getParameter("CONTENTTYPE"));
	  int sBusinessType = Integer.parseInt(request.getParameter("BUSINESSTYPE")==null?"1":request.getParameter("BUSINESSTYPE"));
	  String returnurl=request.getParameter("returnurl")==null?"":request.getParameter("returnurl");
	  String playurl=request.getParameter("playurl")==null?"":request.getParameter("playurl");
	
      String path = request.getContextPath();
	  String localIp= request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/jsp/defaulthdcctv/en_develop/";

	  
       String QUERYGET_URL="http://14.29.1.46:8080/ACS/vas/queryOrderedPackage";
	  
       String orderurl="http://14.29.1.46:8080/ACS/vas/serviceorder?SPID=&UserID="+UserID+"&ProductID=510&UserToken="+UserToken+"&Action=3&OrderMode=1&ContinueType=1";
	   
	   String jumporderurl=localIp + "SZ_EPG/page/check/page/buy_discount.jsp";
       String testurl=localIp + "HD_experience.jsp";

       String Result=request.getParameter("Result")==null?"":request.getParameter("Result");
	   if(playurl.indexOf("http:")==-1)
	   {
	     playurl=localIp+playurl;
	   }
	   
	   URL postUrl=new URL(QUERYGET_URL);
	   HttpURLConnection connection=(HttpURLConnection)postUrl.openConnection();
	   connection.setDoInput(true);
	   connection.setDoOutput(true);
	   connection.setConnectTimeout(5000);  
	   connection.setRequestMethod("POST");
	   connection.setUseCaches(false);
	   connection.setInstanceFollowRedirects(true);
	   connection.connect();
	   DataOutputStream outdata=new DataOutputStream(connection.getOutputStream());
	   String requestXml="{userToken:'" +UserToken +"',userId:'"+ UserID + "',spId:''}";

	   outdata.writeBytes(requestXml); 
	   outdata.flush();
       outdata.close(); // flush and close
       BufferedReader reader = new BufferedReader(new InputStreamReader(
               connection.getInputStream()));
        StringBuilder sb=new StringBuilder();
		 String lines="";
		 while((lines=reader.readLine())!=null){
			 sb.append(lines);
			 
		 }
		 reader.close();
		 connection.disconnect();
		
	   String queryresult=sb.toString();
           int isorder=0;
	   String packageid="";
          
	   if(queryresult.indexOf("\"packageId\":\"510\"")!=-1){
		 System.out.println("wangss100:"+playurl);
		 response.sendRedirect(playurl);
		 return;
	   }

      if(Result.equals("0")){
		 System.out.println("wangss100:"+playurl);
          response.sendRedirect(playurl);
		   return;
	  }
	  
	  
	   if(Result.equals("1")){
		System.out.println("wangss100:"+returnurl);
          response.sendRedirect(returnurl);
		   return;
	  }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>一次购买页面(新版本5)-深圳IP电视高清专区EPG3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/style2.css" />
<style type="text/css">
<!--
	body{ background:url(../images/bg02.jpg) no-repeat;}
-->
</style>
</head>
<script type="text/javascript" src="../../../js/pagecontrol.js"></script>
<script type="text/javascript">

var area0,area1;
var areaid=0;
var indexid=0;
window.onload = function(){
	       
			area0 = AreaCreator(1,3,new Array(-1,-1,1,-1),"area0_list_","className:item item_focus","className:item");
	    	area1 = AreaCreator(1,1,new Array(0,-1,-1,-1),"area1_list_","className:item item_focus","className:item");
			area0.doms[0].domOkEvent=function(){
			    var strUrl = window.location.href;
				var strUrl1 = strUrl.substring(0,strUrl.indexOf("?")+1);
				var strUrl3 = strUrl1+"playurl="+escape("<%=playurl%>")+"&returnurl="+escape("<%=returnurl%>");
				window.location.href = "<%=orderurl%>"+"&ReturnURL="+escape(strUrl3);
                
            }
			
			area0.doms[1].domOkEvent=function(){
				window.location.href = "<%=returnurl%>";
			}
			area0.doms[2].domOkEvent=function(){
			window.location.href = "<%=jumporderurl%>?SUBJECTID=<%=typesId%>&VODID=<%=sProgId%>&FATHERID=<%=sFatherSeriesId%>&PLAYTYPE=<%=sPlayType%>&CONTENTTYPE=<%=sContentType%>&BUSINESSTYPE=<%=sBusinessType%>&returnurl="+escape(window.location.href)+"&playurl="+escape("<%=playurl%>");
			}
			area1.doms[0].domOkEvent=function(){
				window.location.href = "<%=testurl%>?returnurl="+escape(window.location.href);
			}
			pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area0,area1));
		    pageobj.backurl ="<%=returnurl%>";
		} 
</script>

<body>

<!--head-->
<div class="logo">
	<div class="pic"><img src="../images/logo.png" /></div>
	<div class="txt txt-b">高清尊享包&nbsp;<span>订购</span></div>
</div>

<div class="adfont"><img src="../images/adfont.png" /></div>
<!--head the end-->	
	

	
<!--once-buy-->	
<div class="once-buy">
	<div class="pic"><img src="../images/ad-1280X403.jpg" /></div>
	
	<div class="btn-b">
		<!--焦点 
			class="item item_focus"
		-->
		<div class="item" id="area0_list_0">
			<div class="txt">立即订购</div>
		</div>
		<div class="item" style="left:170px;" id="area0_list_1">
			<div class="txt" >返&nbsp;&nbsp;回</div>
		</div>
		<div class="item" style="left:340px;" id="area0_list_2">
			<div class="txt"  style="font-size:20px;">原价订购子包</div>
		</div>
	</div>
	
	<div class="txt" style="top:418px;"><img src="../images/buy-font.png" /></div>
	<div class="pic" style="left:34px; top:530px;"><img src="../images/buy-bottom.jpg" /></div>
	<div class="btn-b" style="left:911px; top:539px;">
		<!--焦点 
			class="item item_focus"
		-->
		
		<div class="item" style="left:170px;" id="area1_list_0">
			<div class="txt">测&nbsp;&nbsp;试</div>
		</div>
	</div>
	
</div>
<!--once-buy the end-->		
	 	
	
</body>
</html>
