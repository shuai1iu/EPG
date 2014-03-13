<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
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
<%@ include file="database.jsp"%>
<script type="text/javascript">
var jRecommlist,jRanklist,jTopiclist;
<%
	MetaData metadata = new MetaData(request);
	String returnurl = request.getParameter("returnurl")==null?"index.jsp?back=1":request.getParameter("returnurl");
	int[] intSubjectType = {9999};
	String typeid = request.getParameter("typeid")==null?"-1":request.getParameter("typeid");
	String myrecommcode = "-1",myrankcode = "-1",mytopiccode = "-1";
	if(filmtypeid.equals(typeid)){
		myrecommcode = filmrecommcode;
		myrankcode = filmrankcode;
		mytopiccode = filmtopiccode;
	}else if(hottypeid.equals(typeid)){
		myrecommcode = hotrecommcode;
		myrankcode = hotrankcode;
		mytopiccode = hottopiccode;
	}else if(animationtypeid.equals(typeid)){
		myrecommcode = animationrecommcode;
		myrankcode = animationrankcode;
		mytopiccode = animationtopiccode;
	}
	//获取栏目列表
	/*JSONArray jsoncatelist = null;
	
	ArrayList cateresultList = metadata.getTypeListByTypeId(typeid,-1,0,intSubjectType);
	if(cateresultList != null && cateresultList.size() > 1 && ((ArrayList)cateresultList.get(1)).size() > 0){
		ArrayList tempList = new ArrayList();
		ArrayList tempResultList = (ArrayList)cateresultList.get(1);
		for(int i = 0;i<tempResultList.size();i++){
			HashMap tempmap = new HashMap();
			HashMap mapx=(HashMap)tempResultList.get(i);
			tempmap.put("TYPE_ID",mapx.get("TYPE_ID").toString());
			tempmap.put("TYPE_NAME",mapx.get("TYPE_NAME").toString());		
			tempList.add(tempmap);		
		}	
		jsoncatelist = JSONArray.fromObject(tempList);
	}*/
	
	//获取推荐的3个影片
	ArrayList recommList=new MyUtil(request).getVodListData(myrecommcode,3);
	if(recommList!=null&&recommList.size()>0){
%>
	jRecommlist = eval('('+'<%=recommList.get(0)%>'+')'); //推荐影片列表
<%
	}
	//获取排行榜
	ArrayList rankList=new MyUtil(request).getVodListData(myrankcode,5);
	if(rankList!=null&&rankList.size()>0){
%>
	jRanklist = eval('('+'<%=rankList.get(0)%>'+')'); //排行榜列表
<%
	}
	//获取专题海报
	JSONArray jtopiclist = null;
	
	ArrayList topicresultList=(ArrayList)metadata.getVasListByTypeId(mytopiccode, 2, 0);
	if(topicresultList != null && topicresultList.size() > 1 && ((ArrayList)topicresultList.get(1)).size() > 0){
		ArrayList tempList = new ArrayList();
		ArrayList tempResultList = (ArrayList)topicresultList.get(1);
		for(int i = 0;i<tempResultList.size();i++){
			HashMap tempmap = new HashMap();
			HashMap mapx=(HashMap)tempResultList.get(i);
			tempmap.put("VASID",mapx.get("VASID").toString());
			tempmap.put("VASNAME",mapx.get("VASNAME").toString());	
			ServiceHelp serviceHelp = new ServiceHelp(request);				
			String vasurl=serviceHelp.getVasUrl((Integer)mapx.get("VASID"));
			tempmap.put("VASURL",vasurl);	
			Map map = metadata.getVasDetailInfo((Integer)mapx.get("VASID"));
		    tempmap.put("PICPATH",map.get("POSTERPATH").toString());
			tempList.add(tempmap);
		}
		jtopiclist = JSONArray.fromObject(tempList);
	}
	
%>
jTopiclist = <%=jtopiclist%>;  //专题列表
var returnurl = '<%=returnurl %>';
//填充栏目
/*
function bindCateData(data) {
	   catename=unescape(catename);  //ztewebkit
	    if(catename=="推荐栏目"){
			$('catename').innerHTML = '推荐栏目';
		}else{
			var tmpname=catename.split('-');
			$('catename').innerHTML = tmpname[0]+'-'+tmpname[1];
		}
        for (i = 0; i < area0.doms.length; i++) {
            if (i < data.length) {
				area0.doms[i].setcontent("",data[i].TYPE_NAME,12);
				area0.doms[i].mylink="vodlist.jsp?typeid="+data[i].TYPE_ID+"&returnurl="+location.href;
            }else{
                area0.doms[i].updatecontent("");
			}
        }
}*/
//填充推荐
function bindRecommData(data) {
	  for (i = 0; i < area1.doms.length; i++) {
            if (i < data.length) {
				area1.doms[i].setcontent("",data[i].VODNAME,12);
				area1.doms[i].updateimg("../"+(data[i].POSTERPATHS.type3[0]!=undefined?data[i].POSTERPATHS.type3[0]:(data[i].PICPATH!=undefined?data[i].PICPATH:'images/no_picture_259x232.jpg')));
			    area1.doms[i].mylink="vod-tv-detail.jsp?vodid="+data[i].VODID+"&typeid=<%=myrecommcode%>"+"&returnurl="+location.href;
            }else{
                area1.doms[i].updatecontent("");
				area1.doms[i].updateimg("#");
			}
     }
}
//填充专题
function bindTopicData(data){
		for(i=0;i<area3.doms.length;i++){
		   if(i<data.length){
			   area3.doms[i].updateimg("../"+data[i].PICPATH);
			   area3.doms[i].mylink = data[i].VASURL;
		   }else{
			   area3.doms[i].updateimg("#");
		   }
		}   
}

//填充排行榜
function bindRankData(data) {
        for (i = 0; i < area2.doms.length; i++) {
            if (i < data.length) {
				area2.doms[i].setcontent("",data[i].VODNAME,12);
				area2.doms[i].mylink="vod-tv-detail.jsp?vodid="+data[i].VODID+"&typeid=<%=myrankcode%>"+"&returnurl="+location.href;
            }else{
                area2.doms[i].updatecontent("");
			}
        }
}
</script>
