<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ include file="util/save_focus.jsp"%>
<%@ include file="datajsp/sim_playbackpagingData.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>

<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>测试节目单</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />


<script language="javascript" type="text/javascript" src="js/pagecontrol.js"></script>
<script language="javascript" type="text/javascript">
	var channelId = '<%=request.getParameter("channelId")%>';
	var returnurl = '<%=request.getParameter("returnurl")%>';
	var currFocusChannelIndex ;
	var area0;
	var area1;
	var area2;
	var timeIndex = 0;
	var lastDateTimeIndex = 0;
	var lastChannelId = channelId;
	var isFirstLoad = true;
	var curPageIndex=1;
	var areaid;
	var indexid;
	var firstChannelId = 0;
	var AjaxReturn = -1;

function getChannelData(data,count)
{
	 area0.setpageturndata(data.length,parseInt(count));
	 for (var i = 0; i < area0.doms.length; i++) 
	 {
		  if (i >=data.length) 
		  {
			  area0.doms[i].updatecontent("");
          }
		  else
		  {
 
		 	 var tmpSeq = "" + (data[i].channelNumber-1000);
		 	 var tmpStr = "";
         	 if (tmpSeq.length == 1)
               tmpStr = "00";
          	if (tmpSeq.length == 2)
               tmpStr = "0";
        	  var text = tmpStr + (data[i].channelNumber-1000) + " &nbsp;" + data[i].channelName;
         	 area0.doms[i].setcontent("",text,22,true);
		 area0.doms[i].dataurlorparam=data[i].channelId;			 
		 area0.doms[i].channelnum=data[i].channelNumber-1000;
		  }
       }
	   if(focusObj!=undefined&&focusObj!="null")
	   {
		  
		   var url = "datajsp/sim_playbacklistdata.jsp?channelId="+area0.doms[focusObj[1].curindex].dataurlorparam + "&currarea=0";
		   getAJAXData(url,getDateData);

	   }
	   
}

function rerverseDate(data)
{
	var dateList = new Array();
	for(var i = data.length - 1; i >= 0; i --)
	{
		dateList.push(data[i]);
	}
	return dateList;
}


function getDateData(data)
{
	data=eval('('+data+')');
	
	rerverseDate(data);	
	area1.datanum = data.length;

	for (var j = 0; j < area1.doms.length; j++)
	{
		
   		if (j >= data.length) 
		{
			area1.doms[j].updatecontent("");
    	}
		else
		{
			area1.doms[j].updatecontent(data[j].dateChinese.substring(5,data[j].dateChinese.length));
			area1.doms[j].dataurlorparam=data[j].date24;
			
		}
    }
	
    if(isFirstLoad &&data.length != 0 )
    {
		var tmpDate = data[0].date24;
		if(focusObj!=undefined&&focusObj!="null" &&focusObj.length >2)
		{
			tmpDate = area1.doms[focusObj[2].curindex].dataurlorparam;
			area2.curpage = focusObj[0].curpage;
				
		}
		
		AjaxReturn = 0;
		var url = "datajsp/sim_playbacklistdata.jsp?channelId="+area0.doms[area0.curindex].dataurlorparam + "&currarea=1&pageIndex="+area2.curpage+"&beforedate="+tmpDate;
		getAJAXData(url,getProgramData);
		if (AjaxReturn == 0) //AjaxReturn ==0)
		{
		    	clearProgramList();
			var textr = "暂无内容";
			area2.doms[0].setcontent("", textr, 30);
		}
		AjaxReturn = -1;
    	isFirstLoad = false;
    }

}

function getProgramData(result)
{
	AjaxReturn = 1;	
	var re;
	if(result.substring(0,1)!='{')
	   return;
	re=eval('('+result+')');
    var data=re.data;
    var pageCount=re.count;
	data.length;
	area2.setpageturndata(data.length,pageCount);
	   for (var k = 0; k < area2.doms.length; k++) 
	   {
			
            if (k < data.length) 
			{
				 
				 var hour = data[k].STARTTIME.substring(8,10);
				var minitue = data[k].STARTTIME.substring(10,12);
				var text = hour+":"+minitue + " " + data[k].PROGNAME;//获取回放节目列表
				area2.doms[k].setcontent("",text,33);
				var	url = "au_PlayFilm.jsp?PROGID=" + data[k].PROGRAMID+ "&PLAYTYPE=4&CONTENTTYPE=300&&BUSINESSTYPE=5&PROGSTARTTIME=" + data[k].STARTTIME + "&PROGENDTIME=" + data[k].ENDTIME+"&ISSUB=1&PREVIEWFLAG=1&TVOD=1&CHANNELID="+area0.doms[area0.curindex].dataurlorparam+"&LOGICCHANNELID="+area0.doms[area0.curindex].channelnum;

				area2.doms[k].tempurl = url;  
            }
            else
			{
				area2.doms[k].updatecontent("");
			}
			
			
       }
}

function clearProgramList()
{
	  for (var k = 0; k < area2.doms.length; k++) 
	 {
	 	area2.doms[k].updatecontent("");
	 }
}

			
    function initPage()
	 {
        area0 = AreaCreator(9, 1, new Array(-1, -1, -1, 1), "channel", "className:menuli on", "className:menuli");
        area0.setstaystyle("className:menuli current", 3);
		area0.setfocuscircle(0);
       	area1 = AreaCreator(7, 1, new Array(-1, 0, -1, 2), "date", "className:d_li on", "className:d_li");
	    area1.setstaystyle("className:d_li current", 3);
	    area1.asyngetdata = function(id)
	    {
	    	lastChannelId = channelId;
		getAJAXData("datajsp/sim_playbacklistdata.jsp?channelId="+id + "&currarea=0",getDateData);	   
	    }
		area0.asyngetdata=function()
		 {
		         area0.changefocusingEvent();  //zte
                         var list=new Array();
			 var start = (this.curpage-1)*9;
			 var size = (totalChannelList.length-start)>=9?9:(totalChannelList.length-start);
			 for(i=0;i<size;i++)
	         {
	            list[i]=totalChannelList[start+i];
	         }
             getChannelData(list,pagecount);
		 }
		 area0.setcrossturnpage();
	    area0.changefocusingEvent=function()
	   {
	   		 area2.curpage = 1;
			isFirstLoad = true;
			
	   }
	   area1.changefocusingEvent=function()
	   {
	   		if(lastDateTimeIndex != area1.curindex)
	   			area2.curpage = 1;
	   		lastDateTimeIndex = area1.curindex;
		
	   }
        area2 = AreaCreator(11, 1, new Array(-1, 1, -1, -1), "p", "className:p_li on", "className:p_li");
		
		area2.setcrossturnpage();
		area2.setfocuscircle(0);
		area2.setpageturnattention("pageup","images/up.png","images/up_gray.png","pagedown","images/down.png","images/down_gray.png");
		var t;
		area2.asyngetdata=function(date)
		{
			if(date == undefined)
				date = area1.doms[area1.curindex].dataurlorparam;
			AjaxReturn = 0;
			var str_Date =  (parseInt(date) - 6) + " ";
			var url = "datajsp/sim_playbacklistdata.jsp?channelId="+area0.doms[area0.curindex].dataurlorparam + "&currarea=1&pageIndex="+area2.curpage+"&currdate="+str_Date+"&beforedate="+date;
			getAJAXData(url,getProgramData);
			if (AjaxReturn == 0) //AjaxReturn ==0)
			{
			    	clearProgramList();
				var textr = "暂无内容";
				area2.doms[0].setcontent("", textr, 30);
			}
			AjaxReturn = -1;
		}
		
		area2.areaOkEvent = function(){
/*			saveFocstr(pageobj);
	 		area2.doms[area2.curindex].tempurl +="&returnurl="+escape("sim_playbacklist.jsp?channelId="+area0.doms[area0.curindex].dataurlorparam+'<%=request.getParameter("returnurl")==null?"":"&returnurl="+request.getParameter("returnurl") %>');
			location.href = area2.doms[area2.curindex].tempurl;
*/
		break;
		}

		
		area0.dataarea=area1;
		area1.dataarea=area2;
		
		 if(focusObj!=undefined&&focusObj!="null")
		{
			 areaid = parseInt(focusObj[0].areaid);
			 indexid = parseInt(focusObj[0].curindex);
			 area2.curpage = parseInt(focusObj[0].curpage);
			 area0.curpage = parseInt(focusObj[1].curpage);
		}

		
		pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):currFocusChannelIndex, new Array(area0, area1, area2));
		setDarkFocus();
		getChannelData(jsChannelList,pagecount);
		pageobj.backurl = returnurl;
		document.getElementById("scrollText").innerHTML = "<marquee scrollamount='4'>"+scrollText+"</marquee>";
		area0.curpage=curPageIndex;
    }
</script>


</head>

<body onLoad="initPage();">
<div class="main">
	
	<!--logo-->
	<div class="logo">节目单</div>
	<div class="date" id="currDate"></div>
	
	
	
	<!--menu-->
  <div class="menu3"><!--焦点为 class="menuli on"  当前选中为 class="menuli current"-->
		<div><img src="images/menu_line.png" /></div>
	<div class="menuli"><div id="channel0" style="width:320px"></div></div> 
		<div><img src="images/menu_line.png" /></div>
	<div class="menuli " ><div id="channel1" style="width:320px"></div></div> 
		<div><img src="images/menu_line.png" /></div>
	<div class="menuli" ><div id="channel2" style="width:320px"></div></div> 
		<div><img src="images/menu_line.png" /></div>
	<div class="menuli"><div id="channel3" style="width:320px"></div></div> 
		<div><img src="images/menu_line.png" /></div>
	<div class="menuli"><div id="channel4" style="width:320px"></div></div> 
		<div><img src="images/menu_line.png" /></div>
	<div class="menuli"><div id="channel5" style="width:320px"></div></div> 
		<div><img src="images/menu_line.png" /></div>
	<div class="menuli"><div id="channel6" style="width:320px"></div></div> 
		<div><img src="images/menu_line.png" /></div>
	<div class="menuli"><div id="channel7" style="width:320px"></div></div> 
		<div><img src="images/menu_line.png" /></div>
	<div class="menuli"><div id="channel8" style="width:320px"></div></div> 
		<div><img src="images/menu_line.png" /></div>
	</div>
	
	
	
	<!--mid-->		
	<div class="playback_date"><!--焦点为 class="d_li on"  当前选中为 class="d_li current"-->
		<div align="center"><img src="images/up.png" /></div>
		<div class="d_li" id="date0"></div>
		<div class="d_li" id="date1"></div>
		<div class="d_li" id="date2"></div>
		<div class="d_li" id="date3"></div>
		<div class="d_li" id="date4"></div>
		<div class="d_li" id="date5"></div>
		<div class="d_li" id="date6"></div>
		<div align="center"><img src="images/down.png" /></div>
	</div>

	
	
	<!--r-->
<div class="channel_list wid2" style=" left:555px;">
		<div>节目列表</div>
		<div><img src="images/line4.png" width="630" /></div>
		<div class="p_li" id="p0"></div>
		<div class="p_li" id="p1"></div>
		<div class="p_li" id="p2"></div>
		<div class="p_li" id="p3"></div>
		<div class="p_li" id="p4"></div>
		<div class="p_li" id="p5"></div>
		<div class="p_li" id="p6"></div>
		<div class="p_li" id="p7"></div>
		<div class="p_li" id="p8"></div>
		<div class="p_li" id="p9"></div>
		<div class="p_li" id="p10"></div>
  </div>
<div class="channel_up"><img  id="pageup"/></div>
  <div class="channel_down"><img id="pagedown" /></div>

	 <!--bottom_notice-->
	<div class="notice"><marquee loop="<%=reTime%>" scrolldelay="<%=speed%>" id="ad_text"><%=rollName%></marquee></div>
     <iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="0" height="0" ></iframe>
     <iframe name="hidden_frame_channel" id="hidden_frame_channel" style=" display:none" width="0" height="0" ></iframe>
    

</div>
   <div style="visibility:hidden; z-index:-1">
    <!--首页左边导航暗焦点--> 
    <img src="images/menu_bgon2.png"/>
    <img src="images/menu_bgfocuson2.png"/>
     <img src="images/sub_bg2on.png"/>
    <img src="images/sub_bg2focuson.png"/>
    
    </div>
</body>
<%@ include file="servertimehelp.jsp"%>
</html>
