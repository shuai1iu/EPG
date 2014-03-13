<!-- 描  述：应用页面控制层 -->
<!-- 修改人：wangss -->
<!-- 修改时间：2010-8-9-->
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ include file="datajsp/application_Data.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript">
    var scrollText = "套餐";
    var pagecount=<%=pagecount%>;
    function loadChannel() {
        area0=AreaCreator(11,1,new Array(-1,-1,-1,-1),"area0_list_","className:menuli on","className:menuli");
	    area0.setstaystyle("className:menuli current", 3);
	    //area0.setdarknessfocus(7);
	   
	    area0.doms[0].mylink=indexhref[0];
	    area0.doms[1].mylink=indexhref[1];
	    area0.doms[2].mylink=indexhref[2];
	    //area0.doms[3].mylink="application.jsp?indexid=3";
	    area0.doms[3].mylink=indexhref[3];
	    area0.doms[4].mylink=indexhref[4];
	    area0.doms[5].mylink=indexhref[5];
	   // area0.doms[6].mylink=indexhref[6];
	    area0.doms[7].mylink=indexhref[7];
	    area0.doms[8].mylink=indexhref[8];
	    area0.doms[9].mylink=indexhref[9];
		area0.setfocuscircle(0);
	    //定义应用区域
	    area1=AreaCreator(2,3,new Array(-1,0,-1,-1),"app","className:bgon","className:bg");
	    area1.setcrossturnpage();
	    area1.curpage=jsCurrPage;
	    area1.asyngetdata=function()
	    {     
	         area1.lockin=true;
			 $('hidden_frame').src="datajsp/application_Dataiframe.jsp?curpage="+area1.curpage;
	    }
	    area1.datanum = appList.length;
	    pageobj = new PageObj(areaid, indexid, new Array(area0, area1),null);
	    pageobj.goBackEvent=function()
	    {
		    location.href="index.jsp";
		   //this.changefocus(0,indexid);
	    }
    }
    function loadData()
	{
	   loadChannel();
	   getdata(appList,pagecount);
       document.getElementById("scrollText").innerHTML = "<marquee scrollamount='4'>"+scrollText + "</marquee>";
    }
    
    //点击跳转到其他的应用
    function OkFun()
	{   
	   if(appList[pageobj.getfocusindex()].appURL=="#")
	   {  
	      return;
	   }
	   else
	   {
	      var tmpStr = new String();			
	      tmpStr = 1+","+pageobj.getfocusindex()+","+area1.curpage;
	      var url= "au_PlayFilm.jsp?PROGID=" +appList[pageobj.getfocusindex()].vasId+"&PLAYTYPE=" + <%=EPGConstants.PLAYTYPE_VAS%>
				+ "&CONTENTTYPE="+ <%=EPGConstants.CONTENTTYPE_VAS%>+"&BUSINESSTYPE=" + <%=EPGConstants.BUSINESSTYPE_VAS%>;
		  window.location.href = "SaveCurrFocus.jsp?currFoucs=" + tmpStr + "&url=" + url;
	   }
   } 
    
   //数据绑定 为图片和文字绑定内容 
   function getdata(data,count)
   {		
        area1.setpageturndata(data.length,parseInt(count));
        for(var i=0;i<area1.doms.length;i++)
		 {
			 if(i<data.length)
			 { 
			     area1.doms[i].contentdom=$("name"+i);
				 area1.doms[i].imgdom=$("pic"+i);
	  			 area1.doms[i].setcontent("·",data[i].appName,12);
				 area1.doms[i].mylink="";
				 area1.doms[i].updateimg(data[i].appImage);
				 document.getElementById('app'+i).style.visible = "visible";
				 area1.doms[i].domOkEvent=function()
				 {
				   OkFun();
				 }
			 }
			 else
			 { 
			     area1.doms[i].contentdom=$("name"+i);
				 area1.doms[i].imgdom=$("pic"+i);  
			     area1.doms[i].updatecontent("");
				 area1.doms[i].updateimg("images/temp/dot.gif");
				 area1.doms[i].mylink="";
				 document.getElementById('app'+i).style.visibility = "hidden";
			 }
		 }
		 // $('pageNum').innerHTML=area1.curpage+"/"+count;
		 area1.lockin=false;
		 if(area1.curpage==1) {$("pageup").src="images/up_gray.png";} else {$("pageup").src="images/up.png";}
		 if(area1.curpage==count) {$("pagedown").src="images/down_gray.png";} else {$("pagedown").src="images/down.png";}
  }
 </script>