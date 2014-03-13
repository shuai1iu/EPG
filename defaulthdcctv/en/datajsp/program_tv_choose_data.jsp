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
<script type="text/javascript">
<%
	//String[] allTypeId 父栏目ID
	Integer vodId = request.getParameter("vodid")==null?1:Integer.parseInt(request.getParameter("vodid"));  //父Id
	String typeId = request.getParameter("typeid")==null?"-1":request.getParameter("typeid");
	String pstTypestr = request.getParameter("psttype");

	Integer sitcomIndex = request.getParameter("sitcomindex")==null?0:Integer.parseInt(request.getParameter("sitcomindex"));
	//子集id
	String sitcom = request.getParameter("sitcom");
	
	int pagesize = 36;
	int curpage = 1;
	if(sitcom==null){
		curpage = Integer.parseInt(request.getParameter("curpage")==null?"1":request.getParameter("curpage"));
	}else{
		curpage = Integer.parseInt(sitcom)/pagesize+1;  //当前页数
		sitcomIndex = Integer.parseInt(sitcom)%pagesize-1; //当前集数
	}
	int pagestart = (curpage-1)*pagesize;
	boolean isfaved = false;
	int pagecount = 0;
	String exstr = "";	
	
	MetaData metadata = new MetaData(request);
	String name = null;
	
	if(name==null){
		if(shouyetuijian2code.equals(typeId)||dianbocode.equals(typeId)){
			name = "热点推荐";
		}else if(!"-1".equals(typeId)){
			HashMap typeInfoMap = metadata.getTypeInfoByTypeId(typeId);
			name = typeInfoMap.get("TYPENAME").toString();
		}
	}
	
	JSONArray jSitcoms = null;
	JSONObject jContent = null;
	int retcount = 0;
	int tmpint = -1;
	
	//获取内容详情
	HashMap sitcomDetail = (HashMap)metadata.getVodDetailInfo(vodId);
	
	if(sitcomDetail!=null){
		HashMap tempsitcomDetail = new HashMap();
		tempsitcomDetail.put("VODID",sitcomDetail.get("VODID"));
		HashMap castMap = (HashMap)sitcomDetail.get("CASTMAP");	
		if(castMap!=null&&castMap.get(6)!=null){
			String[] tempCasts = (String[])castMap.get(6);
			StringBuffer actor = new StringBuffer();
			for(String str : tempCasts){
				actor.append(","+str.trim());
			}
			sitcomDetail.put("ACTOR","".equals(actor.toString())?null:actor.toString().substring(1));		
		}
		String picpath = (String)sitcomDetail.get("PICPATH");
		tempsitcomDetail.put("PICPATH",picpath);
		String postertype = pstTypestr==null?"1":pstTypestr;
		HashMap postersMap = (HashMap)sitcomDetail.get("POSTERPATHS");
		String postpath = getPosterPath(postersMap,request,picpath,postertype).toString();
		tempsitcomDetail.put("POSTERPATH",postpath);
		if(sitcomDetail.get("VODNAME")!=null){
			String tmpname = sitcomDetail.get("VODNAME").toString().replaceAll("'","’");
			tempsitcomDetail.put("VODNAME",sitcomDetail.get("VODNAME"));
		}
		tempsitcomDetail.put("VODPRICE",sitcomDetail.get("VODPRICE"));
		if(sitcomDetail.get("DIRECTOR")!=null){
			String tmpname = sitcomDetail.get("DIRECTOR").toString().replaceAll("'","'");
			tempsitcomDetail.put("DIRECTOR",sitcomDetail.get("DIRECTOR"));
		}
		if(sitcomDetail.get("ACTOR")!=null){
			String tmpname = sitcomDetail.get("ACTOR").toString().replaceAll("'","'");
			tempsitcomDetail.put("ACTOR",sitcomDetail.get("ACTOR"));
		}
		if(sitcomDetail.get("INTRODUCE")!=null){
			String tmpname = sitcomDetail.get("INTRODUCE").toString().replaceAll("'","'");
			tempsitcomDetail.put("INTRODUCE",sitcomDetail.get("INTRODUCE"));
		}
		ArrayList subVodIdlist = (ArrayList)sitcomDetail.get("SUBVODIDLIST");
		ArrayList subVodNumlist = (ArrayList)sitcomDetail.get("SUBVODNUMLIST");
		ArrayList newArr = new ArrayList();
		if(subVodIdlist!=null&&subVodIdlist!=null){
				pagecount = (subVodIdlist.size()-1)/pagesize+1;
				for(int i=0;i<subVodIdlist.size();i++){
					HashMap tempMap = new HashMap();
					tempMap.put("VODID",subVodIdlist.get(i));
					String subVodNum = subVodNumlist.get(i).toString();
					subVodNum = "00"+subVodNum;
					tempMap.put("VODNAME",subVodNum.substring(subVodNum.length()-3));
					newArr.add(tempMap);
				}
			}
		tempsitcomDetail.put("SUBVODNUMLIST",subVodNumlist);
		tempsitcomDetail.put("SUBVODLIST",newArr);
		tempsitcomDetail.put("CONTENTTYPE",sitcomDetail.get("CONTENTTYPE"));
		jContent = JSONObject.fromObject(tempsitcomDetail);
		
		ServiceHelp shelper = new ServiceHelp(request);
		int contentid = Integer.parseInt(sitcomDetail.get("VODID").toString());
		int contenttype = Integer.parseInt(sitcomDetail.get("CONTENTTYPE").toString());
		isfaved = shelper.isFavorited(contentid,contenttype);  //是否已收藏
	}
	
	//获取相关影片
	if("-1".equals(typeId)&&((String[])sitcomDetail.get("allTypeId")).length!=0){
		typeId = ((String[])sitcomDetail.get("allTypeId"))[0];
		HashMap tmpTypeInfo = (HashMap)metadata.getTypeInfoByTypeId(typeId);
		if(tmpTypeInfo!=null){
			name = tmpTypeInfo.get("TYPENAME").toString();
		}
		if(name==null){
			name="热点推荐";
		}
	}
	Integer contenttype = (Integer)sitcomDetail.get("CONTENTTYPE");
	List aboutvods_result = (ArrayList)metadata.getVodListByTypeId(typeId,7,0,contenttype);
	JSONArray json_aboutvods = null; 
	if(aboutvods_result!=null){
		List aboutvods = (ArrayList)aboutvods_result.get(1);
		for(int i =0;i<aboutvods.size();i++){
			String postertype = "1";
			HashMap itmmap = (HashMap)aboutvods.get(i);
			HashMap postersMap = (HashMap)itmmap.get("POSTERPATHS");
			String picpath = "";
			String postpath = getPosterPath(postersMap,request,picpath,postertype).toString();
			itmmap.put("POSTERPATH",postpath);
		}
		json_aboutvods = JSONArray.fromObject(aboutvods);
	}
	
	String retcode= "";
%>
	var pstTypestr = '<%=pstTypestr %>';
	var pagesize = <%=pagesize %>;
	var jsonContent = eval('(<%=jContent %>)');
	var jsonaboutvods = eval('(<%=json_aboutvods %>)');
	var jsonSitcoms;
	var sitcom_count = jsonContent.SUBVODLIST.length;
	var pagecount = <%=pagecount%>;
	var isfaved = <%=isfaved%>;
	var tempvodid = "-1"; //连续剧子vodid 用于输入框时返回操作
	
	//列表填充
	function setListData(itms){		
		if(itms!=null&&itms!="null"){
			area1.datanum = itms.length;
			area1.setpageturndata(itms.length,pagecount);
			for(var i=0;i<pagesize;i++){
				if(i<area1.datanum){
					area1.doms[i].updatecontent(itms[i].VODNAME);
					area1.doms[i].youwanauseobj = "au_PlayFilm.jsp?PROGID="+itms[i].VODID+"&PLAYTYPE=1&CONTENTTYPE=0&BUSINESSTYPE=1&TYPE_ID=<%=typeId%>&FATHERSERIESID=<%=vodId%>&returnurl="+escape(location.href);									
				}else{
					area1.doms[i].updatecontent("");
					area1.doms[i].youwanauseobj = "";
				}
			}
		}
	}
	
	//相关影片填充
	function setaboutListData(itms){
		if(itms!=undefined){
			for(var i=0;i<itms.length;i++){
				if(itms[i].VODID==<%=vodId %>){
					itms.splice(i,1);
					break;							
				}	
			}
			
			area10.datanum = itms.length;
			if(pstTypestr=="1"){
				$("film_list3").style.display = "block";
			}else{
				$("film_list2").style.display = "block";
			}
			for(var i=0,l=area10.doms.length;i<l;i++){
					if(i<area10.datanum){
						area10.doms[i].contentdom.style.display = "block";
						area10.doms[i].updateimg(itms[i].POSTERPATH);							
						area10.doms[i].mylink = "vod_turnpager.jsp?vodid="+itms[i].VODID+"&typeid=<%=typeId%>&psttype="+pstTypestr+"&returnurl="+escape(location.href);
					}else{
						area10.doms[i].contentdom.style.display = "none";
						area10.doms[i].updateimg("#");
						area10.doms[i].mylink = "";
					}
			}			
		}else{
			area10.datanum = 0;
		}
	}
	
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
			$("sitcom_act").innerHTML = "<b>主演：</b>"+(obj.ACTOR!=undefined?obj.ACTOR:"未知");
			$("sitcom_int").innerHTML = "<b>内容简介：</b>"+getcutedstring(obj.INTRODUCE,((pstTypestr=="1")?138:158));
		}
	}
	
	function getItmsByPage(cptitms,icurpage,ipagesize){
		var reclist=new Array();
		var start = (icurpage-1)*ipagesize;
		for(var i=0;i<ipagesize&&(i+(icurpage-1)*ipagesize)<cptitms.length;i++){
			 reclist[i]=cptitms[start+i];
		}
		return reclist;
	}
	
</script>