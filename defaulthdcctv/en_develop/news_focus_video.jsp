<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file="datajsp/news_focus_videodata.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>焦点新闻视频_央视高清EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript" src="js/EPGConstants.js"></script>
<script type="text/javascript"> 
   var area1;
   var returnurl = '<%=request.getParameter("returnurl")!=null?request.getParameter("returnurl"):"index.jsp"%>';
    window.onload=function()
   {
	   var areaid=<%=request.getParameter("areaid")%>;
	   var indexid=<%=request.getParameter("indexid")%>;
	   var area0=AreaCreator(1,1,new Array(-1,-1,-1,1),"area","className:bgon","className:bg");
	   area1=AreaCreator(10,1,new Array(-1,0,-1,-1),"area1_list_","className:p_li on","className:p_li");
	   
	   area1.setpageturnattention("pageup","images/up.png","images/up_gray.png","pagedown","images/down.png","images/down_gray.png");
	   
	   //getdata(list);
	   area1.setcrossturnpage();
	   area1.asyngetdata=function()
	   {
			 this.lockin=true;
			 $('hidden_frame').src="datajsp/news_focus_videoasyndata.jsp?curpage="+this.curpage;
		}
	   area1.changefocusedEvent=function()
	   {
		    $("new_img").src=this.doms[this.curindex].youwanauseobj;   
	   }
	   getdata(list,pagecount);
	   pageobj=new PageObj(areaid!=null?parseInt(areaid):1,indexid!=null?parseInt(indexid):0,new Array(area0,area1));
	   pageobj.backurl=unescape(returnurl);
       
   }

   function getdata(data,count)
   {
	   area1.setpageturndata(data.length,parseInt(count));
		for(i=0;i<area1.doms.length;i++)
			{
				if(i<data.length)
			   {
			       if(type==1||type==9999)
			       {
				       area1.doms[i].setcontent((i+1)+'.',data[i].VODNAME,30);
				       area1.doms[i].youwanauseobj=data[i].PICPATH;
					   area1.doms[i].mylink = "au_PlayFilm.jsp?PROGID="+data[i].VODID+"&PLAYTYPE="+EPGConstants.PLAY_TYPE_VOD+"&CONTENTTYPE="+EPGConstants.CONTENT_TYPE_VOD+"&BUSINESSTYPE="+EPGConstants.BUSINESS_TYPE_VOD+"&returnurl="+escape(location.href);
				   }
				   else if(type==3)
				   {
				       area1.doms[i].setcontent((i+1)+'.',data[i].CHANNELNAME,30);
				       area1.doms[i].youwanauseobj=data[i].PICS_PATH;
				   }
			   }
			   else
				area1.doms[i].updatecontent("");
				$("page").innerHTML=area1.curpage+"/"+count;
			}
		area1.lockin=false;
   }
</script>
</head>

<body>
<div class="main">
	<div style="visibility:hidden; z-index:-1">
    <!--首页左边导航暗焦点--> 
    <img src="images/list_bg2on.png"/>
    <img src="images/pic_bg14on.png"/>
    </div>
	<!--logo-->
	<div class="logo">焦点新闻</div>
	<div class="date" id="currDate"></div>
	
	<!--left_newspic-->
	<div class="newsbigpic">
		<div class="bg" id="area0"><img id="new_img" /></div>
  	</div>
	

	
	<!--r-->
	<div class="channel_list wid2" style=" left:555px;">
		<div class="title2">相关视频列表</div>
		<div class="padtb"><img src="images/line4.png" width="630" /></div>
		<div class="p_li" id="area1_list_0">1.政府军多处防空设施被袭数辆装甲车摧毁</div>
		<div class="p_li" id="area1_list_1">2.反对派占领艾季达比耶</div>
		<div class="p_li" id="area1_list_2">3.道德观察：观察世间百态</div>
		<div class="p_li" id="area1_list_3">4.政府军多处防空设施被袭数辆装甲车摧毁</div>
		<div class="p_li" id="area1_list_4">5.法律讲堂：专家主题讲座</div>
		<div class="p_li" id="area1_list_5">6.政府军多处防空设施被袭数辆装甲车</div>
		<div class="p_li" id="area1_list_6">7.反对派占领艾季达比耶</div>
		<div class="p_li" id="area1_list_7">8.心理访谈：关注心理健康</div>
		<div class="p_li" id="area1_list_8">9.英法军事干预升级首都遭“最猛烈”空袭</div>
		<div class="p_li" id="area1_list_9">10.法律讲堂：专家主题讲座</div>
  </div>
  <div class="pages4" id="page">1/10</div>
  <div class="channel_up"><img id="pageup" src="images/up.png" /></div>
  <div class="channel_down"><img id="pagedown" src="images/down.png" /></div>
	
	
	
	
 <!--bottom_notice-->
	<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>

</div>
<iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="0" height="0" ></iframe>
<%@ include file="servertimehelp.jsp" %>
</body>
</html>
