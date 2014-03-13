<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="servertimehelp.jsp" %>
<%@ include file="datajsp/news_column_namedata.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<script type="text/javascript" src="js/pagecontrol.js"></script>

<script type="text/javascript"> 
   var area1;
   var returnurl = '<%=request.getParameter("returnurl")!=null?request.getParameter("returnurl"):"index.jsp"%>';
   window.onload=function()
   {
	   var areaid=<%=request.getParameter("areaid")%>;
	   var indexid=<%=request.getParameter("indexid")%>;
	   var area0=AreaCreator(4,1,new Array(-1,-1,-1,1),"area0_list_","className:menuli on","className:menuli");
	    area0.doms[0].mylink="news_rolling.jsp?returnurl="+escape(returnurl);
		area0.doms[1].mylink="news_focus.jsp?returnurl="+escape(returnurl);
		//area0.doms[2].mylink="news_column_name.jsp?returnurl="+returnurl;
		area0.doms[3].mylink="news_ranking.jsp?returnurl="+escape(returnurl);
	   area0.setstaystyle("className:menuli current",3);
	   area1=AreaCreator(2,3,new Array(-1,0,-1,-1),"area1_list_","className:bgon","className:bg");
	   
	   pageobj=new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):2,new Array(area0,area1));
	   area1.setpageturnattention("pageup","images/up.png","images/up_gray.png","pagedown","images/down.png","images/down_gray.png");
	   if(areaid!=null&&areaid!=0)
	   area0.setdarknessfocus(2);
	   pageobj.backurl=unescape(returnurl);
	   area1.setcrossturnpage();
	   area1.asyngetdata=function()
	   {
			 this.lockin=true;
			 $('hidden_frame').src="datajsp/news_column_nameasyndata.jsp?curpage="+this.curpage;
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
				   $("area1_area_"+i).style.visibility="visible";
				    area1.doms[i].contentdom=$("area1_title_"+i);
				    area1.doms[i].imgdom=$("area1_img_"+i);
	  			    area1.doms[i].setcontent("",data[i].TYPE_NAME,12);
 				    area1.doms[i].updateimg(data[i].TYPE_PICPATH);
                    area1.doms[i].mylink="news_today_focus.jsp?typeid="+data[i].TYPE_ID+"&returnurl="+escape(window.location.href);
			   }
			   else
				$("area1_area_"+i).style.visibility="hidden";
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
	<div class="dibb wid6"> 
		<div align="center"><img id="pageup" src="images/up.png" /></div>
		<div class="news_list">
			<div class="kind" id="area1_area_0">
				<div class="bg" id="area1_list_0"><img id="area1_img_0" width="259" height="194" /></div>
				<div class="f" id="area1_title_0"></div>
			</div>
			<div class="kind" id="area1_area_1">
				<div class="bg" id="area1_list_1"><img id="area1_img_1" width="259" height="194" /></div>
				<div class="f" id="area1_title_1"></div>
			</div>
			<div class="kind" id="area1_area_2">
				<div class="bg" id="area1_list_2"><img id="area1_img_2"  width="259" height="194" /></div>
				<div class="f" id="area1_title_2"></div>
			</div>
			<div class="kind" id="area1_area_3">
				<div class="bg" id="area1_list_3"><img id="area1_img_3"  width="259" height="194" /></div>
				<div class="f" id="area1_title_3"></div>
			</div>
			<div class="kind" id="area1_area_4">
				<div class="bg" id="area1_list_4"><img  id="area1_img_4" width="259" height="194" /></div>
				<div class="f" id="area1_title_4"></div>
			</div>
			<div class="kind" id="area1_area_5">
				<div class="bg" id="area1_list_5"><img id="area1_img_5" width="259" height="194" /></div>
				<div class="f" id="area1_title_5"></div>
			</div>
		</div>
		<div align="center"><img  id="pagedown"  src="images/down.png" /></div>
    </div>
	<div class="pages2" id="page">1/2</div>
	 <!--bottom_notice-->
	<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>
</div>
<iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="0" height="0" ></iframe>
</body>
</html>

