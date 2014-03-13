<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file="config/config_TrailerInVas.jsp"%>
<%@ include file="OneKeyPlay.jsp"%>
<html>
<head>
<%@ include file="save_focus.jsp"%>
<%@ include file="datajsp/livedata.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
    <meta name="page-view-size" content="640*530"/>
    <title>直播 | CCTV-IP电视</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <style type="text/css">
        body {
            background:  url("../images/body-page-live.gif") no-repeat;
        }
        .mod-liveMovieShow {
            background-color: #052438;
            height: 270px;
            width: 360px;
            position: absolute;
            left: 260px;
            top: 90px;
        }
        .mod-liveMovieShow .pic {
            height: 264px;
            width: 353px;
            left: 3px;
            top: 3px;
        }
        .live-playList .txtTh {
            height: 24px;
            width: 110px;
            position: absolute;
        }
        .live-playList .item .txt {
            width: 180px;//ztewebkit
        }
        .live-playList .item .txtTime {
            position: absolute;
            width: 75px;
        }
    </style>
    <script type="text/javascript" src="../js/pagecontrolx.js"></script>
<script type="text/javascript">
   var area0,area1,area2;
   var list=new Array();
   var backurl="<%=request.getParameter("returnurl")%>";
   var zhiboid;
   var livett;
   var progId="<%=CATEGORY_TRAILER_ID%>";
   var returnurl;
   var setPlayTime;
   var load_iFrameTime;
   window.onload=function()
   {
	   Authentication.CTCSetConfig("key_ctrl_ex", "0");
	   returnurl=unescape(window.location.href);
		   if(returnurl.indexOf('back=1')==-1)
		   {
		       if(returnurl.indexOf('?')==-1)
			      returnurl+="?back=1";
		       else
			      returnurl+="&back=1";
		    }
	    refreshServerTime();
		area0=AreaCreator(8,1,new Array(-1,-1,-1,1),"area0_list_","className:icon onboder","className:icon"); 
		area0.stablemoveindex=new Array(-1,-1,-1,"0-0,1-1,2-2,3-3,4-4,5-5,6-6,7-7");
		for(i=0;i<8;i++)
		   area0.doms[i].imgdom=$("area0_img_"+i);
	    area1=AreaCreator(8,1,new Array(-1,0,-1,-1),new Array("area1_list_","area1_list1_"),new Array("className:item item_select","className:link onboder"),new Array("className:item","className:link offboder"));  
		area1.stablemoveindex=new Array(-1,"0-0,1-1,2-2,3-3,4-4,5-5,6-6,7-7",-1,-1);
		area1.setpageturnattention("pageup","../images/arr-up.png","../images/arr-up_disable.png","pagedown","../images/arr-down.png","../images/arr-down_disable.png");
		for(i=0;i<8;i++)
		{
		    area1.doms[i].contentdom=$("area1_txt_"+i);	
			area1.doms[i].numdom=$("area1_num_"+i);	
		}
		area2=AreaCreator(3,1,new Array(-1,-1,-1,-1),"area2_txt_","className:","className:");
		for(i=0;i<3;i++)
		{
			area2.doms[i].datedom=$("area2_date_"+i);	
		}
		var backfocus;
	      if("1"=='<%=backflag%>')
		    backfocus=getCurFocus("clive");
		pageobj=new PageObj(new Array(area0,area1,area2));
		pageobj.goBackEvent=function()
	   {
		   window.location.href=(backurl!=null&&backurl!='null'&&backurl!=undefined)?backurl:"index.jsp?back=1";
	   }
	   pageobj.pageOkEvent=function()
	   {
		  var json=createFocstr(pageobj);
          saveCookie("clive",json!=undefined?json:"");    
	   }
	   if(backfocus!=null)
	   {
		   area0.curpage=<%=curpage%>;
		   area1.curpage=<%=curpage%>;
	       pageobj.areas[backfocus[0].areaid].curindex=backfocus[0].curindex;
	   }

	   area1.areaOkEvent=function()
	   {
		   window.location.href="play_ControlChannel.jsp?CHANNELNUM="+area1.doms[area1.curindex].channelnum+"&COMEFROMFLAG=1&returnurl="+escape(location.href); 
	   }
		area1.setcrossturnpage();
	    area1.setfocuscircle(0);
		area1.dataarea=area2;
		area1.changefocusedEvent=function()
		{
		   if(setPlayTime) clearTimeout(setPlayTime);
		   setPlayTime = setTimeout(setTimePlay,300);
		}
		area1.areaPageTurnEvent1=function()
		{
		     area0.curpage=area1.curpage;
		}
		area1.setSimulationAjax(function()
		 {
			 list=new Array();
			 var start = (this.curpage-1)*8;
			 var size = (totallist.length-start)>=8?8:(totallist.length-start);
			 for(i=0;i<size;i++)
	         {
	            list[i]=totallist[start+i];
	         }
             getdata(list,pagecount);
		 });
		  area2.setTrueAjax("datajsp/liveasyndata.jsp?channelid=#(area1.doms[area1.curindex].dataurlorparam)",showdetail);
		 var start = (parseInt(<%=curpage%>)-1)*8;
		 var size = (totallist.length-start)>=8?8:(totallist.length-start);
		 for(i=0;i<size;i++)
	     {
	          list[i]=totallist[start+i];
	     }
		 
       getdata(list,pagecount);   
	   pageobj.setinitfocus(backfocus!=null?backfocus[0].areaid:1,backfocus!=null?backfocus[0].curindex:0);
	   clearTimeout(load_iFrameTime);
	   load_iFrameTime = setTimeout("load_iframe()",400);
   }
    
	//定时播放
	function setTimePlay()
	{
		clearTimeout(setPlayTime);
		if(playPage.mp!=null && playPage.mp!=undefined )
		{ playPage.mp.joinChannel(totallist[(area1.curpage-1)*8+area1.curindex].UserChannelID-1000);}
	}

   function getdata(data,count)
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
				   area1.doms[i].setcontent("",data[i].ChannelName,14);
				   area1.doms[i].numdom.innerHTML=tmpStr +(data[i].UserChannelID-1000);
			       area1.doms[i].dataurlorparam=data[i].ChannelID;
				   area1.doms[i].channelnum=data[i].UserChannelID-1000;
				   if(data[i].ISTVOD=='0')
				   {
				      area0.doms[i].updateimg("../images/icon-ltlive-gray.png");
					  area0.doms[i].mylink=""; 
				   }
				   else
				   {
				      area0.doms[i].updateimg("../images/icon-ltlive.png");
					  area0.doms[i].mylink="playback.jsp?channelId="+data[i].ChannelID+"&returnurl="+escape(returnurl);
				   }
				   
				   area0.doms[i].dom[0].style.visibility="visible";
			   }
			   else
			   {
				   area1.doms[i].updatecontent("");
				   area1.doms[i].numdom.innerHTML="";
				   area0.doms[i].dom[0].style.visibility="hidden";
			   }
			}
   }
   function showdetail(result)
   {
	   var re=eval('('+result+')');
	   var data=re.data;
       rectotallist=new Array();
       rectotallist=data;
	   area2.datanum=data.length;
	   for(i=0;i<area2.doms.length;i++)
			{
				if(i<data.length)
			   {
				   var time=data[i].starttime.substring(0,5);
				   area2.doms[i].setcontent("",data[i].proname,18);
				   area2.doms[i].datedom.innerHTML=time;
				   //if(parseInt(data[i].STATUS)==1)
			   }
			   else
				  area2.doms[i].updatecontent("");
			}
   }
   //视频窗口
   function load_iframe()
	{
		if (progId != "" && progId != "null" && progId != null)
		{	
			playPage.location.href = "PlayTrailerInVas.jsp?left=263&top=87&width=355&height=266&type="+"<%=CATEGORY_TRAILER_TYPE%>"+"&value=" + "<%=CATEGORY_TRAILER_ID%>" +"&mediacode="+ "<%=CATEGORY_TRAILER_ID%>" +"&contenttype="+ "<%=CATEGORY_TRAILER_CONTENTTYPE%>&liveid="+area1.doms[area1.curindex].channelnum;	
		}
		else 
		{
			document.getElementById("mid_play").src ="images/temp/1.jpg";
		}
	}
</script>
</head>
<body  bgcolor="transparent">
<div class="wrapper">
    <!-- S 面包屑 -->
    <div class="mod-bread" >
        直播中国
    </div>
    <!-- E 面包屑 -->

    <!-- S 时间 -->
    <div class="mod-dataTime" id="currDate"></div>
    <!-- E 时间 -->

    <!-- S 左侧导航 -->
    <div class="leftNav-c">

        <!-- S 向上箭头 -->
        <div class="item-arr-up" style="top:75px;">
            <img id="pageup" />
        </div>
        <!-- E 向上箭头 -->

        <div class="item" style="top:110px;" id="area1_list_0">
            <div class="icon" id="area0_list_0"><img id="area0_img_0" src="../images/icon-ltlive.png" /></div>
            <div class="link" id="area1_list1_0"><img src="../images/t.gif" /></div>
            <div class="txt">
                <div class="num" id="area1_num_0"></div>
                <div class="name" id="area1_txt_0"></div>
            </div>
        </div>
        <div class="item" style="top:151px;" id="area1_list_1">
            <div class="icon" id="area0_list_1"><img id="area0_img_1" src="../images/icon-ltlive.png" /></div>
            <div class="link" id="area1_list1_1"><img src="../images/t.gif" /></div>
            <div class="txt">
                <div class="num" id="area1_num_1"></div>
                <div class="name" id="area1_txt_1"></div>
            </div>
        </div>
        <div class="item" style="top:192px;" id="area1_list_2">
            <div class="icon" id="area0_list_2"><img id="area0_img_2" src="../images/icon-ltlive.png" /></div>
            <div class="link" id="area1_list1_2"><img src="../images/t.gif" /></div>
            <div class="txt">
                <div class="num" id="area1_num_2"></div>
                <div class="name" id="area1_txt_2"></div>
            </div>
        </div>
        <div class="item" style="top:233px;" id="area1_list_3">
            <div class="icon" id="area0_list_3"><img id="area0_img_3" src="../images/icon-ltlive.png" /></div>
            <div class="link" id="area1_list1_3"><img src="../images/t.gif" /></div>
            <div class="txt">
                <div class="num" id="area1_num_3"></div>
                <div class="name" id="area1_txt_3"></div>
            </div>
        </div>
        <div class="item" style="top:274px;" id="area1_list_4">
            <div class="icon" id="area0_list_4"><img id="area0_img_4" src="../images/icon-ltlive.png" /></div>
            <div class="link" id="area1_list1_4"><img src="../images/t.gif" /></div>
            <div class="txt">
                <div class="num" id="area1_num_4"></div>
                <div class="name" id="area1_txt_4"></div>
            </div>
        </div>
        <div class="item" style="top:315px;" id="area1_list_5">
            <div class="icon" id="area0_list_5"><img id="area0_img_5" src="../images/icon-ltlive.png" /></div>
            <div class="link" id="area1_list1_5"><img src="../images/t.gif" /></div>
            <div class="txt">
                <div class="num" id="area1_num_5"></div>
                <div class="name" id="area1_txt_5"></div>
            </div>
        </div>
        <div class="item" style="top:356px;" id="area1_list_6">
            <div class="icon" id="area0_list_6"><img id="area0_img_6" src="../images/icon-ltlive.png" /></div>
            <div class="link" id="area1_list1_6"><img src="../images/t.gif" /></div>
            <div class="txt">
                <div class="num" id="area1_num_6"></div>
                <div class="name" id="area1_txt_6"></div>
            </div>
        </div>
        <div class="item" style="top:397px;" id="area1_list_7">
            <div class="icon" id="area0_list_7"><img id="area0_img_7" src="../images/icon-ltlive.png" /></div>
            <div class="link" id="area1_list1_7"><img src="../images/t.gif" /></div>
            <div class="txt">
                <div class="num" id="area1_num_7"></div>
                <div class="name" id="area1_txt_7"></div>
            </div>
        </div>

        <!-- S 向下箭头 -->
        <div class="item-arr-down" style="top:444px;">
            <img id="pagedown"/>
        </div>
        <!-- E 向下箭头 -->

    </div>
    <!-- E 左侧导航 -->

    <!-- S 直播视频窗口 -->
    <div style="position:absolute; width:0; height:0;">
    <!-- 视频窗口 -->
<iframe id="playPage" name="playPage" frameborder="0" width="100%" height="100%" scrolling="no"  ></iframe>
    </div>
    <!-- E 直播视频窗口 -->

    <!-- S 播放列表 -->
    <div class="live-playList">
        <div class="txtTh" style="left:277px; top:371px;">正在播放：</div>
        <div class="item">
            <div class="txt" style="left:379px; top:371px;" id="area2_txt_0"></div>
            <div class="txtTime" style="left:550px; top:371px;" id="area2_date_0"></div>
        </div>
        <div class="txtTh" style="left:277px; top:400px;">即将播放：</div>
        <div class="item">
            <div class="txt" style="left:379px; top:400px;" id="area2_txt_1"></div>
            <div class="txtTime" style="left:550px; top:400px;" id="area2_date_1"></div>
        </div>
        <div class="item">
            <div class="txt" style="left:379px; top:432px;" id="area2_txt_2"></div>
            <div class="txtTime" style="left:550px; top:432px;" id="area2_date_2"></div>
        </div>
    </div>
    <!-- E 播放列表 -->
</div>

<%@ include file="servertimehelp.jsp" %>
</body>
</html>
