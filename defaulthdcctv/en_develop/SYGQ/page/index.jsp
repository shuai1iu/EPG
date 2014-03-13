<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="datajsp/codepage.jsp"%>
<%@ include file="datajsp/indexData.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>
<%@ include file="util/save_focus.jsp"%>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ page import="com.huawei.iptvmw.epg.facade.service.UserRecordImpl" %>
<%
/*
* Date 2013-12-19
* Description ��ȡ�û�����
* Author LS
*/
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


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页-深圳首映专区高清 EPG3.0</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" rel="stylesheet" href="../css/style.css" />
<style type="text/css">
<!--
	body{ background:url(../images/bg-index.jpg) no-repeat;}
-->
</style>

<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
var area0,area1,area2,area3,area4,area5,area6,area7;
var pageobj;
var areaid = 1,indexid = 0;
var cruntpage="";
//��ȡ�û�����
var userrecord = <%=recordPoints%>;
var temppageTurnList=new Array();
var rollText;
var returnurl = '<%=request.getParameter("returnurl")==null?"../../index.jsp":request.getParameter("returnurl")%>';
var headListData = [{cateName:"首页",cateURL:"index.jsp"},
                    {cateName:"动作",cateURL:"actionFilm.jsp"},
					{cateName:"喜剧",cateURL:"comedyFilm.jsp"},
					{cateName:"爱情",cateURL:"affectionalFilm.jsp"},
					{cateName:"惊悚",cateURL:"thrillerFilm.jsp"},
					{cateName:"其他",cateURL:"otherFilm.jsp"},
					{cateName:"片花",cateURL:"trailersFilm.jsp"},
					{cateName:"片库",cateURL:"vaultFilm.jsp"}]
window.onload = function()
{
     area7=AreaCreator(1,1,new Array(-1,-1,0,-1),"area7_list_","className:item item_focus","className:item");
     area7.areaOkEvent=function(){
      };  
 //����ҳ���ӻ��ְ�ť
     area8=AreaCreator(1,1,new Array(-1,-1,0,-1),"area8_list_","className:item item_focus","className:item");
     area8.areaOkEvent=function(){
            location.href="../../jifen/index.jsp?returnUrl=../SYGQ/page/index.jsp";
      };
	area0 = AreaCreator(1,8,new Array(8,-1,1,-1),"area0_list_","className:item item_focus","className:item");
	//area0.stablemoveindex=new Array("4-0>3","4-0>3","0-1>0","3-0>4");
	area0.setfocuscircle(1);
	for(i=0;i<8;i++)
	{
	   area0.doms[i].contentdom=$("area0_text_"+i);
	  // area0.doms[i].imgdom=$("area0_icon_"+i);
	}
	area0.areaOkEvent = function()
	{
		if(area0.curindex!=0)
		{
		   window.location.href=headListData[area0.curindex].cateURL+"?returnurl=index.jsp";
		}
	/*	else
		{
			window.location.href="dangjiao/page/index.jsp";
		}*/
	}
	bindHeadCatedata(headListData);
	
	
	area1 = AreaCreator(1,1,new Array(0,-1,-1,2),"area1_list_","className:item item_focus","className:item");
	//area1.stablemoveindex=new Array("4-0>3","4-0>3","0-1>0","3-0>4");
	//area1.setfocuscircle(1);
	for(i=0;i<1;i++)
	{
	   //area1.doms[i].contentdom=$("area1_text_"+i);
	   area1.doms[i].imgdom=$("area1_icon_"+i);
	}
	area1.areaOkEvent = function()
	{
		if(reYinData[area2.curindex].VODID!=undefined)
		{
			window.location.href="detail.jsp?vodid="+reYinData[area1.curindex].VODID+"&cateNamePosition=10&returnurl="+escape(location.href)+"&typeid=<%=shouyereying%>";
			saveFocstr(pageobj);
		}
	}
	//ISSUBSCRIBED(1:订购、0:未订购)
	//ISSITCOM: 连续剧类型(0:非连续剧父集、1:连续剧父集)
	area2 = AreaCreator(2,1,new Array(0,1,-1,4),"area2_list_","className:item item_focus","className:item");
	//area2.stablemoveindex=new Array("4-0>3","4-0>3","0-1>0","3-0>4");
	//area1.setfocuscircle(1);
	for(i=0;i<2;i++)
	{
	   //area2.doms[i].contentdom=$("area2_text_"+i);
	   area2.doms[i].imgdom=$("area2_icon_"+i);
	}
	area2.areaOkEvent = function()
	{
		if(reYinData[area2.curindex+1].VODID!=undefined)
		{
			window.location.href="detail.jsp?vodid="+reYinData[area2.curindex+1].VODID+"&cateNamePosition=10&returnurl="+escape(location.href)+"&typeid=<%=shouyereying%>";
			saveFocstr(pageobj);
		}
	}
	bindReYinData(reYinData);
	
	area3 = AreaCreator(1,1,new Array(0,2,4,-1),"area3_list_","className:item item_focus","className:item");
	area3.areaOkEvent = function()
	{
		window.location.href="more.jsp?renQiORTuijianFlag=renQi&cateName=人气&returnurl="+escape(location.href);
		saveFocstr(pageobj);
	}
	
	
	area4 = AreaCreator(1,2,new Array(3,2,5,-1),"area4_list_","className:item item_focus","className:item");
	//area3.stablemoveindex=new Array("4-0>3","4-0>3","0-1>0","3-0>4");
	//area1.setfocuscircle(1);
	for(i=0;i<2;i++)
	{
	   //area4.doms[i].contentdom=$("area4_text_"+i);
	   area4.doms[i].imgdom=$("area4_icon_"+i);
	}
	area4.areaOkEvent = function()
	{
		if(renQiData[area4.curindex].VODID!=undefined)
		{
			window.location.href="detail.jsp?vodid="+renQiData[area4.curindex].VODID+"&cateNamePosition=8&returnurl="+escape(location.href)+"&typeid=<%=shouyerenqi%>";
			saveFocstr(pageobj);
		}
	}
	bindRenqiData(renQiData);
	
	
	area5 = AreaCreator(1,1,new Array(4,2,6,-1),"area5_list_","className:item item_focus","className:item");
	area5.areaOkEvent = function()
	{
		window.location.href="more.jsp?renQiORTuijianFlag=tuiJian&cateName=推荐&returnurl="+escape(location.href);
		saveFocstr(pageobj);
	}
	
	
	area6 = AreaCreator(1,2,new Array(5,2,-1,-1),"area6_list_","className:item item_focus","className:item");
	//area4.stablemoveindex=new Array("4-0>3","4-0>3","0-1>0","3-0>4");
	//area1.setfocuscircle(1);
	for(i=0;i<2;i++)
	{
	   //area6.doms[i].contentdom=$("area6_text_"+i);
	   area6.doms[i].imgdom=$("area6_icon_"+i);
	}
	area6.areaOkEvent = function()
	{
		if(tuiJianDate[area6.curindex].VARSURL.indexOf("jsp")!=-1&&tuiJianDate[area6.curindex].VARSURL!=undefined)
		{						
		    window.location.href="../../../../"+tuiJianDate[area6.curindex].VARSURL+"&returnurl="+escape(location.href)+"&typeid=<%=shouyetuijian%>";
		    saveFocstr(pageobj);
		}
	}
	bindTuijianData(tuiJianDate);
	
	if(focusObj!=undefined&&focusObj!="null")
	{
		areaid = parseInt(focusObj[0].areaid);
		indexid = parseInt(focusObj[0].curindex);
		//cruntpage = parseInt(focusObj[0].curpage);
	}
	
	rollText = <%=stringArray%>;
	setMarquee(0);
	pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area0,area1,area2,area3,area4,area5,area6,area7,area8),null);
	pageobj.backurl=returnurl;
	//���û���������ҳ��ʾ
    document.getElementById("jifentxt").innerHTML = userrecord;
}

         
		 
		 
function setMarquee(num)
{
	var tempString = rollText[num];
	//$("rollText").innerHTML="<marquee scrollamount='1' direction='up' height='20' width='550' scrolldelay='200'>"+tempString+'</marquee>';
	$("rollText").innerHTML=tempString;
	/*num++;
	var timeout;
	clearTimeout(timeout);
	if(num>=rollText.length)
	{
       num=0;	
	} 
    timeout = setTimeout("setMarquee("+num+")",8000);*/
	
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

function bindReYinData(datavalue)
{
	//ISSUBSCRIBED(1:订购、0:未订购)
	//ISSITCOM: 连续剧类型(0:非连续剧父集、1:连续剧父集)
	
	
	      
	//$("testText").innerHTML =datavalue[0].VODID;	  
		  
	//document.getElementById("testText").innerHTML='';
	for(i=0;i<(area1.doms.length+area2.doms.length);i++)
	{
		//$("rollText").innerHTML = "<marquee>"+datavalue[0].POSTERPATHS+"</marquee>>";
		if(i==0)
		{
			 if(i<datavalue.length)
			 {
				 //area1.doms[i].setcontent("",datavalue[i].VODNAME,16,true,true);
				 area1.doms[i].updateimg(datavalue[i].POSTERPATHS==undefined?"../images/nopicture.jpg":"../"+datavalue[i].POSTERPATHS);
			 }
			 else
			 {
				 //area1.doms[i].updatecontent("暂无数据");
				 area1.doms[i].updateimg("../images/zwsj.jpg");
			 }
		}
		else
		{
			 if(i<datavalue.length)
			 {
				 //area2.doms[i-1].setcontent("",datavalue[i].VODNAME,10,true,true);
				 area2.doms[i-1].updateimg(datavalue[i].POSTERPATHS==undefined?"../images/nopicture.jpg":"../"+datavalue[i].POSTERPATHS);
				 //$("area2_list_"+(i-1)).style.display="block";
			 }
			 else
			 {
				 //area2.doms[i-1].updatecontent("暂无数据");
				 area2.doms[i-1].updateimg("../images/zwsj.jpg");
		         //$("area2_list_"+(i-1)).style.display="none";
			 }
		}
	}
}

function bindRenqiData(datavalue)
{
	for(i=0;i<area4.doms.length;i++)
	{
	   if(i<datavalue.length)
	   {
		   //area4.doms[i].setcontent("",datavalue[i].VODNAME,10,true,true);
		   area4.doms[i].updateimg(datavalue[i].POSTERPATHS==undefined?"../images/nopicture.jpg":"../"+datavalue[i].POSTERPATHS);
	   }
	   else
	   {
		   //area4.doms[i].updatecontent("暂无数据");
		   area4.doms[i].updateimg("../images/zwsj.jpg");
	   }
	}
}

function bindTuijianData(datavalue)
{
	//document.getElementById("testText").innerHTML=tuiJianDate[1].VARSURL;
	for(i=0;i<area6.doms.length;i++)
	{
	   if(i<datavalue.length)
	   {
		   //area6.doms[i].setcontent("",datavalue[i].VASNAME,10,true,true);
		   area6.doms[i].updateimg(datavalue[i].POSTERPATHS==undefined?"../images/nopicture.jpg":"../"+datavalue[i].POSTERPATHS);
	   }
	   else
	   {
		   //area6.doms[i].updatecontent("暂无数据");
		   area6.doms[i].updateimg("../images/zwsj.jpg");
	   }
	}
}
</script>

</head>

<body>
   <!--head-->
	<div class="btn btn-jifen">
		<!--���� 
				class="item item_focus"
		-->
		<div class="item" id="area8_list_0"><!--���ְ�ť--></div>
	</div>
         <div class="btn btn-jifen"  style="left:795px;top:44px;color:#FFFFFF;">
            <div class="jifen_focus" id="jifentxt" style="text-align:center" ><!--��ʾ����--></div>
         </div>

	<!--head the end-->
	
	<!--menu-->
		<div class="menu">
        	<div class="item item_select" style="z-index:-2;left:0px;"></div>
			<!--焦点 
				class="item item_focus"
				选中
				class="item item_select"
			-->
            <div class="item" id="area0_list_0">
				<div class="txt" id="area0_text_0"></div>
			</div>    
			<div class="item" id="area0_list_1" style="left:152px;">
				<div class="txt" id="area0_text_1"></div>
			</div> 
			<div class="item" id="area0_list_2" style="left:304px;">
				<div class="txt" id="area0_text_2"></div>
			</div>
			<div class="item" id="area0_list_3" style="left:456px;">
				<div class="txt" id="area0_text_3"></div>
			</div> 
			<div class="item" id="area0_list_4" style="left:608px;">
				<div class="txt" id="area0_text_4"></div>
			</div> 
			<div class="item" id="area0_list_5" style="left:760px;">
				<div class="txt" id="area0_text_5"></div>
			</div> 
			<div class="item" id="area0_list_6" style="left:912px;">
				<div class="txt" id="area0_text_6"></div>
			</div> 
			<div class="item" id="area0_list_7" style="left:1064px;">
				<div class="txt" id="area0_text_7"></div>
			</div>
		</div>
	<!--menu the end-->	
	
	
	
	<!--poster-->
	<div class="poster-a">
		<!--焦点 
				class="item item_focus"
			-->
        <div class="item" id="area1_list_0">
			<div class="pic"><img id="area1_icon_0" src="#" /></div>
		<!--	<div class="txt-wrap">
				<div class="txt" id="area1_text_0"></div>
			</div>-->
		</div>
	</div>
	<div class="poster-b">
		<!--焦点 
				class="item item_focus"
			-->
        <div class="item" id="area2_list_0">
			<div class="pic"><img id="area2_icon_0" src="#" /></div>
		<!--	<div class="txt-wrap">
				<div class="txt" id="area2_text_0"></div>
			</div>-->
		</div>
		<div class="item" id="area2_list_1" style="top:215px;">
			<div class="pic"><img id="area2_icon_1" src="#" /></div>
		<!--	<div class="txt-wrap">
				<div class="txt" id="area2_text_1"></div>
			</div>-->
		</div>
	</div>
	
	<div class="poster-c">
		<!--焦点 
				class="item item_focus"
			-->
        <div class="item" id="area4_list_0">
			<div class="pic"><img id="area4_icon_0" src="#" /></div>
		<!--	<div class="txt-wrap">
				<div class="txt" id="area4_text_0"></div>
			</div>-->
		</div>
		<div class="item" id="area4_list_1" style="left:218px;">
			<div class="pic"><img id="area4_icon_1" src="#" /></div>
			<!--<div class="txt-wrap">
				<div class="txt" id="area4_text_1"></div>
			</div-->
		</div>
	</div>
	<div class="btn-more">
		<!--焦点 
				class="item item_focus"
			-->
		<div class="item" id="area3_list_0">更多></div>
	</div>
	
	<div class="poster-c" style="top:448px;">
		<!--焦点 
				class="item item_focus"
			-->
        <div class="item" id="area6_list_0">
			<div class="pic"><img id="area6_icon_0" src="#" /></div>
			<!--<div class="txt-wrap">
				<div class="txt" id="area6_text_0"></div>
			</div>-->
		</div>
		<div class="item" id="area6_list_1" style="left:218px;">
			<div class="pic"><img id="area6_icon_1" src="#" /></div>
		<!--	<div class="txt-wrap">
				<div class="txt" id="area6_text_1"></div>
			</div>-->
		</div>
	</div>
	<div class="btn-more" style="top:404px;">
		<!--焦点 
				class="item item_focus"
			-->
		<div class="item" id="area5_list_0">更多></div>
	</div>
	<!--poster the end-->
	
	
	
	<!--notice-->
	<div class="notice" id="rollText"></div>
	<!--notice the end-->
	
	
</body>
</html>
