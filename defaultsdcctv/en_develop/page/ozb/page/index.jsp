<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>央视欧洲杯 标清EPG 2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/content.css" />
<%@ include file="config/config_TrailerInVas.jsp"%>
<%@ include file="util/save_focus.jsp"%>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<%@ include file="util/util_AdText.jsp"%>
<%@ include file="datajsp/index_data.jsp"%>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
	//--common var S
	var areaid=0,indexid=0;
	var area0,area1,area2,area3,area4;
	//--common var E
	
	window.onload=function(){
		setEPG();
		//--area0 S 上部导航栏
		if(hotlen>0){
		   area0=AreaCreator(1,6,new Array(-1,-1,2,-1),"area0_list_","afocus","ablur");		   
		   area0.stablemoveindex=new Array(-1,-1,"0-1>0,1-0,2-1,3-2,4-3,5-4",-1);
		}else {
		   area0=AreaCreator(1,6,new Array(-1,-1,1,-1),"area0_list_","afocus","ablur");
		   area0.stablemoveindex=new Array(-1,-1,"0-1>0,1-1>0,2-1>0,3-1>0,4-1>0,5-1>0",-1);
		}
		 area0.setfocuscircle(1);
		 area0.setstaystyle("className:",2);
		//--area0 E
		
		//--area1 S 左推荐
		area1=AreaCreator(3,1,new Array(0,3,-1,3),"area1_list_","afocus","ablur");
		area1.setstaystyle("className:",3);
		area1.stablemoveindex=new Array(-1,-1,-1,"2-4>0");
		for(var i=0,l=area1.doms.length;i<l;i++){
			area1.doms[i].imgdom = $('area1_img_'+i);
		}
		area1.areaOkEvent = function(){
			saveFocstr(pageobj);				
//getAJAXData("datajsp/get_vasurl.jsp?vasid="+area1.doms[area1.curindex].youwanauseobj,turnUrl);
		};
		//--area1 E
		
		//--area2 S 搜索热词
		area2=AreaCreator(1,jHotkeywords.length,new Array(0,1,3,-1),"area2_list_","afocus","ablur");
		area2.stablemoveindex=new Array("0-0>2,1-0>2,2-0>3,3-0>3,4-0>4",-1,-1,-1);
		area2.areaOkEvent = function(){saveFocstr(pageobj);};
		//for(var i=0,l=area2.doms.length;i<l;i++){area2.doms[i].contentdom =$('area2_content_'+i);}
		 
		//--area2 E
		
		//--area3 S 播放窗口
		if(hotlen>0){
			area3=AreaCreator(1,1,new Array(2,1,4,-1),"area3_list_","afocus","ablur");
		}
		else{
			area3=AreaCreator(1,1,new Array(0,1,4,-1),"area3_list_","afocus","ablur");
		}
		area3.areaOkEvent = function(){saveFocstr(pageobj);};
		//--area3 E
		
		//--area4 S 精彩回看
		area4=AreaCreator(3,1,new Array(3,1,-1,-1),"area4_list_","afocus","ablur");
		area4.stablemoveindex=new Array(-1,"0-2",-1,-1);
		for(var i=0,l=area4.doms.length;i<l;i++){area4.doms[i].contentdom =$('area4_content_'+i);}
		area4.areaOkEvent = function(){saveFocstr(pageobj);};
		//--area4 E
		
		//--Set focus S
		if(focusObj!=undefined&&focusObj!="null"){
			areaid = parseInt(focusObj[0].areaid);
			indexid = parseInt(focusObj[0].curindex);
		}
		//--Set focus E
		
		//--特殊处理
		bindArea2Doms(jHotkeywords);
		//--
		
		//--init pageobj S
		pageobj = new PageObj(areaid,indexid,new Array(area0,area1,area2,area3,area4));
		pageobj.backurl = "../../index.jsp";
		refreshServerTime();//时间填充
		//--init pageobj S
		
		//--BindData S
		
		bindNavigatData();
		bindRecommendData(jRecommends);
		bindHotKeyWordsData(jHotkeywords);
		bindBesttvodData(jBesttvod);
		
		//--BindData E
		
		//--PlayInVas S
		setTimeout(load_iframe,500);
		//--PlayInVas E
		//pageobj.pageSetMuteFlagEvent=setMuteFlag;
		//setTimeout(isMute,1500);
		
		document.getElementById("marquee").innerHTML="<marquee scrollamount='4'>"+introduce+"</marquee>";
		
	}
//common function S
	function turnUrl(url){
		if(url!=undefined&&url!="null"){
			url += ((url.indexOf("?")==-1)?"?":"&")+"returnurl="+escape(location.href);
			location.href = url;
		}
	}
//common funciton E
	//左右键EPG控制
function setEPG()
{
    Authentication.CTCSetConfig("key_ctrl_ex", "0");
}
/*function isMute()
{
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1)
	{
		document.getElementById("voice").src="../images/play/muteon.png";
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
			document.getElementById("voice").src="../images/play/muteoff.png";
			voiceTimer = setTimeout(hideVoice, 5000);
		}
	}
	else
	{
		mp.setMuteFlag(1);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
		{
			document.getElementById("voice").src="../images/play/muteon.png";
		}
	}      
}
function hideVoice()
{
	document.getElementById("voice").src="../images/t.gif";
}*/
</script>
<style type="text/css">
<!--
	body{ background:url(../images/bg-index.gif) no-repeat;}
-->
</style>
</head>

<body style="background-color:transparent;">

<!--head-->
	<div class="date" id="currDate"></div>
	
	<!--menu-->
	<div class="menu"> <!--当前选中为 class="item wid* item-select"；2字宽为wid1;3字宽为wid2,4字宽为wid3--> 
		<div class="item wid1">
			<div class="link"><a href="#" id="area0_list_0"><img src="../images/menu01.jpg" /></a></div>
		</div>               
		<div class="item wid3" style="left:63px;">
			<div class="link"><a href="#" id="area0_list_1"><img src="../images/t.gif" /></a></div>
		</div>
		<div class="item wid3" style="left:172px;">
			<div class="link"><a href="#" id="area0_list_2"><img src="../images/t.gif" /></a></div>
		</div>
		<div class="item wid3" style="left:281px;">
			<div class="link"><a href="#" id="area0_list_3"><img src="../images/t.gif" /></a></div>	
		</div>
		<div class="item wid2" style="left:390px;">
			<div class="link"><a href="#" id="area0_list_4"><img src="../images/t.gif" /></a></div>
		</div>
		<div class="item wid1" style="left:475px;">
			<div class="link"><a href="#" id="area0_list_5"><img src="../images/t.gif" /></a></div>
		</div>
	</div>
<!--the end-->

<div style="position:absolute; left:560px; top:125px; width:54px; height:66px; z-index:3;"><img id="voice" src="../images/t.gif"/></div>	


<!--推荐位-->
<div class="index-pic"> 
	<div class="item">
		<div class="link"><a href="#" id="area1_list_0"><img src="../images/t.gif" /></a></div>
     	<div class="pic"><img id="area1_img_0" src="" /></div>
	</div>
	<div class="item" style="top:147px;">
		<div class="link"><a href="#" id="area1_list_1"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area1_img_1" src="" /></div>
	</div>
	<div class="item" style="top:294px;">
		<div class="link"><a href="#" id="area1_list_2"><img src="../images/t.gif" /></a></div>
		<div class="pic"><img id="area1_img_2" src="" /></div>
	</div>
</div>	
<!--the end-->


        
<!--关键词-->
<div class="keyword" id="hotwordarea"><!--2字宽为wid1;3字宽为wid2,4字宽为wid3-->
<%
	if(hotkey_resultlist!=null){
		for(int i = 0,l = hotkey_resultlist.size();i<l;i++){
%>
		<div style="float:left; padding-left:10px;">
        	<div class="link" id="area2_border_<%=i%>"><a href="#" id="area2_list_<%=i%>"><img style="height:25px;" id="area2_img_<%=i%>" src="../images/t.gif" /></a></div>
            <div id="area2_content_<%=i%>"><%=((HashMap)hotkey_resultlist.get(i)).get("TYPE_NAME").toString() %></div>
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
		<div class="pic"><img src="" /></div>		
	</div>
</div>
<!--the end-->


	
<!--精彩回看-->
<div class="index-look-back">  
	<div class="item">
		<div class="link"><a href="#" id="area4_list_0"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area4_content_0"></div>
	</div>
	<div class="item" style="top:26px;">
		<div class="link"><a href="#" id="area4_list_1"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area4_content_1"></div>
	</div>
	<div class="item" style="top:52px;">
		<div class="link"><a href="#" id="area4_list_2"><img src="../images/t.gif" /></a></div>
		<div class="txt" id="area4_content_2"></div>
	</div>
</div>
<!--the end-->	
	
	
	
<!--滚动字幕-->
<div class="notice">
	<div class="txt" id="marquee" style="width:360"></div>
</div>
<!--the end-->
<div style="left:239px;top:119px;">	
	<iframe id="playPage" name="playPage" frameborder="0" height="0px" width="0px"></iframe>
</div>	
<%@ include file="servertimehelp.jsp" %>	
</body>
</html>
