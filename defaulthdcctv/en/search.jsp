<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="datajsp/codepage.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>搜索_央视高清EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<style>
<!--

-->
</style>
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript" src="js/gstatj.js"></script>
<script type="text/javascript">
var list;
var userid = Authentication.CTCGetConfig("UserID");
var returnurl = "index.jsp";
    window.onload=function()
   {
           gstaFun(userid,647);
	   var areaid=parseInt('<%=request.getParameter("areaid")==null?"0":"3" %>');
	   var indexid=parseInt('<%=request.getParameter("indexid")==null?"9":"0" %>');
	   var area0=AreaCreator(10,1,new Array(-1,-1,-1,1),"area0_list_","className:menuli on","className:menuli");
	   area0.setstaystyle("className:menuli current",3);
	   area0.doms[0].mylink=indexhref[0];
	   area0.doms[1].mylink=indexhref[1];
	   area0.doms[2].mylink=indexhref[2];
	   //area0.doms[3].mylink="application.jsp?indexid=3";
	   area0.doms[3].mylink=indexhref[3];
	   area0.doms[4].mylink=indexhref[4];
	   area0.doms[5].mylink=indexhref[5];
	   area0.doms[6].mylink=indexhref[6];
	   area0.doms[7].mylink=indexhref[7];
	   area0.doms[8].mylink=indexhref[8];
	   area0.doms[9].mylink=indexhref[9];
	   //area0.doms[9].mylink = "../../defaulthdzhuanti/ayh2012/ayh2012test/ayh2012hd/url.html";
	   area0.setfocuscircle(0);
       var area1=AreaCreator(1,1,new Array(-1,0,3,2),"arrow","src:images/icon_arrowon.png","src:images/icon_arrow.png");
       area1.stablemoveindex = new Array(-1,-1,"0-4",-1);
       
       var area2=AreaCreator(1,1,new Array(-1,1,3,-1),"search","className:s2 on","className:s2");
       area2.stablemoveindex = new Array(-1,-1,"0-5",-1);
       var area3=AreaCreator(2,7,new Array(2,0,4,-1),"letters0_","className:on","className:");
	   area3.stablemoveindex = new Array("4-1>0,5-2>0,6-2>0",-1,"7-0,8-1,9-2,10-3,11-3,12-4,13-5",-1);
       var area4=AreaCreator(2,6,new Array(3,0,-1,-1),"letters1_","className:on","className:");
	   area4.stablemoveindex = new Array("0-7,1-8,2-9,3-11,4-12,5-13",-1,-1,-1);
	   pageobj=new PageObj(areaid,indexid,new Array(area0,area1,area2,area3,area4));
	   pageobj.goBackEvent=function()
	   {
		   location.href="index.jsp";
		   //this.changefocus(0,9);
	   }
	   if(!!areaid)
	   area0.setdarknessfocus(8);   
	   //area0.areaOutingEvent=function()
//	   {
//		   switch(this.curindex)
//		   {
//			   case 0:   window.location.href="index.jsp?areaid=1&indexid=0";return true; break;
//			   case 1:   window.location.href="channel.jsp?areaid=1&indexid=0";return true; break;
//			   case 2:   window.location.href="dibbling.jsp?areaid=1&indexid=0";return true; break;
//			   case 3:   window.location.href="playback.jsp?areaid=1&indexid=0";return true; break;
//			   case 4:   window.location.href="local.jsp?areaid=1&indexid=0";return true; break;
//			   case 5:   window.location.href="application.jsp?areaid=1&indexid=0";return true; break;
//			   case 6:   window.location.href="package.jsp?areaid=1&indexid=0";return true; break;
//			   case 7:   window.location.href="space_collect.jsp?areaid=1&indexid=0";return true; break;
//		   }
//	   }

	   area2.areaOkEvent = function(){
		   var strWord = $("word").innerHTML;
		   if(strWord.length>0&&strWord=="VWXYSMF") 
		   { 
			  location.href = "sim_index.jsp";
		   }
                   else if(strWord.length>0&&strWord=="Y")
                   {
                          location.href = "hd_epg/HD_index.jsp";
                   }
                   else if(strWord.length>0&&strWord=="A")
                   {
                          location.href = "jpui/page/newJpChannel.jsp";
                   }
                   else if(strWord.length>0&&strWord=="S")
                   {
                           location.href ="../../defaultsdcctv/en/page/vod_turnpager.jsp?catename=VBR&typeid=10000100000000090000000000041981&returnurl=index.jsp";

                   } 
                   else if(strWord.length>0&&strWord=="R")
                   {
			        location.href = activity/page/youChuYinHang.jsp;
		   }else if(strWord.length>0&&strWord=="G")
                   {
                           location.href = "http://219.133.42.99/stock/stockD/indextopway.htm";
                   }            
                   else if(strWord.length>0&&strWord=="E")
                   {
			   var STBID = Authentication.CTCGetConfig("STBID");
                           var ZTESTBID = iPanel.ioctlRead("infoHWSN"); 

				if(undefined == ZTESTBID)
			       {
                                        ZTESTBID = "";
                                }
                                if(undefined == STBID)
                               {
                                      STBID = "";
                               }

			   location.href = "https://125.88.107.108/tvbank?boxno="+STBID+"&boxicno="+ZTESTBID+"&operators=1044&resolution=1280&tvbrowser=017&ReturnURL=http://125.88.70.16:8082/EPG/jsp/defaulthdcctv/en/index.jsp";
		   } 
		   else if(strWord.length>0&&strWord!="VWXYSMF")
		   {location.href = "search_result.jsp?returnurl="+escape(location.href)+"&keyword="+$("word").innerHTML;}
	   }
	   area3.areaOkEvent=function()
	   {
		   if($("word").innerHTML.length <9){
		   	$("word").innerHTML += this.doms[this.curindex].dom[0].innerHTML;
		   }
	   }
	   area4.areaOkEvent = function()
	   {
		   if($("word").innerHTML.length <9){
		   	$("word").innerHTML += this.doms[this.curindex].dom[0].innerHTML;
		   }
	   }

       area1.areaOkEvent=function(){
           $("word").innerHTML = $("word").innerHTML.substr(0,$("word").innerHTML.length-1);
       }
   }
</script>
</head>

<body>
<div class="main">
	<!--logo-->
	<div class="logo"><img src="images/logo.png" /></div>
	<div class="date" id="currDate">2011年5月30日 | 15:00</div>
	
	
	
	<!--menu-->
	<div class="menu"> <!--焦点为 class="menuli on"  当前选中为 class="menuli current"-->
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_0" style="top:1px"><img src="images/icon_0.png" />首  页</div> <!--class="menuli on"-->
		<div style="top:55px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_1" style="top:56px"><img src="images/icon_1.png" />频  道</div>
		<div style="top:110px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_2" style="top:111px"><img src="images/icon_2.png" />点  播</div>
		<div style="top:165px"><img src="images/menu_line.png" /></div>
        <div class="menuli" id="area0_list_3" style="top:166px"><img src="images/icon_3.png" />专  题</div>
		<div style="top:220px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_4" style="top:221px"><img src="images/icon_4.png" />回  放</div>
		<div style="top:275px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_5" style="top:276px"><img src="images/icon_5.png" />深  圳</div>
		<div style="top:330px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_6" style="top:331px"><img src="images/icon_11new.png" />排  行</div>  <!--20130909 hxt 增加排行入口-->
		<div style="top:385px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_7" style="top:386px"><img src="images/icon_7.png" />应  用</div>   <!--20130909 hxt 将应用入口下移-->
		<div style="top:440px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_8" style="top:441px"><img src="images/icon_9.png" />空  间</div>
		<div style="top:499px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_9" style="top:500px"><img src="images/icon_10.png" />搜  索</div>
		<div style="top:555px"><img src="images/menu_line.png" /></div>
	</div>
	
	
	
		<!--search-->
	<div class="search">
		<div id="word" style='width:415px; height:45px; line-height:46px; border:solid 1px #5F5E63; font-size:36px; font-family:"黑体"; background-color:#fff; color:#000; overflow-y:hidden'></div>
		<div class="s1"><img src="images/icon_arrow.png" id="arrow0"/></div><!--icon_arrowon.png-->
		<div class="s2" id="search0">搜索</div>
  	</div>
	
	
	<div class="search_letter">
		<div id="letters0_0">A</div>
		<div id="letters0_1">B</div>
		<div id="letters0_2">C</div>
		<div id="letters0_3">D</div>
		<div id="letters0_4">E</div>
		<div id="letters0_5">F</div>
		<div id="letters0_6">G</div>
		<div id="letters0_7">H</div>
		<div id="letters0_8">I</div>
		<div id="letters0_9">J</div>
		<div id="letters0_10">K</div>
		<div id="letters0_11">L</div>
		<div id="letters0_12">M</div>
		<div id="letters0_13">N</div>
		<div id="letters1_0">O</div>
		<div id="letters1_1">P</div>
		<div id="letters1_2">Q</div>
		<div>&nbsp;</div>
		<div id="letters1_3">R</div>
		<div id="letters1_4">S</div>
		<div id="letters1_5">T</div>
		<div id="letters1_6">U</div>
		<div id="letters1_7">V</div>
		<div id="letters1_8">W</div>
		<div>&nbsp;</div>
		<div id="letters1_9">X</div>
		<div id="letters1_10">Y</div>
		<div id="letters1_11">Z</div>
	</div>
	<!--bottom_notice-->
		<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>
</div>
<%@ include file="servertimehelp.jsp" %>
	<div style="visibility:hidden; z-index:-1">
    	<img src="images/menu_bgfocuson.png"/>
        <img src="images/menu_bgon.png"/>
        <img src="images/search_letter_bgon.png"/>               
	</div>
</body>
</html>
