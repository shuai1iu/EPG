<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="datajsp/package_intro_data.jsp"%>
<html>
<head>
<script language="javascript" type="text/javascript" src="js/pagecontrol.js"></script>
<script language="javascript" type="text/javascript">
    window.onload=function(){
	  var doms0;
	  var area0;
	  pageobj = new PageObj(0,0, new Array(area0),null);
      pageobj.goBackEvent=function()
	  {
		   window.location.href=returnurl;
	  }
	}
</script>
</head>
</html>