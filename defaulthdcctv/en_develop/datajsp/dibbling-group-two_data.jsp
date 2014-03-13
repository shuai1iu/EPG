<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>

<script type="text/javascript">
<% 
    
	MetaData metadata = new MetaData(request);
	String postertype = "0";
	String returnurl = request.getParameter("returnurl")==null?"index.jsp?back=1":request.getParameter("returnurl");
	String typeid=request.getParameter("catacode")==null?"1":request.getParameter("catacode");
	String focObj ="";
	String typenum=request.getParameter("typenum")==null?"4":request.getParameter("typenum");
	String topicInfo = "";  //topic info by SZMG; it contains the topic's line/row/pictures/links informations.

	int vodid;
	int area2pagecount = 0;    //左侧栏目页数
	int area2pagesize = 24;     //左侧栏目每页数据量
	int area2curindex=0;       //左侧栏目当前位置
	int area2curpage=1;        //左侧栏目当前焦点
	int cur_area2_index=0;      //数组焦点
	int areaid=3;
	int indexid=0;
		
	JSONArray jsonvodlist = null; //节目列表

	ArrayList vod_list=new ArrayList();
	
	HashMap second_ptypemap = (HashMap)metadata.getTypeInfoByTypeId(typeid); 
	String picTypePath = "";
	if(second_ptypemap != null)
	{
		HashMap posterPathTypeMap = (HashMap)second_ptypemap.get("POSTERPATHS");
		picTypePath = getPosterPath(posterPathTypeMap,request,"absolute","3").toString();
	}
	
	//获取VOD内容列表
	int isSubTypeOrContent = metadata.getSubTypeOrContent(typeid);
	if(isSubTypeOrContent==1){
%>
		location.href = "vod_turnpager.jsp?typeid=<%=typeid %>&returnurl="+escape('<%=returnurl %>');
<%
	}else if(isSubTypeOrContent==0){
		ArrayList vodlist = (ArrayList)metadata.getVodListByTypeId(typeid,-1,0);
		if(vodlist!=null && vodlist.size() > 1 && ((ArrayList)vodlist.get(1)).size() > 0){
			int count = ((Integer)((HashMap)vodlist.get(0)).get("COUNTTOTAL")).intValue(); //总数量
			area2pagecount = (count-1)/area2pagesize+1;
			if(area2curindex>=count){
				area2curindex = count-1;
			}
			ArrayList tempList = new ArrayList();
		    	vod_list = (ArrayList)vodlist.get(1);
			for(int i = 1;i<vod_list.size();i++){              //i=1 begin from the second.
				Object obj = vod_list.get(i);
				HashMap tempmap = new HashMap();
				String tmpvodid = ((HashMap)obj).get("VODID").toString();
				String tmpvodname =(i+1)+".&nbsp;" +((HashMap)obj).get("VODNAME").toString();
				
				tempmap.put("VODID",tmpvodid);	
				tempmap.put("VODNAME",tmpvodname);
								
				if(i==cur_area2_index){
					vodid = Integer.parseInt(tmpvodid);
				}
				tempList.add(tempmap);
			}
			jsonvodlist = JSONArray.fromObject(tempList);
			
			Object TopicInfoObj = vod_list.get(0);
			topicInfo = ((HashMap)TopicInfoObj).get("INTRODUCE").toString();
		}
		
	}
	
	if(vod_list.size()==0){
		    ArrayList tempList1 = new ArrayList();
			HashMap tempmap1 = new HashMap();
			tempmap1.put("VODID",-1);	
			tempmap1.put("VODNAME","暂无内容");
			tempmap1.put("POSTERPATHS","");
			tempmap1.put("PICPATH","");	
			tempList1.add(tempmap1);
			jsonvodlist = JSONArray.fromObject(tempList1);
		    area2pagecount=1;
	}
%>

var returnurl='<%=returnurl %>';
var area2pagecount = <%=area2pagecount %>;
var area2pagesize = <%=area2pagesize %>;
var area2curindex = <%=area2curindex %>;
var area2curpage = <%=area2curpage %>;
var picTypePath="<%=picTypePath%>";
var jsonvodlist = eval('('+'<%=jsonvodlist%>'+')');

var areaid=<%=areaid %>;
var indexid=<%=indexid %>;
var typenum="<%=typenum%>";
var topicInfo="<%=topicInfo%>";

</script>
