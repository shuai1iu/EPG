<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<html>
<head>
<script type="text/javascript">
<%
int curpage = Integer.parseInt(request.getParameter("curpage"));
%>
    var arrinstruText=new Array();
	var strinstruText="";
	arrinstruText.push("央视操作央视操作央视操作央视操作央视操作央视操作央视操作央视操作央视操作央视操作央视操作央视操作央视操作央视操作央视操作央视操作央视操作");
	arrinstruText.push("央视操作2");
    var jsCurrPage ='<%=curpage%>';
    var pos = parseInt(jsCurrPage) * 1 - 1;
	strinstruText=arrinstruText[pos];
	window.parent.getdata(strinstruText,2);
</script>
</head>
<body>
</body>
</html>