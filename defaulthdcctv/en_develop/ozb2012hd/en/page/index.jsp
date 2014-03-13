<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>央视欧洲杯高清3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<%@ include file="config/config_TrailerInVas.jsp"%>
<%@ include file="util/save_focus.jsp"%>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<%@ include file="datajsp/index_data.jsp"%>
<script src="../js/pagecontrolx.js" type="text/javascript"></script>
<script type="text/javascript" language="javascript">
var area0,area1,area2,area3,area4;
window.onload=function(){
	  
		 //导航栏
		 if(hotlen>0){
		   area0=AreaCreator(1,6,new Array(-1,-1,2,-1),"area0_list_","afocus","ablur");		   
		   area0.stablemoveindex=new Array(-1,-1,"0-1>0,1-0,2-1,3-2,4-3,5-4",-1);
		  }else{
			  area0=AreaCreator(1,6,new Array(-1,-1,1,-1),"area0_list_","afocus","ablur");
			  area0.stablemoveindex=new Array(-1,-1,"0-1>0,1-1>0,2-1>0,3-1>0,4-1>0,5-1>0",-1);
		  }
		  area0.setfocuscircle(1);
		  area0.setstaystyle("className:",2);

		//左推荐
		area1=AreaCreator(3,1,new Array(0,3,-1,3),"area1_list_","afocus","ablur");
		area1.setstaystyle("className:",3);
		area1.stablemoveindex=new Array(-1,-1,-1,"2-4>0");
		for(var i=0,l=area1.doms.length;i<l;i++){
			area1.doms[i].imgdom = $('area1_img_'+i);
		}
		//editing by ty 2012年5月31日 14:21:07
		//1.修改左侧推荐栏目为增值业务形式,使用ajax获取到增值业务的url
		area1.areaOkEvent = function(){			
			saveFocstr(pageobj);
			//getAJAXData("datajsp/get_vasurl.jsp?vasid="+area1.doms[area1.curindex].youwanauseobj,turnUrl);
		};
		
		//搜索热词
		area2=AreaCreator(1,5,new Array(0,1,3,-1),"area2_list_","afocus","ablur");
		area2.stablemoveindex=new Array("0-0>2,1-0>2,2-0>3,3-0>3,4-0>4",-1,-1,-1);
		area2.areaOkEvent = function(){saveFocstr(pageobj);};
		/*for(var i=0,l=area2.doms.length;i<l;i++){
			area2.doms[i].contentdom = $('area2_content_'+i);
			area2.doms[i].borderdom = new Array($('area2_div_'+i),$('area2_img_'+i));
		}*/
		
		//--area3 S 播放窗口
		if(hotlen>0){
			area3=AreaCreator(1,1,new Array(2,1,4,-1),"area3_list_","afocus","ablur");
		}
		else{
			area3=AreaCreator(1,1,new Array(0,1,4,-1),"area3_list_","afocus","ablur");
		}
		
		area3.areaOkEvent = function(){saveFocstr(pageobj);};
		
		//精彩回看
		area4=AreaCreator(3,1,new Array(3,1,-1,-1),"area4_list_","afocus","ablur");
		area4.stablemoveindex=new Array(-1,"0-2",-1,-1);
		for(var i=0,l=area4.doms.length;i<l;i++){area4.doms[i].contentdom =$('area4_content_'+i);}
		area4.areaOkEvent = function(){saveFocstr(pageobj);};
		
		if(focusObj!=undefined&&focusObj!="null"){
			areaid = parseInt(focusObj[0].areaid);
			indexid = parseInt(focusObj[0].curindex);
		}
		//--特殊处理
		bindArea2Doms(jHotkeywords);
		
		pageobj = new PageObj(new Array(area0,area1,area2,area3,area4));
		pageobj.backurl = "../../../index.jsp";
		refreshServerTime();//时间填充
		//--init pageobj S
		//--BindData S
		bindNavigatData();
		bindRecommendData(jRecommends);
		bindHotKeyWordsData(jHotkeywords);
		bindBesttvodData(jBesttvod);
		//alert(jRecommends[0]);
		setTimeout(load_iframe,500);
		//alert(window.location.href);
		pageobj.pageSetMuteFlagEvent=setMuteFlag;
		setTimeout(isMute,1000);
}

//common function S
//editing by ty 2012年5月31日 14:22:41
//1.执行完ajax后执行的跳转方法
	function turnUrl(url){
		if(url!=undefined&&url!="null"){
			url += ((url.indexOf("?")==-1)?"?":"&")+"returnurl="+escape(location.href);
			location.href = url;
		}
	}
//common funciton E
function isMute()
{
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1)
	{
		document.getElementById("voice").src="../../../images/playcontrol/playChannel/muteon.png";
    }
}

function setMuteFlag()
{
	hideVoice();
	clearTimeout(voiceTimer);
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1)
	{
		mp.setMuteFlag(0);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
		{
			document.getElementById("voice").src="../../../images/playcontrol/playChannel/muteoff.png";
			voiceTimer = setTimeout(hideVoice, 5000);
		}
	}
	else
	{
		mp.setMuteFlag(1);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
		{
			document.getElementById("voice").src="../../../images/playcontrol/playChannel/muteon.png";
		}
	}      
}
function hideVoice()
{
	document.getElementById("voice").src="../../../images/dot.gif";
}
</script>
<style type="text/css">
<!--
	body{ background:url(../images/bg-index.gif) no-repeat;}

-->
</style>
</head>

<body style="background-color:transparent;">

<!--head-->
	<div class="date"  id="currDate"></div>
	
	<!--menu-->
	<div class="menu"> <!--当前选中为 class="item wid* item-select"；2字宽为wid1;3字宽为wid2,4字宽为wid3--> 
		<div class="item wid1 item-select">
			<div class="link"><a href="#" id="area0_list_0"><img src="../images/t.gif" /></a></div>
            <div class="txt">欧洲杯</div>
		</div>               
		<div class="item wid3" style="left:128px;">
			<div class="link"><a href="#" id="area0_list_1"><img src="../images/t.gif" /></a></div>
            <div class="txt">赛事点播</div>
		</div>
		<div class="item wid3" style="left:346px;">
			<div class="link"><a href="#" id="area0_list_2"><img src="../images/t.gif" /></a></div>
            <div class="txt">精彩视频</div>
		</div>
		<div class="item wid3" style="left:564px;">
			<div class="link"><a href="#" id="area0_list_3"><img src="../images/t.gif" /></a></div>
            <div class="txt">球星殿堂</div>	
		</div>
		<div class="item wid2" style="left:782px;">
			<div class="link"><a href="#" id="area0_list_4"><img src="../images/t.gif" /></a></div>
            <div class="txt">射手榜</div>	
		</div>
		<div class="item wid1" style="left:952px;">
			<div class="link"><a href="#" id="area0_list_5"><img src="../images/t.gif" /></a></div>
            <div class="txt">搜索</div>
		</div>
	</div>
<!--the end-->



<!--推荐位-->
<div class="index-pic"> 
	<div class="item">
		<div class="link"><a href="#" id="area1_list_0"><img src="../images/t.gif" /></a></div>
     	<div class="pic"><img id="area1_img_0" src=""/></div>
	</div>
	<div class="item" style="top:198px;">
		<div class="link"><a href="#" id="area1_list_1"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area1_img_1" src="" /></div>
	</div>
	<div class="item" style="top:396px;">
		<div class="link"><a href="#" id="area1_list_2"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area1_img_2" src="" /></div>
	</div>
</div>	
<!--the end-->


        
<!--关键词-->
<div class="keyword" id="hotwordarea">
<%
	//editing by ty 2012年6月1日 10:29:12
	//1.央视建立为栏目的方式，所以将取值中get("VODNAME")变为get("TYPE_NAME")
	if(hotkey_resultlist!=null){
		for(int i = 0,l = hotkey_resultlist.size();i<l;i++){
%>
		<div style="float:left; padding-left:10px;">
        	<div class="link" id="area2_border_<%=i%>" style="margin-top:2px;">
			  <a href="#" id="area2_list_<%=i%>"><img style="height:34px;" id="area2_img_<%=i%>" src="../images/t.gif" /></a>
		    </div>
            <div id="area2_content_<%=i%>" style="font-size:30px; margin-top:5px;"><%=((HashMap)hotkey_resultlist.get(i)).get("TYPE_NAME").toString().trim()%></div>
        </div>
<%
		}
	}
%>
</div>
<!--the end-->



<!--播放区-->
<div class="index-video">  
	<div class="item">	
		<div class="link"><a href="#" id="area3_list_0"><img src="../images/t.gif" /></a></div>
		<div class="pic"><!--<img src="../images/temp/video-651X490.jpg" />-->
			<iframe id="playPage" name="playPage" src="" border="0" frameSpacing="0" marginWidth="0" marginHeight="0" frameBorder="0" noResize scrolling="no" vspace="0" width="761" height="377" style="background:transparent;"></iframe>
		</div>		
	</div>
</div>
<!--the end-->


	
<!--精彩回看-->
<div class="index-look-back">  
	<div class="item">
		<div class="link"><a href="#" id="area4_list_0"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area4_content_0"></div>
	</div>
	<div class="item" style="top:38px;">
		<div class="link"><a href="#" id="area4_list_1"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area4_content_1"></div>
	</div>
	<div class="item" style="top:76px;">
		<div class="link"><a href="#" id="area4_list_2"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area4_content_2"></div>
	</div>
</div>
<!--the end-->	


<div style="position:absolute; left:1170px; top:175px; width:54px; height:66px; z-index:3;"><img id="voice" src="../../../images/dot.gif"/></div>	
	
<!--滚动字幕-->
<div class="notice">
	<div class="txt" style="width:702px"><marquee width="700px" scrollamount="4"><%=introduce %></marquee></div>
</div>
<!--the end-->	
<div style="display:none" id="hotlen"></div>		
<%@ include file="servertimehelp.jsp"%>
</body>
</html>
