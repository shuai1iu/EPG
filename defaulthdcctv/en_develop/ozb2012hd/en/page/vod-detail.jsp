<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视欧洲杯高清3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<%@ include file="util/save_focus.jsp"%>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="datajsp/vod-tv-detail_data.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<script type="text/javascript" src="../js/pagecontrolx.js"></script>
<script type="text/javascript" src="../js/EPGConstants.js"></script>
<script type="text/javascript">
	//--common var S
	//var areaid=(rsitcom=='null')?3:3;

	var area0,area1,area2,popup0;
	var isbookmark = false;   //判断是否存在书签
	var begintime,endtime;    //开始时间，结束时间
	var cur_progId;         //弹出层时，保存当前焦点
	var isfavsucc = -1; //用于判断收藏是否添加成功 0.添加失败(添加接口失败) 1.添加成功 2.收藏夹
	 
	//--common var E
   function getItmsByPage(cptitms,icurpage,ipagesize){
	var reclist=new Array();
	var start = (icurpage-1)*ipagesize;
	for(var i=0;i<ipagesize&&(i+(icurpage-1)*ipagesize)<cptitms.length;i++){
	     reclist[i]=cptitms[start+i];
	}
	
	return reclist;
  }
	
 
	//跳转播放地址
	function turnPlayurl(progId,fatherSeriesId,contentType,isPlayBookMark){
		var play_url = "au_PlayFilm.jsp?PROGID="+progId;
		play_url+="&FATHERSERIESID="+fatherSeriesId;
		play_url+="&CONTENTTYPE="+contentType;
		play_url+="&BUSINESSTYPE="+EPGConstants.BUSINESS_TYPE_VOD;
		if(false&&isPlayBookMark==0){
			play_url+="&PLAYTYPE="+EPGConstants.PLAY_TYPE_BOOKMARK;
			play_url+="&BEGINTIME="+begintime;
			play_url+="&ENDTIME="+endtime;
		}else if(true||isPlayBookMark==1){
			play_url+="&PLAYTYPE="+EPGConstants.PLAY_TYPE_VOD;
		}
		play_url+="&returnurl="+escape(location.href);
		//alert(play_url);
		location.href = play_url;
	}
	
	//common function S
	//添加收藏
	function addCollect(resultstr){
		isfavsucc = parseInt(resultstr);
		switch(isfavsucc){
			case 1:
				isfaved = true;						
				$("area0_img_0").src = "../images/btn-favorites-del.png";
			break;
	    	default:
				break;
		} 	   
	}
	
	//删除收藏
	function delCollect(resultstr){
		isfavsucc = parseInt(resultstr);
		switch(isfavsucc){
			case 1:
				isfaved = false;
				$("area0_img_0").src = "../images/btn-favorites.png";
				break;
			default:
				break;
		}
	}

	window.onload=function(){
		//--area0 S 上部按钮
		area0=AreaCreator(1,1,new Array(-1,-1,1,-1),"area0_list_","afocus","ablur");
		area0.doms[0].domOkEvent  = function(){
			if(!isfaved){
				getAJAXData("datajsp/space_collectAdd_iframedata.jsp?PROGID="+jContent.VODID+"&PROGTYPE="+jContent.CONTENTTYPE,addCollect);
			}else{
				getAJAXData("datajsp/space_collectDel_iframedata.jsp?PROGID="+jContent.VODID+"&PROGTYPE="+jContent.CONTENTTYPE,delCollect);
			}
		}
	
		
	
		area1=AreaCreator(1,9,new Array(0,-1,2,-1),"area1_link_","afocus","ablur");
		area1.stablemoveindex=new Array(0,-1,2,-1);
	
		for(var i=0;i<area1.doms.length;i++){
			area1.doms[i].contentdom=$('area1_content_'+i);
		}
		area1.areaOkEvent = function(){
			saveFocstr(pageobj); 
			cur_progId = this.doms[this.curindex].youwanaobj;
			turnPlayurl(cur_progId,pvodid,contentype,this.curindex);
		}
		area1.curpage = curpage;
		//--area1 E
		
		//--area2 S 推荐栏目
		area2=AreaCreator(1,6,new Array(1,-1,-1,-1),"area2_link_","afocus","ablur");
		
		for(i=0;i<area2.doms.length;i++) area2.doms[i].imgdom=$("area2_img_"+i);
	    area2.areaOkEvent=function(){
			saveFocstr(pageobj);
			location.href = "vod-detail.jsp?typeid=<%=recommendtypeid%>&vodid="+area2.doms[area2.curindex].youwanaobj+"&returnurl="+escape(location.href);
		}
			
		pageobj = new PageObj(new Array(area0,area1,area2));
		pageobj.backurl=returnurl;
	    
		bindContentData(jContent);
	    bindTuijData(json_aboutvods);
	    bindTvChooseData(getItmsByPage(jContent.SUBVODLIST,area1.curpage,area1.doms.length));
	
		pageobj.setinitfocus(areaid,indexid);
	}
</script>


<style type="text/css">
<!--
	body{ background:url(../images/bg2.jpg) no-repeat;}

-->
</style>
</head>

<body>

<!--head-->
	<div class="detail-catalog" id="catename"></div>
	<div class="detail-title" id="idetail">节目详情</div>
<!--the end-->




<!--介绍-->
<div class="detail-intro">
	<div class="con">
		<div class="txt01" id="vodName">名称</div>
	  
		<div class="txt02" style="top:72px;" id="vodItd">简介:</div>
	</div>
	<div class="btn">   
		<div class="item">
			<div class="link"><a href="#" id="area0_list_0"><img src="../images/t.gif" /></a></div>
			<div class="pic"><img id="area0_img_0" src="../images/btn-favorites.png" /></div>
		</div>
	</div>
	<div class="poster"> 
		<div class="item"><img id="vodPst" src="#" /></div>
	</div>
	<div class="num">   
		<div class="tit">集&nbsp;数</div>
		<div class="item" id="area1_list_0">
			<div class="link"><a href="#" id="area1_link_0"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area1_content_0"></div>
		</div>	
		<div class="item" style=" left:240px;" id="area1_list_1">
			<div class="link"><a href="#" id="area1_link_1"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area1_content_1"></div>
		</div>
		<div class="item" style=" left:340px;" id="area1_list_2">
			<div class="link"><a href="#" id="area1_link_2"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area1_content_2"></div>
		</div>
		<div class="item" style=" left:440px;" id="area1_list_3">
			<div class="link"><a href="#" id="area1_link_3"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area1_content_3"></div>
		</div>
		<div class="item" style=" left:540px;" id="area1_list_4">
			<div class="link"><a href="#" id="area1_link_4"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area1_content_4"></div>
		</div>
		<div class="item" style=" left:640px;" id="area1_list_5">
			<div class="link"><a href="#"  id="area1_link_5"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area1_content_5"></div>
		</div>
		<div class="item" style=" left:740px;" id="area1_list_6">
			<div class="link"><a href="#" id="area1_link_6"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area1_content_6"></div>
		</div>
		<div class="item" style=" left:840px;"  id="area1_list_7">
			<div class="link"><a href="#"  id="area1_link_7"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area1_content_7"></div>
		</div>
		<div class="item" style=" left:945px;"  id="area1_list_8">
			<div class="link"><a href="#"  id="area1_link_8"><img src="../images/t.gif" /></a></div>
			<div class="txt" id="area1_content_8"></div>
		</div>
	</div>
</div>
<!--the end-->

	
	
	
<!--推荐区节目-->
<div class="detail-recommend">  
	<div class="item" id="area2_list_0">
		<div class="link"><a href="#" id="area2_link_0"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img_0" src="#" /></div>
	</div>
	<div class="item" style="left:200px;"  id="area2_list_1">
		<div class="link"><a href="#" id="area2_link_1"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img_1" src="#" /></div>
	</div>
	<div class="item" style="left:400px;" id="area2_list_2">
		<div class="link"><a href="#"  id="area2_link_2"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img_2" src="#" /></div>	</div>
	
    <div class="item" style="left:600px;"  id="area2_list_3">
		<div class="link"><a href="#"  id="area2_link_3"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img_3" src="#" /></div>
	</div>
	<div class="item" style="left:800px;" id="area2_list_4">
		<div class="link"><a href="#"  id="area2_link_4"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img_4" src="#" /></div>
	</div>
	<div class="item" style="left:1000px;"  id="area2_list_5">
		<div class="link"><a href="#" id="area2_link_5"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area2_img_5"  src="#" /></div>
	</div>
</div>
<!--the end-->	
		
</body>
</html>
