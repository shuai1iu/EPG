<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page language="java" import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.math.*" %>

<%@ include file="datajsp/test_indexdata.jsp"%>
<%
// 靠标记获取光标记忆
String areaFlag_1 = request.getParameter("areaFlag_1");
String areaFlag_2 = request.getParameter("areaFlag_2");
int num			=	0;
int areaID		=	0;
int indexID		=	0;
int pageID		=	0;
if(null != areaFlag_1){
	num = Integer.parseInt(areaFlag_1);
	if(19 < num){
		pageID = (int)Math.ceil(num/18);
		num = num%18;
	}
	if(num > 8 && num < 19){
		areaID = 2 ;
		indexID = (num-9);
	}else if(num < 9){
		areaID = 0 ;
		indexID = num;
	}
}

if(null != areaFlag_2){
	num = Integer.parseInt(areaFlag_2);
	if(19 < num){
		pageID = (int)Math.ceil(num/18);
		num = num%18;
	}
	if(num > 8 && num < 19){
		areaID = 3 ;
		indexID = (num-9);
	}else if(num < 9){
		areaID = 1 ;
		indexID = num;
	}
}
%>

<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript">
	
	var areaid = 0;
	var indexid = 0;
	var page = 0;
	var curpage = 0;
	var area0;
	var area1;
	var area2;
	var area3;
	var area4;
	var area5;

	var pagecount = parseInt((list1.length-1)/pagesize)+1;
	//var returnurl = escape(window.location.href);
	var returnurl_1 = "test/test_index.jsp";
	var returnurl_2 = "test_index.jsp";
	areaid = <%=areaID%>;
	indexid = <%=indexID%>;
	page = <%=pageID%>;
	window.onload = function(){
		area0 = AreaCreator(9,1,new Array(4, -1, 2, 1),"cate_","className:menulitest on","className:menulitest");
		area0.stablemoveindex = new Array(-1,-1,"8-5>0","0-1>0,1-1>1,2-1>2,3-1>3,4-1>4,5-1>5,6-1>6,7-1>7,8-1>8");
		area1 = AreaCreator(9,1,new Array(4, 0, 3, 2 ),"image_","className:menutest on","className:menutest");
		area1.stablemoveindex = new Array("0-4>2","0-0>1,1-0>1,2-0>2,3-0>3,4-0>4,5-0>5,6-0>6,7-0>7,8-0>8","8-5>0","1-2>1,2-2>2,3-2>3,4-2>4,5-2>5,6-2>6,7-2>7,8-2>8");
		area2 = AreaCreator(9,1,new Array(4, 1, 0, 3),"cate1_","className:menulitest on","className:menulitest");
		area2.stablemoveindex = new Array("0-4>3","0-1>0,1-1>1,2-1>2,3-1>3,4-1>4,5-1>5,6-1>6,7-1>7,8-1>8","8-5>1","0-3>0,1-3>1,2-3>2,3-3>3,4-3>4,5-3>5,6-3>6,7-3>7,8-3>8");
		area3 = AreaCreator(9,1,new Array(4, 2, 1, -1),"image1_","className:menutest on","className:menutest");
		area3.stablemoveindex = new Array("0-4>4","0-2>0,1-2>1,2-2>2,3-2>3,4-2>4,5-2>5,6-2>6,7-2>7,8-2>8","8-5>1",-1);
		area4 = AreaCreator(1,5,new Array(-1, -1, 2, -1),"area4_title_","className:simtitle on","className:simtitle");
		area4.stablemoveindex = new Array(-1,-1,"0-0>0,1-1>0,2-2>0,3-3>0",-1);
		area4.doms[0].mylink = "../sim_index.jsp";
		area4.doms[1].mylink = "test_topic.jsp";
		area4.doms[2].mylink = "../sim_playback.jsp";
		area4.doms[3].mylink = "test_index.jsp";
		area4.doms[4].mylink = "../../../defaultsdcctv/en/page/sim_index.jsp";	
		area0.setpageturnattention("turnpage_0","images/up.png","images/up_gray.png","turnpage_1","images/down.png","images/down_gray.png");
		//S--翻页
		area5 = AreaCreator(1,2,new Array(1,-1,-1,-1),"turnpage_","className:testturnpage on","className:testturnpage");
		area5.stablemoveindex = new Array("0-0>8,1-2>8",1,"0-0>0,1-1>0,2-2>0,3-3>0",-1);
	   // area5.stablemoveindex = nw Array("0-1>1,1-1>3",-1,-1,-1);
		area5.doms[0].domOkEvent=function(){
			pageUp();
		}
		function pageUp() {
			if (page>0){
				page--;
				getdata1(list1,page);
			}
		}
				  
		area5.doms[1].domOkEvent=function(){
			pageDown();
		}
		function pageDown() {
				if((page+1)<pagecount){
					page++;
					getdata1(list1,page);
				}
		};
		//E--翻页

	 pageobj = new PageObj(areaid,indexid, new Array(area0, area1, area2, area3, area4, area5));


	 pageobj.goBackEvent=function()
	 {
	       location.href="../sim_index.jsp?back=1&indexid=3";
	 }
		getdata1(list1,page);
	}

   function getdata1(data,page)
   {
   	   area0.datanum=data.length;
		for(i=0;i<area0.doms.length;i++)
		{
			if(i<data.length && data[i+page*pagesize].VODNAME!=undefined)
			   
		{
				   area0.doms[i].setcontent("",data[i+page*pagesize].VODNAME,8,false,true);
			           area0.doms[i].mylink="../vod_turnpager.jsp?vodid="+data[i+page*pagesize].VODID+"&typeid=<%=shouyetuijian2code%>"+"&returnurl="+returnurl_1 + "?areaFlag_1="+ data[i+page*pagesize].POSTERPATHS;
			   	   area1.doms[i].mylink="test_index_pic.jsp?pic="+data[i+page*pagesize].POSTERPATHS + "&returnurl="+returnurl_2 + "?areaFlag_2="+ data[i+page*pagesize].POSTERPATHS;
			   }else
				   area0.doms[i].updatecontent("");
		}
	 area2.datanum=data.length;
	        for(i=0;i<area2.doms.length;i++)
	        {
				if(i<data.length-9 && data[i+9+page*pagesize].VODNAME!=undefined){
					area2.doms[i].setcontent("",data[i+9+page*pagesize].VODNAME,8,false,true);
					area2.doms[i].mylink="../vod_turnpager.jsp?vodid="+data[i+9+page*pagesize].VODID+"&typeid=<%=shouyetuijian2code%>"+"&returnurl="+returnurl_1 + "?areaFlag_1="+ data[i+9+page*pagesize].POSTERPATHS;
					area3.doms[i].mylink="test_index_pic.jsp?pic="+data[i+9+page*pagesize].POSTERPATHS + "&returnurl="+returnurl_2 + "?areaFlag_2="+ data[i+9+page*pagesize].POSTERPATHS;
				   
			  }else
					area2.doms[i].updatecontent("");
	        }
			var curpage = page + 1;
			document.getElementById('page').innerHTML = curpage+"/"+pagecount;
  }




</script>
