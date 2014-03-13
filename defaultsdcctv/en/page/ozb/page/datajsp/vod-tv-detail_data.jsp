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
	String catename = request.getParameter("catename")==null?"":request.getParameter("catename"); 
	Integer vodid = request.getParameter("vodid")==null?1:Integer.parseInt(request.getParameter("vodid"));
	String typeid = request.getParameter("typeid")==null?"-1":request.getParameter("typeid");
	Integer sitcomIndex = request.getParameter("sitcomindex")==null?0:Integer.parseInt(request.getParameter("sitcomindex"));
	String sitcom = request.getParameter("sitcom");
	String recommendtypeid=Vod_Recommend;
	String returnurl = request.getParameter("returnurl")==null?"index.jsp?back=1":request.getParameter("returnurl");
	
	String focObj ="";
	
	boolean isNeedToBuy = false;
	int pagecount = 1;
	int pagesize = 9;
	int curpage = 1;
	int areaid=1;
	int indexid=0;
	int area2curindex=0;       //推荐位海报位置
    int area1curindex=0;
	
	/*if(sitcom==null||"".equals(sitcom)){
		curpage = Integer.parseInt(request.getParameter("curpage")==null?"1":request.getParameter("curpage"));
	}else{
		curpage = Integer.parseInt(sitcom)/pagesize+1;  //当前页数
		sitcomIndex = Integer.parseInt(sitcom)%pagesize-1; //当前集数
	}*/
	curpage=1;
	
	if(focstr!=null){
	    focObj = String.valueOf(getState(analyticFocStr(focstr),"2","curindex"));
		area2curindex = (focObj==null||focObj.equals("null"))?0:Integer.parseInt(focObj);
	     if(focObj!=null&&(!focObj.equals("null"))){
			 areaid=2;
			 indexid=area2curindex;
		}
		focObj = String.valueOf(getState(analyticFocStr(focstr),"1","curindex"));
		area1curindex = (focObj==null||focObj.equals("null"))?0:Integer.parseInt(focObj);
	     if(focObj!=null&&(!focObj.equals("null"))){
			 areaid=1;
			 indexid=area1curindex;
		}
		
	}
	
	JSONObject jsoncontentInfo = null;
	JSONArray json_aboutvods = null; 
	
	HashMap mediadetailInfo = (HashMap)metadata.getVodDetailInfo(vodid);
	boolean isfaved = false;
	if(mediadetailInfo!=null){
		HashMap postersMap = (HashMap)mediadetailInfo.get("POSTERPATHS");
		String picpath = getPicPath(request,(String)mediadetailInfo.get("PICPATH"));
		String postpath = getPosterPath(postersMap,request,"absolute","5").toString();
		if("".equals(catename)){
			if(!("-1".equals(typeid))){
				HashMap first_ptypemap = (HashMap)metadata.getTypeInfoByTypeId(typeid);
				if(first_ptypemap!=null){
					String first_ptypeid = (String)first_ptypemap.get("PARENTID");  //第一级父栏目
					if(!("-1".equals(first_ptypeid))){
						HashMap second_ptypemap = (HashMap)metadata.getTypeInfoByTypeId(first_ptypeid); //第二级父栏目
						if(second_ptypemap!=null){
							String second_ptypeid = (String)second_ptypemap.get("PARENTID");
							catename = (String)second_ptypemap.get("TYPENAME")+">"+(String)first_ptypemap.get("TYPENAME");
							catename = catename.replace("s-","-");
						}else{
							catename = (String)first_ptypemap.get("TYPENAME");
						}
					}
				}
				else{
					 catename = "搜索结果";
				}
			}else{
				catename = "搜索结果";
			}
		}
		else{
			
			catename = "搜索结果";
		}
		mediadetailInfo.put("POSTPATH",postpath);
		mediadetailInfo.put("PICPATH",picpath);
		String issitcom = mediadetailInfo.get("ISSITCOM").toString();
		
		ArrayList newArr = new ArrayList();
		if("0".equals(issitcom)){
			pagecount = 1;
			HashMap tempMap = new HashMap();
			tempMap.put("VODID",vodid);
			tempMap.put("VODNAME","1");
			newArr.add(tempMap);
		}else{
			ArrayList subVodIdlist = (ArrayList)mediadetailInfo.get("SUBVODIDLIST");
			ArrayList subVodNumlist = (ArrayList)mediadetailInfo.get("SUBVODNUMLIST");
			if(subVodIdlist!=null&&subVodNumlist!=null){
				pagecount = (subVodIdlist.size()-1)/pagesize+1;
				for(int i=0;i<subVodIdlist.size();i++){
					HashMap tempMap = new HashMap();
					if(i==0){
						//获取子集价格
						mediadetailInfo.put("SUBVODPRICE",metadata.getVodPriceByVodId((Integer)subVodIdlist.get(i)));
					}
					tempMap.put("VODID",subVodIdlist.get(i));
					String subVodNum = subVodNumlist.get(i).toString();
					subVodNum = subVodNum;
					tempMap.put("VODNAME",subVodNum);
					newArr.add(tempMap);
				}
			}
		}
		mediadetailInfo.put("SUBVODLIST",newArr);
		
		jsoncontentInfo = JSONObject.fromObject(mediadetailInfo);	 //转化为JSON对象
		ServiceHelp shelper = new ServiceHelp(request);
		int contentid = Integer.parseInt(mediadetailInfo.get("VODID").toString());
		int contenttype = Integer.parseInt(mediadetailInfo.get("CONTENTTYPE").toString());
		isfaved = shelper.isFavorited(contentid,contenttype);  //是否已收藏
	
	}
	ArrayList vodlist = (ArrayList)metadata.getVodListByTypeId(Vod_Recommend,5,0);
		if(vodlist!=null && vodlist.size() > 1 && ((ArrayList)vodlist.get(1)).size() > 0){
			ArrayList tempList = new ArrayList();
			ArrayList vod_list = (ArrayList)vodlist.get(1);
			for(int i = 0;i<vod_list.size();i++){
				Object obj = vod_list.get(i);
				HashMap tempmap = new HashMap();
				String tmpvodid = ((HashMap)obj).get("VODID").toString();
				String tmpvodname = ((HashMap)obj).get("VODNAME").toString();
				HashMap postersMap = (HashMap)(((HashMap)obj).get("POSTERPATHS"));
		    	String picpath = ((HashMap)obj).get("PICPATH").toString();
			    String postpath =  getPosterPath(postersMap,request,"absolute",postertype).toString();
				
				tempmap.put("VODID",tmpvodid);	
				tempmap.put("VODNAME",tmpvodname);
				tempmap.put("POSTERPATHS",postpath);
			    tempmap.put("PICPATH",picpath);	
				tempList.add(tempmap);
			}
			json_aboutvods = JSONArray.fromObject(tempList);
	}
%>

var catename = '<%=catename %>';
var typeid = '<%=typeid %>';
var pvodid = '<%=vodid %>'; //传递过来的vodid
var returnurl = '<%=returnurl %>';
var isfaved = <%=isfaved %>;
var isNeedToBuy = <%=isNeedToBuy %>;
var jContent = <%=jsoncontentInfo%>;  //点播栏目列表
var json_aboutvods=<%=json_aboutvods%>;
var contentype = jContent.CONTENTTYPE;
var subcount = jContent.SUBVODLIST.length;
var pagecount = <%=pagecount %>;
var curpage = <%=curpage %>;
var curindex = <%=sitcomIndex %>
var rsitcom = '<%=sitcom %>';       
var areaid=<%=areaid %>;
var indexid=<%=indexid %>;
var focstr='<%=focstr %>';
var focObj="<%=focObj %>";
//alert(pvodid+":"+jContent.CODE);看到这里了
//填充一级栏目
//需要字段 :片长ELAPSETIME 价格VODPRICE 主演ACTOR
function bindContentData(itm) {
	$('catename').innerHTML = '点播>'+catename;
    $("vodPst").src = itm.PICPATH;
	// alert(itm.PICPATH);
	itm.VODNAME = (itm.VODNAME==undefined||itm.VODNAME=="null")?"暂无":itm.VODNAME;
	itm.VODNAME = (getbytelength(itm.VODNAME)>25)?getcutedstring(itm.VODNAME,25):itm.VODNAME;
	$("vodName").innerHTML = itm.VODNAME;
	
	itm.INTRODUCE = (itm.INTRODUCE==undefined||itm.INTRODUCE=="null")?"暂无简介":itm.INTRODUCE;
	itm.INTRODUCE = (getbytelength(itm.INTRODUCE)>143)?getcutedstring(itm.INTRODUCE,143):itm.INTRODUCE;
	$("vodItd").innerHTML = itm.INTRODUCE;
	
	$("area0_img_1").src = isfaved?"../images/btn-favorites-del.png":"../images/btn-favorites.png";
}


function bindTvChooseData(itms){
	
	area1.setpageturndata(itms.length, pagecount);
 
    for (i = 0; i < area1.doms.length; i++) {
    	if (i < itms.length) {
			
			area1.doms[i].setcontent("",itms[i].VODNAME,13);
			if($("area1_list_"+i).style.display=="none"){
				$("area1_list_"+i).style.display = "block";
			}
			area1.doms[i].youwanaobj = itms[i].VODID;
       	}else{
            area1.doms[i].updatecontent("");
			$("area1_list_"+i).style.display = "none";
			area1.doms[i].youwanaobj = "";
		}
    }
  
}

function bindTuijData(itms){
	 area2.setpageturndata(itms.length, 1);
     for (i = 0; i < area2.doms.length; i++) {
            if (i < itms.length) {
			    area2.doms[i].updateimg(itms[i].POSTERPATHS);
				area2.doms[i].youwanaobj = itms[i].VODID;
				if($('area2_list_'+i).style.display=="none"){
					 $('area2_list_'+i).style.display = "block";	
				}
		    }else{
                area2.doms[i].updatecontent("");
		    	$('area2_list_'+i).style.display = "none";	
		
			    area2.doms[i].updateimg("#");
			}
		
     }
}

</script>