<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="datajsp/special_topicdata.jsp" %>
<%@ include file="datajsp/codepage.jsp"%>
<%@ include file="../datajsp/util_AdText.jsp"%>
<%@ include file="../util/save_focus.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>专题_测试</title>
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<style>
<!--
	body { background:url(images/mainbg.jpg) no-repeat;}
	.lines {
		left:40px;
		position:absolute; 
		top:89px;
	}
	.topicList {
		left:70px;
		position:absolute; 
		top:120px;
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
		left:512px;
		position:absolute; 
		top:628px;
		text-align:center;
		width:430px;
	}	
-->
</style>
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript">
   var returnurl=escape(window.location.href);
   var area0;
   var area1;
   var area2; 
   var list=new Array();
    window.onload=function()
   {
	   var areaid= <%=request.getParameter("areaid")%>;
	   var indexid=<%=request.getParameter("indexid")%>;
	   area0 = AreaCreator(1,5,new Array(-1, -1, 1, -1),"area0_title_","className:simtitle on","className:simtitle");
	   area0.stablemoveindex = new Array(-1,-1,1,-1);
	   area0.doms[0].mylink = "../sim_index.jsp";
	   area0.doms[1].mylink = "test_topic.jsp";
	   area0.doms[2].mylink = "../sim_playback.jsp";
	   area0.doms[3].mylink = "test_index.jsp";
	   area0.doms[4].mylink = "../../../defaultsdcctv/en/page/sim_index.jsp";	   

	   area1=AreaCreator(3,5,new Array(0,-1,2,-1),"area1_list_","className:item item_focus","className:item");
	   area1.stablemoveindex = new Array("0-0>1,1-0>1,2-0>1,3-0>1,4-0>1",-1,"2-2>1,3-2>1,4-2>1",-1);
	   area1.areaOkEvent = function(){
		   saveFocstr(pageobj);
	   };
	  
	    area2 = AreaCreator(1,2,new Array(1,-1,-1,-1),"turnpage_","className:testturnpage on","className:testturnpage");
	   // area2.stablemoveindex = nw Array("0-1>1,1-1>3",-1,-1,-1);
	   if(focusObj!=undefined&&focusObj!="null"){
			   areaid = parseInt(focusObj[0].areaid);
			   indexid = parseInt(focusObj[0].curindex);
			   area1.curpage = parseInt(focusObj[0].curpage);		   
	   }

area2.doms[0].domOkEvent=function(){
       	if((parseInt(area1.curpage)-1)<=0) 
		return;
	area1.pageturn(-1);	
	list=getItmsByPage(totallist,area1.curpage,pagesize);
       getdata(list,Math.ceil(totallist.length/pagesize));
};
		  
area2.doms[1].domOkEvent=function(){
       	if((parseInt(area1.curpage)+1)>area1.pagecount) return;
		area1.pageturn(1);
	list=getItmsByPage(totallist,area1.curpage,pagesize);
	getdata(list,Math.ceil(totallist.length/pagesize));
};
	   
		   
	pageobj=new PageObj(areaid!=null?parseInt(areaid):1,indexid!=null?parseInt(indexid):0,new Array(area0,area1,area2));

	for(i=0;i<area1.doms.length;i++)
	       area1.doms[i].imgdom=$('area1_img_'+i);
       	  if(areaid!=null&&areaid!=0)
		 area0.setdarknessfocus(2);
	   pageobj.goBackEvent=function()
	   {
		   location.href="../sim_index.jsp?back=1&indexid=1";
	   }
	   area1.asyngetdata=function()
	   {
             getdata(list,Math.ceil(totallist.length/pagesize));
		}
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
				   area1.doms[i].updateimg(data[i].TopicPic);
				  StrType = data[i].TopicType;
				  if(StrType.indexOf("te")>=0)
					area1.doms[i].mylink = "../ori-dibbling-group-two-te.jsp?catacode="+data[i].TopicCode+"&returnurl="+escape(location.href)+"&typenum=4";
				  else
				  	area1.doms[i].mylink = "../ori-dibbling-group-two.jsp?catacode="+data[i].TopicCode+"&returnurl="+escape(location.href)+"&typenum=4";
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

<div class="simtitle"> <!--焦点为 class="menuli on"  当前选中为 class="menuli current"-->
	<div class="simtitle" id="area0_title_0" style="left:-120px;"><img src="images/simtitle_1.png" /></div>
        <div class="simtitle" id="area0_title_1" style="left:70px;"><img src="images/simtitle_2.png" /></div>
        <div class="simtitle" id="area0_title_2" style="left:260px;"><img src="images/simtitle_3.png" /></div>
        <div class="simtitle" id="area0_title_3" style="left:450px;"><img src="images/simtitle_4.png" /></div>
        <div class="simtitle" id="area0_title_4" style="left:650px;"><img src="../images/simtitle_5.png" /></div>
</div>
		     	
<div class="main">
						      
	
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
		<div class="item" id="area1_list_4" style="left:928px;">
		        <div class="pic"><img id="area1_img_4" width="197" height="145" /></div>
		</div>



		
		<div class="item" id="area1_list_5" style="top:180px;">
			<div class="pic"><img id="area1_img_5" width="197" height="145" /></div>
		</div>
		<div class="item" id="area1_list_6" style="left:232px;top:180px;">
			<div class="pic"><img id="area1_img_6" width="197" height="145" /></div>
		</div>
		<div class="item" id="area1_list_7" style="left:464px;top:180px;">
			<div class="pic"><img id="area1_img_7" width="197" height="145" /></div>
		</div>
		<div class="item" id="area1_list_8" style="left:696px;top:180px;">
			<div class="pic"><img id="area1_img_8" width="197" height="145" /></div>
		</div>
		<div class="item" id="area1_list_9" style="left:928px;top:180px;">
		        <div class="pic"><img id="area1_img_9" width="197" height="145" /></div>
		</div>


		
		<div class="item" id="area1_list_10" style="top:360px;">
			<div class="pic"><img id="area1_img_10" width="197" height="145"/></div>
		</div>
		<div class="item" id="area1_list_11" style="left:232px;top:360px;">
			<div class="pic"><img id="area1_img_11" width="197" height="145"/></div>
		</div>
		<div class="item" id="area1_list_12" style="left:464px;top:360px;">
			<div class="pic"><img id="area1_img_12" width="197" height="145" /></div>
		</div>
		<div class="item" id="area1_list_13" style="left:696px;top:360px;">
			<div class="pic"><img id="area1_img_13" width="197" height="145" /></div>
		</div>
		<div class="item" id="area1_list_14" style="left:928px;top:360px;">
		        <div class="pic"><img id="area1_img_14" width="197" height="145" /></div>
		</div>


		
	</div>

	
        <div class="topicPage" style="left:427px;top:670px" id="page"></div>
	
</div>
        <div class="testturnpage">
	     <div class="testturnpage" id = "turnpage_0" style = "left:477px;top:665px"><img src = images/test_last_page.png></div>
	     <div class="testturnpage" id = "turnpage_1" style = "left:692px;top:665px"><img src = images/test_next_page.png></div>
	</div>
				    


<iframe name="hidden_frame" id="hidden_frame" style=" display:none" width="0" height="0" ></iframe>
<%@ include file="../servertimehelp.jsp" %>
</body>
</html>
