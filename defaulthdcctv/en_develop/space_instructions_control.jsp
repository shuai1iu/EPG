<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="datajsp/space_instructions_data.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<html>
<head>
<script language="javascript" type="text/javascript" src="js/pagecontrol.js"></script>
<script language="javascript" type="text/javascript">
var scrollText = "操作介绍";    
    function loadData()
	{
	   loadChannel();
	   getdata(strinstruText,1);
       document.getElementById("scrollText").innerHTML = "<marquee scrollamount='4'>"+scrollText + "</marquee>";
    }
   
	function getdata(data,count)
	{		 
	     area2.setpageturndata(1,parseInt(count));
		 $("area2_list_0").innerHTML=data;
		 area2.lockin=false;
     }

    function loadChannel() {
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
		
	    area1 = AreaCreator(6,1, new Array(-1,0, -1, 3), "area1_list_", "className:d_li on", "className:d_li");	
		area1.setstaystyle("className:d_li current", 3);
		
		area1.doms[0].mylink="space_collect.jsp?areaid=1&indexid=0";
		area1.doms[1].mylink="space_bookmarks.jsp?areaid=1&indexid=1";
	    area1.doms[2].mylink="space_consumer_records.jsp?areaid=1&indexid=2";
	    area1.doms[3].mylink="space_cancel.jsp?areaid=1&indexid=3";
	    //area1.doms[4].mylink="space_instructions.jsp?areaid=1&indexid=4";
		area1.doms[5].mylink="space_installed.jsp?areaid=1&indexid=5";
		 if(areaid==2){
	      area1.setdarknessfocus(3);
		  $('area1_list_3').className="d_li current";
		}
	    area2 = AreaCreator(1, 1, new Array(-1,-1, -1, -1), "area2_list_", "className:channel_list wid5 pb1 ch1", "className:channel_list wid5 pb1 ch1");
	    area2.asyngetdata=function()
		{
			 area2.lockin=true;
			 $('hidden_frame').src="datajsp/space_instructions_iframedata.jsp?curpage="+area2.curpage;
		}
		area2.datanum = 1;
		
		var doms3=new Array(2);
		doms3[0]=new  DomData("area3_list_0","className:btn_up btn_bgon","className:btn_up");
		doms3[0].domOkEvent =function()
		{
			area2.pageturn(-1);
		}
		doms3[1]=new  DomData("area3_list_1","className:btn_down btn_bgon","className:btn_down");
		doms3[1].domOkEvent =function()
		{
			area2.pageturn(1);
		}
	    area3=new Area(2,1,doms3,new Array(-1,1,-1,-1));
		
		area3.areaPageTurnEvent=function(pageAreanum)
		{
		  area2.pageturn(pageAreanum);
			
		}
		pageobj = new PageObj(areaid, indexid, new Array(area0, area1,area2,area3),null);
	   pageobj.goBackEvent=function()
	   {
		   location.href="index.jsp";
		   //this.changefocus(0,8);
	   }
	}
</script>
</head>
</html>
