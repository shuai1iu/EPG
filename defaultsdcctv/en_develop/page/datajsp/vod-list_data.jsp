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
	
	int pagecount = 0;    //页数
	int pagesize = 8;    //每页数据量
	
	JSONArray jsonvodlist = null; //节目列表
	JSONObject jsonvodinfo = null;
	JSONArray jsontestlist = null;	

	String typeid = request.getParameter("typeid");
	String catename = request.getParameter("catename")==null?"推荐栏目":request.getParameter("catename");
	Integer vodid = request.getParameter("vodid")==null?1:Integer.parseInt(request.getParameter("vodid"));
	String returnurl = request.getParameter("returnurl")==null?"index.jsp?back=1":request.getParameter("returnurl");
	int curpage = 1;
	int curindex = 0;
	if(focstr!=null){
		String focObj = String.valueOf(getState(analyticFocStr(focstr),"0","curpage"));
		curpage = (focObj==null||focObj.equals("null"))?1:Integer.parseInt(focObj);
		focObj = String.valueOf(getState(analyticFocStr(focstr),"0","curindex"));
		curindex = (focObj==null||focObj.equals("null"))?0:Integer.parseInt(focObj);	
	}
	int indexid = pagesize*(curpage-1)+curindex;
	
	//获取内容列表
	int isSubTypeOrContent = metadata.getSubTypeOrContent(typeid);
	if(isSubTypeOrContent==1){
%>
			location.href = "vod_turnpager.jsp?typeid=<%=typeid %>&returnurl="+escape('<%=returnurl %>');
<%
	}else if(isSubTypeOrContent==0){
		ArrayList vodlist = (ArrayList)metadata.getVodListByTypeId(typeid,-1,0);
		if(vodlist!=null && vodlist.size() > 1 && ((ArrayList)vodlist.get(1)).size() > 0){
			int count = ((Integer)((HashMap)vodlist.get(0)).get("COUNTTOTAL")).intValue(); //总数量
			pagecount = (count-1)/pagesize+1;
			if(indexid>=count){
				indexid = count-1;
			}
			ArrayList tempList = new ArrayList();
			ArrayList vod_list = (ArrayList)vodlist.get(1);
			for(int i = 0;i<vod_list.size();i++){
				Object obj = vod_list.get(i);
				HashMap tempmap = new HashMap();
				String tmpvodid = ((HashMap)obj).get("VODID").toString();
				String tmpvodname = ((HashMap)obj).get("VODNAME").toString();
				tempmap.put("VODID",tmpvodid);	
				tempmap.put("VODNAME",tmpvodname);					
				if(vodid==1&&i==indexid){
					vodid = Integer.parseInt(tmpvodid);
				}
				tempList.add(tempmap);
			}
			jsonvodlist = JSONArray.fromObject(tempList);
		}
		
		//获取内容详情
		boolean isfaved = false;
		HashMap mediadetailInfo = (HashMap)metadata.getVodDetailInfo(vodid);
		if(mediadetailInfo!=null){
			HashMap postersMap = (HashMap)(mediadetailInfo.get("POSTERPATHS"));
			String picpath = (String)mediadetailInfo.get("PICPATH");
			String postpath =  getPosterPath(postersMap,request,picpath,postertype).toString();
			mediadetailInfo.put("POSTERPATHS","../"+postpath);
			mediadetailInfo.put("PICPATH","../"+picpath);
			HashMap castMap = (HashMap)mediadetailInfo.get("CASTMAP");	
			if(castMap!=null&&castMap.get(6)!=null){
				String[] tempCasts = (String[])castMap.get(6);
			//	System.out.println("tempCasts--------------"+tempCasts);
				StringBuffer actor = new StringBuffer();
				for(String str : tempCasts){
					actor.append(","+str.trim());
			}
			mediadetailInfo.put("ACTOR","".equals(actor.toString())?null:actor.toString().substring(1));	
			String introduce=(String)mediadetailInfo.get("INTRODUCE");
			mediadetailInfo.put("INTRODUCE",introduce);
		}
		String tempDir = (String)mediadetailInfo.get("DIRECTOR");
		tempDir = tempDir!=null?tempDir.trim():null;
	      //  System.out.println("tempDir--------------"+tempDir); 		
		mediadetailInfo.put("DIRECTOR",tempDir);
		ServiceHelp shelper = new ServiceHelp(request);
		int contentid = Integer.parseInt(mediadetailInfo.get("VODID").toString());
		int contenttype = Integer.parseInt(mediadetailInfo.get("CONTENTTYPE").toString());
		isfaved = shelper.isFavorited(contentid,contenttype);  //是否已收藏
		mediadetailInfo.put("ISFAVED",isfaved);
		jsonvodinfo = JSONObject.fromObject(mediadetailInfo);
		}
	}               		  
%>
var israndom = false;
var isfaved = false;
var pagesize = <%=pagesize %>;
var pagecount = <%=pagecount %>;
var jVodlist = <%=jsonvodlist%>;  //点播栏目列表
var jVodInfo = <%=jsonvodinfo%>;  //点播内容详情
var returnurl = '<%=returnurl %>';
var catename = '<%=catename %>';
//填充节目列表
function bindVodData(itms) {
	        catename=unescape(catename);  //ztewebkit
		if(catename=="推荐栏目"){
			$('catename').innerHTML = '<span>点播-推荐栏目';
		}else{
			var tmpname=catename.split('-');
			$('catename').innerHTML = '<span>点播-'+tmpname[0]+'-</span>'+tmpname[1];
		}
        area0.setpageturndata(itms.length, pagecount);

	if(itms.length>0)
	{
	       for (i = 0; i < area0.doms.length; i++) {
	   	       if (i < itms.length) {
				area0.doms[i].setcontent("",itms[i].VODNAME,13);
				area0.doms[i].mylink = "vod-tv-detail.jsp?catename=<%=catename %>&typeid=<%=typeid %>&vodid="+itms[i].VODID+"&returnurl="+escape(location.href);
				area0.doms[i].youwanaobj = itms[i].VODID;
		       }else{			       
                                area0.doms[i].updatecontent("");
		                area0.doms[i].mylink = "";	       
		       }
	       }
	}else{
		                area0.doms[0].updatecontent("暂无内容");
				area0.doms[0].mylink = "";
	}
		//getAJAXData("datajsp/vod-list_data_iframe.jsp?vodid="+area0.doms[area0.curindex].youwanaobj,bindData);
        $('page').innerHTML =  '<span class="current">'+area0.curpage+'</span>/'+(pagecount==undefined?1:pagecount);
}

function bindVodContent(itm){
	area1.datanum = 1;
	$('vod_pst').src = itm.POSTERPATHS;
	isfaved = itm.ISFAVED;
	//itm.VODNAME = (itm.VODNAME==undefined||itm.VODNAME=="null")?"暂无":itm.VODNAME;
	//itm.VODNAME = (getbytelength(itm.VODNAME)>12)?getcutedstring(itm.VODNAME,12):itm.VODNAME;
	//$('vod_name').innerText = "片名："+itm.VODNAME;
	itm.DIRECTOR = (itm.DIRECTOR==undefined||itm.DIRECTOR=="null"||itm.DIRECTOR=='null'||itm.DIRECTOR==""||itm.DIRECTOR=="undefined")?"暂无":itm.DIRECTOR;
	itm.DIRECTOR = (getbytelength(itm.DIRECTOR)>32)?getcutedstring(itm.DIRECTOR,32):itm.DIRECTOR;
	     //   itm.DIRECTOR = (itm.DIRECTOR==undefined||itm.DIRECTOR=="null"||itm.DIRECTOR=='null'||itm.DIRECTOR==""||itm.DIRECTOR=="undefined"||itm.DIRECTOR==null||itm.DIRECTOR=='undefined'||itm.DIRECTOR==undefined)?"暂无":itm.DIRECTOR;
//	alert(itm.DIRECTOR);
	if(itm.DIRECTOR!=undefined&&itm.DIRECTOR!='undefined'&&itm.DIRECTOR!="undefined")
		$('vod_dct').innerHTML = '<span class="th">导演：</span>'+itm.DIRECTOR;
	else
		$('vod_dct').innerHTML = '<span class="th">导演：</span>'+"暂无";
	itm.ACTOR = (itm.ACTOR==undefined||itm.ACTOR=="null")?"暂无":itm.ACTOR;
	itm.ACTOR = (getbytelength(itm.ACTOR)>60)?getcutedstring(itm.ACTOR,60):itm.ACTOR;
	if(itm.ACTOR!=undefined&&itm.ACTOR!='undefined'&&itm.ACTOR!="undefined")
		$('vod_act').innerHTML = '<span class="th">主演：</span>'+itm.ACTOR;
	else
		$('vod_act').innerHTML = '<span class="th">主演：</span>'+"暂无";
	$('introduce').innerHTML = getcutedstring(itm.INTRODUCE,124);
	//$('vod_timespan').innerHTML = '<span class="th">时长：</span>'+((itm.ELAPSETIME==undefined)?0:itm.ELAPSETIME)+'分钟';
	//$('vod_price').innerHTML = '<span class="th">价格：</span>'+((itm.VODPRICE==undefined)?0:itm.VODPRICE)+'元';
}
</script>
