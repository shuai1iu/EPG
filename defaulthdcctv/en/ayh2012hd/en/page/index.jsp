<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><%@ include file="../common/golbal.jsp" %> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>深圳奥运专题高清3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="<%=static_url%>/css/style.css" />
<script type="text/javascript" src="<%=static_url%>/js/common.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/cookie.js"></script>
<script type="text/javascript">
if(typeof(iPanel)!= 'undefined'){iPanel.focusWidth = "8"; iPanel.defaultFocusColor = "#2A5BB8";}
</script>
<style type="text/css">
<!--
body{ background: transparent url(<%=static_url%>/images/bg-index.gif) no-repeat;}
-->
</style>
</head>
<body onload="onPageLoad();" onunload="unload()">
<%@ include file="../datasource/datasource.jsp" %>
<%@ include file="../datasource/property.jsp" %>
<% 

   String itvUserId = (String)session.getAttribute("USERID");

   DataSource dataSource=new DataSource(request);

   String returnurl=dataSource.huaWeiUtil.getString(request.getParameter("returnurl"));

   int pos=dataSource.huaWeiUtil.getInt(request.getParameter("pos"),0);

   int area=dataSource.huaWeiUtil.getInt(request.getParameter("area"),1);
   int channelNUMtemp = dataSource.huaWeiUtil.getInt(request.getParameter("channelNUMtemp"),15);

   //获取左边推荐的影片

   EpgResult jingcaihuikans = dataSource.getVodInfoListByTypeId(1,3,"00000100000000090000000000020410","1");

   List jingcaihuikanlist = new ArrayList();

   List idList = new ArrayList();

   if(jingcaihuikans!=null&&jingcaihuikans.getResultcode()==0&&jingcaihuikans.getDatas()!=null)
   {

	   jingcaihuikanlist = (List)jingcaihuikans.getDatas();

   }

   

   //普通推荐栏目的方式

   EpgResult catetuijians = dataSource.getCategorys(1,2,aoyunminglan,"0");

   List catetuijianlist = new ArrayList();

   if(catetuijians!=null&&catetuijians.getResultcode()==0&&catetuijians.getDatas()!=null)

   {

		catetuijianlist = (List)catetuijians.getDatas();

   }

   

   //获取热词(栏目形式)

   EpgResult hotkeys=dataSource.getCategorys(1,7,recisousuo,"0");

   List hotskeylist=new ArrayList();

   if(hotkeys!=null&&hotkeys.getResultcode()==0&&hotkeys.getDatas()!=null)

   {

	   hotskeylist=(List)hotkeys.getDatas();

   }

   

   //获取右边的频道列表

   EpgResult channelData=dataSource.getChannelListByTypeId(1,8,ayhzhibocode);

   List channelList=new ArrayList();

   if(channelData!=null&&channelData.getResultcode()==0&&channelData.getDatas()!=null)

   {

	   channelList=(List)channelData.getDatas();

   }

%>



<% String currentPageId = "_1000"; %>

<%@ include file="../common/head.jsp" %>

<!--左边推荐位-->

<div class="index-pic">

	<div class="item">

	    <%if(jingcaihuikanlist!=null){if(jingcaihuikanlist.size()>0) {%>

        <div class="link"><a href="#" id="vod_0" 
        onclick="gotopaly(<%=((TblCmsProgram)jingcaihuikanlist.get(0)).getDsubvodidlist().get(0)%>,<%=((TblCmsProgram)jingcaihuikanlist.get(0)).getDid()%>,0)">
        <img src="<%=static_url%>/images/t.gif" /></a></div>

        <div class="pic"><img src="<%=((TblCmsProgram)jingcaihuikanlist.get(0)).getDpicpath()%>" /></div>

        <%}}%>

	</div>

    <div class="item" style="top:185px;">

	    <%if(jingcaihuikanlist!=null){if(jingcaihuikanlist.size()>1) {%>

        <div class="link"><a href="#" id="vod_1" 
        onclick="gotopaly(<%=((TblCmsProgram)jingcaihuikanlist.get(1)).getDsubvodidlist().get(0)%>,<%=((TblCmsProgram)jingcaihuikanlist.get(1)).getDid()%>,1)">
        <img src="<%=static_url%>/images/t.gif" /></a></div>

        <div class="pic"><img src="<%=((TblCmsProgram)jingcaihuikanlist.get(1)).getDpicpath()%>" /></div>

        <%}}%>

	</div>

    <div class="item" style="top:370px;">

	    <%if(jingcaihuikanlist!=null){if(jingcaihuikanlist.size()>2) {%>

        <div class="link"><a href="#" id="vod_2" 
        onclick="gotopaly(<%=((TblCmsProgram)jingcaihuikanlist.get(2)).getDsubvodidlist().get(0)%>,<%=((TblCmsProgram)jingcaihuikanlist.get(2)).getDid()%>,2)">
        <img src="<%=static_url%>/images/t.gif" /></a></div>

        <div class="pic"><img src="<%=((TblCmsProgram)jingcaihuikanlist.get(2)).getDpicpath()%>" /></div>

        <%}}%>

	</div>

</div>	

<!--the end-->



<!--播放区-->

<div class="index-video">  

	<div class="item">	

		<div class="link"><a href="#" onclick="goFull()" id="channelOK"><img src="<%=static_url%>/images/t.gif" /></a></div>

		<div class="pic">

			<iframe id="playPage" name="playPage" border="0" frameSpacing="0" marginWidth="0" marginHeight="0" frameBorder="0" noResize scrolling="no" vspace="0" width="680" height="381" style="background:transparent;"></iframe>

		</div>		

	</div>

</div>

<div class="index-channel">

	<div class="item">

		<%if(channelList!=null){if(channelList.size()>0) {%>

        <div class="link"><a href="#" id="channel_a_0" onclick="goChannelPlay(<%=((TblCmsChannel)channelList.get(0)).getDchannelnumber()%>,0)" onfocus="showFullName(0)" 

        onblur="showCutName(0)"><img src="<%=static_url%>/images/t.gif" /></a></div>

        <div class="txt" id="channelName_0" style="overflow:hidden"><%=((TblCmsChannel)channelList.get(0)).getDname()%></div>

        <%}}%>

	</div>  

	<div class="item" style="top:48px;">

		<%if(channelList!=null){if(channelList.size()>1) {%>

        <div class="link"><a href="#" id="channel_a_1" onclick="goChannelPlay(<%=((TblCmsChannel)channelList.get(1)).getDchannelnumber()%>,1)" onfocus="showFullName(1)" 

        onblur="showCutName(1)"><img src="<%=static_url%>/images/t.gif" /></a></div>

        <div class="txt" id="channelName_1" style="overflow:hidden"><%=((TblCmsChannel)channelList.get(1)).getDname()%></div>

        <%}}%>

	</div>  

	<div class="item" style="top:96px;">

		<%if(channelList!=null){if(channelList.size()>2) {%>

        <div class="link"><a href="#" id="channel_a_2" onclick="goChannelPlay(<%=((TblCmsChannel)channelList.get(2)).getDchannelnumber()%>,2)" onfocus="showFullName(2)" 

        onblur="showCutName(2)"><img src="<%=static_url%>/images/t.gif" /></a></div>

        <div class="txt" id="channelName_2" style="overflow:hidden"><%=((TblCmsChannel)channelList.get(2)).getDname()%></div>

        <%}}%>

	</div>  

	<div class="item" style="top:144px;">

		<%if(channelList!=null){if(channelList.size()>3) {%>

        <div class="link"><a href="#" id="channel_a_3" onclick="goChannelPlay(<%=((TblCmsChannel)channelList.get(3)).getDchannelnumber()%>,3)" onfocus="showFullName(3)" 

        onblur="showCutName(3)"><img src="<%=static_url%>/images/t.gif" /></a></div>

        <div class="txt" id="channelName_3" style="overflow:hidden"><%=((TblCmsChannel)channelList.get(3)).getDname()%></div>

        <%}}%>

	</div>  

	<div class="item" style="top:193px;">

		<%if(channelList!=null){if(channelList.size()>4) {%>

        <div class="link"><a href="#" id="channel_a_4" onclick="goChannelPlay(<%=((TblCmsChannel)channelList.get(4)).getDchannelnumber()%>,4)" onfocus="showFullName(4)" 

        onblur="showCutName(4)"><img src="<%=static_url%>/images/t.gif" /></a></div>

        <div class="txt" id="channelName_4" style="overflow:hidden"><%=((TblCmsChannel)channelList.get(4)).getDname()%></div>

        <%}}%>

	</div>  

	<div class="item" style="top:242px;">

		<%if(channelList!=null){if(channelList.size()>5) {%>

        <div class="link"><a href="#" id="channel_a_5" onclick="goChannelPlay(<%=((TblCmsChannel)channelList.get(5)).getDchannelnumber()%>,5)" onfocus="showFullName(5)" 

        onblur="showCutName(5)"><img src="<%=static_url%>/images/t.gif" /></a></div>

        <div class="txt" id="channelName_5" style="overflow:hidden"><%=((TblCmsChannel)channelList.get(5)).getDname()%></div>

        <%}}%>

	</div>  

	<div class="item" style="top:291px;">

		<%if(channelList!=null){if(channelList.size()>6) {%>

        <div class="link"><a href="#" id="channel_a_6" onclick="goChannelPlay(<%=((TblCmsChannel)channelList.get(6)).getDchannelnumber()%>,6)" onfocus="showFullName(6)" 

        onblur="showCutName(6)"><img src="<%=static_url%>/images/t.gif" /></a></div>

        <div class="txt" id="channelName_6" style="overflow:hidden"><%=((TblCmsChannel)channelList.get(6)).getDname()%></div>

        <%}}%>

	</div>  

	<div class="item" style="top:340px;">

		<%if(channelList!=null){if(channelList.size()>7) {%>

        <div class="link"><a href="#" id="channel_a_7" onclick="goChannelPlay(<%=((TblCmsChannel)channelList.get(7)).getDchannelnumber()%>,7)" onfocus="showFullName(7)"

         onblur="showCutName(7)"><img src="<%=static_url%>/images/t.gif" /></a></div>

        <div class="txt" id="channelName_7" style="overflow:hidden"><%=((TblCmsChannel)channelList.get(7)).getDname()%></div>

        <%}}%>

	</div>  

	

</div>

<!--the end-->





<!--关键词-->

<div class="keyword"><!--2字宽为wid1;3字宽为wid2,4字宽为wid3-->

	<div class="icon-search"><img src="<%=static_url%>/images/icon-search.jpg" /></div>

	<% if(hotskeylist.size()>0) {

	TblCmsCategory category=null;

	int leftpx=30;//距离左边的长度

	int hotNum = 0 ;//热词的长度 设定为27个字

	int hotlen = hotskeylist.size();

	for(int i=0;i<hotlen;i++){ 

		category=(TblCmsCategory)hotskeylist.get(i);

		String categoryname = dataSource.huaWeiUtil.getString(category.getDname());

		int cateNameLen = categoryname.length()>6?6:categoryname.length();

		if((hotNum+cateNameLen) > 26 ){ break; }

		if(cateNameLen>=6){

			%>

			 <div class="item wid5" style="left:<%=leftpx %>px;">

				<div class="link"><a href="#" onclick="goSearch(<%=i%>)" id="key_a_<%=i%>"><img src="<%=static_url%>/images/t.gif" /></a></div>

				<div class="txt"><%=categoryname.substring(0,6) %></div>

			</div> 

		   <%

			leftpx+=168;hotNum+=6;

		}else if(cateNameLen>=5){

			%>

             <div class="item wid4" style="left:<%=leftpx %>px;">

                <div class="link"><a href="#" onclick="goSearch(<%=i%>)" id="key_a_<%=i%>"><img src="<%=static_url%>/images/t.gif" /></a></div>

                <div class="txt"><%=categoryname.substring(0,5) %></div>

            </div> 

           <%

			leftpx+=142;hotNum+=5;

		}else if(cateNameLen>=4){

			%>

			<div class="item wid3" style="left:<%=leftpx %>px;">

                <div class="link"><a href="#" onclick="goSearch(<%=i%>)" id="key_a_<%=i%>"><img src="<%=static_url%>/images/t.gif" /></a></div>

                <div class="txt"><%=categoryname.substring(0,4) %></div>

            </div> 

			<%

			leftpx+=116;hotNum+=4;

		}else if(cateNameLen==3){

			%>

			<div class="item wid2" style="left:<%=leftpx %>px;">

                <div class="link"><a href="#" onclick="goSearch(<%=i%>)" id="key_a_<%=i%>"><img src="<%=static_url%>/images/t.gif" /></a></div>

                <div class="txt"><%=categoryname %></div>

            </div> 

			<%

			leftpx+=90;hotNum+=3;

		}else {

			%>

			 <div class="item wid1" style="left:<%=leftpx %>px;">

                <div class="link"><a href="#" onclick="goSearch(<%=i%>)" id="key_a_<%=i%>"><img src="<%=static_url%>/images/t.gif" /></a></div>

                <div class="txt"><%=categoryname %></div>

            </div>       

			<%

			leftpx+=60;hotNum+=2;

		}

	}

}%>

</div>

<!--the end-->



<!--下面推荐位-->

<div class="index-r-pic">

	<div class="item">

		<%if(catetuijianlist!=null){if(catetuijianlist.size()>0) {%>

        <div class="link"><a href="#" id="vas_a_0" onclick="goTojincai(0)"><img src="<%=static_url%>/images/t.gif" /></a></div>

        <div class="pic"><img width="100%" height="100%" src="<%=static_url%>/images/index_zuorsc.jpg" /></div>

        <%}}%>

	</div>

	<div class="item" style="left:403px;">

		<%if(catetuijianlist!=null){if(catetuijianlist.size()>1) {%>

        <div class="link"><a href="#" id="vas_a_1" onclick="goTojincai(1)"><img src="<%=static_url%>/images/t.gif" /></a></div>

        <div class="pic"><img width="100%" height="100%" src="<%=static_url%>/images/index_jingcai.jpg" /></div>

        <%}}%>

	</div>

   <!--(TblCmsCategory)catetuijianlist.get(1)).getPicpath()-->

</div>

<!--the end-->



<script type="text/javascript">

var area = <%=area %>; //0:导航 1：左推荐位 2：精彩推荐 3：搜索词 4：视频窗口

var pos = <%=pos %> ;

var returnurl = "<%=returnurl%>";

var itvUserId = "<%=itvUserId %>";
var channelNUMtemp = <%=channelNUMtemp%>;

var backUrl = "index.jsp";

var keyNameList = new Array();

var vodIdList = new Array();

var vasCateUrlList = new Array();

var CateIdList = new Array();

var channelName = new Array();
<%

if(hotskeylist.size()>0){

   TblCmsCategory category=null;

	int len = hotskeylist.size();

	for(int i=0;i<len;i++){ 

		%>

keyNameList[<%=i%>]="<%=((TblCmsCategory)hotskeylist.get(i)).getDdescription().toUpperCase()%>";//修改为传递简介
		<%

	}

}

/*

if(jingcaihuikanlist.size()>0){

	TblCmsProgram vods=null;

	int vodlen = jingcaihuikanlist.size();

	for(int i=0;i<vodlen;i++){ 

	   %>

		vodIdList[<%=i%>]=<%=((TblCmsProgram)jingcaihuikanlist.get(i)).getDcmsid()%>;

	   <%

	}	

}*/



/*增值业务栏目，需要时启用

if(vastuijianlist.size()>0){

	TblCmsVasCategory vasCate = null;

	int vaslen = vastuijianlist.size();

	for(int i= 0; i < vaslen ; i++){

	  %>

		vasCateUrlList[<%=i%>]="<%=((TblCmsVasCategory)vastuijianlist.get(i)).getDvasurl()%>";

	   <%

	}

}*/

/*

if(catetuijianlist.size()>0){

	TblCmsCategory cate = null;

	int len = catetuijianlist.size();

	for(int i= 0; i < len ; i++){

	  %>

		CateIdList[<%=i%>]=<%=((TblCmsCategory)catetuijianlist.get(i)).getDcmsid()%>;

	   <%

	}

}*/

if(channelList.size()>0 && channelList!=null){

     int channelLen = channelList.size();

	 for(int i = 0 ;i<channelLen;i++){

	   %>

		channelName[<%=i%>]="<%=((TblCmsChannel)channelList.get(i)).getDname()%>";

	   <%

	 }

}

%>

var loadIframeTimer = "";

function onPageLoad(){

	 init();

	 if(returnurl!=""&&returnurl!=null){addURLtoCookie("index",returnurl);}

	 loadIframeTimer = setTimeout("loadIframe()",200);

}

function unload(){

	if(loadIframeTimer){clearTimeout(loadIframeTimer);}

}


function init()

{

	if(1==area){$("vod_"+pos).focus();}

	else if(2==area){$("channelOK").focus();}

	else if(3==area){$("key_a_"+pos).focus();}

	else if(4==area){$("vas_a_"+pos).focus();}

	else if(5==area){$("channel_a_"+pos).focus();}

}



function goBack(){
	
	 window.location.href = "<%=static_cctv_index%>" ;
}



function goSearch(num){

	var searchUrl = "search.jsp?keywords="+keyNameList[num];

	backUrl = "index.jsp?area=3&pos="+num+"&channelNUMtemp="+channelNUMtemp;

	addURLtoCookie("search",backUrl);

	 window.location.href = searchUrl;

}


function goFull(){
	var channelPlayUrl = "<%=static_en%>/player/play_ControlChannel.jsp?CHANNELNUM="+channelNUMtemp;

	backUrl = "<%=static_en%>/page/index.jsp?area=2&channelNUMtemp="+channelNUMtemp;

	addURLtoCookie("channelPlay",backUrl);

	 window.location.href = channelPlayUrl;

}

function goChannelPlay(channelNUM,num){
	channelNUMtemp = channelNUM;
	var channelPlayUrl = "<%=static_en%>/player/PlayTrailerInVas.jsp?_channelid="+channelNUMtemp+"&_height=381&_width=680&_left=432&_top=152";
	playPage.location.href = channelPlayUrl;

}

function gotopaly(progid,fatherid,num){

	backUrl = "<%=static_en%>/page/index.jsp?area=1&pos="+num+"&channelNUMtemp="+channelNUMtemp;

	addURLtoCookie("vodPlay",backUrl);
	

    location.href = "<%=static_en%>/player/au_PlayFilm.jsp?PROGID="+progid+"&FATHERSERIESID="+fatherid+"&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=0&BEGINTIME=0&ENDTIME=200";

}

function goTojincai(num)

{

	var url="";

	var num=num;

	var endUrl = "<%=static_en%>/page/index.jsp?area=4&pos="+num+"&channelNUMtemp="+channelNUMtemp;

	if(num==0){
		var dbListcategoryId = "00000100000000090000000000020089";

		url = "<%=static_en%>/page/ayml.jsp?dbListcategoryId="+dbListcategoryId+"&indexFlage=0";

		backUrl = endUrl;

	    addURLtoCookie("index",backUrl);

	}else{

		// url = "http://14.31.15.70/?itvUserId="+ itvUserId +"&endUrl= "+ location.href;   
		var dbListcategoryId = "00000100000000090000000000020042";

		url = "<%=static_en%>/page/china.jsp?dbListcategoryId="+dbListcategoryId+"&indexFlage=0";

		backUrl = endUrl;

	    addURLtoCookie("index",backUrl);      

	}

	location.href = url;

}



function loadIframe(){
	playPage.location.href = "<%=static_en%>/player/PlayTrailerInVas.jsp?_channelid="+channelNUMtemp+"&_height=381&_width=680&_left=432&_top=152";

	voiceTimer = setTimeout("isMute()",800);
}

var $$ = {};

function $(id){

	if(!$$[id]){

	   $$[id] = document.getElementById(id);

	}

	return $$[id];

}

function showFullName(num){

	 $("channelName_"+num).innerHTML = ((channelName[num]).length)>6?("<marquee startposition='90%'>"+channelName[num]+"</marquee>"):(channelName[num]);

}

function showCutName(num){

	 $("channelName_"+num).innerHTML = ((channelName[num]).length)>6?(channelName[num]).substr(0,6):channelName[num];

}

document.onkeypress = keyEvent;
function keyEvent()
{
	var val = event.which ? event.which : event.keyCode;
	return keypress(val);
}
function keypress(keyval)
{
	switch(keyval)
	{
		case 259:volumeUp();break;
		case 260:volumeDown();break;
		case 261:setMuteFlag();break;
		case 8:goBack();break;		
	} 
}
//////为深圳加播放器的控制begin///////
var volumeDivIsShow = false;
var volume = 50;
var bottomTimer = "";
var voiceTimer = "";
function volumeUp()
{
	
	hideVoice();
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(1 == muteFlag){mp.setMuteFlag(0);}
	volume = mp.getVolume(); 
	volume += 5;
	if(volume >= 100){volume = 100;  }
	mp.setVolume(volume);  
	if (mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
	{
		if(bottomTimer){clearTimeout(bottomTimer);}
		genVolumeTable(volume);
		bottomTimer = setTimeout("hideBottom();", 3000);
	}
}
function volumeDown()
{	
    hideVoice();
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){mp.setMuteFlag(0);}
	volume = mp.getVolume();
	volume -= 5;	
	if(volume <= 0){volume = 0;   }
	mp.setVolume(volume);  
	if (mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
	{
		if(bottomTimer){clearTimeout(bottomTimer);}
		genVolumeTable(volume);
		bottomTimer = setTimeout("hideBottom();", 3000);
	}
}
function hideBottom()
{
	volumeDivIsShow = false;
	$("bottomframe").innerHTML = "";
}
function hideVoice()
{
	$("voice").src = "#";
}
function genVolumeTable(volume)
{
	var tableDef = '<table width="490px" border="0" cellpadding="0" cellspacing="0"><tr>';
	volume = parseInt(volume / 5);
	for (i = 0; i < 40; i++)
	{
		if (i % 2 == 0)
		{
			tableDef += '<td width="10px" height="27px" bgcolor="transparent"></td>';
		}
		else
		{
			if ( i / 2 < volume)
			{
				tableDef += '<td width="10px" height="27px" bgcolor="#00ff00"></td>';
			}
			else
			{
				tableDef += '<td width="10px" height="27px" bgcolor="cccccc"></td>';
			}
		}
	}
	tableDef += '<td width="10px"></td><td width="20px"><img src="<%=static_en%>/player/playerimages/volume.gif"></td><td width="20px" style="color:white;font-size:28">' + 						volume + '</td>';
	tableDef += '</tr></table>'; 
	$("bottomframe").innerHTML = tableDef;    	
}
function setMuteFlag()
{
	hideBottom();
	if(voiceTimer){clearTimeout(voiceTimer);}
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(1 == muteFlag){
		mp.setMuteFlag(0);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0){
			$("voice").src = "<%=static_en%>/player/playerimages/muteoff.png";
			voiceTimer = setTimeout("hideVoice()", 3000);
		}
	}else{
		mp.setMuteFlag(1);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0){
			$("voice").src = "<%=static_en%>/player/playerimages/muteon.png";
		}
	}      
}
function isMute(){
	var muteFlag = mp.getMuteFlag();
	if(1 == muteFlag){
		$("voice").src = "<%=static_en%>/player/playerimages/muteon.png";
	}
}
//////为深圳加播放器的控制end///////
</script>
<div id="bottomframe" style="position:absolute;left:440px; top:460px; width:600px; height:80px; z-index:3"></div>
<div style="position:absolute; left:1050px; top:160px; width:54px; height:66px; z-index:4;"><img id="voice" src="<%=static_url%>/images/dot.gif"/></div>
</body>

</html>

