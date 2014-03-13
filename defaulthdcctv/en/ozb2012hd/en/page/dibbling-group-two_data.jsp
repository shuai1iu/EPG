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

	int vodid;
	int area2pagecount = 0;    //左侧栏目页数
	int area2pagesize = 10;     //左侧栏目每页数据量
	int area2curindex=0;       //左侧栏目当前位置
	int area2curpage=1;        //左侧栏目当前焦点
	int cur_area2_index=0;      //数组焦点
	int areaid=3;
	int indexid=0;
	
	Calendar calendar = Calendar.getInstance();
    String hour = ((Integer)calendar.get(Calendar.HOUR_OF_DAY)).toString();
    String minute = ((Integer)calendar.get(Calendar.MINUTE)).toString();
    minute = minute.length() < 2?"0"+minute :minute;
	String strcurdate=hour + ":"+minute;
	
	
	
	JSONArray jsonvodlist = null; //节目列表
    JSONArray jsonRecommends = null;   //推荐栏目	 
	
	if(focstr!=null){
	    
		focObj = String.valueOf(getState(analyticFocStr(focstr),"2","curpage"));
		area2curpage = (focObj==null||focObj.equals("null"))?1:Integer.parseInt(focObj);
		focObj = String.valueOf(getState(analyticFocStr(focstr),"2","curindex"));
	    area2curindex = (focObj==null||focObj.equals("null"))?0:Integer.parseInt(focObj);
		cur_area2_index = (area2curpage-1)*area2pagesize+area2curindex;
		areaid=2;
		indexid=area2curindex;
		
	
	}
   //获取推荐栏目
   /**
   ArrayList recommend_list = (ArrayList)metadata.getVodListByTypeId(Index_Recommend,2,0);
   if(recommend_list!=null&&recommend_list.size()>1){
	 ArrayList recommend_resultlist = (ArrayList)recommend_list.get(1);
	 if(recommend_resultlist!=null){
		 for(int i=0;i<recommend_resultlist.size();i++){
			HashMap tempMap = (HashMap)recommend_resultlist.get(i);
			HashMap postersMap = (HashMap)(tempMap.get("POSTERPATHS"));
			String picpath = (String)tempMap.get("PICPATH");
			String postpath =  getPosterPath(postersMap,request,picpath,postertype).toString();
			tempMap.put("POSTERPATHS","../../"+postpath);
			tempMap.put("PICPATH","../../"+picpath);
		 }
		 jsonRecommends = JSONArray.fromObject(recommend_resultlist);
	  }	 
    }
	**/
	
	//获取推荐栏目vas
	  ArrayList recommend_list_vas = (ArrayList)metadata.getVasListByTypeId(Index_Recommend1,2,0);
	  //String postertype = "0";
	  if(recommend_list_vas!=null&&recommend_list_vas.size()>1){
		 ArrayList recommend_resultlist = (ArrayList)recommend_list_vas.get(1);
		 if(recommend_resultlist!=null){
			 for(int i=0;i<recommend_resultlist.size();i++){
				HashMap tempVasMap = ((HashMap)recommend_resultlist.get(i));
			 	Integer vasId = (Integer)tempVasMap.get("VASID");
				HashMap tempMap = (HashMap)metadata.getVasDetailInfo(vasId);
				if(tempMap!=null){
					String posterPath = (String)tempMap.get("POSTERPATH");
					tempVasMap.put("POSTERPATH","../../"+posterPath);
				}				
			 }
			 jsonRecommends = JSONArray.fromObject(recommend_resultlist);
		 }	 
	  }
	
    HashMap second_ptypemap = (HashMap)metadata.getTypeInfoByTypeId(typeid); 
	HashMap posterPathTypeMap = (HashMap)second_ptypemap.get("POSTERPATHS");
	String picTypePath ="../../" +getPosterPath(posterPathTypeMap,request,"","2").toString();
	
	 //  typeid=Star_Hall;
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
			ArrayList vod_list = (ArrayList)vodlist.get(1);
			for(int i = 0;i<vod_list.size();i++){
				Object obj = vod_list.get(i);
				HashMap tempmap = new HashMap();
				String tmpvodid = ((HashMap)obj).get("VODID").toString();
				String tmpvodname =(i+1)+".&nbsp;" +((HashMap)obj).get("VODNAME").toString();
			    //HashMap postersMap = (HashMap)(((HashMap)obj).get("POSTERPATHS"));
		       //	String picpath = ((HashMap)obj).get("PICPATH").toString();
			   // String postpath =  getPosterPath(postersMap,request,picpath,postertype).toString();
				
				tempmap.put("VODID",tmpvodid);	
				tempmap.put("VODNAME",tmpvodname);
				//tempmap.put("POSTERPATHS","../../"+postpath);
			   // tempmap.put("PICPATH","../../"+picpath);	
								
				if(i==cur_area2_index){
					vodid = Integer.parseInt(tmpvodid);
				}
				tempList.add(tempmap);
			}
			jsonvodlist = JSONArray.fromObject(tempList);
		}
		
	}
%>

var returnurl='<%=returnurl %>';

var area2pagecount = <%=area2pagecount %>;
var area2pagesize = <%=area2pagesize %>;
var area2curindex = <%=area2curindex %>;
var area2curpage = <%=area2curpage %>;
var jRecommends = <%=jsonRecommends %>;   //推荐栏目
var picTypePath="<%=picTypePath%>";
var jsonvodlist = eval('('+'<%=jsonvodlist%>'+')');
var strcurdate="<%=strcurdate%>";
var areaid=<%=areaid %>;
var	indexid=<%=indexid %>;
var typenum="<%=typenum%>";


//填充VOD
function bindVODData(itms) {
        area2.setpageturndata(itms.length, area2pagecount);
        for (i = 0; i < area2.doms.length; i++) {
            if (i < itms.length) {
				area2.doms[i].setcontent("",itms[i].VODNAME,50);
			   // area2.doms[i].updateimg(itms[i].PICPATH);
				area2.doms[i].youwanauseobj = itms[i].VODID;
				
				if($('area2_list'+i).style.display=="none"){
					 $('area2_list'+i).style.display = "block";	
				}
		    }else{
                area2.doms[i].updatecontent("");
		    	$('area2_list'+i).style.display = "none";	
		        area2.doms[i].youwanauseobj = "";
			 //   area2.doms[i].updateimg("#");
			}
	   }
	  area2curpage=area2.curpage;
      $('page').innerHTML = area2.curpage+"/"+(area2pagecount==undefined?1:area2pagecount)+"页";
}

//填充左侧推荐内容
function bindRecommendData(itms){
	if(itms!=undefined&&itms!="null"){
		area1.datanum = itms.length;
		for(var i=0,l=area1.doms.length,dl=itms.length;i<l;i++){
			if(i<dl){
				area1.doms[i].updateimg(itms[i].POSTERPATH);
				area1.doms[i].youwanauseobj = itms[i].VASID;
			}
		}
	}else{
		area1.datanum = 0;
	}
	$("picTypePath").src=picTypePath;
}
</script>