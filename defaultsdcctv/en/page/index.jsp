﻿<%
/*******************************
 * FileName:inde.jsp
 * Time:20130909 9:30
 * Author:ZSZ
 * description:标清首页改版，
 * 部分借用上一版本源码
 *******************************/
%>
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="config/config_TrailerInVas.jsp"%>
<%@ include file="OneKeyPlay.jsp"%>
<%@ include file="util/util_AdText.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<%@ include file="save_focus.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<%@ include file="datajsp/indexdata.jsp"%>
<%@ include file="util/util_getPosterPaths.jsp"%>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<meta name="page-view-size" content="640*530"/>
<title>CCTV-IP电视</title>
<link rel="stylesheet" type="text/css" href="../css/newstyle.css" />

<style type="text/css">
<%
/*
    @decription 获取用户信息，以及是否首次进入 
	@author ls
	@date  2014-02-15
*/
UserProfile upf_Jump = new UserProfile(request);
String groupId = upf_Jump.getUserGroupId();
String userId = upf_Jump.getUserId();
String isFirst = request.getParameter("isFirst");
%>
body {
background:  url("../images/newbgsd.png") no-repeat;
}

</style>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
if (typeof(iPanel) != 'undefined'){iPanel.focusWidth = "2";iPanel.defaultFocusColor = "#FCFF05";}
var area0,area1,area2,area3,area4,area5,area6,area7,area8;
var returnurl="index.jsp";
var progId="<%=CATEGORY_TRAILER_ID%>";
/*该参数用于控制首页大窗内容为视频或图片VAS链接*/
var area5setlink = 0;        
/*通过JS方法取userId,机顶盒型号,机顶盒IP地址*/
var user = Authentication.CTCGetConfig("UserID");
var STBType = Authentication.CTCGetConfig("STBType");
var STB_IP = Authentication.CTCGetConfig("pppoe_ip");
/*
   @description changeRecommend定时触发推荐位切换
   @author LS
   @date 2013-10-31
 */
var changeRecommend =  window.setInterval("changeImage()",5000);
var changeFlag = 2;

/*下列数组用于存放首页各入口的名称与链接，便于探针调用*/
var imgVasName = new Array();
var thirdVasName;
var txtVasName = new Array();
var imgVodName = new Array();
var txtVasUrl = new Array();
var imgVasUrl = new Array();
var thirdVasUrl;
var imgVodUrl = new Array();
    var area5Url;
/*isFirst为标明首页是否是开机第一次访问*/
var isFirst = <%=isFirst%>;
window.onload=function()
{
/*当首页为开机第一次访问时，触发开机探针*/
if("1" == isFirst)
{
    document.getElementById("log_frame").src = "http://219.133.42.99:8080/EPG_Statistics/EPG_BOOT.jsp?userID="+user+"&STB_IP="+ STB_IP+"&EPG_TYPE=SD&STB_TYPE="+ STBType + "&GROUP=" + <%=groupId%>;
}
	Authentication.CTCSetConfig("key_ctrl_ex", "0");
	if(returnurl.indexOf('back=1')==-1)
	{
		if(returnurl.indexOf('?')==-1)
			returnurl+="?back=1";
		else
			returnurl+="&back=1";
	}
	returnurl=escape(returnurl);
	var backflag='<%=request.getParameter("back")%>';
	area0=AreaCreator(1,7,new Array(3,-1,8,-1),"area0_list_","afocus","ablur");
	area0.setfocuscircle(1);
	area0.stablemoveindex=new Array("6-4>0",-1,"1-5>0,2-5>0,3-5>0,4-5>0,5-6>0,6-6>0",-1);
        /* 将首页导航栏链接改为数组形式从codepage.jsp读取 20140210 LS */
 

		 /*在首页上方导航栏点击确认键时触发入口探针*/
        area0.areaOkEvent = function()
        {
              area0.doms[area0.curindex].domOkEvent=function()
              {
	          $("log_frame").src = "http://219.133.42.99:8080/EPG_Statistics/EPG_AREA.jsp?userID="+user+"&EPG_TYPE=SD&EPG_CATA=EPG_SD_CATA_UP_"+area0.curindex;
              }
              window.location.href=indexhref[area0.curindex] + "?returnurl=" + returnurl;
        }
	//直播港澳台 
	area8=AreaCreator(1,1,new Array(0,6,1,5),"area8_list_","afocus","ablur");
	area8.doms[0].contentdom=$("area8_txt_0");   
	/*在直播港澳台点击确认键时触发入口探针*/
	area8.areaOkEvent = function()
	{
              area8.doms[area8.curindex].domOkEvent = function()
              {
	          $("log_frame").src = "http://219.133.42.99:8080/EPG_Statistics/EPG_AREA.jsp?userID="+user+"&EPG_CATA_NAME="+txtVasName[area8.curindex]+"&EPG_TYPE=SD&EPG_CATA=EPG_SD_CATA_LEFT_0";
              }
              window.location.href =  txtVasUrl[area8.curindex];
	}
	//文字推荐位
	area1=AreaCreator(7,2,new Array(8,6,2,5),"area1_list_","afocus","ablur");
	area1.stablemoveindex=new Array(-1,-1,"12-2>0,13-2>1",-1);
	for(i=0;i<14;i++)
		area1.doms[i].contentdom=$("area1_txt_"+i);
	/*在文字推荐位点击确认键时触发入口探针*/
	area1.areaOkEvent = function()
	{
              area1.doms[area1.curindex].domOkEvent = function()
              {
		$("log_frame").src = "http://219.133.42.99:8080/EPG_Statistics/EPG_AREA.jsp?userID="+user+"&EPG_CATA_NAME="+txtVasName[area1.curindex + 1]+"&EPG_TYPE=SD&EPG_CATA=EPG_SD_CATA_LEFT_"+parseFloat(parseInt(area1.curindex) + 1);
              }
               window.location.href =  txtVasUrl[area1.curindex + 1];
        }

	//文字热点位
	area2=AreaCreator(3,2,new Array(1,6,3,5),"area2_list_","afocus","ablur");
	area2.stablemoveindex=new Array("0-12,1-13","0-7>2,2-7>2,4-7>2","4-0>0,5-0>0","1-7>0,3-7>0,5-7>0");
	for(i=0;i<6;i++)
	{
		area2.doms[i].contentdom=$("area2_txt_"+i);
	}
	/*在文字热点位点击确认键时触发入口探针*/
	area2.areaOkEvent = function()
	{
              area2.doms[area2.curindex].domOkEvent = function()
              {
		$("log_frame").src = "http://219.133.42.99:8080/EPG_Statistics/EPG_AREA.jsp?userID="+user+"&EPG_CATA_NAME="+txtVasName[area2.curindex + 15]+"&EPG_TYPE=SD&EPG_CATA=EPG_SD_CATA_LEFT_"+parseFloat(parseInt(area2.curindex) + 15);
              }
               window.location.href =  txtVasUrl[area2.curindex + 15]; 
              
	}

	//空间
	area3=AreaCreator(1,1,new Array(7,4,0,4),"area3_","afocus","ablur");
	area3.stablemoveindex=new Array("0-4","0-4>0",-1,-1);

/*在空间点击确认键时触发入口探针*/
        area3.areaOkEvent = function()
        {
              area3.doms[area3.curindex].domOkEvent=function()
              {
                  $("log_frame").src = "http://219.133.42.99:8080/EPG_Statistics/EPG_AREA.jsp?userID="+user+"&EPG_TYPE=SD&EPG_CATA=EPG_SD_CATA_UP_SPACE";
              }
              window.location.href="space_collect.jsp?returnurl="+returnurl;
        }
	//搜索
	area4=AreaCreator(1,1,new Array(9,3,0,3),"area4_","afocus","ablur");
	area4.stablemoveindex=new Array(-1,"0-3>0",-1,"0-0>6");

/*在搜索点击确认键时触发入口探针*/
        area4.areaOkEvent = function()
        {
              area4.doms[area4.curindex].domOkEvent=function()
              {
                  $("log_frame").src =  "http://219.133.42.99:8080/EPG_Statistics/EPG_AREA.jsp?userID="+user+"&EPG_TYPE=SD&EPG_CATA=EPG_SD_CATA_UP_SEARCH" ;
              }
              window.location.href="search.jsp?returnurl="+returnurl;
        }
	//大窗 
	area5=AreaCreator(1,1,new Array(0,8,7,6),"area5_","afocus","ablur");
	area5.doms[0].imgdom=$("area5_img_0");
	area5.stablemoveindex=new Array("0-1","0-8",-1,-1);

	/*首页大窗内容控制，0为视频，1为VAS*/
	area5setlink = <%=imageorchannel%>;        
	if(area5setlink == 0)
	{
	    area5Url="play_ControlChannel.jsp?CHANNELNUM=<%=shouyezhibo%>&COMEFROMFLAG=1&returnurl="+escape(location.href);
	}
	else if(indexiframeUrl!=null)
	{
     
	    area5Url="../../../"+indexiframeUrl;
	}
	else
	{
	    area5Url="index.jsp?returnurl="+escape(location.href);//修改了视频链接
	}
        /*在首页大窗点击确认键时触发入口探针*/
        area5.areaOkEvent = function()
        {
              area5.doms[area5.curindex].domOkEvent=function()
              {
                $("log_frame").src =  "http://219.133.42.99:8080/EPG_Statistics/EPG_AREA.jsp?userID="+user+"&EPG_TYPE=SD&EPG_CATA=EPG_SD_CATA_MEDIA_0";
              }
              window.location.href=area5Url;
        } 
	//右侧vas位 
	area6=AreaCreator(2,1,new Array(0,5,9,1),"area6_list_","afocus","ablur");
	area6.stablemoveindex=new Array("0-5",-1,-1,"0-8>0,1-8>0");
	area6.doms[0].imgdom=$("area6_img_0");
	area6.doms[1].imgdom=$("area6_img_1");
            
        /*在右侧两VAS位点击确认键时触发入口探针*/
        area6.areaOkEvent = function()
        {
              area6.doms[area6.curindex].domOkEvent=function()
              {        
                $("log_frame").src =  "http://219.133.42.99:8080/EPG_Statistics/EPG_AREA.jsp?userID="+user+"&EPG_CATA_NAME="+imgVasName[area6.curindex]+"&EPG_TYPE=SD&EPG_CATA=EPG_SD_CATA_RIGHT_"+area6.curindex;
              }
                window.location.href = imgVasUrl[area6.curindex];
        }

	//下部推荐位
	area7=AreaCreator(1,2,new Array(5,3,0,9),"area7_list_","afocus","ablur");
	area7.stablemoveindex=new Array("2-6>1","0-2>1","0-1,1-3,2-5",-1);
	for(i=0;i<2;i++)
	{
		//area7.doms[i].contentdom=$("area7_txt_"+i);
		area7.doms[i].imgdom=$("area7_img_"+i);
	}
        /*在下部两VOD位点击确认键时触发入口探针*/
        area7.areaOkEvent = function()
        {
            area7.doms[area7.curindex].domOkEvent = function()
            {
                $("log_frame").src = "http://219.133.42.99:8080/EPG_Statistics/EPG_AREA.jsp?userID="+user +"&EPG_CATA_NAME="+imgVodName[area7.curindex]+"&EPG_TYPE=SD&EPG_CATA=EPG_SD_CATA_DOWN_"+area7.curindex;
            }
            window.location.href = imgVodUrl[area7.curindex];
        }


        /*右下角推荐位*/
	area9=AreaCreator(1,1,new Array(6,7,4,2),"area9_list_","afocus","ablur");
	area9.stablemoveindex=new Array("0-6>1","0-7>1",-1,-1);
	area9.doms[0].imgdom=$("area9_img_0");
        /*在右下侧VAS位点击确认键时触发入口探针*/
        area9.areaOkEvent = function()
        {
            area9.doms[area9.curindex].domOkEvent = function()
            {
                $("log_frame").src = "http://219.133.42.99:8080/EPG_Statistics/EPG_AREA.jsp?userID="+user+"&EPG_CATA_NAME="+thirdVasName+"&EPG_TYPE=SD&EPG_CATA=EPG_SD_CATA_RIGHT_2";
            }
            window.location.href = thirdVasUrl;
        }

	var backfocus;
	if("1"==backflag){
		backfocus=getCurFocus("cindex");
	}
	pageobj=new PageObj(backfocus!=null?backfocus[0].areaid:0,backfocus!=null?backfocus[0].curindex:0,new Array(area0,area1,area2,area3,area4,area5,area6,area7,area8,area9));

	pageobj.pageOkEvent=function()
	{
		var json=createFocstr(pageobj);
		saveCookie("cindex",json!=undefined?json:"");    
	}
	pageobj.pageNumTypeEvent=function(num){
		funcInputNum(parseInt(num));
	};
	binddata();
	load_iframe();

	var backfocusareaid= backfocus!=null?backfocus[0].areaid:0; 
	if(6 == backfocusareaid || 9 == backfocusareaid)
	{
		window.clearInterval(changeRecommend);
	}		
	area6.areaInedEvent = function(){
		window.clearInterval(changeRecommend);
	}
	area6.areaOutingEvent =  function(){
		changeRecommend = window.setInterval("changeImage()",5000);
	};

	area9.areaInedEvent = function(){
		window.clearInterval(changeRecommend);
	}
	area9.areaOutingEvent =  function(){
		changeRecommend = window.setInterval("changeImage()",5000);
	};   

}


/********************
 * function:获取图片、名字等数据
 * time:20130913 11:15
 * author:ZSZ
 * description:新增获取数据异常时默认显示数据
 ********************/
function binddata()
{
	//推荐
	if(list != undefined && list != "" && list != "null" && list != null){
		VAStext(list,area1);
	}

	//热点
	if(list1 != undefined && list1 != "" && list1 != "null" && list1 != null){
		VAStext(list1,area2);
	}

	//专题 右侧2张图
	if(list2 != undefined && list2 != "" && list2 != "null" && list2 != null){
		VASimg(list2,area6);
	}

	//推荐点播
	if(list3 != undefined && list3 != "" && list3 != "null" && list3 != null){
		getdata(list3);
	}

	//电影 下侧3张图
	if(list3_vas != undefined && list3_vas != "" && list3_vas != "null" && list3_vas != null){
		VASimg1(list3_vas,area9)
	}

	//直播港澳台
	if(list4 != undefined && list4 != "" && list4 != "null" && list4 != null){
		VAStext(list4,area8);
	}

}

function changeImage()
{
	if(changeFlag == 1)
	{
		if(list2 != undefined && list2 != "" && list2 != "null" && list2 != null)
		{
			VASimg(list2_sec,area6);
			VASimg1(list3_vas_sec,area9)
			/*右侧两VAS位第二组统计*/
			area6.areaOkEvent = function()
			{
                            area6.doms[area6.curindex].domOkEvent = function()
                            {
				$("log_frame").src = "http://219.133.42.99:8080/EPG_Statistics/EPG_AREA.jsp?userID="+user+"&EPG_CATA_NAME="+imgVasName[area6.curindex]+"&EPG_TYPE=SD&EPG_CATA=EPG_SD_CATA_RIGHT_"+parseFloat(parseInt(area6.curindex) + 3);
                            }
                            window.location.href = imgVasUrl[area6.curindex];
			}
			/*右下侧VAS位第二组统计*/
			area9.areaOkEvent = function()
			{
                            area9.doms[area9.curindex].domOkEvent = function()
                            {
				$("log_frame").src = "http://219.133.42.99:8080/EPG_Statistics/EPG_AREA.jsp?userID="+user+"&EPG_CATA_NAME="+thirdVasName+"&EPG_TYPE=SD&EPG_CATA=EPG_SD_CATA_RIGHT_5";
                            }
                            window.location.href = thirdVasUrl;
			}
		}
		changeFlag = 2;
	}
	else if(changeFlag == 2)
	{
	    if(list2_sec != undefined && list2_sec != "" && list2_sec != "null" && list2_sec != null)
	    {
	        VASimg(list2,area6);
	        VASimg1(list3_vas,area9)
	        /*右侧两VAS位第一组统计*/
	        area6.areaOkEvent = function()
	        {
                    area6.doms[area6.curindex].domOkEvent = function()
                    {
	            $("log_frame").src = "http://219.133.42.99:8080/EPG_Statistics/EPG_AREA.jsp?userID="+user+"&EPG_CATA_NAME="+imgVasName[area6.curindex]+"&EPG_TYPE=SD&EPG_CATA=EPG_SD_CATA_RIGHT_"+area6.curindex;
                    }
                    window.location.href = imgVasUrl[area6.curindex];
	        }
	        /*右下侧VAS位第一组统计*/
	        area9.areaOkEvent = function()
	        {
                    area9.doms[area9.curindex].domOkEvent = function()
                    {
		        $("log_frame").src = "http://219.133.42.99:8080/EPG_Statistics/EPG_AREA.jsp?userID="+user+"&EPG_CATA_NAME="+thirdVasName+"&EPG_TYPE=SD&EPG_CATA=EPG_SD_CATA_RIGHT_2";
                    }
                            window.location.href = thirdVasUrl;
	        }
	    }
	    changeFlag = 1;
	}
}


function VAStext(data,area)
{
	area.datanum=(data.length==undefined?0:data.length);
	for(i=0;i<area.doms.length;i++)
	{
		if(i<data.length)
		{
			area.doms[i].setcontent("",data[i].VASNAME,14,false,false);
                        area.doms[i].youwannauseobj=data[i].VASID;
                        /*用于存储探针所需内容名称 20140210 LS*/
                        if ( area == area8)
                        {
			    txtVasName[i] = data[i].VASNAME;
                            txtVasUrl[i] =  "../../../"+data[i].VASURL; 
			}
			else if(area == area1)
                        {
                            txtVasName[i + 1] = data[i].VASNAME;
                            txtVasUrl[i + 1] =  "../../../"+data[i].VASURL;
                        }
                        else if (area == area2)
                        {
                            txtVasName[i + 15] = data[i].VASNAME;
                            txtVasUrl[i + 15] =  "../../../"+data[i].VASURL;
                        }
		}
		else
			area.doms[i].updatecontent("");
	}   
}

function VASimg(data,area)
{
	area.datanum=(data.length==undefined?0:data.length);
	for(i=0;i<area.doms.length;i++)
	{
		if(i<data.length)
		{
			if(changeFlag == 1)
			{
				area.doms[i].updateimg("../"+zhuantipic_sec[i]);
			}else
			{
				area.doms[i].updateimg("../"+zhuantipic[i]);
			}
			area.doms[i].youwannauseobj=data[i].VASID;
                        /*用于存储探针所需VAS链接  20140210 LS*/
                        imgVasName[i] = data[i].VASNAME;
			if(data[i].VASURL.indexOf('?')==-1)
			{
			        imgVasUrl[i] = "../../../"+data[i].VASURL+"?back=1&returnurl="+returnurl;
			}
			else
			{
				imgVasUrl[i] = "../../../"+data[i].VASURL+"&back=1&returnurl="+returnurl;
			}   
		}
		else{
			area.doms[i].updateimg("#");
		}
	}   
}

function alertVasurl(vasurl){


	window.location.href=vasurl;
}


function VASimg1(data,area)
{
	area.datanum = (data.length==undefined?0:data.length);
	if(area.datanum >= 0)
	{   
		if(changeFlag == 2)
		{
			area.doms[0].updateimg("../"+array3_vasPic[0]);
		}else
		{	
			area.doms[0].updateimg("../"+array3_vasPic_sec[0]);
		}


		area.doms[0].youwannauseobj=data[0].VASID;
	        /*存储探针所需VAS名称 LS 20140221*/
		thirdVasName = data[0].VASNAME;
		if(data[0].VASURL.indexOf('?')==-1)
		{
                        thirdVasUrl = "../../../"+data[0].VASURL+"?back=1&returnurl="+returnurl;
		}
		else
		{
                        thirdVasUrl = "../../../"+data[0].VASURL+"&back=1&returnurl="+returnurl;
		}
	}
	else
		area.doms[0].updateimg("#");
}


function getdata(data)
{   

	area7.datanum=data.length;
	for(i=0;i<area7.doms.length;i++)
	{
		if(i<data.length)
		{

			area7.doms[i].updateimg("../"+(data[i].POSTERPATHS.type3[0]!=undefined?data[i].POSTERPATHS.type3[0]:(data[i].PICPATH!=undefined?data[i].PICPATH:'images/no_picture_259x232.jpg')));
			//0:视频VOD、1:视频频道、2:音频频道、3:频道、4:音频AOD、10:VOD、100:增值业务、300:节目、9999:混合栏目
			//area7.doms[i].setcontent("",data[i].VODNAME,12);
			/*存储探针所需VOD名称 LS 20140221 */
                        imgVodName[i] = data[i].VODNAME;
	                imgVodUrl[i] = "vod-tv-detail.jsp?vodid="+data[i].VODID+"&typeid=<%=shouyerediancode%>"+"&returnurl="+returnurl;
		}
		else
			area7.doms[i].updateimg("#");

	}

}
//视频窗口
function load_iframe()
{

	if(area5setlink == 1)
	{
		progId="";//故意修改 MXR修改中间为图片
	}

	if (progId != "" && progId != "null" && progId != null)
	{	
		playPage.location.href = "PlayTrailerInVas.jsp?left=157&top=112&width=308&height=233&type="+"<%=CATEGORY_TRAILER_TYPE%>"+"&value=" + "<%=CATEGORY_TRAILER_ID%>" +"&mediacode="+ "<%=CATEGORY_TRAILER_ID%>" +"&contenttype="+ "<%=CATEGORY_TRAILER_CONTENTTYPE%>&liveid="+"<%=shouyezhibo%>"; 
	}
	else 
	{
		//document.getElementById("mid_play").src ="../images/kids.jpg";
		if(indexiframePic[0]!=null&&indexiframePic[0]!="")
			document.getElementById("mid_play").src = "../"+indexiframePic[0];
		else
			document.getElementById("mid_play").src ="../images/kids.jpg";
	}
}

//下面为音量控制	
var volumeDivIsShow = false;
var volume = 20;
function volumeUp()
{

	hideVoice();
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1){mp.setMuteFlag(0);}
	volume = mp.getVolume(); 
	volume += 5;
	if(volume >= 100){volume = 100;    }
	mp.setVolume(volume);  
	if (mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
	{
		clearTimeout(bottomTimer);
		bottomTimer = "";
		genVolumeTable(volume);
		bottomTimer = setTimeout(hideBottom, 5000);
	}
}
function volumeDown()
{	
	hideVoice();
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1)
	{
		mp.setMuteFlag(0);
	}
	volume = mp.getVolume();
	volume -= 5;	
	if(volume <= 0)
	{
		volume = 0;    
	}
	mp.setVolume(volume);  
	if (mp.getNativeUIFlag() == 0 || mp.getAudioVolumeUIFlag() == 0)
	{
		clearTimeout(bottomTimer);
		bottomTimer = "";
		genVolumeTable(volume);
		bottomTimer = setTimeout(hideBottom, 5000);
	}
}
function hideBottom()
{
	volumeDivIsShow = false;
	document.getElementById("bottomframe").innerHTML = "";
}
function hideVoice()
{
	document.getElementById("voice").src="images/dot.gif";
}
function genVolumeTable(volume)
{
	var tableDef = '<table width="980px" border="0" cellpadding="0" cellspacing="0"><tr>';
	volume = parseInt(volume / 5);
	for (i = 0; i < 40; i++)
	{
		if (i % 2 == 0)
		{
			tableDef += '<td width="20px" height="54px" bgcolor="transparent"></td>';
		}
		else
		{
			if ( i / 2 < volume)
			{
				tableDef += '<td width="20px" height="54px" bgcolor="#00ff00"></td>';
			}
			else
			{
				tableDef += '<td width="20px" height="54px" bgcolor="cccccc"></td>';
			}
		}
	}
	tableDef += '<td width="20px"></td><td width="40px"><img src="images/playcontrol/playChannel/volume.gif"></td><td width="40px" style="color:white;font-size:28">' + volume + '</td>';
	tableDef += '</tr></table>'; 
	document.getElementById("bottomframe").innerHTML = tableDef;    	
}
function setMuteFlag()
{
	hideBottom();
	clearTimeout(voiceTimer);
	bottomTimer = ""; 
	volumeDivIsShow = true;
	var muteFlag = mp.getMuteFlag();
	if(muteFlag == 1)
	{
		mp.setMuteFlag(0);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
		{
			document.getElementById("voice").src="images/playcontrol/playChannel/muteoff.png";
			voiceTimer = setTimeout(hideVoice, 5000);
		}
	}
	else
	{
		mp.setMuteFlag(1);
		if (mp.getNativeUIFlag() == 0 || mp.getMuteUIFlag() == 0)
		{
			document.getElementById("voice").src="images/playcontrol/playChannel/muteon.png";
		}
	}      
}

</script>
</head>
<body bgcolor='transparent'>
<div class="wrapper">
<!-- E LOGO -->

<div id="bottomframe" style="position:absolute;left:60px; top:590px; width:1200px; height:190px; z-index:1"></div>
<div style="position:absolute; left:816px; top:105px; width:54px; height:66px; z-index:3;"><img id="voice" src="images/dot.gif"/></div>

<!-- S 导航 -->
<div class="mod-index-nav">
<div class="item" style="left:14px;">
<div class="link"><a href="#" id="area0_list_0"><img  style="width:106px;"/></a></div>
<div class="txt" style="margin-left:10px;">直播</div>
</div>
<div class="item" style="left:120px;" >
<div class="link"><a href="#" id="area0_list_1"><img  style="width:90px;"/></a></div>
<div class="txt" style="margin-left:14px;">点播</div>
</div>
<div class="item" style="left:210px;" >
<div class="link"><a href="#" id="area0_list_2"><img  style="width:90px;"/></a></div>
<div class="txt" style="margin-left:14px;">回放</div>
</div>
<div class="item" style="left:300px;" >
<div class="link"><a href="#" id="area0_list_3"><img  style="width:90px;"/></a></div>
<div class="txt" style="margin-left:14px;">深圳</div>
</div>
<div class="item" style="left:380px;" >
<div class="link"><a href="#" id="area0_list_4"><img  style="width:90px;"/></a></div>
<div class="txt" style="margin-left:14px;">应用</div>
</div>
<div class="item item" style="left:460px;">
<div class="link"><a href="#" id="area0_list_5"><img  style="width:90px;"/></a></div>
<div class="txt" style="margin-left:14px;">专题</div>
</div>
<div class="item" style="left:545px;">
<div class="link"><a href="#" id="area0_list_6"><img  style="width:90px;"/></a></div>
<div class="txt" style="margin-left:5px;">排行</div>
</div>


<!-- E 导航 -->

<!-- S 推荐 -->







<div class="mod-index-recommend">

<div class="item" id="tuijian" style="left: 27px; top: 108px;">
<div class="link"    ><a href="#" id="area8_list_0"  ><img src="../../images/t.gif" /></a></div>
<div class="txt" id="area8_txt_0"  >直播港澳台</div>
</div>

<div class="item" style="left: 15px; top: 138px;">
<div class="link" ><a href="#" id="area1_list_0"><img src="../../images/t.gif" /></a></div>
<div class="txt" id="area1_txt_0">果果</div>
</div>
<div class="item" style="left: 80px; top: 138px;">
<div class="link"><a href="#" id="area1_list_1"><img src="../../images/t.gif" /></a></div>
<div class="txt" id="area1_txt_1">天年乐</div>
</div>
<div class="item" style="left: 15px; top: 168px;">
<div class="link"><a href="#" id="area1_list_2"><img src="../../images/t.gif" /></a></div>
<div class="txt" id="area1_txt_2">电影</div>
</div>
<div class="item" style="left: 80px; top: 168px;">
<div class="link"><a href="#" id="area1_list_3"><img src="../../images/t.gif" /></a></div>
<div class="txt" id="area1_txt_3">剧场</div>
</div>
<div class="item" style="left: 15px; top: 198px;">
<div class="link"><a href="#" id="area1_list_4"><img src="../../images/t.gif" /></a></div>
<div class="txt" id="area1_txt_4">新闻</div>
</div>
<div class="item" style="left: 80px; top: 198px;">
<div class="link"><a href="#" id="area1_list_5"><img src="../../images/t.gif" /></a></div>
<div class="txt" id="area1_txt_5">体育</div>
</div>
<div class="item" style="left: 15px; top: 228px;">
<div class="link"><a href="#" id="area1_list_6"><img src="../../images/t.gif" /></a></div>
<div class="txt" id="area1_txt_6">科教</div>
</div>
<div class="item" style="left: 80px; top: 228px;">
<div class="link"><a href="#" id="area1_list_7"><img src="../../images/t.gif" /></a></div>
<div class="txt" id="area1_txt_7">娱乐</div>
</div>
<div class="item" style="left: 15px; top: 258px;">
<div class="link"><a href="#" id="area1_list_8"><img src="../../images/t.gif" /></a></div>
<div class="txt" id="area1_txt_8">健康</div>
</div>
<div class="item" style="left: 80px; top: 258px;">
<div class="link"><a href="#" id="area1_list_9"><img src="../../images/t.gif" /></a></div>
<div class="txt" id="area1_txt_9">财经</div>
</div>
<div class="item" style="left: 15px; top: 288px;">
<div class="link"><a href="#" id="area1_list_10"><img src="../../images/t.gif" /></a></div>
<div class="txt" id="area1_txt_10">法治</div>
</div>
<div class="item" style="left: 80px; top: 288px;">
<div class="link"><a href="#" id="area1_list_11"><img src="../../images/t.gif" /></a></div>
<div class="txt" id="area1_txt_11">人文</div>
</div>
<div class="item" style="left: 15px; top: 318px;">
<div class="link"><a href="#" id="area1_list_12"><img src="../../images/t.gif" /></a></div>
<div class="txt" id="area1_txt_12">生活</div>
</div>
<div class="item" style="left: 80px; top: 318px;">
<div class="link"><a href="#" id="area1_list_13"><img src="../../images/t.gif" /></a></div>
<div class="txt" id="area1_txt_13">选秀</div>
</div>
</div>
<!-- E 推荐 -->


<!-- S 热点 -->
<div class="mod-index-hot" >
<div class="item" style="left: 15px; top: 364px;">
<div class="link"><a href="#" id="area2_list_0"><img src="../../images/t.gif" /></a></div>
<div class="txt" id="area2_txt_0">淘淘</div>
</div>
<div class="item" style="left: 80px; top: 364px;">
<div class="link"><a href="#" id="area2_list_1"><img src="../../images/t.gif" /></a></div>
<div class="txt" id="area2_txt_1">唱K</div>
</div>
<div class="item" style="left: 15px; top: 395px;">
<div class="link"><a href="#" id="area2_list_2"><img src="../../images/t.gif" /></a></div>
<div class="txt" id="area2_txt_2">高网</div>
</div>
<div class="item" style="left: 80px; top: 395px;">
<div class="link"><a href="#" id="area2_list_3"><img src="../../images/t.gif" /></a></div>
<div class="txt" id="area2_txt_3">军事</div>
</div>
<div class="item" style="left: 15px; top: 425px;">
<div class="link"><a href="#" id="area2_list_4"><img src="../../images/t.gif" /></a></div>
<div class="txt" id="area2_txt_4">篮球</div>
</div>
<div class="item" style="left: 80px; top: 425px;">
<div class="link"><a href="#" id="area2_list_5"><img src="../../images/t.gif" /></a></div>
<div class="txt" id="area2_txt_5">活动</div>
</div>
</div>
<!-- E 热点 -->

<!-- S 我的空间 -->
<div class="btn-myspace"  style="top:15px;left:435px">
<a href="#" id="area3_0" ><img style="width:90px;height:35px"  /></a>
</div>
<!-- E 我的空间 -->

<!-- S 节目搜索 -->
<div class="btn-proSearch" style="top:15px;left:521px">
<a href="#" id="area4_0" style=""><img style="width:90px;height:35px" /></a>
</div>
<!-- E 节目搜索 -->

<!-- S 视频展示 -->
<div class="mod-indexShowMovie">
<div class="pic"><a href="#" id="area5_0"><img id="mid_play" src="#" style="height:234px; width:306px;"/></a></div>
</div>
<!--
<div class="mod-indexShowMovie">
<div class="pic">
<img id="area5_img_0" src="../images/jy.jpg"/>
</div>
</div>
<!-- E 视频展示 -->

<!-- S 专题 右侧2张图-->
<div class="mod-index-specTopic" >
<div class="item" style="top: 107px; left:468px;">
<div class="link"><a href="#" id="area6_list_0"><img src="../../images/t.gif" /></a></div>
<div class="icon" style="display:none;"><img src="../images/icon-zt.png" /></div>
<div class="pic"><img  id="area6_img_0" src="../images/index_test.png"/></div>
</div>
<div class="item" style="top: 230px; left:468px;" >
<div class="link"><a href="#" id="area6_list_1"><img src="../../images/t.gif" /></a></div>
<div class="icon" style="display:none;"><img src="../images/icon-zt.png" /></div>
<div class="pic"><img id="area6_img_1" src="../images/index_test.png" /></div>
</div>
</div>
<!-- E 专题 右侧2张图-->

<!-- S 电影 下侧3张图-->
<div class="mod-index-movie">
<div class="item" style="left: 150px;top:355px; z-index:11;">
<div class="link"><a href="#" id="area7_list_0"><img src="../../images/t.gif" /></a></div>
<!-- <div class="txtWrap">
<div class="txt" id="area7_txt_0"></div>
</div> -->
<div class="pic"><img id="area7_img_0" src="../images/index_test.png" /></div>
</div>
<div class="item" style="left: 309px; top:355px; z-index:11;">
<div class="link"><a href="#" id="area7_list_1"><img src="../../images/t.gif" /></a></div>
<!-- <div class="txtWrap">
<div class="txt" id="area7_txt_1"></div>
</div> -->
<div class="pic"><img id="area7_img_1" src="../images/index_test.png" /></div>
</div>
<!---右下角图片----> 
<div class="item" style="left: 468px; top:355px; z-index:11;">
<div class="link"><a href="#" id="area9_list_0"><img src="../../images/t.gif" /></a></div>
<div class="pic"><img id="area9_img_0" src="../images/index_test.png" /></div>
</div>
</div>
<!-- E 电影 下侧3张图-->

<!-- S 底部走马灯 -->
<div> 

<div id="mar" >
<%for(int i=0;i<rollsize;i++){
	%>
		<div id="demo<%=i%>"><%=rollText[i]%></div>
		<%
}
%>
</div>
<script>
var speed = 50;//滚动速度
var out = 5*1000//停留时间
var top = mar.scrollTop + 1;
var MyMar = 0;
var lh = 20;//滚动高度
var step = lh/2;

function Marquee(){
	if((demo<%=rollsize-1%>.offsetTop-mar.scrollTop)<=0){
		clearInterval(MyMar);
		setTimeout(startMar,out);
		resetMar();
	} else {
		if(0 == mar.scrollTop%lh){
			clearInterval(MyMar);
			setTimeout(startMar,out);
		}
		mar.scrollTop++;
	}
}

function startMar(){
	MyMar=setInterval(Marquee,speed);
}

function resetMar(){
	mar.scrollTop=top;
}

var Mar=startMar();
</script>



</div> 

<!-- E 底部走马灯 -->
<iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="1px" height="1px" ></iframe>
<iframe name="hidden_frame1" id="hidden_frame1" style=" display:none" width="1px" height="1px" ></iframe>
<!--用户行为数据统计-->
<iframe id="log_frame" name="log_frame" src="http://219.133.42.99:8080/EPG_Statistics/EPG_APP.jsp?userID=<%=userId%>&&EPG_TYPE=SD&EPG_CATA_NAME=APP_SD_INDEXPAGE"  frameborder="0" height="1px" width="1px" style=" display:none" ></iframe>
<!-- 视频窗口 -->
<iframe id="playPage" name="playPage" frameborder="0" height="1px" width="1px" style=" display:none" ></iframe>
</div>
</body>
</html>
