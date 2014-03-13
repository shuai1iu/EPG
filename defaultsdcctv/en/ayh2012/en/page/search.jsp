<%@ page contentType="text/html; charset=utf-8" language="java" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><%@ include file="../common/golbal.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视奥运 标清EPG 2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="<%=static_url%>/css/style.css" />
<link type="text/css" rel="stylesheet" href="<%=static_url%>/css/content.css" />
<script type="text/javascript" src="<%=static_url%>/js/cookie.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/common.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/commonevent.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/ajax_common.js"></script>
</head>
<body onload="onPageLoad();"  background="#"  bgcolor="#000000">
<div style="position:absolute;z-index:-1;">
	<img style="width:640px;height:530px;" src="<%=static_url%>/images/bg.jpg" />
</div>
<%@ include file="../datasource/property.jsp"%>
<%@ include file="../datasource/datasource.jsp"%>
<%
	DataSource dataSource=new DataSource(request);
	String keywords=dataSource.huaWeiUtil.getString(request.getParameter("keywords"));
    int pageIndex=dataSource.huaWeiUtil.getInt(request.getParameter("pageIndex"),1);
	int isreturn=dataSource.huaWeiUtil.getInt(request.getParameter("isreturn"),0);//是否是详情页返回的标志
    //int pageSize=dataSource.huaWeiUtil.getInt(request.getParameter("pageSize"),10);
	int pos=dataSource.huaWeiUtil.getInt(request.getParameter("pos"),0);
	int area=dataSource.huaWeiUtil.getInt(request.getParameter("area"),0);
	
%>
<div class="wrapper">

<%String currentPageId = "_1006"; %>
<%@ include file="../common/head.jsp" %>
<!--the end-->



<!--search-box-->
<div class="search-box">
	<div class="search-input">
		<div class="link"><a href="#"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt" id="searchTxt"><%=keywords %></div>
	</div>
	<div class="search-btn">
		<div class="link"><a href="#" onclick="searchFilm()"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="btn"><img src="<%=static_url%>/images/btn-search.png" /></div>
	</div>
</div>
<!--the end-->



<!--search-num-abc-->
<div class="search-key">
	<div class="item">
		<div class="link"><a href="#" onclick="addTxt('1')"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">1</div>
	</div>
	<div class="item" style="left:43px;">
		<div class="link"><a href="#" onclick="addTxt('2')"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">2</div>
	</div>
	<div class="item" style="left:86px;">
		<div class="link"><a href="#" onclick="addTxt('3')"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">3</div>
	</div>
	<div class="item" style="left:129px;">
		<div class="link"><a href="#" onclick="addTxt('4')"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">4</div>
	</div>
	<div class="item" style="left:172px;">
		<div class="link"><a href="#" onclick="addTxt('5')"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">5</div>
	</div>
	<div class="item" style="left:215px;">
		<div class="link"><a href="#" onclick="addTxt('6')"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">6</div>
	</div>
	<div class="item" style="left:258px;">
		<div class="link"><a href="#" onclick="addTxt('7')"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">7</div>
	</div>
	<div class="item" style="left:301px;">
		<div class="link"><a href="#" onclick="addTxt('8')"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">8</div>
	</div>
	<div class="item" style="left:344px;">
		<div class="link"><a href="#" onclick="addTxt('9')"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">9</div>
	</div>
	<div class="item" style="left:387px;">
		<div class="link"><a href="#" onclick="addTxt('0')"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">0</div>
	</div>
	<div class="item-del" style="left:430px;">
		<div class="link"><a href="#" onclick="subTxt()"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt"></div>
	</div>
	
	<div style="top:43px;">
		<div class="item">
			<div class="link"><a href="#" onclick="addTxt('A')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">A</div>
		</div>
		<div class="item" style="left:43px;">
			<div class="link"><a href="#" onclick="addTxt('B')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">B</div>
		</div>
		<div class="item" style="left:86px;">
			<div class="link"><a href="#" onclick="addTxt('C')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">C</div>
		</div>
		<div class="item" style="left:129px;">
			<div class="link"><a href="#" onclick="addTxt('D')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">D</div>
		</div>
		<div class="item" style="left:172px;">
			<div class="link"><a href="#" onclick="addTxt('E')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">E</div>
		</div>
		<div class="item" style="left:215px;">
			<div class="link"><a href="#" onclick="addTxt('F')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">F</div>
		</div>
		<div class="item" style="left:258px;">
			<div class="link"><a href="#" onclick="addTxt('G')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">G</div>
		</div>
		<div class="item" style="left:301px;">
			<div class="link"><a href="#" onclick="addTxt('H')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">H</div>
		</div>
		<div class="item" style="left:344px;">
			<div class="link"><a href="#" onclick="addTxt('I')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">I</div>
		</div>
		<div class="item" style="left:387px;">
			<div class="link"><a href="#" onclick="addTxt('J')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">J</div>
		</div>
		<div class="item" style="left:430px;">
			<div class="link"><a href="#" onclick="addTxt('K')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">K</div>
		</div>
		<div class="item" style="left:473px;">
			<div class="link"><a href="#" onclick="addTxt('L')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">L</div>
		</div>
		<div class="item" style="left:516px;">
			<div class="link"><a href="#" onclick="addTxt('M')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">M</div>
		</div>
	</div>
	
	<div style="top:86px;">
		<div class="item">
			<div class="link"><a href="#" onclick="addTxt('N')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">N</div>
		</div>
		<div class="item" style="left:43px;">
			<div class="link"><a href="#" onclick="addTxt('O')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">O</div>
		</div>
		<div class="item" style="left:86px;">
			<div class="link"><a href="#" onclick="addTxt('P')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">P</div>
		</div>
		<div class="item" style="left:129px;">
			<div class="link"><a href="#" onclick="addTxt('Q')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">Q</div>
		</div>
		<div class="item" style="left:172px;">
			<div class="link"><a href="#" onclick="addTxt('R')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">R</div>
		</div>
		<div class="item" style="left:215px;">
			<div class="link"><a href="#" onclick="addTxt('S')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">S</div>
		</div>
		<div class="item" style="left:258px;">
			<div class="link"><a href="#" onclick="addTxt('T')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">T</div>
		</div>
		<div class="item" style="left:301px;">
			<div class="link"><a href="#" onclick="addTxt('U')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">U</div>
		</div>
		<div class="item" style="left:344px;">
			<div class="link"><a href="#" onclick="addTxt('V')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">V</div>
		</div>
		<div class="item" style="left:387px;">
			<div class="link"><a href="#" onclick="addTxt('W')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">W</div>
		</div>
		<div class="item" style="left:430px;">
			<div class="link"><a href="#" onclick="addTxt('X')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">X</div>
		</div>
		<div class="item" style="left:473px;">
			<div class="link"><a href="#" onclick="addTxt('Y')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">Y</div>
		</div>
		<div class="item" style="left:516px;">
			<div class="link"><a href="#" onclick="addTxt('Z')"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt">Z</div>
		</div>
	</div>
</div>
<!--the end-->



<!--page-->
<div class="page">
	<div class="item">
		<div class="link"><a href="#;" onclick="pageAction( -1 )"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="pic"><img src="<%=static_url%>/images/btn-prev.png" /></div>
	</div> 
	<div class="item" style="left:102px;">
		<div class="link"><a href="#;" onclick="pageAction( 1 )"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="pic"><img src="<%=static_url%>/images/btn-next.png" /></div>
	</div>
	<div class="num"><span id="page"></span></div>
</div>
<!--the end-->


	
<!--introduce-->
<div class="introduce"> <!--当前选中为 class="item item_select"-->
	<div class="item item00"  id="item_0" style="display:none">
		<div class="link"><a href="#" id="a_0" onclick="goDetail(0)" onblur="showCutName(0)" onclick="goDetail(0)" >
        <img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt" id="vod_0"></div>
	</div>
	<div class="item item01" id="item_1" style="display:none;">
		<div class="link"><a href="#" id="a_1" onclick="goDetail(1)" onblur="showCutName(1)" onclick="goDetail(1)" >
        <img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt" id="vod_1"></div>
	</div>
	<div class="item item02" id="item_2" style="display:none;">
		<div class="link"><a href="#" id="a_2" onclick="goDetail(2)" onblur="showCutName(2)" onclick="goDetail(2)" >
        <img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt" id="vod_2"></div>
	</div>
	<div class="item item03" id="item_3" style="display:none;">
		<div class="link"><a href="#" id="a_3" onclick="goDetail(3)" onblur="showCutName(3)" onclick="goDetail(3)" >
        <img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt" id="vod_3"></div>
	</div>
	<div class="item item04" id="item_4" style="display:none;">
		<div class="link"><a href="#" id="a_4" onclick="goDetail(4)" onblur="showCutName(4)" onclick="goDetail(4)" >
        <img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt" id="vod_4"></div>
	</div>
</div>
		
	
</div>
<!--the end-->	
	
</div>

<script type="text/javascript">
var pageCount=1;
var pageIndex=<%=pageIndex%>;
var pageSize=5;
var jsonObj;
var vodList;
var backUrl="index.jsp";
var ajaxurl="";
var area = <%=area%>; //7:内容列表
var pos = <%=pos%> ;//焦点
var isreturn = <%=isreturn %>;//1：是详情页返回
var $$ = {};
function $(id){
	if(!$$[id]){
	   $$[id] = document.getElementById(id);
	}
	return $$[id];
}
function onPageLoad(){
     keyBinds();
	 searchFilm();
}
function searchFilm(){
	if($("searchTxt").innerText!=undefined && $("searchTxt").innerText!=""){
		if(0==isreturn){pageIndex = 1;pos =0;}
		isreturn=0;
		init();
	}	
}

function pageAction(action ){ 
   if(action==1){ pageIndex=pageIndex+1; }else{ pageIndex=pageIndex-1; } 
   if((pageIndex>0)&&(pageIndex<=pageCount)){
	    pos = 0 ;init();
   }else{
      if(action==1){ pageIndex=pageCount; }else{ pageIndex = 1; } 
   }
}
function init(){
	ajaxurl="<%=static_en%>/ajaxdata/search_list_data.jsp?pageIndex="+pageIndex +"&pageSize="+pageSize+"&keywords=CNTVAY"+$("searchTxt").innerText;
    getAJAXData(ajaxurl,myCallBack);
}
function myCallBack(respText)
{
	 jsonObj = eval('('+respText+')');
	 vodList = jsonObj.jsonvodlist;
	 pageCount=jsonObj.jsonpagecount;
	 var len=vodList.length;
	 for(var i=len;i<pageSize;i++){
		$("item_"+i).style.display = "none";
	 } 
	 for(var i=0;i<len;i++){
	  	$("vod_"+i).innerText = vodList[i].dname;
		$("item_"+i).style.display = "block";
	 }
	 $("page").innerText=((pageCount == 0)?0:pageIndex)+"/"+pageCount; 
	 if(len>=1){$("a_"+pos).focus();}
}

BaseProcess.prototype.KEY_PAGEUP_EVENT=function(){
	   pageAction(-1 );
	}
BaseProcess.prototype.KEY_PAGEDOWN_EVENT=function(){
	   pageAction( 1 );
	}
BaseProcess.prototype.KEY_BACK_EVENT=function(){
	   goBack();
	}
function goBack(){
	 backUrl = getURLtoCookie("search");
	 backUrl = (backUrl!="")?backUrl:"index.jsp";
	 location.href=backUrl ;
	}

function goDetail(num){
	var programid = vodList[num].dcmsid;
	if(programid!=null && programid!="" && programid!="undefined" && programid!=undefined){
		var detailUrl="<%=static_en%>/page/detail.jsp?categoryId=-1&categoryname=&programid="+programid;
		backUrl = "<%=static_en%>/page/search.jsp?area=7&pageIndex="+pageIndex+"&pos="+num+"&keywords="+$("searchTxt").innerText+"&isreturn=1";
		addURLtoCookie("detail",backUrl);
		location.href = detailUrl;
	}
}

var str="<%=keywords %>";
function addTxt(word){
 if( (str+word).length>6 ){return }
 str=str+word;
 $("searchTxt").innerHTML=str;
}
function subTxt( ){
 str=str.substring(0,str.length-1);
 $("searchTxt").innerHTML=str;
}
function showFullName(num){
	 $("vod_"+num).innerHTML = ((vodList[num].dname).length)>28?("<marquee>"+vodList[num].dname+"</marquee>"):(vodList[num].dname);
}
function showCutName(num){
	 $("vod_"+num).innerHTML = ((vodList[num].dname).length)>28?(vodList[num].dname).substr(0,28):vodList[num].dname;
}
</script>
	
</body>
</html>
