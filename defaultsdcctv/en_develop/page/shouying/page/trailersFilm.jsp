<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="datajsp/trailersFilmData.jsp"%>
<%@ include file="datajsp/menuName.jsp"%>
<%@ include file="util/save_focus.jsp"%>
<%@ page import="com.huawei.iptvmw.epg.facade.service.UserRecordImpl" %>
<%
UserRecordImpl recordServiceHelpHWCTC = new UserRecordImpl(request);
Map userRecord = new HashMap();
int iType = 3;          
try             
{ 
   userRecord = recordServiceHelpHWCTC.queryRewardPoints(iType);
}                       
catch(Exception e){

} 
int recordPoints = 0;
recordPoints =  (Integer)userRecord.get("AVAILABLE_TELE_REWARD_POINTS");
 
  String path = request.getRequestURI().substring(0,request.getRequestURI().lastIndexOf("/")+1);   
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>动作-深圳标清首映EPG2.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
var area0,area1,area2,area3,area4;
var pageobj;
var userrecord = <%=recordPoints%>;
var areaid = 2,indexid = 0;
var cruntpage="";
var area1_numString ="";
var area3_numString ="";
var temppageTurnList=new Array();
var returnurl = '<%=request.getParameter("returnurl")==null?"index.jsp":request.getParameter("returnurl")%>';
var headListData = [{cateName:"首页",cateURL:"index.jsp"},
                    {cateName:"动作",cateURL:"actionFilm.jsp"},
					{cateName:"喜剧",cateURL:"comedyFilm.jsp"},
					{cateName:"爱情",cateURL:"affectionalFilm.jsp"},
					{cateName:"惊悚",cateURL:"thrillerFilm.jsp"},
					{cateName:"其他",cateURL:"otherFilm.jsp"},
					{cateName:"片花",cateURL:"trailersFilm.jsp"},
					{cateName:"片库",cateURL:"vaultFilm.jsp"}];
var nameList = <%=jsonTypeInfo%>;
window.onload = function()
{
	 area4=AreaCreator(1,2,new Array(-1,-1,0,-1),"area4_list_","className:item item_focus","className:item ");
	 area4.areaOkEvent=function(){
		 saveFocstr(pageobj);
		 if(area4.curindex == 1){
			 location.href="../../../../../defaultsdcctv/en/page/jifen/index.jsp?returnUrl=../../../../defaultgdsd/en/page/shouying/page/index.jsp"; 
			 }else{
				  location.href="order-monthly3.jsp?returnurl="+escape(window.location.href);
				 }
      
      };
	area0 = AreaCreator(1,8,new Array(4,-1,1,-1),"area0_list_","className:item item_focus","className:item");
	area0.setfocuscircle(1);
	for(i=0;i<8;i++)
	{
	   area0.doms[i].contentdom=$("area0_text_"+i);
	}
	area0.areaOkEvent = function()
	{
		if(area0.curindex!=6)
		{
		    window.location.href=headListData[area0.curindex].cateURL+"?returnurl="+returnurl;
		}
	}
	//bindHeadCatedata(headListData);
	initMenu(nameList);
	
	area2 = AreaCreator(2,4,new Array(1,-1,3,-1),"area2_list_","className:item item_focus","className:item");
	//area2.stablemoveindex=new Array("4-0>3","4-0>3","0-1>0","3-0>4");
	//area1.setfocuscircle(1);
	area2.pagecount = Math.ceil(contentTotal/8);
	for(i=0;i<8;i++)
	{
	   //area2.doms[i].contentdom=$("area2_text_"+i);
	   area2.doms[i].imgdom=$("area2_icon_"+i);
	}
	area2.areaOkEvent = function()
	{
		if(temppageTurnList[area2.curindex].VODID!=undefined)
		{
			window.location.href="detail.jsp?vodid="+temppageTurnList[area2.curindex].VODID+"&cateNamePosition=6&returnurl="+escape(location.href)+"&typeid=<%=pianhua%>";
			saveFocstr(pageobj);
		}
	}
	
	        
			
			
	//area2.setcrossturnpage();
	area2.asyngetdata=function()
	{
		//turnpageShowData(this.curpage)
		$('hidden_frame').src = "<%=basePath%>datajsp/trailersFilmData.jsp?isFirstFlag=1&stratPosition="+(this.curpage-1)*8;
		//getAJAXData("datajsp/trailersFilmData.jsp?stratPosition="+(this.curpage-1)*8+"&isFirstFlag=1",bindFilmsData);
		
	}
	
	area1 = AreaCreator(1,4,new Array(0,-1,2,-1),"area1_list_","className:item item_focus","className:item");
	area1.stablemoveindex = new Array("0-6,1-6,2-6,3-6",-1,-1,-1);
	area1.areaOkEvent = function()
	{
		if(area1.curindex==0)
		{
			area2.pageTurn(1);
			$("area2_list_"+area2.curindex).className="item";
		}
		else if(area1.curindex==1)
		{
		    area2.pageTurn(-1);
			$("area2_list_"+area2.curindex).className="item";
		}
		else if(area1.curindex==3)
		{
			if(area1_numString!=""&&area1_numString.charAt(0)!=0&&area1_numString.length<=4
			   &&area1_numString>0&&area1_numString<=area2.pagecount)
			{
				area2.curpage=parseInt(area1_numString);
			    $('hidden_frame').src = "<%=basePath%>datajsp/trailersFilmData.jsp?isFirstFlag=1&stratPosition="+(area2.curpage-1)*8;
			}
			else
			{
				area1_numString="";
			    $("area1_list_3").innerHTML = area1_numString;
			}
		}
		else
		{
			window.location.href=returnurl;
		}
		
	}
	
	area1.goBackEvent = function()
	{
		if(area1.curindex==3)
		{
			if(area1_numString!="")
			{
				pageobj.backurl=undefined;
				area1_numString=area1_numString.substring(0,area1_numString.length-1);
				$("area1_list_3").innerHTML = area1_numString;
			}
		}
		else
		{
		    pageobj.backurl=returnurl;
		}
	}
	
	
	   
	   
	area3 = AreaCreator(1,4,new Array(2,-1,-1,-1),"area3_list_","className:item item_focus","className:item");
	area3.areaOkEvent = function()
	{
		if(area3.curindex==0)
		{
			area2.pageTurn(1);
			$("area2_list_"+area2.curindex).className="item";
		}
		else if(area3.curindex==1)
		{
		    area2.pageTurn(-1);
			$("area2_list_"+area2.curindex).className="item";
		}
		else if(area3.curindex==3)
		{
			if(area3_numString!=""&&area3_numString.charAt(0)!=0&&area3_numString.length<=4
			   &&area3_numString>0&&area3_numString<=area2.pagecount)
			{
				area2.curpage=parseInt(area3_numString);
			    $('hidden_frame').src = "<%=basePath%>datajsp/trailersFilmData.jsp?isFirstFlag=1&stratPosition="+(area2.curpage-1)*8;
			}
			else
			{
				area3_numString="";
			    $("area3_list_3").innerHTML = area3_numString;
			}
		}
		else
		{
			window.location.href=returnurl;
		}
	}
	
	area3.goBackEvent = function()
	{
		if(area3.curindex==3)
		{
			if(area3_numString!="")
			{
				pageobj.backurl=undefined;
				area3_numString=area3_numString.substring(0,area3_numString.length-1);
				$("area3_list_3").innerHTML = area3_numString;
			}
		}
		else
		{
		    pageobj.backurl=returnurl;
		}
	}
	
	area0.goBackEvent = function()
	{
		pageobj.backurl=returnurl;
	}
	
	area2.goBackEvent = function()
	{
		pageobj.backurl=returnurl;
	}
	
	if(focusObj!=undefined&&focusObj!="null")
	{
		areaid = parseInt(focusObj[0].areaid);
		indexid = parseInt(focusObj[0].curindex);
		cruntpage = parseInt(focusObj[0].curpage);
	}
	
	pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):6, new Array(area0,area1,area2,area3,area4),null);
	document.getElementById("jifentxt").innerHTML = userrecord;
	pageobj.pageNumTypeEvent=function(num)
	{
	    showPageNUM(num);
    }
	
	if(cruntpage!=""&&cruntpage!=1)
	{
		area2.curpage = cruntpage;
	    $('hidden_frame').src = "<%=basePath%>datajsp/trailersFilmData.jsp?isFirstFlag=1&stratPosition="+(area2.curpage-1)*8;
	}
	else
	{
	    bindFilmsData(trailersFilmData);
	}
}

function initMenu(data){
		area0.doms[1].setcontent("",data.name1,10,true,true);
		area0.doms[2].setcontent("",data.name2,10,true,true);
		area0.doms[3].setcontent("",data.name3,10,true,true);
		area0.doms[4].setcontent("",data.name4,10,true,true);
		area0.doms[5].setcontent("",data.name5,10,true,true);
		area0.doms[6].setcontent("",data.name6,10,true,true);
		area0.doms[7].setcontent("",data.name7,10,true,true);
		}
function bindHeadCatedata(datavalue)
{
	for(i=0;i<area0.doms.length;i++)
	{
	   if(i<datavalue.length)
	   {
		   area0.doms[i].setcontent("",datavalue[i].cateName,10,true,true);
	   }
	   else
	   {
		   area0.doms[i].updatecontent("");
	   }
	}
	
}


  
  
function bindFilmsData(datavalue)
{
	temppageTurnList = datavalue;
    var start = (area2.curpage-1)*8;
	var size = (contentTotal-start)>=8?8:(contentTotal-start);
	area2.setpageturndata(size, area2.pagecount);
	//document.getElementById("testText").innerHTML=datavalue.length;
	if(area2.pagecount<=1)
	{
		area1.doms[0].setCanFocus(false,2);
		area3.doms[0].setCanFocus(false,2);
		area1.doms[1].setCanFocus(false,2);
		area3.doms[1].setCanFocus(false,2);
		$("areaGray1_list_0").style.display="block";
		$("areaGray3_list_0").style.display="block";
		$("areaGray1_list_1").style.display="block";
		$("areaGray3_list_1").style.display="block";
	}
	else
	{
		if(area2.curpage == 1)
		{
			area1.doms[0].setCanFocus(true);
			area3.doms[0].setCanFocus(true);
			area1.doms[1].setCanFocus(false,2);
			area3.doms[1].setCanFocus(false,2);
			$("areaGray1_list_0").style.display="none";
			$("areaGray3_list_0").style.display="none";
			$("areaGray1_list_1").style.display="block";
			$("areaGray3_list_1").style.display="block";
			if(pageobj.curareaid == 1&&area1.curindex==1)
			{
				pageobj.changefocus(1,0);
				$("areaGray1_list_1").style.display="block";
			}
			if(pageobj.curareaid == 3&&area3.curindex==1)
			{
				pageobj.changefocus(3,0);
				$("areaGray3_list_1").style.display="block";
			}
		}
		else if(area2.curpage == area2.pagecount)
		{
			area1.doms[1].setCanFocus(true);
			area3.doms[1].setCanFocus(true);
			area1.doms[0].setCanFocus(false,1);
			area3.doms[0].setCanFocus(false,1);
		/*	$("area1_list_0").className="item item_not";
			$("area3_list_0").className="item item_not";*/
			$("areaGray1_list_1").style.display="none";
			$("areaGray3_list_1").style.display="none";
			$("areaGray1_list_0").style.display="block";
			$("areaGray3_list_0").style.display="block";
			if(pageobj.curareaid == 1&&area1.curindex==0)
			{
				pageobj.changefocus(1,1);
				$("areaGray1_list_0").style.display="block";
			}
			if(pageobj.curareaid == 3&&area3.curindex==0)
			{
				pageobj.changefocus(3,1);
				$("areaGray3_list_0").style.display="block";
			}
		
		}
		else
		{
			area1.doms[0].setCanFocus(true);
			area1.doms[1].setCanFocus(true);
			area3.doms[0].setCanFocus(true);
			area3.doms[1].setCanFocus(true);
			$("areaGray1_list_1").style.display="none";
			$("areaGray3_list_1").style.display="none";
			$("areaGray1_list_0").style.display="none";
			$("areaGray3_list_0").style.display="none";
		}
	}
	for(i=0;i<area2.doms.length;i++)
	{
	   if(i<datavalue.length)
	   {
		   //area2.doms[i].setcontent("",datavalue[i].VODNAME,8,true,true);
		   area2.doms[i].updateimg(datavalue[i].POSTERPATHS==undefined?"../images/nopicture.jpg":"../../"+datavalue[i].POSTERPATHS);
		   $("area2_list_"+i).style.display="block";
	   }
	   else
	   {
		   //area2.doms[i].updatecontent("暂无数据");
		   area2.doms[i].updateimg("#");
		   $("area2_list_"+i).style.display="none";
	   }
	}
	
	if(datavalue.length>0)
	{ 
	    $("page_1").innerHTML = "页"+area2.curpage+"/"+area2.pagecount+"页";
		$("page_2").innerHTML = "页"+area2.curpage+"/"+area2.pagecount+"页";
	}
	else
	{
		$("page_1").innerHTML = "";
		$("page_2").innerHTML = "";
	}
}

function showPageNUM(num)
{
	if(pageobj.curareaid==1&&area1.curindex==3&&area1_numString.length<4)
	{
		area1_numString =area1_numString+num;
		$("area1_list_3").innerHTML = area1_numString;
	}
	
	if(pageobj.curareaid==3&&area3.curindex==3&&area3_numString.length<4)
	{
		area3_numString =area3_numString+num;
		$("area3_list_3").innerHTML = area3_numString;
	}

}

      
	  
	  
</script>
</head>

<body bgcolor="transparent">

<!--pagebg-->
<div class="pagebg">
	<div class="pic"><img src="../images/bg-common.jpg" width="640" height="530" /></div>
</div>
<!--pagebg the end-->



<iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="0" height="0" ></iframe>
<div class="wrapper">

	<!--head-->
	<div class="logo"><img src="../images/logo.png" /></div>
	<div class="btn btn-buy">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area4_list_0"><!--特惠包月--></div>
		<div class="pic"><img src="../images/buy01.png" /></div>
	</div>
        <div class="btn btn-shop" id="txtposition">
			
			<div class="item" id="area4_list_1"><!--积分商城--></div>
			<div class="pic"><img src="../images/buy02.png" /></div>
		
        </div>
			<div id="jifentxt" class="txt" style="color:#88d200;left: 543px;top: 23px;width:65px;"></div>
	<!--head the end-->

	
	<!--menu-->
		<div class="menu">
			<!--焦点 
				class="item item_focus"
				选中
				class="item item_select"
			-->
			<div class="item" id="area0_list_0">
				<div class="txt" id="area0_text_0">首页</div>
			</div>    
			<div class="item" id="area0_list_1" style="left:77px;">
				<div class="txt" id="area0_text_1"></div>
			</div> 
			<div class="item" id="area0_list_2" style="left:154px;">
				<div class="txt" id="area0_text_2"></div>
			</div>
			<div class="item" id="area0_list_3" style="left:231px;">
				<div class="txt" id="area0_text_3"></div>
			</div> 
			<div class="item" id="area0_list_4" style="left:308px;">
				<div class="txt" id="area0_text_4"></div>
			</div> 
			<div class="item" id="area0_list_5" style="left:385px;">
				<div class="txt" id="area0_text_5"></div>
			</div> 
			<div class="item" id="area0_list_6" style="left:462px;">
                <div class="item item_select"></div>
				<div class="txt" id="area0_text_6"></div>
			</div> 
			<div class="item" id="area0_list_7" style="left:539px;">
				<div class="txt" id="area0_text_7"></div>
			</div>  
		</div>
	<!--menu the end-->
	
	
	
	<!--pages-->
	<div class="pages">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="btn">
			<div class="item" id="area1_list_0">下页</div>
            <div class="item item_not" id="areaGray1_list_0" style="display:none">下页</div>
			<div class="item" id="area1_list_1" style="left:60px;">上页</div>
            <div class="item item_not" id="areaGray1_list_1" style="left:60px;display:none">上页</div>
			<div class="item" id="area1_list_2" style="left:120px;">返回</div>
		</div>
		<div class="input">
			<div class="txt" id="testText">跳转至</div>
			<div class="item" id="area1_list_3" style="left:64px;"></div>
			<div class="txt" style="left:122px;" id="page_1"></div>
		</div>
	</div>
	<!--pages the end-->
	
	
	
	<!--list-->
	<div class="list-a">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="item" id="area2_list_0">
			<div class="pic"><img id="area2_icon_0" src="#" /></div>
			<!--<div class="txt-wrap">
				<div class="txt" id="area2_text_0"></div>
			</div>-->
		</div>
		<div class="item" id="area2_list_1" style="left:150px;">
			<div class="pic"><img id="area2_icon_1" src="#" /></div>
			<!--<div class="txt-wrap">
				<div class="txt" id="area2_text_1"></div>
			</div>-->
		</div>
		<div class="item" id="area2_list_2" style="left:300px;">
			<div class="pic"><img id="area2_icon_2" src="#" /></div>
			<!--<div class="txt-wrap">
				<div class="txt" id="area2_text_2"></div>
			</div>-->
		</div>
		<div class="item" id="area2_list_3" style="left:450px;">
			<div class="pic"><img id="area2_icon_3" src="#" /></div>
			<!--<div class="txt-wrap">
				<div class="txt" id="area2_text_3"></div>
			</div>-->
		</div>
		<div class="item" id="area2_list_4" style="top:167px;">
			<div class="pic"><img id="area2_icon_4" src="#" /></div>
			<!--<div class="txt-wrap">
				<div class="txt" id="area2_text_4"></div>
			</div>-->
		</div>
		<div class="item" id="area2_list_5" style="left:150px;top:167px;">
			<div class="pic"><img id="area2_icon_5" src="#" /></div>
			<!--<div class="txt-wrap">
				<div class="txt" id="area2_text_5"></div>
			</div>-->
		</div>
		<div class="item" id="area2_list_6" style="left:300px;top:167px;">
			<div class="pic"><img id="area2_icon_6" src="#" /></div>
			<!--<div class="txt-wrap">
				<div class="txt" id="area2_text_6"></div>
			</div>-->
		</div>
		<div class="item" id="area2_list_7" style="left:450px;top:167px;">
			<div class="pic"><img id="area2_icon_7" src="#" /></div>
			<!--<div class="txt-wrap">
				<div class="txt" id="area2_text_7"></div>
			</div>-->
		</div>
	</div>
	<!--list the end-->
	
	
	
	<!--pages-->
	<div class="pages" style="top:478px;">
		<!--焦点 
				class="item item_focus"
		-->
		<div class="btn">
			<div class="item" id="area3_list_0">下页</div>
            <div class="item item_not" id="areaGray3_list_0" style="display:none">下页</div>
			<div class="item" id="area3_list_1" style="left:60px;">上页</div>
            <div class="item item_not" id="areaGray3_list_1" style="left:60px;display:none">上页</div>
			<div class="item" id="area3_list_2" style="left:120px;">返回</div>
		</div>
		<div class="input">
			<div class="txt" id="testText1">跳转至</div>
			<div class="item" id="area3_list_3" style="left:64px;"></div>
			<div class="txt" style="left:122px;" id="page_2"></div>
		</div>	
	</div>
	<!--pages the end-->
</div>
</body>
</html>