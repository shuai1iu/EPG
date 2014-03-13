<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="util/util_getPosterPaths.jsp"%>
<%@ include file="util/save_focus.jsp"%>
<%@ include file="datajsp/dibbling-group-two_data.jsp"%>
<%@ include file="datajsp/codepage.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>new topic 3.0</title>
<meta name="page-view-size" content="640*530" />
<link type="text/css" rel="stylesheet" href="css/content2.css" />
<script type="text/javascript" language="javascript">

	window.onload=function(){
		initPage();
	}

	function initPage() {
			//处理传入的按钮信息
			var LinkInfo = topicInfo;
			var LinkInfoArray =  LinkInfo.split("?");
			var TmpLinkLength = LinkInfoArray[4].split(":");	//count:7
			var LinkLength = TmpLinkLength[1];		//7
	
			var TmpLines = LinkInfoArray[6].split(":");        //line:04
			var Lines = TmpLines[1];              
			var TmpRows = LinkInfoArray[7].split(":");        //row:02
			var Rows = TmpRows[1];              
	
	
			var TmpPosArray =  LinkInfoArray[0].split(":");		//pos:{179,271}c{36,178}c{107,224}c{417,239}c{251,306}c{339,281}c{492,282}	
			var PosArray =  TmpPosArray[1].split("c");		//get pos by c {179,271}
	
			var TmpImgArray =  LinkInfoArray[1].split(":"); 	//img:{61,257}c{57,209}c{61,214}c{60,208}c{59,195}c{61,220}c{58,204}
			var ImgArray =  TmpImgArray[1].split("c");              //get img by c
					
			var tmpP,tmpP_set1,tmpP_set2;
			for(var i=0;i<LinkLength;i++){
				tmpP = PosArray[i];
				tmpP_set1 = tmpP.replace(/\{/,"");
				tmpP_set2 = tmpP_set1.replace(/\}/,"");
				var LastPArray = tmpP_set2.split(",");
				$('pic0_style'+i).style.left = LastPArray[0];	
				$('pic0_style'+i).style.top = LastPArray[1];	
	//			alert($('pic0_style'+i).style.top);
	
				tmpP = ImgArray[i];
				tmpP_set1 = tmpP.replace(/\{/,"");
				tmpP_set2 = tmpP_set1.replace(/\}/,"");
				var LastImgArray = tmpP_set2.split(",");
				$('img0_style'+i).style.width = LastImgArray[0];
				$('img0_style'+i).style.height = LastImgArray[1];
	//          alert($('img0_style'+i).style.height+'and '+$('img0_style'+i).style.width);
			} 
			document.getElementsByTagName('body')[0].style.backgroundImage='url(' + picTypePath + ')';
			 
	}

//common function S
function turnUrl(url){
		if(url!=undefined&&url!="null"){
			url += ((url.indexOf("?")==-1)?"?":"&")+"returnurl="+escape(location.href);
			location.href = url;
		}
	}
</script>
	
<style type="text/css">
<!--
	body{ background:url(../images/t.gif) no-repeat;}
-->	
</style>
</head>

<body>
<div class="item">
       <div class="pic" id="pic0_style0"><a href="#" id="area2_link0"><img id="img0_style0" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style1"><a href="#" id="area2_link1"><img id="img0_style1" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style2"><a href="#" id="area2_link2"><img id="img0_style2" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style3"><a href="#" id="area2_link3"><img id="img0_style3" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style4"><a href="#" id="area2_link4"><img id="img0_style4" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style5"><a href="#" id="area2_link5"><img id="img0_style5" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style6"><a href="#" id="area2_link6"><img id="img0_style6" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style7"><a href="#" id="area2_link7"><img id="img0_style7" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style8"><a href="#" id="area2_link8"><img id="img0_style8" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style9"><a href="#" id="area2_link9"><img id="img0_style9" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style10"><a href="#" id="area2_link10"><img id="img0_style10" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style11"><a href="#" id="area2_link11"><img id="img0_style11" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style12"><a href="#" id="area2_link12"><img id="img0_style12" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style13"><a href="#" id="area2_link13"><img id="img0_style13" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style14"><a href="#" id="area2_link14"><img id="img0_style14" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style15"><a href="#" id="area2_link15"><img id="img0_style15" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style16"><a href="#" id="area2_link16"><img id="img0_style16" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style17"><a href="#" id="area2_link17"><img id="img0_style17" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style18"><a href="#" id="area2_link18"><img id="img0_style18" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style19"><a href="#" id="area2_link19"><img id="img0_style19" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style20"><a href="#" id="area2_link20"><img id="img0_style20" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style21"><a href="#" id="area2_link21"><img id="img0_style21" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style22"><a href="#" id="area2_link22"><img id="img0_style22" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style23"><a href="#" id="area2_link23"><img id="img0_style23" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style24"><a href="#" id="area2_link24"><img id="img0_style24" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style25"><a href="#" id="area2_link25"><img id="img0_style25" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style26"><a href="#" id="area2_link26"><img id="img0_style26" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style27"><a href="#" id="area2_link27"><img id="img0_style27" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style28"><a href="#" id="area2_link28"><img id="img0_style28" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style29"><a href="#" id="area2_link29"><img id="img0_style29" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
       <div class="pic" id="pic0_style30"><a href="#" id="area2_link30"><img id="img0_style30" src="../images/t.gif" style="background-color:transparent;border:0;"/></a></div>
</div>
</body>
</htm>
