<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="ppvData/ppvListData.jsp"%>
<%@ include file="util/save_focus.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>看大片列表</title>
<style type="text/css">
body, div, h1, h2, h3, h4, h5, h6, button, input, textarea, th, td { margin:0; padding:0; }
a { text-decoration: none; }
fieldset, img { border: 0; }

	body {
		background:url(../images/bg-list.jpg) no-repeat;
		width:640px;height:526px; 
		background-color:#000000;
		color:#FFF;
	}	
	.item,
	.link,
	.icon,
	.txt,
	.pic { 
		left:0;
		position:absolute;  
		top:0;
	}
	.link { z-index:3;}
	.pic { z-index:2;}
	.headline {
		font-size:26px;
		height:40px;
		line-height:40px;
		left: 33px;
		position:absolute;
		top: 6px;
		width: 500px;
	}
	.favList {
		position:absolute;
		left: 20px;
		top: 92px;
		width: 594px;
		height: 363px;
	}
	.pageNum {
		position:absolute;
		left: 277px;
		top: 434px;
		width: 86px;
		height: 36px;
	}
	.filmList { 
		left: 12px;
		position:absolute;  
		top: 55px;
	}
	.filmList .item {
		background:url(../images/pic-145X198-bg.png) no-repeat;
		height:208px;
		width:155px;
	}
	.filmList .item .link,
	.filmList .item .pic {
		left:5px;
		top:5px;
	}
	.filmList .item .link,
	.filmList .item .link img {
		height:198px;
		width:145px;
	}
	.filmList .item .pic,
	.filmList .item .pic img {
		height:198px;
		width:145px;
	}
	.pages { 
		left: 24px;
		position:absolute;  
		top: 483px;
	}
	.pages .txt {
		font-size:18px;
		height:30px;
		line-height:30px;
	}
	.pages .txt-num {
		color:#7cc9e6;
		left:246px;
		text-align:center;
		width:100px;
	}
	.pages .txt-num span {
		color:#fff;
	}
</style>
</head>

<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
var area0;
var pageobj;
var areaid = 0,indexid = 0;
var cruntpage="";
var temppageTurnList=new Array();
var returnurl = '<%=request.getParameter("returnurl")==null?"index.jsp":request.getParameter("returnurl")%>';
window.onload = function()
{
	
	area0 = AreaCreator(2,4,new Array(-1,-1,-1,-1),"area0_list_","afocus","ablur");
	area0.pagecount = Math.ceil(contentTotal/8);
	for(i=0;i<8;i++)
	{
	   area0.doms[i].imgdom=$("area0_icon_"+i);
	}
	area0.areaOkEvent = function()
	{
		if(temppageTurnList[area0.curindex].VODID!=undefined)
		{
			window.location.href="vod-tv-detail.jsp?vodid="+temppageTurnList[area0.curindex].VODID+"&typeid=<%=typeID%>"+"&isPPVFlag=1"+"&returnurl="+escape(location.href);
			saveFocstr(pageobj);
		}
	}
	area0.asyngetdata=function()
	{
		//turnpageShowData(this.curpage)
		 $('hidden_frame').src = "<%=basePath%>ppvData/ppvListData.jsp?isFirstFlag=1&stratPosition="+(this.curpage-1)*8;
		//getAJAXData("datajsp/actionFilmData.jsp?stratPosition="+(this.curpage-1)*8+"&isFirstFlag=1",bindFilmsData);
		
	}
	area0.goBackEvent = function()
	{
		pageobj.backurl=returnurl;
	}
	
	if(focusObj!=undefined&&focusObj!="null")
	{
		areaid = parseInt(focusObj[0].areaid);
		indexid = parseInt(focusObj[0].curindex);
		cruntpage = parseInt(focusObj[0].curpage);
	}
	pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area0),null);
	if(cruntpage!=""&&cruntpage!=1)
	{
		area0.curpage = cruntpage;
	    $('hidden_frame').src = "<%=basePath%>ppvData/ppvListData.jsp?isFirstFlag=1&stratPosition="+(area0.curpage-1)*8;
	}
	else
	{
	    bindFilmsData(ppvListData);
	}
}
  
function bindFilmsData(datavalue)
{
	temppageTurnList = datavalue;
    var start = (area0.curpage-1)*8;
	var size = (contentTotal-start)>=8?8:(contentTotal-start);
	area0.setpageturndata(size, area0.pagecount);
	for(i=0;i<area0.doms.length;i++)
	{
		
		
		            
					
					
	   if(i<datavalue.length)
	   {
		   area0.doms[i].updateimg(datavalue[i].POSTERPATHS==undefined?"../images/nopicture.jpg":datavalue[i].POSTERPATHS);
		   $("area0_list_"+i).style.display="block";
	   }
	   else
	   {
		   area0.doms[i].updateimg("#");
		   $("area0_list_"+i).style.display="none";
	   }
	}
	
	if(datavalue.length>0)
	{ 
	    $("page").innerHTML ="<span>"+area0.curpage+"</span>/"+area0.pagecount;
	}
	else
	{
		$("page").innerHTML = "";
	}
}
</script>
<body>	


<!--head-->
	<div class="headline" style="size:1px">好片库</div>
<!--head the end-->


<!--list-->
	<div class="filmList">
		<div class="item">
			<div class="link"><a href="#" id="area0_list_0"><img src="../images/dot.gif" /></a></div>
			<div class="pic"><img id="area0_icon_0" src="#" /></div>
		</div>
		<div class="item" style="left:153px;">
			<div class="link"><a href="#" id="area0_list_1"><img src="../images/dot.gif" /></a></div>
			<div class="pic"><img id="area0_icon_1" src="#" /></div>
		</div>
		<div class="item" style="left:306px;">
			<div class="link"><a href="#" id="area0_list_2"><img src="../images/dot.gif" /></a></div>
			<div class="pic"><img id="area0_icon_2" src="#" /></div>
		</div>
		<div class="item" style="left:459px;">
			<div class="link"><a href="#" id="area0_list_3"><img src="../images/dot.gif" /></a></div>
			<div class="pic"><img id="area0_icon_3" src="../images/demopic/pic-145X198.jpg" /></div>
		</div>
		
		<div class="item" style="top:215px;">
			<div class="link"><a href="#" id="area0_list_4"><img src="../images/dot.gif" /></a></div>
			<div class="pic"><img id="area0_icon_4" src="#" /></div>
		</div>
		<div class="item" style="left:153px;top:215px;">
			<div class="link"><a href="#" id="area0_list_5"><img src="../images/dot.gif" /></a></div>
			<div class="pic"><img id="area0_icon_5" src="#" /></div>
		</div>
		<div class="item" style="left:306px;top:215px;">
			<div class="link"><a href="#" id="area0_list_6"><img src="../images/dot.gif" /></a></div>
			<div class="pic"><img id="area0_icon_6" src="#" /></div>
		</div>
		<div class="item" style="left:459px;top:215px;">
			<div class="link"><a href="#" id="area0_list_7"><img src="../images/dot.gif" /></a></div>
			<div class="pic"><img id="area0_icon_7" src="#" /></div>
		</div>
	</div>
<!--list the end-->
	
	
	
<!--pages-->
	<div class="pages">
		<div class="txt txt-num" id="page"></div>
	</div>
<!--pages the end-->
<iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="0" height="0" ></iframe>	
</body>
</html>
