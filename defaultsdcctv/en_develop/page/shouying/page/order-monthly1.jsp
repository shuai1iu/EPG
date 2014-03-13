<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
	String tmp_parm = request.getQueryString();	
	String returnUrl = request.getParameter("returnurl") == null ? "HD_index.jsp" : request.getParameter("returnurl");
    String prodname = request.getParameter("prodname")==null?"":request.getParameter("prodname");
	String price = request.getParameter("price")==null?"":request.getParameter("price");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首映包月-深圳标清首映EPG2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/styleorder.css" />
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
	var area0;
	window.onload = function(){
		
		area0 = AreaCreator(1,2,new Array(-1,-1,-1,-1),"area0_list_","className:item item_focus","className:item");
		area0.doms[0].domOkEvent = function(){
			   window.location.href="enSureSubscribe1.jsp?<%=tmp_parm%>";
			   }
		area0.doms[1].domOkEvent = function(){
			window.location.href="<%=returnUrl%>";
		}
		pageobj = new PageObj(0,0,new Array(area0),null);	
		pageobj.backurl = "<%=returnUrl%>"; 
	}
</script>
</head>

<body bgcolor="transparent">

<!--pagebg-->
<div class="pagebg">
	<div class="pic"><img src="../images/bg-order02.jpg" width="640" height="530" /></div>
</div>
<!--pagebg the end-->



<div class="wrapper">

	<!--order-->
	<div class="order-form form02">
		<div class="txt txt01" style="color:#53636f;">套餐名</div>
		<div class="txt txt02" style="color:#fff; font-size:25px;left:155px;"><%=prodname%></div>
		
		<div class="txt txt01" style="top:56px;">资&nbsp;&nbsp;费</div>
		<div class="txt txt02" style="top:56px; left:155px;"><span><%=price%></span>&nbsp;元 / 月</div>
		
		<div class="btn-b">
			<!--焦点 
					class="item item_focus"
			-->
			<div class="item" id="area0_list_0">付费购买</div>
			<div class="item" style="left:136px;" id="area0_list_1">返  &nbsp; 回</div>
		</div>
		
	</div>
	<!--order the end-->
	
	
	<!--prompt-->
	<div class="prompt">
		<div class="pic"><img src="../images/line2.png" /></div>
		<div class="icon"><img src="../images/icon-i.png" /></div>
		<div class="txt">如需取消包月，请在首页 - 我的空间 - 取消订购中按照提示操作“取消包月”。</div>
	</div>
	<!--prompt the end-->
	
</div>	

</body>
</html>
