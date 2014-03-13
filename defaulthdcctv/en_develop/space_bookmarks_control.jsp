<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="datajsp/space_bookmarks_data.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<html>
<head>
<script language="javascript" type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript" src="js/EPGConstants.js"></script>
<script language="javascript" type="text/javascript">
var scrollText = "书签";
var isDel=false;///是否弹出删除对话框
var succ=0;///是否删除成功
var pagedel;
var pagecount=<%=pagecount%>;alert(pagecount);//总的页数alert(pagecount);
var delBookMarkObj=null;//当删除时 保存删除的书签对象
var DelSuPop;
var DelFailPop;
var pagesize=22;
var bookmarkList;  
var pos=0; 

    //初始化书签数组
	function initBookArray()
	{  
	    pos=area2.curpage * pagesize - pagesize;
		bookmarkList=new Array();  alert("totalBookmarkList.length"+totalBookmarkList.length);
		for(var i=pos;i<(pos+pagesize)&& i<totalBookmarkList.length;i++)
		{
			bookmarkList.push(totalBookmarkList[i]);
	    }
		
	}
	
    function loadData()
	{
	  
	   loadChannel();
	   area2.curpage=jscurpage;alert("cur"+jscurpage);
	   initBookArray();
	   getdata(bookmarkList,pagecount);
       document.getElementById("scrollText").innerHTML = "<marquee scrollamount='4'>"+scrollText + "</marquee>";
       
    }
     
    //弹出删除对话框
    function OkFun()
	{   
	   
	   //editing by ty 2011年9月4日 19:08:45
	   if(parseInt(bookmarkList[pageobj.getfocusindex()].bookmarkObjType)==2)
	   {  
	     
	      pageobj.popups[0].showme();
	      isDel=true;
		  //delBookMarkObj=bookmarkList[pageobj.getfocusindex()];	
		  //window.alert(delBookMarkObj.progId);	  
	   }
	   else if(parseInt(bookmarkList[pageobj.getfocusindex()].bookmarkObjType)==1)
	   {
		   //editing by ty 2011年12月29日 18:48:50
	      var urlstr = "au_PlayFilm.jsp?PROGID="+bookmarkList[pageobj.getfocusindex()].progId
				urlstr += "&PLAYTYPE="+EPGConstants.PLAY_TYPE_BOOKMARK;
				if(bookmarkList[pageobj.getfocusindex()].superVodId!=undefined){
					urlstr+="&FATHERSERIESID="+bookmarkList[pageobj.getfocusindex()].superVodId;
				}
				urlstr += "&BEGINTIME="+bookmarkList[pageobj.getfocusindex()].beginTime;
				urlstr += "&ENDTIME="+bookmarkList[pageobj.getfocusindex()].endTime;
				urlstr += "&CONTENTTYPE="+EPGConstants.CONTENT_TYPE_VOD_VIDEO;
				urlstr += "&BUSINESSTYPE="+EPGConstants.BUSINESS_TYPE_VOD;
				urlstr += "&returnurl="+escape("space_bookmarks.jsp?curpage="+area2.curpage+"&areaid=2&indexid="+pageobj.getfocusindex());
				location.href = urlstr;
	   }
    }
   
	function getdata(data,count)
	{	
	     area2.setpageturndata(data.length,parseInt(count));alert(data.length);
		 for(var i=0;i<area2.doms.length;i++)
		 {
			 if(i<data.length)
			 {
				 area2.doms[i].setcontent("",data[i].progName,30);
                               //ZTE
				// area2.doms[i].mylink="";
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
		window.location.href="space_bookmarks.jsp?curpage="+area2.curpage+"&indexid="+pageobj.getfocusindex()+"&areaid=2";
	 }
	 function  DelFailFun(){
	 
	    DelFailPop.closeme();
		setDelDefault();
		window.location.href="space_bookmarks.jsp?curpage="+area2.curpage+"&indexid="+pageobj.getfocusindex()+"&areaid=2";
     }
	
     function loadChannel() {
	    area0 = AreaCreator(10, 1, new Array(-1, -1, -1, 1), "area0_list_", "className:menuli on", "className:menuli");
        area0.setstaystyle("className:menuli current", 3);
		
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
		if(areaid!=null&&areaid!=0){
           area0.setdarknessfocus(8);
		   $('area0_list_8').className="menuli current";
		}
		
	    area1 = AreaCreator(6,1, new Array(-1,0, -1, 2), "area1_list_", "className:d_li on", "className:d_li");	
	    area1.setstaystyle("className:d_li current", 3);
	   
	    area1.doms[0].mylink="space_collect.jsp?areaid=1&indexid=0";
		//area1.doms[1].mylink="space_bookmarks.jsp?areaid=1&indexid=1";
	    area1.doms[2].mylink="space_consumer_records.jsp?areaid=1&indexid=2";
	    area1.doms[3].mylink="space_cancel.jsp?areaid=1&indexid=3";
	    area1.doms[4].mylink="space_instructions.jsp?areaid=1&indexid=4";
		area1.doms[5].mylink="space_installed.jsp?areaid=1&indexid=5";
	    if(areaid==2){
	      area1.setdarknessfocus(1);
		  $('area1_list_1').className="d_li current";
		}
		area2 = AreaCreator(11, 2, new Array(-1,1, -1, -1), "area2_list_", "className:p_li on2", "className:p_li");
	    area2.setcrossturnpage();
	    area2.asyngetdata=function()
		{
	       area2.lockin=true;
		   initBookArray();
	       getdata(bookmarkList,pagecount);
		   area2.lockin=false;
		}
		if(bookmarkList != undefined)
		   area2.datanum = bookmarkList.length;
	    var pops=new Array();
	   
		var area3=AreaCreator(1,2,new Array(-1,-1,-1,-1),"area7_list","className:on","className:");
	   
        var DelPop=new Popup('area7_list',new Array(area3));
         pops[0]=DelPop;
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
   		var area4=AreaCreator(1,1,new Array(-1,-1,-1,-1),"area4_list_","className:on","className:");
	    DelSuPop=new Popup('area4_list',new Array(area4),0,0);
	    area4.doms[0].domOkEvent=DelSuFun;
	    pops[1]=DelSuPop;
	    
		var area5=AreaCreator(1,1,new Array(-1,-1,-1,-1),"area5_list","className:on","className:");
		DelFailPop=new Popup("area5_list",new Array(area5),0,0);
    	area5.doms[0].domOkEvent=DelFailFun;
    	pops[2]=DelFailPop;
	
		pops[1].closemedEvent = function(){
			setDelDefault();
			window.location.href="space_bookmarks.jsp?curpage="+area2.curpage+"&indexid="+pageobj.getfocusindex()+"&areaid=2";
		};
		pops[2].closemedEvent = function(){
			setDelDefault();
			window.location.href="space_bookmarks.jsp?curpage="+area2.curpage+"&indexid="+pageobj.getfocusindex()+"&areaid=2";

		};
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
	  delBookMarkObj=bookmarkList[area2.curindex];	
      var delUrl = "datajsp/space_bookMarkDel_iframedata.jsp?PROGID="+delBookMarkObj.progId+"&PROGTYPE="+delBookMarkObj.progType;
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
	  delBookMarkObj=null;
	  area2.lockin=false; 
	  pageobj=pagedel;
	}
</script>
</head>
</html>
