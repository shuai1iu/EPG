<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ include file="../../config/properties.jsp"%>
<%

	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	int areaid = request.getParameter("areaid")==null?0:Integer.parseInt(request.getParameter("areaid"));
	int indexid = request.getParameter("indexid")==null?0:Integer.parseInt(request.getParameter("indexid"));
	
	String parentCategoryCode = "10000100000000090000000000033290";
    String categoryListFile="../../" + datajspname + "/categoryList.jsp";

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>湖北-湖北广电标清EPG2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/common.css" />
<style type="text/css">
.list-a {
	left:25px;
	position:absolute;
	top:151px;
}
.list-a .item .pic {
	background-color:#fff;
	left:3px;
	height:86px;
	width:104px;
}
.list-a .item .pic img {
	left:1px;
	position:absolute;
	top:1px;
}
.list-a .item .txt-wrap {
	background:url(../images/list-txt-bg.png) no-repeat;
	left:119px;
	top:3px;
	height:80px;
	width:159px;
}
.list-a .item .txt {
	color:#0a64a3;
	left:5px;
	top:53px;
	width:154px;
}
.list-a .item .txt-tit {
	color:#000;
	font-size:24px;
	left:16px;
	top:5px;
	width:140px;
}
</style>
<script tyep="text/javascript">

<jsp:include page="<%=categoryListFile%>">
	<jsp:param name="parentCategoryCode" value="<%=parentCategoryCode%>" /> 
	<jsp:param name="pageIndex" value="1" /> 
	<jsp:param name="pageSize" value="6" /> 
    <jsp:param name="varName" value="categoryListData" />
	<jsp:param name="fileds" value="-1" />
</jsp:include>
	
	

	var area0,area1,area2,area3;
	var pageobj=new Object();

	 function $(id) 
	 {
		  return document.getElementById(id);
	 }	

	 var area0={curindex:0,datanum:5,name:"area0"};
	 var area1={curindex:0,datanum:2,name:"area1"};
	 var area2={curindex:0,datanum:6,name:"area2",curpage:categoryListData.curPage,pagenum:categoryListData.totalPage,pagesize:6,rows:3,cols:2};
	 var area3={curindex:0,datanum:2,name:"area3"};

	 pageobj.curareaindex=<%=areaid%>;
	 pageobj.curindex=<%=indexid%>;
	 pageobj.areas=new Array();
	 pageobj.areas.push(area0);
	 pageobj.areas.push(area1);
	 pageobj.areas.push(area2);
	 pageobj.areas.push(area3);

	 area0.changefocusEvent = function(stepvalue){
		$("area0_list_"+area0.curindex).blur();
	    area0.curindex=stepvalue+area0.curindex;
		if(area0.curindex<0){
			area0.curindex=area0.datanum-1;
		}
		if(area0.curindex>=area0.datanum){
			area0.curindex=0;
		}
		$("area0_list_"+area0.curindex).focus();
	 }

	 area1.changefocusEvent = function(stepvalue){
		$("area1_list_"+area1.curindex).blur();
	    area1.curindex=stepvalue+area1.curindex;
		if(area1.curindex<0){
			area1.curindex=area1.datanum-1;
		}
		if(area1.curindex>=area1.datanum){
			area1.curindex=0;
		}
		$("area1_list_"+area1.curindex).focus();
	 }

	 area2.changefocusEvent = function(stepvalue){
		$("area2_list_"+area2.curindex).blur();
	    area2.curindex=stepvalue+area2.curindex;
		if(area2.curindex<0){
			area2.curindex=area2.datanum-1;
		}
		if(area2.curindex>=area2.datanum){
			area2.curindex=area2.curindex-stepvalue;
		}
		$("area2_list_"+area2.curindex).focus();
	 }
	 
	 area3.changefocusEvent = function(stepvalue){
		$("area3_list_"+area3.curindex).blur();
	    area3.curindex=stepvalue+area3.curindex;
		if(area3.curindex<0){
			area3.curindex=area3.datanum-1;
		}
		if(area3.curindex>=area3.datanum){
			area3.curindex=0;
		}
		$("area3_list_"+area3.curindex).focus();
	 }
	 
	 /*
	 area.changefocusEvent = function(area,stepvalue){
	 	var strAreaName = area.name;
	 	$(strAreaName+"_list_"+area2.curindex).blur();
	    area.curindex=stepvalue+area.curindex;
		if(area.curindex<0){
			area.curindex=area.datanum-1;
		}
		if(area.curindex>=area.datanum){
			area.curindex=0;
		}
		$(strAreaName+"_list_"+area.curindex).focus();
	 }
	 */

	 area0.ok = function(){
		area0.doms[area0.curindex].domOkEvent();
	 }
	 
	 area0.doms = new Array();
	 area0.doms[0].domOKEvent = function(){
	 	window.location.href = "";
	 }
	 
	 area0.doms[1].domOKEvent = function(){
	 	window.location.href = "";
	 }
	 
	 area0.doms[2].domOKEvent = function(){
	 	window.location.href = "";
	 }
	 
	 area0.doms[3].domOKEvent = function(){
	 	window.location.href = "";
	 }
	 
	 area0.doms[4].domOKEvent = function(){
	 	window.location.href = "";
	 }

	 area1.ok = function(){
		if(area1.curindex==0){
			area2.pageTurnEvent(-1);
		}else{
			area2.pageTurnEvent(1);
		}
	 }

	 area2.ok = function(){
	 	$('area2_description_0').innerHTML = categoryListData;
		window.location.href = "column-news.jsp?categoryCode="+categoryListData.categoryList[area2.curindex].categoryCode+"&areaid=2&indexid="+area2.curindex;
	 }
	 
	 area3.ok = function(){
		if(area3.curindex==0){
			area2.pageTurnEvent(-1);
		}else{
			area2.pageTurnEvent(1);
		}
	 }

	 area0.pageTurnEvent = function(num){
		 //pageTurnEvent(area0,area0Data,num);
	 }

	 area1.pageTurnEvent = function(num){
		 //pageTurnEvent(area1,area1Data,num);
	 }

	 area2.pageTurnEvent = function(num){
	 	 var area2curpage = area2.curpage+num;
		 if(area2curpage>=1&&area2curpage<=area2.pagenum){
		 	area2.curpage = area2curpage;
			$("hidden_frame").src = "iframe/newsIframe.jsp?curpage="+area2curpage;
		 }
	 }
	 
	 area3.pageTurnEvent = function(num){
		 //pageTurnEvent(area3,area3Data,num);
	 }

	/*
	 function pageTurnEvent(area,areaData,num){
		var strArea = area.name;
		area.curpage = area.curpage + num;
		if(area.curpage<1){
			area.curpage = 1;
		}
		if(area.curpage>area.pagenum){
			area.curpage=area.pagenum;
		}
		var start = (area.curpage-1)*area.pagesize;
		var end = start + area.pagesize;
		if(end>area.total){
			end = area.total;
		}
		var i;
		for(i=start,j=0;i<end;i++,j++){
			$(strArea+'_list_'+j).innerHTML = areaData[i];
		}
		area.datanum = j;
		for(;j<area.pagesize;j++){
			$(strArea+'_list_'+j).innerHTML = " ";
		}
		if(area.curindex>=area.datanum){
			$(strArea+'_list_'+area.curindex).blur();
			area.curindex = 0;
			$(strArea+'_list_'+area.curindex).focus();
		}
	 }
	 */
	 
	 window.onload = function(){

		$('area'+pageobj.curareaindex+"_list_"+pageobj.curindex).focus();

		showPagenum();

	 }
	 
	 function showPagenum(){
	 	
		$('page').innerHTML = categoryListData.curpage+"/"+categoryListData.totalPage+"页";
		
	 }
	 
	 function bindCatalogListData(){
	 	var categoryList = categoryListData.categoryList;
		var length = categoryList.length;
		for(i=0;i<length;i++){
			$("area2_img_"+i).src = categoryList[i].pictureList.poster;
			$("area2_title_"+i).innerHTML = categoryList[i].name;
			$("area2_description_"+i).innerHTML = categoryList[i].description;
		}
		showPagenum();
	 }

     // JScript 文件
		var	KEY_TV_IPTV=1290;
		var	KEY_POWEROFF=1291;
		var	KEY_SUBTITLE=1292;
		var	KEY_BOOKMARK =1293;
		var	KEY_PIP=1294;
		var KEY_LOCAL=1295;
		var KEY_REFRESH=1296;
		var KEY_SETUP=282;
		var KEY_HOME=292;
		var KEY_BACK = 8;
		var KEY_DELETE  = 280;
		var KEY_ENTER=13;
		var KEY_OK =13;
		var KEY_HELP = 284;
		var KEY_LEFT=37;
		var KEY_UP=38;
		var KEY_RIGHT=39;
		var KEY_DOWN=40;
		var KEY_PAGEUP = 33;
		var KEY_PAGEDOWN = 34;
		var KEY_0 = 48;
		var KEY_1 = 49;
		var KEY_2 = 50;
		var KEY_3 = 51;
		var KEY_4 = 52;
		var KEY_5 = 53;
		var KEY_6 = 54;
		var KEY_7 = 55;
		var KEY_8 = 56;
		var KEY_9 = 57;
		var KEY_CHANNELUP = 257;
		var KEY_CHANNELDOWN = 258;
		var KEY_VOLUP = 259;
		var KEY_VOLDOWN =260;
		var KEY_MUTE =261;
		var KEY_PLAY=263;
		var KEY_PAUSE=263;
		var KEY_SEEK=271;
		var KEY_SWITCH = 280;
		var KEY_FAVORITE = 281;
		var KEY_AUDIOCHANNEL=286;
		var KEY_IME= 283;
		var KEY_FASTFORWARD=264;
		var KEY_FASTREWIND=265;
		var KEY_SEEKEND=266;
		var KEY_SEEKBEGIN=267;
		var KEY_STOP=270;
		var KEY_MENU=290;
		//var KEY_RED = 275;
		//var KEY_GREEN = 276;
		//var KEY_YELLOW = 277;
		var KEY_RED = 1108;
		var KEY_GREEN = 1110;
		var KEY_YELLOW = 1109;
		var KEY_BLUE =278 ;
		var KEY_STAR=106;
		var KEY_SHARP=105;
		var KEY_F1 = 291;
		var KEY_F2 = 292;
		var KEY_F3 = 293;
		var KEY_F4 = 294;
		var KEY_F5 = 295;
		var KEY_F6 = 296;
		
		//事件 规范是0x300
		var KEY_EVENT= 768;
		
		document.onirkeypress = keyEvent;
		//document.onkeypress = keyEvent;
		//document.onkeydown = keyEvent;
		function keyEvent()
		{
			var val = event.which ? event.which : event.keyCode;
			return keypress(val);
		}
		function keypress(keyval)
		{
			switch(keyval)
			{
			
				case 87: //up
				case KEY_UP:			
					pageobj.move(0);
					break;
				case 65: //left
				case KEY_LEFT: 
					pageobj.move(1);
					break;
				case 83: //down
				case KEY_DOWN:
					pageobj.move(2);
					break;
				case 68: //right
				case KEY_RIGHT: //right
					pageobj.move(3);
					break;
				case 188:
				case 33:
		        case KEY_PAGEUP:
			        pageobj.pageTurnEvent(-1);
				    break;
		        case 190:
				case 34:
				case KEY_PAGEDOWN:
			        pageobj.pageTurnEvent(1);
					break;
				case 13:
				case KEY_OK: //enter
					pageobj.ok();
					break;
				case 32:    // 空格
				case KEY_BACK:
					pageobj.goBack();
					break;
			    default:return 0;
			}
			return 0;
		}

		pageobj.backurl="index.jsp";
		pageobj.goBack=function(){
			window.location.href=pageobj.backurl;
		};

		pageobj.ok=function(){
			pageobj.areas[pageobj.curareaindex].ok();
		};

		pageobj.move=function(direction){
			switch(direction){
				   case 0:{
					   if(pageobj.curareaindex==0){

					   }else if(pageobj.curareaindex==1){
						 $('area1_list_'+area1.curindex).blur();
						 area0.curindex=0;
						 area1.curindex=0;
						 $('area0_list_'+area0.curindex).focus();
						 pageobj.curareaindex=0;
					   }else if(pageobj.curareaindex==2){
					   		if(area2.curindex<area2.cols){
								$('area2_list_'+area2.curindex).blur();
								$('area1_list_0').focus();
								area1.curindex=0;
								area2.curindex=0
								pageobj.curareaindex=1;
								return 0;
							}
						   var area2curindex = area2.curindex-area2.cols;
						   if(area2curindex>=0){
						   		area2.curindex = area2curindex;
						   		$('area2_list_'+area2curindex).focus();
						  	}	
						 					   
					   }else if(pageobj.curareaindex==3){
						 $('area3_list_'+area3.curindex).blur();
						 area2.curindex=0
						 area3.curindex=0;
						 $('area2_list_'+area2.curindex).focus();
						 pageobj.curareaindex=2;						   
					   }
					   break;  
				   }
				   case 1:{
					   if(pageobj.curareaindex==0){
						    pageobj.areas[pageobj.curareaindex].changefocusEvent(-1);
					   }else if(pageobj.curareaindex==1){
						    pageobj.areas[pageobj.curareaindex].changefocusEvent(-1);	   
					   }else if(pageobj.curareaindex==2){
					   		if(area2.curindex!=0&&area2.curindex!=2&&area2.curindex!=4){
								pageobj.areas[pageobj.curareaindex].changefocusEvent(-1); 
							}else{
								pageobj.areas[pageobj.curareaindex].changefocusEvent(1); 
							}					   
						}else if(pageobj.curareaindex==3){
						    pageobj.areas[pageobj.curareaindex].changefocusEvent(-1);
					   }
					   break;
				   }
				   case 2:{
					   if(pageobj.curareaindex==0){
						 $('area0_list_'+area0.curindex).blur();
						 area0.curindex=0;
						 area1.curindex=0;
						 $('area1_list_'+area1.curindex).focus();
						 pageobj.curareaindex=1;
					   }else if(pageobj.curareaindex==1){
						 $('area1_list_'+area1.curindex).blur();
						 area2.curindex=0;
						 area1.curindex=0;
						 $('area2_list_'+area2.curindex).focus();
						 pageobj.curareaindex=2;
					   }else if(pageobj.curareaindex==2){
					   		if(area2.curindex>=area2.cols*(area2.rows-1)){
								$('area2_list_'+area2.curindex).blur();
								$('area3_list_0').focus();
								area2.curindex=0;
								area3.curindex=0;
								pageobj.curareaindex=3;
								return 0;
							}
						   var area2curindex = area2.curindex+2;
						   if(area2curindex<area2.datanum){
						   		area2.curindex = area2curindex;
						   		$('area2_list_'+area2curindex).focus();
						  	}
					   }else if(pageobj.curareaindex==3){
						   
					   }
					   break;	
				   }
				   case 3:{
					   if(pageobj.curareaindex==0){
						    pageobj.areas[pageobj.curareaindex].changefocusEvent(1);
					   }else  if(pageobj.curareaindex==1){
						    pageobj.areas[pageobj.curareaindex].changefocusEvent(1);  
					   }else  if(pageobj.curareaindex==2){
					   		if(area2.curindex!=1&&area2.curindex!=3&&area2.curindex!=5){
								pageobj.areas[pageobj.curareaindex].changefocusEvent(1); 
							}else{
								pageobj.areas[pageobj.curareaindex].changefocusEvent(-1); 
							}
					   }else  if(pageobj.curareaindex==3){
						    pageobj.areas[pageobj.curareaindex].changefocusEvent(1);
					   }
					   break;
					}
			  }
		 };

		 pageobj.pageTurnEvent = function(num){

			pageobj.areas[pageobj.curareaindex].pageTurnEvent(num);
						 
		}

</script>
</head>

<body style="background:url(../images/bg-news01.jpg) no-repeat;">
	
<!-- menu -->
	<div class="menu-news">
		<!--
		选中为
			class="item item01 item01_select" 2字 
			class="item item02 item02_select" 4字
			class="item item03 item03_select" 5字	 
		-->
		<div class="item item01">
			<div class="link"><a id="area0_list_0" href="#" onfocus="javascript:focus();"><img src="../images/t.gif" width="61" height="37" /></a></div>
			<div class="txt">首页</div>
        </div>
		<div class="item item01 item01_select" style="left:128px;">
			<div class="link"><a id="area0_list_1" href="#"><img src="../images/t.gif" width="61" height="37" /></a></div>
			<div class="txt">湖北</div>
        </div>
		<div class="item item01" style="left:217px;">
			<div class="link"><a id="area0_list_2" href="#"><img src="../images/t.gif" width="61" height="37" /></a></div>
			<div class="txt">名栏</div>
        </div>
		<div class="item item02" style="left:310px;">
			<div class="link"><a id="area0_list_3" href="#"><img src="../images/t.gif" width="112" height="37" /></a></div>
			<div class="txt">经视直播</div>
        </div>
		<div class="item item03" style="left:453px;">
			<div class="link"><a id="area0_list_4" href="#"><img src="../images/t.gif" width="142" height="37" /></a></div>
			<div class="txt">长江新闻号</div>
        </div>
	</div>
<!-- menu the end-->
	
	
<!-- page -->
	<div class="page-a">
		<!--灰色为
				btn-prev02_gray.png
				btn-next02_gray.png
		-->	
		<div class="item"><a id="area1_list_0" href="#"><img src="../images/btn-prev02.png" alt="上页" width="88" height="36" /></a></div>
		<div class="item" style="left:100px;"><a id="area1_list_1" href="#"><img src="../images/btn-next02.png" alt="下页" width="88" height="36" /></a></div>
	</div>
	<div id="page" class="txt" style="color:#75cefc; font-size:18px; left:503px; top:112px; text-align:right; width:100px;"></div>
<!-- page the end-->


<!-- list -->
	<div class="list-a">
		<div id="area2_0" class="item" style="visibility:visible;">
			<div class="link"><a id="area2_list_0" href="#" ><img src="../images/t.gif" width="282" height="87" /></a></div>
			<div class="pic"><img id="area2_img_0" src="${categoryListData.categoryList[0].poster}" /></div>
			<div class="txt-wrap">
				<div id="area2_title_0" class="txt txt-tit">${categoryListData.categoryList[0].name}</div>
				<div id="area2_description_0" class="txt">${categoryListData.categoryList[0].description}</div>
			</div>
		</div>
		<div id="area2_1" class="item" style="left:298px;visibility:visible;">
			<div class="link"><a id="area2_list_1" href="#"><img src="../images/t.gif" width="282" height="87" /></a></div>
			<div class="pic"><img id="area2_img_1" src="${categoryListData.categoryList[1].poster}" /></div>
			<div class="txt-wrap">
				<div id="area2_title_1" class="txt txt-tit">${categoryListData.categoryList[1].name}</div>
				<div id="area2_description_1" class="txt">${categoryListData.categoryList[1].description}</div>
			</div>
		</div>
		<div id="area2_2" class="item" style="top:108px;visibility:visible;">
			<div class="link"><a id="area2_list_2" href="#"><img src="../images/t.gif" width="282" height="87" /></a></div>
			<div class="pic"><img id="area2_img_2" src="${categoryListData.categoryList[2].poster}" /></div>
			<div class="txt-wrap">
				<div id="area2_title_2" class="txt txt-tit">${categoryListData.categoryList[2].name}</div>
				<div id="area2_description_2" class="txt">${categoryListData.categoryList[2].description}</div>
			</div>
		</div>
		<div id="area2_3" class="item" style="left:298px;top:108px;visibility:visible;">
			<div class="link"><a id="area2_list_3" href="#"><img src="../images/t.gif" width="282" height="87" /></a></div>
			<div class="pic"><img id="area2_img_3" src="${categoryListData.categoryList[3].poster}" /></div>
			<div class="txt-wrap">
				<div id="area2_title_3" class="txt txt-tit">${categoryListData.categoryList[3].name}</div>
				<div id="area2_description_3" class="txt">${categoryListData.categoryList[3].description}</div>
			</div>
		</div>
		<div id="area2_4" class="item" style="top:215px;visibility:visible;">
			<div class="link"><a id="area2_list_4" href="#"><img src="../images/t.gif" width="282" height="87" /></a></div>
			<div class="pic"><img id="area2_img_4" src="${categoryListData.categoryList[4].poster}" /></div>
			<div class="txt-wrap">
				<div id="area2_title_4" class="txt txt-tit">${categoryListData.categoryList[4].name}</div>
				<div id="area2_description_4" class="txt">${categoryListData.categoryList[4].description}</div>
			</div>
		</div>
		<div id="area2_5" class="item" style="left:298px;top:215px;visibility:visible;">
			<div class="link"><a id="area2_list_5" href="#"><img src="../images/t.gif" width="282" height="87" /></a></div>
			<div class="pic"><img id="area2_img_5" src="${categoryListData.categoryList[5].poster}" /></div>
			<div class="txt-wrap">
				<div id="area2_title_5" class="txt txt-tit">${categoryListData.categoryList[5].name}</div>
				<div id="area2_description_5" class="txt">${categoryListData.categoryList[5].description}</div>
			</div>
		</div>
	</div>
<!-- list the end-->


<!-- page -->
	<div class="page-a" style="top:468px;">
		<!--焦点为
				class="item item_focus" 
		-->	
		<div class="item "><a id="area3_list_0" href="#"><img src="../images/btn-prev02.png" alt="上页" width="88" height="36" /></a></div>
		<div class="item" style="left:100px;"><a id="area3_list_1" href="#"><img src="../images/btn-next02.png" alt="下页" width="88" height="36" /></a></div>
	</div>
<!-- page the end-->
	
</body>
<iframe name="hidden_frame" id="hidden_frame" style=" visibility:hidden;" width="0" height="0" ></iframe>
</html>
