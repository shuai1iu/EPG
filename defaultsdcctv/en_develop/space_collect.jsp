<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="space_collect_control.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>


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
            left: 10px;
            top: 8px;
        }
	    .myspace-list .item .linkonboder{
			  height: 36px;
              width: 200px;
			  position:absolute;
			  border:2px solid #ffff50;
		 } 
		
		.myspace-list .item .linkoffboder{
			  height: 36px;
              width: 200px;
			  position:absolute;
			  border:2px hidden  #3f6089;
		 }
        .myspace-list .item .icon {
            height: 23px;
            width: 24px;
            left: 232px;
            top: 8px;
        }
		 .myspace-list .item .onboder {
            height: 23px;
            width: 24px;
            left: 232px;
            top: 8px;
			position:absolute;
			border:2px solid #ffff50;
        }
		 .myspace-list .item .offboder {
            height: 23px;
            width: 24px;
            left: 232px;
            top: 8px;
			position:absolute;
			border:2px hidden  #3f6089;
        }
		
		
        .mod-movieShow .item {
            background-color: #1f2847;
        }
		.mod-pop-box {
            background: url("../images/pop-432x218-1.png") no-repeat;
            height: 218px;
            width: 432px;
            position: absolute;
            left: 104px;
            top: 142px;
        }
        .mod-pop-box .txt2 {
            font-size: 20px;
            height: 24px;
			left:0;
			position:absolute;
            text-align: center;
            width: 432px;
        }
	    .onboder1
		{
			 position:absolute;
		    height: 40px;width: 144px;
			border:2px solid #ffff50;
        }
		.offboder1
		{
			 position:absolute;
		    height: 40px;width: 144px; 
			border:2px hidden  #3f6089;
        }
		 .leftNav-e .item .onboder1
		{
			 position:absolute;
		    height: 40px;width: 144px;
			border:2px solid #ffff50;
        }
		.leftNav-e .item .offboder1
		{
			 position:absolute;
		    height: 40px;width: 144px; 
			border:2px hidden  #3f6089;
        }
		.leftNav-e .item .txt {
			 position:absolute;
			height: 40px;
			width: 144px;
        }
    </style>
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
        <div class="item item_select"  style="top:122px;">
            <div class="offboder" id="area0_list_0" ><img src="../images/t.gif" /></div>
            <div class="txt">收&nbsp;藏</div>
        </div>
        <div class="item" style="top:169px;">
            <div class="offboder" id="area0_list_1"><img src="../images/t.gif" /></div>
            <div class="txt">书&nbsp;签</div>
        </div>
        <div class="item" style="top:216px;" >
            <div class="offboder" id="area0_list_2"><img src="../images/t.gif" /></div>
            <div class="txt">计&nbsp;费</div>
        </div>
        <div class="item" style="top:263px;">
            <div class="offboder" id="area0_list_3"><img src="../images/t.gif" /></div>
            <div class="txt">指&nbsp;南</div>
        </div>
    </div>
    <!-- E 左侧导航 -->

    <div class="myspace-list">
        <div class="item" style="top:96px;">
            <div class="link" id="area1_list_0"><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_txt_0"></div>
            <div class="icon" id="area2_list_0"><img src="../images/icon-x.png" /></div>
        </div>
        <div class="item" style="top:140px;">
            <div class="link" id="area1_list_1"><img src="../images/t.gif" /></div>
            <div class="txt"  id="area1_txt_1"></div>
            <div class="icon" id="area2_list_1"><img src="../images/icon-x.png" /></div>
        </div>
        <div class="item" style="top:184px;">
            <div class="link" id="area1_list_2"><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_txt_2"></div>
            <div class="icon" id="area2_list_2"><img src="../images/icon-x.png" /></div>
        </div>
        <div class="item" style="top:228px;">
            <div class="link" id="area1_list_3"><img src="../images/t.gif" /></div>
            <div class="txt"  id="area1_txt_3"></div>
            <div class="icon" id="area2_list_3"><img src="../images/icon-x.png" /></div>
        </div>
        <div class="item" style="top:272px;">
            <div class="link" id="area1_list_4"><img src="../images/t.gif" /></div>
            <div class="txt"  id="area1_txt_4"></div>
            <div class="icon" id="area2_list_4"><img src="../images/icon-x.png" /></div>
        </div>
        <div class="item" style="top:316px;">
            <div class="link" id="area1_list_5"><img src="../images/t.gif" /></div>
            <div class="txt"  id="area1_txt_5"></div>
            <div class="icon" id="area2_list_5"><img src="../images/icon-x.png" /></div>
        </div>
        <div class="item" style="top:360px;">
            <div class="link" id="area1_list_6"><img src="../images/t.gif" /></div>
            <div class="txt"  id="area1_txt_6"></div>
            <div class="icon" id="area2_list_6"><img src="../images/icon-x.png" /></div>
        </div>

        <div class="mod-paging-b" style="left:185px;top:436px;width:286px;text-align: center;" id="pageArea">
          
        </div>
    </div>

    <!-- S 电影 -->
    <div class="mod-movieShow">
        <div class="item" style="top: 74px;">
            <div class="link"  id="area2_list_0"><img src="../images/t.gif" /></div>
            <div class="txtWrap">
                <div class="txt" id="area2_txt_0"></div>
            </div>
            <div class="pic" id="area2_img_0"><img src="#" /></div>
        </div>
        <div class="item" style="top: 207px;">
            <div class="link" id="area2_list_1"><img src="../images/t.gif" /></div>
            <div class="txtWrap">
                <div class="txt" id="area2_txt_1"></div>
            </div>
            <div class="pic" id="area2_img_1"><img src="#" /></div>
        </div>
        <div class="item" style="top: 340px;">
            <div class="link" id="area2_list_2"><img src="../images/t.gif" /></div>
            <div class="txtWrap">
                <div class="txt" id="area2_txt_2"></div>
            </div>
            <div class="pic" id="area2_img_2"><img src="#" /></div>
        </div>
    </div>
    <!-- E 电影 -->
</div>

<div class="mod-pop-box" id="area3_list"  style="display:none">
    <div class="txt2" style="top:40px;">您确定要删除该收藏吗？</div>
    <div class="btn btn-w-91x42-1" style="left:80px; top:130px;">
        <div class="link"  id="area3_list_0"><img src="../images/t.gif" /></div>
        <div class="txt">确定</div>
    </div>
    <!--<div class="btn btn-ori-131x42-1" style="left:117px; top:130px;">
        <div class="link"><a href="#"><img src="../../images/t.gif" /></a></div>
        <div class="txt">结束观看</div>
    </div>-->
    <div class="btn btn-w-91x42-1" style="left:260px; top:130px;">
        <div class="link" id="area3_list_1"><img src="../images/t.gif" /></div>
        <div class="txt">返回</div>
    </div>
</div>
<div class="mod-pop-box" id="area4_list" style="display:none">
    <div class="txt2" style="top:40px;">操作成功！</div>
    <div class="btn btn-ori-131x42-1" style="left:117px; top:130px;">
        <div class="link" id="area4_list_0"><img src="../images/t.gif" /></div>
        <div class="txt">确定</div>
    </div>
</div>
<div class="mod-pop-box" id="area5_list" style="display:none">
    <div class="txt2" style="top:40px;">操作失败！</div>
    <div class="btn btn-ori-131x42-1" style="left:117px; top:130px;">
        <div class="link" id="area5_list_0"><img src="../images/t.gif" /></div>
        <div class="txt">确定</div>
    </div>
</div>
</body>
</html>