<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
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
	ServiceHelp serviceHelp = new ServiceHelp(request);
	String typeid = "-1";
	String postertype = "3";
	String returnurl = request.getParameter("returnurl")==null?"index.jsp?back=1":request.getParameter("returnurl");
	
	int countTotal = 0;
	int pagecount = 0;    //页数
	int pagesize = 8;    //每页数据量
	String str="";
	int [] intSubjectType = {9999,10}; //只需要混合类型的
	int typeFlag = 0; //是否显示定制栏目 0.非定制栏目 1.定制栏目 2.所有栏目
	int contentType = 0; //子栏目视频类型
	List markArray = Arrays.asList("0-0","0-1","2-0","2-1"); //判断区域此标签为标清本地需显示的
	//System.out.println("======================MMMAAARRRKKKAAARRRRRRRAAAYYY============="+markArray);
	int curindex = Integer.parseInt(request.getParameter("curindex")==null?"0":request.getParameter("curindex"));
	
	if(focstr!=null){
		String focObj = String.valueOf(getState(analyticFocStr(focstr),"0","curpage"));
		int cur_area0_page = (focObj==null||focObj.equals("null"))?1:Integer.parseInt(focObj);
		focObj = String.valueOf(getState(analyticFocStr(focstr),"0","curindex"));
		int cur_area0_index = (focObj==null||focObj.equals("null"))?0:Integer.parseInt(focObj);
		curindex = (cur_area0_page-1)*pagesize+cur_area0_index;
	}
	
	JSONArray jsontypelist = null; //一级栏目列表	
	JSONArray jsoncatelist = null; //二级栏目列表
	JSONArray jsonrmdlist = null;//推荐节目列表

	ArrayList fullTypeList = new ArrayList();

	//获取VAS列表
	ArrayList vasresultList = metadata.getVasListByTypeId("10000100000000090000000000028311",-1,0);	
	//System.out.println("==========VASresultlist1111=============="+vasresultList);

	ArrayList VasAddList = metadata.getVasListByTypeId("10000100000000090000000000037210",6,0);
	if(null!=VasAddList&&VasAddList.size()>0)
	{
        ArrayList VasAddListContent = (ArrayList)VasAddList.get(1);
	    for(int i=0;i<VasAddListContent.size();i++)
		{
		    HashMap tempMap = (HashMap)VasAddListContent.get(i);
			//"ISVAS" 是否是新增vas 1为是 0代表不是
			HashMap tempResultMap = new HashMap();
			tempResultMap.put("ISVAS",1);
			tempResultMap.put("VAS_ID",(Integer)tempMap.get("VASID"));
			tempResultMap.put("TYPE_NAME",(String)tempMap.get("VASNAME"));
			tempResultMap.put("URL",serviceHelp.getVasUrl((Integer)tempMap.get("VASID")).toString());
			//获得图片路径
			fullTypeList.add(tempResultMap);
		}
	System.out.println("==============================fulltypelisth hahah=================="+fullTypeList);
	
	
	}
	//获取栏目列表
	ArrayList typeresultList = metadata.getTypeListByTypeId("-1",-1,0,intSubjectType,typeFlag); //获取根目录全部
	
	if(typeresultList!=null&&typeresultList.size()>0){
		ArrayList newresultList=(ArrayList)typeresultList.get(1);
		for(int i=0;i<newresultList.size();i++){
			HashMap tempMap = (HashMap)newresultList.get(i);
			
			String introduce = (String)tempMap.get("TYPE_INTRODUCE");	
			if(introduce!=null&&markArray.contains(introduce)){
				HashMap resultMap = new HashMap();
				resultMap.put("ISVAS",0);
				resultMap.put("TYPE_ID",(String)tempMap.get("TYPE_ID"));
				resultMap.put("TYPE_NAME",(String)tempMap.get("TYPE_NAME"));
				fullTypeList.add(resultMap);
					
			}
		}
	}
	ArrayList resultList=new ArrayList();
	HashMap mcount=new HashMap();
	mcount.put("COUNTTOTAL",fullTypeList.size());
	resultList.add(mcount);
	//System.out.println("==========resultlist1111=============="+resultList);
	resultList.add(fullTypeList);
	//System.out.println("==========resultlist2222=============="+resultList);
	if(resultList == null || resultList.size() < 2 || ((ArrayList)resultList.get(1)).size() == 0)
	{
		str ="暂无数据";
	}else{
		ArrayList typeList = (ArrayList)resultList.get(1);
		jsontypelist = JSONArray.fromObject(typeList);
		//System.out.println("==========JSONTYPELIST=============="+jsontypelist);
		int typeSize = typeList.isEmpty()? 0: typeList.size();
		int count = ((Integer)((HashMap)resultList.get(0)).get("COUNTTOTAL")).intValue(); //总数量
		pagecount = (count-1)/pagesize+1;
	}
	
	
	int catepagecount = 1;    //页数
	int catepagesize = 12;
	int rmdpagesize = 3;
	
	//获取当前焦点typeid
	HashMap tMap = (HashMap)fullTypeList.get(curindex);
	
 if((Integer)tMap.get("ISVAS")==0)
{
	typeid=(String)tMap.get("TYPE_ID");
	//获取栏目列表
	ArrayList cateresultList = metadata.getTypeListByTypeId(typeid,-1,0,intSubjectType,typeFlag);
	if(cateresultList != null && cateresultList.size() > 1 && ((ArrayList)cateresultList.get(1)).size() > 0)
	{
		
		ArrayList tempList = new ArrayList();
		for(Object obj : ((ArrayList)cateresultList.get(1))){
			HashMap tempmap = new HashMap();
			tempmap.put("ISPIC",0);
			tempmap.put("TYPE_ID",((HashMap)obj).get("TYPE_ID").toString());
			tempmap.put("TYPE_NAME",((HashMap)obj).get("TYPE_NAME").toString());
			tempList.add(tempmap);
		}
		int count = ((Integer)((HashMap)cateresultList.get(0)).get("COUNTTOTAL")).intValue(); //总数量
//		System.out.println("-------------------------------------------------------------------"+tempList);
		catepagecount = (count-1)/catepagesize+1;
		jsoncatelist = JSONArray.fromObject(tempList);
	}
}
 else
 {
     int addVasId = (Integer)tMap.get("VAS_ID");
	 HashMap addVasMapInfo = (HashMap)metadata.getVasDetailInfo(addVasId);
	 HashMap posterMap = (HashMap)addVasMapInfo.get("POSTERPATHS");
	 String postPath = (String)addVasMapInfo.get("POSTERPATH");
	 String addVasPic =  getPosterPath(posterMap,request,postPath,"0").toString();
	 HashMap tempMap = new HashMap();
	 tempMap.put("ISPIC",1);
	 tempMap.put("PICPATH","../"+addVasPic);
	 jsoncatelist = JSONArray.fromObject(tempMap);
//	 System.out.println("===========================hahahah===================="+jsoncatelist);
	 catepagecount = 1;    //页数
	 catepagesize = 1;
 }
	
	//获取推荐栏目
	String rmdtypeid = 	dianbocode;
	ArrayList rmdlist = (ArrayList)metadata.getVodListByTypeId(rmdtypeid,rmdpagesize,0);
	if(rmdlist!=null && rmdlist.size() > 1 && ((ArrayList)rmdlist.get(1)).size() > 0){
		ArrayList tempList = new ArrayList();
		for(Object obj : ((ArrayList)rmdlist.get(1))){
			HashMap tempmap = new HashMap();
			HashMap postersMap = (HashMap)(((HashMap)obj).get("POSTERPATHS"));
			String picpath = ((HashMap)obj).get("PICPATH").toString();
			String postpath =  getPosterPath(postersMap,request,picpath,postertype).toString();
			String tmptypeid = ((HashMap)obj).get("VODID").toString();
			String tmptypename = ((HashMap)obj).get("VODNAME").toString();
			tempmap.put("VODID",tmptypeid);	
			tempmap.put("VODNAME",tmptypename);		
			tempmap.put("POSTERPATHS","../"+postpath);
			tempmap.put("PICPATH","../"+picpath);
			tempList.add(tempmap);
		}
		jsonrmdlist = JSONArray.fromObject(tempList);
		System.out.println("==========myfavarote=============="+jsonrmdlist);
	}

	//拼接Json
	String contentsJson="({jsoncatelist:"+jsoncatelist+",jsonrmdlist:"+jsonrmdlist+"})";
	 //System.out.println("==========CONTENTSJSON=============="+contentsJson);
%>

var israndom = false;
var returnurl='<%=returnurl %>';
var pagesize = <%=pagesize %>;
var pagecount = <%=pagecount %>;
var catepagecount = <%=catepagecount %>;
var jTypelist = <%=jsontypelist%>;  //点播栏目列表
var jContents = '<%=contentsJson %>';
var jCatelist = '';
var jRmdlist='';    //点播和推荐节目json字符串
//填充一级栏目
function bindTypeData(itms) {
        area0.setpageturndata(itms.length, pagecount);
        for (i = 0; i < area0.doms.length; i++) {
            if (i < itms.length) {
				area0.doms[i].setcontent("",itms[i].TYPE_NAME,12);
				area0.doms[i].dataurlorparam = itms[i].TYPE_ID;
				if(itms[i].ISVAS==1)
				{
			       //  area0.doms[i].mylink = "../../../../"+itms[i].URL;
				area0.doms[i].mylink = "sztvpgq/page/activityyifang.jsp";
				$("test").innerHTML = itms[i].URL;
				 area0.doms[i].dataurlorparam = itms[i].VAS_ID	 
				}
				else
				{
				    area0.doms[i].mylink = "";
				}  
            }else{
                area0.doms[i].updatecontent("");
				area0.doms[i].dataurlorparam = -2;
			}
        }
}

//填充二级栏目
function bindCateData(itms) {

			area1.setpageturndata(itms.length, catepagecount);
                        if(itms.length>1)
                       {

			var catename = jTypelist[((area0.curpage-1)*area0.doms.length+area0.curindex)].TYPE_NAME;
					   area1.doms[0].imgdom = $("area1_pic");
                                           area1.doms[0].updateimg("../images/t.gif");
			$("area1_list_0").style.width = "105px";
			$("area1_list_0").style.height = "37px";
			for (i = 0; i < area1.doms.length; i++) {
				if (i < itms.length) 
				{		 
			                    
					    area1.doms[i].setcontent("",itms[i].TYPE_NAME,10);
					    area1.doms[i].mylink = "vod_turnpager.jsp?catename="+escape(catename+"-"+itms[i].TYPE_NAME)+"&typeid="+itms[i].TYPE_ID+"&returnurl="+escape(location.href);
					    area1.doms[i].youwanaobj = itms[i].TYPE_ID;
				//		$("test").innerHTML = i;
				    
				}
				else
				{
					area1.doms[i].updatecontent("");
					area1.doms[i].mylink = "";
					area1.doms[i].youwanaobj = -2;
				}
			  }	
			var startPos = 190+((280-42*catepagecount)/2);
			var strHTML = "";
			for(var i=0;i<catepagecount;i++){
				if(i==(area1.curpage-1)){
					strHTML +=('<div class="item item_select" style="left:'+(startPos+42*i)+'px;"><div class="link"><img src="../images/t.gif" /></div><div class="txt" id="catepage'+i+'">'+(i+1)+'</div></div>');
				}else{
					//alert(startPos+42*i);
					strHTML +=('<div class="item" style="left:'+(startPos+42*i)+'px;"><div class="link"><img src="../images/t.gif" /></div><div class="txt" id="catepage'+i+'">'+(i+1)+'</div></div>');
				}			
			  }
			$('catepage').innerHTML = strHTML;	
		       }
		      else
                      {
			   $("area1_list_0").style.width = "220px";
			   $("area1_list_0").style.height = "200px";
		           $("area1_list_0").style.display = "block"
                           area1.doms[0].imgdom=$("area1_pic");
			   area1.doms[0].updateimg(itms[0].PICPATH);
			  
			 //area1.doms[0].updateimg("../../../images/universal/film/poster/iptvcms/server/default/deploy/cms.war/upload/poster/201312/IMG20131220182656355387_ppppppppppppp153x116.jpg");
		//	  $("test").innerHTML = itms[0].PICPATH; 
			   area1.doms[0].mylink = itms[0].URL;
			for( i = 0 ; i<area1.doms.length;i++ )
                        {
                            area1.doms[i].updatecontent("");
		            area1.doms[i].mylink = "";
                            area1.doms[i].youwanaobj = -2;
                        }
			$('catepage').innerHTML = "";
                      }
}

//填充推荐栏目		
function bindRmdData(itms,needlen){
	area2.datanum = (itms.length==undefined)?0:itms.length;	
	for(var i=0;i<needlen;i++){
		if(i<itms.length){
			area2.doms[i].mylink = "vod-tv-detail.jsp?vodid="+itms[i].VODID+"&ptypeid=<%=typeid %>&typeid="+area1.doms[area1.curindex].youwanaobj+"&returnurl="+escape(location.href); 
		//	$("test").innerHTML = area2.doms[i].mylink;
			//area2.doms[i].setcontent("",itms[i].VODNAME,12);
			area2.doms[i].updateimg(itms[i].POSTERPATHS);
			if($('area2_' + i)!=undefined)
			$('area2_' + i).style.display = "block";  //ztewebkit
		}else{
			area2.doms[i].mylink = "";
			area2.doms[i].updateimg("");
			area2.doms[i].updatecontent("");
			if($('area2_' + i)!=undefined)  //ztewebkit
			$('area2_' + i).style.display = "none";
		}
	}
}
</script>
