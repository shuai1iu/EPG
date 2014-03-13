<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ include file = "../config/config_recommd.jsp"%>
<script>
var posterData = [];
<!--取推荐海报-->
<%
     int vodSize = 0;
	 List recommendvod= metaData.getVodListByTypeId(VOD_FILMDETAIL_TYPEID,6,0);
	 if(recommendvod==null || recommendvod.size()!=2)
	 {
	      //turnPage.removeLast();
%>
          //window.location.href = "InfoDisplay.jsp?ERROR_ID=25&ERROR_TYPE=2";
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
				 HashMap picpathTempMap = (HashMap)realrecommendvodmap.get("POSTERPATHS"); 
				 int mapLength = 0;	
				 String picPathTemp[]=null; 
				 String picPath="false";
				 for(int j=0;j < 14;j++)
			     {
					   if(picpathTempMap.containsKey("2"))
					   {
							mapLength = ((String[]) picpathTempMap.get("2")).length;
							picPathTemp = new String[mapLength];
							picPathTemp = (String[]) picpathTempMap.get("2");	
							break;
					   }
					   else
					   {
						     picPath="false";  
					   }
				 }
				 //二次校验,用于判断路径下的图片是否存在
				String pagePath = request.getRealPath("./");
				for(int j = 0;j < mapLength;j++)
				{
					int numTemp = picPathTemp[j].lastIndexOf("images/universal/film");
					
					if(numTemp > 0)
					{
						String strTemp = picPathTemp[j].substring(numTemp);
						strTemp = "/jsp/" + strTemp;
						File imagesFile = new File(pagePath + strTemp);
						if(!imagesFile.exists())
						{
							//return "false";
						}
						else
						{
							picPath =picPathTemp[j];
							break;
						}
					}
				}
			     if(picPath=="false")
			     {
			         picPath="images/display/vod/detailPoster_no_pic.jpg";
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