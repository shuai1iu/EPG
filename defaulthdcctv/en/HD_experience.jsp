
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page language="java" import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="config/config_TrailerInVas.jsp"%>
<%@ include file="OneKeyPlay.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>
<%@ include file="HD_experience_ctrl.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>高清体验区</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />



<style>
body { background:url(images/mainbg.jpg) no-repeat;}

.exp_title {
	position:absolute;
	left:58px;
	top:20px;
	width:209px;
	height:33px;
	font-size:40px;
}

.exp_title1 {
	position:absolute;
	left:92px;
	top:91px;
	width:273px;
	height:32px;
}

.exp_title2 {
	position:absolute;
	left:93px;
	top:227px;
	width:272px;
	height:32px;
}



.exp_img{
        position:absolute;
        left:62px;
        top:274px;

}

.name{
position:absolute;
        top:149px;
	left:14px;
        width:258px;
        height:31px;
        z-index:10;
	text-align:center;
	font-size: 24px;
}

.name{
background:url(images/img_name.png) no-repeat;
	   z-index:9;
}

.exp_img .exp_on
{background:url(images/experience_on.png) no-repeat;}

.exp_img .item
{
        position:absolute;
        width:286px;
        height:194px;
}


.exp_img .item .pic
{
        left:14px;
        position:absolute;
        top:14px;
        z-index:4;
}


.exp_img .item .pic,
.exp_img .item .pic img
{
         width:258px 
         height:166px
}


.exp_img .item_focus
{background:url(images/experience_on.png) no-repeat}




.bottom {
	position: absolute;
	left: 30px;
	top: 672px;
	width: 600px;
	height: 30px;
	background-image: url(../images/bottombg.png);
}

.top{
        position:absolute;
        left:50px;
        top:79px;
	width:335px;
	heigth:55px;
}




.top .channel_focus
{
background:url(images/menu_bgfocuson.png) no-repeat;
}

-->
</style>

</head>
<body>
	
	<div class="main" style="left:20px;top:80px"><img src="images/HD_line.png"/></div>
    <div class="main" style="left:20px;top:220px"><img src="images/HD_line.png"/></div>


    <div class="date" id="currDate"></div>                   
    <div class="top">
	    <div class="top" id="channel_0">深圳卫视高清</div>  
        <div class="top" style="left:405px;" id="channel_1">深圳体育高清</div>		
<!----
	    <div class="top" id="channel_0">CCTV-1高清</div>   
        <div class="top" style="left:405px;" id="channel_1">深圳卫视高清</div>
	    <div class="top" style="left:770px;" id="channel_2">湖南卫视高清</div>
---->
    </div>    
    <div class="exp_title">高清体验区</div>
        <div class="exp_title1">高清直播频道</div>
        <div class="exp_title2">高清影视点播</div>


    <div class="exp_img">
        <div class="item" id="area1_pic_0" >
        	<div class="pic"><img id="area1_img_0"  width="258" height="166" /></div>
        </div>
        <div class="name" id="e_name_0"><marquee behavior=alternate></marquee></div>
        
          <div class="item" id="area1_pic_1" style="left:289px" >
        	<div class="pic"><img id="area1_img_1"  width="258" height="166" /></div>
        </div>
        <div class="name" id="e_name_1" style="left:303px" ></div>
          
        <div class="item" id="area1_pic_2" style="left:579px">
        <div class="pic"><img id="area1_img_2"  width="258" height="166" /></div>
        </div>
        <div class="name" id="e_name_2" style="left:593px"></div>
        
        
        <div class="item" id="area1_pic_3" style="left:868px">
        <div class="pic"><img id="area1_img_3"  width="258" height="166" /></div>
        </div>
        <div class="name" id="e_name_3" style="left:882px"></div>
        
        <div class="item" id="area1_pic_4" style="top:191px;">
        <div class="pic"><img id="area1_img_4"  width="258" height="166" /></div>
        </div>
        <div class="name" id="e_name_4" style="top:340px;" ><marquee behavior=alternate></marquee></div>
        
        <div class="item" id="area1_pic_5" style="top:191px;left:289px">
        <div class="pic"><img id="area1_img_5"  width="258" height="166" /></div>
        </div>
        <div class="name" id="e_name_5" style="top:340px;left:303px"></div>
        <div class="item" id="area1_pic_6" style="top:191px;left:579px">
        <div class="pic"><img id="area1_img_6"  width="258" height="166" /></div>
        </div>
        <div class="name" id="e_name_6" style="top:340px;left:593px"></div>
        <div class="item" id="area1_pic_7" style="top:191px;left:868px">
        <div class="pic"><img id="area1_img_7"  width="258" height="166" /></div>
        </div>
        <div class="name" id="e_name_7" style="top:340px;left:882px"></div>


  </div>


    <div class="bottom">请按遥控器上的返回键返回</div>

</div>

</body>
</html>
