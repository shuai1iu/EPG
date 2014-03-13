<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
String returnurl = request.getParameter("returnurl") == null ? "index.jsp" : request.getParameter("returnurl");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>特惠包月2-深圳标清首映EPG2.0</title>
<meta name="page-view-size" content="640*530" />
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<link type="text/css" rel="stylesheet" href="../css/style.css" />
</head>

<script type="text/javascript">
var returnurl = "<%=returnurl%>";

window.onload=function(){
  var area0=AreaCreator(1,1,new Array(-1,-1,-1,-1),"area0_list_","className:item item_focus","className:item ");
  area0.areaOkEvent=function(){
	   window.location.href=returnurl;
	  }
      pageobj=new PageObj(0,1,new Array(area0));
         pageobj.goBackEvent=function(){
                 window.location.href=returnurl;
           };
         };
</script>

<body bgcolor="transparent">

<!--pagebg-->
<div class="pagebg">
	<div class="pic"><img src="../images/bg-order03.jpg" width="640" height="530" /></div>
</div>
<!--pagebg the end-->



<div class="wrapper">

	<!--order-->
	<div class="btn-c" style="left:185px;">
		<!--ç¦ç¹ 
				class="item item_focus"
		-->
		<div class="item">已订购</div>
        <div class="item item_focus" id="area0_list_0" style="left:145px;">返&nbsp;回</div>
	</div>
	<!--order the end-->

	
</div>	

</body>
</html>
