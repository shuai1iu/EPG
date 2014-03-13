<%
/**********************
* FileName:codepage.jsp
* Time:20130909 9:30
* Author:ZSZ
* description:标清各栏目code
**********************/
%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<%!
	final static Integer ADLOADING = 1;
	final static Integer ADUNLOAD = 3;
	String shouyezhibo="11"; //首页窗口直播userChannelID
//	final static String index_mid="00000100000000090000000000019750";//首页适配窗口的海报的控
//	final static String shouyetuijiancode="00000100000000090000000000018861"; //首页下部推荐
        final static String shouyetuijiancode="10000100000000090000000000035475"; //首页改版后下部推荐
	//final static String shouyerediancode="00000100000000090000000000018810";  //首页热点
	//final static String shouyetuijiancoe="00000100000000090000000000018811";  //首页推荐
	/*******2013.8.7 11:30 ZSZ 修改标清首页左边上下推荐位、右边vas位************/
	final static String shouyetuijiancoe="10000100000000090000000000032666";  //首页推荐(上)
	final static String shouyerediancode="10000100000000090000000000032667";  //首页热点(下)
	final static String shouyezhuanticode="10000100000000090000000000032970";  //首页专题
	final static String shouyezhuanticode1="10000100000000090000000000032971";//首页VAS
	final static String shouyetuijiancoe1="10000100000000090000000000032992";//直播港澳台
	/*******2013.8.7 11:30 ZSZ修改标清首页左边上下推荐位、右边vas位************/
	//final static String shouyezhuanticode="00000100000000090000000000018812";  //首页专题
	//final static String shouyezhuanticode1="10000100000000090000000000028311";//首页VAS
//	final static String dianbocode="00000100000000090000000000018862"; //点播页面推荐
        final static String dianbocode="10000100000000090000000000035476"; //改版后点播页面推荐
	final static String shuqiancode="00000100000000090000000000018864"; //书签推荐
	final static String shoucangcode="00000100000000090000000000018863"; //收藏推荐
  	final static String topiccode="10000100000000090000000000030110";//专题
      //  final static String shouyetuijiancoe1="10000100000000090000000000031819";//直播港澳台
	final static String indexiframecode="10000100000000090000000000026864";
        //修改了央视新改版的三个页面code
		final static String filmtypeid="";//"00000100000000090000000000018150";//电影栏目id
		final static String hottypeid="00000100000000090000000000018151";//热剧栏目id
		final static String animationtypeid="00000100000000090000000000018157";//动画栏目id
		final static String filmrecommcode="10000100000000090000000000025331"; //电影推荐
		final static String filmrankcode="10000100000000090000000000025332"; //电影排行榜
		final static String filmtopiccode="00000100000000090000000000018812"; //电影专题
		final static String hotrecommcode="10000100000000090000000000025333"; //热剧推荐
		final static String hotrankcode="10000100000000090000000000025334"; //热剧排行榜
		final static String hottopiccode="00000100000000090000000000018812"; //热剧专题
		final static String animationrecommcode="10000100000000090000000000025335"; //动画推荐
		final static String animationrankcode="10000100000000090000000000025336"; //动画排行榜
		final static String animationtopiccode="";//"00000100000000090000000000018812"; //动画专题															
//	code
	final static String gaoqingzhibocode="00000100000000090000000000015840"; //高清直播
	final static String biaoqingzhibocode="00000100000000090000000000015842"; //标清直播
/*	final static String[] dianbocodes={"电影天地==00000100000000090000000000016356","电视剧场==00000100000000090000000000016358","第一体育==00000100000000090000000000016360","科教纪录==00000100000000090000000000016361","娱乐时尚==00000100000000090000000000016365","财经视界==00000100000000090000000000016362","健康生活==00000100000000090000000000016408","金色童年==00000100000000090000000000016369","法治空间 ==00000100000000090000000000016417","数字人文==00000100000000090000000000016622","旅游城市==00000100000000090000000000016594"};*/
//	final static String[] zhuanticode={"人文历史==00000100000000090000000000016921==rwls.jpg","今日说法==00000100000000090000000000017162==jrsf.jpg","说出你的故事==00000100000000090000000000016465==scndgs.jpg"};
%>
<script>
//红绿黄蓝   (直播，回看，点播，信息, 搜索， 收藏)
var fourcolorkey=new Array("live.jsp","playback.jsp","vod.jsp","space_collect.jsp","search.jsp","space_collect.jsp");
/*首页上部导航栏定义*/
var indexhref=new Array("live.jsp","vod.jsp","playback.jsp","../../../defaultgdsd/en/page/index.jsp","app.jsp","topiclist.jsp","ranking.jsp");

</script>
<%
	String tmpcurpageName = request.getRequestURI();
	tmpcurpageName = tmpcurpageName.substring(tmpcurpageName.lastIndexOf("/")+1);
	tmpcurpageName = tmpcurpageName.substring(0,tmpcurpageName.lastIndexOf("."));
	ArrayList tmpfocstrList = (ArrayList)request.getSession().getAttribute("focstrs");
	List tmpallindePageName = Arrays.asList("index","dibbling");
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
				if(Integer.parseInt(codeOfChannel) == -1)
				{
					imageorchannel = 1;
				}
				else
				{
				
					shouyezhibo = codeOfChannel;
				}
			}
                }

%>
