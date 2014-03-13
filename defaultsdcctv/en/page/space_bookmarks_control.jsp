<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="datajsp/space_bookmarks_data.jsp"%>

<html>
<head>
<script language="javascript" type="text/javascript" src="../js/pagecontrol.js"></script>
<script language="javascript" type="text/javascript" src="../js/EPGConstants.js"></script>

<script language="javascript" type="text/javascript">

var pagesize=7;
var pos=0; 
var backurl="<%=request.getParameter("returnurl")==null?"index.jsp?back=1":request.getParameter("returnurl") %>";

var popList;//层对象集合
var delPop;//删除操作层
var delFailPop;//删除失败层
var delSuPop;//删除成功层
var area0;
var area1;
var area2;
var area3;
var area4;
var area5;
var area6;

var delContentObject;//删除对象
var pagedel;

var isDel=false;///是否弹出删除对话框
var delSuccFlag=0;///是否删除成功

var pagecount=<%=pagecount%>;
var pagesize=7;
var pos=0; 


//初始化收藏数组
function initBookMarkList(){  
    
    pos=jscurpage * pagesize - pagesize;
	bookmarkList=new Array(); 
	
	for(var i=pos;i<(pos+pagesize)&& i<totalBookmarkList.length;i++)
	{
		bookmarkList.push(totalBookmarkList[i]);
	}
}

//加载主数据
function loadBody() {
	if(parseInt(jscurpage)==0)
	{  
		pagecount=1;
		jscurpage=1;
		
	}
	refreshServerTime();
    initBookMarkList();
	//构建菜单区域
     if(collentNum==0)
     {
        area0 = AreaCreator(6, 1, new Array(-1, -1, -1, 3), "area0_list_", "className:item onboder", "className:item offboder");
	 }
	 else
	 {
        area0 = AreaCreator(6, 1, new Array(-1, -1, -1, 1), "area0_list_", "className:item onboder", "className:item offboder");
	}
    
    
    area0.doms[0].mylink="space_collect.jsp?areaid=0&indexid=0";
    //area0.doms[1].mylink="space_bookmarks.jsp?areaid=0&indexid=1";
    area0.doms[2].mylink="space_consumer_records.jsp?areaid=0&indexid=2";
	area0.doms[3].mylink="space_cancel.jsp?areaid=0&indexid=3";
	area0.doms[4].mylink="space_instructions.jsp?areaid=0&indexid=4";
	area0.doms[5].mylink="space_installed.jsp?areaid=0&indexid=5";
    area0.setfocuscircle(0);
    //end
    area0.doms[1].focusstyle=new Array("className:item item_select onboder");
	area0.doms[1].unfocusstyle=new Array("className:item item_select offboder");
   
   //构建收藏列表区域
   area1 = AreaCreator(7, 1, new Array(-1,0, -1, 2), "area1_list_", "className:txt onboder", "className:txt offboder");
   area1.setcrossturnpage();
   area1.stablemoveindex=new Array(-1,-1,-1,"0-0,1-1,2-2,3-3,4-4,5-5,6-6");
   area1.setfocuscircle(0);
   area1.asyngetdata=function()
   {  
      area2.curpage=area1.curpage;
	  jscurpage=area2.curpage;
	  area1.lockin=true;
	  area2.lockin=true;
	  initBookMarkList();
	  showCollectDel(bookmarkList,pagecount);
	  area1.lockin=false;
	  area2.lockin=false;
   }
   area1.datanum = bookmarkList.length;
   //end
   
   //构建删除列表区域
   area2 = AreaCreator(7, 1, new Array(-1,1, -1, 3), "area2_list_", "className:icon onboder", "className:icon offboder");
   area2.setcrossturnpage();
   area2.stablemoveindex=new Array(-1,"0-0,1-1,2-2,3-3,4-4,5-5,6-6",-1,-1);
   area2.setfocuscircle(0);
   area2.asyngetdata=function()
   {  
     
      area1.curpage=area2.curpage;
	  area2.lockin=true;
	  jscurpage=area2.curpage;
	  initBookMarkList();
	  showCollectDel(bookmarkList,pagecount);
	  area2.lockin=false;
	  area1.lockin=false;
   }
    area2.datanum = bookmarkList.length;
    //end
    if(collentNum==0)
    {
       area3 = AreaCreator(3, 1, new Array(-1,0, -1, -1), "area3_list_", "className:item onboder", "className:item offboder");
	}
	else
	{
	   area3 = AreaCreator(3, 1, new Array(-1,2, -1, -1), "area3_list_", "className:item onboder", "className:item offboder");
	}
    popList=new Array();
	
	//构建删除操作层
     area4=AreaCreator(1,2,new Array(-1,-1,-1,-1),"area4_list_","className:btn btn-w-91x42-1 onboder","className:btn btn-w-91x42-1 offboder");
     delPop=new Popup("area4_list",new Array(area4),0,1);
	///开始执行删除操作
	area4.doms[0].domOkEvent=function()
	{   
	   area1.lockin=true; //加锁防止焦点的移
	   area2.lockin=true;
	   pagedel.popups[0].closeme();
	   pageobj=null;
	   delFavFun();
	}
	area4.doms[1].domOkEvent=function()
	{
	   pagedel.popups[0].closeme();
	};
	//end
	
	//构建删除成功层
	area5=AreaCreator(1,1,new Array(-1,-1,-1,-1),"area5_list_","className:btn btn-ori-131x42-1","className:btn btn-ori-131x42-1");
	delSuPop=new Popup("area5_list",new Array(area5),0,0);
	area5.doms[0].domOkEvent=delSuFun;
        delSuPop.closemedEvent=function(){
            setDelDefault();
	    window.location.href="space_bookmarks.jsp?curpage="+area2.curpage+"&indexid="+pageobj.getfocusindex()+"&areaid=2";

        }
	//end
	
	//构建删除失败层
        area6=AreaCreator(1,1,new Array(-1,-1,-1,-1),"area6_list_","className:btn btn-ori-131x42-1","className:btn btn-ori-131x42-1");
	delFailPop=new Popup("area6_list",new Array(area6),0,0);
	area6.doms[0].domOkEvent=delFailFun;
	delFailPop.closemedEvent=function(){
            setDelDefault();
	    window.location.href="space_bookmarks.jsp?curpage="+area2.curpage+"&indexid="+pageobj.getfocusindex()+"&areaid=2";

        }
	
	popList[0]=delPop;
	popList[1]=delSuPop;
	popList[2]=delFailPop;
	
	
	if(collentNum==0){
         pageobj = new PageObj(0, 1, new Array(area0, area1,area2,area3),popList);
	}
	else
	{    
	    
	   pageobj = new PageObj(areaid, indexid, new Array(area0, area1,area2,area3),popList);
	}
	pageobj.goBackEvent=function()
	{
	   window.location.href=backurl;
	}
	
	area1.curpage=jscurpage;
	area2.curpage=jscurpage;
	showTj(tjList);
        showCollectDel(bookmarkList,pagecount);
	pagedel=pageobj;
	
	
}
//显示推荐影片
function showTj(data){

	area3.setpageturndata(data.length,1);

	for(var i=0;i<area3.doms.length;i++)
	{    
	    area3.doms[i].contentdom=$("area3_txt_"+i);
		area3.doms[i].imgdom=$("area3_img_"+i);
		if(i<data.length) 
	    {
		   $('area3_list_'+i).style.display = "block";	  
		  
		   area3.doms[i].updateimg("../"+data[i].POSTERPATHS.type0[0]!=undefined?"../"+data[i].POSTERPATHS.type0[0]:'images/no_picture_259x165.jpg');
		   //0:视频VOD、1:视频频道、2:音频频道、3:频道、4:音频AOD、10:VOD、100:增值业务、300:节目、9999:混合栏目
		   area3.doms[i].setcontent("",data[i].VODNAME,12);

		   area3.doms[i].mylink="vod-tv-detail.jsp?vodid="+data[i].VODID+"&typeid=<%=shuqiancode%>"+"&returnurl="+escape("space_bookmarks.jsp?curpage="+area2.curpage+"&indexid="+i+"&areaid=3");
		
	     }
	     else{
			  $('area3_list_'+i).style.display = "none";	
			  area3.doms[i].updateimg("#");
		 }
		
	}
}


//显示收藏列表
function showCollectDel(data,count){		 
	 area1.setpageturndata(data.length,parseInt(count));
	 if(collentNum!=0)
	 {
	   area2.setpageturndata(data.length,parseInt(count));
	 }
	 
	 for(var i=0;i<area1.doms.length;i++)
	 {       
  
		 if(i<data.length)
		 {
			 area1.doms[i].setcontent("",data[i].progName,21);
			 area1.doms[i].mylink="";
			 area1.doms[i].domOkEvent=function()
			 {  
				 OkFun();
			 }
			 if(collentNum!=0){
				
				 $('area2_list_'+i).style.display = "block";
				 area2.doms[i].mylink="";
				 area2.doms[i].domOkEvent=function()
				 {  
					 delFun();
				 }
			 }
			 else
			 {
			    $('area2_list_'+i).style.display = "none";
			 }
		 }
		 else{
			
		    area1.doms[i].updatecontent("");
			$('area2_list_'+i).style.display = "none";
		 }
	 }
	 
	 area1.lockin=false;
	 area2.lockin=false;
	 $("pageArea").innerHTML="<span class=\"current\">"+area1.curpage+"</span>/"+pagecount;
}
 
	 
//弹出删除对话框
function OkFun()
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

//弹出删除对话框
function delFun(){
	delContentObject=bookmarkList[pageobj.getfocusindex()];
	pageobj.popups[0].showme();
	isDel=true;
}

	 
function  delSuFun(){
        delSuPop.closeme();
	setDelDefault();
	window.location.href="space_bookmarks.jsp?curpage="+area2.curpage+"&indexid="+pageobj.getfocusindex()+"&areaid=2";
}

function  delFailFun(){
    delFailPop.closeme();
	setDelDefault();
	window.location.href="space_bookmarks.jsp?curpage="+area2.curpage+"&indexid="+pageobj.getfocusindex()+"&areaid=2";
}

//删除操作函数
function delFavFun()
{
   var delUrl = "datajsp/space_bookMarkDel_iframedata.jsp?PROGID="+delContentObject.progId+"&PROGTYPE="+delContentObject.progType;
 
   getAJAXData(delUrl,delFav);
   delSuccFlag=false;
   function delFav(succ){

	 if(parseInt(succ) == 1)
	 { 
	   pagedel.popups[1].closetime=5;
	   pagedel.popups[1].showme();
	   delSuccFlag=true;
	 }
	 else
	 { 
		pagedel.popups[2].closetime=5;
		pagedel.popups[2].showme();
		delSuccFlag=false;
	 }
  }
}

//恢复默认值 
function setDelDefault()
{
   delSuccFlag=false;
   delContentObject=null;
   area2.lockin=false; 
   area1.lockin=false; 
   isDel=false;
   pageobj=pagedel;
}
</script>
</head>
</html>
