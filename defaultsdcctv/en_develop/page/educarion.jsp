<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../../defaultgdsd/en/page/datajsp/util_AdText.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link type="text/css" href="../../../defaultgdsd/en/css/common.css" rel="stylesheet" />
<link type="text/css" href="../../../defaultgdsd/en/css/content.css" rel="stylesheet" />
<%@ include file="app_control.jsp"%>
</head>

<body  onLoad="loadBody();">
<!--head-->
	<div class="logo">应用</div>
	<div class="date" id="currDate" style="left:340px; width:290px"></div>
	<div class="line"><img src="../../../defaultgdsd/en/images/line.png" width="100%" /></div>
<!--the end-->

<!--list-->
	<div class="app_list" style="top:78px; left:27px;">  
<!-- 焦点为 class="on" 默认为 class="bg"-->
        <div class="bg" id="area0_list_0">
          <div class="pic"><img id="area0_img_0" src="#" width="173" height="112" /></div>
          <div class="name" id="area0_txt_0" style="border-top:10px;"></div>
        </div>
        <div class="bg" id="area0_list_1" style="left:197px;">
          <div class="pic"><img id="area0_img_1" src="#" width="173" height="112" /></div>
          <div class="name" id="area0_txt_1" style="border-top:10px"></div>
        </div>
        <div class="bg" id="area0_list_2" style="left:394px;">
          <div class="pic"><img id="area0_img_2" src="#" width="173" height="112" /></div>
          <div class="name" id="area0_txt_2" style="border-top:10px"></div>
        </div>
        <div class="bg" id="area0_list_3" style="top:188px;">
          <div class="pic"><img id="area0_img_3" src="#" width="173" height="112" /></div>
          <div class="name" id="area0_txt_3" style="border-top:10px"></div>
        </div>
        <div class="bg" id="area0_list_4" style="left:197px;top:188px">
          <div class="pic"><img id="area0_img_4" src="#" width="173" height="112" /></div>
          <div class="name" id="area0_txt_4" style="border-top:10px"></div>
        </div>
        <div class="bg" id="area0_list_5" style="left:394px;top:188px">
          <div class="pic"><img id="area0_img_5" src="#" width="173" height="112" /></div>
          <div class="name" id="area0_txt_5" style="border-top:10px"></div>
        </div>
	 </div>
	
	<div class="page" id="pageArea" style="top:435px; left:313px;">1/1</div>	
<!--the end-->

<!--footer-->
    <div class="line" style="top:467px"><img src="../../../defaultgdsd/en/images/line.png" width="100%" /></div>
	<div class="direction">	
		<div style="left:43px;"><img src="../../../defaultgdsd/en/images/iconb03.png" /></div>	
		<div style=" top:5px;left:95px;">选择频道</div>
		<div style=" top:5px;left:222px;"><img src="../../../defaultgdsd/en/images/btn-page.png" /></div>	
		<div style=" top:5px;left:325px;">翻页</div>
	</div>
<!--the end-->	
<%@ include file="servertimehelp.jsp" %>
</body>
</html>
