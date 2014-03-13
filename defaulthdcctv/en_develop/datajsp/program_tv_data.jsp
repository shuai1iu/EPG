<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="../util/util_getPosterPaths.jsp"%>
<script type="text/javascript">
<%
	//Integer vodid = request.getParameter("id")==null?1:Integer.parseInt(request.getParameter("id"));
	String vodId = "0";
	String type = request.getParameter("type");
	String typeId = request.getParameter("typeid")==null?"00000100000000090000000000001261":request.getParameter("typeid"); //测试，默认为最新上线
	String parent_typeId = request.getParameter("ptypeid")==null?"-2":request.getParameter("ptypeid"); //父栏目id默认-1
	MetaData metadata = new MetaData(request);
	
	JSONObject jsontypeInfo = null;  //栏目信息（实际为获取内容信息）
	JSONObject jsonMediainfo = null; //用于栏目信息中没有的价格、主持、嘉宾等细节
	JSONArray jsonabouttypes = null; //相关影片
	boolean isfaved = false;
	String typeName = "未知";
	
	//获取栏目名称、 父栏目id
	HashMap typeInfo = null;
	if(typeId.length() == parent_typeId.length()){
		typeInfo = (HashMap)metadata.getTypeInfoByTypeId(typeId);
	}else{
		typeInfo = (HashMap)metadata.getTypeInfoByTypeId(parent_typeId);
	}
	
	if(typeInfo!=null){
		if("-2".equals(parent_typeId)){
			parent_typeId = typeInfo.get("PARENTID").toString();
		}
		typeName = typeInfo.get("TYPENAME").toString();
		String postertype = "1";
		HashMap postersMap = (HashMap)typeInfo.get("POSTERPATHS");
		String picpath = getPosterPath(postersMap,request,"","2").toString();
		String postpath = getPosterPath(postersMap,request,picpath,postertype).toString();
		typeInfo.put("POSTERPATH",postpath);
		HashMap castMap = (HashMap)typeInfo.get("CASTMAP");	
		if(castMap!=null&&castMap.get(6)!=null){
			String[] tempCasts = (String[])castMap.get(6);
			StringBuffer actor = new StringBuffer();
			for(String str : tempCasts){
				actor.append(","+str.trim());
			}
			typeInfo.put("ACTOR","".equals(actor.toString())?null:actor.toString().substring(1));		
		}
		typeInfo.put("PICPATH",picpath);
		jsontypeInfo = JSONObject.fromObject(typeInfo);
	}
	
	//栏目相关内容（实际为获取内容信息）
	Integer contentType = 0;
	if(request.getParameter("contenttype")!=null){
		contentType = Integer.parseInt(request.getParameter("contenttype"));
	}
	List medialist_result = (ArrayList)metadata.getVodListByTypeId(typeId,1,0,contentType);
	
	if(medialist_result!=null&&medialist_result.size()>=2){
		List medialist = (ArrayList)medialist_result.get(1);
		if(medialist!=null&&!medialist.isEmpty()){
			String postertype = "2";		
			HashMap mediaInfo = (HashMap)medialist.get(0);
			String tmpvodid = mediaInfo.get("VODID").toString(); 
			mediaInfo = (HashMap)metadata.getVodDetailInfo(Integer.parseInt(tmpvodid));
			
			HashMap postersMap = (HashMap)mediaInfo.get("POSTERPATHS");
			String picpath = "";
			String postpath = getPosterPath(postersMap,request,picpath,postertype).toString();
			mediaInfo.put("POSTERPATH",postpath);
			jsonMediainfo = JSONObject.fromObject(mediaInfo);
		}
	}else if(typeId.length() != parent_typeId.length()){
		String postertype = "1"; 
		HashMap mediaInfo = (HashMap)metadata.getVodDetailInfo(Integer.parseInt(typeId));
		HashMap postersMap = (HashMap)mediaInfo.get("POSTERPATHS");
		String picpath = "";
		String postpath = getPosterPath(postersMap,request,picpath,postertype).toString();
		mediaInfo.put("POSTERPATH",postpath);
		jsonMediainfo = JSONObject.fromObject(mediaInfo);
	}
	
	//相关影片	
	List aboutvods_result = (ArrayList)metadata.getTypeListByTypeId(parent_typeId,5,0);
	if(aboutvods_result!=null&&aboutvods_result.size()>=2){
		List abouttypes_result = (ArrayList)aboutvods_result.get(1);
		for(int i =0;i<abouttypes_result.size();i++){
				String postertype = "2";
				HashMap itmmap = (HashMap)abouttypes_result.get(i);
				HashMap postersMap = (HashMap)itmmap.get("POSTERPATHS");
				String picpath = "";
				String postpath = getPosterPath(postersMap,request,picpath,postertype).toString();
				itmmap.put("POSTERPATHS",postpath);
			}
		jsonabouttypes = JSONArray.fromObject(abouttypes_result);
	}else if(parent_typeId.length()!=typeId.length()){
		aboutvods_result = ((ArrayList)metadata.getVodListByTypeId(parent_typeId,5,0));
		if(aboutvods_result!=null&&aboutvods_result.size()>=2){
			List abouttypes_result = (ArrayList)aboutvods_result.get(1);
			for(int i =0;i<abouttypes_result.size();i++){
				String postertype = "1";
				HashMap itmmap = (HashMap)abouttypes_result.get(i);
				HashMap postersMap = (HashMap)itmmap.get("POSTERPATHS");
				String picpath = "";
				String postpath = getPosterPath(postersMap,request,picpath,postertype).toString();
				itmmap.put("POSTERPATHS",postpath);
			}
			jsonabouttypes = JSONArray.fromObject(abouttypes_result);
		}
	}
%>

	var jTypeInfo = eval('('+'<%=jsontypeInfo %>'+')');          //栏目信息
	var jMediaInfo = eval('('+'<%=jsonMediainfo %>'+')');	     //栏目补充信息
	var jAbouttypes = eval('('+'<%=jsonabouttypes %>'+')');    //
	var isfaved = <%=isfaved %>;
	
	var begintime = '-1';
	var endtiem = '-1';
	var isbookmark = undefined;		

		//editing 2011年8月21日 14:38:49
 		//填充相关节目		
		function setListData(itms){
			area1.datanum = 0;
		if(itms!=null){
			for(var i=0;i<itms.length;i++){
				if(itms[i].TYPE_NAME=='<%=typeName %>'||itms[i].VODID == jMediaInfo.VODID){
					itms.splice(i,1);
					break;							
				}	
			}
			
			area1.datanum = itms.length;
			for(var i=0;i<4;i++){
					if(i<area1.datanum){
						area1.doms[i].contentdom.style.display = "block";
						area1.doms[i].updateimg(itms[i].POSTERPATHS);						
						area1.doms[i].mylink = "program_tv.jsp?typeid="+(itms[i].TYPE_ID==undefined?itms[i].VODID:itms[i].TYPE_ID)+"&ptypeid=<%=parent_typeId%>&returnurl="+escape(location.href);
					}else{
						area1.doms[i].contentdom.style.display = "none";
						area1.doms[i].updateimg("#");
						area1.doms[i].mylink = "";
					}
			}			
		}
	}

        //绑定系统内容信息
        function Bindcontent() {
			if("<%=typeId %>".length!="<%=parent_typeId %>".length){
				$('contentname').innerHTML=jMediaInfo.VODNAME;
				$('img_right').src = jMediaInfo.POSTERPATH;
				$('contentdesc').innerHTML=getcutedstring((jMediaInfo.INTRODUCE==undefined||jMediaInfo.INTRODUCE=="null")?"暂无简介":jMediaInfo.INTRODUCE,111);
			}else{
				$('contentname').innerHTML=jTypeInfo.TYPENAME;
				if(jTypeInfo.POSTERPATH=="images/no_picture_192x264.jpg"){
					jTypeInfo.POSTERPATH = jTypeInfo.PICPATH;
				}
				$('img_right').src = jTypeInfo.POSTERPATH;
				$('contentdesc').innerHTML=getcutedstring((jTypeInfo.INTRODUCE==undefined||jTypeInfo.INTRODUCE=="null")?"暂无简介":jTypeInfo.INTRODUCE,111);
			}
			$('contentprise').innerHTML=(jMediaInfo.VODPRICE==undefined||jMediaInfo.VODPRICE=="null")?0:jMediaInfo.VODPRICE;
			$('contentzhuchi').innerHTML=(jMediaInfo.DIRECTOR==undefined||jMediaInfo.DIRECTOR=="null")?"暂无":jMediaInfo.DIRECTOR;
			$('contentjiabin').innerHTML=(jMediaInfo.ACTOR==undefined||jMediaInfo.ACTOR=="null")?"暂无":jMediaInfo.ACTOR;
			
			
        }
    </script>