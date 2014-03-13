<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>节目详情-多集- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<style type="text/css">
<!--
	body{ background:url(../../images/bg-d03.jpg) no-repeat;}
-->
</style>

<%@ include file="../../../config/properties.jsp"%>
<%
String programCode = request.getParameter("programCode")==null?"-1":request.getParameter("programCode");
String contentCode = request.getParameter("contentCode")==null?"-1":request.getParameter("contentCode");
String categoryCode = request.getParameter("categoryCode")==null?"-1":request.getParameter("categoryCode");
String strFile="../../../" + datajspname  + "/vodInfo.jsp";
String strFileVodList = "../../../" + datajspname  + "/vodList.jsp";
String strFavouriteFile="../../../" + datajspname  + "/checkFavourite.jsp";
%>
<%@ include file="../../datajsp/favoritedData.jsp"%>
<%@ include file="../../../config/code.jsp"%>
<%@ include file="../../base.jsp"%>
<script type="application/javascript">
	
	<jsp:include page="<%=strFile%>">
		<jsp:param name="programCode" value="<%=programCode%>" /> 
		<jsp:param name="contentCode" value="<%=contentCode%>" />
		<jsp:param name="categoryCode" value="<%=categoryCode%>" />
		<jsp:param name="varName" value="vodInfoData" /> 
		<jsp:param name="isBug" value="1" />
	</jsp:include>
	
	//右侧推荐影片
	<jsp:include page="<%=strFileVodList%>">
            <jsp:param name="categoryCode" value="<%=rightRecCode%>" /> 
		    <jsp:param name="varName" value="rightVodList" /> 
		    <jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="3" />
			<jsp:param name="fields" value="-1" />
			<jsp:param name="isBug" value="1" />
    </jsp:include>
	//判断是否有收藏
	<jsp:include page="<%=strFavouriteFile%>">             
		<jsp:param name="programCode" value="<%=programCode%>" />
		<jsp:param name="categoryCode" value="<%=categoryCode%>"/> 
		<jsp:param name="varName" value="tempFavourite"/>
		<jsp:param name="favoriteType" value="VOD" />
	</jsp:include>
	<%
		Boolean  tempFavourite = new Boolean("False");
		if(request.getAttribute("tempFavourite")!=null){
			tempFavourite = (Boolean)request.getAttribute("tempFavourite");
		}
	%>
	var isfaved=<%=tempFavourite%>;
	var area0,area1,area2,area3;
	var areaid = 0;
	var indexid = 0;
	window.onload = function(){
		window.focus();
		var focusObj=OperatorFocus.getCurFocusAndDelete();
		if(focusObj!=undefined && focusObj!="null" && focusObj!=null)
		{
			if(focusObj.focusdatas!=undefined && focusObj.focusdatas.length>0)
			{
				 areaid=focusObj.focusdatas[0].areaid;
				 indexid=focusObj.focusdatas[0].curindex;
			}
		}
		
		area0 = AreaCreator(1,3,new Array(-1,-1,1,3),"area0_list_","className:item item_focus","className:item");
		area0.doms[1].domOkEvent=function()
	    {
		   if(!isfaved)
		   {
			
			$("actionFrame").src="../iframe/spaceCollectAddIframe.jsp?programCode="+vodInfoData.programCode+"&favoriteType=VOD";
		   }
		   else
		   {
			
			$("actionFrame").src="../iframe/spaceCollectDelIframe.jsp?programCode="+vodInfoData.programCode+"&favoriteType=VOD";
		   }
		
	    }
		
		
		
		area1 = AreaCreator(1,4,new Array(0,-1,2,3),"area1_list_","className:item item_focus","className:item");
		area1.areaOkEvent = function(){
			var vodLength = vodInfoData.subVodList.length;
			if((area1.curindex+1) != area1.datanum){
				area2.datanum = 30;
			}else{
				area2.datanum = (vodLength!=0&&vodLength%30==0)?30:vodLength%30;
			}
			for(i=0;i<30;i++){
				$("area2_list_"+i).innerHTML = area1.curindex*30+(i+1)+"";
				if(i<area2.datanum){
					$("area2_list_"+i).style.visibility = "visible";
				}else{
					$("area2_list_"+i).style.visibility = "hidden";
				}
			}
		}
		
		area2 = AreaCreator(3,10,new Array(1,-1,-1,3),"area2_list_","className:item item_focus","className:item");
		area2.areaOkEvent = function(){
			//window.location.href = "../../../hwdatajsp/getPlayURL.jsp?type=CHAN&mediacode=3200&value=3200&contenttype=1";
			window.location.href = "../vodPlayer/vodPlayer.jsp?ParentContentCode=<%=contentCode%>&ParentProgramCode=<%=programCode%>&returnUrl="+escape(window.location.href)+"&totalSubVod="+vodInfoData.subVodList.length+"&programType=14&programCode="+vodInfoData.subVodList[area2.curindex].programCode+"&contentCode="+vodInfoData.subVodList[area2.curindex].contentCode+"&categoryCode="+vodInfoData.categoryCode+"&definition="+vodInfoData.definition;
		}
		area3 = AreaCreator(3,1,new Array(-1,0,-1,-1),"area3_list_","className:item item_focus","className:item");
		pageobj = new PageObj(areaid, indexid, new Array(area0,area1,area2,area3));
		pageobj.pageOkEvent=function(){
			   OperatorFocus.saveFocstr(pageobj);
		};
		//alert(OperatorFocus.getLastReturn());
		pageobj.backurl = OperatorFocus.getLastReturn();
		pageInit();
	}
	
	function pageInit(){
		vodInfoBind();
		if(!isfaved)
	    {
		    $("menu0").innerHTML = "收藏";
	    }
	    else
	    {
		    $("menu0").innerHTML = "移除";
	    }
	}
	
	//影片信息数据绑定
	function vodInfoBind(){
		$("poster").src = vodInfoData.pictureList.poster;
		$("vodName").innerHTML = vodInfoData.name;
		var vodPrice = vodInfoData.price;
		var vodPrice1,vodPrice2;
		if(vodPrice.indexOf(".")==-1){
			vodPrice1 = vodPrice;
			vodPrice2 = ".0";
		}else{
			vodPrice1 = vodPrice.substring(0,vodPrice.indexOf("."));
			vodPrice2 = vodPrice.substring(vodPrice.indexOf("."));
		}
		$("vodPrice").innerHTML = "售价：￥<span>"+vodPrice1+"</span>"+vodPrice2;
		$("direct").innerHTML = "<span>导演：</span>"+vodInfoData.directDisplay;
		$("actor").innerHTML = "<span>主演：</span>"+vodInfoData.actorDisplay;
		var vodDesc = vodInfoData.description.length>75?(vodInfoData.description.substring(0,75)+"..."):vodInfoData.description;
		$("description").innerHTML = "剧情简介："+vodDesc;
		
		var vodLength = vodInfoData.subVodList.length;
		$("vodTotal").innerHTML = "共"+vodLength+"集";
		area1.datanum = Math.ceil(vodLength/30)==0?1:Math.ceil(vodLength/30);
		for(i=0;i<area1.datanum;i++){
			$("area1_list_"+i).style.visibility = "visible";
		}
		area2.datanum = vodLength>30?30:vodLength;
		for(j=29;j>=area2.datanum;j--){
			$("area2_list_"+j).style.visibility = "hidden";
		}
		for(var i=0;i<4;i++){
			if(vodLength>i*30&&vodLength<=30*(i+1)){
				$("area1_list_"+i).innerHTML=(i*30+1)+"-"+vodLength;
		   }
	   }
	   
	   vodInit();//绑定相关推荐三部影片
	   	
	}
	
	function vodInit(){
		    //右相关推荐
			var rightVodListLength = rightVodList.vodDataList.length;
			for(i=0;i<rightVodListLength;i++){
			$("area3_img_"+i).src = rightVodList.vodDataList[i].pictureList.poster;
			};	
	}
	
	//添加收藏
    function addCollect(resultstr)
	{
	   isfavsucc = parseInt(resultstr.result);
	   isdofav();
    }

    //删除收藏
    function delCollect(resultstr)
    {
	   isfavsucc = parseInt(resultstr.result);
	   dodelfav();
    }
	
	
	function isdofav()
	{
	     switch(isfavsucc){
			case 0:
						//	$("div_fav0").innerHTML = "添加收藏失败，请稍候再试";
				 break;
			case 1:
				isfaved = true;					
				$("menu0").innerHTML = "移除";
						//	$("div_fav0").innerHTML = "节目已成功加入收藏";
						//	isfavsucc = -1;
						//	pageobj.popups[1].showme();
				break;
			case 2:
						//	$("div_fav0").innerHTML = "收藏夹已满，请删除后重试";
						//	pageobj.popups[1].showme();
				break;
				default:
				break;
				} 	   
	 }
	
	function dodelfav()
	{
		switch(isfavsucc){
		   case 0:
				//	$("div_fav0").innerHTML = "移除收藏失败，请稍候再试";
			    break;
			case 1:
				isfaved = false;
				$("menu0").innerHTML = "收藏";
					//pageobj.popups[1].showme();
					//isfavsucc = -1;
					//succ = -1;
					break;
			default:
					break;
		   }
	}
	
	
	
</script>
</head>

<body bgcolor="transparent">

<div class="wrapper">

	<!--head-->
	<div class="headline-shade">节目详情</div>
	<div class="headline">节目详情</div>
	<!--head the end-->
	
	
	
	<!--detail-->
	<div class="detail">
		<div class="pic pic-poster"><img id="poster" src="../../images/demopic/pic-269X385.jpg" /></div>
		<div class="txt txt01" id="vodName">甄嬛传</div>
		<div class="txt txt02" style="left:747px;" id="vodPrice">售价：￥<span>15</span>.0</div>
		<div class="txt txt03" style="top:50px;" id="direct"><span>导演：</span>沙恩·布莱克 </div>
		<div class="txt txt03" style="top:86px;" id="actor"><span>主演：</span>孙俪 / 陈建斌 / 蔡少芬 / 李东学 / 陶昕然 / 蒋欣</div>
		<div class="pic" style="left: 298px;top:140px;"><img src="../../images/line.png" width="600" height="1" /></div>
		<div class="txt txt03" style="top:150px;" id="description">剧情简介：该剧是一部宫廷情感大戏,更注重描写“后宫女人”的真实情感,剧中甄嬛从一个不谙世事单纯少女长为一个善于谋权的深宫妇人，凝结了千百年来无数后宫女子的缩影。</div>
	</div>
	
		<!--btns-->
		<div class="btn-a" style="top: 375px;">
			<!--焦点 
					class="item item_focus"
			-->
			<div class="item" id="area0_list_0">
				<div class="icon"><img src="../../images/icon01.png" /></div>
				<div class="txt">订购</div>
			</div>
			<div class="item" style="left:145px;" id="area0_list_1">
				<div class="icon"><img src="../../images/icon02.png" /></div>
				<div class="txt" id="menu0">收藏</div>
			</div>
		</div>
		
		<div class="btn-b" style="top: 375px;">
			<!--焦点 
					class="item item_focus"
				不可点
					class="item item_no"
			-->
			<div class="item item_no" id="area0_list_2">
				<div class="icon"><img src="../../images/icon03.png" /></div>
				<div class="txt">书签播放</div>
			</div>
		</div>
		
		<!--选集-->
		<div class="anthology">
			<div class="tv-sub">
				<!--焦点 
						class="item item_focus"
				-->
				<div class="item" id="area1_list_0" style="visibility:hidden">1-30</div>
				<div class="item" style=" left:90px;visibility:hidden" id="area1_list_1" >31-60</div>
				<div class="item" style=" left:190px;visibility:hidden" id="area1_list_2" >61-90</div>
                <div class="item" style=" left:290px;visibility:hidden" id="area1_list_3" >91-120</div>
				<div class="txt txt-all" id="vodTotal">共100集</div>
			</div>
			<div class="tv-num">
				<!--焦点 
						class="item item_focus"
				-->
				<div class="item" id="area2_list_0">1</div>
				<div class="item" style="left:55px;" id="area2_list_1">2</div>
				<div class="item" style="left:110px;" id="area2_list_2">3</div>
				<div class="item" style="left:165px;" id="area2_list_3">4</div>
				<div class="item" style="left:220px;" id="area2_list_4">5</div>
				<div class="item" style="left:275px;" id="area2_list_5">6</div>
				<div class="item" style="left:330px;" id="area2_list_6">7</div>
				<div class="item" style="left:385px;" id="area2_list_7">8</div>
				<div class="item" style="left:440px;" id="area2_list_8">9</div>
				<div class="item" style="left:495px;" id="area2_list_9">10</div>
				
				<div class="item" style="top:55px;" id="area2_list_10">11</div>
				<div class="item" style="left:55px;top:55px;" id="area2_list_11">12</div>
				<div class="item" style="left:110px;top:55px;" id="area2_list_12">13</div>
				<div class="item" style="left:165px;top:55px;" id="area2_list_13">14</div>
				<div class="item" style="left:220px;top:55px;" id="area2_list_14">15</div>
				<div class="item" style="left:275px;top:55px;" id="area2_list_15">16</div>
				<div class="item" style="left:330px;top:55px;" id="area2_list_16">17</div>
				<div class="item" style="left:385px;top:55px;" id="area2_list_17">18</div>
				<div class="item" style="left:440px;top:55px;" id="area2_list_18">19</div>
				<div class="item" style="left:495px;top:55px;" id="area2_list_19">20</div>
				
				<div class="item" style="top:110px;" id="area2_list_20">21</div>
				<div class="item" style="left:55px;top:110px;" id="area2_list_21">22</div>
				<div class="item" style="left:110px;top:110px;" id="area2_list_22">23</div>
				<div class="item" style="left:165px;top:110px;" id="area2_list_23">24</div>
				<div class="item" style="left:220px;top:110px;" id="area2_list_24">25</div>
				<div class="item" style="left:275px;top:110px;" id="area2_list_25">26</div>
				<div class="item" style="left:330px;top:110px;" id="area2_list_26">27</div>
				<div class="item" style="left:385px;top:110px;" id="area2_list_27">28</div>
				<div class="item" style="left:440px;top:110px;" id="area2_list_28">29</div>
				<div class="item" style="left:495px;top:110px;" id="area2_list_29">30</div>
			</div>
		</div>
	<!--detail the end-->
		
	
	
	<!--相关推荐 & r-->
	<div class="list-pic-g">
		<div class="txt txt-tit">相关推荐</div>
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item"  id="area3_list_0">
			<div class="pic"><img id="area3_img_0" src="../../images/demopic/pic-132X190.jpg" /></div>
		</div>
		<div class="item" style="top:260px;" id="area3_list_1">
			<div class="pic" ><img id="area3_img_1" src="../../images/demopic/pic-132X190.jpg" /></div>
		</div>
		<div class="item" style="top:480px;" id="area3_list_2">
			<div class="pic"><img id="area3_img_2" src="../../images/demopic/pic-132X190.jpg" /></div>
		</div>
		<div class="cover"><img src="../../images/cover.png" /></div>
	</div>
	
	<div class="btn-e">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item">
			<div class="btn btn-up"><!--向上--></div>
		</div>
		<div class="item item_focus" style="top:560px;">
			<div class="btn btn-down"><!--向下--></div>
		</div>
	</div>
	<!--相关推荐 & r the end-->	
	
</div>
<iframe id="actionFrame"  style="width:0px;height:0px;border:0px;" ></iframe>
</body>
</html>
