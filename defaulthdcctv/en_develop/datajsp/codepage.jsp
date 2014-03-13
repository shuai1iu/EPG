<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>


<%!
	String shouyezhibo = "11";   //首页窗口直播ID，配合首页大窗频道VAS控制修改时作为默认值
	final static Integer ADLOADING = 1;//广告加载中标识
	final static Integer ADUNLOAD = 3;//广告不加载标识
//	final static String shouyezhibo="11"; //首页窗口直播userChannelID   
	final static String index_mid="10000100000000090000000000030110";//首页适配窗口的海报的控制
	final static String zhuanti="10000100000000090000000000030110";//专题
	final static String shouyetuijian1code="00000100000000090000000000017003"; //首页下部推荐
	final static String sdfivecode = "10000100000000090000000000031281";
	final static String sdtwocode = "10000100000000090000000000031282";
	final static String hdfourcode = "10000100000000090000000000040630";//"10000100000000090000000000031283";
	final static String hdtwocode = "10000100000000090000000000031284";
//	final static String shouyetuijian2code="00000100000000090000000000018734"; //首页右边推荐
//	final static String dianbocode="00000100000000090000000000018735"; //点播页面推荐
        final static String dianbocode="10000100000000090000000000035474";//点播页面推荐
        final static String shouyetuijian2code="10000100000000090000000000035472"; //首页右边推荐
        final static String shouyetuijian2code2="10000100000000090000000000035473"; //首页右边推荐第二组
	final static String gaoqingzhibocode="00000100000000090000000000015840"; //高清直播
	
//	final static String gaoqingzhibocode="10000100000000090000000000036170"; //hhr 0710 test for gangaotai live
	final static String biaoqingzhibocode="00000100000000090000000000015842"; //标清直播
	final static String indexiframecode="10000100000000090000000000026863";
	final static String shouyetuijian3code="10000100000000090000000000028194";//高清央视首页右侧第三个
	final static String shouyetuijian4code="10000100000000090000000000028312";//高清央视首页右侧第四个


	String imageorchannel = "0";	
	//final static String biaoqingzhibocode="00000100000000090000000000022141";
	final static String szdianbocode="00000100000000090000000000016916";
//	final static String[] dianbocodes={"高清体验==00000100000000090000000000016917","新闻频道==00000100000000090000000000018176","电影天地==00000100000000090000000000018150","电视剧场==00000100000000090000000000018151","第一体育==00000100000000090000000000018152","科教纪录==00000100000000090000000000018153","娱乐时尚==00000100000000090000000000018154","健康生活==00000100000000090000000000018155","财经视界==00000100000000090000000000018156","金色童年==00000100000000090000000000018157" ,"法治空间==00000100000000090000000000018158","旅游城市==00000100000000090000000000018183","数字人文==00000100000000090000000000018288"};
//	final static String[] zhuanticode={"浪漫情人节==00000100000000090000000000018630==topic1.jpg","龙年贺岁==00000100000000090000000000018460==topic2.jpg","启航2012==00000100000000090000000000018384==topic3.jpg","快乐圣诞==00000100000000090000000000018419==topic4.jpg","情满中秋2012==00000100000000090000000000018173==topic5.jpg","八一军魂==00000100000000090000000000018231==topic6.jpg"};
%>
<script>
//var indexhref=new Array("index.jsp","channel.jsp","dibbling.jsp","special_topic.jsp","playback.jsp","../../defaultgd/en/home.jsp","ranking.jsp","../../defaultgd/en/vod_yule_szgd.jsp?homeFlag=cctv","space_collect.jsp","search.jsp");
var indexhref=new Array("../en_develop/index.jsp","channel.jsp","dibbling.jsp","special_topic.jsp","playback.jsp","../../defaultgd/en/home.jsp","ranking.jsp","application.jsp","space_collect.jsp","search.jsp");

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


//0808首页大窗频道VAS控制修改 LS
	
	ServiceHelp serviceHelpChannel = new ServiceHelp(request);
	int imageorchannel = 0;
	if(serviceHelpChannel !=null)
                {
	//20500号VAS的URL地址用于制定首页大窗的频道号或者图片，当URL为-1时显示为图片，为其他数字时为频道号	
			String codeOfChannel = serviceHelpChannel.getVasUrl(20500); 
			if(codeOfChannel != null && codeOfChannel != "")
			{
			System.out.println("============codeofchannel====================="+codeOfChannel);
				if(Integer.parseInt(codeOfChannel) == -1)
				{
					imageorchannel = 1;
				}
				else
				{
				
					shouyezhibo = codeOfChannel;
				}
			}
			System.out.println("===============================shouyehzibo============="+shouyezhibo);
                }
%>
