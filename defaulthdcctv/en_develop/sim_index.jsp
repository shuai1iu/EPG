<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page language="java" import="java.util.*"%>
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
<%@ include file="datajsp/sim_indexdata.jsp"%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页_央视高清EPG</title>
<meta name="page-view-size" content="1280*720"/>
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<style>
<!--
body{ background1:url(images/mainbg_index.png) no-repeat}
.geton{z-index:3}
.getoff{z-index:1}
-->

.simtitle{width:190px;height:45px; position:absolute; top:10px;left:230px;}
.simtitle div.on{ background:url(images/simtitle_on.png) no-repeat;width:200px;height:55px;}

/*sim_l_ad*/
.l_ad{ position:absolute; top:78px; left:3px}
.l_ad div{ width:332px; height:162px; position:absolute; top:0; left:0}
.l_ad div.on{ background:url(images/pic_bg2.png) no-repeat; z-index:2}
.l_ad div img{ position:absolute; top:11px; left:14px}

</style>
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript">

   var returnurl=escape(window.location.href);
   var area2;
   var area3;
	var progId="<%=CATEGORY_TRAILER_ID%>";
    window.onload=function()
   {
	   var areaid=<%=request.getParameter("areaid")%>;
	var indexid=<%=request.getParameter("indexid")%>;
	   
	   var backflag='<%=request.getParameter("back")%>';
	 area0=AreaCreator(4,1,new Array(4,-1,-1,1),new Array("area0_list_","area0_list1_"),new Array("className:on","className:geton"),new Array("className:","className:"));
	   area0.stablemoveindex = new Array("0-5>0",-1,-1,"3-2>0");
	   for(i=0;i<4;i++)
		  area0.doms[i].imgdom=$("area0_img_"+i);
	   var area1=AreaCreator(1,1,new Array(4,0,2,3),"area1_list_","className:mid_adon","className:mid_ad");
	    area1.stablemoveindex = new Array("0-5>2",-1,-1,-1);
	  if(indexiframeUrl!=null&&indexiframeUrl!="")
	             area1.doms[0].mylink = "../../"+indexiframeUrl;
	   else
	   	   area1.doms[0].mylink = "../../defaultgd/en/hdyoung/page/index.jsp?returnurl="+escape(location.href);

	   area2=AreaCreator(1,4,new Array(1,0,4,3),"area2_list_","className:item item03 item03_focus","className:item item03");
	   area2.stablemoveindex=new Array(-1,"0-3","0-0,1-2,2-4,3-6","3-3");
	   for(var i=0;i<area2.doms.length;i++){
			area2.doms[i].contentdom = $("area2_listName_"+i);
		}
	   area2.doms[0].focusstyle = new Array("className:item item04 item04_focus");
       area2.doms[0].unfocusstyle = new Array("className:item item04");
	   
	   var area4=AreaCreator(2,8,new Array(2,0,-1,3),"area4_list_","className:item item01 item01_focus","className:item item01");
	   area4.stablemoveindex=new Array("0-0,1-0,2-1,3-1,4-2,5-2,6-3,7-3","0-3,8-3",-1,"7-3,15-3");
	   for(var j=0;j<area4.doms.length;j++){
			area4.doms[j].contentdom = $("area4_listName_"+j);
		}
	   area4.doms[0].focusstyle = new Array("className:item item02 item02_focus");
       area4.doms[0].unfocusstyle = new Array("className:item item02");
	   area4.doms[1].focusstyle = new Array("className:item item02 item02_focus");
       area4.doms[1].unfocusstyle = new Array("className:item item02");
	   area4.doms[8].focusstyle = new Array("className:item item02 item02_focus");
       area4.doms[8].unfocusstyle = new Array("className:item item02");
	   area4.doms[9].focusstyle = new Array("className:item item02 item02_focus");
       area4.doms[9].unfocusstyle = new Array("className:item item02");

	   area3=AreaCreator(4,1,new Array(4,1,-1,-1),new Array("area3_list_","area3_list1_"),new Array("className:on","className:geton"),new Array("className:","className:"));
	   area3.stablemoveindex=new Array("0-5>4","3-2>3",-1,-1);
	   for(i=0;i<4;i++)
	      area3.doms[i].imgdom=$("area3_img_"+i);

	   var area5=AreaCreator(1,5,new Array(-1,-1,1,-1),"area5_title_","className:simtitle on","className:simtitle");
	   area5.setstaystyle("className:simtitle current",3);
	   area5.setfocuscircle(5);
	   area5.doms[0].mylink = "sim_index.jsp";
	   area5.doms[4].mylink = "../../defaultsdcctv/en/page/sim_index.jsp";
	   area5.doms[1].mylink = "test/test_topic.jsp";
	   area5.doms[3].mylink = "test/test_index.jsp";  
	   area5.doms[2].mylink = "sim_playback.jsp";
	  

		var backfocus; 
		if("1"==backflag){
			backfocus=getCurFocus("sim_index");
		}
	   pageobj=new PageObj(areaid!=null?parseInt(areaid):5,indexid!=null?parseInt(indexid):0,new Array(area0,area1,area2,area3,area4,area5));

		if(backfocus!=null)
	   {


	       pageobj.areas[backfocus[0].areaid].curpage=backfocus[0].curpage;
	       pageobj.areas[backfocus[0].areaid].curindex=backfocus[0].curindex;
		   setDarkFocus("sim_index");
	   }
	   pageobj.pageOkEvent=function()
	   {
		  var json=createFocstr(pageobj);
          saveCookie("sim_index",json!=undefined?json:"");    
	   }
	   if(areaid!=null&&areaid!=0)
	   pageobj.goBackEvent=function()
	   {
		   this.changefocus(0,0);
	   }
	   getdata(fivelist,sdtwolist);
	   getdataSecond(fourlist,hdtwolist);

	   getdata1(list1);   
	   getdata2(list2);
//	   getdata3(list2);
	   //load_iframe();
	   setTimeout(load_iframe,200);
  	   
   }
   
   function getdataSecond(four,hdtwo)
   {
	 
	  var j_index = 0;
	  var j2_index = 0;
		for(var j=0;j<area4.doms.length;j++){
			if(j == 0 || j == 1 || j == 8 || j == 9){
				if(four[j_index] != null){
					var showName = four[j_index].VASNAME;
						if(showName.length > 2){showName = four[j_index].VASNAME.substring(0,3)}
				   	   area4.doms[j].setcontent("",showName,20,true,true);
					   area4.doms[j].youwannauseobj=four[j_index].VASID;
					   area4.doms[j].domOkEvent=function()
					   {
						   $('hidden_frame').src="datajsp/indexdetaildata.jsp?vasid="+this.youwannauseobj;
					   }
					}else{
			   			area4.doms[j].updatecontent("");
			   		}
					j_index++;
				}else{
					if(hdtwo[j2_index] != null){
						var showName = hdtwo[j2_index].VASNAME;
						if(showName.length > 2){showName = hdtwo[j2_index].VASNAME.substring(0,2)}
						area4.doms[j].setcontent("",showName,20,true,true);
					    area4.doms[j].youwannauseobj=hdtwo[j2_index].VASID;
					    area4.doms[j].domOkEvent=function()
					   {
						   $('hidden_frame').src="datajsp/indexdetaildata.jsp?vasid="+this.youwannauseobj;
					   }
						}else{
			   				area4.doms[j].updatecontent("");
			   			}
						j2_index++;
					}
			
			}
   }
   function getdata(five,sdtwo)
   {
	  var i_index = 0;
		for(var i=0;i<area2.doms.length;i++)
			{
				if(i == 0)
			   {
				   if(five[0]!=null){
					   area2.doms[i].setcontent("",five[i].VASNAME.substring(0,5),20,true,true);
					   area2.doms[i].youwannauseobj=five[i].VASID;
					   area2.doms[i].domOkEvent=function()
					   {
						   $('hidden_frame').src="datajsp/indexdetaildata.jsp?vasid="+this.youwannauseobj;
					   }
					 }else{
			   			area2.doms[i].updatecontent("");
			   		}
			   }else{
			   if(sdtwo[i_index] != null){
				   	var showName = sdtwo[i_index].VASNAME;
						if(showName.length > 3){showName = sdtwo[i_index].VASNAME.substring(0,4)}
				   	   area2.doms[i].setcontent("",showName,20,true,true);
					   area2.doms[i].youwannauseobj=sdtwo[i_index].VASID;
					   area2.doms[i].domOkEvent=function()
					   {
						   $('hidden_frame').src="datajsp/indexdetaildata.jsp?vasid="+this.youwannauseobj;
					   }
				   }else{
			   			area2.doms[i].updatecontent("");
			   		}
					i_index++;
				}	
			}
   }
 

   function getdata1(data)
   {
	   area3.datanum=data.length;
		for(i=0;i<area3.doms.length;i++)
			{
				if(i<data.length)
			   {
					area3.doms[i].updateimg(data[i].POSTERPATHS.type0[0]!=undefined?data[i].POSTERPATHS.type0[0]:(data[i].PICPATH!=undefined?data[i].PICPATH:'images/no_picture_259x165.jpg'));
				    area3.doms[i].mylink="vod_turnpager.jsp?vodid="+data[i].VODID+"&typeid=<%="10000100000000090000000000029036"%>"+"&returnurl="+returnurl;
			   }
			   else
				   area3.doms[i].updateimg("#");
			}
		
   } 
  
   function getdata2(data)
{ 
	   area0.datanum =4 ;
        	for(i=0;i<area0.datanum;i++)
 		{
			if(i<area0.datanum)
			{
			   area0.doms[i].updateimg(vasList2Pic[i]);
			   area0.doms[i].youwannauseobj=data[i].VASID;
			   area0.doms[i].domOkEvent=function()
			   {
				  $('hidden_frame').src="datajsp/indexdetaildata1.jsp?vasid="+this.youwannauseobj;
			   }
		}
		else
		   area0.doms[i].updateimg("#");
	}
}



/*
   function getdata3(data)
   {
   area3.datanum =4 ;
   for(i=0;i<area3.datanum;i++)
   {
   if(i<area3.datanum)
   {       
   area3.doms[i].updateimg(vasList2Pic[i+4]);
   area3.doms[i].youwannauseobj=data[i+4].VASID;
   area3.doms[i].domOkEvent=function()
   { 
   $('hidden_frame').src="datajsp/indexdetaildata1.jsp?vasid="+this.youwannauseobj;                          

   }      
   }       
   else
   area3.doms[i].updateimg("#");
   }
   }                               
 */


function load_iframe()
{
	if(indexiframePic[0]!=null&&indexiframePic[0]!="")
		document.getElementById("mid_play").src = indexiframePic[0];
	else
		document.getElementById("mid_play").src ="images/hdkid.jpg";

}
function goURL(url)
{
	document.location.href='../'+url;	
}

function goURL1(vasurl)
{
	if(vasurl.match("defaulthdcctv/en_develop/")||vasurl.match("defaultgd/en/"))
	{
		document.location.href=vasurl;
	}else
	{
		alert("VAS链接配置有误~请检查喵！----CMS君");
	}


}

function goURL2(vasurl)
{

	document.location.href=vasurl;
}


</script>
</head>

<body style="background:url(images/mainbg_index.png); background-color:transparent;">
<div class="main">
    <div style="visibility:hidden; z-index:-1">
    <img src="images/menu_bgfocuson.png"/>
    <img src="images/menu_bgon.png"/>
    <img src="images/pic_bg1on.png"/>
    <img src="images/nav_bgon.png"/>
    <img src="images/pic_bg2.png"/>
    <img src="images/sim_title_on.png"/>
    </div>
	<!--menu-->
<div class="simtitle"> 
	<div class="simtitle" id="area5_title_0" style="left:-120px;"><img src="images/simtitle_1.png" /></div>
	<div class="simtitle" id="area5_title_1" style="left:70px;"><img src="images/simtitle_2.png" /></div>
       	<div class="simtitle" id="area5_title_2" style="left:260px;"><img src="images/simtitle_3.png" /></div>
	<div class="simtitle" id="area5_title_3" style="left:450px;"><img src="images/simtitle_4.png" /></div>
	<div class="simtitle" id="area5_title_4" style="left:650px;"><img src="images/simtitle_5.png" /></div>
</div>
	
	
	
	<!--mid-->
	<div class="mid_ad" id="area1_list_0"><img src="#" id="mid_play" width="508" height="385" /></div> <!--mid_ad/mid_adon-->
	
	<div class="mid_nav"> <!--class="on"-->
		<div class="icon-hd"><img src="images/index-nav-hd.png" /></div>
		<!--焦点 
			class="item item01 item01_focus"  2字
			class="item item02 item02_focus"　3字
			class="item item03 item03_focus"  4字
			class="item item04 item04_focus"  5字
		-->
		<div id="area2_list_0" class="item item04">
			<div id="area2_listName_0" class="txt">直播港澳台</div>
		</div>
		<div id="area2_list_1" class="item item03" style="left:169px;">
			<div id="area2_listName_1" class="txt">尊享包</div>
		</div>
		<div id="area2_list_2" class="item item03" style="left:293px;">
			<div id="area2_listName_2" class="txt">时尚包</div>
		</div>
		<div id="area2_list_3" class="item item03" style="left:418px;">
			<div id="area2_listName_3" class="txt">淘淘乐园</div>
		</div>
		
		<div id="area4_list_0" class="item item02" style="top:44px;">
			<div id="area4_listName_0" class="txt">看大片</div>
		</div>
		<div id="area4_list_1" class="item item02" style="left:84px;top:44px;">
			<div id="area4_listName_1" class="txt">热剧</div>
		</div>
		<div id="area4_list_2" class="item item01" style="left:169px;top:44px;">
			<div id="area4_listName_2" class="txt">热剧</div>
		</div>
		<div id="area4_list_3" class="item item01" style="left:232px;top:44px;">
			<div id="area4_listName_3" class="txt">热剧</div>
		</div>
		<div id="area4_list_4" class="item item01" style="left:293px;top:44px;">
			<div id="area4_listName_4" class="txt">热剧</div>
		</div>
		<div id="area4_list_5" class="item item01" style="left:357px;top:44px;">
			<div id="area4_listName_5" class="txt">热剧</div>
		</div>
		<div id="area4_list_6" class="item item01" style="left:418px;top:44px;">
			<div id="area4_listName_6" class="txt">热剧</div>
		</div>
		<div id="area4_list_7" class="item item01" style="left:480px;top:44px;">
			<div id="area4_listName_7" class="txt">热剧</div>
		</div>
		
		<div id="area4_list_8" class="item item02" style="top:85px;">
			<div id="area4_listName_8" class="txt">纪实</div>
		</div>
		<div id="area4_list_9" class="item item02" style="left:84px;top:85px;">
			<div id="area4_listName_9" class="txt">娱乐</div>
		</div>
		<div id="area4_list_10" class="item item01" style="left:169px;top:85px;">
			<div id="area4_listName_10" class="txt">热剧</div>
		</div>
		<div id="area4_list_11" class="item item01" style="left:232px;top:85px;">
			<div id="area4_listName_11" class="txt">热剧</div>
		</div>
		<div id="area4_list_12" class="item item01" style="left:293px;top:85px;">
			<div id="area4_listName_12" class="txt">热剧</div>
		</div>
		<div id="area4_list_13" class="item item01" style="left:357px;top:85px;">
			<div id="area4_listName_13" class="txt">热剧</div>
		</div>
		<div id="area4_list_14" class="item item01" style="left:418px;top:85px;">
			<div id="area4_listName_14" class="txt">热剧</div>
		</div>
		<div id="area4_list_15" class="item item01" style="left:480px;top:85px;">
			<div id="area4_listName_15" class="txt">热剧</div>
		</div>
	</div>
	<div class="nav_line"><img src="images/line.png" /></div>
	
	<!--l-->
	<div class="l_ad">
	<div style="top:0" id="area0_list1_0"><img id="area0_img_0"  width="305" height="137"/></div>
	<div id="area0_list_0" style="top:-1px"></div>
	<div style="top:139px;" id="area0_list1_1"><img id="area0_img_1" width="305" height="137"/></div>
	<div id="area0_list_1" style="top:138px"></div>
	<div style="top:278px;" id="area0_list1_2"><img id="area0_img_2" width="305" height="137" /></div>
	<div id="area0_list_2" style="top:277px;"></div>
	<div style="top:417px;" id="area0_list1_3"><img id="area0_img_3" width="305" height="137" /></div>
	<div id="area0_list_3" style="top:416px"></div>
	</div>

	
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
<iframe id="playPage" name="playPage" frameborder="0" height="1px" width="1px"></iframe>
<iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="1px" height="1px" ></iframe>
<%@ include file="servertimehelp.jsp" %>
</body>
</html>
