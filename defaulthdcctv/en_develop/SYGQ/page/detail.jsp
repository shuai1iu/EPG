<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="datajsp/detailData.jsp"%>
<%@ include file="util/save_focus.jsp"%>
<%
 
  String path = request.getRequestURI().substring(0,request.getRequestURI().lastIndexOf("/")+1);   
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>详情页-深圳首映专区高清 EPG3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<style type="text/css">
<!--
	body{ background:url(../images/bg-common.jpg) no-repeat;}
-->
</style>

<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
var area0,area1,area2,bookMarkArea;
var pageobj;
var areaid = '<%=request.getParameter("areaid")==null?"0":request.getParameter("areaid")%>';
var indexid = '<%=request.getParameter("indexid")==null?"0":request.getParameter("indexid")%>';
var cruntpage='<%=request.getParameter("cruntpage")==null?"1":request.getParameter("cruntpage")%>';
var isSticom="";
var subNumList = new Array();
var subIdList = new Array();
var temppageTurnList=new Array()
var returnurl = '<%=request.getParameter("returnurl")==null?"actionFilm.jsp":request.getParameter("returnurl")%>';
var cateNamePosition = '<%=request.getParameter("cateNamePosition")==null?"0":request.getParameter("cateNamePosition")%>';
var isAssess="";
var isBookMark="";
var isPlay='<%=request.getParameter("isPlay")==null?"1":request.getParameter("isPlay")%>';
var fatherSeriesId = '<%=progid %>'; //传递过来的vodid
var contentType="";
var progId ="";
var temppageTurnVodIdList;
var popup0;
var headListData = [{cateName:"首页"},
                    {cateName:"动作"},
					{cateName:"喜剧"},
					{cateName:"爱情"},
					{cateName:"惊悚"},
					{cateName:"其他"},
					{cateName:"片花"},
					{cateName:"片库"},
					{cateName:"人气"},
					{cateName:"推荐"},
					{cateName:"热映"}]
var isbookmark = false;   //判断是否存在书签
var begintime,endtime;    //开始时间，结束时间
window.onload = function()
{		
	isSticom = mediadetailInfo.ISSITCOM;
	isAssess = mediadetailInfo.ISASSESS;
	isBookMark = mediadetailInfo.ISBOOKMARK;
	contentType = mediadetailInfo.CONTENTTYPE;
	if(isSticom==0)
	{
	    area2=AreaCreator(1,1,new Array(-1,-1,0,-1),"area2_list_","className:item item_focus","className:item");
        area2.areaOkEvent=function(){
            location.href="order-monthly3.jsp";
        };
		$("vodDetailDiv").style.display="block";
		area0 = AreaCreator(1,4,new Array(1,-1,-1,-1),"areaDetail0_list_","className:item item_focus","className:item");
		area0.areaOkEvent = function()
	    {
			if(area0.curindex==0&&isPlay=="1")
			{
				 progId = mediadetailInfo.VODID;
				  var play_url = "../../au_PlayFilm.jsp?PROGID="+progId;
				  play_url+="&FATHERSERIESID="+fatherSeriesId;
				  play_url+="&CONTENTTYPE="+contentType;
				  play_url+="&BUSINESSTYPE=1";
				  play_url+="&PLAYTYPE=1&ISVIP=1";
				  play_url+="&returnurl="+escape("<%=basePath%>detail.jsp?areaid=0&indexid=0&cateNamePosition="+cateNamePosition+"&isPlay="+isPlay+"&vodid="+fatherSeriesId+"&returnurl="+returnurl);
				  window.location.href=play_url;
				  //saveFocstr(pageobj);
				 // getAJAXData("check_subscribe.jsp?VODID=<%=progid%>&FATHERID=<%=progid%>&SUBJECTID=<%=typeid%>&CONTENTTYPE=<%=voddetailInfo.get("CONTENTTYPE")%>&BUSINESSTYPE=1&PLAYTYPE=1",checksubscribe);
			}
			else if(area0.curindex==1&&isBookMark==true)
			{
				  progId = mediadetailInfo.VODID;
				  var play_url = "../../au_PlayFilm.jsp?PROGID="+progId;
				  play_url+="&FATHERSERIESID="+fatherSeriesId;
				  play_url+="&CONTENTTYPE="+contentType;
				  play_url+="&BUSINESSTYPE=1";
				  play_url+="&PLAYTYPE=6&ISVIP=1";
				  play_url+="&BEGINTIME="+mediadetailInfo.BEGINTIME;
				  play_url+="&ENDTIME="+mediadetailInfo.ENDTIME;
				  play_url+="&returnurl="+escape("<%=basePath%>detail.jsp?areaid=0&indexid=1&cateNamePosition="+cateNamePosition+"&isPlay="+isPlay+"&vodid="+fatherSeriesId+"&returnurl="+returnurl);
				  window.location.href=play_url;
				  //$("cateName").innerHTML=location.href;
				  //saveFocstr(pageobj);
				//getAJAXData("check_subscribe.jsp?VODID=<%=progid%>&FATHERID=<%=progid%>&SUBJECTID=<%=typeid%>&CONTENTTYPE=<%=voddetailInfo.get("CONTENTTYPE")%>&BUSINESSTYPE=1&PLAYTYPE=1",checksubscribe1);
			}
			else if(area0.curindex==2&&isAssess==1)
			{
			
			}
			else if(area0.curindex==3)
			{
				//$("cateName").innerHTML=returnurl;
				window.location.href=returnurl;
			}
	    }
		
		if(isAssess==0||isAssess==undefined)
		{
		   $("areaDetail0_list_2").className="item item_not";
		}
		else
		{
		   $("areaDetail0_list_2").className="item";
		}
		
		if(isBookMark==false||isBookMark==undefined)
		{
		   $("areaDetail0_list_1").className="item item_not";
		}
		else
		{
		   $("areaDetail0_list_1").className="item";
		}
		
		if(isPlay=="0")
		{
		   $("item_not_show_paly").className="btn btn_not_play";
		}
		else
		{
		   $("item_not_show_paly").className="btn btn-play";
		}
		
		pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area0,area2),null);
	}
	else
	{
		$("subListOptionDiv").style.display="block";
		$("subListNumDiv").style.display="block";
		subNumList = mediadetailInfo.SUBVODNUMLIST;
	    subIdList = mediadetailInfo.SUBVODIDLIST;
		temppageTurnVodIdList = subIdList;
		area0 = AreaCreator(2,8,new Array(1,-1,-1,-1),"areaTvDetail0_list_","className:item item_focus","className:item");
		//area0.setcrossturnpage();
		area0.pagecount = Math.ceil(subNumList.length/16);
		area0.asyngetdata=function()
		{
			turnpageShowData(this.curpage)
			
		}
		
		
		        
				
				
		area0.areaOkEvent = function()
	    {
			progId = temppageTurnVodIdList[area0.curindex];
			$('hidden_frame').src = "datajsp/check_bookmark.jsp?vodid="+progId;
		}
		area1 = AreaCreator(1,3,new Array(-1,-1,0,-1),"areaTvDetail1_list_","className:item item_focus","className:item");
		
		area1.areaOkEvent = function()
		{
			if(area1.curindex==0)
			{
				area0.pageTurn(1);
				$("areaTvDetail0_list_"+area0.curindex).className="item";
			}
			else if(area1.curindex==1)
			{
				area0.pageTurn(-1);
				$("areaTvDetail0_list_"+area0.curindex).className="item";
			}
			else
			{
				window.location.href=returnurl;
			}
			
		}
		
		
		bookMarkArea = AreaCreator(1,2,new Array(-1,-1,-1,-1),"bookMarkArea_","className:item item_focus","className:item");
		popup0 = new Popup("bookMarkArea",new Array(bookMarkArea));
		bookMarkArea.areaOkEvent = function()
		{
			if(bookMarkArea.curindex==0)
			{
				palySubListBookMark(begintime,endtime);
			}
			else
			{
				palySubList();
			}
			popup0.closeme();
		}
	  	popup0.goBackEvent=function()
		{
		   this.closeme();
	   	}
		
		if(cruntpage!=""&&cruntpage!=1)
		{
			area0.curpage = cruntpage;
			turnpageShowData(area0.curpage);
		}
		else
		{
			bandSubList(subNumList);
		}
		pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area0,area1),new Array(popup0));
	}
	bindContentData(mediadetailInfo);
	pageobj.backurl=returnurl;
	
	
}


        
		
function bindContentData(mediadetailInfo)
{
	$("cateName").innerHTML=headListData[cateNamePosition].cateName+">"+(mediadetailInfo.VODNAME==undefined?"暂无":mediadetailInfo.VODNAME);
	$("vodName").innerHTML =mediadetailInfo.VODNAME==undefined?"暂无":mediadetailInfo.VODNAME;
	$("postPath").src =mediadetailInfo.POSTPATH==undefined?"../images/nopicture.jpg":"../"+mediadetailInfo.POSTPATH;
	$("vodDirector").innerHTML =mediadetailInfo.DIRECTOR==undefined?"暂无信息":(getbytelength(mediadetailInfo.DIRECTOR)>24?getcutedstring(mediadetailInfo.DIRECTOR,24):mediadetailInfo.DIRECTOR);
	$("vodActor").innerHTML =mediadetailInfo.ACTOR==undefined?"暂无信息":(getbytelength(mediadetailInfo.ACTOR)>24?getcutedstring(mediadetailInfo.ACTOR,24):mediadetailInfo.ACTOR);
	if(isSticom==0)
	{
	    $("vodIntroduce").innerHTML =mediadetailInfo.INTRODUCE==undefined?"暂无信息":(getbytelength(mediadetailInfo.INTRODUCE)>206?getcutedstring(mediadetailInfo.INTRODUCE,206):mediadetailInfo.INTRODUCE);
		if(isBookMark==false&&isAssess==0)
		{
			area0.doms[1].setCanFocus(false,3);
			area0.doms[2].setCanFocus(false,3);
			area0.doms[1].unfocusstyle = new Array("className:item item_not");
			area0.doms[2].unfocusstyle = new Array("className:item item_not");
		
		}
		else if(isBookMark==true&&isAssess==0)
		{
			area0.doms[2].setCanFocus(false,3);
			area0.doms[2].unfocusstyle = new Array("className:item item_not");
		}
		else if(isBookMark==true&&isAssess==1)
		{
			area0.doms[1].setCanFocus(true);
			area0.doms[2].setCanFocus(true);
		}
		else if(isBookMark==false&&isAssess==1)
		{
			area0.doms[1].setCanFocus(false,2);
			area0.doms[1].unfocusstyle = new Array("className:item item_not");
		}
	}
	else
	{
		$("vodIntroduce").innerHTML =mediadetailInfo.INTRODUCE==undefined?"暂无信息":(getbytelength(mediadetailInfo.INTRODUCE)>130?getcutedstring(mediadetailInfo.INTRODUCE,130):mediadetailInfo.INTRODUCE);
	}

}

function turnpageShowData(cruntpageNUM)
{
	var pageTurnDataList=new Array();
	temppageTurnVodIdList=new Array()
	if(subNumList.length>16)
	{
		 var start = (cruntpageNUM-1)*16;
		 var size = (subNumList.length-start)>=16?16:(subNumList.length-start);
		 for(i=0;i<size;i++)
		 {
			pageTurnDataList[i]=subNumList[start+i];
			temppageTurnVodIdList[i]=subIdList[start+i]
		 }
		 bandSubList(pageTurnDataList);
	}
	temppageTurnList = pageTurnDataList;
}

function bandSubList(dataValue)
{
	area0.setpageturndata(dataValue.length, area0.pagecount);
	//document.getElementById("testText").innerHTML=datavalue.length;
	for(i=0;i<area0.doms.length;i++)
	{
	   if(i<dataValue.length)
	   {
		   $("areaTvDetail0_list_"+i).innerHTML=dataValue[i];
		   $("areaTvDetail0_list_"+i).style.display="block";
	   }
	   else
	   {
		   $("areaTvDetail0_list_"+i).innerHTML="";
		   $("areaTvDetail0_list_"+i).style.display="none";
	   }
	}
	
	if(subNumList.length>0)
	{ 
	    $("page").innerHTML = area0.curpage+"/"+area0.pagecount;
	}
	else
	{
		$("page").innerHTML = "";
	}

}

        
		
		

//查找书签
function checkBookmark(subVoddetailInfo){
	isbookmark = subVoddetailInfo.ISBOOKMARK;
	begintime = subVoddetailInfo.BEGINTIME;
	endtime = subVoddetailInfo.ENDTIME;
	if(isbookmark==true){  //判断是否有书签
		pageobj.popups[0].showme();
	}
	else
	{
		progId = temppageTurnVodIdList[area0.curindex];
		var play_url = "../../../au_PlayFilm.jsp?PROGID="+progId;
		play_url+="&FATHERSERIESID="+fatherSeriesId;
		play_url+="&CONTENTTYPE="+contentType;
		play_url+="&BUSINESSTYPE=1";
		play_url+="&PLAYTYPE=1&ISVIP=1";
		play_url+="&returnurl="+escape("<%=basePath%>detail.jsp?areaid=0&indexid="+area0.curindex+"&cruntpage="+area0.curpage+"&cateNamePosition="+cateNamePosition+"&isPlay="+isPlay+"&vodid="+fatherSeriesId+"&returnurl="+returnurl);
	  	window.location.href=play_url;
		//getAJAXData("check_subscribe.jsp?VODID="+progId+"&FATHERID=<%=progid%>&SUBJECTID=<%=typeid%>&CONTENTTYPE=<%=voddetailInfo.get("CONTENTTYPE")%>&BUSINESSTYPE=1&PLAYTYPE=1",checksubscribe2);	
	}
}

function palySubList()
{
	 progId = temppageTurnVodIdList[area0.curindex];
	 var play_url = "../../au_PlayFilm.jsp?PROGID="+progId;
	  play_url+="&FATHERSERIESID="+fatherSeriesId;
	  play_url+="&CONTENTTYPE="+contentType;
	  play_url+="&BUSINESSTYPE=1";
	  play_url+="&PLAYTYPE=1&ISVIP=1";
	  play_url+="&returnurl="+escape("<%=basePath%>detail.jsp?areaid=0&indexid="+area0.curindex+"&cruntpage="+area0.curpage+"&cateNamePosition="+cateNamePosition+"&isPlay="+isPlay+"&vodid="+fatherSeriesId+"&returnurl="+returnurl);
	  window.location.href=play_url;
	  //getAJAXData("check_subscribe.jsp?VODID="+progId+"&FATHERID=<%=progid%>&SUBJECTID=<%=typeid%>&CONTENTTYPE=<%=voddetailInfo.get("CONTENTTYPE")%>&BUSINESSTYPE=1&PLAYTYPE=1",checksubscribe2);
}

function palySubListBookMark(begintime,endtime)
{
	 progId = temppageTurnVodIdList[area0.curindex];
	  var play_url = "../../au_PlayFilm.jsp?PROGID="+progId;
	  play_url+="&FATHERSERIESID="+fatherSeriesId;
	  play_url+="&CONTENTTYPE="+contentType;
	  play_url+="&BUSINESSTYPE=1";
	  play_url+="&PLAYTYPE=6&ISVIP=1";
	  play_url+="&BEGINTIME="+begintime;
	  play_url+="&ENDTIME="+endtime;
	  play_url+="&returnurl="+escape("<%=basePath%>detail.jsp?areaid=0&indexid="+area0.curindex+"&cruntpage="+area0.curpage+"&cateNamePosition="+cateNamePosition+"&isPlay="+isPlay+"&vodid="+fatherSeriesId+"&returnurl="+returnurl);
	  window.location.href=play_url;
	 // getAJAXData("check_subscribe.jsp?VODID="+progId+"&FATHERID=<%=progid%>&SUBJECTID=<%=typeid%>&CONTENTTYPE=<%=voddetailInfo.get("CONTENTTYPE")%>&BUSINESSTYPE=1&PLAYTYPE=1",checksubscribe3);
}

function checksubscribe(jsonResult)
{
	//alert(jsonResult);
	var jsonResult = eval('('+jsonResult+')');
	//jsonResult.ALLOWPLAY=false;
	
	if(jsonResult.ALLOWPLAY==false)
	{
		progId = mediadetailInfo.VODID;
		var play_url = "../../au_PlayFilm.jsp?PROGID="+progId;
		play_url+="&FATHERSERIESID="+fatherSeriesId;
		play_url+="&CONTENTTYPE="+contentType;
		play_url+="&BUSINESSTYPE=1";
		play_url+="&PLAYTYPE=1";
		play_url+="&returnurl="+escape("<%=basePath%>detail.jsp?areaid=0&indexid=0&cateNamePosition="+cateNamePosition+"&isPlay="+isPlay+"&vodid="+fatherSeriesId+"&returnurl="+returnurl);
		var pageName="order.jsp?SUBJECTID=<%=typeid%>&VODID=<%=progid%>&FATHERID=<%=progid%>&PLAYTYPE=1&CONTENTTYPE=<%=voddetailInfo.get("CONTENTTYPE")%>&BUSINESSTYPE=1&returnurl="+escape(location.href)+"&playurl="+escape(play_url);
		/*$("vodIntroduce").innerHTML = "<marquee>"+pageName+"</marquee>";
		return;*/
		location.href = pageName;
	}
	else
	{
		progId = mediadetailInfo.VODID;
		var play_url = "../../au_PlayFilm.jsp?PROGID="+progId;
		play_url+="&FATHERSERIESID="+fatherSeriesId;
		play_url+="&CONTENTTYPE="+contentType;
		play_url+="&BUSINESSTYPE=1";
		play_url+="&PLAYTYPE=1";
		play_url+="&returnurl="+escape("<%=basePath%>detail.jsp?areaid=0&indexid=0&cateNamePosition="+cateNamePosition+"&isPlay="+isPlay+"&vodid="+fatherSeriesId+"&returnurl="+returnurl);
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
		progId = mediadetailInfo.VODID;
		var play_url = "../../au_PlayFilm.jsp?PROGID="+progId;
		play_url+="&FATHERSERIESID="+fatherSeriesId;
		play_url+="&CONTENTTYPE="+contentType;
		play_url+="&BUSINESSTYPE=1";
		play_url+="&PLAYTYPE=6";
		play_url+="&BEGINTIME="+mediadetailInfo.BEGINTIME;
		play_url+="&ENDTIME="+mediadetailInfo.ENDTIME;
		play_url+="&returnurl="+escape("<%=basePath%>detail.jsp?areaid=0&indexid=1&cateNamePosition="+cateNamePosition+"&isPlay="+isPlay+"&vodid="+fatherSeriesId+"&returnurl="+returnurl);
		var pageName="order.jsp?SUBJECTID=<%=typeid%>&VODID=<%=progid%>&FATHERID=<%=progid%>&PLAYTYPE=1&CONTENTTYPE=<%=voddetailInfo.get("CONTENTTYPE")%>&BUSINESSTYPE=1&returnurl="+escape(location.href)+"&playurl="+escape(play_url);
		location.href = pageName;
	}
	else
	{
		progId = mediadetailInfo.VODID;
		var play_url = "../../au_PlayFilm.jsp?PROGID="+progId;
		play_url+="&FATHERSERIESID="+fatherSeriesId;
		play_url+="&CONTENTTYPE="+contentType;
		play_url+="&BUSINESSTYPE=1";
		play_url+="&PLAYTYPE=6";
		play_url+="&BEGINTIME="+mediadetailInfo.BEGINTIME;
		play_url+="&ENDTIME="+mediadetailInfo.ENDTIME;
		play_url+="&returnurl="+escape("<%=basePath%>detail.jsp?areaid=0&indexid=1&cateNamePosition="+cateNamePosition+"&isPlay="+isPlay+"&vodid="+fatherSeriesId+"&returnurl="+returnurl);
		window.location.href=play_url;
	}
}
function checksubscribe2(jsonResult)
{
	//alert(jsonResult);
	var jsonResult = eval('('+jsonResult+')');
	//jsonResult.ALLOWPLAY=false;
	
	if(jsonResult.ALLOWPLAY==false)
	{
		progId = temppageTurnVodIdList[area0.curindex];
		var play_url = "../../au_PlayFilm.jsp?PROGID="+progId;
		play_url+="&FATHERSERIESID="+fatherSeriesId;
		play_url+="&CONTENTTYPE="+contentType;
		play_url+="&BUSINESSTYPE=1";
		play_url+="&PLAYTYPE=1";
		play_url+="&returnurl="+escape("<%=basePath%>detail.jsp?areaid=0&indexid="+area0.curindex+"&cruntpage="+area0.curpage+"&cateNamePosition="+cateNamePosition+"&isPlay="+isPlay+"&vodid="+fatherSeriesId+"&returnurl="+returnurl);
	    var pageName="order.jsp?SUBJECTID=<%=typeid%>&VODID="+progId+"&FATHERID=<%=progid%>&PLAYTYPE=1&CONTENTTYPE=<%=voddetailInfo.get("CONTENTTYPE")%>&BUSINESSTYPE=1&returnurl="+escape(location.href)+"&playurl="+escape(play_url);
		location.href = pageName;
	}
	else
	{
		progId = temppageTurnVodIdList[area0.curindex];
		var play_url = "../../au_PlayFilm.jsp?PROGID="+progId;
		play_url+="&FATHERSERIESID="+fatherSeriesId;
		play_url+="&CONTENTTYPE="+contentType;
		play_url+="&BUSINESSTYPE=1";
		play_url+="&PLAYTYPE=1";
		play_url+="&returnurl="+escape("<%=basePath%>detail.jsp?areaid=0&indexid="+area0.curindex+"&cruntpage="+area0.curpage+"&cateNamePosition="+cateNamePosition+"&isPlay="+isPlay+"&vodid="+fatherSeriesId+"&returnurl="+returnurl);
	    window.location.href=play_url;
	}
}
function checksubscribe3(jsonResult)
{
	//alert(jsonResult);
	var jsonResult = eval('('+jsonResult+')');
	//jsonResult.ALLOWPLAY=false;
	
	if(jsonResult.ALLOWPLAY==false)
	{
		progId = temppageTurnVodIdList[area0.curindex];
		var play_url = "../../au_PlayFilm.jsp?PROGID="+progId;
		play_url+="&FATHERSERIESID="+fatherSeriesId;
		play_url+="&CONTENTTYPE="+contentType;
		play_url+="&BUSINESSTYPE=1";
		play_url+="&PLAYTYPE=6";
		play_url+="&BEGINTIME="+begintime;
		play_url+="&ENDTIME="+endtime;
		play_url+="&returnurl="+escape("<%=basePath%>detail.jsp?areaid=0&indexid="+area0.curindex+"&cruntpage="+area0.curpage+"&cateNamePosition="+cateNamePosition+"&isPlay="+isPlay+"&vodid="+fatherSeriesId+"&returnurl="+returnurl);
		var pageName="order.jsp?SUBJECTID=<%=typeid%>&VODID="+progId+"&FATHERID=<%=progid%>&PLAYTYPE=1&CONTENTTYPE=<%=voddetailInfo.get("CONTENTTYPE")%>&BUSINESSTYPE=1&returnurl="+escape(location.href)+"&playurl="+escape(play_url);
		location.href = pageName;
	}
	else
	{
		progId = temppageTurnVodIdList[area0.curindex];
		var play_url = "../../au_PlayFilm.jsp?PROGID="+progId;
		play_url+="&FATHERSERIESID="+fatherSeriesId;
		play_url+="&CONTENTTYPE="+contentType;
		play_url+="&BUSINESSTYPE=1";
		play_url+="&PLAYTYPE=6";
		play_url+="&BEGINTIME="+begintime;
		play_url+="&ENDTIME="+endtime;
		play_url+="&returnurl="+escape("<%=basePath%>detail.jsp?areaid=0&indexid="+area0.curindex+"&cruntpage="+area0.curpage+"&cateNamePosition="+cateNamePosition+"&isPlay="+isPlay+"&vodid="+fatherSeriesId+"&returnurl="+returnurl);
		window.location.href=play_url;
	}
}
</script>

</head>

<body>
    	<!--head-->
	<div class="btn btn-buy">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area2_list_0"><!--特惠包月--></div>
	</div>
	<!--head the end-->

	
	<!--head-->
	<div class="headline" id="cateName"></div>
<!--head the end-->
	
	
	
	<!--detail-->
	<div class="detail">
        <div class="txt txt-title" id="vodName"></div>
        <div class="poster-a">
            <div class="item">
                <div class="pic"><img id="postPath" src="#" /></div>
            </div>
        </div>
        <div class="pic" style="top:471px;"><img src="../images/pic-shade.png" /></div>
		<div class="txt txt01" style="top:53px;">导&nbsp;&nbsp;演 ：</div>
		<div class="txt txt01" style="top:89px;">主&nbsp;&nbsp;演 ：</div>
		<div class="txt txt01" style="top:125px;">简&nbsp;&nbsp;介 ：</div>
		
	  <div class="txt txt02" style="top:53px; font-size:20px;" id="vodDirector"></div>
	  <div class="txt txt02" style="top:89px; font-size:20px;" id="vodActor"></div>
	  <div class="txt txt02" style="top:125px;" id="vodIntroduce"></div>
</div>
	
	<!--btn-->
<div class="btn-a" id="vodDetailDiv" style="display:none">
		<!--焦点 
				class="item item_focus"
			灰色/不可用
				class="item item_not"
		-->
		<div class="item" id="areaDetail0_list_0">
			<div class="link"></div>
			<div class="btn btn-play" id="item_not_show_paly"><!--播放--></div>
		</div>
		<div class="item" id="areaDetail0_list_1" style="left:136px;">
			<div class="link"></div>
			<div class="btn btn-see" id="item_not_show_bookMark"><!--续看--></div>
		</div>
		<div class="item item_not" id="areaDetail0_list_2" style="left:272px;">
			<div class="link"></div>
			<div class="btn btn-preview" id="item_not_show_preview"><!--预览--></div>
		</div>
		<div class="item" id="areaDetail0_list_3" style="left:408px;">
			<div class="link"></div>
			<div class="btn btn-return" id="areaDetail0_list_3"><!--返回--></div>
		</div>
	</div>
<!--detail the end-->


<!--pages-->
<div class="pages" id="subListOptionDiv" style="top:455px; left:558px; display:none">
		<!--焦点 
				class="item item_focus"
			灰色/不可用
				class="item item_not"
		-->
		<div class="btn">
			<div class="item" id="areaTvDetail1_list_0">下页</div>
			<div class="item" style="left:109px;" id="areaTvDetail1_list_1">上页</div>
			<div class="item" style="left:218px;" id="areaTvDetail1_list_2">返回</div>
		</div>
		<div class="input">
			<div class="txt" style="left:0;" id="page"></div>
		</div>
	</div>
	<!--pages the end-->
<!--play-num-->
<div class="play-num" id="subListNumDiv" style="display:none">
		<!--焦点 
				class="item item_focus"
		-->	
		<div class="item" style="left:10px;" id="areaTvDetail0_list_0"></div>
		<div class="item" style="left:75px;" id="areaTvDetail0_list_1"></div>
		<div class="item" style="left:140px;" id="areaTvDetail0_list_2"></div>
		<div class="item" style="left:205px;" id="areaTvDetail0_list_3"></div>
		<div class="item" style="left:270px;" id="areaTvDetail0_list_4"></div>
		<div class="item" style="left:335px;" id="areaTvDetail0_list_5"></div>
		<div class="item" style="left:400px;" id="areaTvDetail0_list_6"></div>
		<div class="item" style="left:465px;" id="areaTvDetail0_list_7"></div>
		
		<div class="item" style="left:10px; top:64px;" id="areaTvDetail0_list_8"></div>
		<div class="item" style="left:75px;top:64px;" id="areaTvDetail0_list_9"></div>
		<div class="item" style="left:140px;top:64px;" id="areaTvDetail0_list_10"></div>
		<div class="item" style="left:205px;top:64px;" id="areaTvDetail0_list_11"></div>
		<div class="item" style="left:270px;top:64px;" id="areaTvDetail0_list_12"></div>
		<div class="item" style="left:335px;top:64px;" id="areaTvDetail0_list_13"></div>
		<div class="item" style="left:400px;top:64px;" id="areaTvDetail0_list_14"></div>
		<div class="item" style="left:465px;top:64px;" id="areaTvDetail0_list_15"></div>
  	</div>
	<!--play-num the end-->
    
    
    <!--pop up layer-->
<div class="pop-up" id="bookMarkArea" style="display:none">
	<div class="con">
		<div class="txt">是否从书签播放？</div>
		<div class="btn">
			<!--焦点 
					class="item item_focus"
				-->
			<div class="item" id="bookMarkArea_0">书签播放</div>
			<div class="item" id="bookMarkArea_1" style="left:100px;">从头播放</div>
		</div>
	</div>
</div>
<!--pop up layer the end-->	
</div>	
<iframe name="hidden_frame" id="hidden_frame" style="display: none" width="1" height="1"></iframe>	
	
</body>
</html>
