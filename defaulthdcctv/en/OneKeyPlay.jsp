<%-- Copyright 2008-2009 Huawei Tech. Co. Ltd. All Rights Reserved. --%>
<%-- FileName: OneKeyPlay.jsp --%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.ArrangeChannel" %>
<% 
    String strPath = "/EPG/jsp/hdcctv/en/";
%>
<script>
    window.onload = deleyLoadFunc("onekeyload");
    /**
     *延迟调用方法，传递方法名称时，需以此格式传递:deleyLoadFunc("functionName");
     *@para funcName  需要延迟的方法名称 
     *@para deleyTime  延迟时间(毫秒)，可选参数，默认延迟时间1000毫秒
     *@para arg0  需要延迟的方法参数字符串
     */
    function deleyLoadFunc(funcName, deleyTime, arg0)
    {
        
        if(arg0 == undefined || arg0 == "")
        {
            funcName = funcName +"();";
        }
        else
        {
            funcName = funcName +"(" + arg0 + ");";
        }
        
        funcName = "\"" + funcName + "\"";
        
        if(deleyTime == undefined || deleyTime == "" || deleyTime == 0 || /\D/.test(deleyTime))
        {
            deleyTime = 1000;
        }
        
        var deleyStr = "";
        deleyStr += "setTimeout(" + funcName + "," + parseInt(deleyTime) + ");";
        document.writeln("<script language='javascript'>");
        document.writeln(deleyStr);
        document.writeln("<\/script>");
    }
    
    function onekeyload()
    {
	//Webkit Fixed:
        //document.onkeypress = onekeyplayevent;
        
        //判断当前页面中是否有playChannel和inputNum方法，如果有则覆盖

        if(window.playChannel != undefined)
        {
           window.playChannel = funcPlayChannel;
        }
        else
        {
            playChannel = funcPlayChannel;
        }
        
        if(window.inputNum != undefined)
        {
           window.inputNum = funcInputNum;
        }
        else
        {
            inputNum = funcInputNum;
        }
    }

    var number = 0;
    var funcInputNum = function(i)
    {
		if(number * 10 > 1000)
        {
            return 0;
        }
        number = number * 10 + i;
        showChannelNum(number);

        clearTimeout(timeID);
        timeID = setTimeout("playChannel("+ number +")", 1000);
    }
    
    //function playChannel(chanNum)
    var funcPlayChannel = function(chanNum)
    {        
		var tmpurl = "play_ControlChannel.jsp?&CHANNELNUM="+chanNum+"&COMEFROMFLAG=0&ISSUB=0&PREVIEWFLAG=0&returnurl="+escape(location.href);
		//var tmpurl = "play_ControlAction.jsp?&CHANNELNUM="+chanNum+"&COMEFROMFLAG=0&ISSUB=0&PREVIEWFLAG=0&returnurl="+escape(location.href);
        // 播放频道时需要判断该频道是否已订购，修改页面跳转
		//alert(tmpurl);
		window.location.href = tmpurl;    
    }
    
    function showChannelNum(num)
    {
    	// 如果没有trailer则直接展示
    	if (document.all.PlayTrailer == undefined)
    	{
	        var tabdef = '<table width=200 height=30><tr align="right"><td style="color:green; font-size:36px">';
	        tabdef += num;
	        tabdef += '</td></tr></table>';
	        document.getElementById("topframe").innerHTML=tabdef;
        }
        // 否则在trailer中展示
        else
        {
        	document.all.PlayTrailer.showChannelNum(num);
        }
	
    }
    
   
    function funcShowHelp()
    {       
        var nextUrl = "<%=strPath%>help.jsp"; 
        top.EPG.location.href =  nextUrl; 
    }
   
    function funcShowFavourite()
    {       
        var nextUrl = "<%=strPath%>FavoAction.jsp?ACTION=show&enterFlag=check"; 
        top.EPG.location.href =  nextUrl; 
    }
    
    function funcShowBookmark()
    {       
        var nextUrl = "<%=strPath%>BookMark.jsp"; 
        top.EPG.location.href =  nextUrl; 
    }
    
    function goUtility()
    {	
	        eval("eventJson = " + Utility.getEvent());
	        var typeStr = eventJson.type;
	
	        switch(typeStr)
	        {          
	            case "EVENT_MEDIA_END":            
	               document.all.PlayTrailer.mp.playFromStart();
	                return false; 					
					  
				case "EVENT_TVMS":
					dealTVMSEvent();
				    break;
					
	            default :
	                break;
	        }
	        return true;
    }
    
    function volumeUp()
    {    	
    	var muteFlag =  getMpObj().getMuteFlag();
        if(muteFlag == 1)
        {
            getMpObj().setMuteFlag(0);
        }
         
        volume = getMpObj().getVolume(); 
        
        if(volume >= 100)
        {
            volume = 100;           
           
        }
        else
        {
        	volume += 5;
        }
        
        getMpObj().setVolume(volume);        
    }

    function volumeDown()
    {
    	var muteFlag =  getMpObj().getMuteFlag();
        if(muteFlag == 1)
        {
            getMpObj().setMuteFlag(0);
        }
        
        volume = getMpObj().getVolume();
                
        if(volume <= 0)
        {
            volume = 0;    
        }
        else
        {
            volume -= 5;
        }
        
        getMpObj().setVolume(volume); 
    }
    
    function setMuteFlag()
    {
    	var muteFlag =  getMpObj().getMuteFlag();
        if(muteFlag == 1)
        {
            getMpObj().setMuteFlag(0);
        }
        else
        {
        	getMpObj().setMuteFlag(1);
        }
    }
    
    function getMpObj()
    {
    	if (document.all.PlayTrailer == undefined)
    	{
    		if (top.EPG.PlayTrailer == undefined)  return mp;
    		else return top.EPG.PlayTrailer.mp;
    		
    	}
    	else
    	{
    		return document.all.PlayTrailer.mp;
    	}
    }

</script>
<div id="topframe" style="position:absolute;left:600px; top:20px; width:200px; height:30px; z-index:2">
</div>
