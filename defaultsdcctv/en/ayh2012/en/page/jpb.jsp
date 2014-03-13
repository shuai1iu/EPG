<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head><%@ include file="../common/golbal.jsp" %>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<meta name="page-view-size" content="640*530"/>
<title>奖牌榜 - EPG</title>
<link rel="stylesheet" type="text/css" href="<%=static_url%>/css/style.css" />
<script type="text/javascript" src="<%=static_url%>/js/common.js"></script>
<script type="text/javascript" src="<%=static_url%>/js/commonevent.js"></script>
</head>
<body onload="onPageLoad();" background="#"  bgcolor="#000000">
<div style="position:absolute;z-index:-1;">
	<img style="width:640px;height:530px;" src="<%=static_url%>/images/bg-page-1.jpg" />
</div>
<%@ include file="../datasource/datasource.jsp" %>
<%@ include file="../datasource/property.jsp"%>
<%
   DataSource dataSource=new DataSource(request); 
   int pos = dataSource.huaWeiUtil.getInt(request.getParameter("pos"),0);
   String postertype = "0";

	//获得该栏目的自身的图片做为左边的图片显示
	PkitEpgResult categoryinfo = dataSource.getCategory(jiangpaibang,"1");
	TblCmsCategory cate = new TblCmsCategory();
	String categoryPic = "";
	if(categoryinfo!=null){
		cate = (TblCmsCategory)categoryinfo.getOneObject();
		categoryPic = cate.getPicpath();
	}
	
   
   //增值业务栏目的推荐位,需要时启用
   /*
   PkitEpgResult vastuijians = dataSource.getVasCategorys(1,3,jiangpaibang,"0");
   List vastuijianlist = new ArrayList();
   if(vastuijians!=null && vastuijians.getResultcode()==0 && vastuijians.getDatas()!=null)
   {
	   vastuijianlist = (List)vastuijians.getDatas();
   } */  
   
   //普通推荐栏目的方式
   PkitEpgResult catetuijians = dataSource.getCategorys(1,3,jiangpaibangtuijiancate,"2");
   List catetuijianlist = new ArrayList();
   if(catetuijians!=null&&catetuijians.getResultcode()==0&&catetuijians.getDatas()!=null)
   {
		catetuijianlist = (List)catetuijians.getDatas();
   }
%>




<div class="wrapper">

<%String currentPageId = "_1005"; %>
<%@ include file="../common/head.jsp" %>
    <!-- E 导航 -->

    <!-- S 主内容 -->
    <div class="topList">
      <div class="pic" style=" left:22px;top:113px;"><img id="pic_left" src="<%=categoryPic%>" width="395" height="390" /></div>
    </div>
    <!-- E 主内容 -->

    <!-- S 侧栏 -->
    <div class="picList" style="left:432px; top:113px;">
		<%if(catetuijianlist!=null){int len =catetuijianlist.size();for(int i=0;i<len;i++) {%>
            <div class="item" style="top:<%=126*i%>px;">
            <div class="link"><a href="#" id="cate_a_<%=i%>" onclick="goXmdb(<%=i%>)"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic"><img src="<%=((TblCmsCategory)catetuijianlist.get(i)).getPicpath()%>" /></div>
            </div>
        <%}}%>
    </div>
    <!-- E 侧栏 -->

</div>

<script type="text/javascript">
var pos = <%=pos%> ;
var CateIdList = new Array();
<%
if(catetuijianlist.size()>0){
	int len = catetuijianlist.size();
	for(int i= 0; i < len ; i++){
	  %>
		CateIdList[<%=i%>] = "<%=((TblCmsCategory)catetuijianlist.get(i)).getDcmsid()%>";
	   <%
	}
}
%>
function onPageLoad(){
     keyBinds();
	 init();
}
function init()
{
	document.getElementById("cate_a_"+pos).focus();
}
function goXmdb(num){
	var xmdbUrl="<%=static_en%>/page/xmdb.jsp?categoryId="+CateIdList[num];
	if(xmdbUrl!=null && xmdbUrl!="" && xmdbUrl!="undefined" && xmdbUrl!=undefined){
		backUrl = "<%=static_en%>/page/jpb.jsp?pos="+num;
		addURLtoCookie("xmdb",backUrl);
		location.href = xmdbUrl;
	}
}
BaseProcess.prototype.KEY_BACK_EVENT=function(){
	   goBack();
}
function goBack(){
	 var url="index.jsp";
	 window.location.href=url ;
}

</script>

</body>
<script type="text/javascript" src="<%=static_url%>/js/cookie.js"></script>
</html>