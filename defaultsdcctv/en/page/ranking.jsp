<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile"%>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="util/save_focus.jsp"%>
<%
	MetaData metadata = new MetaData(request);
	ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
    //ArrayList rankResult = metadata.getVodListByTypeId(" ",8,0);	
    ArrayList rankResult = metadata.getVodListByTypeId("10000100000000090000000000032871",8,0); 
	JSONArray jsonList = null;
	if(rankResult != null && rankResult.size() > 1 && ((ArrayList)rankResult.get(1)).size() > 1){
		ArrayList tempList = new ArrayList();
		ArrayList vodList = (ArrayList)rankResult.get(1);		
		for(int i=0;i<vodList.size();i++){
			HashMap mapx = (HashMap)vodList.get(i);
			HashMap tempMap = new HashMap();
			String tmpvodid = mapx.get("VODID").toString();
                        int pid = Integer.parseInt(tmpvodid);
			if(mapx.get("VODNAME") != null){
				String tmpvodname = mapx.get("VODNAME").toString();
				tempMap.put("VODNAME",tmpvodname);	
				}else{
					tempMap.put("VODNAME","暂无信息");
					}			
			tempMap.put("VODID",tmpvodid);				
			HashMap detailMap = (HashMap)metadata.getVodDetailInfo(Integer.parseInt(tmpvodid));
			String isSitcom = detailMap.get("ISSITCOM").toString();
			tempMap.put("ISSITCOM",isSitcom);
			HashMap posterMap = (HashMap)(detailMap.get("POSTERPATHS"));
			String playurl = serviceHelpHWCTC.getTriggerPlayUrlHWCTC(1,pid ,pid,"0","0","0","0","0");
			int st=playurl.indexOf("rtsp");//此为单播，需找华为提供组播测试。
			if(-1 != st)
			{
			    playurl=playurl.substring(st,playurl.length());
			}
			tempMap.put("playurl",playurl);	
			if(posterMap!=null){
				//0.缩略图1.海报2.剧照3.图标4.标题图5.广告图6.草图7.背景9.频道图99.其他
				String picUrl = getPosterPath(posterMap,"../images/zwtp.jpg","5",request);
				tempMap.put("PICURL",picUrl);	
		        }
		     tempList.add(tempMap);
	       }
		
		jsonList = JSONArray.fromObject(tempList);
		}
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>排行榜-点播-电影62_央视高清EPG</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/rankstyle.css" />
<style>
<%
   String catename = "排行";
//ZTE
//body{ background:url(images/mainbg_index.png) no-repeat}
%>

<!--
body{ background1:url(images/mainbg_index.png) no-repeat}
.geton{z-index:3}
.getoff{z-index:1}
-->
</style>
<script type="text/javascript" src="../js/pagecontrol.js"></script>
<script type="text/javascript">
   var indexid = 0,areaid = 0;
   var resultlist= <%=jsonList%>;
   var returnurl=escape(window.location.href);
   var area0;
   window.onload=function()
   {
	   area0=AreaCreator(8,1,new Array(-1,-1,-1,-1),"area0_list_","className:item item_focus","className:item");
	   area0.stablemoveindex = new Array(-1,-1,-1,-1);
	   for(var j=0;j<area0.doms.length;j++){
			area0.doms[j].contentdom = $("area0_listName_"+j);
		}
	   area0.changefocusedEvent = function(){
		   if(resultlist !=null && resultlist[area0.curindex] != null){
			   $("showPic").src = "../"+resultlist[area0.curindex].PICURL;
			   }else{
				   $("showPic").src = "../images/zwtp.jpg";
				   }		  
		   }
	   area0.setfocuscircle(0);	   
	   if(focusObj!=undefined&&focusObj!=null){
			   areaid = parseInt(focusObj[0].areaid);
			   indexid = parseInt(focusObj[0].curindex);
		    }			
	   pageobj=new PageObj(areaid,indexid,new Array(area0),null);
	   pageobj.backurl = "index.jsp?back=1";
	   gerdata(resultlist);
   }
    function gerdata(data){
		if(data != null && data.length > 0){
			   area0.datanum = data.length;
			}else{
				area0.datanum = 1;
			}
		for(var i = 0;i < area0.doms.length; i++){
			if(data[i]!=null && data != null && data.length > 0){
					   area0.doms[i].setcontent("",data[i].VODNAME,20);
					   area0.doms[i].youwannauseobj=data[i].VODID;
					   area0.doms[i].title = data[i].ISSITCOM;
					   area0.doms[i].domOkEvent=function()
					   {
						 saveFocstr(pageobj);
						  var tempURL = null;
						  if(location.href.indexOf('?')==-1){
							tempURL = location.href+"?a=1";
							}else{
								var tUrl = location.href.substring(0,location.href.indexOf('?'));
								tempURL = tUrl+"?a=1";
							}							
						   if(this.title == 0){
							   window.location.href = "vod-tv-detail.jsp?catename=<%=catename %>&vodid=" + this.youwannauseobj + "&returnurl="+escape(tempURL);
							   }else{
								   window.location.href = "vod-zt-detail.jsp?catename=<%=catename %>&vodid=" + this.youwannauseobj + "&returnurl="+escape(tempURL);
								   }						 
					   }
					 }else{
			   			area0.doms[i].updatecontent("暂无内容，请稍后再试");
			   		}
			}
		}
	function goURL(url)
	{
	   document.location.href='../'+url;	
	}
	
	function goURL1(vasurl)
	{
	   document.location.href=vasurl;	
	}
</script>
</head>
<body bgcolor="transparent">
<!--pagebg-->
<div class="pagebg">
	<div class="pic"><img src="../images/bg-rank.jpg" width="640" height="530" /></div>
</div>
<!--pagebg the end-->
<div class="wrapper">
	<!--head-->
	<div class="date" id="currDate"></div>
	<!--head the end-->	
	<!--list-->
		<div class="list-rank">
			<!--焦点 
				class="item item_focus"
			-->
			<div id="area0_list_0" class="item">
				<div class="txt txt01">1</div>
				<div id="area0_listName_0" class="txt txt02">暂无内容，请稍后再试</div>
			</div>    
			<div id="area0_list_1" class="item" style="top:47px;">
				<div class="txt txt01">2</div>
				<div id="area0_listName_1" class="txt txt02">暂无内容，请稍后再试</div>
			</div>
			<div id="area0_list_2" class="item" style="top:94px;">
				<div class="txt txt01">3</div>
				<div id="area0_listName_2" class="txt txt02">暂无内容，请稍后再试</div>
			</div>
			<div id="area0_list_3" class="item" style="top:141px;">
				<div class="txt txt01">4</div>
				<div id="area0_listName_3" class="txt txt02">暂无内容，请稍后再试</div>
			</div>
			<div id="area0_list_4" class="item" style="top:188px;">
				<div class="txt txt01">5</div>
				<div id="area0_listName_4" class="txt txt02">暂无内容，请稍后再试</div>
			</div>
			<div id="area0_list_5" class="item" style="top:235px;">
				<div class="txt txt01">6</div>
				<div id="area0_listName_5" class="txt txt02">暂无内容，请稍后再试</div>
			</div>
			<div id="area0_list_6" class="item" style="top:282px;">
				<div class="txt txt01">7</div>
				<div id="area0_listName_6" class="txt txt02">暂无内容，请稍后再试</div>
			</div>
			<div id="area0_list_7" class="item" style="top:329px;">
				<div class="txt txt01">8</div>
				<div id="area0_listName_7" class="txt txt02">暂无内容，请稍后再试</div>
			</div>
		</div>
	<!--list the end-->	
	<!--poster-->
	<div class="poster-rank">
		<div class="pic"><img id="showPic" src="#" /></div>
	</div>
	<!--poster the end-->
</div>	
<%@ include file="servertimehelp.jsp" %>
</body>
</html>

