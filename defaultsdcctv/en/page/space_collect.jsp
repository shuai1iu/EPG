<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="datajsp/util_AdText.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
    <meta name="page-view-size" content="640*530"/>
    <title>收藏 | CCTV-IP电视</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <style type="text/css">
     body {
            background: #263150 url("../images/body-page-myspace-1.png") no-repeat;
        }
        .myspace-list {}
        .myspace-list .item .link,
        .myspace-list .item .link img {
            height: 36px;
            width: 200px;
        }
        .myspace-list .item {
            height: 36px;
            width: 274px;
            left: 196px;
        }
        .myspace-list .item .txt {
			line-height:35px;
			height: 35px;
            width: 230px;
            left: 2px;
            top: 0px;
        }
        .myspace-list .item .icon {
            height: 23px;
            width: 24px;
            left: 232px;
            top: 8px;
        }
        .mod-movieShow .item {
            background-color: #1f2847;
        }
		
	
		.mod-pop-box {
            background: url("../images/pop-432x218-2.png") no-repeat;
            height: 218px;
            width: 432px;
            position: absolute;
            left: 104px;
            top: 142px;
            z-index:20;
        }
        .mod-pop-box .txt2 {
            font-size: 20px;
            height: 24px;
			left:0;
			position:absolute;
            text-align: center;
            width: 432px;
        }
	   
    </style>
<%@ include file="space_collect_control.jsp"%>
</head>
<body onLoad="loadBody();">
<div class="wrapper">
    <!-- S 面包屑 -->
    <div class="mod-bread">
        我的空间
    </div>
    <!-- E 面包屑 -->

    <!-- S 时间 -->
    <div class="mod-dataTime" id="currDate"></div>
    <!-- E 时间 -->

    <!-- S 左侧导航 -->
    <div class="leftNav-e">
        <div class="item item_select"  id="area0_list_0" style="top:122px;">
            <div class="txt">收&nbsp;藏</div>
        </div>
        <div class="item" id="area0_list_1" style="top:169px;">
            <div class="txt">书&nbsp;签</div>
        </div>
        <div class="item" id="area0_list_2" style="top:216px;" >
            <div class="txt">订购记录</div>
        </div>
        <div class="item" id="area0_list_3" style="top:263px;" >
            <div class="txt">取消订购</div>
        </div>
        <div class="item" id="area0_list_4" style="top:310px;">
           <div class="txt">操作简介</div>
        </div>
		<div class="item" id="area0_list_5" style="top:360px;">
           <div class="txt">使用指南</div>
        </div>
    </div>
    <!-- E 左侧导航 -->

    <div class="myspace-list">
        <div class="item" style="top:96px;">
            <div class="txt"  id="area1_list_0"></div>
            <div class="icon" id="area2_list_0"><img src="../images/icon-x.png" /></div>
        </div>
        <div class="item" style="top:140px;">
            <div class="txt"  id="area1_list_1"></div>
            <div class="icon" id="area2_list_1"><img src="../images/icon-x.png" /></div>
        </div>
        <div class="item" style="top:184px;">
            <div class="txt"  id="area1_list_2"></div>
            <div class="icon" id="area2_list_2"><img src="../images/icon-x.png" /></div>
        </div>
        <div class="item" style="top:228px;">
            <div class="txt"  id="area1_list_3"></div>
            <div class="icon" id="area2_list_3"><img src="../images/icon-x.png" /></div>
        </div>
        <div class="item" style="top:272px;">
            <div class="txt"  id="area1_list_4"></div>
            <div class="icon" id="area2_list_4"><img src="../images/icon-x.png" /></div>
        </div>
        <div class="item" style="top:316px;">
          
            <div class="txt"  id="area1_list_5"></div>
            <div class="icon" id="area2_list_5"><img src="../images/icon-x.png" /></div>
        </div>
        <div class="item" style="top:360px;">
           
            <div class="txt"  id="area1_list_6"></div>
            <div class="icon" id="area2_list_6"><img src="../images/icon-x.png" /></div>
        </div>

        <div class="mod-paging-b" style="left:185px;top:436px;width:286px;text-align: center;" id="pageArea">
          
        </div>
    </div>

    <!-- S 电影 -->
    <div class="mod-movieShow">
        <div class="item" id="area3_list_0" style="top: 74px;">
             <div class="txtWrap">
                <div class="txt" id="area3_txt_0"></div>
            </div>
            <div class="pic" ><img id="area3_img_0" src="#" /></div>
        </div>
        <div class="item"  id="area3_list_1" style="top: 207px;">
            <div class="txtWrap">
                <div class="txt" id="area3_txt_1"></div>
            </div>
            <div class="pic" ><img id="area3_img_1" src="#" /></div>
        </div>
        <div class="item" id="area3_list_2" style="top: 340px;">
            <div class="txtWrap">
                <div class="txt" id="area3_txt_2"></div>
            </div>
            <div class="pic" ><img id="area3_img_2" src="#" /></div>
        </div>
    </div>
    <!-- E 电影 -->
</div>

<div class="mod-pop-box" id="area4_list" style="display:none">
    <div class="txt2" style="top:40px;">您确定要删除该收藏吗？</div>
    <div class="btn btn-w-91x42-1" style="left:80px; top:130px;" id="area4_list_0">
        <div class="txt">确定</div>
    </div>
    <div class="btn btn-w-91x42-1" style="left:260px; top:130px;" id="area4_list_1">
        <div class="txt">返回</div>
    </div>
</div>
<div class="mod-pop-box" id="area5_list" style="display:none">
    <div class="txt2" style="top:40px;">操作成功！</div>
    <div class="btn btn-ori-131x42-1" style="left:117px; top:130px;" id="area5_list_0">
        <div class="txt">确定</div>
    </div>
</div>
<div class="mod-pop-box" id="area6_list" style="display:none">
    <div class="txt2" style="top:40px;">操作失败！</div>
    <div class="btn btn-ori-131x42-1" style="left:117px; top:130px;" id="area6_list_0">
        <div class="txt">确定</div>
    </div>
</div>
</body>
</html>
