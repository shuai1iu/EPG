<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file="../util/util_getPosterPaths.jsp" %>
<script type="text/javascript">
//绑定初始化第一个栏目下面的数据
<%
	String typeId = request.getParameter("typeid")==null?"00000100000000090000000000001261":request.getParameter("typeid"); //测试，默认为最新上线
	String type = request.getParameter("type");
	String parent_typeId = request.getParameter("ptypeid")==null?typeId:request.getParameter("ptypeid"); //父栏目id默认-1
	int pagesize = 11;
	int curpage = Integer.parseInt(request.getParameter("curpage")==null?"1":request.getParameter("curpage"));
	int curindex = Integer.parseInt(request.getParameter("curindex")==null?"0":request.getParameter("curindex"));
	int curcontentindex = -1;
	int pagestart = (curpage-1)*pagesize;
	boolean isfaved = false;
	int pagecount = 0;
	String typeName = "未知";
	String vodId = request.getParameter("backvodid");
	
	MetaData metadata = new MetaData(request);
	JSONArray jFilms = null;
	JSONObject jContent = null;
	String tmp_typeId = typeId;
	if(typeId.length()!=parent_typeId.length()){
		tmp_typeId = parent_typeId;
	}
	
	//获取列表 
	if(typeId!=null){
		List contentList = metadata.getVodListByTypeId(tmp_typeId,9999,0);
		if(contentList!=null&&contentList.size()>=2){			
			int counttotal = Integer.parseInt(((HashMap)contentList.get(0)).get("COUNTTOTAL").toString()); //总数
			pagecount = (counttotal-1)/pagesize +1; //获取总页数
			List templist = (ArrayList)contentList.get(1);
			if(templist!=null&&templist.size()>0){				
				for(int i =0;i<templist.size();i++){
					HashMap tempMap = new HashMap();
					String temp_vodId = ((HashMap)templist.get(i)).get("VODID").toString();
					if(typeId.length()!=parent_typeId.length()&&temp_vodId.equals(typeId)){
						curcontentindex = i;
					}
					tempMap.put("VODID",((HashMap)templist.get(i)).get("VODID"));
					tempMap.put("VODNAME",((HashMap)templist.get(i)).get("VODNAME"));
					templist.set(i,tempMap);
				}
				if(curindex>=templist.size()){
					curindex=templist.size()-1;
				}
				if(vodId==null){
					HashMap contentmap =  (HashMap)templist.get(0);
					vodId = contentmap.get("VODID").toString();
				}
			}
			jFilms = JSONArray.fromObject(templist);
		}
	}
	//获取内容
	String tpicpath = "";
	HashMap mediadetailInfo = (HashMap)metadata.getVodDetailInfo(Integer.parseInt(vodId));
	if(mediadetailInfo!=null){
		String postertype = "1";
		HashMap postersMap = (HashMap)mediadetailInfo.get("POSTERPATHS");
		//String picpath = "images/no_picture_259x232.jpg";
		String picpath = (String)mediadetailInfo.get("PICPATH");
		tpicpath = picpath;
		String postpath = getPosterPath(postersMap,request,picpath,postertype).toString();
		HashMap castMap = (HashMap)mediadetailInfo.get("CASTMAP");	
		if(castMap!=null&&castMap.get(6)!=null){
			String[] tempCasts = (String[])castMap.get(6);
			StringBuffer actor = new StringBuffer();
			for(String str : tempCasts){
				actor.append(","+str.trim());
			}
			mediadetailInfo.put("ACTOR","".equals(actor.toString())?null:actor.toString().substring(1));		
		}
		mediadetailInfo.put("PICPATH",postpath);
		jContent = JSONObject.fromObject(mediadetailInfo);
	}
	
	//获取栏目名称
	HashMap typeInfo = (HashMap)metadata.getTypeInfoByTypeId(tmp_typeId);
	if(typeInfo!=null){
		typeName = typeInfo.get("TYPENAME").toString();
	}
		
%>
	var pagesize = <%=pagesize %>;
	var jsonSitcoms = <%=jFilms %>;
	var jsonContent = <%=jContent %>;
	var pagecount = <%=pagecount%>;

     function bindData(items) {
           //初始化第一页
		   if(items!=null&&items!=undefined&&items!="null"){
			   area1.setpageturndata(items.length,pagecount);
			   for(var i = 0;i<pagesize;i++){
			   		if(i<items.length){
						area1.doms[i].setcontent("",items[i].VODNAME,31,true,false);
						area1.doms[i].youwanauseobj = items[i].VODID;
					}else{
						area1.doms[i].updatecontent("");
						area1.doms[i].youwanauseobj = undefined;
					}
				}
				$('page').innerHTML = area1.curpage+"/"+pagecount;
		   }else{
			  area1.doms[0].updatecontent("暂无内容");
			  area1.datanum = 1; 
		   }
        }

 
        //绑定系统内容信息
        function bindContent(itm) {
			//if(itm==null)itm = jsonContent;
			//ZTE
            $('zhuchi').innerText=(itm.DIRECTOR == undefined||(jsonmediaInfo!=undefined && jsonmediaInfo.DIRECTOR == "null"))?"暂无":itm.DIRECTOR;
	    //ZTE
			$('jiabin').innerText=(itm.ACTOR == undefined ||(jsonmediaInfo!=undefined && jsonmediaInfo.ACTOR=="null"))?"暂无":itm.ACTOR;
			$('desc').innerText=getcutedstring((itm.INTRODUCE==undefined||itm.INTRODUCE=="null")?"暂无简介":itm.INTRODUCE,83);
			if(itm.PICPATH==""||itm.PICPATH==undefined||itm.PICPATH=="null"||itm.PICPATH=="images/no_picture_192x264.jpg"){
				itm.PICPATH="<%=tpicpath %>";
			}
			$('img_right').src = itm.PICPATH;
        }
    </script>