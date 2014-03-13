<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%> 
<script language="javascript" type="text/javascript" src="js/pagecontrol.js"></script>
<script language="javascript" type="text/javascript">
var area0;
var area1;// poster
var area2;
function pagingItemData(data,pageIndex,totalRecord,pageCount)
{
	area1.setpageturndata(data.length,pageCount);
	area1.datanum = data.length;
	for (var k = 0; k < area1.doms.length; k++) 
	{
		if (k >= data.length) 
		{
			area1.doms[k].updatecontent("");
		}
		 else
		 {
		 	area1.doms[k].updatecontent(data[k].typeName);
		 	area1.doms[k].dataurlorparam = data[k].typeId;
		 }   
	}
}

function pagingNewsData(jsNewsList,pageIndex,totalRecord,pageCoun)
{
}

function initPage()
{
	area0 = AreaCreator(4, 1, new Array(-1, -1, -1, 1), "news", "className:menuli on", "className:menuli");
	area0.setstaystyle("className:menuli current", 0);
	area0.setfocuscircle(0); 
	area0.doms[0].mylink="news_rolling.jsp";
	area0.doms[3].mylink="news_ranking.jsp";
	area1 =  AreaCreator(10, 1, new Array(-1,0, -1, 2), "item", "className:d_li2 current", "className:d_li2e");
	area1.setstaystyle("className:d_li2 current", 0);
	area1.asyngetdata=function()
	{
	
		 $('hidden_frame_item').src="news_rollingitempaging.jsp?pageIndex="+area1.curpage;
	}
	area2 = AreaCreator(10, 1, new Array(-1,1, -1, -1), "newslist", "className:p_li on", "className:p_li");
	area2.setpageturnattention("pageup","images/up.png","images/up_gray.png","pagedown","images/down.png",	"images/down_gray.png");
	var areaid=<%=request.getParameter("areaid")%>;
    var indexid=<%=request.getParameter("indexid")%>;
    areaid = areaid!=null?parseInt(areaid):0;
	indexid = indexid!=null?parseInt(indexid):0;
    pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area0, area1,area2));
	area2.asyngetdata=function()
	{
	
		 $('hidden_frame_news').src="news_rollingnewspaging.jsp?pageIndex="+area2.curpage;
	}
	//area2.asyngetdata();
	area1.asyngetdata();
}

</script>