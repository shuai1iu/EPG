<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="datajsp/save_focus.jsp"%>
<%@ include file="datajsp/code.jsp"%>
<%@ include file="datajsp/indexdata.jsp"%>
<%@ page import="com.huawei.iptvmw.epg.facade.service.UserRecordImpl" %>

<%
String returnurl = request.getParameter("returnurl")==null?"../index.jsp":request.getParameter("returnurl");

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
 
UserProfile userProfile = new UserProfile(request);
String userid = userProfile.getUserId();
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页-深圳高清院线专区EPG3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="css/HDstyle.css" />
<style type="text/css">
<!--
	body{ background:url(images/bg01.jpg) no-repeat;}
-->
</style>
<script type="text/javascript" src="../js/gstatj.js"></script>
<script type="text/javascript" src="js/pagecontrol_1.0.4.js"></script>
<script type="text/javascript">
	var headListData = [{cateURL:"HD_index.jsp?topid=0"},
						{cateURL:"list_pic.jsp?topid=0"},
						{cateURL:"list_pic.jsp?topid=1"},
						{cateURL:"list_pic.jsp?topid=2"},
						{cateURL:"list_pic.jsp?topid=3"},
						{cateURL:"list_pic.jsp?topid=4"},
						{cateURL:"list.jsp?topid=0"},
						{cateURL:"list.jsp?topid=1"}];
	var area0,area1,area2,area3,area4,area5;
	var areaid = 1;
	var indexid = 0;
	var rylist= <%=ryjsonList%>;
	var rqlist= <%=rqjsonList%>;
	var tjlist= <%=tjjsonList%>;
       	var returnurl = "<%=returnurl%>";

	window.onload=function()
	{
                 gstaFun('<%=userid%>',660);
		area0=AreaCreator(1,8,new Array(6,-1,1,-1),"nav0_list_","className:item","className:item");
		area0.slitherParam = new Array("area0_focus",0,0,146,0,1,30,0);
		area0.setfocuscircle(1);
		area0.areaOkEvent = function(){
			if(area0.curindex==0) return;
			var cateURL = headListData[area0.curindex].cateURL;
			saveFocstr(pageobj);
			window.location.href = cateURL+"&returnurl="+escape(window.location.href);
			}
		
		area1=AreaCreator(1,1,new Array(0,-1,2,3),"nav1_list_","className:item item_focus","className:item");
		area1.stablemoveindex = new Array(-1,-1,-1,-1);
		area1.doms[0].imgdom=$("area1_img_0");
		
		area2=AreaCreator(1,3,new Array(1,-1,-1,3),"nav2_list_","className:item","className:item");
		area2.slitherParam=new Array("area1_focus",0,0,208,0,1,40,0);
		area2.stablemoveindex = new Array(-1,-1,-1,"2-1");
		for(i=0;i<3;i++)
		{
		   //area4.doms[i].contentdom=$("area4_text_"+i);
		   area2.doms[i].imgdom=$("area2_img_"+i);
		}
		
		area3=AreaCreator(2,1,new Array(5,1,-1,4),"nav3_list_","className:item","className:item");
		area3.slitherParam=new Array("area2_focus",0,0,0,243,1,0,40);
		area3.stablemoveindex = new Array(-1,"0-1>0,1-2>2",-1,"0-0,1-1");
		for(i=0;i<2;i++)
		{
		   area3.doms[i].imgdom=$("area3_img_"+i);
		}
		
		area4=AreaCreator(2,1,new Array(5,3,-1,-1),"nav4_list_","className:item","className:item");
		area4.slitherParam=new Array("area3_focus",0,0,0,243,1,0,40);
		area4.stablemoveindex = new Array("0-1","0-0,1-1",-1,-1);
		for(i=0;i<2;i++)
		{
		   area4.doms[i].imgdom=$("area4_img_"+i);
		}
		
		area5=AreaCreator(1,2,new Array(0,1,3,-1),"nav5_list_","className:item item_focus","className:item");
		area5.stablemoveindex = new Array(-1,-1,"0-3>0,1-4>0",-1);
		area5.doms[0].domOkEvent = function(){
			saveFocstr(pageobj);
				window.location = "index_popular.jsp?returnurl="+location.href;
			}
		area5.doms[1].domOkEvent = function(){
			saveFocstr(pageobj);
			window.location = "index_recommend.jsp?returnurl="+location.href;
			}
			
		if(focusObj!=undefined&&focusObj!="null"){
			   areaid = parseInt(focusObj[0].areaid);
			   indexid = parseInt(focusObj[0].curindex);
		   }
			
                area6=AreaCreator(1,1,new Array(-1,-1,0,-1),"jifen_","className:item item_focus","className:item");
                area6.doms[0].mylink = "../jifen/index.jsp?returnUrl=../hd_epg/HD_index.jsp";
		pageobj=new PageObj(areaid,indexid,new Array(area0,area1,area2,area3,area4,area5,area6),null);
                pageobj.backurl = returnurl;
		bindarea1data(rylist)
		binddata(area3,rqlist);
		bindVASdata(tjlist);
	}
	function bindarea1data(data){
		if(data[0]!=null){
					   //area1.doms[0].setcontent("",data[0].VODNAME,36);
					   area1.doms[0].youwannauseobj=data[0].VODID;
					   area1.doms[0].updateimg("../"+data[0].PICURL);
					   area1.doms[0].title = data[0].ISSITCOM;
					   area1.doms[0].domOkEvent=function()
					   {
						 var tempURL = location.href;
							
						   if(this.title == 0){
							   saveFocstr(pageobj);
							   window.location.href = "film_details.jsp?vodid=" + this.youwannauseobj + "&returnurl="+escape(tempURL);
							   }else{
								  saveFocstr(pageobj);
								   window.location.href = "tv_details.jsp?vodid=" + this.youwannauseobj + "&returnurl="+escape(tempURL);
								   }
						 
					   }
					 }else{
			   			area1.doms[0].updatecontent("");
			   		}
		for(var i = 1;i < area2.doms.length+1; i++){
			if(data[i]!=null){
					   //area2.doms[i].setcontent("",data[i].VODNAME,36);
					   area2.doms[i-1].youwannauseobj=data[i].VODID;
					   area2.doms[i-1].updateimg("../"+data[i].PICURL);
					   area2.doms[i-1].title = data[i].ISSITCOM;
					   area2.doms[i-1].domOkEvent=function()
					   {
						 var tempURL = location.href;
						  if(this.youwannauseobj==null  ||  this.youwannauseobj=="" ||  this.youwannauseobj==undefined) return;
						  //$("nav0_txt_0").innerHTML=this.title;
						  //return;
						   if(this.title == 0){
							   saveFocstr(pageobj);
							   window.location.href = "film_details.jsp?vodid=" + this.youwannauseobj + "&returnurl="+escape(tempURL);
							   }else{
								   saveFocstr(pageobj);
								   window.location.href = "tv_details.jsp?vodid=" + this.youwannauseobj + "&returnurl="+escape(tempURL);
								   }
						 
					   }
					 }else{
			   			area2.doms[i-1].updatecontent("");
			   		}
			}
		}
 	function binddata(area,data){
		for(var i = 0;i < area.doms.length; i++){
			if(data[i]!=null){
					   //area.doms[i].setcontent("",data[i].VODNAME,36);
					   area.doms[i].youwannauseobj=data[i].VODID;
					   area.doms[i].updateimg("../"+data[i].PICURL);
					   area.doms[i].title = data[i].ISSITCOM;
					   area.doms[i].domOkEvent=function()
					   {
						 var tempURL = location.href;
							
						   if(this.title == 0){
							   saveFocstr(pageobj);
							   window.location.href = "film_details.jsp?vodid=" + this.youwannauseobj + "&returnurl="+escape(tempURL);
							   }else{
								   saveFocstr(pageobj);
								   window.location.href = "tv_details.jsp?vodid=" + this.youwannauseobj + "&returnurl="+escape(tempURL);
								   }
						 
					   }
					 }else{
			   			area.doms[i].updatecontent("");
			   		}
			}
		}
	function bindVASdata(data){
		for(var i = 0;i < area4.doms.length; i++){
			if(data[i]!=null){
					   //area.doms[i].setcontent("",data[i].VODNAME,36);
					   area4.doms[i].youwannauseobj=data[i].VASID;
					   area4.doms[i].title=data[i].VASURL;
					   area4.doms[i].updateimg("../"+data[i].PICURL);
					   area4.doms[i].domOkEvent=function()
					   {
						 var tempURL = location.href;
						 saveFocstr(pageobj);
						 window.location.href ="../../../"+this.title+"&returnurl="+escape(tempURL);
						 
					   }
					 }else{
			   			area4.doms[i].updatecontent("");
			   		}
			}
		}
</script>
</head>
<body>

<!--head-->
<div class="logo">
	<div class="pic"><img src="images/logo.png" /></div>
	<!--<div class="txt txt-a">高清院线</div> -->
</div>

<!---���ֶ�����ť��ʽ--->
<div class="jifen">
        <div  class="item" id="jifen_0" style="left:550px;top:-10px"></div>
        <div  class="pic" id="jifentxt" style="text-align:center;left:650px;top:30px;color:#FF0000"><%=recordPoints%></div>
</div>
<div class="adfont"><img src="images/adfont.png" /></div>
<!--head the end-->	



<!--menu-->	
<div class="menu">
	<div class="item item_focus" style="left:292px;visibility:hidden;" id="area0_focus"></div> <!--焦点移动层-->
	<!--焦点 
			class="item item_focus"
		选中
			class="item item_select"
	-->
    <div class="item item_select">
	<div id="nav0_list_0" class="item">
		<div class="txt" id="nav0_txt_0">最新</div>
	</div>
    </div>
	<div id="nav0_list_1" class="item" style="left:146px;">
		<div class="txt">动作</div>
	</div>
	<div id="nav0_list_2" class="item" style="left:292px;">
		<div class="txt">喜剧</div>
	</div>
	<div id="nav0_list_3" class="item" style="left:438px;">
		<div class="txt">爱情</div>
	</div>
	<div id="nav0_list_4" class="item" style="left:584px;">
		<div class="txt">惊悚</div>
	</div>
	<div id="nav0_list_5" class="item" style="left:729px;">
		<div class="txt">卡通</div>
	</div>
	<div id="nav0_list_6" class="item" style="left:875px;">
		<div class="txt">片库</div>
	</div>
	<div id="nav0_list_7" class="item" style="left:1022px;">
		<div class="txt">片花</div>
	</div>
</div>
<!--menu the end-->		
	
	
	
<!--poster-->	
<div class="poster-a">
	<!--焦点 
		class="item item_focus"
	-->
	<div id="nav1_list_0" class="item">
		<div class="link"></div>
		<div class="pic"><img id="area1_img_0" src="#" /></div>
	</div>
</div>

<div class="poster-b">
	<div class="item item_focus" style="left:208px;visibility:hidden;" id="area1_focus"><div class="link"></div></div> <!--焦点移动层-->
	<!--焦点 
		class="item item_focus"
	-->
	<div id="nav2_list_0" class="item">
		<div class="link"></div>
		<div class="pic"><img id="area2_img_0" src="#" /></div>
	</div>
	<div id="nav2_list_1" class="item" style="left:208px;">
		<div class="link"></div>
		<div class="pic"><img id="area2_img_1" src="#" /></div>
	</div>
	<div id="nav2_list_2" class="item" style="left:416px;">
		<div class="link"></div>
		<div class="pic"><img id="area2_img_2" src="#" /></div>
	</div>
</div>

<div class="poster-b" style="left:751px; top:215px;">
	<div class="item item_focus" style="top:243px;visibility:hidden;" id="area2_focus"><div class="link"></div></div> <!--焦点移动层-->
	<!--焦点 
		class="item item_focus"
	-->
	<div id="nav3_list_0" class="item">
		<div class="link"></div>
		<div class="pic"><img id="area3_img_0" src="#" /></div>
	</div>
	<div id="nav3_list_1" class="item" style="top:243px;">
		<div class="link"></div>
		<div class="pic"><img id="area3_img_1" src="#" /></div>
	</div>
</div>
<div class="more">
	<!--焦点 
		class="item item_focus"
	-->
	<div id="nav5_list_0" class="item">更多</div>
</div>

<div class="poster-b" style="left:1029px; top:215px;">
	<div class="item item_focus" style="top:243px;visibility:hidden;" id="area3_focus"><div class="link"></div></div> <!--焦点移动层-->
	<!--焦点 
		class="item item_focus"
	-->
	<div id="nav4_list_0" class="item">
		<div class="link"></div>
		<div class="pic"><img id="area4_img_0" src="#" /></div>
	</div>
	<div id="nav4_list_1" class="item" style="top:243px;">
		<div class="link"></div>
		<div class="pic"><img id="area4_img_1" src="#" /></div>
	</div>
</div>
<div class="more" style="left:1170px;">
	<!--焦点 
		class="item item_focus"
	-->
	<div id="nav5_list_1" class="item">更多</div>
</div>
<!--poster the end-->		

	
</body>
</html>
