<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="datajsp/database1.jsp"%>
<script language="javascript" type="text/javascript" src="../../../defaultgdsd/en/js/pagecontrol.js"></script>
<script language="javascript" type="text/javascript">
<% 
  MetaData metadata = new MetaData(request);
  ArrayList array1=new MyUtil(request).getVasListData("10000100000000090000000000036097",6);
 String[] apppic=new String[6]; //获取海报
 String[] appurl=new String[6];
 String[] appintro=new String[6];
  ArrayList tmpvas=(ArrayList)metadata.getVasListByTypeId("10000100000000090000000000036097",6,0);  
if(tmpvas!=null)
{
ArrayList zt=(ArrayList)tmpvas.get(1);  int total=zt.size(); 
if(zt!=null&& zt.size()>0)

{
	for(int i=0;i<zt.size();i++)
{
		HashMap mapx=(HashMap)zt.get(i);
		int tempvasid=(Integer)mapx.get("VASID");
		Map map = metadata.getVasDetailInfo(tempvasid);
		apppic[i]=map.get("POSTERPATH").toString();
		System.out.println("=============================posterpath======================="+apppic[i]);
        ServiceHelp serviceHelp = new ServiceHelp(request);
        appurl[i]=serviceHelp.getVasUrl(tempvasid).toString();
}
}
}
%>
var list2=eval('('+'<%=array1.get(0)%>'+')');
var apppic=new Array();
<%for(int i=0;i<apppic.length;i++)
 {%>     
	apppic[<%=i%>]='<%=apppic[i]%>';  
<%}%>
var appurl=new Array();
<%for(int i=0;i<appurl.length;i++) 
{%>
    appurl[<%=i%>]='<%=appurl[i]%>'; 
<%}%>    
<%
   UserProfile upf_Jump = new UserProfile(request);
   String user = upf_Jump.getUserId();
  int curpage=1;
  int indexid=0;
  int areaid=0;
  if(request.getParameter("curpage")!=null)
  {
	 curpage = Integer.parseInt(request.getParameter("curpage"));
  }
  if(request.getParameter("indexid")!=null)
  {
	indexid = Integer.parseInt(request.getParameter("indexid"));
  }
  if(request.getParameter("areaid")!=null)
  {
	areaid = Integer.parseInt(request.getParameter("areaid"));
  }
%>
var jscurpage=<%=curpage%>;
if(parseInt(jscurpage)>2)
{
jscurpage=2;
}
var userid_str="<%=user%>";
var indexid=<%=indexid%>;
var areaid=<%=areaid%>;
var pos=0; 
var area0;
var STBType =Authentication.CTCGetConfig("STBType");
var pagecount=1;
var pagesize=6;
var appList=new Array();
var backurl="<%=request.getParameter("returnurl")==null?"index.jsp?back=1":request.getParameter("returnurl") %>";
var returnurl=unescape(window.location.href);
//初始化消费记录数组
function initAppList(){  
    
    	pos=jscurpage * pagesize - pagesize;
	appList=new Array(); 
}
//加载主数据
function loadBody() {
    initAppList();
	refreshServerTime();
	//构建菜单区域
    area0 = AreaCreator(2, 3, new Array(-1, -1, -1, -1), "area0_list_", "className:on", "className:bg");
    area0.setcrossturnpage();
    area0.stablemoveindex=new Array(-1,-1,"0-0>5",-1);
    area0.asyngetdata=function()
    {  
      jscurpage=area0.curpage;	  
	  area0.lockin=true;
       initAppList();
	  showCollectDel(list2,pagecount);
	  area0.lockin=false;	
   }
   area0.datanum = 6;
   //end
	pageobj = new PageObj(areaid, indexid, new Array(area0));
	pageobj.goBackEvent=function()
	{
	  window.location.href=backurl;
	}
	
	area0.curpage=jscurpage;
	
    showCollectDel(list2,pagecount);
}
//显示收藏列表
function showCollectDel(data,count){		 
	
	 area0.setpageturndata(data.length,parseInt(count));
	 for(var i=0;i<area0.doms.length;i++)
	 {
		 if(i<data.length)
		 {
			 area0.doms[i].imgdom=$("area0_img_"+i);
			 area0.doms[i].mylink="../../../"+appurl[i];//+location.href;
			 area0.doms[i].updateimg("../"+apppic[i]);
			 document.getElementById('area0_list_'+i).style.display = "";
		 }
		 else{
			   area0.doms[i].imgdom=$("area0_img_"+i);  
			   area0.doms[i].updateimg("../images/temp/dot.gif");
			   area0.doms[i].mylink="";
			   document.getElementById('area0_list_'+i).style.display = "none";
		 }
	 }
	 area0.lockin=false;
	 $("pageArea").innerHTML=area0.curpage+"/"+pagecount;
}
</script>

