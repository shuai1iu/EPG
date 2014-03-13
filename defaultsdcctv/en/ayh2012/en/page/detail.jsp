<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head><%@ include file="../common/golbal.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="<%=static_url%>/css/style.css" />
<link type="text/css" rel="stylesheet" href="<%=static_url%>/css/content.css" />
<script type="text/javascript" src="<%=static_url%>/js/cookie.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/common.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/commonevent.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/ajax_common.js"></script>
</head>
<body onload="onPageLoad();"  background="#"  bgcolor="#000000">
<div style="position:absolute;z-index:-1;">
	<img style="width:640px;height:530px;" src="<%=static_url%>/images/bg-dibbling.jpg" />
</div>
<%@ include file="../datasource/datasource.jsp"%>
<%@ include file="../datasource/property.jsp"%>
<% 
DataSource dataSource=new DataSource(request); 
String postertype = "1";
int pos=dataSource.huaWeiUtil.getInt(request.getParameter("pos"),0);
int area=dataSource.huaWeiUtil.getInt(request.getParameter("area"),0);
String categoryId=request.getParameter("categoryId"); 
String categoryname=request.getParameter("categoryname");
String programid=request.getParameter("programid");
PkitEpgResult epgResult=dataSource.getVodInfo(categoryId,categoryname,programid,"-1",postertype);
TblCmsProgram vod=new TblCmsProgram();
if(epgResult!=null&&epgResult.getResultcode()==0&&epgResult.getOneObject()!=null){
   vod=(TblCmsProgram)epgResult.getOneObject();
}


//获得推荐位图片
PkitEpgResult tuijians=dataSource.getVodListByTypeId(1,6,xiangqingtuijian,"1");
List tuijianlist=new ArrayList();
if(tuijians!=null&&tuijians.getResultcode()==0&&tuijians.getDatas()!=null)
{
   tuijianlist=(List)tuijians.getDatas();
}
%>

<!--head-->
<div class="detail-catalog">奥运专题</div>
<div class="date" id="currentDate"></div>
<script type="text/javascript">
showCurrentDate('currentDate','hh:mi');
</script>
<!--the end-->

<!--介绍-->
<div class="detail-intro">
	<div class="con">
		<div class="txt01"><%=dataSource.huaWeiUtil.getTopString(vod.getDname(),22,"..")%></div>
		<div class="txt02" style="top:57px;"><span>赛事：</span><%=dataSource.huaWeiUtil.getTopString(vod.getDname(),18,"..")%></div>
		<div class="txt03" style="top:93px;"><span>简介：</span><%=dataSource.huaWeiUtil.getTopString(vod.getDdescription(),82,"..")%></div>
	</div>
	<!--<div class="btn">   
		<div class="item">
			<div class="link"><a href="#" onclick="addCollect()"><img src="<%=static_url%>/images/t.gif" /></a></div>
			<div class="pic"><img src="<%=static_url%>/images/btn-add-collect.png" /></div>
		</div>
        <div class="item" style="left:125px; vertical-align:text-bottom; color:#FF0" id="result"></div>		
	</div>-->
	<div class="poster"> 
		<div class="item"><img src="<%=vod.getDpostpath()%>" height="210px" width="153px"/></div>
	</div>
	<div class="num">   
        <!--连续剧的情况如下-->
		<% if("1".equals((String)vod.getDissitcom())&&vod.getDsubvodnumlist()!=null) {
				int subVodNum=0;
				int subVodId=0;
				int num=vod.getDsubvodnumlist().size();
                for(int i=0;i<num;i++)
				{ 
					subVodNum = (Integer)((List)vod.getDsubvodnumlist()).get(i);
					subVodId = (Integer)((List)vod.getDsubvodidlist()).get(i);
	      %> 
               <div class="item" style=" left:<%=(55*i) %>px;">
                 <div class="link"><a id="subNum_<%=i%>" href="#" onclick="gotoVodPlay(<%=i%>)"><img src="<%=static_url%>/images/t.gif" /></a></div>
                 <div class="txt" ><%=subVodNum %></div>
               </div>
                    
                <%}
            }  else{
		    %>
               <div class="item" style=" left:55px;">
                  <div class="link"><a id="subNum_0" href="#" onclick="gotoVodPlay(0)"><img src="<%=static_url%>/images/t.gif" /></a></div>
                   <div class="txt" >1</div>
                </div>
			<%
             }
            %>   
    </div>
</div>
<!--the end-->

	
<!--推荐区节目-->
<div class="detail-recommend"> 
  <%if(tuijianlist!=null){ int len = tuijianlist.size();for(int i=0 ;i<len ;i++) {%>
	<div class="item" style="left:<%=102*i%>px;">
		<div class="link"><a href="<%=static_en%>/page/detail.jsp?categoryId=-1&categoryname=&programid=<%=((TblCmsProgram)tuijianlist.get(i)).getDcmsid()%>">
        <img src="<%=static_url%>/images/t.gif" /></a></div>
		<div class="pic"><img src="<%=((TblCmsProgram)tuijianlist.get(i)).getDpostpath()%>" /></div>
	</div>
   <%}}%>
</div>
<!--the end-->	
	

<script type="text/javascript">
var area = <%=area%>;//0:搜索区域 1：集数区域 2：浮动层
var pos = <%=pos%>;
var jsonObj;
var subVodIdList = new Array();
<% 
if(vod!=null) {
	if("1".equals((String)vod.getDissitcom())&&vod.getDsubvodidlist()!=null)
	{
		int len = vod.getDsubvodidlist().size();
		for(int i = 0 ;i < len ; i++){
			%>
			subVodIdList[<%=i%>]=<%=(Integer)((List)vod.getDsubvodidlist()).get(i) %>;
			<%
		}
	}else{
		%>
		subVodIdList[0] = <%=vod.getDid() %>;
		<%
	}
}
%>
var backUrl="<%=static_en%>/page/index.jsp";
function onPageLoad(){
     keyBinds();
	 document.getElementById("subNum_"+pos).focus();
}
 
BaseProcess.prototype.KEY_BACK_EVENT=function(){
	   goBack();
}

function gotoVodPlay(num){
	var vodPlayUrl = "<%=static_en%>/player/vodplay.jsp?progId="+subVodIdList[num];
	backUrl = "<%=static_en%>/page/detail.jsp?area=1&pos="+num+"&categoryId=-1&categoryname=&programid=<%=programid%>";
	addURLtoCookie("vodPlay",backUrl);
	location.href = vodPlayUrl;
}
function goBack(){
	 backUrl = getURLtoCookie("detail");
	 backUrl = (backUrl!="")?backUrl:"index.jsp";
	 location.href=backUrl ;
}
function addCollect(){
	var ajaxurl = "<%=static_en%>/ajaxdata/collect_add_data.jsp?programid="+subVodIdList[0]+"&programType=0";
	getAJAXData(ajaxurl,myCallBack);
}
function delCollect(){
	var ajaxurl = "<%=static_en%>/ajaxdata/collect_del_data.jsp?programid="+subVodIdList[0]+"&programType=0";
	getAJAXData(ajaxurl,myCallBack);
}
function myCallBack(respText){
	 jsonObj = eval('('+respText+')');
	 var recode = jsonObj.resultcode;
	 var redesc = jsonObj.resultdesc;
	 showInfo(redesc);
}
function showInfo(myinfo){
	 document.getElementById("result").innerText = myinfo;
	 var showInfoTimer = setTimeout(hideInfo, 1000);
}
function hideInfo(){
	document.getElementById("result").innerText = "";
	showInfoTimer = "";
}
</script>
		
</body>
</html>
