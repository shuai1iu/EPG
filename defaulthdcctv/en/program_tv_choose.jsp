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
<%@ include file="util/save_focus.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="datajsp/program_tv_choose_data.jsp" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title></title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript" src="js/EPGConstants.js"></script>
<script type="text/javascript">
var vodid = <%=vodId %>;
var returnurl = '<%=request.getParameter("returnurl")!=null?request.getParameter("returnurl"):"index.jsp"%>';
var buystatu = '<%=retcode%>';  // 0.已经购买
var favstatu = 0;  // 0.未收藏
var isfavsucc = -1; //用于判断收藏是否添加成功 0.添加失败(添加接口失败) 1.添加成功 2.收藏夹已满
var succ = -1;
var urlstr = "";
var isbookmark = undefined;  //是否有书签返回码
var begintime = '-1';
var endtiem = '-1';
var isTextBox = undefined;
var area0,area1,area2,area3,area4,area5,area6,area7;
var area8;  //套餐选择
var area9;  //确定购买
var area10;
    window.onload=function()
   {
	   var areaid=0;
	   var indexid=1;
	   area0=AreaCreator(4,1,new Array(-1,-1,2,2),"menu","className:menuli on","className:menuli");
	   area0.stayindexdir ="3";
	   
	   area0.doms[0].domOkEvent = function(){
		   if($("inpchoose").style.display=="block"){			   
			   $("inpchoose").style.display = "block";
			   $("about_films").style.display = "block";
			   $("sitcom_int").style.display = "block";
			   
			   $("inpnum").style.display = "none";
			   $("inpchoose").style.display = "none";
		   	   area0.directions[3]=6;
			   area0.directions[2]=6;
		   }
	   }
	   
	   area0.kk = function(){
			//1.播放DIV:inpnum,inpchoose
	  		//2.购买DIV:btnbuy,titabout,btnsubs
	  		//3.已购买DIV:,titisbuy.titabout,btnsubs(时间显示 tittime)
			switch(area0.curindex){
				case 1:
				if($("inpnum").style.display != "block"){			
						$("inpnum").style.display = "block";
						$("inpchoose").style.display = "block";
						$("btnbuy0").style.display = "none";
						$("titabout").style.display = "none";
						$("btnsubs").style.display = "none";
						$("titisbuy").style.display = "none";
						area0.stablemoveindex=new Array(-1,-1,-1,"0-2>0,1-2>0,2-2>0,3-2>0");
					}
						break;
				case 3:
				if($("inpnum").style.display != "none"){
						$("inpnum").style.display = "none";
						$("inpchoose").style.display = "none";										
						$("btnsubs").style.display = "block";
						$("titabout").style.display = "block";
						$("btnbuy0").style.display = "block";
						area0.stablemoveindex=new Array(-1,-1,-1,"0-4>0,1-4>0,2-4>0,3-4>0");
					}
						break;				
			}
	   }
	   
       area1=AreaCreator(4,9,new Array(0,2,-1,-1),"link","className:on","className:");
	   area1.stablemoveindex = new Array("0-3",-1,-1,-1);
	   if(jsonContent.SUBVODLIST.length==0){
	   		area1.datanum = 0;
	   }else{
		   area1.datanum = jsonContent.SUBVODLIST.length;
	   }
	   
	   area1.setpageturnattention("upicon","images/up.png","images/up_gray.png","downicon","images/down.png","images/down_gray.png");
	   area1.dataareae = area1;
	   area1.curpage = <%=curpage %>;
	   area1.curindex = <%=sitcomIndex%>;
	   area1.setcrossturnpage(); //设定可移动翻页
	   area1.asyngetdata=function()
   {
	   getAJAXData("datajsp/protvchooseasyndata.jsp?curpage="+this.curpage+"&vodid="+vodid,updatapage);
   }
   
   
   //首先判断是否收费
   		//notend 2011年8月20日 15:12:39
		//需要修改：未判断是否购买，必须先判断购买
   	   area1.areaOkEvent = function(){
			if(buystatu=='0'&&false){
				pageobj.popups[2].showme();
			}else{
				getAJAXData("datajsp/check_bookmark.jsp?vodid="+jsonSitcoms[area1.curindex].VODID,checkBookmark);
			}
			return true;
	   }
	   
	   //弹出层
	   //书签
	   area2 = AreaCreator(1,2,new Array(-1,-1,-1,-1),"div_tip","className:on","className:");
	   area2.doms[0].domOkEvent = function(){ //书签播放
	   		if(tempvodid=="-1"){
				tempvodid = jsonSitcoms[area1.curindex].VODID;
			}
              		location.href = "au_PlayFilm.jsp?PROGID="+tempvodid+"&ISTVSERIESFLAG=1&FATHERSERIESID=<%=vodId%>&PLAYTYPE="+EPGConstants.PLAY_TYPE_BOOKMARK+"&CONTENTTYPE="+jsonContent.CONTENTTYPE+"&BUSINESSTYPE="+EPGConstants.BUSINESS_TYPE_VOD+"&BEGINTIME="+begintime+"&ENDTIME="+endtime+"&returnurl="+escape(location.href);
			popup0.closeme();
	   }
	   
	   area2.doms[1].domOkEvent = function(){ //从头播放
	   		if(tempvodid=="-1"){
				tempvodid = jsonSitcoms[area1.curindex].VODID;
			}
			location.href = "au_PlayFilm.jsp?PROGID="+tempvodid+"&ISTVSERIESFLAG=1&FATHERSERIESID=<%=vodId%>&PLAYTYPE="+EPGConstants.PLAY_TYPE_VOD+"&CONTENTTYPE="+jsonContent.CONTENTTYPE+"&BUSINESSTYPE="+EPGConstants.BUSINESS_TYPE_VOD+"&returnurl="+escape(location.href);
	   		popup0.closeme();
	   }
	   var popup0 = new Popup("div_tip",new Array(area2));
	   popup0.goBackEvent=function()
	   {
		   tempvodid = -1;
		   this.closeme();
	   }
	   
	   //添加删除收藏
	   var popup1 = new Popup("div_fav");
	   popup1.closetime = 3;
	   
	   //购买
	   area4 = AreaCreator(1,2,new Array(-1,-1,1,-1),"div_buy","className:on","className:");
	   //var area5 = AreaCreator(1,1,new Array(0,0,-1,0),"div_about","className:on","className:");
	   //area5.stablemoveindex = new Array(-1,-1,-1,"0-1");
	   
	   var popup2 = new Popup("div_buy",new Array(area4),0,1);
	   popup2.goBackEvent=function(){
		   this.closeme();
	   }
	   
	   area4.doms[0].domOkEvent = function(){		   
		   //buystatu = 1;		   
		   //$("div_fav0").innerHTML = "节目已购买成功"
		   area0.changefocus(1,false);
		   area0.changefocus(3,true);
		   area0.curindex = 3;
		   pageobj.closeme();	   
	   }
	   
	   popup2.closemedEvent = function(){
		   	pageobj.changefocus(4,0);
	   }
	   
	   //提示信息窗口关闭时
	   popup1.closemedEvent = function(){
		   if($("div_fav0").innerHTML == "节目已购买成功"){
		   		pageobj.popups[0].showme();
		   }
	   }
	   
	   area0.doms[2].domOkEvent = function(){
		   	if(!isfaved){
				getAJAXData("datajsp/space_collectAdd_iframedata.jsp?PROGID="+jsonContent.VODID+"&PROGTYPE="+jsonContent.CONTENTTYPE,addCollect);												
			}else{
				getAJAXData("datajsp/space_collectDel_iframedata.jsp?PROGID="+jsonContent.VODID+"&PROGTYPE="+jsonContent.CONTENTTYPE,delCollect);				
			}
	   }
	   area0.doms[1].domOkEvent = function(){
				if(buystatu=='0'&&false){
					pageobj.popups[2].showme();
				}else{
					if($("inpchoose").style.display=="none"){
					   $("inpchoose").style.display = "none";
					   $("about_films").style.display = "none";
					   $("sitcom_int").style.display = "none";
					   
					   $("inpnum").style.display = "block";
					   $("inpchoose").style.display = "block";
		   				area0.directions[3]=2;
						area0.directions[2]=2;
	            	}
					if(jsonContent.SUBVODLIST.length!=0){
						pageobj.changefocus(1,area1.curindex);
					}
					//pageobj.popups[0].showme();
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
	   
	  area6 = AreaCreator(1,1,new Array(3,0,3,1),"sitcom_num","className:inp_bgon","className:inp_bg");
	  area6.areaNumTypeEvent = function(num){
	  	if($("sitcom_num").innerHTML.length<5){
			$("sitcom_num").innerHTML+=num;
		}
	  }
	  area6.goBackEvent = function(){
		  if($("sitcom_num").innerHTML.length==0){
			  return false;
		  }else{
			$("sitcom_num").innerHTML = $("sitcom_num").innerHTML.substring(0,$("sitcom_num").innerHTML.length-1);
			return true;
		  }		
	  }
	  
	  
	  area7 = AreaCreator(1,1,new Array(2,0,2,1),"sitcom_ply","className:on","className:");
	  
	  
	  
	  //notend 2011年8月20日 15:11:47
	  //需要修改：未判断是否购买，必须先判断购买  
	  area7.areaOkEvent = function(){
	  	var sitcom_num = parseInt($("sitcom_num").innerText,10);
		var minsitcom_num = parseInt(jsonContent.SUBVODLIST[0].VODNAME,10);
		var maxsitcom_num = parseInt(jsonContent.SUBVODLIST[jsonContent.SUBVODLIST.length-1].VODNAME,10);
		if(sitcom_num<=maxsitcom_num&&sitcom_num>=minsitcom_num){		//如果是在集数内	
			for(var i=0,l=jsonContent.SUBVODNUMLIST.length;i<l;i++){
				if(sitcom_num == jsonContent.SUBVODNUMLIST[i]){
					tempvodid = jsonContent.SUBVODLIST[i].VODID;
				}
			}
			if(tempvodid!=-1){
				getAJAXData("datajsp/check_bookmark.jsp?vodid="+tempvodid,checkBookmark);
			}else{
				$("div_fav0").innerHTML = "集数输入错误，请输入正确的集数";
				pageobj.popups[1].showme();
				sitcom_num = minsitcom_num;
				$("sitcom_num").innerHTML = sitcom_num;
			}
			//getAJAXData("vod_getvodid.jsp?vodid="+jsonContent.VODID+"&sitcomnum="+sitcom_num,getsitvodid);		
		}else if(sitcom_num==0||$("sitcom_num").innerText.length==0){
			$("div_fav0").innerHTML = "集数输入错误，请输入正确的集数";
			pageobj.popups[1].showme();
			sitcom_num = minsitcom_num;
			$("sitcom_num").innerHTML = sitcom_num;
	  	}else{		
			$("div_fav0").innerHTML = "集数输入错误，请输入正确的集数";
			pageobj.popups[1].showme();
			sitcom_num = maxsitcom_num;
			$("sitcom_num").innerHTML = sitcom_num;
		}
	  }
	  
	  area6.areaOkEvent = function(){ area7.areaOkEvent();};
	  
	  area9 = AreaCreator(1,1,new Array(-1,0,4,-1),"btnbuy","className:on","className:");  //确认购买
	  area8 = AreaCreator(3,3,new Array(5,0,-1,-1),"subjects","className:on","className:");  //套餐选择	  
	  
	  area9.areaInedEvent = function(){
	  	 
	  }
	  
	  if(pstTypestr=="1"){
		  area10 = AreaCreator(1,4,new Array(0,0,-1,-1),"cate_","className:on","className:"); //相关影片
		for(var i = 0;i<area10.doms.length;i++){area10.doms[i].imgdom = $("img_"+i);}
	  }else{
	  	area10 = AreaCreator(1,6,new Array(0,0,-1,-1),"about","className:on","className:"); //相关影片
		for(var i = 0;i<area10.doms.length;i++){area10.doms[i].imgdom = $("img"+i);}
	  }
	  
	  
	  
	  area10.areaInedEvent = function(){
	  	
	  }
	  
	  area6.areaInedEvent = function(){
		  isTextBox = 1;
	  }
	  
	  area6.areaOutedEvent = function(){
	  	 isTextBox = undefined;
	  }
	  pageobj=new PageObj(areaid,indexid,new Array(area0,area1,area6,area7,area8,area9,area10),new Array(popup0,popup1,popup2));
	  pageobj.backurl = returnurl;
	  area0.doms[2].updatecontent(isfaved?"移除收藏":"收  &nbsp;&nbsp;  藏");
	  
	  //判断焦点，设定移动策略
	   if(areaid==0&&indexid==0){
		  area0.directions[3]=6;
		  area0.directions[2]=6;
	  }else if(areaid==0&&indexid==1){
		  area0.directions[3]=2;
		  area0.directions[2]=2;
	  }
	   //判断是否已收藏
	  jsonSitcoms = getItmsByPage(jsonContent.SUBVODLIST,area1.curpage,pagesize)
	  setListData(jsonSitcoms);
	  setContentData(jsonContent);
	  setaboutListData(jsonaboutvods);
//ZTE
	  setProgInfoData( jsonprogList);document.getElementById("main_id_0").style.display="block";	 
// setProgInfoData(jsonprogList);
	  if(jsonContent.SUBVODLIST.length!=0){
	  	area0.doms[area0.curindex].ok();
	  }
	  //是否显示购买按钮
	  if(true){
		  area0.datanum = 3;
		  $("tmpicon").style.display = "none";
		  $("menu3").style.display = "none";
	  }
	  
	  //1.播放DIV:inpnum,inpchoose
	  //2.购买DIV:btnbuy,titabout,btnsubs
	  //3.已购买DIV:,titisbuy.titabout,btnsubs(时间显示 tittime)
	  
   } 
   
   //删除收藏
   function dodelfav(){
	   switch(isfavsucc){
		   case -1:
				setTimeout("dodelfav()",500);
				break;
			case 0:
				$("div_fav0").innerHTML = "移除收藏失败，请稍候再试";
				pageobj.popups[1].showme();
				break;
			case 1:
				isfaved = false;
				$("div_fav0").innerHTML = "节目已移除收藏";
				$("menu2").innerHTML = "收  &nbsp;&nbsp;  藏";
				pageobj.popups[1].showme();
				isfavsucc = -1;
				succ = -1;
				break;
			default:
				break;
	   }
   }
   
   //获取书签并播放
   function getbookmark(){
	   if(isbookmark==undefined){
		   setTimeout("getbookmark()",500);
	   }else{
		   if(isbookmark==true){  //判断是否有书签
				pageobj.popups[0].showme();
			}else{		
				if(tempvodid=="-1"){					
					tempvodid = jsonSitcoms[area1.curindex].VODID;
				}
			location.href = "au_PlayFilm.jsp?PROGID="+tempvodid+"&ISTVSERIESFLAG=1&FATHERSERIESID=<%=vodId%>&PLAYTYPE="+EPGConstants.PLAY_TYPE_VOD+"&CONTENTTYPE="+jsonContent.CONTENTTYPE+"&BUSINESSTYPE="+EPGConstants.BUSINESS_TYPE_VOD+"&returnurl="+escape(location.href);
			}
	   }
   }
   
    //获取集数
   function gettempvodid(){
	   if(tempvodid=="-1"){
		   setTimeout("gettempvodid()",200);
	   }else{
		   getAJAXData("datajsp/check_bookmark.jsp?vodid="+tempvodid,checkBookmark);	   		
			//$("hidden_frame").src = "datajsp/check_bookmark.jsp?vodid="+tempvodid;
	   }
   }
   
   //收藏
   function isdofav(){
		   switch(isfavsucc){
			   		case -1:
						setTimeout("isdofav()",500);
						break;
					case 0:
						$("div_fav0").innerHTML = "添加收藏失败，请稍候再试";
						pageobj.popups[1].showme();
						break;
					case 1:
						isfaved = true;						
						$("menu2").innerHTML = "移除收藏";
						$("div_fav0").innerHTML = "节目已成功加入收藏";
						isfavsucc = -1;
						pageobj.popups[1].showme();
						break;
					case 2:
						$("div_fav0").innerHTML = "收藏夹已满，请删除后重试";
						pageobj.popups[1].showme();
						break;
					default:
						break;
			} 	   
   }
    
//添加收藏
function addCollect(resultstr){
	isfavsucc = parseInt(resultstr);
	isdofav();
}
//删除收藏
function delCollect(resultstr){
	isfavsucc = parseInt(resultstr);
	dodelfav();
}

//查找书签
function checkBookmark(resultstr){
	var resultmsg = eval('('+resultstr+')');
	isbookmark = resultmsg.isbookmark;
	begintime = resultmsg.begintime;
	endtime = resultmsg.endtime;
	getbookmark();
}	

//翻页
function updatapage(jsonstr){
	jsonSitcoms = getItmsByPage(jsonContent.SUBVODLIST,area1.curpage,pagesize);
	setListData(jsonSitcoms);
}

//根据集数获取vodid
function getsitvodid(resultstr){
	tempvodid = parseInt(resultstr);
	gettempvodid();
}

  
</script>
</head>

<body>
<!--ZTE-->
<div  class="main" id="main_id_0" style="display:none">
<!-- <div  class="main"> -->
	
	<!--logo-->
	<div class="logo" style="width:630px"><%=name %></div>
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
		<div><img src="images/menu_line.png" id="tmpicon"/></div>
	</div>
	
	
	
	<!--tv-->	
	<div class="dibb"> 
		<div id="tv_choose_pic" class="tv_choose_pic"><img id="sitcom_pst" width="192" height="264" /></div>
        <!--tv_choose_input-->	
		<div class="tv_choose_input" id="inpnum" style=" display:none;">
			<div class="f24b">集数选择：</div>
			<div class="inp_bg" id="sitcom_num0"><div id="sitcom_num" style="color:#000;text-align:center;"></div></div> <!--class="inp_bg"/ class="inp_bgon"-->
			<div class="pop_btns" style="top:110px; left:30px; font-size:36px">	
				<div id="sitcom_ply0">播 放</div>
			</div>
		</div>
        
		<div id="tv_choose_intro" class="tv_choose_intro">
			<div id="sitcom_name"><b>片名：</b></div>
			<div id="sitcom_price" style="display:none;"><b>价格：</b></div>
			<div id="sitcom_dct"><b>导演：</b></div>
			<div id="sitcom_act"><b>主演：</b></div>
			<div><img src="images/line2.png" /></div>
            <div id="titisbuy" style="display:none;">
            	<div class="f36 padtb2" align="center">已购买请点击播放</div>
				<div class="f36" align="center" id="tittime">有效时间 2011-06-01 15:00</div>
            </div>
            <div class="f24b" id="sitcom_int"></div>
            <div class="f36 btns3">
				<div id="btnbuy0" style="display:none">确认付费</div>
            </div>
	</div>	
        <!-- tv_choose -->	
	<div class="dibb2" style="width:680px;top:192px;left:230px;display:none;" id="inpchoose">
    	<div class="arrow2"><img src="images/up.png" id="upicon" /></div>
		<div class="tv_choose_episode" style="width:680px">
			<div id="link0"></div> 
			<div id="link1"></div>
			<div id="link2"></div>
			<div id="link3"></div>
			<div id="link4"></div>
			<div id="link5"></div>
			<div id="link6"></div>
			<div id="link7"></div>
			<div id="link8"></div>
			<div id="link9"></div>
			<div id="link10"></div>
			<div id="link11"></div>
			<div id="link12"></div> 
			<div id="link13"></div>
			<div id="link14"></div>
			<div id="link15"></div>
			<div id="link16"></div>
			<div id="link17"></div>
			<div id="link18"></div>
			<div id="link19"></div>
			<div id="link20"></div>
			<div id="link21"></div>
			<div id="link22"></div>
			<div id="link23"></div>
			<div id="link24"></div>
			<div id="link25"></div>
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
        <div class="arrow2" style="top:350px"><img id="downicon" src="images/down.png" /></div>		
	</div>			
	</div>
    <!--tv_choose-->
    	
	<div class="dibb4" id="titabout" style="display:none;">
		<div class="f24b">所属套餐：</div>
		<div class="line4"><img src="images/line4.png" /></div>		
  	</div>
  	
	
	<div class="film_list4" id="btnsubs" style="display:none;">
		<div id="subjects0">大众点播包</div>
		<div id="subjects1">最新影视</div>
		<div id="subjects2">央视风云</div>
		<div id="subjects3">学习教育</div>
		<div id="subjects4">大众点播包</div>
		<div id="subjects5">少儿动画</div>
		<div id="subjects6">学习教育</div>
		<div id="subjects7">大众点播包</div>
        <div id="subjects8">家庭影院</div>
  	</div>
    
    <!--tv_choose-->	
	<div class="dibb3" id="about_films" style="">
		<div class="f24b">相关影片：</div>
		<div class="line4"><img src="images/line4.png" /></div>
		<div class="film_list2" id="film_list2" style="display:none;">
			<div id="about0" ><img id="img0" src="" width="133" height="186" /></div>
			<div id="about1" style="left:151px"><img id="img1" src="" width="133" height="186" /></div>
			<div id="about2" style="left:302px"><img id="img2" src="" width="133" height="186" /></div>
			<div id="about3" style="left:453px"><img id="img3" src="" width="133" height="186" /></div>
			<div id="about4" style="left:604px"><img id="img4" src="" width="133" height="186" /></div>
			<div id="about5" style="left:755px"><img id="img5" src="" width="133" height="186" /></div>
		</div>
        <div class="film_list3" id="film_list3" style="display:none;">
			<div id="cate_0"><img src="" id="img_0" width="209" height="186" style="display::none;" /></div>
			<div id="cate_1" style="left:227px"><img src="" id="img_1" width="209" height="186"/></div>
			<div id="cate_2" style="left:454px"><img src="" id="img_2" width="209" height="186"/></div>
			<div id="cate_3" style="left:681px"><img src="" id="img_3" width="209" height="186"/></div>
		</div>		
  </div>
    	
	 <!--bottom_notice-->
	<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>
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
	<div class="popup disno" id="div_buy" display="none">
		<div class="pop_fee f48" style="top:100px">对不起，您未订购本片，请订购后观看</div>
		<!--<div class="pop_fee f48" style="top:100px">很遗憾！操作没有成功</div>	-->
		<div class="pop_price f24" style="top:160px"></div>
		<div class="pop_btns po2">	
			<div class="on" id="div_buy0">确定</div>
	  </div>
	</div>
   
</div>
<%@ include file="servertimehelp.jsp" %>
    <div style="visibility:hidden; z-index:-1">
    <img src="images/tv_choose_bgon.png"/>
    <img src="images/inp_bgon.png"/>  
    <img src="images/menu_bgon.png"/>
    <iframe id="hidden_frame" width="0" height="0"></iframe>
	</div>
</body>
</html>
