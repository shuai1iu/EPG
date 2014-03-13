
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
<%@ include file = "../../keyboard_A2/keydefine.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>高清体验区</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />



<style>
body { background:url(images/bg.jpg) no-repeat;}

.exp_title {
	position:absolute;
	left:58px;
	top:40px;
	width:169px;
	height:33px;
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
	overflow:scroll;
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


 <script type="text/javascript">
 
        
		var returnurl = '<%=request.getParameter("returnurl")!=null?request.getParameter("returnurl"):"index.jsp"%>';
		document.onkeypress = eventHandler;
		var flag = 1;
		var flag1 = 2;
		var flag2 = 7;
		function init() {
		flag =0;
		flag1 = 0;
		displayVodNull();
		displayChannel0();
		}
		
		function displayChannel0(){
		setWebkitTransform("channel_0", "menu_bgfocuson.png");
		setWebkitTransform("channel_1", "");
		setWebkitTransform("channel_2", "");
		}
		
		function displayChannel1(){
		setWebkitTransform("channel_0", "");
		setWebkitTransform("channel_1", "menu_bgfocuson.png");
		setWebkitTransform("channel_2", "");
		}
		
		function displayChannel2(){
		setWebkitTransform("channel_0", "");
		setWebkitTransform("channel_1", "");
		setWebkitTransform("channel_2", "menu_bgfocuson.png");
		}
		
		function displayVod0(){
		setWebkitTransform("area1_pic_0", "experience_on.png");
		setWebkitTransform("area1_pic_1", "");
		setWebkitTransform("area1_pic_2", "");
		setWebkitTransform("area1_pic_3", "");
		setWebkitTransform("area1_pic_4", "");
		setWebkitTransform("area1_pic_5", "");
		setWebkitTransform("area1_pic_6", "");
		setWebkitTransform("area1_pic_7", "");
		}
		
		function displayVod1(){
		setWebkitTransform("area1_pic_0", "");
		setWebkitTransform("area1_pic_1", "experience_on.png");
		setWebkitTransform("area1_pic_2", "");
		setWebkitTransform("area1_pic_3", "");
		setWebkitTransform("area1_pic_4", "");
		setWebkitTransform("area1_pic_5", "");
		setWebkitTransform("area1_pic_6", "");
		setWebkitTransform("area1_pic_7", "");
		}
		
		function displayVod2(){
		setWebkitTransform("area1_pic_0", "");
		setWebkitTransform("area1_pic_1", "");
		setWebkitTransform("area1_pic_2", "experience_on.png");
		setWebkitTransform("area1_pic_3", "");
		setWebkitTransform("area1_pic_4", "");
		setWebkitTransform("area1_pic_5", "");
		setWebkitTransform("area1_pic_6", "");
		setWebkitTransform("area1_pic_7", "");
		}
		
		function displayVod3(){
		setWebkitTransform("area1_pic_0", "");
		setWebkitTransform("area1_pic_1", "");
		setWebkitTransform("area1_pic_2", "");
		setWebkitTransform("area1_pic_3", "experience_on.png");
		setWebkitTransform("area1_pic_4", "");
		setWebkitTransform("area1_pic_5", "");
		setWebkitTransform("area1_pic_6", "");
		setWebkitTransform("area1_pic_7", "");
		}
		
		function displayVod4(){
		setWebkitTransform("area1_pic_0", "");
		setWebkitTransform("area1_pic_1", "");
		setWebkitTransform("area1_pic_2", "");
		setWebkitTransform("area1_pic_3", "");
		setWebkitTransform("area1_pic_4", "experience_on.png");
		setWebkitTransform("area1_pic_5", "");
		setWebkitTransform("area1_pic_6", "");
		setWebkitTransform("area1_pic_7", "");
		}
		
		function displayVod5(){
		setWebkitTransform("area1_pic_0", "");
		setWebkitTransform("area1_pic_1", "");
		setWebkitTransform("area1_pic_2", "");
		setWebkitTransform("area1_pic_3", "");
		setWebkitTransform("area1_pic_4", "");
		setWebkitTransform("area1_pic_5", "experience_on.png");
		setWebkitTransform("area1_pic_6", "");
		setWebkitTransform("area1_pic_7", "");
		}
		
		function displayVod6(){
		setWebkitTransform("area1_pic_0", "");
		setWebkitTransform("area1_pic_1", "");
		setWebkitTransform("area1_pic_2", "");
		setWebkitTransform("area1_pic_3", "");
		setWebkitTransform("area1_pic_4", "");
		setWebkitTransform("area1_pic_5", "");
		setWebkitTransform("area1_pic_6", "experience_on.png");
		setWebkitTransform("area1_pic_7", "");
		}
		
		function displayVod7(){
		setWebkitTransform("area1_pic_0", "");
		setWebkitTransform("area1_pic_1", "");
		setWebkitTransform("area1_pic_2", "");
		setWebkitTransform("area1_pic_3", "");
		setWebkitTransform("area1_pic_4", "");
		setWebkitTransform("area1_pic_5", "");
		setWebkitTransform("area1_pic_6", "");
		setWebkitTransform("area1_pic_7", "experience_on.png");
		}
		
		function displayVodNull()
		{
		setWebkitTransform("area1_pic_0", "");
		setWebkitTransform("area1_pic_1", "");
		setWebkitTransform("area1_pic_2", "");
		setWebkitTransform("area1_pic_3", "");
		setWebkitTransform("area1_pic_4", "");
		setWebkitTransform("area1_pic_5", "");
		setWebkitTransform("area1_pic_6", "");
		setWebkitTransform("area1_pic_7", "");
		}
		
		
		
		function setWebkitTransform(object, value)
		{
		document.getElementById(object).style.backgroundImage = "url(images/" + value + ")";
		}
		
		function doSelect() 
		{
		switch (flag) {
		case 0:
			switch(flag1){
				case 0:
					var temp = "play_ControlChannel.jsp?CHANNELNUM=<%="201"%>&COMEFROMFLAG=1&returnurl="+escape(location.href);
					window.location.href = temp;
					break;
				case 1:
					var temp = "play_ControlChannel.jsp?CHANNELNUM=<%="203"%>&COMEFROMFLAG=1&returnurl="+escape(location.href);
					window.location.href = temp;
					break;
				case 2:
					var temp ="play_ControlChannel.jsp?CHANNELNUM=<%="205"%>&COMEFROMFLAG=1&returnurl="+escape(location.href);
					window.location.href = returnUrl;
					break;
						}
		case 1:
			switch (flag2){
				case 0:
					var temp = "vod_turnpager.jsp?vodid="+data[0].VODID+"&typeid=<%=shouyetuijian2code%>"+"&returnurl="+returnurl;
					window.location.href = temp;
					break;
				case 1:
					var temp = "vod_turnpager.jsp?vodid="+data[1].VODID+"&typeid=<%=shouyetuijian2code%>"+"&returnurl="+returnurl;
					window.location.href = temp;
					break;
				case 2:
					var temp = "vod_turnpager.jsp?vodid="+data[2].VODID+"&typeid=<%=shouyetuijian2code%>"+"&returnurl="+returnurl;
					window.location.href = temp;
					break;
				case 3:
					var temp = "vod_turnpager.jsp?vodid="+data[3].VODID+"&typeid=<%=shouyetuijian2code%>"+"&returnurl="+returnurl;
					window.location.href = temp;
					break;
				case 4:
					var temp = "vod_turnpager.jsp?vodid="+data[4].VODID+"&typeid=<%=shouyetuijian2code%>"+"&returnurl="+returnurl;
					window.location.href = temp;
					break;
				case 5:
					var temp = "vod_turnpager.jsp?vodid="+data[5].VODID+"&typeid=<%=shouyetuijian2code%>"+"&returnurl="+returnurl;
					window.location.href = temp;
					break;
				case 6:
					var temp = "vod_turnpager.jsp?vodid="+data[6].VODID+"&typeid=<%=shouyetuijian2code%>"+"&returnurl="+returnurl;
					window.location.href = temp;
					break;
				case 7:
					var temp = "vod_turnpager.jsp?vodid="+data[7].VODID+"&typeid=<%=shouyetuijian2code%>"+"&returnurl="+returnurl;
					window.location.href = temp;
					break;
					}
				}
		}
		
		function keyDown() {
		switch (flag)
			{
			case 0:
				flag = 1;
				flag2 = 0;
				displayVod0();
				break;
			case 1:
				switch (flag2)
				{
					case 0:
						displayVod4();
						flag2 = 4;
						break;
					case 1:
						displayVod5();
						flag2 = 5;
						break;
					case 2:
						displayVod6();
						flag2 = 6;
						break;
					case 3:
						displayVod7();
						flag2 = 7;
						break;
					case 4:
						displayVod4();
						flag2 = 4;
						break;
					case 5:
						displayVod5();
						flag2 = 5;
						break;
					case 6:
						displayVod6();
						flag2 = 6;
						break;
					case 7:
						displayVod7();
						flag2 = 7;
						break;
				}	
			}
		}
		
		function keyUp() {
		switch (flag)
			{
			case 0:
				flag = 0;
			//	flag1 = flag1;
			case 1:
				switch (flag2)
				{
					case 0:
						flag = 0;
						flag1 = 0;
						displayChannel0();
						displayVodNull();
						break;
					case 1:
						flag = 0;
						flag1 = 1;
						displayChannel1();
						displayVodNull();
						break;
					case 2:
						flag = 0;
						flag1 = 1;
						displayChannel1();
						flag2 = null;
						displayVodNull();
						break;
					case 3:
						flag = 0;
						flag1 = 2;
						displayChannel2();
						displayVodNull();
						break;
					case 4:
						displayVod0();
						flag2 = 0;
						break;
					case 5:
						displayVod1();
						flag2 = 1;
						break;
					case 6:
						displayVod2();
						flag2 = 2;
						break;
					case 7:
						displayVod3();
						flag2 = 3;
						break;
				}
			}		
		}
		
		
		function keyRight() {
		switch (flag){
		case 0:
			displayVodNull();
			switch (flag1) {
				case 0:		
					displayChannel1();
					flag1 = 1;
					break;
				case 1:		
					displayChannel2();
					flag1 = 2;
					break;
				case 2:		
					displayChannel0();
					flag1 = 0;
					break;
					}
		case 1:
			switch (flag2) {
				case 0:		
					displayVod1();
					flag2 = 1;
					break;
				case 1:		
					displayVod2();
					flag2 = 2;
					break;
				case 2:		
					displayVod3();
					flag2 = 3;
					break;
				case 3:		
					displayVod0();
					flag2 = 0;
					break;
				case 4:		
					displayVod5();
					flag2 = 5;
					break;
				case 5:		
					displayVod6();
					flag2 = 6;
					break;
				case 6:		
					displayVod7();
					flag2 = 7;
					break;
				case 7:		
					displayVod5();
					flag2 = 5;
					break;
				}
			}
		}
	
	
		function keyLeft() {
		switch (flag){
		case 0:
			switch (flag1) {
				case 0:		
					displayChannel2();
					flag1 = 2;
					break;
				case 1:		
					displayChannel0();
					flag1 = 0;
					break;
				case 2:		
					displayChannel1();
					flag1 = 1;
					break;
					}
		case 1:
			switch (flag2) {
				case 0:		
					displayVod3();
					flag2 = 3;
					break;
				case 1:		
					displayVod0();
					flag2 = 0;
					break;
				case 2:		
					displayVod1();
					flag2 = 1;
					break;
				case 3:		
					displayVod2();
					flag2 = 2;
					break;
				case 4:		
					displayVod7();
					flag2 = 7;
					break;
				case 5:		
					displayVod4();
					flag2 = 4;
					break;
				case 6:		
					displayVod5();
					flag2 = 5;
					break;
				case 7:		
					displayVod6();
					flag2 = 6;
					break;
				}
			}
		}
		
		function eventHandler(event) {
		switch (event.which) {
			case <%=KEY_BACKSPACE%>:
			case <%=KEY_RETURN%>:
				window.location.href = returnUrl;
				break;
			case <%=KEY_OK%>:
				doSelect();
				break;
			case <%=KEY_RIGHT%>:
				keyRight();
				break;
			case <%=KEY_LEFT%>:
				keyLeft();
				break;
			case <%=KEY_DOWN%>:
				keyDown();
				break;
			case <%=KEY_UP%>:
				keyUp();
				break;
		}
	}
	
	
	
window.onload = function() { init(); }
		
		
       




</script>











</head>
<body>

    
    <div class="top">
    	<div class="top" id="channel_0">CCTV-1高清</div>
        <div class="top" style="left:405px;" id="channel_1">深圳卫视高清</div>
	<div class="top" style="left:770px;" id="channel_2">湖南卫视高清</div>
    </div>
    <div class="exp_title">高清体验</div>
        <div class="exp_title1">高清直播频道体验</div>
        <div class="exp_title2">高清点播内容体验</div>


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
