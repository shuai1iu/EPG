<%@ page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<%
  String curpage=request.getParameter("curpage")==null?"":request.getParameter("curpage");
  String vodListFile="../../../hwdatajsp/vodList.jsp";
  System.out.println("liuyong*************liuyong********"+curpage);
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>dibTVImageIframe</title>
<script type="text/javascript">

            <jsp:include page="<%=vodListFile%>">             
			<jsp:param name="categoryCode" value="10000100000000090000000000031172" /> 
			<jsp:param name="pageIndex" value="<%=curpage%>" /> 
			<jsp:param name="pageSize" value="10" /> 
			<jsp:param name="varName" value="dibTVTurnPageName" />
			<jsp:param name="fileds" value="-1" />
			<jsp:param name="isBug" value="1" />
			</jsp:include>
			
		
             function init(){
               parent.callData(dibTVTurnPageName);
              }
			
         
         
         
</script>

</head>

<body onload="init()">
</body>
</html>
