<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="datajsp/util_AdText.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="page-view-size" content="640*530" />
<title></title>
<link type="text/css" href="../../../defaultgdsd/en/css/common.css" rel="stylesheet" />
<link type="text/css" href="../../../defaultgdsd/en/css/content.css" rel="stylesheet" />
<style>
.edu_list {	
	left:60px; 
	position:absolute; 
	top:129px;
}
.edu_list div { 
	height:179px;
	left:0px;
	position:absolute; 
	top:6px; 	 
	width:223px;
}
.edu_list div.bg{background:url(../images/edu-bg.png) no-repeat;}
.edu_list div.on{background:url(../images/edu-bgon.png) no-repeat;}
	.edu_list div .pic{
		 height:112px; 
		 left:12px;
		 position:absolute;
		 top:12px;
		 width:173px;
  }
.edu_list div.name{
 		 background-color:#2e2d30;
         height:43px; 
		 left:12px;
		 position:absolute;
		 top:124px;
		 width:173px;}
		 
</style>
<%@ include file="education_control.jsp"%>
</head>

<body  style="background:url(../images/jymh.png); background-repeat:no-repeat; background-color:transparent;" onLoad="loadBody();">
<!--head-->
	<div class="date" id="currDate" style="left:335px; width:290px"></div>

<!--the end-->

<!--list-->
	<div class="edu_list" style="top:112px; left:0px;">  
<!-- 焦点为 class="on" 默认为 class="bg"-->
        <div class="bg" id="area0_list_0" style="left:-1px;">
          <div class="pic"><img id="area0_img_0" src="#" width="201" height="135" /></div>
        </div>
        <div class="bg" id="area0_list_1" style="left:209px;">
          <div class="pic"><img id="area0_img_1" src="#" width="201" height="135" /></div>
        </div>
        <div class="bg" id="area0_list_2" style="left:418px;">
          <div class="pic"><img id="area0_img_2" src="#" width="201" height="135" /></div>
        </div>
        <div class="bg" id="area0_list_3" style="top:155px;">
          <div class="pic"><img id="area0_img_3" src="#" width="201" height="135" /></div>
        </div>
        <div class="bg" id="area0_list_4" style="left:209px;top:155px;">
          <div class="pic"><img id="area0_img_4" src="#" width="201" height="135" /></div>
        </div>
        <div class="bg" id="area0_list_5" style="left:418px;top:155px;">
          <div class="pic"><img id="area0_img_5" src="#" width="201" height="135" /></div>
        </div>
	 </div>
	
	<div class="page" id="pageArea" style="top:435px; left:313px;">1/1</div>	
<!--the end-->

<!--footer-->

<!--the end-->	
<%@ include file="servertimehelp.jsp" %>
</body>
</html>
