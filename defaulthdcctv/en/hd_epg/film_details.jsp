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
<%@ include file = "datajsp/query_IsHasBookMark.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="datajsp/save_focus.jsp"%>
<%@ include file="datajsp/util_getPosterPaths.jsp"%>
<%
	String returnurl = request.getParameter("returnurl")==null?"":request.getParameter("returnurl");
	String vodid = request.getParameter("vodid")==null?"0":request.getParameter("vodid");

	MetaData metadata = new MetaData(request);
	ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
	
	JSONArray jsonList = null;
	ArrayList tempList = new ArrayList();
	HashMap tempMap = new HashMap();
	HashMap detailMap = (HashMap)metadata.getVodDetailInfo(Integer.parseInt(vodid));
	System.out.print(detailMap);
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
	if(detailMap.get("INTRODUCE") != null){
		String INTRODUCE = detailMap.get("INTRODUCE").toString();//节目简介
		tempMap.put("INTRODUCE",INTRODUCE);
		}else{
			tempMap.put("INTRODUCE","暂无信息");
			}
	if(detailMap.get("ISASSESS") != null){
		String ISASSESS = detailMap.get("ISASSESS").toString();//片花
		System.out.println("============ISASSESS===================== "+ISASSESS+" ========END");
		tempMap.put("ISASSESS",ISASSESS);
		}else{
			tempMap.put("ISASSESS","-1");
			}
	
	if(posterMap!=null){
		//0.缩略图1.海报2.剧照3.图标4.标题图5.广告图6.草图7.背景9.频道图99.其他
		String picUrl = getPosterPath(posterMap,"images/demopic/pic-173X231.jpg","1",request);
		tempMap.put("PICURL",picUrl);	
		 }
		 
	HashMap isbm_result = isHasBookMark(tempMap.get("VODID").toString(),request);
	Boolean isbookmark = new Boolean("False");  //是否包含书签
	String begintime = "";  //开始时间
	String endtime = "";    //结束时间
	if(isbm_result!=null){
		isbookmark = new Boolean(isbm_result.get("ISBOOKMARK").toString());
		begintime = isbm_result.get("BEGINTIME").toString();
		endtime = isbm_result.get("ENDTIME").toString();
	}
	tempMap.put("ISBOOKMARK",isbookmark);
	tempMap.put("BEGINTIME",begintime);
	tempMap.put("ENDTIME",endtime);
	tempList.add(tempMap);
	jsonList = JSONArray.fromObject(tempList);
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>电影详情-深圳高清院线专区EPG3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="css/HDstyle.css" />
<style type="text/css">
<!--
	body{ background:url(images/bg05.jpg) no-repeat;}
-->
</style>
<script type="text/javascript" src="js/cookie.js"></script>
<script type="text/javascript" src="js/pagecontrol_1.0.4.js"></script>
<script type="text/javascript">
	var returnurl = unescape("<%=returnurl%>");
	var datajson = <%=jsonList%>;
	var area0;
	var areaid = 0;
	var indexid = 1;
	var ISassess = datajson[0].ISASSESS;
	var isBookMark=datajson[0].ISBOOKMARK;
	var beginTime = datajson[0].BEGINTIME;
	var endTime = datajson[0].ENDTIME;
	window.onload=function(){
		if(returnurl!=""){
			addCookie("returnurl",returnurl,24);
		}else{
			window.returnurl = getCookie("returnurl");
		}
			
		area0=AreaCreator(1,4,new Array(-1,-1,-1,-1),"area0_list_","className:item item_focus","className:item");
		if(ISassess == 0 || ISassess == -1){
			area0.doms[2].setCanFocus(false,3);
			$("prewIcon").style.backgroundImage="url(images/iconGray01.png)"
			}
		if(isBookMark==false)
		{
			area0.doms[0].setCanFocus(false,1);
			$("bookMarkIcon").style.backgroundImage="url(images/iconGray04.png)"
		}else{
			indexid = 0;
			}
		area0.areaOkEvent = function()
		{
			if(area0.curindex == 0&&isBookMark==true)
			{
				saveFocstr(pageobj);
				getAJAXData("check_subscribe.jsp?VODID="+datajson[0].VODID+"&FATHERID="+datajson[0].VODID+"&SUBJECTID=-1&CONTENTTYPE="+datajson[0].CONTENTTYPE+"&BUSINESSTYPE=1&PLAYTYPE=1",checksubscribe1);
			}else if(area0.curindex == 1)
			{
				saveFocstr(pageobj);
				 getAJAXData("check_subscribe.jsp?VODID="+datajson[0].VODID+"&FATHERID="+datajson[0].VODID+"&SUBJECTID=-1&CONTENTTYPE="+datajson[0].CONTENTTYPE+"&BUSINESSTYPE=1&PLAYTYPE=1",checksubscribe);
			}else if(area0.curindex == 2 && ISassess == 1)
			{
				saveFocstr(pageobj);
				var play_url = "../play_controlVod.jsp?PROGID="+datajson[0].VODID+"&FATHERSERIESID=-1&PLAYTYPE=5&BEGINTIME=0&PRODUCTID=0&SERVICEID=0&ONECEPRICE=0&CONTENTTYPE=10&returnurl="+escape("hd_epg/film_details.jsp?vodid="+datajson[0].VODID+"&returnurl="+"");
		window.location.href=play_url;
			}
			else
			{
				window.location.href = returnurl;
			}
	   }
		
		if(focusObj!=undefined&&focusObj!="null"){
			   areaid = parseInt(focusObj[0].areaid);
			   indexid = parseInt(focusObj[0].curindex);
			   if(ISassess == 0 && indexid == 2){
				   indexid = 1;
				   }
		   }
		pageobj=new PageObj(areaid,indexid,new Array(area0),null);
		pageobj.backurl = returnurl;
		initdata(datajson);
		}
function checksubscribe(jsonResult)
{
	//alert(jsonResult);
	var jsonResult = eval('('+jsonResult+')');
	//jsonResult.ALLOWPLAY=false;
	
	if(jsonResult.ALLOWPLAY==false)
	{
		var play_url = "../play_controlVod.jsp?PROGID="+datajson[0].VODID+"&FATHERSERIESID=-1&PLAYTYPE=1&BEGINTIME=0&PRODUCTID=0&SERVICEID=0&ONECEPRICE=0&CONTENTTYPE=10&returnurl="+escape("hd_epg/film_details.jsp?vodid="+datajson[0].VODID+"&returnurl="+"");
		var pageName="order.jsp?SUBJECTID=-1&VODID="+datajson[0].VODID+"&FATHERID="+datajson[0].VODID+"&PLAYTYPE=1&CONTENTTYPE="+datajson[0].CONTENTTYPE+"&BUSINESSTYPE=1&returnurl="+escape(location.href)+"&playurl="+escape(play_url);
		/*$("vodIntroduce").innerHTML = "<marquee>"+pageName+"</marquee>";
		return;*/
		location.href = pageName;
	}
	else
	{
		var play_url = "../play_controlVod.jsp?PROGID="+datajson[0].VODID+"&FATHERSERIESID=-1&PLAYTYPE=1&BEGINTIME=0&PRODUCTID=0&SERVICEID=0&ONECEPRICE=0&CONTENTTYPE=10&returnurl="+escape("hd_epg/film_details.jsp?vodid="+datajson[0].VODID+"&returnurl="+"");
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
		var play_url = "../play_controlVod.jsp?PROGID="+datajson[0].VODID+"&FATHERSERIESID=-1&PLAYTYPE=6&BEGINTIME="+beginTime+"&ENDTIME="+endTime+"&PRODUCTID=0&SERVICEID=0&ONECEPRICE=0&CONTENTTYPE=10&returnurl="+escape("hd_epg/film_details.jsp?vodid="+datajson[0].VODID+"&returnurl="+"");
		var pageName="order.jsp?SUBJECTID=-1&VODID="+datajson[0].VODID+"&FATHERID="+datajson[0].VODID+"&PLAYTYPE=1&CONTENTTYPE="+datajson[0].CONTENTTYPE+"&BUSINESSTYPE=1&returnurl="+escape(location.href)+"&playurl="+escape(play_url);
		location.href = pageName;
	}
	else
	{
		var play_url = "../play_controlVod.jsp?PROGID="+datajson[0].VODID+"&FATHERSERIESID=-1&PLAYTYPE=6&BEGINTIME="+beginTime+"&ENDTIME="+endTime+"&PRODUCTID=0&SERVICEID=0&ONECEPRICE=0&CONTENTTYPE=10&returnurl="+escape("hd_epg/film_details.jsp?vodid="+datajson[0].VODID+"&returnurl="+"");
		window.location.href=play_url;
	}
}
	function initdata(data){
		if(data[0]!=null){
			$("vodname").innerHTML = data[0].VODNAME;
			$("daoyan").innerHTML =  "<span>导演：</span>" + data[0].DIRECTOR;
			$("yanyuan").innerHTML = "<span>演员：</span>" + data[0].ACTOR; 
			$("message").innerHTML = data[0].INTRODUCE; 
			$("vodpic").src = "../"+data[0].PICURL; 
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
		<div id="vodname" class="txt txt-title"></div>
		<div class="pic" style="top:35px;"><img src="../images/line.png" /></div>
		<div id="daoyan" class="txt txt-info" style="top:58px;"><span>导演：</span>M·奈特·沙马兰</div>
		<div id="yanyuan" class="txt txt-info" style="top:94px;"><span>演员：</span>威尔·史密斯  贾登·史密斯  佐伊·克罗维兹......</div>
		<div class="txt txt-info" style="top:130px;"><span>剧情：</span></div>
		<div id="message" class="txt txt-info" style="top:130px; left:93px; width:630px;">未来世界，愚蠢的人类文明令地球环境日趋恶化，温暖甜蜜的
家乡变成充满灾难和死亡人间炼狱。此后，人类穿越太空在首
新星建立新的家园而外星人操控的怪兽厄萨对这群外来者展开
残酷屠杀，人称"原鬼"的游骑兵最高指挥官......</div>
	</div>
<!--left list the end-->	


	
<!--r poster-->	
<div class="poster-e">
	<!--焦点 
		class="item item_focus"
	-->
	<div class="item">
		<div class="pic"><img id="vodpic" src="#" /></div>
	</div>
</div>
<!--r poster the end-->		
	
	
	
<!--btns-->	
<div class="btn-a">
	<!--焦点 
			class="item item_focus"
		-->
	<div id="area0_list_0" class="item">
		<div class="icon icon04" id="bookMarkIcon"></div>
		<div class="txt">续看</div>
	</div>
	<div id="area0_list_1" class="item" style="left:100px;">
		<div class="icon icon03"></div>
		<div class="txt">播放</div>
	</div>
	<div id="area0_list_2" class="item" style="left:200px;">
		<div class="icon icon01" id="prewIcon"></div>
		<div class="txt">预览</div>
	</div>
	<div id="area0_list_3" class="item" style="left:300px;">
		<div class="icon icon02"></div>
		<div class="txt">返回</div>
	</div>
</div>
<!--btns the end-->
	
<div id="test" style="left:100px;top:100px;color:#FF0000" ></div>   
<div id="test02" style="left:100px;top:150px;color:#FF0000" ></div>    
 
    
</body>
</html>
