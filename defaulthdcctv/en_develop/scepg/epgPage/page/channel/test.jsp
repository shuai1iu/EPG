<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelpHWCTC" %>
<%@ page import="java.util.*"%>
<%
    ServiceHelpHWCTC serviceHelphwctc = new ServiceHelpHWCTC(request);
    int parameter=2; //VOD 1  CHAN 2  TVOD 4
    int progId=3177;//节目的CHANNELID
    int progIndex=1202;// CHANNELINDEX
    String strContentType="1" ; //播放类型
    String  playUrl = serviceHelphwctc.getTriggerPlayUrlHWCTC(parameter,progId,progIndex,"0","0","0","0",strContentType);
    
    System.out.println("**************************************");
    System.out.println("**********playUrl*******"+playUrl);
    System.out.println("**************************************");
%>


