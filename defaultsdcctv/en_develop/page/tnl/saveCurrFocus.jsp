<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" buffer="64kb"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage"%>
<%
	String preFoucs = request.getParameter("preFoucs");
	String url = "";
	String strurl =(String)request.getQueryString();
    if(strurl!=null)
    {
        if(strurl.indexOf("url")!=-1)
        {
            url = strurl.substring(strurl.indexOf("url")+4);
        }
    }
	TurnPage turnPage = new TurnPage(request);
    //修改当前URL队列的最后一个URL，增加currFocus参数
    if(preFoucs != null)
    {
        turnPage.savcCurrFoucs(preFoucs);
    }
	response.sendRedirect(url);
%>