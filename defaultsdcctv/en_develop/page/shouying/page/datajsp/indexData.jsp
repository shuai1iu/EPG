<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray"%>
<%@ page import="net.sf.json.JSONObject"%>
<script>
var reYinData;
var renQiData;
var tuiJianDate;
<%
JSONArray jsonvodlist = null; //节目列表
JSONArray renqijsonvodlist = null; //节目列表
JSONArray tuijianjsonvodlist = null; //节目列表
String postertype = "1";
String tuijianpostertype = "5";
int pagesize=3;
int reqipagesize=2;
int stratPosition = request.getParameter("stratPosition")==null?0:Integer.parseInt(request.getParameter("stratPosition"));
//String typeid= request.getParameter("typeid")==null?"-1":request.getParameter("typeid");
MetaData metadata = new MetaData(request);
ServiceHelp serviceHelpxx = new ServiceHelp(request);
ArrayList vodlist = (ArrayList)metadata.getVodListByTypeId(shouyereying,pagesize,stratPosition);
ArrayList tempList = new ArrayList();
ArrayList vod_list = new ArrayList();
if(vodlist!=null && vodlist.size() > 1 && ((ArrayList)vodlist.get(1)).size() > 0)
{
	vod_list = (ArrayList)vodlist.get(1);
}
for(int i = 0;i<vod_list.size();i++)
{
	Object obj = vod_list.get(i);
	HashMap tempmap = new HashMap();
	String tmpvodid = ((HashMap)obj).get("VODID").toString();
	String tmpvodname = ((HashMap)obj).get("VODNAME").toString();
	tempmap.put("VODID",tmpvodid);
	tempmap.put("VODNAME",tmpvodname);
	//海报信息
	HashMap postersMap = (HashMap)(((HashMap)obj).get("POSTERPATHS"));
	String picpath = (String)((HashMap)obj).get("PICPATH");
	String postpath =  getPosterPath(postersMap,request,picpath,postertype).toString();
	tempmap.put("POSTERPATHS","../"+postpath);
	tempList.add(tempmap);
}



ArrayList reqivodlist = (ArrayList)metadata.getVodListByTypeId(shouyerenqi,reqipagesize,stratPosition);
ArrayList reqitempList = new ArrayList();
ArrayList reqivod_list = new ArrayList();
if(reqivodlist!=null && reqivodlist.size() > 1 && ((ArrayList)reqivodlist.get(1)).size() > 0)
{
	reqivod_list = (ArrayList)reqivodlist.get(1);
}
for(int i = 0;i<reqivod_list.size();i++)
{
	Object obj = reqivod_list.get(i);
	HashMap tempmap = new HashMap();
	String tmpvodid = ((HashMap)obj).get("VODID").toString();
	String tmpvodname = ((HashMap)obj).get("VODNAME").toString();
	tempmap.put("VODID",tmpvodid);
	tempmap.put("VODNAME",tmpvodname);
	//海报信息
	HashMap postersMap = (HashMap)(((HashMap)obj).get("POSTERPATHS"));
	String picpath = (String)((HashMap)obj).get("PICPATH");
	String postpath =  getPosterPath(postersMap,request,picpath,postertype).toString();
	tempmap.put("POSTERPATHS","../"+postpath);
	reqitempList.add(tempmap);
}


ArrayList tuijianvodlist = (ArrayList)metadata.getVasListByTypeId(shouyetuijian,reqipagesize,stratPosition);
ArrayList tuijiantempList = new ArrayList();
ArrayList tuijianvod_list = new ArrayList();
if(tuijianvodlist!=null && tuijianvodlist.size() > 1 && ((ArrayList)tuijianvodlist.get(1)).size() > 0)
{
	tuijianvod_list = (ArrayList)tuijianvodlist.get(1);
}
for(int i = 0;i<tuijianvod_list.size();i++)
{
	HashMap obj = (HashMap)tuijianvod_list.get(i);
	HashMap tempmap = new HashMap();
	int tmpvodid=(Integer)obj.get("VASID");
	String tmpvodname = obj.get("VASNAME").toString();
	tempmap.put("VASID",tmpvodid);
	tempmap.put("VASNAME",tmpvodname);
	//海报信息
	/*HashMap postersMap = (HashMap)obj.get("POSTERPATHS");
	String picpath = (String)obj.get("PICPATH");
	String postpath =  getPosterPath(postersMap,request,picpath,tuijianpostertype).toString();
	tempmap.put("POSTERPATHS","../"+postpath);
	tuijiantempList.add(tempmap);*/
	String vasurl=serviceHelpxx.getVasUrl(tmpvodid);
	Map mapindex = metadata.getVasDetailInfo(tmpvodid);
	HashMap postersMap = (HashMap)mapindex.get("POSTERPATHS");
	String picpath = (String)mapindex.get("POSTERPATH");
	String postpath =  getPosterPath(postersMap,request,picpath,"5").toString();
	tempmap.put("VARSURL",vasurl);
	tempmap.put("POSTERPATHS","../"+postpath);
	tuijiantempList.add(tempmap);
}

jsonvodlist = JSONArray.fromObject(tempList);
renqijsonvodlist = JSONArray.fromObject(reqitempList);
tuijianjsonvodlist = JSONArray.fromObject(tuijiantempList);
%>
reYinData=<%=jsonvodlist%>;
renQiData=<%=renqijsonvodlist%>;
tuiJianDate=<%=tuijianjsonvodlist%>;
</script>
