<%--
  Copyright (C), 2004-2005, Huawei Tech. Co., Ltd.
  File name:     showException.jsp
  Description:   用于捕获没有处理的异常。 
--%>

<%@ page isErrorPage="true"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGSysParam"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@include file = "../../../keyboard_A2/keydefine.jsp"%>
<%
  //页面跳转
  TurnPage turnPage = new TurnPage(request);
%>

<html>
<script>
<!--
    iPanel.firstLinkFocus=0;
    document.onkeypress = event;
    document.onirkeypress = event ;
    function event()
    {
        var val = event.which;
        return keypress(val);
    }
    
    /**
     *返回到上一级页面






     */
    function goBack()
    {
        window.location.href = "<%=turnPage.go(-1)%>";
    }    
    
    function keypress(keyval)
    {    
        switch(keyval)
        {
            case <%=KEY_BACKSPACE%>://回退键和返回键同样处理        
            case <%=KEY_RETURN%>:
                goBack();
                return 0;//返回0机定盒不处理  
            default:
               //videoControl(keyval);
					break; 
        }
        return 1;
    }     
	
	function setFocus()
	{
		document.getElementById("back").focus();
		document.getElementById("back").focus();
	}  
	
-->

<%

String desc = "服务器错误！";
String resolve = "请稍候重试，如果问题依然存在，联系服务提供商！";
%>
</script>

<head>
<title>showException</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" background="./images/common/bg-InfoDisplay.gif" onLoad="javascript:setFocus();">
<table width="640" height="84">
	<tr>   
	    <td width="40"></td>
		<td width="380">
		</td>
		<td width="245" valign="bottom" align="right">
		</td>
		 <td width="55"></td>
	</tr>
</table>
<table width="640" height="340" align="middle" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td width="100" >
        </td>
        <td width="100px" height="330">
            <table width="101" height="220" border="0" cellpadding="0" cellspacing="0" align="middle" valign="top">
                <tr>
		    <%---modify by lilulu 2006-3-15---%>
                    <td width="100" height="48">&nbsp;</td>
                </tr>
                <tr>
                    <td height="153" align="center">
                        <img src="images/common/img-redalert.gif">
                    </td>
                </tr>
                <tr>
                    <td height="19">&nbsp;</td>
                </tr>
          </table>
      </td> 
        <td>
            <table width="400px" height="330" border="0" cellpadding="0" cellspacing="0" align="middle" valign="top">
                <tr>
                    <td>
                        <table width="350px" border="0" cellpadding="0" cellspacing="0" align="middle" topmargin="0" valign="top">
                            <tr>
                                <td height="40px">                                </td>
                            </tr>                   
                            <tr>
                                <td align="middle" topmargin="0" valign="top" height="20px" class="noticetitle" style="color:#FFFFFF"><%=desc%></td>
                            </tr>
                            <tr>
                                <td height="10px"></td>
                            </tr>
                            <tr>
                                <td height="153">
                                    <span class="messageinfo" style="color:#FFFFFF">
                                        <%=resolve%></span></td>
                          </tr>
                            <tr>
                                <td align="center" valign="middle">
                                    <a href="javascript:goBack()" id="back"><img src="images/common/goback.gif" width="138" height="43" /></a>                                </td>
                            </tr>
                            <tr>
                                <td height="24">&nbsp;</td>
                            </tr>
                        </table>
                    </td>            
                    <td width="100">&nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<% exception.printStackTrace();%>
<table width="640" height="79" cellpadding="0" cellspacing="0" >
	<tr>
		<td>
		</td>
	</tr>
</table>

</body>
</html>

