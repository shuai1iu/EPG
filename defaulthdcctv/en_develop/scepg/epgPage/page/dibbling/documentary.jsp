<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../../config/properties.jsp"%>
<%
String strfile="../../../" + datajspname  + "/vodList.jsp";
String strFileCate="../../../" + datajspname  + "/categoryList.jsp";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>纪实- 四川央视概念版高清EPG4.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../../css/style.css" />
<link type="text/css" rel="stylesheet" href="../../css/dibbling.css" />
<style type="text/css">
<!--
	/*body{ background:url(../../images/) no-repeat;}*/
-->
</style>
	<%@ include file="../../../util/servertime.jsp"%>
	<%@ include file="../../../config/code.jsp"%>
    <%@ include file="../../base.jsp"%>
    <script type="application/javascript" src="../../js/MediaPlayer.js"></script>
    <script type="text/javascript">
	
	//顶部栏目
		<jsp:include page="<%=strFileCate%>">   
			<jsp:param name="parentCategoryCode" value="<%=documentaryCatagoryCode%>" /> 
			<jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="7" /> 
			<jsp:param name="varName" value="documentaryList" />
			<jsp:param name="fileds" value="-1" />
			<jsp:param name="isBug" value="1" />
		</jsp:include>
		
		//左侧三部影片
		<jsp:include page="<%=strfile%>">
			<jsp:param name="categoryCode" value="<%=documentaryLeftCode%>"/> 
			<jsp:param name="varName" value="leftContentList"/>
			<jsp:param name="fields" value="-1" /> 
			<jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="3" />
			<jsp:param name="isBug" value="1" />
		</jsp:include>
		
		//中间一部影片
		<jsp:include page="<%=strfile%>">
			<jsp:param name="categoryCode" value="<%=documentaryCenterCode%>"/> 
			<jsp:param name="varName" value="centerVodData"/>
			<jsp:param name="fields" value="-1" /> 
			<jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="1" />
			<jsp:param name="isBug" value="1" />
		</jsp:include>
		
		//底部影片一
		<jsp:include page="<%=strfile%>">
			<jsp:param name="categoryCode" value="<%=documentaryBottomCode_1%>"/> 
			<jsp:param name="varName" value="bottomVod_1"/>
			<jsp:param name="fields" value="-1" /> 
			<jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="1" />
			<jsp:param name="isBug" value="1" />
		</jsp:include>
		
		//底部影片二
		<jsp:include page="<%=strfile%>">
			<jsp:param name="categoryCode" value="<%=documentaryBottomCode_2%>"/> 
			<jsp:param name="varName" value="bottomVod_2"/>
			<jsp:param name="fields" value="-1" /> 
			<jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="1" />
			<jsp:param name="isBug" value="1" />
		</jsp:include>
		
		//底部影片三
		<jsp:include page="<%=strfile%>">
			<jsp:param name="categoryCode" value="<%=documentaryBottomCode_3%>"/> 
			<jsp:param name="varName" value="bottomVod_3"/>
			<jsp:param name="fields" value="-1" /> 
			<jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="1" />
			<jsp:param name="isBug" value="1" />
		</jsp:include>
		
		//底部影片四
		<jsp:include page="<%=strfile%>">
			<jsp:param name="categoryCode" value="<%=documentaryBottomCode_4%>"/> 
			<jsp:param name="varName" value="bottomVod_4"/>
			<jsp:param name="fields" value="-1" /> 
			<jsp:param name="pageIndex" value="1" /> 
			<jsp:param name="pageSize" value="1" />
			<jsp:param name="isBug" value="1" />
		</jsp:include>
	
	
		var curContent = new Array();
		curContent.push(leftContentList);
		curContent.push(centerVodData);
		curContent.push(bottomVod_1);
		curContent.push(bottomVod_2);
		curContent.push(bottomVod_3);
		curContent.push(bottomVod_4);
		var area0,area1,area2,area3;
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
			
			area0 = AreaCreator(1,7,new Array(-1,-1,2,-1),"area0_list_","className:item item_focus","className:item");
			for(var i=0;i<area0.doms.length;i++)
			{
				area0.doms[i].contentdom = $("area0_txt_"+i);
			}
			area0.areaOkEvent = function(){
				var catagoryName=documentaryList.categoryList[area0.curindex].name; 
				window.location.href="documentary-detail-1.jsp?parentCategoryCode="+documentaryList.categoryList[area0.curindex].parentCategoryCode+"&catagoryName="+catagoryName;
			}
			area1 = AreaCreator(3,1,new Array(-1,-1,3,2),"area1_list_","className:item item_focus","className:item");
			for(var i=0;i<area1.doms.length;i++)
			{
				area1.doms[i].contentdom = $("area1_txt_"+i);
			}
			area1.areaOkEvent = function(){
				$("gotoPlayIframe").src = "../iframe/gotoPlayIframe.jsp?programCode="+leftContentList.vodDataList[area1.curindex].programCode+"&contentCode="+leftContentList.vodDataList[area1.curindex].contentCode+"&categoryCode="+leftContentList.vodDataList[area1.curindex].categoryCode;
			}	
			area2 = AreaCreator(1,2,new Array(0,1,3,-1),"area2_list_","className:item item_focus","className:item");
			area2.stablemoveindex = new Array(-1,-1,"1-3>3",-1);
			area2.doms[1].domOkEvent = function(){
				$("gotoPlayIframe").src = "../iframe/gotoPlayIframe.jsp?programCode="+centerVodData.vodDataList[area2.curindex].programCode+"&contentCode="+centerVodData.vodDataList[area2.curindex].contentCode+"&categoryCode="+centerVodData.vodDataList[area2.curindex].categoryCode;
			}
			area3 = AreaCreator(1,4,new Array(1,-1,-1,-1),"area3_list_","className:item item_focus","className:item");
			area3.stablemoveindex = new Array("0-1>2,1-2>0,2-2>0,3-2>1",-1,-1,-1);
			for(var i=0;i<area3.doms.length;i++)
			{
				area3.doms[i].contentdom = $("area3_txt_"+i);
			}
			area3.doms[0].domOkEvent = function(){
				$("gotoPlayIframe").src = "../iframe/gotoPlayIframe.jsp?programCode="+bottomVod_1.vodDataList[0].programCode+"&contentCode="+bottomVod_1.vodDataList[0].contentCode+"&categoryCode="+bottomVod_1.vodDataList[0].categoryCode;
			}
			area3.doms[1].domOkEvent = function(){
				$("gotoPlayIframe").src = "../iframe/gotoPlayIframe.jsp?programCode="+bottomVod_2.vodDataList[0].programCode+"&contentCode="+bottomVod_2.vodDataList[0].contentCode+"&categoryCode="+bottomVod_2.vodDataList[0].categoryCode;
			}
			area3.doms[2].domOkEvent = function(){
				$("gotoPlayIframe").src = "../iframe/gotoPlayIframe.jsp?programCode="+bottomVod_3.vodDataList[0].programCode+"&contentCode="+bottomVod_3.vodDataList[0].contentCode+"&categoryCode="+bottomVod_3.vodDataList[0].categoryCode;
			}
			area3.doms[3].domOkEvent = function(){
				$("gotoPlayIframe").src = "../iframe/gotoPlayIframe.jsp?programCode="+bottomVod_4.vodDataList[0].programCode+"&contentCode="+bottomVod_4.vodDataList[0].contentCode+"&categoryCode="+bottomVod_4.vodDataList[0].categoryCode;
			}
			pageobj = new PageObj(0,0,new Array(area0,area1,area2,area3));	
			pageobj.backurl = OperatorFocus.getLastReturn();
			pageobj.pageOkEvent=function()
			{
				OperatorFocus.saveFocstr(pageobj);
			};
			pageInit();
		}
		
		function gotoPlay(vodInfoData){
			var returnUrl=window.location.href;
			window.location.href="../vodPlayer/vodPlayer.jsp?ParentContentCode="+curContent[pageobj.curareaid].vodDataList[pageobj.areas[pageobj.curareaid].curindex].contentCode+"&programType=1&ParentProgramCode="+vodInfoData.programCode+"&programCode="+vodInfoData.programCode+"&contentCode="+vodInfoData.contentCode+"&returnUrl="+escape(returnUrl)+"&categoryCode="+vodInfoData.categoryCode+"&definition="+vodInfoData.definition;
		}
		
		function indexPlay(){
			userchannelid="20";
			play(184,149,591,339);
		}
		function destoryMP()
		{
			mp.stop();
		}
		
		function pageInit(){
			
			//栏目绑定
			var documentaryList_Length = documentaryList.categoryList.length;
			area0.datanum = documentaryList_Length;
			if(documentaryList_Length>0)
			{
				for(var i=0;i<8;i++)
				{
					if(i<documentaryList_Length)
						area0.doms[i].setcontent("",documentaryList.categoryList[i].name,8,true,false);
					else
						$("area0_list_"+i).style.visibility = "hidden";
			    };
			};	
			
			//左侧三部影片海报
			for(i=0;i<3;i++){
				area1.doms[i].setcontent("",leftContentList.vodDataList[i].name,10,true,false);
				$("area1_img_"+i).src = leftContentList.vodDataList[i].pictureList.poster;
			}
			
			//中间一部影片海报
			$("area2_img_"+1).src = centerVodData.vodDataList[0].pictureList.poster;
			
			//底部四部影片数据绑定
			area3.doms[0].setcontent("",bottomVod_1.vodDataList[0].name,18,true,false);
			$("area3_img_0").src = bottomVod_1.vodDataList[0].pictureList.poster;
			
			area3.doms[1].setcontent("",bottomVod_2.vodDataList[0].name,18,true,false);
			$("area3_img_1").src = bottomVod_2.vodDataList[0].pictureList.poster;
			
			area3.doms[2].setcontent("",bottomVod_3.vodDataList[0].name,18,true,false);
			$("area3_img_2").src = bottomVod_3.vodDataList[0].pictureList.poster;
			
			area3.doms[3].setcontent("",bottomVod_4.vodDataList[0].name,18,true,false);
			$("area3_img_3").src = bottomVod_4.vodDataList[0].pictureList.poster;
		}
	</script>
</head>

<body bgcolor="transparent" onUnload="destoryMP()">

	<iframe src="" width="1px;" height="1px" id="gotoPlayIframe"></iframe>

<!--pagebg-->
<div class="pagebg">
	<div class="pic"><img src="../../images/bg-doc01.jpg" width="189" height="493" /></div>
	<div class="pic" style="left:189px;"><img src="../../images/bg-doc02.jpg" width="1091" height="154" /></div>
	<div class="pic" style="left:780px;top:154px;"><img src="../../images/bg-doc03.jpg" width="500" height="339" /></div>
	<div class="pic" style="top:493px;"><img src="../../images/bg-doc04.jpg" width="1280" height="227" /></div>
</div>
<!--pagebg the end-->



<div class="wrapper">

	<!--menu-->
	<div class="menu-d">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area0_list_0">
			<div class="txt" id="area0_txt_0"></div>
		</div>
		<div class="item" style="left:152px;" id="area0_list_1">
			<div class="txt" id="area0_txt_1"></div>
		</div>
		<div class="item" style="left:304px;" id="area0_list_2">
			<div class="txt" id="area0_txt_2"></div>
		</div>
		<div class="item" style="left:456px;" id="area0_list_3">
			<div class="txt" id="area0_txt_3"></div>
		</div>
		<div class="item" style="left:608px;" id="area0_list_4">
			<div class="txt" id="area0_txt_4"></div>
		</div>
		<div class="item" style="left:760px;" id="area0_list_5">
			<div class="txt" id="area0_txt_5"></div>
		</div>
		<div class="item" style="left:912px;" id="area0_list_6">
			<div class="txt" id="area0_txt_6"></div>
		</div>
	</div>
	<!--menu the end-->		
	
	
	
	<!--list-pic & Left-->
	<div class="list-pic-t">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area1_list_0">
			<div class="pic"><img id="area1_img_0" src="" /></div>
			<div class="txt" id="area1_txt_0"></div>
		</div>
		<div class="item" style="top:131px;" id="area1_list_1">
			<div class="pic"><img id="area1_img_1" src="" /></div>
			<div class="txt" id="area1_txt_1"></div>
		</div>
		<div class="item" style="top:262px;" id="area1_list_2">
			<div class="pic"><img id="area1_img_2" src="" /></div>
			<div class="txt" id="area1_txt_2"></div>
		</div>
	</div>
	<!--list-pic & Left the end-->		
	
	
	
	<!--video-->
	<div class="video-doc">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area2_list_0">
			<div class="pic"><!--<img src="../../images/demopic/video-591X339.jpg" />--></div>
			<div class="btn"><!--<img src="../../images/play.png" />--></div>
		</div>
	</div>
	<!--video the end-->		
	
	
	
	<!--list-pic & r-->
	<div class="list-pic-u">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area2_list_1">
			<div class="pic"><img id="area2_img_1" src="" /></div>
		</div>
	</div>
	<!--list-pic & r the end-->		
	
	
	
	
	<!--list-pic & bottom-->
	<div class="list-pic-v">
		<div class="txt txt-title05">热播纪实</div>
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area3_list_0">
			<div class="pic"><img id="area3_img_0" src="" /></div>
			<div class="txt" id="area3_txt_0"></div>
		</div>
	</div>
	<div class="list-pic-v" style="left:351px;">
		<div class="txt txt-title05">每日推荐</div>
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area3_list_1">
			<div class="pic"><img id="area3_img_1" src="" /></div>
			<div class="txt" id="area3_txt_1"></div>
		</div>
	</div>
	<div class="list-pic-v" style="left:662px;">
		<div class="txt txt-title05">微纪录</div>
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area3_list_2">
			<div class="pic"><img id="area3_img_2" src="" /></div>
			<div class="txt" id="area3_txt_2"></div>
		</div>
	</div>
	<div class="list-pic-v" style="left:973px;">
		<div class="txt txt-title05">引进专区</div>
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area3_list_3">
			<div class="pic"><img id="area3_img_3" src="" /></div>
			<div class="txt" id="area3_txt_3"></div>
		</div>
	</div>
	<!--list-pic & bottom the end-->		
	
	
	
</div>
	
</body>
</html>
