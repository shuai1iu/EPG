<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%> 
<%@ include file="util/save_focus.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<%@ include file="datajsp/playbackdata.jsp"%>
<script language="javascript" type="text/javascript" src="../js/pagecontrol.js"></script>
<script language="javascript" type="text/javascript">
         var area2;
        window.onload = function() {
            refreshServerTime();
            initPage();
        }
        var area0;
        var area1;
       
        var timeIndex = 0;
        var isFirstLoad = true;
        var firstChannelId = 0;
        var firstChanelDate = "";
        var returnurl = '<%=request.getParameter("returnurl")%>';
		var currIndex;
		var currPage;
		var requestChannelId = '<%=request.getParameter("channelId")%>';
		var areaid;
		var indexid;
var AjaxReturn = -1;

        function initPage() {
			area0 = AreaCreator(8, 1, new Array(-1, -1, -1, 2), new Array("channel", "channel_a"), new Array("className:item item_select", "className:link onboder"), new Array("className:item", "className:link offboder"));
			area1 = AreaCreator(7, 1, new Array(-1, 2, -1, 0), new Array("date", "date_a"), new Array("className:item item_select", "className:link onboder"), new Array("className:item", "className:link offboder"));
			area2 = AreaCreator(9, 1, new Array(-1, 0, -1, 1), new Array("program", "program_a"), new Array("className:item item_focus", "className:link onboder"), new Array("className:item", "className:link offboder"));
			if(focusObj!=undefined&&focusObj!="null" )
			{
				areaid = parseInt(focusObj[0].areaid);
				indexid = parseInt(focusObj[0].curindex);
				if(area2 != undefined )
					area2.curpage = parseInt(focusObj[0].curpage);
				if(focusObj.length >=2)
				{
					if(area0 != undefined)
						area0.curpage = parseInt(focusObj[1].curpage);
				}
			}
            //channellist
           
            area0.setstaystyle(new Array("className:item item_select", "className:link offboder"), 3);
            area0.setfocuscircle(0);
            area0.setcrossturnpage();
            area0.setpageturnattention("channelPageUp", "../images/arr-up.png", "../images/arr-up_disable.png", "channelPageDown", "../images/arr-down.png", "../images/arr-down_disable.png");
			//area0.setstaystyle("className:item item_select", 3);
            for (var i = 0; i < 8; i++) {
                area0.doms[i].contentdom = $("channel" + i + i);
            }
            area0.asyngetdata = function() {
                pagerChannelList();
            }
            area0.changefocusingEvent = function() {
                area2.curpage = 1;
				if(area1.curindex == 0)
					isFirstLoad = true;
            }

           
			area1.setstaystyle(new Array("className:item item_select", "className:link offboder"), 1);
            area1.asyngetdata = function(channelId) {
			area1.setfocuscircle(0);
				
                firstChannelId = channelId;
                var url = "datajsp/playbackdateList.jsp?channelId=" + channelId;
				
                getAJAXData(url, getDateList);
            }
            area1.changefocusingEvent = function() {
                area2.curpage = 1;
            }
          
            for (var k = 0; k < 9; k++) {
                area2.doms[k].contentdom = $("program" + k + "_name" + k);
            }
            area2.setfocuscircle(0);
            area2.setcrossturnpage();
            // getprogramlist
            area2.asyngetdata = function(date) {
                if (date == undefined)
                    date = area1.doms[area1.curindex].dataurlorparam;
                var url = " datajsp/playbackprogramList.jsp?channelId=" + area0.doms[area0.curindex].dataurlorparam + "&pageIndex=" + area2.curpage + "&currdate=" + date;
		AjaxReturn = 0;
                getAJAXData(url, getProgamList);
                if(AjaxReturn == 0) 
                {
			clearProgramList();	
                       $("program0_time0").innerHTML = "";
			area2.doms[0].updatecontent("暂无内容");
                }
		AjaxReturn = -1;
		if(pageobj.curareaid == 2)
		    area2.doms[area2.curindex].changefocus(true);
            }
	   area2.setcrossturnpage();
	   area2.areaOkEvent = function()
	   {
		saveFocstr(pageobj);
           }
            area0.dataarea = area1;
            area1.dataarea = area2;
   	   if(areaid != null && indexid != null)
		pageobj = new PageObj(areaid,indexid, new Array(area0, area1, area2));
	else
	{
		if(requestChannelId != null && requestChannelId != undefined && requestChannelId != "" && requestChannelId != "null")
		{
		
			findChannel();
			if(currPage != undefined && currPage != "undefined")
			if(currPage == 0)
			{
				currPage = 1;
			}
					
			area0.curpage = parseInt(currPage);
			if(currIndex != undefined && currIndex != "undefined")
				pageobj = new PageObj(0,parseInt(currIndex), new Array(area0, area1, area2));
		}
		else
			pageobj = new PageObj(0,0, new Array(area0, area1, area2));
				
		}
		if(returnurl != null && returnurl != undefined && returnurl != "" && returnurl != "null")
			 pageobj.backurl = returnurl;
	        else
			pageobj.backurl = "index.jsp?back=1";
			
		
		setDarkFocus();
                pagerChannelList();
        }

        function clearProgramList() {
		area1.directions[1] = 0;
                area0.directions[3] = 1;
                area2.setpageturndata(0, 0);
                $("pageNum").innerText ="";
            	for (var k = 0; k < area2.doms.length; k++) {
               	 	$("program" + k + "_time" + k).innerHTML = "";
                	$("program" + k + "_name" + k).innerHTML = "";
            	}
        }

        function getProgamList(result) {
	    AjaxReturn = 1;
            //clearProgramList();
            var re;
            if (result.substring(0, 1) != '{')
                return;
            re = eval('(' + result + ')');
            var data = re.data;

            var pageCount = re.count;
            area2.setpageturndata(data.length, pageCount);
			if(pageCount!=0){
				area0.directions[3] = 2;
				area1.directions[1] = 2;
				for (var k = 0; k < area2.doms.length; k++) {
					if (k < data.length) {
						
						var hour = data[k].STARTTIME.substring(8, 10);
						var minitue = data[k].STARTTIME.substring(10, 12);
						var time = hour + ":" + minitue;
						var url = "au_ReviewOrSubscribe.jsp?PROGID=" + data[k].PROGRAMID + "&PLAYTYPE=4&CONTENTTYPE=300&&BUSINESSTYPE=5&PROGSTARTTIME=" + data[k].STARTTIME + "&PROGENDTIME=" + data[k].ENDTIME + "&ISSUB=1&PREVIEWFLAG=1&TVOD=1&CHANNELID=" + area0.doms[area0.curindex].dataurlorparam +"&LOGICCHANNELID="+area0.doms[area0.curindex].youwanauseobj + "&returnurl="+escape("playback.jsp");
						
						area2.doms[k].mylink = url;
						$("program" + k + "_time" + k).innerHTML = time;
						area2.doms[k].setcontent("", data[k].PROGNAME, 19, true, false);
					}
					else {
						area2.doms[k].updatecontent("");
						$("program" + k + "_time" + k).innerHTML = "";
					}
	
				}
				$("pageNum").innerText =area2.curpage+"/"+pageCount;
			}else{
				area1.directions[1] = 0;
				area0.directions[3] = 1;
				area2.doms[0].updatecontent("暂无内容");
				area2.setpageturndata(0, 0);
				$("pageNum").innerText ="";
			}
        }

        function clearDateList() {
            for (var k = 0; k < area1.doms.length; k++) {
                $("date" + k + k).innerHTML = "";
            }

        }

        function rerverseDate(data) {
            var dateList = new Array();

            for (var i = data.length - 1; i >= 0; i--) {
                dateList.push(data[i]);
            }
            return dateList;
        }

        function getDateList(result) {
	   clearDateList();
           var data = eval('(' + result + ')');
           data = rerverseDate(data);
	    if (data != undefined)  //ztewebkit
           area1.datanum = (data.length<=7)?data.length:7;
	   if (data != undefined)  //ztewebkit
           for (var j = 0; j < 7 && j < data.length; j++) {

              if (j >= data.length) {
                    //area1.doms[j].updatecontent("");
                    $("date" + j + j).innerHTML = "";
              }
              else {
                   $("date" + j + j).innerHTML = data[j].dateDay;
                    area1.doms[j].dataurlorparam = data[j].date24;
              }

            }
            if (isFirstLoad && data.length != 0) {

                //第一次加载一次节目单
                firstChanelDate = data[0].date24;
		if(focusObj!=undefined&&focusObj!="null" && focusObj.length >2)
		{
			
			firstChanelDate = area1.doms[focusObj[2].curindex].dataurlorparam;
			
			area2.curpage = focusObj[0].curpage;
		}
		else
		{
			$("date0").className = "item item_select";
		}
		AjaxReturn = 0;
                getAJAXData("datajsp/playbackprogramList.jsp?channelId=" + firstChannelId + "&pageIndex=" + area2.curpage + "&currdate=" + firstChanelDate, getProgamList);
		if(AjaxReturn == 0)
		{
			clearProgramList();
			$("program0_time0").innerHTML = "";
			area2.doms[0].updatecontent("暂无内容");
		}
		AjaxReturn = -1;
                isFirstLoad = false;
            }
	    else
	    {
		AjaxReturn = 0;
		getAJAXData("datajsp/playbackprogramList.jsp?channelId=" + firstChannelId + "&pageIndex=" + area2.curpage + "&currdate=" + area1.doms[area1.curindex].dataurlorparam, getProgamList);
                if(AjaxReturn == 0) //AjaxReturn ==0)
                {
			clearProgramList();
                       $("program0_time0").innerHTML = "";
	       		area2.doms[0].updatecontent("暂无内容");	       
	        }
		AjaxReturn = -1;
	    }


        }

        function getChannelData(data, pageCount) {
            area0.setpageturndata(data.length, parseInt(pageCount));
			area0.datanum = data.length;
            for (var i = 0; i < area0.doms.length; i++) {

                if (i < data.length) {
					
					var tmpchannelNumber = parseInt(data[i].channelNumber) - 1000;
                    var tmpSeq = "" + tmpchannelNumber;
					
                    var tmpStr = "";
                    if (tmpSeq.length == 1)
                        tmpStr = "00";
                    if (tmpSeq.length == 2)
                        tmpStr = "0";
                  
                    var channelNumber = tmpStr + tmpSeq;
                    var content = channelNumber + "  " + data[i].channelName;
					
                    area0.doms[i].setcontent("", content, 18, true, false);
                    area0.doms[i].dataurlorparam = data[i].channelId;
					area0.doms[i].youwanauseobj=tmpchannelNumber;
                }
                else {
                    $("channel" + i + "_num" + i).innerHTML = "";
                    area0.doms[i].updatecontent("");
                }
            }
            
            if (isFirstLoad && data.length != 0) 
		{
			firstChannelId = data[0].channelId;
			if(focusObj!=undefined && focusObj!="null" && focusObj != null)
			{
				firstChannelId = area0.doms[focusObj[1].curindex].dataurlorparam;
					
			}
			else
			{
				if(requestChannelId != null && requestChannelId != undefined && requestChannelId != "" && requestChannelId != "null")
				{
					firstChannelId = requestChannelId;
				}
			}
				
			var url = "datajsp/playbackdateList.jsp?channelId=" + firstChannelId;
                	getAJAXData(url, getDateList);
			getAJAXData(url, getDateList);
				
            }

        }
		
		function findChannel()
		{
			
			var pageSize = 8;
			for(var i = 0; i < pageCount ; i ++)
			{
				var startPos = i * pageSize;
				var endPos = startPos + pageSize;
				for (var j = startPos; j < endPos; j++) 
				{
                  if (jsChannelList[j].channelId == requestChannelId) 
				  {
					  
                      currPage = parseInt(i + 1);
                      currIndex = parseInt(j % pageSize);
                      return;
                  }
              }
			}
		}
		
		
        function pagerChannelList() {
            var channelList = new Array();
            var start = (area0.curpage - 1) * 8;
		
            var size = (totalRecord - start) >= 8 ? 8 : (totalRecord - start);
            for (i = 0; i < size; i++) {
                channelList[i] = jsChannelList[start + i];
            }
		
            getChannelData(channelList, pageCount);
        }

        function $(elemId) {
            return document.getElementById(elemId);
        }
	
	

    </script>
