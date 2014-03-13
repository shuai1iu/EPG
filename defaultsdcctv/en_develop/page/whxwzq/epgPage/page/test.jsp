<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>湖北-湖北广电标清EPG2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/common.css" />
<style type="text/css">
.list-a {
	left:25px;
	position:absolute;
	top:151px;
}
.list-a .item .pic {
	background-color:#fff;
	left:3px;
	height:86px;
	width:104px;
}
.list-a .item .pic img {
	left:1px;
	position:absolute;
	top:1px;
}
.list-a .item .txt-wrap {
	background:url(../images/list-txt-bg.png) no-repeat;
	left:119px;
	top:3px;
	height:80px;
	width:159px;
}
.list-a .item .txt {
	color:#0a64a3;
	left:5px;
	top:53px;
	width:154px;
}
.list-a .item .txt-tit {
	color:#000;
	font-size:24px;
	left:16px;
	top:5px;
	width:140px;
}
</style>
</head>

<body style="background:url(../images/bg-news01.jpg) no-repeat;">
	
<!-- menu -->
	<div class="menu-news">
		<!--
		选中为
			class="item item01 item01_select" 2字 
			class="item item02 item02_select" 4字
			class="item item03 item03_select" 5字	 
		-->
		<div class="item item01">
			<div class="link"><a id="area0_list_0" href="#"><img src="../images/t.gif" width="61" height="37" /></a></div>
			<div class="txt">首页</div>
        </div>
		<div class="item item04" style="left:128px;">
			<div class="link"><a id="area0_list_1" href="#"><img src="../images/t.gif" width="61" height="37" /></a></div>
			<div class="txt">湖北</div>
        </div>
		<div class="item item01" style="left:217px;">
			<div class="link"><a id="area0_list_2" href="#"><img src="../images/t.gif" width="61" height="37" /></a></div>
			<div class="txt">名栏</div>
        </div>
		<div class="item item02" style="left:310px;">
			<div class="link"><a id="area0_list_3" href="#"><img src="../images/t.gif" width="112" height="37" /></a></div>
			<div class="txt">经视直播</div>
        </div>
		<div class="item item03" style="left:453px;">
			<div class="link"><a id="area0_list_4" href="#"><img src="../images/t.gif" width="142" height="37" /></a></div>
			<div class="txt">长江新闻号</div>
        </div>
	</div>
<!-- menu the end-->
	
	
<!-- page -->
	<div class="page-a">
		<!--灰色为
				btn-prev02_gray.png
				btn-next02_gray.png
		-->	
		<div class="item"><!--<a href="#">--><img src="../images/btn-prev02_gray.png" alt="上页" width="88" height="36" /><!--</a>--></div>
		<div class="item" style="left:100px;"><a href="#"><img src="../images/btn-next02.png" alt="下页" width="88" height="36" /></a></div>
	</div>
	<div class="txt" style="color:#75cefc; font-size:18px; left:503px; top:112px; text-align:right; width:100px;">1/2页</div>
<!-- page the end-->

<!-- list -->
	<div class="list-a">
		<div id="area2_0" class="item" style="visibility">
			<div class="link"><a id="area2_list_0" href="#" ><img src="../images/t.gif" width="282" height="87" /></a></div>
			<div class="pic"><img id="area2_img_0" src="${categoryListData.categoryList[0].poster}" /></div>
			<div class="txt-wrap">
				<div id="area2_title_0" class="txt txt-tit"></div>
				<div id="area2_description_0" class="txt"></div>
		</div>
		<div id="area2_1" class="item" style="left:298px;visibility">
			<div class="link"><a id="area2_list_1" href="#"><img src="../images/t.gif" width="282" height="87" /></a></div>
			<div class="pic"><img id="area2_img_1" src="${categoryListData.categoryList[1].poster}" /></div>
			<div class="txt-wrap">
				<div id="area2_title_1" class="txt txt-tit"></div>
				<div id="area2_description_1" class="txt"></div>
			</div>
		</div>
		<div id="area2_2" class="item" style="top:108px;visibility">
			<div class="link"><a id="area2_list_2" href="#"><img src="../images/t.gif" width="282" height="87" /></a></div>
			<div class="pic"><img id="area2_img_2" src="${categoryListData.categoryList[2].poster}" /></div>
			<div class="txt-wrap">
				<div id="area2_title_2" class="txt txt-tit"></div>
				<div id="area2_description_2" class="txt"></div>
			</div>
		</div>
		<div id="area2_3" class="item" style="left:298px;top:108px;visibility">
			<div class="link"><a id="area2_list_3" href="#"><img src="../images/t.gif" width="282" height="87" /></a></div>
			<div class="pic"><img id="area2_img_3" src="${categoryListData.categoryList[3].poster}" /></div>
			<div class="txt-wrap">
				<div id="area2_title_3" class="txt txt-tit"></div>
				<div id="area2_description_3" class="txt"></div>
			</div>
		</div>
		<div id="area2_4" class="item" style="top:215px;visibility">
			<div class="link"><a id="area2_list_4" href="#"><img src="../images/t.gif" width="282" height="87" /></a></div>
			<div class="pic"><img id="area2_img_4" src="${categoryListData.categoryList[4].poster}" /></div>
			<div class="txt-wrap">
				<div id="area2_title_4" class="txt txt-tit"></div>
				<div id="area2_description_4" class="txt"></div>
			</div>
		</div>
		<div id="area2_5" class="item" style="left:298px;top:215px;visibility:">
			<div class="link"><a id="area2_list_5" href="#"><img src="../images/t.gif" width="282" height="87" /></a></div>
			<div class="pic"><img id="area2_img_5" src="${categoryListData.categoryList[5].poster}" /></div>
			<div class="txt-wrap">
				<div id="area2_title_5" class="txt txt-tit"></div>
				<div id="area2_description_5" class="txt"> </div>
			</div>
		</div>
    </div>
<!-- list the end-->


<!-- page -->
	<div class="page-a" style="top:468px;">
		<div class="item "><a href="#"><img src="../images/btn-prev02.png" alt="上页" width="88" height="36" /></a></div>
		<div class="item" style="left:100px;"><a href="#"><img src="../images/btn-next02.png" alt="下页" width="88" height="36" /></a></div>
	</div>
<!-- page the end-->
	
</body>
<iframe name="hidden_frame" id="hidden_frame" style="visibility:hidden;" width="0" height="0" ></iframe>
</html>