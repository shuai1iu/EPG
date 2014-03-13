<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
 String returnUrl = request.getParameter("returnUrl") == null ? "HD_index.jsp" : request.getParameter("returnUrl");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>特惠包月1-深圳首映专区高清 EPG3.0</title>
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
  var area0=AreaCreator(1,1,new Array(-1,-1,-1,-1),"area0_list_","className:item item_focus","className:item ");
  area0.areaOkEvent=function(){
	  window.location.href=returnUrl;
	  }
      pageobj=new PageObj(0,0,new Array(area0));
         pageobj.goBackEvent=function(){
                 window.location.href=returnUrl;
           };
         };
</script>

<!--
	body{ background:url(../images/bg-order03.jpg) no-repeat;}
-->


<body>
	
    	<!--order-->
	<div class="btn-d" style="left:475px;">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item">
			<div class="txt">已订购</div>
		</div>
		<div id="area0_list_0" class="item item_focus" style="left:188px;">
			<div class="txt">返&nbsp;回</div>
		</div>
	</div>
	<!--order the end-->
	
	
</body>
</html>
