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
	Integer vodid = request.getParameter("vodid")==null?1:Integer.parseInt(request.getParameter("vodid")); //子id
	MetaData metadata = new MetaData(request);
	String progid = "-2";
	int sitcom_num = request.getParameter("sitcomnum")==null?0:Integer.parseInt(request.getParameter("sitcomnum"));
	if(sitcom_num>0){
		sitcom_num -=1;
		List tempret = (ArrayList)metadata.getSitcomList(vodid.toString(),1,sitcom_num);
		if(tempret!=null){
			HashMap tmpmap= (HashMap)((ArrayList)tempret.get(1)).get(0);
			progid = tmpmap.get("VODID").toString();
		}
	}
	response.getWriter().print(progid);
%>
