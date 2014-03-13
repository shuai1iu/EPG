<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="config/config_TrailerInVas.jsp"%>
<%@ include file="OneKeyPlay.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="save_focus.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<%@ include file="datajsp/indexdata.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页_央视高清EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<style>
<%
//ZTE
//body{ background:url(images/mainbg_index.png) no-repeat}
 %>

<!--
body{ background1:url(images/mainbg_index.png) no-repeat}
.geton{z-index:3}
.getoff{z-index:1}
-->
</style>
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript">
   //var numkey=true;var bluekey=true;var redkey=true;var greenkey=true;var yellowkey=true;
   var returnurl=escape(window.location.href);
   var area2;
   var area3;
    var progId="<%=CATEGORY_TRAILER_ID%>";
    window.onload=function()
   {
	   var areaid=<%=request.getParameter("areaid")%>;
	   var indexid=<%=request.getParameter("indexid")%>;
	   var backflag='<%=request.getParameter("back")%>';
	   var area0=AreaCreator(10,1,new Array(-1,-1,-1,1),"area0_list_","className:menuli on","className:menuli");
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
	   area0.stablemoveindex = new Array(-1,-1,-1,"8-2>0,9-2>0");
	   
	   var area1=AreaCreator(1,1,new Array(-1,0,2,3),"area1_list_","className:mid_adon","className:mid_ad");

	   //area1.doms[0].mylink="play_ControlChannel.jsp?CHANNELNUM=<%=shouyezhibo%>&COMEFROMFLAG=1&returnurl="+escape(location.href);//"<%=CATEGORY_fullScreenPlayUrl%>";
	   area1.doms[0].mylink = "ayh2012hd/en/page/index.jsp?returnurl="+escape(location.href);
	
	   area2=AreaCreator(3,4,new Array(1,0,-1,3),"area2_list_","className:on","className:");
	   area2.stablemoveindex=new Array(-1,-1,-1,"3-3,7-3,11-3");
	   area3=AreaCreator(4,1,new Array(-1,1,-1,-1),new Array("area3_list_","area3_list1_"),new Array("className:on","className:geton"),new Array("className:","className:"));
	   area3.stablemoveindex=new Array(-1,"3-2>3",-1,-1);
	   //添加推荐海报循环2011.3.13
	   area3.setfocuscircle(0);
	   for(i=0;i<4;i++)
	      area3.doms[i].imgdom=$("area3_img_"+i);
	   //开机定位深圳
	   var start=getCookie("isstart");
	   //随时定位深圳
	   var backfocus;
	      if("1"==backflag)
		    backfocus=getCurFocus("index");
	   pageobj=new PageObj(areaid!=null?parseInt(areaid):(backfocus!=null?backfocus[0].areaid:0),indexid!=null?parseInt(indexid):(backfocus!=null?backfocus[0].curindex:(start==undefined?5:0)),new Array(area0,area1,area2,area3));
	   saveCookie("isstart","yes"); 
	   if(backfocus!=null)
	   {
	       pageobj.areas[backfocus[0].areaid].curpage=backfocus[0].curpage;
	       pageobj.areas[backfocus[0].areaid].curindex=backfocus[0].curindex;
		   setDarkFocus("index");
	   }
	   pageobj.pageOkEvent=function()
	   {
		  var json=createFocstr(pageobj);
          saveCookie("index",json!=undefined?json:"");    
	   }
	   pageobj.pageVolChangeEvent=function(num)
	   {
		   if(num==-1)
		         volumeDown();
		   else if(num==1)
		         volumeUp();
	   }
	   pageobj.pageSetMuteFlagEvent=setMuteFlag;
	   if(areaid!=null&&areaid!=0)
	   area0.setdarknessfocus(0);
	   pageobj.goBackEvent=function()
	   {
		   this.changefocus(0,0);
	   }
	   getdata(list);
	   getdata1(list1);
	   //load_iframe();
	   setTimeout(load_iframe,200);
	   
   }
   
   function getdata(data)
   {
	   area2.datanum=(data.length==undefined?0:data.length);
		for(i=0;i<area2.doms.length;i++)
			{
				if(i<data.length)
			   {
				  
				   //area2.doms[i].setcontent("",data[i].PROGRAMNAME,8,true,true);
				   //0:视频VOD、1:视频频道、2:音频频道、3:频道、4:音频AOD、10:VOD、100:增值业务、300:节目、9999:混合栏目
				   //if(data[i].PROGRAMTYPE==0||data[i].PROGRAMTYPE==4)
			       //   area2.doms[i].mylink="vod_turnpager.jsp?vodid="+data[i].PROGRAMID+"&returnurl="+returnurl;
				   //else if(data[i].PROGRAMTYPE==1||data[i].PROGRAMTYPE==2)
				   //   area2.doms[i].mylink="vod_turnpager.jsp?vodid="+data[i].PROGRAMID+"&returnurl="+returnurl;
				   //else if(data[i].PROGRAMTYPE==100)
				   //   area2.doms[i].mylink="vas.jsp";
				   
				   area2.doms[i].setcontent("",data[i].VASNAME,8,true,true);
				   area2.doms[i].youwannauseobj=data[i].VASID;
				   area2.doms[i].domOkEvent=function()
				   {
					   
					   $('hidden_frame').src="datajsp/indexdetaildata.jsp?vasid="+this.youwannauseobj;
				   }
				   
			   }
			   else
				area2.doms[i].updatecontent("");
			}
		//area2.doms[2].updatecontent("娱乐测试");
		//area2.doms[2].mylink = "dibbling_recreation.jsp&returnurl="+escape(location.href);
		//area2.doms[3].updatecontent("新闻测试");
		//area2.doms[3].mylink = "news_rolling.jsp?typeid=00000100000000090000000000001064&returnurl="+escape(location.href);		
   }
   function getdata1(data)
   {   
	   area3.datanum=data.length;
		for(i=0;i<area3.doms.length;i++)
			{
				if(i<data.length)
			   {
								   area3.doms[i].updateimg(data[i].POSTERPATHS.type0[0]!=undefined?data[i].POSTERPATHS.type0[0]:(data[i].PICPATH!=undefined?data[i].PICPATH:'images/no_picture_259x165.jpg'));
				   //0:视频VOD、1:视频频道、2:音频频道、3:频道、4:音频AOD、10:VOD、100:增值业务、300:节目、9999:混合栏目
			       area3.doms[i].mylink="vod_turnpager.jsp?vodid="+data[i].VODID+"&typeid=<%=shouyetuijian2code%>"+"&returnurl="+returnurl;
			   }
			   else
				   area3.doms[i].updateimg("#");
			    
			}
		
   }
   
   //视频窗口
   function load_iframe()
	{
		progId="";//mxr
		if (progId != "" && progId != "null" && progId != null)
		{			
			playPage.location.href = "PlayTrailerInVas.jsp?left=150&top=200&width=508&height=385&type="+"<%=CATEGORY_TRAILER_TYPE%>"+"&value=" + "<%=CATEGORY_TRAILER_ID%>" +"&mediacode="+ "<%=CATEGORY_TRAILER_ID%>" +"&contenttype="+ "<%=CATEGORY_TRAILER_CONTENTTYPE%>";
		}
		else 
		{
			//alert("picpath======"+picpath);
//ZTE			
document.getElementById("mid_play").src  =  ( picpath!=null&&picpath!=""&&picpath!="absolute")?picpath:"images/temp/ozb2012.jpg";
//document.body.style.background = "url(images/mainbg_index.jpg) no-repeat";document.getElementById("mid_play").src  =  ( picpath!=null&&picpath!=""&&picpath!="absolute") ? picpath:"images/temp/ozb2012.jpg";

		    //document.getElementById("mid_play").src = "images/temp/ozb2012.jpg";
		}
	}
	function goURL(url)
	{
	   document.location.href='../'+url;	
	}
var volumeDivIsShow = false;
var volume = 20;
	function volumeUp()
{
	hideVoice();
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1)
	{
		mp.setMuteFlag(0);
	}
	volume = mp.getVolume(); 
	volume += 5;
	if(volume >= 100)
	{
		volume = 100;             
	}
	mp.setVolume(volume);  
	if (mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
	{
		clearTimeout(bottomTimer);
		bottomTimer = "";
		genVolumeTable(volume);
		bottomTimer = setTimeout("hideBottom();", 5000);
	}
}
function volumeDown()
{	
    hideVoice();
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1)
	{
		mp.setMuteFlag(0);
	}
	volume = mp.getVolume();
	volume -= 5;	
	if(volume <= 0)
	{
		volume = 0;    
	}
	mp.setVolume(volume);  
	if (mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
	{
		clearTimeout(bottomTimer);
		bottomTimer = "";
		genVolumeTable(volume);
		bottomTimer = setTimeout("hideBottom();", 5000);
	}
}
function hideBottom()
{
	volumeDivIsShow = false;
	document.getElementById("bottomframe").innerHTML = "";
}
function hideVoice()
{
	document.getElementById("voice").src="images/dot.gif";
}
function genVolumeTable(volume)
{
	var tableDef = '<table width="980px" border="0" cellpadding="0" cellspacing="0"><tr>';
	volume = parseInt(volume / 5);
	for (i = 0; i < 40; i++)
	{
		if (i % 2 == 0)
		{
			tableDef += '<td width="20px" height="54px" bgcolor="transparent"></td>';
		}
		else
		{
			if ( i / 2 < volume)
			{
				tableDef += '<td width="20px" height="54px" bgcolor="#00ff00"></td>';
			}
			else
			{
				tableDef += '<td width="20px" height="54px" bgcolor="cccccc"></td>';
			}
		}
	}
	tableDef += '<td width="20px"></td><td width="40px"><img src="images/playcontrol/playChannel/volume.gif"></td><td width="40px" style="color:white;font-size:28">' + volume + '</td>';
	tableDef += '</tr></table>'; 
	document.getElementById("bottomframe").innerHTML = tableDef;    	
}
function setMuteFlag()
{
	hideBottom();
	clearTimeout(voiceTimer);
	bottomTimer = ""; 
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1)
	{
		mp.setMuteFlag(0);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
		{
			//document.getElementById("bottomframe").innerHTML = '<table><tr><td><img src="images/playcontrol/playChannel/muteoff.png"></td></tr></table>';
			document.getElementById("voice").src="images/playcontrol/playChannel/muteoff.png";
			voiceTimer = setTimeout(hideVoice, 5000);
		}
	}
	else
	{
		mp.setMuteFlag(1);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
		{
			//document.getElementById("bottomframe").innerHTML = '<table><tr><td><img src="images/playcontrol/playChannel/muteon.png"></td></tr></table>';
			document.getElementById("voice").src="images/playcontrol/playChannel/muteon.png";
			//voiceTimer = setTimeout("hideVoice();", 5000);
		}
	}      
}
</script>
</head>

<body style="background:url(images/mainbg_index.png); background-color:transparent;">
<div class="main">
	<!--初始化加载图片-->
    <div style="visibility:hidden; z-index:-1">
    <!--首页左边导航暗焦点--> 
    <img src="images/menu_bgfocuson.png"/>
    <img src="images/menu_bgon.png"/>
    <!--首页视频大图-->
    <img src="images/pic_bg1on.png"/>
    <!--节目-->
    <img src="images/nav_bgon.png"/>
    <!--右侧-->
    <img src="images/pic_bg2.png"/>
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
		<div class="menuli" id="area0_list_6" style="top:331px"><img src="images/icon_7.png" />应  用</div>
		<div style="top:385px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_7" style="top:386px"><img src="images/icon_8.png" />套  餐</div>
		<div style="top:440px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_8" style="top:441px"><img src="images/icon_9.png" />空  间</div>
		<div style="top:499px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_9" style="top:500px"><img src="images/icon_10.png" />搜  索</div>
		<div style="top:555px"><img src="images/menu_line.png" /></div>
	</div>
	
	
	
	
	<!--mid-->
	<div class="mid_ad" id="area1_list_0"><img src="#" id="mid_play" width="508" height="385" /></div> <!--mid_ad/mid_adon-->
	
	<div class="mid_nav"> <!--class="on"-->
		<div id="area2_list_0"></div>
		<div id="area2_list_1" style="left:134px"></div>
		<div id="area2_list_2" style="left:268px"></div>
		<div id="area2_list_3" style="left:402px"></div>
		<div id="area2_list_4" style="top:39px"></div>
		<div id="area2_list_5" style="top:39px;left:134px"></div>
		<div id="area2_list_6" style="top:39px;left:268px"></div>
		<div id="area2_list_7" style="top:39px;left:402px"></div>
		<div id="area2_list_8" style="top:78px"></div>
		<div id="area2_list_9" style="top:78px;left:134px"></div>
		<div id="area2_list_10" style="top:78px;left:268px"></div>
		<div id="area2_list_11" style="top:78px;left:402px"></div>
	</div>
	<div class="nav_line"><img src="images/line.png" /></div>
	
	
	
	<!--r-->
	<div class="r_ad">
		<div style="top:0" id="area3_list1_0"><img id="area3_img_0"  width="305" height="137"/></div>
        <div id="area3_list_0" style="top:-1px"></div>
        <div style="top:139px;" id="area3_list1_1"><img id="area3_img_1" width="305" height="137"/></div>
		<div id="area3_list_1" style="top:138px"></div>
        <div style="top:278px;" id="area3_list1_2"><img id="area3_img_2" width="305" height="137" /></div>
		<div id="area3_list_2" style="top:277px;"></div>
        <div style="top:417px;" id="area3_list1_3"><img id="area3_img_3" width="305" height="137" /></div>
		<div id="area3_list_3" style="top:416px"></div>
	</div>
	<!--bottom_notice-->
	<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>
    
</div>
<div id="bottomframe" style="position:absolute;left:60px; top:530px; width:1200px; height:190px; z-index:1"></div>
<div style="position:absolute; left:816px; top:105px; width:54px; height:66px; z-index:3;"><img id="voice" src="images/dot.gif"/></div>
<iframe name="hidden_frame_time" id="hidden_frame_time" style=" display:none" width="1px" height="1px" ></iframe>
<!-- 视频窗口 -->
<iframe id="playPage" name="playPage" frameborder="0" height="1pxpx" width="1pxpx"></iframe>
<iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="1px" height="1px" ></iframe>
<%@ include file="servertimehelp.jsp" %>
</body>
</html>
