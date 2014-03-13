<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ include file="util/save_focus.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>
<%@ page import="java.util.*"%>
 <%@ page import="java.text.*"%> 
<%@ include file="datajsp/codepage.jsp"%>
<%@ include file="datajsp/playbackdata.jsp"%>


<html >
<head>
<style>
.simtitle{width:190px;height:45px; position:absolute; top:10px;left:230px;}
.simtitle div.on{ background:url(images/simtitle_on.png) no-repeat;width:200px;height:55px;}

.testturnpage { position:absolute;  }
.testturnpage div.on{background:url(test/images/test_page_on.png) no-repeat;z-index:2 }

/*channel*/
.channel_sub,.channel_sub2{ position:absolute; top:90px; left:345px; width:350px}
.channel_sub div.on,.channel_sub2 div.on{ background:url(/images/channel_subon.png) no-repeat}
.channel_sub div.sub,.channel_sub2 div.sub{ height:46px; line-height:40px; padding-left:40px}
	.channel_sub{ top:120px!important; left:150px!important}
	.channel_sub2{ top:120px!important; left:740px!important}
</style>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!-- ZTE -->
<meta name="page-view-size" content="640*530" />
<title></title>
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />




<script language="javascript" type="text/javascript" src="js/pagecontrol.js"></script>
<!--<script language="javascript" type="text/javascript" src="js/pagecontrol.js"></script>-->
<script language="javascript" type="text/javascript">
	var scrollText = "欢迎中央电视台领导视察指导工作";
    //var pageobj;
	var area0;
	var area1;
	var timeIndex = 0;
	var areaid;
	var indexid;
	
	function getdata(data,pageCount)
	 {	
		 area1.setpageturndata(data.length,parseInt(pageCount));
		 
		 var area1size = area1.doms.length;
		 for(var i=0;i<area1size;i++)
		 {
			 var t = 0;   //改变顺序
			 if(i<(area1size/2)) t = i*2;
			 else t = i*2-21;
			 if(i<data.length)
			 {
				  var tmpNumber = parseInt(data[i].channelNumber) - 1000;
				  var tmpSeq = "" + tmpNumber;
            	  		var tmpStr = "";
           		  	if (tmpSeq.length == 1)
                			tmpStr = "00";
            	  		if (tmpSeq.length == 2)
                			tmpStr = "0";
           		  	var text = tmpStr + tmpSeq + " &nbsp;" + data[i].channelName;
				 	
				  area1.doms[t].updatecontent(text);
				  area1.doms[t].mylink="sim_playbacklist.jsp?channelId="+data[i].channelId +"&returnurl="+escape(location.href);
				 
			 }
			 else
			     area1.doms[t].updatecontent("");
		 }
		 document.getElementById('page').innerHTML = area1.curpage+"/"+pageCount;
		 area1.lockin=false;
	 }


    function initPage()
	{
		var area0=AreaCreator(1,5,new Array(-1,-1,1,-1),"area0_title_","className:simtitle on","className:simtitle");
	   area0.setstaystyle("className:simtitle current",3);
	   area0.setfocuscircle(1);
	   area0.doms[0].mylink = "sim_index.jsp";
	   area0.doms[4].mylink = "../../defaultsdcctv/en/page/sim_index.jsp";
	   area0.doms[1].mylink = "test/test_topic.jsp";
	   area0.doms[3].mylink = "test/test_index.jsp";  
	   
        area1 = AreaCreator(11, 2, new Array(0,-1, 2, -1), "channel", "className:sub on", "className:sub");
		area1.setpageturnattention("pageup","images/up.png","images/up_gray.png","pagedown","images/down.png","images/down_gray.png");

	  area2 = AreaCreator(1,2,new Array(1,-1,-1,-1),"turnpage_","className:testturnpage on","className:testturnpage");
	
		
		if(focusObj!=undefined&&focusObj!="null")
		{
				areaid = parseInt(focusObj[0].areaid);
				indexid = parseInt(focusObj[0].curindex);
				area1.curpage = parseInt(focusObj[0].curpage);
		}
		
		
area2.doms[0].domOkEvent=function(){
	if((parseInt(area1.curpage)-1)<=0) 
		return;
	area1.pageturn(-1);	
	list=getItmsByPage(totallist,area1.curpage,pagesize);
       
	getdata(list,4);//4Ϊ��ҳ��
};
		  
area2.doms[1].domOkEvent=function(){
       	if((parseInt(area1.curpage)+1)>area1.pagecount) return;
		area1.pageturn(1);
	list=getItmsByPage(totallist,area1.curpage,pagesize);
	getdata(list,4);
};



		pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):4, new Array(area0, area1,area2));
		setDarkFocus();
		pageobj.goBackEvent = function()
		{
			location.href="index.jsp";
			//this.changefocus(0,4);
		}
//		area1.setcrossturnpage();
//		area1.setfocuscircle(0);
		
		area1.asyngetdata=function()
		{
			 area1.lockin=true;
			 //getAJAXData("playbackpagingdata.jsp?pageIndex="+area1.curpage,getdata)
			 var list=new Array();
			 var start = (this.curpage-1)*22;
			 var size = (totalRecord-start)>=22?22:(totalRecord-start);
			 for(i=0;i<size;i++)
	         	{
	            		list[i]=jsChannelList[start+i];
	         	}
			 getdata(list,pageCount);
			 //$('hidden_frame').src="playbackpagingdata.jsp?pageIndex="+area1.curpage;
		}
		area1.areaOkEvent = function()
		{
			saveFocstr(pageobj);
			//alert(document.cookie);
		}
		area1.asyngetdata();
        
		document.getElementById("scrollText").innerHTML = "<marquee scrollamount='4'>"+scrollText + "</marquee>";
		//refreshServerTime();
		//setInterval("refreshServerTime()",60000);
		

    }
	   
</script>







</head>

<body onLoad="initPage();">
<div class="main">
	
	
	<div class="simtitle"> 
	<div class="simtitle" id="area0_title_0" style="left:-120px;"><img src="images/simtitle_1.png" /></div>
	<div class="simtitle" id="area0_title_1" style="left:70px;"><img src="images/simtitle_2.png" /></div>
       	<div class="simtitle" id="area0_title_2" style="left:260px;"><img src="images/simtitle_3.png" /></div>
	<div class="simtitle" id="area0_title_3" style="left:450px;"><img src="images/simtitle_4.png" /></div>
	<div class="simtitle" id="area0_title_4" style="left:650px;"><img src="images/simtitle_5.png" /></div>
</div>

	
	
	<!--mid-->	
	<div class="channel_sub" style="top:120px"> 
		<div class="sub" id="channel0"></div><!--class="on"-->
		<div class="sub" id="channel2"></div>
		<div class="sub" id="channel4"></div>
		<div class="sub" id="channel6"></div>
		<div class="sub" id="channel8"></div>
		<div class="sub" id="channel10"></div>
		<div class="sub" id="channel12"></div>
		<div class="sub" id="channel14"></div>
		<div class="sub" id="channel16"></div>
		<div class="sub" id="channel18"></div>
        	<div class="sub" id="channel20"></div>
	</div>

	
	
	<!--r-->
	<div class="channel_sub2">
		<div class="sub" id="channel1"></div><!--class="on"-->
		<div class="sub" id="channel3"></div>
		<div class="sub" id="channel5"></div>
		<div class="sub" id="channel7"></div>
		<div class="sub" id="channel9"></div>
		<div class="sub" id="channel11"></div>
		<div class="sub" id="channel13"></div>
		<div class="sub" id="channel15"></div>
		<div class="sub" id="channel17"></div>
		<div class="sub" id="channel19"></div>
		<div class="sub" id="channel21"></div>
    </div>
    <div class="channel_up2" style="left:600px"><img src="images/up.png"  id="pageup"/></div>
    <div class="channel_down2" style="left:600px"><img src="images/down.png" id="pagedown" /></div>
  
    <div class="pages2" style="top:665px;left:600px" id="page"></div>
  
	
	
	 <!--bottom_notice-->
	<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>
    <iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="0" height="0" ></iframe>
  
 	<div class="testturnpage">
	     <div class="testturnpage" id = "turnpage_0" style = "left:457px;top:665px"><img src = test/images/test_last_page.png></div>
	     <div class="testturnpage" id = "turnpage_1" style = "left:672px;top:665px"><img src = test/images/test_next_page.png></div>
	</div>
			 

</div>
<!--初始化加载图片-->
    <div style="visibility:hidden; z-index:-1">
    <!--首页左边导航暗焦点--> 
    <img src="images/menu_bgon.png"/>
    <img src="images/menu_bgfocuson.png"/>
    </div>

</body>
<%@ include file="servertimehelp.jsp"%>
</html>
