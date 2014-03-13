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
<%
	String keyword = new String(request.getParameter("keyword").getBytes("ISO-8859-1"),"UTF-8");//关键字
	Integer curpage = request.getParameter("curpage")!=null?Integer.parseInt(request.getParameter("curpage")):1; //页码
	Integer pagesize = 12;	//最大显示个数	
	Integer pagestart = (curpage-1)*pagesize;  //开始取数据的下
	Integer counttotal = 0;                //条目总数
	Integer pagecount = 0;
		JSONArray jFilms = null;           //数据转化为JSON
		ServiceHelp svcHelp = new ServiceHelp(request);
		int isSubVod = 1;
		List resultlist = svcHelp.searchFilmsByCode(keyword,pagestart,pagesize,isSubVod);
		if(resultlist!=null){
			counttotal = Integer.parseInt(((HashMap)resultlist.get(0)).get("COUNTTOTAL").toString()); //总数
			pagecount = (counttotal-1)/pagesize +1; //获取总页数
			ArrayList newList = new ArrayList();
			ArrayList tempList = (ArrayList)resultlist.get(1);
			for(int i=0;i<tempList.size();i++){
				HashMap newmap = (HashMap)tempList.get(i);
				if(newmap!=null){
					newmap.put("vodName",newmap.get("vodName"));
					newmap.put("vodId",newmap.get("vodId"));
					newList.add(newmap);
				}
			}
			jFilms = JSONArray.fromObject(newList);
		}
	response.getWriter().print(jFilms);
%>