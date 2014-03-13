<%
String ctx = request.getRequestURL().toString();
ctx = ctx.substring(0,ctx.lastIndexOf("/"));

String static_url = ctx + "/../static";//指向static静态文件目录
String static_en = ctx + "/../";//指向项目的en目录

String ctx0="";
if (request.getServerPort()>0) {
	ctx0=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+ request.getContextPath();
}else{
	ctx0 = request.getScheme()+"://"+request.getServerName()+ request.getContextPath();
}
//String static_cctv_index = ctx0+ "/jsp/defaultsdcctv/en/page/index.jsp";//深圳：配置家庭首页的地址
String static_cctv_index = ctx0+ "/jsp/defaulthdcctv/en_develop/index.jsp";//配置家庭首页的地址 
%>

