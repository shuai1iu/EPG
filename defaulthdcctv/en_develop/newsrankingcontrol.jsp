<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%> 
<script language="javascript" type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript" src="js/EPGConstants.js"></script>
<script language="javascript" type="text/javascript">
var area0;
var area1;// poster
var area2;
var returnurl = '<%=request.getParameter("returnurl")%>';
function pagingData(data,pageIndex,totalRecord,pageCount)
{
	area2.datanum = data.length;
	area2.setpageturndata(jsNewsList.length,parseInt(pageCount));
	for(var i=0;i<area2.doms.length;i++)
	{
			 if(i<data.length)
			 {
				var preFix = (parseInt(i) + 1) +".";
				area2.doms[i].setcontent(preFix,data[i].VodName,32);
			    var url = "au_PlayFilm.jsp?PROGID="+data[i].VodId+"&PLAYTYPE="+EPGConstants.PLAY_TYPE_VOD+"&CONTENTTYPE="+EPGConstants.CONTENT_TYPE_VOD_VIDEO +"&BUSINESSTYPE="+EPGConstants.BUSINESS_TYPE_VOD+"&returnurl="+escape(location.href);
		    	area2.doms[i].mylink=url; 
			 }
			 else
			     area2.doms[i].updatecontent("");
		 }
		 document.getElementById('page').innerHTML = area2.curpage+"/"+pageCount;
}


function initPage()
{
	
    area0 = AreaCreator(4, 1, new Array(-1, -1, -1, 1), "news", "className:menuli on", "className:menuli");
	area0.setstaystyle("className:menuli current", 0);
	area0.setfocuscircle(0); 
	area0.doms[0].mylink="news_rolling.jsp?returnurl="+escape(returnurl);
	area0.doms[1].mylink="news_focus.jsp?returnurl="+escape(returnurl);
	area0.doms[2].mylink="news_column_name.jsp?returnurl="+escape(returnurl);
	//area0.doms[3].mylink="news_ranking.jsp?returnurl="+returnurl;

	area1 =  AreaCreator(3, 1, new Array(-1,0, -1, 2), "pic", "className:bgon", "className:bg");
	area2 = AreaCreator(10, 1, new Array(-1,1, -1, -1), "newslist", "className:p_li on", "className:p_li");
	
	area2.setpageturnattention("pageup","images/up.png","images/up_gray.png","pagedown","images/down.png","images/down_gray.png");
	area2.setcrossturnpage();
	var areaid=<%=request.getParameter("areaid")%>;
    var indexid=<%=request.getParameter("indexid")%>;
    areaid = areaid!=null?parseInt(areaid):0;
	indexid = indexid!=null?parseInt(indexid):3;
    pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area0, area1,area2));
	pageobj.backurl = unescape(returnurl);
	area2.asyngetdata=function()
	{
	
		 $('hidden_frame').src="newsrankingpaging.jsp?pageIndex="+area2.curpage;
	}
	area2.asyngetdata();
}
</script>
