
<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="com.huawei.iptvmw.epg.bean.MetaData" %>
<%@ page import="com.huawei.iptvmw.epg.bean.TurnPage" %>
<%@ page import="com.huawei.iptvmw.epg.util.*" %>
<%@ page import="net.sf.json.JSONArray" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../datajsp/util_AdText.jsp"%>
<%@ include file="../util/save_focus.jsp"%>
<%@ include file="test_index_pic_data.jsp"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="page-view-size" content="1280*720" />
<link type="text/css" href="css/common.css" rel="stylesheet" />
<link type="text/css" href="css/content.css" rel="stylesheet" />
<title>������ҳ</title>

<script type="text/javascript" src="js/pagecontrol.js"></script>
<script type="text/javascript">
<%
String picPosition = request.getParameter("pic");
String pic0 = "";
String pic1 = "";
String pic2 = "";
String pic3 = "";
int position = Integer.parseInt(picPosition);
HashMap testMap = (HashMap)newresultList.get(position);
String pic = (testMap.get("POSTERPATHS")).toString();
pic = pic.substring(1,pic.length()-1);
//pic = "aaaaaa./aaa/aa/aaa/aa/ , asdasdasdasdasdasd ,asdasdawdwdasdadas";
// 过滤出真实图片地址
String[] picstr  = pic.split(",");
for(int i = 0; i<picstr.length; i++){
	if(picstr[i].contains("type0")){
		picstr[i] = picstr[i].substring(picstr[i].indexOf("type0")+6);
		pic0 = picstr[i];
	}else if(picstr[i].contains("type1")){
		picstr[i] = picstr[i].substring(picstr[i].indexOf("type1")+6);
		pic1 = picstr[i];
	}else if(picstr[i].contains("type2")){
		picstr[i] = picstr[i].substring(picstr[i].indexOf("type2")+6);
		pic2 = picstr[i];
	}else if(picstr[i].contains("type3")){
		picstr[i] = picstr[i].substring(picstr[i].indexOf("type3")+6);
		pic3 = picstr[i];
	}
}

%>
	var areaid = 0;
	var indexid = 0;
	var pageindex = 0;
	var area0;
	var area1;
window.onload = function(){
      
//	var pics[4] = new Array("'../'+'<%=pic0%>'","'../'+'<%=pic1%>'","'../'+'<%=pic2%>'","'../'+'<%=pic3%>'");		

	var pic0 = '../'+'<%=pic0%>';
	var pic1 = '../'+'<%=pic1%>';
	var pic2 = '../'+'<%=pic2%>';
	var pic3 = '../'+'<%=pic3%>';
	var returnurl = '<%=request.getParameter("returnurl")%>';
	
	
       	area0 = AreaCreator(1,5,new Array(-1, -1, -1, -1),"area0_title_","className:simtitle on","className:simtitle");
           area0.doms[0].mylink = "../sim_index.jsp";
	   area0.doms[1].mylink = "test_topic.jsp";
	   area0.doms[2].mylink = "../sim_playback.jsp";
           area0.doms[3].mylink = "test_index.jsp";
	   area0.doms[4].mylink = "../../../defaultsdcctv/en/page/sim_index.jsp";
	   area1 = AreaCreator(2,2,new Array(0, -1, -1, -1),"area1_list_");


   	 pageobj = new PageObj(areaid,indexid, new Array(area0, area1));
/*	 pageobj.goBackEvent=function()
         {
	       location.href="test_index.jsp";
	 }		
*/

	pageobj.backurl = returnurl;

			 
	 for(i=0;i<4;i++)
	{
	     area1.doms[i].imgdom = $("area1_img_"+i);
	}
	
/*	for(i=0;i<4;i++)	
	{
		area1.doms[i].updateimg(pics[i]);
	}
*/

	 area1.doms[0].updateimg(pic0);
	 area1.doms[1].updateimg(pic1);
	 area1.doms[2].updateimg(pic2);
	 area1.doms[3].updateimg(pic3);


}
</script>
</head>
<body>

<div class="simtitle"> <!--����Ϊ class="menuli on"  ��ǰѡ��Ϊ class="menuli current"-->
	<div class="simtitle" id="area0_title_0" style="left:-120px;"><img src="images/simtitle_1.png" /></div>
        <div class="simtitle" id="area0_title_1" style="left:70px;"><img src="images/simtitle_2.png" /></div>
        <div class="simtitle" id="area0_title_2" style="left:260px;"><img src="images/simtitle_3.png" /></div>
        <div class="simtitle" id="area0_title_3" style="left:450px;"><img src="images/simtitle_4.png" /></div>
        <div class="simtitle" id="area0_title_4" style="left:650px;"><img src="../images/simtitle_5.png" /></div>

</div>

<div class="r_ad" style="left:200px">
        <div style="top:40px" id="area1_list1_0"><img id="area1_img_0"/></div>
	<div style="top:40px;left:500px" id="area1_list1_1"><img id="area1_img_1" /></div>
	<div style="top:368px;" id="area1_list1_2"><img id="area1_img_2"  /></div>
	<div style="top:368px;left:500px" id="area1_list1_3"><img id="area1_img_3"  /></div>
</div>


<div class="r_ad" style="left:0px">
<div style="top: 40px; position: absolute; left: 115px;" >缩略图</div>
<div style="top: 40px; position: absolute; left: 640px;" >海报</div>
<div style="top: 368px; position: absolute; left: 130px;" >剧照</div>
<div style="top: 368px; position: absolute; left: 640px;" >图标</div>
</div>

<%@ include file="../servertimehelp.jsp" %>

</body>
</html>
