<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.EPGConstants"%>
<%@ page import="com.huawei.iptvmw.epg.util.EPGUtil"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<script type="text/javascript">
 		function getbackpic() {
            var images = new Array();
            var ids = new Array();
			<%
			   	String str1 = "";
			   	MetaData metaData1 = new MetaData(request);
			    ArrayList tuijianList =  metaData1.getRecommendVodByType(CateFrist,3,0);
				if(tuijianList == null || tuijianList.size() < 2 || ((ArrayList)tuijianList.get(1)).size() == 0)
				{
					 str1 ="空";
				}
				else
				{
					ArrayList contentList = (ArrayList)tuijianList.get(1);
					int typeSize = contentList.isEmpty()? 0: contentList.size();
					for(int i=0;i<typeSize;i++)
					{
						 HashMap listCon = (HashMap)contentList.get(i);
						 String vodId = listCon.get("VODID").toString().trim();
						String picPath_s = listCon.get("PICPATH").toString().trim();
				        %>
						images.push('<%=picPath_s%>');
						ids.push('<%=vodId%>');
						<%
					}
				}
			%>
			getdatapic(images, ids);
			}
				
</script>