<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="java.util.*"%>
<%
	String epgPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/EPG/jsp/";
	String svodid = request.getParameter("vodid")==null?"":request.getParameter("vodid").toString();
	int vodid = Integer.parseInt(svodid);
	String returnurl = request.getParameter("returnurl")!=null?request.getParameter("returnurl"):"index.jsp";
	String typeid = request.getParameter("typeid")==null?"":request.getParameter("typeid").toString();
	
	ServiceHelp serviceHelp = new ServiceHelp(request);
	MetaData metadata = new MetaData(request);
		
	HashMap tempMap = new HashMap();
	ArrayList tempList = new ArrayList();
	JSONArray datalist = null;	
	
	String tempvodname = "";
	String tempdirector = "";
	String tempactor = "";
	String tempvodprice = "";
	String tempintroduce = "";
	
	HashMap typeMap = (HashMap)metadata.getTypeInfoByTypeId(typeid);
	String typeName = "";
	if(typeMap!=null){
		typeName = typeMap.get("TYPENAME").toString();
	}
	
	HashMap detailMap =  (HashMap)metadata.getVodDetailInfo(vodid);
	if(detailMap.get("VODNAME")!=null){
			tempvodname = detailMap.get("VODNAME").toString();
	}
	if(detailMap.get("DIRECTOR")!=null)
		tempdirector = detailMap.get("DIRECTOR").toString();
	if(detailMap.get("CASTMAP")!=null){
		HashMap castMap = (HashMap)detailMap.get("CASTMAP");
		if(castMap!=null&&castMap.get(6)!=null){
			String[] tempCasts = (String[])castMap.get(6);
			StringBuffer actor = new StringBuffer();
			if(tempCasts.length>0){
				for(String str : tempCasts){
					actor.append("  "+str.trim());
				}
				tempMap.put("ACTOR",actor.toString().substring(1));
			}
		}
	}
	if(detailMap.get("VODPRICE")!=null)
		tempvodprice = detailMap.get("VODPRICE").toString();
	if(detailMap.get("INTRODUCE")!=null)
		tempintroduce = detailMap.get("INTRODUCE").toString();
	int contenttype = Integer.parseInt(detailMap.get("CONTENTTYPE").toString());
	HashMap posterMap = (HashMap)(detailMap.get("POSTERPATHS"));
	String picUrl = "";
	if(posterMap!=null){
		//0.ËõÂÔÍ¼1.º£±¨2.¾çÕÕ3.Í¼±ê4.±êÌâÍ¼5.¹ã¸æÍ¼6.²İÍ¼7.±³¾°9.ÆµµÀÍ¼99.ÆäËû
		picUrl = "../../"+getPosterPath(posterMap,"images/display/vod/poster_no_pic.jpg","1",request);
	}
	
	tempMap.put("VODNAME",tempvodname);
	tempMap.put("DIRECTOR",tempdirector);
	tempMap.put("VODPRICE",tempvodprice);
	tempMap.put("INTRODUCE",tempintroduce);
	tempMap.put("PICURL",picUrl);
	tempMap.put("CONTENTTYPE",contenttype);
	tempList.add(tempMap);
	datalist= JSONArray.fromObject(tempList);

%>
<script type="text/javascript">
	var typeName = '<%=typeName%>';
	var returnurl = unescape('<%=returnurl%>');
	var datalist = <%=datalist%>;
</script>