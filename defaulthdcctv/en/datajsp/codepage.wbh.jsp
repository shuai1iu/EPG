﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%!
	final static String shouyezhibo="11"; //首页窗口直播userChannelID
	final static String shouyetuijian1code="00000100000000090000000000017003"; //首页下部推荐
	final static String shouyetuijian2code="00000100000000090000000000018734"; //首页右边推荐
	final static String dianbocode="00000100000000090000000000018735"; //点播页面推荐
	final static String gaoqingzhibocode="00000100000000090000000000015840"; //高清直播
	final static String biaoqingzhibocode="00000100000000090000000000015842"; //标清直播
	final static String[] dianbocodes={"高清体验==00000100000000090000000000016917","电影天地==00000100000000090000000000018150","电视剧场==00000100000000090000000000018151","第一体育==00000100000000090000000000018152","科教纪录==00000100000000090000000000018153","娱乐时尚==00000100000000090000000000018154","健康生活==00000100000000090000000000018155","财经视界==00000100000000090000000000018156","金色童年==00000100000000090000000000018157" ,"法治空间==00000100000000090000000000018158","精品专题==00000100000000090000000000018159","旅游城市==00000100000000090000000000018183","数字人文==00000100000000090000000000018288"};
	final static String[] zhuanticode={"浪漫情人节==00000100000000090000000000018630==topic1.jpg","龙年贺岁==00000100000000090000000000018460==topic2.jpg","启航2012==00000100000000090000000000018384==topic3.jpg"};
%>
<script>
var indexhref=new Array("index.jsp","channel.jsp","dibbling.jsp","special_topic.jsp","playback.jsp","../../defaultgd/en/home.jsp","../../defaultgd/en/vod_yule_szgd.jsp?homeFlag=cctv","package.jsp","space_collect.jsp","search.jsp");
</script>
<%
	String tmpcurpageName = request.getRequestURI();
	tmpcurpageName = tmpcurpageName.substring(tmpcurpageName.lastIndexOf("/")+1);
	tmpcurpageName = tmpcurpageName.substring(0,tmpcurpageName.lastIndexOf("."));
	ArrayList tmpfocstrList = (ArrayList)request.getSession().getAttribute("focstrs");
	List tmpallindePageName = Arrays.asList("index","channel","dibbling","playback","application","package","space_collect","space_bookmarks","space_consumer_records","space_instructions","search");
	if(tmpallindePageName.contains(tmpcurpageName)){
			tmpfocstrList = new ArrayList();
			request.getSession().setAttribute("focstrs",tmpfocstrList);
	}
%>
