<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.huawei.iptvmw.epg.bean.ServiceHelp" %>
<!--页面判断是否已收藏-->
<%
        boolean isfaved = false;
		ServiceHelp shelper = new ServiceHelp(request);
		isfaved = shelper.isFavorited(Integer.parseInt(programCode),0);  //是否已收藏   
%>
<script>
var isfaved = <%=isfaved%>;
</script>
