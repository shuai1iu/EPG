<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<html>
<head>
<%@ include file="save_focus.jsp"%>
<%@ include file="datajsp/channeldata.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>
<%
UserProfile userProfile = new UserProfile(request);
String userid = userProfile.getUserId();
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>频道_央视高清EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript" src="js/gstatj.js"></script>
<script type="text/javascript"> 
   var area1;
   var area2;
   var list=new Array();
   var reclist=new Array();
   var rectotallist;
   var reccount;
   var area0;
    window.onload=function()
   {
	   gstaFun('<%=userid%>',640);
	   var areaid=<%=request.getParameter("areaid")%>;
	   var indexid=<%=request.getParameter("indexid")%>;
	   area0=AreaCreator(10,1,new Array(-1,-1,-1,1),"area0_list_","className:menuli on","className:menuli");
	   area0.setstaystyle("className:menuli current",3);
	   area0.doms[0].mylink=indexhref[0];
	   area0.doms[1].mylink=indexhref[1];
	   area0.doms[2].mylink=indexhref[2];
	   //area0.doms[3].mylink="application.jsp?indexid=3";
	   area0.doms[3].mylink=indexhref[3];
	   area0.doms[4].mylink=indexhref[4];
	   area0.doms[5].mylink=indexhref[5];
	   area0.doms[6].mylink=indexhref[6];
	   area0.doms[7].mylink=indexhref[7];
	   area0.doms[8].mylink=indexhref[8];
	   area0.doms[9].mylink=indexhref[9];
	   area0.setfocuscircle(0);
	   area1=AreaCreator(11,1,new Array(-1,0,-1,2),"area1_list_","className:sub on","className:sub");
	   area1.setstaystyle("className:sub current",3);
	   for(i=0;i<area1.doms.length;i++)
	   {
		   area1.doms[i].contentdom  = $("area1_txt_"+i); 
	   }
	   area2=AreaCreator(10,1,new Array(-1,1,-1,-1),"area2_list_","className:p_li on2","className:p_li");
	   var area3=AreaCreator(1,2,new Array(-1,-1,1,-1),"area3_list_","className:on","className:");
	   area3.doms[0].mylink="package_intro.jsp?returnurl="+escape(window.location.href);
	   var area4=AreaCreator(1,1,new Array(0,0,-1,0),"area4_list_","className:on","className:");
	   area4.stablemoveindex=new Array(-1,-1,-1,"0-1");
	   var popup=new Popup('package',new Array(area3,area4),0,1);
	   popup.goBackEvent=function()
	   {
		   this.closeme();
	   }
	   //popup.closetime=3;
	   var backfocus;
	      if("1"=='<%=backflag%>')
		  backfocus=getCurFocus("channel");
	   pageobj=new PageObj(areaid!=undefined?parseInt(areaid):(backfocus!=null?backfocus[0].areaid:0),indexid!=undefined?parseInt(indexid):(backfocus!=null?backfocus[0].curindex:1),new Array(area0,area1,area2),new Array(popup));
	   area1.setpageturnattention("pageup","images/up.png","images/up_gray.png","pagedown","images/down.png","images/down_gray.png");
	   area2.setpageturnattention("pageup1","images/up.png","images/up_gray.png","pagedown1","images/down.png","images/down_gray.png");
	   if(areaid!=null&&areaid!=0)
	   area0.setdarknessfocus(1);
	   if(backfocus!=null)
	   {
	       pageobj.areas[backfocus[0].areaid].curpage=backfocus[0].curpage;
	       pageobj.areas[backfocus[0].areaid].curindex=backfocus[0].curindex;
		   setDarkFocus("channel");
	   }
	   pageobj.goBackEvent=function()
	   {
		   location.href="index.jsp";
		   //this.changefocus(0,1);
	   }
	   area1.asyngetdata=function()
		 {
			 list=new Array();
			 var start = (this.curpage-1)*11;
			 var size = (totallist.length-start)>=11?11:(totallist.length-start);
			 for(i=0;i<size;i++)
	         {
	            list[i]=totallist[start+i];
	         }
             getdata1(list,pagecount);
		 }
		
	   area1.setcrossturnpage();
	   area1.setfocuscircle(0);
	   area1.dataarea=area2;
	   area1.delay=true;
	   area1.changefocusingEvent=function()
	   {
		      area2.curpage=1;
	   }
	   area1.areaOkEvent=function()
	   {
          var json=createFocstr(pageobj);
          saveCookie("channel",json!=undefined?json:""); 
		  var channelNumber = area1.doms[area1.curindex].channelnum;
			var channelAuthorID = area1.doms[area1.curindex].dataurlorparam;
			window.location.href="au_PlayFilm.jsp?PROGID=" + channelAuthorID + "&PLAYTYPE=2&CONTENTTYPE=3&&BUSINESSTYPE=2&ALLOWAD=1&CHANNELNUM="+channelNumber+"&COMEFROMFLAG=1&returnurl="+escape(location.href);
		//window.location.href="play_ControlChannel.jsp?CHANNELNUM="+area1.doms[area1.curindex].dataurlorparam+"&returnurl="+escape(location.href);
	         //window.location.href="play_ControlChannel.jsp?CHANNELNUM="+area1.doms[area1.curindex].channelnum+"&COMEFROMFLAG=1&returnurl="+escape(location.href);
			//window.location.href="au_ReviewOrSubscribe.jsp?PROGID=" + area1.doms[area1.curindex].dataurlorparam 
								//+ "&PLAYTYPE=8&CONTENTTYPE=3&BUSINESSTYPE=2"
								//+ "&CHANNELNUM=" + area1.doms[area1.curindex].dataurlorparam + "&PREVIEWFLAG=1&ISSUB=1&COMEFROMFLAG=2&CHANTYPE="+&returnurl="+escape(location.href);
		     //pageobj.popups[0].showme();   
	   }
	   area2.setfocuscircle(0);
	   area2.areaOkEvent=function()
	   {
		   if(area2.curpage==1&&area2.curindex==0)
		   {
			   var json=createFocstr(pageobj);
               saveCookie("channel",json!=undefined?json:"");   
			   var channelNumber2 = area1.doms[area1.curindex].channelnum;
			   var channelAuthorID2 = area1.doms[area1.curindex].dataurlorparam;
			   window.location.href="au_PlayFilm.jsp?PROGID=" + channelAuthorID2 + "&PLAYTYPE=2&CONTENTTYPE=3&&BUSINESSTYPE=2&ALLOWAD=1&CHANNELNUM="+channelNumber2+"&COMEFROMFLAG=1&returnurl="+escape(location.href);
		       //window.location.href="play_ControlAction.jsp?CHANNELNUM="+area1.doms[area1.curindex].channelnum+"&COMEFROMFLAG=1&returnurl="+escape(location.href);
			   //window.location.href="play_ControlChannel.jsp?CHANNELNUM="+area1.doms[area1.curindex].channelnum+"&COMEFROMFLAG=1&returnurl="+escape(location.href);
			   //window.location.href="au_PlayFilm.jsp?PROGID=" + channelAuthorID2 + "&PLAYTYPE=2&CONTENTTYPE=3&&BUSINESSTYPE=2&ALLOWAD=1&CHANNELNUM="+channelNumber+"&COMEFROMFLAG=1&returnurl="+escape(location.href);
		  
		   }
	   }
	   area2.asyngetdata=function(dataurl)
		 {

			     //移动更换数据
			   if(!!dataurl)
			   {
				   //alert("datajsp/channelasyndata1.jsp?channelid="+dataurl);
				   getAJAXData("datajsp/channelasyndata1.jsp?channelid="+area1.doms[area1.curindex].dataurlorparam,getdata);
				   //$('hidden_frame').src="datajsp/channelasyndata1.jsp?channelid="+dataurl;
			   }
			   else
			   {
			     //翻页
			     reclist=new Array();
			     var start = (this.curpage-1)*10;
			     var size = (rectotallist.length-start)>=10?10:(rectotallist.length-start);

			     for(i=0;i<size;i++)
	             {
	               reclist[i]=rectotallist[start+i];
	             }
                 getdata2(reclist,reccount);
			   }
		 }
	   area2.setcrossturnpage();
	         var start = (parseInt(<%=curpage%>)-1)*11;
			 var size = (totallist.length-start)>=11?11:(totallist.length-start);
			 for(i=0;i<size;i++)
	         {
	            list[i]=totallist[start+i];
	         }
       getdata1(list,pagecount);
       //for(i=0;i<(rectotallist.length>=11?11:rectotallist.length);i++)
	   ///{
	   //   reclist[i]=rectotallist[i];
	   //}
       //getdata2(reclist,reccount);
       
   }

   function getdata1(data,count)
   {
	   area1.setpageturndata(data.length,parseInt(count));
		for(i=0;i<area1.doms.length;i++)
			{
				if(i<data.length)
			   {
				   var tmpSeq = "" + (data[i].UserChannelID-1000);
            	   var tmpStr = "";
           		   if (tmpSeq.length == 1)
                		tmpStr = "00";
            	   if (tmpSeq.length == 2)
                		tmpStr = "0";
				   area1.doms[i].updatecontent(tmpStr +(data[i].UserChannelID-1000)+"  " +data[i].ChannelName);
				   //area1.doms[i].updatecontent(data[i].ChannelName);
			       //area1.doms[i].mylink="index.jsp?channelid=data[i].ChannelID";
			       area1.doms[i].dataurlorparam=data[i].ChannelID;
				   area1.doms[i].channelnum=data[i].UserChannelID-1000;
			   }
			   else
				area1.doms[i].updatecontent("");
			}
	    //area1.dataarea.asyngetdata(area1.doms[area1.curindex].dataurlorparam);
		area2.asyngetdata(data[0].ChannelID);
   }
   function getdata(result)
   {   
       var re=eval('('+result+')');
	   var data=re.data;
	   var count=re.count;
       rectotallist=new Array();
       rectotallist=data;
	   //把第一条数据变成白色
	   rectotallist[0].STATUS=1;
       reccount=parseInt((count-1)/10)+1;
       reclist=new Array();
       for(i=0;i<(rectotallist.length>=10?10:rectotallist.length);i++)
	   {
	      reclist[i]=rectotallist[i];
	   }
       getdata2(reclist,reccount);
   }
   function getdata2(data,count)
   {
	   area2.setpageturndata(data.length,parseInt(count));
		    for(i=0;i<area2.doms.length;i++)
			{
				if(i<data.length)
			   {
				   var time=data[i].starttime.substring(0,5);
				   area2.doms[i].setcontent("",time+" "+data[i].proname,26);
				   //if(parseInt(data[i].STATUS)==1)
				   if(parseInt(data[i].STATUS)==1)
				   {
					   if(pageobj.curareaid==2&&area2.curindex==i)
						   area2.doms[i].changestyle(new Array("className:p_li on2"));
					   else
					       area2.doms[i].changestyle(new Array("className:p_li"));
					   area2.doms[i].focusstyle[0]="className:p_li on2";
				       area2.doms[i].unfocusstyle[0]="className:p_li";
				   }
				   else
				   {
					   if(pageobj.curareaid==2&&area2.curindex==i)
						   area2.doms[i].changestyle(new Array("className:p_li fgray on2"));
					   else
					       area2.doms[i].changestyle(new Array("className:p_li fgray"));
				       area2.doms[i].focusstyle[0]="className:p_li fgray on2";
				       area2.doms[i].unfocusstyle[0]="className:p_li fgray";
				   }
			   }
			   else
				  area2.doms[i].updatecontent("");
			}
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
    <img src="images/list_bg3on.png"/>
    <img src="images/channel_subon.png"/>
    <img src="images/list_bg2on.png"/>
    <img src="images/sub_bgon.png"/>
    </div>
	<!--logo-->
	<div class="logo"><img src="images/logo.png" /></div>
	<div class="date" id="currDate"></div>
	
	
	
	<!--menu-->
	<div class="menu"> <!--焦点为 class="menuli on"  当前选中为 class="menuli current"-->
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_0" style="top:1px"><img src="images/icon_0.png" />首  页</div> <!--class="menuli on"-->
		<div style="top:55px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_1" style="top:56px"><img src="images/icon_1.png" />频  道</div>
		<div style="top:110px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_2" style="top:111px"><img src="images/icon_2.png" />点  播</div>
		<div style="top:165px"><img src="images/menu_line.png" /></div>
        <div class="menuli" id="area0_list_3" style="top:166px"><img src="images/icon_3.png" />专  题</div>
		<div style="top:220px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_4" style="top:221px"><img src="images/icon_4.png" />回  放</div>
		<div style="top:275px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_5" style="top:276px"><img src="images/icon_5.png" />深  圳</div>
		<div style="top:330px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_6" style="top:331px"><img src="images/icon_11new.png" />排  行</div> <!--20130909 hxt 增加排行入口-->
		<div style="top:385px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_7" style="top:386px"><img src="images/icon_7.png" />应  用</div> <!--20130909 hxt 将应用入口下移-->
		<div style="top:440px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_8" style="top:441px"><img src="images/icon_9.png" />空  间</div>
		<div style="top:499px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_9" style="top:500px"><img src="images/icon_10.png" />搜  索</div>
		<div style="top:555px"><img src="images/menu_line.png" /></div>
	</div>
	
	
	
	<!--mid-->	
	<div class="channel_sub"> 
		<div align="center"><img id="pageup" /></div>
		<div class="sub" id="area1_list_0"><div id="area1_txt_0" style='padding-left:10px;'></div></div><!--class="on"-->
		<div class="sub" id="area1_list_1"><div id="area1_txt_1" style='padding-left:10px;'></div></div>
		<div class="sub" id="area1_list_2"><div id="area1_txt_2" style='padding-left:10px;'></div></div>
		<div class="sub" id="area1_list_3"><div id="area1_txt_3" style='padding-left:10px;'></div></div>
		<div class="sub" id="area1_list_4"><div id="area1_txt_4" style='padding-left:10px;'></div></div>
		<div class="sub" id="area1_list_5"><div id="area1_txt_5" style='padding-left:10px;'></div></div>
		<div class="sub" id="area1_list_6"><div id="area1_txt_6" style='padding-left:10px;'></div></div>
		<div class="sub" id="area1_list_7"><div id="area1_txt_7" style='padding-left:10px;'></div></div>
		<div class="sub" id="area1_list_8"><div id="area1_txt_8" style='padding-left:10px;'></div></div>
		<div class="sub" id="area1_list_9"><div id="area1_txt_9" style='padding-left:10px;'></div></div>
		<div class="sub" id="area1_list_10"><div id="area1_txt_10" style='padding-left:10px;'></div></div>
		<div align="center"><img id="pagedown" /></div>
	</div>

	
	
	<!--r-->
	<div class="channel_list">
		<div>节目列表</div>
		<div class="pad"><img src="images/line2.png" /></div>
		<div class="p_li" id="area2_list_0" style="width:460px"></div>
		<div class="p_li" id="area2_list_1" style="width:460px"></div>
		<div class="p_li" id="area2_list_2" style="width:460px"></div>
		<div class="p_li" id="area2_list_3" style="width:460px"></div>
		<div class="p_li" id="area2_list_4" style="width:460px"></div>
		<div class="p_li" id="area2_list_5" style="width:460px"></div>
		<div class="p_li" id="area2_list_6" style="width:460px"></div>
		<div class="p_li" id="area2_list_7" style="width:460px"></div>
		<div class="p_li" id="area2_list_8" style="width:460px"></div>
		<div class="p_li" id="area2_list_9" style="width:460px"></div>
  </div>
  <div class="channel_up"><img id="pageup1" /></div>
  <div class="channel_down"><img id="pagedown1" /></div>
  
  
	
	
	<!--bottom_notice-->
	<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>
    
    <!--popup-->
	<div class="popup" id="package" style="display:none">
      <div class="pop_fee">对不起，本频道属于收费频道。</div>	
            <div class="pop_price" style="top:105px">价格：2.00元</div>	
            <div class="pop_price" style="top:150px">您可以单独购买本频道，或购买相应套餐</div>	
            <div class="pop_btns">	
			<div id="area3_list_0">购买</div>
			<div>&nbsp;</div>
			<div id="area3_list_1">返回</div>
 	 		</div>
         <div class="pop_btns po1">
                <div id="area4_list_0">了解套餐</div>
         </div>
	</div>
	<!--popup the end-->
    
    
    
</div>
<iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="0" height="0" ></iframe>
<%@ include file="servertimehelp.jsp" %>
</body>

</html>
