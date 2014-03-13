<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<html >
<head>
<script type="text/javascript" src="js/gstatj.js"></script>
<script language="javascript" type="text/javascript" src="js/pagecontrol.js"></script>
<script language="javascript" type="text/javascript">
	var channelId = '<%=request.getParameter("channelId")%>';
	var currFocusChannelIndex ;
	var scrollText = "回放列表测试";
	var area0;
	var area1;
	var area2;
	var timeIndex = 0;
	var lastDateTimeIndex = 0;
	var lastChannelId = channelId;
	var isFirstLoad = true;
	var curPageIndex=1;
var userid = Authentication.CTCGetConfig("UserID");
	var areaid= <%=request.getParameter("areaid")==null?0:Integer.parseInt(request.getParameter("areaid"))%>;
	var indexid= <%=request.getParameter("cruntFocus")==null?0:Integer.parseInt(request.getParameter("cruntFocus"))%>;
	var cruntFocus = <%=request.getParameter("cruntFocus")==null?0:Integer.parseInt(request.getParameter("cruntFocus"))%>
	var firstChannelId = 0;
	var AjaxReturn = -1;
	var isComFromHD = <%=request.getParameter("isComFromHD")==null?0:Integer.parseInt(request.getParameter("isComFromHD"))%>;
	var tempchannelNumber;
function getChannelData(data,count)
{
	 area0.setpageturndata(data.length,parseInt(count));
	 for (var i = 0; i < area0.doms.length; i++) 
	 {
		  if (i >=data.length) 
		  {
			  area0.doms[i].updatecontent("");
          }
		  else
		  {
			  tempchannelNumber = parseInt(data[cruntFocus].channelNumber) - 1000;
 
		 	 var tmpSeq = "" + (data[i].channelNumber-1000);
		 	 var tmpStr = "";
         	 if (tmpSeq.length == 1)
               tmpStr = "00";
          	if (tmpSeq.length == 2)
               tmpStr = "0";
        	  var text = tmpStr + (data[i].channelNumber-1000) + " &nbsp;" + data[i].channelName;
         	 area0.doms[i].setcontent("",text,22,true);
		 area0.doms[i].dataurlorparam=data[i].channelId;			 
		 area0.doms[i].channelnum=data[i].channelNumber-1000;
		  }
       }
	   if(focusObj!=undefined&&focusObj!="null")
	   {
		  
		   //lastChannelId = area0.doms[focusObj[1].curindex].dataurlorparam;
		   var url = "datajsp/playbacklistdata.jsp?channelId="+area0.doms[focusObj[1].curindex].dataurlorparam + "&currarea=0";
		   //clearProgramList();
		   getAJAXData(url,getDateData);
		   //area1.asyngetdata(lastChannelId);

	   }
	   
}

function rerverseDate(data)
{
	var dateList = new Array();
	
	for(var i = data.length - 1; i >= 0; i --)
	{
		dateList.push(data[i]);
	}
	return dateList;
}

function getDateData(data)
{
	data=eval('('+data+')');
	
	data = rerverseDate(data);
	
	area1.datanum = data.length;

	for (var j = 0; j < area1.doms.length; j++)
	{
		
   		if (j >= data.length) 
		{
			area1.doms[j].updatecontent("");
    	}
		else
		{
			area1.doms[j].updatecontent(data[j].dateChinese.substring(5,data[j].dateChinese.length));
			area1.doms[j].dataurlorparam=data[j].date24;
			
		}
    }
	
    if(isFirstLoad &&data.length != 0 )
    {
		var tmpDate = data[0].date24;
		if(focusObj!=undefined&&focusObj!="null" &&focusObj.length >2)
		{
			tmpDate = area1.doms[focusObj[2].curindex].dataurlorparam;
			area2.curpage = focusObj[0].curpage;
				
		}
		AjaxReturn = 0;
		var url = "datajsp/playbacklistdata.jsp?channelId="+area0.doms[area0.curindex].dataurlorparam + "&currarea=1&pageIndex="+area2.curpage+"&currdate="+tmpDate;
		getAJAXData(url,getProgramData);
		//alert("load1 AjaxReturn="+AjaxReturn);
		if (AjaxReturn == 0) //AjaxReturn ==0)
		{
		    	clearProgramList();
			var textr = "暂无内容";
			area2.doms[0].setcontent("", textr, 30);
		}
		AjaxReturn = -1;
    	isFirstLoad = false;
    }

}

function getProgramData(result)
{
	AjaxReturn = 1;	
	var re;
	if(result.substring(0,1)!='{')
	   return;
	re=eval('('+result+')');
    var data=re.data;
    var pageCount=re.count;
	data.length;
	area2.setpageturndata(data.length,pageCount);
	   for (var k = 0; k < area2.doms.length; k++) 
	   {
			
            if (k < data.length) 
			{
				 
				 var hour = data[k].STARTTIME.substring(8,10);
				var minitue = data[k].STARTTIME.substring(10,12);
				var text = hour+":"+minitue + " " + data[k].PROGNAME;//获取回放节目列表
				area2.doms[k].setcontent("",text,33);
				var	url = "au_PlayFilm.jsp?PROGID=" + data[k].PROGRAMID+ "&PLAYTYPE=4&CONTENTTYPE=300&&BUSINESSTYPE=5&PROGSTARTTIME=" + data[k].STARTTIME + "&PROGENDTIME=" + data[k].ENDTIME+"&ISSUB=1&PREVIEWFLAG=1&TVOD=1&CHANNELID="+area0.doms[area0.curindex].dataurlorparam+"&LOGICCHANNELID="+area0.doms[area0.curindex].channelnum;

				area2.doms[k].tempurl = url;  
            }
            else
			{
				area2.doms[k].updatecontent("");
			}
			
			
       }
       //alert("pageCount:"+pageCount + "datalen:"+data.length);
}

function clearProgramList()
{
	  for (var k = 0; k < area2.doms.length; k++) 
	 {
	 	area2.doms[k].updatecontent("");
	 }
}

			
    function initPage()
	 {
        gstaFun(userid,652);
        area0 = AreaCreator(9, 1, new Array(-1, -1, -1, 1), "channel", "className:menuli on", "className:menuli");
        area0.setstaystyle("className:menuli current", 3);
		area0.setfocuscircle(0);
       	area1 = AreaCreator(7, 1, new Array(-1, 0, -1, 2), "date", "className:d_li on", "className:d_li");
	    area1.setstaystyle("className:d_li current", 3);
	    area1.asyngetdata = function(id)
	    {
	    	lastChannelId = channelId;
		getAJAXData("datajsp/playbacklistdata.jsp?channelId="+id + "&currarea=0",getDateData);	   
		//document.getElementById("hidden_frame_channel").src = "playbacklistpaging.jsp?channelId="+id + "&currarea=0" ;
	    }
		area0.asyngetdata=function()
		 {
		         area0.changefocusingEvent();  //zte
                         var list=new Array();
			 var start = (this.curpage-1)*9;
			 var size = (totalChannelList.length-start)>=9?9:(totalChannelList.length-start);
			 for(i=0;i<size;i++)
	         {
	            list[i]=totalChannelList[start+i];
	         }
             getChannelData(list,pagecount);
		 }
		 area0.setcrossturnpage();
	    area0.changefocusingEvent=function()
	   {
	   		 area2.curpage = 1;
			isFirstLoad = true;
			
	   }
	   area1.changefocusingEvent=function()
	   {
	   		if(lastDateTimeIndex != area1.curindex)
	   			area2.curpage = 1;
	   		lastDateTimeIndex = area1.curindex;
		
	   }
		//area1.setfocuscircle(0); 
		
        area2 = AreaCreator(11, 1, new Array(-1, 1, -1, -1), "p", "className:p_li on", "className:p_li");
		
		area2.setcrossturnpage();
		area2.setfocuscircle(0);
		area2.setpageturnattention("pageup","images/up.png","images/up_gray.png","pagedown","images/down.png","images/down_gray.png");
		var t;
		area2.asyngetdata=function(date)
		{
			if(date == undefined)
				date = area1.doms[area1.curindex].dataurlorparam;
			//var url = "playbacklistpaging.jsp?channelId="+area0.doms[area0.curindex].dataurlorparam + "&currarea=1&pageIndex="+area2.curpage+"&currdate="+date ;
			//document.getElementById("hidden_frame_channel").src = url;
			AjaxReturn = 0;
			var url = "datajsp/playbacklistdata.jsp?channelId="+area0.doms[area0.curindex].dataurlorparam + "&currarea=1&pageIndex="+area2.curpage+"&currdate="+date;
			getAJAXData(url,getProgramData);
			//alert("load2 AjaxReturn="+AjaxReturn);
			if (AjaxReturn == 0) //AjaxReturn ==0)
			{
			    	clearProgramList();
				var textr = "暂无内容";
				area2.doms[0].setcontent("", textr, 30);
			}
			AjaxReturn = -1;
		}
		
		area2.areaOkEvent = function(){
			saveFocstr(pageobj);
	 		area2.doms[area2.curindex].tempurl +="&returnurl="+escape("playbacklist.jsp?channelId="+area0.doms[area0.curindex].dataurlorparam+"&isComFromHD="+isComFromHD+"&cruntFocus="+cruntFocus+'<%=request.getParameter("returnurl")==null?"":"&returnurl="+request.getParameter("returnurl") %>');
			location.href = area2.doms[area2.curindex].tempurl;
		}
		
		area0.dataarea=area1;
		area1.dataarea=area2;
		
	    //pageobj = new PageObj(0, currFocusChannelIndex, new Array(area0, area1,area2));
		 if(focusObj!=undefined&&focusObj!="null")
		{
			 areaid = parseInt(focusObj[0].areaid);
			 indexid = parseInt(focusObj[0].curindex);
			 area2.curpage = parseInt(focusObj[0].curpage);
			 area0.curpage = parseInt(focusObj[1].curpage);
		}

		
		if(isComFromHD==0)
		{
			indexid = currFocusChannelIndex;
		}
		pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):indexid, new Array(area0, area1, area2));
		setDarkFocus();
		getChannelData(jsChannelList,pagecount);
		if(isComFromHD==0)
		{
		   pageobj.backurl = "playback.jsp";
		}
		else
		{
			pageobj.backurl="play_ControlChannelHD.jsp?CHANNELNUM="+tempchannelNumber+"&COMEFROMFLAG=1&currChannelIndex="+cruntFocus;
		
		}
		document.getElementById("scrollText").innerHTML = "<marquee scrollamount='4'>"+scrollText+"</marquee>";
		area0.curpage=curPageIndex;
    }
</script>
</head>
</html>
