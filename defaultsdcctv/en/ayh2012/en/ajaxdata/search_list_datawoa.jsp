<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ include file="../datasource/datasource.jsp"%>
<%@ include file="../datasource/property.jsp"%>
<%
	DataSource dataSource=new DataSource(request); 
	int pageIndex=dataSource.huaWeiUtil.getInt(request.getParameter("pageIndex"),1);
	int pageSize=dataSource.huaWeiUtil.getInt(request.getParameter("pageSize"),5);
	String postertype = "5";
	int pageCount=0;
	String keywords=dataSource.huaWeiUtil.getString(request.getParameter("keywords"));
	PkitEpgResult epgResult=dataSource.searchVodInfos(pageIndex,pageSize,keywords,"1");
	List vods=new ArrayList();
	JSONArray jsonpage=null;
	if(epgResult!=null&&epgResult.getResultcode()==0&&epgResult.getDatas()!=null){
	   vods=(List)epgResult.getDatas();
	   pageCount=epgResult.getPageCount();
	}
	jsonpage=JSONArray.fromObject(vods);
	
%>
<script>
parent.myCallBack('<%="{jsonvodlist:"+jsonpage+",jsonpagecount:"+pageCount+"}" %>');
if(typeof(iPanel)!= 'undefined'){iPanel.focusWidth = "2"; iPanel.defaultFocusColor = "#FCFF05";}
</script>
