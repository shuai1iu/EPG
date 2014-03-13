<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<script>
var posterData = [];
<!--取推荐海报-->
<%
     int vodSize = 0;
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
			         picPath="images/display/vod/prog_no_pic.jpg";
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