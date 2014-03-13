<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
<script type="text/javascript" language="javascript">
<%
int curpage = Integer.parseInt(request.getParameter("curpage"));
int curarea = Integer.parseInt(request.getParameter("curarea"));
%>

    var channelNamelist = new Array("CCTV-1", "CCTV-2", "CCTV-3", "CCTV-4", "CCTV-5",
                                "CCTV-6", "CCTV-7", "CCTV-8", "CCTV-9", "CCTV-10",
                       "CCTV-12", "CCTV-13", "四川卫视", "上海卫视", "湖南卫视",
                                "江苏卫视", "湖北卫视", "新疆卫视", "山东卫视", "河南卫视",
								
								"CCTV-11", "CCTV-21", "CCTV-31", "CCTV-41", "CCTV-51",
                                "CCTV-61", "CCTV-71", "CCTV-81", "CCTV-91", "CCTV-101",
                       "CCTV-121", "CCTV-131", "四川卫视1", "上海卫视1", "湖南卫视1",
                                "江苏卫视1", "湖北卫视1", "新疆卫视1", "山东卫视1", "河南卫视1",
								
								"CCTV-12", "CCTV-22", "CCTV-32", "CCTV-42", "CCTV-52",
                                "CCTV-62", "CCTV-72", "CCTV-82", "CCTV-92", "CCTV-102",
                       "CCTV-122", "CCTV-132", "四川卫视2", "上海卫视2", "湖南卫视2",
                                "江苏卫视2", "湖北卫视2", "新疆卫视2", "山东卫视2", "河南卫视2");
	var channelSeqList = new Array("1", "12", "3", "100", "4",
   "11", "15", "9", "38", "46",
   "789", "178", "223", "45", "34",
   "5", "2", "98", "19", "46",
   
   "11", "121", "31", "100", "41",
   "111", "151", "91", "381", "461",
   "789", "178", "223", "45", "34",
   "51", "21", "981", "191", "461",
   
   "12", "122", "32", "100", "42",
   "112", "152", "92", "382", "462",
   "789", "178", "223", "452", "342",
   "52", "22", "982", "192", "462"
   );

	var pList = new Array("10:00 新闻三十分1", "10:00 新闻三十分2", "10:00 新闻三十分3", "10:00 新闻三十分4",
    "10:00 新闻三十分5", "10:00 新闻三十分6", "10:00 新闻三十分7", "10:00 新闻三十分8",
    "10:00 新闻三十分9", "10:00 新闻三十分10", "10:00 新闻三十分11",
	
	"11:00 新闻三十分1", "11:00 新闻三十分2", "11:00 新闻三十分3", "11:00 新闻三十分4",
    "11:00 新闻三十分5", "11:00 新闻三十分6", "11:00 新闻三十分7", "11:00 新闻三十分8",
    "11:00 新闻三十分9", "11:00 新闻三十分10", "11:00 新闻三十分11",
	
	"12:00 新闻三十分1", "12:00 新闻三十分2", "12:00 新闻三十分3", "12:00 新闻三十分4",
    "12:00 新闻三十分5", "12:00 新闻三十分6", "12:00 新闻三十分7", "12:00 新闻三十分8",
    "12:00 新闻三十分9", "12:00 新闻三十分10", "12:00 新闻三十分11",
	);
    var dateList = new Array("5月31日", "5月30日", "5月29日", "5月28日", "5月27日", "5月26日",
	"6月31日", "6月30日", "6月29日", "6月28日", "6月27日", "6月26日",
	"7月31日", "7月30日", "7月29日", "7月28日", "7月27日", "7月26日");
	var jsCurPage ='<%=curpage%>';
	var jsCurArea = '<%=curarea%>';
	var pos = 0;
	alert("currarea" + jsCurArea);
	if(parseInt(jsCurArea) == 0)
	{
		pos = parseInt(jsCurPage) * 9 - 9;
		var channelList = new Array();
		for(var i = pos; i < channelNamelist.length; i ++)
		{
		    var channelObj = {};
     		channelObj.channelSeq = channelSeqList[i];
   			channelObj.channelName = channelNamelist[i];
    		channelList.push(channelObj);
		}
		window.paren.getChannelData(channelList,100);
	}
	
	if(parseInt(jsCurArea) == 1)
	{
		pos = parseInt(jsCurPage) * 6 - 6;
		var newDateList = new Array();
		for(var i = pos; i < dateList.length; i ++)
		{
			newDateList.push(dateList[i]);
		}
		window.parent.getDateData(newDateList,100);
	}
	
	if(parseInt(jsCurArea) == 2)
	{
		pos = parseInt(jsCurPage) * 11 - 11;
		var programList = new Array();
		for (var j = 0; j < 11; j++) 
		{
            var programObj = {};
            programObj.program = pList[j];
            programList.push(programObj);
        }
		window.parent.getProgramData(programList,100);
	}
	

    
	
</script>
</head>
</html>