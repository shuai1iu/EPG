<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>JS鼠标移上后图片放大特效_网页代码站(www.webdm.cn)</title>
<script src="js/jquery.js"></script>
<script language="javascript">
<!--
//直接加载:hover 图片放大过度不流畅
$(document).ready(function(){
	$("#zoom0 img").hover(function(){$(this).addClass("hover")},
		function(){$(this).removeClass("hover")}
	)	
})

//-->
</script>
<style>
<!--
body{
	background:url(images/bg-pop.jpg);
}


#zoom0,#zoom,#zoom1{
	background-image:url(images/bg-pop.jpg);
	width:750px;
	height:200px;
	margin:5px auto;
	padding:10px;
}

#pic1,#pic2,#pic3{
	float:left;
	width:240px;
	height:190px;
	margin:5px;
}


#zoom0 img{
	background:#FFF;
	width:220px;
	height:170px;
	margin:10px;
	padding:5px;
}

#zoom0 img.hover{
	width:240px;
	height:190px;
	margin:0px;
	cursor:pointer;
}

#zoom1 img{
	background:#FFF;
	width:220px;
	height:170px;
	margin:10px;
	padding:5px;
}

#zoom1 img:hover{
	cursor:pointer;
	-webkit-transform:scale(1.1);
}


p{
	height:30px;
	line-height:30px;
	color:#FFF;
	font-size:28px;
	font-weight:bold;
	text-shadow:4px 4px 5px #fC0;
}
-->
</style>
</head>
<body>
<p align="center">ZoomIn Jquery+CSS2 </p>
 <div id="zoom0">
	 <div id="pic1"><img src="images/button01a.png" /></div>
	 <div id="pic2"><img src="images/button02a.png" /></div>
	 <div id="pic3"><img src="images/button03a.png" /></div>
 
 </div>

<p align="center">ZoomIn CSS3</p> 
 <div id="zoom1">
	 <div id="pic1"><img src="images/button01a.png" /></div>
	 <div id="pic2"><img src="images/button02a.png" /></div>
	 <div id="pic3"><img src="images/button03a.png" /></div> 
 </div>
<br />
</body>
</html>


