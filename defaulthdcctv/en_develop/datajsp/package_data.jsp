<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<script language="javascript"  type="text/javascript">
<%
int curpage=1;
int areaid=0;
int indexid=7;
if(request.getParameter("curpage")!=null)
{
	curpage = Integer.parseInt(request.getParameter("curpage"));
}
if(request.getParameter("areaid")!=null)
{
	areaid = Integer.parseInt(request.getParameter("areaid"));
}

if(request.getParameter("indexid")!=null)
{
	indexid = Integer.parseInt(request.getParameter("indexid"));
}
%>
  
   var packageimgList = new Array("images/temp/packimg1.jpg","images/temp/packimg2.jpg","images/temp/packimg3.jpg");
   var packageBackimgList = new Array("images/temp/packimgBack.jpg","images/temp/packimg2Back.jpg","images/temp/packimg3Back.jpg");
   var packagetypeList = new Array("了解详情","了解详情" ,"了解详情");
   var jsCurrPage =<%=curpage%>;
   var pos = parseInt(jsCurrPage) * 3 - 3;
   var packageidList=new Array("1","2","3");
   var packageisorder=new Array("1","1","1");
   var packageList=new Array();
   for(var i = pos; i < (pos+3) && i< packageimgList.length; i ++)
   {
	   var packageObj = {};
       packageObj.packageObjimg = packageimgList[i];
       packageObj.packageObjtype= packagetypeList[i];
	   packageObj.packageObjId=packageidList[i];
	   packageObj.packageObjorder=packageisorder[i];
	   packageObj.packageObjback=packageBackimgList[i];
	   packageList.push(packageObj);
  }
  var areaid=<%=areaid%>;
  var indexid=<%=indexid%>;
</script>