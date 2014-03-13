<%-- Copyright (C), Huawei Tech. Co., Ltd. --%>
<%-- Author:zhuxingwei --%>
<%-- CreateAt:20090203 --%>
<%-- FileName:play_ControlPassCheckInfolock.jsp --%>

<%-- 页面功能:校验用户密码--%>
<%-- 跳转描述:参数returnurl指向的url--%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@ page language="java" errorPage="ShowException.jsp" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%@ page import="java.util.*" %>
<%
    //校验用户密码
    String password = request.getParameter("pwd");
    String currChanNum = request.getParameter("currChanNum");
    String currChannelId = request.getParameter("currChannelId");
    String currChanIndex = request.getParameter("currChanIndex");
    ServiceHelp serviceHelp = new ServiceHelp(request);
    boolean checkPasswdRet = false;
		String timeStamp = (String)request.getParameter("timeStamp");
    checkPasswdRet = serviceHelp.checkPassword(password,timeStamp);
    String relPasswordMD5 = request.getParameter("relPasswordMD5");
%>
<html>
<link href="css/stylesheet.css" rel="stylesheet" type="text/css">
<script>

	 if (typeof(iPanel) != 'undefined')
	  {
		iPanel.focusWidth = "4";
		iPanel.defaultFocusColor = "#FCFF05";
	  }
	
	var checkPasswdRet = '<%=checkPasswdRet%>';
	var currChanNum = <%=currChanNum%>;
	currChanNum = parseInt(currChanNum);
	var currChannelId = '<%=currChannelId%>';
	var currChanIndex = '<%=currChanIndex%>';
	currChanIndex = parseInt(currChanIndex);

	function init_page()
	{
		Authentication.CTCSetConfig("Pwd","<%=relPasswordMD5%>");
		if(checkPasswdRet == "true")
		{
			//解决频解锁成功以后，按频道加减键到该频道仍然需要输入密码问题
			parent.currChannelIndex = currChanIndex;
			parent.isLock[currChanIndex] = '0';  
			parent.isControlled[currChanIndex] = 'false';
			//如果解锁成功的话，需要把用户输入的频道号重新赋值
			parent.currChannelNum = currChanNum;
			//解锁标志位也得复位
			parent.lockFlag = "false";
			parent.joinChannel(currChanNum);
			parent.hiddenLockInfo();
			parent.clearTimeout(parent.channelListTimer);
	    parent.hiddenChannelList();
		}
		else
		{
			parent.showErrorInfo();
		}
	}
    init_page();
</script>
</html>
