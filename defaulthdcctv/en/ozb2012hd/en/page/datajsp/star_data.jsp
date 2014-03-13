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
	String typeid=request.getParameter("typeid")==null?"1":request.getParameter("typeid");
	String focObj ="";


	int vodid;
	int area1pagecount = 0;    //左侧栏目页数
	int area1pagesize = 12;     //左侧栏目每页数据量
	int area1curindex=0;       //左侧栏目当前位置
	int area1curpage=1;        //左侧栏目当前焦点
	int cur_area1_index=0;      //数组焦点
	int areaid=1;
	int indexid=0;
	Calendar calendar = Calendar.getInstance();
    String hour = ((Integer)calendar.get(Calendar.HOUR_OF_DAY)).toString();
    String minute = ((Integer)calendar.get(Calendar.MINUTE)).toString();
    minute = minute.length() < 2?"0"+minute :minute;
	String strcurdate=hour + ":"+minute;
	
	
	
	
	JSONArray jsonvodlist = null; //节目列表

	
	if(focstr!=null){
	    
		focObj = String.valueOf(getState(analyticFocStr(focstr),"1","curpage"));
		area1curpage = (focObj==null||focObj.equals("null"))?1:Integer.parseInt(focObj);
		focObj = String.valueOf(getState(analyticFocStr(focstr),"1","curindex"));
	    area1curindex = (focObj==null||focObj.equals("null"))?0:Integer.parseInt(focObj);
		cur_area1_index = (area1curpage-1)*area1pagesize+area1curindex;
		areaid=1;
		indexid=area1curindex;
		
	
	}
    typeid=Star_Hall;
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
			area1pagecount = (count-1)/area1pagesize+1;
			if(area1curindex>=count){
				area1curindex = count-1;
			}
			ArrayList tempList = new ArrayList();
			ArrayList vod_list = (ArrayList)vodlist.get(1);
			for(int i = 0;i<vod_list.size();i++){
				Object obj = vod_list.get(i);
				HashMap tempmap = new HashMap();
				String tmpvodid = ((HashMap)obj).get("VODID").toString();
				String tmpvodname = ((HashMap)obj).get("VODNAME").toString();
				HashMap postersMap = (HashMap)(((HashMap)obj).get("POSTERPATHS"));
		    	String picpath = ((HashMap)obj).get("PICPATH").toString();
			    String postpath = getPosterPath(postersMap,request,"absolute","1").toString();
				picpath = getPicPath(request,picpath);
			    tempmap.put("VODID",tmpvodid);	
				tempmap.put("VODNAME",tmpvodname);
				tempmap.put("POSTERPATHS",postpath);
			    tempmap.put("PICPATH",picpath);	
								
				if(i==cur_area1_index){
					vodid = Integer.parseInt(tmpvodid);
				}
				tempList.add(tempmap);
			}
			jsonvodlist = JSONArray.fromObject(tempList);
		}
		
	}
%>

var returnurl='<%=returnurl %>';

var area1pagecount = <%=area1pagecount %>;
var area1pagesize = <%=area1pagesize %>;
var area1curindex = <%=area1curindex %>;
var area1curpage = <%=area1curpage %>;
var strcurdate="<%=strcurdate%>";

var jsonvodlist = eval('('+'<%=jsonvodlist%>'+')');

var areaid=<%=areaid %>;
var	indexid=<%=indexid %>;
//绑定数据
function bindNavigatData(){
		var linkArrs = {"index":3};
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


//填充VOD
function bindVODData(itms) {
        area1.setpageturndata(itms.length, area1pagecount);
        for (i = 0; i < area1.doms.length; i++) {
            if (i < itms.length) {
				area1.doms[i].setcontent("",itms[i].VODNAME,12);
			    area1.doms[i].updateimg(itms[i].POSTERPATHS);
				area1.doms[i].youwanaobj = itms[i].VODID;
				if($('area1_list'+i).style.display=="none"){
					 $('area1_list'+i).style.display = "block";	
				}
				
		    }else{
                area1.doms[i].updatecontent("");
		    	$('area1_list'+i).style.display = "none";	
		        area1.doms[i].youwanaobj = "";
			    area1.doms[i].updateimg("#");
			}
		
        }
	area1curpage=area1.curpage;
    $('page').innerHTML = area1.curpage+"/"+(area1pagecount==undefined?1:area1pagecount)+"页";
}

</script>