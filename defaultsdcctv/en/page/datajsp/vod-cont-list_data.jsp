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
	String typeid= request.getParameter("typeid")==null?"-1":request.getParameter("typeid");
	String catename = request.getParameter("catename");	
	Integer cur_area0_page = null; //当前页
	Integer cur_area0_index = null; //当前下标
	Integer curcateindex = request.getParameter("curcateindex")==null?0:Integer.parseInt(request.getParameter("curcateindex"));  //当前选中栏目下标
	String curtypeid = request.getParameter("curtypeid");
	String returnurl = request.getParameter("returnurl")==null?"index.jsp?back=-1":request.getParameter("returnurl");
	
	int catepagecount = 0;   //栏目总页数
	int vodpagecount = 0;    //栏目总页数
	int catepagesize = 8; 	 //每页栏目数据量
	int vodpagesize = 8; 	 //每页栏目数据量
	int[] intSubjectType = {9999};
	
	if(focstr!=null){
		String focObj = String.valueOf(getState(analyticFocStr(focstr),"0","curpage"));
		cur_area0_page = (focObj==null||focObj.equals("null"))?1:Integer.parseInt(focObj);
		focObj = String.valueOf(getState(analyticFocStr(focstr),"0","curindex"));
		cur_area0_index = (focObj==null||focObj.equals("null"))?0:Integer.parseInt(focObj);
		curcateindex = (cur_area0_page-1)*catepagesize+cur_area0_index;
		focObj = String.valueOf(getState(analyticFocStr(focstr),"1","curyouwanaobj"));
		curtypeid = (focObj==null||focObj.equals("null"))?null:focObj;
	}
	
	JSONArray jsoncatelist = null;
	JSONArray jsonvodlist = null;
	
	//获取栏目列表
	
	ArrayList cateresultList = metadata.getTypeListByTypeId(typeid,-1,0,intSubjectType);
	if(cateresultList != null && cateresultList.size() > 1 && ((ArrayList)cateresultList.get(1)).size() > 0){
		ArrayList tempList = new ArrayList();
		int count = ((Integer)((HashMap)cateresultList.get(0)).get("COUNTTOTAL")).intValue(); //总数量
		catepagecount = (count-1)/catepagesize+1;
		if(curcateindex!=null&&curcateindex>=count){
			curcateindex = count-1;
		}	
		for(int i = 0;i<((ArrayList)cateresultList.get(1)).size();i++){
			
			HashMap tempmap = new HashMap();
			Object obj = ((ArrayList)cateresultList.get(1)).get(i);
			String temp_typeid = ((HashMap)obj).get("TYPE_ID").toString();
			
			if(curtypeid==null && curcateindex !=null && i == curcateindex){
				curtypeid = temp_typeid;
			}else if(curcateindex == null&&curtypeid!=null&&curtypeid.equals(temp_typeid)){
				curcateindex = i;
			}
			tempmap.put("TYPE_ID",temp_typeid);
			tempmap.put("TYPE_NAME",((HashMap)obj).get("TYPE_NAME").toString());		
			tempList.add(tempmap);		
		}	
		jsoncatelist = JSONArray.fromObject(tempList);
	}
	
	if(curcateindex!=null&&cur_area0_page==null&&cur_area0_index==null){
		cur_area0_page = curcateindex/catepagesize+1;
		cur_area0_index = curcateindex%catepagesize;
	}else if(cur_area0_page==null&&cur_area0_index==null){
		cur_area0_page = 1;
		cur_area0_index = 0;
	}
	
	//获取当前栏目内容
	int isSubTypeOrContent = metadata.getSubTypeOrContent(curtypeid); //获取下级栏目类型（0.内容，1.栏目）
	if(isSubTypeOrContent==0){
		ArrayList vodresultlist = (ArrayList)metadata.getVodListByTypeId(curtypeid,-1,0);
		if(vodresultlist!=null && vodresultlist.size() > 1 && ((ArrayList)vodresultlist.get(1)).size() > 0){
			ArrayList tempList = new ArrayList();
			int count = ((Integer)((HashMap)vodresultlist.get(0)).get("COUNTTOTAL")).intValue(); //总数量
			vodpagecount = (count-1)/vodpagesize+1;
			for(Object obj : ((ArrayList)vodresultlist.get(1))){
				HashMap tempmap = new HashMap();
				String tmptypeid = ((HashMap)obj).get("VODID").toString();
				String tmptypename = ((HashMap)obj).get("VODNAME").toString();
				tempmap.put("VODID",tmptypeid);	
				tempmap.put("VODNAME",tmptypename);		
				tempList.add(tempmap);
			}
			jsonvodlist = JSONArray.fromObject(tempList);
		}
	}else if(isSubTypeOrContent==1){
		ArrayList typeresultList = metadata.getTypeListByTypeId(curtypeid,-1,0,intSubjectType);
		if(typeresultList != null && typeresultList.size() > 1 && ((ArrayList)typeresultList.get(1)).size() > 0){
			int count = ((Integer)((HashMap)typeresultList.get(0)).get("COUNTTOTAL")).intValue(); //总数量
			vodpagecount = (count-1)/vodpagesize+1;
			ArrayList tempList = new ArrayList();
			for(int i = 0;i<((ArrayList)typeresultList.get(1)).size();i++){	
				HashMap tempmap = new HashMap();
				Object obj = ((ArrayList)typeresultList.get(1)).get(i);
				tempmap.put("TYPE_ID",((HashMap)obj).get("TYPE_ID").toString());
				tempmap.put("TYPE_NAME",((HashMap)obj).get("TYPE_NAME").toString());		
				tempList.add(tempmap);		
			}
			jsonvodlist = JSONArray.fromObject(tempList);
		}
	}else if(isSubTypeOrContent==0x07010000){}//为空暂不处理
	
	if(catename==null){
		catename = "推荐栏目";
	}
%>
var returnurl = '<%=returnurl %>';
var catepagesize = <%=catepagesize %>; 	 //每页栏目数据量
var vodpagesize = <%=vodpagesize %>;	 //每页栏目数据量
var catepagecount = <%=catepagecount %>;
var vodpagecount = <%=vodpagecount %>;
var jCatelist = <%=jsoncatelist%>;  //栏目列表
var jVodlist = <%=jsonvodlist%>;    //节目列表
var catename = '<%=catename %>';
var cur_area0_page = <%=cur_area0_page %>;
var cur_area0_index = <%=cur_area0_index %>;
//填充栏目
function bindCateData(itms) {
	   catename=unescape(catename);  //ztewebkit
	    if(catename=="推荐栏目"){
			$('catename').innerHTML = '<span>点播-推荐栏目';
		}else{
			var tmpname=catename.split('-');
			$('catename').innerHTML = '<span>点播-'+tmpname[0]+'-</span>'+tmpname[1];
		}
        area0.setpageturndata(itms.length, catepagecount);
        for (i = 0; i < area0.doms.length; i++) {
            if (i < itms.length) {
				area0.doms[i].setcontent("",itms[i].TYPE_NAME,12);
				area0.doms[i].dataurlorparam = itms[i].TYPE_ID;
            }else{
                area0.doms[i].updatecontent("");
				area0.doms[i].dataurlorparam = -2;
			}
        }
		$('catalogspage').innerHTML = '<span class="current">'+area0.curpage+'</span>/'+(catepagecount==undefined?1:catepagecount);
}

//填充节目
function bindVodData(itms) {
        area1.setpageturndata(itms.length, vodpagecount);
        for (i = 0; i < area1.doms.length; i++) {
            if (i < itms.length) {
				if(itms[i].VODNAME != undefined){
					area1.doms[i].setcontent("",itms[i].VODNAME,24);
					area1.doms[i].mylink = "vod-zt-detail.jsp?catename=<%=catename %>&typeid="+ area0.doms[area0.curindex].dataurlorparam+"&vodid="+itms[i].VODID+"&returnurl="+escape(location.href);
					area1.doms[i].youwanaobj = itms[i].VODID;
				}else if(itms[i].TYPE_NAME != undefined){
					area1.doms[i].setcontent("",itms[i].TYPE_NAME,24);
					area1.doms[i].mylink = "vod_turnpager.jsp?catename="+escape(catename+"-"+itms[i].TYPE_NAME)+"&typeid="+itms[i].TYPE_ID+"&returnurl="+escape(location.href);
					area1.doms[i].youwanaobj = itms[i].TYPE_ID;
				}
            }else{
                area1.doms[i].updatecontent("");
				area1.doms[i].mylink = undefined;
				area1.doms[i].youwanaobj = -2;
			}
        }
        $('vodspage').innerHTML = '<span class="current">'+area1.curpage+'</span>/'+((vodpagecount==undefined || isNaN(vodpagecount))?1:vodpagecount); //(vodpagecount==undefined?1:vodpagecount);
}
</script>
