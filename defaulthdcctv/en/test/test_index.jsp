
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="../datajsp/util_AdText.jsp"%>
<%@ include file="../util/save_focus.jsp"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style>
.topicPage {
		font-size:28px;
		position:absolute; 
		text-align:center;
		z-index:11;
}
.testturnpage { position:absolute;  }
.testturnpage div.on{background:url(images/test_page_on.png) no-repeat;z-index:11 }
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<title>推荐位</title>
<%@ include file="test_index_ctrl.jsp"%>
</head>
<body>

<div class="main">

<div class="simtitle"> 
	<div class="simtitle" id="area4_title_0" style="left:-120px;"><img src="images/simtitle_1.png" /></div>
        <div class="simtitle" id="area4_title_1" style="left:70px;"><img src="images/simtitle_2.png" /></div>
        <div class="simtitle" id="area4_title_2" style="left:260px;"><img src="images/simtitle_3.png" /></div>
        <div class="simtitle" id="area4_title_3" style="left:450px;"><img src="images/simtitle_4.png" /></div>
        <div class="simtitle" id="area4_title_4" style="left:650px;"><img src="../images/simtitle_5.png" /></div>
</div>
<div style = "left:50px;top:100px;position:absolute">节目名称</div>

<div class="menu3test" align="center" >
    <div> <img src="images/menu_line.png" /></div>
    <div class="menulitest" id="cate_0"></div>
    <div  id="menu0"> <img src="images/menu_line.png"  /></div>
    <div class="menulitest" id="cate_1"></div>
    <div  id="menu1"> <img src="images/menu_line.png" /></div>
    <div class="menulitest" id="cate_2"></div>
    <div  id="menu2"> <img src="images/menu_line.png"  /></div>
    <div class="menulitest" id="cate_3"></div>
    <div  id="menu3"> <img src="images/menu_line.png" /></div>
    <div class="menulitest" id="cate_4"></div>
    <div  id="menu4"> <img src="images/menu_line.png" /></div>
    <div class="menulitest" id="cate_5"></div>
    <div  id="menu5"> <img src="images/menu_line.png" /></div>
    <div class="menulitest" id="cate_6"></div>
    <div  id="menu6"> <img src="images/menu_line.png" /></div>
    <div class="menulitest" id="cate_7"></div>
    <div  id="menu7"> <img src="images/menu_line.png" /></div>
    <div class="menulitest" id="cate_8"></div>
    <div id="menu8"> <img src="images/menu_line.png"  /></div>
</div>

<div  class="menutest" align="center" style="left: 500px"> 
    <div  class="menutest" id="image_0" style="top:168px"><img src="images/test_image.png" /></div>
    <div class="menutest" id="image_1" style="top:223px"> <img src="images/test_image.png" /></div>
    <div class="menutest" id="image_2" style="top:278px"> <img src="images/test_image.png" /></div>
     <div class="menutest" id="image_3" style="top:333px"> <img src="images/test_image.png" /></div>
     <div class="menutest" id="image_4" style="top:388px"> <img src="images/test_image.png" /></div>
     <div class="menutest" id="image_5" style="top:444px"> <img src="images/test_image.png" /></div>
     <div class="menutest" id="image_6" style="top:499px"> <img src="images/test_image.png" /></div>
     <div class="menutest" id="image_7" style="top:554px"> <img src="images/test_image.png" /></div>
     <div class="menutest" id="image_8" style="top:609px"><img src="images/test_image.png" /></div>
</div>
					  




  <div class="menu3test" align="center" style="left:651px">
       	 <div>
    <img src="images/menu_line.png" /></div>
            <div class="menulitest" id="cate1_0">
          </div>
              <div  id="menu9">
                <img src="images/menu_line.png" /></div>
            <div class="menulitest" id="cate1_1">
          </div>
            <div  id="menu10">
                <img src="images/menu_line.png" />
	    </div>
             <div class="menulitest" id="cate1_2">
          </div>
            <div  id="menu11">
                <img src="images/menu_line.png" /></div>
            <div class="menulitest" id="cate1_3">
          </div>
            <div  id="menu12">
                <img src="images/menu_line.png" /></div>
            <div class="menulitest" id="cate1_4">
          </div>
            <div  id="menu13">
                <img src="images/menu_line.png" /></div>
            <div class="menulitest" id="cate1_5">
          </div>
            <div  id="menu14">
                <img src="images/menu_line.png" /></div>
            <div class="menulitest" id="cate1_6">
          </div>
            <div  id="menu15">
                <img src="images/menu_line.png" /></div>
            <div class="menulitest" id="cate1_7">
          </div>
            <div  id="menu16">
                <img src="images/menu_line.png" /></div>
            <div class="menulitest" id="cate1_8">
          </div>
            <div id="menu17">
                <img src="images/menu_line.png"  /></div>
  </div>
        

<div  class="menutest" align="center" style="left: 1098px;">
    <div class="menutest" id="image1_0" style="top:168px"> <img src="images/test_image.png" /></div>
    <div class="menutest" id="image1_1" style="top:223px"> <img src="images/test_image.png" /></div>
    <div class="menutest" id="image1_2" style="top:278px"> <img src="images/test_image.png" /></div>
    <div class="menutest" id="image1_3" style="top:333px"> <img src="images/test_image.png" /></div>
    <div class="menutest" id="image1_4" style="top:388px"> <img src="images/test_image.png" /></div>
    <div class="menutest" id="image1_5" style="top:444px"> <img src="images/test_image.png" /></div>
    <div class="menutest" id="image1_6" style="top:499px"> <img src="images/test_image.png" /></div>
    <div class="menutest" id="image1_7" style="top:554px"> <img src="images/test_image.png" /></div>
    <div class="menutest" id="image1_8" style="top:609px"><img src="images/test_image.png" /></div>
</div>
								     




  <!--bottom_notice-->
<div>
	<iframe name="hidden_frame" id="hidden_frame" style="display: none" width="0" height="0">
	    </iframe>

	<div class="topicPage" style="left:600px; top:670px;" id="page"></div>
	<div class="testturnpage">
	     <div class="testturnpage" id = "turnpage_0" style = "left:457px;top:665px"><img src = images/test_last_page.png></div>
	     <div class="testturnpage" id = "turnpage_1" style = "left:672px;top:665px"><img src = images/test_next_page.png></div>
	</div>

	<div style="visibility:hidden; z-index:-1">
        
      <img src="images/menu_bgon.png"/>
      </div>
</div>
<%@ include file="../servertimehelp.jsp" %>

</body>
</html>
