<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%

    String prodname = request.getParameter("prodname")==null?"":request.getParameter("prodname");
	
	
	session.setAttribute("prodname",prodname);   
	
    String prodid = request.getParameter("prodid")==null?"":request.getParameter("prodid");
	
	String parentvodid = request.getParameter("parentvodid")==null?"":request.getParameter("parentvodid");
	String price = request.getParameter("price")==null?"":request.getParameter("price");
    String serverid = request.getParameter("serverid")==null?"":request.getParameter("serverid");
    String vodid = request.getParameter("vodid")==null?"":request.getParameter("vodid");
    String url1 = request.getParameter("url1")==null?"":request.getParameter("url1");
	
	String isurl1 = request.getParameter("isurl1")==null?"0":request.getParameter("isurl1").toString();
	if(isurl1.equals("1")){
		url1=request.getSession().getAttribute("url1")==null?"":request.getSession().getAttribute("url1").toString(); 
	}
	request.getSession().setAttribute("url1",url1);
	String playurl = request.getParameter("playurl")==null?"":request.getParameter("playurl");
    String isppv = request.getParameter("isppv")==null?"0":request.getParameter("isppv");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>二次确定订购页-深圳IP电视高清专区EPG3.0</title>
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
	area0=AreaCreator(1,2,new Array(-1,-1,-1,-1),"area0_list","className:item item_focus","className:item");
	
	pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area0));
	pageobj.backurl = "<%=url1%>"; 
	
    area0.doms[0].domOkEvent=function(){
		if(<%=isppv%>==1){
	       window.location.href="enSureSubscribe.jsp?CONTENTTYPE=0&BUSINESSTYPE=1&PRODUCTCODE=<%=prodid%>&SERVICECODE=<%=serverid%>&VODID=<%=vodid%>&FATHERID=<%=parentvodid%>&playurl="+escape("<%=playurl%>");
		}else{
			window.location.href="enSureSubscribe.jsp?CONTENTTYPE=10&BUSINESSTYPE=1&PRODUCTCODE=<%=prodid%>&SERVICECODE=<%=serverid%>&VODID=<%=vodid%>&FATHERID=<%=parentvodid%>&playurl="+escape("<%=playurl%>");
			
		}
    };
    area0.doms[1].domOkEvent=function(){
	    window.location.href="<%=url1%>";
    };
}
</script>

</head>

<body>
	
<!--order-->	
<div class="order">
	<div class="con-bg">
		<div class="txt txt04">套餐名：</div>
		<div class="txt txt05"><%=prodname%></div>
		<div class="txt txt04" style="top:92px;">资&nbsp;&nbsp;&nbsp;费：</div>
		<div class="txt txt05" style="top:92px;"><%=price%>元/
		<%
		   if(isppv.equals("1")){
		%> 
           部  
        <%
		   }else{
		%>
		   月
		   
		<% }%>
        </div>
	</div>
	
	<div class="line" style="top:311px;"></div>
	
	<div class="btn-a" style="left:315px; top:346px;">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item item_focus" id="area0_list0">
			<div class="txt">付费购买</div>
		</div>
		<div class="item" style="left:200px;" id="area0_list1">
			<div class="txt">返&nbsp;&nbsp;回</div>
		</div>
	</div>
		
	<div class="txt txt03">如需取消包月，请在首页“空间”中按提示操作“取消包月”（“时尚包”和“尊享包”需到营业厅办理） </div>
	
</div>
<!--order the end-->	

	
</body>
</html>
