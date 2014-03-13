<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../../../../config/properties.jsp"%>
<%
	String channelListFile="../../../../" + datajspname  + "/channelList.jsp";
	String channelProgrameFile="../../../../" + datajspname  + "/channelPrevue.jsp";

	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>直播OSD频道选择_央视高清EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<style>
<!--
body{ background:#000 url(images/temp/bg.jpg) no-repeat}
-->
</style>

<%@ include file="../../../../util/channelDateUtil.jsp"%>
<%@include file="../../../../config/code.jsp"%>
<!--<script type="text/javascript" src="../../../js/pagecontrol_1.0.4.js"></script>-->
<script type="text/javascript" src="../../../js/savefocus.js"></script>
<script type="text/javascript">

         //将频道列表全部取出来
		<jsp:include page="<%=channelListFile%>">        
				<jsp:param name="categoryCode" value="<%=channelListCode%>"/> 
				<jsp:param name="varName" value="channelList"/>
				<jsp:param name="fields" value="-1" /> 
				<jsp:param name="pageIndex" value="1" /> 
				<jsp:param name="pageSize" value="-1" />
				<jsp:param name="isBug" value="1" />
		</jsp:include>	
      
      

	   <jsp:include page="<%=channelProgrameFile%>">
				<jsp:param name="channelId" value="3177"/> 
				<jsp:param name="varName" value="channelProgrameList"/>
				<jsp:param name="curdate" value="<%=strDate%>"/>
				<jsp:param name="fields" value="-1" /> 
				<jsp:param name="isBug" value="1" />
		</jsp:include>	



</script>


<script type="text/javascript">

	document.onkeypress = keyEvent;
	//document.onkeydown = keyEvent;
	function keyEvent()
	{
			alert("====================1=1111============");
		var val = event.which ? event.which : event.keyCode;
				alert("====================1=val============"+val);
		return keypress(val);
	}

	function keypress(keyval)
	{
		alert("====================1=============");
		
	}


var area0,area1;
var  channelId=parent.channelId;

/*var  channelId=parent.channelId;
var indexid=parent.indexid;
var curpage=parent.curpage;
var channelName=parent.channelName;
var channelNum=parent.channelNum;

alert("==channelId="+channelId+"===indexid="+indexid+"==curpage="+curpage);
*/

window.onload=function()
{
	 area0=AreaCreator(10, 1, new Array( - 1, -1, -1,  -1), "area0_list_", "className:sub on", "className:sub");
	//. area0.curpage=curpage;
	// area0.pagecount =Math.ceil((channelList.channelDataList.length/10));	
	// area0.endwiseCrossturnpage = true;  
	/* area0.areaPageTurnEvent = function(num)
	 {
	     binChannelListData(getChannelListValue(area0.curpage),area0.curpage);
		 
	 };*/
	 pageobj = new PageObj(0, 2, new Array(area0));
	 alert(pageobj+"=============");
	 //pageobj.backurl = "../../index/index.jsp";
	// pageInit();
 
}

/*    function pageInit()
	{
		//绑定频道列表
	     binChannelListData(getChannelListValue(curpage),curpage);	
		//绑定节目
		 bindChannelProgrames();
		//5秒后隐藏节目单
		 setTimeout(hiddenProgrames,3000);

	} 
	
	//隐藏绑定节目
	function hiddenProgrames()
	{
		$("channel_msg").style.visibility="hidden";
	}


    
	//对频道列表进行分页处理
	function getChannelListValue(currentPage)
	{
		var length=channelList.channelDataList.length;
		var start = (currentPage-1)*10;
		var end = (start+10);
		if(end>=length)
		{
			end=length;  
		}
		var temptestList=new Array();
		for(var i=start;i<end;i++)
		{
			temptestList.push(channelList.channelDataList[i]);
		}
		return temptestList;
	}
	   
	//绑定频道列表
	function binChannelListData(datavalue,currentPage)
	{ 
	    var initNum="000";

		area0.datanum=datavalue.length;
		area0.setendwisepageturndata(area0.datanum,area0.pagecount);

		for(i=0;i<10;i++)
		{
			$("area0_list_"+i).innerHTML="";
		}
		
		for(var j = 0; j< datavalue.length; j++) 
		{
			
			if(datavalue[j] != null)
			{	
				var contentNum=initNum+eval((currentPage-1)*10+1+j);
		        var num=contentNum.substr(contentNum.length-3,3);
				$("area0_list_"+j).innerHTML=num+"   "+datavalue[j].channelName;		
			}
		}
					
    }
	//绑定节目列表
	function bindChannelProgrames()
	{
		$("title").innerHTML=channelName;
		$("curprograme").innerHTML=channelProgrameList[0].tvodProgramName;
		for(var i=0;i<4;i++)
		{
			$("area1_time_"+i).innerHTML=channelProgrameList[i+1].startTime.substr(0,5)+"-"+channelProgrameList[i+1].endTime.substr(0,5);
			$("area1_list_"+i).innerHTML=channelProgrameList[i+1].tvodProgramName;
		}
	}
	
	
	*/
	

</script>

</head>

<body>
<div class="main">
	
	<!--channel_msg-->
	<div class="channel_choose" style="visibility:visible">
		<div align="center"><img src="images/up.png" /></div>
		<div id="area0_list_0" class="sub">012   &nbsp;CCTV-12</div><!--class="on"-->
		<div><img src="images/menu_line.png" /></div>
		<div id="area0_list_1" class="sub">013   &nbsp;CCTV-13</div>
		<div><img src="images/menu_line.png" /></div>
		<div id="area0_list_2" class="sub">013   &nbsp;CCTV-13</div>
		<div><img src="images/menu_line.png" /></div>
		<div id="area0_list_3" class="sub">013   &nbsp;CCTV-13</div>
		<div><img src="images/menu_line.png" /></div>
		<div id="area0_list_4" class="sub">016   &nbsp;CCTV-NEWS</div>
		<div><img src="images/menu_line.png" /></div>
		<div id="area0_list_5" class="sub">017   &nbsp;北京卫视</div>
		<div><img src="images/menu_line.png" /></div>
		<div id="area0_list_6" class="sub">018   &nbsp;上海卫视</div>
		<div><img src="images/menu_line.png" /></div>
		<div id="area0_list_7" class="sub">014   &nbsp;CCTV-14</div>
		<div><img src="images/menu_line.png" /></div>
		<div id="area0_list_8" class="sub">015   &nbsp;CCTV-15</div>
		<div><img src="images/menu_line.png" /></div>
		<div id="area0_list_9" class="sub">019   &nbsp;湖南卫视</div>

		<div><img src="images/menu_line.png" /></div>

		<div align="center"><img src="images/down.png" /></div>
	</div>
  
  
  
  <!--channel_msg-->
	<div id="channel_msg" class="channel_msg" style="visibility:visible">
		<div class="title" id="title">CCTV-9</div>
		<div class="mar">当前节目：</div>
		<div><img src="images/menu_line.png" /></div>
		<div class="mar" id="curprograme">战争纪实</div>
		<div><img src="images/menu_line.png" /></div>
		<div class="mar" >节目单：</div>
		<div><img src="images/menu_line.png" /></div>
		<div class="mar" id="area1_time_0">11:00-11:30</div>
		<div><img src="images/menu_line.png" /></div>
		<div class="mar"  id="area1_list_0">面条之路 6</div>
		<div><img src="images/menu_line.png" /></div>
		<div class="mar"  id="area1_time_1">11:30-12:00</div>
		<div><img src="images/menu_line.png" /></div>
		<div class="mar"  id="area1_list_1">面条支路 7</div>
		<div><img src="images/menu_line.png" /></div>
		<div class="mar" id="area1_time_2">12:00-12:50</div>
		<div><img src="images/menu_line.png" /></div>
		<div class="mar" id="area1_list_2">当紫禁城遇上卢浮宫</div>
		<div><img src="images/menu_line.png" /></div>
		<div class="mar" id="area1_time_3">12:50-13:30</div>
		<div><img src="images/menu_line.png" /></div>
		<div class="mar" id="area1_list_3">大唐西行记</div>		
  </div>
	
</div>
</body>


</html>
