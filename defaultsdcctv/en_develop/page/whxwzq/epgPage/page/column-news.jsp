<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="../../config/code.jsp"%>
<%@ include file="../../config/properties.jsp"%>
<%!

    public static int getbytelength(String value)
	{
        double valueLength = 0;
        String chinese = "[\u4e00-\u9fa5]";
        for (int i = 0; i < value.length(); i++)
		{
            String temp = value.substring(i, i + 1);
            if (temp.matches(chinese))
			{
                valueLength += 2;
            } else 
			{
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
String vodListFile="../../" + datajspname  + "/vodList.jsp";
String categoryCode=request.getParameter("categoryCode")==null?"":request.getParameter("categoryCode");

String parentCategoryCode=request.getParameter("parentCategoryCode")==null?"":request.getParameter("parentCategoryCode");
String areaid=request.getParameter("areaid")==null?"0":request.getParameter("areaid");
String indexid=request.getParameter("indexid")==null?"0":request.getParameter("indexid");
//String categoryName=request.getParameter("categoryName")==null?"":new String(request.getParameter("categoryName").getBytes("ISO-8859-1"),"UTF-8");
String categoryName=request.getParameter("categoryName")==null?"":request.getParameter("categoryName");
String backurl = request.getParameter("backurl")==null?"":request.getParameter("backurl");
String parentCategoryimg="";
String parentCategoryName="";
if(parentCategoryCode.equals(categoryCode_hubei)){
	parentCategoryimg="bg-news-v01.jpg";
	parentCategoryName="湖北-"+categoryName;
}else if(parentCategoryCode.equals(categoryCode_minglan)){
	parentCategoryimg="bg-news-column01.jpg";
	parentCategoryName="名栏-"+categoryName;
}


if(backurl!=""){
	setCookie(response,"backurl",backurl,24);
}else{
	backurl = getCookie(request,"backurl");
}

int area1SelectIndex = request.getParameter("selectIndex")==null?0:Integer.parseInt(request.getParameter("selectIndex"));
int area1SelectPage = request.getParameter("selectPage")==null?1:Integer.parseInt(request.getParameter("selectPage"));


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>名栏-新闻联播-湖北广电标清EPG2.0</title>
<meta name="page-view-size" content="640*530" />
<%@ include file="base.jsp"%>
<style type="text/css">
.video {
	left:355px;
	position:absolute;
	top:127px;
}
/*.video .link,
.video .link img,*/
.video .pic {
	height:207px;
    width:263px;
}
.list {
	left:16px;
	position:absolute;
	top:142px;
}
.list .item {
	height:37px;
	width:312px;
}
.list .item .txt {
	color:#000;
	font-size:20px;
	line-height:37px;
	left:15px;
	width:310px;
} 
/*.list .item_focus {
	background:url(../images/list01_select.png) no-repeat;
}*/ 
.list .item_select {
	background:url(../images/list01_select.png) no-repeat;
}
.list .item_select .txt {
	color:#fff;
}
</style>
<script type="text/javascript" src="../js/MediaPlayer.js"></script>
<script type="text/javascript">

<jsp:include page="<%=vodListFile%>">             
	<jsp:param name="categoryCode" value="<%=categoryCode%>" /> 
	<jsp:param name="pageIndex" value="<%=area1SelectPage%>" /> 
	<jsp:param name="pageSize" value="10" /> 
	<jsp:param name="varName" value="colNewsVodList" />
	<jsp:param name="fileds" value="-1" />
	<jsp:param name="isBug" value="1" />
</jsp:include> 

<%
 JSONObject tempjsontypeList = new JSONObject();
 JSONArray tempVodList=new JSONArray();
 if(request.getAttribute("colNewsVodList")!=null){
 	 tempjsontypeList = (JSONObject)request.getAttribute("colNewsVodList");
	 tempVodList=(JSONArray)tempjsontypeList.get("vodDataList");
 }
%>

var initCurpage=colNewsVodList.curPage;
var initTotalpage=colNewsVodList.totalPage;
var area1SelectIndex=<%=area1SelectIndex%>;
var area1SelectPage=<%=area1SelectPage%>;
var autoPager="false";//控制自动翻页后播放
var vodListData=colNewsVodList;
function callVodListData(data)
{
	var vodlength=data.vodDataList.length;
	
	initCurpage=data.curPage;
	initTotalpage=data.totalPage;	
	initCurpgTotalpg();//更新当页/总页
	area1.datanum=vodlength;
	vodListData=data;
	for(var i=0;i<vodlength;i++)
	{
		$("area1_div_"+i).style.visibility="visible";
	//	$("area1_txt_"+i).innerHTML=data.vodDataList[i].name;
		if(getbytelength(vodListData.vodDataList[i].name)>24)
		{
			vodListData.vodDataList[i].iscut=true;
			vodListData.vodDataList[i].cutname=getcutedstring(vodListData.vodDataList[i].name,24,false);
		}else
		{
		    vodListData.vodDataList[i].iscut=false;
			vodListData.vodDataList[i].cutname=vodListData.vodDataList[i].name;
	    }
		$("area1_txt_"+i).innerHTML=vodListData.vodDataList[i].cutname;
		
	}
	if(vodlength<10)
	{
		for(var i=vodlength;i<10;i++)
		{
			$("area1_div_"+i).style.visibility="hidden";
		}
	}
	if(autoPager=="true")
	{
		var name=vodListData.vodDataList[area1SelectIndex].name;
	    $("newVodname").innerHTML=name.length>10?name.substr(0,8)+"...":name;
		initPlayUrl();	
	}
	
}


function callPlayUrlData(tempdata)
{
	//$("newVodname").innerHTML=data;
	initPlay(tempdata);
}
</script>
<script type="text/javascript">
var pageobj=new Object();
function $(id) 
{
   return document.getElementById(id);
}

function getbytelength(str)
{
	var byteLen=0,len=str.length;
	if(str)
	{
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



var area0={curindex:0,datanum:2,name:"area0"};
var area1={curindex:area1SelectIndex,datanum:colNewsVodList.vodDataList.length,name:"area1",curpage:initCurpage,pagenum:initTotalpage,pagesize:colNewsVodList.vodDataList.length,rows:10,cols:1};
var area2={curindex:0,datanum:2,name:"area2"};
var area3={curindex:0,datanum:0,name:"area3"};
var area4={curindex:0,datanum:0,name:"area4"};


var curr_focus=0;   
var curareaindex=0;
var curindex=0;


pageobj.curareaindex=<%=areaid%>;
pageobj.curindex=<%=indexid%>;
pageobj.areas=new Array();
pageobj.areas.push(area0);
pageobj.areas.push(area1);
pageobj.areas.push(area2);
pageobj.areas.push(area3);
pageobj.areas.push(area4);

area0.doms = new Array();
area2.doms = new Array();
area0.ok=function()
{
    area0.doms[area0.curindex].domOkEvent();
};

area1.ok=function()
{
	//获取playUrl进行播放
	var curDivindex=area1.curindex;
	$("area1_div_"+curDivindex).className="item item_select";
	if(area1SelectIndex==curDivindex)
	{
		$("area1_div_"+area1SelectIndex).className="item item_select";
	}else
	{
		$("area1_div_"+area1SelectIndex).className="item";
	}
	area1SelectIndex=area1.curindex;
	var name=vodListData.vodDataList[area1SelectIndex].name;
	$("newVodname").innerHTML=name.length>10?name.substr(0,8)+"...":name;
	area1SelectPage=area1.curpage;
	initPlayUrl();	
}


area2.ok=function()
{
   area2.doms[area2.curindex].domOkEvent();
};

area4.ok=function()
{
	var programCode=vodListData.vodDataList[area1.curindex].programCode;
	var tmpBackUrl="<%=tempProperBath%>column-news.jsp?parentCategoryCode=<%=parentCategoryCode%>&categoryCode="+"<%=categoryCode%>"+"&areaid=4&indexid=0&categoryName=<%=categoryName%>&selectIndex="+area1SelectIndex+"&selectPage="+area1SelectPage;
	window.location.href="<%=tempProperBath%>play_controlVod.jsp?TYPE_ID="+"<%=categoryCode%>"+"&PROGID="+programCode+"&backurl="+escape(tmpBackUrl);
}

area3.ok=function()
{
	var programCode=vodListData.vodDataList[area1.curindex].programCode;
	var tmpBackUrl="<%=tempProperBath%>column-news.jsp?parentCategoryCode=<%=parentCategoryCode%>&categoryCode="+"<%=categoryCode%>"+"&areaid=3&indexid=0&categoryName=<%=categoryName%>&selectIndex="+area1SelectIndex+"&selectPage="+area1SelectPage;
	window.location.href="<%=tempProperBath%>play_controlVod.jsp?TYPE_ID="+"<%=categoryCode%>"+"&PROGID="+programCode+"&backurl="+escape(tmpBackUrl);
}

function DomData()
{
	this.domOkEvent=undefined;
}

for(var i=0;i<2;i++)
{
   area0.doms[i]=new DomData();
   area2.doms[i]=new DomData();
}

area0.doms[0].domOkEvent=function()
{	
    if(area1.curpage>1)
	{   
	
		if(pageobj.curareaindex==1){
			$('area1_list_'+area1.curindex).blur();
			$('area1_list_0').focus();
			area1.curindex=0;
		}
	
	    area1.curpage=area1.curpage-1;
		if(area1.curpage==1)
		{
			$("area0_img_0").src="../images/btn-prev02_gray.png";
			$("area2_img_0").src="../images/btn-prev02_gray.png";
		}
		$("area0_img_1").src="../images/btn-next02.png";
		$("area2_img_1").src="../images/btn-next02.png";
		initArea1Select();
		$("getColumnNewsFrame").src="<%=tempProperBath%>iframe/getColumnNewsFrame.jsp?categoryCode="+"<%=categoryCode%>"+"&pageSize=10&curpage="+area1.curpage;
	}
}


area0.doms[1].domOkEvent=function()
{
	if(area1.curpage<area1.pagenum)
	{
	
		if(pageobj.curareaindex==1){
			$('area1_list_'+area1.curindex).blur();
			$('area1_list_0').focus();
			area1.curindex=0;
		}
	
		area1.curpage=area1.curpage+1;
		if(area1.curpage==area1.pagenum)
		{
			$("area0_img_1").src="../images/bg-next02_gray.png";
			$("area2_img_1").src="../images/bg-next02_gray.png";
		}
		$("area0_img_0").src="../images/btn-prev02.png";
		$("area2_img_0").src="../images/btn-prev02.png";
		initArea1Select();
		$("getColumnNewsFrame").src="<%=tempProperBath%>iframe/getColumnNewsFrame.jsp?categoryCode="+"<%=categoryCode%>"+"&pageSize=10&curpage="+area1.curpage;
	}
}



area2.doms[0].domOkEvent=function()
{	
    if(area1.curpage>1)
	{   
	    area1.curpage=area1.curpage-1;
		if(area1.curpage==1)
		{
			$("area0_img_0").src="../images/btn-prev02_gray.png";
			$("area2_img_0").src="../images/btn-prev02_gray.png";
		}
		$("area0_img_1").src="../images/btn-next02.png";
		$("area2_img_1").src="../images/btn-next02.png";
		initArea1Select();
		$("getColumnNewsFrame").src="<%=tempProperBath%>iframe/getColumnNewsFrame.jsp?categoryCode="+"<%=categoryCode%>"+"&pageSize=10&curpage="+area1.curpage;
	}
}

area2.doms[1].domOkEvent=function()
{
	if(area1.curpage<area1.pagenum)
	{
		area1.curpage=area1.curpage+1;
		if(area1.curpage==area1.pagenum)
		{
			$("area0_img_1").src="../images/bg-next02_gray.png";
			$("area2_img_1").src="../images/bg-next02_gray.png";
		}
		$("area0_img_0").src="../images/btn-prev02.png";
		$("area2_img_0").src="../images/btn-prev02.png";
		initArea1Select();
		$("getColumnNewsFrame").src="<%=tempProperBath%>iframe/getColumnNewsFrame.jsp?categoryCode="+"<%=categoryCode%>"+"&pageSize=10&curpage="+area1.curpage;
	}
}

area0.changefocusEvent = function(stepvalue)
{
	 $("area0_list_"+area0.curindex).blur();
	 area0.curindex=stepvalue+area0.curindex;
	 if(area0.curindex<0)
	 {
		area0.curindex=area0.datanum-1;
	 }
	 if(area0.curindex>=area0.datanum)
	 {
	     area0.curindex=0;
	 }
	 $("area0_list_"+area0.curindex).focus();
	 
 }

area1.changefocusEvent = function(stepvalue)
{
	$("area1_list_"+area1.curindex).blur();
	$("area1_txt_"+area1.curindex).innerHTML =vodListData.vodDataList[area1.curindex].cutname;	
	area1.curindex=stepvalue+area1.curindex;
    var area1curindex=area1.curindex;
	if(area1curindex<0)
	{ 
	    area1.curindex=0;
	    area0.curindex=0;
	    pageobj.curareaindex=0;
	    $("area1_list_"+area1.curindex).blur();
	    $("area0_list_"+area0.curindex).focus();
	}
	else if(area1curindex>=area1.datanum)
	{
	    area1.curindex=area1.datanum-1;
	    area2.curindex=0;
	    pageobj.curareaindex=2;
	    $("area1_list_"+area1.curindex).blur();
	    $("area2_list_"+area2.curindex).focus();
	}
	else
	{
	   $("area1_list_"+area1.curindex).focus(); 
	   gunDname();
    }
	
}

area3.changefocusEvent = function(stepvalue)
{
	pageobj.curareaindex=4;
	$("area3_list_0").blur();
	$("area4_list_0").focus();
}

function gunDname()
{
	if(vodListData.vodDataList[area1.curindex].iscut==true)
	{	
	   $("area1_txt_"+area1.curindex).innerHTML ="<marquee>"+vodListData.vodDataList[area1.curindex].name+"</marquee>";	
	}else{
	   $("area1_txt_"+area1.curindex).innerHTML =vodListData.vodDataList[area1.curindex].name;	
	}
}
	 
area2.changefocusEvent = function(stepvalue)
{
	 $("area2_list_"+area2.curindex).blur();
	 area2.curindex=stepvalue+area2.curindex;
	 if(area2.curindex<0)
	 {
		area2.curindex=area2.datanum-1;
	 }
	 if(area2.curindex>=area2.datanum)
	 {
	     area2.curindex=0;
	 }
	 $("area2_list_"+area2.curindex).focus();
 }



pageobj.backurl=unescape("<%=backurl%>");

pageobj.move=function(direction){
	switch(direction){
		   case 0:
		   {
			   if(pageobj.curareaindex==1)
			   {
				    pageobj.areas[pageobj.curareaindex].changefocusEvent(-1);
				   
			   }else if(pageobj.curareaindex==2)
			   {
				    $('area2_list_'+area2.curindex).blur();
					area1.curindex=area1.datanum-1;
					area2.curindex=0;
					$('area1_list_'+area1.curindex).focus();
					pageobj.curareaindex=1;
					if(vodListData.vodDataList[area1.curindex].iscut==true)
	                {
	                    $("area1_txt_"+area1.curindex).innerHTML ="<marquee>"+vodListData.vodDataList[area1.curindex].name+"</marquee>";	
	                }
				   
			   }else  if(pageobj.curareaindex==3)
			   {
				    pageobj.areas[pageobj.curareaindex].changefocusEvent(-1);
				   
			   }
			   break;   
		   }
		   case 1:
		   {
		        if(pageobj.curareaindex==0)
	            {
	                pageobj.areas[pageobj.curareaindex].changefocusEvent(-1);
	            }
	            else if(pageobj.curareaindex==2)
				{
				    pageobj.areas[pageobj.curareaindex].changefocusEvent(-1);
	            }
				else if(pageobj.curareaindex==3)
				{
					$('area3_list_'+area3.curindex).blur();
					gunDname();
					area3.curindex=0;
					$('area1_list_'+area1.curindex).focus();
					pageobj.curareaindex=1;
	            }
			    break; 
		   }
		   case 2:
		   {
			    if(pageobj.curareaindex==0)
			    {
				     $('area0_list_'+area0.curindex).blur();
					 area0.curindex=0;
					 area1.curindex=0;
					 $('area1_list_'+area1.curindex).focus();
					 pageobj.curareaindex=1;
					 if(vodListData.vodDataList[area1.curindex].iscut==true)
	                 {
	                     $("area1_txt_"+area1.curindex).innerHTML ="<marquee>"+vodListData.vodDataList[area1.curindex].name+"</marquee>";	
	                 }		 
				}else  if(pageobj.curareaindex==1)
				{
				    pageobj.areas[pageobj.curareaindex].changefocusEvent(1); 
				}
				else  if(pageobj.curareaindex==4)
				{
					pageobj.curareaindex=3;
					$('area4_list_'+area4.curindex).focus();
					$('area3_list_'+area3.curindex).focus();
				    
				}
				
		       break;   
		   }
		   case 3:
		   {
			    if(pageobj.curareaindex==0)
			    {
		           pageobj.areas[pageobj.curareaindex].changefocusEvent(1);
			    }
				else if(pageobj.curareaindex==1)
			    {
					$('area1_list_'+area1.curindex).blur();
					$('area1_txt_'+area1.curindex).innerHTML = vodListData.vodDataList[area1.curindex].cutname;
					area3.curindex=0;
					$('area3_list_'+area3.curindex).focus();
					pageobj.curareaindex=3;
			    }
			    else if(pageobj.curareaindex==2)
			    {
		           pageobj.areas[pageobj.curareaindex].changefocusEvent(1);
			    }
			    break; 
			}
	  }
 };
 
window.onload = function()
{
    pageInit();
	$("categoryName").innerHTML="<%=parentCategoryName%>";
	var name=vodListData.vodDataList[area1SelectIndex].name;
	$("newVodname").innerHTML=name.length>10?name.substr(0,8)+"...":name;
	judgeVodNameLength();
}

pageobj.ok=function()
{
	pageobj.areas[pageobj.curareaindex].ok();
};

pageobj.pageUp=function()
{
	area0.doms[0].domOkEvent();
}
pageobj.pageDown=function()
{
	area0.doms[1].domOkEvent();
}

pageobj.goBack=function()
{
	window.location.href=pageobj.backurl;
}

function pageInit()
{
	initCurpgTotalpg();	//初始化当前页/总共页面
	initArea1Select();//初始化area1播放状态
	initPlayUrl();
	
}

// 判断影片的名字是否超过容纳的最大长度，
//若超过获得焦点时候滚动
function judgeVodNameLength()
{
	 for(var i=0;i<vodListData.vodDataList.length;i++)
	 {
		 if(getbytelength(vodListData.vodDataList[i].name)>24)
		 {
			 vodListData.vodDataList[i].iscut=true;
			 vodListData.vodDataList[i].cutname=getcutedstring(vodListData.vodDataList[i].name,24,false);
		 }else
		 {
			 vodListData.vodDataList[i].iscut=false;
			 vodListData.vodDataList[i].cutname=vodListData.vodDataList[i].name;
		 }
	}
	
}




//初始化area1是否被播放状态（item select）
function initArea1Select()
{
	if(area1.curpage==area1SelectPage)
	{
		$("area1_div_"+area1SelectIndex).className="item item_select";
	}
	else
	{
		$("area1_div_"+area1SelectIndex).className="item";
	}
	if(pageobj.curareaindex!=0){
		$("area1_list_"+area1SelectIndex).focus();
	}
}


//初始化当前页/总共页面
function initCurpgTotalpg()
{
	$("curpgTotalpg").innerHTML=initCurpage+"/"+initTotalpage+"页";
}

function initPlayUrl()
{
	mp.stop();
	var contentCode=vodListData.vodDataList[area1.curindex].contentCode;
	var programCode=vodListData.vodDataList[area1.curindex].programCode;
	$("getVodPlayUrlFrame").src="<%=tempProperBath%>iframe/getVodPlayUrlFrame.jsp?programCode="+programCode+"&contentCode="+contentCode;
	
}

//播放新闻
function initPlay(tempurl)
{
	playUrl=tempurl;
    play(355,127,263,207);
}

function playEnd()
{
	if(area1.curindex<area1.datanum)
	{
		if(area1.curindex==9)
		{
			$("area1_div_"+area1SelectIndex).className="item";
			area1SelectIndex=0;
			area1SelectPage=area1.curpage+1;
			area1.curindex=area1.curindex+1
			autoPager="true";
		    area0.doms[1].domOkEvent();

		}
		else
		{
			autoPager="false";
		    $("area1_div_"+area1SelectIndex).className="item";
		  //  area1SelectIndex=area1.curindex;
			area1.curindex=area1.curindex+1;
			area1SelectIndex=area1.curindex;
		    initArea1Select()//下一个被选中状态
			var name=vodListData.vodDataList[area1SelectIndex].name;
	        $("newVodname").innerHTML=name.length>10?name.substr(0,8)+"...":name;
		    initPlayUrl();//获取播放地址 进行播放
		}
		
		
	}
	
}


	var KEY_BACK = 8;
	var KEY_ENTER=13;
	var KEY_OK =13;
	var KEY_HELP = 124;
	var KEY_LEFT=37;
	var KEY_UP=38;
	var KEY_RIGHT=39;
	var KEY_DOWN=40;



	document.onkeypress = keyEvent;
	//document.onkeydown = keyEvent;
	function keyEvent()
	{
		var val = event.which ? event.which : event.keyCode;
		return keypress(val);
	}
	function keypress(keyval)
	{ 
	
		if(keyval==768)
		{
		    goUtility();
		}
		switch(keyval)
		{
			case 33:
			   pageobj.pageUp();
			   break;
			case 34:
			   pageobj.pageDown();
			   break;
		    case 119:
			case 87: //up
			case KEY_UP:			
				pageobj.move(0);
				break;
			
			case 97:
			case 65: //left
			case KEY_LEFT: 
				pageobj.move(1);
				break;
			case 115:
			case 83: //down
			case KEY_DOWN:
				pageobj.move(2);
				break;
		    case 100:
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
		    default:return 0;
		}
		return 0;
	}



function goUtility(){
	
	    
    	eval("eventJson = " + Utility.getEvent());
		var typeStr = eventJson.type;
    	switch(typeStr){
			case 'EVENT_FIRST_I_FRAME'://b700 V2U
    		case "EVENT_MEDIA_BEGINING"://b700 V2A
    			break;
            case "EVENT_MEDIA_ERROR":
            //	goBack();
            	break;
            case "EVENT_MEDIA_END":
				playEnd();
                break;
            default :
                return 1;
        }
        return 1;
    }


</script>
</head>

<body bgcolor="transparent" onUnload="destoryMP()">
<!--pagebg-->
<div class="pagebg">
	<div class="pic"><img src="../images/<%=parentCategoryimg%>" width="640" height="127" /></div>
	<div class="pic" style="top:127px;"><img src="../images/bg-news-v02.jpg" width="355" height="207" /></div>
	<div class="pic" style="top:127px; left:618px;"><img src="../images/bg-news-v03.jpg" width="22" height="207" /></div>
	<div class="pic" style="top:334px;"><img src="../images/bg-news-v04.jpg" width="640" height="196" /></div>
</div>
<!--pagebg the end-->

<div class="wrapper">
	<!-- head -->
	<div id="categoryName" class="txt" style="color:#000;font-size:27px;font-weight:bold;left:39px;top:53px;width:560px;"></div>
	<!-- head the end -->

	
	<!-- page -->
	<div class="page-a">
		<!--灰色为
				btn-prev02_gray.png
				btn-next02_gray.png
		-->	
		<div class="item" ><a id="area0_list_0" href="#"><img id="area0_img_0"  src="../images/btn-prev02_gray.png" alt="上页" width="88" height="36" /></a></div>
		<div class="item" style="left:100px;" ><a id="area0_list_1" href="#"><img  id="area0_img_1"  src="../images/btn-next02.png" alt="下页" width="88" height="36" /></a></div>
	</div>
	<div class="txt" style="color:#000; font-size:18px; left:229px; top:102px; text-align:right; width:100px;" id="curpgTotalpg">1/1页</div>
	<!-- page the end-->
	
	
	<!-- list -->
    <div class="list">
		<!--焦点为
				class="item item_focus" 
			选中为
				class="item item_select" 
		-->	
		<div class="item" id="area1_div_0">
			<div class="link"><a id="area1_list_0" href="#"><img src="../images/t.gif" width="312" height="37" /></a></div>
			<div class="txt" id="area1_txt_0">
                    <% if(tempVodList.size()>0) {
					   if(getbytelength(tempVodList.getJSONObject(0).get("name").toString())>24){
						  %>
						   <%=getcutedstring(tempVodList.getJSONObject(0).get("name").toString(),24,false)%>
					<%}else{%>
						<%=tempVodList.getJSONObject(0).get("name").toString()%>
					<%}
				   }%>
            </div>
		</div>
		<div class="item" style="top:32px;" id="area1_div_1">
			<div class="link"><a id="area1_list_1" href="#"><img src="../images/t.gif" width="312" height="37" /></a></div>
			<div class="txt" id="area1_txt_1">
                    <% if(tempVodList.size()>1) {
					   if(getbytelength(tempVodList.getJSONObject(1).get("name").toString())>24){
						  %>
						   <%=getcutedstring(tempVodList.getJSONObject(1).get("name").toString(),24,false)%>
					<%}else{%>
						<%=tempVodList.getJSONObject(1).get("name").toString()%>
					<%}
				   }%>
            
            </div>
		</div>
		<div class="item" style="top:64px;"  id="area1_div_2">
			<div class="link"><a id="area1_list_2" href="#"><img src="../images/t.gif" width="312" height="37" /></a></div>
			<div class="txt" id="area1_txt_2">
                    <% if(tempVodList.size()>2) {
					   if(getbytelength(tempVodList.getJSONObject(2).get("name").toString())>24){
						  %>
						   <%=getcutedstring(tempVodList.getJSONObject(2).get("name").toString(),24,false)%>
					<%}else{%>
						<%=tempVodList.getJSONObject(2).get("name").toString()%>
					<%}
				   }%>
            </div>
		</div>
		<div class="item" style="top:96px;" id="area1_div_3">
			<div class="link"><a id="area1_list_3" href="#"><img src="../images/t.gif" width="312" height="37" /></a></div>
			<div class="txt" id="area1_txt_3">
                  <% if(tempVodList.size()>3) {
					   if(getbytelength(tempVodList.getJSONObject(3).get("name").toString())>24){
						  %>
						   <%=getcutedstring(tempVodList.getJSONObject(3).get("name").toString(),24,false)%>
					<%}else{%>
						<%=tempVodList.getJSONObject(3).get("name").toString()%>
					<%}
				   }%>
            </div>
		</div>
		<div class="item" style="top:128px;" id="area1_div_4">
			<div class="link"><a id="area1_list_4" href="#"><img src="../images/t.gif" width="312" height="37" /></a></div>
			<div class="txt" id="area1_txt_4">
                    <% if(tempVodList.size()>4) {
					   if(getbytelength(tempVodList.getJSONObject(4).get("name").toString())>24){
						  %>
						   <%=getcutedstring(tempVodList.getJSONObject(4).get("name").toString(),24,false)%>
					<%}else{%>
						<%=tempVodList.getJSONObject(4).get("name").toString()%>
					<%}
				   }%>
            
            </div>
		</div>
		<div class="item" style="top:160px;" id="area1_div_5">
			<div class="link"><a id="area1_list_5" href="#"><img src="../images/t.gif" width="312" height="37" /></a></div>
			<div class="txt" id="area1_txt_5">
                   <% if(tempVodList.size()>5) {
					   if(getbytelength(tempVodList.getJSONObject(5).get("name").toString())>24){
						  %>
						   <%=getcutedstring(tempVodList.getJSONObject(5).get("name").toString(),24,false)%>
					<%}else{%>
						<%=tempVodList.getJSONObject(5).get("name").toString()%>
					<%}
				   }%>
            
            </div>
		</div>
		<div class="item" style="top:192px;" id="area1_div_6">
			<div class="link"><a id="area1_list_6" href="#"><img src="../images/t.gif" width="312" height="37" /></a></div>
			<div class="txt" id="area1_txt_6">
                   <% if(tempVodList.size()>6) {
					   if(getbytelength(tempVodList.getJSONObject(6).get("name").toString())>24){
						  %>
						   <%=getcutedstring(tempVodList.getJSONObject(6).get("name").toString(),24,false)%>
					<%}else{%>
						<%=tempVodList.getJSONObject(6).get("name").toString()%>
					<%}
				   }%>
            
            </div>
		</div>
		<div class="item" style="top:224px;" id="area1_div_7">
			<div class="link"><a id="area1_list_7" href="#"><img src="../images/t.gif" width="312" height="37" /></a></div>
			<div class="txt" id="area1_txt_7">
                    <% if(tempVodList.size()>7) {
					   if(getbytelength(tempVodList.getJSONObject(7).get("name").toString())>24){
						  %>
						   <%=getcutedstring(tempVodList.getJSONObject(7).get("name").toString(),24,false)%>
					<%}else{%>
						<%=tempVodList.getJSONObject(7).get("name").toString()%>
					<%}
				   }%>
            
            </div>
		</div>
		<div class="item" style="top:256px;" id="area1_div_8">
			<div class="link"><a id="area1_list_8" href="#"><img src="../images/t.gif" width="312" height="37" /></a></div>
			<div class="txt" id="area1_txt_8">
                   <% if(tempVodList.size()>8) {
					   if(getbytelength(tempVodList.getJSONObject(8).get("name").toString())>24){
						  %>
						   <%=getcutedstring(tempVodList.getJSONObject(8).get("name").toString(),24,false)%>
					<%}else{%>
						<%=tempVodList.getJSONObject(8).get("name").toString()%>
					<%}
				   }%>
            
             </div>
		</div>
		<div class="item" style="top:288px;" id="area1_div_9">
			<div class="link"><a id="area1_list_9" href="#"><img src="../images/t.gif" width="330" height="37" /></a></div>
			<div class="txt" id="area1_txt_9">
                    <% if(tempVodList.size()>9) {
					   if(getbytelength(tempVodList.getJSONObject(9).get("name").toString())>24){
						  %>
						   <%=getcutedstring(tempVodList.getJSONObject(9).get("name").toString(),24,false)%>
					<%}else{%>
						<%=tempVodList.getJSONObject(9).get("name").toString()%>
					<%}
				   }%>
            
            </div>
		</div>
	</div>
	<!-- list the end -->
	
	
	<!-- page -->
	<div class="page-a" style="top:468px;">
		<!--灰色为
				btn-prev02_gray.png
				btn-next02_gray.png
		-->	
		<div class="item " ><a id="area2_list_0" href="#"><img id="area2_img_0" src="../images/btn-prev02_gray.png" alt="上页" width="88" height="36" /></a></div>
		<div class="item" style="left:100px;" ><a id="area2_list_1" href="#"><img id="area2_img_1" src="../images/btn-next02.png" alt="下页" width="88" height="36" /></a></div>
	</div>
	<!-- page the end-->


	<!-- video-->
	<div class="btn" style="left:544px; top:92px;"><a id="area4_list_0" href="#"><img src="../images/full-screen.png" width="75" height="25" /></a></div>
    <div class="video">
		<div class="link"><a id="area3_list_0" href="#"><img src="../images/t.gif" width="263" height="207" /></a></div>
		<div class="pic"></div>
		<div class="btn" style="left:86px;top:58px;z-index:10;"></div>
    </div>


	<div class="txt" id="newVodname" style="color:#084124; font-size:24px; line-height:30px; left:355px; top:395px; text-align:center; width:263px;"></div>
	<div class="txt" style="color:#084124; font-size:24px; line-height:30px; left:355px; top:435px; text-align:center; width:263px;"> <<<%=categoryName%>>></div>
    <!-- video the end -->
	<iframe id="getColumnNewsFrame"  style="width:0px;height:0px;border:0px;" ></iframe> 
    <iframe id="getVodPlayUrlFrame"  style="width:0px;height:0px;border:0px;" ></iframe> 
</div>	

</body>
</html>
