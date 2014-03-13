<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="datajsp/space_collect_data.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<html>
<head>
<script type="text/javascript" src="js/gstatj.js"></script>
<script language="javascript" type="text/javascript" src="js/pagecontrol.js"></script>
<script language="javascript" type="text/javascript">
var scrollText = "收藏";
var isDel=false;///是否弹出删除对话框
var succ=0;///是否删除成功
var pagedel;
var DelContentObject=null;//当点击删除时保存要删除的对象
var pagecount=<%=pagecount%>;
var DelSuPop;
var userid = Authentication.CTCGetConfig("UserID");
var DelFailPop;
   function loadData()
	{
	   loadChannel();
         
	   getdata(collentList,pagecount);
       document.getElementById("scrollText").innerHTML = "<marquee scrollamount='4'>"+scrollText + "</marquee>";
    }
     
    //弹出删除对话框
    function OkFun()
	{   
	   
	   if(parseInt(collentList[pageobj.getfocusindex()].collentObjType)==2)
	   {  
	      DelContentObject=collentList[pageobj.getfocusindex()];
	      pageobj.popups[0].showme();
	      isDel=true;
	   }
	  else if(parseInt(collentList[pageobj.getfocusindex()].collentObjType)==1)
	   {
	     window.location.href="vod_turnpager.jsp?vodid="+collentList[pageobj.getfocusindex()].progId +"&returnurl="+escape("space_collect.jsp?curpage="+area2.curpage+"&areaid=2&indexid="+pageobj.getfocusindex());
	   }
    }
   
	function getdata(data,count)
	{		 
	     area2.setpageturndata(data.length,parseInt(count));
		 for(var i=0;i<area2.doms.length;i++)
		 {
			 if(i<data.length)
			 {
				 area2.doms[i].setcontent("",data[i].progName,30);
				 area2.doms[i].mylink="";
				 area2.doms[i].domOkEvent=function()
				 {  
				     OkFun();
				 }
			 }
			 else
			     area2.doms[i].updatecontent("");
		 }
		 
		 area2.lockin=false;
		 if(area2.curpage==1) {$("pageup").src="images/up_gray.png";} else {$("pageup").src="images/up.png";}
		 if(area2.curpage==count) {$("pagedown").src="images/down_gray.png";} else {$("pagedown").src="images/down.png";}
     }
	 
	function  DelSuFun(){
	   
	    DelSuPop.closeme();
		setDelDefault();
		window.location.href="space_collect.jsp?curpage="+area2.curpage+"&indexid="+pageobj.getfocusindex()+"&areaid=2";
    }
	 function  DelFailFun(){
	 
	    DelFailPop.closeme();
		setDelDefault();
		window.location.href="space_collect.jsp?curpage="+area2.curpage+"&indexid="+pageobj.getfocusindex()+"&areaid=2";
     }
	 function showdata(data){
		  collentList=new Array();
		  collentList=eval('('+data+')');
		  getdata(collentList,pagecount);
	 }
     function loadChannel() {i
       gstaFun(userid,653);
       area0 = AreaCreator(10, 1, new Array(-1, -1, -1, 1), "area0_list_", "className:menuli on", "className:menuli");
       area0.setstaystyle("className:menuli current", 3);
	   if(areaid!=null&&areaid!=0){
           area0.setdarknessfocus(8);
		   $('area0_list_8').className="menuli current";
	   }
	   area0.doms[0].mylink=indexhref[0];
	   area0.doms[1].mylink=indexhref[1];
	   area0.doms[2].mylink=indexhref[2];
	   //area0.doms[3].mylink="application.jsp?indexid=3";
	   area0.doms[3].mylink=indexhref[3];
	   area0.doms[4].mylink=indexhref[4];
	   area0.doms[5].mylink=indexhref[5];
	   area0.doms[6].mylink=indexhref[6];
	   area0.doms[7].mylink=indexhref[7];
	   // area0.doms[8].mylink=indexhref[8];
	   area0.doms[9].mylink=indexhref[9];
       area0.setfocuscircle(0);
	   area1 = AreaCreator(6,1, new Array(-1,0, -1, 2), "area1_list_", "className:d_li on", "className:d_li");	
	   area1.setstaystyle("className:d_li current", 3);
		
	 //area1.doms[0].mylink="space_collect.jsp?areaid=1&indexid=0";
		area1.doms[1].mylink="space_bookmarks.jsp?areaid=1&indexid=1";
	    area1.doms[2].mylink="space_consumer_records.jsp?areaid=1&indexid=2";
	    area1.doms[3].mylink="space_cancel.jsp?areaid=1&indexid=3";
	    area1.doms[4].mylink="space_instructions.jsp?areaid=1&indexid=4";
		area1.doms[5].mylink="space_installed.jsp?areaid=1&indexid=5";
	   if(areaid==2){
	      area1.setdarknessfocus(0);
		  $('area1_list_0').className="d_li current";
		}
		
		area2 = AreaCreator(11, 2, new Array(-1,1, -1, -1), "area2_list_", "className:p_li on2", "className:p_li");
	    area2.setcrossturnpage();
	    area2.asyngetdata=function()
		{ 
		   area2.lockin=true;
		   var myajaxUrl="datajsp/space_collect_iframedata.jsp?curpage="+area2.curpage;
		   getAJAXData(myajaxUrl,showdata);
		}
		area2.datanum = collentList.length;
		if(area2 != undefined)
		 area2.curpage = parseInt(jscurpage);
		//window.alert(area2.curpage);
		var pops=new Array();
		var area3=AreaCreator(1,2,new Array(-1,-1,-1,-1),"area7_list","className:on","className:");
	  
	    var DelPop=new Popup("area7_list",new Array(area3));
	    ///开始执行删除操作
	    area3.doms[0].domOkEvent=function()
		{   
		   isDel=true;
		   area2.lockin=true; //加锁防止焦点的移
		   pagedel.popups[0].closeme();
		   pageobj=null;
		   delFavFun();
	    }
	    area3.doms[1].domOkEvent=function()
	    {
	       pagedel.popups[0].closeme();
	    };
	    pops[0]=DelPop;
	    var area4=AreaCreator(1,1,new Array(-1,-1,-1,-1),"area4_list","className:on","className:");
	    DelSuPop=new Popup("area4_list",new Array(area4),0,0);
	    area4.doms[0].domOkEvent=DelSuFun;
	    pops[1]=DelSuPop;
	    
        var area5=AreaCreator(1,1,new Array(-1,-1,-1,-1),"area5_list","className:on","className:");
	    DelFailPop=new Popup("area5_list",new Array(area5),0,0);
    	area5.doms[0].domOkEvent=DelFailFun;
    	pops[2]=DelFailPop;
	
	    pageobj = new PageObj(areaid, indexid, new Array(area0, area1,area2),pops);
	    pageobj.goBackEvent=function()
	    {
			location.href="index.jsp";
		   //this.changefocus(0,8);
	    }
		pagedel=pageobj;
	}
	
    function delFavFun()
    {
      var delUrl = "datajsp/space_collectDel_iframedata.jsp?PROGID="+DelContentObject.progId+"&PROGTYPE="+DelContentObject.progType;
	  getAJAXData(delUrl,delFav);
      isSuccess=false;
      function delFav(succ){
	     if(parseInt(succ) == 1)
		 { 
		   pagedel.popups[1].closetime=5;
		   pagedel.popups[1].showme();
		 }
		 else
		 { 
		    pagedel.popups[2].closetime=5;
		    pagedel.popups[2].showme();
		 }
	  }
    }
    
    function setDelDefault()
	{
	  isDelNum=3;
	  succ=0;
	  isDel=false;
	  DelContentObject=null;
	  area2.lockin=false; 
	  pageobj=pagedel;
	}
</script>
</head>
</html>
