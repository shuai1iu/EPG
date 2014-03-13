<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head><%@ include file="../common/golbal.jsp" %>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
<meta name="page-view-size" content="640*530"/>
<title>奖牌榜 - EPG</title>
<link rel="stylesheet" type="text/css" href="<%=static_url%>/css/style.css" />
<script type="text/javascript" src="<%=static_url%>/js/common.js"></script>
<style type="text/css">
body {
	background: #1c1949 url("<%=static_url%>/images/bg-page-1.jpg") no-repeat;
}
</style>
</head>
<body onload="onPageLoad();">
<%@ include file="../datasource/datasource.jsp" %>
<%@ include file="../datasource/property.jsp"%>
<%
   DataSource dataSource=new DataSource(request); 
   String postertype = "0";

	//获得该栏目的自身的图片做为左边的图片显示
	EpgResult categoryinfo = dataSource.getCategory(jiangpaibang,"1");
	TblCmsCategory cate = new TblCmsCategory();
	String categoryPic = "";
	if(categoryinfo!=null){
		cate = (TblCmsCategory)categoryinfo.getOneObject();
		categoryPic = cate.getPicpath();
	}
	
   
   //增值业务栏目的推荐位
   EpgResult vastuijians = dataSource.getVasCategorys(1,3,jiangpaibang,"0");
   List vastuijianlist = new ArrayList();
   if(vastuijians!=null && vastuijians.getResultcode()==0 && vastuijians.getDatas()!=null)
   {
	   vastuijianlist = (List)vastuijians.getDatas();
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
		<%if(vastuijianlist!=null){int len =vastuijianlist.size();for(int i=0;i<len;i++) {%>
            <div class="item" style="top:<%=126*i%>px;">
            <div class="link"><a href="#"><img src="<%=static_url%>/images/t.gif" /></a></div>
            <div class="pic"><img src="<%=((TblCmsVasCategory)vastuijianlist.get(i)).getDposterpath0()%>" /></div>
            </div>
        <%}}%>
    </div>
    <!-- E 侧栏 -->

</div>

<script type="text/javascript">

function onPageLoad(){
  
}
 

function goBack(){
	 var url="index.jsp";
	 window.location.href=url ;
	}
document.onkeypress = keyEvent;
function keyEvent()
{
	var val = event.which ? event.which : event.keyCode;
	return keypress(val);
}
function keypress(keyval)
{
	switch(keyval)
	{
		case 8:
			goBack();
			break;
	} 
}
</script>

</body>
</html>