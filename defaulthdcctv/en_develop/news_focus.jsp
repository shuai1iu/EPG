<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="datajsp/news_focusdata.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>焦点新闻_央视高清EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<script type="text/javascript" src="js/pagecontrol.js"></script>

<script type="text/javascript"> 
   var area1;
   var returnurl = '<%=request.getParameter("returnurl")%>';
    window.onload=function()
   {
	   var areaid=<%=request.getParameter("areaid")%>;
	   var indexid=<%=request.getParameter("indexid")%>;
	   var area0=AreaCreator(4,1,new Array(-1,-1,-1,1),"area0_list_","className:menuli on","className:menuli");
	   area0.doms[0].mylink="news_rolling.jsp?returnurl="+escape(returnurl);
	   //area0.doms[1].mylink="news_focus.jsp?returnurl="+returnurl;
	   area0.doms[2].mylink="news_column_name.jsp?returnurl="+escape(returnurl);
	   area0.doms[3].mylink="news_ranking.jsp?returnurl="+escape(returnurl);
	   area0.setstaystyle("className:menuli current",3);
	   area1=AreaCreator(3,1,new Array(-1,0,-1,-1),new Array("area1_list_","area1_title_","area1_detail_","area1_img_"),"className:bgon","className:bg");
	   //popup.closetime=3;
	   pageobj=new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):1,new Array(area0,area1));
	   area1.setpageturnattention("pageup","images/up.png","images/up_gray.png","pagedown","images/down.png","images/down_gray.png");
	   if(areaid!=null&&areaid!=0)
	   area0.setdarknessfocus(1);
	   pageobj.backurl=unescape(returnurl);
	   //getdata(list);
	   area1.setcrossturnpage();
	   area1.asyngetdata=function()
	   {
			 this.lockin=true;
			 $('hidden_frame').src="datajsp/news_focusasyndata.jsp?curpage="+this.curpage+"&typeid=<%=typeId%>";
		}
       getdata(list,pagecount);
   }

   function getdata(data,count)
   {
	   area1.setpageturndata(data.length,parseInt(count));
		for(i=0;i<area1.doms.length;i++)
			{
				if(i<data.length)
			   {
				   area1.doms[i].dom[0].style.visibility="visible";
				   area1.doms[i].settext(1,data[i].TYPE_NAME);
				   area1.doms[i].settext(2,data[i].TYPE_INTRODUCE);
				   area1.doms[i].dom[3].src=data[i].TYPE_PICPATH;
				   area1.doms[i].mylink="news_focus_video.jsp?code="+data[i].TYPE_ID+"&type="+data[i].SUBJECT_TYPE +"&returnurl="+escape(location.href);
			   }
			   else
				area1.doms[i].dom[0].style.visibility="hidden";
				$("page").innerHTML=area1.curpage+"/"+count;
			}
		area1.lockin=false;
   }
</script>
</head>

<body>
<div class="main">
	<!--初始化加载图片-->
    <div style="visibility:hidden; z-index:-1">
    <!--首页左边导航暗焦点--> 
    <img src="images/menu_bgfocuson.png"/>
    <img src="images/menu_bgon.png"/>
    <img src="images/pic_bg11on.png"/>
    </div>
	<!--logo-->
	<div class="logo">新闻</div>
	<div class="date" id="currDate"></div>

	<!--menu-->
	<div class="menu2">
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_0">滚动新闻</div> <!--焦点为class="menuli on"-->
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_1">焦点新闻</div> <!--当前选中为class="menuli current"-->
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_2">新闻名栏</div>    
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_3">新闻排行</div>
		<div><img src="images/menu_line.png" /></div>
	</div>
	
		
	
	
	<!--film-->	
	<div class="dibb wid4"> 
		<div align="center"><img id="pageup" src="images/up.png" /></div>
		<div class="package_list2">
			<div class="bg" id="area1_list_0">
				<img width="200" height="148" id="area1_img_0" />
				<div class="f" id="area1_title_0"></div>
				<div class="f2" id="area1_detail_0"></div>
		    </div>
			<div class="bg" id="area1_list_1">
				<img width="200" height="148" id="area1_img_1" />
			  	<div class="f" id="area1_title_1"></div>
				<div class="f2" id="area1_detail_1"></div>
			</div>
			<div class="bg" id="area1_list_2">
				<img width="200" height="148" id="area1_img_2" />
				<div class="f" id="area1_title_2"></div>
				<div class="f2" id="area1_detail_2"></div>
			</div>
		</div>
		<div align="center"><img id="pagedown" src="images/down.png" /></div>
    </div>
	<div class="pages3" id="page"></div>
	
	
	
	
	 <!--bottom_notice-->
	<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>

</div>
<iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="0" height="0" ></iframe>
<%@ include file="servertimehelp.jsp" %>
</body>
</html>
