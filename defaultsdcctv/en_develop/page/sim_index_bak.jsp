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
<%@ include file="util/util_AdText.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<%@ include file="save_focus.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<%@ include file="datajsp/sim_indexdata.jsp"%>
<%@ include file="util/util_getPosterPaths.jsp"%>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<meta name="page-view-size" content="640*530"/>
<title>CCTV-IP电视</title>
<link rel="stylesheet" type="text/css" href="../css/style.css" />
<style type="text/css">
    body {
        background:  url("../images/body-page-index.gif") no-repeat;
    }
</style>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
	if (typeof(iPanel) != 'undefined'){iPanel.focusWidth = "2";iPanel.defaultFocusColor = "#FCFF05";}
    var area0,area1,area2,area3,area4,area5,area6,area7,area8;
	var returnurl=unescape(window.location.href);
	var progId="<%=CATEGORY_TRAILER_ID%>";
    window.onload=function()
   {   
		Authentication.CTCSetConfig("key_ctrl_ex", "0");
		if(returnurl.indexOf('back=1')==-1)
		{
		    if(returnurl.indexOf('?')==-1)
			   returnurl+="?back=1";
			else
			   returnurl+="&back=1";
		}
	   returnurl=escape(returnurl);
	   var backflag='<%=request.getParameter("back")%>';
	   area0=AreaCreator(1,6,new Array(4,-1,8,-1),"area0_list_","afocus","ablur");
	   area0.setfocuscircle(1);
	   area0.stablemoveindex=new Array("2-7>0,3-7>1,4-7>2,5-7>2",-1,"1-5>0,2-5>0,3-5>0,4-6>0,5-6>0",-1);
	   area0.doms[0].mylink="live.jsp?returnurl="+returnurl;
	   area0.doms[1].mylink="vod.jsp?returnurl="+returnurl;
	   area0.doms[2].mylink="playback.jsp?returnurl="+returnurl;
	   //area0.doms[3].mylink="#";
	   area0.doms[3].mylink="../../../defaultgdsd/en/page/index.jsp?returnurl="+returnurl;
	   //area0.doms[4].mylink="app.jsp?returnurl="+returnurl;
 //              area0.doms[4].mylink="2013nh/page/nhindex1.jsp?returnurl="+returnurl;
	   area0.doms[4].mylink="../../../defaultgdsd/en/page/app.jsp?returnurl="+returnurl;
	   area0.doms[5].mylink="topiclist.jsp?returnurl="+returnurl;
	  // area0.doms[5].mylink="../SZ_SDEPG/page/gatlive.jsp?returnurl="+returnurl;
	  
	   area1=AreaCreator(3,2,new Array(8,6,2,5),"area1_list_","afocus","ablur");
	   area1.stablemoveindex=new Array(-1,-1,"7-1",-1);
	   for(i=0;i<6;i++)
	       area1.doms[i].contentdom=$("area1_txt_"+i);
	   area2=AreaCreator(3,2,new Array(1,6,3,5),"area2_list_","afocus","ablur");
	   area2.stablemoveindex=new Array("0-6,1-7","0-1,2-1,4-1",-1,"3-7>0,5-7>0");
	   for(i=0;i<6;i++)
	       area2.doms[i].contentdom=$("area2_txt_"+i);
	   area3=AreaCreator(1,1,new Array(2,7,4,7),"area3_","afocus","ablur");
	   area3.stablemoveindex=new Array("0-4","0-2",-1,-1);
	   area3.doms[0].mylink="space_collect.jsp";
	   area4=AreaCreator(1,1,new Array(3,7,0,7),"area4_","afocus","ablur");
	   area4.stablemoveindex=new Array(-1,"0-2",-1,-1);
	   area4.doms[0].mylink="search.jsp";
	   area5=AreaCreator(1,1,new Array(0,8,7,6),"area5_","afocus","ablur");
	   area5.doms[0].imgdom=$("area5_img_0");
	   area5.stablemoveindex=new Array("0-2","0-8",-1,-1);
	   area6=AreaCreator(2,1,new Array(0,5,7,1),"area6_list_","afocus","ablur");
	   area6.stablemoveindex=new Array("0-5",-1,"1-2","1-2>0");
	   area6.doms[0].imgdom=$("area6_img_0");
	   area6.doms[1].imgdom=$("area6_img_1");
	   area7=AreaCreator(1,3,new Array(5,3,0,3),"area7_list_","afocus","ablur");
	   area7.stablemoveindex=new Array("2-6>1",-1,"0-2,1-3,2-4",-1);
	   area7.doms[2].imgdom=$("area6_img_1");
	    for(i=0;i<3;i++)
		{
	       //area7.doms[i].contentdom=$("area7_txt_"+i);
		   area7.doms[i].imgdom=$("area7_img_"+i);
		}
           area8=AreaCreator(1,1,new Array(0,6,1,5),"area8_list_","afocus","ablur");	
		 area8.doms[0].contentdom=$("area8_txt_0");   
	var backfocus;
	      if("1"==backflag)
		    backfocus=getCurFocus("cindex");
	   pageobj=new PageObj(backfocus!=null?backfocus[0].areaid:0,backfocus!=null?backfocus[0].curindex:0,new Array(area0,area1,area2,area3,area4,area5,area6,area7,area8));
	   
	   var area1setlink = 0;        //area1setlink=0 use iframe player and live URL; area1setlink=1 usr picture and page-link URL;
	   if(area1setlink == 0)
	   //	area5.doms[0].mylink="play_ControlChannel2.jsp?ControlFlag=0&CHANNELNUM=<%=shouyezhibo%>&COMEFROMFLAG=1&returnurl="+escape(location.href);
	   	area5.doms[0].mylink="play_ControlChannel.jsp?CHANNELNUM=<%=shouyezhibo%>&COMEFROMFLAG=1&returnurl="+escape(location.href);	 
	   else if(indexiframeUrl!=null)
	   //	area5.doms[0].mylink="../../../"+indexiframeUrl+"?returnurl="+escape(location.href);
	        area5.doms[0].mylink="../../../"+indexiframeUrl;
	   else
		   area5.doms[0].mylink="young/index.html?returnurl="+escape(location.href);//修改了视频链接
	   
	   pageobj.pageOkEvent=function()
	   {
		var json=createFocstr(pageobj);
          	saveCookie("cindex",json!=undefined?json:"");    
	   }
	   binddata();
	   load_iframe();
	   //setTimeout(load_iframe,500);
   }
   function binddata()
   {
	   //推荐
	   VAStext(list,area1);
	   //热点
	   VAStext(list1,area2);
	   //专题
	   VASimg(list2,area6);
	   //推荐点播
	   getdata(list3);
	   VASimg1(list3_vas,area7)
   	   VAStext(list4,area8);
	}
   function VAStext(data,area)
   {
	   area.datanum=(data.length==undefined?0:data.length);
		for(i=0;i<area.doms.length;i++)
			{
				if(i<data.length)
			   {
				   area.doms[i].setcontent("",data[i].VASNAME,14,false,false);
				   area.doms[i].youwannauseobj=data[i].VASID;
				   area.doms[i].mylink = data[i].VASURL;
				   /**
				   area.doms[i].domOkEvent=function()
				   {
					   
					   window.location.href="indexdetaildata.jsp?vasid="+this.youwannauseobj;
				   }
				   **/
				   
			   }
			   else
				area.doms[i].updatecontent("");
			}   
   }
   function VASimg(data,area)
   {
	   area.datanum=(data.length==undefined?0:data.length);
		for(i=0;i<area.doms.length;i++)
			{
				if(i<data.length)
			   {
				    //var param=new Array(data[i].VASID,area.doms[i]);
				    //getAJAXData("datajsp/indeximgdata.jsp?vasid="+data[i].VASID,showimg,param);
					area.doms[i].updateimg("../"+zhuantipic[i]);
					area.doms[i].youwannauseobj=data[i].VASID;
					area.doms[i].mylink = "../../../"+data[i].VASURL+"?back=1&returnurl="+returnurl;
					/**
					area.doms[i].domOkEvent=function()
				   {
					   
					   window.location.href="indexdetaildata.jsp?vasid="+this.youwannauseobj;
				   }
				   **/				
			   }
			   else
				area.doms[i].updateimg("#");

			}   
   }
   function alertVasurl(vasurl){
	   
	 
     window.location.href=vasurl;
   }
   function VASimg1(data,area)
   {
	   area.datanum += (data.length==undefined?0:data.length);
				if(2<area.datanum)
			   {
					area.doms[2].updateimg("../"+array3_vasPic[0]);
					area.doms[2].youwannauseobj=data[0].VASID;
					//area.doms[2].mylink = data[2].VASURL;			
		  		   area.doms[2].domOkEvent=function()
				   {
					   
					  $('hidden_frame').src ="indexdetaildata.jsp?vasid="+this.youwannauseobj;
				   }
			   }
			   else
				area.doms[2].updateimg("#");
   }
   
   
   function getdata(data)
   {   
       
	   area7.datanum=data.length;
		for(i=0;i<area7.doms.length;i++)
			{
				if(i<data.length)
			   {
				  
				   area7.doms[i].updateimg("../"+(data[i].POSTERPATHS.type3[0]!=undefined?data[i].POSTERPATHS.type3[0]:(data[i].PICPATH!=undefined?data[i].PICPATH:'images/no_picture_259x232.jpg')));
				   //0:视频VOD、1:视频频道、2:音频频道、3:频道、4:音频AOD、10:VOD、100:增值业务、300:节目、9999:混合栏目
				   //area7.doms[i].setcontent("",data[i].VODNAME,12);
			       area7.doms[i].mylink="vod-tv-detail.jsp?vodid="+data[i].VODID+"&typeid=<%=shouyerediancode%>"+"&returnurl="+returnurl;
			   }
			   else
				   area7.doms[i].updateimg("#");
			    
			}
		//var tmpindex=1;
		//if(data[tmpindex]!=undefined)
		//{
	    //   area5.doms[0].updateimg("../"+(data[tmpindex].POSTERPATHS.type0[0]!=undefined?data[tmpindex].POSTERPATHS.type0[0]:(data[tmpindex].PICPATH!=undefined?data[tmpindex].PICPATH:'images/no_picture_259x232.jpg')));
	    //   alert(data[tmpindex].VODID);
		//   area5.doms[0].mylink="vod-tv-detail.jsp?vodid="+data[tmpindex].VODID+"&typeid=-1&returnurl="+returnurl;
		//}
		//area5.doms[0].updateimg("../images/jy.jpg");
		//area5.doms[0].mylink="vod-tv-detail.jsp?vodid=740029&typeid=-1&returnurl="+returnurl;
   }
   //视频窗口
   function load_iframe()
	{
	//	progId="";//故意修改 MXR修改中间为图片
		if (progId != "" && progId != "null" && progId != null)
		{			
			playPage.location.href = "PlayTrailerInVas.jsp?left=182&top=107&width=286&height=215&type="+"<%=CATEGORY_TRAILER_TYPE%>"+"&value=" + "<%=CATEGORY_TRAILER_ID%>" +"&mediacode="+ "<%=CATEGORY_TRAILER_ID%>" +"&contenttype="+ "<%=CATEGORY_TRAILER_CONTENTTYPE%>&liveid="+"<%=shouyezhibo%>";
		}
		else 
		{
			//document.getElementById("mid_play").src ="../images/kids.jpg";
			if(indexiframePic[0]!=null&&indexiframePic[0]!="")
				document.getElementById("mid_play").src = "../"+indexiframePic[0];
			else
				document.getElementById("mid_play").src ="../images/kids.jpg";
		}
	}
	
//下面为音量控制	
var volumeDivIsShow = false;
var volume = 20;
function volumeUp()
{

	hideVoice();
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){mp.setMuteFlag(0);}
	volume = mp.getVolume(); 
	volume += 5;
	if(volume >= 100){volume = 100;    }
	mp.setVolume(volume);  
	if (mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
	{
		clearTimeout(bottomTimer);
		bottomTimer = "";
		genVolumeTable(volume);
		bottomTimer = setTimeout(hideBottom, 5000);
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
		bottomTimer = setTimeout(hideBottom, 5000);
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
			document.getElementById("voice").src="images/playcontrol/playChannel/muteoff.png";
			voiceTimer = setTimeout(hideVoice, 5000);
		}
	}
	else
	{
		mp.setMuteFlag(1);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
		{
			document.getElementById("voice").src="images/playcontrol/playChannel/muteon.png";
		}
	}      
}
	
</script>
</head>
<body bgcolor='transparent'>
<div class="wrapper">

    <!-- S LOGO -->
    <div class="logo"><img src="../images/logo.png" /></div>
    <!-- E LOGO -->

	<div id="bottomframe" style="position:absolute;left:60px; top:590px; width:1200px; height:190px; z-index:1"></div>
	<div style="position:absolute; left:816px; top:105px; width:54px; height:66px; z-index:3;"><img id="voice" src="images/dot.gif"/></div>
    
    <!-- S 导航 -->
    <div class="mod-index-nav">
        <div class="item item-live" style="left:20px;">
            <div class="link"><a href="#" id="area0_list_0"><img src="../../images/t.gif" /></a></div>
            <div class="txt">直播</div>
        </div>
        <div class="item" style="left:160px;" >
            <div class="link"><a href="#" id="area0_list_1"><img src="../../images/t.gif" /></a></div>
            <div class="txt">点播</div>
        </div>
        <div class="item" style="left:255px;" >
            <div class="link"><a href="#" id="area0_list_2"><img src="../../images/t.gif" /></a></div>
            <div class="txt">回放</div>
        </div>
        <div class="item" style="left:347px;" >
            <div class="link"><a href="#" id="area0_list_3"><img src="../../images/t.gif" /></a></div>
            <div class="txt">深圳</div>
        </div>
        <div class="item" style="left:440px;" >
            <div class="link"><a href="#" id="area0_list_4"><img src="../../images/t.gif" /></a></div>
            <div class="txt">应用</div>
        </div>
        <div class="item item-zhuanti" style="left:533px;">
            <div class="link"><a href="#" id="area0_list_5"><img src="../images/t.gif" /></a></div>
            <div class="txt">专题</div>
        </div>
    </div>
    <!-- E 导航 -->

    <!-- S 推荐 -->
 






<div class="mod-index-recommend">

	 <div class="item" id="tuijian" style="left: 40px; top: 140px;">
            <div class="link"    ><a href="#" id="area8_list_0"  ><img src="../../images/t.gif" /></a></div>
            <div class="txt" id="area8_txt_0"  ></div>
        </div>


        <div class="item" style="left: 29px; top: 170px;">
            <div class="link" ><a href="#" id="area1_list_0"><img src="../../images/t.gif" /></a></div>
            <div class="txt" id="area1_txt_0"></div>
        </div>
        <div class="item" style="left: 100px; top: 170px;">
            <div class="link"><a href="#" id="area1_list_1"><img src="../../images/t.gif" /></a></div>
            <div class="txt" id="area1_txt_1"></div>
        </div>
        <div class="item" style="left: 29px; top: 200px;">
            <div class="link"><a href="#" id="area1_list_2"><img src="../../images/t.gif" /></a></div>
            <div class="txt" id="area1_txt_2"></div>
        </div>
        <div class="item" style="left: 100px; top: 200px;">
            <div class="link"><a href="#" id="area1_list_3"><img src="../../images/t.gif" /></a></div>
            <div class="txt" id="area1_txt_3"></div>
        </div>
        <div class="item" style="left: 29px; top: 230px;">
            <div class="link"><a href="#" id="area1_list_4"><img src="../../images/t.gif" /></a></div>
            <div class="txt" id="area1_txt_4"></div>
        </div>
        <div class="item" style="left: 100px; top: 230px;">
            <div class="link"><a href="#" id="area1_list_5"><img src="../../images/t.gif" /></a></div>
            <div class="txt" id="area1_txt_5"></div>
        </div>
    </div>
    <!-- E 推荐 -->

    <!-- S 热点 -->
    <div class="mod-index-hot">
        <div class="item" style="left: 29px; top: 296px;">
            <div class="link"><a href="#" id="area2_list_0"><img src="../../images/t.gif" /></a></div>
            <div class="txt" id="area2_txt_0"></div>
        </div>
        <div class="item" style="left: 100px; top: 296px;">
            <div class="link"><a href="#" id="area2_list_1"><img src="../../images/t.gif" /></a></div>
            <div class="txt" id="area2_txt_1"></div>
        </div>
        <div class="item" style="left: 29px; top: 327px;">
            <div class="link"><a href="#" id="area2_list_2"><img src="../../images/t.gif" /></a></div>
            <div class="txt" id="area2_txt_2"></div>
        </div>
        <div class="item" style="left: 100px; top: 327px;">
            <div class="link"><a href="#" id="area2_list_3"><img src="../../images/t.gif" /></a></div>
            <div class="txt" id="area2_txt_3"></div>
        </div>
        <div class="item" style="left: 29px; top: 357px;">
            <div class="link"><a href="#" id="area2_list_4"><img src="../../images/t.gif" /></a></div>
            <div class="txt" id="area2_txt_4"></div>
        </div>
        <div class="item" style="left: 100px; top: 357px;">
            <div class="link"><a href="#" id="area2_list_5"><img src="../../images/t.gif" /></a></div>
            <div class="txt" id="area2_txt_5"></div>
        </div>
    </div>
    <!-- E 热点 -->

    <!-- S 我的空间 -->
    <div class="btn-myspace">
        <a href="#" id="area3_0"><img src="../images/index-btn-mySpace.png" alt="我的空间" /></a>
    </div>
    <!-- E 我的空间 -->

    <!-- S 节目搜索 -->
    <div class="btn-proSearch">
        <a href="#" id="area4_0"><img src="../images/index-btn-proSearch.png" alt="节目搜索" /></a>
    </div>
    <!-- E 节目搜索 -->

    <!-- S 视频展示 -->
    <div class="mod-indexShowMovie">
    <div class="pic"><a href="#" id="area5_0"><img id="mid_play" src="#" style="height:220px; width:290px;" /></a></div>
    </div>
    <!--
    <div class="mod-indexShowMovie">
        <div class="pic">
           <img id="area5_img_0" src="../images/jy.jpg"/>
        </div>
    </div>
    <!-- E 视频展示 -->

    <!-- S 专题 -->
    <div class="mod-index-specTopic">
        <div class="item" style="top: 108px;">
            <div class="link"><a href="#" id="area6_list_0"><img src="../../images/t.gif" /></a></div>
            <div class="icon" style="display:none;"><img src="../images/icon-zt.png" /></div>
            <div class="pic"><img  id="area6_img_0" /></div>
        </div>
        <div class="item" style="top: 223px;" >
            <div class="link"><a href="#" id="area6_list_1"><img src="../../images/t.gif" /></a></div>
            <div class="icon" style="display:none;"><img src="../images/icon-zt.png" /></div>
            <div class="pic"><img id="area6_img_1" /></div>
        </div>
    </div>
    <!-- E 专题 -->

    <!-- S 电影 -->
    <div class="mod-index-movie">
        <div class="item" style="left: 180px;">
            <div class="link"><a href="#" id="area7_list_0"><img src="../../images/t.gif" /></a></div>
            <!-- <div class="txtWrap">
                <div class="txt" id="area7_txt_0"></div>
            </div> -->
            <div class="pic"><img id="area7_img_0"/></div>
        </div>
        <div class="item" style="left: 331px;">
            <div class="link"><a href="#" id="area7_list_1"><img src="../../images/t.gif" /></a></div>
            <!-- <div class="txtWrap">
                <div class="txt" id="area7_txt_1"></div>
            </div> -->
            <div class="pic"><img id="area7_img_1" /></div>
        </div>
        <div class="item" style="left: 481px;">
            <div class="link"><a href="#" id="area7_list_2"><img src="../../images/t.gif" /></a></div>
            <!-- <div class="txtWrap">
                <div class="txt" id="area7_txt_2"></div>
            </div> -->
            <div class="pic"><img id="area7_img_2" /></div>
        </div>
    </div>
    <!-- E 电影 -->

    <!-- S 底部走马灯 -->



    <!-- E 底部走马灯 -->
    <iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="1px" height="1px" ></iframe>
    <iframe name="hidden_frame1" id="hidden_frame1" style=" display:none" width="1px" height="1px" ></iframe>
    <!-- 视频窗口 -->
<iframe id="playPage" name="playPage" frameborder="0" height="1px" width="1px"></iframe>
</div>
</body>
</html>
