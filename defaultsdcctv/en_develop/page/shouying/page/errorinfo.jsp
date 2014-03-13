<%@ page contentType="text/html; charset =UTF-8" pageEncoding="UTF-8"%>
<%
    String	url1=request.getSession().getAttribute("url1")==null?"":request.getSession().getAttribute("url1").toString(); 
    String errid =request.getParameter("ERROR_ID")==null?"0":request.getParameter("ERROR_ID").toString();
	int interrid = Integer.parseInt(errid);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="../css/styleorder.css" />
<style type="text/css">
    body {
        background: #0d4764 url("../images/body-page-only-bg-1.jpg") no-repeat;
    }
    .mod-pop-box {
        background: url("../images/pop-432x218-1.png") no-repeat;
        height: 218px;
        width: 502px;
        position: absolute;
        left:69px;
        top: 102px;
    }
    .mod-pop-box .txt {
        font-size: 30px;
        height: 32px;
        text-align: center;
        width: 502px;
        color:#FFF;
    }
</style>
</head>
<script>
var KEY_OK =13;
var KEY_BACK = 8;
var KEY_BACKSPACE  = 8;
document.onkeypress = Keyevent;
function Keyevent()
{
	var val = event.which;
	return keypress(val);
}
function goBack()
{	
	window.location.href = "<%=url1%>";	
}
function keypress(keyval)
{
	switch(keyval)
	{
		case KEY_BACK://回退键和返回键同样处理       
		case KEY_BACKSPACE:
		case KEY_OK:
			 goBack();
			return 0;
		default :
				break; 
	}
	return 1;
}
function auto_return()
{
	tempTime=  setTimeout("returnCategory();",5000);
}

function returnCategory()
{
   clearTimeout(tempTime);
   window.location.href = "<%=url1%>";	
}

</script>
<body onLoad="javascript:auto_return()">

<div class="wrapper">
    <div class="mod-pop-box">
        
        <div class="txt" style="top:135px;">
		<% if(interrid==202) {%>
	             您机顶盒的在线订购功能已关闭
                     <div>&nbsp; </div>
                     <div style="font-size:25px; color:#FF9; text-align:center;">请拨打10000号或到电信营业厅办理开通.</div>
        <%}  else { %>
         抱歉，订购失败。
         <%}%></div>
       
    </div>
</div>
<div style="top:500px;left:30px; position:absolute;">5秒后自动返回</div>
</body>
</html>
