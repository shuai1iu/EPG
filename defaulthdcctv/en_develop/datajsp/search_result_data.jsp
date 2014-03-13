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
var pagenum = 0;
var pagecount = 1;
var keyword = "";
var fcontent = new Array();
	<%
	String keyword = new String(request.getParameter("keyword").getBytes("ISO-8859-1"),"UTF-8");//关键字
	int pagenum = request.getParameter("pagenum")!=null?Integer.parseInt(request.getParameter("pagenum")):1; //页码
	//SEARCHCODE 搜索码
	MetaData meta = new MetaData(request);
		int pagesize = 12;                 //最大显示个数		
		int pagestart = (pagenum-1)*pagesize;  //开始取数据的下标	
		int isSubVod = 1;				   //是否包含子集（0.包含,1.不包含）
		int counttotal = 0;                //条目总数
		int pagecount = 0;
		JSONArray jFilms = null;           //数据转化为JSON
		ServiceHelp svcHelp = new ServiceHelp(request);
		List resultlist = svcHelp.searchFilmsByCode(keyword,0,-1,isSubVod);
		if(resultlist!=null){
			counttotal = Integer.parseInt(((HashMap)resultlist.get(0)).get("COUNTTOTAL").toString()); //总数
			pagecount = (counttotal-1)/pagesize +1; //获取总页数
			ArrayList newList = new ArrayList();
			ArrayList tempList = (ArrayList)resultlist.get(1);
			for(int i=0;i<tempList.size();i++){
				HashMap newmap = (HashMap)tempList.get(i);
				if(newmap!=null){
	%>
				var newObj = {};
				newObj.vodName = '<%=newmap.get("vodName").toString() %>';
				newObj.vodId = '<%=newmap.get("vodId").toString() %>';
				fcontent.push(newObj);
	<%
				}
			}
		}
	%>
	counttotal = <%=counttotal%>;
	pagenum = <%=pagenum%>;
	pagecount = <%=pagecount%>;
	area0.pagecount = pagecount;
	keyword = "<%=keyword%>";	
	
	function setData(itms){
		if(area0.curindex>itms.length-1){
			area0.changefocus(area0.curindex,false);
			area0.changefocus(itms.length-1,true);
		}
		if(itms.length==undefined||itms.length==0){
			//若为空
			area0.datanum = 0;
			area0.doms[0].updatecontent("未搜索到影片内容");
			area0.changefocus(0,false);
		}else{
			area0.setpageturndata(itms.length, pagecount);
			for(var i =0;i<area0.doms.length;i++){
				if(i<area0.datanum){
					area0.doms[i].setcontent("",itms[i].vodName,45,true);
					area0.doms[i].mylink = "vod_turnpager.jsp?vodid="+itms[i].vodId+"&returnurl="+escape(location.href);				
				}else{
					area0.doms[i].updatecontent("");
					area0.doms[i].mylink = "";
				}
			}			
		}		
	}
</script>