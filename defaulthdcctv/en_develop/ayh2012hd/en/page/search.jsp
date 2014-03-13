<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head><%@ include file="../common/golbal.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>深圳奥运专题高清3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="<%=static_url%>/css/style.css" />
<script type="text/javascript" src="<%=static_url%>/js/cookie.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/common.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/ajax_common.js"></script>
</head>
<body onload="onPageLoad();">

<%@ include file="../datasource/property.jsp"%>
<%@ include file="../datasource/datasource.jsp"%>
<%
	DataSource dataSource=new DataSource(request);
	String keywords=dataSource.huaWeiUtil.getString(request.getParameter("keywords"));
    int pageIndex=dataSource.huaWeiUtil.getInt(request.getParameter("pageIndex"),1);
    //int pageSize=dataSource.huaWeiUtil.getInt(request.getParameter("pageSize"),10);
	int pos=dataSource.huaWeiUtil.getInt(request.getParameter("pos"),0);
	int area=dataSource.huaWeiUtil.getInt(request.getParameter("area"),1);
%>
<div class="wrapper">

<%String currentPageId = "_1007"; %>
<%@ include file="../common/head.jsp" %>

<!--search-->
<div class="content02">
	<!--search input-->
	<div class="search"> 
		<div class="search-input">
			<div class="link"><a href="#" onclick="searchFilm()" id="Inputfocus"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt" id="searchTxt"><%=keywords %></div>
		</div>
		<div class="search-btn"><a href="#" onclick="searchFilm()"><img src="<%=static_url%>/images/btn-search.jpg" /></a></div>
		<div class="search-select">
			<!--A-B-->
			<div class="item">
				<div class="link"><a href="#;" onclick="addTxt('A')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">A</div>
			</div>
			<div class="item" style="left:43px;">
				<div class="link"><a href="#;" onclick="addTxt('B')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">B</div>
			</div>
			<div class="item" style="left:86px;">
				<div class="link"><a href="#;" onclick="addTxt('C')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">C</div>
			</div>
			<div class="item" style="left:129px;">
				<div class="link"><a href="#;" onclick="addTxt('D')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">D</div>
			</div>
			<div class="item-del" style="left:172px;">
				<div class="link"><a href="#;" onclick="subTxt()"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">删除</div>
			</div>
			<!--E-K-->
			<div class="item" style="top:43px;">
				<div class="link"><a href="#;" onclick="addTxt('E')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">E</div>
			</div>
			<div class="item" style="left:43px; top:43px;">
				<div class="link"><a href="#;" onclick="addTxt('F')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">F</div>
			</div>
			<div class="item" style="left:86px; top:43px;">
				<div class="link"><a href="#;" onclick="addTxt('G')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">G</div>
			</div>
			<div class="item" style="left:129px; top:43px;">
				<div class="link"><a href="#;" onclick="addTxt('H')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">H</div>
			</div>
			<div class="item" style="left:172px; top:43px;">
				<div class="link"><a href="#;" onclick="addTxt('I')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">I</div>
			</div>
			<div class="item" style="left:215px; top:43px;">
				<div class="link"><a href="#;" onclick="addTxt('J')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">J</div>
			</div>
			<div class="item" style="left:258px; top:43px;">
				<div class="link"><a href="#;" onclick="addTxt('K')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">K</div>
			</div>
			<!--L-R-->
			<div class="item" style="top:86px;">
				<div class="link"><a href="#;" onclick="addTxt('L')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">L</div>
			</div>
			<div class="item" style="left:43px; top:86px;">
				<div class="link"><a href="#;" onclick="addTxt('M')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">M</div>
			</div>
			<div class="item" style="left:86px; top:86px;">
				<div class="link"><a href="#;" onclick="addTxt('N')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">N</div>
			</div>
			<div class="item" style="left:129px; top:86px;">
				<div class="link"><a href="#;" onclick="addTxt('O')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">O</div>
			</div>
			<div class="item" style="left:172px; top:86px;">
				<div class="link"><a href="#;" onclick="addTxt('P')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">P</div>
			</div>
			<div class="item" style="left:215px; top:86px;">
				<div class="link"><a href="#;" onclick="addTxt('Q')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">Q</div>
			</div>
			<div class="item" style="left:258px; top:86px;">
				<div class="link"><a href="#;" onclick="addTxt('R')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">R</div>
			</div>
			<!--S-Y-->
			<div class="item" style="top:129px;">
				<div class="link"><a href="#;" onclick="addTxt('S')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">S</div>
			</div>
			<div class="item" style="left:43px; top:129px;">
				<div class="link"><a href="#;" onclick="addTxt('T')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">T</div>
			</div>
			<div class="item" style="left:86px; top:129px;">
				<div class="link"><a href="#;" onclick="addTxt('U')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">U</div>
			</div>
			<div class="item" style="left:129px; top:129px;">
				<div class="link"><a href="#;" onclick="addTxt('V')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">V</div>
			</div>
			<div class="item" style="left:172px; top:129px;">
				<div class="link"><a href="#;" onclick="addTxt('W')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">W</div>
			</div>
			<div class="item" style="left:215px; top:129px;">
				<div class="link"><a href="#;" onclick="addTxt('X')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">X</div>
			</div>
			<div class="item" style="left:258px; top:129px;">
				<div class="link"><a href="#;" onclick="addTxt('Y')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">Y</div>
			</div>
			<!--Z-6-->
			<div class="item" style="top:172px;">
				<div class="link"><a href="#;" onclick="addTxt('Z')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">Z</div>
			</div>
			<div class="item" style="left:43px; top:172px;">
				<div class="link"><a href="#;" onclick="addTxt('1')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">1</div>
			</div>
			<div class="item" style="left:86px; top:172px;">
				<div class="link"><a href="#;" onclick="addTxt('2')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">2</div>
			</div>
			<div class="item" style="left:129px; top:172px;">
				<div class="link"><a href="#;" onclick="addTxt('3')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">3</div>
			</div>
			<div class="item" style="left:172px; top:172px;">
				<div class="link"><a href="#;" onclick="addTxt('4')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">4</div>
			</div>
			<div class="item" style="left:215px; top:172px;">
				<div class="link"><a href="#;" onclick="addTxt('5')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">5</div>
			</div>
			<div class="item" style="left:258px; top:172px;">
				<div class="link"><a href="#;" onclick="addTxt('6')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">6</div>
			</div>
			<!--7-0-->
			<div class="item" style="top:215px;">
				<div class="link"><a href="#;" onclick="addTxt('7')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">7</div>
			</div>
			<div class="item" style="left:43px; top:215px;">
				<div class="link"><a href="#;" onclick="addTxt('8')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">8</div>
			</div>
			<div class="item" style="left:86px; top:215px;">
				<div class="link"><a href="#;" onclick="addTxt('9')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">9</div>
			</div>
			<div class="item" style="left:129px; top:215px;">
				<div class="link"><a href="#;" onclick="addTxt('0')"><img src="<%=static_url%>/images/t.gif" /></a></div>
				<div class="txt">0</div>
			</div>
			
		</div>
	</div>
	
	<!--line-->
	<div class="line-s"><img src="<%=static_url%>/images/line-s.png" /></div>
	
	<!--result-search-->
	<div class="search-result" id="search-result">
		<div class="title" id="totalNum"></div>
		
		<div class="item" id="item_0" style="display:none">
			<div class="link"><a href="#" id="a_0" onclick="gotoVodPlay(0)" onfocus="showFullName(0)" onblur="showCutName(0)"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt" id="vod_0"></div>
		</div>
		<div class="item" id="item_1" style="top:91px;display:none">
			<div class="link"><a href="#" id="a_1" onclick="gotoVodPlay(1)" onfocus="showFullName(1)" onblur="showCutName(1)"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt" id="vod_1"></div>
		</div>
		<div class="item" id="item_2" style="top:137px;display:none">
			<div class="link"><a href="#" id="a_2" onclick="gotoVodPlay(2)" onfocus="showFullName(2)" onblur="showCutName(2)"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt" id="vod_2"></div>
		</div>
		<div class="item"  id="item_3" style="top:183px;display:none">
			<div class="link"><a href="#" id="a_3" onclick="gotoVodPlay(3)" onfocus="showFullName(3)" onblur="showCutName(3)"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt" id="vod_3"></div>
		</div>
		<div class="item" id="item_4" style="top:229px;display:none">
			<div class="link"><a href="#" id="a_4" onclick="gotoVodPlay(4)" onfocus="showFullName(4)" onblur="showCutName(4)"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt" id="vod_4"></div>
		</div>
		<div class="item" id="item_5" style="top:275px;display:none">
			<div class="link"><a href="#" id="a_5" onclick="gotoVodPlay(5)" onfocus="showFullName(5)" onblur="showCutName(5)"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt" id="vod_5"></div>
		</div>
		<div class="item"  id="item_6" style="top:321px;display:none">
			<div class="link"><a href="#" id="a_6" onclick="gotoVodPlay(6)" onfocus="showFullName(6)" onblur="showCutName(6)"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt" id="vod_6"></div>
		</div>
		<div class="item" id="item_7" style="top:367px;display:none">
			<div class="link"><a href="#" id="a_7" onclick="gotoVodPlay(7)" onfocus="showFullName(7)" onblur="showCutName(7)"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt" id="vod_7"></div>
		</div>
		<div class="item" id="item_8" style="top:413px;display:none">
			<div class="link"><a href="#" id="a_8" onclick="gotoVodPlay(8)" onfocus="showFullName(8)" onblur="showCutName(8)"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="txt" id="vod_8"></div>
		</div>
	</div>
	
	<!--pages-->
	<div class="pages page-sty05" id="pageUpAndDwn" style="visibility:hidden">
		<div class="item">
			<div class="pic"><a href="#;" onclick="pageAction( -1 )"><img src="<%=static_url%>/images/btn-prev.png" width="78" height="30" /></a></div>
		</div>
		<div class="item" style="left:87px;">
			<div class="pic"><a href="#;" onclick="pageAction( 1 )"><img src="<%=static_url%>/images/btn-next.png" width="78" height="30" /></a></div>
		</div>
		<div class="pages-num" id="page"></div>
	</div>
</div>
</div>
<!--the end-->
<script type="text/javascript">
var pageCount=1;
var pageIndex=<%=pageIndex%>;
var pageSize=9;
var jsonObj;
var vodList;
var backUrl="index.jsp";
var ajaxurl="";
var area = <%=area%>; //7:内容列表
var pos = <%=pos%> ;//焦点
var $$ = {};
function $(id){
	if(!$$[id]){
	   $$[id] = document.getElementById(id);
	}
	return $$[id];
}
function onPageLoad(){
	if(1==area){$("Inputfocus").focus();}
	else if(2==area){
	}
	 searchFilm();
}
 
function searchFilm(){
	if($("searchTxt").innerText!=""&&$("searchTxt").innerText!=undefined)
	{
	  if(0==isreturn){pageIndex = 1;pos =0;}
	  isreturn=0;
	  var url="<%=static_en%>/ajaxdata/search_list_data.jsp?pageIndex="+pageIndex+"&pageSize="+pageSize+"&keywords=CNTVAY"+$("searchTxt").innerText;
	  showInfo();
	  getAJAXData(url,myCallBack);$("a_"+pos).focus();
	}
}
function pageAction(action ){ 
   if(action==1){ pageIndex=pageIndex+1; }else{ pageIndex=pageIndex-1; } 
   if((pageIndex>0)&&(pageIndex<=pageCount)){
	    ajaxurl="<%=static_en%>/ajaxdata/search_list_data.jsp?pageIndex="+pageIndex +"&pageSize="+pageSize+"&keywords=CNTVAY"+$("searchTxt").innerText;
        getAJAXData(ajaxurl,myCallBack);$("a_0").focus();
   }else{
      if(action==1){ pageIndex=pageCount; }else{ pageIndex = 1; } 
   }
}
function myCallBack(respText)
{
	 jsonObj = eval('('+respText+')');
	 vodList = jsonObj.jsonvodlist;
	 pageCount=jsonObj.jsonpagecount;
	 var len=vodList.length;
	 $("totalNum").innerText = "共有"+len+"条搜索结果：";
	 if(len<=0) {
		 $("pageUpAndDwn").style.visibility = "hidden";
	 } else {
		 $("pageUpAndDwn").style.visibility = "visible";
	 }
	 for(var i=len;i<pageSize;i++)
	 {
		$("item_"+i).style.display = "none";
	 } 
	 for(var i=0;i<len;i++)
	 {
	  	$("vod_"+i).innerText = vodList[i].dname.substr(0,20);
		$("item_"+i).style.display = "block";
	 }
	 $("page").innerText=pageIndex+"/"+pageCount;
}

function goBack(){
	 backUrl = getURLtoCookie("search");
	 backUrl = (backUrl!="")?backUrl:"index.jsp";
	 location.href=backUrl ;
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
function showInfo(){
	$("totalNum").innerText = "搜索中，请耐心等候。。。";
}
function showFullName(num){
	 $("vod_"+num).innerHTML = ((vodList[num].dname).length)>20?("<marquee>"+vodList[num].dname+"</marquee>"):(vodList[num].dname);
}
function showCutName(num){
	 $("vod_"+num).innerHTML = ((vodList[num].dname).length)>20?(vodList[num].dname).substr(0,20):vodList[num].dname;
}
function gotoVodPlay(num){
	var programid = vodList[num].dsubvodidlist[0];
	var fatherid = vodList[num].did;
var vodPlayUrl = "<%=static_en%>/player/au_PlayFilm.jsp?PROGID="+programid+"&FATHERSERIESID="+fatherid+"&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=0&BEGINTIME=0&ENDTIME=200000";
	backUrl = "<%=static_en%>/page/search.jsp?area=7&pos="+num+"&pageIndex="+pageIndex+"&keywords="+$("searchTxt").innerText+"&isreturn=1";
	addURLtoCookie("vodPlay",backUrl);
	location.href = vodPlayUrl;
}	

document.onkeypress = keyEvent;
function keyEvent()
{
	var val = event.which ? event.which : event.keyCode;
	return keypress(val);
}
function keypress(keyval)
{
	switch(keyval)
	{
		case 33://pgae_up
		 pageAction(-1 );
			break;
		case 34://page_down
		 pageAction( 1 );
			break;
		case 8:
			goBack();
			break;
	} 
}

</script>
</body>
</html>
