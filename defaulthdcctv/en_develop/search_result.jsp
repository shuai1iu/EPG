<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="datajsp/util_AdText.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>搜索结果_央视高清EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<%@ include file="datajsp/search_result_data.jsp" %>
<style>
<!--

-->
</style>
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript">
//需要修改
var returnurl = '<%=request.getParameter("returnurl")!=null?request.getParameter("returnurl"):"index.jsp"%>';
var area0;

 window.onload=function(){
	   var areaid=0;
	   var indexid=0;
	   area0=AreaCreator(12,1,new Array(-1,-1,-1,-1),"result","className:r_li on","className:r_li");
	   area0.setpageturnattention("upicon","images/up.png","images/up_gray.png","downicon","images/down.png","images/down_gray.png");
	   area0.setcrossturnpage(); //设定可移动翻页
	   area0.asyngetdata=function(){
	   		setData(getcurcates(fcontent,area0.curpage,<%=pagesize %>));
   	   }
   		
	   pageobj=new PageObj(areaid,indexid,new Array(area0));
	   pageobj.backurl = returnurl;
	   setData(getcurcates(fcontent,area0.curpage,<%=pagesize %>));	   
   }
   
   //editing by ty 2011-11-22 17:47:21		
			//菜单回调的参数
/////////////////////////////////////////////////////////////////////////////////////////////////////
	function getcurcates(itms,curpage,pagesize){
		var newitms = new Array();
		for(var i = (curpage-1)*<%=pagesize %>,j=0;j<<%=pagesize %>&&i<itms.length;i++,j++){
			newitms.push(itms[i]);		
		}
		return newitms;
	}
</script>
</head>
<body>
<div class="main">
	
	<!--logo-->
	<div class="logo">搜索结果</div>
	<div class="date" id="currDate">2011年5月30日 | 15:00</div>
	
	
	
	<!--menu-->
	<div class="menu2"> <!--焦点为 class="menuli on"  当前选中为 class="menuli current"-->
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" style="width:500px;"><%=request.getParameter("keyword")!=null?request.getParameter("keyword"):"空白"%></div>
		<div><img src="images/menu_line.png" /></div>
	</div>
	
	
	
	<!--search_result-->
	<div class="search_result">
		<div align="center"><img id="upicon" src="images/up_gray.png" /></div>
		<div class="r_li on" id="result0" style="width:790px;"></div>
		<div class="r_li" id="result1" style="width:790px;"></div>
		<div class="r_li" id="result2" style="width:790px;"></div>
		<div class="r_li" id="result3" style="width:790px;"></div>
		<div class="r_li" id="result4" style="width:790px;"></div>
		<div class="r_li" id="result5" style="width:790px;"></div>
		<div class="r_li" id="result6" style="width:790px;"></div>
		<div class="r_li" id="result7" style="width:790px;"></div>
		<div class="r_li" id="result8" style="width:790px;"></div>
		<div class="r_li" id="result9" style="width:790px;"></div>
		<div class="r_li" id="result10" style="width:790px;"></div>
		<div class="r_li" id="result11" style="width:790px;"></div>
		<div align="center"><img id="downicon" src="images/down_gray.png" /></div>
	</div>	
	 <!--bottom_notice-->
	<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>
</div>
<%@ include file="servertimehelp.jsp" %>
<iframe id="hidden_frame" width="0" height="0"/>
<div style="visibility:hidden; z-index:-1">
    	<img src="images/search_list_bgon.png"/>
        <img src="images/down.png"/>
        <img src="images/up.png"/>             
</div>
</body>
</html>
