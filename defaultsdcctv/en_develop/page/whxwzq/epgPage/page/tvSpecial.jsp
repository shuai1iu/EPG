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
<title>电视剧专题-湖北广电标清EPG2.0</title>
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
                valueLength += 1;
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

	int area1SelectIndex = request.getParameter("area1SelectIndex")==null?0:Integer.parseInt(request.getParameter("area1SelectIndex"));
	int area4SelectIndex = request.getParameter("area4SelectIndex")==null?0:Integer.parseInt(request.getParameter("area4SelectIndex"));
	
	int area3curpage = request.getParameter("area3curpage")==null?1:Integer.parseInt(request.getParameter("area3curpage"));
	int area4curpage = request.getParameter("area4curpage")==null?1:Integer.parseInt(request.getParameter("area4curpage"));
	
	String returnurl = request.getParameter("returnurl")==null?"":request.getParameter("returnurl");
	if(returnurl!=""){
		setCookie(response,"returnurl",returnurl,24);
	}else{
		returnurl = getCookie(request,"returnurl");
	}

	int area3NameLength = 10;
	int area4NameLength = 10;

	String categoryListFile="../../" + datajspname + "/categoryList.jsp";
	String vodListFile="../../" + datajspname + "/vodList.jsp";

%>
<style type="text/css">
.tv-topic {
	left:15px;
	position:absolute;
	top:166px;
}
.tv-topic .item {
	background:url(../images/tv-topic02.png) no-repeat;
	height:56px;
	width:305px;
}
.tv-topic .item .txt-num,
.tv-topic .item .txt-num-top {
	font-size:22px;
	font-weight:bold;
	line-height:22px;
	text-align:center;
	left:5px;
	top:5px;
	height:22px;
	width:22px;
}
.tv-topic .item .txt-num {
	color:#c68e36;
}
.tv-topic .item .txt-num-top {
	background:url(../images/numbg02.png) no-repeat;
	color:#723d17;
}
.tv-topic .item .txt01 {
	font-size:18px;
	line-height:24px;
	left:33px;
	top:4px;
	width:265px;
}
.tv-topic .item-a {
	background:url(../images/tv-topic01.png) no-repeat;
	height:66px;
}
.tv-topic .item-a .pic {
	background:url(../images/pic03.png) no-repeat;
	left:31px;
	height:66px;
	width:54px;
}
.tv-topic .item-a .pic img {
	left:6px;
	position:absolute;
	top:5px;
	height:56px;
	width:42px;
}
.tv-topic .item-a .txt01 {
	font-size:20px;
	left:95px;
	top:6px;
	width:185px;
}
.tv-topic .item-a .txt02 {
	color:#ffd76a;
	font-size:20px;
	left:95px;
	top:38px;
	width:185px;
}
</style>
<script>
	
	<jsp:include page="<%=categoryListFile%>">
		<jsp:param name="parentCategoryCode" value="<%=categoryCode_dsj_zt%>" /> 
		<jsp:param name="pageIndex" value="<%=area4curpage%>" /> 
		<jsp:param name="pageSize" value="6" /> 
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
			curVodListCode=tempcategoryList.getJSONObject(area4SelectIndex).get("categoryCode").toString();
			categoryListNum = tempcategoryList.size();	
		}
	
	%>

	<jsp:include page="<%=vodListFile%>">
		<jsp:param name="categoryCode" value="<%=curVodListCode%>" /> 
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
	var area1={selectIndex:<%=area1SelectIndex%>,curindex:0,datanum:8,name:"area1",areaid:1,rows:1,cols:8};
	var area2={curindex:0,datanum:2,name:"area2",areaid:2,rows:1,cols:2};
	var area3={curindex:0,datanum:<%=vodListNum%>,name:"area3",areaid:3,curpage:<%=tempcurVodListPage%>,pagenum:<%=temptotalVodListPage%>,rows:2,cols:2};
	var area4={selectIndex:<%=area4SelectIndex%>,selectPage:1,curindex:0,datanum:<%=categoryListNum%>,name:"area4",areaid:4,curpage:<%=tempcurCategoryPage%>,pagenum:<%=temptotalCategoryPage%>,rows:6,cols:1};
	
	var area3NameLength = <%=area3NameLength%>;
	var area4NameLength = <%=area4NameLength%>;
	
	var curVodListCode = "<%=curVodListCode%>";
	
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
				area4.pageTurnEvent(-1);
			break;
			case 1:
				area4.pageTurnEvent(1);
			break;
		}
	}
	
	area3.ok = function(){
	
	}
	
	area4.ok = function(){
		
		$("area4_arrow_"+area4.selectIndex).style.visibility = "hidden";
		
		area4.selectIndex = area4.curindex;
		area4.selectPage = area4.curpage;
		
		$("area4_arrow_"+area4.selectIndex).style.visibility = "visible";
		
		removeMarqueeByCategory(categoryListData,area4);
		
		curVodListCode = categoryListData.categoryList[area4.selectIndex].categoryCode
		
		$("hidden_frame").src = "<%=tempProperBath%>iframe/getVodListFrame.jsp?categoryCode="+curVodListCode+"&curpage=1";
		
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
				
		area3.datanum = vodListData.vodDataList.length;
		
		for(;i<4;i++){
			$("area3_list_"+i).style.visibility = "hidden";
			//$("area3_txt_"+i).innerHTML="";
			//$("area3_txt_"+i).src="";
		}
				
	}
	
	area0.pageTurnEvent = function(num){
	
	}
	
	area1.pageTurnEvent = function(num){
	
	}
	
	area2.pageTurnEvent = function(num){

	}
	
	area3.pageTurnEvent = function(num){
	
	}
	
	area4.pageTurnEvent = function(num){
	
		var tmp = area4.curpage+num;
		if(area4.pagenum>1){
			if(tmp>=1&&tmp<=area4.pagenum){
				area4CurindexSetZero();
				removeArrow();
				area4.curpage = tmp;
				$("hidden_frame").src = "<%=tempProperBath%>iframe/getCategoryListFrame.jsp?categoryCode="+"<%=categoryCode_dsj_zt%>"+"&curpage="+area4.curpage;
			}else if(tmp<1){
				area4CurindexSetZero();
				removeArrow();
				area4.curpage = area4.pagenum;
				$("hidden_frame").src = "<%=tempProperBath%>iframe/getCategoryListFrame.jsp?categoryCode="+"<%=categoryCode_dsj_zt%>"+"&curpage="+area4.curpage;
			}else if(tmp>area4.pagenum){
				area4CurindexSetZero();
				removeArrow();
				area4.curpage = 1;
				$("hidden_frame").src = "<%=tempProperBath%>iframe/getCategoryListFrame.jsp?categoryCode="+"<%=categoryCode_dsj_zt%>"+"&curpage="+area4.curpage;
			}
		}
		
	}
	
	function area4CurindexSetZero(){
		if(pageobj.curareaindex==4){
			//$("area4_a_"+area4.curindex).blur();
			//removeMarqueeByVod(categoryListData,area4);
			area4.curindex = 0;
			//addMarqueeByVod(vodListData,area4);
			$("area4_a_0").focus();
		}
	}
	
	function bindCategoryListData(){
		
		for(var i=0;i<categoryListData.categoryList.length;i++){
			 if(getbytelength(categoryListData.categoryList[i].name)>=area4NameLength){
				 categoryListData.categoryList[i].iscut=true;
				 categoryListData.categoryList[i].cutname=getcutedstring(categoryListData.categoryList[i].name,area4NameLength,false);
			 }else{
				 categoryListData.categoryList[i].iscut=false;
				 categoryListData.categoryList[i].cutname=categoryListData.categoryList[i].name;
			 }
				 $("area4_list_"+i).style.visibility = "visible";
				 $("area4_txt_"+i).innerHTML = categoryListData.categoryList[i].cutname;
				 $("area4_img_"+i).src = categoryListData.categoryList[i].pictureList.poster;
		}
		
		if(i>=1){
			$("area4_desc_0").innerHTML = getcutedstring(categoryListData.categoryList[0].description,area4NameLength,false);
		}
				
		area4.datanum = categoryListData.categoryList.length;
		
		for(;i<6;i++){
			$("area4_list_"+i).style.visibility = "hidden";
			//$("area4_txt_"+i).innerHTML="";
			//$("area4_txt_"+i).src="";
		}
		
		addArrow();
		showPagenum();
		
	}
	
	function addArrow(){
		
		if(area4.curpage==area4.selectPage){
			$("area4_arrow_"+area4.selectIndex).style.visibility = "visible";
		}
		
	}
	
	function removeArrow(){
		
		if(area4.curpage==area4.selectPage){
			$("area4_arrow_"+area4.selectIndex).style.visibility = "hidden";
		}
		
	}
	
	function showPagenum(){
	
		area4.curpage = categoryListData.curPage;
		area4.pagenum = categoryListData.totalPage;

		$("page").innerHTML = area4.curpage+"/"+area4.pagenum+"页";
	
	}
	
	area0.changefocusEvent = function(dir){
		switch(dir){
			case 1:
				changeFocusInArea(area0,0);
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
				changeArea(area1,area0);
			break;
			case 1:
				changeFocusInArea(area1,1);
				//changeFocusLeftOrRightEvent(area1,-1);
			break;
			case 2:
				changeArea(area1,area4);
				addMarqueeByCategory(categoryListData,area4);
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
				changeArea(area2,area4);
				addMarqueeByCategory(categoryListData,area4);
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
					changeArea(area3,area1);
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
					addMarqueeByCategory(categoryListData,area4);	   
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
				if(isCrossLimit==true){

				}else{
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
				if(area4.curindex>0){
					removeMarqueeByCategory(categoryListData,area4);
					changeFocusInArea(area4,0);
					addMarqueeByCategory(categoryListData,area4);
				}else{
					removeMarqueeByCategory(categoryListData,area4);
					changeArea(area4,area2);
				}
			break;
			case 2:
				if(area4.curindex<area4.datanum-1){
					removeMarqueeByCategory(categoryListData,area4);
					changeFocusInArea(area4,2);
					addMarqueeByCategory(categoryListData,area4);
				}
			break;
			case 3:
				removeMarqueeByCategory(categoryListData,area4);
				changeArea(area4,area3);
				addMarqueeByVod(vodListData,area3);
			break;
		}
	}
	
	function changeArea(fromArea,toArea,tmpvodList){
		//$(fromArea.name+"_a_"+fromArea.curindex).blur();
		fromArea.curindex=0;
		toArea.curindex=0;
		pageobj.curareaindex=toArea.areaid;
		$(toArea.name+"_a_"+toArea.curindex).focus();
	}
	
	function changeFocusInArea(area,dir,tmpvodList){
	
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
		//$(area.name+"_a_"+area1.curindex).blur();
		area.curindex = area.curindex + area.cols*stepvalue;
		$(area.name+"_a_"+area.curindex).focus();
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
			$(area.name+"_txt_"+area.curindex).innerHTML = "<marquee>"+tmpvodList.vodDataList[area.curindex].name+"</marquee>";
		}
	}
	
	function removeMarqueeByCategory(tmpcategoryList,area){
		if(tmpcategoryList.categoryList[area.curindex].iscut){
			$(area.name+"_txt_"+area.curindex).innerHTML = tmpcategoryList.categoryList[area.curindex].cutname;
		}
	}
	
	function addMarqueeByCategory(tmpcategoryList,area){
		if(tmpcategoryList.categoryList[area.curindex].iscut){
			$(area.name+"_txt_"+area.curindex).innerHTML = "<marquee>"+tmpcategoryList.categoryList[area.curindex].name+"</marquee>";
		}
	}
	
	window.onload = function(){
		
		initFocus();
		
		bindVodListCutName(vodListData,area3NameLength);
		bindCategoryListCutName(categoryListData,area4NameLength)
		
	}
	
	function bindCategoryListCutName(tmpCategoryList,length){
	
		for(var i=0;i<tmpCategoryList.categoryList.length;i++){
		 if(getbytelength(tmpCategoryList.categoryList[i].name)>=length){
			 tmpCategoryList.categoryList[i].iscut=true;
			 tmpCategoryList.categoryList[i].cutname=getcutedstring(tmpCategoryList.categoryList[i].name,length,false);
		 }else{
			 tmpCategoryList.categoryList[i].iscut=false;
			 tmpCategoryList.categoryList[i].cutname=tmpCategoryList.categoryList[i].name;
		 }
		}
	
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
		
		$("area"+pageobj.curareaindex+"_a_"+pageobj.curindex).focus();
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
			pageobj.areas[pageobj.curareaindex].changefocusEvent(direction);
		}

		pageobj.pageTurnEvent = function(num){
			pageobj.areas[pageobj.curareaindex].pageTurnEvent(num);	 
		}

</script>
</head>

<body style="background:url(../images/bg-tv02.jpg) no-repeat;">

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
		<div id="area1_list_0" class="item">
			<div class="link"><a id="area1_a_0" href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">首页</div>
        </div>
		<div id="area1_list_1" class="item" style="left:80px;">
			<div class="link"><a id="area1_a_1" href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">追剧</div>
        </div>
		<div id="area1_list_2" class="item" style="left:160px;">
			<div class="link"><a id="area1_a_2" href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">内地</div>
        </div>
		<div id="area1_list_3" class="item" style="left:240px;">
			<div class="link"><a id="area1_a_3" href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">港台</div>
        </div>
		<div id="area1_list_4" class="item" style="left:320px;">
			<div class="link"><a id="area1_a_4" href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">日韩</div>
        </div>
		<div id="area1_list_5" class="item" style="left:400px;">
			<div class="link"><a id="area1_a_5" href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">欧美</div>
        </div>
		<div id="area1_list_6" class="item" style="left:480px;">
			<div class="link"><a id="area1_a_6" href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">类型</div>
        </div>
		<div id="area1_list_7" class="item item_select" style="left:560px;">
			<div class="link"><a id="area1_a_7" href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">专题</div>
        </div>
	</div>
<!-- menu the end-->


<!-- 热门专题 -->
	<div class="pic" style="left:105px; top:127px;"><img src="../images/font-topic.png" alt="热门专题" /></div>
	<div class="tv-topic">
		<div id="area4_list_0" class="item item-a">
			<div class="link"><a id="area4_a_0" href="#"><img src="../images/t.gif" width="305" height="66" /></a></div>
			<div class="txt txt-num-top">1</div>
			<div id="area4_img_0" class="pic" style="visibility:<%if(area4SelectIndex==0){%>visible;<%}else{%>hidden;<%}%>"><img src="${categoryListData.categoryList[0].poster}" /></div>
			<div id="area4_txt_0" class="txt txt01">
                    <% if(tempcategoryList.size()>0) {
					   if(getbytelength(tempcategoryList.getJSONObject(0).get("name").toString())>=area4NameLength){
						  %>
						   <%=getcutedstring(tempcategoryList.getJSONObject(0).get("name").toString(),area4NameLength,false)%>
					<%}else{%>
                    	 <%=tempcategoryList.getJSONObject(0).get("name").toString()%>
					<%}
				   }%>
            </div>
			<div id="area4_desc_0" class="txt txt02" style="visibility:<%if(area4SelectIndex==0){%>visible;<%}else{%>hidden;<%}%>">
                     <% if(tempcategoryList.size()>0) {
					   if(getbytelength(tempcategoryList.getJSONObject(0).get("description").toString())>=area4NameLength){
						  %>
						   <%=getcutedstring(tempcategoryList.getJSONObject(0).get("description").toString(),area4NameLength,false)%>
					<%}else{%>
                    	 <%=tempcategoryList.getJSONObject(0).get("description").toString()%>
					<%}
				   }%>
            </div>
			<div id="area4_arrow_0" class="btn" style="left:282px; top:21px;visibility:<%if(area4SelectIndex==0){%>visible;<%}else{%>hidden;<%}%>"><img src="../images/arrow-r02.png" /></div>
		</div>
		<div id="area4_list_1" class="item" style="top:66px;">
			<div class="link"><a id="area4_a_1" href="#"><img src="../images/t.gif" width="305" height="56" /></a></div>
			<div class="txt txt-num-top">2</div>
			<div id="area4_txt_1" class="txt txt01">
                    <% if(tempcategoryList.size()>1) {
					   if(getbytelength(tempcategoryList.getJSONObject(1).get("name").toString())>=area4NameLength){
						  %>
						   <%=getcutedstring(tempcategoryList.getJSONObject(1).get("name").toString(),area4NameLength,false)%>
					<%}else{%>
                    	 <%=tempcategoryList.getJSONObject(1).get("name").toString()%>
					<%}
				   }%>
            </div>
			<div id="area4_arrow_1" class="btn" style="left:282px; top:21px;visibility:<%if(area4SelectIndex==1){%>visible;<%}else{%>hidden;<%}%>"><img src="../images/arrow-r02.png" /></div>
		</div>
		<div id="area4_list_2" class="item" style="top:122px;">
			<div class="link"><a id="area4_a_2" href="#"><img src="../images/t.gif" width="305" height="56" /></a></div>
			<div class="txt txt-num-top">3</div>
			<div id="area4_txt_2" class="txt txt01">
                    <% if(tempcategoryList.size()>2) {
					   if(getbytelength(tempcategoryList.getJSONObject(2).get("name").toString())>=area4NameLength){
						  %>
						   <%=getcutedstring(tempcategoryList.getJSONObject(2).get("name").toString(),area4NameLength,false)%>
					<%}else{%>
                    	 <%=tempcategoryList.getJSONObject(2).get("name").toString()%>
					<%}
				   }%>
            </div>
            <div id="area4_arrow_2" class="btn" style="left:282px; top:21px;visibility:<%if(area4SelectIndex==2){%>visible;<%}else{%>hidden;<%}%>"><img src="../images/arrow-r02.png" /></div>
		</div>
		<div id="area4_list_3" class="item" style="top:178px;">
			<div class="link"><a id="area4_a_3" href="#"><img src="../images/t.gif" width="305" height="56" /></a></div>
			<div class="txt txt-num">4</div>
			<div id="area4_txt_3" class="txt txt01">
                    <% if(tempcategoryList.size()>3) {
					   if(getbytelength(tempcategoryList.getJSONObject(3).get("name").toString())>=area4NameLength){
						  %>
						   <%=getcutedstring(tempcategoryList.getJSONObject(3).get("name").toString(),area4NameLength,false)%>
					<%}else{%>
                    	 <%=tempcategoryList.getJSONObject(3).get("name").toString()%>
					<%}
				   }%>
            </div>
			<div id="area4_arrow_3" class="btn" style="left:282px; top:21px;visibility:<%if(area4SelectIndex==3){%>visible;<%}else{%>hidden;<%}%>"><img src="../images/arrow-r02.png" /></div>
		</div>
		<div id="area4_list_4" class="item" style="top:234px;">
			<div class="link"><a id="area4_a_4" href="#"><img src="../images/t.gif" width="305" height="56" /></a></div>
			<div class="txt txt-num">5</div>
			<div id="area4_txt_4" class="txt txt01">
                    <% if(tempcategoryList.size()>4) {
					   if(getbytelength(tempcategoryList.getJSONObject(4).get("name").toString())>=area4NameLength){
						  %>
						   <%=getcutedstring(tempcategoryList.getJSONObject(4).get("name").toString(),area4NameLength,false)%>
					<%}else{%>
                    	 <%=tempcategoryList.getJSONObject(4).get("name").toString()%>
					<%}
				   }%>
            </div>
            <div id="area4_arrow_4" class="btn" style="left:282px; top:21px;visibility:<%if(area4SelectIndex==4){%>visible;<%}else{%>hidden;<%}%>"><img src="../images/arrow-r02.png" /></div>
		</div>
		<div id="area4_list_5" class="item" style="top:290px;">
			<div class="link"><a id="area4_a_5" href="#"><img src="../images/t.gif" width="305" height="56" /></a></div>
			<div class="txt txt-num">6</div>
            <div id="area4_txt_5" class="txt txt01">
                    <% if(tempcategoryList.size()>5) {
					   if(getbytelength(tempcategoryList.getJSONObject(5).get("name").toString())>=area4NameLength){
						  %>
						   <%=getcutedstring(tempcategoryList.getJSONObject(5).get("name").toString(),area4NameLength,false)%>
					<%}else{%>
                    	 <%=tempcategoryList.getJSONObject(5).get("name").toString()%>
					<%}
				   }%>
            </div>
            <div id="area4_arrow_5" class="btn" style="left:282px; top:21px;visibility:<%if(area4SelectIndex==5){%>visible;<%}else{%>hidden;<%}%>"><img src="../images/arrow-r02.png" /></div>
		</div>
	</div>
<!-- 热门专题 the end-->
	
	
<!-- page -->
	<div class="page-b" style="left:14px;">
		<div class="item">
			<div class="link"><a id="area2_a_0" href="#"><img src="../images/t.gif" width="41" height="24" /></a></div>
			<div class="txt">上页</div>
		</div>
		<div class="item" style="left:52px;">
			<div class="link"><a id="area2_a_1" href="#"><img src="../images/t.gif" width="41" height="24" /></a></div>
			<div class="txt">下页</div>
		</div>
	</div>
	<div id="page" class="txt" style=" font-size:18px; left:255px; top:101px; text-align:right; width:60px;"><%=tempcurCategoryPage%>/<%=temptotalCategoryPage%></div>
<!-- page the end-->


<!-- list -->	
	<div class="list-tv">
		<div id="area3_list_0" class="item" style="left:155px;visibility:<% if(tempvodList.size()>0){%>visible;<%}else{%>hidden;<%}%>">
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
		</div>
		<div id="area3_list_1" class="item" style="left:310px;visibility:<% if(tempvodList.size()>1){%>visible;<%}else{%>hidden;<%}%>">
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
		<div id="area3_list_2" class="item" style="left:155px;top:203px;visibility:<% if(tempvodList.size()>2){%>visible;<%}else{%>hidden;<%}%>">
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
		<div id="area3_list_3" class="item" style="left:310px;top:203px;visibility:<% if(tempvodList.size()>3){%>visible;<%}else{%>hidden;<%}%>">
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
	</div>
<!-- list the end-->

	
</body>
<iframe name="hidden_frame" id="hidden_frame" style="visibility:hidden;" width="0" height="0" ></iframe>
</html>

