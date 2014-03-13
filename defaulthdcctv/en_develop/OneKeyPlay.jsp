<%-- Copyright 2008-2009 Huawei Tech. Co. Ltd. All Rights Reserved. --%>
<%-- FileName: OneKeyPlay.jsp --%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="java.util.*" %>
<script>
<%  
    MetaData recmetaData = new MetaData(request);
    String gaoqingzhibocode="00000100000000090000000000015840"; //高清直播
    String biaoqingzhibocode="00000100000000090000000000015842"; //标清直播
    String strPath = "/EPG/jsp/hdcctv/en/";
    ArrayList recChanresult=new ArrayList();
    ArrayList recChanresult1=new ArrayList();
    ArrayList recChanList=new ArrayList();
    ArrayList recChanchannel1=new ArrayList();
	
    recChanresult = recmetaData.getChanListByTypeId(gaoqingzhibocode,-1,0);//高清直播CODE
    recChanresult1 = recmetaData.getChanListByTypeId(biaoqingzhibocode,-1,0);//标清直播CODE
    recChanList=(ArrayList)recChanresult.get(1);
    recChanchannel1=(ArrayList)recChanresult1.get(1);


  	recChanList.addAll(recChanchannel1);//得到所有的
    int realSize = 0;
    realSize = recChanList.size();//频道个数
    HashMap chanInfo = new HashMap();
%>
    var channelNumList=new Array();
<% 
   for(int i=0; i<realSize; i++)
   {
	  chanInfo = (HashMap)recChanList.get(i);
	  Integer chanIndex = (Integer)chanInfo.get("CHANNELINDEX");//频道顺序号
	  chanIndex=chanIndex-1000;
%>
      channelNumList.push(<%=chanIndex%>);
<%
  }

%>
    var number = 0;
    function funcInputNum(i)
    {   
	    if(number==0) funcPlayChannel('');
	    if(number * 10 < 1000)
        {   
		    number = number * 10 + i;
        }
        showChannelNum(number);
        clearTimeout(timeID);
        timeID = setTimeout("funcPlayChannel("+ number +")", 3000);
    }
    
    //function playChannel(chanNum)
    function funcPlayChannel(chanNum)
    {        
	    if(containFun(channelNumList,chanNum)){
		    var tmpurl = "play_ControlChannel.jsp?&CHANNELNUM="+chanNum+"&COMEFROMFLAG=0&ISSUB=0&PREVIEWFLAG=0&returnurl="+escape(location.href);
		    window.location.href = tmpurl;    
		}
		else{
			showChannelNum("频道号不存在!");
			number=0;
			setTimeout("document.getElementById('topframe').innerHTML=''", 2000);
		}
    }
    
	function containFun(strArr,str)//过滤频道判断
	{	
		if(strArr!=null){
			for(var i=0;i<strArr.length;i++){
				 if(strArr[i]==str){
					 return true; 
				 }
			}
		}
		return false;
	}
	
    function showChannelNum(num)
    {
       document.getElementById("topframe").innerHTML=num;
	}
</script>
<div id="topframe" style="position:absolute;font-size:50px;left:650px;top:108px;width:200px;height:30px;z-index:2;color:#FFF;text-align:right;">
</div>
