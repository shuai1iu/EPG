<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
 <%@ page import="java.text.*"%> 
<%@ include file="datajsp/codepage.jsp"%>
<%@ include file="datajsp/playbackdata.jsp"%>
<script language="javascript" type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript" src="js/gstatj.js"></script>
<!--<script language="javascript" type="text/javascript" src="js/pagecontrol.js"></script>-->
<script language="javascript" type="text/javascript">
	var scrollText = "欢迎中央电视台领导视察指导工作";
    //var pageobj;
	var area0;
	var area1;
	var timeIndex = 0;
	var areaid;
	var indexid;
var userid = Authentication.CTCGetConfig("UserID");	
	function getdata(data,pageCount)
	 {	
		 area1.setpageturndata(data.length,parseInt(pageCount));
		 
		 for(var i=0;i<area1.doms.length;i++)
		 {
			 if(i<data.length)
			 {
				  var tmpNumber = parseInt(data[i].channelNumber) - 1000;
				  var tmpSeq = "" + tmpNumber;
            	  var tmpStr = "";
           		  if (tmpSeq.length == 1)
                		tmpStr = "00";
            	  if (tmpSeq.length == 2)
                		tmpStr = "0";
           		  var text = tmpStr + tmpSeq + " &nbsp;" + data[i].channelName;
				  
				  area1.doms[i].updatecontent(text);
				  area1.doms[i].mylink="playbacklist.jsp?channelId="+data[i].channelId +"&returnurl="+escape(location.href);
				 
			 }
			 else
			     area1.doms[i].updatecontent("");
		 }
		 document.getElementById('page').innerHTML = area1.curpage+"/"+pageCount;
		 area1.lockin=false;
	 }


    function initPage()
	{
		
		gstaFun(userid,643);
		area0=AreaCreator(10,1,new Array(-1,-1,-1,1),"area0_list_","className:menuli on","className:menuli");
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
	   
        area1 = AreaCreator(11, 2, new Array(-1,0, -1, -1), "channel", "className:sub on", "className:sub");
		area1.setpageturnattention("pageup","images/up.png","images/up_gray.png","pagedown","images/down.png","images/down_gray.png");

		//areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):1
        //pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):4, new Array(area0, area1));
		
		
		if(focusObj!=undefined&&focusObj!="null")
		{
				areaid = parseInt(focusObj[0].areaid);
				indexid = parseInt(focusObj[0].curindex);
				area1.curpage = parseInt(focusObj[0].curpage);
		}
		
		pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):4, new Array(area0, area1));
		setDarkFocus();
		pageobj.goBackEvent = function()
		{
			location.href="index.jsp";
			//this.changefocus(0,4);
		}
		area1.setcrossturnpage();
		area1.setfocuscircle(0);
		
		area1.asyngetdata=function()
		{
			 area1.lockin=true;
			 //getAJAXData("playbackpagingdata.jsp?pageIndex="+area1.curpage,getdata)
			 var list=new Array();
			 var start = (this.curpage-1)*22;
			 var size = (totalRecord-start)>=22?22:(totalRecord-start);
			 for(i=0;i<size;i++)
	         {
	            list[i]=jsChannelList[start+i];
	         }
			 getdata(list,pageCount);
			 //$('hidden_frame').src="playbackpagingdata.jsp?pageIndex="+area1.curpage;
		}
		area1.areaOkEvent = function()
		{
			saveFocstr(pageobj);
			//alert(document.cookie);
		}
		area1.asyngetdata();
        
		document.getElementById("scrollText").innerHTML = "<marquee scrollamount='4'>"+scrollText + "</marquee>";
		//refreshServerTime();
		//setInterval("refreshServerTime()",60000);
		

    }
	


   
</script>
