<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
    <meta name="page-view-size" content="640*530"/>
    <title>CCTV-IP电视</title>
    <link rel="stylesheet" type="text/css" href="../css/style.css" />
    <style type="text/css">
        body {
                 background: #0d4764 url("../images/build.jpg") no-repeat;
           //   background: #0d4764 url("../images/guanggao.jpg") no-repeat;
       	}
    </style>
    <script language="javascript" type="text/javascript" src="../js/pagecontrol.js"></script>
    <script language="javascript" type="text/javascript">
            var backurl="<%=request.getParameter("returnurl")==null?"index.jsp?back=1":request.getParameter("returnurl") %>";
	    var  area0 = AreaCreator(1, 1, new Array(-1, -1, -1, -1), "area0_list_", "className:logo", "className:logo");
	    pageobj = new PageObj(0, 0, new Array(area0));
	    pageobj.goBackEvent=function()
            {
               window.location.href=backurl;
            } 
	</script>
</head>
<body>
<div class="wrapper">

	<!-- S LOGO -->
    <div class="logo" id="area0_list_0"><img src="../images/logo.png" /></div>
    <!-- E LOGO -->
	
</div>
</body>
</html>
