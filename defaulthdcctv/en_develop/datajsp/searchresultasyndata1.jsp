<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
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
    //ArrayList list=metaData.getVodListByTypeId(code,8,station); 
	//String title=metaData.getTypeNameByTypeId(code);
	int curpage= Integer.parseInt(request.getParameter("curpage"));
	ArrayList list=new ArrayList();
	HashMap<String,String> map=new HashMap<String,String>();
	map.put("COUNTTOTAL","50");
	list.add(map);
	ArrayList list1=new ArrayList();
	int size=0;
	if(50-(curpage-1)*11<11)
	 size=50-(curpage-1)*11;
	 else
	  size = 11;
	  String[] xx={"012  CCTV-12","013  CCTV-13","014  CCTV-14","015  CCTV-15","016  CCTV-NEWS","017  北京卫视","018  上海卫视","014  CCTV-14","019   湖南卫视","020  湖北卫视","020  浙江卫视"};
	for(int i=0;i<size;i++)
	{
		HashMap<String,String> map1=new HashMap<String,String>();
	    map1.put("name",xx[i]+((curpage*11)+i));
	    map1.put("sex",""+((curpage*11)+i));
	    list1.add(map1);
	}
	list.add(list1);
	HashMap hash=null;
	JSONArray jsonList=null;
	int pagecount=0;
	int count=0;
	if(list!=null)
	{
	 jsonList=JSONArray.fromObject(list.get(1));
	 hash=(HashMap)list.get(0);
	}
	if(hash!=null)
	{
	      count=Integer.parseInt(hash.get("COUNTTOTAL").toString());
	      pagecount=(count-1)/11+1;
	}
%>
    window.parent.getdata1(eval('('+'<%=jsonList%>'+')'),'<%=pagecount%>');
</script>
</head>
<body>
</body>
</html>