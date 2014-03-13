<!-- 描  述：获取图片推荐位及其type -->
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.lang.Integer"%>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData"%>
<%@ include file = "util_getPosterPaths.jsp"%>

<script>
var bRecomFilmName = new Array(); //节目名称
var bRecommFilmId = new Array(); //节目编号
var bRecommFilmPic = new Array(); //海报图片
var picSize = 0;
<%
	MetaData metaData_ = new MetaData(request);
	//获取类别参数 
	ArrayList arectypeList = metaData_.getRecommendFilms(4,0);//getVodListByTypeId(strTypeId);
	if (null != arectypeList && ((Integer)((HashMap)arectypeList.get(0)).get("COUNTTOTAL")).intValue() != 0 
				&& null != ((ArrayList)arectypeList.get(1)) && ((ArrayList)arectypeList.get(1)).size() > 0)
	{
		ArrayList rfilmLsInfo = (ArrayList)arectypeList.get(1);
		  int pSize = rfilmLsInfo.size();
		for(int i=0;i<rfilmLsInfo.size();i++)
		{
			HashMap rfilmHash = (HashMap)rfilmLsInfo.get(i);
			Map filmInfoMap_ = metaData_.getVodDetailInfo(((Integer)rfilmHash.get("VODID")).intValue());
			//海报信息
			HashMap picpathTemp = (HashMap)rfilmHash.get("POSTERPATHS"); 
			String picPath = getPosterPath(picpathTemp,request);
			if(picPath=="false")
			{
				picPath = "";
			}
%>
			bRecomFilmName[<%=i%>] = '<%=rfilmHash.get("VODNAME")%>';
			bRecommFilmId[<%=i%>] = <%=rfilmHash.get("VODID")%>;
			bRecommFilmPic[<%=i%>]='<%=picPath%>';
<%
		}
		%>
		picSize = '<%=pSize%>';
		<%
	}
%>
</script>