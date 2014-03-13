<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="datajsp/special_topicdata.jsp" %>
<%@ include file="datajsp/codepage.jsp"%>
<%@ include file="datajsp/util_AdText.jsp"%>
<%@ include file="util/save_focus.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>专题_央视高清EPG</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<style>
<!--
	body { background:url(images/bg.jpg) no-repeat;}
	.lines {
		left:40px;
		position:absolute; 
		top:89px;
	}
	.topicList {
		left:302px;
		position:absolute; 
		top:100px;
	}
	.topicList .item {
		height:175px;
		left:0;
		position:absolute; 
		top:0;
		width:230px;
	}
	.topicList .item .icon {
		left:156px;
		position:absolute; 
		top:14px;
		z-index:5;
	}
	.topicList .item .pic {
		left:17px;
		position:absolute; 
		top:14px;
		z-index:4;
	}
	.topicList .item .pic,
	.topicList .item .pic img {
		height:145px;
		width:197px;
	}
	.topicList .item_focus {
		background:url(images/topic-bg-focus.png) no-repeat;
	}
	.topicPage {
		font-size:28px;
		left:551px;
		position:absolute; 
		top:628px;
		text-align:center;
		width:430px;
	}	
-->
</style>
<script type="text/javascript" src="js/gstatj.js"></script>
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript">
   var returnurl=escape(window.location.href);
   var area1;
   var list=new Array();
var userid = Authentication.CTCGetConfig("UserID");
    window.onload=function()
   {
           gstaFun(userid,642);
	   var areaid=<%=request.getParameter("areaid")%>;
	   var indexid=<%=request.getParameter("indexid")%>;
	   var area0=AreaCreator(10,1,new Array(-1,-1,-1,1),"area0_list_","className:menuli on","className:menuli");
	   area0.setstaystyle("className:menuli current",3);
	   area0.doms[0].mylink=indexhref[0];
	   area0.doms[1].mylink=indexhref[1];
	   area0.doms[2].mylink=indexhref[2];
	   //area0.doms[3].mylink="application.jsp?indexid=3";
	   area0.doms[3].mylink=indexhref[3];
	   area0.doms[4].mylink=indexhref[4];
	   area0.doms[5].mylink=indexhref[5];
	   area0.doms[6].mylink=indexhref[6];
	   area0.doms[7].mylink=indexhref[7];
	   area0.doms[8].mylink=indexhref[8];
	   area0.doms[9].mylink=indexhref[9];
	   area0.setfocuscircle(0);
       area1=AreaCreator(3,4,new Array(-1,0,-1,-1),"area1_list_","className:item item_focus","className:item");
	   area1.areaOkEvent = function(){
		   saveFocstr(pageobj);
	   };
	   
	   //popup.closetime=3;
	   if(focusObj!=undefined&&focusObj!="null"){
			   areaid = parseInt(focusObj[0].areaid);
			   indexid = parseInt(focusObj[0].curindex);
			   area1.curpage = parseInt(focusObj[0].curpage);		   
	   }
	   pageobj=new PageObj(areaid!=null?parseInt(areaid):1,indexid!=null?parseInt(indexid):0,new Array(area0,area1));
	   //area1.setpageturnattention("pageup","images/up.png","images/up_gray.png","pagedown","images/down.png","images/down_gray.png");
	   for(i=0;i<area1.doms.length;i++)
	       area1.doms[i].imgdom=$('area1_img_'+i);
	   if(areaid!=null&&areaid!=0)
	   area0.setdarknessfocus(3);
	   pageobj.goBackEvent=function()
	   {
		   location.href="index.jsp";
		   //this.changefocus(0,3);
	   }
	   //getdata(list);
	   area1.setcrossturnpage();
	   area1.asyngetdata=function()
	   {
			 //this.lockin=true;
	        //$('hidden_frame').src="datajsp/special_topicasyndata.jsp?curpage="+this.curpage;
			list=getItmsByPage(totallist,area1.curpage,pagesize);
			 //var start = (this.curpage-1)*<%=pageSize%>;
			 //var size = (totallist.length-start)>=<%=pageSize%>?<%=pageSize%>:(totallist.length-start);
			 
			 //for(i=0;i<size;i++)
	        // {
	           // list[i]=totallist[start+i];
	         //}
             getdata(list,Math.ceil(totallist.length/pagesize));
		}
		//for(var i=(area1.curpage-1)*<%=pageSize%>;i<(totallist.length>=<%=pageSize%>?<%=pageSize%>:totallist.length);i++)
	  // {
		   //alert(i%<%=pageSize%>);
	     // list[i%<%=pageSize%>]=totallist[i];
	   //}
	   list=getItmsByPage(totallist,area1.curpage,pagesize);
       getdata(list,Math.ceil(totallist.length/pagesize));
   }

   function getdata(data,count)
   {
	   area1.setpageturndata(data.length,parseInt(count));
	   var StrType = "NULL";
		for(i=0;i<area1.doms.length;i++)
			{
				if(i<data.length)
			   {
				   area1.doms[i].dom[0].style.visibility="visible";
				   area1.doms[i].updateimg(data[i].TopicPic);//  area1.doms[i].updateimg("images/temp/"+data[i].TopicPic);
				  //area1.doms[i].mylink = "dibbling_recreation.jsp?typeid=" + data[i].TopicCode+"&returnurl="+escape(location.href);
				  //area1.doms[i].mylink="program_tvpart_choose.jsp?type=cate&typeid="+data[i].TopicCode +"&returnurl="+escape(location.href);
				 // area1.doms[i].mylink="program_tvpart_choose_zt.jsp?ptypeid="+ "<%=zhuanti%>"+"&type=zt&typeid=" + data[i].TopicCode+"&returnurl="+escape(location.href);
				  StrType = data[i].TopicType;
				  if(StrType.indexOf("te")>=0)
					area1.doms[i].mylink = "ori-dibbling-group-two-te.jsp?catacode="+data[i].TopicCode+"&returnurl="+escape(location.href)+"&typenum=4";	//for 18da
				  else
				  	area1.doms[i].mylink = "ori-dibbling-group-two.jsp?catacode="+data[i].TopicCode+"&returnurl="+escape(location.href)+"&typenum=4";
				  //area1.doms[i].mylink = "activity/page/activityindex.jsp";
			   }
			   else
				area1.doms[i].dom[0].style.visibility="hidden";
				$("page").innerHTML=area1.curpage+"/"+count;
			}
		area1.lockin=false;
   }
   
function getItmsByPage(cptitms,icurpage,ipagesize){
	var reclist=new Array();
	var start = (icurpage-1)*ipagesize;
	for(var i=0;i<ipagesize&&(i+(icurpage-1)*ipagesize)<cptitms.length;i++){
	     reclist[i]=cptitms[start+i];
	}
	return reclist;
}
</script>
</head>

<body>
<div class="main">
	<!--初始化加载图片-->
    <div style="visibility:hidden; z-index:-1">
    <!--首页左边导航暗焦点--> 
    <img src="images/menu_bgfocuson.png"/>
    <img src="images/menu_bgon.png"/>
    <img src="images/pic_bg15on.png"/>
    </div>
	<!--logo-->
	<div class="logo"><img src="images/logo.png" /></div>
	<div class="date" id="currDate"></div>
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

	<div class="lines"><img src="images/lines.png" /></div>
	<div class="topicList"> <!--焦点为 class="item item_focus" -->
		<div class="item" id="area1_list_0">
			<div class="pic"><img id="area1_img_0" width="197" height="145" /></div>
		</div>
		<div class="item" id="area1_list_1" style="left:232px;">
			<div class="pic"><img id="area1_img_1" width="197" height="145" /></div>
		</div>
		<div class="item" id="area1_list_2" style="left:464px;">
			<div class="pic"><img id="area1_img_2" width="197" height="145" /></div>
		</div>
		<div class="item" id="area1_list_3" style="left:696px;">
			<div class="pic"><img id="area1_img_3" width="197" height="145" /></div>
		</div>
		
		<div class="item" id="area1_list_4" style="top:180px;">
			<div class="pic"><img id="area1_img_4" width="197" height="145" /></div>
		</div>
		<div class="item" id="area1_list_5" style="left:232px;top:180px;">
			<div class="pic"><img id="area1_img_5" width="197" height="145" /></div>
		</div>
		<div class="item" id="area1_list_6" style="left:464px;top:180px;">
			<div class="pic"><img id="area1_img_6" width="197" height="145" /></div>
		</div>
		<div class="item" id="area1_list_7" style="left:696px;top:180px;">
			<div class="pic"><img id="area1_img_7" width="197" height="145" /></div>
		</div>
		
		<div class="item" id="area1_list_8" style="top:360px;">
			<div class="pic"><img id="area1_img_8" width="197" height="145"/></div>
		</div>
		<div class="item" id="area1_list_9" style="left:232px;top:360px;">
			<div class="pic"><img id="area1_img_9" width="197" height="145"/></div>
		</div>
		<div class="item" id="area1_list_10" style="left:464px;top:360px;">
			<div class="pic"><img id="area1_img_10" width="197" height="145" /></div>
		</div>
		<div class="item" id="area1_list_11" style="left:696px;top:360px;">
			<div class="pic"><img id="area1_img_11" width="197" height="145" /></div>
		</div>
	</div>
	
	<div class="topicPage" id="page"></div>
	
</div>
<iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="0" height="0" ></iframe>
<%@ include file="servertimehelp.jsp" %>
</body>
</html>
