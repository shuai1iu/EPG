<!-- 描  述：获取图片推荐位及其type -->
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.lang.Integer"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ include file = "util_getPosterPaths.jsp"%>
<%@ include file = "../config/config_recommd.jsp"%>
<script>
var bRecommFilmId = new Array(); //节目编号
var bRecommFilmPic = new Array(); //海报图片
var picSize=0;
<%
		 int vodSize = 0;
	     MetaData metaData = new MetaData(request);
		 List filmInfoMap= metaData.getVodListByTypeId(VOD_TVOD_TYPEID,3,0);
		 if(null==filmInfoMap || filmInfoMap.size()!=2)
	     {
	          //turnPage.removeLast();
%>
              //window.location.href = "InfoDisplay.jsp?ERROR_ID=25&ERROR_TYPE=2";
<%
	     }
		 else
		 {
			  ArrayList filmInfoMapArray = (ArrayList)filmInfoMap.get(1);
			  if(filmInfoMapArray!=null && filmInfoMapArray.size()>0)
		      {
					vodSize = filmInfoMapArray.size();
			        for(int i=0;i<vodSize;i++)
			        {
						 HashMap filmInfoMapArrayMap = (HashMap)filmInfoMapArray.get(i);
						 int vodId=((Integer)filmInfoMapArrayMap.get("VODID")).intValue();
						 HashMap picpathTempMap = (HashMap)filmInfoMapArrayMap.get("POSTERPATHS");
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
			         picPath="";
			     }
%>
					     bRecommFilmId[<%=i%>] = <%=vodId%>;
					     bRecommFilmPic[<%=i%>]='<%=picPath%>';
<%
				      }
		         }
		   }
%>
		picSize = '<%=vodSize%>';

		
</script>