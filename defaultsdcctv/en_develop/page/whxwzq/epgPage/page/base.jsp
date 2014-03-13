<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
/* =S Css Reset
----------------------------------------------- */
body, div, input { margin:0; padding:0;}
body, div, button, input { font-size:16px; font-family: SimHei,sans-serif; line-height: 100%;}
a { text-decoration: none;}
img { border: 0;}
/* =S Global
----------------------------------------------- */
.item, .link, .txt-wrap, .txt, .btn, .icon, .pic, .pic-shade, .num, .win { position:absolute;}
.link { left: 0; top: 0; z-index:9;}
.txt { left: 0; z-index:7;}
.txt-wrap { z-index:6;}
.icon { z-index:5;}
.pic-shade { z-index:4;}
.pic { z-index:3;}
.btn { text-align: center;}
body {
	color: #f1f1f1;
    height: 530px;
    width: 640px;
    /*background: transparent;*/
    overflow: hidden;
    position: relative;
}
.wrapper,.pagebg {
	left: 0;
	position:absolute;
	top:0;
}
.wrapper {
    height: 530px;
    width: 640px;
	z-index:2;
}
.pagebg {
	z-index:1;
}
.pages {
	color:#fef8f8;
	font-size:16px;
	left:525px;
	position:absolute;
	top:472px;
	text-align:right;
	width:100px;
}
.page-a {
	left:27px;
	position:absolute;
	top:102px;
}
.page-a .item {
	height:36px;
	width:88px;
}  
.page-a .item_focus {
	background:url(../images/page_focus.png) no-repeat;
}

.menu-news {
	left:0;
	position:absolute;
	top:45px;
}
.menu-news .item {
	height:42px;
	left:41px;
}
.menu-news .item .link {
	top:1px;
}
.menu-news .item .txt {
	color:#fff;
	font-size:27px;
	line-height:37px;
	text-align:center;
	top:3px;
	height:37px;
}
.menu-news .item01,
.menu-news .item01 .txt {
	width:61px;
}  
.menu-news .item01_select {
	background:url(../images/news-menu01.png) no-repeat;
}
.menu-news .item02,
.menu-news .item02 .txt {
	width:112px;
} 
.menu-news .item02_select {
	background:url(../images/news-menu02.png) no-repeat;
}
.menu-news .item03,
.menu-news .item03 .txt {
	width:142px;
} 
.menu-news .item03_select {
	background:url(../images/news-menu03.png) no-repeat;
}
.menu-news .item04 {
	top:0;
	width:87px;
} 
.menu-news .item04 .txt {
	left:8px;
	top:5px;
	text-align:left;
	width:80px;
} 
.menu-news .item04 {
	background:url(../images/news-menu04.png) no-repeat;
}
.menu-news .item04_select {
	background:url(../images/news-menu04_select.png) no-repeat;
}
</style>