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
 ArrayList array1=new MyUtil(request).getVasListData("10000100000000090000000000035250",5);
 String[] apppic=new String[5]; //获取海报
 String[] appurl=new String[5];
 String[] appintro=new String[5];
  ArrayList tmpvas=(ArrayList)metadata.getVasListByTypeId("10000100000000090000000000035250",5,0);  
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
          //    appintro[i]=map.get("INTRODUCE").toString();
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
var groupId_str="<%=groupId%>";//alert(groupId_str);
var indexid=<%=indexid%>;
var areaid=<%=areaid%>;
var pos=0; 
var area0;
var STBType =Authentication.CTCGetConfig("STBType");
var pagecount=1;
var pagesize=6;
var appnum=0;
var appList=new Array();
var backurl="<%=request.getParameter("returnurl")==null?"index.jsp?back=1":request.getParameter("returnurl") %>";
alert(backurl);var returnurl=unescape(window.location.href);
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
	//  showCollectDelhy(listhy,pagecount);
	  showCollectDel(list2,pagecount);
          if(groupId_str==1232)
          showCollectDelhy(pagecount);
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
//    showCollectDelhy(listhy);
    showCollectDel(list2,pagecount);
    if(groupId_str==1232)
     showCollectDelhy(pagecount);

}


function showCollectDelhy(count){		 
           	
	          area0.setpageturndata(1+appnum,parseInt(count));
			 area0.doms[appnum].contentdom=$("area0_txt_"+appnum);
			 area0.doms[appnum].imgdom=$("area0_img_"+appnum);
			 area0.doms[appnum].updatecontent("光明翠湖社区");
			 area0.doms[appnum].mylink="http://14.29.1.13:8080/epg/login!index.action?tradeId=1232"+"&itvUserId=" + userid_str + "&endUrl=" + location.href;
			 area0.doms[appnum].updateimg("industryAppImages/1232.jpg");//+groupid+".jpg");//alert(appintrohy[0]);
			 document.getElementById('area0_list_'+appnum).style.display = "";	
	         area0.lockin=false;
	       //  $("pageArea").innerHTML=area0.curpage+"/"+pagecount;
}
//显示收藏列表
function showCollectDel(data,count){		 
	
	 area0.setpageturndata(data.length,parseInt(count));
	 for(var i=0;i<area0.doms.length;i++)
	 {//alert("qian"+i);
		 if(i<data.length)
		 {        
			 area0.doms[i].contentdom=$("area0_txt_"+i);
			 area0.doms[i].imgdom=$("area0_img_"+i);alert("11"+location.href);
			 area0.doms[i].setcontent("·",data[i].VASNAME,12);//alert(appurl[i]);
//             if(appintro[i]==3)//qiezi          
			 area0.doms[i].mylink=appurl[i]+location.href;
  //           if(appintro[1]==2)//kalaok
    //         area0.doms[i].mylink=appurl[i]+userid_str+'&endUrl='+location.href;
      //       if(appintro[c]==1)//zhongyou
        //     area0.doms[i].mylink=appurl[i]+STBType+'&user='+userid_str+'&enterURL='+location.href;
			 area0.doms[i].updateimg("../"+apppic[i]);//alert(appintro[i]);
			 document.getElementById('area0_list_'+i).style.display = "";
                         appnum=i+1;
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

