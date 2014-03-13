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
<title>院线包月二次确定页面-深圳首映专区高清EPG3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="css/style.css" />
<style type="text/css">
<!--
	body{ background:url(images/bg-order01.jpg) no-repeat;}
	
-->
</style>

<script type="text/javascript" src="js/pagecontrol.js"></script>
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

<body>
	
<!--order-->	
<div class="order-new">
	<div class="con-bg">
		<div class="txt txt04">套餐名：</div>
		<div class="txt txt05"><%=prodname%></div>
		<div class="txt txt04" style="top:92px;">资&nbsp;&nbsp;费：</div>
		<div class="txt txt05" style="top:92px;"><%=price%> 元/月</div>
	</div>
	
	<div class="line" style="top:311px;"></div>
	
	<div class="btn-c">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area0_list_0">
			<div class="txt">付费购买</div>
		</div>
		<div class="item" style="left:200px;" id="area0_list_1">
			<div class="txt">返&nbsp;&nbsp;回</div>
		</div>
	</div>
		
	<div class="txt txt03">如需取消包月，请在首页“空间”中按提示操作“取消包月”（“时尚包”和“尊享包”需到营业厅办理）</div>
	
</div>
<!--order the end-->	

	
</body>
</html>