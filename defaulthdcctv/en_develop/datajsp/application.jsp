<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ include file="application_Ctrl.jsp"%>
<%@ include file="servertimehelp.jsp" %>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<head>
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
</head>

<body>
<div class="main">
	
	<!--logo-->
	<div class="logo"><img src="images/logo.png" /></div>
	<div class="date" id="currDate"></div>
	<!--menu-->
	<div class="menu"> <!--焦点为 class="menuli on"  当前选中为 class="menuli current"-->
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_0"><img src="images/icon_1.png" />首  页</div>
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_1"><img src="images/icon_2.png" />频  道</div>
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_2"><img src="images/icon_3.png" />点  播</div>
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_3"><img src="images/icon_4.png" />回  放</div>
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_4"><img src="images/icon_5.png" />本  地</div>
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli current" id="area0_list_5"><img src="images/icon_6.png" />应  用</div>
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_6"><img src="images/icon_7.png" />套  餐</div>
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_7"><img src="images/icon_8.png" />空  间</div>
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_8"><img src="images/icon_9.png" />搜  索</div>
		<div><img src="images/menu_line.png" /></div>
	</div>
	
	<!--film-->	
	<div class="dibb wid4"> 
		<div align="center" ><img src="images/up.png"  id="pageup"/></div>
		<div class="app_list">
          <div id="app0" class="bgon"><img  id="pic0"  src="images/temp/6.jpg" width="244" height="155"/><div class="f" id="name0"></div></div> 
		  <div id="app1" class="bg"><img  id="pic1"  src="images/temp/6.jpg" width="244" height="155"/><div class="f" id="name1"></div></div> 
		  <div id="app2" class="bg"><img  id="pic2"  src="images/temp/6.jpg" width="244" height="155"/><div class="f" id="name2"></div></div> 
	      <div id="app3" class="bg"><img  id="pic3"  src="images/temp/6.jpg" width="244" height="155"/><div class="f" id="name3"></div></div> 
	      <div id="app4" class="bg"><img  id="pic4"  src="images/temp/6.jpg" width="244" height="155"/><div class="f" id="name4"></div></div> 
		  <div id="app5" class="bg"><img  id="pic5"  src="images/temp/6.jpg" width="244" height="155" /><div class="f" id="name5"></div></div> 
	  
		</div>
		<div align="center" ><img  id="pagedown" src="images/down.png" /></div>
  </div>
	<div class="pages3" id="pageNum"></div>
	<!--bottom_notice-->
	<div class="notice"><marquee direction="left" scrollamount="4"></marquee></div>
   <iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="0" height="0" ></iframe>

</div>
</body>
</html>