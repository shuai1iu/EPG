<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><%@ include file="../common/golbal.jsp" %> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>深圳奥运专题高清3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="<%=static_url%>/css/style.css" />
<script type="text/javascript">
if(typeof(iPanel)!= 'undefined'){iPanel.focusWidth = "8"; iPanel.defaultFocusColor = "#2A5BB8";}
</script>
<script type="text/javascript" src="<%=static_url%>/js/common.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/cookie.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/ajax_common.js"></script>
</head>
<%@ include file="../datasource/datasource.jsp"%>
<%@ include file="../datasource/property.jsp"%>
<% 
   DataSource dataSource=new DataSource(request); 
   int pos = dataSource.huaWeiUtil.getInt(request.getParameter("pos"),0);
   int area = dataSource.huaWeiUtil.getInt(request.getParameter("area"),2);
   int pageIndex = dataSource.huaWeiUtil.getInt(request.getParameter("pageIndex"),1);
   int pageSize = dataSource.huaWeiUtil.getInt(request.getParameter("pageSize"),10);
   String postertype = "2";
   int pageCount=0;
   String categoryId = guanjunzhongguo;
   
%>
<body onload="onPageLoad()">
<% String currentPageId = "_1003"; %>
<%@ include file="../common/head.jsp" %>

<!--sub-->
<div class="sub">  <!--item-focus为焦点；select为当前选中;若有item-focus为焦点则去掉<div class="link"><a href="#"><img src="<%=static_url%>/images/t.gif" /></a></div>--> 
	<div class="item item-focus">
		<div class="link"><a href="#"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">冠军中国</div>
	</div> 
	<div class="item" style="left:151px;">
		<div class="link"><a href="china-corps.jsp"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">中国军团</div>
	</div>
	<div class="item" style="left:301px;">
		<div class="link"><a href="china-daily-star.jsp"><img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="txt">每日一星</div>
	</div>
</div>	
<!--the end-->



<!--list-->
<div class="content">
	<div class="pic-list">   <!--item-focus为焦点--> 
		<div class="item" id="item_0" style="display:none;">
			<div class="link"><a href="#" id="div_a_0" onclick="gotoVodPlay(0)" onfocus="showFullName(0)" onblur="showCutName(0)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="pic"><img id="img_0" src="#" /></div>
			<div class="txt" id="vod_0"></div>
		</div>
		<div class="item" id="item_1" style="left:242px;display:none;">
			<div class="link"><a href="#" id="div_a_1" onclick="gotoVodPlay(1)" onfocus="showFullName(1)" onblur="showCutName(1)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="pic"><img id="img_1" src="#" /></div>
			<div class="txt" id="vod_1"></div>
		</div>
		<div class="item" id="item_2" style="left:484px;display:none;">
			<div class="link"><a href="#" id="div_a_2" onclick="gotoVodPlay(2)" onfocus="showFullName(2)" onblur="showCutName(2)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="pic"><img id="img_2" src="#" /></div>
			<div class="txt" id="vod_2"></div>
		</div>
		<div class="item" id="item_3" style="left:726px;display:none;">
			<div class="link"><a href="#" id="div_a_3" onclick="gotoVodPlay(3)" onfocus="showFullName(3)" onblur="showCutName(3)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="pic"><img id="img_3" src="#" /></div>
			<div class="txt" id="vod_3"></div>
		</div>
		<div class="item" id="item_4" style="left:968px;display:none;">
			<div class="link"><a href="#" id="div_a_4" onclick="gotoVodPlay(4)" onfocus="showFullName(4)" onblur="showCutName(4)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="pic"><img id="img_4" src="#" /></div>
			<div class="txt" id="vod_4"></div>
		</div>
	</div>
	
	<div class="pic-list" style="top:225px;">
		<div class="item"  id="item_5" style="display:none;">
			<div class="link"><a href="#" id="div_a_5" onclick="gotoVodPlay(5)" onfocus="showFullName(5)" onblur="showCutName(5)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="pic"><img id="img_5" src="#" /></div>
			<div class="txt" id="vod_5"></div>
		</div>
		<div class="item" id="item_6" style="left:242px;display:none;">
			<div class="link"><a href="#" id="div_a_6" onclick="gotoVodPlay(6)" onfocus="showFullName(6)" onblur="showCutName(6)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="pic"><img id="img_6" src="#" /></div>
			<div class="txt" id="vod_6"></div>
		</div>
		<div class="item" id="item_7" style="left:484px;display:none;">
			<div class="link"><a href="#" id="div_a_7" onclick="gotoVodPlay(7)" onfocus="showFullName(7)" onblur="showCutName(7)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="pic"><img id="img_7" src="#" /></div>
			<div class="txt" id="vod_7"></div>
		</div>
		<div class="item" id="item_8" style="left:726px;display:none;">
			<div class="link"><a href="#" id="div_a_8" onclick="gotoVodPlay(8)" onfocus="showFullName(8)" onblur="showCutName(8)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="pic"><img id="img_8" src="#" /></div>
			<div class="txt" id="vod_8"></div>
		</div>
		<div class="item" id="item_9" style="left:968px;display:none;">
			<div class="link"><a href="#" id="div_a_9" onclick="gotoVodPlay(9)" onfocus="showFullName(9)" onblur="showCutName(9)">
            <img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="pic"><img id="img_9" src="#" /></div>
			<div class="txt" id="vod_9"></div>
		</div>
	</div>
	
</div>

	<!--pages-->
	<div class="pages page-sty02" style="border-top:none; left:44px;">
		<div class="item">
			<div class="pic"><a href="#" onclick="pageAction(-1)"><img src="<%=static_url%>/images/btn-prev.png" width="78" height="30" /></a></div>
		</div>
		<div class="item" style="left:87px;">
			<div class="pic"><a href="#" onclick="pageAction(1)"><img src="<%=static_url%>/images/btn-next.png" width="78" height="30" /></a></div>
		</div>
		<div class="pages-num" id="page"></div>
	</div>

<!--the end-->
<script type="text/javascript">
var pageCount=<%=pageCount%>;
var pageIndex=<%=pageIndex%>;
var pageSize=<%=pageSize%>;
var jsonObj;
var vodList;
var backUrl = "index.jsp";
var ajaxurl="";
var area = <%=area%>; //0:top 1：3个子栏目 2:列表 
var pos = <%=pos%> ;


var $$ = {};
function $(id){
	if(!$$[id]){
	   $$[id] = document.getElementById(id);
	}
	return $$[id];
}
function onPageLoad(){
	 init();
	 initpos(); 
}
function initpos(){
	if(2==area){$("div_a_"+pos).focus();}
}
function init(){
	ajaxurl = "<%=static_en%>/ajaxdata/vod_list_data.jsp?pageIndex="+pageIndex+"&pageSize="+pageSize+"&categoryId=<%=categoryId%>&posterType=<%=postertype%>";
    getAJAXData(ajaxurl,myCallBack);
} 
function myCallBack(respText){
	 jsonObj = eval('('+respText+')');
	 vodList = jsonObj.jsonvodlist;
	 pageCount=jsonObj.jsonpagecount;
	 var len = vodList.length;
	 for(var i=len;i<pageSize;i++){
	 	$("item_"+i).style.display = "none";
	 }
	 for(var i=0;i<len;i++){     
		$("vod_"+i).innerText = ((vodList[i].dname).length)>8?(vodList[i].dname).substr(0,8):vodList[i].dname;
		$("img_"+i).src = vodList[i].dpostpath;
	    $("item_"+i).style.display = "block";
	 }
	 $("page").innerText = ((pageCount == 0)?0:pageIndex)+"/"+pageCount;
	 if(len>=1){$("div_a_"+pos).focus();}
}
function showFullName(num){
	 $("vod_"+num).innerHTML = ((vodList[num].dname).length)>8?("<marquee>"+vodList[num].dname+"</marquee>"):(vodList[num].dname);
}
function showCutName(num){
	 $("vod_"+num).innerHTML = ((vodList[num].dname).length)>8?(vodList[num].dname).substr(0,8):vodList[num].dname;
}
function pageAction(action ){ 
   if(action==1){ pageIndex=pageIndex+1; }else{ pageIndex=pageIndex-1; } 
   if((pageIndex>0)&&(pageIndex<=pageCount)){
      pos = 0; init();
   }else{
      if(action==1){ pageIndex = pageCount; }else{ pageIndex = 1; } 
   }
}

function gotoVodPlay(num){
	var programid = vodList[num].dsubvodidlist[0];
	var fatherid = vodList[num].did;
	//var vodPlayUrl = "<%=static_en%>/player/vodplay.jsp?progId="+programid;
var vodPlayUrl = "<%=static_en%>/player/au_PlayFilm.jsp?PROGID="+programid+"&FATHERSERIESID="+fatherid+"&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=0&BEGINTIME=0&ENDTIME=200000";
	backUrl = "<%=static_en%>/page/china.jsp?area=2&pos="+num+"&categoryId=-1&categoryname=&programid="+programid;
	addURLtoCookie("vodPlay",backUrl);
	location.href = vodPlayUrl;
}	
function goBack(){
	 location.href = "index.jsp";
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
			pageAction(-1);
			break;
		case 34://page_down
			pageAction(1);
			break;
		case 8:
			goBack();
			break;
	} 
}
</script>	
</body>
</html>
