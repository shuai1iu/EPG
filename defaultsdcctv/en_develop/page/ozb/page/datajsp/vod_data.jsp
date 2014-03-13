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
	String typeid="";
	String focObj ="";
	int vodid;
	int area1pagecount = 0;    //左侧栏目页数
	int area1pagesize = 8;     //左侧栏目每页数据量
	int area1curindex=0;       //左侧栏目当前位置
	int area1curpage=1;        //左侧栏目当前焦点
	int cur_area1_index=0;      //数组焦点
	int areaid=3;
	int indexid=0;
	int area3pagecount = 0;    //左侧媒体列表页数
	int area3pagesize = 8;     //左侧媒体列表每页数据量
	int area3curindex=0;       //左侧媒体列表当前位置
	int area3curpage=1;        //左侧栏目列表当前焦点
	int cur_area3_index=0;
	Calendar calendar = Calendar.getInstance();
    String hour = ((Integer)calendar.get(Calendar.HOUR_OF_DAY)).toString();
    String minute = ((Integer)calendar.get(Calendar.MINUTE)).toString();
    minute = minute.length() < 2?"0"+minute :minute;
	String strcurdate=hour + ":"+minute;
	ArrayList vod_list =new ArrayList();
	int [] intSubjectType = {9999,10}; //只需要混合类型的
	int typeFlag = 0; //是否显示定制栏目 0.非定制栏目 1.定制栏目 2.所有栏目
	int contentType = 0; //子栏目视频类型
	JSONArray jsonvodlist = null; //节目列表
	JSONArray jsoncatelist=null; //栏目列表
	
	if(focstr!=null){
	   	focObj = String.valueOf(getState(analyticFocStr(focstr),"3","curpage"));
		area3curpage = (focObj==null||focObj.equals("null"))?1:Integer.parseInt(focObj);
		focObj = String.valueOf(getState(analyticFocStr(focstr),"3","curindex"));
	    area3curindex = (focObj==null||focObj.equals("null"))?0:Integer.parseInt(focObj);
		cur_area3_index = (area3curpage-1)*area3pagesize+area3curindex;
		areaid=3;
		indexid=area3curindex;
		
	    focObj = String.valueOf(getState(analyticFocStr(focstr),"1","curpage"));
		area1curpage = (focObj==null||focObj.equals("null"))?1:Integer.parseInt(focObj);
		focObj = String.valueOf(getState(analyticFocStr(focstr),"1","curindex"));
	    area1curindex = (focObj==null||focObj.equals("null"))?0:Integer.parseInt(focObj);
		cur_area1_index = (area1curpage-1)*area1pagesize+area1curindex;
	
	}
	
	//获取栏目列表
	ArrayList cateresultList = metadata.getTypeListByTypeId(Wonderful_video,-1,0,intSubjectType,typeFlag);
	if(cateresultList != null && cateresultList.size() > 1 && ((ArrayList)cateresultList.get(1)).size() > 0){
		ArrayList tempList = new ArrayList();
		for(Object obj : ((ArrayList)cateresultList.get(1))){
			HashMap tempmap = new HashMap();
			tempmap.put("TYPE_ID",((HashMap)obj).get("TYPE_ID").toString());
			tempmap.put("TYPE_NAME",((HashMap)obj).get("TYPE_NAME").toString());
			tempList.add(tempmap);
		}
		int count = ((Integer)((HashMap)cateresultList.get(0)).get("COUNTTOTAL")).intValue(); //总数量
		area1pagecount = (count-1)/area1pagesize+1;
		jsoncatelist = JSONArray.fromObject(tempList);
	}
	
	HashMap tMap = (HashMap)((ArrayList)cateresultList.get(1)).get(cur_area1_index);
	typeid=(String)tMap.get("TYPE_ID");

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
			area3pagecount = (count-1)/area3pagesize+1;
			if(area3curindex>=count){
				area3curindex = count-1;
			}
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
								
				if(i==cur_area3_index){
					vodid = Integer.parseInt(tmpvodid);
				}
				tempList.add(tempmap);
			}
			jsonvodlist = JSONArray.fromObject(tempList);
		}
		
	}
	
	if(vod_list.size()==0){
		    ArrayList tempList1 = new ArrayList();
			HashMap tempmap1 = new HashMap();
			tempmap1.put("VODID",-1);	
			tempmap1.put("VODNAME","暂无内容");
			tempmap1.put("POSTERPATHS","");
			tempmap1.put("PICPATH","../images/nopicbq.jpg");	
			tempList1.add(tempmap1);
			jsonvodlist = JSONArray.fromObject(tempList1);
		    area3pagecount=1;
	}
%>

var returnurl='<%=returnurl %>';

var area1pagecount = <%=area1pagecount %>;
var area1pagesize = <%=area1pagesize %>;
var area1curindex = <%=area1curindex %>;
var area1curpage = <%=area1curpage %>;

var area3pagecount = <%=area3pagecount %>;
var area3pagesize = <%=area3pagesize %>;
var area3curindex = <%=area3curindex %>;
var area3curpage = <%=area3curpage %>;
var strcurdate="<%=strcurdate%>";
var jsoncatelist =eval('('+'<%=jsoncatelist%>'+')');  //点播栏目列表
var jsonvodlist = eval('('+'<%=jsonvodlist%>'+')');
var focstr='<%=focstr %>';
var areaid=<%=areaid %>;
var	indexid=<%=indexid %>;
var typeid='<%=typeid%>';
//填充栏目
function bindCateData(itms) {
	area1.setpageturndata(itms.length, area1pagecount);
	area1.datanum=itms.length;
	for (i = 0; i < area1.doms.length; i++) {
		if (i < itms.length) {
			area1.doms[i].setcontent("",itms[i].TYPE_NAME,13);
			area1.doms[i].youwanaobj = itms[i].TYPE_ID;
		}else{
			area1.doms[i].updatecontent("");
			area1.doms[i].mylink = "";
		}
	}
  
}

//填充VOD
function bindVODData(itms) {
	    area1.mymovelock = false;
        area3.setpageturndata(itms.length, area3pagecount);
		area3.datanum=itms.length;
        for (i = 0; i < area3.doms.length; i++) {
            if (i < itms.length) {
				area3.doms[i].setcontent("",itms[i].VODNAME,10);
			    area3.doms[i].updateimg(itms[i].PICPATH);
				area3.doms[i].youwanaobj = itms[i].VODID;
				if($('area3_list'+i).style.display=="none"){
					 $('area3_list'+i).style.display = "block";	
				}
		    }else{
                area3.doms[i].updatecontent("");
		    	$('area3_list'+i).style.display = "none";	
		
			    area3.doms[i].updateimg("#");
			}
		
        }
	area3curpage=area3.curpage;
    $('page').innerHTML = area3.curpage+"/"+(area3pagecount==undefined?1:area3pagecount)+"页";
	
	//$("currDate").innerHTML=area1.mymovelock;
}

</script>