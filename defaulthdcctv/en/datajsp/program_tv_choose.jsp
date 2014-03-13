<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %><html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="datajsp/program_tv_choose_data.jsp" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>节目详情-电视剧-播放选择_央视高清EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript">
var vodid = <%=vodId %>;
var returnurl = '<%=request.getParameter("returnurl")!=null?request.getParameter("returnurl"):"indexpkit.jsp"%>';
var buystatu = 0;  // 0.未购买
var favstatu = 0;  // 0.未收藏
    window.onload=function()
   {
	   var areaid=0;
	   var indexid=0;
	   var area0=AreaCreator(4,1,new Array(-1,-1,1,1),"menu","className:menuli on","className:menuli");
	   area0.stayindexdir ="3";
       var area1=AreaCreator(3,12,new Array(0,0,-1,-1),"link","className:on","className:");
	   area1.stablemoveindex = new Array("0-3",-1,-1,-1);
	   area1.datanum = jsonSitcoms.length;
	   //弹出层
	   //书签
	   var area2 = AreaCreator(1,2,new Array(-1,-1,-1,-1),"div_tip","className:on","className:");
	   area2.doms[0].domOkEvent = function(){ //书签播放
			//window.location = "";
			popup0.closeme();
	   }
	   area2.doms[1].domOkEvent = function(){ //从头播放
	   		popup0.closeme();
	   }
	   var popup0 = new Popup("div_tip",new Array(area2));
	   popup0.goBackEvent=function()
	   {
		   this.closeme();
	   }
	   
	   //添加删除收藏
	   var popup1 = new Popup("div_fav");
	   popup1.closetime = 1;
	   
	   //购买
	   var area4 = AreaCreator(1,2,new Array(-1,-1,1,-1),"div_buy","className:on","className:");
	   var area5 = AreaCreator(1,1,new Array(0,0,-1,0),"div_about","className:on","className:");
	   area5.stablemoveindex=new Array(-1,-1,-1,-1,"0-1");
	   var popup2 = new Popup("div_buy",new Array(area4,area5),0,1);
	   popup2.goBackEvent=function()
	   {
		   this.closeme();
	   }
	   
	   area4.doms[0].domOkEvent = function(){
		   pageobj.closeme();
		   buystatu = 1;		   
		   $("div_fav0").innerHTML = "节目已购买成功";
		   popup1.showme();
	   }
	   
	   area5.doms[0].domOkEvent = function(){
	   	   window.location.href = "package_intro.jsp?returnurl="+escape(window.location.href);
	   }
	   
	   area0.doms[2].domOkEvent = function(){
		   	if(favstatu==0){
				favstatu = 1;
				$("div_fav0").innerHTML = "节目已成功加入收藏";
				$("menu2").innerHTML = "移除收藏";
				pageobj.popups[1].showme();
			}else{
				favstatu = 0;
				$("div_fav0").innerHTML = "节目已移除收藏";
				$("menu2").innerHTML = "收  &nbsp;&nbsp;  藏";
				pageobj.popups[1].showme();
			}
	   }
	   area0.doms[1].domOkEvent = function(){  
				if(buystatu==0){
					pageobj.popups[2].showme();
				}else{
					$("div_fav0").innerHTML = "该节目已购买，无需再次购买";
					pageobj.popups[1].showme();
				}
	   }
	   
	   area0.doms[3].domOkEvent = function(){
		   if(buystatu==0){
			    buystatu=1;
	   			$("div_fav0").innerHTML = "节目已购买成功";
		   }else{
			   $("div_fav0").innerHTML = "该节目已购买，无需再次购买";
		   }
			pageobj.popups[1].showme();
	   }
	   
	  pageobj=new PageObj(areaid,indexid,new Array(area0,area1),new Array(popup0,popup1,popup2));
	  pageobj.backurl = unescape(returnurl);
	  setListData(jsonSitcoms);
	  setContentData(jsonContent);
   }  
</script>
</head>

<body>
<div class="main">
	
	<!--logo-->
	<div class="logo">同步首播</div>
	<div class="date" id="currDate">2011年5月30日 | 15:00</div>
	
	
	
	<!--menu-->
	<div class="menu2">
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="menu0">节目信息</div> <!--class="menuli on"-->
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="menu1">播放选择</div>
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="menu2">收  &nbsp;&nbsp;  藏</div>    
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="menu3">购  &nbsp;&nbsp;  买</div>
		<div><img src="images/menu_line.png" /></div>
	</div>
	
	
	
	<!--tv-->	
	<div class="dibb"> 
		<div class="tv_choose_pic"><img id="sitcom_pst" src="images/temp/7.jpg" width="192" height="264" /></div>
		<div class="tv_choose_intro">
			<div id="sitcom_name"><b>片名：</b>新少林寺</div>
			<div id="sitcom_price"><b>价格：</b>2.00元</div>
			<div id="sitcom_dct"><b>导演：</b>陈木胜</div>
			<div id="sitcom_act"><b>主演：</b>刘德华，谢霆锋，范冰冰，成龙</div>
			<div><img src="images/line2.png" /></div>
		</div>				
	</div>
	
	
	
	<!--tv_choose-->	
	<div class="dibb2">
		<div class="f24b">集数选择：</div>
		<div align="center"><img src="images/up_gray.png" /></div>
		<div class="tv_choose_episode">
			<div id="link0">001</div> 
			<div id="link1">002</div>
			<div id="link2">003</div>
			<div id="link3">004</div>
			<div id="link4">005</div>
			<div id="link5">006</div>
			<div id="link6">007</div>
			<div id="link7">008</div>
			<div id="link8">009</div>
			<div id="link9">010</div>
			<div id="link10">011</div>
			<div id="link11">012</div>
			<div id="link12">013</div> 
			<div id="link13">014</div>
			<div id="link14">015</div>
			<div id="link15">016</div>
			<div id="link16">017</div>
			<div id="link17">018</div>
			<div id="link18">019</div>
			<div id="link19">020</div>
			<div id="link20">021</div>
			<div id="link21">022</div>
			<div id="link22">023</div>
			<div id="link23">024</div>
			<div id="link24">025</div>
			<div id="link25">026</div>
            <div id="link26"></div>
			<div id="link27"></div>
			<div id="link28"></div>
			<div id="link29"></div>
			<div id="link30"></div>
            <div id="link31"></div>
			<div id="link32"></div>
			<div id="link33"></div>
			<div id="link34"></div>
			<div id="link35"></div> 
		</div>
		<div align="center"><img src="images/down_gray.png" /></div>
		
	</div>
	
	
	
	<!-- bottom_notice -->
	<div class="notice"><marquee id="buttom_txt" id="bottomtxt">欢迎观看IPTV</marquee></div>
    <!-- play tip -->
	<div class="popup" id="div_tip" style="display:none;">    	
		<div class="pop_fee">是否从书签处开始播放？</div>		
		<div class="pop_btns">	
			<div id="div_tip0" class="on">书签播放</div>
			<div>&nbsp;</div>
			<div id="div_tip1">从头播放</div>
	    </div>
    </div>      
    <!-- add del -->
    <div class="popup" id="div_fav" style="display:none;">
			<div class="pop_tip" id = "div_fav0">节目已成功加入收藏/节目已移除收藏</div>		
	</div>        
    <!-- buy -->
    <div class="popup" id="div_buy" style="display:none">
         	<div class="pop_fee">对不起，您未购买本片，请购买后观看。</div>	
            <div class="pop_price">价格：2.00元</div>	
            <div class="pop_btns">	
			<div id="div_buy0">购买本片</div>
			<div>&nbsp;</div>
			<div id="div_buy1">返回</div>
 	 		</div>
         <div class="pop_btns po1">
                <div id="div_about0">了解套餐</div>
         </div>
	 </div>
</div>
<%@ include file="servertimehelp.jsp" %>
    <div style="visibility:hidden; z-index:-1">
    <img src="images/tv_choose_bgon.png"/>
	</div>
</body>
</html>
