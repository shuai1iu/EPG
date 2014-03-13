<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.info.UserProfile" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.*" %>
<%@ include file="../../../defaultgdsd/en/page/datajsp/codepage.jsp"%>
<script language="javascript" type="text/javascript" src="../../../defaultgdsd/en/js/pagecontrol.js"></script>
<script language="javascript" type="text/javascript">
<%
   UserProfile upf_Jump = new UserProfile(request);
   String user = upf_Jump.getUserId();
   String groupId = upf_Jump.getUserGroupId();
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
var groupId_str="<%=groupId%>";
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
var totalAppList = [  
{title : '中国游戏中心',
	pic_path:'../../../defaultgdsd/en/images/szgd/07.jpg',
	url : 'http://183.60.28.26/gamePortal/homePageAction.do?method=all&inType=3&stbType='+STBType+'&user='+userid_str+'&enterURL='+location.href
},{title : '卡拉OK',
	pic_path:'../../../defaultgdsd/en/images/szgd/06.jpg',
	url : 'http://125.88.98.144:9090/gd/index.jsp?userID='+userid_str+'&endUrl='+location.href
},{title : '天翼相册',
	pic_path:'../../../defaultgdsd/en/images/szgd/tyxc.png',
	url : 'http://189pic.21cn.com/iptv/new/?endUrl='+location.href
}
];

var endurl = location.href;
endurl = endurl.substr(0,endurl.lastIndexOf("?"));

var totalAppList2 = [  
{title : '中国游戏中心',
	pic_path:'../../../defaultgdsd/en/images/szgd/07.jpg',
	url : 'http://183.60.28.26/gamePortal/homePageAction.do?method=all&inType=3&stbType='+STBType+'&user='+userid_str+'&enterURL='+location.href
},{title : '卡拉OK',
	pic_path:'../../../defaultgdsd/en/images/szgd/06.jpg',
	url : 'http://125.88.98.144:9090/gd/index.jsp?userID='+userid_str+'&endUrl='+location.href
},{title : '天翼相册',
	pic_path:'../../../defaultgdsd/en/images/szgd/tyxc.png',
	url : 'http://189pic.21cn.com/iptv/new/?endUrl='+location.href
},{title : '光明翠湖社区',
	pic_path:'industryAppImages/1232.jpg',
	url : 'http://14.29.1.13:8080/epg/login!index.action?tradeId=1232&itvUserId='+userid_str+"&endUrl="+endurl//'http://189pic.21cn.com/iptv/new/?endUrl='+location.href
}

];

//初始化消费记录数组
function initAppList(){  
    
    	pos=jscurpage * pagesize - pagesize;
	appList=new Array(); 
	if(groupId_str!=1232)
	{
	for(var i=pos;i<(pos+pagesize)&& i<totalAppList.length;i++)
	{
		appList.push(totalAppList[i]);
	}
	}
	else
	{
	for(var i=pos;i<(pos+pagesize)&& i<totalAppList2.length;i++)
	{
		appList.push(totalAppList2[i]);
	}
	}
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
	  showCollectDel(appList,pagecount);
	  area0.lockin=false;
	
   }
   area0.datanum = appList.length;
   //end
   
  
	
	pageobj = new PageObj(areaid, indexid, new Array(area0));
	pageobj.goBackEvent=function()
	{
	  window.location.href=backurl;
	}
	
	area0.curpage=jscurpage;
	
    showCollectDel(appList,pagecount);
}

 //点击跳转到其他的应用
function OkFun()
{   
   if(appList[pageobj.getfocusindex()].url=="#")
   {  
	   return;
   }
   else
   {
	  window.location.href =appList[pageobj.getfocusindex()].url;
   }
} 

//显示收藏列表
function showCollectDel(data,count){		 
	
	 area0.setpageturndata(data.length,parseInt(count));
	 for(var i=0;i<area0.doms.length;i++)
	 {
		 if(i<data.length)
		 {
			 area0.doms[i].contentdom=$("area0_txt_"+i);
			 area0.doms[i].imgdom=$("area0_img_"+i);
			 area0.doms[i].setcontent("·",data[i].title,12);
			 area0.doms[i].mylink="";
			 area0.doms[i].updateimg(data[i].pic_path);
			 document.getElementById('area0_list_'+i).style.display = "";
			 area0.doms[i].domOkEvent=function()
			 {
			   OkFun();
			 }
		 }
		 else{
			   area0.doms[i].contentdom=$("area0_txt_"+i);
			   area0.doms[i].imgdom=$("area0_img_"+i);  
			   area0.doms[i].updatecontent("");
			   area0.doms[i].updateimg("../images/temp/dot.gif");
			   area0.doms[i].mylink="";
			   document.getElementById('area0_list_'+i).style.display = "none";
		 }
	 }
	 area0.lockin=false;
	 $("pageArea").innerHTML=area0.curpage+"/"+pagecount;
}
</script>

