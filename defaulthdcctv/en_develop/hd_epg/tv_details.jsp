<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="datajsp/save_focus.jsp"%>
<%@ include file="datajsp/util_getPosterPaths.jsp"%>
<%
	String path = request.getRequestURI().substring(0,request.getRequestURI().lastIndexOf("/")+1);   
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;

	String returnurl = request.getParameter("returnurl")==null?"HD_index.jsp":request.getParameter("returnurl");
	String vodid = request.getParameter("vodid")==null?"0":request.getParameter("vodid");

	MetaData metadata = new MetaData(request);
	ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
	
	JSONArray jsonList = null;
	ArrayList tempList = new ArrayList();
	HashMap tempMap = new HashMap();
	HashMap detailMap = (HashMap)metadata.getVodDetailInfo(Integer.parseInt(vodid));
	HashMap posterMap = (HashMap)(detailMap.get("POSTERPATHS"));
	String tempvodid = detailMap.get("VODID").toString();
	int contentType = (Integer)detailMap.get("CONTENTTYPE");
	tempMap.put("CONTENTTYPE",contentType);
	tempMap.put("VODID",tempvodid);
	if(detailMap.get("VODNAME") != null){
		String vodname = detailMap.get("VODNAME").toString();
		tempMap.put("VODNAME",vodname);
		}else{
			tempMap.put("VODNAME","暂无信息");
			}
	
	if(detailMap.get("DIRECTOR") != null){
		String DIRECTOR = detailMap.get("DIRECTOR").toString();// 导演名字
		tempMap.put("DIRECTOR",DIRECTOR);
		}else{
			tempMap.put("DIRECTOR","暂无信息");
			}
	
	HashMap castMap = (HashMap)detailMap.get("CASTMAP");	
	if(castMap!=null&&castMap.get(6)!=null)
	{
		String[] tempCasts = (String[])castMap.get(6);
		StringBuffer actor = new StringBuffer();
		for(String str : tempCasts){
			actor.append(","+str.trim());
		}
		tempMap.put("ACTOR","".equals(actor.toString())?"暂无信息":actor.toString().substring(1));		
	}

	if(detailMap.get("ISASSESS") != null){
		String ISASSESS = detailMap.get("ISASSESS").toString();//片花
		tempMap.put("ISASSESS",ISASSESS);
		}else{
			tempMap.put("ISASSESS","-1");
			}	
	if(detailMap.get("INTRODUCE") != null){
		String INTRODUCE = detailMap.get("INTRODUCE").toString();//节目简介
		tempMap.put("INTRODUCE",INTRODUCE);
		}else{
			tempMap.put("INTRODUCE","暂无信息");
			}
	
	if(detailMap.get("SITCOMNUM") != null){
		String SITCOMNUM = detailMap.get("SITCOMNUM").toString();//集数
		tempMap.put("SITCOMNUM",SITCOMNUM);
		}else{
			tempMap.put("SITCOMNUM","0");
			}
	ArrayList subVodIdList = (ArrayList)detailMap.get("SUBVODIDLIST");
	tempMap.put("SUBVODIDLIST",subVodIdList);
	ArrayList subVodNumList = (ArrayList)detailMap.get("SUBVODNUMLIST");
	tempMap.put("SUBVODNUMLIST",subVodNumList);
	if(posterMap!=null){
		//0.缩略图1.海报2.剧照3.图标4.标题图5.广告图6.草图7.背景9.频道图99.其他
		String picUrl = getPosterPath(posterMap,"images/demopic/pic-173X231.jpg","1",request);
		tempMap.put("PICURL",picUrl);	
		 }
	tempList.add(tempMap);
	jsonList = JSONArray.fromObject(tempList);
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>电视剧详情-深圳高清院线专区EPG3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="css/HDstyle.css" />
<style type="text/css">
<!--
	body{ background:url(images/bg05.jpg) no-repeat;}
-->
</style>
<script type="text/javascript" src="js/pagecontrol_1.0.4.js"></script>
<script type="text/javascript">
	var returnurl = "<%=returnurl%>";
	var datajson = <%=jsonList%>;
	var vodIdList = new Array();
	var vodNumList = new Array();
	var area0,area1,area2;
/*	var areaid = 1;
	var indexid = 0;
	var cruntpage="";*/
	var areaid = '<%=request.getParameter("areaid")==null?"1":request.getParameter("areaid")%>';
	var indexid = '<%=request.getParameter("indexid")==null?"0":request.getParameter("indexid")%>';
	var cruntpage='<%=request.getParameter("cruntpage")==null?"1":request.getParameter("cruntpage")%>';
	var vodnum = 0;
	var ISassess = datajson[0].ISASSESS;
	var temppageTurnVodIdList=new Array();
	var temppageTurnList=new Array()
	var isbookmark;
	var begintime;
	var endtime;
	var progId;
	window.onload=function(){
		if(datajson[0].SUBVODIDLIST.length > 0)
		{
			vodIdList = datajson[0].SUBVODIDLIST;
			vodNumList = datajson[0].SUBVODNUMLIST;
			temppageTurnVodIdList = vodIdList;
		}
		area0=AreaCreator(1,2,new Array(-1,-1,1,-1),"area0_list_","className:item item_focus","className:item");
		area0.areaOkEvent = function()
		{
			if(area0.curindex==0)
			{
				area1.curpage=area1.curpage+1>area1.pagecount?area1.pagecount:area1.curpage+1;
				turnpageShowData(area1.curpage);
				$("area1_list_"+area1.curindex).className="item";
			}
			else if(area0.curindex==1)
			{
				area1.curpage=area1.curpage-1>1?area1.curpage-1:1;
				turnpageShowData(area1.curpage);
				$("area1_list_"+area1.curindex).className="item";
			}
			
		}
		
		
		        
				
				
		area1=AreaCreator(2,15,new Array(0,-1,2,-1),"area1_list_","className:item item_focus","className:item");
		area1.pagecount = Math.ceil(vodNumList.length/30);
		area1.areaOkEvent = function()
	    {
			progId = temppageTurnVodIdList[area1.curindex];
			$('hidden_frame').src = "check_bookmark.jsp?vodid="+progId;
		}
		/*area1.asyngetdata=function()
		{
			//turnpageShowData(this.curpage)
			
		}*/
		
		area2=AreaCreator(1,2,new Array(1,-1,-1,-1),"area2_list_","className:item item_focus","className:item");
		if(ISassess == 0 || ISassess == -1){
			area2.doms[0].setCanFocus(false,1);
			$("prewIcon").style.backgroundImage="url(images/iconGray01.png)";
			}
		area2.areaOkEvent = function(){
			if(area2.curindex == 0 && ISassess == 1){
				/*
				var play_url = "../play_controlVod.jsp?PROGID="+progId+"&FATHERSERIESID="+datajson[0].VODID+"&PLAYTYPE=5&BEGINTIME=0&PRODUCTID=0&SERVICEID=0&ONECEPRICE=0&CONTENTTYPE=10&returnurl="+escape("hd_epg/tv_details.jsp?areaid=1&indexid="+area1.curindex+"&cruntpage="+area1.curpage+"&vodid="+datajson[0].VODID+"&returnurl="+returnurl);*/
				var play_url = "../au_PlayFilm.jsp?PROGID="+progId;
				  play_url+="&FATHERSERIESID="+datajson[0].VODID;
				  play_url+="&CONTENTTYPE="+datajson[0].CONTENTTYPE;
				  play_url+="&BUSINESSTYPE=1";
				  play_url+="&PLAYTYPE=5&ISVIP=1";
				  play_url+="&returnurl="+escape("<%=basePath%>tv_details.jsp?areaid=1&indexid="+area1.curindex+"&cruntpage="+area1.curpage+"&vodid="+datajson[0].VODID+"&returnurl="+returnurl);
		window.location.href=play_url;
				}else{
					window.location.href = returnurl;
					}
			}
			
	
	   
		 if(focusObj!=undefined&&focusObj!="null")
		{
			areaid = parseInt(focusObj[0].areaid);
			indexid = parseInt(focusObj[0].curindex);
			cruntpage = parseInt(focusObj[0].curpage);
		}
		
		pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area0,area1,area2),null);
		pageobj.backurl = returnurl;
		  showData(datajson);
}
				
	function showData(data)
	{
		if(data[0]!=null)
		{
			$("vodname").innerHTML = data[0].VODNAME;
			$("daoyan").innerHTML =  "<span>导演：</span>" + data[0].DIRECTOR;
			$("yanyuan").innerHTML = "<span>演员：</span>" + data[0].ACTOR; 
			var message = data[0].INTRODUCE;
			if(message.length > 100){message = message.substring(0,100)+"......"}
			$("message").innerHTML = message;
			$("vodpic").src = "../"+data[0].PICURL; 
		}
		
		if(cruntpage!=""&&cruntpage!=1)
		{
			area1.curpage = cruntpage;
			turnpageShowData(area1.curpage);
		}
		else
		{
			bandSubList(vodNumList);
		}
	}


function bandSubList(dataValue)
{
	area1.setpageturndata(dataValue.length, area1.pagecount);
	//document.getElementById("testText").innerHTML=datavalue.length;
	for(i=0;i<area1.doms.length;i++)
	{
	   if(i<dataValue.length)
	   {
		   $("area1_list_"+i).innerHTML=dataValue[i];
		   $("area1_list_"+i).style.display="block";
	   }
	   else
	   {
		   $("area1_list_"+i).innerHTML="";
		   $("area1_list_"+i).style.display="none";
	   }
	}
	if(dataValue.length>0)
	{ 
	    $("pagecontent").innerHTML = area1.curpage+"/"+area1.pagecount;
	}
	else
	{
		$("pagecontent").innerHTML = "";
	}

}
function checksubscribe(jsonResult)
{
	//alert(jsonResult);
	var jsonResult = eval('('+jsonResult+')');
	//jsonResult.ALLOWPLAY=false;
	
	if(jsonResult.ALLOWPLAY==false)
	{
		var play_url = "../play_controlVod.jsp?PROGID="+progId+"&FATHERSERIESID="+datajson[0].VODID+"&PLAYTYPE=1&BEGINTIME=0&PRODUCTID=0&SERVICEID=0&ONECEPRICE=0&CONTENTTYPE=10&returnurl="+escape("hd_epg/tv_details.jsp?areaid=1&indexid="+area1.curindex+"&cruntpage="+area1.curpage+"&vodid="+datajson[0].VODID+"&returnurl="+returnurl);
		var pageName="order.jsp?SUBJECTID=-1&VODID="+datajson[0].VODID+"&FATHERID="+datajson[0].VODID+"&PLAYTYPE=1&CONTENTTYPE="+datajson[0].CONTENTTYPE+"&BUSINESSTYPE=1&returnurl="+escape(location.href)+"&playurl="+escape(play_url);
		/*$("vodIntroduce").innerHTML = "<marquee>"+pageName+"</marquee>";
		return;*/
		location.href = pageName;
	}
	else
	{
		var play_url = "../play_controlVod.jsp?PROGID="+progId+"&FATHERSERIESID="+datajson[0].VODID+"&PLAYTYPE=1&BEGINTIME=0&PRODUCTID=0&SERVICEID=0&ONECEPRICE=0&CONTENTTYPE=10&returnurl="+escape("hd_epg/tv_details.jsp?areaid=1&indexid="+area1.curindex+"&cruntpage="+area1.curpage+"&vodid="+datajson[0].VODID+"&returnurl="+returnurl);
		window.location.href=play_url;
	}
}	
function checksubscribe1(jsonResult)
{
	//alert(jsonResult);
	var jsonResult = eval('('+jsonResult+')');
	//jsonResult.ALLOWPLAY=false;
	
	if(jsonResult.ALLOWPLAY==false)
	{
		var play_url = "../play_controlVod.jsp?PROGID="+progId+"&FATHERSERIESID="+datajson[0].VODID+"&PLAYTYPE=1&BEGINTIME="+begintime+"&ENDTIME="+endTime+"&PRODUCTID=0&SERVICEID=0&ONECEPRICE=0&CONTENTTYPE=10&returnurl="+escape("hd_epg/tv_details.jsp?areaid=1&indexid="+area1.curindex+"&cruntpage="+area1.curpage+"&vodid="+datajson[0].VODID+"&returnurl="+returnurl);
		var pageName="order.jsp?SUBJECTID=-1&VODID="+progId+"&FATHERID="+datajson[0].VODID+"&PLAYTYPE=1&CONTENTTYPE="+datajson[0].CONTENTTYPE+"&BUSINESSTYPE=1&returnurl="+escape(location.href)+"&playurl="+escape(play_url);
		location.href = pageName;
	}
	else
	{
		var play_url = "../play_controlVod.jsp?PROGID="+progId+"&FATHERSERIESID="+datajson[0].VODID+"&PLAYTYPE=1&BEGINTIME="+begintime+"&ENDTIME="+endTime+"&PRODUCTID=0&SERVICEID=0&ONECEPRICE=0&CONTENTTYPE=10&returnurl="+escape("hd_epg/tv_details.jsp?areaid=1&indexid="+area1.curindex+"&cruntpage="+area1.curpage+"&vodid="+datajson[0].VODID+"&returnurl="+returnurl);
		window.location.href=play_url;
	}
}
function turnpageShowData(cruntpageNUM)
{
	var pageTurnDataList=new Array();
	temppageTurnVodIdList=new Array()
	if(vodNumList.length>30)
	{
		 var start = (cruntpageNUM-1)*30;
		 var size = (vodNumList.length-start)>=30?30:(vodNumList.length-start);
		 for(i=0;i<size;i++)
		 {
			pageTurnDataList[i]=vodNumList[start+i];
			temppageTurnVodIdList[i]=vodIdList[start+i]
		 }
		 bandSubList(pageTurnDataList);
	}
	temppageTurnList = pageTurnDataList;
}		

//查找书签
function checkBookmark(subVoddetailInfo){
	saveFocstr(pageobj);
	isbookmark = subVoddetailInfo.ISBOOKMARK;
	begintime = subVoddetailInfo.BEGINTIME;
	endtime = subVoddetailInfo.ENDTIME;
	progId = temppageTurnVodIdList[area1.curindex];
	//document.getElementById("testText").innerHTML=progId+"---"+datajson[0].VODID;
	if(isbookmark==true){  //判断是否有书签
		progId = temppageTurnVodIdList[area1.curindex];
		var play_url = "../au_PlayFilm.jsp?PROGID="+progId;
				  play_url+="&FATHERSERIESID="+datajson[0].VODID;
				  play_url+="&CONTENTTYPE="+datajson[0].CONTENTTYPE;
				  play_url+="&BUSINESSTYPE=1";
				  play_url+="&PLAYTYPE=1&ISVIP=1";
				  play_url+="&BEGINTIME="+begintime+"&ENDTIME="+endTime;
				  play_url+="&returnurl="+escape("<%=basePath%>tv_details.jsp?areaid=1&indexid="+area1.curindex+"&cruntpage="+area1.curpage+"&vodid="+datajson[0].VODID+"&returnurl="+returnurl);
		window.location.href=play_url;
	}
	else
	{
		progId = temppageTurnVodIdList[area1.curindex];
		var play_url = "../au_PlayFilm.jsp?PROGID="+progId;
				  play_url+="&FATHERSERIESID="+datajson[0].VODID;
				  play_url+="&CONTENTTYPE="+datajson[0].CONTENTTYPE;
				  play_url+="&BUSINESSTYPE=1";
				  play_url+="&PLAYTYPE=1&ISVIP=1";
				  play_url+="&returnurl="+escape("<%=basePath%>tv_details.jsp?areaid=1&indexid="+area1.curindex+"&cruntpage="+area1.curpage+"&vodid="+datajson[0].VODID+"&returnurl="+returnurl);
		window.location.href=play_url;
	}
}

          
		  
		  
		  		
</script>
</head>

<body>

<!--head-->
<div class="logo">
	<div class="pic"><img src="images/logo.png" /></div>
</div>
<div class="adfont"><img src="images/adfont.png" /></div>
<!--head the end-->	


<!--left list-->	
	<!--info-->
	<div class="details">
		<div id="vodname" class="txt txt-title">龙门镖局</div>
		<div class="pic" style="top:35px;"><img src="../images/line.png" /></div>
		<div id="daoyan" class="txt txt-info" style="top:58px;"><span>导演：</span>王勇</div>
		<div id="yanyuan" class="txt txt-info" style="top:94px;"><span>演员：</span>袁咏仪  李倩  郭京飞  钱芳  刘冠麟  杨皓宇  张瑞涵</div>
		<div class="txt txt-info" style="top:130px;"><span>剧情：</span></div>
		<div id="message" class="txt txt-info" style="top:130px; left:93px; width:650px;">龙门镖局本是束河镇赫赫有名的镖局，在原来的当家佟镖头死后却负债累累水果贩子蔡八斗为了挣钱，到龙门镖局去讨债，却中了圈套，和平安票号的少主陆三金一同被关了起来。两人与镖局
	    的遗孀盛秋月、镖师温良恭、大夫邱璎珞.....</div>
	</div>
	
	<!--pages-->
	<div class="pages-a">
		<!--焦点 
			class="item item_focus"
		-->
		<div id="area0_list_0" class="item">
			<div class="icon"><img src="../images/icon-arrow-r.png" /></div>
			<div class="txt">下页</div>
		</div>
		<div id="pagecontent" class="txt txt-num"></div>
		<div id="area0_list_1" class="item" style="left:138px;">
			<div class="icon"><img src="../images/icon-arrow-l.png" /></div>
			<div class="txt">上页</div>
		</div>
	</div>
	
	<!--set-->
	<div class="tv-num">
		<!--焦点 
			class="item item_focus"
		-->
		<div id="area1_list_0" class="item"></div>
		<div id="area1_list_1" class="item" style="left:45px;"></div>
		<div id="area1_list_2" class="item" style="left:90px;"></div>
		<div id="area1_list_3" class="item" style="left:135px;"></div>
		<div id="area1_list_4" class="item" style="left:180px;"></div>
		<div id="area1_list_5" class="item" style="left:225px;"></div>
		<div id="area1_list_6" class="item" style="left:270px;"></div>
		<div id="area1_list_7" class="item" style="left:315px;"></div>
		<div id="area1_list_8" class="item" style="left:360px;"></div>
		<div id="area1_list_9" class="item" style="left:405px;"></div>
		<div id="area1_list_10" class="item" style="left:450px;"></div>
		<div id="area1_list_11" class="item" style="left:495px;"></div>
		<div id="area1_list_12" class="item" style="left:540px;"></div>
		<div id="area1_list_13" class="item" style="left:585px;"></div>
		<div id="area1_list_14" class="item" style="left:630px;"></div>
		
		<div id="area1_list_15" class="item" style="top:48px;"></div>
		<div id="area1_list_16" class="item" style="left:45px;top:48px;"></div>
		<div id="area1_list_17" class="item" style="left:90px;top:48px;"></div>
		<div id="area1_list_18" class="item" style="left:135px;top:48px;"></div>
		<div id="area1_list_19" class="item" style="left:180px;top:48px;"></div>
		<div id="area1_list_20" class="item" style="left:225px;top:48px;"></div>
		<div id="area1_list_21" class="item" style="left:270px;top:48px;"></div>
		<div id="area1_list_22" class="item" style="left:315px;top:48px;"></div>
		<div id="area1_list_23" class="item" style="left:360px;top:48px;"></div>
		<div id="area1_list_24" class="item" style="left:405px;top:48px;"></div>
		<div id="area1_list_25" class="item" style="left:450px;top:48px;"></div>
		<div id="area1_list_26" class="item" style="left:495px;top:48px;"></div>
		<div id="area1_list_27" class="item" style="left:540px;top:48px;"></div>
		<div id="area1_list_28" class="item" style="left:585px;top:48px;"></div>
		<div id="area1_list_29" class="item" style="left:630px;top:48px;"></div>
	</div>
<!--left list the end-->	


	
<!--r poster-->	
<div class="poster-e">
	<!--焦点 
		class="item item_focus"
	-->
	<div class="item item_focus">
		<div class="pic"><img id="vodpic" src="#" /></div>
	</div>
</div>
<!--r poster the end-->		
	
	
	
<!--btns-->	
<div class="btn-a">
	<!--焦点 
			class="item item_focus"
		-->
	<div id="area2_list_0" class="item">
		<div class="icon icon01" id="prewIcon"></div>
		<div class="txt">预览</div>
	</div>
	<div id="area2_list_1" class="item" style="left:100px;">
		<div class="icon icon02"></div>
		<div class="txt">返回</div>
	</div>
</div>
<!--btns the end-->
<div id="testText" style="color:#F00; position:absolute; left: 319px; top: 182px; width: 438px; height: 82px;"></div>			
<iframe name="hidden_frame" id="hidden_frame" style="display: none" width="1" height="1"></iframe>	
</body>
</html>
