<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%
  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <meta name="page-view-size" content="1280*720"/>
    <title>订购成功提示 EPG</title>
    <link rel="stylesheet" href="../css/style1.css">
    <style>
        body {
            background: #b8b9bd url("../images/j-bg-orderWhite.jpg") no-repeat;
        }
    </style>
    <script type="text/javascript" src="../../../js/pagecontrol.js"></script>
	<script type="text/javascript">
	   var area0;
	   var areaid = 0,indexid = 0;
	   window.onload = function(){
		   var areaid = 0,indexid = 0;
		   area0=AreaCreator(1,1,new Array(-1,-1,-1,-1),"area0_list","className:item item_focus","className:item");
		   pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area0));
		   pageobj.backurl ="../../index.jsp";
		   area0.doms[0].domOkEvent=function(){
	            window.location.href="../../index.jsp";
           };
	   }
	
	
	</script>
</head>
<body>
<div class="wrapper">
    
    <!-- S 页面头部 -->
    <div class="j-logoPageTitle">高清尊享包 <span class="f">订购</span></div>
    <!-- E 页面头部 -->

    <!-- S 页面内容 -->
    <div class="j-tipsBox">
        <div class="j-title">尊敬的用户：</div>
        <div class="j-cont">您已订购本套餐，无需重新订购，谢谢!</div>
        <div class="j-cornerTxt"><img src="..//images/j-tipsBox-cornerTxt-2.png" alt="高清尊享包"/></div>
        <div class="j-effectLight"><img src="../images/j-tipsBox-light.png" /></div>

        <div class="j-btn-back" style="left: 727px; top:279px;">
            <div class="item item_focus" id="area0_list0"></div>
        </div>
    </div>
    <!-- E 页面内容 -->
</div>
</body>
