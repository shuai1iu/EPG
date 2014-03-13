<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
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
	String typeId = "-1";
	String postertype = "5";
	if(request.getParameter("type")!=null){
		typeId = request.getParameter("type");
	}
	int countTotal = 0;
	int pagecount = 0;    //页数
	int pagesize = 12;    //每页数据量
	int curpage = Integer.parseInt(request.getParameter("curpage")==null?"1":request.getParameter("curpage"));
	String str="";
	int [] intSubjectType = {9999}; //只需要混合类型的
	int typeFlag = 0; //是否显示定制栏目 0.非定制栏目 1.定制栏目 2.所有栏目
	int contentType = 0; //子栏目视频类型
	int curindex = Integer.parseInt(request.getParameter("curindex")==null?"0":request.getParameter("curindex"));
	
	JSONArray jsontypelist = null; //子栏目列表
	JSONArray jsonrmdlist = null;//推荐节目列表
	
	//获取栏目列表
	/////////////////////////////////////////////////////////////
	List markArray = Arrays.asList("0-0","0-1","1-0","1-1"); //判断区域此标签为央视高清需显示的 

	ArrayList allOriResultList = metadata.getTypeListByTypeId("-1",-1,0,intSubjectType,typeFlag); //获取根目录全部 
	ArrayList szOriResultList = metadata.getTypeListByTypeId(szdianbocode,-1,0,intSubjectType,typeFlag); //获取深圳根目录列表 
	ArrayList ParseResultList = new ArrayList();	//用于分析的中栏目列表
	ArrayList tempAllList = new ArrayList();
	
	ArrayList fullTypeList = new ArrayList(); //包含了深圳可取栏目与根目录可取栏目的总栏目列表 
	if(szOriResultList!=null&&szOriResultList.size()>1){
		ParseResultList=(ArrayList)szOriResultList.get(1);	//获取深圳栏目 
	}
	if(allOriResultList!=null&&allOriResultList.size()>1){
		tempAllList = (ArrayList)allOriResultList.get(1); //获取全部栏目 
		if(tempAllList!=null)	ParseResultList.addAll(tempAllList);	//深圳栏目+全部栏目 
	}
	if(ParseResultList!=null&&ParseResultList.size()>0){
		for(int i=0;i<ParseResultList.size();i++){
			HashMap tempMap = (HashMap)ParseResultList.get(i);	
			String introduce = (String)tempMap.get("TYPE_INTRODUCE");
			if(introduce!=null&&markArray.contains(introduce)){
				HashMap resultMap = new HashMap();
				resultMap.put("TYPE_ID",(String)tempMap.get("TYPE_ID"));
				resultMap.put("TYPE_NAME",(String)tempMap.get("TYPE_NAME"));
				fullTypeList.add(resultMap);	//add需要的数据到fullTypeList 
			}
		}
	}

	ArrayList resultList=new ArrayList();	//封装数据 
	HashMap mcount=new HashMap();
	mcount.put("COUNTTOTAL",fullTypeList.size());
	resultList.add(mcount);
	resultList.add(fullTypeList);
	//////////////////////////////////////////////////////////////
	if(resultList == null || resultList.size() < 2 || ((ArrayList)resultList.get(1)).size() == 0)
	{
		str ="暂无数据";
	}else{
		ArrayList typeList = (ArrayList)resultList.get(1);
		jsontypelist = JSONArray.fromObject(typeList);
		int typeSize = typeList.isEmpty()? 0: typeList.size();
		int count = ((Integer)((HashMap)resultList.get(0)).get("COUNTTOTAL")).intValue(); //总数量
		pagecount = (count-1)/pagesize+1;
	}
	
	String subtypeId = dianbocode;
	//获取当前子栏目列表
	ArrayList subresultList = metadata.getVodListByTypeId(subtypeId,3,0);
	if(subresultList!=null&&subresultList.size()>=2){
		List subList = (ArrayList)subresultList.get(1);
		postertype = "0";
		if(subList!=null){
			for(int i =0;i<subList.size();i++){
				HashMap itmmap = (HashMap)subList.get(i);
				HashMap postersMap = (HashMap)itmmap.get("POSTERPATHS");
				String picpath = itmmap.get("PICPATH").toString();
				String postpath =  getPosterPath(postersMap,request,picpath,postertype).toString();
				itmmap.put("POSTERPATHS",postpath);
			}
		}
		jsonrmdlist = JSONArray.fromObject(subList);
	}
%>

var israndom = false;
var pagesize = <%=pagesize %>;
var pagecount = <%=pagecount %>;
var jTypelist = eval('('+'<%=jsontypelist%>'+')');  //点播栏目列表
var jRmdlist = eval('('+'<%=jsonrmdlist%>'+')');    //推荐内容列表
//栏目回掉的参数
function bindListData(itms) {
        area1.setpageturndata(itms.length, pagecount);
            for (i = 0; i < pagesize; i++) {
                if (i < itms.length) {
				   area1.doms[i].setcontent("",itms[i].TYPE_NAME,12);
                   //area1.doms[i].updatecontent(itms[i].TYPE_NAME);
				   var tempstr = pageConstants[itms[i].TYPE_ID]==undefined?"dibbling_recreation.jsp":pageConstants[itms[i].TYPE_ID];
				   area1.doms[i].mylink = tempstr+"?typeid=" + itms[i].TYPE_ID+"&returnurl="+escape(location.href); 
                }
                else{
                    area1.doms[i].updatecontent("");
					area1.doms[i].mylink = undefined;
				}
            }
            $('page').innerHTML = area1.curpage + "/" + pagecount;
        }

//填充推荐栏目		
function bindRmdData(itms,needlen){
	if(itms ==undefined){
		itms = jRmdlist;
	}
	area2.datanum = (itms.length==undefined)?0:itms.length;
	
	for(var i=0;i<needlen;i++){
		if(i<itms.length){
			area2.doms[i].mylink = "vod_turnpager.jsp?vodid="+itms[i].VODID+"&typeid=<%=subtypeId %>"+"&returnurl="+escape(location.href); 
			$('img' + i).src = itms[i].POSTERPATHS;
			$('img' + i).style.display = "block";
		}else{
			area2.doms[i].mylink = ""; 
			$('img' + i).src = "";
			$('img' + i).style.display = "none";
		}
	}
}
</script>
