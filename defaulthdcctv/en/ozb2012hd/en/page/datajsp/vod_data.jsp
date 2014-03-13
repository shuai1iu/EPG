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
	String postertype = "1";
	String returnurl = request.getParameter("returnurl")==null?"index.jsp?back=1":request.getParameter("returnurl");
	String typeid="";
	String focObj ="";
	int vodid;
	int area1pagecount = 0;    //左侧栏目页数
	int area1pagesize = 8;     //左侧栏目每页数据量
	int area1curindex=0;       //左侧栏目当前位置
	int area1curpage=1;        //左侧栏目当前焦点
	int cur_area1_index=0;      //数组焦点
	int areaid=2;
	int indexid=0;
	int area3pagecount = 0;    //左侧媒体列表页数
	int area3pagesize = 10;     //左侧媒体列表每页数据量
	int area3curindex=0;       //左侧媒体列表当前位置
	int area3curpage=1;        //左侧栏目列表当前焦点
	int cur_area3_index=0;
	Calendar calendar = Calendar.getInstance();
    String hour = ((Integer)calendar.get(Calendar.HOUR_OF_DAY)).toString();
    String minute = ((Integer)calendar.get(Calendar.MINUTE)).toString();
    minute = minute.length() < 2?"0"+minute :minute;
	String strcurdate=hour + ":"+minute;
	
	int [] intSubjectType = {9999,10}; //只需要混合类型的
	int typeFlag = 0; //是否显示定制栏目 0.非定制栏目 1.定制栏目 2.所有栏目
	int contentType = 0; //子栏目视频类型
	JSONArray jsonvodlist = null; //节目列表
	JSONArray jsoncatelist=null; //栏目列表
	
	if(focstr!=null){
	   	focObj = String.valueOf(getState(analyticFocStr(focstr),"2","curpage"));
		area3curpage = (focObj==null||focObj.equals("null"))?1:Integer.parseInt(focObj);
		focObj = String.valueOf(getState(analyticFocStr(focstr),"2","curindex"));
	    area3curindex = (focObj==null||focObj.equals("null"))?0:Integer.parseInt(focObj);
		cur_area3_index = (area3curpage-1)*area3pagesize+area3curindex;
		areaid=2;
		indexid=area3curindex;
		
	    focObj = String.valueOf(getState(analyticFocStr(focstr),"1","curpage"));
		area1curpage = (focObj==null||focObj.equals("null"))?1:Integer.parseInt(focObj);
		focObj = String.valueOf(getState(analyticFocStr(focstr),"1","curindex"));
	    area1curindex = (focObj==null||focObj.equals("null"))?0:Integer.parseInt(focObj);
		cur_area1_index = (area1curpage-1)*area1pagesize+area1curindex;
	
	}
	
	//获取栏目列表
	ArrayList cateresultList = metadata.getTypeListByTypeId(Wonderful_video,-1,0,intSubjectType,typeFlag);
	int idex=0;
	if(cateresultList != null && cateresultList.size() > 1 && ((ArrayList)cateresultList.get(1)).size() > 0){
		ArrayList tempList = new ArrayList();
		for(Object obj : ((ArrayList)cateresultList.get(1))){
			HashMap tempmap = new HashMap();
		    if(idex==0){
			  tempmap.put("TYPE_ID","00000100000000090000000000019711");
			  tempmap.put("TYPE_NAME","高清赛场");
			}
			else{
			   tempmap.put("TYPE_ID",((HashMap)obj).get("TYPE_ID").toString());
			   tempmap.put("TYPE_NAME",((HashMap)obj).get("TYPE_NAME").toString());
			}
			idex=idex+1;
			tempList.add(tempmap);
		}
		int count = ((Integer)((HashMap)cateresultList.get(0)).get("COUNTTOTAL")).intValue(); //总数量
		area1pagecount = (count-1)/area1pagesize+1;
		jsoncatelist = JSONArray.fromObject(tempList);
	}
	
	HashMap tMap = (HashMap)((ArrayList)cateresultList.get(1)).get(cur_area1_index);
	if(cur_area1_index==0){
		typeid="00000100000000090000000000019711";
	}else{
	  typeid=(String)tMap.get("TYPE_ID");
	}
    ArrayList vod_list=new ArrayList();
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
			tempmap1.put("PICPATH","../images/nopicgq.jpg");	
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
var strcurdate="<%=strcurdate%>";
var area2pagecount = <%=area3pagecount %>;
var area2pagesize = <%=area3pagesize %>;
var area2curindex = <%=area3curindex %>;
var area2curpage = <%=area3curpage %>;

var jsoncatelist =eval('('+'<%=jsoncatelist%>'+')');  //点播栏目列表
var jsonvodlist = eval('('+'<%=jsonvodlist%>'+')');
var focstr='<%=focstr %>';
var areaid=<%=areaid %>;
var	indexid=<%=indexid %>;

//填充栏目
function bindCateData(itms) {
	area1.setpageturndata(itms.length, area1pagecount);
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
        area2.setpageturndata(itms.length, area2pagecount);
        for (i = 0; i < area2.doms.length; i++) {
            if (i < itms.length) {
				area2.doms[i].setcontent("",itms[i].VODNAME,10);
			    area2.doms[i].updateimg(itms[i].POSTERPATHS);
				area2.doms[i].youwanaobj = itms[i].VODID;
				if($('area2_list'+i).style.display=="none"){
					 $('area2_list'+i).style.display = "block";	
				}
		    }else{
                area2.doms[i].updatecontent("");
		    	$('area2_list'+i).style.display = "none";	
		
			    area2.doms[i].updateimg("#");
			}
		
        }
	area2curpage=area2.curpage;
    $('page').innerHTML = area2.curpage+"/"+(area2pagecount==undefined?1:area2pagecount)+"页";
	
	//$("currDate").innerHTML=area1.mymovelock;
}

</script>