<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="datajsp/save_focus.jsp"%>
<%@ include file="datajsp/listdata.jsp"%>
<%@ include file="datajsp/menuName.jsp"%>
<%@ page import="com.huawei.iptvmw.epg.facade.service.UserRecordImpl" %>

<%
/*
* Date 20131219
* Author LS
* Dscription ��ȡ�û����Ż���
*/
UserRecordImpl recordServiceHelpHWCTC = new UserRecordImpl(request);
Map userRecord = new HashMap();
int iType = 3;          
try             
{ 
   userRecord = recordServiceHelpHWCTC.queryRewardPoints(iType);
}                       
catch(Exception e){

} 
int recordPoints = 0;
recordPoints =  (Integer)userRecord.get("AVAILABLE_TELE_REWARD_POINTS");
 
String returnurl = request.getParameter("returnurl")==null?"HD_index.jsp":request.getParameter("returnurl");
String topid = request.getParameter("topid")==null?"0":request.getParameter("topid");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页-深圳高清院线专区EPG3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="css/HDstyle.css" />
<style type="text/css">
<!--
	body{ background:url(images/bg03.jpg) no-repeat;}
-->
</style>
<script type="text/javascript" src="js/pagecontrol_1.0.4.js"></script>
<script type="text/javascript">
	var topid = <%=topid%>;
	var returnurl = "<%=returnurl%>";
	var numString = "";
	var areaid = 2;
	var indexid = 0;
	var curentpage = <%=curentpage%>;
	var headListData = [{cateURL:"HD_index.jsp?topid=0"},
						{cateURL:"list_pic.jsp?topid=0"},
						{cateURL:"list_pic.jsp?topid=1"},
						{cateURL:"list_pic.jsp?topid=2"},
						{cateURL:"list_pic.jsp?topid=3"},
						{cateURL:"list_pic.jsp?topid=4"},
						{cateURL:"list.jsp?topid=0"},
						{cateURL:"list.jsp?topid=1"}];
	var nameList = <%=jsonTypeInfo%>;
	var area0,area1,area2,area3;
	window.onload=function()
	{
		if(topid == 0){
			$("selectid_0").style.display = "block";
			}else{
				$("selectid_1").style.display = "block";
				}
		area0=AreaCreator(1,8,new Array(3,-1,1,-1),"nav0_list_","className:item","className:item");
		area0.slitherParam = new Array("area0_focus",0,0,146,0,1,30,0);
		area0.areaOkEvent = function(){
			var cateURL = headListData[area0.curindex].cateURL;
			saveFocstr(pageobj);
			window.location.href = cateURL+"&returnurl="+escape(window.location.href);
		}
		
		area1=AreaCreator(1,4,new Array(0,-1,2,-1),"nav1_list_","className:item item_focus","className:item");
		area1.areaOkEvent = function(){
			if(area1.curindex == 0){
				pageDown();
				}else if(area1.curindex == 1){
					pageUp();
					}else if(area1.curindex == 3){
						if(numString!=""&&numString.charAt(0)!=0&&numString.length<=4
						   &&numString>0&&numString<=area2.pagecount)
						{
							area2.curpage=parseInt(numString);
							curentpage = area2.curpage;
							numString="";
							$("nav1_list_3").innerHTML = numString;
							frame.location.href = "datajsp/listdata.jsp?isFirstFlag=1&topid="+topid+"&start="+(area2.curpage-1)*12;
						}
						else
						{
							numString="";
							$("nav1_list_3").innerHTML = numString;
						}
						}else{
							window.location.href = returnurl;
							}
			}
		area1.goBackEvent = function()
		{
			if(area1.curindex==3)
			{
				if(numString!="")
				{
					pageobj.backurl=undefined;
					numString=numString.substring(0,numString.length-1);
					$("nav1_list_3").innerHTML = numString;
				}
			}
			else
			{
			   pageobj.backurl=returnurl;
			}
		}
		var moveindex = topid + 6;
		area1.stablemoveindex = new Array("0-"+moveindex+",1-"+moveindex+",2-"+moveindex+",3-"+moveindex,-1,-1,-1);
		
		area2=AreaCreator(2,6,new Array(1,-1,-1,-1),"nav2_list_","className:item","className:item");
		area2.slitherParam=new Array("area2_focus",0,0,193,240,1,40,40);
		area2.endwiseCrossturnpage = true;
		area2.areaPageTurnEvent = function(num){
			if(num == -1){
				pageUp();
				}else{
					pageDown();
					}
			}
		
		for(var i = 0;i < area2.doms.length; i++){
			area2.doms[i].imgdom=$("nav2_img_"+i);
			}
		area2.curpage = curentpage;
		area2.pagecount = Math.ceil(contentTotal/12);
		
		if(focusObj!=undefined&&focusObj!="null"){
			 areaid = parseInt(focusObj[0].areaid);
			 indexid = parseInt(focusObj[0].curindex);
		   }
		area3=AreaCreator(1,2,new Array(-1,-1,0,-1),"jifen_","className:item item_focus","className:item");
				area3.doms[0].mylink = "order-monthly3.jsp?returnUrl="+escape(window.location.href);
                area3.doms[1].mylink = "../jifen/index.jsp?returnUrl=../hd_epg/HD_index.jsp";
		pageobj=new PageObj(areaid,indexid,new Array(area0,area1,area2,area3),null);
		pageobj.pageNumTypeEvent=function(num)
		{
			showPageNUM(num);
		}
		pageobj.backurl = returnurl;
		binddata(jsonList);
		initMenu(nameList);
	}
	function initMenu(data){
		$("nav0_txt_1").innerHTML = data.name1;
		$("nav0_txt_2").innerHTML = data.name2;
		$("nav0_txt_3").innerHTML = data.name3;
		$("nav0_txt_4").innerHTML = data.name4;
		$("nav0_txt_5").innerHTML = data.name5;
		$("nav0_txt_6").innerHTML = data.name6;
		$("nav0_txt_7").innerHTML = data.name7;
		}
	function binddata(data){
		area2.datanum = data.length;
		if(area2.curpage == 1){
			area1.doms[1].setCanFocus(false,2);
			if(pageobj.curareaid == 1 && area1.curindex == 1){
				pageobj.changefocus(1,0);
			}
			area1.doms[0].setCanFocus(true);
			}else if(area2.curpage == area2.pagecount){
				area1.doms[0].setCanFocus(false,1);
				if(pageobj.curareaid == 1 && area1.curindex == 0){
					pageobj.changefocus(1,1);
				}
				area1.doms[1].setCanFocus(true);
				}else if(area2.pagecount == 1){
					area1.doms[0].setCanFocus(false,2);
					area1.doms[1].setCanFocus(false,2);
					}else{
					area1.doms[0].setCanFocus(true);
					area1.doms[1].setCanFocus(true);
					}
		for(var i = 0;i < area2.doms.length; i++){
			if(data[i]!=null){
					   //area2.doms[i].setcontent("",data[i].VODNAME,36);
					   $("nav2_list_"+i).style.visibility = "visible";
					   area2.doms[i].youwannauseobj=data[i].VODID;
					   area2.doms[i].updateimg("../"+data[i].PICURL);
					   area2.doms[i].title = data[i].ISSITCOM;
					   area2.doms[i].domOkEvent=function()
					   {
						  var tempURL = "list.jsp?topid=<%=topid%>&curentpage=" + curentpage +"&start="+(area2.curpage-1)*12+"&returnurl="+escape(returnurl);
							
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
						area2.doms[i].updateimg("#");
						$("nav2_list_"+i).style.visibility = "hidden";
			   		}
			}
		if(data.length > 0){
			$("pagecontent").innerHTML = "页 "+area2.curpage+"/"+area2.pagecount+"页";
			}else{
				$("pagecontent").innerHTML = "";
				}
		}
	function showPageNUM(num)
	{
		if(pageobj.curareaid==1&&area1.curindex==3&&numString.length<4)
			{
				numString =numString+num;
				$("nav1_list_3").innerHTML = numString;
			}
	}
	function pageUp(){
		curentpage -= 1;
		if(curentpage < 1){curentpage = 1;area2.curpage = curentpage;return;}
		area2.curpage = curentpage;
		frame.location.href = "datajsp/listdata.jsp?isFirstFlag=1&topid="+topid+"&start="+(area2.curpage-1)*12;
		}
	function pageDown(){
		curentpage += 1;
		if(curentpage > area2.pagecount){curentpage = area2.pagecount;area2.curpage = area2.pagecount;return;}
		area2.curpage = curentpage;
		frame.location.href = "datajsp/listdata.jsp?isFirstFlag=1&topid="+topid+"&start="+(area2.curpage-1)*12;
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
<div class="btn btn-buy">
		<!--焦点 
				class="item item_focus"
		-->
		<div id="jifen_0" class="item"><!--特惠包月--></div>
		<div class="pic"><img src="images/buy01.png" /></div>
	</div>
	<div class="btn btn-shop">
		<!--焦点 
				class="item item_focus"
		-->
		<div id="jifen_1" class="item"><!--积分商城--></div>
		<div class="pic"><img src="images/buy02.png" /></div>
	</div>
	<div id="jifentxt" class="txt" style=" font-size:22px; color:#fff;left: 657px;top: 53px;width:65px;"><%=recordPoints%></div>

<!--head the end-->	



<!--menu-->	
<div class="menu">
	<div class="item item_focus" style="left:146px;visibility:hidden;" id="area0_focus"></div> <!--焦点移动层-->
	<!--焦点 
			class="item item_focus"
		选中
			class="item item_select"
	-->
	<div id="nav0_list_0" class="item">
		<div class="txt" id="nav0_txt_0">推荐</div>
	</div>
	<div id="nav0_list_1" class="item" style="left:146px;">
		<div class="txt" id="nav0_txt_1"></div>
	</div>
	<div id="nav0_list_2" class="item" style="left:292px;">
		<div class="txt" id="nav0_txt_2"></div>
	</div>
	<div id="nav0_list_3" class="item" style="left:438px;">
		<div class="txt" id="nav0_txt_3"></div>
	</div>
	<div id="nav0_list_4" class="item" style="left:584px;">
		<div class="txt" id="nav0_txt_4"></div>
	</div>
	<div id="nav0_list_5" class="item" style="left:729px;">
		<div class="txt" id="nav0_txt_5"></div>
	</div>
	<div id="nav0_list_6" class="item" style="left:875px;">
    	<div id="selectid_0" class="item item_select" style="display:none;"></div>
		<div class="txt" id="nav0_txt_6"></div>
    </div>
	<div id="nav0_list_7" class="item" style="left:1022px;">
        <div id="selectid_1" class="item item_select" style="display:none;"></div>
		<div class="txt" id="nav0_txt_7"></div>
    </div>
</div>
<!--menu the end-->		
	
	
	
<!--pages-->
	<div class="pages">
		<!--焦点 
			class="item item_focus"
		-->
		<div class="p01">
			<div id="nav1_list_0" class="item">
				<div class="icon"><img src="images/icon-next.png" /></div>
				<div class="txt">下 页</div>
			</div>
		</div>
		<div class="p02">
			<div id="nav1_list_1" class="item">
				<div class="icon"><img src="images/icon-prev.png" /></div>
				<div class="txt">上 页</div>
			</div>
		</div>
		<div class="p03">
			<div id="nav1_list_2" class="item">
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
			<div id="nav1_list_3" class="item"></div>
		</div>
		<div id="pagecontent" class="txt txt02"></div>
	</div>	
<!--pages the end-->	


	
<!--poster-->	
<div class="poster-d" style="left:67px; top:217px;">
	<div class="item item_focus" style="left:193px;top:240px;visibility:hidden;" id="area2_focus"><div class="link"></div></div> <!--焦点移动层-->
	<!--焦点 
		class="item item_focus"
	-->
	<div id="nav2_list_0" class="item">
		<div class="link"></div>
		<div class="pic"><img id="nav2_img_0" src="#" /></div>
	</div>
	<div id="nav2_list_1" class="item" style="left:193px;">
		<div class="link"></div>
		<div class="pic"><img id="nav2_img_1" src="#" /></div>
	</div>
	<div id="nav2_list_2" class="item" style="left:386px;">
		<div class="link"></div>
		<div class="pic"><img id="nav2_img_2" src="#" /></div>
	</div>
	<div id="nav2_list_3" class="item" style="left:579px;">
		<div class="link"></div>
		<div class="pic"><img id="nav2_img_3" src="#" /></div>
	</div>
	<div id="nav2_list_4" class="item" style="left:772px;">
		<div class="link"></div>
		<div class="pic"><img id="nav2_img_4" src="#" /></div>
	</div>
	<div id="nav2_list_5" class="item" style="left:965px;">
		<div class="link"></div>
		<div class="pic"><img id="nav2_img_5" src="#" /></div>
	</div>
	
	<div id="nav2_list_6" class="item" style="top:238px;">
		<div class="link"></div>
		<div class="pic"><img id="nav2_img_6" src="#" /></div>
	</div>
	<div id="nav2_list_7" class="item" style="left:193px;top:238px;">
		<div class="link"></div>
		<div class="pic"><img id="nav2_img_7" src="#" /></div>
	</div>
	<div id="nav2_list_8" class="item" style="left:386px;top:238px;">
		<div class="link"></div>
		<div class="pic"><img id="nav2_img_8" src="#" /></div>
	</div>
	<div id="nav2_list_9" class="item" style="left:579px;top:238px;">
		<div class="link"></div>
		<div class="pic"><img id="nav2_img_9" src="#" /></div>
	</div>
	<div id="nav2_list_10" class="item" style="left:772px;top:238px;">
		<div class="link"></div>
		<div class="pic"><img id="nav2_img_10" src="#" /></div>
	</div>
	<div id="nav2_list_11" class="item" style="left:965px;top:238px;">
		<div class="link"></div>
		<div class="pic"><img id="nav2_img_11" src="#" /></div>
	</div>
</div>
<!--poster the end-->
<div id="test" style="position:absolute; left:380px; top:39px; color:#FF0000; width: 374px; height: 28px;" ></div>			
<iframe name="frame" width="0px" height="0px"></iframe>
</body>
</html>
