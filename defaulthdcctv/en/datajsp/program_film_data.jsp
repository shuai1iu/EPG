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
<%@ include file="codepage.jsp"%>
<script>
<%
	//String[] allTypeId 父栏目ID
	Integer vodid = request.getParameter("vodid")==null?1:Integer.parseInt(request.getParameter("vodid"));
	String typeid = request.getParameter("typeid")==null?"-1":request.getParameter("typeid");
	String name = null;
	String pstTypestr = request.getParameter("psttype");	
	String RtnURL = request.getParameter("returnurl")==null?"-1":request.getParameter("returnurl");
	
	MetaData metadata = new MetaData(request);
	if(shouyetuijian2code.equals(typeid)||dianbocode.equals(typeid)){
		name = "热点推荐";
	}else if(!"-1".equals(typeid)){
		HashMap typeInfoMap = metadata.getTypeInfoByTypeId(typeid);
		name = typeInfoMap.get("TYPENAME").toString();
	}
	HashMap mediadetailInfo = (HashMap)metadata.getVodDetailInfo(vodid);
	JSONObject jsonmediaInfo = null;
	boolean isfaved = false;
	if(mediadetailInfo!=null){
		String postertype = pstTypestr==null?"1":pstTypestr;
		HashMap postersMap = (HashMap)mediadetailInfo.get("POSTERPATHS");
		String picpath = (String)mediadetailInfo.get("PICPATH");
		String postpath = getPosterPath(postersMap,request,picpath,postertype).toString();
		mediadetailInfo.put("POSTERPATH",postpath);
		mediadetailInfo.put("PICPATH",picpath);
		HashMap castMap = (HashMap)mediadetailInfo.get("CASTMAP");
		if(castMap!=null&&castMap.get(6)!=null){
			String[] tempCasts = (String[])castMap.get(6);
			StringBuffer actor = new StringBuffer();
			for(String str : tempCasts){
				actor.append(","+str.trim());
			}
			mediadetailInfo.put("ACTOR","".equals(actor.toString())?null:actor.toString().substring(1));		
		}
		jsonmediaInfo = JSONObject.fromObject(mediadetailInfo);	 //转化为JSON对象
		ServiceHelp shelper = new ServiceHelp(request);
		int contentid = Integer.parseInt(mediadetailInfo.get("VODID").toString());
		int contenttype = Integer.parseInt(mediadetailInfo.get("CONTENTTYPE").toString());
		isfaved = shelper.isFavorited(contentid,contenttype);  //是否已收藏
	}
	
	//获取产品包
	//notend 2011年8月20日 15:16:10
	//需要确认：未确认产品包能否查询与购买
	ServiceHelpHWCTC serHelphwctc = new ServiceHelpHWCTC(request);
	HashMap progs_result = (HashMap)serHelphwctc.authorizationHWCTC(vodid,1,0,1,typeid,0);
	JSONArray json_monthList = null;
	JSONArray json_timesList = null;
	JSONArray json_progList = null;
	String retcode = "";
	if(progs_result!=null){
		retcode = progs_result.get("RETCODE").toString();
		List monthList = (ArrayList)progs_result.get("MONTH_LIST");//包月产品列表
		List timesList = (ArrayList)progs_result.get("TIMES_LIST");//按次产品列表
		List progList =(ArrayList)progs_result.get("PREORDERED_PRODLIST");//已经订购产品列表
		//转化成JSON格式
		json_monthList = JSONArray.fromObject(monthList);
		json_timesList = JSONArray.fromObject(timesList);
		json_progList = JSONArray.fromObject(progList);
	}
	
	//获取相关影片
	
	if("-1".equals(typeid)&&((String[])mediadetailInfo.get("allTypeId")).length!=0){
		typeid = ((String[])mediadetailInfo.get("allTypeId"))[0];
		HashMap tmpTypeInfo = (HashMap)metadata.getTypeInfoByTypeId(typeid);
		if(tmpTypeInfo!=null){
			name = tmpTypeInfo.get("TYPENAME").toString();			
		}
		if(name==null){
			name="热点推荐";
		}
	}
	Integer contenttype = (Integer)mediadetailInfo.get("CONTENTTYPE");
	List aboutvods_result = (ArrayList)metadata.getVodListByTypeId(typeid,7,0,contenttype);
	JSONArray json_aboutvods = null; 
	if(aboutvods_result!=null){
		List aboutvods = (ArrayList)aboutvods_result.get(1);
		for(int i =0;i<aboutvods.size();i++){
			String postertype = "1";
			HashMap itmmap = (HashMap)aboutvods.get(i);
			HashMap postersMap = (HashMap)itmmap.get("POSTERPATHS");
			String picpath = (String)itmmap.get("PICPATH");
			String postpath = getPosterPath(postersMap,request,picpath,postertype).toString();
			itmmap.put("POSTERPATH",postpath);
		}
		json_aboutvods = JSONArray.fromObject(aboutvods);
	}
%>
	var pstTypestr = '<%=pstTypestr %>';
	var jsonmediaInfo = <%=jsonmediaInfo %>;	
	var isfaved = <%=isfaved %>;
	var jsonaboutvods = <%=json_aboutvods %>;
	//var jsonmonthList = eval('('+'<%=json_monthList %>'+')');
	//var jsontimesList = eval('('+'<%=json_timesList %>'+')');
	//var jsonprogList = eval('('+'<%=json_progList %>'+')');
	var buystatu = '<%=retcode %>'; //是否需要购买 0.无需购买 504.未购买
	var begintime = '-1';
	var endtiem = '-1';
	var isbookmark = undefined;
	
	
	//详情内容填充
	function setContentData(obj){
		if(obj!=null){
			$("sitcom_pst").src = obj.POSTERPATH;
			if(pstTypestr=="1"){
				$("tv_choose_pic").style.width = "259px";
				$("tv_choose_pic").style.height = "232px";
				$("sitcom_pst").style.width = "259px";
				$("sitcom_pst").style.height = "232px";
				$("tv_choose_intro").style.left = "297px";
				$("tv_choose_intro").style.width = "608px";
			}
			$("sitcom_name").innerHTML = "<b>片名：</b>"+obj.VODNAME;
			$("sitcom_price").innerHTML = "<b>价格：</b>"+(obj.VODPRICE==undefined?0:obj.VODPRICE);
			$("sitcom_dct").innerHTML = "<b>导演：</b>"+(obj.DIRECTOR!=undefined?obj.DIRECTOR:"未知");
			//obj.ACTOR = （obj.ACTORS==undefined）?"未知"obj.ACTORS.join(" ");
			$("sitcom_act").innerHTML = "<b>主演：</b>"+(obj.ACTOR!=undefined?obj.ACTOR:"未知");
			$("introduce").innerHTML = "<b>内容简介：</b>"+getcutedstring(obj.INTRODUCE,((pstTypestr=="1")?138:158));
		}
	}
	
	//相关影片填充
	function setListData(itms){
		if(itms!=undefined){
			for(var i=0;i<itms.length;i++){
				if(itms[i].VODID==<%=vodid %>){
					itms.splice(i,1);
					break;							
				}	
			}
			for(var i=0;i<itms.length;i++){
                                var topicIntro = itms[i].INTRODUCE;
				if(topicIntro.search(/img/)){
                                        itms.splice(i,1);
                                        break;
                                }
                        }
			
			area1.datanum = itms.length;
			if(pstTypestr=="1"){
				$("film_list3").style.display = "block";
			}else{
				$("film_list2").style.display = "block";
			}
			for(var i=0;i<area1.doms.length;i++){
					if(i<area1.datanum){
						$("about"+i).style.display = "block";
						area1.doms[i].updateimg(itms[i].POSTERPATH);
						area1.doms[i].mylink = "vod_turnpager.jsp?vodid="+itms[i].VODID+"&typeid=<%=typeid%>&psttype="+pstTypestr+"&returnurl="+escape(location.href);
					}else{
						$("about"+i).style.display = "none";
						area1.doms[i].updateimg("#");
						area1.doms[i].mylink = "";
					}
			}			
		}else{
			area1.datanum = 0;
		}
	}
</script>
