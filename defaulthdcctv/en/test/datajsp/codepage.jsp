<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%!
	final static String index_mid="10000100000000090000000000022670";//首页适配窗口的海报的控制
	final static String zhuanti="10000100000000090000000000030110";//专题
	final static String shouyetuijian1code="00000100000000090000000000017003"; //首页下部推荐
	final static String shouyetuijian2code="00000100000000090000000000018734"; //首页右边推荐
	final static String dianbocode="00000100000000090000000000018735"; //点播页面推荐
	final static String gaoqingzhibocode="00000100000000090000000000015840"; //高清直播
	final static String biaoqingzhibocode="00000100000000090000000000015842"; //标清直播
	final static String indexiframecode="10000100000000090000000000026863";
	final static String shouyetuijian3code="10000100000000090000000000028194";//高清央视首页右侧第三个
	final static String shouyetuijian4code="10000100000000090000000000028312";//高清央视首页右侧第四个
	final static String testcode1 = "10000100000000090000000000029036"; //测试推荐位
	final static String testcode2 = "10000100000000090000000000029040"; //测试高清推荐位VAS
	final static String testcode3 = "10000100000000090000000000029042"; //测试首页下部推荐位VAS
	final static String testcode4 = "10000100000000090000000000029043"; //测试首页高清大窗VAS
	

	
	//final static String biaoqingzhibocode="00000100000000090000000000022141";
	final static String szdianbocode="00000100000000090000000000016916";
//	final static String[] dianbocodes={"高清体验==00000100000000090000000000016917","新闻频道==00000100000000090000000000018176","电影天地==00000100000000090000000000018150","电视剧场==00000100000000090000000000018151","第一体育==00000100000000090000000000018152","科教纪录==00000100000000090000000000018153","娱乐时尚==00000100000000090000000000018154","健康生活==00000100000000090000000000018155","财经视界==00000100000000090000000000018156","金色童年==00000100000000090000000000018157" ,"法治空间==00000100000000090000000000018158","旅游城市==00000100000000090000000000018183","数字人文==00000100000000090000000000018288"};
//	final static String[] zhuanticode={"浪漫情人节==00000100000000090000000000018630==topic1.jpg","龙年贺岁==00000100000000090000000000018460==topic2.jpg","启航2012==00000100000000090000000000018384==topic3.jpg","快乐圣诞==00000100000000090000000000018419==topic4.jpg","情满中秋2012==00000100000000090000000000018173==topic5.jpg","八一军魂==00000100000000090000000000018231==topic6.jpg"};
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
