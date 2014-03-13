<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file="datajsp/util_AdText.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>新闻名栏-今日关注_央视高清EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
</head>
<%@ include file="datajsp/news_today_focus_data.jsp" %>
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript" src="js/EPGConstants.js"></script>
<script type="text/javascript">
        var pageindex = 0;
        var area1;
        var area0;
		var area2;
		var area3;
		var area5;
		var isfavsucc = -1; //用于判断收藏是否添加成功 0.添加失败(添加接口失败) 1.添加成功 2.收藏夹已满
		var isbuysucc = -1; //用于判断购买是否成功
        var isbookmark = undefined;  //是否有书签返回码
		var begintime = '-1';
		var endtiem = '-1';
		
		//页面加载时候执行
        window.onload = function() {
            //导航默认选中 行，列，可移动的方向（-1为不可移动或者区域号 上左下右）
            area0 = AreaCreator(2, 1, new Array(-1, -1, 1, 1), "menu", "className:menuli on", "className:menuli");
            //导航链接地址
            area0.setstaystyle("className:menuli current", 3);
            //栏目列表页面数据
            area1 = AreaCreator(pagesize, 1, new Array(-1, 0, -1, -1), "content_", "className:ch_li on", "className:ch_li");
			area2 = AreaCreator(1, 2, new Array(-1, -1, 1, -1), "sele_", "className:on", "className:");
			area3 = AreaCreator(1, 1, new Array(0, -1, -1, -1), "sele1_", "className:on", "className:");
			var popup1=new Popup("divshowsale",new Array(area2,area3),0,1);
			var popup2=new Popup("divshow");
			
			//弹出层
	   		//书签
		   area5 = AreaCreator(1,2,new Array(-1,-1,-1,-1),"div_tip","className:on","className:");
		   area5.doms[0].domOkEvent = function(){ //书签播放
				location.href = "au_PlayFilm.jsp?PROGID="+jsonContent.VODID+"&PLAYTYPE="+EPGConstants.PLAY_TYPE_BOOKMARK+"&CONTENTTYPE="+jsonContent.CONTENTTYPE+"&BUSINESSTYPE="+EPGConstants.BUSINESS_TYPE_VOD+"&BEGINTIME="+begintime+"&ENDTIME="+endtime+"&returnurl="+escape(location.href);
		   }
	   
		   area5.doms[1].domOkEvent = function(){ //从头播放
				location.href = "au_PlayFilm.jsp?PROGID="+jsonContent.VODID+"&PLAYTYPE="+EPGConstants.PLAY_TYPE_VOD+"&CONTENTTYPE="+jsonContent.CONTENTTYPE+"&BUSINESSTYPE="+EPGConstants.BUSINESS_TYPE_VOD+"&returnurl="+escape(location.href);
				popup3.closeme();
		   }
		   var popup3 = new Popup("div_tip",new Array(area5));
		   popup3.goBackEvent=function()
		   {
			   this.closeme();
		   }
            //是否默认选中需要传递参数进行判断
            pageobj = new PageObj(0, 1, new Array(area0,area1),new Array(popup1,popup2,popup3)); //参数（区域，选中第几个，区域列表）
			//area0.setdarknessfocus(1); //灰色显示的
			
			
			//书签判断
			area1.areaOkEvent = function(){
				//editing 未确定是否有书签，暂时不考虑
				//$("hidden_frame").src = "datajsp/check_bookmark.jsp?vodid="+area1.doms[area1.curindex].youwanauseobj;
				//getbookmark();
				location.href = "au_PlayFilm.jsp?PROGID="+jsonContent.VODID+"&PLAYTYPE="+EPGConstants.PLAY_TYPE_VOD+"&CONTENTTYPE="+jsonContent.CONTENTTYPE+"&BUSINESSTYPE="+EPGConstants.BUSINESS_TYPE_VOD+"&returnurl="+escape(location.href);
			}
			
			popup2.closetime=1;
			popup1.goBackEvent=function()
			{
				   this.closeme();
			}
			
            //区域0的确认事件
            area0.areaOkEvent = function() {
                switch (this.curindex) {
					//editing ty 2011年8月21日 21:26:16
					//case 0: break;
					case 0: return true; break;  
                    case 1:	return true; break;
                    case 2: if(!isfaved){
								$("hidden_frame").src = "datajsp/space_collectAdd_iframedata.jsp?PROGID=<%=vodId%>&PROGTYPE="+jsonContent.CONTENTTYPE;				
								isdofav();						
							}else{
							$("hidden_frame").src = "datajsp/space_collectDel_iframedata.jsp?PROGID="+jsonContent.VODID+"&PROGTYPE="+jsonContent.CONTENTTYPE;
							dodelfav();
						}
						break;
                    case 3: pageobj.popups[0].showme(); return true; break;
                }
            }
			
            area1.setcrossturnpage();
            //下一页事件
            area1.asyngetdata = function(dataurl) {
                $('hidden_frame').src = "datajsp/newstodayfocustasyndata.jsp?curpage=" + this.curpage + "&typeid=<%=typeId%>&curindex="+area1.curindex;
            }
			area1.setpageturnattention("pageup","images/up.png","images/up_gray.png","pagedown","images/down.png","images/down_gray.png");
			
			//切换焦点事件
			area1.changefocusedEvent = function(){
				$('hidden_frame').src = "datajsp/newstodayfocustasyndata.jsp?ccid="+jsonNews[area1.curindex].VODID;
			}
			
			area2.areaOkEvent = function() {
                switch (area2.curindex) {
					case 0: return true; break;
                    case 1: area2.closeme(); return true; break;
                }
            }
			area3.areaOkEvent = function() {
                window.location.href = "package_intro.jsp"; return true; break;  
            }
			
			area0.doms[2].updatecontent(isfaved?"移除收藏":"收  &nbsp;&nbsp;  藏");
            //区域1右移事件
			
			//editing 2011年8月21日 14:24:03
			  //是否显示购买按钮
			  if(true){
				  area0.datanum = 3;
				  $("tmpicon1").style.display = "none";
				  $("menu3").style.display = "none";
				  $("tmpicon0").style.display = "none";
				  $("menu2").style.display = "none";
			 }
			 
             bindData(jsonNews);
  			 bindContent();
			 pageobj.backurl = unescape(returnurl);
        }
		
		function isdofav(){
		   switch(isfavsucc){
			   		case -1:
						setTimeout("isdofav()",500);
						break;
					case 0:
						$("divshowtext").innerHTML = "添加收藏失败，请稍候再试";
						pageobj.popups[1].showme();
						break;
					case 1:
						isfaved = true;						
						$("menu2").innerHTML = "移除收藏";
						$("divshowtext").innerHTML = "节目已成功加入收藏";
						isfavsucc = -1;
						pageobj.popups[1].showme();
						break;
					case 2:
						$("divshowtext").innerHTML = "收藏夹已满，请删除后重试";
						pageobj.popups[1].showme();
						break;
					default:
						break;
			} 	   
   }
   
   function dodelfav(){
	   isfavsucc = succ;
	   switch(isfavsucc){
		   case -1:
				setTimeout("dodelfav()",500);
				break;
			case 0:
				$("divshowtext").innerHTML = "移除收藏失败，请稍候再试";
				pageobj.popups[1].showme();
				break;
			case 1:
				isfaved = false;
				$("divshowtext").innerHTML = "节目已移除收藏";
				$("menu2").innerHTML = "收  &nbsp;&nbsp;  藏";
				pageobj.popups[1].showme();
				isfavsucc = -1;
				succ = -1;
				break;
			default:
				break;
	   }
   }
   
   //editing ty 2011年8月22日 10:40:37
   //获取书签并播放
   function getbookmark(){
	   if(isbookmark==undefined){
		   setTimeout("getbookmark()",500);
	   }else{
		   if(isbookmark==true){  //判断是否有书签
				pageobj.popups[2].showme();
			}else{		
				location.href = location.href = "au_PlayFilm.jsp?PROGID="+jsonSitcoms[area1.curindex].VODID+"&FATHERSERIESID=<%=vodId%>&PLAYTYPE="+EPGConstants.PLAY_TYPE_VOD+"&CONTENTTYPE="+jsonSitcoms[area1.curindex].CONTENTTYPE+"&BUSINESSTYPE="+EPGConstants.BUSINESS_TYPE_VOD+"&returnurl="+escape(location.href);
			}
	   }
   }
    </script>

<body>
<div class="main">
	
	<!--logo-->
	<div class="logo">今日关注</div>
	<div class="date" id="currDate"></div>
	
	
	
	<!--menu-->
	<!--menu-->
	<div class="menu2"> <!--焦点为 class="menuli on"  当前选中为 class="menuli current"-->
		<div><img src="images/menu_line.png" /></div>
		<div id="menu0" class="menuli">节目信息</div> <!--class="menuli on"-->
		<div><img src="images/menu_line.png" /></div>
		<div id="menu1" class="menuli">播  &nbsp;&nbsp;  放</div>
		<div><img src="images/menu_line.png" /></div>
		<div id="menu2" class="menuli">收  &nbsp;&nbsp;  藏</div>    
		<div><img id ="tmpicon0" src="images/menu_line.png" /></div>
		<div id="menu3" class="menuli">购  &nbsp;&nbsp;  买</div>
		<div><img id ="tmpicon1" src="images/menu_line.png" /></div>
	</div>
	
	
	
	<!--list-->
	<div class="choose_list">
		<div align="center"><img id="pageup" src="#" /></div>
		<div class="ch_li" id="content_0"></div>
		<div class="ch_li" id="content_1"></div>
		<div class="ch_li" id="content_2"></div>
		<div class="ch_li" id="content_3"></div>
		<div class="ch_li" id="content_4"></div>
		<div class="ch_li" id="content_5"></div>
		<div class="ch_li" id="content_6"></div>
		<div class="ch_li" id="content_7"></div>
		<div class="ch_li" id="content_8"></div>
		<div class="ch_li" id="content_9"></div>
		<div class="ch_li" id="content_10"></div>
		<div align="center"><img id="pagedown" src="#" /></div>
	</div>
	<div class="line5"><img src="images/lines5.png" /></div>
	
	
	
	
	<!--side_r-->
	<div class="side_r">
		<div><img id="content_pst" src="images/temp/today.jpg" /></div>
		<div id="content_dct"><b>主持：</b>陈木胜</div>
		<div id="content_act"><b>嘉宾：</b>刘德华</div>
		<div class="f24b">内容简介：</div>
		<div id="content_itd">“月亮公主”孟庭苇将会带着什么样的礼物来到现场？在凌晗、程程、范温柔，或热情，你喜欢哪一种女人呢？</div>
	</div>
		
	<!-- book mark -->
	<div class="popup" id="div_tip" style="display:none;">    	
		<div class="pop_fee">是否从书签处开始播放？</div>		
		<div class="pop_btns">
			<div id="div_tip0" class="on">书签播放</div>
			<div>&nbsp;</div>
			<div id="div_tip1">从头播放</div>
	    </div>
    </div>
	
	 <!--bottom_notice-->
	<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>

</div>

<iframe id="hidden_frame" width="0" height="0"/>
<div style="visibility:hidden; z-index:-1">
	    <%@ include file="servertimehelp.jsp" %>
    	<img src="images/down.png"/>
        <img src="images/up.png"/>          
</div>
</body>
</html>
