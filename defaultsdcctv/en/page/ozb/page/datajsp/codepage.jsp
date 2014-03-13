<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%!
	final static String Index_Live_SD="15"; //首页窗口直播Code（标清），暂时使用CCTV5
	final static String Index_Live_HD="1015"; //首页窗口直播Code（标清），暂时使用CCTV5
	
	final static String index_mid="00000100000000090000000000019750";//首页适配窗口的海报的控制及滚动字幕
	
	//首页热词CODE
	final static String Index_Hotkey = "00000100000000090000000000019681";
	//首页推荐
	final static String Index_Recommend = "00000100000000090000000000019663";	    
	
	final static String Index_Recommend1 = "00000100000000090000000000019663";
	
	//首页精彩回放
	final static String Index_Besttvod = "00000100000000090000000000019688";
	
	//点播页面推荐
	final static String Vod_Recommend="00000100000000090000000000019688";
	
	//精彩视频
	final static String Wonderful_video="00000100000000090000000000019687";
	
	//球星殿堂
	final static String Star_Hall="00000100000000090000000000019697";
	
	final static String Match_Vod = "00000100000000090000000000019658";
	
	final static String Top_Score = "00000100000000090000000000019689";
	
	final static String gaoqingzhibocode="00000100000000090000000000015840"; //高清直播
	
	final static String biaoqingzhibocode="00000100000000090000000000015842"; //标清直播
%>
<script>
//红绿黄蓝   (直播，回看，点播，信息)
var fourcolorkey=new Array("channel.jsp?dtype=sd","hk.jsp","dibbling.jsp","space_collect.jsp","search.jsp","space_collect.jsp");
</script>
<%
	String tmpcurpageName = request.getRequestURI();
	tmpcurpageName = tmpcurpageName.substring(tmpcurpageName.lastIndexOf("/")+1);
	tmpcurpageName = tmpcurpageName.substring(0,tmpcurpageName.lastIndexOf("."));
	/** 这段代码主要用于没有使用焦点记忆的首页面去清除焦点，但现在统一使用一个save_focus.jsp，理论上不需要了
	ArrayList tmpfocstrList = (ArrayList)request.getSession().getAttribute("focstrs");
	List tmpallindePageName = Arrays.asList("index","group-match","knockout","video","star","top-scorer","search");
	if(tmpallindePageName.contains(tmpcurpageName)){
			tmpfocstrList = new ArrayList();
			request.getSession().setAttribute("focstrs",tmpfocstrList);
	}
	**/
%>