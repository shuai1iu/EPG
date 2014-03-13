<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%!
	final static String shouyezhibo="2001"; //首页窗口直播userChannelID
	final static String index_mid="00000100000000090000000000019750";//首页适配窗口的海报的控
	//final static String shouyetuijiancode="00000100000000090000000000018861"; //首页下部推荐(中下部3个影片的vod)
	final static String shouyetuijiancode="10000100000000090000000000009194"; //首页下部推荐(中下部3个影片的vod)
	final static String shouyerediancode="10000100000000090000000000022481";  //首页热点(6个vas的code)
	final static String shouyetuijiancoe="10000100000000090000000000022745"; //首页推荐（8个vas的code）
	final static String shouyezhuanticode="10000100000000090000000000022482";  //首页专题(右上角2个的vascode)
	//final static String shouyezhuanticode="00000100000000090000000000021998";  //首页专题(右上角2个的vascode)
	//final static String dianbocode="00000100000000090000000000018862"; //点播页面推荐
	
	//下面3个推荐暂时用最新上线的栏目ID做测试
	
	
	final static String dianbocode="10000100000000090000000000009196"; //点播页面推荐
	final static String shuqiancode="10000100000000090000000000009196"; //书签推荐
	final static String shoucangcode="10000100000000090000000000009196"; //收藏推荐
	final static String shouyezuoxia_tuijian="10000100000000090000000000009195";//首页左下方推荐
	
	
	
	
	
	
	                             
								 
								 
								 
								 
								 
								 
								 
								 
	final static String gaoqingzhibocode="00000100000000090000000000020932"; //高清直播
	//final static String biaoqingzhibocode="00000100000000090000000000020932"; //标清直播
	final static String biaoqingzhibocode="00000100000000090000000000015842"; //标清直播
	final static String biaoqinglunbocode="10000100000000090000000000007697"; //标清轮播
	final static String[] dianbocodes={"电影天地==10000100000001000000000000608066","电视剧场==00000100000000090000000000016358","第一体育==00000100000000090000000000016360","科教纪录==00000100000000090000000000016361","娱乐时尚==00000100000000090000000000016365","财经视界==00000100000000090000000000016362","健康生活==00000100000000090000000000016408","金色童年==00000100000000090000000000016369","法治空间 ==00000100000000090000000000016417","数字人文==00000100000000090000000000016622","旅游城市==00000100000000090000000000016594"};
	final static String[] zhuanticode={"人文历史==00000100000000090000000000016921==rwls.jpg","今日说法==00000100000000090000000000017162==jrsf.jpg","说出你的故事==00000100000000090000000000016465==scndgs.jpg"};
%>




             
             
<script>
//红绿黄蓝   (直播，回看，点播，信息, 搜索， 收藏)
var fourcolorkey=new Array("live.jsp","playback.jsp","vod.jsp","space_collect.jsp","search.jsp","space_collect.jsp");
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
%>