<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.util.StringDateUtil" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.*" %>
<%@ page import="net.sf.json.JSONArray"%>
<%@ page import="net.sf.json.JSONObject"%>
<%@ include file="util_getPosterPaths.jsp"%>
<%
    
	String isfromtvod = request.getParameter("isfromtvod")==null?"0":request.getParameter("isfromtvod").toString();
	
	String channelcode = request.getParameter("channelcode")==null?"":request.getParameter("channelcode").toString();
	String area0index = request.getParameter("area0index")==null?"":request.getParameter("area0index").toString();
	String area1index = request.getParameter("area1index")==null?"":request.getParameter("area1index").toString();
	String area2index = request.getParameter("area2index")==null?"":request.getParameter("area2index").toString();
	String channelid = request.getParameter("channelid")==null?"":request.getParameter("channelid").toString();
	String ishownum = request.getParameter("ishownum")==null?"":request.getParameter("ishownum").toString();
	MetaData metaData = new MetaData(request);
   
    ArrayList result=new ArrayList();
    ArrayList result1=new ArrayList();
    result = metaData.getChanListByTypeId("10000100000000090000000000039770",4,0);
    result1=(ArrayList)result.get(1);
    
	JSONArray recChannelBill=null;
	
	ArrayList recChanList=new ArrayList();
	
	for(int j=0;j<result1.size();j++)
	{
		HashMap chanInfomap = (HashMap)result1.get(j);
		String tempchannelcode =String.valueOf(chanInfomap.get("CHANNELID"));
		int tempchannelid = ((Integer)chanInfomap.get("CHANNELINDEX")).intValue()-1000;
		String tempchannelname = String.valueOf(chanInfomap.get("CHANNELNAME"));
		HashMap chanInfomap1 = new HashMap();
		chanInfomap1.put("channelname",tempchannelname);
		chanInfomap1.put("channelid",tempchannelid);
		chanInfomap1.put("channelcode",tempchannelcode);
		
		 if(channelcode.equals("") && j==0){
			channelcode=tempchannelcode;
		}
		if(channelid.equals("") && j==0){
			channelid=String.valueOf(tempchannelid);
		}
		recChanList.add(chanInfomap1);
	}  
	
	recChannelBill = JSONArray.fromObject(recChanList);
    
	
    ServiceHelp serviceHelpxx = new ServiceHelp(request);
	JSONArray tuijianjsonvodlist = null; //节目列表
	ArrayList tuijianvodlist = (ArrayList)metaData.getVasListByTypeId("10000100000000090000000000042210",2,0);
	ArrayList tuijiantempList = new ArrayList();
	ArrayList tuijianvod_list = new ArrayList();
	if(tuijianvodlist!=null && tuijianvodlist.size() > 1 && ((ArrayList)tuijianvodlist.get(1)).size() > 0)
	{
		tuijianvod_list = (ArrayList)tuijianvodlist.get(1);
	}
	
	for(int i = 0;i<tuijianvod_list.size();i++)
	{
		HashMap obj = (HashMap)tuijianvod_list.get(i);
		HashMap tempmap = new HashMap();
		int tmpvodid=(Integer)obj.get("VASID");
		String tmpvodname = obj.get("VASNAME").toString();
		tempmap.put("VASID",tmpvodid);
		tempmap.put("VASNAME",tmpvodname);
	    String vasurl=serviceHelpxx.getVasUrl(tmpvodid);
		Map mapindex = metaData.getVasDetailInfo(tmpvodid);
		HashMap postersMap = (HashMap)mapindex.get("POSTERPATHS");
		String picpath = (String)mapindex.get("POSTERPATH");
		String postpath =  getPosterPath(postersMap,request,picpath,"5").toString();
		tempmap.put("VARSURL",vasurl);
		tempmap.put("POSTERPATHS",postpath);
		tuijiantempList.add(tempmap);
	}
	tuijianjsonvodlist = JSONArray.fromObject(tuijiantempList);
    
	JSONArray jsonDateList=null;
	System.out.println("wanchan"+channelcode);
	int len = 0;
	HashMap timeHash = metaData.getChannelInfo(channelcode);
	len = Integer.parseInt(timeHash.get("RECORDLENGTH").toString());
	int timeShiftLength = (int)len / 60;
	if(timeShiftLength < 1)
	timeShiftLength = 1;
	timeShiftLength = (int)timeShiftLength / 60 / 24;
	SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
	SimpleDateFormat formatterChinese = new SimpleDateFormat("MM-dd");
	Date currDate = new java.util.Date();
	// currDate.setMinutes(timeShiftLength);
	Calendar  cal = Calendar.getInstance();
	cal.add(Calendar.DAY_OF_MONTH, -timeShiftLength);
	//cal.add(Calendar.DAY_OF_MONTH,1);
	Date beforeDate = cal.getTime();
	String time = formatter.format(beforeDate);
	ArrayList channelDateList=new ArrayList();
	while(beforeDate.compareTo(currDate) <= 0 )
	{
		//timeList += formatterChinese.format(beforeDate) + ",";
		HashMap mydate=new HashMap();
		mydate.put("date24",formatter.format(beforeDate));
		mydate.put("dateChinese",formatterChinese.format(beforeDate));
		channelDateList.add(mydate);
		cal.add(Calendar.DAY_OF_MONTH,1);
		beforeDate = cal.getTime();	
	}
   jsonDateList = JSONArray.fromObject(channelDateList);
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>央视精品专区-标清-2 - 深圳央视标清EPG2.0</title>
<meta name="page-view-size" content="1280*720" />
<style>
/* =S Css Reset
----------------------------------------------- */
body, div, h1, h2, h3, h4, h5, h6, button, input, textarea, th, td { margin: 0; padding: 0; }
body, div, button, input, select, textarea { font-size: 22px; font-family: Microsoft YaHei,sans-serif; line-height: 100%; }
h1, h2, h3, h4, h5, h6 { font-size: 100%; }
a { text-decoration: none; }
fieldset, img { border: 0; }
button, input, select, textarea { font-size:100%; }

/* =S Global
----------------------------------------------- */
.item, .link, .txt-wrap, .txt, .btn, .icon, .pic, .cover, .num, .win { 
	left: 0;
	position:absolute;
	top: 0;
}
.link { z-index: 9;}
.txt { z-index: 7;}
.txt-wrap { z-index: 6;}
.icon { z-index: 5;}
.cover { z-index: 4;}
.pic { z-index: 3;}
.btn { text-align: center;}

body, .wrapper {
    height: 720px;
    width: 1280px;
    background: transparent;
    /*overflow: hidden;*/
    position: relative;
}
body {
   /* background-color: #000;*/
    color: #f0f0f0;
}
.wrapper,.pagebg {
	left: 0;
	position: absolute;
	top: 0;
}
.wrapper {
	z-index: 2;
}
.pagebg {
	z-index: 1;
}
.logo {
	left:13px;
	position:absolute; 
	top:203px; 
}

/* left ----------------------------------------------- */
.hd-left {
	background:url(../images/left-bg.png) repeat;
	left:0;
	position:absolute; 
	top:0; 
	height:720px;
	width:280px;
	z-index:3;
}
.nav {
	left:0;
	position:absolute; 
	top:259px; 
}
.nav .item {
	background:url(../images/nav-bg01.png) no-repeat;
	height:63px;
	width:230px;
	z-index:5;
}
.nav .item .txt {
	color:#c9caca;
	left:10px;
	text-align:center;
	line-height:46px;
	top:7px;
	height:46px;
	width:206px;
}
.nav .item_focus {
	background:url(../images/nav-bg01_focus.png) no-repeat;
	z-index:6;
}
.nav .item_focus .txt { 
	color:#fff;
	font-size:27px;
	line-height:46px;
	left:42px;
	top:7px;
	height:46px;
	width:155px;
}
.nav .item_select {
	background:url(../images/nav-bg01_select.png) no-repeat;
	z-index:6;
}
.nav .item_select .txt { 
	color:#fff;
	font-size:27px;
	line-height:46px;
	left:42px;
	top:7px;
	height:46px;
	width:155px;
}
.nav .btn {
	background:url(../images/nav-bg02.png) no-repeat;
	color:#000;
	left:220px;
	top:13px;
	text-align:center;
	line-height:36px;
	height:36px;
	width:60px;
	z-index:4;
}
.poster  {
	left:3px;
	position:absolute; 
	top:503px; 
}
.poster .item {
	height:98px;
	width:210px;
}
.poster .item .pic {
	left:3px;
	top:3px;
}
.poster .item .pic,
.poster .item .pic img {
	height:92px;
	width:204px;
}
.poster .item_focus {
	background:url(../images/list-pic01_focus.png) no-repeat;
}

/* mid ----------------------------------------------- */
.hd-mid {
	background:url(../images/mid-bg.png) repeat;
	left:197px;
	position:absolute; 
	top:0; 
	height:720px;
	width:201px;
	z-index:4;
}
.nav-b {
	left:0;
	position:absolute; 
	top:251px; 
}
.nav-b .item {
	background:url(../images/nav-bg03.png);
	height:75px;
	width:201px;
}
.nav-b .item .txt {
	color:#ababab;
	font-size:22px;
	text-align:center;
	line-height:44px;
	top:16px;
	height:44px;
	width:201px;
}
.nav-b .item_focus {
	background:url(../images/nav-bg03_focus.png) no-repeat;
}
.nav-b .item_focus .txt { 
	color:#fff;
	font-size:27px;
}
.nav-b .item_select {
	background:url(../images/nav-bg03_select.png) no-repeat;
}
.nav-b .item_select .txt { 
	color:#fff;
}

/* list ------------------------------------------------*/
.list {
	background:url(../images/list-bg.png) no-repeat;
	left:843px;
	position:absolute;
	top:468px;
	height:240px;
	width:425px;
}
.list .txt {
	color:#ababab;
	left:65px;
	top:65px;
	width:315px;
}
.list .txt-on {
	color:#fff;
	font-size:34px;
}
.list-warp {
	background:url(../images/list-b-bg.png) repeat;
	left:364px;
	position:absolute; 
	top:0; 
	height:720px;
	width:417px;
}
.list-b {
	left:0;
	position:absolute; 
	top:75px; 
}
.list-b .item {
	height:70px;
	width:417px;
	z-index:3;
}
.list-b .item .txt {
	color:#ababab;
	line-height:44px;
	left:125px;
	top:12px;
	height:44px;
	width:290px;
}
.list-b .item .txt-time {
	left:50px;
	height:30px;
	width:80px;
}
.list-b .item_see .txt {
	color:#fff;
}
.list-b .item_focus {
	background:url(../images/list-b_focus.png) no-repeat;
	z-index:4;
}
.list-b .item_focus .txt {
	font-size:26px;
}
.list-warp .btn {
	left:168px; 
	top:35px;
}
.list-warp .btn .item {
	height:34px;
	width:50px;
}
.list-warp .btn-up .item {
	background:url(../images/btn-up.png) no-repeat;
}
.list-warp .btn-up .item_focus {
	background:url(../images/btn-up_focus.png) no-repeat;
}
.list-warp .btn-up .item_no{
	background:url(../images/btn-up_none.png) no-repeat;
}
.list-warp .btn-down .item {
	background:url(../images/btn-down.png) no-repeat;
}
.list-warp .btn-down .item_focus {
	background:url(../images/btn-down_focus.png) no-repeat;
}
.list-warp .btn-down .item_no {
	background:url(../images/btn-down_none.png) no-repeat;
}
.list-warp .btn-down { top:654px;}

/* popup layer ------------------------------------------------*/
.popup-lb-warp {
	background:url(../images/trans80.png) repeat;
	left:0;
	position:absolute;
	top:0;
	height:720px;
	width:1280px;
	z-index:3;
}
.popup-lb {
	background:url(../images/popup-bg.png) no-repeat;
	left:187px;
	position:absolute;
	top:154px;
	height:412px;
	width:906px;
}
.popup-lb .txt-font {
	color:#fff;
	font-size:36px;
	line-height:66px;
	left:203px;
	top:95px;
	text-align:center;
	width:500px;
}
.popup-lb .btn {
	left:11px;
	top:311px;
}
.popup-lb .item {
	height:90px;
	width:441px;
}
.popup-lb .item .icon {
	left:105px;
	top:18px;
	height:55px;
	width:55px;
}
.popup-lb .item .txt {
	color:#363636;
	font-size:28px;
	left:195px;
	line-height:90px;
	text-align:left;
	height:90px;
	width:200px;
}
.popup-lb .item_focus {
	background-color:#2467e6;
}
.popup-lb .item_focus .txt { 
	color:#fff;
}
.popup-lb .item .icon01 {
	background:url(../images/icon01.png) no-repeat;
}
.popup-lb .item .icon02 {
	background:url(../images/icon02.png) no-repeat;
}
.popup-lb .item_focus .icon01 {
	background:url(../images/icon01_focus.png) no-repeat;
}
.popup-lb .item_focus .icon02 {
	background:url(../images/icon02_focus.png) no-repeat;
}
</style>
<script  type="text/javascript">
        var channellist=eval('('+'<%=recChannelBill%>'+')');
		var datelist=eval('('+'<%=jsonDateList%>'+')');
		var vaslist=eval('('+'<%=tuijianjsonvodlist%>'+')');
	    var tvodlist=new Array();
		var totaltvodlist=new Array();
		var goblanktimer;
		var ishownum=<%=ishownum%>;
		var filmInfoTimer; 
		function goBlank(){
			window.location.href="play_ControlChannel.jsp";
		}
		
		function clearBlankTimer(){
		   	clearTimeout(goblanktimer);
			goblanktimer=setTimeout("goBlank()",4000);
		}
		
		//隐藏错误提示信息
		function hiddenChannnum()
		{
		   $("topframe").style.display = "none";
		   $("topframenum").innerHTML="";
		}

		function hiddenFilmInfo()
		{
			clearTimeout(filmInfoTimer);
			hiddenChannnum();
			$("filmInfo").style.display = "none";
		}

		function init_info(jsontext){
			var thisjson=eval('('+jsontext+')'); ;
			if(thisjson.progMenus.length>0){
				$("progName_0").innerHTML=thisjson.progMenus[0].progName;
				$("progName_1").innerHTML=thisjson.progMenus[1].progTime+"&nbsp;&nbsp;"+thisjson.progMenus[1].progName;
				$("progName_2").innerHTML=thisjson.progMenus[2].progTime+"&nbsp;&nbsp;"+thisjson.progMenus[2].progName;
			}
			$("filmInfo").style.display = "block";
		}
		
		window.onload=function(){
			  document.onkeypress = keyEvent;
			  window.focus();
			  setEPG();
			  if(ishownum==1){
				  $("topframe").style.display = "block";
				  $("topframenum").innerHTML="<%=channelid%>";		 
				  getAJAXData("play_ControlChannelminiInfoajax.jsp?CHANNELID=<%=channelcode%>&CHANNELNUM=<%=channelid%>",init_info);
				  filmInfoTimer = setTimeout("hiddenFilmInfo()",4000);
			  }
			  goblanktimer=setTimeout("goBlank()",4000);
			  if(pageobj.curareaindex==0){
				   $("divchannel"+area0.curindex).className="item item_focus";
				   $("divchannelbtn"+area0.curindex).style.display="block";
				   $("logo").src = "../images/logo-"+channellist[area0.curindex].channelid+".png";//2014/1/27 台标切换
			  }
			  bindChannelData();
			  bindDateData();
			  bindTvodData();
			  bindVas();
	  };

	   //左右键机顶盒控制
		function setSTB()
		{
			Authentication.CTCSetConfig("key_ctrl_ex", "1");
		}
		//左右键EPG控制
		function setEPG()
		{
			Authentication.CTCSetConfig("key_ctrl_ex", "0");
		}


      //初始化绑定频道
	  function bindChannelData(){
		   area0.datanum=channellist.length;
		   for(var i=0;i<area0.datanum;i++){
				if(i<channellist.length){
				  $("divchanneltxt"+i).innerHTML=channellist[i].channelname;
				}else{
				  $("divchanneltxt"+i).innerHTML="";
				}
			   
		   }
	  }


	   //初始化绑定日期
	  function bindDateData(){
		   datelist = rerverseDate(datelist);//2014/1/27 反转日期数组
		   area1.datanum=datelist.length;
		   for(var i=0;i<8;i++){
				if(i<datelist.length){
					$("divdatetxt"+i).innerHTML=datelist[i].dateChinese;
				}else{
					 $("divdatetxt"+i).innerHTML="";
					
				}
			}
	  }
		
		//2014/1/27 反转日期数组
		function rerverseDate(data)
		{
			var tmpList = new Array();
			
			for(var i = data.length - 1; i >= 0; i --)
			{
				tmpList.push(data[i]);
			}
			return tmpList;
		}
     
	   //初始化绑定VAS
      function bindVas(){
		  $("divvasimg0").src="../../"+vaslist[0].POSTERPATHS;//2014/1/27
		  $("divvasimg1").src="../../"+vaslist[1].POSTERPATHS;//2014/1/27 
	  }

      //初始化绑定回看列表
	  function bindTvodData(){
		   area2.datanum=tvodlist.length;
		   for(var i=0;i<18;i++){
				if(i<tvodlist.length){
					 var temphour = tvodlist[i].STARTTIME.substring(8,10);
					 var tempminitue = tvodlist[i].STARTTIME.substring(10,12);
					 var temptext = temphour+":"+tempminitue;
					 $("divtvoddate"+i).innerHTML=temptext;
					 if(tvodlist[i].LiveSTATUS==0 || tvodlist[i].LiveSTATUS==2){
						 $("divtvod"+i).className="item item_see"; 
					 }else{
						 $("divtvod"+i).className="item"; 
					 }
					 
					 
					 if(getbytelength(tvodlist[i].PROGNAME)>20){
						  tvodlist[i].cutPROGNAME=getcutedstring(tvodlist[i].PROGNAME,20,false);
						  tvodlist[i].iscut=true;
					 }
					 else{
						  tvodlist[i].cutPROGNAME=tvodlist[i].PROGNAME;
						  tvodlist[i].iscut=false;
					 }
					
					 $("divtvodtxt"+i).innerHTML=tvodlist[i].cutPROGNAME;
					
				}else{
					  $("divtvoddate"+i).innerHTML="";
					  $("divtvodtxt"+i).innerHTML="";
				}
		  }
		  if(area2.pagenum>1){
			  $("pageUp").className="item item_focus";
			  $("pageDown").className="item item_focus";
		  }else{
			  $("pageUp").className="item";
			  $("pageDown").className="item";
		  }
      }
	  
	 function getbytelength(str){
		var byteLen=0,len=str.length;
		if(str){
			for(var i=0;i<len;i++)
			{
			   if(str.charCodeAt(i)>255)
				  byteLen+=2;
			   else
				  byteLen++;
			}
			return byteLen;
		}
		return 0;
    }
	
	//数组分页
	function getItmsByPage(cptitms,icurpage,ipagesize){
			var reclist=new Array();
			var start = (icurpage-1)*ipagesize;
			for(var i=0;i<ipagesize&&(i+(icurpage-1)*ipagesize)<cptitms.length;i++){
				 reclist[i]=cptitms[start+i];
			}	
			return reclist;
	}
	
	
	function getcutedstring(sSource,iLen,dot)
	{
	
	    var str = "";
	    var l = 0;
	    var schar;
	    if(dot) iLen=iLen+4;
	    for(var i=0; schar=sSource.charAt(i); i++)
	    {
	         str += schar;
	         l += (schar.match(/[^\x00-\xff]/) != null ? 2 : 1);
			 if(l >= iLen)
			 {
				break;
			 }
	    }
		if(dot) return str;
		else 
		return str+"...";
	}

	  
	  
      var _in_ajax = window.ActiveXObject ? new ActiveXObject("Microsoft.XMLHTTP") : new XMLHttpRequest();

      var zte_browser = navigator.userAgent.indexOf('ztebw');
     
	 //传入的successMethed有一个字符串参数，处理成功后将服务器返回的信息做参数传入
      function getAJAXData(url, successMethed,param) {
		if (url != undefined && url != null && url != "") {
			var temp = url.split("?"); url = temp[0];
			if (temp.length > 1) { url += "?" + encodeURI(temp[1]); }
		}
		if(zte_browser >=0){
			var _in_ajax_1 = window.ActiveXObject ? new ActiveXObject("Microsoft.XMLHTTP") : new XMLHttpRequest();
			_in_ajax_1.open("POST",  url,  true); 
			_in_ajax_1.onreadystatechange= function() {
			    if (_in_ajax_1.readyState == 4) { if (_in_ajax_1.status == 200) { successMethed(_in_ajax_1.responseText,param);} } 
		    }
		    _in_ajax_1.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		    _in_ajax_1.setRequestHeader("X-Requested-With", "XMLHttpRequest");
		    _in_ajax_1.send(null);
        }else{
			_in_ajax.open("POST", url, false);
			_in_ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
			_in_ajax.setRequestHeader("X-Requested-With", "XMLHttpRequest");
			_in_ajax.send(null);
			 //_in_ajax.onreadystatechange=successMethed;
			 if (_in_ajax.readyState == 4) { if (_in_ajax.status == 200) { successMethed(_in_ajax.responseText,param); } } 
          }
       }
   
   
	var curareaindex=0;
	var curindex=0;
  
    var area0={selectindex:<%=area0index%>,curindex:<%=area0index%>,stadyindex:<%=area0index%>,datanum:4,curpage:1,pagenum:1};
    var area1={selectindex:0,curindex:0,stadyindex:0,datanum:8,curpage:1,pagenum:1};
    var area2={selectindex:0,curindex:0,stadyindex:0,datanum:18,curpage:1,pagenum:1};
    var area3={selectindex:0,curindex:0,stadyindex:0,datanum:2,curpage:1,pagenum:1};
    var pageobj=new Object();
    pageobj.curareaindex=curareaindex;
    pageobj.curindex=curindex;
    pageobj.areas=new Array();
    pageobj.areas.push(area0);
    pageobj.areas.push(area1);
    pageobj.areas.push(area2);
    pageobj.areas.push(area3);
  
  pageobj.backurl="";
  pageobj.goback=function(){
	   parent.goBack();
  };
  
  pageobj.ok=function(){
	   pageobj.areas[pageobj.curareaindex].ok();
  };

  pageobj.pageTurn=function(num){ //2014/1/27 翻页键翻页
	   clearBlankTimer();
	   if(pageobj.curareaindex==2){
		     var temptotalpage=pageobj.areas[pageobj.curareaindex].pagenum;
			 var tempcurpage=pageobj.areas[pageobj.curareaindex].curpage;	
			 if(temptotalpage<=1)
				 return;					 	 
			 if((tempcurpage+num)<1)
			 {
			    pageobj.areas[pageobj.curareaindex].curpage=temptotalpage;
			 }
			 else if((tempcurpage+num)>temptotalpage)
			 {
			    pageobj.areas[pageobj.curareaindex].curpage=1;	   
			 }
			 else
			 {
				pageobj.areas[pageobj.curareaindex].curpage=tempcurpage+num;
			 }
			 tvodlist=new Array();
			
			 tvodlist=getItmsByPage(totaltvodlist,pageobj.areas[pageobj.curareaindex].curpage,18);
			 pageobj.areas[pageobj.curareaindex].datanum=tvodlist.length;
			 bindTvodData();
			 if(pageobj.areas[pageobj.curareaindex].curindex>=tvodlist.length)
		     {
				pageobj.areas[pageobj.curareaindex].clearfocus();
				pageobj.areas[pageobj.curareaindex].curindex = -1;
				pageobj.areas[pageobj.curareaindex].areafocus(1);
		     }
			 else
			 {
				  if(tvodlist[area2.curindex]!=undefined&&tvodlist[area2.curindex].LiveSTATUS!=1){
					  $("divtvod"+area2.curindex).className = "item item_see item_focus";
				  }else{
					  $("divtvod"+area2.curindex).className = "item item_focus";
				  }
				  if(tvodlist[area2.curindex].iscut==true){
					  $("divtvodtxt"+area2.curindex).innerHTML="<marquee behavior='scroll' width='90%' startposition='90%'>"+tvodlist[area2.curindex].PROGNAME+"</marquee>";
				  }
			 }
	   }
  }
  
  pageobj.move=function(direction){
	  clearBlankTimer();
	  switch(direction){
		   case 0:{
			   if(pageobj.curareaindex==0){
				  if((pageobj.areas[pageobj.curareaindex].curindex-1)>=0){
					   pageobj.curareaindex=0;
					   pageobj.areas[pageobj.curareaindex].areafocus(-1);
					  
				  }else{
					  pageobj.areas[pageobj.curareaindex].clearfocus();
					  pageobj.curareaindex=3;
					  pageobj.areas[pageobj.curareaindex].curindex=-1;
					  pageobj.areas[pageobj.curareaindex].areafocus(1);
					  
				  }
				   
			   }else  if(pageobj.curareaindex==1){
				   
				    if((pageobj.areas[pageobj.curareaindex].curindex-1)>=0){
					     pageobj.areas[pageobj.curareaindex].areafocus(-1);
				    }else{
						 pageobj.areas[pageobj.curareaindex].clearfocus();
						 pageobj.areas[pageobj.curareaindex].curindex=pageobj.areas[pageobj.curareaindex].datanum-2;
					     pageobj.areas[pageobj.curareaindex].areafocus(1);
					}
				   
			   }else  if(pageobj.curareaindex==2){
				    if((pageobj.areas[pageobj.curareaindex].curindex-1)>=0){
					     pageobj.areas[pageobj.curareaindex].areafocus(-1);
				    }else{
						
						 var tempcurpage=pageobj.areas[pageobj.curareaindex].curpage;
						 var temptotalpage=pageobj.areas[pageobj.curareaindex].pagenum;
						 
						 if(temptotalpage>1){
			                if((tempcurpage-1)<1)//2014/1/27 条件0改为1 
						    {
							  pageobj.areas[pageobj.curareaindex].curpage=pageobj.areas[pageobj.curareaindex].pagenum;
						    }
						    else
						    {
							   pageobj.areas[pageobj.curareaindex].curpage=tempcurpage-1;
							   
						    }
						     tvodlist=new Array();
							
							 tvodlist=getItmsByPage(totaltvodlist,pageobj.areas[pageobj.curareaindex].curpage,18);
							 pageobj.areas[pageobj.curareaindex].datanum=tvodlist.length;
							 bindTvodData();
						 }
						 pageobj.areas[pageobj.curareaindex].clearfocus();
						 pageobj.areas[pageobj.curareaindex].curindex=pageobj.areas[pageobj.curareaindex].datanum-2;
					     pageobj.areas[pageobj.curareaindex].areafocus(1);
					}
				   
			   }else  if(pageobj.curareaindex==3){
				   if((pageobj.areas[pageobj.curareaindex].curindex-1)>=0){
					   pageobj.areas[pageobj.curareaindex].areafocus(-1);				  
				   }else{
				      pageobj.areas[pageobj.curareaindex].clearfocus();
					  pageobj.curareaindex=0;
					  pageobj.areas[pageobj.curareaindex].curindex=pageobj.areas[pageobj.curareaindex].datanum-2;
					  pageobj.areas[pageobj.curareaindex].areafocus(1);
				   }		   
			   }
			   break;   
		   }
		   case 1:{
			    if(pageobj.curareaindex==1){
					  area0.areain();
					  pageobj.curareaindex=0;
			    }else if(pageobj.curareaindex==2){
				      area2.clearfocus();
					  pageobj.curareaindex=1;
				      area1.curindex=area1.stadyindex;
	                  $("divdate"+area1.curindex).className="item item_focus";
			    }
			    break; 
		   }
		   case 2:{
			    if(pageobj.curareaindex==0){
				  if((pageobj.areas[pageobj.curareaindex].curindex+1)<pageobj.areas[pageobj.curareaindex].datanum){
					   pageobj.curareaindex=0;
					   pageobj.areas[pageobj.curareaindex].areafocus(1);
					  
				  }else{
					  pageobj.areas[pageobj.curareaindex].clearfocus();
					  pageobj.curareaindex=3;
					  pageobj.areas[pageobj.curareaindex].curindex=-1;
					  pageobj.areas[pageobj.curareaindex].areafocus(1);
					  
					  
				  }
				   
			   }else  if(pageobj.curareaindex==1){
				    if((pageobj.areas[pageobj.curareaindex].curindex+1)<pageobj.areas[pageobj.curareaindex].datanum){
					     pageobj.areas[pageobj.curareaindex].areafocus(1);
				    }else{
						 pageobj.areas[pageobj.curareaindex].clearfocus();
						 pageobj.areas[pageobj.curareaindex].curindex=-1;
					     pageobj.areas[pageobj.curareaindex].areafocus(1);
					}
				   
			   }else  if(pageobj.curareaindex==2){
				   
				    if((pageobj.areas[pageobj.curareaindex].curindex+1)<pageobj.areas[pageobj.curareaindex].datanum){
						 pageobj.areas[pageobj.curareaindex].areafocus(1);
				    }else{
						 var tempcurpage=pageobj.areas[pageobj.curareaindex].curpage;
						 var temptotalpage=pageobj.areas[pageobj.curareaindex].pagenum;
						
						 if(temptotalpage>1){
			                if((tempcurpage+1)>temptotalpage)
						    {
							  pageobj.areas[pageobj.curareaindex].curpage=1;
						    }
						    else
						    {
							   pageobj.areas[pageobj.curareaindex].curpage=tempcurpage+1;
							   
						    }
						     tvodlist=new Array();
							
							 tvodlist=getItmsByPage(totaltvodlist,pageobj.areas[pageobj.curareaindex].curpage,18);
							 pageobj.areas[pageobj.curareaindex].datanum=tvodlist.length;
							 bindTvodData();
							
						 }
						 pageobj.areas[pageobj.curareaindex].clearfocus();
						 pageobj.areas[pageobj.curareaindex].curindex=-1;
						 //$("divchanneltxt"+0).innerHTML=pageobj.areas[pageobj.curareaindex].curpage;
					     pageobj.areas[pageobj.curareaindex].areafocus(1);
						 
					}
				   
			   }else  if(pageobj.curareaindex==3){
				   if((pageobj.areas[pageobj.curareaindex].curindex+1)<pageobj.areas[pageobj.curareaindex].datanum){
					   pageobj.areas[pageobj.curareaindex].areafocus(1);	  
				   }else{
				      pageobj.areas[pageobj.curareaindex].clearfocus();
					  pageobj.curareaindex=0;
					  pageobj.areas[pageobj.curareaindex].curindex=-1;
					  pageobj.areas[pageobj.curareaindex].areafocus(1);
				   }
				}
			   break;   
		   }
		   case 3:{
			    if(pageobj.curareaindex==0){
					 area0.areaout();
					 pageobj.curareaindex=1;
					 area1.areain();
			    }else if(pageobj.curareaindex==1){
				     area1.areaout();
					 pageobj.curareaindex=2;
					 area2.areain();
			    }
			    break; 
			 
		   }
		  
	  }
	  
  };
  
  
  
  area3.ok=function(){
	  var tempurl = "../../../../"+vaslist[area3.curindex].VARSURL//2014/1/27
	  parent.goToUrl(tempurl);
  };
  
  area3.areain=function(){
	
  };
  
  area3.areaout=function(){
	
  };
  
  area3.areafocus=function(stepvalue){
	  if(area3.curindex>=0 && area3.curindex<area3.datanum){
	    $("divvas"+area3.curindex).className="item";
	  }
	  area3.curindex=area3.curindex+stepvalue;
	  if(area3.curindex<0){
		  area3.curindex=0;
	  }
	  if(area3.curindex>=area3.datanum){
		  area3.curindex=area3.datanum-1;
	  }
	  pageobj.curindex=area3.curindex;
	  $("divvas"+area3.curindex).className="item item_focus";
  };
  area3.clearfocus=function(){
	 $("divvas"+area3.curindex).className="item";
  };
  
   //离开当前直播
   function stopChannel()
   {	
	 parent.mp.leaveChannel();
   }
  
   area0.ok=function(){
	    //加载视频
	    var tempchannel=channellist[area0.curindex];
		area0index=area0.curindex;
	    parent.mp.joinChannel(tempchannel.channelid);
		area0index=area0.curindex;
		parent.channelid=tempchannel.channelid;
		parent.area0index=area0index;
		parent.channelcode=tempchannel.channelcode;
	    $("topframe").style.display = "block";
		$("topframenum").innerHTML=tempchannel.channelid;
		getAJAXData("play_ControlChannelminiInfoajax.jsp?CHANNELID="+tempchannel.channelcode+"&pltvStatusFlag=1&CHANNELNUM="+tempchannel.channelid,init_info);
		clearTimeout(filmInfoTimer);
		filmInfoTimer = setTimeout("hiddenChannnum();", 5000);
   };
  
  area0.areain=function(){
	  $("divchannellist").style.display="none";
	  $("divtvodlist").style.display="none";
	  $("divchannel"+area0.stadyindex).className="item item_focus";
	  $("divchannelbtn"+area0.stadyindex).style.display="block";
	  pageobj.curareaindex=0;
  };
  
  area0.areaout=function(){
	  $("divchannellist").style.display="block";
	  $("divtvodlist").style.display="block";
	  area0.stadyindex=area0.curindex;
	  $("divchannel"+area0.curindex).className="item item_select";
	  $("divchannelbtn"+area0.curindex).style.display="none";
  };
  
  area0.areafocus=function(stepvalue){
	  if(area0.curindex>=0 && area0.curindex<area0.datanum){
	    $("divchannel"+area0.curindex).className="item";
		$("divchannelbtn"+area0.curindex).style.display="none";
	  }
	  area0.curindex=area0.curindex+stepvalue;
	  if(area0.curindex<0){
		  area0.curindex=0;
	  }
	  if(area0.curindex>=area0.datanum){
		  area0.curindex=area0.datanum-1;
	  }
	  pageobj.curindex=area0.curindex;
	  $("divchannel"+area0.curindex).className="item item_focus";
	  $("divchannelbtn"+area0.curindex).style.display="block";
	  $("logo").src = "../images/logo-"+channellist[area0.curindex].channelid+".png";//2014/1/27 台标切换
  };
  area0.clearfocus=function(){
	 $("divchannel"+area0.curindex).className="item";
	 $("divchannelbtn"+area0.curindex).style.display="none";
  };
  
  
  
  area1.ok=function(){
	  
	  
	  
  };
  
  
  
  function getProgramData(result)
  {
	 var re;
	 if(result.substring(0,1)!='{')
	 return;
	 re=eval('('+result+')');
	 tvodlist=new Array();
	 totaltvodlist=new Array();
     totaltvodlist=re.data;
	 area2.darkindex = re.livestart;
     var pageCount=Math.ceil(totaltvodlist.length/18);
	 area2.curpage=Math.ceil((area2.darkindex-1)/18);
	 if(area2.curpage==0)
		 area2.curpage = 1;
	 tvodlist=getItmsByPage(totaltvodlist,area2.curpage,18);
     area2.pagenum=pageCount;
	 area2.datanum=tvodlist.length;
	 bindTvodData();
	 clearBlankTimer();
  }
  
  var timergetprogrma=null;
  
  function ajaxGetProgram(){
	   var url = "playbacklistdata.jsp?channelId="+channellist[area0.stadyindex].channelcode + "&currarea=1&pageIndex="+1+"&currdate="+datelist[area1.curindex].date24;
	   getAJAXData(url,getProgramData);
 }
  
  
  area1.areain=function(){
	   area1.clearfocus();
	   area1.curindex=-1;
	   area1.areafocus(1)
	   pageobj.curareaindex=1;
	   var url = "playbacklistdata.jsp?channelId="+channellist[area0.stadyindex].channelcode + "&currarea=1&pageIndex="+area2.curpage+"&currdate="+datelist[area1.curindex].date24;
	   getAJAXData(url,getProgramData);
	   
	   
  };
  
  area1.areaout=function(){
	  area1.stadyindex=area1.curindex;
	  $("divdate"+area1.curindex).className="item item_select";
  };
  
  area1.areafocus=function(stepvalue){
	  if(area1.curindex>=0 && area1.curindex<area1.datanum){
	    $("divdate"+area1.curindex).className="item";
	  }
	  area1.curindex=area1.curindex+stepvalue;
	  if(area1.curindex<0){
		  area1.curindex=0;
	  }
	  if(area1.curindex>=area1.datanum){
		  area1.curindex=area1.datanum-1;
	  }
	  pageobj.curindex=area1.curindex;
	  clearTimeout(timergetprogrma);
	  timergetprogrma=setTimeout("ajaxGetProgram()",300);
	  
	  $("divdate"+area1.curindex).className="item item_focus";
   };
  
  
  
   area1.clearfocus=function(){
	 $("divdate"+area1.curindex).className="item";
   };
  
  
  area2.ok=function(){
	  //2014/1/27 如果是未播节目点击无反应
	  if(tvodlist[area2.curindex].LiveSTATUS==1)
		 return;
	 if(tvodlist[area2.curindex].LiveSTATUS==0)
	 {
		
		  //$("divdatetxt0").innerHTML=tempchannelid;
		  var tempchannelnum=channellist[area0.curindex].channelid;
		  // $("divdatetxt0").innerHTML=tempchannelnum;
		  var tmpSeq = "" + tempchannelnum;
		  var tmpStr = "";
		  if (tmpSeq.length == 1)
				tmpStr = "00";
		  if (tmpSeq.length == 2)
				tmpStr = "0";
		  var channelNumber = tmpStr + tmpSeq;
		  var tempchannelid=channellist[area0.curindex].channelcode;
		  parent.area0index=area0.curindex;
		  parent.area1index=area1.curindex;
		  parent.area2index=area2.curindex;
		  parent.channelcode=tempchannelid;
		  parent.channelid=channellist[area0.curindex].channelid;
		  //$("divdatetxt0").innerHTML=tempchannelid;
		  var temptourl="play_controlTVodJP.jsp?PROGID=" + tvodlist[area2.curindex].PROGRAMID + "&PLAYTYPE=4&CONTENTTYPE=300&&BUSINESSTYPE=5&PROGSTARTTIME=" + tvodlist[area2.curindex].STARTTIME + "&PROGENDTIME=" + tvodlist[area2.curindex].ENDTIME + "&ISSUB=1&PREVIEWFLAG=1&TVOD=1&CHANNELID=" + tempchannelid +"&LOGICCHANNELID="+tempchannelnum;
		 // $("divtvodtxt0").innerHTML=temptourl;
		 // $("divtvodtxt0").innerHTML="<marquee behavior='scroll' width='90%' startposition='90%'>"+temptourl+"</marquee>";
		  parent.goToUrl(temptourl);
	 }else{
		 area0.ok();
	 }
  };
  
  area2.areain=function(){
	   area2.clearfocus();
	   area2.curindex=-1;
	   var moveindex = area2.darkindex-(area2.curpage-1)*18-1;
	   area2.areafocus(moveindex);
	   pageobj.curareaindex=2;
  };
  
  area2.areaout=function(){
	  
	  
	  
  };
  
  area2.areafocus=function(stepvalue){  
	  if(area2.curindex>=0 && area2.curindex<area2.datanum){
		   if(tvodlist[area2.curindex]!=undefined&&tvodlist[area2.curindex].LiveSTATUS!=1){
			  $("divtvod"+area2.curindex).className = "item item_see";
		  }else{
			  $("divtvod"+area2.curindex).className = "item";
		  }
	    //$("divtvod"+area2.curindex).style.background="url()";
		if(tvodlist[area2.curindex].iscut==true){
			 $("divtvodtxt"+area2.curindex).innerHTML=tvodlist[area2.curindex].cutPROGNAME;
		}
	  }
	  area2.curindex=area2.curindex+stepvalue;
	  if(area2.curindex<0){
		  area2.curindex=0;
	  }
	  if(area2.curindex>=area2.datanum){
		  area2.curindex=area2.datanum-1;
	  }
	  pageobj.curindex=area2.curindex;
	  if(tvodlist[area2.curindex]!=undefined&&tvodlist[area2.curindex].LiveSTATUS!=1){
		  $("divtvod"+area2.curindex).className = "item item_see item_focus";
	  }else{
		  $("divtvod"+area2.curindex).className = "item item_focus";
	  }
	 // $("divtvod"+area2.curindex).style.background="url(../images/list-b_focus.png) no-repeat";
	  //$("divtvodtxt"+area2.curindex).style="font-size:26px;";
	  if(tvodlist[area2.curindex].iscut==true){
       $("divtvodtxt"+area2.curindex).innerHTML="<marquee behavior='scroll' width='90%' startposition='90%'>"+tvodlist[area2.curindex].PROGNAME+"</marquee>";
	  }
	  
  };
  
   area2.clearfocus=function(){
	  if(tvodlist[area2.curindex]!=undefined&&tvodlist[area2.curindex].LiveSTATUS!=1){
		  $("divtvod"+area2.curindex).className = "item item_see";
	  }else{
		  $("divtvod"+area2.curindex).className = "item";
	  }
	 //$("divtvod"+area2.curindex).style.background="url()";
	 //$("divtvodtxt"+area2.curindex).style="";
	 if(area2.curindex<tvodlist.length) $("divtvodtxt"+area2.curindex).innerHTML=tvodlist[area2.curindex].cutPROGNAME;
   };
  
 
  
  
  
  //返回dom对象
  function $(elementid){
	  return document.getElementById(elementid);  
  }
  
  
 
 

 



	  // JScript 文件
	var	KEY_TV_IPTV=1290;
	var	KEY_POWEROFF=1291;
	var	KEY_SUBTITLE=1292;
	var	KEY_BOOKMARK =1293;
	var	KEY_PIP=1294;
	var KEY_LOCAL=1295;
	var KEY_REFRESH=1296;
	var KEY_SETUP=282;
	var KEY_HOME=292;
	var KEY_BACK = 8;
	var KEY_DELETE  = 280;
	var KEY_ENTER=13;
	var KEY_OK =13;
	var KEY_HELP = 284;
	var KEY_LEFT=37;
	var KEY_UP=38;
	var KEY_RIGHT=39;
	var KEY_DOWN=40;
	var KEY_PAGEUP = 33;
	var KEY_PAGEDOWN = 34;
	var KEY_0 = 48;
	var KEY_1 = 49;
	var KEY_2 = 50;
	var KEY_3 = 51;
	var KEY_4 = 52;
	var KEY_5 = 53;
	var KEY_6 = 54;
	var KEY_7 = 55;
	var KEY_8 = 56;
	var KEY_9 = 57;
	var KEY_CHANNELUP = 257;
	var KEY_CHANNELDOWN = 258;
	var KEY_VOLUP = 259;
	var KEY_VOLDOWN =260;
	var KEY_MUTE =261;
	var KEY_PLAY=263;
	var KEY_PAUSE=263;
	var KEY_SEEK=271;
	var KEY_SWITCH = 280;
	var KEY_FAVORITE = 281;
	var KEY_AUDIOCHANNEL=286;
	var KEY_IME= 283;
	var KEY_FASTFORWARD=264;
	var KEY_FASTREWIND=265;
	var KEY_SEEKEND=266;
	var KEY_SEEKBEGIN=267;
	var KEY_STOP=270;
	var KEY_MENU=290;
	//var KEY_RED = 275;
	//var KEY_GREEN = 276;
	//var KEY_YELLOW = 277;
	var KEY_RED = 1108;
	var KEY_GREEN = 1110;
	var KEY_YELLOW = 1109;
	var KEY_BLUE =278 ;
	var KEY_STAR=106;
	var KEY_SHARP=105;
	var KEY_F1 = 291;
	var KEY_F2 = 292;
	var KEY_F3 = 293;
	var KEY_F4 = 294;
	var KEY_F5 = 295;
	var KEY_F6 = 296;
	
	//事件 规范是0x300
	var KEY_EVENT= 768;
	
	//document.onirkeypress = keyEvent;
	//document.onkeypress = keyEvent;
	function keyEvent()
	{
		var val = event.which ? event.which : event.keyCode;
		return keypress(val);
	}
	function keypress(keyval)
	{
		switch(keyval)
		{
		
			case 87: //up
			case KEY_UP:			
				pageobj.move(0);
				break;
			case 65: //left
			case KEY_LEFT: 
				pageobj.move(1);
				break;
			case 83: //down
			case KEY_DOWN:
				pageobj.move(2);
				break;
			case 68: //right
			case KEY_RIGHT: //right
				pageobj.move(3);
				break;
			case 13:
			case KEY_OK: //enter
				pageobj.ok();
				break;
			case 32:    // 空格
			case KEY_BACK:
				pageobj.goBack();
				break;
			case KEY_PAGEUP:
				pageobj.pageTurn(-1);
				break;
			case KEY_PAGEDOWN:
				pageobj.pageTurn(1);
				break;
		    default:return 0;
		}
		return 0;
	}


</script>


</head>

<body bgcolor="transparent">

<!--pagebg-->

<!--pagebg the end-->
<div id="topframe" style="position:absolute;left:925px; top:8px; width:300px; height:70px; z-index:1"><table width="400" height="70"><tr align="center"><td style="color:#006600;font-size:40px;" id="topframenum"></td></tr></table></div>
</div>


<div class="wrapper">
	<!--left-->	
	<div class="hd-left">
		<div class="logo"><img id="logo" src="../images/logo-13.png" /></div>
		<div class="nav">
			<!--焦点 
					class="item item_focus"
				选中 
					class="item item_select"
			-->
			<div id="divchannel0" class="item">
				<div class="txt" id="divchanneltxt0"></div>
			</div>
            <div class="btn" id="divchannelbtn0" style="display:none">回看</div>
			<div  id="divchannel1" class="item" style="top:35px;">
				<div class="txt" id="divchanneltxt1"></div>
			</div>
            <div class="btn" id="divchannelbtn1" style="top:47px;display:none">回看</div>
			<div id="divchannel2" class="item" style="top:70px;">
				<div class="txt" id="divchanneltxt2"></div>
			</div>
            <div class="btn" id="divchannelbtn2" style="top:82px;display:none">回看</div>
			<div id="divchannel3" class="item" style="top:105px;">
				<div class="txt" id="divchanneltxt3"></div>
			</div>
            <div class="btn" id="divchannelbtn3" style="top:118px;display:none">回看</div>
		</div>
		
		<div class="poster">
			<!--焦点 
					class="item item_focus"
				-->
			<div class="item" id="divvas0">
				<div class="pic"><img id="divvasimg0"/></div>
			</div>
			<div class="item" id="divvas1" style="top:98px;">
				<div class="pic"><img id="divvasimg1"/></div>
			</div>
		</div>
	</div>	
	<!--left the end-->		
	
	
	
	<!--mid the end-->	
	<div class="hd-mid" id="divchannellist" style="display:none">
		<div class="nav-b">
			<!--焦点 
					class="item item_focus"
				选中 
					class="item item_select"
			-->
			<div id="divdate0" class="item">
				<div id="divdatetxt0" class="txt"></div>
			</div>
			<div id="divdate1" class="item" style="top:35px;">
				<div id="divdatetxt1" class="txt"></div>
			</div>
			<div id="divdate2" class="item" style="top:70px;">
				<div id="divdatetxt2" class="txt"></div>
			</div>
			<div id="divdate3" class="item" style="top:105px;">
				<div id="divdatetxt3" class="txt"></div>
			</div>
			<div id="divdate4" class="item" style="top:140px;">
				<div id="divdatetxt4" class="txt"></div>
			</div>
			<div id="divdate5" class="item" style="top:175px;">
				<div id="divdatetxt5" class="txt"></div>
			</div>
			<div id="divdate6" class="item" style="top:210px;">
				<div id="divdatetxt6" class="txt"></div>
			</div>
			<div id="divdate7" class="item" style="top:245px;">
				<div id="divdatetxt7" class="txt"></div>
			</div>
		</div>
	</div>
	<!--mid the end-->
	
	
	
	<!--list-->
	<div class="list-warp" id="divtvodlist" style="display:none">
		<div class="btn btn-up">
			<!--焦点 
					class="item item_focus"
			-->
			<div id="pageUp" class="item"></div>
		</div>
		
		<div class="list-b">
			<!--焦点 
					class="item item_focus"
				已看 
					class="item item_see"
			-->
			<div class="item item_see" id="divtvod0">
				<div class="txt txt-time" id="divtvoddate0"></div>
				<div class="txt" id="divtvodtxt0"></div>
			</div>
			<div class="item" style="top:30px;"  id="divtvod1">
				<div class="txt txt-time" id="divtvoddate1"></div>
				<div class="txt" id="divtvodtxt1"></div>
			</div>
			<div class="item" style="top:60px;" id="divtvod2">
				<div class="txt txt-time" id="divtvoddate2"></div>
				<div class="txt" id="divtvodtxt2"></div>
			</div>
			<div class="item" style="top:90px;" id="divtvod3">
				<div class="txt txt-time" id="divtvoddate3"></div>
				<div class="txt" id="divtvodtxt3"></div>
			</div>
			<div class="item" style="top:120px;" id="divtvod4">
				<div class="txt txt-time" id="divtvoddate4"></div>
				<div class="txt" id="divtvodtxt4"></div>
			</div>
			<div class="item" style="top:150px;" id="divtvod5">
				<div class="txt txt-time" id="divtvoddate5"></div>
				<div class="txt" id="divtvodtxt5"></div>
			</div>
			<div class="item" style="top:180px;" id="divtvod6">
				<div class="txt txt-time" id="divtvoddate6"></div>
				<div class="txt" id="divtvodtxt6"></div>
			</div>
			<div class="item" style="top:210px;" id="divtvod7">
				<div class="txt txt-time" id="divtvoddate7"></div>
				<div class="txt" id="divtvodtxt7"></div>
			</div>
			<div class="item" style="top:240px;" id="divtvod8">
				<div class="txt txt-time" id="divtvoddate8"></div>
				<div class="txt" id="divtvodtxt8"></div>
			</div>
			<div class="item" style="top:270px;" id="divtvod9">
				<div class="txt txt-time" id="divtvoddate9"></div>
				<div class="txt" id="divtvodtxt9"></div>
			</div>
			<div class="item" style="top:300px;" id="divtvod10">
				<div class="txt txt-time" id="divtvoddate10"></div>
				<div class="txt" id="divtvodtxt10"></div>
			</div>
			<div class="item" style="top:330px;" id="divtvod11">
				<div class="txt txt-time" id="divtvoddate11"></div>
				<div class="txt" id="divtvodtxt11"></div>
			</div>
			<div class="item" style="top:360px;" id="divtvod12">
				<div class="txt txt-time" id="divtvoddate12"></div>
				<div class="txt" id="divtvodtxt12"> </div>
			</div>
			<div class="item" style="top:390px;" id="divtvod13">
				<div class="txt txt-time" id="divtvoddate13"></div>
				<div class="txt" id="divtvodtxt13"> </div>
			</div>
			<div class="item" style="top:420px;" id="divtvod14">
				<div class="txt txt-time" id="divtvoddate14"></div>
				<div class="txt" id="divtvodtxt14"></div>
			</div>
			<div class="item" style="top:450px;" id="divtvod15">
				<div class="txt txt-time" id="divtvoddate15"></div>
				<div class="txt" id="divtvodtxt15"></div>
			</div>
			<div class="item" style="top:480px;" id="divtvod16">
				<div class="txt txt-time" id="divtvoddate16"></div>
				<div class="txt" id="divtvodtxt16"></div>
			</div>
			<div class="item" style="top:510px;" id="divtvod17">
				<div class="txt txt-time" id="divtvoddate17"></div>
				<div class="txt" id="divtvodtxt17"></div>
			</div>
		</div>
		
		<div class="btn btn-down">
			<!--焦点 
					class="item item_focus"
			-->
			<div id="pageDown" class="item"></div>
		</div>
		
	</div>	
	<!--list the end-->	

	<div id="filmInfo" class="list" style="display:none">
		<div id="progName_0" class="txt txt-on"></div>
		<div id="progName_1" class="txt" style="top:123px;"></div>
		<div id="progName_2" class="txt" style="top:155px;"></div>
	</div>
	
</div>

</body>
</html>
