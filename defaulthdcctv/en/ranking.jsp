<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
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
<%@ include file="datajsp/util_AdText.jsp"%>
<%@ include file="util/util_getPosterPaths.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="save_focus.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<%
	int curindex=0;
	curindex=request.getParameter("curindex")!=null?Integer.parseInt(request.getParameter("curindex")):0;	
	MetaData metadata = new MetaData(request);
	ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
//	ArrayList rankResult = metadata.getVodListByTypeId("593",10,0);
        ArrayList rankResult = metadata.getVodListByTypeId("10000100000000090000000000031593",10,0);
	JSONArray jsonList = null;
	if(rankResult != null && rankResult.size() > 1 && ((ArrayList)rankResult.get(1)).size() > 1){
		ArrayList tempList = new ArrayList();
		ArrayList vodList = (ArrayList)rankResult.get(1);		
		for(int i=0;i<vodList.size();i++){
			HashMap mapx = (HashMap)vodList.get(i);
			HashMap tempMap = new HashMap();
			String tmpvodid = mapx.get("VODID").toString();
                        int pid = Integer.parseInt(tmpvodid);
			String tmpvodname = mapx.get("VODNAME").toString();
			tempMap.put("VODID",tmpvodid);	
			tempMap.put("VODNAME",tmpvodname);	
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
				String picUrl = getPosterPath(posterMap,"images/zwtp.jpg","5",request);
				tempMap.put("PICURL",picUrl);	
		        }
		     tempList.add(tempMap);
	       }		
		jsonList = JSONArray.fromObject(tempList);
		}
UserProfile userProfile = new UserProfile(request);
String userid = userProfile.getUserId();

%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>排行榜-点播-电影62_央视高清EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<style>
<%
//ZTE
//body{ background:url(images/mainbg_index.png) no-repeat}
 %>
<!--
body{ background1:url(images/mainbg_index.png) no-repeat}
.geton{z-index:3}
.getoff{z-index:1}
-->
</style>
<script type="text/javascript" src="js/gstatj.js"></script>
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript">
   //var numkey=true;var bluekey=true;var redkey=true;var greenkey=true;var yellowkey=true;
   var indexid = <%=curindex%>;
   var resultlist= <%=jsonList%>;
   var returnurl=escape(window.location.href);
   var area0
   var area1
   var progId="<%=CATEGORY_TRAILER_ID%>";
    window.onload=function()
   {
           gstaFun('<%=userid%>',644);
	   var backflag='<%=request.getParameter("back")%>';
	   area0=AreaCreator(10,1,new Array(-1,-1,-1,1),"area0_list_","className:menuli on","className:menuli");
	   area0.setstaystyle("className:menuli current",3);
	   area0.doms[0].mylink=indexhref[0];
	   area0.doms[1].mylink=indexhref[1];
	   area0.doms[2].mylink=indexhref[2];
	   area0.doms[3].mylink=indexhref[3];
	   area0.doms[4].mylink=indexhref[4];
	   area0.doms[5].mylink=indexhref[5];
	   area0.doms[6].mylink=indexhref[6];
	   area0.doms[7].mylink=indexhref[7];
	   area0.doms[8].mylink=indexhref[8];
	   area0.doms[9].mylink=indexhref[9];
	   area0.setfocuscircle(0);
	   area0.stablemoveindex = new Array(-1,-1,-1,-1);
	   area1=AreaCreator(10,1,new Array(-1,0,-1,-1),"area1_list_","className:item item_focus","className:item");
	   area1.stablemoveindex = new Array(-1,"0-6,1-6,2-6,3-6,4-6,5-6,7-6,8-6,9-6",-1,-1);
	   for(var j=0;j<area1.doms.length;j++){
			area1.doms[j].contentdom = $("area1_listName_"+j);
		}
	   area1.changefocusedEvent = function(){
		if(resultlist !=null && resultlist[area1.curindex] != null)
                {   
                   $("showPic").src = resultlist[area1.curindex].PICURL;
	        }
                else
                {
                   $("showPic").src = "images/zwtp.jpg";
                }
              }
	   area1.setfocuscircle(0);
	   pageobj=new PageObj(1,indexid!=null?parseInt(indexid):0,new Array(area0,area1),null);
	   pageobj.backurl = "index.jsp";
	   area0.setdarknessfocus(6);
	   gerdata(resultlist);
   }
    function gerdata(data){
		for(var i = 0;i < area1.doms.length; i++){
			if(data[i]!=null){
					   area1.doms[i].setcontent("",data[i].VODNAME,34);
					   area1.doms[i].youwannauseobj=data[i].VODID;
					   area1.doms[i].title = data[i].ISSITCOM;
					   area1.doms[i].domOkEvent=function()
					   {
						 var tempURL = null;
						 if(location.href.indexOf('?')==-1){
							tempURL = location.href + "?curindex=" + area1.curindex;
							}else{
								var tUrl = location.href.substring(0,location.href.indexOf('?'));
								tempURL = tUrl + "?curindex=" + area1.curindex;
							}
							
						   if(this.title == 0){
							   window.location.href = "program_film.jsp?vodid=" + this.youwannauseobj + "&returnurl="+escape(tempURL);
							   }else{
								   window.location.href = "program_tv_choose.jsp?vodid=" + this.youwannauseobj + "&returnurl="+escape(tempURL);
								   }						 
					   }
					 }else{
			   			area1.doms[i].updatecontent("暂无内容，请稍后再试");
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
<body style="background:url(images/mainbg.jpg); background-color:transparent;">
<div class="main">   
	<!--logo-->
	<div class="logo"><img src="images/logo.png" /></div>
	<div class="date" id="currDate"></div>
	<!--menu-->
	<div class="menu"> <!--焦点为 class="menuli on"  当前选中为 class="menuli current"-->
		<div><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_0" style="top:1px"><img src="images/icon_0.png" />首  页</div> <!--class="menuli on"-->
		<div style="top:55px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_1" style="top:56px"><img src="images/icon_1.png" />频  道</div>
		<div style="top:110px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_2" style="top:111px"><img src="images/icon_2.png" />点  播</div>
		<div style="top:165px"><img src="images/menu_line.png" /></div>
	    <div class="menuli" id="area0_list_3" style="top:166px"><img src="images/icon_3.png" />专  题</div>
		<div style="top:220px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_4" style="top:221px"><img src="images/icon_4.png" />回  放</div>
		<div style="top:275px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_5" style="top:276px"><img src="images/icon_5.png" />深  圳</div>
		<div style="top:330px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_6" style="top:331px"><img src="images/icon_11new.png" />排  行</div>
		<div style="top:385px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_7" style="top:386px"><img src="images/icon_7.png" />应  用</div>
		<div style="top:440px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_8" style="top:441px"><img src="images/icon_9.png" />空  间</div>
		<div style="top:499px"><img src="images/menu_line.png" /></div>
		<div class="menuli" id="area0_list_9" style="top:500px"><img src="images/icon_10.png" />搜  索</div>
		<div style="top:555px"><img src="images/menu_line.png" /></div>
	</div>	
	<!--mid-->
	<div class="ranking-list">
		<!--焦点 
				class="item item_focus"
			-->
		<div class="item" id="area1_list_0">
			<div class="icon"><img src="images/rank/num01.png" /></div>
			<div class="txt" id="area1_listName_0">暂无内容，请稍后再试</div>
		</div>
		<div class="item" style="top:53px;" id="area1_list_1">
			<div class="icon"><img src="images/rank/num02.png" /></div>
			<div class="txt" id="area1_listName_1">暂无内容，请稍后再试</div>
		</div>
		<div class="item" style="top:106px;" id="area1_list_2">
			<div class="icon"><img src="images/rank/num03.png" /></div>
			<div class="txt" id="area1_listName_2">暂无内容，请稍后再试</div>
		</div>
		<div class="item" style="top:159px;" id="area1_list_3">
			<div class="icon"><img src="images/rank/num04.png" /></div>
			<div class="txt" id="area1_listName_3">暂无内容，请稍后再试</div>
		</div>
		<div class="item" style="top:212px;" id="area1_list_4">
			<div class="icon"><img src="images/rank/num05.png" /></div>
			<div class="txt" id="area1_listName_4">暂无内容，请稍后再试</div>
		</div>
		<div class="item" style="top:265px;" id="area1_list_5">
			<div class="icon"><img src="images/rank/num06.png" /></div>
			<div class="txt" id="area1_listName_5">暂无内容，请稍后再试</div>
		</div>
		<div class="item" style="top:318px;" id="area1_list_6">
			<div class="icon"><img src="images/rank/num07.png" /></div>
			<div class="txt" id="area1_listName_6">暂无内容，请稍后再试</div>
		</div>
		<div class="item" style="top:371px;" id="area1_list_7">
			<div class="icon"><img src="images/rank/num08.png" /></div>
			<div class="txt" id="area1_listName_7">暂无内容，请稍后再试</div>
		</div>
		<div class="item" style="top:424px;" id="area1_list_8">
			<div class="icon"><img src="images/rank/num09.png" /></div>
			<div class="txt" id="area1_listName_8">暂无内容，请稍后再试</div>
		</div>
		<div class="item" style="top:477px;" id="area1_list_9">
			<div class="icon"><img src="images/rank/num10.png" /></div>
			<div class="txt" id="area1_listName_9">暂无内容，请稍后再试</div>
		</div>
	</div>	
	<!--r-->
	<div class="r-poster">
		<div class="item">
			<div class="pic"><img id="showPic" src="images/zwtp.jpg"  width="375" height="498"/></div>
		</div>
		<!--<div class="icon-hd"><img src="images/rank/hd.png" /></div>-->
	</div>	
	<!--bottom_notice-->
	<div class="notice"></div>    
</div>
<%@ include file="servertimehelp.jsp" %>
</body>
</html>

