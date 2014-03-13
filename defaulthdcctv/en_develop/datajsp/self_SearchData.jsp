<!--文件名：self_SearchData.jsp-->
<!--描述:搜索页面数据层-->
<!--修改者：yangtao-->
<!--时间：2010-07-27-->
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" buffer="32kb"%>
<%@ page import="java.util.*"%>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ include file = "SubStringFunction.jsp"%>
<%@ include file = "../util/util_getPosterPaths.jsp"%>
<script type="text/javascript">
//图片数据
var posterData= [];

<!--取推荐海报-->
<%
     //获取焦点记忆参数
	 TurnPage turnPage = new TurnPage(request);
	 //首次进搜索页面
	 String isFirst = request.getParameter("ISFIRST");

	 String type = request.getParameter("TYPE");
	 int itype = 0;
	 try
	 {
	     itype = Integer.parseInt(type);
	 }
	 catch(Exception e)
	 {
		 
	 }
	 String condition = "";
	 
	 String preUrl = turnPage.go(0); 
	 String nextUrl = turnPage.getLast();
	 if("2".equals(isFirst))
	 {
		 if(itype == 1)
		 {
			 itype = 1;
			 condition = new String(request.getParameter("CONDITION").getBytes("ISO-8859-1"),"UTF-8");
		 }
		 else if(itype == 2)
		 {
			 //搜索方式:0-搜索码 1-主演名 2-导演名 
			 itype =2; 
			 //搜索条件
			 condition = new String(request.getParameter("CONDITION").getBytes("ISO-8859-1"),"UTF-8");
		 }
	 }
	 else if("1".equals(isFirst))
	 {
		 itype = 0;
		 condition = "";
	 }
	 else
	 {
		 condition = ""; 
	 }
	
	 //记忆页面，将页面加入到页面队列
    if("1".equals(isFirst) && (turnPage.getLast().indexOf("vod_Category.jsp?MainPage=1")!=-1 ||turnPage.getLast().indexOf("vod_HotFilmList.jsp")!=-1||turnPage.getLast().indexOf("query_Favorite.jsp")!=-1||turnPage.getLast().indexOf("self_Search.jsp")!=-1))
    {
    	 turnPage.removeLast(); 
    }
	
	String tempUrl = turnPage.go(-2);
	if(!"2".equals(isFirst) && (turnPage.getLast().indexOf("vod_FilmDetail.jsp") == 0 || turnPage.getLast().indexOf("vod_TVDetail.jsp") == 0 || turnPage.getLast().indexOf("vod_TVTypeDetail.jsp") == 0))
	{
		turnPage.removeUrl(tempUrl);
	}
		
	 turnPage.addUrl("self_Search.jsp?currFocus=0&TYPE="+itype);
 
     int vodSize = 0;
	 MetaData metaData = new MetaData(request);
     List recommendvod=metaData.getRecommendFilms(5,0);
	 if(recommendvod==null && recommendvod.size()!=2)
	 {
	      turnPage.removeLast();
%>
          window.location.href = "InfoDisplay.jsp?ERROR_ID=25&ERROR_TYPE=2";
<%
	 }
	 else
	 {
	     ArrayList realrecommendvod = (ArrayList)recommendvod.get(1);
		 if(realrecommendvod!=null && realrecommendvod.size()>0)
		 {
		     vodSize = realrecommendvod.size();
			 for(int i=0;i<vodSize;i++)
			 {
			     HashMap realrecommendvodmap = (HashMap)realrecommendvod.get(i);
				 int vodId=((Integer)realrecommendvodmap.get("VODID")).intValue();
				 HashMap picpathTemp = (HashMap)realrecommendvodmap.get("POSTERPATHS"); 
			     String picPath = getPosterPath(picpathTemp,request);
			     if(picPath=="false")
			     {
			         picPath="images/search/no_pic.jpg";
			     }
				 HashMap voddetailInfo =(HashMap) metaData.getVodDetailInfo(vodId);
				 
				 int issitcom = ((Integer)voddetailInfo.get("ISSITCOM")).intValue();
%>
                 var tempObject = {};
				 tempObject.vodId="<%=vodId%>";
				 tempObject.vodPoster="<%=picPath%>";
				 tempObject.issitcom="<%=issitcom%>";
				 posterData.push(tempObject);
<%
			 }
		 }
		 else
		 {
%>
		       var tempObject = {};
			   tempObject.vodId="暂无数据";
			   tempObject.vodPoster="";
			   tempObject.issitcom="";
			   posterData.push(tempObject);
<%
		 }
	 }
%>

     var picSize = "<%=vodSize%>";
</script>