<%@ page import="com.bestv.epg.util.WordUtil" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" buffer="32kb" %>
<%@ include file="../../keyboard_A2/keydefine.jsp" %>
<%@ include file="OneKeySwitch_1.jsp" %>

<html>
<head>
    <title>频道</title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <style type="text/css">
        <!--
        body {
            margin-left: 0;
            margin-top: 0;
            margin-right: 0;
            margin-bottom: 0;
        }

        -->
    </style>
    <script type="text/javascript">
        if (typeof(iPanel) != 'undefined') {
            iPanel.focusWidth = "1";
            iPanel.defaultFocusColor = "#000000";
            iPanel.firstLinkFocus = 0;
        }

        var programList=[{"proName":"test1","beginTime":"9:09"},
                         {"proName":"test2","beginTime":"9:09"},
                         {"proName":"test3","beginTime":"9:09"},
                         {"proName":"test4","beginTime":"9:09"},
                         {"proName":"test5","beginTime":"9:09"},
                         {"proName":"test6","beginTime":"9:09"}];
    </script>
</head>

<%!
    private static final int CHANNEL_PER_PAGE = 10;

    private void sortChanList(List channelList) {
        Collections.sort(channelList, new Comparator() {
            public int compare(Object o1, Object o2) {
                return (Integer) ((Map) o1).get("UserChannelID") -
                        (Integer) ((Map) o2).get("UserChannelID");
            }
        });
    }

    private String addZeroIfNecessary(Integer channelIndex) {
        String index = String.valueOf(channelIndex.intValue());
        while (index.length() < 3) {
            index = "0" + index;
        }
        return index;
    }
%>

<%
    TurnPage turnPage = new TurnPage(request);
    String preUrl = turnPage.go(0);
    if(!preUrl.startsWith("channel_trailerChannel_szgd_hd"))
	{
      turnPage.addUrl();
	}

    //高清支持,从session中取得
    int supportHD = 0;
    String strSupportHD = (String) session.getAttribute("SupportHD");
    if (strSupportHD != null)
        supportHD = Integer.parseInt(strSupportHD.trim());

    int pageIndex = 0;

    //焦点记忆
    String focusElmId = "";
    String[] focusMemory = turnPage.getPreFoucs();
    if (focusMemory != null && focusMemory.length == 2) {
        pageIndex = Integer.parseInt(focusMemory[0]);
        focusElmId = focusMemory[1];
    }

    MetaData metaData = new MetaData(request);
    List channelResultList = null;
    List channelList = new ArrayList();
    int channelCount = 0;

    try {
        channelResultList = metaData.getChannelListInfo();
    } catch (Exception e) {
        e.printStackTrace();
    }
    if (channelResultList == null) channelResultList = new ArrayList();

    ArrayList fliterArray = new ArrayList();
    for (int i = 0; i < channelResultList.size(); i++) {
        Map channelMap = (HashMap) channelResultList.get(i);
        if (null != channelMap.get("UserChannelID")) {
            int tmpChanId = (Integer) channelMap.get("UserChannelID");
            if (tmpChanId < 200) {
                fliterArray.add(channelMap);
            }
        }
    }
    channelResultList = fliterArray;

    channelCount = channelResultList.size();

   
     for (int i = 0; i < channelCount; i++) {
            Map channelMap = (HashMap) channelResultList.get(i);
            int definitionFlag;
            if (null == channelMap.get("DEFINITION")) {
                definitionFlag = 2;
            } else {
                definitionFlag = (Integer) channelMap.get("DEFINITION");
            }
            
			if (definitionFlag != 2) {
                channelList.add(channelMap);
            }
     }
   

    channelCount = channelList.size();
    sortChanList(channelList);

    //将经过过滤和排序的频道列表放入上下文
    session.setAttribute("ORIGINAL_CHANNEL_LIST", channelList);

    if (channelList.size() == 0) {
        turnPage.removeLast();
%>
<jsp:forward page="InfoDisplay.jsp?ERROR_ID=25&ERROR_TYPE=2"/>
<%
} else {

    int pageNumber = (channelCount % CHANNEL_PER_PAGE == 0) ?
            channelCount / CHANNEL_PER_PAGE : (channelCount / CHANNEL_PER_PAGE + 1);
%>

<script type="text/javascript">
    var supportHD_js = <%=supportHD%>;

    var page_index = <%=pageIndex%>;
    var channelCount = <%=channelCount%>;
    var channel_per_page = <%=CHANNEL_PER_PAGE%>;
    var page_number = <%=pageNumber%>;
    focusIndex = 0;
    var channelList = [];
    var chanIndex = <%=pageIndex * CHANNEL_PER_PAGE%>;

    var pageProtect = false;
	var key_load=0;
	var nextProg = {};
	var playingProg = {};
	var proList=[];
	var processBarWidth = 0;
</script>

<%
    int preLoadChanOffset = (pageIndex + 1) * CHANNEL_PER_PAGE < channelCount ?
            (pageIndex + 1) * CHANNEL_PER_PAGE : channelCount;
    for (int i = pageIndex * CHANNEL_PER_PAGE; i < preLoadChanOffset; i++) {
        Map channel = (Map) channelList.get(i);
        //回看标识
        int hasRecProg = (Integer) channel.get("IsTvod");
%>
<script type="text/javascript">
    var channel = {};
    channel["ChannelID"] = "<%=channel.get("ChannelID")%>";
    channel["ChannelName"] = "<%=WordUtil.subWord(((String) channel.get("ChannelName")).trim(), 160, "20px", (Map) application.getAttribute("SUB_STRING_MAP"))%>";
    if (channel["ChannelName"].indexOf("CCTV") != -1 && channel["ChannelName"].indexOf("(") != -1) {
        channel["ChannelName"] = channel["ChannelName"].substring(0, 5) + "...";
    }
    channel["CompleteChannelName"] = "<%=channel.get("ChannelName")%>";
    channel["UserChannelID"] = "<%=addZeroIfNecessary((Integer) channel.get("UserChannelID"))%>";
    channel["DecChannelID"] = <%=channel.get("UserChannelID")%>;
    channel["isSubscribe"] = "<%=channel.get("isSubscribe")%>";
    channel["IsTvod"] = "<%=channel.get("IsTvod")%>";
    channel["IsNvod"] = "<%=channel.get("IsNvod")%>";
    channel["hasRecProg"] = "<%=hasRecProg%>";
    channel["previewAble"] = "<%=channel.get("PreviewEnableHWCTC")%>";
    channel["ChannelType"] = "<%=channel.get("ChannelType")%>";
    channel["isHighDefinition"] = <%=channel.get("DEFINITION")%>;
    channelList[chanIndex++] = channel;
</script>
<%
    }
%>

<script type="text/javascript">
var lockPanel = false;
var backupIndex = 0;
var onTvodLink = false;
document.onirkeypress = event;
document.onkeypress = event;

function event() {
    var val = event.which ;
    return keypress(val);
}

function keypress(key_val) {
    switch (key_val)
            {
        case <%=KEY_BACKSPACE%>://回退键和返回键同样处理
        case <%=KEY_RETURN%>:
            window.location.href = "<%=turnPage.go(-1)%>";
            break;
        case <%=KEY_LEFT%>:
            if (lockPanel) {
                lockPanel = false;
                preIndex = backupIndex;
                focusIndex = backupIndex;
                document.getElementById("chan" + preIndex).focus();
            } else if (!onTvodLink) {
                if (document.getElementById("tvod" + preIndex)) {
                    document.getElementById("tvod" + preIndex).focus();
                    onTvodLink = true;
                } else {
                    return 0;
                }
            }
            return 0;
        case <%=KEY_RIGHT%>:
            if (onTvodLink) {
                onTvodLink = false;
				document.getElementById("chan" + preIndex).focus();
            } else if (!lockPanel) {
                lockPanel = true;
                backupIndex = preIndex;
                document.getElementById("trailerLink").focus();
                focusIndex = 1000;
            }
            return 0;
        case <%=KEY_UP%>:
            if(key_load==0) return 0;
			
			if (lockPanel) {
                if (focusIndex == 1002) {
                    focusIndex = 1001;
                    if (document.getElementById("lockPanel2")) document.getElementById("lockPanel2").focus();
                } else if (focusIndex == 1001) {
                    focusIndex = 1000;
                    if (document.getElementById("trailerLink")) document.getElementById("trailerLink").focus();
                } else {
                    return 0;
                }
            } else if (focusIndex % 10 != 0) {
                if (onTvodLink && !document.getElementById("tvod" + (focusIndex - 1))) {
                    onTvodLink = false;
                    document.getElementById("chan" + (focusIndex - 1)).focus();
                }
                focusControl(focusIndex - 1);
            } else if (focusIndex % 10 == 0) {
                if (page_number == 1 || page_number == 0) 
				{
					 return 0;
				}
                lockPanel = false;
                onTvodLink = false;
                genChannelList(page_index - 1, true);
                pageUpOffset = (9 > channelCount - 1 - page_index * channel_per_page) ?
                               channelCount - 1 - page_index * channel_per_page : 9;
                focusIndex = page_index * channel_per_page + pageUpOffset;
                focusControl(focusIndex);
            }
            break;
        case <%=KEY_DOWN%>:
		    if(key_load==0) return 0;
            if (lockPanel) {
                if (focusIndex == 1000) {
                    if (document.getElementById("lockPanel2")) {
                        focusIndex = 1001;
                        document.getElementById("lockPanel2").focus();
                    } else {
                        return 0;
                    }
                } else if (focusIndex == 1001) {
                    focusIndex = 1002;
                    if (document.getElementById("lockPanel3")) document.getElementById("lockPanel3").focus();
                } else {
                    return 0;
                }
            } else if (focusIndex % 10 < channel_per_page - 1 && focusIndex != channelCount - 1) {
                if (onTvodLink && !document.getElementById("tvod" + (focusIndex + 1))) {
                    onTvodLink = false;
                    document.getElementById("chan" + (focusIndex + 1)).focus();
                }
				
				focusControl(focusIndex + 1);
            } else if (focusIndex % 10 == channel_per_page - 1 || focusIndex == channelCount - 1) {
                if (page_number == 1 || page_number == 0) 
				{
				  return 0;
				}
				lockPanel = false;
                onTvodLink = false;
                genChannelList(page_index + 1);
                focusIndex = page_index * channel_per_page;
                focusControl(focusIndex);
				document.getElementById("chan" + focusIndex).focus();
            } else {
				return 0;
            }
            break;
        case <%=KEY_PAGEUP%>:
            if (page_number == 1 || page_number == 0) break;
			
			lockPanel = false;
            onTvodLink = false;
            genChannelList(page_index - 1);
            focusIndex = page_index * channel_per_page;
            focusControl(focusIndex);
            break;
        case <%=KEY_PAGEDOWN%>:
            if (page_number == 1 || page_number == 0) break;
			
		    lockPanel = false;
            onTvodLink = false;
            genChannelList(page_index + 1);
            focusIndex = page_index * channel_per_page;
            focusControl(focusIndex);
            break;
        default:
            return videoControl(key_val);
        
    }
}

focusId = "";
function initPage() {
    //iPanel.ioctlWrite("printf", "------------------------channel page begin------------------------------" + "\n");
    timename=setInterval("showDate();",1000);  
    renderPage();
    focusId = '<%=focusElmId%>';
    genChannelList(page_index);
    
	 
   setTimeout(function() {
    if (focusId != "") {
            document.getElementById(focusId).focus();
            focusIndex = parseInt(focusId.substring(4));
			tempchannelId =  channelList[focusIndex]["ChannelID"] ; 
	        tempindex = focusIndex; 
            if (focusId.indexOf("tvod") != -1) onTvodLink = true;
    } else {
			tempchannelId =  channelList[0]["ChannelID"] ; 
	        tempindex = 0; 
            document.getElementById("chan0").focus();
    }
		
    focusControl(focusIndex);
    focusId = "";
     }, 50); 

    processTrailer();

    setTimeout(function() {
        document.getElementById("chanDataIframe").src = "channel_trailerChannelLoadIframe.jsp";
    }, 500);

    //iPanel.ioctlWrite("printf", "------------------------channel page end------------------------------" + "\n");
}

function genChannelList(page_num, bottomFocus) {
    //iPanel.ioctlWrite("printf", "------------------------channel list render begin------------------------------" + "\n");
    if(page_number == 0 || page_number == 1)
	 {
	   	document.getElementById("upflag").src = "images/dot.gif"; 
	    document.getElementById("downflag").src = "images/dot.gif";  
	 }
	 else if(page_num == 0 || page_num == page_number)
     {
		document.getElementById("upflag").src = "images/dot.gif"; 
	    document.getElementById("downflag").src = "images/szgd/arrow_down_f.png"; 
	 }
	 else if(page_num == (page_number-1) || page_num < 0)
	 {
		document.getElementById("upflag").src = "images/szgd/arrow_up_f.png"; 
	    document.getElementById("downflag").src = "images/dot.gif"; 
	 }
	 else
	 {
		document.getElementById("upflag").src = "images/szgd/arrow_up_f.png"; 
	    document.getElementById("downflag").src = "images/szgd/arrow_down_f.png";
	 } 
    
	 
     if (page_num == page_index || pageProtect) {
        if (page_num < 0) page_num = page_number - 1;
        if (page_num == page_number) page_num = 0;
        page_index = page_num;
        var offset = page_index * channel_per_page;
        var loopLimit = ((offset + channel_per_page) < channelCount) ? (offset + channel_per_page) : channelCount;

        var channelListElm = document.getElementById("channelList");
        channelListElm.innerHTML = "";
        var dynaStr = "";
        var j = 0;


        //-----------------------------------------------------------------------------------------------------------------//
        var programElm = document.getElementById("programList");
        var dpStr="";
        for(var k=0;k<programList.length;k++){
        	var pTop = (k % 10) * 43 + 157;
            dpStr += "<div id=\"proN" + k + "\" style='position:absolute;left:393px;top:"+pTop+"px;width:150px;height:34px;color:grey;font-size:20px;'>" + programList[k]["proName"] + "</div>";
            }
        programElm.innerHTML+=dpStr;
        //-------------------------------------------------------------------------------------------------------------------//

        
        for (var i = offset; i < loopLimit; i++) {
            //位置变量
            var top1 = (i % 10) * 43 + 165;
            var top2 = (i % 10) * 43 + 175;
            var top3 = (i % 10) * 43 + 172;
            var left1 = 100;
            var left2 = 121;
            var left3 = 181;
            var left4 = 54;
            var loopVar = channelList[i];
            var channelUrl = genUrl(loopVar);
            channelUrl = "SaveCurrFocus.jsp?currFoucs=" + page_index + ",chan" + i + "&url=" + channelUrl;
            var tvodUrl = genTvodUrl(loopVar);
            tvodUrl = "SaveCurrFocus.jsp?currFoucs=" + page_index + ",tvod" + i + "&url=" + tvodUrl;
            if (loopVar["isSubscribe"] == "1") {
                dynaStr += "<div style='position:absolute;left:" + left1 + "px;top:" + top1 + "px;width:239px;height:42px;'><a id=\"chan" + i + "\" href=\"" + channelUrl + "\"><img id=\"chanPanel" + i + "\" src=\"images/dot.gif\" width=\"239\" height=\"42\" border=\"0\"></a></div>";
				dynaStr += "<div style='position:absolute;left:" + left1 + "px;top:" + (top1+43) + "px;width:239px;height:2px;'><img  src=\"images/szgd/line_interval.png\" width=\"239\" height=\"2\" border=\"0\"></div>";
				
                dynaStr += "<div id=\"chanId" + i + "\" style='position:absolute;left:" + left2 + "px;top:" + top2 + "px;color:#ffffff;font-size:20px;'>" + loopVar["UserChannelID"] + "</div>";
                dynaStr += "<div id=\"chanName" + i + "\" style='position:absolute;left:" + left3 + "px;top:" + top2 + "px;width:170px;height:34px;color:#ffffff;font-size:20px;'>" + loopVar["ChannelName"] + "</div>";
            } else {
                dynaStr += "<div style='position:absolute;left:" + left1 + "px;top:" + top1 + "px;width:239px;height:42px;'><a id=\"chan" + i + "\" href=\"" + channelUrl + "\"><img id=\"chanPanel" + i + "\" src=\"images/dot.gif\" width=\"239\" height=\"42\" border=\"0\"></a></div>";
				dynaStr += "<div style='position:absolute;left:" + left1 + "px;top:" + (top1+43) + "px;width:239px;height:2px;'><img  src=\"images/szgd/line_interval.png\" width=\"239\" height=\"2\" border=\"0\"></div>";
				
                dynaStr += "<div id=\"chanId" + i + "\" style='position:absolute;left:" + left2 + "px;top:" + top2 + "px;color:grey;font-size:20px;'>" + loopVar["UserChannelID"] + "</div>";
                dynaStr += "<div id=\"chanName" + i + "\" style='position:absolute;left:" + left3 + "px;top:" + top2 + "px;width:150px;height:34px;color:grey;font-size:20px;'>" + loopVar["ChannelName"] + "</div>";
            }
            if (loopVar["hasRecProg"] == "1") {
                dynaStr += "<div style='position:absolute;left:" + left4 + "px;top:" + top3 + "px;width:27px;height:27px;'><a id=\"tvod" + i + "\" href=\"" + tvodUrl + "\"><img src=\"images/channel20/ui_button_backlook.png\" width=\"18\" height=\"22\"></a></div>";
            }
            j++;
        }
        channelListElm.innerHTML += dynaStr;

        if (focusId == "") {
            if (bottomFocus) {
                document.getElementById("chan" + (loopLimit - 1)).focus();
            } else {
                document.getElementById("chan" + offset).focus();
            }
        }
		
		setTimeout("key_load=1;",200);
    }
}

var timeId = 0;
chanIndex = 0;
function showDetail(index) {
    loadTrailer(index);//播放vod

    startMarquee(index);//字符过长就用跑马灯
    showPanel(index);//没有视屏则tishi

    clearTimeout(timeId);
    chanIndex = index;
	
	loadProg(chanIndex);
    timeId = setTimeout(function() {
	
	if( playingProg["progName"] == undefined)
	{
	  document.getElementById("processBar").width = 0;
	  document.getElementById("playingProg").innerText = "&nbsp;暂无节目单";
	}
	else
	{
	  document.getElementById("processBar").width = processBarWidth;
	  document.getElementById("playingProg").innerText = playingProg["showBegin"] + "&nbsp;" + playingProg["progName"]+ (proList.length);
	}
	
	if( nextProg["progName"] == undefined)
	{
	  document.getElementById("nextProg").innerText = "&nbsp;暂无节目单";
	}
	else
	{
	  document.getElementById("nextProg").innerText = nextProg["showBegin"] + "&nbsp;" + nextProg["progName"];
	}
		playingProg = {};
		nextProg = {};
    }, 1000);
	
}

var prePanel = "";
var preId = "";
var preText = "";
preIndex = 0;
function showPanel(index) {
    pastePanel(index);
}

function pastePanel(index) {
    var channel = channelList[preIndex];
    if (prePanel != "") document.getElementById(prePanel).src = "images/dot.gif";
    if (preId != "") document.getElementById(preId).style.color = channel["isSubscribe"] == "1" ? "#ffffff" : "grey";
    if (preText != "") document.getElementById(preText).style.color = channel["isSubscribe"] == "1" ? "#ffffff" : "grey";
    preIndex = index;
    prePanel = "chanPanel" + index;
    preId = "chanId" + index;
    preText = "chanName" + index;
    document.getElementById(prePanel).src = "images/szgd/focus.png";
  
}

function hideDetail(index) {
    stopMarquee(index);
    clearPre();
}

function clearPre() {
    var channel = channelList[preIndex];
    if (prePanel != "") document.getElementById(prePanel).src = "images/dot.gif";
    if (preId != "") document.getElementById(preId).style.color = channel["isSubscribe"] == "1" ? "#ffffff" : "grey";
    if (preText != "") document.getElementById(preText).style.color = channel["isSubscribe"] == "1" ? "#ffffff" : "grey";
}

function startMarquee(index) {
    var channel = channelList[index];
    marqueeText = channel["CompleteChannelName"];
    
	if (channel["ChannelName"] != channel["CompleteChannelName"]) {
        //document.getElementById("chanName" + index).innerHTML = "<marquee scrollamount=5>" + marqueeText + "</marquee>";
    }
}

function stopMarquee(index) {
    var channel = channelList[index];
	
	if (channel["ChannelName"] != channel["CompleteChannelName"]) {
       // document.getElementById("chanName" + index).innerHTML = channel["ChannelName"];
    }
}

function loadTrailer(index) {
    if (channelList[index]["isSubscribe"] == "1") {
        if (channelList[preIndex]["isSubscribe"] == "0") {
            document.getElementById("trailerPic").src = "images/dot.gif";
            processTrailer();
        }
        var channelIndex = channelList[index]["DecChannelID"];
        mp.joinChannel(parseInt(channelIndex));
    } else {
        mp.leaveChannel();
        document.getElementById("trailerPic").src = "images/channel20/ui_bg_unsubscribechannel.jpg";
    }
}

//显示计时器
var loadchannel = -1;
var tempchannelId = '';
var tempindex = '';
function loadProg(index) {
    var channelId = channelList[index]["ChannelID"];
    tempchannelId = channelId ; 
	tempindex = index; 
	 
    document.getElementById("trailerLink").href = "SaveCurrFocus.jsp?currFoucs=" + page_index + ",chan" + index + "&url=" + genUrl(channelList[index]);
    clearProgDiv();
	document.getElementById("channelProg").src = "channel_trailerChannelProgIframe_szgd.jsp?channelId=" + channelId + "&chanIndex=" + index;
	document.getElementById("proIframe").src = "test_channel_program.jsp?channelId=" + tempchannelId + "&chanIndex=" + tempindex;
	clearTimeout(loadchannel);
    loadchannel = setTimeout("loadprogData()",200);
    
}

function loadprogData()
{
	document.getElementById("channelProg").src = "channel_trailerChannelProgIframe_szgd.jsp?channelId=" + tempchannelId + "&chanIndex=" + tempindex;
	document.getElementById("proIframe").src = "test_channel_program.jsp?channelId=" + tempchannelId + "&chanIndex=" + tempindex;
}

function clearProgDiv() {
    document.getElementById("playingProg").innerHTML = "";
    document.getElementById("nextProg").innerHTML = "";
    document.getElementById("lastProg").innerHTML = "";
    document.getElementById("theProgBeforeLast").innerHTML = "";
    document.getElementById("lockDiv2").innerHTML = "";
    document.getElementById("lockDiv3").innerHTML = "";
    document.getElementById("processBar").width = "0";
}

function focusControl(index) {
    hideDetail(preIndex);
    showDetail(index);
    updateIndexInfo(index);
    focusIndex = index;
}

function updateIndexInfo(index) {
   // document.getElementById("chanIndex").innerHTML = index + 1;
}

function genChannelUrl(channel) {
    var channelUrl = "";
    if (channel["ChannelType"] == 3)
    {
        channelUrl = "au_PlayFilm.jsp?PROGID=" + channel["ChannelID"]
                + "&PLAYTYPE=" + "<%=EPGConstants.PLAYTYPE_VAS%>"
                + "&CONTENTTYPE=" + "<%=EPGConstants.CONTENTTYPE_VAS%>"
                + "&BUSINESSTYPE=" + "<%=EPGConstants.BUSINESSTYPE_VAS%>"
                + "&CHANNELNUM=" + channel["UserChannelID"] + "&PREVIEWFLAG=" + channel["previewAble"]
                + "&ISSUB=" + channel["isSubscribe"]
                + "&COMEFROMFLAG=2";
    }
    if (channel["IsNvod"] == 1)
    {
        channelUrl = "au_PlayFilm.jsp?PROGID=" + channel["ChannelID"]
                + "&PLAYTYPE=" + "<%=EPGConstants.PLAYTYPE_NVOD %>"
                + "&CONTENTTYPE=" + "<%=EPGConstants.CONTENTTYPE_CHANNEL_VIDEO%>"
                + "&BUSINESSTYPE=" + "<%=EPGConstants.BUSINESSTYPE_NVOD%>"
                + "&CHANNELNUM=" + channel["UserChannelID"] + "&PREVIEWFLAG=" + channel["previewAble"]
                + "&ISSUB=" + channel["isSubscribe"]
                + "&COMEFROMFLAG=2";
    }
    else
    {
        channelUrl = "au_PlayFilm.jsp?PROGID=" + channel["ChannelID"]
                + "&PLAYTYPE=" + "<%=EPGConstants.PLAYTYPE_LIVE %>"
                + "&CONTENTTYPE=" + "<%=EPGConstants.CONTENTTYPE_CHANNEL_VIDEO%>"
                + "&BUSINESSTYPE=" + "<%=EPGConstants.BUSINESSTYPE_LIVETV%>"
                + "&CHANNELNUM=" + channel["UserChannelID"] + "&PREVIEWFLAG=" + channel["previewAble"]
                + "&ISSUB=" + channel["isSubscribe"]
                + "&COMEFROMFLAG=2";
    }
    return channelUrl;
}

/**
 *获得URL，进入频道播放流程
 */
function genUrl(channel) {
    var channelUrl = genChannelUrl(channel);
    if (channel["isHighDefinition"] == 1)
    {
        if (supportHD_js == 1) {
            return channelUrl;
        }
        else
        {
            return "InfoDisplay.jsp?ERROR_TYPE=2&ERROR_ID=128";
        }
    }
    else
    {
        return channelUrl;
    }
}

function genTvodUrl(channel) {
    //chanIsDefinition＝1高清频道2标清频
    if (channel["isHighDefinition"] == 1) {
        if (supportHD_js == 1) {
            return "catchup_portal_szgd.jsp?CHANNELID=" + channel["ChannelID"] ;
        }
        else {
            return "InfoDisplay.jsp?ERROR_TYPE=2&ERROR_ID=128";
        }
    }
    else {
        return "catchup_portal_szgd.jsp?CHANNELID=" + channel["ChannelID"] ;
    }
}

 //---------------------------------------------------  
	  // 日期格式化 
	  // 格式 YYYY/yyyy/YY/yy 表示年份
	  // MM/M 月份   
	  // W/w 星期 
	  // dd/DD/d/D 日期 
	  // hh/HH/h/H 时间 
	  // mm/m 分钟 
	  // ss/SS/s/S 秒   
	  //---------------------------------------------------   
	  Date.prototype.Format = function(formatStr){   
           var str = formatStr;   
           var Week = ['日','一','二','三','四','五','六'];  
  
           str=str.replace(/yyyy|YYYY/,this.getFullYear());   
           str=str.replace(/yy|YY/,(this.getYear() % 100)>9?(this.getYear() % 100).toString():'0' + (this.getYear() % 100));   
 
           str=str.replace(/MM/,(this.getMonth()+1)>9?(this.getMonth()+1).toString():'0' + (this.getMonth()+1));   
           str=str.replace(/M/g,this.getMonth());   
  
           str=str.replace(/w|W/g,Week[this.getDay()]);   
  
           str=str.replace(/dd|DD/,this.getDate()>9?this.getDate().toString():'0' + this.getDate());   
           str=str.replace(/d|D/g,this.getDate());   
 
           str=str.replace(/hh|HH/,this.getHours()>9?this.getHours().toString():'0' + this.getHours());   
           str=str.replace(/h|H/g,this.getHours());   
           str=str.replace(/mm/,this.getMinutes()>9?this.getMinutes().toString():'0' + this.getMinutes());   
           str=str.replace(/m/g,this.getMinutes());   
  
           str=str.replace(/ss|SS/,this.getSeconds()>9?this.getSeconds().toString():'0' + this.getSeconds());   
           str=str.replace(/s|S/g,this.getSeconds());   
  
           return str;   
       }  
	   
	   function showDate()
	   {
		    var d= new Date();
			var date = '<span style="font-size:20px; color:#ffffff;"> '+d.Format('yyyy年MM月dd日')+'</span>';
			var week = '<span style="font-size:20px; color:#ffffff;"> '+'星期'+d.Format('W')+'</span>'+'<span style="font-size:22px; color:#d8583b;"> '+d.Format('hh:mm:ss')+'</span>';
			
			document.getElementById("sysDate").innerHTML =date;
			document.getElementById("sysWeek").innerHTML =week;
			
	   }
</script>

<%
    ServiceHelpHWCTC serviceHelphwctc = new ServiceHelpHWCTC(request);

    String playUrl;
    //获取第一个频道的信息
    int channelId = Integer.parseInt(String.valueOf(((Map) channelList.get(0)).get("ChannelID")));
    int channelIndex = Integer.parseInt(String.valueOf(((Map) channelList.get(0)).get("UserChannelID")));
    String mediacode = String.valueOf(((Map) channelList.get(0)).get("CODE"));
    playUrl = serviceHelphwctc.getTriggerPlayUrlHWCTC(2, channelId, channelIndex, "0", "0", "0", "0", "2");
	
	
%>

<script type="text/javascript">
    var mp = new MediaPlayer();
    var json = '[{mediaUrl:"<%=playUrl%>",';
    json += 'mediaCode: "<%=mediacode%>",';
    json += 'mediaType:1,';
    json += 'audioType:1,';
    json += 'videoType:3,';
    json += 'streamType:2,';
    json += 'drmType:1,';
    json += 'fingerPrint:0,';
    json += 'copyProtection:1,';
    json += 'allowTrickmode:0,';
    json += 'startTime:0,';
    json += 'endTime:10000.3,';
    json += 'entryID:"jsonentry1"}]';

    var channelIndex = <%=channelIndex%>;

    function processTrailer() {
        initMediaPlay();
        mp.leaveChannel();

        mp.setSingleMedia(json);
        mp.setAllowTrickmodeFlag(0);
        mp.setNativeUIFlag(0);
        mp.setMuteUIFlag(0);

        play();
    }

    function play() {
        //mp.joinChannel(channelIndex);
		mp.setVideoDisplayArea(893, 155, 485, 272);
        mp.setVideoDisplayMode(0);
        mp.refreshVideoDisplay();
    }

    function initMediaPlay() {
        var instanceId = mp.getNativePlayerInstanceID();
        var playListFlag = 0;
        var videoDisplayMode = 0;
        var height = 0;
        var width = 0;
        var left = 0;
        var top = 0;
        var muteFlag = 0;
        var subtitleFlag = 0;
        var videoAlpha = 0;
        var cycleFlag = 0;
        var randomFlag = 0;
        var autoDelFlag = 0;
        var useNativeUIFlag = 1;
        mp.initMediaPlayer(instanceId, playListFlag, videoDisplayMode, height, width, left, top, muteFlag, useNativeUIFlag, subtitleFlag, videoAlpha, cycleFlag, randomFlag, autoDelFlag);
    }

    function destoryMP() {
        mp.leaveChannel();
        mp.stop();
    }
</script>

<body bgcolor="transparent" background="images/szgd/bg_other_2.png" onLoad="initPage();"
      onunload="destoryMP();">
      
<div style="position:absolute;left:87px;top:54px;"><img src="images/szgd/logo.png" /></div>
<!-- <div style="position:absolute;left:850px;top:54px;"><img src="images/szgd/logo1.png" width="171" height="39"/> </div> -->
<div style="position:absolute; left:1050px; top:45px; width:168px; height:58px;">
<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%" style="font-size:14px; color:#FFFFFF">
<tr>
<td id="sysDate" align="center"></td>
</tr>
<tr>
<td id="sysWeek" align="center"></td>
</tr>
</table>
</div>

<div style="position:absolute; left:907px; top:185px; width:304px; height:124px;">
<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%" style="font-size:18px; color:#ffffff">
<tr>
<td width="35%"><img src="images/szgd/dll.jpg" width="98" height="122"/></td>
<td width="65%"><img src="images/szgd/num1.png" width="40" height="41"/> <br /><br />
杜拉拉升职记
</td>
</tr>
</table>
</div>
<div style="position:absolute; left:907px; top:318px; width:304px; height:124px;">
<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%" style="font-size:20px; color:#ffffff">
<tr>
<td width="35%"><img src="images/szgd/ys.jpg" width="98" height="122"/></td>
<td width="65%"><img src="images/szgd/num2.png" width="40" height="41"/> <br /><br />
亚瑟和他的迷你王国2</td>
</tr>
</table>
</div>
<div style="position:absolute; left:907px; top:451px; width:304px; height:124px;">
<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%" style="font-size:20px; color:#ffffff">
<tr>
<td width="35%"><img src="images/szgd/ygbh.jpg" width="98" height="122"/></td>
<td width="65%"><img src="images/szgd/num3.png" width="40" height="41"/> <br /><br />
月光宝盒</td>
</tr>
</table>
</div>

<div style="position:absolute; left:361px; top:123px;"><img src="images/szgd/line_interval_1.png" width="1" height="480"/></div> 

<div style='position:absolute; left:180px; top:103px; width:70px; height:20px;'>
    <img id="upflag" src="images/dot.gif" width="70" height="20"/>
</div>

<div style='position:absolute; left:180px; top:603px; width:70px; height:20px;'>
    <img id="downflag" src="images/dot.gif" width="70" height="20"/>
</div>


<div style='position:absolute; left:73px; top:138px; width:170px; height:33px; color:#ffffff; font-size:26px; font-weight:bold;'>
    高清频道
</div>
<!--
<div style='position:absolute; left:451px; top:116px; color:#46a1f7; font-size:20px'>
    第<span id="chanIndex"></span>/<%=channelCount%>个频道
</div>
-->
<div id="channelList"></div>
<div id="programList"></div>

<div style="position:absolute; left:393px; top:426px; width:491px; height:13px">
    <img id="processBar" src="images/channel20/process_bar.gif" width="0" height="13">
</div>

<div style="position:absolute; left:393px; top:157px; width:385px; height:272px;">
    <a id="trailerLink" href="#"><img id="trailerPic" src="images/dot.gif" width="485" height="272"></a>
</div>

<div style="position:absolute; left:690px; top:470px; width:495px; color:#ffffff; font-size:19px;">
   正在播出:&nbsp;<font color=\"#ffffff\" id="playingProg"></font>
</div>

<div  style="position:absolute; left:689px; top:500px; width:499px; color:#ffffff; font-size:19px;">
   将要播出:&nbsp;<font color=\"#ffffff\" id="nextProg"></font>
</div>
<!--
<div id="lockDiv2" style="position:absolute;left:460px;top:495px;width:315px;height:45px"></div>
<div id="lastProg" style="position:absolute;left:470px;top:507px;width:315px;height:45px;color:#ffffff;font-size:19px;"></div>

<div id="lockDiv3" style="position:absolute;left:460px;top:547px;width:315px;height:45px"></div>
<div id="theProgBeforeLast"
     style="position:absolute;left:470px;top:560px;width:315px;height:45px;color:#ffffff;font-size:19px;"></div>
-->
<div style="position:absolute;left:68px;top:630px;width:1123px;height:60px;">
<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%" style="font-size:18px; color:#fdb913;">
<tr>
<td width="9%">操作提示：</td>
<td width="3%">按</td>
<td width="8%"><img src="images/szgd/key.png" width="80" height="16"/></td>
<td width="14%">可进行选择，按 </td>
<td width="5%" style="color:#FFFFFF">确认</td>
<td width="10%">键进入，按</td>
<td width="6%" style="color:#FFFFFF">返回</td>
<td width="7%">键退出</td>
<td width="3%"><img src="images/szgd/b_ico1.png" width="19" height="19"/></td>
<td width="8%">我的空间</td>
<td width="3%"><img src="images/szgd/b_ico2.png" width="19" height="19"/></td>
<td width="6%">搜索</td>
<td width="3%"><img src="images/szgd/b_ico3.png" width="19" height="19"/></td>
<td width="5%">点播</td>
<td width="3%"><img src="images/szgd/b_ico4.png" width="19" height="19"/></td>
<td width="5%">本地</td>
</tr>
</table>
</div>
<iframe id="channelProg" frameborder="0" height="0" width="0" ></iframe>
<iframe id="chanDataIframe" width="0" height="0"></iframe>
<iframe id="proIframe" width="0" height="0"></iframe>

</body>

<%
    }
%>

</html>