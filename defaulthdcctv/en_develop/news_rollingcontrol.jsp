<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%> 
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<script language="javascript" type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript" src="js/EPGConstants.js"></script>
<script language="javascript" type="text/javascript">
var area0;
var area1;// poster
var area2;
var isFirstLoad = true;
var returnurl = '<%=request.getParameter("returnurl")%>';
<% 
	String typeId = request.getParameter("typeid")==null?"00000100000000090000000000001064":request.getParameter("typeid");
	List menu_result = (ArrayList)(new MetaData(request).getTypeListByTypeId(typeId,4,0));
	JSONArray jsonmenus = null; //左侧menu
	if(menu_result!=null&&menu_result.size()>1){
		List menucontents = (ArrayList)menu_result.get(1);
		jsonmenus = JSONArray.fromObject(menucontents);
	}
%>
var jMenus = eval('('+'<%=jsonmenus%>'+')'); //左侧菜单

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
	if(isFirstLoad)
	{
		area2.asyngetdata();
		isFirstLoad = false;
	}
}

function pagingNewsData(data,pageIndex,totalRecord,pageCount)
{
	area2.setpageturndata(data.length,pageCount);
	area2.datanum = data.length;
	for (var k = 0; k < area2.doms.length; k++) 
	{
		if (k >= data.length) 
		{
			area2.doms[k].updatecontent("");
		}
		 else
		 {
		 	var preFix = (parseInt(k) + 1) +".";
			area2.doms[k].setcontent(preFix,data[k].vodName,32);
		 	area2.doms[k].dataurlorparam = data[k].vodId;
		    var url = "au_PlayFilm.jsp?PROGID="+data[k].vodId+"&PLAYTYPE="+EPGConstants.PLAY_TYPE_VOD+"&CONTENTTYPE="+EPGConstants.CONTENT_TYPE_VOD_VIDEO +"&BUSINESSTYPE="+EPGConstants.BUSINESS_TYPE_VOD+"&returnurl="+escape(location.href);
		    area2.doms[k].mylink=url; 
		 }   
	}
	
}

function initPage()
{
	area0 = AreaCreator(4, 1, new Array(-1, -1, -1, 1), "news", "className:menuli on", "className:menuli");
	area0.setstaystyle("className:menuli current", 3);
	area0.setfocuscircle(0); 
	//area0.doms[0].mylink="news_rolling.jsp?returnurl="+returnurl;
	area0.doms[1].mylink="news_focus.jsp?returnurl="+escape(returnurl);
	area0.doms[2].mylink="news_column_name.jsp?returnurl="+escape(returnurl);
	area0.doms[3].mylink="news_ranking.jsp?returnurl="+escape(returnurl);
	area1 =  AreaCreator(10, 1, new Array(-1,0, -1, 2), "item", "className:d_li2 on", "className:d_li2");
	area1.setstaystyle("className:d_li2 current", 3);
	area1.setpageturnattention("catalogpageup","images/up.png","images/up_gray.png","catalogpagedown","images/down.png",	"images/down_gray.png");
	area1.asyngetdata=function()
	{
	
		 $('hidden_frame_item').src="news_rollingitempaging.jsp?pageIndex="+area1.curpage;
	}
	area1.setfocuscircle(0); 
	area2 = AreaCreator(10, 1, new Array(-1,1, -1, -1), "newslist", "className:p_li on", "className:p_li");
	area2.setpageturnattention("pageup","images/up.png","images/up_gray.png","pagedown","images/down.png",	"images/down_gray.png");
	var areaid=<%=request.getParameter("areaid")%>;
    var indexid=<%=request.getParameter("indexid")%>;
    areaid = areaid!=null?parseInt(areaid):0;
	indexid = indexid!=null?parseInt(indexid):0;
    pageobj = new PageObj(areaid!=null?parseInt(areaid):0,indexid!=null?parseInt(indexid):0, new Array(area0, area1,area2));
	area2.asyngetdata=function(typeId)
	{
		if(typeId == null || typeId == undefined)
			typeId = area1.doms[area1.curindex].dataurlorparam;
	
		 $('hidden_frame_news').src="news_rollingnewspaging.jsp?pageIndex="+area2.curpage+"&typeId=<%=typeId%>";
	}
	pageobj.backurl = unescape(returnurl);
	area1.dataarea=area2;
	//area2.asyngetdata();
	area1.asyngetdata();
	
}

</script>