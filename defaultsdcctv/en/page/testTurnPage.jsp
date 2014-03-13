<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%
TurnPage turnPage = new TurnPage(request);
ServiceHelp serviceHelp = new ServiceHelp(request);
turnPage.addUrl("http://www.1111.com");
turnPage.addUrl("http://www.2222.com");
turnPage.addUrl("http://www.3333.com");
turnPage.addUrl("http://www.4444.com");
turnPage.addUrl("http://www.5555.com");
//turnPage.addUrl();
String goBackUrl1 =turnPage.go(-1); //turnPage.go(-1);  //结论是依次上线为444，333，222，111，不会删除
turnPage.removeUrl(goBackUrl1);
String goBackUrl2 =turnPage.getLast();//turnPage.getLast(); //
String goBackUrl3 =turnPage.go(-1);//turnPage.getLast(); //
String goBackUrl4 =turnPage.go(-2);//turnPage.getLast(); //
//turnPage.getLast() 得到的不管好多都是最后一个 ，不会删除
//turnPage.go(-1) 结论是依次上线为444，333，222，111，不会
//turnPage.addUrl() 再用turnPage.getLast()获取出来的是page/testTurnPage.jsp?null
//
%>
<script>
var goBackUrl1="<%=goBackUrl1%>";
var goBackUrl2="<%=goBackUrl2%>";
var goBackUrl3="<%=goBackUrl3%>";
var goBackUrl4="<%=goBackUrl4%>";
alert(goBackUrl1+"---"+goBackUrl2+"---"+goBackUrl3+"---"+goBackUrl4);

</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>测试跳转</title>
</head>

<body>
</body>
</html>