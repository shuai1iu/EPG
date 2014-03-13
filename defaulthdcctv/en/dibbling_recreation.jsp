<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ include file="datajsp/util_AdText.jsp"%>
<%@ include file="util/save_focus.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<title>点播</title>
<%@ include file="dibbling_recreation_ctrl.jsp"%>
</head>
<body><!--UPDATE BY Evans Date:2011/10/18-->
    <div class="main">
        <!--logo-->
        <div class="logo" style="width: 500px;">
            <%=typeName%></div>
	<div class="date" id="currDate"></div>
        <!--menu-->
        <div class="menu2">
            <div>
                <img src="images/menu_line.png" /></div>
            <div class="menuli" id="cate_0" style="width:300px">
            </div>
            <div id="menu0">
                <img src="images/menu_line.png" /></div>
            <div class="menuli" id="cate_1" style="width:300px">
            </div>
            <div id="menu1">
                <img src="images/menu_line.png" /></div>
            <div class="menuli" id="cate_2" style="width:300px">
            </div>
            <div id="menu2">
                <img src="images/menu_line.png" /></div>
            <div class="menuli" id="cate_3" style="width:300px">
            </div>
            <div id="menu3">
                <img src="images/menu_line.png" /></div>
            <div class="menuli" id="cate_4" style="width:300px">
            </div>
            <div id="menu4">
                <img src="images/menu_line.png" /></div>
            <div class="menuli" id="cate_5" style="width:300px">
            </div>
            <div id="menu5">
                <img src="images/menu_line.png" /></div>
            <div class="menuli" id="cate_6" style="width:300px">
            </div>
            <div id="menu6">
                <img src="images/menu_line.png" /></div>
            <div class="menuli" id="cate_7" style="width:300px">
            </div>
            <div id="menu7">
                <img src="images/menu_line.png" /></div>
            <div class="menuli" id="cate_8" style="width:300px">
                </div>
            <div id="menu8">
                <img src="images/menu_line.png"  /></div>
        </div>
        <!--film-->
        <div class="dibb">
            <div class="arrow"><img id="pageup" src="images/up.png" /></div>
            <div class="rec_list" id="cates" style="display:none;">
                <div class="bg" id="content_0">
                    <img  width="259" height="165" id="img_0" /><div class="f"
                        id="contentname_0">
                        </div>
                </div>
                <div class="bg" id="content_1" style="left:295px" >
                    <img  width="259" height="165" id="img_1" /><div class="f"
                        id="contentname_1">
                        </div>
                </div>
                <div class="bg" id="content_2" style="left:590px">
                    <img  width="259" height="165" id="img_2" /><div class="f"
                        id="contentname_2">
                        </div>
                </div>
                <div class="bg" id="content_3" style="top:255px;">
                    <img width="259" height="165" id="img_3" /><div class="f"
                        id="contentname_3">
                         </div>
                </div>
                <div class="bg" id="content_4" style="top:255px;left:295px">
                    <img  width="259" height="165" id="img_4" /><div class="f"
                        id="contentname_4">
                         </div>
                </div>
                <div class="bg" id="content_5" style="top:255px;left:590px">
                    <img  width="259" height="165" id="img_5" /><div class="f"
                        id="contentname_5">
                         </div>
                </div>
            </div>
            <div class="film_list" align="center" id="films" style="display:none;">
                <div id="filmscontent_0">
                    <img  width="161" height="222" id="pic_0" /></div>
                <div id="filmscontent_1" style="left:182px">
                    <img  width="161" height="222" id="pic_1" /></div>
                <div id="filmscontent_2" style="left:364px">
                    <img  width="161" height="222" id="pic_2" /></div>
                <div id="filmscontent_3" style="left:546px">
                    <img width="161" height="222" id="pic_3" /></div>
                <div id="filmscontent_4" style="left:728px">
                    <img width="161" height="222" id="pic_4" /></div>
                <div id="filmscontent_5" style="top:250px">
                    <img width="161" height="222" id="pic_5" /></div>
                <div id="filmscontent_6" style="top:250px;left:182px">
                    <img  width="161" height="222" id="pic_6" /></div>
                <div id="filmscontent_7" style="top:250px;left:364px">
                    <img width="161" height="222" id="pic_7" /></div>
                <div id="filmscontent_8" style="top:250px;left:546px">
                    <img width="161" height="222" id="pic_8" /></div>
                <div id="filmscontent_9" style="top:250px;left:728px">
                    <img width="161" height="222" id="pic_9" /></div>
            </div>
            <div class="arrow" style="top:530px"><img id="pagedown" src="images/down.png" /></div>
        </div>
        <div class="pages2" id="page">
        </div>
        <div class="pages5" id="catepage">
        </div>
         <!--bottom_notice-->
	<div class="notice" id="marq"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>
    </div>
    <iframe name="hidden_frame" id="hidden_frame" style="display: none" width="0" height="0">
    </iframe>
    <div style="visibility:hidden; z-index:-1">
    <!--首页左边导航暗焦点--> 
    <img src="images/pic_bg5on.png"/>
    <img src="images/menu_bgon.png"/>
</div>
<%@ include file="servertimehelp.jsp" %>
</body>
</html>