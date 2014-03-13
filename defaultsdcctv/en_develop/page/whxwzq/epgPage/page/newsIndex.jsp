<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="../../config/code.jsp"%>
<%@ include file="../../config/properties.jsp"%>
<%!

    public static int getbytelength(String value) {
        double valueLength = 0;
        String chinese = "[\u4e00-\u9fa5]";
        for (int i = 0; i < value.length(); i++) {
            String temp = value.substring(i, i + 1);
            if (temp.matches(chinese)) {
                valueLength += 2;
            } else {
                valueLength +=1;
            }
        }
        return  (int)(Math.ceil(valueLength));
   }
    	
    	
    public static String getcutedstring(String sSource,int iLen,boolean dot)
    {
    	String chinese = "[\u4e00-\u9fa5]";
    	String str = "";
        int l = 0;
        char schar;
    	if(dot)
    	  iLen=iLen+4;
        for(int i=0; i<sSource.length(); i++)
         {
        	 schar=sSource.charAt(i);
        	 String tempstr=schar+"";
             str += schar;
             l += (tempstr.matches(chinese) != false ? 2 : 1);
            if(l >= iLen)
             {
                break;
             }
         }
    	if(dot)
          return str;
    	else 
    	  return str+"...";
    }

	public static void setCookie(HttpServletResponse response,String name,String value,int hour){
				
		Cookie cookie = new Cookie(name,value);
		cookie.setMaxAge(3600*hour);
		cookie.setPath("/") ;
				
		response.addCookie(cookie);
		
	}
	
	public static String getCookie(HttpServletRequest request,String name){
		
		String value = "";
		
		Cookie[] cookies = request.getCookies();
		if(cookies==null){
			return value;
		}
		for(int i=0;i<cookies.length;i++){
			if(cookies[i].getName().equals(name)){
				value = cookies[i].getValue();
				return value;
			}
		}
				
		return value;
		
	}

%>
<%

	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	int areaid = request.getParameter("areaid")==null?0:Integer.parseInt(request.getParameter("areaid"));
	int indexid = request.getParameter("indexid")==null?0:Integer.parseInt(request.getParameter("indexid"));
	
	int area1index  = request.getParameter("area1index")==null?0:Integer.parseInt(request.getParameter("area1index"));
	int area2curpage  = request.getParameter("area2curpage")==null?1:Integer.parseInt(request.getParameter("area2curpage"));
	
	String returnurl = request.getParameter("returnurl")==null?"":request.getParameter("returnurl");
	if(returnurl!=""){
		setCookie(response,"returnurl",returnurl,24);
	}else{
		returnurl = getCookie(request,"returnurl");
	}
	
	int area1NameLength=3;
	int area2NameLength=30;
	int area4NameLength=6;
	
    String categoryListFile="../../" + datajspname + "/categoryList.jsp";
	String vodListFile="../../" + datajspname + "/vodList.jsp";

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新闻-湖北广电标清EPG2.0</title>
<meta name="page-view-size" content="640*530" />
<%@ include file="base.jsp"%>
<style type="text/css">
.nav {
	left:14px;
	position:absolute;
	top:102px;
}
.nav .item {
	height:37px;
	width:95px;
}
.nav .item .txt {
	font-size:22px;
	line-height:37px;
	text-align:center;
	height:37px;
	width:95px;
}
.nav .item_select {
	background:url(../images/nav-news_select.png) no-repeat;
}
.nav .item_select .txt {
	color:#000;
	font-size:25px;
}
.list-b {
	left:109px;
	position:absolute;
	top:147px;
}
.list-b .item .txt {
	color:#0d94e3;
	font-size:20px;
	left:23px;
	line-height:34px;
	height:34px;
	width:345px;
}
.list-c {
	left:491px;
	position:absolute;
	top:125px;
}
.list-c .item .pic,
.list-c .item .pic img {
	height:125px;
	width:131px;
}
.list-c .item .txt {
	background:url(../images/trans80.png) repeat;
	top:99px;
	text-align:center;
	line-height:26px;
	height:26px;
	width:131px;
}
</style>
</head>

<script type="text/javascript">

<jsp:include page="<%=categoryListFile%>">
	<jsp:param name="parentCategoryCode" value="<%=categoryCode_newsIndex%>" /> 
	<jsp:param name="pageIndex" value="1" /> 
	<jsp:param name="pageSize" value="8" /> 
	<jsp:param name="varName" value="categoryListData" />
	<jsp:param name="fileds" value="-1" />
</jsp:include>

<%
    JSONObject tempjsontypeList = new JSONObject();
	int temptotalCategorySize=0;
	int tempcurCategoryPage=1;
	int temptotalCategoryPage=1;
	JSONArray tempcategoryList = new JSONArray();
	String curVodListCode="";
	int categoryListNum = 0;	
	
	if(request.getAttribute("categoryListData")!=null){
		tempjsontypeList = (JSONObject)request.getAttribute("categoryListData");
		temptotalCategorySize=Integer.parseInt(tempjsontypeList.get("totalSize").toString());
		tempcurCategoryPage=Integer.parseInt(tempjsontypeList.get("curPage").toString());
		temptotalCategoryPage=Integer.parseInt(tempjsontypeList.get("totalPage").toString());
	 
		tempcategoryList=(JSONArray)tempjsontypeList.get("categoryList");
		curVodListCode=tempcategoryList.getJSONObject(area1index).get("categoryCode").toString();
		categoryListNum = tempcategoryList.size();	
	}

%>

<jsp:include page="<%=vodListFile%>">
	<jsp:param name="categoryCode" value="<%=curVodListCode%>" /> 
	<jsp:param name="varName" value="vodListData" /> 
	<jsp:param name="pageIndex" value="<%=area2curpage%>" /> 
	<jsp:param name="pageSize" value="10" />
	<jsp:param name="fields" value="-1" />
</jsp:include>

<%
    JSONObject tempjsonvodList = new JSONObject();
	int temptotalVodListSize=0;
    int tempcurVodListPage=1;
    int temptotalVodListPage=1;
    JSONArray tempvodList= new JSONArray();
	int vodListNum = 0;
	
	if(request.getAttribute("vodListData")!=null){
	    tempjsonvodList = (JSONObject)request.getAttribute("vodListData");
    	temptotalVodListSize=Integer.parseInt(tempjsonvodList.get("totalSize").toString());
   		tempcurVodListPage=Integer.parseInt(tempjsonvodList.get("curPage").toString());
    	temptotalVodListPage=Integer.parseInt(tempjsonvodList.get("totalPage").toString());
		tempvodList=(JSONArray)tempjsonvodList.get("vodDataList");
		vodListNum = tempvodList.size();
	}
%>

<jsp:include page="<%=vodListFile%>">
	<jsp:param name="categoryCode" value="<%=recommendCode_newsIndex%>" /> 
	<jsp:param name="varName" value="recommendListData" /> 
	<jsp:param name="pageIndex" value="1" /> 
	<jsp:param name="pageSize" value="3" />
	<jsp:param name="fields" value="-1" />
</jsp:include>

<%
    JSONObject tempjsonrecommendList = new JSONObject();
	int temptotalRecommendListSize=0;
    int tempcurRecommendListPage=1;
    int temptotalRecommendListPage=1;
    JSONArray tempRecommendList = new JSONArray();
	int recommendListNum = 0;
	
	if(request.getAttribute("recommendListData")!=null){
		tempjsonrecommendList = (JSONObject)request.getAttribute("recommendListData");
    	temptotalRecommendListSize=Integer.parseInt(tempjsonrecommendList.get("totalSize").toString());
    	tempcurRecommendListPage=Integer.parseInt(tempjsonrecommendList.get("curPage").toString());
    	temptotalRecommendListPage=Integer.parseInt(tempjsonrecommendList.get("totalPage").toString());
    	tempRecommendList=(JSONArray)tempjsonrecommendList.get("vodDataList");
		recommendListNum = tempRecommendList.size();
	}
%>

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
	
	function getcutedstring(sSource,iLen,dot)
	{
		/*var endstr="...";
		for(i=0;i<len;i++)
		   if(str.charCodeAt(i)>255)
			 len--;
		str=str.substr(0,len)+endstr;
		return str;*/
		var str = "";
		var l = 0;
		var schar;
		if(dot)
		  iLen=iLen+4;
		for(var i=0; schar=sSource.charAt(i); i++)
		 {
			 str += schar;
			 l += (schar.match(/[^\x00-\xff]/) != null ? 2 : 1);
			if(l >= iLen)
			 {
				break;
			 }
		 }
		if(dot)
		  return str;
		else 
		  return str+"...";
	}

	var area0,area1,area2,area3,area4;
	var pageobj=new Object();
	
	var area1NameLength=<%=area1NameLength%>;
	var area2NameLength=<%=area2NameLength%>;
	var area4NameLength=<%=area4NameLength%>;

	 function $(id) 
	 {
		  return document.getElementById(id);
	 }	

	 var area0={curindex:0,datanum:5,name:"area0",areaid:0};
	 var area1={selectindex:<%=area1index%>,curindex:0,datanum:<%=categoryListNum%>,name:"area1",areaid:1};
	 var area2={curindex:0,datanum:<%=vodListNum%>,name:"area2",areaid:2,curpage:<%=area2curpage%>,pagenum:<%=temptotalVodListPage%>};
	 var area3={curindex:0,datanum:2,name:"area3",areaid:3};
	 var area4={curindex:0,datanum:<%=recommendListNum%>,name:"area4",areaid:4};

	 pageobj.curareaindex=<%=areaid%>;
	 pageobj.curindex=<%=indexid%>;
	 
	 pageobj.areas=new Array();
	 pageobj.areas.push(area0);
	 pageobj.areas.push(area1);
	 pageobj.areas.push(area2);
	 pageobj.areas.push(area3);
	 pageobj.areas.push(area4);

	 area0.changefocusEvent = function(stepvalue){
		$("area0_list_"+area0.curindex).blur();
	    area0.curindex=stepvalue+area0.curindex;
		if(area0.curindex<0){
			area0.curindex=area0.datanum-1;
		}
		if(area0.curindex>=area0.datanum){
			area0.curindex=0;
		}
		$("area0_list_"+area0.curindex).focus();
	 }

	 area1.changefocusEvent = function(stepvalue){
		$("area1_list_"+area1.curindex).blur();
		$("area1_txt_"+area1.curindex).innerHTML = categoryListData.categoryList[area1.curindex].cutname;
	    area1.curindex=stepvalue+area1.curindex;
		if(area1.curindex<0){
			area1.curindex=area1.datanum-1;
		}
		if(area1.curindex>=area1.datanum){
			area1.curindex=0;
		}
		if(categoryListData.categoryList[area1.curindex].iscut){
			$("area1_txt_"+area1.curindex).innerHTML = "<marquee>"+categoryListData.categoryList[area1.curindex].name+"</marquee>";
		}
		$("area1_list_"+area1.curindex).focus();
	 }

	 area2.changefocusEvent = function(stepvalue){
		$("area2_list_"+area2.curindex).blur();
		$("area2_txt_"+area2.curindex).innerHTML = vodListData.vodDataList[area2.curindex].cutname;
	    area2.curindex=stepvalue+area2.curindex;
		if(area2.curindex<0){
			area2.curindex=area2.datanum-1;
		}
		if(area2.curindex>=area2.datanum){
			area2.curindex=0;
		}
		if(vodListData.vodDataList[area2.curindex].iscut){
			$("area2_txt_"+area2.curindex).innerHTML = "<marquee>"+vodListData.vodDataList[area2.curindex].name+"</marquee>";
		}
		$("area2_list_"+area2.curindex).focus();
	 }
	 
	 area3.changefocusEvent = function(stepvalue){
		$("area3_list_"+area3.curindex).blur();
	    area3.curindex=stepvalue+area3.curindex;
		if(area3.curindex<0){
			area3.curindex=area3.datanum-1;
		}
		if(area3.curindex>=area3.datanum){
			area3.curindex=0;
		}
		$("area3_list_"+area3.curindex).focus();
	 }
	 
	 area4.changefocusEvent = function(stepvalue){
		$("area4_list_"+area4.curindex).blur();
		$("area4_txt_"+area4.curindex).innerHTML = recommendListData.vodDataList[area4.curindex].cutname;
	    area4.curindex=stepvalue+area4.curindex;
		if(area4.curindex<0){
			area4.curindex=area4.datanum-1;
		}
		if(area4.curindex>=area4.datanum){
			area4.curindex=0;
		}
		if(recommendListData.vodDataList[area4.curindex].iscut){
			$("area4_txt_"+area4.curindex).innerHTML = "<marquee>"+recommendListData.vodDataList[area4.curindex].name+"</marquee>";
		}
		$("area4_list_"+area4.curindex).focus();
	 }

	 area0.ok = function(){
	 
		switch(area0.curindex){		
			case 0:
				window.location.href="<%=tempProperBath%>newsIndex.jsp";
			break;
			case 1:
				window.location.href="<%=tempProperBath%>news.jsp?categoryCode="+"<%=categoryCode_hubei%>"+"&area0index=1&areaid=0&indexid=1";
			break;
			case 2:
				window.location.href="<%=tempProperBath%>news.jsp?categoryCode="+"<%=categoryCode_minglan%>"+"&area0index=2&areaid=0&indexid=2";
			break;
			case 3:
				window.location.href="<%=tempProperBath%>tvLive.jsp?categoryCode="+"<%=categoryCode_yszb%>"+"&area5SelectIndex=3";
			break;
			case 4:
				window.location.href="<%=tempProperBath%>tvLive.jsp?categoryCode="+"<%=categoryCode_cjhxw%>"+"&area5SelectIndex=4";
			break;
			default:
			break;
		}
	 }
	 
	 area1.ok = function(){
		$("area1_"+area1.selectindex).className="item";
	 	$("area1_"+area1.curindex).className="item item_select";
		area1.selectindex = area1.curindex;
		$('hidden_frame').src = "<%=tempProperBath%>iframe/newsIndexIframe.jsp?categoryCode="+categoryListData.categoryList[area1.curindex].categoryCode;
	 }

	 area2.ok = function(){
	 	var backurl="<%=tempProperBath%>newsIndex.jsp?areaid=2&indexid="+area2.curindex+"&area1index="+area1.selectindex+"&area2curpage="+area2.curpage;
		var PROGID = vodListData.vodDataList[area2.curindex].programCode;
		var TYPE_ID = categoryListData.categoryList[area1.selectindex].categoryCode;
		window.location.href = "<%=tempProperBath%>play_controlVod.jsp?TYPE_ID="+TYPE_ID+"&PROGID="+PROGID+"&PLAYTYPE=1&backurl="+escape(backurl);
	 }
	 
	 area3.ok = function(){
		if(area3.curindex==0){
			area2.pageTurnEvent(-1);
		}else{
			area2.pageTurnEvent(1);
		}
	 }
	 
	 area4.ok = function(){
	 	var backurl="<%=tempProperBath%>newsIndex.jsp?areaid=4&indexid="+area4.curindex+"&area1index="+area1.selectindex+"&area2curpage="+area2.curpage;
		var PROGID = recommendListData.vodDataList[area4.curindex].programCode;
		var TYPE_ID = "<%=recommendCode_newsIndex%>";
		window.location.href = "<%=tempProperBath%>play_controlVod.jsp?TYPE_ID="+TYPE_ID+"&PROGID="+PROGID+"&PLAYTYPE=1&backurl="+escape(backurl);	 
	 }

	 area0.pageTurnEvent = function(num){

	 }

	 area1.pageTurnEvent = function(num){

	 }

	 area2.pageTurnEvent = function(num){
	 	 var area2curpage = area2.curpage+num;
		 if(area2curpage>=1&&area2curpage<=area2.pagenum){
		 	area2.curpage = area2curpage;
			$("hidden_frame").src = "<%=tempProperBath%>iframe/newsIndexIframe.jsp?categoryCode="+categoryListData.categoryList[area1.selectindex].categoryCode+"&curpage="+area2curpage;
		 }
		 if(pageobj.curareaindex==2){
		 	$("area2_list_"+area2.curindex).blur();
		 	$("area2_list_0").focus();
			area2.curindex=0;
		 }
	 }
	 
	 area3.pageTurnEvent = function(num){

	 }
	 
	 area4.pageTurnEvent = function(num){

	 }
	 	 
	 window.onload = function(){

		$('area'+pageobj.curareaindex+"_list_"+pageobj.curindex).focus();
		pageobj.areas[pageobj.curareaindex].curindex =  pageobj.curindex;
		
		for(var i=0;i<categoryListData.categoryList.length;i++){
		 if(getbytelength(categoryListData.categoryList[i].name)>=area1NameLength){
			 categoryListData.categoryList[i].iscut=true;
			 categoryListData.categoryList[i].cutname=getcutedstring(categoryListData.categoryList[i].name,area1NameLength,false);
		 }else{
			 categoryListData.categoryList[i].iscut=false;
			 categoryListData.categoryList[i].cutname=categoryListData.categoryList[i].name;
		 }
		}
		
		for(var i=0;i<vodListData.vodDataList.length;i++){
		 if(getbytelength(vodListData.vodDataList[i].name)>=area2NameLength){
			 vodListData.vodDataList[i].iscut=true;
			 vodListData.vodDataList[i].cutname=getcutedstring(vodListData.vodDataList[i].name,area2NameLength,false);
		 }else{
			 vodListData.vodDataList[i].iscut=false;
			 vodListData.vodDataList[i].cutname=vodListData.vodDataList[i].name;
		 }
		}
		
		for(var i=0;i<recommendListData.vodDataList.length;i++){
		 if(getbytelength(recommendListData.vodDataList[i].name)>=12){
			 recommendListData.vodDataList[i].iscut=true;
			 recommendListData.vodDataList[i].cutname=getcutedstring(recommendListData.vodDataList[i].name,12,false);
		 }else{
			 recommendListData.vodDataList[i].iscut=false;
			 recommendListData.vodDataList[i].cutname=recommendListData.vodDataList[i].name;
		 }
		}
		
	 }
	 
	 /*
	 function bindCategoryListData(){
	 	var categoryList = categoryListData.categoryList;
		var length = categoryList.length;
		for(i=0;i<length;i++){
			$("area1_txt_"+i).innerHTML = categoryList[i].name;
		}
		area1.datanum = length;
		for(;i<8;i++){
			$("area1_txt_"+i).innerHTML="";
		}
	 }
	 */
	 
	 function bindVodListData(){

		for(var i=0;i<vodListData.vodDataList.length;i++){
		 if(getbytelength(vodListData.vodDataList[i].name)>=area2NameLength){
			 vodListData.vodDataList[i].iscut=true;
			 vodListData.vodDataList[i].cutname=getcutedstring(vodListData.vodDataList[i].name,area2NameLength,false);
		 }else{
			 vodListData.vodDataList[i].iscut=false;
			 vodListData.vodDataList[i].cutname=vodListData.vodDataList[i].name;
		 }
		 	 $("area2_txt_"+i).innerHTML = vodListData.vodDataList[i].cutname;
		}
		
		area2.datanum = vodListData.vodDataList.length;
		
		for(;i<10;i++){
			$("area2_txt_"+i).innerHTML="";
		}

		showPagenum();
		
	 }
	 
	 function showPagenum(){
	 	
		area2.curpage = vodListData.curPage;
		area2.pagenum = vodListData.totalPage;
		
		if(1<area2.curpage&&area2.curpage<area2.pagenum){
			$("area3_img_0").src = "../images/btn-prev02.png";
			$("area3_img_1").src = "../images/btn-next02.png";
		}else if(area2.curpage>=area2.pagenum){
			$("area3_img_0").src = "../images/btn-prev02.png";
			$("area3_img_1").src = "../images/bg-next02_gray.png";
		}else if(area2.curpage<=1){
			$("area3_img_0").src = "../images/btn-prev02_gray.png";
			$("area3_img_1").src = "../images/btn-next02.png";
		}
		$('page').innerHTML = area2.curpage+"/"+area2.pagenum+"页";
		
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
		document.onkeydown = keyEvent;
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
				case 188:
				case 33:
		        case KEY_PAGEUP:
			        pageobj.pageTurnEvent(-1);
				    break;
		        case 190:
				case 34:
				case KEY_PAGEDOWN:
			        pageobj.pageTurnEvent(1);
					break;
				case 13:
				case KEY_OK: //enter
					pageobj.ok();
					break;
				case 32:    // 空格
				case KEY_BACK:
					pageobj.goBack();
					break;
			    default:return 0;
			}
			return 0;
		}

		pageobj.backurl=unescape("<%=returnurl%>");
		pageobj.goBack=function(){
			window.location.href=pageobj.backurl;
		};

		pageobj.ok=function(){
			pageobj.areas[pageobj.curareaindex].ok();
		};

		pageobj.move=function(direction){
			switch(direction){
				   case 0:{
					   if(pageobj.curareaindex==0){
					   
					   }else if(pageobj.curareaindex==1){
							if(area1.curindex>0){
								area1.changefocusEvent(-1);
							}else{
								$("area1_txt_0").innerHTML = categoryListData.categoryList[0].cutname;
								changeArea(area1,area0);
							}
					   }else if(pageobj.curareaindex==2){
							if(area2.curindex>0){
								area2.changefocusEvent(-1);
							}else{
								$("area2_txt_0").innerHTML = vodListData.vodDataList[0].cutname;
								changeArea(area2,area3);
							} 					   
					   }else if(pageobj.curareaindex==3){
							changeArea(area3,area0);	
					   }else if(pageobj.curareaindex==4){
					   		if(area4.curindex>0){
								area4.changefocusEvent(-1);
							}else{
								$("area4_txt_0").innerHTML = recommendListData.vodDataList[0].cutname;
								changeArea(area4,area0);				   
							}
					   }
					   break;  
				   }
				   case 1:{
					   if(pageobj.curareaindex==0){
						    area0.changefocusEvent(-1);
					   }else if(pageobj.curareaindex==1){
						    area1.changefocusEvent(-1);	   
					   }else if(pageobj.curareaindex==2){
					   		$("area2_txt_"+area2.curindex).innerHTML = vodListData.vodDataList[area2.curindex].cutname;
							if(categoryListData.categoryList[0].iscut){
								$("area1_txt_0").innerHTML = "<marquee>"+categoryListData.categoryList[0].name+"</marquee>";
							}
							changeArea(area2,area1);				   
					   }else if(pageobj.curareaindex==3){
					   		if(area3.curindex==0){
								if(categoryListData.categoryList[0].iscut){
									$("area1_txt_0").innerHTML = "<marquee>"+categoryListData.categoryList[0].name+"</marquee>";
								}
								changeArea(area3,area1);
							}else{
								area3.changefocusEvent(-1);
							}
					   }else if(pageobj.curareaindex==4){
					   		$("area4_txt_"+area4.curindex).innerHTML = vodListData.vodDataList[area4.curindex].cutname;
							if(vodListData.vodDataList[0].iscut){
								$("area2_txt_0").innerHTML = "<marquee>"+vodListData.vodDataList[0].name+"</marquee>";
							}
						    changeArea(area3,area2);
					   }
					   break;
				   }
				   case 2:{
					   if(pageobj.curareaindex==0){
							if(categoryListData.categoryList[0].iscut){
								$("area1_txt_0").innerHTML = "<marquee>"+categoryListData.categoryList[0].name+"</marquee>";
							}
							changeArea(area0,area1);
					   }else if(pageobj.curareaindex==1){
						    area1.changefocusEvent(1);  
					   }else if(pageobj.curareaindex==2){
						    area2.changefocusEvent(1);  
					   }else if(pageobj.curareaindex==3){
					   		if(vodListData.vodDataList[0].iscut){
								$("area2_txt_0").innerHTML = "<marquee>"+vodListData.vodDataList[0].name+"</marquee>";
							}
						    changeArea(area3,area2);
					   }else if(pageobj.curareaindex==4){
						    area4.changefocusEvent(1);
					   }
					   break;	
				   }
				   case 3:{
					   if(pageobj.curareaindex==0){
						    area0.changefocusEvent(1);
					   }else if(pageobj.curareaindex==1){
					   		$("area1_txt_"+area1.curindex).innerHTML = categoryListData.categoryList[area1.curindex].cutname;
							if(vodListData.vodDataList[0].iscut){
								$("area2_txt_0").innerHTML = "<marquee>"+vodListData.vodDataList[0].name+"</marquee>";
							}
							changeArea(area1,area2);
					   }else if(pageobj.curareaindex==2){
					   		$("area2_txt_"+area2.curindex).innerHTML = vodListData.vodDataList[area2.curindex].cutname;
							if(recommendListData.vodDataList[0].iscut){
								$("area4_txt_0").innerHTML = "<marquee>"+recommendListData.vodDataList[0].name+"</marquee>";
							}
							changeArea(area2,area4);
					   }else if(pageobj.curareaindex==3){
					   		if(area3.curindex==0){
								area3.changefocusEvent(1)
							}else{
								if(recommendListData.vodDataList[0].iscut){
									$("area4_txt_0").innerHTML = "<marquee>"+recommendListData.vodDataList[0].name+"</marquee>";
								}
								changeArea(area3,area4);
							}
					   }else if(pageobj.curareaindex==4){

					   }
					   break;
					}
			  }
		 };
		 		 
		 function changeArea(fromArea,toArea){
			$(fromArea.name+'_list_'+fromArea.curindex).blur();
			$(toArea.name+'_list_0').focus();
			toArea.curindex=0
			fromArea.curindex=0;
			pageobj.curareaindex=toArea.areaid;	
		 }

		 pageobj.pageTurnEvent = function(num){
			pageobj.areas[pageobj.curareaindex].pageTurnEvent(num);	 
		}


</script>

<body style="background:url(../images/bg-news03.jpg) no-repeat;">
	
<!-- menu -->
	<div class="menu-news">
		<!--选中为
			class="item item01 item01_select" 2字 
			class="item item02 item02_select" 4字
			class="item item03 item03_select" 5字	 
			class="item item04 item04_select" 仅用于"湖北"
		-->
		<div class="item item01 item01_select">
			<div class="link"><a id="area0_list_0" href="#"><img src="../images/t.gif" width="61" height="40" /></a></div>
			<div class="txt">首页</div>
        </div>
		<div class="item item04" style="left:128px;">
			<div class="link"><a id="area0_list_1" href="#"><img src="../images/t.gif" width="87" height="40" /></a></div>
			<div class="txt">湖北</div>
        </div>
		<div class="item item01" style="left:240px;">
			<div class="link"><a id="area0_list_2" href="#"><img src="../images/t.gif" width="61" height="40" /></a></div>
			<div class="txt">名栏</div>
        </div>
		<div class="item item02" style="left:325px;">
			<div class="link"><a id="area0_list_3" href="#"><img src="../images/t.gif" width="112" height="40" /></a></div>
			<div class="txt">经视直播</div>
        </div>
		<div class="item item03" style="left:460px;">
			<div class="link"><a id="area0_list_4" href="#"><img src="../images/t.gif" width="142" height="40" /></a></div>
			<div class="txt">长江新闻号</div>
        </div>
	</div>
<!-- menu the end-->


<!-- nav -->
	<div class="nav">
		<!--选中为
			class="item item_select" 
		-->
		<div id="area1_0" <%if(area1index==0){%>class="item item_select"<%}else{%>class="item"<%}%>>
			<div class="link"><a id="area1_list_0" href="#"><img src="../images/t.gif" width="95" height="37" /></a></div>
			<div id="area1_txt_0" class="txt">
                   <% if(tempcategoryList.size()>0) {
					   if(getbytelength(tempcategoryList.getJSONObject(0).get("name").toString())>=area1NameLength){
						  %>
						   <%=getcutedstring(tempcategoryList.getJSONObject(0).get("name").toString(),area1NameLength,false)%>
					<%}else{%>
                    	 <%=tempcategoryList.getJSONObject(0).get("name").toString()%>
					<%}
				   }%>
            </div>
        </div>
		<div id="area1_1" <%if(area1index==1){%>class="item item_select"<%}else{%>class="item"<%}%> style="top:40px;">
			<div class="link"><a id="area1_list_1" href="#"><img src="../images/t.gif" width="95" height="37" /></a></div>
			<div id="area1_txt_1" class="txt">
                   <% if(tempcategoryList.size()>1) {
					   if(getbytelength(tempcategoryList.getJSONObject(1).get("name").toString())>=area1NameLength){
						  %>
						   <%=getcutedstring(tempcategoryList.getJSONObject(1).get("name").toString(),area1NameLength,false)%>
					<%}else{%>
                    	 <%=tempcategoryList.getJSONObject(1).get("name").toString()%>
					<%}
				   }%>
            </div>
        </div>
		<div id="area1_2" <%if(area1index==2){%>class="item item_select"<%}else{%>class="item"<%}%> style="top:80px;">
			<div class="link"><a id="area1_list_2" href="#"><img src="../images/t.gif" width="95" height="37" /></a></div>
			<div id="area1_txt_2" class="txt">
                   <% if(tempcategoryList.size()>2) {
					   if(getbytelength(tempcategoryList.getJSONObject(2).get("name").toString())>=area1NameLength){
						  %>
						   <%=getcutedstring(tempcategoryList.getJSONObject(2).get("name").toString(),area1NameLength,false)%>
					<%}else{%>
                    	 <%=tempcategoryList.getJSONObject(2).get("name").toString()%>
					<%}
				   }%>
            </div>
        </div>
		<div id="area1_3" <%if(area1index==3){%>class="item item_select"<%}else{%>class="item"<%}%> style="top:120px;">
			<div class="link"><a id="area1_list_3" href="#"><img src="../images/t.gif" width="95" height="37" /></a></div>
			<div id="area1_txt_3" class="txt">
                   <% if(tempcategoryList.size()>3) {
					   if(getbytelength(tempcategoryList.getJSONObject(3).get("name").toString())>=area1NameLength){
						  %>
						   <%=getcutedstring(tempcategoryList.getJSONObject(3).get("name").toString(),area1NameLength,false)%>
					<%}else{%>
                    	 <%=tempcategoryList.getJSONObject(3).get("name").toString()%>
					<%}
				   }%>
            </div>
        </div>
		<div id="area1_4" <%if(area1index==4){%>class="item item_select"<%}else{%>class="item"<%}%> style="top:160px;">
			<div class="link"><a id="area1_list_4" href="#"><img src="../images/t.gif" width="95" height="37" /></a></div>
			<div id="area1_txt_4" class="txt">
                   <% if(tempcategoryList.size()>4) {
					   if(getbytelength(tempcategoryList.getJSONObject(4).get("name").toString())>=area1NameLength){
						  %>
						   <%=getcutedstring(tempcategoryList.getJSONObject(4).get("name").toString(),area1NameLength,false)%>
					<%}else{%>
                    	 <%=tempcategoryList.getJSONObject(4).get("name").toString()%>
					<%}
				   }%>
            </div>
        </div>
		<div id="area1_5" <%if(area1index==5){%>class="item item_select"<%}else{%>class="item"<%}%> style="top:200px;">
			<div class="link"><a id="area1_list_5" href="#"><img src="../images/t.gif" width="95" height="37" /></a></div>
			<div id="area1_txt_5" class="txt">
                   <% if(tempcategoryList.size()>5) {
					   if(getbytelength(tempcategoryList.getJSONObject(5).get("name").toString())>=area1NameLength){
						  %>
						   <%=getcutedstring(tempcategoryList.getJSONObject(5).get("name").toString(),area1NameLength,false)%>
					<%}else{%>
                    	 <%=tempcategoryList.getJSONObject(5).get("name").toString()%>
					<%}
				   }%>
            </div>
        </div>
		<div id="area1_6" <%if(area1index==6){%>class="item item_select"<%}else{%>class="item"<%}%> style="top:240px;">
			<div class="link"><a id="area1_list_6" href="#"><img src="../images/t.gif" width="95" height="37" /></a></div>
			<div id="area1_txt_6" class="txt">
                   <% if(tempcategoryList.size()>6) {
					   if(getbytelength(tempcategoryList.getJSONObject(6).get("name").toString())>=area1NameLength){
						  %>
						   <%=getcutedstring(tempcategoryList.getJSONObject(6).get("name").toString(),area1NameLength,false)%>
					<%}else{%>
                    	 <%=tempcategoryList.getJSONObject(6).get("name").toString()%>
					<%}
				   }%>
            </div>
        </div>
		<div id="area1_7" <%if(area1index==7){%>class="item item_select"<%}else{%>class="item"<%}%> style="top:280px;">
			<div class="link"><a id="area1_list_7" href="#"><img src="../images/t.gif" width="95" height="37" /></a></div>
			<div id="area1_txt_7" class="txt">
                   <% if(tempcategoryList.size()>7) {
					   if(getbytelength(tempcategoryList.getJSONObject(7).get("name").toString())>=area1NameLength){
						  %>
						   <%=getcutedstring(tempcategoryList.getJSONObject(7).get("name").toString(),area1NameLength,false)%>
					<%}else{%>
                    	 <%=tempcategoryList.getJSONObject(7).get("name").toString()%>
					<%}
				   }%>
            </div>
        </div>
	</div>
<!-- nav the end-->
	
	
<!-- page -->
	<div class="page-a" style="left:113px;">
		<!--灰色为
				btn-prev02_gray.png
				btn-next02_gray.png
		-->	
		<div id="area3_0" class="item"><a id="area3_list_0" href="#"><img id="area3_img_0" <% if(tempcurVodListPage==1) {%>src="../images/btn-prev02_gray.png"<%} else{%>src="../images/btn-prev02.png"<%}%> alt="上页" width="88" height="36" /></a></div>
		<div id="area3_1" class="item" style="left:100px;"><a id="area3_list_1" href="#"><img id="area3_img_1" src="<% if(tempcurVodListPage==temptotalVodListPage) {%>../images/bg-next02_gray.png<%} else{%>../images/btn-next02.png<%}%>" alt="下页" width="88" height="36" /></a></div>
	</div>
	<div id="page" class="txt" style="color:#0d94e3; left:373px; top:110px; text-align:right; width:100px;"><%=tempcurVodListPage%>/<%=temptotalVodListPage%>页</div>
<!-- page the end-->


<!-- list -->
	<div class="list-b">
		<div class="item">
			<div class="link"><a id="area2_list_0" href="#"><img src="../images/t.gif" width="374" height="34" /></a></div>
			<div id="area2_txt_0" class="txt">
                    <% if(tempvodList.size()>0) {
						if(getbytelength(tempvodList.getJSONObject(0).get("name").toString())>=area2NameLength){%>
							<%=getcutedstring(tempvodList.getJSONObject(0).get("name").toString(),area2NameLength,false)%>
					<%}else{%>
						<%=tempvodList.getJSONObject(0).get("name").toString()%>
					<%}
				   }%>
            </div>
		</div>
		<div class="item" style="top:35px;">
			<div class="link"><a id="area2_list_1" href="#"><img src="../images/t.gif" width="374" height="34" /></a></div>
			<div id="area2_txt_1" class="txt">
                    <% if(tempvodList.size()>1) {
						if(getbytelength(tempvodList.getJSONObject(1).get("name").toString())>=area2NameLength){%>
							<%=getcutedstring(tempvodList.getJSONObject(1).get("name").toString(),area2NameLength,false)%>
					<%}else{%>
						<%=tempvodList.getJSONObject(1).get("name").toString()%>
					<%}
				   }%>
            </div>
		</div>
		<div class="item" style="top:70px;">
			<div class="link"><a id="area2_list_2" href="#"><img src="../images/t.gif" width="374" height="34" /></a></div>
			<div id="area2_txt_2" class="txt">
                    <% if(tempvodList.size()>2) {
						if(getbytelength(tempvodList.getJSONObject(2).get("name").toString())>=area2NameLength){%>
							<%=getcutedstring(tempvodList.getJSONObject(2).get("name").toString(),area2NameLength,false)%>
					<%}else{%>
						<%=tempvodList.getJSONObject(2).get("name").toString()%>
					<%}
				   }%>
            </div>
		</div>
		<div class="item" style="top:105px;">
			<div class="link"><a id="area2_list_3" href="#"><img src="../images/t.gif" width="374" height="34" /></a></div>
			<div id="area2_txt_3" class="txt">
                     <% if(tempvodList.size()>3) {
						if(getbytelength(tempvodList.getJSONObject(3).get("name").toString())>=area2NameLength){%>
							<%=getcutedstring(tempvodList.getJSONObject(3).get("name").toString(),area2NameLength,false)%>
					<%}else{%>
						<%=tempvodList.getJSONObject(3).get("name").toString()%>
					<%}
				   }%>
            </div>
		</div>
		<div class="item" style="top:140px;">
			<div class="link"><a id="area2_list_4" href="#"><img src="../images/t.gif" width="374" height="34" /></a></div>
			<div id="area2_txt_4" class="txt">
                    <% if(tempvodList.size()>4) {
						if(getbytelength(tempvodList.getJSONObject(4).get("name").toString())>=area2NameLength){%>
							<%=getcutedstring(tempvodList.getJSONObject(4).get("name").toString(),area2NameLength,false)%>
					<%}else{%>
						<%=tempvodList.getJSONObject(4).get("name").toString()%>
					<%}
				   }%>
            </div>
		</div>
		<div class="item" style="top:175px;">
			<div class="link"><a id="area2_list_5" href="#"><img src="../images/t.gif" width="374" height="34" /></a></div>
			<div id="area2_txt_5" class="txt">
                    <% if(tempvodList.size()>5) {
						if(getbytelength(tempvodList.getJSONObject(5).get("name").toString())>=area2NameLength){%>
							<%=getcutedstring(tempvodList.getJSONObject(5).get("name").toString(),area2NameLength,false)%>
					<%}else{%>
						<%=tempvodList.getJSONObject(5).get("name").toString()%>
					<%}
				   }%>
            </div>
		</div>
		<div class="item" style="top:210px;">
			<div class="link"><a id="area2_list_6" href="#"><img src="../images/t.gif" width="374" height="34" /></a></div>
			<div id="area2_txt_6" class="txt">
                    <% if(tempvodList.size()>6) {
						if(getbytelength(tempvodList.getJSONObject(6).get("name").toString())>=area2NameLength){%>
							<%=getcutedstring(tempvodList.getJSONObject(6).get("name").toString(),area2NameLength,false)%>
					<%}else{%>
						<%=tempvodList.getJSONObject(6).get("name").toString()%>
					<%}
				   }%>
            </div>
		</div>
		<div class="item" style="top:245px;">
			<div class="link"><a id="area2_list_7" href="#"><img src="../images/t.gif" width="374" height="34" /></a></div>
			<div id="area2_txt_7" class="txt">
                    <% if(tempvodList.size()>7) {
						if(getbytelength(tempvodList.getJSONObject(7).get("name").toString())>=area2NameLength){%>
							<%=getcutedstring(tempvodList.getJSONObject(7).get("name").toString(),area2NameLength,false)%>
					<%}else{%>
						<%=tempvodList.getJSONObject(7).get("name").toString()%>
					<%}
				   }%>
            </div>
		</div>
		<div class="item" style="top:280px;">
			<div class="link"><a id="area2_list_8" href="#"><img src="../images/t.gif" width="374" height="34" /></a></div>
			<div id="area2_txt_8" class="txt">
                    <% if(tempvodList.size()>8) {
						if(getbytelength(tempvodList.getJSONObject(8).get("name").toString())>=area2NameLength){%>
							<%=getcutedstring(tempvodList.getJSONObject(8).get("name").toString(),area2NameLength,false)%>
					<%}else{%>
						<%=tempvodList.getJSONObject(8).get("name").toString()%>
					<%}
				   }%>
            </div>
		</div>
		<div class="item" style="top:315px;">
			<div class="link"><a id="area2_list_9" href="#"><img src="../images/t.gif" width="374" height="34" /></a></div>
			<div id="area2_txt_9" class="txt">
                    <% if(tempvodList.size()>9) {
						if(getbytelength(tempvodList.getJSONObject(9).get("name").toString())>=area2NameLength){%>
							<%=getcutedstring(tempvodList.getJSONObject(9).get("name").toString(),area2NameLength,false)%>
					<%}else{%>
						<%=tempvodList.getJSONObject(9).get("name").toString()%>
					<%}
				   }%>
            </div>
		</div>
	</div>
	
	<!--今日推荐-->
	<div class="txt" style=" font-size:20px; left:497px; top:96px; text-align:center; width:120px;">今日推荐</div>
	<div class="list-c">
		<div class="item" style="visibility:visible;">
			<div class="link"><a id="area4_list_0" href="#"><img src="../images/t.gif" width="131" height="125" /></a></div>
			<div class="pic"><img id="area4_img_0" src="${recommendListData.vodDataList[0].pictureList.poster}" /></div>
			<div id="area4_txt_0" class="txt">
                    <% if(tempRecommendList.size()>0) {
						if(getbytelength(tempRecommendList.getJSONObject(0).get("name").toString())>=area4NameLength){%>
							<%=getcutedstring(tempRecommendList.getJSONObject(0).get("name").toString(),area4NameLength,false)%>
					<%}else{%>
						<%=tempRecommendList.getJSONObject(0).get("name").toString()%>
					<%}
				   }%>
            </div>
		</div>
		<div class="item" style="top:130px;visibility:visible;">
			<div class="link"><a id="area4_list_1" href="#"><img src="../images/t.gif" width="131" height="125" /></a></div>
			<div class="pic"><img id="area4_img_1" src="${recommendListData.vodDataList[1].pictureList.poster}" /></div>
			<div id="area4_txt_1" class="txt">
                    <% if(tempRecommendList.size()>1) {
						if(getbytelength(tempRecommendList.getJSONObject(1).get("name").toString())>=area4NameLength){%>
							<%=getcutedstring(tempRecommendList.getJSONObject(1).get("name").toString(),area4NameLength,false)%>
					<%}else{%>
						<%=tempRecommendList.getJSONObject(1).get("name").toString()%>
					<%}
				   }%>
            </div>
		</div>
		<div class="item" style="top:260px;visibility:visible;">
			<div class="link"><a id="area4_list_2" href="#"><img src="../images/t.gif" width="131" height="125" /></a></div>
			<div class="pic"><img id="area4_img_2" src="${recommendListData.vodDataList[2].pictureList.poster}" /></div>
			<div id="area4_txt_2" class="txt">
                    <% if(tempRecommendList.size()>2) {
						if(getbytelength(tempRecommendList.getJSONObject(2).get("name").toString())>=area4NameLength){%>
							<%=getcutedstring(tempRecommendList.getJSONObject(2).get("name").toString(),area4NameLength,false)%>
					<%}else{%>
						<%=tempRecommendList.getJSONObject(2).get("name").toString()%>
					<%}
				   }%>
            </div>
		</div>
	</div>
<!-- list the end-->

	
</body>
<iframe name="hidden_frame" id="hidden_frame" style="visibility:hidden;" width="0" height="0" ></iframe>
</html>
