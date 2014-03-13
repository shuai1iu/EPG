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
<script>
<%
	 String returnurl = request.getParameter("returnurl")==null?"../../../../defaultsdcctv/en/page/index.jsp":request.getParameter("returnurl");
	 String keyword = request.getParameter("keyword");
	 String hotkeyword = request.getParameter("hotkeyword");
	 MetaData metadata = new MetaData(request);
	 
	 JSONArray jsonHotkeywords = null;  //热词
	 JSONArray jsonSearchResult = null; //搜索结果
	 int resultpagecount = 1;
	 int pagesize = 6;
	 int isSubVod = 1;
	 
	 //获取热词
	 ArrayList hotkey_list = (ArrayList)metadata.getTypeListByTypeId(Index_Hotkey,4,0);
	 if(hotkey_list!=null&&hotkey_list.size()>1){
		 ArrayList hotkey_resultlist = (ArrayList)hotkey_list.get(1);
		if(hotkey_resultlist!=null){
			 for(int i =0,l=hotkey_resultlist.size();i<l;i++){
				 HashMap tempMap = new HashMap();
				 String typeName = ((HashMap)hotkey_resultlist.get(i)).get("TYPE_NAME").toString().trim();
				 String introduce = ((HashMap)hotkey_resultlist.get(i)).get("TYPE_INTRODUCE").toString().trim();
				 tempMap.put("TYPE_NAME",typeName);
				 tempMap.put("TYPE_INTRODUCE",introduce);
				 hotkey_resultlist.set(i,tempMap);
			 }
			 jsonHotkeywords = JSONArray.fromObject(hotkey_resultlist);
		 }	 
	 }
	 
	 if(keyword!=null){
		ServiceHelp svcHelp = new ServiceHelp(request);
	 	List searchlist = svcHelp.searchFilmsByCode(keyword,0,-1,isSubVod);
		if(searchlist!=null&&searchlist.size()>1){
			int count = ((Integer)((HashMap)searchlist.get(0)).get("COUNTTOTAL")).intValue(); //总数量
	    	resultpagecount = (count-1)/pagesize+1;
			ArrayList searchresultlist = (ArrayList)searchlist.get(1);
			if(searchresultlist!=null){
				ArrayList tempSearchresult = new ArrayList();
				for(int i=0,l=searchresultlist.size();i<l;i++){
					HashMap tempMap = new HashMap();
					tempMap.put("vodName",((HashMap)searchresultlist.get(i)).get("vodName"));
					tempMap.put("vodId",((HashMap)searchresultlist.get(i)).get("vodId"));
					tempSearchresult.add(tempMap);
				}
				jsonSearchResult = JSONArray.fromObject(tempSearchresult);
			}else{
				resultpagecount = 1;
			}
		}
	 }
%>
var curPage = '<%=tmpcurpageName %>';
var resultpagecount = <%= resultpagecount%>;
var jHotkeywords = <%=jsonHotkeywords %>; //热词
var jSearchResult = <%=jsonSearchResult %>; //热词
var returnurl = '<%=returnurl %>';
var keyword='<%=keyword==null?"CNTVOZB":keyword %>',hotkeyword='<%=hotkeyword==null?"":hotkeyword %>';

//填充导航栏链接
function bindNavigatData(){
	var linkArrs = {"search":5};
	area0.doms[0].mylink = "index.jsp";
	if(true){
		area0.doms[1].mylink = "group-match.jsp";
	}else{
		area0.doms[1].mylink = "knockout.jsp";
	}
	area0.doms[2].mylink = "video.jsp";
	area0.doms[3].mylink = "star.jsp";
	area0.doms[4].mylink = "top-scorer.jsp";
	area0.doms[5].mylink = "search.jsp";
	area0.doms[linkArrs[curPage]].mylink = undefined;
}

//填充左侧热词
function bindHotKeyWordsData(itms){
	if(itms!=undefined&&itms!="null"){
		area1.datanum = (itms.length > area1.doms.length)?area1.doms.length:itms.length;
		for(var i=0,l=area1.doms.length,dl=itms.length;i<l;i++){
			if(i<dl){
				area1.doms[i].setcontent("",itms[i].TYPE_NAME,8,false,true);
				area1.doms[i].youwanauseobj = "CNTVOZB"+itms[i].TYPE_INTRODUCE;
			}else{
				area1.doms[i].mylink = "";
			}
		}
	}else{
		area1.datanum = 0;
	}
	$('hotkeyword').innerHTML = hotkeyword;
}

function bindSearchResultData(itms){
	if(itms!=undefined&&itms!="null"){
		area7.setpageturndata(itms.length,resultpagecount);
		for(var i=0,l=area7.doms.length,dl=itms.length;i<l;i++){
			if(i<dl){
				area7.doms[i].setcontent("",(i+1)+"."+itms[i].vodName,59);
				area7.doms[i].mylink = "vod_turnpager.jsp?vodid="+itms[i].vodId+"&returnurl="+escape("search.jsp?keyword="+keyword+"&hotkeyword="+hotkeyword+"&returnurl="+returnurl);
			}else{
				area7.doms[i].updatecontent("");
				area7.doms[i].mylink = "";
			}
		}
		$('result_page').innerHTML = area7.curpage+"/"+(resultpagecount==undefined?1:resultpagecount)+"页";
	}else{
		area7.datanum = 0;
		$('result_page').innerHTML = "1/1页";
	}
}
</script>