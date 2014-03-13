<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ include file="datajsp/HD_experience_data.jsp"%>
<%@ include file = "../../keyboard_A2/keydefine.jsp" %>
<%@ include file="datajsp/codepage.jsp"%>
<%
    //页面跳转
       TurnPage turnPage = new TurnPage(request);  
    	String returnUrl = "";


	 if (request.getParameter("returnurl") != null && !"".equals(request.getParameter("returnurl")) && !"null".equals(request.getParameter("returnurl")))
    {
        returnUrl = request.getParameter("returnurl");
    }
    else
    {
        returnUrl = turnPage.go(-1);
	}
	String temp = "";
	temp = request.getParameter("TEMPLATENAME");
	int address = 1;
	if(null != temp && !"".equals(temp))
		address = Integer.parseInt(temp);
	else
		address = 0;
System.out.println("RETURNURL=="+returnUrl);

%>
      
    
<script type="text/javascript" src="js/pagecontrol.js"></script>
    <script type="text/javascript">
               	var area0,area1;
		var areaid = 0;
		var indexid = 0;
		var returnurl ="<%=returnUrl%>";			
	 	
		var address =<%=address%>;
/*
    Date 2013-11-25
    Author LS
    Description 高清体验区仅保留深圳卫视高清频道，注释掉其他频道

*/
        window.onload = function() {
        //    area0 = AreaCreator(1, 3, new Array(-1, -1, 1, -1), "channel_", "className:top channel_focus", "className:top");
            area0 = AreaCreator(1, 2, new Array(-1, -1, 1, -1), "channel_", "className:top channel_focus", "className:top");
	//    area0.doms[0].mylink="play_ControlChannel.jsp?CHANNELNUM=<%="201"%>&COMEFROMFLAG=1&ISSUB=1&returnurl="+escape(location.href);
           //深圳卫视置于0号位
	    area0.doms[0].mylink="play_ControlChannel.jsp?CHANNELNUM=<%="202"%>&COMEFROMFLAG=1&ISSUB=1&returnurl="+escape(location.href);
		area0.doms[1].mylink="play_ControlChannel.jsp?CHANNELNUM=<%="207"%>&COMEFROMFLAG=1&ISSUB=1&returnurl="+escape(location.href);
	//    area0.doms[2].mylink="play_ControlChannel.jsp?CHANNELNUM=<%="221"%>&COMEFROMFLAG=1&ISSUB=1&returnurl="+escape(location.href);
	    area1 = AreaCreator(2, 4, new Array(0, -1, -1, -1), new Array("area1_pic_","e_name_"), "className:item item_focus", "className:item");
	    for(i=0;i<8;i++)
	   	       area1.doms[i].imgdom=$('area1_img_'+i);
	    pageobj = new PageObj(areaid,indexid, new Array(area0, area1));
	if(address == 1 )
	{
		 getdata(list);

		pageobj.backurl = '../../defaultgd/en/'+'<%=turnPage.getLast()%>';
	}else if(address == 0)
	{
	getdata2(list);
	 pageobj.backurl = returnurl;

	}
}

function getdata(data)
{

	for(i = 0; i < 8;i++)
	{
		if(i<8)
		{
			area1.doms[i].updateimg(data[i].POSTERPATHS.type0[0]!=undefined?data[i].POSTERPATHS.type0[0]:(data[i].PICPATH!=undefined?data[i].PICPATH:'images/no_picture_259x165.jpg'));
			area1.doms[i].mylink ="../../defaultgd/en/IPTVseriesListDetail_szgd.jsp?TYPE_ID=" + "10000100000000090000000000029090"+"&FILM_ID="+data[i].VODID+"&PREFOUCS=,play";
		}
			else
			 area1.doms[i].updateimg("#");
					    
	}



}




function getdata2(data)
{
        for(i = 0; i < 8;i++)
        {
                if(i<8)
                {
                        area1.doms[i].updateimg(data[i].POSTERPATHS.type0[0]!=undefined?data[i].POSTERPATHS.type0[0]:(data[i].PICPATH!=undefined?data[i].PICPATH:'images/no_picture_259x165.jpg'));
		//	 area1.doms[i].mylink = "vod_turnpager.jsp?vodid="+data[i].VODID+"&typeid="+"10000100000000090000000000029090"+"&returnurl="+escape(returnurl); 
                  	area1.doms[i].mylink = "vod_turnpager.jsp?vodid="+data[i].VODID+"&typeid="+"10000100000000090000000000029090"+"&returnurl="+escape(returnurl);              
                }else
                         area1.doms[i].updateimg("#");

        }



}




</script>
