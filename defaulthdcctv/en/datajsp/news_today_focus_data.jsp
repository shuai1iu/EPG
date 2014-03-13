<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<html>
<head>
<script>
<%
	String typeId =request.getParameter("typeid")!=null?"00000100000000090000000000001247":request.getParameter("typeid"); //00000100000000090000000000001261 测试
	String returnurl = request.getParameter("returnurl")==null?"news_column_name.jsp":request.getParameter("returnurl");
	int curpage = request.getParameter("curpage")!=null?Integer.parseInt(request.getParameter("curpage")):1; //页码
	int curindex = request.getParameter("curindex")==null?0:Integer.parseInt(request.getParameter("curindex")); //当前下标
	String vodId = "0";
	
	MetaData metadata = new MetaData(request);
	int pagesize = 11;                 //最大显示个数		
	int pagestart = (curpage-1)*pagesize;  //开始取数据的下标	
	int counttotal = 0;                //条目总数
	int pagecount = 0;                 //总页数 
	JSONArray jFilms = null;           //列表
	JSONObject jContent = null;            //内容
	//是翻页的情况下
	if(typeId!=null){
		List contentList = metadata.getVodListByTypeId(typeId,pagesize,pagestart);
		if(contentList!=null&&contentList.size()>=2){			
			counttotal = Integer.parseInt(((HashMap)contentList.get(0)).get("COUNTTOTAL").toString()); //总数
			pagecount = (counttotal-1)/pagesize +1; //获取总页数
			jFilms = JSONArray.fromObject((ArrayList)contentList.get(1));
			List templist = (ArrayList)contentList.get(1);
			if(curindex>=templist.size()){
				curindex=templist.size();
			}
			HashMap contentmap =  (HashMap)templist.get(curindex);
			vodId = contentmap.get("VODID").toString();
		}
	}
	//获取内容
		HashMap mediadetailInfo = (HashMap)metadata.getVodDetailInfo(Integer.parseInt(vodId));	
        jContent = JSONObject.fromObject(mediadetailInfo);
%>

	var curpage = <%=curpage%>;
	var pagecount = <%=pagecount%>;
	var returnurl = '<%=returnurl %>';
	var jsonNews = eval('('+'<%=jFilms%>'+')');
	var jsonContent  = eval('('+'<%=jContent%>'+')');
	var pagesize = <%=pagesize %>;
	function bindData(items) {
           //初始化第一页
		   if(items==undefined){
		   		//window.alert("空");
				return;
		   }
		   area1.setpageturndata(items.length,pagecount);
		   	for(var i = 0;i<pagesize;i++){
				if(i<items.length){
					area1.doms[i].setcontent("",items[i].VODNAME,29,true,false);
					area1.doms[i].youwanauseobj = items[i].VODID;  
				}else{
					area1.doms[i].updatecontent("");
					area1.doms[i].youwanauseobj = undefined;
				}
			}
        }
		
	function bindContent(itm){
		if(itm=null)itm = jsonContent;
            $('content_dct').innerHTML="<b>主持：</b>"+((itm.DIRECTOR==undefined||jsonmediaInfo.DIRECTOR=="null")?"暂无":itm.DIRECTOR);
			$('content_act').innerHTML="<b>嘉宾：</b>"+((itm.ACTOR==undefined||jsonmediaInfo.ACTOR=="null")?"暂无":itm.ACTOR);
			$('content_itd').innerHTML=(itm.INTRODUCE==undefined||itm.INTRODUCE=="null")?"暂无简介":itm.INTRODUCE;
			$('content_pst').src = itm.PICPATH;
	}
</script>
</head>
<body>
</body>
</html>