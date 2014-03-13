<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ include file="../util/util_getPosterPaths.jsp" %>
<%
	MetaData metadata = new MetaData(request);
	int area3curpage=1;
    String typeid = request.getParameter("typeid")==null?"":request.getParameter("typeid");	
  
	area3curpage=Integer.valueOf((request.getParameter("area3curpage")==null?"1":request.getParameter("area3curpage"))).intValue();	
	JSONArray jsonvodlist = null; //节目列表
	String postertype = "1";
	int area3pagecount=1;
	int area3pagesize=10;
	ArrayList vod_list=new ArrayList();
	
	ArrayList vodlist = (ArrayList)metadata.getVodListByTypeId(typeid,-1,0);
	if(vodlist!=null && vodlist.size() > 1 && ((ArrayList)vodlist.get(1)).size() > 0){
		int count = ((Integer)((HashMap)vodlist.get(0)).get("COUNTTOTAL")).intValue(); //总数量
	    area3pagecount = (count-1)/area3pagesize+1;
		ArrayList tempList = new ArrayList();
	    vod_list = (ArrayList)vodlist.get(1);
		for(int i = 0;i<vod_list.size();i++){
			Object obj = vod_list.get(i);
			HashMap tempmap = new HashMap();
			String tmpvodid = ((HashMap)obj).get("VODID").toString();
			String tmpvodname = ((HashMap)obj).get("VODNAME").toString();
			HashMap postersMap = (HashMap)(((HashMap)obj).get("POSTERPATHS"));
			String picpath = ((HashMap)obj).get("PICPATH").toString();
			String postpath =  getPosterPath(postersMap,request,"absolute",postertype).toString();
			picpath = getPicPath(request,picpath);
			tempmap.put("VODID",tmpvodid);	
			tempmap.put("VODNAME",tmpvodname);
			tempmap.put("POSTERPATHS",postpath);
			tempmap.put("PICPATH",picpath);	
			tempList.add(tempmap);
		}
		jsonvodlist = JSONArray.fromObject(tempList);
	}
	
	if(vod_list.size()==0){
		    ArrayList tempList1 = new ArrayList();
			HashMap tempmap1 = new HashMap();
			tempmap1.put("VODID",-1);	
			tempmap1.put("VODNAME","暂无内容");
			tempmap1.put("POSTERPATHS","");
			tempmap1.put("PICPATH","../images/nopicgq.jpg");	
			tempList1.add(tempmap1);
			jsonvodlist = JSONArray.fromObject(tempList1);
		    area3pagecount=1;
	}
   response.getWriter().print("{jsonvodlist:"+jsonvodlist+",jsonpage:"+area3pagecount+"}");
%>	
