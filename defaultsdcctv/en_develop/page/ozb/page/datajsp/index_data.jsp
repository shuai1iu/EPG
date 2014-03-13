<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<script>
<%
	 String returnurl = request.getParameter("returnurl")==null?"../../../../defaultsdcctv/en/page/index.jsp":request.getParameter("returnurl");
	 MetaData metadata = new MetaData(request);
	 
	 JSONArray jsonHotkeywords = null;  //热词
	 JSONArray jsonRecommends = null;   //推荐栏目	 
	 JSONArray jsonBesttvod = null;     //精彩回放
	 
	 //获取热词
	 ArrayList hotkey_list = (ArrayList)metadata.getTypeListByTypeId(Index_Hotkey,-1,0);
	 ArrayList hotkey_resultlist = null;
	 if(hotkey_list!=null&&hotkey_list.size()>1){
		 hotkey_resultlist = (ArrayList)hotkey_list.get(1);
		 if(hotkey_resultlist!=null){
			 for(int i =0,l=hotkey_resultlist.size();i<l;i++){
				 HashMap tempMap = new HashMap();
				 String typeName = ((HashMap)hotkey_resultlist.get(i)).get("TYPE_NAME").toString().trim();
				 String introduce = ((HashMap)hotkey_resultlist.get(i)).get("TYPE_INTRODUCE").toString().trim();
				 tempMap.put("TYPE_NAME",typeName);
				 tempMap.put("TYPE_INTRODUCE",introduce);
				 hotkey_resultlist.set(i,tempMap);
			 }
			 jsonHotkeywords = JSONArray.fromObject(hotkey_resultlist);
		 }	 
	 }
	 
	  //中间图片获取及滚动字幕
	  HashMap map = (HashMap)metadata.getTypeInfoByTypeId(index_mid);
	  String introduce = (String)map.get("INTRODUCE");
	 
	 //获取推荐栏目
	  ArrayList recommend_list = (ArrayList)metadata.getVodListByTypeId(Index_Recommend,3,0);
	  String postertype = "0";
	  if(recommend_list!=null&&recommend_list.size()>1){
		 ArrayList recommend_resultlist = (ArrayList)recommend_list.get(1);
		 if(recommend_resultlist!=null){
			 for(int i=0;i<recommend_resultlist.size();i++){
			 	HashMap tempMap = (HashMap)recommend_resultlist.get(i);
				HashMap postersMap = (HashMap)(tempMap.get("POSTERPATHS"));
				String picpath = (String)tempMap.get("PICPATH");
				String postpath =  getPosterPath(postersMap,request,"absolute",postertype).toString();
				tempMap.put("POSTERPATHS",postpath);
				tempMap.put("PICPATH","../../"+picpath);
			 }
			 jsonRecommends = JSONArray.fromObject(recommend_resultlist);
		 }	 
	  }
	  
	  
	  //获取推荐栏目vas
	/*  ArrayList recommend_list_vas = (ArrayList)metadata.getVasListByTypeId(Index_Recommend1,3,0);
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
	  */
	 
	 //获取精彩回放
	 ArrayList besttvod_list = (ArrayList)metadata.getVodListByTypeId(Index_Besttvod,3,0);
	 if(besttvod_list!=null&&besttvod_list.size()>1){
		 ArrayList besttvod_resultlist = (ArrayList)besttvod_list.get(1);
		 if(besttvod_resultlist!=null){
			 jsonBesttvod = JSONArray.fromObject(besttvod_resultlist);
		 }	 
	  }
%>
var index_Recommend = '<%=Index_Recommend %>';
var index_Besttvod = '<%=Index_Besttvod %>';
var curPageName = '<%=tmpcurpageName %>';
var jRecommends = <%=jsonRecommends %>;   //推荐栏目
var jHotkeywords = <%=jsonHotkeywords %>; //热词
var jBesttvod = <%=jsonBesttvod %>;       //精彩视频回看
var returnurl = '<%=returnurl %>';
var hotlen=jHotkeywords.length;
var introduce="<%=introduce %>";
//填充导航栏链接
function bindNavigatData(){
	if(true){
		area0.doms[1].mylink = "group-match.jsp";
	}else{
		area0.doms[1].mylink = "knockout.jsp";
	}
	area0.doms[2].mylink = "video.jsp";
	area0.doms[3].mylink = "star.jsp";
	area0.doms[4].mylink = "top-scorer.jsp";
	area0.doms[5].mylink = "search.jsp";
}

//填充左侧推荐内容
function bindRecommendData(itms){
	if(itms!=undefined&&itms!="null"){
		var rlen=itms.length<3?itms.length:3;//20120609 edit by mxr 
		area1.datanum = itms.length;
		for(var i=0;i<rlen;i++){
				area1.doms[i].updateimg(itms[i].POSTERPATHS);
				area1.doms[i].mylink = "vod-detail.jsp?typeid="+index_Besttvod+"&vodid="+itms[i].VODID+"&returnurl="+escape(location.href);
				//area1.doms[i].youwanauseobj = itms[i].VASID;
		}
	}else{
		area1.datanum = 0;
	}
}

//填充中间热词
function bindHotKeyWordsData(itms){
	if(itms!=undefined&&itms!="null"){
		hotlen=itms.length<5?itms.length:5;//20120609 edit by mxr
		for(var i=0;i<hotlen;i++){	
				area2.doms[i].mylink = "search.jsp?keyword=CNTVOZB"+itms[i].TYPE_INTRODUCE+"&hotkeyword="+itms[i].TYPE_NAME+"&returnurl="+escape(location.href);
		}
	}else{
		area2.datanum = 0;
		area0.stablemoveindex[2] = 3;
	}
}

//下部精彩回看
function bindBesttvodData(itms){
	if(itms!=undefined&&itms!="null"){
		var bestlen=itms.length<3?itms.length:3;//20120609 edit by mxr
		area4.datanum = itms.length;
		for(var i=0;i<bestlen;i++){
			area4.doms[i].setcontent("",(i+1)+"."+itms[i].VODNAME,35);
			area4.doms[i].mylink = "vod-detail.jsp?typeid="+index_Besttvod+"&vodid="+itms[i].VODID+"&returnurl="+escape(location.href);
		}
	}else{
		area4.datanum = 0;
	}
}

function load_iframe(){	
		playPage.location.href = "PlayTrailerInVas.jsp?left=239&top=119&width=378&height=283&type=<%=CATEGORY_TRAILER_TYPE%>&value=<%=CATEGORY_TRAILER_ID%>&mediacode=<%=CATEGORY_TRAILER_ID%>&contenttype=<%=CATEGORY_TRAILER_CONTENTTYPE%>&liveid=<%=Index_Live_SD%>";
		area3.doms[0].mylink="play_ControlChannel.jsp?CHANNELNUM=<%=Index_Live_SD%>&COMEFROMFLAG=1&returnurl="+escape(location.href);
}

function bindArea2Doms(itms){
	if(itms!=undefined&&itms!="null"){
		var curlength = 1;
		var curleft = 10;
		for(var i=0,l=itms.length;i<l;i++){
			curlength += itms[i].TYPE_NAME.length+1;
			if(curlength<=19){
				curleft += (i==0)?0:$("area2_content_"+(i-1)).clientWidth;
				$("area2_img_"+i).style.width = $("area2_content_"+i).clientWidth;
				$("area2_border_"+i).style.left = (10*i)+curleft;
			}else{
				if(area2.datanum==undefined){
					area2.datanum = i;
				}
				$("area2_content_"+i).style.display = "none";
			}
		}
		if(area2.datanum==undefined){
			area2.datanum = itms.length;
		}
	}
}
</script>