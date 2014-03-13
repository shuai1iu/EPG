<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<meta name="page-view-size" content="640*530"/>
<title>点播电视剧节目详情 | CCTV-IP电视</title>
<link rel="stylesheet" type="text/css" href="../css/style.css" />
<style type="text/css">
body {
    background: #0d4764 url("../images/body-page-common-detail-1.jpg") no-repeat;
}
.mod-movieCont .txt {
    font-size:18px;
    height: 30px;
}
.mod-movieCont .btn .txt {
    font-size: 20px;
}
.mod-movieCont .txt span.th {
    color: #a0a1a4;
}
.mod-movieCont .txtIntro {
    width:482px; height: 80px; left:118px; top:269px; line-height:24px; font-size:18px;
}
.mod-movieCont .txtPerformer {
    width:230px; height: 60px; left:118px; top:209px; line-height:24px; font-size:18px;
}
.mod-movieCont .pic {background-color:#062b42; left:480px; top:94px; width:115px; height:160px;}
.mod-movieCont .pic img {position:absolute; left: 3px; top:3px; width:109px; height: 154px;}

.mod-pop-box {
    background:url("../images/pop-432x218-2.png") no-repeat;
    height: 218px;
    width: 432px;
    position: absolute;
    left: 104px;
    top: 142px;
    z-index:12;
}
.mod-pop-box .txt2 {
    font-size: 20px;
    height: 24px;
    left:0;
    position:absolute;
    text-align: center;
    width: 432px;
    z-index:12;
}
</style>
<%@ include file="util/save_focus.jsp"%>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="datajsp/vod-tv-detail_data.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript" src="../js/EPGConstants.js"></script>
<script type="text/javascript">
	//--common var S
	var areaid=3;
	var indexid=(curindex=='null')?0:curindex;
	var area0,area1,area2,area3,popup0,popup1,bkm_area;
	var isbookmark = false;   //判断是否存在书签
	var begintime,endtime;    //开始时间，结束时间
	var cur_progId;         //弹出层时，保存当前焦点
	var isfavsucc = -1; //用于判断收藏是否添加成功 0.添加失败(添加接口失败) 1.添加成功 2.收藏夹已满
	//--common var E
	
	window.onload = function(){
		//--area0 S
		//area0 = AreaCreator(1,1,new Array(3,-1,1,-1),"area0_list_","className:btn btn-ori-91x42-1 onboder","className:btn btn-ori-91x42-1 offboder");
		//area0.areaOkEvent = function(){}
		//--area0 E
		
		//--area1 S
		//szgx hhr 删除书签按钮
		area1 = AreaCreator(1,1,new Array((isNeedToBuy?0:3),-1,3,-1),"area1_list_","className:btn btn-blue-91x42-1 onboder","className:btn btn-blue-91x42-1 offboder");
		area1.areaOkEvent = function(){
			if(!isfaved){
				getAJAXData("datajsp/space_collectAdd_iframedata.jsp?PROGID="+jContent.VODID+"&PROGTYPE="+jContent.CONTENTTYPE,addCollect);
			}else{
				getAJAXData("datajsp/space_collectDel_iframedata.jsp?PROGID="+jContent.VODID+"&PROGTYPE="+jContent.CONTENTTYPE,delCollect);
			}
		}
		//--area1 E
		
		//--area2 S
		//szgx hhr 删除书签按钮
		area2 = AreaCreator(1,1,new Array(1,-1,3,-1),"area2_list_","className:btn btn-g-91x42-1 onboder","className:btn btn-g-91x42-1 offboder");
		if(jContent.SUBVODLIST.length==1||true){
			area2.areaOkEvent = function(){			
				cur_progId = area3.doms[0].youwanaobj;
				getAJAXData("datajsp/check_bookmark.jsp?vodid="+cur_progId,checkBookmark);
			}
		}else{
			area2.areaOkEvent = function(){
				cur_progId = jContent.VODID;
				getAJAXData("datajsp/check_bookmarks.jsp?vodid="+cur_progId,checkBookmark);
			}
		}
		
		//--area2 S
		
		//--area3 S
		area3 = AreaCreator(2,6,new Array(1,-1,-1,-1),"area3_list_","className:btn btn-w-70x37-1 onboder","className:btn btn-w-70x37-1 offboder");
		for(var i=0;i<area3.doms.length;i++){
			area3.doms[i].contentdom=$('area3_content_'+i);
			area3.doms[i].bindFilmChoose = function(cname,cvodid){
				this.setcontent("",cname,13);
				this.dom[0].style.display = "block";
				this.youwanaobj = cvodid;
			}
		}
		area3.asyngetdata = function(dataurl) {
			bindTvChooseData(getItmsByPage(jContent.SUBVODLIST,area3.curpage,area3.doms.length));
		}
		area3.areaOkEvent = function(){
			cur_progId = this.doms[this.curindex].youwanaobj;
			getAJAXData("datajsp/check_bookmark.jsp?vodid="+cur_progId,checkBookmark);
		}
		area3.curpage = curpage;
		//--area3 E
		
		//--bkm_area S
		bkm_area = AreaCreator(1,2,new Array(-1,-1,-1,-1),new Array("bkm_area_btn_","bkm_area_txt_"),new Array("className:btn btn-w-91x42-1 onboder","className:btn btn-w-91x42-1 txt"),new Array("className:btn btn-w-91x42-1 txt","className:btn btn-w-91x42-1 txt"));
		bkm_area.areaOkEvent = function(){
			turnPlayurl(cur_progId,pvodid,contentype,this.curindex);
			popup1.closeme();
		}
		//--bkm_area E
		
		//--popup0 S
		popup0 = new Popup("fav_div");
	    popup0.closetime = 3;
		popup0.goBackEvent=function(){
		   this.closeme();
	    }
		//--popup0 E
		
		//--popup1 S
		 popup1 = new Popup("bkm_div",new Array(bkm_area));
	  	 popup1.goBackEvent=function(){
		   this.closeme();
	   	}
		//--popup2 E
		
		//--pageobj S
		pageobj = new PageObj(areaid,indexid, new Array(area0,area1,area2,area3),new Array(popup0,popup1));
		pageobj.backurl=returnurl;
		//--pageobj E
		
		//--binddatas S	
		bindContentData(jContent);
		if(jContent.SUBVODLIST.length>3){bindTvChooseData(getItmsByPage(jContent.SUBVODLIST,area3.curpage,area3.doms.length));}
		else if(jContent.SUBVODLIST.length<=3){bindFilmChooseData(jContent.SUBVODLIST);}
		//--binddatas E
	}
	
//common function S
//添加收藏
function addCollect(resultstr){
	isfavsucc = parseInt(resultstr);
	switch(isfavsucc){
		case 0:
			$("fav_div_status").innerHTML = "添加收藏失败，请稍候再试";
			pageobj.popups[0].showme();
			break;
		case 1:
			isfaved = true;						
			$("area1_content_0").innerHTML = "移除收藏";
			$("fav_div_status").innerHTML = "节目已成功加入收藏";
			isfavsucc = -1;
			pageobj.popups[0].showme();
			break;
		case 2:
			$("fav_div_status").innerHTML = "收藏夹已满，请删除后重试";
			pageobj.popups[0].showme();
			break;
		default:
			break;
	} 	   
}

//删除收藏
function delCollect(resultstr){
	isfavsucc = parseInt(resultstr);
	switch(isfavsucc){
		case 0:
			$("fav_div_status").innerHTML = "移除收藏失败，请稍候再试";
			pageobj.popups[0].showme();
			break;
		case 1:
			isfaved = false;
			$("fav_div_status").innerHTML = "节目已移除收藏";
			$("area1_content_0").innerHTML = "收&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;藏";
			pageobj.popups[0].showme();
			isfavsucc = -1;
			break;
		default:
			break;
	}
}

//查找书签
function checkBookmark(resultstr){
	var resultmsg = eval('('+resultstr+')');
	isbookmark = resultmsg.isbookmark;
	begintime = resultmsg.begintime;
	endtime = resultmsg.endtime;
	if(isbookmark==true){  //判断是否有书签
		pageobj.popups[1].showme();
	}else{
		turnPlayurl(cur_progId,pvodid,contentype,1);
	}
}

//跳转播放地址
function turnPlayurl(progId,fatherSeriesId,contentType,isPlayBookMark){
	var play_url = "au_PlayFilm.jsp?PROGID="+progId;
	play_url+="&FATHERSERIESID="+fatherSeriesId;
	play_url+="&CONTENTTYPE="+contentType;
	play_url+="&BUSINESSTYPE="+EPGConstants.BUSINESS_TYPE_VOD;
	if(isPlayBookMark==0){
		play_url+="&PLAYTYPE="+EPGConstants.PLAY_TYPE_BOOKMARK;
		play_url+="&BEGINTIME="+begintime;
		play_url+="&ENDTIME="+endtime;
	}else if(isPlayBookMark==1){
		play_url+="&PLAYTYPE="+EPGConstants.PLAY_TYPE_VOD;
	}
	play_url+="&returnurl="+escape(location.href);
	location.href = play_url;
}

function getItmsByPage(cptitms,icurpage,ipagesize){
	var reclist=new Array();
	var start = (icurpage-1)*ipagesize;
	for(var i=0;i<ipagesize&&(i+(icurpage-1)*ipagesize)<cptitms.length;i++){
	     reclist[i]=cptitms[start+i];
	}
	return reclist;
}
//common function E
</script>
</head>
<body>
<div class="wrapper">

    <!-- S 面包屑 -->
    <div class="mod-bread">
        <span id="catename"></span>节目详情
    </div>
    <!-- E 面包屑 -->

    <!-- 内容部分 -->
    <div class="txt" style="font-size:24px; width:530px; height:30px; left:62px; top:94px;" id="vodName"></div>

    <!-- S 图文描述部分 -->
    <div class="mod-movieCont">
        <div class="pic"><img width="109" height="154"  id="vodPst" src="" /></div>

        <!-- S 彩色按钮 -->
        <!--临时屏蔽订购-->
        <!--<div class="btn btn-ori-91x42-1" style="left:379px; top:97px;" id="area0_list_0">
            <div class="link"><img src="../images/t.gif" /></div>
            <div class="txt" id="area0_content_0">订&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;购</div>
        </div>-->
        <div class="btn btn-blue-91x42-1" style="left:379px; top:153px;" id="area1_list_0">
            <div class="link"><img src="../images/t.gif" /></div>
            <div class="txt" id="area1_content_0">收&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;藏</div>
        </div>
	<!--  szgx hhr 屏蔽书签按钮
        <div class="btn btn-g-91x42-1" style="left:379px; top:209px;" id="area2_list_0">
            <div class="link"><img src="../images/t.gif" /></div>
            <div class="txt" id="area2_content_0">书签播放</div>
        </div>
	-->
        <!-- E 彩色按钮 -->

        <div class="txt" style="width:180px; left:62px; top:150px;" id="vodPrice"></div>
        <div class="txt" style="width:200px; left:62px; top:180px;" id="vodDrt"></div>
        <div class="txt" style="width:160px; left:276px; top:180px;" id="vodSubcount"></div>
        <div class="txt" style="width:180px; left:62px; top:209px;"><span class="th">主演：</span></div>
        <div class="txt txtPerformer" id="vodAct"></div>
        <div class="txt" style="width:100px; left:62px; top:269px;"><span class="th">简介：</span></div>
        <div class="txt txtIntro" id="vodItd"></div>
    </div>
    <!-- E 图文描述部分 -->

    <!-- S 底部按钮 -->
    <div class="btn btn-w-70x37-1" style="left:118px; top:356px; display:none;" id="area3_list_0">
        <div class="link"><img src="../images/t.gif" /></div>
        <div class="txt" id="area3_content_0">1</div>
    </div>
    <div class="btn btn-w-70x37-1" style="left:198px; top:356px; display:none;" id="area3_list_1">
        <div class="link"><img src="../images/t.gif" /></div>
        <div class="txt" id="area3_content_1">2</div>
    </div>
    <div class="btn btn-w-70x37-1" style="left:278px; top:356px; display:none;" id="area3_list_2">
        <div class="link"><img src="../images/t.gif" /></div>
        <div class="txt" id="area3_content_2">3</div>
    </div>
    <div class="btn btn-w-70x37-1" style="left:358px; top:356px; display:none;" id="area3_list_3">
        <div class="link"><img src="../images/t.gif" /></div>
        <div class="txt" id="area3_content_3">4</div>
    </div>
    <div class="btn btn-w-70x37-1" style="left:438px; top:356px; display:none;" id="area3_list_4">
        <div class="link"><img src="../images/t.gif" /></div>
        <div class="txt" id="area3_content_4">5</div>
    </div>
    <div class="btn btn-w-70x37-1" style="left:518px; top:356px; display:none;" id="area3_list_5">
        <div class="link"><img src="../images/t.gif" /></div>
        <div class="txt" id="area3_content_5">6</div>
    </div>

    <div class="btn btn-w-70x37-1" style="left:118px; top:403px; display:none;" id="area3_list_6">
        <div class="link"><img src="../images/t.gif" /></div>
        <div class="txt" id="area3_content_6">7</div>
    </div>
    <div class="btn btn-w-70x37-1" style="left:198px; top:403px; display:none;" id="area3_list_7">
        <div class="link"><img src="../images/t.gif" /></div>
        <div class="txt" id="area3_content_7">8</div>
    </div>
    <div class="btn btn-w-70x37-1" style="left:278px; top:403px; display:none;" id="area3_list_8">
        <div class="link"><img src="../images/t.gif" /></div>
        <div class="txt" id="area3_content_8">9</div>
    </div>
    <div class="btn btn-w-70x37-1" style="left:358px; top:403px; display:none;" id="area3_list_9">
        <div class="link"><img src="../images/t.gif" /></div>
        <div class="txt" id="area3_content_9">10</div>
    </div>
    <div class="btn btn-w-70x37-1" style="left:438px; top:403px; display:none;" id="area3_list_10">
        <div class="link"><img src="../images/t.gif" /></div>
        <div class="txt" id="area3_content_10">11</div>
    </div>
    <div class="btn btn-w-70x37-1" style="left:518px; top:403px; display:none;" id="area3_list_11">
        <div class="link"><img src="../images/t.gif" /></div>
        <div class="txt" id="area3_content_11">12</div>
    </div>
    <!-- E 底部按钮 -->
	<div class="mod-paging-b" style="left: 332px; top:452px;" id="page"></div>
    
    <!-- S pop_up -->
    <div class="mod-pop-box" id="fav_div" style=" display:none;">
		<div class="txt2" style="top:90px;" id="fav_div_status"></div>
    </div>
    <!-- E pop_up -->
   
<!--popup 书签提示hwwebkit -->    
     <div class="mod-pop-box" id="bkm_div" style="display:none">
     	<div class="txt2" style="top:40px;">是否从书签处开始播放？</div>
		<div class="btn btn-w-91x42-1" style="left:80px; top:130px;" id="bkm_area_btn_0">
            <div class="link"><img src="../images/t.gif" /></div>
            <div class="txt" style="font-size:18px;" id="bkm_area_txt_0">书签播放</div>
        </div>
        <div class="btn btn-w-91x42-1" style="left:260px; top:130px;" id="bkm_area_btn_1">
            <div class="link"><img src="../images/t.gif" /></div>
            <div class="txt" style="font-size:18px;" id="bkm_area_txt_1">从头播放</div>
        </div>
    </div> 
</div>
</body>
</html>
