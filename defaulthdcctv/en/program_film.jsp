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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>节目详情-电影_央视高清EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript" src="js/EPGConstants.js"></script>
<script type="text/javascript">
var list;
var returnurl = '<%=request.getParameter("returnurl")!=null?request.getParameter("returnurl"):"index.jsp"%>';
var isfavsucc = -1; //用于判断收藏是否添加成功 0.添加失败(添加接口失败) 1.添加成功 2.收藏夹已满
var succ = -1;
var isbuysucc = -1; //用于判断购买是否成功
var retcode = undefined;
var area0; //左侧菜单
var area1; //相关影片
var area2; //书签控制
var area4; //播放未购买提示确认键
var area5; //套餐包列表
var area6; //确认购买

//editing by ty
//2011年10月19日 17:45:35

    window.onload=function()
   {
	   var areaid=0;
	   var indexid=1;
	   area0=AreaCreator(4,1,new Array(-1,-1,1,1),"menu","className:menuli on","className:menuli");

	   area0.doms[2].domOkEvent = function(){
		   	if(!isfaved){
				getAJAXData("datajsp/space_collectAdd_iframedata.jsp?PROGID="+jsonmediaInfo.VODID+"&PROGTYPE="+jsonmediaInfo.CONTENTTYPE,addCollect);
				//$("ctrframe").src = "datajsp/space_collectAdd_iframedata.jsp?PROGID="+jsonmediaInfo.VODID+"&PROGTYPE="+jsonmediaInfo.CONTENTTYPE;				
										
			}else{
				getAJAXData("datajsp/space_collectDel_iframedata.jsp?PROGID="+jsonmediaInfo.VODID+"&PROGTYPE="+jsonmediaInfo.CONTENTTYPE,delCollect);
				//$("ctrframe").src = "datajsp/space_collectDel_iframedata.jsp?PROGID="+jsonmediaInfo.VODID+"&PROGTYPE="+jsonmediaInfo.CONTENTTYPE;
			}
	   }
	   
	   area0.doms[0].domOkEvent = function(){		   	
	   		if($("about_films").style.display =="none"){ //如果是购买页面
				$("about_films").style.display = "block";
				$("btnbuy0").style.display = "none";
				$("titabout").style.display = "none";
				$("btnsubs").style.display = "none";
				$("titisbuy").style.display = "none";
				$("introduce").style.display ="block";
				pageobj.areas[1] = area1;
			}
	   }
	   
	   //notend 2011年8月20日 15:15:08
	   //需要修改：未判断是否购买
	   area0.doms[1].domOkEvent = function(){
					if(true){//判断是否已购		   
					getAJAXData("datajsp/check_bookmark.jsp?vodid="+jsonmediaInfo.VODID,checkBookmark);
					//$("ctrframe").src = "datajsp/check_bookmark.jsp?vodid="+jsonmediaInfo.VODID;
					}
	   					}
	 
	   area0.doms[3].domOkEvent = function(){
		  if($("btnsubs").style.display =="none"){ //如果不是购买页面	        
				$("about_films").style.display = "none";
				$("btnbuy0").style.display = "block";
				$("titabout").style.display = "block";
				$("btnsubs").style.display = "block";
				$("titisbuy").style.display = "none";
				$("introduce").style.display ="none";
				pageobj.areas[1]=area5;
		  }
	   }
	   
	   if(pstTypestr=="1"){
		   area1=AreaCreator(1,4,new Array(-1,0,-1,-1),"cate_","className:on","className:");	   
	   for(var i=0;i<area1.doms.length;i++){area1.doms[i].imgdom = $("img_"+i);}
	   }else{
		   area1=AreaCreator(1,6,new Array(-1,0,-1,-1),"about","className:on","className:");	   
		   for(var i=0;i<area1.doms.length;i++){area1.doms[i].imgdom = $("img"+i);}
	   }
	   area1.stablemoveindex = new Array("0-2",-1,-1,-1);
	  
	   
	   //弹出层
	  
	  //书签
	   area2 = AreaCreator(1,2,new Array(-1,-1,-1,-1),"div_tip","className:on","className:");
	   area2.doms[0].domOkEvent = function(){  //书签播放
	   	   //location.href = "au_PlayFilm.jsp?PROGID="+jsonmediaInfo.VODID+"&PLAYTYPE="+EPGConstants.PLAY_TYPE_BOOKMARK+"&CONTENTTYPE="+jsonmediaInfo.CONTENTTYPE+"&BUSINESSTYPE="+EPGConstants.BUSINESS_TYPE_VOD+"&BEGINTIME="+begintime+"&ENDTIME="+endtime+"&returnurl="+escape(location.href);
		   location.href = "au_PlayFilm.jsp?PROGID="+jsonmediaInfo.VODID+"&PLAYTYPE="+EPGConstants.PLAY_TYPE_BOOKMARK+"&CONTENTTYPE=0&BUSINESSTYPE="+EPGConstants.BUSINESS_TYPE_VOD+"&BEGINTIME="+begintime+"&ENDTIME="+endtime+"&returnurl="+escape(location.href);
	   
	   }
	   area2.doms[1].domOkEvent = function(){
		   //从头播放
			//alert("alert");	
	   	   //location.href = "au_PlayFilm.jsp?PROGID="+jsonmediaInfo.VODID+"&PLAYTYPE="+EPGConstants.PLAY_TYPE_VOD+"&CONTENTTYPE="+jsonmediaInfo.CONTENTTYPE+"&BUSINESSTYPE="+EPGConstants.BUSINESS_TYPE_VOD+"&returnurl="+escape(location.href);
		   location.href = "au_PlayFilm.jsp?PROGID="+jsonmediaInfo.VODID+"&PLAYTYPE="+EPGConstants.PLAY_TYPE_VOD+"&CONTENTTYPE=0&BUSINESSTYPE="+EPGConstants.BUSINESS_TYPE_VOD+"&returnurl="+escape(location.href);
			popup0.closeme();
	   }
	   var popup0 = new Popup("div_tip",new Array(area2));
	   popup0.goBackEvent=function()
	   {
		   this.closeme();
	   }
	   
	   //添加删除收藏
	   var popup1 = new Popup("div_fav");
	   popup1.closetime = 3;
	   
	   //购买
	   area4 = AreaCreator(1,1,new Array(-1,-1,1,-1),"div_buy","className:on","className:");
	   
	   var popup2 = new Popup("div_buy",new Array(area4),0,1);
	   popup2.goBackEvent=function()
	   {
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
	   
	   area5 = AreaCreator(3,3,new Array(3,0,-1,-1),"subjects","className:on","className:");  //套餐列表
	   area6 = AreaCreator(1,1,new Array(-1,0,2,-1),"btnbuy","className:on","className:");  //确认购买
	   
	   area5.datanum = 9;
	   area5.areaOkEvent = function(){
	   		area6.doms[0].mylink = area5.doms[area5.curindex].youwanauseobj;			
	   }
	   
	   area6.areaOkEvent = function(){
	   		//location.href = "au_PlayFilm.jsp?PROGID="+jsonmediaInfo.VODID+"&PLAYTYPE="+EPGConstants.PLAY_TYPE_VOD+"&CONTENTTYPE="+jsonmediaInfo.CONTENTTYPE+"&BUSINESSTYPE="+EPGConstants.BUSINESS_TYPE_VOD+"&returnurl="+escape(location.href);
			location.href = "au_PlayFilm.jsp?PROGID="+jsonmediaInfo.VODID+"&PLAYTYPE="+EPGConstants.PLAY_TYPE_VOD+"&CONTENTTYPE=0&BUSINESSTYPE="+EPGConstants.BUSINESS_TYPE_VOD+"&returnurl="+escape(location.href);
	   }
	      
	   pageobj=new PageObj(areaid,indexid,new Array(area0,area1,area5,area6),new Array(popup0,popup1,popup2));
	   pageobj.backurl = returnurl;
	   area0.doms[2].updatecontent(isfaved?"移除收藏":"收  &nbsp;&nbsp;  藏");
	   //判断是否已收藏
	  //如果已订购
	  
	  //editing 2011年8月21日 14:24:03
	  //是否显示购买按钮
	  if(true){
		  area0.datanum = 3;
		  $("tmpicon").style.display = "none";
		  $("menu3").style.display = "none";
	  }
	  
	  //填充影片详情
	  setContentData(jsonmediaInfo);
	  //填充相关影片
	  setListData(jsonaboutvods);


	  pageobj.changefocus(areaid,indexid);  
   }
   
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
				area6.areaOkEvent();
			}
	   }
   }
   
   //进行购买
   function dobuy(){
	    //window.alert(retcode);
   		if(retcode==undefined){
			setTimeout("dobuy()",500);
		}else{
			switch(retcode){
				case "0":  //订购成功
					isbuysucc = 0;
					break;
				case "0x07030001":  //订购失败
					isbuysucc = -1;
					break;
				case "0x07030300":  //重复订购，订购失败
					isbuysucc = 0;
					break;   	
				case "0x07000005":  //传入参数失败（用于调试）
					break;
				case "0x07030100":  //数据库异常
					break;
  				case "0x07030200":  //网络异常
					break;
  				case "0x04010004":   //用户不存在或非法用户
					break;
 				case "0x04010899":   //用户令牌非法
					break;
			}
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
</script>
<!-- ZTE-->
<%-- <%@ include file="datajsp\program_film_data.jsp" %> --%>
<%@ include file="datajsp/program_film_data.jsp" %>
</head>

<body>
<!-- ZTE -->
<div  class="main" >
	
	<!--logo-->
	<div class="logo" style="width:620px"><%=name %></div>
	<div class="date" id="currDate">2011年5月30日 | 15:00</div>
	
	
	
	<!--menu-->
	<div class="menu2">
		<div><img src="images/menu_line.png" /></div>
		<div id="menu0" class="menuli">节目信息</div> <!--class="menuli on"-->
		<div><img src="images/menu_line.png" /></div>
		<div id="menu1" class="menuli">播  &nbsp;&nbsp;  放</div>
		<div><img src="images/menu_line.png" /></div>
		<div id="menu2" class="menuli">收  &nbsp;&nbsp;  藏</div>    
		<div><img src="images/menu_line.png" /></div>
		<!-- ZTE -->
		<div id="menu3" style="display:none" class="menuli">购  &nbsp;&nbsp;  买</div>
		<div><img id ="tmpicon" style="display:none" src="images/menu_line.png" /></div>
		<!--
		<div id="menu3" class="menuli">购  &nbsp;&nbsp;  买</div>
		<div><img id ="tmpicon" src="images/menu_line.png" /></div>
		-->
	</div>
	
	
	
	<!--tv-->	
	<div class="dibb"> 
		<div class="tv_choose_pic" id="tv_choose_pic"><img id="sitcom_pst" width="192" height="264" /></div>
		<div class="tv_choose_intro" id="tv_choose_intro">
			<div id="sitcom_name"><b>片名：</b></div>
			<div id="sitcom_price" style="display:none;"><b>价格：</b>元</div>
			<div id="sitcom_dct"><b>导演：</b></div>
			<div id="sitcom_act"><b>主演：</b></div>
			<div><img src="images/line2.png" /></div>
			<div class="f24b" id="introduce" style="">内容简介：</div>
            <!-- <div class="f24b" id="introduce" style="">内容简介：<script>document.write(jsonmediaInfo.PICPATH)</script></div> -->
            <div id="titisbuy" style="display:none;">
            	<div class="f36 padtb2" align="center">已购买请点击播放</div>
				<div class="f36" align="center" id="tittime">有效时间 2011-06-01 15:00</div>
            </div>
            <div class="f36 btns3">
				<div id="btnbuy0" style="display:none;">确认付费</div>
            </div>
			<div class="f24"></div>
		</div>				
	</div>
	
    <!--packet_choose-->
    	
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
			<div id="about0"><img id="img0" src="" width="133" height="186" /></div>
			<div id="about1" style="left:151px;"><img id="img1" src="" width="133" height="186" /></div>
			<div id="about2" style="left:302px;"><img id="img2" src="" width="133" height="186" /></div>
			<div id="about3" style="left:453px;"><img id="img3" src="" width="133" height="186" /></div>
			<div id="about4" style="left:604px;"><img id="img4" src="" width="133" height="186" /></div>
			<div id="about5" style="left:755px;"><img id="img5" src="" width="133" height="186" /></div>
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
<!--初始化加载图片-->
    <div style="visibility:hidden; z-index:-1">
    <img src="images/pic_bg7.png"/>
    <iframe id="ctrframe" width="0" height="0"/>
	</div>
</body>
</html>
