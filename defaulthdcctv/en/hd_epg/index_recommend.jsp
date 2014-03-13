<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="datajsp/save_focus.jsp"%>
<%@ include file="datajsp/recommdata.jsp"%>
<%
String returnurl = request.getParameter("returnurl")==null?"HD_index.jsp":request.getParameter("returnurl");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>推荐更多-深圳高清院线专区EPG3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="css/HDstyle.css" />
<style type="text/css">
<!--
	body{ background:url(images/bg02.jpg) no-repeat;}
-->
</style>
<script type="text/javascript" src="js/pagecontrol_1.0.4.js"></script>
<script type="text/javascript">
	var returnurl = "<%=returnurl%>";
	var curentpage = <%=curentpage%>;
	var numString = "";
	var area0,area1,area2;
	var areaid = 1;
	var indexid = 0;
	window.onload=function()
	{
		area0=AreaCreator(1,4,new Array(-1,-1,1,-1),"nav0_list_","className:item item_focus","className:item");
		//area0.setfocuscircle(1);
		area0.areaOkEvent = function(){
			if(area0.curindex == 0){
				pageDown();
				}else if(area0.curindex == 1){
					pageUp();
					}else if(area0.curindex == 3){
						if(numString!=""&&numString.charAt(0)!=0&&numString.length<=4&&numString>0&&numString<=area2.pagecount)
						{
							area2.curpage=parseInt(numString);
							curentpage = area2.curpage;
							numString="";
							$("nav0_list_3").innerHTML = numString;
							frame.location.href = "datajsp/populardata.jsp?isFirstFlag=1&start="+(area2.curpage-1)*9;
						}
						else
						{
							numString="";
							$("nav0_list_3").innerHTML = numString;
						}
						
						}else{
							window.location.href = returnurl;
							}
			}
		area0.goBackEvent = function()
		{
			if(area0.curindex==3)
			{
				if(numString!="")
				{
					pageobj.backurl=undefined;
					numString=numString.substring(0,numString.length-1);
					$("nav0_list_3").innerHTML = numString;
				}
			}
			else
			{
			   pageobj.backurl=returnurl;
			}
		}
		area1=AreaCreator(1,1,new Array(0,-1,-1,2),"nav1_list_","className:item item_focus","className:item");
		area1.doms[0].imgdom=$("area1_img_0");
		area1.curpage = curentpage;
		area1.pagecount =  Math.ceil(contentTotal/9);
		area1.stablemoveindex = new Array(-1,-1,-1,-1);
		
		area2=AreaCreator(2,4,new Array(0,1,-1,-1),"nav2_list_","className:item","className:item");
		area2.slitherParam=new Array("area2_focus",0,0,193,238,1,40,40);
		area2.stablemoveindex = new Array(-1,-1,-1,-1);
		area2.curpage = curentpage;
		area2.pagecount =  Math.ceil(contentTotal/9);
		area2.endwiseCrossturnpage = true;
		//area1.endwiseCrossturnpage = true;
		area1.areaPageTurnEvent = function(num){
			if(num == -1){
				pageUp();
				}else{
					pageDown();
					}
			}
		area2.areaPageTurnEvent = function(num){
			if(num == -1){
				pageUp();
				}else{
					pageDown();
					}
			}
		for(var i = 0;i < area2.doms.length; i++){
			area2.doms[i].imgdom=$("area2_img_"+i);
			}
			
		if(focusObj!=undefined&&focusObj!="null"){
			   areaid = parseInt(focusObj[0].areaid);
			   indexid = parseInt(focusObj[0].curindex);
		   }
		pageobj=new PageObj(areaid,indexid,new Array(area0,area1,area2),null);
		pageobj.backurl = returnurl;
		pageobj.pageNumTypeEvent=function(num)
		{
			showPageNUM(num);
		}
		
		binddata(tjList);
	}
	
	function binddata(data){
		area2.datanum = data.length - 1;
		if(area2.curpage == 1){
			area0.doms[1].setCanFocus(false,2);
			if(pageobj.curareaid == 0 && area0.curindex == 1){
				pageobj.changefocus(0,0);
			}
			area0.doms[0].setCanFocus(true);
			}else if(area2.curpage == area2.pagecount){
				area0.doms[0].setCanFocus(false,1);
				if(pageobj.curareaid == 0 && area0.curindex == 0){
					pageobj.changefocus(0,1);
				}
				area0.doms[1].setCanFocus(true);
				}else if(area2.pagecount == 1){
					area0.doms[0].setCanFocus(false,2);
					area0.doms[1].setCanFocus(false,2);
					}else{
					area0.doms[0].setCanFocus(true);
					area0.doms[1].setCanFocus(true);
					}
		if(data[0]!=null){
					   //area1.doms[0].setcontent("",data[0].VODNAME,36);
					   //$("nav2_list_"+i).style.visibility = "visible";
					   area1.doms[0].youwannauseobj=data[0].VODID;
					   area1.doms[0].updateimg("../"+data[0].PICURL);
					   area1.doms[0].title = data[0].ISSITCOM;
					   area1.doms[0].domOkEvent=function()
					   {
						  var tempURL = "index_recommend.jsp?curentpage=" + curentpage +"&start="+(area2.curpage-1)*9+"&returnurl="+escape(returnurl);
							
						   if(this.title == 0){
							   saveFocstr(pageobj);
							   window.location.href = "film_details.jsp?vodid=" + this.youwannauseobj + "&returnurl="+escape(tempURL);
							   }else{
								  saveFocstr(pageobj);
								   window.location.href = "tv_details.jsp?vodid=" + this.youwannauseobj + "&returnurl="+escape(tempURL);
								   }
						 
					   }
					 }else{
			   			//area1.doms[0].updatecontent("");
						area1.doms[0].updateimg("#");
						//$("nav2_list_0").style.visibility = "hidden";
			   		}
		for(var i = 1;i < area2.doms.length+1; i++){
			if(data[i]!=null){
					   //area2.doms[i].setcontent("",data[i].VODNAME,36);
					   $("nav2_list_"+(i-1)).style.visibility = "visible";
					   area2.doms[i-1].youwannauseobj=data[i].VODID;
					   area2.doms[i-1].updateimg("../"+data[i].PICURL);
					   area2.doms[i-1].title = data[i].ISSITCOM;
					   area2.doms[i-1].domOkEvent=function()
					   {
						  var tempURL = "index_recommend.jsp?curentpage=" + curentpage +"&start="+(area2.curpage-1)*9+"&returnurl="+escape(returnurl);
							
						   if(this.title == 0){
							   saveFocstr(pageobj);
							   window.location.href = "film_details.jsp?vodid=" + this.youwannauseobj + "&returnurl="+escape(tempURL);
							   }else{
								   saveFocstr(pageobj);
								   window.location.href = "tv_details.jsp?vodid=" + this.youwannauseobj + "&returnurl="+escape(tempURL);
								   }
						 
					   }
					 }else{
			   			//area2.doms[i].updatecontent("");
						area2.doms[i-1].updateimg("#");
						$("nav2_list_"+(i-1)).style.visibility = "hidden";
			   		}
			}
		    if(data.length > 0){
		    	$("pagecontent").innerHTML = "页 "+area2.curpage+"/"+area2.pagecount+"页";
				if(data.length==1){
					pageobj.changefocus(1,0);
					$("area3_focus").style.visibility = "hidden";
				}
			}else{
				$("pagecontent").innerHTML = "";
			}
			
		}
	function showPageNUM(num)
	{
		if(pageobj.curareaid==0&&area0.curindex==3&&numString.length<4)
			{
				numString =numString+num;
				$("nav0_list_3").innerHTML = numString;
			}
	}
	function pageUp(){
		curentpage -= 1;
		if(curentpage < 1){curentpage = 1;area2.curpage = curentpage;return;}
		area2.curpage = curentpage;
		frame.location.href = "datajsp/recommdata.jsp?isFirstFlag=1&start="+(area2.curpage-1)*9;
		}
	function pageDown(){
		curentpage += 1;
		if(curentpage > area2.pagecount){curentpage = area2.pagecount;area2.curpage = area2.pagecount;return;}
		area2.curpage = curentpage;
		frame.location.href = "datajsp/recommdata.jsp?isFirstFlag=1&start="+(area2.curpage-1)*9;
		}
</script>
</head>
<body>

<!--head-->
<div class="logo">
	<div class="pic"><img src="images/logo.png" /></div>
	<!--<div class="txt txt-a">高清院线</div> -->
</div>

<div class="adfont"><img src="images/adfont.png" /></div>
<!--head the end-->	



<!--head title-->	
	<div class="pic" style="left:71px; top:104px;"><img src="images/title02.png" /></div>
<!--head title the end-->		
	
	
	
	
<!--pages-->
	<div class="pages">
		<!--焦点 
			class="item item_focus"
		-->
		<div class="p01">
			<div id="nav0_list_0" class="item">
				<div class="icon"><img src="images/icon-next.png" /></div>
				<div class="txt">下 页</div>
			</div>
		</div>
		<div class="p02">
			<div id="nav0_list_1" class="item">
				<div class="icon"><img src="images/icon-prev.png" /></div>
				<div class="txt">上 页</div>
			</div>
		</div>
		<div class="p03">
			<div id="nav0_list_2" class="item">
				<div class="icon"><img src="images/icon-arrow.png" /></div>
				<div class="txt">返 回</div>
			</div>
		</div>
	</div>

	<!--form-->
	<div class="form">
		<div class="txt txt01">跳至</div>
			<!--焦点 
				class="item item_focus"
			-->
		<div class="input">
			<div id="nav0_list_3" class="item"></div>
		</div>
		<div id="pagecontent" class="txt txt02"></div>
	</div>	
<!--pages the end-->	


	
<!--poster-->	
<div class="poster-c">
	<!--焦点 
		class="item item_focus"
	-->
	<div id="nav1_list_0" class="item">
		<div class="link"></div>
		<div class="pic"><img id="area1_img_0" src="images/demopic/pic-333X441.jpg" /></div>
	</div>
</div>

<div class="poster-d">
	<div class="item item_focus" style="left:193px;top:238px;visibility:hidden;" id="area2_focus"><div class="link"></div></div> <!--焦点移动层-->
	<!--焦点 
		class="item item_focus"
	-->
	<div id="nav2_list_0" class="item">
		<div class="link"></div>
		<div class="pic"><img id="area2_img_0" src="images/demopic/pic-173X231.jpg" /></div>
	</div>
	<div id="nav2_list_1" class="item" style="left:193px;">
		<div class="link"></div>
		<div class="pic"><img id="area2_img_1" src="images/demopic/pic-173X231.jpg" /></div>
	</div>
	<div id="nav2_list_2" class="item" style="left:386px;">
		<div class="link"></div>
		<div class="pic"><img id="area2_img_2" src="images/demopic/pic-173X231.jpg" /></div>
	</div>
	<div id="nav2_list_3" class="item" style="left:579px;">
		<div class="link"></div>
		<div class="pic"><img id="area2_img_3" src="images/demopic/pic-173X231.jpg" /></div>
	</div>
	<div id="nav2_list_4" class="item" style="top:238px;">
		<div class="link"></div>
		<div class="pic"><img id="area2_img_4" src="images/demopic/pic-173X231.jpg" /></div>
	</div>
	<div id="nav2_list_5" class="item" style="left:193px;top:238px;">
		<div class="link"></div>
		<div class="pic"><img id="area2_img_5" src="images/demopic/pic-173X231.jpg" /></div>
	</div>
	<div id="nav2_list_6" class="item" style="left:386px;top:238px;">
		<div class="link"></div>
		<div class="pic"><img id="area2_img_6" src="images/demopic/pic-173X231.jpg" /></div>
	</div>
	<div id="nav2_list_7" class="item" style="left:579px;top:238px;">
		<div class="link"></div>
		<div class="pic"><img id="area2_img_7" src="images/demopic/pic-173X231.jpg" /></div>
	</div>
</div>
<!--poster the end-->		

<iframe name="frame" width="0px" height="0px"></iframe>
</body>
</html>
