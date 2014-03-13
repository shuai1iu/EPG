<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.facade.service.BookmarkImpl" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ include file = "keyboard/keydefine.jsp"%>
<%@ include file="../../config/properties.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>vod播控页面</title>


<style type="text/css"> 
/* =S Css Reset
----------------------------------------------- */
body, div, h1, h2, h3, h4, h5, h6, button, input, textarea, th, td { margin:0px; padding:0px; }
body, div, button, input, select, textarea { font-size: 20px; font-family: SimHei,sans-serif; line-height: 100%; }
h1, h2, h3, h4, h5, h6 { font-size: 100%; }
a { text-decoration: none; }
fieldset, img { border: 0px; }
button, input, select, textarea { font-size:100%; }


/* =S Global
----------------------------------------------- */
.item, .link, .txt, .btn, .icon, .pic, .cover, .num, .win { position:absolute;}
.link { left: 0px; top: 0px; z-index:79;}
.txt { left: 0px; z-index:76;}
.icon { z-index:75;}
.cover { z-index:74;}
.pic { z-index:73;}
.btn { text-align: center;}

body, .wrapper {
    height: 530px;
    width: 640px;
    background: transparent;
    position: relative;
}
body {
    color: #f1f1f1;
}
.onboder{ 
	height: 36px;width: 200px; border:2px solid #ffff50;
}
.offboder{ 
	height: 36px;width: 200px; border:2px hidden  #3f6089;
}

/* S= Header
----------------------------------------------- */


/* S= Mod
----------------------------------------------- */
.logo {
    height: 31px;
    width: 200px;
    position: absolute;
    left: 17px;
    top: 15px;
}


/* S= Bread */
.mod-bread {
    color: #f1f1f1;
    font-size: 26px;
    position: absolute;
    left: 20px;
    top: 18px;
}
.mod-bread span {
    color: #a0a1a4;
    font-size: 20px;
}
/* E= Bread */

.mod-dataTime {
    color: #7cc9e6;
    font-size: 18px;
    height: 24px;
    text-align: right;
    width: 244px;
    position: absolute;
    left: 382px;
    top: 19px;
}

/* S= paging */
.mod-paging-a {}
.mod-paging-a .item,
.mod-paging-a .item .link,
.mod-paging-a .item .link img,
.mod-paging-a .item .txt {
    height: 30px;
    width: 40px;
}
.mod-paging-a .item {
    background: url("../images/mod-paging-a-item.jpg") no-repeat;
    top: 414px;
}
.mod-paging-a .item .link {}
.mod-paging-a .item .txt {
    height: 24px;
    text-align: center;
    top: 4px;
}
.mod-paging-a .item_select {
    background: url("../images/mod-paging-a-item_select.jpg") no-repeat;
}

.mod-paging-b {
    color: #7cc9e6;
    font-size: 20px;
    height: 24px;
    width: 150px;
    position: absolute;
}
.mod-paging-b .current {
    color: #f0f0f0;
}
/* E= paging */

.mod-starLine {
    height: 20px;
    width: 140px;
    position: absolute;
}
.mod-starLine img {
    padding: 0;
    margin: 0 -3px;
}

/* S= Button */
.btn-g-211x42-1 {
    background: url("../images/btn-g-211x42-1.png") no-repeat;
}
.btn-g-211x42-1,
.btn-g-211x42-1 .link,
.btn-g-211x42-1 .link img,
.btn-g-211x42-1 .txt {
    height: 42px;
    width: 211px;
}
.btn-g-211x42-1 .txt {
    font-size: 26px;
    height: 24px;
    top: 8px;
}

.btn-g-91x42-1 {
    background: url("../images/btn-g-91x42-1.png") no-repeat;
}
.btn-g-91x42-1,
.btn-g-91x42-1 .link,
.btn-g-91x42-1 .link img,
.btn-g-91x42-1 .txt {
    height: 42px;
    width: 91px;
}
.btn-g-91x42-1 .txt {
    font-size: 20px;
    height: 24px;
    top: 10px;
}

.btn-ori-131x42-1 {
    background: url("../images/btn-ori-131x42-1.png") no-repeat;
}
.btn-ori-131x42-1,
.btn-ori-131x42-1 .link,
.btn-ori-131x42-1 .link img,
.btn-ori-131x42-1 .txt {
    height: 42px;
    width: 131px;
}
.btn-ori-131x42-1 .txt {
    font-size: 26px;
    height: 24px;
    top: 8px;
}

.btn-ori-91x42-1 {
    background: url("../images/btn-ori-91x42-1.png") no-repeat;
}
.btn-ori-91x42-1,
.btn-ori-91x42-1 .link,
.btn-ori-91x42-1 .link img,
.btn-ori-91x42-1 .txt {
    height: 42px;
    width: 91px;
}
.btn-ori-91x42-1 .txt {
    font-size: 20px;
    height: 24px;
    top: 10px;
}

.btn-blue-91x42-1 {
    background: url("../images/btn-blue-91x42-1.png") no-repeat;
}
.btn-blue-91x42-1,
.btn-blue-91x42-1 .link,
.btn-blue-91x42-1 .link img,
.btn-blue-91x42-1 .txt {
    height: 42px;
    width: 91px;
}
.btn-blue-91x42-1 .txt {
    font-size: 20px;
    height: 24px;
    top: 10px;
}

.btn-w-91x42-1 {
    background: url("../images/btn-w-91x42-1.png") no-repeat;
}
.btn-w-91x42-1,
.btn-w-91x42-1 .link,
.btn-w-91x42-1 .link img,
.btn-w-91x42-1 .txt {
    height: 42px;
    width: 91px;
}
.btn-w-91x42-1 .txt {
    color: #04334f;
    font-size: 26px;
    height: 24px;
    top: 8px;
}

.btn-w-131x42-1 {
    background: url("../images/btn-w-131x42-1.png") no-repeat;
}
.btn-w-131x42-1,
.btn-w-131x42-1 .link,
.btn-w-131x42-1 .link img,
.btn-w-131x42-1 .txt {
    height: 42px;
    width: 131px;
}
.btn-w-131x42-1 .txt {
    color: #04334f;
    font-size: 26px;
    height: 24px;
    top: 8px;
}

.btn-w-70x37-1 {
    background: url("../images/btn-w-70x37-1.png") no-repeat;
}
.btn-w-70x37-1,
.btn-w-70x37-1 .link,
.btn-w-70x37-1 .link img,
.btn-w-70x37-1 .txt {
    height: 37px;
    width: 70px;
}
.btn-w-70x37-1 .txt {
    color: #04334f;
    font-size: 20px;
    height: 24px;
    top: 9px;
}
/* E= Button */

/* S= AD */
.mod-as-420x110-1 {
    background-color: #0d3346;
    height: 110px;
    width: 420px;
    position: absolute;
}
.mod-as-420x110-1 .pic {
    height: 103px;
    width: 414px;
    left: 3px;
    top: 3px;
}
/* E= AD */

/* S= Page
----------------------------------------------- */

/* S index */
.mod-index-nav {}
.mod-index-nav .item,
.mod-index-nav .item .link,
.mod-index-nav .item .link img,
.mod-index-nav .item .txt {
    height: 43px;
    width: 65px;
}
.mod-index-nav .item {
    top: 54px;
}
.mod-index-nav .item .txt {
    font-size: 22px;
    height: 24px;
    text-align: center;
    top: 11px;
}

.mod-index-nav .item-live,
.mod-index-nav .item-live .link,
.mod-index-nav .item-live .link img,
.mod-index-nav .item-live .txt {
    height: 43px;
    width: 128px;
}
.mod-index-nav .item-live {
    background: url("../images/item-live.jpg") left top no-repeat;
}
.mod-index-nav .item-live .txt {
    text-align: left;
    width: 100px;
    left: 28px;
}
.mod-index-nav .item {}
.mod-index-nav .item {}

.mod-indexShowMovie {
    height: 220px;
    width: 290px;
    position: absolute;
    left: 180px;
    top: 108px;
}
.mod-indexShowMovie .pic {
    height: 214px;
    width: 284px;
    position: absolute;
    left: 3px;
    top: 3px;
}
.mod-index-recommend {} /* recommend */
.mod-index-recommend .item,
.mod-index-recommend .item .link,
.mod-index-recommend .item .link img,
.mod-index-recommend .item .txt {
    height: 30px;
    width: 59px;
}
.mod-index-recommend .item .link {}
.mod-index-recommend .item .txt {
    height: 22px;
    text-align: center;
    top: 6px;
}

.mod-index-hot {} /* hot */
.mod-index-hot .item,
.mod-index-hot .item .link,
.mod-index-hot .item .link img,
.mod-index-hot .item .txt {
    height: 30px;
    width: 59px;
}
.mod-index-hot .item .link {

}
.mod-index-hot .item .txt {
    height: 22px;
    text-align: center;
    top: 6px;
}

.mod-index-specTopic {}  /* special topic */
.mod-index-specTopic {}
.mod-index-specTopic .item {
    left: 481px;
}
.mod-index-specTopic .item,
.mod-index-specTopic .item .link,
.mod-index-specTopic .item .link img {
    height: 105px;
    width: 140px;
}
.mod-index-specTopic .item .link {}
.mod-index-specTopic .item .pic,
.mod-index-specTopic .item .pic img {
    height: 99px;
    width: 134px;
}
.mod-index-specTopic .item .pic {
    left: 3px;
    top: 3px;
}
.mod-index-specTopic .item .icon {
    height: 58px;
    width: 58px;
    right: 3px;
    top: 3px;
}

.mod-index-movie {}  /* Movie */
.mod-index-movie .item {
    top: 338px;
}
.mod-index-movie .item,
.mod-index-movie .item .link,
.mod-index-movie .item .link img {
    height: 135px;
    width: 140px;
}
.mod-index-movie .item .link {}
.mod-index-movie .item .pic,
.mod-index-movie .item .pic img {
    height: 129px;
    width: 134px;
}
.mod-index-movie .item .pic {
    left: 3px;
    top: 3px;
}
.mod-index-movie .item .txtWrap {
    background: url("../images/t80.png");
    height: 30px;
    width: 134px;
    position: absolute;
    left: 3px;
    top: 102px;
    z-index: 81;
}
.mod-index-movie .item .txt {
    color: #b4b4b5;
    font-size: 20px;
    height: 24px;
    width: 120px;
    left: 12px;
    top: 6px;
}

.mod-marquee {}
.mod-marquee .txt {
    font-size: 18px;
    height: 24px;
    width: 567px;
    position: absolute;
    left: 53px;
    top: 494px;
}

.btn-myspace {
    height: 32px;
    width: 122px;
    position: absolute;
    left: 35px;
    top: 394px;
}
.btn-proSearch {
    height: 32px;
    width: 122px;
    position: absolute;
    left: 35px;
    top: 433px;
}
/* E index */

/* S Vod */
.leftNav-a {}
.leftNav-a .item-arr-up,
.leftNav-a .item-arr-up .link,
.leftNav-a .item-arr-up .link img,
.leftNav-a .item-arr-down,
.leftNav-a .item-arr-down .link,
.leftNav-a .item-arr-down .link img {
    height: 20px;
    width: 28px;
}
.leftNav-a .item-arr-up,
.leftNav-a .item-arr-down {
    background-repeat: no-repeat;
    position: absolute;
    left: 92px;
}
.leftNav-a .item-arr-up {
    background-image: url(../images/arr-up.png);
}
.leftNav-a .item-arr-up-disable {
    background-image: url(../images/arr-up_disable.png);
}
.leftNav-a .item-arr-down {
    background-image: url(../images/arr-down.png);
}
.leftNav-a .item-arr-down-disable {
    background-image: url(../images/arr-down_disable.png);
}

.leftNav-a .item,
.leftNav-a .item .link,
.leftNav-a .item .link img {
    width: 185px;
}
.leftNav-a .item {
    height: 120px;
}
.leftNav-a .item .link,
.leftNav-a .item .link img {
    height: 40px;
}
.leftNav-a .item .link {
    left: 0px;
    top: 40px;
}
.leftNav-a .item .txt {
    color: #a0a1a4;
    font-size: 24px;
    height: 30px;
    text-align: right;
    width: 148px;
    left: 0px;
    top: 49px;
}
.leftNav-a .item_select {
    background: url("../images/lta-item_select.png") no-repeat;
}
.leftNav-a .item_select .txt {
    color: #f1f1f1;
}

.leftNav-b .item,
.leftNav-b .item .link,
.leftNav-b .item .link img {
    width: 255px;
}
.leftNav-b .item {
    height: 120px;
}
.leftNav-b .item .link,
.leftNav-b .item .link img {
    height: 40px;
}
.leftNav-b .item .link {
    left: 0px;
    top: 40px;
}
.leftNav-b .item .txt {
    color: #a0a1a4;
    font-size: 24px;
    height: 30px;
    width: 168px;
    left: 54px;
    top: 49px;
}
.leftNav-b .item_select {
    background: url("../images/ltb-item_select.png") no-repeat;
}
.leftNav-b .item_select .txt {
    color: #f1f1f1;
}

.mod-movieShow {}  /* Movie */
.mod-movieShow .item {
    background-color: #062d44;
    left: 482px;
}
.mod-movieShow .item,
.mod-movieShow .item .link,
.mod-movieShow .item .link img {
    height: 123px;
    width: 128px;
}
.mod-movieShow .item .pic,
.mod-movieShow .item .pic img {
    height: 117px;
    width: 122px;
}
.mod-movieShow .item .pic {
    left: 3px;
    top: 3px;
}
.mod-movieShow .item .txtWrap {
    background: url("../images/t80.png");
    height: 27px;
    width: 122px;
    position: absolute;
    left: 3px;
    top: 93px;
    z-index: 81;
}
.mod-movieShow .item .txt {
    color: #b4b4b5;
    font-size: 20px;
    height: 24px;
    width: 108px;
    left: 12px;
    top: 5px;
}
/* E Vod */

/* S Live */
..leftNav-c {}
.leftNav-c .item-arr-up,
.leftNav-c .item-arr-up .link,
.leftNav-c .item-arr-up .link img,
.leftNav-c .item-arr-down,
.leftNav-c .item-arr-down .link,
.leftNav-c .item-arr-down .link img {
    height: 20px;
    width: 28px;
}
.leftNav-c .item-arr-up,
.leftNav-c .item-arr-down {
    background-repeat: no-repeat;
    position: absolute;
    left: 123px;
}

.leftNav-c .item,
.leftNav-c .item .link,
.leftNav-c .item .link img {
    height: 31px;
}
.leftNav-c .item {
    width: 230px;
    left: 20px;
}
.leftNav-c .item .link,
.leftNav-c .item .link img {
    width: 186px;
}
.leftNav-c .item .link {
    left: 44px;
    top: 0px;
}
.leftNav-c .item .txt {
    color: #a0a1a4;
    font-size: 20px;
    height: 24px;
    width: 148px;
    left: 52px;
    top: 7px;
}
.leftNav-c .item .txt .num,
.leftNav-c .item .txt .name {
    height: 24px;
    position: absolute;
    top: 0px;
}
.leftNav-c .item .txt .num {
    color: #254c63;
    width: 50px;
    left: 0px;
}
.leftNav-c .item .txt .name {
    width: 128px;
    left: 51px;
}
.leftNav-c .item .icon {
    height: 30px;
    width: 20px;
    left: 17px;
    top: 0px;
}
.leftNav-c .item_select {
    background: url("../images/ltc-item_select.png") no-repeat;
}
.leftNav-c .item_select .txt,
.leftNav-c .item_select .txt .num {
    color: #f1f1f1;
}
/* E Live */

/* S Tvod */
.leftNav-d {}
.leftNav-d .item-arr-up,
.leftNav-d .item-arr-up .link,
.leftNav-d .item-arr-up .link img,
.leftNav-d .item-arr-down,
.leftNav-d .item-arr-down .link,
.leftNav-d .item-arr-down .link img {
    height: 20px;
    width: 28px;
}
.leftNav-d .item-arr-up,
.leftNav-d .item-arr-down {
    background-repeat: no-repeat;
    position: absolute;
    left: 100px;
}
.leftNav-d .item-arr-up {
    background-image: url(../images/arr-up.png);
}
.leftNav-d .item-arr-up-disable {
    background-image: url(../images/arr-up_disable.png);
}
.leftNav-d .item-arr-down {
    background-image: url(../images/arr-down.png);
}
.leftNav-d .item-arr-down-disable {
    background-image: url(../images/arr-down_disable.png);
}

.leftNav-d .item,
.leftNav-d .item .link,
.leftNav-d .item .link img {
    height: 36px;
    width: 190px;
}
.leftNav-d .item {
    left: 20px;
}
.leftNav-d .item .txt {
    font-size: 20px;
    height: 24px;
    width: 190px;
    left: 0px;
    top: 9px;
}
.leftNav-d .item .txt .txtcon {
    left:20px; 
	position:absolute; 
	top:0;
}
.leftNav-d .item .txt .num,
.leftNav-d .item .txt .name {
    height: 24px;
    position: absolute;
    top: 0px;
}
.leftNav-d .item .txt .num {
    color: #254c63;
    width: 72px;
    left: 17px;
}
.leftNav-d .item .txt .name {
    width: 128px;
    left: 72px;
}
.leftNav-d .item_select {
    background: url("../images/ltd-item_select.jpg") no-repeat;
}
.leftNav-d .item_select .txt,
.leftNav-d .item_select .txt .num {
    color: #f1f1f1;
}

.tvod-timeCont {}
.tvod-timeCont .item,
.tvod-timeCont .item .link,
.tvod-timeCont .item .link img {
    height: 30px;
    width: 310px;
}
.tvod-timeCont .item {
    left: 230px;
}
.tvod-timeCont .item .icon {
    color: #71ce14;
    font-size: 14px;
    display: none;
    height: 24px;
    width: 42px;
    left: 10px;
    top: 10px;
}
.tvod-timeCont .item .txt {
    color: #ededed;
    height: 24px;
    width: 216px;
    left: 10px;
    top: 6px;
}
.tvod-timeCont .item .txtTime {
    color: #415a67;
    height: 24px;
    width: 58px;
    position: absolute;
    top: 6px;
    left: 226px;
}

.tvod-timeCont .item {}
.tvod-timeCont .item_focus .icon {
    display: block;
}
.tvod-timeCont .item_focus .txt {
    left: 53px;
}
.tvod-timeCont .item-disable .txt {
    color: #396073;
}

.tvod-timeTag {}
.tvod-timeTag .item,
.tvod-timeTag .item .link,
.tvod-timeTag .item .link img,
.tvod-timeTag .item .txt {
    height: 34px;
    width: 78px;
}
.tvod-timeTag .item {
    left: 542px;
}
.tvod-timeTag .item .txt {
    color: #457080;
    height: 24px;
    width: 53px;
    width: 53px;
    left: 20px;
    top: 5px;
}
.tvod-timeTag .item_select .txt {
    color: #7cc9e6;
    text-decoration: underline;
}
/* E Tvod */


/* S mySpace */
.leftNav-e .item,
.leftNav-e .item .link,
.leftNav-e .item .link img,
.leftNav-e .item .txt {
    height: 40px;
    width: 144px;
}
.leftNav-e .item {
    left: 31px;
}
.leftNav-e .item .txt {
    font-size: 24px;
    height: 24px;
    text-align: center;
    left: 0px;
    top: 7px;
}
.leftNav-e .item_select {
    background: url("../images/lte-item_select.png") no-repeat;
}
.leftNav-e .item_select .txt {
    font-weight: bold;
}
/* E mySpace */

.playStatus {
    height: 40px;
    width: 300px;
    position: absolute;
    left: 865px;
    top: 35px;
}
.playStatus .icon {
    height: 40px;
    width: 40px;
    left: 260px;
    top: 0px;
}
.playStatus .txt {
    color: #f0f0f0;
    font-size: 30px;
    font-weight: bold;
    height: 30px;
    text-align: right;
    width: 240px;
    top: 0px;
    left: 0;
}





/* =S Css Reset
----------------------------------------------- */
body, div, h1, h2, h3, h4, h5, h6, button, input, textarea, th, td { margin:0px; padding:0px; }
body, div, button, input, select, textarea { font-size:16px; font-family: SimHei,sans-serif; line-height: 100%; }
h1, h2, h3, h4, h5, h6 { font-size: 100%; }
a { text-decoration: none; }
fieldset, img { border: 0px; }
button, input, select, textarea { font-size:100%; }

/* =S Global
----------------------------------------------- */
.item, .link, .txt-wrap, .txt, .btn, .icon, .pic, .pic-shade, .num, .win { position:absolute;}
.link { left: 0px; top: 0px; z-index:9;}
.txt { left: 0px; z-index:7;}
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
.logo-hubei {
	left:4px;
	position:absolute;
	top:3px;
}
.logo-cctv {
	left:555px;
	position:absolute;
	top:12px;
}
.logo-dx {
	left:520px;
	position:absolute;
	top:8px;
}
.txtLogo,
.txtDate {
	font-weight:bold;
}
.txtLogo {
	font-size:24px;
	left:78px;
	top:14px;
	width:160px;
}
.txtDate {
	left:252px;
	top:22px;
	width:120px;
}
.txtDate02 {
	font-size:16px;
	left:468px;
	top:11px;
	text-align:right;
	width:160px;
}
.weather {
	left:373px;
	position:absolute;
	top:12px;
}
.weather .txt {
	left:37px;
	top:10px;
	width:120px;
}
.txt-title {
	color:#ededed;
	font-size:26px;
	font-weight:bold;
	left:21px;
	top:16px;
	width:160px;
}
.txt-title-r {
	font-size:18px;
	left:441px;
	top:21px;
	text-align:right;
	width:180px;
}

/*index----------------------------------------------------*/
.menu {
	left:14px;
	position:absolute;
	top:52px;
}
.menu .item,
.menu .item .link,
.menu .item .link img,
.menu .item .txt {
	height:38px;
	width:68px;
} 
.menu .item .txt {
	color:#dbdbdb;
	font-size:22px;
	font-weight:bold;
	line-height:38px;
	text-align:center;
} 
.indexRecommend {
	left:9px;
	position:absolute;
	top:99px;
}
.indexRecommend .item,
.indexRecommend .item .link,
.indexRecommend .item .link img,
.indexRecommend .item .txt {
    height: 26px;
    width: 55px;
}
.indexRecommend .item .txt {
	font-size:20px;
	font-weight:bold;
	line-height:26px;
    text-align: center;
}
.indexRecommend .item .icon {
	background:url(../images/hot.png) no-repeat;
	left:45px;
	top:0;
    height: 18px;
    width: 28px;
	z-index:10;
}
.btnSpace {
	left:17px;
	position:absolute;
	top:272px;
}
.btnSpace .link,
.btnSpace .link img {
	height:30px;
    width:46px;
}
.btnSearch {
	left:72px;
	position:absolute;
	top:272px;
}
.btnSearch .link,
.btnSearch .link img {
	height:30px;
    width:46px;
}
.indexList {
	left:8px;
	position:absolute;
	top:309px;
}
.indexList .item,
.indexList .item .link,
.indexList .item .link img {
    height: 26px;
    width: 117px;
}
.indexList .item .txt {
	font-size:16px;
	font-weight:bold;
    height: 24px;
	line-height:26px;
	left:7px;
    width: 105px;
}
.indexVideo {
	left:128px;
	position:absolute;
	top:96px;
}
.indexVideo .link,
.indexVideo .link img,
.indexVideo .pic {
	height:262px;
    width:335px;
}
.indexVideo .btn {
	left:122px;
	top:85px;
	z-index:10;
}
.videoList {
	left:128px;
	position:absolute;
	top:96px;
}
.videoList .item,
.videoList .item .pic,
.videoList .item .pic img {
    height:128px;
    width:164px;
}
.videoList .item .txt-wrap {
	background:url(../images/tra80.png) no-repeat;
    height:30px;
	top:98px;
    width: 164px;
}
.videoList .item .txt-wrap .txt {
	color:#b4b4b5;
	font-size:22px;
	text-align:center;
    height:30px;
	line-height:30px;
    width: 164px;
}
.videoList-r {
	left:489px;
	position:absolute;
	top:98px;
}
.videoList-r .item,
.videoList-r .item .pic,
.videoList-r .item .pic img {
    height:128px;
    width:143px;
}
.videoList-r .item .txt-wrap {
	background:url(../images/tra80.png) no-repeat;
    height:30px;
	top:98px;
    width: 143px;
}
.videoList-r .item .txt-wrap .txt {
	color:#b4b4b5;
	font-size:22px;
	text-align:center;
    height:30px;
	line-height:30px;
    width: 143px;
}

/*bottom----------------------------------------------------*/
.notice {
	font-size:20px;
	left: 18px;
	position: absolute;
	top: 500px;
	height:22px;
	width:610px;
}

/*list----------------------------------------------------*/
.list {
	left:15px;
	position:absolute;
	top:90px;
}
.list .item,
.list .item .link,
.list .item .link img {
    height:28px;
    width:340px;
}
.list .item .icon {
	background:url(../images/icon-arrow.png) no-repeat;
    height:12px;
	left:10px;
	top:8px;
    width: 11px;
}
.list .item .txt {
	color:#3f3f3f;
	font-size:16px;
    height:28px;
	line-height:28px;
	left:30px;
    width: 300px;
}
.list-a {
	left:10px;
	position:absolute;
	top:71px;
}
.list-a .item { 
	/*background-color:#001622;*/
}
.list-a .item,
.list-a .item .link,
.list-a .item .link img {
    height:125px;
    width:305px;
}
.list-a .item .pic,
.list-a .item .pic img {
    height:125px;
    width:305px;
}
/*.list-a .item .pic {
	left:2px;
	top:2px;
}*/
.list-b {
	left:62px;
	position:absolute;
	top:99px;
}
.list-b .item,
.list-b .item .link,
.list-b .item .link img {
    height:155px;
    width:170px;
}
.list-c {
	left:119px;
	position:absolute;
	top:96px;
}
.list-c .item,
.list-c .item .link,
.list-c .item .link img,
.list-c .item .pic,
.list-c .item .pic img {
    height:162px;
    width:120px;
}
.list-c .item .txt-wrap {
	background:url(../images/txt-bg.png) no-repeat;
    height:23px;
	top:139px;
    width: 120px;
}
.list-c .item .txt-wrap .txt {
	font-size:20px;
	text-align:center;
    height:23px;
	line-height:23px;
    width: 120px;
}
.list-d {
	left:254px;
	position:absolute;
	top:198px;
}
.list-d .item,
.list-d .item .link,
.list-d .item .link img,
.list-d .item .pic,
.list-d .item .pic img {
    height:30px;
    width:46px;
}
.list-d .item .txt {
	color:#5a6b75;
	font-size:18px;
	font-weight:bold;
	text-align:center;
    height:30px;
	line-height:30px;
    width: 46px;
}
.list-d .item_select .txt {
	background:url(../images/txt-bg_select.png) no-repeat;
	color:#fff;
}
.list-e {
	left:310px;
	position:absolute;
	top:69px;
}
.list-e .item,
.list-e .item .link,
.list-e .item .link img {
	height:30px;
	width:271px;
}
.list-e .item .time,
.list-e .item .txt {
	color:#fff;
	font-size:20px;
	line-height:30px;
}
.list-e .item .time {
	left:19px;
	position:absolute;
	top:0;
	width:60px;
}
.list-e .item .txt {
	left:94px;
	width:175px;
}
.list-e .item_gray .time,
.list-e .item_gray .txt {
	color:#5c6f79;
}
.list-f {
	left:259px;
	position:absolute;
	top:357px;
}
.list-f .title {
	color:#ebebeb;
	font-size:20px;
    height:30px;
	line-height:30px;
    width: 90px;
}
.list-f .item { 
	left:133px;
	top:0;
}
.list-f .item .time,
.list-f .item .txt {
	color:#eaf2f7;
	line-height:30px;
}
.list-f .item .time {
	left:0;
	position:absolute;
	top:0;
	width:60px;
}
.list-f .item .txt {
	left:77px;
	width:135px;
}
.list-f .item_gray .time,
.list-f .item_gray .txt {
	color:#babece;
}

/*vod----------------------------------------------------*/
.nav {
	left:0;
	position:absolute;
	top:28px;
}
.nav .item {
	height:120px;
	width:110px;
} 
.nav .item .link,
.nav .item .txt {
	top:40px;
} 
.nav .item .link,
.nav .item .link img,
.nav .item .txt {
	height:40px;
	width:110px;
} 
.nav .item .txt {
	font-size:24px;
	line-height:40px;
	text-align:center;
} 
.nav .item_select {
	background:url(../images/nav-bg_focus.png) no-repeat;
} 
.nav .item_select .txt {
	color:#ffe827;
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
.nav-b {
	left:8px;
	position:absolute;
	top:85px;
}
.nav-b .item,
.nav-b .item .link,
.nav-b .item .link img,
.nav-b .item .txt {
	height:30px;
	width:49px;
} 
.nav-b .item .txt {
	font-size:20px;
	line-height:30px;
	text-align:center;
} 
.nav-b .item_select {
	background:url(../images/trans30.png) repeat;
} 
.nav-b .item_select .txt {
	color:#ffe827;
}
.nav-b .item_gray .txt {
	color:#989c9f;
}
.nav-c {
	left:57px;
	position:absolute;
	top:66px;
}
.nav-c .item,
.nav-c .item .link,
.nav-c .item .link img {
	height:30px;
	width:171px;
}
.nav-c .item .num {
	color:#698391;
	font-size:18px;
	line-height:30px;
	left:25px;
	position:absolute;
	top:0;
	width:36px;
}
.nav-c .item .txt {
	font-size:20px;
	line-height:30px;
	left:67px;
	width:105px;
}
.nav-c .item_select {
	background:url(../images/trans55.png) repeat;
} 
.nav-c .item_select .num,
.nav-c .item_select .txt {
	color:#ffe827;
}
.nav-d {
	left:56px;
	position:absolute;
	top:66px;
}
.nav-d .item .link,
.nav-d .item .link img {
	left:23px;
	height:30px;
	width:134px;
}
.nav-d .item .icon {
	top:2px;
	height:26px;
	width:26px;
}
.nav-d .item .num {
	color:#698391;
	font-size:18px;
	line-height:30px;
	left:26px;
	position:absolute;
	top:0;
	width:35px;
}
.nav-d .item .txt {
	font-size:20px;
	line-height:30px;
	left:61px;
	width:96px;
}
.nav-e {
	left:2px;
	position:absolute;
	top:76px;
}
.nav-e .item,
.nav-e .item .link,
.nav-e .item .link img,
.nav-e .item .txt {
	height:33px;
	width:52px;
} 
.nav-e .item .txt {
	font-size:20px;
	line-height:33px;
	text-align:center;
} 
.nav-e .item_select {
	background:url(../images/txt-bg02_select.png) repeat;
} 
/*.nav-e .item_select .txt {
	color:#ffe827;
}*/
.nav-e .item_gray .txt {
	color:#989c9f;
}
.nav-f {
	left:40px;
	position:absolute;
	top:28px;
}
.nav-f .item {
	left:15px;
}
.nav-f .item .link,
.nav-f .item .txt {
	top:2px;
}
.nav-f .item .link,
.nav-f .item .link img {
	height:33px;
	width:145px;
}
.nav-f .item .icon {
	left:147px;
	top:6px;
	height:26px;
	width:26px;
}
.nav-f .item .num {
	font-size:18px;
	line-height:33px;
	left:7px;
	position:absolute;
	top:0;
	width:40px;
}
.nav-f .item .txt {
	font-size:20px;
	line-height:30px;
	left:48px;
	width:90px;
}
.nav-f .line {
	background:url(../images/line.png) no-repeat;
	left:0;
	position:absolute;
	top:0;
	height:1px;
	width:165px;
}

/*live----------------------------------------------------*/
.video-live {
	left:217px;
	position:absolute;
	top:55px;
}
.video-live .link,
.video-live .link img,
.video-live .pic {
	height:295px;
    width:406px;
}
.video-live .btn {
	left:173px;
	top:115px;
	z-index:10;
}

/*bottom----------------------------------------------------*/
.bottom-a {
	background:url(../images/play-bottom01.png) no-repeat;
	left:0;
	position:absolute;
	top:450px;
	height:80px;
    width:640px;
	z-index:3;
}
.bottom-a .btn-fast {
	left:16px;
	position:absolute;
	top:28px;
}
.bottom-a .btn-fast .icon {
	top:5px;
}
.bottom-a .btn-fast .txt {
	color:#fff;
	font-size:18px;
	line-height:28px;
	left:24px;
	width:28px;
}
.txt-time {
	color:#fff;
	font-size:18px;
	line-height:28px;
	width:65px;
}
.bottom-a .progress-bar3 {
	left:125px;
	position:absolute;
	top:11px;
}
.bottom-a .progress-bar3 .bar {
	background:url(../images/progress-bar-bg.png) no-repeat;
	left:0;
	position:absolute;
	top:22px;
	height:19px;
    width:445px;
}
.bottom-b {
	background:url(../images/play-bottom02.png) no-repeat;
	left:0;
	position:absolute;
	top:399px;
	height:131px;
    width:640px;
	z-index:3;
}
.bottom-b .progress-bar3 {
	left:85px;
	position:absolute;
	top:3px;
}
.bottom-b .progress-bar3 .bar {
	background:url(../images/progress-bar-bg02.png) no-repeat;
	left:0;
	position:absolute;
	top:22px;
	height:19px;
    width:485px;
}
.bottom-b .txt-prompt {
	color:#ff0000;
	font-size:20px;
	text-align:center;
	top:48px;
	width:640px;
}
.form {
	left:120px;
	position:absolute;
	top:82px;
}
.form .txt {
	font-size:18px;
	line-height:30px;
	height:30px;
	width:22px;
}
.form .item  {
	left:125px;
}
.form .item .txt {
	height:30px;
    width:52px;
}
.form .item .txt {
	background-color:#ffffff;
	color:#000;
	font-size:20px;
	text-align:center;
}
.form .item_focus .txt {
	background:url(../images/input_focus.png) no-repeat;
}

.btn-a  {
	left:412px;
	position:absolute;
	top:82px;
}
.btn-a .item ,
.btn-a .item .txt {
	height:30px;
    width:56px;
}
.btn-a .item .txt {
	font-size:18px;
	line-height:30px;
	text-align:center;
}
.btn-a .item_focus {
	background:url(../images/btn-a_focus.png) repeat;
}
.left-layer {
	background:url(../images/left-bg.png) repeat;
	left:0;
	position:absolute;
	top:0;
	height:530px;
    width:295px;
	z-index:3;
}
.right-layer {
	background:url(../images/right-bg.png) repeat;
	left:345px;
	position:absolute;
	top:0;
	height:530px;
    width:295px;
	z-index:3;
}
.right-layer .txt {
	font-size:18px;
	left:120px;
	line-height:37px;
	width:165px;
}
.right-layer .txt-tit {
	font-size:24px;
	text-align:center;
	top:18px;
}
.right-layer .con {
	left:0;
	position:absolute;
	top:67px;
}
.right-layer .line {
	background:url(../images/line2.png) no-repeat;
	left:72px;
	position:absolute;
	top:0;
	height:1px;
	width:220px;
}

</style>
<style type="text/css"> 
<!--
body { background-color:#000; font-family:"Microsoft YaHei"; font-size:22px; color:#fff;  margin:0px; padding:0px; width:640px; height:530px; overflow:hidden; position:relative;}
body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,p,th,td {margin:0; padding:0}
pre,em,i,textarea,input,font{font-size:12px; font-weight:normal; font-style:normal}
img {border:0; margin:0}
button, input, select, textarea { font-size:100%;}
.pop_btns { 
	left:30px;
	position:absolute; 
	top:115px;  
	width:420px;
}
.pop_btns div {
	height:35px;
	line-height:35px;
	position:absolute;
	top:1px;
	text-align:center;
	width: 109px;
}
.pop_btns .btn02 { width:105px; visibility:hidden}
.pop_btns div.on2 { visibility:visible;}
.volume {
	background:url(../images/play/volume-bg.png) no-repeat;
	height:45px;
	line-height:45px;
	left:102px; 
	position:absolute; 
	top:455px;
	width:431px;
}
.volume div{
	left:0; 
	position:absolute; 
	top:0;
}
.volume div.on{
	background:url(../images/play/volume-bgon.jpg) repeat-x;
	border:solid 1px #262626;
	height:21px;
	left:48px; 
	position:absolute; 
	top:9px;
}

.mod-pop-box {
	background: url(../images/pop-365x176-1.png) no-repeat;
	height: 176px;
	width: 365px;
	position: absolute;
	left: 140px;
	top: 180px;
}
.smallmod-pop-box{
	background: url(../images/pop-245x176-1.png) no-repeat;
	height: 176px;
	width: 245px;
	position: absolute;
	left: 200px;
	top: 180px;

}

.bottom-ad {
	background: url(../images/t30.png);
	height: 109px;
	width: 420px;
	position: absolute;
	left: 110px;
	top: 371px;
}
.bottom-ad img {
	height: 103px;
	width: 414px;
	position: absolute;
	left: 3px;
	top: 3px;
}
.exit{
	height: 530px;
    width: 640px;
    position: absolute;
	left:0px;
}
.exitback{
    background: #0d4764 url(../images/body-page-end5.jpg) no-repeat;
}


.exitsticom {background: #0d4764 url(../images/body-page-tv-auto-end.jpg) no-repeat;}
.mod-tvAutoEnd .pic {
	height: 91px;
	width: 109px;
	left: 176px;
	top: 91px;
}
.mod-tvAutoEnd .txtTitle {
	color:#7cc9e6;
	font-size: 20px;
	left: 302px; top: 94px;
}
.mod-tvAutoEnd .txtNum {
	font-size: 24px;
	left: 302px; top: 132px;
}
.mod-tvAutoEnd .link {}

.pop-next {
	background: url("../images/pop-365x176-1.png") no-repeat;
	height: 176px;
	width: 365px;
	position: absolute;
	left: 140px;
	top: 178px;
}
.pop-next .txtTitle,
.pop-next .txtCont {
	height: 24px;
	text-align: center;
	width: 365px;
	position: absolute;
	left: 0px;
}
.pop-next .txtTitle {
	color: #7cc9e6;
	top: 24px;
}
.pop-next .txtCont {
	font-size: 26px;
	top: 65px;
}
.bottom01 {
	background:url(../images/bottom-bg01.png) repeat;
	left:0;
	position:absolute;
	top:461px;
	height:36px;
    width:640px;
	z-index:3;
}
.bottom02 {
	background:url(../images/bottom-bg02.png) repeat;
	left:0;
	position:absolute;
	top:496px;
	height:34px;
    width:640px;
	z-index:3;
}

.bottom02 .txt {
	font-size:18px;
	line-height:34px;
}

-->
</style>

<style>
.blueFont
{font:"黑体";color:#FFFFFF;font-size:16px; }
.whiteFont
{font:"黑体";color:#FFFFFF;font-size:16px;}
</style>
<%

String progId = request.getParameter("PROGID"); //vod节目id


//progId="1579865";


//progId="2065613";


int iProgId = 0;	
String fatherId = request.getParameter("FATHERSERIESID");
String playType = request.getParameter("PLAYTYPE"); //播放类型
playType="1";

int iPlayType = 0;	
String beginTime = request.getParameter("BEGINTIME"); //节目播放开始时间
String vasBeginTime = request.getParameter("beginTime");
String productId = request.getParameter("PRODUCTID"); //订购产品id	
String serviceId = request.getParameter("SERVICEID"); //对应服务id	
String price = request.getParameter("ONECEPRICE"); //该产品对应价格	
String contentType = request.getParameter("CONTENTTYPE");
String vasFlag = request.getParameter("vasFlag"); //增值页面标志位
String backurl = request.getParameter("backurl"); //如果是从增值服务页面进入的返回url
String typeId = request.getParameter("TYPE_ID");//栏目ID


//typeId="10000100000000090000000000033294";

String isChildren = request.getParameter("isChildren");
String type=request.getParameter("ECTYPE");
String poster = request.getParameter("POSTER");
int itype =0;
if(type != null && type !="" && type != "null")
{	
	itype=Integer.parseInt(type);
}	
String playUrl = ""; //触发机顶盒播放地址
int iPlayBillId = 0; //节目单编号（可选参数），仅当progId是频道时有效，此处只是为满足接口	
String endTime = request.getParameter("ENDTIME");
if(endTime == null || endTime=="" || "".equals(endTime) || "undefined".equals(endTime))
{
	endTime = "20000"; //播放结束时间
}
boolean isSucess = true;
/*******************对获取参数进行异常处理 start*************************/
try
{
	iProgId = Integer.parseInt(progId);
	iPlayType = Integer.parseInt(playType);
}
catch(Exception e)
{
	iProgId = -1;
	iPlayType = -1;
	isSucess = false;
}
if(fatherId == null || "".equals(fatherId) || "null".equals(fatherId) || "undefined".equals(fatherId)){fatherId = "-1";}
if(beginTime == null || "".equals(beginTime)|| "null".equals(fatherId)){beginTime = "0";}
if(productId == null || "".equals(productId)|| "null".equals(fatherId)){productId = "0";}
if(serviceId == null || "".equals(serviceId)|| "null".equals(fatherId)){serviceId = "0";}
if(price == null || "".equals(price)|| "null".equals(fatherId)){price = "0";}
if(contentType == null || "".equals(contentType)|| "null".equals(fatherId)){
	contentType =String.valueOf(EPGConstants.CONTENTTYPE_VOD);
}
String infoDisplay = "errorinfo.jsp?ERROR_TYPE=2&ERROR_ID=26&ECTYPE="+itype;
/*******************对获取参数进行异常处理 end*************************/
MetaData metaData = new MetaData(request);
ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
ServiceHelp serviceHelp = new ServiceHelp(request);
BookmarkImpl bookmarkImpl = new BookmarkImpl(request);//书签
int iShowDelayTime = 5000;
try{
	String showDelayTime = serviceHelp.getMiniEPGDelay ();
	iShowDelayTime = Integer.parseInt(showDelayTime)* 1000;
}catch(Exception e){
	iShowDelayTime = 8000;
}
/*************************获取播放url start**************************************/
if( "1".equals(vasFlag))//增值业务使用老接口
{
	playUrl = serviceHelp.getTriggerPlayUrl(iPlayType,iProgId,"0");
	playUrl = playUrl + "&playseek="+vasBeginTime+"-"+endTime;
	
}else{
//	playUrl = serviceHelpHWCTC.getTriggerPlayUrlHWCTC(iPlayType,iProgId,iPlayBillId,beginTime,endTime,productId,serviceId,contentType);
	
	
//	System.out.println("iPlayBillId="+iPlayBillId+"beginTime="+beginTime+"endTime="+endTime+"productId="+productId+"serviceId="+serviceId+"contentType"+contentType);
	
	//iPlayBillId=0beginTime=0endTime=20000productId=0serviceId=0contentType=10
	playUrl = serviceHelpHWCTC.getTriggerPlayUrlHWCTC(iPlayType,iProgId,-1,beginTime,endTime,"0","0","0");
}



//连续剧子集书签焦点记忆
if(!fatherId.equals("-1"))
{
	bookmarkImpl.addSitcomItem(progId,fatherId);		
}
if(playUrl != null && playUrl.length() > 0)
{
	int tmpPosition = playUrl.indexOf("rtsp");
	if(-1 != tmpPosition)
	{
		playUrl = playUrl.substring(tmpPosition,playUrl.length());
	
	}else{
		isSucess = false;
	}
}	
/*************************获取播放url end**************************************/
		
TurnPage turnPage = new TurnPage(request);

String goBackUrl = turnPage.go(-1);

if(backurl != null && ! "".equals(backurl))
{
	goBackUrl = backurl;
}
if(!isSucess)
{
	response.sendRedirect(infoDisplay);
}

System.out.println("******************************");
System.out.println(request.getParameter("backurl"));
System.out.println(request.getParameter("PROGID"));
System.out.println(request.getParameter("TYPE_ID"));
System.out.println("******************************");

%>

<script>

var KEY_DEL=1131;
var minEPGIsShowFlag=false;
var seekDivIsShowFlag=false;
var quitDivIsShow = false;
var preOrNextProgIsShow = false;
var processDivIsShowFlag = false;
var sitNum=""; //当前栏目vod的集数
var processLength = 0;
var timesLength = 0;
var totalMoveTimes = 10;
var timePreCell=0;
//每次移动的精度条的像素
var processPreCell=0;
//移动当前次数
var cruntMoveTimes = 0;
//快进快退进度条
//精度条总长度
var speedProcessLength = 445-19;
var speedTimesLength=0;
var speedCruntPlayTime=0;
var dowrSpeedProcessTime;
var speed=0;
var seekAreaFlag = 0;
var seekArea0Position = 0;
var seekArea1Position = 0;
var progNamePosition=0;

//输入框时
var bufInputH="";
//输入框分
var bufInputM="";


var preProgId="";
var nextProgId=""
var preProgNum="";
var nextProgNum="";
var vodName="";
var preProgName="";
var nextProgName=""; 
 
 


//var playUrl="rtsp://220.181.168.185:5541/mp4/2013henanfenghui/zhibo/cctv1.ts";
var playUrl="<%=playUrl%>";

var mp = new MediaPlayer();//播放器对象
var mediaStr = '[{mediaUrl:"'+ playUrl +'",';
mediaStr += 'mediaCode: "jsoncode1",';
mediaStr += 'mediaType:2,';
mediaStr += 'audioType:1,';
mediaStr += 'videoType:1,';
mediaStr += 'streamType:1,';
mediaStr += 'drmType:1,';
mediaStr += 'fingerPrint:0,';
mediaStr += 'copyProtection:1,';
mediaStr += 'allowTrickmode:1,';
mediaStr += 'startTime:0,';
mediaStr += 'endTime:20000,';
mediaStr += 'entryID:"jsonentry1"}]';

function $(strId)
{
	return document.getElementById(strId);
}



document.onkeypress = keyEvent;
function keyEvent()
{
	var val = event.which ? event.which : event.keyCode;
	return keypress(val);
}	

/**
*一键到尾
*/
function goEnd()
{
	mp.gotoEnd();
}
/**
*一键到头
*/
function goStart()
{
	mp.gotoStart();
}


function pressKey_pageUp()
{
	if(seekDivIsShowFlag==true||processDivIsShowFlag==true){return;}
	goStart();
}
	
function pressKey_pageDown()
{	
    if(seekDivIsShowFlag==true||processDivIsShowFlag==true){return;}
    goEnd();
}

function keypress(keyval)
{
	switch(keyval)
	{
		case <%=KEY_UP%>:return pressKey_up();		
		case <%=KEY_DOWN%>:return pressKey_down();	
		case <%=KEY_LEFT%>: return pressKey_left(); 
		case <%=KEY_RIGHT%>: return pressKey_right();			
		case <%=KEY_PAGEDOWN%>:return pressKey_pageDown();		
		case <%=KEY_PAGEUP%>:return pressKey_pageUp();	
		case <%=KEY_PAUSE_PLAY%>:
		case <%=KEY_POS%>:
			pauseOrPlay(); //case 271://定位键
			return 0;
			return false;
		 case <%=KEY_RETURN%>:
			pressKey_quit();  //退出时处理
			return 0;
		  case <%=KEY_STOP%>:
			pauseOrPlay();
			return 0;
	  case <%=KEY_VOL_UP%>:
			volumeUp();
			return false;
		case <%=KEY_VOL_DOWN%>:
			volumeDown();
			return false;
		 case <%=KEY_FAST_FORWARD%>:
			fastForward();
			return false;
		case <%=KEY_FAST_REWIND%>:
			fastRewind();
			return false;
		case <%=KEY_IPTV_EVENT%>:  
			goUtility();
			break;
		case <%=KEY_MUTE%>:setMuteFlag();return false;
		case <%=KEY_INFO%>:showMinEpg();return 0;
		case <%=KEY_OK%>:pressOk();return;
		case KEY_DEL:
		case 280:
        	if(seekDivIsShowFlag==true){delInputTime();}return 0;break;
		case <%=KEY_0%>:showInputTime(0);return false;
	    case <%=KEY_1%>:showInputTime(1);return false;
		case <%=KEY_2%>:showInputTime(2);return false;
		case <%=KEY_3%>:showInputTime(3);return false;
		case <%=KEY_4%>:showInputTime(4);return false;
		case <%=KEY_5%>:showInputTime(5);return false;
		case <%=KEY_6%>:showInputTime(6);return false;
		case <%=KEY_7%>:showInputTime(7);return false;
		case <%=KEY_8%>:showInputTime(8);return false;
		case <%=KEY_9%>:showInputTime(9);return false;
	}
	return true;
}




function pressKey_up()
{
	if(seekDivIsShowFlag==true)
	{
		if(seekAreaFlag==1)
		{
			$("seekArea1_"+seekArea1Position).className="item";
			seekArea0Position=0;
			$("seekArea0_"+seekArea0Position).src="../images/btn-point_focus.png";
			seekAreaFlag=0;
		  
		}
	}
	
}

function pressKey_down()
{
	if(seekDivIsShowFlag==true)
	{
		if(seekAreaFlag==0)
		{
			$("seekArea0_"+seekArea0Position).src="../images/btn-point.png";
			seekArea1Position=0;
			$("seekArea1_"+seekArea1Position).className="item item_focus";
			seekAreaFlag=1;
		}
	}
}

function pressKey_left()
{
	if(seekDivIsShowFlag==true)
	{
		if(seekAreaFlag==0)
		{
			seekArea0Position=0;
			$("seekArea0_"+seekArea0Position).src="../images/btn-point_focus.png";
			drowProcess(-1);
		
		}
		else
		{
			$("seekArea1_"+seekArea1Position).className="item";
			seekArea1Position--;
			if(seekArea1Position<0)
			{
				seekArea1Position=3;
			}
			$("seekArea1_"+seekArea1Position).className="item item_focus";
		}
	}else if(minEPGIsShowFlag==true)
	{
		$("preAProgName").focus();	
		progNamePosition=0;
	}
	else if(quitDivIsShow==true||preOrNextProgIsShow==true)
	{
		//不响应
	}
	else
	{
		fastRewind();
	}

}




function pressKey_right()
{
	if(seekDivIsShowFlag==true)
	{
		if(seekAreaFlag==0)
		{
			seekArea0Position=0;
			$("seekArea0_"+seekArea0Position).src="../images/btn-point_focus.png";
			drowProcess(1);
		
		}
		else
		{
			$("seekArea1_"+seekArea1Position).className="item";
			seekArea1Position++;
			if(seekArea1Position>3)
			{
				seekArea1Position=0;
			}
			$("seekArea1_"+seekArea1Position).className="item item_focus";
		}
	}
	else if(minEPGIsShowFlag==true)
	{
		$("nextAProgName").focus();	
		progNamePosition=1;
	}
	else if(quitDivIsShow==true||preOrNextProgIsShow==true)
	{
	    //不响应
	}
	else
	{
		fastForward();
	}
}


//快进
function fastForward()
{
	if(minEPGIsShowFlag==true)
	{
		hideMinEpg();
	}
	else if(seekDivIsShowFlag==true)
	{
		hideseekDiv();
	}
	if(speed>=32)
	{
		speed=1;
	}
	speed = speed * 2;
	$("speedIcon").src ="../images/icon-fast.png";
	$("speedText").innerHTML = speed+'X';	
	mp.fastForward(speed);
	if(dowrSpeedProcessTime!=undefined)
	clearTimeout(dowrSpeedProcessTime);
	dorwSpeedProcess();
	if(processDivIsShowFlag==false)
	{
	    showSpeedDiv();
	}
}





//快退
function fastRewind()
{
	if(minEPGIsShowFlag==true)
	{
		hideMinEpg();
	}
	else if(seekDivIsShowFlag==true)
	{
		hideseekDiv();
	}
	if(speed>=32)
	{
		speed=1;
	}
	speed = speed * 2;
	$("speedIcon").src ="../images/icon-rewind.png"
	$("speedText").innerHTML = speed+'X';	
	mp.fastRewind(-speed);
	if(dowrSpeedProcessTime!=undefined)
	clearTimeout(dowrSpeedProcessTime);
	dorwSpeedProcess();
	if(processDivIsShowFlag==false)
	{
	    showSpeedDiv();
	}
}





//画快进快退的进度条
function dorwSpeedProcess()
{
	speedTimesLength = mp.getMediaDuration();
	speedCruntPlayTime = mp.getCurrentPlayTime();
	$("speedBar").style.left=Math.floor((speedCruntPlayTime/speedTimesLength)*speedProcessLength)+"px";
	$("totalTime").innerHTML = convertTime(speedTimesLength);
	$("cruntSpeedPlayTime").innerHTML = convertTime(speedCruntPlayTime);
	dowrSpeedProcessTime = setTimeout(dorwSpeedProcess,5000);

}












//画暂停的精度条
function drowProcess(step)
{
	cruntMoveTimes=cruntMoveTimes+step;
	if(cruntMoveTimes>totalMoveTimes)
	{
		cruntMoveTimes=totalMoveTimes;
	}
	else if(cruntMoveTimes<0)
	{
		cruntMoveTimes=0;
	}
	$("processBor").style.left=Math.floor(processPreCell*(cruntMoveTimes))+"px";
	$("cruntTime").innerHTML = convertTime(Math.floor(timePreCell*(cruntMoveTimes)));

}

function jumpPreNextVod(stepvalue)
{
	if(stepvalue==0&&preProgId!=-1)
		{
			
			window.location.href="<%=tempProperBath%>play_controlVod.jsp?PROGID="+preProgId+"&PLAYTYPE=1"+"&TYPE_ID="+"<%=typeId%>"+"&backurl="+escape("<%=goBackUrl%>");
		}
		else if(stepvalue==1&&nextProgId!=-1)
		{
			
			window.location.href="<%=tempProperBath%>play_controlVod.jsp?PROGID="+nextProgId+"&PLAYTYPE=1"+"&TYPE_ID="+"<%=typeId%>"+"&backurl="+escape("<%=goBackUrl%>");
		}
}


function pressOk()
{
	if(seekDivIsShowFlag==false&&processDivIsShowFlag==false&&quitDivIsShow==false&&minEPGIsShowFlag==false)
	{
	    readyMinEpgData();	
	}
	else if(processDivIsShowFlag==true)
	{
		hiddenSpeedDiv();
		resume();
	}
	else if(minEPGIsShowFlag==true)
	{
		
	}
	else if(seekDivIsShowFlag==true)
	{
		var playTime=0;
		if(seekAreaFlag==0&&seekArea0Position==0)
		{
			playTime = Math.floor(timePreCell*(cruntMoveTimes));
			hideseekDiv();
			playByTime(playTime);
		}
		else if(seekAreaFlag==1&&seekArea1Position==2)
		{
			if(bufInputH.length==0)
			{
			    bufInputH="00";
			}
			
			if(bufInputM.length==0)
			{
				bufInputM="00"
			}
			 var hour = parseInt(bufInputH,10);
	         var mins = parseInt(bufInputM,10);	
		     playTime =  hour*3600 + mins*60;
			if(playTime>timesLength||playTime<0)
			{
				$("inputTimesError").style.display = "block";
				bufInputH="";
				bufInputM="";
				$("seekArea1Text_0").innerHTML="";
			    $("seekArea1Text_1").innerHTML="";
			}
			else
			{
				$("inputTimesError").style.display = "none";
				hideseekDiv();
				playByTime(playTime);
			}
		}
		else if(seekAreaFlag==1&&seekArea1Position==3)
		{
		     //输入框时
			bufInputH="";
			//输入框分
			bufInputM="";
			$("seekArea1Text_0").innerHTML="00";
			$("seekArea1Text_1").innerHTML="00";
		}
	}
}



function pressKey_quit()
{
	if(seekDivIsShowFlag==true)
	{
	    delInputTime();
	}
	else
	{
		if(processDivIsShowFlag==true)
		{
			hiddenSpeedDiv();
		}
		else if(seekDivIsShowFlag==true)
		{
			hideseekDiv();
		}
		
		showQuitDiv();
		pause();
	}
}


function showQuitDiv()
{
	if(quitDivIsShow == true){return;}
    $("quitDiv").style.display = "block";
	$("quit").focus()
	quitDivIsShow = true;
}

function hideQuitDiv()
{
	if(quitDivIsShow == false){return;}
	$("quitDiv").style.display = "none";
	quitDivIsShow = false;
}

function showInputTime(num)
{
	if(seekAreaFlag==1)
	{
		if(seekArea1Position==0)
		{
			if(bufInputH.length>=2)
			{
				$("seekArea1_0").className="item";
				$("seekArea1_1").className="item item_focus";
				seekArea1Position=1;
			}
			else
			{
				bufInputH = bufInputH+num;
			   $("seekArea1Text_0").innerHTML=bufInputH;
			}
		}
		else if(seekArea1Position==1)
		{
			if(bufInputM.length>=2)
			{
				$("seekArea1_1").className="item";
				$("seekArea1_2").className="item item_focus";
				seekArea1Position=2;
			}
			else
			{
				bufInputM = bufInputM+num;
			   $("seekArea1Text_1").innerHTML=bufInputM;
			}
		}
	}
}



function delInputTime()
{
	if(seekAreaFlag==1)
	{
		if(seekArea1Position==0)
		{
			bufInputH = bufInputH.substring(0,bufInputH.length-1)
			$("seekArea1Text_0").innerHTML=bufInputH;
		}
		else if(seekArea1Position==1)
		{
			bufInputM = bufInputM.substring(0,bufInputM.length-1)
			$("seekArea1Text_1").innerHTML=bufInputM;
		}
		else
		{
			resume();
		    hideseekDiv();
		}
	}
	else
	{
		resume();
		hideseekDiv();
	}
}





function volumeUp()
{
	if(seekDivIsShowFlag||processDivIsShowFlag){return true;}
	if(minEPGIsShowFlag){hideMinEpg();}
	var muteFlag =  mp.getMuteFlag();
	if(muteFlag == 1){mp.setMuteFlag(0);}
	volume = mp.getVolume();
	showVolumeTable();
	volume += 5;
	if(volume > 100){volume = 100;}
	//changeVolume(volume);
	mp.setVolume(volume);
	if(bottomTimer!=undefined)
	clearTimeout(bottomTimer);
	bottomTimer=setTimeout(hideVolumeTable, 3000);
}


//减小音量
function volumeDown()
{
	if(seekDivIsShowFlag||processDivIsShowFlag){return true;}
	if(minEPGIsShowFlag){hideMinEpg();}
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){mp.setMuteFlag(0);}
	volume = mp.getVolume();
	showVolumeTable();
	volume -= 5;
	if(volume <0){volume = 0;}
	//changeVolume(volume);
	mp.setVolume(volume);
	if(bottomTimer!=undefined)
	clearTimeout(bottomTimer);
	bottomTimer=setTimeout(hideVolumeTable, 3000);
}


function setMuteFlag()
{
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){
		mp.setMuteFlag(0);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0){
			$("voice").style.display = "none";
			var Timer;
			if(Timer!=undefined)
			Timer = setTimeout(hideMute, 5000);
		}
	}else{
		mp.setMuteFlag(1);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0){
			$("voice").style.display = "block";
			var Timer;
			if(Timer!=undefined)
			Timer = setTimeout(hideMute, 5000);
		}
	}
}




function pauseOrPlay()
{
    if(processDivIsShowFlag==true)
	{
		hiddenSpeedDiv();
		pause();
		showseekDiv();
    }
	else if(quitDivIsShow==true)
	{
		hideQuitDiv();
	}
    else if(minEPGIsShowFlag==true)
    {
	    hideMinEpg();
    }
    else if(seekDivIsShowFlag==false)
	{   
	    pause();
		readyseekDivData();
		showseekDiv();
	}else
	{
		resume();
		hideseekDiv();	
	}
}




function readyseekDivData()
{
	var mediaTime = mp.getMediaDuration();
	var cruntPlayTime = mp.getCurrentPlayTime();
	//prcess总像素
	processLength = 485-19;
	//影片总长度
	timesLength = mediaTime;
	//每次移动的时间的单元格
	timePreCell=timesLength/totalMoveTimes;
	//每次移动的精度条的像素
	processPreCell=processLength/totalMoveTimes;
	//当前所在的次数
	cruntMoveTimes = Math.ceil(cruntPlayTime/timePreCell);
	
	var endTime = convertTime(mediaTime);
	var cruntTime = convertTime(cruntPlayTime);
	$("processBor").style.left=processPreCell*(cruntMoveTimes)+"px";
	$("endTime").innerHTML = endTime;
	$("cruntTime").innerHTML = cruntTime;
}


function showseekDiv()
{
	$("seekArea0_"+seekArea0Position).src="../images/btn-point_focus.png";
	$("seekDiv").style.display = "block";
    seekDivIsShowFlag=true;
}

function hideseekDiv()
{
	seekAreaFlag = 0;
    seekArea0Position = 0;
	//输入框时
    bufInputH="";
    //输入框分
    bufInputM="";
	$("seekArea1_"+seekArea1Position).className="item";
	$("seekArea1Text_0").innerHTML=bufInputH;
	$("seekArea1Text_1").innerHTML=bufInputM;
	$("seekDiv").style.display = "none";
	seekDivIsShowFlag=false;
}



function showSpeedDiv()
{
	$("prcessDiv").style.display = "block";
    processDivIsShowFlag=true;
}

function hiddenSpeedDiv()
{
	speed=1;
	$("prcessDiv").style.display = "none";
    processDivIsShowFlag=false;
}

function cancel()
{
	resume();
	hideQuitDiv();
}
function quit()
{	
    mp.stop();
    antoQuit();
}
function antoQuit()
{
	window.location.href =unescape("<%=goBackUrl%>");
}



/**
*保存书签并退出
*/
function saveBookMark()
{
	 addBook();
}

//添加书签
function addBook()
{
	var progTime=mp.getCurrentPlayTime(); //读取当前播放的时间
	var endTime = mp.getMediaDuration(); //该vod播放时长
	var addBookUrl="<%=tempProperBath%>iframe/space_bookMarkAdd_iframedata.jsp?SUPVODID=<%=fatherId%>&PROGID=<%=progId%>&BEGINTIME="+progTime+"&ENDTIME="+endTime;
	$("addBookIframe").src=addBookUrl;
}

function getJson(num)
{
   window.location.href="<%=goBackUrl%>";
   
}

/**
*播放暂停
*/
function pause()
{
	mp.pause();
}
/**
*恢复播放
*/
function resume() 
{
	mp.resume(); 
}




function convertTime(_time)
{
	if(undefined == _time || _time.length == 0){_time = mp.getMediaDuration();}
	var returnTime = "";
	var time_second = "";
	var time_min = "";
	var time_hour = "";
	time_second = String(_time % 60);
	var tempIndex = -1;
	tempIndex = (String(_time / 60)).indexOf(".");
	if(tempIndex != -1)
	{
		time_min = (String(_time / 60)).substring(0,tempIndex);
		tempIndex = -1;
	}
	else{time_min = String(_time / 60);}
	tempIndex = (String(time_min / 60)).indexOf(".");
	if(tempIndex != -1)
	{
		time_hour = (String(time_min / 60)).substring(0,tempIndex);
		tempIndex = -1;
	}
	else{time_hour = String(time_min / 60);}
	time_min = String(time_min % 60);
	if("" == time_hour || 0 == time_hour){time_hour = "00";}
	if("" == time_min || 0 == time_min){time_min = "00";}
	if("" == time_second || 0 == time_second){time_second = "00";}
	if(time_hour.length == 1){time_hour = "0" + time_hour;}
	if(time_min.length == 1){time_min = "0" + time_min;}
	if(time_second.length == 1){time_second = "0" + time_second;}
	returnTime = time_hour + ":" + time_min + ":" + time_second;
	return returnTime;
}




















function initMediaPlay()
{
    var instanceId = mp.getNativePlayerInstanceID();
    var playListFlag = 0;
    var videoDisplayMode = 1,useNativeUIFlag = 1;
    var height = 0,width = 0,left = 0,top = 0;
    var muteFlag = 0;
    var subtitleFlag = 0;
    var videoAlpha = 0;
    var cycleFlag = 0;
    var randomFlag = 0;
    var autoDelFlag = 0;
    mp.initMediaPlayer(instanceId,playListFlag,videoDisplayMode,height,width,left,top,muteFlag,useNativeUIFlag,subtitleFlag,videoAlpha,cycleFlag,randomFlag,autoDelFlag);
	mp.setSingleMedia(mediaStr); //设置媒体播放器播放媒体内容
	/*
    mp.setNativeUIFlag(1); //0不使UI本地显示 		   1本地显示
    mp.setMuteUIFlag(1);  //0静音图标不显示			    1本地显示  
    mp.setAudioVolumeUIFlag(1);//设置音量调节本地UI的显示标志 0:不允许 1：允许
    mp.setAudioTrackUIFlag(1);
	mp.setProgressBarUIFlag(1);
    mp.setChannelNoUIFlag(1); //0不使频道号本地显示 		   1本地显示
	mp.setAllowTrickmodeFlag(0);//0允许媒体快进，快退，暂停  1本地控制
    mp.setVideoDisplayArea(0, 0, 0, 0);//全屏显示
    mp.setVideoDisplayMode(1); 
    mp.refreshVideoDisplay(); //调整视频显示，需要上面两函数配合
	*/
	mp.setNativeUIFlag(1); //0不使UI本地显示 		   1本地显示
    mp.setMuteUIFlag(1);  //0静音图标不显示			    1本地显示  
    mp.setAudioVolumeUIFlag(1);//设置音量调节本地UI的显示标志 0:不允许 1：允许
    mp.setAudioTrackUIFlag(1);
	mp.setProgressBarUIFlag(0);
    mp.setChannelNoUIFlag(0); //0不使频道号本地显示 		   1本地显示
	mp.setAllowTrickmodeFlag(0);//0允许媒体快进，快退，暂停  1本地控制
    mp.setVideoDisplayArea(0, 0, 0, 0);//全屏显示
    mp.setVideoDisplayMode(1); 
    mp.refreshVideoDisplay(); //调整视频显示，需要上面两函数
}

/**
*播放
*/
function play()
{
	/*if(isBookMark){ var type = 1,speed = 1;mp.playByTime(type,beginTime,speed);}
	else{mp.playFromStart();}*/
	mp.playFromStart();
}


/**
*页面加载结束后触发此函数
*/
function start()
{		
	initMediaPlay();		
	play();
	init();
}



function init()
{
	loadData();
}
	
/**
*获取数据
*/
function loadData()
{
	$("getDataIframe").src = "<%=tempProperBath%>play_controlVodData.jsp?progId="+"<%=iProgId%>"+"&categoryCode="+"<%=typeId%>";
}

function createMinEpg()
{
	setTimeout(readyMinEpgData,1000);
}
function readyMinEpgData()
{
	$("vodName").innerHTML ="正在播放:"+vodName;
	$("preProgName").innerHTML = preProgName;
	$("nextProgName").innerHTML = nextProgName;
	showMinEpg();
}


function showMinEpg()
{
	$("minEpgDiv1").style.display = "block";
	$("minEpgDiv2").style.display = "block";
	$("preAProgName").focus();
	minEPGIsShowFlag=true;
	var hideMinEpgTimer;
	if(hideMinEpgTimer!=undefined)
	clearTimeout(hideMinEpgTimer);
	hideMinEpgTimer=setTimeout(hideMinEpg,5000);
}

function hideMinEpg()
{
	$("preAProgName").focus();
	$("minEpgDiv1").style.display = "none";
	$("minEpgDiv2").style.display = "none";
	minEPGIsShowFlag=false;
}

function getVodTime()
{
	var time = '',hour = 0,minute = 0,second = 0;
	var totalSecond = mp.getMediaDuration();   
	if(totalSecond != "undefined" && second != null)
	{
		minute = Math.floor(totalSecond/60);
		second = totalSecond%60;
	}
	hour = Math.floor(minute/60);
	minute = minute%60;	
	if(hour < 10){hour = '0' + hour;}
	if(minute < 10){minute = '0' + minute;}
	if(second < 10){second = '0' + second;}
	time = hour + ':'+ minute + ':' + second;
	return time;
}

function playByTime(playTime)
{
	var type = 1;
	speed = 1;
	var playTime = parseInt(playTime);
	mp.playByTime(type,playTime,speed);
	mp.setVideoDisplayMode(1);
	mp.refreshVideoDisplay();
}



function unload()
{
   var instanceId = mp.getNativePlayerInstanceID();
	mp.stop();
	mp.releaseMediaPlayer(instanceId);
}
/**
*机顶盒事件响应
*/

function goUtility(){    
    	eval("eventJson = " + Utility.getEvent());
		var typeStr = eventJson.type;
    	switch(typeStr){
			case 'EVENT_FIRST_I_FRAME'://b700 V2U
    		case "EVENT_MEDIA_BEGINING":
		      if(processDivIsShowFlag==true)
			  {
				  hiddenSpeedDiv();
			  }
			break;
            case "EVENT_MEDIA_ERROR":
            //	goBack();
            	break;
            case "EVENT_MEDIA_END":
				playNextProg();
                break;
            default :
                return 1;
        }
        return 1;
}



function playNextProg()
{
	if(processDivIsShowFlag==true)
	{
		hiddenSpeedDiv();
	}
	
	if(nextProgId!=-1)
	{
		window.location.href="<%=tempProperBath%>play_controlVod.jsp?PROGID="+nextProgId+"&PLAYTYPE=1"+"&TYPE_ID="+"<%=typeId%>"+"&backurl="+escape("<%=goBackUrl%>");
	}
	else
	{
		window.location.href=unescape("<%=goBackUrl%>");
	}
}




</script>
</head>
<body bgcolor="transparent" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="background-color: transparent" onLoad="start()" onUnload="unload()">
 
   	<iframe id="getDataIframe"  style="width:0px;height:0px;border:0px;" ></iframe> 
      <%--记录书签-----------%>
    <iframe id="addBookIframe"  style="width:0px;height:0px;border:0px;" ></iframe> 
            
<!--音量键-->
<div id="volumeDiv" class="volume" style="display:none">
    <div style="width:320px;"><div id="volumeLen" class="on" style="width:1px;"></div></div> <!--总宽度为320px;也可以用100%-->
    <div id="volumeCur" style="left:380px; text-align:center; line-height:45px"></div>
</div>
<!--音量键-->              
           
<%--按暂停键后出现的模块begin-------------------------------%>
<div class="bottom-b" id="seekDiv" style="display:none">
	<div class="icon" style="left:0px; top:25px;"><img src="../images/icon-pause.png" alt="暂停" /></div>
	
	<div class="txt txt-time" style="left:18px;top:20px; text-align:right;">00:00:00</div> <!--已播放的时间-->
	<div class="txt txt-time" style="left:572px; top:20px;" id="endTime"></div> <!--总时间-->
	
	<div class="progress-bar3" style="top:3px;">
		<div class="txt txt-time" style="left:200px;" id="cruntTime"></div> <!--快进快退的时间-->
		<div class="bar">
        <!--<div class="btn" style="left:43px;"><img src="../images/btn-point_focus.png" /></div>--> <!--获得焦点时；left最大值：430px-->
			<div class="btn" style="left:0px;" id="processBor"><img id="seekArea0_0" src="../images/btn-point_focus.png" /></div> <!--left最大值：430px-->
		</div>
	</div>
	
	<div class="txt txt-prompt" style="color:#00F;display:none" id="inputTimesError">提示：输入超出设定范围，请重新输入</div>
	
	<div class="form">
		<div class="txt" style="width:130px;">输入定位时间：</div>
		<div class="item" id="seekArea1_0" style="position:absolute; left:125px">
			<div class="txt" id="seekArea1Text_0" style="color:#00F;"></div>
		</div>
		<div class="txt" style="position:absolute;left:179px;">时</div>
		<div class="item" style="position:absolute;left:201px;" id="seekArea1_1">
			<div class="txt" id="seekArea1Text_1" style="color:#00F;"></div>
		</div>    
		<div class="txt" style="position:absolute;left:255px;">分</div>
	</div>
	
	<div class="btn-a">
		<div class="item" id="seekArea1_2">
			<div class="txt">跳转</div>    
		</div>
		<div class="item" style="position:absolute;left:72px;" id="seekArea1_3">
			<div class="txt">重置</div>    
		</div>
	</div>
	
</div>
<%--按暂停键后出现的模块end---------------------------------%>

<div class="bottom-a"  id="prcessDiv" style="display:none">
	<div class="btn btn-fast" style="left:0px">
		<div class="icon"><img id="speedIcon" src="../images/icon-fast.png" alt="快进" /></div>
		<!--<div class="icon"><img src="../images/icon-rewind.png" alt="快退" /></div>-->
		<div class="txt" id="speedText">2X</div>
	</div>
	
	<div class="txt txt-time" style="left:55px;top:28px; text-align:right;">00:00:00</div> <!--已播放的时间-->
	<div class="txt txt-time" style="left:572px; top:28px;" id="totalTime">10:30</div> <!--总时间-->
	
	<div class="progress-bar3">
		<div class="txt txt-time" style="left:43px;" id="cruntSpeedPlayTime">09:15</div> <!--快进快退的时间-->
		<div class="bar">
			<div class="btn" style="left:0px;" id="speedBar"><img src="../images/btn-point_focus.png" /></div> <!--left最大值：430px-->
		</div>
	</div>
	
</div>
<%--音量begin-------------------------%>
<div id="voice" style="position:absolute; left:581px; top:15px; width:61px; height:89px; background:url(../images/mute.png);background-color:transparent; display:none;z-index:3;"></div>
<%--音量end---------------------------%>

<%-----------------------play-page-点播信息键--------------%>
<!--pop up layer

minEpgDiv1 minEpgDiv2 curNewName  curUpNewName curNextNewName
-->

<div class="bottom01" id="minEpgDiv1" style="display:none">
	<div class="txt" id="vodName" style="font-size:17px; left:20px; top:9px; width:480px;"></div>
	<div class="txt" style="font-size:17px; left:500px; top:9px; text-align:right; width:120px;"></div>
</div>
<div class="bottom02" id="minEpgDiv2" style="display:none">
	<div class="item">
		<div class="link"><a id="preAProgName" href="javascript:jumpPreNextVod(0);"><img src="../images/t.gif" width="320" height="34" /></a></div>
		<div class="icon" style="left:283px; top:5px;"><img src="../images/arrow-left.png" /></div>
		<div class="txt" id="preProgName" style="left:10px; width:270px;"></div>
	</div>
	<div class="item" style="left:320px;">
		<div class="link"><a  id="nextAProgName" href="javascript:jumpPreNextVod(1);"><img src="../images/t.gif" width="320" height="34" /></a></div>
		<div class="icon" style="left:10px; top:5px;"><img src="../images/arrow-r.png" /></div>
		<div class="txt" id="nextProgName" style=" left:39px; width:270px;"></div>
	</div>
</div>

<!--pop up layer the end-->
<div class="exit" id="quitDiv" style="display:none">
    <div class="smallmod-pop-box">
        <div class="btn btn-g-211x42-1" style="left:17px; top:14px;">
            <div class="link"><a id="bookmark" href="javascript:saveBookMark();"><img src="../images/t.gif" /></a></div>
            <div class="txt">加入书签并退出</div>
        </div>
        <div class="btn btn-ori-131x42-1" style="left:57px; top:65px;">
            <div class="link"><a id="quit" href="javascript:quit();"><img src="../images/t.gif" /></a></div>
            <div class="txt">结束观看</div>
        </div>
        <div class="btn btn-w-131x42-1" style="left:57px; top:115px;">
            <div class="link"><a id="cancel" href="javascript:cancel();"><img src="../images/t.gif" /></a></div>
            <div class="txt">继续观看</div>
        </div>
    </div>
</div>
  
<%--播放结束begin-------------------%>
<div class="exit exitback" id="endDiv" style="left:0px;top:0px;display:none;">

    <!-- S 倒计时文字 -->
    <div class="txt" style="color:#7cc9e6; height: 24px; width:640px; text-align: center; font-size:18px; top:266px;">5秒后自动返回</div>
    <!-- E 倒计时文字 -->

    <!-- S 广告部分 -->
    <!--<div class="mod-as-420x110-1" style="left: 110px; top: 370px;"><div class="pic"><a href="#"><img src="../images/demopic/pic-414x103.jpg" alt="广告位" /></a></div></div>-->
    <!-- E 广告部分 -->

</div>
<%--播放结束end---------------------%>

<%--错误提示开始层-------------%>
<div id="errorDiv" style="position:absolute; left:120px; top:200px; width:400px; height:80px; z-index:-1; display:none"> 
<img src="../images/errorBack.gif" width="400px" height="80px"/></div>
<div id="errorDiv2" style="position:absolute;left:120px;top:300px;width:400px;height:80px;z-index:1;display:none">
  <table align="center" width="400" align="center" height="80">
  <tr>
    <td class="whiteFont" align="center"> 系统错误，请按返回键退出或稍候再试！</td>
  </tr>
  </table>
</div>
<%--错误提示层结束-------------%>

<%--隐藏层begin----%>

  <%--获取数据-----------%>
</body>
</html>
