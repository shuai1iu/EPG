<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript">
//需要修改
var list;
var returnurl = '<%=request.getParameter("returnurl")!=null?request.getParameter("returnurl"):"indexpkit.jsp"%>';
var keyword = '<%=request.getParameter("keyword")!=null?request.getParameter("keyword"):"空白"%>';
 window.onload=function()
   {
	   var areaid=0;
	   var indexid=0;
	   area0=AreaCreator(12,1,new Array(-1,-1,-1,-1),"result","className:r_li on","className:r_li");
	   for(var i=0;i<area0.datanum;i++){
	   		area0.doms[i].mylink = "program_film.jsp?mediaid="+i+"&returnurl="+escape(window.location.href);
	   }
	   pageobj=new PageObj(areaid,indexid,new Array(area0));
	   pageobj.backurl = unescape(returnurl);
   }
</script>