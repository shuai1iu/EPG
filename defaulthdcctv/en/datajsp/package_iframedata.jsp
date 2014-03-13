<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
<script type="text/javascript">
<%
int curpage = Integer.parseInt(request.getParameter("curpage"));
%>
   var packageimgList = new Array("images/temp/packimg1.jpg","images/temp/packimg2.jpg","images/temp/packimg3.jpg");
   var packagetypeList = new Array("了解详情","了解详情" ,"了解详情");
   var packageBackimgList = new Array("temp/packimgBack.jpg","temp/packimg2Back.jpg","temp/packimg3Back.jpg");
   var jsCurrPage ='<%=curpage%>';
   var pos = parseInt(jsCurrPage) * 3 - 3;
   var packageList=new Array();
   var packageidList=new Array("1","2","3","4","5");
   var packageisorder=new Array("1","0","1","0","0");
   for(var i = pos;i < (pos+3) && i< packageimgList.length;i++)
   {
	   var packageObj = {};
       packageObj.packageObjimg = packageimgList[i];
       packageObj.packageObjtype= packagetypeList[i];
	   packageObj.packageObjId=packageidList[i];
	   packageObj.packageObjorder=packageisorder[i];
	   packageObj.packageObjback=packageBackimgList[i];
	   packageList.push(packageObj);
  }
  window.parent.getdata(packageList,2);
</script>
</head>
<body>
</body>
</html>