<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %> 
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
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
        return (int)(Math.ceil(valueLength));
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
  String areaid=request.getParameter("areaid")==null?"1":request.getParameter("areaid");
  String indexid=request.getParameter("indexid")==null?"0":request.getParameter("indexid");
  String categoryRightCode=request.getParameter("categoryRightCode")==null?"0":request.getParameter("categoryRightCode");
  String categoryLiftCode=request.getParameter("categoryLiftCode")==null?"0":request.getParameter("categoryLiftCode");
  categoryRightCode="10000100000000090000000000031172";
  categoryLiftCode="10000100000000090000000000031172";
  int curpage=request.getParameter("curpage")==null?1:Integer.parseInt(request.getParameter("curpage"));
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>电视剧首页-湖北广电标清EPG2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/common.css" />
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
<script type="text/javascript">

<jsp:include page="<%=vodListFile%>">             
	<jsp:param name="categoryCode" value="<%=categoryRightCode%>" /> 
	<jsp:param name="pageIndex" value="<%=curpage%>" /> 
	<jsp:param name="pageSize" value="6" /> 
	<jsp:param name="varName" value="tvVodRightList" />
	<jsp:param name="fileds" value="-1" />
	<jsp:param name="isBug" value="1" />
</jsp:include> 


<jsp:include page="<%=vodListFile%>">             
	<jsp:param name="categoryCode" value="<%=categoryRightCode%>" /> 
	<jsp:param name="pageIndex" value="1" /> 
	<jsp:param name="pageSize" value="1" /> 
	<jsp:param name="varName" value="tvVodLiftList" />
	<jsp:param name="fileds" value="-1" />
	<jsp:param name="isBug" value="1" />
</jsp:include> 




<%
 JSONObject tempjsontypeList =null;
 JSONArray tempVodList=null;
  JSONArray tempVodList1=null;
 if(request.getAttribute("tvVodRightList")!=null)
 {
 	 tempjsontypeList = (JSONObject)request.getAttribute("tvVodRightList");
	 tempVodList=(JSONArray)tempjsontypeList.get("vodDataList");
 }
 
 if(request.getAttribute("tvVodLiftList")!=null)
 {
 	 tempjsontypeList = (JSONObject)request.getAttribute("tvVodLiftList");
	 tempVodList1=(JSONArray)tempjsontypeList.get("vodDataList");
 }
 
 
 

 
 
 
%>

var initCurpage=tvVodRightList.curPage;
var initTotalpage=tvVodRightList.totalPage;

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

</script>
<script type="text/javascript">

var curareaindex=parseInt("<%=areaid%>");
var curindex=parseInt("<%=indexid%>");
var curpage=<%=curpage%>;

var area0={curindex:0,datanum:3,name:"area0"};
var area1={curindex:0,datanum:8,name:"area1"};
var area2={curindex:0,datanum:2,name:"area2"};
var area3={curindex:curindex,datanum:tvVodRightList.vodDataList.length,name:"area3",curpage:initCurpage,pagesize:initTotalpage,rows:2,cols:3};
var area4={curindex:0,datanum:1,name:"area4"};

var pageobj=new Object();

pageobj.curareaindex=parseInt("<%=areaid%>");
pageobj.curindex=parseInt("<%=indexid%>");
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

window.onload = function()
{
    pageInit();
	judgeVodNameLength();
}
function pageInit()
{
    initAreaFocus();
	initCurpgTotalpg();
}
//初始化区域获取焦点
function initAreaFocus()
{
 
    pageobj.areas[pageobj.curareaindex].curindex=pageobj.curindex;
    if(pageobj.curareaindex==1)
    { 
       setFocus(pageobj.curindex);
    }
    else
    {
       $('area'+pageobj.curareaindex+"_list_"+pageobj.curindex).focus();
    }
	
}

//初始化当前页/总页数
function initCurpgTotalpg()
{
	$("curpgTotalpg").innerHTML=initCurpage+"/"+initTotalpage;
}



//释放焦点选择
function freeFocus(area1Currindex)
{
	if($("area1_list_" + area1Currindex)!=undefined)
	{
		$("area1_list_"+area1Currindex).className="item";
	}
}	
//获得焦点选择
function setFocus(area1Currindex)
{
	if($("area1_list_" + area1Currindex)!=undefined)
	{
		$("area1_list_"+area1Currindex).className="item item_select";
	}
}	



area0.changefocusEvent=function(stepvalue)
{
    $("area0_list_"+area0.curindex).blur();
    area0.curindex=area0.curindex+stepvalue;
    if(area0.curindex<0)
    {
       area0.curindex=0;  
    }
    if(area0.curindex>area0.datanum-1)
    {
      area0.curindex=area0.datanum-1;
    }
    $("area0_list_"+area0.curindex).focus();
     pageobj.curindex=area0.curindex;
    
};


area1.changefocusEvent=function(stepvalue)
{
    //freeFocus setFocus
    freeFocus(area1.curindex);
    area1.curindex=area1.curindex+stepvalue;
    if(area1.curindex<0)
    {
       area1.curindex=0;  
    }
    if(area1.curindex>area1.datanum-1)
    {
      area1.curindex=area1.datanum-1;
    }
    pageobj.curindex=area1.curindex;
    setFocus(area1.curindex);
 
};

area2.changefocusEvent=function(stepvalue)
{
    $("area2_list_"+area2.curindex).blur();
    area2.curindex=area2.curindex+stepvalue;
    if(area2.curindex<0)
    {
       area2.curindex=0;  
    }
    if(area2.curindex>area2.datanum-1)
    {
      area2.curindex=area2.datanum-1;
    }
    pageobj.curindex=area2.curindex;
    $("area2_list_"+area2.curindex).focus();
   
}


area3.changefocusEvent=function(stepvalue)
{

    $("area3_list_"+area3.curindex).blur();
    $("area3_txt_"+area3.curindex).innerHTML =tvVodRightList.vodDataList[area3.curindex].cutname;	
    area3.curindex=area3.curindex+stepvalue;
    if(area3.curindex<0)
    {
       area3.curindex=0;  
    }
    if(area3.curindex>area3.datanum-1)
    {
      area3.curindex=area3.datanum-1;
    }
    pageobj.curindex=area3.curindex;
    $("area3_list_"+area3.curindex).focus();
    gunDVodname();
}


// 判断影片的名字是否超过容纳的最大长度，
//若超过获得焦点时候滚动
function judgeVodNameLength()
{
	 for(var i=0;i<tvVodRightList.vodDataList.length;i++)
	 {
		 if(getbytelength(tvVodRightList.vodDataList[i].name)>=8)
		 {
			 tvVodRightList.vodDataList[i].iscut=true;
			 tvVodRightList.vodDataList[i].cutname=getcutedstring(tvVodRightList.vodDataList[i].name,8,false);
		 }else
		 {
			 tvVodRightList.vodDataList[i].iscut=false;
			 tvVodRightList.vodDataList[i].cutname=tvVodRightList.vodDataList[i].name;
		 }
	}
	for(var i=0;i<tvVodLiftList.vodDataList.length;i++)
	 {
		 if(getbytelength(tvVodLiftList.vodDataList[i].name)>=8)
		 {
			 tvVodLiftList.vodDataList[i].iscut=true;
			 tvVodLiftList.vodDataList[i].cutname=getcutedstring(tvVodLiftList.vodDataList[i].name,8,false);
		 }else
		 {
			 tvVodLiftList.vodDataList[i].iscut=false;
			 tvVodLiftList.vodDataList[i].cutname=tvVodLiftList.vodDataList[i].name;
		 }
	}
	
}

function gunDVodname()
{
	if(tvVodRightList.vodDataList[area3.curindex].iscut==true)
	{	
	   $("area3_txt_"+area3.curindex).innerHTML ="<marquee>"+tvVodRightList.vodDataList[area3.curindex].name+"</marquee>";	
	}else
	{
	   $("area3_txt_"+area3.curindex).innerHTML =tvVodRightList.vodDataList[area3.curindex].name;	
	}
	
	
}

function gunDVodname1()
{
	if(tvVodLiftList.vodDataList[area4.curindex].iscut==true)
	{	
	   $("area4_txt_"+area4.curindex).innerHTML ="<marquee>"+tvVodLiftList.vodDataList[area4.curindex].name+"</marquee>";	
	}else
	{
	   $("area4_txt_"+area4.curindex).innerHTML =tvVodLiftList.vodDataList[area4.curindex].name;	
	}
}



pageobj.move=function(direction){
	switch(direction){
		   case 0:
		   {
			   if(pageobj.curareaindex==1)
			   {
				   freeFocus(area1.curindex);
				   pageobj.curareaindex=0;
				   pageobj.curindex=0;
				   $("area0_list_0").focus();	   
			   }else if(pageobj.curareaindex==2)
			   {  
			      $("area2_list_"+area2.curindex).blur();
			      setFocus(area1.curindex);
			      pageobj.curareaindex=1;
			      pageobj.curindex=area1.curindex;   
			   }else  if(pageobj.curareaindex==3)
			   {
			       if(area3.curindex==3||area3.curindex==4||area3.curindex==5)
		           {
					 $("area3_txt_"+area3.curindex).innerHTML =tvVodRightList.vodDataList[area3.curindex].cutname;
		             $("area3_list_"+area3.curindex).blur();
		             area3.curindex=area3.curindex-area3.cols;
		             $("area3_list_"+area3.curindex).focus();
		             pageobj.curindex=area3.curindex;
					 gunDVodname();
		           }else
		           {
					  $("area3_txt_"+area3.curindex).innerHTML =tvVodRightList.vodDataList[area3.curindex].cutname;
		              $("area3_list_"+area3.curindex).blur();
		              $("area2_list_"+area2.curindex).focus();
		              pageobj.curareaindex=2;
		              pageobj.curindex=area2.curindex;
					  
		           }
				   
			   }
			   else if(pageobj.curareaindex==4)
			   {
				   $("area4_txt_"+area4.curindex).innerHTML =tvVodRightList.vodDataList[area4.curindex].cutname;
			       $("area4_list_"+area4.curindex).blur();
			       $("area2_list_"+area2.curindex).focus();
			       pageobj.curareaindex=2;
			       pageobj.curindex=area2.curindex;
				   
			   }
			   break;    
		   }
		   case 1:
		   {
		       if(pageobj.curareaindex==0)
		       {
		          pageobj.areas[pageobj.curareaindex].changefocusEvent(-1);
		       }  
		       else if(pageobj.curareaindex==1)
		       {
		          pageobj.areas[pageobj.curareaindex].changefocusEvent(-1);
		       }
		       else if(pageobj.curareaindex==2)
		       {
		          pageobj.areas[pageobj.curareaindex].changefocusEvent(-1);
		       }
		       else if(pageobj.curareaindex==3)
		       {
		          if(area3.curindex%6==0||area3.curindex%6==3)
		          {
					 $("area3_txt_"+area3.curindex).innerHTML =tvVodRightList.vodDataList[area3.curindex].cutname;
		             $("area3_list_"+(area3.curindex%6)).blur();
		             $("area4_list_"+area4.curindex).focus();
					 gunDVodname1();
		             pageobj.curareaindex=4;
		             pageobj.curindex=area4.curindex;
		          }
		          else
		          {
		             pageobj.areas[pageobj.curareaindex].changefocusEvent(-1);
		          } 
		       }
		       
		       break;    
		   }
		   
		   case 2:
		   {
		      if(pageobj.curareaindex==0)
		       {
		        
		           $("area0_list_"+area0.curindex).blur();
		           pageobj.curareaindex=1;
		           pageobj.curindex=area1.curindex;
		           setFocus(area1.curindex);
		       }
		       else if(pageobj.curareaindex==1)
		       {
		           freeFocus(area1.curindex);
		           $("area2_list_"+area2.curindex).focus();
		           pageobj.curareaindex=2;
		           pageobj.curindex=area2.curindex;
		           
		       }
		       else if(pageobj.curareaindex==2)
		       {
		           $("area2_list_"+area2.curindex).blur();
				   area3.curindex=0;
		           $("area3_list_"+area3.curindex).focus();
				   gunDVodname();
		           pageobj.curareaindex=3;
		           pageobj.curindex=area3.curindex;
		       }
		       else if(pageobj.curareaindex==3)
		       {
		           if(area3.curindex==0||area3.curindex==1||area3.curindex==2)
		           {
					 $("area3_txt_"+area3.curindex).innerHTML =tvVodRightList.vodDataList[area3.curindex].cutname;
		             $("area3_list_"+area3.curindex).blur();
		             area3.curindex=area3.curindex+area3.cols;
		             $("area3_list_"+area3.curindex).focus();
					  	
				     gunDVodname();
		             pageobj.curindex=area3.curindex;
		           }
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
		          pageobj.areas[pageobj.curareaindex].changefocusEvent(1);
		       }
		       else if(pageobj.curareaindex==2)
		       {
		          pageobj.areas[pageobj.curareaindex].changefocusEvent(1);
		       }
		       else if(pageobj.curareaindex==3)
		       {
		          if((area3.curindex+1)%area3.cols!=0)
		          {
		             pageobj.areas[pageobj.curareaindex].changefocusEvent(1);
		          }
		         
		       }
		       else if(pageobj.curareaindex==4)
		       {
				  $("area4_txt_"+area4.curindex).innerHTML =tvVodLiftList.vodDataList[area4.curindex].cutname;
		          $("area4_list_"+area4.curindex).blur();
		          $("area3_list_"+area3.curindex).focus();
				  gunDVodname();
		          pageobj.curareaindex=3;
		          pageobj.curindex=area3.curindex;  
		       }
		       break;  
		   }
		       
	  }
 };
 










    var KEY_BACK = 8;
	var KEY_ENTER=13;
	var KEY_OK =13;
	var KEY_HELP = 284;
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
		switch(keyval)
		{
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



 



</script>
</head>

<body style="background:url(../images/bg-tv01.jpg) no-repeat;">

	<div class="tools">	
		<div class="item">
			<div class="link"><a id="area0_list_0" href="#"><img src="../images/t.gif" width="53" height="31" /></a></div>
			<div class="txt">收藏</div>	
		</div>
		<div class="item" style="left:63px;" >
			<div class="link"><a id="area0_list_1" href="javascript:toAddress(1);"><img src="../images/t.gif" width="53" height="31" /></a></div>
			<div class="txt">书签</div>	
		</div>
		<div class="item" style="left:126px;">
			<div class="link"><a id="area0_list_2" href="javascript:toAddress(2);" ><img src="../images/t.gif" width="53" height="31" /></a></div>
			<div class="txt">搜索</div>	
		</div>
	</div>	
	
<!-- menu -->
	<div class="menu-tv">
		<!--选中为
			class="item item_select"
		-->
		<div class="item"  id="area1_list_0">
			<div class="link"><a href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">首页</div>
        </div>
		<div class="item" style="left:80px;" id="area1_list_1">
			<div class="link"><a href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">追剧</div>
        </div>
		<div class="item" style="left:160px;" id="area1_list_2">
			<div class="link"><a href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">内地</div>
        </div>
		<div class="item" style="left:240px;" id="area1_list_3">
			<div class="link"><a href="#"  ><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">港台</div>
        </div>
		<div class="item" style="left:320px;"  id="area1_list_4">
			<div class="link"><a href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">日韩</div>
        </div>
		<div class="item" style="left:400px;" id="area1_list_5">
			<div class="link"><a href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">欧美</div>
        </div>
		<div class="item" style="left:480px;"  id="area1_list_6">
			<div class="link"><a href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">类型</div>
        </div>
		<div class="item" style="left:560px;" id="area1_list_7">
			<div class="link"><a href="#"><img src="../images/t.gif" width="55" height="38" /></a></div>
			<div class="txt">专题</div>

        </div>
	</div>
	<div class="icon" style="left:485px; top:90px;"><img src="../images/tv-topic.png" alt="金庸影视专题" /></div>
<!-- menu the end-->


<!-- 推荐 -->
	<div class="pic" style="left:34px; top:127px;"><img src="../images/font-tuijian.png" alt="重磅推荐" /></div>
	<div class="tv-pic">
		<div class="link"><a href="#" id="area4_list_0" ><img src="../images/t.gif" width="132" height="174" /></a></div>
		<div class="pic"><img src="../images/demopic/pic-120X161.jpg" /></div>
		<div class="txt-wrap" id="area4_txt_0">
        <% if(tempVodList1.size()>0) {
					   if(getbytelength(tempVodList1.getJSONObject(0).get("name").toString())>8){
						  %>
						   <%=getcutedstring(tempVodList1.getJSONObject(0).get("name").toString(),8,false)%>
					<%}else{%>
						<%=tempVodList1.getJSONObject(0).get("name").toString()%>
					<%}
				   }%>
        </div>
		<div class="txt-mark"><div class="txt" id="area4_txt_1">至第10集</div></div>
	</div>
	<div class="tv-info">
		<div class="txt" id="area4_info_0">
         <% if(tempVodList1.size()>0) {
					   if(getbytelength(tempVodList1.getJSONObject(0).get("description").toString())>54){
						  %>
						   <%=getcutedstring(tempVodList1.getJSONObject(0).get("description").toString(),54,false)%>
					<%}else{%>
						<%=tempVodList1.getJSONObject(0).get("description").toString()%>
					<%}
				   }%>
        
        
        </div>
	</div>
<!-- 推荐 the end-->
	
	
<!-- page -->
	<div class="page-b">
		<div class="item">
			<div class="link"><a href="#" id="area2_list_0"><img src="../images/t.gif" width="41" height="24" /></a></div>
			<div class="txt">上页</div>
		</div>
		<div class="item" style="left:52px;">
			<div class="link"><a href="#" id="area2_list_1"><img src="../images/t.gif" width="41" height="24" /></a></div>
			<div class="txt">上页</div>
		</div>
	</div>
	<div class="txt" id="curpgTotalpg" style=" font-size:18px; left:300px; top:101px; width:60px;">1/34</div>
<!-- page the end-->


<!-- list -->	
	<div class="list-tv">
		<div class="item" >
			<div class="link"><a href="#" id="area3_list_0"><img src="../images/t.gif" width="132" height="175" /></a></div>
			<div class="pic"><img id="area3_img_0" src="../images/demopic/pic-120X140.jpg" /></div>
			<div class="txt-wrap" id="area3_txt_0">
            <% if(tempVodList.size()>0) {
					   if(getbytelength(tempVodList.getJSONObject(0).get("name").toString())>8){
						  %>
						   <%=getcutedstring(tempVodList.getJSONObject(0).get("name").toString(),8,false)%>
					<%}else{%>
						<%=tempVodList.getJSONObject(0).get("name").toString()%>
					<%}
				   }%>
            
            
            </div>
			<!--<div class="txt-mark"><div class="txt">至第10集</div></div>-->
		</div>
		<div class="item" style="left:155px;">
			<div class="link"><a href="#" id="area3_list_1"><img src="../images/t.gif" width="132" height="175" /></a></div>
			<div class="pic"><img id="area3_img_1"  src="../images/demopic/pic-120X140.jpg" /></div>
			<div class="txt-wrap" id="area3_txt_1" >
            <% if(tempVodList.size()>1) {
					   if(getbytelength(tempVodList.getJSONObject(1).get("name").toString())>8){
						  %>
						   <%=getcutedstring(tempVodList.getJSONObject(1).get("name").toString(),8,false)%>
					<%}else{%>
						<%=tempVodList.getJSONObject(1).get("name").toString()%>
					<%}
				   }%>
            </div>
		</div>
		<div class="item" style="left:310px;">
			<div class="link"><a href="#" id="area3_list_2"><img src="../images/t.gif" width="132" height="175" /></a></div>
			<div class="pic"><img id="area3_img_2" src="../images/demopic/pic-120X140.jpg" /></div>
			<div class="txt-wrap" id="area3_txt_2">
            <% if(tempVodList.size()>2) {
					   if(getbytelength(tempVodList.getJSONObject(2).get("name").toString())>8){
						  %>
						   <%=getcutedstring(tempVodList.getJSONObject(2).get("name").toString(),8,false)%>
					<%}else{%>
						<%=tempVodList.getJSONObject(2).get("name").toString()%>
					<%}
				   }%>
            </div>
		</div>
		<div class="item" style="top:203px;">
			<div class="link"><a href="#" id="area3_list_3"><img src="../images/t.gif" width="132" height="175" /></a></div>
			<div class="pic"><img id="area3_img_3" src="../images/demopic/pic-120X140.jpg" /></div>
			<div class="txt-wrap" id="area3_txt_3">
            <% if(tempVodList.size()>3) {
					   if(getbytelength(tempVodList.getJSONObject(3).get("name").toString())>8){
						  %>
						   <%=getcutedstring(tempVodList.getJSONObject(3).get("name").toString(),8,false)%>
					<%}else{%>
						<%=tempVodList.getJSONObject(3).get("name").toString()%>
					<%}
				   }%>
            </div>
		</div>
		<div class="item" style="left:155px;top:203px;">
			<div class="link"><a href="#" id="area3_list_4"><img  src="../images/t.gif" width="132" height="175" /></a></div>
			<div class="pic"><img id="area3_img_4" src="../images/demopic/pic-120X140.jpg" /></div>
			<div class="txt-wrap" id="area3_txt_4">
            <% if(tempVodList.size()>4) {
					   if(getbytelength(tempVodList.getJSONObject(4).get("name").toString())>8){
						  %>
						   <%=getcutedstring(tempVodList.getJSONObject(4).get("name").toString(),8,false)%>
					<%}else{%>
						<%=tempVodList.getJSONObject(4).get("name").toString()%>
					<%}
				   }%>
            
            </div>
		</div>
		<div class="item" style="left:310px;top:203px;">
			<div class="link"><a href="#" id="area3_list_5"><img src="../images/t.gif" width="132" height="175" /></a></div>
			<div class="pic"><img id="area3_img_5" src="../images/demopic/pic-120X140.jpg" /></div>
			<div class="txt-wrap" id="area3_txt_5">
            <% if(tempVodList.size()>5) {
					   if(getbytelength(tempVodList.getJSONObject(5).get("name").toString())>8){
						  %>
						   <%=getcutedstring(tempVodList.getJSONObject(5).get("name").toString(),8,false)%>
					<%}else{%>
						<%=tempVodList.getJSONObject(5).get("name").toString()%>
					<%}
				   }%>     
            </div>
		</div>
	</div>
<!-- list the end-->

	
</body>
</html>
