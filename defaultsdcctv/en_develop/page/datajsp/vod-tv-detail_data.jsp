<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGErrorCode" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
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
	String catename = request.getParameter("catename");
	Integer vodid = request.getParameter("vodid")==null?1:Integer.parseInt(request.getParameter("vodid"));
	String typeid = request.getParameter("typeid")==null?"-1":request.getParameter("typeid");
	Integer sitcomIndex = request.getParameter("sitcomindex")==null?0:Integer.parseInt(request.getParameter("sitcomindex"));
	String sitcom = request.getParameter("sitcom");
	
	String returnurl = request.getParameter("returnurl")==null?"index.jsp?back=1":request.getParameter("returnurl");
	boolean isNeedToBuy = false;
	int pagecount = 1;
	int pagesize = 12;
	int curpage = 1;
	
	if(sitcom==null||"".equals(sitcom)){
		curpage = Integer.parseInt(request.getParameter("curpage")==null?"1":request.getParameter("curpage"));
	}else{
		curpage = (Integer.parseInt(sitcom)-1)/pagesize+1;  //当前页数
		sitcomIndex = Integer.parseInt(sitcom)-1-(curpage-1)*pagesize; //当前集数
	}
	
	JSONObject jsoncontentInfo = null;
	JSONArray json_aboutvods = null; 
	
	HashMap mediadetailInfo = (HashMap)metadata.getVodDetailInfo(vodid);
	boolean isfaved = false;
	if(mediadetailInfo!=null){
		HashMap postersMap = (HashMap)mediadetailInfo.get("POSTERPATHS");
		String picpath = (String)mediadetailInfo.get("PICPATH");
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
		String tempDir = (String)mediadetailInfo.get("DIRECTOR");
		tempDir = tempDir!=null?tempDir.trim():null;
		if(catename==null){
			if("-1".equals(typeid)){
				String[] allTypeids = (String[])mediadetailInfo.get("allTypeId");
				typeid = allTypeids[0];
				HashMap first_ptypemap = (HashMap)metadata.getTypeInfoByTypeId(typeid);
				if(first_ptypemap!=null){
					String first_ptypeid = (String)first_ptypemap.get("PARENTID");  //第一级父栏目
					if(!("-1".equals(first_ptypeid))){
						HashMap second_ptypemap = (HashMap)metadata.getTypeInfoByTypeId(first_ptypeid); //第二级父栏目
						if(second_ptypemap!=null){
							String second_ptypeid = (String)second_ptypemap.get("PARENTID");
							catename = (String)second_ptypemap.get("TYPENAME")+"-"+(String)first_ptypemap.get("TYPENAME");
							catename = catename.replace("s-","-");
						}else{
							catename = (String)first_ptypemap.get("TYPENAME");
						}
					}
				}
			}else{
				catename = "好片库";
			}
		}
		mediadetailInfo.put("POSTPATH","../"+postpath);
		mediadetailInfo.put("PICPATH","../"+picpath);
		mediadetailInfo.put("DIRECTOR",tempDir);
		String issitcom = mediadetailInfo.get("ISSITCOM").toString();
		
		ArrayList newArr = new ArrayList();
		if("0".equals(issitcom)){
			pagecount = 1;
			HashMap tempMap = new HashMap();
			tempMap.put("VODID",vodid);
			tempMap.put("VODNAME","播放");
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
					subVodNum = "00"+subVodNum;
					tempMap.put("VODNAME",subVodNum.substring(subVodNum.length()-3));
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
		
		//判断订购
		ServiceHelpHWCTC serviceHelpHWCTC = new ServiceHelpHWCTC(request);
		Map retMap = null;
	    HashMap resultMap = new HashMap();
		retMap = serviceHelpHWCTC.authorizationHWCTC(vodid,6, contenttype, 1,typeid,vodid);
		int retCode = EPGErrorCode.AUTHORIZATION_DATABASEERROR;   //初始化为数据库异常，防止出现空值
		if(null != retMap && null != retMap.get(EPGConstants.KEY_RETCODE))
		{
			retCode = ((Integer)retMap.get(EPGConstants.KEY_RETCODE)).intValue();
		}
		//授权通过
		if(retCode == EPGErrorCode.SUCCESS)
		{
			isNeedToBuy = false;
		}
		else
		{
			isNeedToBuy = true;
		}
	}
%>
var catename = '<%=catename %>';
var typeid = '<%=typeid %>';
var pvodid = '<%=vodid %>'; //传递过来的vodid
var returnurl = '<%=returnurl %>';
returnurl = returnurl+"&catename="+catename;
var isfaved = <%=isfaved %>;
var isNeedToBuy = <%=isNeedToBuy %>;
var jContent = <%=jsoncontentInfo%>;  //点播栏目列表
var contentype = jContent.CONTENTTYPE;
var subcount = jContent.SUBVODLIST.length;
var pagecount = <%=pagecount %>;
var curpage = <%=curpage %>;
var curindex = <%=sitcomIndex %>
var rsitcom = '<%=sitcom %>';       
//alert(pvodid+":"+jContent.CODE);
//填充一级栏目
//需要字段 :片长ELAPSETIME 价格VODPRICE 主演ACTOR
function bindContentData(itm) {
	/*if((area0 !=undefined) &&(area0.doms[0] !=undefined) ) //hxtwebkit
	area0.doms[0].mylink = "dibbling-tv-detail.jsp?catename="+catename+"&typeid="+typeid+"&vodid="+pvodid+"&returnurl="+escape(location.href);*/
	catename=unescape(catename); //ztewebkit
	$('catename').innerHTML = '点播-'+catename+'-';
	$("vodPst").src = itm.POSTPATH;
	itm.VODNAME = (itm.VODNAME==undefined||itm.VODNAME=="null")?"暂无":itm.VODNAME;
	itm.VODNAME = (getbytelength(itm.VODNAME)>25)?getcutedstring(itm.VODNAME,25):itm.VODNAME;
	$("vodName").innerHTML = itm.VODNAME;
	if(itm.SUBVODLIST.length<=3){
		//$("vodPrice").innerHTML = '<span class="th">售价：</span><span style="color: #7cc9e6;">'+(itm.SUBVODPRICE==undefined?0:itm.SUBVODPRICE)+'元';
	}else{
		//$("vodPrice").innerHTML = '<span class="th">售价：</span><span style="color: #7cc9e6;">'+(itm.SUBVODPRICE==undefined?0:itm.SUBVODPRICE)+'元/集&nbsp;'+(itm.VODPRICE==undefined?0:itm.VODPRICE)+'元/套</span>';
		$("vodSubcount").innerHTML = '<span class="th">集数：</span>'+subcount+'集';
	}
	itm.DIRECTOR = (itm.DIRECTOR==undefined||itm.DIRECTOR=="null")?"暂无":itm.DIRECTOR;
	itm.DIRECTOR = (getbytelength(itm.DIRECTOR)>13)?getcutedstring(itm.DIRECTOR,13):itm.DIRECTOR;
	$("vodDrt").innerHTML = '<span class="th">导演：</span>'+itm.DIRECTOR;
	$("vodAct").innerHTML = (itm.ACTOR==undefined)?"暂无":itm.ACTOR;
	itm.INTRODUCE = (itm.INTRODUCE==undefined||itm.INTRODUCE=="null")?"暂无简介":itm.INTRODUCE;
	itm.INTRODUCE = (getbytelength(itm.INTRODUCE)>143)?getcutedstring(itm.INTRODUCE,143):itm.INTRODUCE;
	$("vodItd").innerHTML = itm.INTRODUCE;
	$("area1_content_0").innerHTML = isfaved?"移除收藏":"收&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;藏";
	if(isNeedToBuy==true)
	{
	   $("area0_list_0").style.display="block";
	}
	else
	{
	   $("area0_list_0").style.display="none";
	}
}

function bindTvChooseData(itms){
	$('page').style.display = "block";
	area3.setpageturndata(itms.length, pagecount);
    for (i = 0; i < area3.doms.length; i++) {
    	if (i < itms.length) {
			area3.doms[i].setcontent("",itms[i].VODNAME,13);
			if(area3.doms[i].dom[0].style.display=="none"){
				area3.doms[i].dom[0].style.display = "block";
			}
			area3.doms[i].youwanaobj = itms[i].VODID;
       	}else{
            area3.doms[i].updatecontent("");
			area3.doms[i].dom[0].style.display = "none";
			area3.doms[i].youwanaobj = "";
		}
    }
    $('page').innerHTML = '<span class="current">'+area3.curpage+'</span>/' + pagecount;
}

function bindFilmChooseData(itms){
	$('page').style.display = "none";
	area3.setpageturndata(itms.length, pagecount);
	switch(itms.length){
		case 1:
			area3.doms[0].bindFilmChoose("播放",itms[0].VODID);
			break;
		case 2:
			area3.doms[0].bindFilmChoose("上集",itms[0].VODID);
			area3.doms[1].bindFilmChoose("下集",itms[1].VODID);
			break;
		case 3:
			area3.doms[0].bindFilmChoose("上集",itms[0].VODID);
			area3.doms[1].bindFilmChoose("中集",itms[1].VODID);
			area3.doms[2].bindFilmChoose("下集",itms[2].VODID);		
			break;
		default:
			break;
	}
}
</script>
