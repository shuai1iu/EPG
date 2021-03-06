<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="../../config/code.jsp"%>
<%@ include file="../../config/properties.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>电视剧首页-湖北广电标清EPG2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/common.css" />
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

	int areaid = request.getParameter("areaid")==null?4:Integer.parseInt(request.getParameter("areaid"));
	int indexid = request.getParameter("indexid")==null?0:Integer.parseInt(request.getParameter("indexid"));

	int area1SelectIndex = request.getParameter("area1SelectIndex")==null?2:Integer.parseInt(request.getParameter("area1SelectIndex"));
	int area3curpage = request.getParameter("area3curpage")==null?1:Integer.parseInt(request.getParameter("area3curpage"));
	
	String categoryVodeList = request.getParameter("categoryVodeList")==null?"10000100000000090000000000031172":request.getParameter("categoryVodeList");
	String categoryTopicVodeList = request.getParameter("categoryTopicVodeList")==null?"10000100000000090000000000031172":request.getParameter("categoryTopicVodeList");

	String returnurl = request.getParameter("returnurl")==null?"":request.getParameter("returnurl");
	if(returnurl!=""){
		setCookie(response,"returnurl",returnurl,24);
	}else{
		returnurl = getCookie(request,"returnurl");
	}

	int area3NameLength = 8;
	int area4NameLength = 14;

    //String categoryListFile="../../" + datajspname + "/categoryList.jsp";
	String vodListFile="../../" + datajspname + "/vodList.jsp";

%>
<style type="text/css">
.tv-info {
	background:url(../images/tv-txt-bg.png) no-repeat;
	left:29px;
	position:absolute;
	top:353px;
	height:150px;
	width:126px;
}
.tv-info .txt {
	font-size:18px;
	line-height:24px;
	left:8px; 
	top:8px; 
	width:110px;
}
.tv-pic {
	background:url(../images/pic01.png) no-repeat;
	height:174px;
	width:132px;
	left:26px;
	position:absolute;
	top:166px;
}
.tv-pic .pic,
.tv-pic .pic img {
	height:161px;
	width:120px;
}
.tv-pic .pic {
	left:6px;
	top:8px;
}
.tv-pic .txt-wrap {
	background:url(../images/trans70.png) repeat;
	font-size:20px;
	left:4px;
	top:147px;
	text-align:center;
	line-height:22px;
	height:22px;
	width:124px;
}
</style>

<script>

<jsp:include page="<%=vodListFile%>">
	<jsp:param name="categoryCode" value="<%=categoryTopicVodeList%>" /> 
	<jsp:param name="varName" value="topicVodListData" /> 
	<jsp:param name="pageIndex" value="1" /> 
	<jsp:param name="pageSize" value="1" />
	<jsp:param name="fields" value="-1" />
</jsp:include>
	
	<%
		JSONObject tempjsonTopicVodList = new JSONObject();
		int temptotalTopicVodListSize=0;
		int tempcurTopicVodListPage=1;
		int temptotalTopicVodListPage=1;
		JSONArray tempTopicVodList= new JSONArray();
		int topicVodListNum = 0;
		
		if(request.getAttribute("topicVodListData")!=null){
			tempjsonTopicVodList = (JSONObject)request.getAttribute("topicVodListData");
			temptotalTopicVodListSize=Integer.parseInt(tempjsonTopicVodList.get("totalSize").toString());
			tempcurTopicVodListPage=Integer.parseInt(tempjsonTopicVodList.get("curPage").toString());
			temptotalTopicVodListPage=Integer.parseInt(tempjsonTopicVodList.get("totalPage").toString());
			tempTopicVodList=(JSONArray)tempjsonTopicVodList.get("vodDataList");
			topicVodListNum = tempTopicVodList.size();
		}
	%>
	
<jsp:include page="<%=vodListFile%>">
	<jsp:param name="categoryCode" value="<%=categoryVodeList%>" /> 
	<jsp:param name="varName" value="vodListData" /> 
	<jsp:param name="pageIndex" value="<%=area3curpage%>" /> 
	<jsp:param name="pageSize" value="6" />
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
    
	var area0,area1,area3,area2,area4;
	var pageobj=new Object();
	
	var area0={curindex:0,datanum:3,name:"area0",areaid:0,rows:1,cols:3};
	var area1={curindex:0,datanum:8,name:"area1",areaid:1,rows:1,cols:8};
	var area2={curindex:0,datanum:2,name:"area2",areaid:2,rows:1,cols:2};
	var area3={curindex:0,datanum:<%=vodListNum%>,name:"area3",areaid:3,curpage:<%=area3curpage%>,pagenum:<%=temptotalVodListPage%>,rows:2,cols:3};
	var area4={curindex:0,datanum:1,name:"area4",areaid:4,rows:1,cols:1};
	
	var area3NameLength = <%=area3NameLength%>;
	var area4NameLength = <%=area4NameLength%>;
	
	var marqueeSpace = "3";
	
	pageobj.curareaindex=<%=areaid%>;
	pageobj.curindex=<%=indexid%>;
	
	pageobj.areas=new Array();
	pageobj.areas.push(area0);
	pageobj.areas.push(area1);
	pageobj.areas.push(area2);
	pageobj.areas.push(area3);
	pageobj.areas.push(area4);


	function $(id) 
	{
		return document.getElementById(id);
	}	

		area0.ok = function(){
	
	}

	area1.ok = function(){
		switch(area1.curindex){
			case 0:
				//changeArea1SelectStyle(0);
				window.location.href="<%=tempProperBath%>tvIndex.jsp";
			break;
			case 1:
				//changeArea1SelectStyle(1);
				window.location.href="<%=tempProperBath%>tvUpdate.jsp";
			break;
			case 2:
				//changeArea1SelectStyle(2);
				window.location.href="<%=tempProperBath%>tvInland.jsp?areaid=4&indexid=0&area1SelectIndex=2&categoryVodeList="+"<%=categoryCode_dsj_ld%>"+"&categoryTopicVodeList="+"<%=categoryCode_dsj_ld_topic%>";
			break;
			case 3:
				//changeArea1SelectStyle(3);
				window.location.href="<%=tempProperBath%>tvInland.jsp?areaid=4&indexid=0&area1SelectIndex=3&categoryVodeList="+"<%=categoryCode_dsj_gt%>"+"&categoryTopicVodeList="+"<%=categoryCode_dsj_gt_topic%>";			
				break;
			case 4:
				//changeArea1SelectStyle(4);
				window.location.href="<%=tempProperBath%>tvInland.jsp?areaid=4&indexid=0&area1SelectIndex=4&categoryVodeList="+"<%=categoryCode_dsj_rh%>"+"&categoryTopicVodeList="+"<%=categoryCode_dsj_rh_topic%>";			
				break;
			case 5:
				//changeArea1SelectStyle(5);
				window.location.href="<%=tempProperBath%>tvInland.jsp?areaid=4&indexid=0&area1SelectIndex=5&categoryVodeList="+"<%=categoryCode_dsj_om%>"+"&categoryTopicVodeList="+"<%=categoryCode_dsj_om_topic%>";			
				break;
			case 6:
				//changeArea1SelectStyle(6);
				window.location.href="<%=tempProperBath%>tvType.jsp";
			break;
			case 7:
				//changeArea1SelectStyle(7);
				window.location.href="<%=tempProperBath%>tvSpecial.jsp";
			break;
		}
	}
	
	/*
	function changeArea1SelectStyle(num){
		$("area1_list_"+area1.selectIndex).className="item";
		area1.selectIndex = num;
		$("area1_list_"+num).className="item item_select";
	}
	*/
	
	area2.ok = function(){
		switch(area2.curindex){
			case 0:
				area3.pageTurnEvent(-1);
			break;
			case 1:
				area3.pageTurnEvent(1);
			break;
		}
	}
	
	area3.ok = function(){
	
	}
	
	area4.ok = function(){
	
	}
	
	area0.pageTurnEvent = function(num){
	
	}
	
	area1.pageTurnEvent = function(num){
	
	}
	
	area2.pageTurnEvent = function(num){
	
	}
	
	area3.pageTurnEvent = function(num){
		var tmp = area3.curpage+num;
		if(area3.pagenum>=2){
			if(tmp>=1&&tmp<=area3.pagenum){
				area3CurindexSetZero();
				area3.curpage = tmp;
				$("hidden_frame").src = "<%=tempProperBath%>iframe/getVodListFrame.jsp?categoryCode="+"<%=categoryVodeList%>"+"&curpage="+area3.curpage;
			}else if(tmp<1){
				area3CurindexSetZero();
				area3.curpage = area3.pagenum;
				$("hidden_frame").src = "<%=tempProperBath%>iframe/getVodListFrame.jsp?categoryCode="+"<%=categoryVodeList%>"+"&curpage="+area3.curpage;
			}else if(tmp>area3.pagenum){
				area3CurindexSetZero();
				area3.curpage = 1;
				$("hidden_frame").src = "<%=tempProperBath%>iframe/getVodListFrame.jsp?categoryCode="+"<%=categoryVodeList%>"+"&curpage="+area3.curpage;
			}
		}
	}
	
	function area3CurindexSetZero(){
		if(pageobj.curareaindex==3){
			//$("area3_a_"+area3.curindex).blur();
			removeMarqueeByVod(vodListData,area3);
			area3.curindex = 0;
			addMarqueeByVod(vodListData,area3);
			$("area3_a_0").focus();
		}
	}
	
	area4.pageTurnEvent = function(num){
	
	}
	
	function bindVodListData(){
	
		for(var i=0;i<vodListData.vodDataList.length;i++){
		 if(getbytelength(vodListData.vodDataList[i].name)>=area3NameLength){
			 vodListData.vodDataList[i].iscut=true;
			 vodListData.vodDataList[i].cutname=getcutedstring(vodListData.vodDataList[i].name,area3NameLength,false);
		 }else{
			 vodListData.vodDataList[i].iscut=false;
			 vodListData.vodDataList[i].cutname=vodListData.vodDataList[i].name;
		 }
		 	 $("area3_list_"+i).style.visibility = "visible";
		 	 $("area3_txt_"+i).innerHTML = vodListData.vodDataList[i].cutname;
			 $("area3_img_"+i).src = vodListData.vodDataList[i].pictureList.poster;
		}
		
		//area3.pagenum = vodListData.totalPage;
		area3.datanum = vodListData.vodDataList.length;
		
		for(;i<6;i++){
			$("area3_list_"+i).style.visibility = "hidden";
			//$("area3_txt_"+i).innerHTML="";
			//$("area3_txt_"+i).src="";
		}
		
		showPagenum();
	
	}
	
	function showPagenum(){
	
		area3.curpage = vodListData.curPage;
		area3.pagenum = vodListData.totalPage;

		$("page").innerHTML = area3.curpage+"/"+area3.pagenum+"页";
	
	}
	
	area0.changefocusEvent = function(dir){
		switch(dir){
			case 1:
				changeFocusInArea(area0,1);
			break;
			case 2:
				changeArea(area0,area1);
			break;
			case 3:
				changeFocusInArea(area0,3);
			break;
		}
	}
	
	area1.changefocusEvent = function(dir){
		switch(dir){
			case 0:
				changeArea(area1,area4);
			break;
			case 1:
				changeFocusInArea(area1,1);
				//changeFocusLeftOrRightEvent(area1,-1);
			break;
			case 2:
				changeArea(area1,area2);
			break;
			case 3:
				changeFocusInArea(area1,3);
				//changeFocusLeftOrRightEvent(area1,1);
			break;
		}
	}
	
	area2.changefocusEvent = function(dir){
		switch(dir){
			case 0:
				changeArea(area2,area1);
			break;
			case 1:
				changeFocusInArea(area2,1);
				//changeFocusLeftOrRightEvent(area1,-1);
			break;
			case 2:
				changeArea(area2,area3);
				addMarqueeByVod(vodListData,area3);
			break;
			case 3:
				changeFocusInArea(area2,3);
				//changeFocusLeftOrRightEvent(area1,1);
			break;
		}
	}
		
	area3.changefocusEvent = function(dir){
		switch(dir){
			case 0:
				if(area3.curindex<area3.cols){
					removeMarqueeByVod(vodListData,area3);
					changeArea(area3,area2);
				}else{
					removeMarqueeByVod(vodListData,area3);
					changeFocusUpOrDownEvent(area3,-1);
					addMarqueeByVod(vodListData,area3);
				}
			break;
			case 1:
				var isCrossLimit = false;
				var curindex = area3.curindex;
				var rows = area3.rows;
				var cols = area3.cols;
				for(i=0;i<rows;i++){
					if(curindex==i*cols){
						isCrossLimit = true;
						break;
					}
				}
				if(isCrossLimit==true){
					removeMarqueeByVod(vodListData,area3);
					changeArea(area3,area4);
					addMarqueeByVod(topicVodListData,area4);	   
				}else{
					removeMarqueeByVod(vodListData,area3);
					changeFocusLeftOrRightEvent(area3,-1);
					addMarqueeByVod(vodListData,area3);
				}
			break;
			case 2:
				if(area3.curindex<area3.datanum-area3.cols){
					removeMarqueeByVod(vodListData,area3);
					changeFocusUpOrDownEvent(area3,1);
					addMarqueeByVod(vodListData,area3);
				}
			break;
			case 3:
				var isCrossLimit = false;
				var curindex = area3.curindex;
				var rows = area3.rows;
				var cols = area3.cols;
				for(i=1;i<=rows;i++){
					if(curindex==i*cols-1){
						isCrossLimit = true;
						break;
					}
				}
				if(isCrossLimit==false){
					removeMarqueeByVod(vodListData,area3);
					changeFocusLeftOrRightEvent(area3,1);
					addMarqueeByVod(vodListData,area3);
				}
			break;
		}
	}
	
	area4.changefocusEvent = function(dir){
		switch(dir){
			case 0:
				changeArea(area4,area1);
			break;
			case 3:
				removeMarqueeByVod(topicVodListData,area4);
				changeArea(area4,area3);
				addMarqueeByVod(vodListData,area3);
			break;
		}
	}
	
	function changeArea(fromArea,toArea){
		//$(fromArea.name+"_a_"+fromArea.curindex).blur();
		if(toArea.datanum>0){
			fromArea.curindex=0;
			toArea.curindex=0;
			pageobj.curareaindex=toArea.areaid;
			$(toArea.name+'_a_'+toArea.curindex).focus();
		}
	}
	
	function changeFocusInArea(area,dir){
		
		switch(dir){
			case 0:
				changeFocusUpOrDownEvent(area,-1);
			break;
			case 1:
				changeFocusLeftOrRightEvent(area,-1);
			break;
			case 2:
				changeFocusUpOrDownEvent(area,1);
			break;
			case 3:
				changeFocusLeftOrRightEvent(area,1);
			break;
		}
		
	}
	
	function changeFocusUpOrDownEvent(area,stepvalue){
		//$(area.name+'_a_'+area1.curindex).blur();
		area.curindex = area.curindex + area.cols*stepvalue;
		$(area.name+'_a_'+area.curindex).focus();
	}
	
	function changeFocusLeftOrRightEvent(area,stepvalue){
		//$(area.name+"_a_"+area.curindex).blur();
		area.curindex=stepvalue+area.curindex;
		if(area.curindex<0){
			area.curindex=area.datanum-1;
		}
		if(area.curindex>=area.datanum){
			area.curindex=0;
		}
		$(area.name+"_a_"+area.curindex).focus();
	}
	
	function removeMarqueeByVod(tmpvodList,area){
		if(tmpvodList.vodDataList[area.curindex].iscut){
			$(area.name+"_txt_"+area.curindex).innerHTML = tmpvodList.vodDataList[area.curindex].cutname;
		}
	}
	
	function addMarqueeByVod(tmpvodList,area){
		if(tmpvodList.vodDataList[area.curindex].iscut){
			$(area.name+"_txt_"+area.curindex).innerHTML = "<marquee scrollAmount="+marqueeSpace+">"+tmpvodList.vodDataList[area.curindex].name+"</marquee>";
		}
	}
	
	window.onload = function(){
		
		initFocus();
		
		bindVodListCutName(vodListData,area3NameLength);
		bindVodListCutName(topicVodListData,area4NameLength);
		
	}
	
	function bindVodListCutName(tmpVodList,length){
	
		for(var i=0;i<tmpVodList.vodDataList.length;i++){
		 if(getbytelength(tmpVodList.vodDataList[i].name)>=length){
			 tmpVodList.vodDataList[i].iscut=true;
			 tmpVodList.vodDataList[i].cutname=getcutedstring(tmpVodList.vodDataList[i].name,length,false);
		 }else{
			 tmpVodList.vodDataList[i].iscut=false;
			 tmpVodList.vodDataList[i].cutname=tmpVodList.vodDataList[i].name;
		 }
		}
	
	}
	
	function initFocus(){
		
		$('area'+pageobj.curareaindex+"_a_"+pageobj.curindex).focus();
		pageobj.areas[pageobj.curareaindex].curindex =  pageobj.curindex; 
		
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
			pageobj.areas[pageobj.curareaindex].changefocusEvent(direction);
		}

		pageobj.pageTurnEvent = function(num){
			pageobj.areas[pageobj.curareaindex].pageTurnEvent(num);	 
		}

</script>
</head>

<body style="background:url(../images/bg-tv01.jpg) no-repeat;">

	<div class="tools">	
		<div class="item">
			<div class="link"><a id="area0_a_0" href="#"><img src="../images/t.gif" width="53" height="31" /></a></div>
			<div class="txt">收藏</div>	
		</div>
		<div class="item" style="left:63px;">
			<div class="link"><a id="area0_a_1" href="#"><img src="../images/t.gif" width="53" height="31" /></a></div>
			<div class="txt">书签</div>	
		</div>
		<div class="item" style="left:126px;">
			<div class="link"><a id="area0_a_2" href="#"><img src="../images/t.gif" width="53" height="31" /></a></div>
			<div class="txt">搜索</div>	
		</div>
	</div>	
	
<!-- menu -->
	<div class="menu-tv">
		<!--选中为
			class="item item_select"
		-->
		<div class="item item_select">
			<div class="link"><a id="area1_a_0" href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">首页</div>
        </div>
		<div class="item" style="left:80px;">
			<div class="link"><a id="area1_a_1" href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">追剧</div>
        </div>
		<div class="item" style="left:160px;">
			<div class="link"><a id="area1_a_2" href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">内地</div>
        </div>
		<div class="item" style="left:240px;">
			<div class="link"><a id="area1_a_3" href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">港台</div>
        </div>
		<div class="item" style="left:320px;">
			<div class="link"><a id="area1_a_4" href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">日韩</div>
        </div>
		<div class="item" style="left:400px;">
			<div class="link"><a id="area1_a_5" href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">欧美</div>
        </div>
		<div class="item" style="left:480px;">
			<div class="link"><a id="area1_a_6" href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">类型</div>
        </div>
		<div class="item" style="left:560px;">
			<div class="link"><a id="area1_a_7" href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">专题</div>
        </div>
	</div>
	<div class="icon" style="left:485px; top:90px;"><img src="../images/tv-topic.png" alt="金庸影视专题" /></div>
<!-- menu the end-->


<!-- 推荐 -->
	<div class="pic" style="left:34px; top:127px;"><img src="../images/font-tuijian.png" alt="重磅推荐" /></div>
	<div class="tv-pic">
		<div class="link"><a id="area4_a_0" href="#"><img src="../images/t.gif" width="132" height="174" /></a></div>
		<div class="pic"><img src="${topicVodListData.vodDataList[0].pictureList.poster}" /></div>
		<div id="area4_txt_0" class="txt-wrap">
			<% if(tempTopicVodList.size()>0) {
                if(getbytelength(tempTopicVodList.getJSONObject(0).get("name").toString())>=area4NameLength){%>
                    <%=getcutedstring(tempTopicVodList.getJSONObject(0).get("name").toString(),area4NameLength,false)%>
            <%}else{%>
                <%=tempTopicVodList.getJSONObject(0).get("name").toString()%>
            <%}
           }%>
        </div>
		<div id="episode" class="txt-mark"><div class="txt">至第10集</div></div>
	</div>
	<div class="tv-info">
		<div id="area4_desc_0" class="txt">
        	<% if(tempTopicVodList.size()>0) {
                if(getbytelength(tempTopicVodList.getJSONObject(0).get("description").toString())>=46){%>
                    <%=getcutedstring(tempTopicVodList.getJSONObject(0).get("description").toString(),46,false)%>
            <%}else{%>
                <%=tempTopicVodList.getJSONObject(0).get("description").toString()%>
            <%}
           }%>
        </div>
	</div>
<!-- 推荐 the end-->
	
	
<!-- page -->
	<div class="page-b">
		<div class="item">
			<div class="link"><a id="area2_a_0" href="#"><img src="../images/t.gif" width="41" height="24" /></a></div>
			<div class="txt">上页</div>
		</div>
		<div class="item" style="left:52px;">
			<div class="link"><a id="area2_a_1" href="#"><img src="../images/t.gif" width="41" height="24" /></a></div>
			<div class="txt">下页</div>
		</div>
	</div>
	<div id="page" class="txt" style=" font-size:18px; left:300px; top:101px; width:60px;"><%=tempcurVodListPage%>/<%=temptotalVodListPage%></div>
<!-- page the end-->


<!-- list -->	
	<div class="list-tv">
		<div id="area3_list_0" class="item" style="<%if(tempvodList.size()>5){%>visibility:visible;<%}else{%>visibility:hidden;<%}%>">
			<div class="link"><a id="area3_a_0" href="#"><img src="../images/t.gif" width="132" height="175" /></a></div>
			<div class="pic"><img id="area3_img_0" src="${vodListData.vodDataList[0].pictureList.poster}" /></div>
			<div id="area3_txt_0" class="txt-wrap">
				<% if(tempvodList.size()>0) {
                    if(getbytelength(tempvodList.getJSONObject(0).get("name").toString())>=area3NameLength){%>
                        <%=getcutedstring(tempvodList.getJSONObject(0).get("name").toString(),area3NameLength,false)%>
                <%}else{%>
                    <%=tempvodList.getJSONObject(0).get("name").toString()%>
                <%}
               }%>
            </div>
			<!--<div class="txt-mark"><div class="txt">至第10集</div></div>-->
		</div>
		<div id="area3_list_1" class="item" style="left:155px;<%if(tempvodList.size()>1){%>visibility:visible;<%}else{%>visibility:hidden;<%}%>">
			<div class="link"><a id="area3_a_1" href="#"><img src="../images/t.gif" width="132" height="175" /></a></div>
			<div class="pic"><img id="area3_img_1" src="${vodListData.vodDataList[1].pictureList.poster}" /></div>
			<div id="area3_txt_1" class="txt-wrap">
            	<% if(tempvodList.size()>1) {
                    if(getbytelength(tempvodList.getJSONObject(1).get("name").toString())>=area3NameLength){%>
                        <%=getcutedstring(tempvodList.getJSONObject(1).get("name").toString(),area3NameLength,false)%>
                <%}else{%>
                    <%=tempvodList.getJSONObject(1).get("name").toString()%>
                <%}
               }%>
            </div>
		</div>
		<div id="area3_list_2" class="item" style="left:310px;<%if(tempvodList.size()>2){%>visibility:visible;<%}else{%>visibility:hidden;<%}%>">
			<div class="link"><a id="area3_a_2" href="#"><img src="../images/t.gif" width="132" height="175" /></a></div>
			<div class="pic"><img id="area3_img_2" src="${vodListData.vodDataList[2].pictureList.poster}" /></div>
			<div id="area3_txt_2" class="txt-wrap">
            	<% if(tempvodList.size()>2) {
                    if(getbytelength(tempvodList.getJSONObject(2).get("name").toString())>=area3NameLength){%>
                        <%=getcutedstring(tempvodList.getJSONObject(2).get("name").toString(),area3NameLength,false)%>
                <%}else{%>
                    <%=tempvodList.getJSONObject(2).get("name").toString()%>
                <%}
               }%>
            </div>
		</div>
		<div id="area3_list_3" class="item" style="top:203px;<%if(tempvodList.size()>3){%>visibility:visible;<%}else{%>visibility:hidden;<%}%>">
			<div class="link"><a id="area3_a_3" href="#"><img src="../images/t.gif" width="132" height="175" /></a></div>
			<div class="pic"><img id="area3_img_3" src="${vodListData.vodDataList[3].pictureList.poster}" /></div>
			<div id="area3_txt_3" class="txt-wrap">
            	<% if(tempvodList.size()>3) {
                    if(getbytelength(tempvodList.getJSONObject(3).get("name").toString())>=area3NameLength){%>
                        <%=getcutedstring(tempvodList.getJSONObject(3).get("name").toString(),area3NameLength,false)%>
                <%}else{%>
                    <%=tempvodList.getJSONObject(3).get("name").toString()%>
                <%}
               }%>
            </div>
		</div>
		<div id="area3_list_4" class="item" style="left:155px;top:203px;<%if(tempvodList.size()>4){%>visibility:visible;<%}else{%>visibility:hidden;<%}%>">
			<div class="link"><a id="area3_a_4" href="#"><img src="../images/t.gif" width="132" height="175" /></a></div>
			<div class="pic"><img id="area3_img_4" src="${vodListData.vodDataList[4].pictureList.poster}" /></div>
			<div id="area3_txt_4" class="txt-wrap">
            	<% if(tempvodList.size()>4) {
                    if(getbytelength(tempvodList.getJSONObject(4).get("name").toString())>=area3NameLength){%>
                        <%=getcutedstring(tempvodList.getJSONObject(4).get("name").toString(),area3NameLength,false)%>
                <%}else{%>
                    <%=tempvodList.getJSONObject(4).get("name").toString()%>
                <%}
               }%>
            </div>
		</div>
		<div id="area3_list_5" class="item" style="left:310px;top:203px;<%if(tempvodList.size()>5){%>visibility:visible;<%}else{%>visibility:hidden;<%}%>">
			<div class="link"><a id="area3_a_5" href="#"><img src="../images/t.gif" width="132" height="175" /></a></div>
			<div class="pic"><img id="area3_img_5" src="${vodListData.vodDataList[5].pictureList.poster}" /></div>
			<div id="area3_txt_5" class="txt-wrap">
            	<% if(tempvodList.size()>5) {
                    if(getbytelength(tempvodList.getJSONObject(5).get("name").toString())>=area3NameLength){%>
                        <%=getcutedstring(tempvodList.getJSONObject(5).get("name").toString(),area3NameLength,false)%>
                <%}else{%>
                    <%=tempvodList.getJSONObject(5).get("name").toString()%>
                <%}
               }%>
            </div>
		</div>
	</div>
<!-- list the end-->

	
</body>
<iframe name="hidden_frame" id="hidden_frame" style="visibility:hidden;" width="0" height="0" ></iframe>
</html>
