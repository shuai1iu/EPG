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
	//String[] allTypeId 父栏目ID
	Integer vodId = request.getParameter("vodid")==null?1:Integer.parseInt(request.getParameter("vodid"));
	int pagesize = 36;
	int curpage = request.getParameter("curpage")!=null?Integer.parseInt(request.getParameter("curpage")):1; //页码
	int pagestart = (curpage-1)*pagesize;	
	
	MetaData metadata = new MetaData(request);
	JSONArray jSitcoms = null;
	int retcount = 0;
	int tmpint = -1;
	
	List sitcom_ret = (ArrayList)metadata.getSitcomList(vodId.toString(),pagesize,pagestart);
	if(sitcom_ret!=null){
		HashMap tmpmap = (HashMap)sitcom_ret.get(0);
		int retcode = Integer.parseInt(tmpmap.get("RETCODE").toString());
		retcount = Integer.parseInt(tmpmap.get("COUNTTOTAL").toString());
		if(retcode==0){
			retcode = -1;
			List tempList = (ArrayList)sitcom_ret.get(1);
			if(tempList!=null&&tempList.size()!=0){
				jSitcoms = JSONArray.fromObject(tempList);	
			}
		}
	}
	
	response.getWriter().print(jSitcoms);
%>	