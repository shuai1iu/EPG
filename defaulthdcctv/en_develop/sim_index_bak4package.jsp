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
<%
MetaData metaData = new MetaData(request);
String introduce = "";
HashMap typeinfomap = metaData.getTypeInfoByTypeId("10000100000000090000000000028210"); //过滤不能直播不能快进频道
if(typeinfomap!=null){
  introduce = (String)typeinfomap.get("TYPE_INTRODUCE");
}
//String introduce = "1@2@3@4@5@6@7@8@9@203";
String[] strarray = introduce.split("@");
//ZTE
//body{ background:url(images/mainbg_index.png) no-repeat}
%>
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
var controlflag = 0;//0:正常频道y页面 1：受控频道页面
var markArray = new  Array();//用来存放过滤的数据
	<%
		for(int i = 0;i < strarray.length;i++){
	%>
		markArray[<%=i %>] = "<%=strarray[i] %>";
	<%
	}
	%>
function containFun(strArr,str)//过滤频道判断
	{	
	if(strArr!=null){
		for(var i=0;i<strArr.length;i++){
			 if(strArr[i]==str){
				 return true; 
			 }
		}
	}
	return false;
}
   var returnurl=escape(window.location.href);
   var area2;
   var area3;
    var progId="<%=CATEGORY_TRAILER_ID%>";
    window.onload=function()
   {
	   var areaid=0;
	   var indexid=0;
	   var backflag='<%=request.getParameter("back")%>';
	 area0=AreaCreator(4,1,new Array(4,-1,-1,1),new Array("area0_list_","area0_list1_"),new Array("className:on","className:geton"),new Array("className:","className:"));
	   area0.stablemoveindex = new Array("0-4>0",-1,-1,"3-2>0");
	   for(i=0;i<4;i++)
		  area0.doms[i].imgdom=$("area0_img_"+i);
	   var area1=AreaCreator(1,1,new Array(4,0,2,3),"area1_list_","className:mid_adon","className:mid_ad");
	    area1.stablemoveindex = new Array("0-4>2",-1,-1,-1);
	  if(indexiframeUrl!=null&&indexiframeUrl!="")
	             area1.doms[0].mylink = "../../"+indexiframeUrl;
	   else
	   	   area1.doms[0].mylink = "../../defaultgd/en/hdyoung/page/index.jsp?returnurl="+escape(location.href);

	   area2=AreaCreator(3,4,new Array(1,0,-1,3),"area2_list_","className:on","className:");
	   area2.stablemoveindex=new Array(-1,"0-3,4-3,8-3",-1,"3-3,7-3,11-3");
	   area3=AreaCreator(4,1,new Array(4,1,-1,-1),new Array("area3_list_","area3_list1_"),new Array("className:on","className:geton"),new Array("className:","className:"));
	   area3.stablemoveindex=new Array("0-4>4","3-2>3",-1,-1);
	   for(i=0;i<4;i++)
	      area3.doms[i].imgdom=$("area3_img_"+i);
		var area4=AreaCreator(1,5,new Array(-1,-1,1,-1),"area4_title_","className:simtitle on","className:simtitle");
	   area4.setstaystyle("className:simtitle current",3);
	   area4.setfocuscircle(1);
	   area4.doms[0].mylink = "sim_index.jsp";
	   area4.doms[4].mylink = "../../defaultsdcctv/en/page/sim_index.jsp";
	   area4.doms[1].mylink = "test/test_topic.jsp";
	   area4.doms[3].mylink = "test/test_index.jsp";  
	   area4.doms[2].mylink = "sim_playback.jsp";	  
	   
	   pageobj=new PageObj(areaid!=null?parseInt(areaid):(backfocus!=null?backfocus[0].areaid:0),indexid!=null?parseInt(indexid):(backfocus!=null?backfocus[0].curindex:(start==undefined?5:0)),new Array(area0,area1,area2,area3,area4));

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
	   if(areaid!=null&&areaid!=0)
	   pageobj.goBackEvent=function()
	   {
		   this.changefocus(0,0);
	   }
	    getdata(list);
   	   getdata2(list2);
	   getdata3(list2);
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
	   document.location.href=vasurl;	
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
	<div class="simtitle" id="area4_title_0" style="left:-120px;"><img src="images/simtitle_1.png" /></div>
	<div class="simtitle" id="area4_title_1" style="left:70px;"><img src="images/simtitle_2.png" /></div>
       	<div class="simtitle" id="area4_title_2" style="left:260px;"><img src="images/simtitle_3.png" /></div>
	<div class="simtitle" id="area4_title_3" style="left:450px;"><img src="images/simtitle_4.png" /></div>
	<div class="simtitle" id="area4_title_4" style="left:650px;"><img src="images/simtitle_5.png" /></div>
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
